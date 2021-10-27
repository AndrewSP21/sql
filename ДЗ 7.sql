-- 1.	��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.
select *
	from users u 
	where exists (select *
						from orders o
						where u.id = o.user_id)
-- 2.	�������� ������ ������� products � �������� catalogs, ������� ������������� ������.
select name as '�����', (select name 
							from catalogs c
							where p.catalog_id = c.id) as '���������'
	from products p

-- 3.	(�� �������) ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name). ���� from, to � label �������� ���������� �������� �������, ���� name � �������. �������� ������ ������ flights � �������� ���������� �������.
select f.id as '�',
	   (select name from cities as c where c.label = f.`from`) as '����� ������', 
       (select name from cities as c where c.label = f.`to`) as '����� ����������'
	from flights as f;
			
