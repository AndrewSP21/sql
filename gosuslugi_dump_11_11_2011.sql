-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: gosuslugi
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actions_in_the_system`
--

DROP TABLE IF EXISTS `actions_in_the_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actions_in_the_system` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `date_action` datetime DEFAULT NULL,
  `name_action` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `IP_adress` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `OS_and_browser` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Actions_in_the_system_user_id_idx` (`user_id`),
  CONSTRAINT `Actions_in_the_system_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Лог активности пользователя';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions_in_the_system`
--

LOCK TABLES `actions_in_the_system` WRITE;
/*!40000 ALTER TABLE `actions_in_the_system` DISABLE KEYS */;
INSERT INTO `actions_in_the_system` VALUES (1,1,'2012-10-03 12:00:34','Вход в систему','185.240.159.127','Opera/9.72 (X11; Linuxi686; en-US) Prest'),(2,2,'1995-05-18 21:07:04','Вход в систему','188.26.177.78','Opera/9.29 (Windows NT 5.2; en-US) Prest'),(3,3,'1983-01-03 01:09:36','Вход в систему','206.63.207.17','Opera/8.68 (X11; Linuxi686; sl-SI) Prest'),(4,4,'2016-05-10 16:33:42','Вход в систему','111.199.48.39','Opera/9.43 (Windows CE; en-US) Presto/2.'),(5,2,'1996-02-13 15:40:26','Выход из системы','224.93.109.68','Opera/8.21 (X11; Linuxx86_64; sl-SI) Pre'),(6,3,'1984-07-18 19:31:24','Выход из системы','106.17.16.134','Opera/8.93 (X11; Linuxx86_64; en-US) Pre'),(7,4,'2017-08-29 14:55:44','Выход из системы','42.226.124.27','Opera/8.40 (X11; Linuxi686; en-US) Prest'),(8,1,'1988-10-15 19:14:08','Вход в систему','39.110.192.78','Opera/8.22 (X11; Linuxx86_64; en-US) Pre'),(9,1,'2019-10-04 09:40:48','Выход из системы','216.179.135.226','Opera/9.37 (X11; Linuxx86_64; sl-SI) Pre'),(10,1,'1992-11-29 18:04:28','Вход в систему','26.142.203.98','Opera/9.47 (X11; Linuxi686; sl-SI) Prest');
/*!40000 ALTER TABLE `actions_in_the_system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_accounts`
--

DROP TABLE IF EXISTS `bank_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_accounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `bank_bik` char(9) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `bank_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `cor_account_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Bank_accounts_user_id_idx` (`user_id`),
  CONSTRAINT `Bank_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Банковские счета';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_accounts`
--

LOCK TABLES `bank_accounts` WRITE;
/*!40000 ALTER TABLE `bank_accounts` DISABLE KEYS */;
INSERT INTO `bank_accounts` VALUES (1,1,'332700624','Сбербанк','4929722562154','4929136737987'),(2,2,'839716439','Сбербанк','6011821514098932','5443637635343519'),(3,3,'200480351','Сбербанк','5503649737273732','5312394673834971'),(4,4,'483252469','ВТБ','5279966042678307','5496949358916729'),(5,5,'814821325','ВТБ','343082931965562','4929078450810712'),(6,6,'624349245','Тинькофф','5232699935930817','4716767876175383'),(7,7,'677282281','Тинькофф','5273677356159672','4532556811251976'),(8,8,'513363702','Тинькофф','5577573394122707','4929636489592309'),(9,9,'534971697','Альфа','6011489738365293','4461521115038980'),(10,10,'134767410','Альфа','5122516553194394','4539283432275');
/*!40000 ALTER TABLE `bank_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_cards`
--

DROP TABLE IF EXISTS `bank_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_cards` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `card_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_date` date DEFAULT NULL,
  `cvc_hash` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Bank_Cards_user_id_idx` (`user_id`),
  CONSTRAINT `Bank_Cards_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Банковские карты';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_cards`
--

LOCK TABLES `bank_cards` WRITE;
/*!40000 ALTER TABLE `bank_cards` DISABLE KEYS */;
INSERT INTO `bank_cards` VALUES (1,1,'5539749069386278','2005-03-09','09af5a619c1900dfc39eb80355eae5aa8aa91198'),(2,2,'4716967889337199','1986-02-20','ee570b6bfddac8df54e0882ad2a200d0a723b02d'),(3,3,'375774581617321','2011-04-14','57e3f22a90bae360178bfc61c0d9fe5922edd544'),(4,4,'348541595706001','1984-03-23','ebf2f6f4725e4bb88f071c13e5dca9c79f0f4b66'),(5,5,'5283739395427630','2019-05-05','20f9197cc7010e5cdf934919a943cfc219b9dd95'),(6,6,'349049759718623','1991-10-21','1a6c632a39b4d1ddda96cd63c61ca683650be3a1'),(7,7,'5530806117467323','1989-08-31','1dee07739369afdfdee11bee3d0dd8ac2e113682'),(8,8,'374699950768881','1987-10-10','772fabe90d68ff4ce84126a2f776cffa5ecbc4d5'),(9,9,'4916059437098','1993-03-30','f9ac093bd762953b8c8fe4ccf0185d3d4676c5ac'),(10,10,'5312335971808204','1972-09-15','2a70aeae17f46c0ca95c5b8bda5d89b530984b94');
/*!40000 ALTER TABLE `bank_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `childrens`
--

DROP TABLE IF EXISTS `childrens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `childrens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id_parent` bigint unsigned DEFAULT NULL,
  `user_id_child` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Childrens_user_id_parent` (`user_id_parent`),
  KEY `Childrens_user_id_chil` (`user_id_child`),
  CONSTRAINT `Childrens_user_id_chil` FOREIGN KEY (`user_id_child`) REFERENCES `users` (`id`),
  CONSTRAINT `Childrens_user_id_parent` FOREIGN KEY (`user_id_parent`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Дети - те же пользователи, но имеют ссылку на пользователя являющегося родителем';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `childrens`
--

LOCK TABLES `childrens` WRITE;
/*!40000 ALTER TABLE `childrens` DISABLE KEYS */;
INSERT INTO `childrens` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);
/*!40000 ALTER TABLE `childrens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordered_services`
--

DROP TABLE IF EXISTS `ordered_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordered_services` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `service_id` bigint unsigned DEFAULT NULL,
  `date_status` date DEFAULT NULL,
  `order_status` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ordered_services_user_id_idx` (`user_id`),
  KEY `ordered_services_service_id` (`service_id`),
  CONSTRAINT `ordered_services_service_id` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`),
  CONSTRAINT `ordered_services_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Заказанные услуги и статусы их выполнения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordered_services`
--

LOCK TABLES `ordered_services` WRITE;
/*!40000 ALTER TABLE `ordered_services` DISABLE KEYS */;
INSERT INTO `ordered_services` VALUES (1,1,1,'2016-04-20','Выполнено'),(2,2,2,'2010-11-22','Выполнено'),(3,3,3,'1987-12-29','Выполнено'),(4,4,4,'2009-06-29','В процессе'),(5,5,5,'2001-08-19','В процессе'),(6,6,6,'2015-03-03','В процессе'),(7,7,7,'2005-07-08','Отклонено'),(8,8,8,'2000-09-03','Отклонено'),(9,9,9,'2011-12-17','Отклонено'),(10,10,10,'2015-11-24','Выполнено');
/*!40000 ALTER TABLE `ordered_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `INN` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(21) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `site` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `organization_id_idx` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Организации';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (1,'340662572700','Детский мир','+79046417575','http://torp.net/'),(2,'601122745714','Лента','+79139662432','http://colesanford.org/'),(3,'601127273258','Ашан','+79559059467','http://dietrichcrooks.biz/'),(4,'534972832900','Да','+79376310070','http://bergebrakus.biz/'),(5,'471684499616','О\'Кей','+79204371984','http://www.kemmer.com/'),(6,'522100153660','Магнит','+79892929737','http://www.cormier.net/'),(7,'601120841826','Пятерочка','+79851532768','http://harber.com/'),(8,'601195598998','Метро','+79578874661','http://www.dach.biz/'),(9,'402400716346','Лабиринт','+79339775033','http://treutelcummerata.com/'),(10,'491644746263','Лореаль','+79962251211','http://www.friesen.com/');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization_permission`
--

DROP TABLE IF EXISTS `organization_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_permission` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `table_row` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `organization_permission_user_id_idx` (`user_id`),
  KEY `organization_permission_organization_id` (`organization_id`),
  CONSTRAINT `organization_permission_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`),
  CONSTRAINT `organization_permission_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Разрешение для организаций';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization_permission`
--

LOCK TABLES `organization_permission` WRITE;
/*!40000 ALTER TABLE `organization_permission` DISABLE KEYS */;
INSERT INTO `organization_permission` VALUES (1,1,1,'bank_cards.card_number'),(2,2,2,'user.firstname'),(3,3,3,'user.firstname'),(4,4,4,'user.lastname'),(5,5,5,'user.lastname'),(6,6,6,'user.phone'),(7,7,7,'user.phone'),(8,8,8,'user.email'),(9,9,9,'user.phone'),(10,10,10,'user.email');
/*!40000 ALTER TABLE `organization_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passport`
--

DROP TABLE IF EXISTS `passport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passport` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `passport_type_id` bigint unsigned NOT NULL,
  `passport_series` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `passport_number` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `birthday` date NOT NULL,
  `date_of_issue` date NOT NULL,
  `date_of_expiration` date DEFAULT NULL,
  `authority_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `authority_number` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `residence_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `passport_id_idx` (`id`),
  KEY `passport_type_id` (`passport_type_id`),
  CONSTRAINT `passport_type_id` FOREIGN KEY (`passport_type_id`) REFERENCES `passport_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Под паспортом понимается удостоверение личности - Паспотр РФ, Заграничный паспорт, Свидетельство о рождении';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passport`
--

LOCK TABLES `passport` WRITE;
/*!40000 ALTER TABLE `passport` DISABLE KEYS */;
INSERT INTO `passport` VALUES (1,1,'982','16912182','1991-06-04','2013-10-26','2022-09-14','МВД','40616','12836 Braun Spurs\nSchadenside, IA 93258'),(2,2,'429','14376030','1998-10-22','1999-06-16','2007-04-25','МВД','22444381','50990 Carmela Pines Apt. 198\nColefurt, WV 08125-0832'),(3,3,'089','04473855','1982-08-27','1985-01-05','2004-05-08','МВД','6396649','670 Lebsack Tunnel\nSouth Courtney, MO 13149'),(4,1,'846','71796208','1997-04-25','2007-04-25','2019-04-03','МВД','23360915','381 Ewell Road\nEast Marcellaberg, CA 32146'),(5,2,'669','22005878','1970-06-04','1989-10-01','2009-12-12','МВД','388879','5041 Sarah Corners Apt. 900\nWest Earnestinemouth, KS 75419'),(6,3,'166','70147247','1999-11-10','2000-09-21','2012-11-10','МВД','394','6648 Howell Freeway Apt. 779\nO\'Reillystad, VA 59650-8271'),(7,1,'027','85703254','1976-08-06','2002-09-20','2009-10-03','ОВД','6119253','1826 Ondricka Road\nRennerberg, GA 76767-6342'),(8,2,'552','08189721','2002-09-20','2009-02-02','2012-11-24','ОВД','2940','718 Bosco Pines\nKaleytown, WA 11499-9908'),(9,3,'382','70661330','1976-12-25','2004-03-30','2008-11-22','ОВД','6854','049 Herzog Extensions Suite 863\nHoegerfurt, NM 03747-9667'),(10,1,'951','62346245','2011-06-04','2013-08-01','2016-06-25','ОВД','17','4321 Breana Island Apt. 382\nGranttown, VT 47966-9715'),(11,2,'396','63012217','1979-11-15','1985-12-05','2001-11-06','ОВД','5','08232 Haag Harbor\nMarkshaven, IA 86837-0641'),(12,3,'677','10107591','2008-11-22','2020-03-13','2025-10-17','ОВД','88709323','28059 Herman Common Suite 191\nJanymouth, WY 33279');
/*!40000 ALTER TABLE `passport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passport_type`
--

DROP TABLE IF EXISTS `passport_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passport_type` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Тип паспорта: Паспотр РФ, Заграничный паспорт, Свидетельство о рождении';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passport_type`
--

LOCK TABLES `passport_type` WRITE;
/*!40000 ALTER TABLE `passport_type` DISABLE KEYS */;
INSERT INTO `passport_type` VALUES (1,'Паспорт РФ'),(2,'Заграничный паспорт'),(3,'Свидетельство о рождении'),(4,'Водительское удостоверение');
/*!40000 ALTER TABLE `passport_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `INN` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `snils` varchar(11) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` enum('f','m','x') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `drivers_license_id` bigint unsigned DEFAULT NULL,
  `passport_rf_id` bigint unsigned DEFAULT NULL,
  `passport_foreign_id` bigint unsigned DEFAULT NULL,
  `birth_certificate_id` bigint unsigned DEFAULT NULL,
  `vehicle_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Profile_passport_rf_id` (`passport_rf_id`),
  KEY `Profile_passport_foreign_idd` (`passport_foreign_id`),
  KEY `Profile_vehicle_id` (`vehicle_id`),
  CONSTRAINT `Profile_passport_foreign_idd` FOREIGN KEY (`passport_foreign_id`) REFERENCES `passport` (`id`),
  CONSTRAINT `Profile_passport_rf_id` FOREIGN KEY (`passport_rf_id`) REFERENCES `passport` (`id`),
  CONSTRAINT `Profile_User_id` FOREIGN KEY (`id`) REFERENCES `users` (`id`),
  CONSTRAINT `Profile_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Профиль пользователя - редко изменяемые атрибуты';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES (1,'516739332563','60112876371','f',1,1,1,1,1),(2,'491659254038','45398483239','f',2,2,2,2,2),(3,'471666318727','40942495446','m',3,3,3,3,3),(4,'601199471400','51964443073','m',4,4,4,4,4),(5,'448505469450','54129606693','f',5,5,5,5,5),(6,'531249880560','49291599224','m',6,6,6,6,6),(7,'513140569119','49168799905','m',7,7,7,7,7),(8,'527630858239','49298158833','f',8,8,8,8,8),(9,'487081831305','53907192844','m',9,9,9,9,9),(10,'543200607326','55668222438','f',10,10,10,10,10);
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(90) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(1500) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `service_id_idx` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Название и описание предоставляемых сервисов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'Получение паспорта','Beatae illo nostrum ea aliquid quo. Neque ut quidem corporis. Quas quo autem nulla. Dolorem praesentium et quas pariatur nihil.'),(2,'Получение водительского удостоверения','Et quas et vel magni ut sed debitis. Quia alias vel quia possimus illo consequatur ipsa laudantium. Voluptatum possimus aut velit sed possimus dolorem.'),(3,'Получение ИНН','Omnis dolor veritatis optio eos voluptatem suscipit quia qui. Possimus sequi minima molestiae expedita. Aut aut qui porro est nobis explicabo.'),(4,'Постановка на учёт транспортного средства','Soluta enim incidunt dolore esse cum magnam porro. Eos atque et earum explicabo veritatis voluptatibus. Occaecati facilis accusamus tempora cumque architecto voluptatem. Odio quisquam consequatur voluptas.'),(5,'Получение загранпаспорта','Cumque saepe impedit excepturi a earum quia dolores molestiae. Hic non quis autem quisquam eligendi ducimus ab sapiente. Velit ut soluta a illo. Rerum dolorem consequatur est voluptatibus rerum.'),(6,'Получение информации о штрафах','Culpa occaecati id reiciendis facere repudiandae voluptatem. Temporibus dolor ut sint. Sit modi porro et ullam dolore. Ut omnis aliquid ratione iure.'),(7,'Получение разрешения на строительство дома','Eaque occaecati nam necessitatibus. Molestiae autem exercitationem qui et voluptates. Quo omnis ratione reprehenderit et et et. Aut id odit reiciendis non quia sunt aliquid.'),(8,'Запись ребенка в детский сад','Numquam voluptatem delectus labore quasi vero. Ut eos dicta molestiae quia. Corporis rerum consectetur porro architecto nesciunt minus.'),(9,'Запись ребенка в школу','Ut fugit maxime consequatur quo provident aut. Laudantium sunt natus alias sit fugiat et nisi. Molestias rerum veritatis qui alias eos.'),(10,'Получение результатов ЕГЭ','Totam laborum veniam culpa velit. Eum voluptatem dolorum delectus. Cupiditate omnis sit perspiciatis dicta beatae ex suscipit quasi. Et accusantium nobis est et voluptas et quis.');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permission`
--

DROP TABLE IF EXISTS `user_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_permission` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `service_id` bigint unsigned DEFAULT NULL,
  `permission` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_permission_user_id_idx` (`user_id`),
  CONSTRAINT `user_permission_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Таблица отображает уровень доступа пользователя к сервисам предоставляемых Госулугами';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permission`
--

LOCK TABLES `user_permission` WRITE;
/*!40000 ALTER TABLE `user_permission` DISABLE KEYS */;
INSERT INTO `user_permission` VALUES (1,1,1,0),(2,2,2,0),(3,3,3,1),(4,4,4,1),(5,5,5,0),(6,6,6,0),(7,7,7,1),(8,8,8,0),(9,9,9,1),(10,10,10,0);
/*!40000 ALTER TABLE `user_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_status`
--

DROP TABLE IF EXISTS `user_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_status` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_status_id_idx` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Статус пользователя в системе: Зарегистрирован, Проверка данных в гос реестрах, Ограниченый доступ, Полный доступ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_status`
--

LOCK TABLES `user_status` WRITE;
/*!40000 ALTER TABLE `user_status` DISABLE KEYS */;
INSERT INTO `user_status` VALUES (33,'Зарегистрирован'),(34,'Проверка данных в гос реестрах'),(35,'Ограниченый доступ'),(36,'Полный доступ');
/*!40000 ALTER TABLE `user_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Р¤Р°РјРёР»РёСЏ',
  `middlename` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'РћС‚С‡РµСЃС‚РІРѕ',
  `password_hash` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(21) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_user_id` bigint unsigned DEFAULT NULL,
  `profile_id` bigint unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `profile_id` (`profile_id`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`),
  KEY `User_Status_id` (`status_user_id`),
  CONSTRAINT `User_Profile_id` FOREIGN KEY (`profile_id`) REFERENCES `profile` (`id`),
  CONSTRAINT `User_Status_id` FOREIGN KEY (`status_user_id`) REFERENCES `user_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Пользователи';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Dandre','Fay','nihil','93400378d1520c0f4e1ad7e82b6b51af89116083','+79274172436','hilma39@example.org',33,1,'1992-09-01 09:07:12','2021-11-11 10:30:42'),(2,'Rosa','Glover','harum','e50b7cc97d32697db28f3a8d617420a47aeefe5d','+79342965451','zschuster@example.com',35,2,'1977-05-28 23:05:44','2021-11-11 10:30:42'),(3,'Lina','Stroman','neque','777ad31c05d457b1d0aca26ccd274374850959a4','+79892309981','kertzmann.ernest@example.com',33,3,'2006-07-29 17:40:04','2021-11-11 10:30:42'),(4,'Cleta','Spencer','molestiae','9aad0c7378840b4765fb2cd8ae3840e7b2b326fe','+79432653584','greenfelder.green@example.net',35,4,'2008-03-25 23:52:30','2021-11-11 10:47:22'),(5,'Dominique','Schamberger','et','7f2f061b192b12d3b7b35cddbd7380257836bf5b','+79486338008','xschmidt@example.net',34,5,'1986-09-08 01:36:29','2021-11-11 10:30:42'),(6,'Hallie','Deckow','sint','7d5d297c43a8a496f1cfa467789265df1a425f28','+79133729319','zkonopelski@example.com',34,6,'1971-05-16 19:08:23','2021-11-11 10:47:22'),(7,'Adella','Crona','neque','bacd1bf51eebac0f9ce13391b9773fa70959d2b4','+79209632600','lance33@example.org',35,7,'1995-02-07 06:35:46','2021-11-11 10:47:22'),(8,'Timmy','Lakin','labore','35f6b5d37d5c19ef6368cf639c8ec1a88903845a','+79646975076','asawayn@example.com',33,8,'2010-03-19 23:13:54','2021-11-11 10:47:22'),(9,'Petra','Price','nostrum','a4157f775d9cb0766b175e39734123213837aa7d','+79605977614','mekhi.jacobson@example.org',34,9,'2007-11-13 05:43:16','2021-11-11 10:30:43'),(10,'Precious','Douglas','cupiditate','f91c17acd1f6b8bfa99e2cd48e871a31ea2f66a2','+79088962873','rick75@example.net',33,10,'2003-09-17 00:28:28','2021-11-11 10:47:22');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `grz` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `passport_series` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `passport_number` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `vehicle_model` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `vin` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `vehicle_type` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `vechicle_color` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `release_year` char(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `max_weight` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `norm_weight` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `engine_power` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vehicle` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Транспортное средство';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES (1,'a191оо197','126','979192','Мерседес','5179127633695392','Легковая','green','2003','2621','2263','105'),(2,'a693оо197','145','907290','Мерседес','4716990276616275','Легковая','fuchsia','1995','2720','2057','071'),(3,'a188оо197','908','998870','Вольво','4539113627700811','Легковая','aqua','2018','2738','1995','187'),(4,'a266оо197','639','972485','Вольво','6011957908194887','Легковая','black','1990','2530','2304','115'),(5,'a962оо197','680','965817','Вольво','4532974164476667','Грузовая','silver','1991','2437','2040','107'),(6,'a918оо197','856','911632','Ауди','6011844321896394','Легковая','olive','2018','2594','1786','284'),(7,'a603оо197','174','960706','Ауди','5587101486569349','Легковая','aqua','2019','2662','2310','204'),(8,'a163оо197','470','968637','Ауди','4916775894470969','Легковая','purple','1985','2531','1694','138'),(9,'a905оо197','951','961068','Мазда','4532310110659','Легковая','gray','2001','2669','2041','073'),(10,'a940оо197','582','999431','Мазда','4539694988645','Легковая','maroon','1982','2754','1623','155');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-11 12:00:37
