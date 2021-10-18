
-- ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
SELECT DISTINCT firstname 
	FROM users
	ORDER BY firstname ASC;


-- iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). 
-- Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)


ALTER TABLE profiles ADD COLUMN is_active BOOL DEFAULT TRUE;
UPDATE profiles SET is_active = FALSE WHERE YEAR (birthday) > (2021-18);



iv. Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)

SELECT created_at FROM messages;
DELETE FROM messages WHERE created_at > now();


v. Написать название темы курсового проекта (в комментарии)
База данных сайта Госуслуги.