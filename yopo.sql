CREATE DATABASE  IF NOT EXISTS `yopo` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `yopo`;
-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: yopo
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image_url` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'BRASA','2021-05-14 06:55:37','2021-05-16 23:28:48','images/1dBitDarp0pBzxETaYW4xkZVtYz9cxIYYxTC1ynB.png'),(2,'FRIED','2021-05-14 06:55:44','2021-05-16 23:28:53','images/m44QjgtYgDSOiBPZuTJDg29EtCWoXONF8MnYjcEl.png'),(3,'FROZEN','2021-05-14 06:55:53','2021-05-16 23:41:36','images/QRdQ7AoF6URDPMTmz1zwJviE18tLK8eu7fAW7ESe.png'),(4,'POSTRES','2021-05-14 06:56:01','2021-05-14 09:25:11','images/OPLUBisp3DkWIhNenRe6UKkHnV0m1djAPLmB9p7p.png');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credentials`
--

DROP TABLE IF EXISTS `credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credentials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `dashboard` tinyint(1) DEFAULT NULL,
  `pos` tinyint(1) DEFAULT NULL,
  `posAdmin` tinyint(1) DEFAULT NULL,
  `rawMaterial` tinyint(1) DEFAULT NULL,
  `products` tinyint(1) DEFAULT NULL,
  `categories` tinyint(1) DEFAULT NULL,
  `subCategories` tinyint(1) DEFAULT NULL,
  `stock` tinyint(1) DEFAULT NULL,
  `inventories` tinyint(1) DEFAULT NULL,
  `inventoriesAdmin` tinyint(1) DEFAULT NULL,
  `customers` tinyint(1) DEFAULT NULL,
  `sales` tinyint(1) DEFAULT NULL,
  `salesAdmin` tinyint(1) DEFAULT NULL,
  `users` tinyint(1) DEFAULT NULL,
  `dispatchedsSale` tinyint(1) DEFAULT NULL,
  `deliveriesSale` tinyint(1) DEFAULT NULL,
  `deliveries` tinyint(1) DEFAULT NULL,
  `paymentMethods` tinyint(1) DEFAULT NULL,
  `deletedReasons` tinyint(1) DEFAULT NULL,
  `offices` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credentials`
--

LOCK TABLES `credentials` WRITE;
/*!40000 ALTER TABLE `credentials` DISABLE KEYS */;
INSERT INTO `credentials` VALUES (1,1,1,NULL,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,'2021-05-17 10:18:15','2021-05-17 10:18:15');
/*!40000 ALTER TABLE `credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Alonso Grimaldo','77035606','Av. Velazco Astete 3471','934094501','agrimaldopci18@gmail.com','Referencia 2','2021-05-17 06:45:47','2021-05-22 15:47:15');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deleted_reasons`
--

DROP TABLE IF EXISTS `deleted_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deleted_reasons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleted_reasons`
--

LOCK TABLES `deleted_reasons` WRITE;
/*!40000 ALTER TABLE `deleted_reasons` DISABLE KEYS */;
INSERT INTO `deleted_reasons` VALUES (1,'DEVOLUCIÓN',NULL,'2021-05-17 10:29:58','2021-05-17 10:29:58');
/*!40000 ALTER TABLE `deleted_reasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliveries`
--

DROP TABLE IF EXISTS `deliveries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deliveries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(10,3) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliveries`
--

LOCK TABLES `deliveries` WRITE;
/*!40000 ALTER TABLE `deliveries` DISABLE KEYS */;
INSERT INTO `deliveries` VALUES (1,'Surco',10.000,'2021-05-15 05:12:03','2021-05-15 05:12:03'),(2,'Barranco',10.000,'2021-05-15 05:12:34','2021-05-15 05:12:34'),(3,'Jesus Maria',10.000,'2021-05-15 05:12:56','2021-05-15 05:12:56'),(4,'La Molina',10.000,'2021-05-15 05:13:04','2021-05-15 05:13:04'),(5,'Lince',10.000,'2021-05-15 05:13:13','2021-05-15 05:13:13'),(6,'Magdalena',10.000,NULL,NULL),(7,'Miraflores',10.000,NULL,NULL),(8,'Centro De Lima',10.000,NULL,NULL),(9,'Pueblo Libre',10.000,NULL,NULL),(10,'San Isidro',10.000,NULL,NULL),(11,'San Luis',10.000,NULL,NULL),(12,'San Miguel',10.000,NULL,NULL),(13,'Santa Catalina',10.000,NULL,NULL),(14,'Surquillo',10.000,NULL,NULL);
/*!40000 ALTER TABLE `deliveries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliveryman`
--

DROP TABLE IF EXISTS `deliveryman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deliveryman` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliveryman`
--

LOCK TABLES `deliveryman` WRITE;
/*!40000 ALTER TABLE `deliveryman` DISABLE KEYS */;
/*!40000 ALTER TABLE `deliveryman` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disabled`
--

DROP TABLE IF EXISTS `disabled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disabled` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `office_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disabled`
--

LOCK TABLES `disabled` WRITE;
/*!40000 ALTER TABLE `disabled` DISABLE KEYS */;
INSERT INTO `disabled` VALUES (26,7,1,'2021-05-14 08:54:00','2021-05-14 08:54:00');
/*!40000 ALTER TABLE `disabled` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventories`
--

DROP TABLE IF EXISTS `inventories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `office_id` int(11) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `codigo` char(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `weight` double(10,3) NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `raw_material_id` bigint(20) unsigned DEFAULT NULL,
  `dispatched_date` date DEFAULT NULL,
  `delivered_date` date DEFAULT NULL,
  `sale_price` double(10,3) NOT NULL DEFAULT '0.000',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventories`
--

LOCK TABLES `inventories` WRITE;
/*!40000 ALTER TABLE `inventories` DISABLE KEYS */;
INSERT INTO `inventories` VALUES (1,1,1,1,'DzI6FuZiDZ',1.000,10,NULL,'2021-05-17','2021-05-17',75.000,NULL,'2021-05-14 08:59:46','2021-05-17 16:50:52'),(2,1,1,1,'cubRweneB6',1.000,2,NULL,NULL,NULL,75.000,'2021-05-17 10:20:16','2021-05-14 08:59:46','2021-05-17 10:20:16'),(3,1,1,1,'omK2ztQ9XC',1.000,3,NULL,NULL,NULL,75.000,'2021-05-17 10:20:19','2021-05-14 08:59:46','2021-05-17 10:20:19'),(4,1,1,1,'6brU7GWm66',1.000,4,NULL,NULL,NULL,75.000,NULL,'2021-05-14 08:59:46','2021-05-17 06:58:38'),(5,1,1,1,'5OYwmsN7Kt',1.000,NULL,NULL,NULL,NULL,0.000,NULL,'2021-05-14 08:59:46','2021-05-14 08:59:46'),(6,1,1,1,'uSF0g5rDMP',1.000,NULL,NULL,NULL,NULL,0.000,NULL,'2021-05-14 08:59:46','2021-05-14 08:59:46'),(7,1,1,1,'rtp5FObmFI',1.000,NULL,NULL,NULL,NULL,0.000,NULL,'2021-05-14 08:59:46','2021-05-14 08:59:46'),(8,1,1,1,'AuzVetfIcx',1.000,NULL,NULL,NULL,NULL,0.000,NULL,'2021-05-14 08:59:46','2021-05-14 08:59:46'),(9,1,1,1,'8scctU6UqP',1.000,NULL,NULL,NULL,NULL,0.000,'2021-05-17 10:20:36','2021-05-14 08:59:46','2021-05-17 10:20:36'),(10,1,1,1,'9BsOK4HYLr',1.000,NULL,NULL,NULL,NULL,0.000,'2021-05-17 10:20:33','2021-05-14 08:59:46','2021-05-17 10:20:33'),(11,2,1,1,'xffjyIkkUh',1.000,5,NULL,NULL,NULL,55.000,NULL,'2021-05-14 08:59:55','2021-05-17 06:59:45'),(12,2,1,1,'bYpzA3Xeer',1.000,6,NULL,NULL,NULL,55.000,NULL,'2021-05-14 08:59:55','2021-05-17 07:11:51'),(13,2,1,1,'BSvl0chOtP',1.000,7,NULL,NULL,NULL,55.000,NULL,'2021-05-14 08:59:55','2021-05-17 07:13:35'),(14,2,1,1,'TjfBCp9d9W',1.000,8,NULL,NULL,NULL,55.000,NULL,'2021-05-14 08:59:55','2021-05-17 07:18:35'),(15,2,1,1,'EBfJ1LNczR',1.000,9,NULL,'2021-05-17',NULL,55.000,NULL,'2021-05-14 08:59:55','2021-05-17 17:39:27'),(16,2,1,1,'HK374RMDyx',1.000,10,NULL,NULL,NULL,55.000,NULL,'2021-05-14 08:59:55','2021-05-17 16:50:52'),(17,2,1,1,'9YySU9huVK',1.000,10,NULL,NULL,NULL,55.000,NULL,'2021-05-14 08:59:55','2021-05-17 16:50:52'),(18,2,1,1,'0ZdtAZTYw4',1.000,NULL,NULL,NULL,NULL,0.000,NULL,'2021-05-14 08:59:55','2021-05-14 08:59:55'),(19,2,1,1,'D1OtT1CliR',1.000,NULL,NULL,NULL,NULL,0.000,NULL,'2021-05-14 08:59:55','2021-05-14 08:59:55'),(20,2,1,1,'Dvf60eNaYg',1.000,NULL,NULL,NULL,NULL,0.000,NULL,'2021-05-14 08:59:55','2021-05-14 08:59:55'),(21,1,1,1,'Pk8BUd4ORM',1.000,NULL,NULL,NULL,NULL,0.000,NULL,'2021-05-17 10:20:54','2021-05-17 10:20:54'),(22,1,1,1,'erajjrK1Xn',1.000,NULL,NULL,NULL,NULL,0.000,NULL,'2021-05-17 10:20:54','2021-05-17 10:20:54'),(23,1,1,1,'WxRDAksrTe',1.000,NULL,NULL,NULL,NULL,0.000,NULL,'2021-05-17 10:20:54','2021-05-17 10:20:54'),(24,1,1,1,'JV99l01zXD',1.000,NULL,NULL,NULL,NULL,0.000,NULL,'2021-05-17 10:20:54','2021-05-17 10:20:54');
/*!40000 ALTER TABLE `inventories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (4,'2014_10_12_000000_create_users_table',1),(5,'2014_10_12_100000_create_password_resets_table',1),(6,'2019_08_19_000000_create_failed_jobs_table',1),(7,'2020_07_14_044539_create_products_table',1),(8,'2020_07_15_071359_create_categories_table',1),(9,'2020_07_16_071010_create_shoppings_table',1),(10,'2020_07_20_231152_create_sub_categories_table',1),(11,'2020_07_21_000519_create_inventories_table',1),(12,'2020_07_21_001313_create_customers_table',1),(13,'2020_07_21_001418_create_sales_table',1),(14,'2020_07_21_002213_create_sales_details_table',1),(15,'2020_08_02_205239_create_deliveries_table',1),(16,'2020_08_05_002331_create_payment_methods_table',1),(17,'2020_08_20_162814_create_payments_table',1),(18,'2020_08_25_040825_create_deleted_reasons_table',1),(19,'2020_08_26_054857_create_credentials_table',1),(20,'2020_09_03_214553_create_deliveryman_table',1),(21,'2020_09_27_184726_create_offices_table',1),(22,'2020_10_17_214611_create_disabled_table',1),(23,'2020_11_03_164243_create_raw_materials_table',1),(24,'2020_11_03_171759_alter_inventories_table',1),(25,'2020_11_07_144032_alter_sales_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offices`
--

DROP TABLE IF EXISTS `offices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `disabled` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offices`
--

LOCK TABLES `offices` WRITE;
/*!40000 ALTER TABLE `offices` DISABLE KEYS */;
INSERT INTO `offices` VALUES (1,'Tienda Virtual',NULL,'2021-05-14 06:50:47','2021-05-17 17:17:47',1);
/*!40000 ALTER TABLE `offices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_methods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_methods`
--

LOCK TABLES `payment_methods` WRITE;
/*!40000 ALTER TABLE `payment_methods` DISABLE KEYS */;
INSERT INTO `payment_methods` VALUES (1,'Yape',NULL,'2021-05-17 10:08:11','2021-05-17 10:08:11'),(2,'Plin',NULL,'2021-05-17 10:08:15','2021-05-17 10:08:15'),(3,'Transferencia BBVA',NULL,'2021-05-17 10:08:22','2021-05-17 10:08:22'),(4,'Transferencia BCP',NULL,'2021-05-17 10:08:27','2021-05-17 10:08:27'),(5,'Transferencia INTERBANK',NULL,'2021-05-17 10:08:43','2021-05-17 10:08:43');
/*!40000 ALTER TABLE `payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mercadopago_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'approved',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,NULL,1,'approved','2021-05-17 10:44:23','2021-05-17 10:44:23');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sale_price` double(10,3) NOT NULL DEFAULT '0.000',
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_category_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `image_url` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Pollo Entero',75.000,'Increíble Pollo a la Brasa Yopero',1,1,'images/uFqHKTpB9u2zhX9NTptokkAi0knkJVADnZcvchNB.png','NIU',NULL,'2021-05-14 07:36:02','2021-05-17 12:28:52'),(2,'Pollo Frito',55.000,'Excelente Pollo Frito con Papás',1,2,'images/RbH59jQPwkGWjdtEJCXxwJLiHLyKMppgFXjnIhqa.png','NIU',NULL,'2021-05-14 08:06:31','2021-05-14 08:06:31'),(27,'Hamburguesa',35.000,'Deliciosa Hamburguesa con la mejor carne que vas a encontrar',1,2,'images/WrDB6aCL6P5R5gE3vOGoeQcUvrIYQD91ZiWSREh4.png','NIU',NULL,'2021-05-14 09:36:08','2021-05-14 09:36:08'),(28,'Nugguets',15.000,'Six Pack De Deliciosas Nugguets de Pollo',1,2,'images/JO7U6bJ5bKiSkPXKXv4mt0eYI9fao31qAQDjiM01.png','NIU',NULL,'2021-05-14 09:36:45','2021-05-14 09:43:30'),(29,'Prueba',45.000,'Chicken Nugguets Congeladas BUENÍSIMAS!',1,3,'images/jby0SWXb6wthx9m0qWXmkQIpED6NCqPBQTHM7Gkv.png','BG','2021-05-17 00:59:17','2021-05-16 23:03:24','2021-05-17 00:59:17');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `raw_materials`
--

DROP TABLE IF EXISTS `raw_materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `raw_materials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `weight` double(10,3) NOT NULL,
  `weight_remaining` double(10,3) NOT NULL,
  `status` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raw_materials`
--

LOCK TABLES `raw_materials` WRITE;
/*!40000 ALTER TABLE `raw_materials` DISABLE KEYS */;
/*!40000 ALTER TABLE `raw_materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `office_id` int(11) NOT NULL,
  `channel` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dispatched_date` date DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `deliver_date` date DEFAULT NULL,
  `delivered_date` date DEFAULT NULL,
  `deleted_reason_id` date DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `payment_method_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_id` int(11) NOT NULL,
  `deliveryman_id` int(11) NOT NULL,
  `delivery_price` double(10,3) NOT NULL,
  `on_model` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'otros',
  `observations` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_time` time NOT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_time` time DEFAULT NULL,
  `payment_autor` time DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,1,1,0,'PUNTO DE VENTA','0000-00-00','2021-05-17','0000-00-00','0000-00-00','0000-00-00',1,'Yape',1,1,10.000,'otros',NULL,'10:30:00','0000-00-00','00:00:00','00:00:00','2021-05-17 10:30:11','2021-05-17 06:50:59','2021-05-17 10:30:11'),(2,1,1,0,'PUNTO DE VENTA',NULL,'2021-05-17',NULL,NULL,NULL,NULL,NULL,1,0,10.000,'otros',NULL,'10:45:00',NULL,NULL,NULL,NULL,'2021-05-17 06:51:40','2021-05-17 06:51:40'),(3,1,1,0,'PUNTO DE VENTA',NULL,'2021-05-18',NULL,NULL,'0000-00-00',NULL,NULL,1,0,10.000,'otros',NULL,'10:30:00',NULL,NULL,NULL,'2021-05-17 12:54:16','2021-05-17 06:52:03','2021-05-17 12:54:16'),(4,1,1,0,'PUNTO DE VENTA',NULL,'2021-05-17',NULL,NULL,NULL,NULL,NULL,1,0,10.000,'otros',NULL,'07:07:00',NULL,NULL,NULL,NULL,'2021-05-17 06:58:37','2021-05-17 06:58:37'),(5,1,1,0,'PUNTO DE VENTA',NULL,'2021-05-17',NULL,NULL,NULL,NULL,NULL,1,0,10.000,'otros',NULL,'07:07:00',NULL,NULL,NULL,NULL,'2021-05-17 06:59:45','2021-05-17 06:59:45'),(6,1,1,0,'PUNTO DE VENTA',NULL,'2021-05-31',NULL,NULL,NULL,NULL,NULL,1,0,10.000,'otros',NULL,'10:10:00',NULL,NULL,NULL,NULL,'2021-05-17 07:11:51','2021-05-17 07:11:51'),(7,1,1,0,'PUNTO DE VENTA',NULL,'2021-05-04',NULL,NULL,NULL,NULL,NULL,1,0,10.000,'otros',NULL,'13:00:00',NULL,NULL,NULL,NULL,'2021-05-17 07:13:35','2021-05-17 07:13:35'),(8,1,1,0,'PUNTO DE VENTA',NULL,'2021-05-31',NULL,NULL,NULL,NULL,NULL,1,0,10.000,'otros',NULL,'10:30:00',NULL,NULL,NULL,NULL,'2021-05-17 07:18:35','2021-05-17 07:18:35'),(9,1,1,0,'PUNTO DE VENTA','2021-05-17','2021-05-17','2021-05-17',NULL,NULL,1,'Yape',3,1,10.000,'otros',NULL,'06:45:00',NULL,NULL,NULL,NULL,'2021-05-17 10:44:23','2021-05-17 17:39:27'),(10,1,1,0,'PUNTO DE VENTA',NULL,'2021-05-17',NULL,NULL,NULL,NULL,NULL,1,0,10.000,'otros',NULL,'10:30:00',NULL,NULL,NULL,NULL,'2021-05-17 16:50:52','2021-05-17 16:50:52');
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_details`
--

DROP TABLE IF EXISTS `sales_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `office_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_details`
--

LOCK TABLES `sales_details` WRITE;
/*!40000 ALTER TABLE `sales_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoppings`
--

DROP TABLE IF EXISTS `shoppings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shoppings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tmp_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int(11) NOT NULL,
  `counter` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoppings`
--

LOCK TABLES `shoppings` WRITE;
/*!40000 ALTER TABLE `shoppings` DISABLE KEYS */;
INSERT INTO `shoppings` VALUES (10,'B6eGfwDEPK',1,4,'2021-05-17 04:05:52','2021-05-17 13:05:11'),(12,'B6eGfwDEPK',27,1,'2021-05-17 13:04:58','2021-05-17 13:04:58'),(13,'B6eGfwDEPK',28,1,'2021-05-17 13:05:02','2021-05-17 13:05:02'),(14,'vlqkanAlQa',1,4,'2021-05-17 16:41:23','2021-05-17 17:33:47'),(17,'vlqkanAlQa',2,1,'2021-05-17 16:45:44','2021-05-17 16:45:44'),(19,'rmxFuEjY9t',2,1,'2021-05-22 15:37:20','2021-05-22 15:40:46'),(20,'rmxFuEjY9t',1,1,'2021-05-22 15:38:54','2021-05-22 15:38:54'),(21,'sZa9unNGUe',2,1,'2021-05-27 19:59:57','2021-05-27 19:59:57'),(22,'sZa9unNGUe',27,1,'2021-05-27 20:01:00','2021-05-27 20:01:00'),(23,'sZa9unNGUe',1,1,'2021-05-27 20:01:17','2021-05-27 20:01:17'),(24,'56QPmjatai',1,1,'2021-05-27 22:23:18','2021-05-27 22:23:18'),(25,'Mmy29EpcN5',1,1,'2021-06-18 06:17:42','2021-06-18 06:17:42'),(26,'sUIXvCTCxT',2,1,'2021-06-18 06:19:33','2021-06-18 06:19:33'),(27,'xoLoFfdS5S',2,1,'2021-06-18 06:29:27','2021-06-18 06:29:27'),(28,'jGTmdfZPHJ',1,1,'2021-06-18 07:50:40','2021-06-18 07:50:40');
/*!40000 ALTER TABLE `shoppings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_categories`
--

DROP TABLE IF EXISTS `sub_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_categories`
--

LOCK TABLES `sub_categories` WRITE;
/*!40000 ALTER TABLE `sub_categories` DISABLE KEYS */;
INSERT INTO `sub_categories` VALUES (1,'PRODUCTO','2021-05-14 07:32:56','2021-05-17 09:56:50'),(2,'COMPLEMENTOS','2021-05-17 09:56:58','2021-05-17 09:57:04');
/*!40000 ALTER TABLE `sub_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_admin` tinyint(1) DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Alonso Grimaldo',1,'agrimaldopci18@gmail.com',NULL,'$2y$10$UnS1p8T830WWlsE6yeUn9edLnfq5fdiuHmqF/rA15RY81aZbWrDmu',NULL,'2021-05-14 06:50:47','2021-05-17 10:18:21');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'yopo'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-18 16:16:36
