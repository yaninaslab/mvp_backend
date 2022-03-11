-- MariaDB dump 10.19  Distrib 10.6.4-MariaDB, for osx10.16 (arm64)
--
-- Host: localhost    Database: shopping_cart
-- ------------------------------------------------------
-- Server version	10.6.4-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cart_UN` (`user_id`),
  CONSTRAINT `cart_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,2),(3,3);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item`
--

DROP TABLE IF EXISTS `cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `cart_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_item_FK` (`item_id`),
  KEY `cart_item_FK_1` (`cart_id`),
  CONSTRAINT `cart_item_FK` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cart_item_FK_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item`
--

LOCK TABLES `cart_item` WRITE;
/*!40000 ALTER TABLE `cart_item` DISABLE KEYS */;
INSERT INTO `cart_item` VALUES (7,4,1),(8,6,3);
/*!40000 ALTER TABLE `cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `price` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `image_url` varchar(500) COLLATE utf8mb4_bin NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `quantity` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `item_FK` (`category_id`),
  CONSTRAINT `item_FK` FOREIGN KEY (`category_id`) REFERENCES `item_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (4,'Pennie Backpack In Colorblock','C$256.80','https://images.coach.com/is/image/Coach/6146_imcah_a0?$desktopProduct$',4,0),(6,'Large Court Backpack In Signature Canvas','C$270','https://images.coach.com/is/image/Coach/6495_imdj8_a0?$desktopProduct$',4,0),(7,'Court Backpack With Tiger Print','C$119.40','https://images.coach.com/is/image/Coach/c6987_imtkc_a0?$desktopProduct$',4,0),(10,'Court Backpack In Signature Canvas','C$159.20','https://images.coach.com/is/image/Coach/c8522_imtvy_a0?$desktopProduct$',4,0),(11,'Kenley Backpack','C$199','https://images.coach.com/is/image/Coach/c5680_imrrj_a0?$desktopProduct$',4,0),(12,'Kenley Backpack With Garden Plaid Print','C$199','https://images.coach.com/is/image/Coach/c8588_imf23_a0?$desktopProduct$',4,0),(13,'Kleo Shoulder Bag 17','C$226.80','https://images.coach.com/is/image/Coach/c5685_imchk_a0?$desktopProduct$',1,0),(14,'Lane Shoulder Bag','C$226.80','https://images.coach.com/is/image/Coach/c8206_ims9v_a0?$desktopProduct$',1,0),(15,'Val Duffle In Signature Canvas','C$238.80','https://images.coach.com/is/image/Coach/c2819_ims5u_a0?$desktopProduct$',1,0),(16,'Kleo Shoulder Bag 17','C$256.80','https://images.coach.com/is/image/Coach/c5687_imgrt_a0?$desktopProduct$',1,0),(17,'Everly Drawstring Shoulder Bag','C$128.40','https://images.coach.com/is/image/Coach/c5671_imchk_a0?$desktopProduct$',1,0),(18,'Rori Shoulder Bag In Colorblock Signature Canvas','C$199','https://images.coach.com/is/image/Coach/c2855_imsdc_a0?$desktopProduct$',1,0),(19,'Jes Crossbody With Coach','C$196.80','https://images.coach.com/is/image/Coach/c8585_imden_a0?$desktopProduct$',2,0),(20,'Tammie Clutch Crossbody In Signature Canvas','C$166.80','https://images.coach.com/is/image/Coach/c7301_imdj8_a0?$desktopProduct$',2,0),(21,'Kleo Crossbody','C$178.80','https://images.coach.com/is/image/Coach/c7376_imblk_a0?$desktopProduct$',2,0),(22,'Camera Bag With Horse And Carriage','C$98.40','https://images.coach.com/is/image/Coach/c4056_imt9z_a0?$desktopProduct$',2,0),(23,'Camera Bag With Horse And Carriage Dot Print','C$129','https://images.coach.com/is/image/Coach/c4057_imm6h_a0?$desktopProduct$',2,0),(24,'Dinky 18 With Quilting','C$275','https://images.coach.com/is/image/Coach/c3843_b4ofu_a0?$desktopProduct$',2,0),(25,'Zip Top Tote With Snowman Print','C$83.40','https://images.coach.com/is/image/Coach/c7255_svf23_a0?$desktopProduct$',3,0),(26,'City Tote In Signature Canvas With Vintage Mini Rose Print','C$113.40','https://images.coach.com/is/image/Coach/c7274_imosn_a0?$desktopProduct$',3,0),(27,'City Tote With Floral Bow Print','C$105','https://images.coach.com/is/image/Coach/c7273_svblm_a0?$desktopProduct$',3,0),(28,'City Tote In Signature Canvas With Kaffe Fassett Print','C$226.80','https://images.coach.com/is/image/Coach/5698_svroh_a0?$desktopProduct$',3,0),(29,'Gallery Tote With Garden Plaid Print','C$164','https://images.coach.com/is/image/Coach/c8755_imtvt_a0?$desktopProduct$',3,0),(30,'Tote With Coach','C$166.80','https://images.coach.com/is/image/Coach/c8293_imtvt_a0?$desktopProduct$',3,0),(31,'Corner Zip Wristlet In Signature Canvas','C$39','https://images.coach.com/is/image/Coach/58035_imrvq_a0?$desktopProduct$',5,0),(32,'Large Corner Zip Wristlet With Coach','C$59','https://images.coach.com/is/image/Coach/c8311_imden_a0?$desktopProduct$',5,0),(33,'Nolita 15','C$79','https://images.coach.com/is/image/Coach/6386_imf8q_a0?$desktopProduct$',5,0),(34,'Nolita 19','C$112.80','https://images.coach.com/is/image/Coach/c1985_imblk_a0?$desktopProduct$',5,0),(35,'Nolita 19 In Signature Canvas With Bee Print','C$130.80','https://images.coach.com/is/image/Coach/c8673_ime7v_a0?$desktopProduct$',5,0),(36,'Nolita 15 In Signature Chambray','C$106.80','https://images.coach.com/is/image/Coach/c8665_imdei_a0?$desktopProduct$',5,0);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_category`
--

DROP TABLE IF EXISTS `item_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_category`
--

LOCK TABLES `item_category` WRITE;
/*!40000 ALTER TABLE `item_category` DISABLE KEYS */;
INSERT INTO `item_category` VALUES (1,'bags'),(2,'crossbody bags'),(3,'totes'),(4,'backpacks'),(5,'wallets');
/*!40000 ALTER TABLE `item_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase`
--

DROP TABLE IF EXISTS `purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_FK` (`user_id`),
  KEY `purchase_FK_1` (`item_id`),
  CONSTRAINT `purchase_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `purchase_FK_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase`
--

LOCK TABLES `purchase` WRITE;
/*!40000 ALTER TABLE `purchase` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `f_name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `l_name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `phone` varchar(10) COLLATE utf8mb4_bin NOT NULL,
  `salt` varchar(15) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'Yana','Slabetska','yana@gmail.com','yana123','6475701711','H9ouTSVq-KmEeg'),(3,'Tonya','Seldon','tonya@gmail.com','tonya123','6475701815','3JysMee47yyrLA');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_session`
--

DROP TABLE IF EXISTS `user_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login_token` varchar(300) COLLATE utf8mb4_bin NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_session_UN` (`login_token`),
  KEY `user_session_FK` (`user_id`),
  CONSTRAINT `user_session_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_session`
--

LOCK TABLES `user_session` WRITE;
/*!40000 ALTER TABLE `user_session` DISABLE KEYS */;
INSERT INTO `user_session` VALUES (2,'Sd_waQAhomEu7TsHwrJergt2GrR_1W8M7CJdyOZBo2OYZb7UegUblSJUF-VKea4pABY',2),(4,'LP9sncRIcnAx5ok4UvQStIrkUNR8653QXEJQYKTtenWzDHtvjR_m8p4tMiHGiG2QrjY',3);
/*!40000 ALTER TABLE `user_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'shopping_cart'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-10 22:51:30
