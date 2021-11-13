
-- -----------------------------------------------------Скрипты характерных выборок--------------------------------------------------------------------------
/*
Скрипты характерных выборок:
1. Перечень доступных услуг для пользователя
2. Перечень доступных услуг для ребенка пользователя
3. Самые популярные услуги

*/

-- 1. Перечень доступных услуг для пользователя

SET @a := 1;

SELECT s.name
	FROM services_available sa INNER JOIN service s ON sa.service_id = s.id 
	WHERE user_id = @a AND permission = 1;

-- 2. Перечень доступных услуг для каждого ребенка пользователя


SELECT (SELECT name FROM service s WHERE sa.service_id = s.id) AS 'Название доступной услуги', 
	   (SELECT concat(u.firstname, ' ', u.lastname, ' ', u.middlename) FROM users u WHERE sa.user_id = u.id) AS 'Услуга доступна'
	FROM services_available sa 
	WHERE permission = 1 AND user_id IN (SELECT user_id_child 
											FROM childrens
											WHERE user_id_parent = @a);


-- 3. Самые популярные услуги в порядке убывания
SELECT s.name AS 'Услуга', count(1)/(SELECT count(1) FROM ordered_services os2) AS 'Доля от всех заказов услуг'
	FROM ordered_services os INNER JOIN service s ON os.service_id = s.id 
	GROUP BY service_id
	ORDER BY count(1) DESC;										

-- -----------------------------------------------------Представления (минимум 2)--------------------------------------------------------------------------
/*
Представления (минимум 2):
1. Перечень организаций имеющих доступ к реквизитам пользователя с перечислением реквизитов.
2. Пользователи документы которых истекают в ближайшие 60 дней
*/
-- 1. Перечень организаций имеющих доступ к реквизитам пользователя с перечислением реквизитов.
CREATE VIEW permissions_organizations AS
SELECT o.name AS 'Название организации', 
	   op.user_id AS 'ID пользователя', 
	   concat(u.firstname, ' ', u.lastname, ' ', u.middlename) 'ФИО пользователя', op.table_row AS 'Реквизиты пользователя'
	FROM organization o INNER JOIN organization_permission op ON o.id = op.organization_id 
						INNER JOIN users u ON u.id = op.user_id;

SELECT * FROM permissions_organizations;

-- 2. Пользователи документы которых истекают в ближайшие 60 дней
CREATE VIEW document_expiration AS 
	SELECT concat(u.firstname, ' ', u.lastname, ' ', u.middlename) 'ФИО', pt.name  AS 'Истекает документ', p.date_of_expiration AS 'Дата истечения'
		FROM passport p INNER JOIN users u ON p.user_id = u.id INNER JOIN passport_type pt ON p.passport_type_id = pt.id
		WHERE p.date_of_expiration BETWEEN now() AND now() + INTERVAL 60 DAY;

SELECT * FROM document_expiration;

-- ------------------------------------------------Хранимые процедуры:-------------------------------------------------------------------------------
/*
Хранимые процедуры:
1. Дети пользователей
2. Список заказанных и список оказанных услуг для пользователя.
3. Средняя длительность оказания услуги за период*/


-- 1. Дети пользователей
SET @b := 1;


CREATE PROCEDURE Children(parent BIGINT UNSIGNED)
	BEGIN
		SELECT concat(u.firstname, ' ', u.lastname, ' ', u.middlename) AS 'Дети' 
			FROM childrens c INNER JOIN users u ON c.user_id_child = u.id 
			WHERE c.user_id_parent = parent;
	END; 

CALL Children(1);


-- 2. Список заказанных и список оказанных услуг для пользователя.
DROP PROCEDURE completed_services;

CREATE PROCEDURE completed_services(users BIGINT UNSIGNED)
	BEGIN
		SELECT s.name AS 'Оказанная услуга' 
			FROM ordered_services os INNER JOIN service s ON s.id = os.service_id 
			WHERE order_status = 'Выполнено' AND user_id = users; 
	END; 

CALL completed_services(1);


CREATE PROCEDURE ordered_services(users BIGINT UNSIGNED)
	BEGIN
		SELECT s.name AS 'Услуга', os.order_status AS 'Статус выполнения'
			FROM ordered_services os INNER JOIN service s ON s.id = os.service_id 
			WHERE order_status != 'Выполнено' AND user_id = users;
	END; 

CALL ordered_services(2);

-- 3. Средняя длительность оказания услуги за период


DROP PROCEDURE IF EXISTS avg_service;
CREATE PROCEDURE avg_service(id_serv BIGINT UNSIGNED)
BEGIN
	SET @ex_serv = 0;
	SET @proc_serv = 0;
	SELECT avg(datediff(os.date_status , os.start_date)) INTO @ex_serv -- Оказанная услуга
		FROM ordered_services os 
		WHERE os.order_status = 'Выполнено' AND os.service_id = id_serv
		GROUP BY service_id;
	
	SELECT avg(datediff(now() , os.start_date)) INTO @proc_serv -- Услуга в процессе
		FROM ordered_services os 
		WHERE os.order_status = 'В процессе' AND os.service_id = id_serv
		GROUP BY service_id;
	
	IF @ex_serv = 0 THEN 
		SET @avg_serv = @proc_serv;
	ELSEIF @proc_serv = 0 THEN 
		SET @avg_serv = @ex_serv ;
	ELSE 
		SET @avg_serv = (@ex_serv + @proc_serv)/2;
	END IF;

	SELECT @avg_serv AS 'Среднее длительность выполнения услуги, дней';
END;

CALL avg_service(1);


-- ------------------------------------------------Триггеры:-------------------------------------------------------------------------------

/*Триггеры:
1. Изменение данных по grz в таблице vehicle фиксируются в отдельной таблице
2. Попытка указать максимальный вес менее нормального в таблице vehicle завершается ошибкой
3. Попытка удаления данных из таблицы actions_in_the_system завершается ошибкой

*/

-- 1. Изменение данных по grz в таблице vehicle фиксируются в отдельной таблице
DROP TABLE IF EXISTS registration_of_changes;
CREATE TABLE registration_of_changes(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	name_table VARCHAR(100),
	name_column VARCHAR(100),
	old_value TEXT,
	new_value TEXT,
	created_at DATETIME DEFAULT NOW(),
	INDEX registration_of_changes_name_table_idx(name_table)
)COMMENT 'Таблица для регистрации изменений, которые отслеживает триггер';

DROP TRIGGER IF EXISTS check_vehicle_grz_update;
CREATE TRIGGER check_vehicle_grz_update BEFORE UPDATE ON vehicle
	FOR EACH ROW
	BEGIN
		IF NEW.grz != OLD.grz THEN 
			INSERT INTO registration_of_changes (name_table, name_column, old_value, new_value) VALUES ('vehicle', 'grz', OLD.grz, NEW.grz);
		END IF;
	END;

SELECT * FROM vehicle v ;
UPDATE vehicle SET grz = 'р001кх199' WHERE id = 10;
SELECT * FROM registration_of_changes;
UPDATE vehicle SET grz = 'р002кх199' WHERE id = 9 OR id = 8;
UPDATE vehicle SET grz = 'р702кх199' WHERE id = 8;

-- 2. Попытка указать максимальный вес менее нормального в таблице vehicle завершается ошибкой

DROP TRIGGER IF EXISTS check_vehicle_max_weight;
CREATE TRIGGER check_vehicle_max_weight BEFORE INSERT ON vehicle
	FOR EACH ROW BEGIN
	  IF NEW.max_weight <= NEW.norm_weight THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Вставка отменена! Максимальная допустимая масса транспортного средства не может быть меньше массы в снаряженном состоянии';
	  END IF;
	END;

SELECT * FROM vehicle v ;
INSERT INTO vehicle (passport_number, max_weight, norm_weight) VALUES ('000001', '2000','1500');
INSERT INTO vehicle (passport_number, max_weight, norm_weight) VALUES ('000002', '2500','2500');

DROP TRIGGER IF EXISTS check_vehicle_max_weight_up;
CREATE TRIGGER check_vehicle_max_weight_up BEFORE UPDATE ON vehicle
	FOR EACH ROW BEGIN
	  IF NEW.max_weight <= NEW.norm_weight THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Изменение отменено! Макс. масса транспортного средства не может быть меньше массы в снаряженном состоянии';
	  END IF;
	END;

SELECT * FROM vehicle v ;
UPDATE vehicle SET norm_weight = '2000' WHERE id = 11;
UPDATE vehicle SET max_weight = '1500' WHERE id = 11;
UPDATE vehicle SET max_weight = '1507' WHERE id = 11;
UPDATE vehicle SET max_weight = '1507', norm_weight = '1507'  WHERE id = 11;


-- 3. Попытка удаления данных из таблицы actions_in_the_system завершается ошибкой
SELECT * FROM actions_in_the_system;

CREATE TRIGGER stop_del_actions_in_the_system BEFORE DELETE ON actions_in_the_system
	FOR EACH ROW BEGIN
	  	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Удаление отменено! Удаление данных из таблицы actions_in_the_system не возможно';
	END;

DELETE FROM actions_in_the_system WHERE id = 10;




