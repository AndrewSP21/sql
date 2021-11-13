-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах 
-- users, catalogs и products в таблицу logs помещается время и дата создания записи, 
-- название таблицы, идентификатор первичного ключа и содержимое поля name.


DROP TABLE IF EXISTS logs;

CREATE TABLE logs (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	date_time DATETIME DEFAULT CURRENT_TIMESTAMP,
	name_table VARCHAR(50),
	name_foreign_key VARCHAR(50),
	name_column  VARCHAR(50)
)COMMENT'Логирование записей'   ENGINE = Archive;

DROP TRIGGER IF EXISTS log_users_insert;

CREATE TRIGGER log_users_insert AFTER INSERT ON users
FOR EACH ROW
	BEGIN
	  INSERT INTO logs(name_table, name_foreign_key, name_column) VALUES ('users', NEW.id, NEW.name);
	END;

INSERT INTO users (name) VALUES ('Гайя-Елена Мохийам');
SELECT * FROM logs;

SHOW TABLE STATUS LIKE 'logs';

CREATE TRIGGER log_catalogs_insert AFTER INSERT ON catalogs
FOR EACH ROW
	BEGIN
	  INSERT INTO logs(name_table, name_foreign_key, name_column) VALUES ('catalogs', NEW.id, NEW.name);
	END;

INSERT INTO catalogs (name) VALUES ('Минтад');
SELECT * FROM logs;


CREATE TRIGGER log_products_insert AFTER INSERT ON products
FOR EACH ROW
	BEGIN
	  INSERT INTO logs(name_table, name_foreign_key, name_column) VALUES ('products', NEW.id, NEW.name);
	END;

INSERT INTO products (name) VALUES ('Орнитоптер');
SELECT * FROM logs;
USE shop;



-- (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.


DROP PROCEDURE add_users_opt;
CREATE PROCEDURE add_users_opt(uopt INT UNSIGNED)
	BEGIN 
		DECLARE i INT DEFAULT 0;
		SET autocommit = 0;
		WHILE i <= uopt DO
			INSERT INTO users (name) VALUES ('Пол'),('Муаддиб'), ('Крис'), ('Альфия'),('Фейраута'),('Харконен'),('Джесика'),('Фрэнк'),('Атрейдес'),('Шай-Хулд');
			SET i = i + 1;
		END WHILE;
		SET autocommit = 1;
		COMMIT;
	END;



CALL add_users_opt (100000);


SELECT count(1) FROM users u ;

