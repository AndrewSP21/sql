-- 1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
SET @sel_user := 1; -- Некоторый пользователь.

SELECT from_user_id 
	FROM messages m 
	WHERE to_user_id = @sel_user
	GROUP BY from_user_id 
	ORDER BY count(1) DESC
	LIMIT 1;


-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

-- Создадим и наполним таблицу object_types которая будет указывать какой объект лайкается

CREATE TABLE object_types (
	id int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name  VARCHAR(30));

INSERT INTO object_types(name) VALUES ('post'), ('user'), ('message'), ('media'); 

-- Внесем данные в таблицу like_status соответствующие содержимому object_types
SET @Count_object_types := (SELECT count(1) FROM  object_types);

UPDATE like_status 
	SET object_id =	(SELECT floor(rand()*(@Count_object_types)+1)); 

-- Установим ограничение на таблицу like_status для поддержания целостности базы

ALTER TABLE like_status ADD CONSTRAINT like_status_object_id FOREIGN KEY (object_id) REFERENCES object_types(id); 



-- Итого количество лайкой пользователям младше 10 лет

SELECT count(1) 
	FROM like_status ls
	WHERE object_id = (SELECT id
							FROM object_types ot
							WHERE name = 'user') AND 							  -- Лайки типу user
		  users_id IN (SELECT user_id 
							FROM profiles p 
							WHERE (date_sub(now() , INTERVAL 10 YEAR)) > birthday);-- Пользователи младше 10 лет



-- 3. Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT (SELECT gender FROM profiles p WHERE p.user_id = ls.users_id) AS Gender
	FROM like_status ls
	GROUP BY gender
	ORDER BY count(1) DESC
	LIMIT 1;
							
							
							
							