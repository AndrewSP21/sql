
-- -----------------------------------------------------������� ����������� �������--------------------------------------------------------------------------
/*
������� ����������� �������:
1. �������� ��������� ����� ��� ������������
2. �������� ��������� ����� ��� ������� ������������
3. ����� ���������� ������

*/

-- 1. �������� ��������� ����� ��� ������������

SET @a := 1;

SELECT s.name
	FROM services_available sa INNER JOIN service s ON sa.service_id = s.id 
	WHERE user_id = @a AND permission = 1;

-- 2. �������� ��������� ����� ��� ������� ������� ������������


SELECT (SELECT name FROM service s WHERE sa.service_id = s.id) AS '�������� ��������� ������', 
	   (SELECT concat(u.firstname, ' ', u.lastname, ' ', u.middlename) FROM users u WHERE sa.user_id = u.id) AS '������ ��������'
	FROM services_available sa 
	WHERE permission = 1 AND user_id IN (SELECT user_id_child 
											FROM childrens
											WHERE user_id_parent = @a);


-- 3. ����� ���������� ������ � ������� ��������
SELECT s.name AS '������', count(1)/(SELECT count(1) FROM ordered_services os2) AS '���� �� ���� ������� �����'
	FROM ordered_services os INNER JOIN service s ON os.service_id = s.id 
	GROUP BY service_id
	ORDER BY count(1) DESC;										

-- -----------------------------------------------------������������� (������� 2)--------------------------------------------------------------------------
/*
������������� (������� 2):
1. �������� ����������� ������� ������ � ���������� ������������ � ������������� ����������.
2. ������������ ��������� ������� �������� � ��������� 60 ����
*/
-- 1. �������� ����������� ������� ������ � ���������� ������������ � ������������� ����������.
CREATE VIEW permissions_organizations AS
SELECT o.name AS '�������� �����������', 
	   op.user_id AS 'ID ������������', 
	   concat(u.firstname, ' ', u.lastname, ' ', u.middlename) '��� ������������', op.table_row AS '��������� ������������'
	FROM organization o INNER JOIN organization_permission op ON o.id = op.organization_id 
						INNER JOIN users u ON u.id = op.user_id;

SELECT * FROM permissions_organizations;

-- 2. ������������ ��������� ������� �������� � ��������� 60 ����
CREATE VIEW document_expiration AS 
	SELECT concat(u.firstname, ' ', u.lastname, ' ', u.middlename) '���', pt.name  AS '�������� ��������', p.date_of_expiration AS '���� ���������'
		FROM passport p INNER JOIN users u ON p.user_id = u.id INNER JOIN passport_type pt ON p.passport_type_id = pt.id
		WHERE p.date_of_expiration BETWEEN now() AND now() + INTERVAL 60 DAY;

SELECT * FROM document_expiration;

-- ------------------------------------------------�������� ���������:-------------------------------------------------------------------------------
/*
�������� ���������:
1. ���� �������������
2. ������ ���������� � ������ ��������� ����� ��� ������������.
3. ������� ������������ �������� ������ �� ������*/


-- 1. ���� �������������
SET @b := 1;


CREATE PROCEDURE Children(parent BIGINT UNSIGNED)
	BEGIN
		SELECT concat(u.firstname, ' ', u.lastname, ' ', u.middlename) AS '����' 
			FROM childrens c INNER JOIN users u ON c.user_id_child = u.id 
			WHERE c.user_id_parent = parent;
	END; 

CALL Children(1);


-- 2. ������ ���������� � ������ ��������� ����� ��� ������������.
DROP PROCEDURE completed_services;

CREATE PROCEDURE completed_services(users BIGINT UNSIGNED)
	BEGIN
		SELECT s.name AS '��������� ������' 
			FROM ordered_services os INNER JOIN service s ON s.id = os.service_id 
			WHERE order_status = '���������' AND user_id = users; 
	END; 

CALL completed_services(1);


CREATE PROCEDURE ordered_services(users BIGINT UNSIGNED)
	BEGIN
		SELECT s.name AS '������', os.order_status AS '������ ����������'
			FROM ordered_services os INNER JOIN service s ON s.id = os.service_id 
			WHERE order_status != '���������' AND user_id = users;
	END; 

CALL ordered_services(2);

-- 3. ������� ������������ �������� ������ �� ������


DROP PROCEDURE IF EXISTS avg_service;
CREATE PROCEDURE avg_service(id_serv BIGINT UNSIGNED)
BEGIN
	SET @ex_serv = 0;
	SET @proc_serv = 0;
	SELECT avg(datediff(os.date_status , os.start_date)) INTO @ex_serv -- ��������� ������
		FROM ordered_services os 
		WHERE os.order_status = '���������' AND os.service_id = id_serv
		GROUP BY service_id;
	
	SELECT avg(datediff(now() , os.start_date)) INTO @proc_serv -- ������ � ��������
		FROM ordered_services os 
		WHERE os.order_status = '� ��������' AND os.service_id = id_serv
		GROUP BY service_id;
	
	IF @ex_serv = 0 THEN 
		SET @avg_serv = @proc_serv;
	ELSEIF @proc_serv = 0 THEN 
		SET @avg_serv = @ex_serv ;
	ELSE 
		SET @avg_serv = (@ex_serv + @proc_serv)/2;
	END IF;

	SELECT @avg_serv AS '������� ������������ ���������� ������, ����';
END;

CALL avg_service(1);


-- ------------------------------------------------��������:-------------------------------------------------------------------------------

/*��������:
1. ��������� ������ �� grz � ������� vehicle ����������� � ��������� �������
2. ������� ������� ������������ ��� ����� ����������� � ������� vehicle ����������� �������
3. ������� �������� ������ �� ������� actions_in_the_system ����������� �������

*/

-- 1. ��������� ������ �� grz � ������� vehicle ����������� � ��������� �������
DROP TABLE IF EXISTS registration_of_changes;
CREATE TABLE registration_of_changes(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	name_table VARCHAR(100),
	name_column VARCHAR(100),
	old_value TEXT,
	new_value TEXT,
	created_at DATETIME DEFAULT NOW(),
	INDEX registration_of_changes_name_table_idx(name_table)
)COMMENT '������� ��� ����������� ���������, ������� ����������� �������';

DROP TRIGGER IF EXISTS check_vehicle_grz_update;
CREATE TRIGGER check_vehicle_grz_update BEFORE UPDATE ON vehicle
	FOR EACH ROW
	BEGIN
		IF NEW.grz != OLD.grz THEN 
			INSERT INTO registration_of_changes (name_table, name_column, old_value, new_value) VALUES ('vehicle', 'grz', OLD.grz, NEW.grz);
		END IF;
	END;

SELECT * FROM vehicle v ;
UPDATE vehicle SET grz = '�001��199' WHERE id = 10;
SELECT * FROM registration_of_changes;
UPDATE vehicle SET grz = '�002��199' WHERE id = 9 OR id = 8;
UPDATE vehicle SET grz = '�702��199' WHERE id = 8;

-- 2. ������� ������� ������������ ��� ����� ����������� � ������� vehicle ����������� �������

DROP TRIGGER IF EXISTS check_vehicle_max_weight;
CREATE TRIGGER check_vehicle_max_weight BEFORE INSERT ON vehicle
	FOR EACH ROW BEGIN
	  IF NEW.max_weight <= NEW.norm_weight THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '������� ��������! ������������ ���������� ����� ������������� �������� �� ����� ���� ������ ����� � ����������� ���������';
	  END IF;
	END;

SELECT * FROM vehicle v ;
INSERT INTO vehicle (passport_number, max_weight, norm_weight) VALUES ('000001', '2000','1500');
INSERT INTO vehicle (passport_number, max_weight, norm_weight) VALUES ('000002', '2500','2500');

DROP TRIGGER IF EXISTS check_vehicle_max_weight_up;
CREATE TRIGGER check_vehicle_max_weight_up BEFORE UPDATE ON vehicle
	FOR EACH ROW BEGIN
	  IF NEW.max_weight <= NEW.norm_weight THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '��������� ��������! ����. ����� ������������� �������� �� ����� ���� ������ ����� � ����������� ���������';
	  END IF;
	END;

SELECT * FROM vehicle v ;
UPDATE vehicle SET norm_weight = '2000' WHERE id = 11;
UPDATE vehicle SET max_weight = '1500' WHERE id = 11;
UPDATE vehicle SET max_weight = '1507' WHERE id = 11;
UPDATE vehicle SET max_weight = '1507', norm_weight = '1507'  WHERE id = 11;


-- 3. ������� �������� ������ �� ������� actions_in_the_system ����������� �������
SELECT * FROM actions_in_the_system;

CREATE TRIGGER stop_del_actions_in_the_system BEFORE DELETE ON actions_in_the_system
	FOR EACH ROW BEGIN
	  	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '�������� ��������! �������� ������ �� ������� actions_in_the_system �� ��������';
	END;

DELETE FROM actions_in_the_system WHERE id = 10;




