-- 1.	Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
select *
	from users u 
	where exists (select *
						from orders o
						where u.id = o.user_id)
-- 2.	Выведите список товаров products и разделов catalogs, который соответствует товару.
select name as 'Товар', (select name 
							from catalogs c
							where p.catalog_id = c.id) as 'Категория'
	from products p

-- 3.	(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
select f.id as '№',
	   (select name from cities as c where c.label = f.`from`) as 'Город вылета', 
       (select name from cities as c where c.label = f.`to`) as 'Город назначения'
	from flights as f;
			
