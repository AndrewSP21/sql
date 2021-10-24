-- 1. ����� ����� ��������� ������������. �� ���� ������������� ���. ���� ������� ��������, ������� ������ ���� ������� � ��������� ������������� (������� ��� ���������).
SET @sel_user := 1; -- ��������� ������������.

SELECT from_user_id 
	FROM messages m 
	WHERE to_user_id = @sel_user
	GROUP BY from_user_id 
	ORDER BY count(1) DESC
	LIMIT 1;


-- 2. ���������� ����� ���������� ������, ������� �������� ������������ ������ 10 ���..

-- �������� � �������� ������� object_types ������� ����� ��������� ����� ������ ���������

CREATE TABLE object_types (
	id int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name  VARCHAR(30));

INSERT INTO object_types(name) VALUES ('post'), ('user'), ('message'), ('media'); 

-- ������ ������ � ������� like_status ��������������� ����������� object_types
SET @Count_object_types := (SELECT count(1) FROM  object_types);

UPDATE like_status 
	SET object_id =	(SELECT floor(rand()*(@Count_object_types)+1)); 

-- ��������� ����������� �� ������� like_status ��� ����������� ����������� ����

ALTER TABLE like_status ADD CONSTRAINT like_status_object_id FOREIGN KEY (object_id) REFERENCES object_types(id); 



-- ����� ���������� ������ ������������� ������ 10 ���

SELECT count(1) 
	FROM like_status ls
	WHERE object_id = (SELECT id
							FROM object_types ot
							WHERE name = 'user') AND 							  -- ����� ���� user
		  users_id IN (SELECT user_id 
							FROM profiles p 
							WHERE (date_sub(now() , INTERVAL 10 YEAR)) > birthday);-- ������������ ������ 10 ���



-- 3. ���������� ��� ������ �������� ������ (�����): ������� ��� �������.

SELECT (SELECT gender FROM profiles p WHERE p.user_id = ls.users_id) AS Gender
	FROM like_status ls
	GROUP BY gender
	ORDER BY count(1) DESC
	LIMIT 1;
							
							
							
							