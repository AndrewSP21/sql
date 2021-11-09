-- Практическое задание по теме “Транзакции, переменные, представления”

-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
-- Используйте транзакции.

START TRANSACTION;

INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
SAVEPOINT us_id_1;

DELETE FROM shop.users WHERE id = 1;
COMMIT;


-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
CREATE VIEW Prod_name_in_catalog AS 
	SELECT p.name AS 'Товарная позиция', c.name AS 'Название каталога'
		FROM products p INNER JOIN catalogs c ON p.catalog_id = c.id;
	
SELECT * FROM Prod_name_in_catalog;
	
-- 3. (по желанию) Пусть имеется таблица с календарным полем created_at. 
-- В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
-- Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.



CREATE TABLE Calendar (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	created_at DATE
);
	
INSERT INTO calendar (created_at)
	VALUES ('2018-08-01'), ('2016-08-04'), ('2018-08-16'), ('2018-08-17');

SELECT created_at FROM calendar;


DROP PROCEDURE IF EXISTS Month_day;
CREATE PROCEDURE Month_day()
	BEGIN 
		DECLARE d date DEFAULT '2018-08-01';
		DROP TABLE IF EXISTS temp_aug_days ;
		CREATE TEMPORARY TABLE temp_aug_days (dates DATE);
		WHILE d < '2018-09-01' DO
			INSERT INTO temp_aug_days (SELECT d);
			SELECT adddate(d, INTERVAL 1 DAY) INTO d;
		END WHILE;
		SELECT dates AS 'Даты', IF (c.created_at IS NOT NULL, 1, 0) AS 'Дата есть'
			FROM temp_aug_days a LEFT JOIN calendar c ON a.dates = c.created_at;
	END;
		
CALL Month_day();




-- 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. 
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.


SET @min_created_at := (SELECT created_at 
						FROM users u 
						ORDER BY created_at DESC
						LIMIT 4,1);
	
DELETE FROM users WHERE created_at < @min_created_at;




-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- 1.	Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", 
-- с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;

CREATE FUNCTION hello()	RETURNS text
	DETERMINISTIC
	BEGIN
		DECLARE result text;
			IF ((time(now()) > '06:00:00') AND (time(now()) <= '12:00:00')) THEN SET result = 'Доброе утро';
			END IF;		
			IF ((time(now()) > '12:00:00') AND (time(now()) <= '18:00:00')) THEN SET result = 'Добрый день';
			END IF;
			IF ((time(now()) > '18:00:00') AND (time(now()) <= '00:00:00')) THEN SET result = 'Добрый вечер';
			END IF;
			IF ((time(now()) > '00:00:00') AND (time(now()) <= '06:00:00')) THEN SET result = 'Доброй ночи';
			END IF;
		RETURN (result);
	END;

SELECT hello();



-- 2.	В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.



DROP TRIGGER IF EXISTS Check_name_description_insert;

CREATE TRIGGER Check_name_description_insert  BEFORE INSERT ON products -- Триггер отменяет вставку если поля name и description одновременно имеют значение NULL 
	FOR EACH ROW 
		BEGIN 
			IF (NEW.name IS NULL) AND (NEW.description IS NULL) THEN 
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled'; 
			END IF;
		END;

		 
CREATE TRIGGER Check_name_description_udate  BEFORE UPDATE ON products -- Триггер отменяет обновление если поля name и description одновременно имеют значение NULL 
	FOR EACH ROW 
		BEGIN 
			IF (NEW.name IS NULL) AND (NEW.description IS NULL) THEN 
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled'; 
			END IF;
		END;





-- 3.	(по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
-- Вызов функции FIBONACCI(10) должен возвращать число 55.

DROP FUNCTION IF EXISTS FIBONACCI;

CREATE FUNCTION FIBONACCI(a int) RETURNS int 
    DETERMINISTIC
	BEGIN
	    DECLARE result INT; -- Объявляем переменную, которую будет возвращать функция
	    DECLARE i INT;
  	    DECLARE olds INT;
  	   
  	    IF (a = 0) THEN SET result = 0;
  	   
  	    ELSEIF (a = 1) OR (a = 2) THEN SET result = 1;
  	    ELSE
  	        SET result = 1;
		    SET olds = 1;
		    SET i = 3;
		 	WHILE i <= a DO                      --  i=3, result=1, olds=1.| i=4, result=2, olds=1.| i=5, result=3, olds=2.
				SET result = result + olds;      --  i=3, result=2, olds=1.| i=4, result=3, olds=1.| i=5, result=5, olds=2.
				SET olds = result - olds;      	 --  i=3, result=2, olds=1.| i=4, result=3, olds=2.| i=5, result=5, olds=3. 			
				SET i = i +1;	                 --  i=4, result=2, olds=1.| i=4, result=3, olds=2.| i=5, result=5, olds=3.
			END WHILE;
		END IF;
		RETURN result;	
	END;


SELECT FIBONACCI(10);


-- Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)
-- 1.	Создайте двух пользователей которые имеют доступ к базе данных shop. 
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
-- второму пользователю shop — любые операции в пределах базы данных shop.

CREATE USER shop IDENTIFIED WITH sha256_password BY '1111';
CREATE USER shop_read IDENTIFIED WITH sha256_password BY '2222';

SELECT Host, User FROM mysql.user;

GRANT ALL ON shop.* TO shop;
GRANT GRANT OPTION ON shop.* TO shop;
GRANT SELECT ON shop.* TO shop_read;


-- 2.	(по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и его пароль. 
-- Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. 
-- Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.

CREATE TABLE accounts (
	id INT,
	name varchar(150),
	password_t varchar(150)
);
DROP VIEW account_view;

CREATE VIEW username AS
	SELECT id, name
		FROM accounts; 

SELECT * FROM accounts ;
SELECT * FROM username ;	

CREATE USER user_read IDENTIFIED WITH sha256_password BY '1111';
GRANT SELECT ON shop.username TO 'user_read'@'%';







