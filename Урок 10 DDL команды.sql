
DROP DATABASE IF EXISTS gosuslugi;
CREATE DATABASE gosuslugi;
USE gosuslugi;

CREATE TABLE users (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    middlename VARCHAR(50) COMMENT 'Отчество',
 	password_hash VARCHAR(100), 
	phone VARCHAR(21) UNIQUE,     
    email VARCHAR(120) UNIQUE,
    status_user_id bigint UNSIGNED,
	profile_id bigint UNSIGNED UNIQUE,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX users_firstname_lastname_idx(firstname, lastname)
) COMMENT 'Пользователи';



CREATE TABLE User_status(
	id BIGINT UNSIGNED NOT NULL AUTO_user_id BIGINT UNSIGNED,
	name VARCHAR(50),
	INDEX user_status_id_idx(_id)
)COMMENT 'Статус пользователя в системе: Зарегистрирован, Проверка данных в гос реестрах, Ограниченый доступ, Полный доступ';

ALTER TABLE users ADD CONSTRAINT User_Status_id FOREIGN KEY (status_user_id) REFERENCES User_status(id);



CREATE TABLE passport_type(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	name VARCHAR(100)
)COMMENT 'Тип паспорта: Паспотр РФ, Заграничный паспорт, Свидетельство о рождени';

CREATE TABLE passport(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	passport_type_id BIGINT UNSIGNED NOT NULL, -- Тип паспорта: РФ, Загран, Свидетельство о рождении
	passport_series VARCHAR(12),
	passport_number VARCHAR(12) NOT NULL,
	birthday DATE NOT NULL,
	date_of_issue DATE NOT NULL,
	date_of_expiration DATE,
	authority_name VARCHAR(100) NOT NULL, -- Кто выдал
	authority_number VARCHAR(30),         -- Номер подраздления, которое выдало
	residence_address VARCHAR(200),		  -- Адрес регистрации
	INDEX passport_id_idx(id),
	CONSTRAINT passport_type_id FOREIGN KEY (passport_type_id) REFERENCES passport_type(id)
)COMMENT 'Под паспортом понимается удостоверение личности - Паспотр РФ, Заграничный паспорт, Свидетельство о рождении';


ALTER TABLE passport ADD COLUMN user_id BIGINT UNSIGNED;
ALTER TABLE passport ADD CONSTRAINT passport_user_id FOREIGN KEY (user_id) REFERENCES users(id);




CREATE TABLE vehicle(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	grz VARCHAR(30), -- Государственный регистрационный знак
	passport_series VARCHAR(12),
	passport_number VARCHAR(12) NOT NULL,
	vehicle_model VARCHAR(30),
	vin  VARCHAR(30),
	vehicle_type VARCHAR(12),
	vechicle_color VARCHAR(30),
	release_year char(4),
	max_weight VARCHAR(12),
	norm_weight VARCHAR(12),	
	engine_power VARCHAR(12),
	INDEX vehicle(id)
)COMMENT 'Транспортное средство';

ALTER TABLE vehicle ADD COLUMN user_id BIGINT UNSIGNED;
ALTER TABLE vehicle ADD CONSTRAINT vehicle_User_id FOREIGN KEY (user_id) REFERENCES users(id);



CREATE TABLE Profile(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	INN VARCHAR(12),
	snils VARCHAR(11),
	gender ENUM('f', 'm', 'x') NOT NULL,
	INDEX Profile_id_idx(id),
)COMMENT 'Профиль пользователя - редко изменяемые атрибуты';

ALTER TABLE users ADD CONSTRAINT User_Profile_id FOREIGN KEY (profile_id) REFERENCES Profile(id);
ALTER TABLE Profile ADD CONSTRAINT Profile_User_id FOREIGN KEY (id) REFERENCES users(id);


CREATE TABLE Actions_in_the_system(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	user_id BIGINT UNSIGNED,
	date_action DATETIME,
	name_action VARCHAR(150),
	IP_adress VARCHAR(40),
	OS_and_browser VARCHAR(40),
	INDEX Actions_in_the_system_user_id_idx(user_id),
	CONSTRAINT Actions_in_the_system_user_id FOREIGN KEY (user_id) REFERENCES users(id)
)COMMENT 'Лог активности пользователя';

CREATE TABLE Bank_Cards(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	user_id BIGINT UNSIGNED,
	card_number VARCHAR(20),
	card_date DATE,
	cvc_hash VARCHAR(150),
	INDEX Bank_Cards_user_id_idx(user_id),
	CONSTRAINT Bank_Cards_user_id FOREIGN KEY (user_id) REFERENCES users(id)
)COMMENT 'Банковские карты';

CREATE TABLE Bank_accounts(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	user_id BIGINT UNSIGNED,
	bank_bik CHAR(9),
	bank_name VARCHAR(200),
	account_number VARCHAR(20),
	cor_account_number VARCHAR(20),
	INDEX Bank_accounts_user_id_idx(user_id),
	CONSTRAINT Bank_accounts_user_id FOREIGN KEY (user_id) REFERENCES users(id)
)COMMENT 'Банковские счета';

CREATE TABLE Childrens(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, -- У одного ребенка может быть больше чем один родитель, так что для одного ребенка
															-- может быть больше чем одна запись в таблице.  
	user_id_parent BIGINT UNSIGNED, -- ссылка на родителя
	user_id_child BIGINT UNSIGNED,  -- ссылка на ребенка
	CONSTRAINT Childrens_user_id_parent FOREIGN KEY (user_id_parent) REFERENCES users(id),
	CONSTRAINT Childrens_user_id_chil FOREIGN KEY (user_id_child) REFERENCES users(id)
)COMMENT 'Дети - те же пользователи, но имеют ссылку на пользователя являющегося родителем';

CREATE TABLE user_permission(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	user_id BIGINT UNSIGNED,
	service_id BIGINT UNSIGNED,
	permission TINYINT UNSIGNED,
	INDEX user_permission_user_id_idx(user_id),
	CONSTRAINT user_permission_user_id FOREIGN KEY (user_id) REFERENCES users(id)
)COMMENT 'Таблица отображает уровень доступа пользователя к сервисам предоставляемых Госулугами';

CREATE TABLE service(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	name VARCHAR(90),
	description VARCHAR(1500),
	INDEX service_id_idx(id)
)COMMENT 'Название и описание предоставляемых сервисов';

CREATE TABLE services_available(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	service_id BIGINT UNSIGNED,
	user_id BIGINT UNSIGNED,
	permission TINYINT UNSIGNED,
	INDEX services_available_user_id_idx(user_id),
	CONSTRAINT services_availablen_user_id FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT services_availablen_service_id FOREIGN KEY (service_id) REFERENCES service(id)	
)COMMENT 'Доступные услуги';


CREATE TABLE ordered_services(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	user_id BIGINT UNSIGNED,
	service_id BIGINT UNSIGNED,
	date_status DATE,
	order_status VARCHAR(30),
	INDEX ordered_services_user_id_idx(user_id),
	CONSTRAINT ordered_services_user_id FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT ordered_services_service_id FOREIGN KEY (service_id) REFERENCES service(id)	
)COMMENT 'Заказанные услуги и статусы их выполнения';

ALTER TABLE ordered_services ADD COLUMN start_date DATE;

CREATE TABLE organization(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	INN VARCHAR(12),
	name VARCHAR(30),
	phone VARCHAR(21),
	site VARCHAR(200),
	INDEX organization_id_idx(id)
)COMMENT 'Организации';



CREATE TABLE organization_permission(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	organization_id BIGINT UNSIGNED,	-- Ссылка на организацию
	user_id BIGINT UNSIGNED,			-- Ссылка на пользователя
	table_row VARCHAR(100),				-- Колонка таблицы связанной с пользователем к которой получает доступ организация
	INDEX organization_permission_user_id_idx(user_id),
	CONSTRAINT organization_permission_users_id FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT organization_permission_organization_id FOREIGN KEY (organization_id) REFERENCES organization(id)	
)COMMENT 'Разрешение для организаций';













