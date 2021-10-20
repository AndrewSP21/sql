-- 1.	Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
UPDATE users SET created_at = NOW(), updated_at = NOW();
-- 2.	Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
ALTER TABLE users ADD COLUMN cr DATETIME;
ALTER TABLE users ADD cOLUMN up DATETIME;
UPDATE users SET cr = STR_TO_DATE(created_at, "%d.%m.%Y %k:%i");
UPDATE users SET up = STR_TO_DATE(updated_at, "%d.%m.%Y %k:%i");
ALTER TABLE users DROP created_at;
ALTER TABLE users DROP updated_at;
ALTER TABLE users RENAME COLUMN cr TO created_at, RENAME COLUMN up TO updated_at;
-- 3.	В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.
 

SELECT value FROM storehouses_products ORDER BY IF (value = 0, 1, 0) ASC, value ASC;
-- 4.	(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)
SELECT * FROM users WHERE birthday_at LIKE '%MAY%' OR birthday_at LIKE '%AUGUST%';
-- 5.	(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
SELECT * FROM CATALOGS WHERE id IN (5,1,2) ORDER BY FIELD (id,5,1,2);
