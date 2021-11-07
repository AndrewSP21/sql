-- 1. ����� ����� ��������� ������������. �� ���� ������������� ���. ���� ������� ��������, ������� ������ ���� 
-- ������� � ��������� ������������� (������� ��� ���������).

select u.firstname as '���', u.lastname '�������'
	from messages m inner join users u on (u.id = m.from_user_id)
	where to_user_id = 71
	group by from_user_id
	order by count(1) DESC
	limit 1;



-- 2.���������� ����� ���������� ������, ������� �������� ������������ ������ 10 ���..

SELECT count(1) -- p.user_id 
	FROM posts_likes pl INNER JOIN posts p ON pl.post_id = p.id INNER JOIN 
		 profiles p2 ON (pl.user_id = p2.user_id AND birthday > DATE_SUB(now() , INTERVAL 10 YEAR));




-- 3.���������� ��� ������ �������� ������ (�����): ������� ��� �������.

	
SELECT p.gender 
	FROM posts_likes pl INNER JOIN profiles p ON pl.user_id = p.user_id AND p.gender != 'x'
	GROUP BY pl.user_id, p.gender 
	ORDER BY count(1) DESC
	LIMIT 1;
	

	