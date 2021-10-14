DROP TABLE IF EXISTS user_status;
CREATE TABLE user_status (
	id		   SERIAL PRIMARY KEY COMMENT "Идентификатор строки",
    users_id   BIGINT UNSIGNED COMMENT "Идентификатор пользователя",
    `status`   VARCHAR(30) COMMENT "Текущий статус",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",
    CONSTRAINT user_status_users_id FOREIGN KEY (users_id) REFERENCES users(id)
) COMMENT 'Таблица статусов';


DROP TABLE IF EXISTS education;
CREATE TABLE education (
	id 			   SERIAL PRIMARY KEY COMMENT "Идентификатор строки",
    users_id 	   BIGINT UNSIGNED COMMENT "Идентификатор пользователя",
    University 	   VARCHAR(300) COMMENT "ВУЗ",
    Faculty 	   VARCHAR(300) COMMENT "Факультет",
    Specialization VARCHAR(300) COMMENT "Специализация",
    Mode_of_study  VARCHAR(50)  COMMENT "Форма обучения",
    Status_ed      VARCHAR(50)  COMMENT "Cтатус после обучения",
    created_at     DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
    updated_at     DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",
    CONSTRAINT education_users_id   FOREIGN KEY (users_id) REFERENCES users(id)
) COMMENT 'Таблица об образовании пользователя';


DROP TABLE IF EXISTS like_status;
CREATE TABLE like_status (
	id         SERIAL PRIMARY KEY COMMENT "Идентификатор строки",
    users_id   BIGINT UNSIGNED COMMENT "Идентификатор пользователя",
    object_id  INT UNSIGNED COMMENT "Идентификатор объекта для простановки лайков",
    `status`   BOOLEAN COMMENT "Статус лайка",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",
    CONSTRAINT like_status_users_id FOREIGN KEY (users_id) REFERENCES users(id)
) COMMENT 'Таблица статусов пользователя';


INSERT INTO  user_status (users_id, `status`) VALUE (1, 'В сети');
INSERT INTO  education (users_id, University ) VALUE (1, 'MGU');
INSERT INTO  like_status (users_id, object_id, `status`) VALUE (1, 1, True);

SELECT * FROM users;
SELECT * FROM user_status;
SELECT * FROM education;
SELECT * FROM like_status;