-- 1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех 
-- общался с выбранным пользователем (написал ему сообщений).

select u.firstname as 'Имя', u.lastname 'Фамилия'
	from messages m inner join users u on (u.id = m.from_user_id)
	where to_user_id = 71
	group by from_user_id
	order by count(1) DESC
	limit 1;



-- 2.Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

SELECT count(1) -- p.user_id 
	FROM posts_likes pl INNER JOIN posts p ON pl.post_id = p.id INNER JOIN 
		 profiles p2 ON (pl.user_id = p2.user_id AND birthday > DATE_SUB(now() , INTERVAL 10 YEAR));




-- 3.Определить кто больше поставил лайков (всего): мужчины или женщины.

	
SELECT p.gender 
	FROM posts_likes pl INNER JOIN profiles p ON pl.user_id = p.user_id AND p.gender != 'x'
	GROUP BY pl.user_id, p.gender 
	ORDER BY count(1) DESC
	LIMIT 1;
	

	
	