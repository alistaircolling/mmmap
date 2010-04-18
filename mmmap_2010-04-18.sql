# Sequel Pro dump
# Version 1630
# http://code.google.com/p/sequel-pro
#
# Host: 127.0.0.1 (MySQL 5.1.37)
# Database: mmmap
# Generation Time: 2010-04-18 16:45:06 +0100
# ************************************************************

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table customers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` (`id`,`name`)
VALUES
	(1,'customer1name'),
	(2,'customer2name'),
	(3,'customer3name'),
	(4,'customer4name'),
	(5,'customer5name'),
	(6,'customer6name');

/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table preferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `preferences`;

CREATE TABLE `preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `value` text,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

LOCK TABLES `preferences` WRITE;
/*!40000 ALTER TABLE `preferences` DISABLE KEYS */;
INSERT INTO `preferences` (`id`,`name`,`value`,`user_id`)
VALUES
	(1,'defaultsearchparameters','{\"customer\":0,\"product\":\"0\",\"saleType\":\"all\",\"fromDate\":\"\",\"toDate\":\"\"}',1),
	(2,'defaultsearchparameters','{\"customer\":0,\"fromDate\":\"\",\"product\":0,\"toDate\":\"\",\"saleType\":\"rental\"}',2),
	(3,'defaultsearchparameters','{\"customer\":0,\"product\":1,\"fromDate\":\"2010-4-1\",\"saleType\":\"sale\",\"toDate\":\"2010-4-2\"}',3);

/*!40000 ALTER TABLE `preferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table products
# ------------------------------------------------------------

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `img_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`,`name`,`img_name`)
VALUES
	(1,'Stop Sign','images/stopSign.jpg'),
	(2,'Go Sign','images/goSign.jpg'),
	(3,'Falling Rocks','images/fallingRocks.jpg'),
	(4,'Roadworks','images/roadWorks.jpg'),
	(5,'Speed Bumps','images/skid.jpg'),
	(6,'Danger!','images/danger.jpg'),
	(7,'Slow Down','images/slowDown.jpg');

/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table transactions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `transactions`;

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `sale_date` date DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `rental_start` date DEFAULT NULL,
  `rental_end` date DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `position` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` (`id`,`customer_id`,`product_id`,`sale_date`,`type`,`rental_start`,`rental_end`,`created_by`,`position`)
VALUES
	(1,1,1,'2010-04-01','sale',NULL,NULL,1,'54.548258875054316,-8.097656250000009'),
	(2,2,3,NULL,'rental','2010-04-03','2010-04-05',2,'53.64635407782998, -1.5058593750000093'),
	(3,2,2,'2010-01-01','sale',NULL,NULL,1,'57.68220791347688, -4.625976562500009'),
	(4,3,4,NULL,'rental','2010-01-01','2010-01-31',3,'51.70159424562466, -0.09960937500000933,'),
	(5,3,5,NULL,'rental','2010-01-01','2010-01-31',3,'55.70398651723006, 4.97753906250001'),
	(6,5,6,NULL,'rental','2010-01-01','2010-01-31',3,'51.70159424562466, -0.09960937500000933,'),
	(7,5,7,NULL,'rental','2010-01-01','2010-01-31',3,'51.70159424562461, -0.09960937500000931'),
	(8,6,7,NULL,'rental','2010-01-01','2010-01-31',3,'51.70159424562466, -0.09960937500000933,'),
	(9,6,7,NULL,'rental','2010-01-01','2010-01-31',3,'51.70159424562466, -0.09960937500000933,'),
	(10,6,7,NULL,'rental','2010-01-01','2010-01-31',3,'51.70159424562466, -0.09960937500000933,'),
	(11,6,7,NULL,'rental','2010-01-01','2010-01-31',3,'51.70159424562466, -0.09960937500000933,'),
	(12,6,7,NULL,'rental','2010-01-01','2010-01-31',3,'51.70159424562466, -0.09960937500000933,'),
	(13,6,7,NULL,'rental','2010-01-01','2010-01-31',3,'51.70159424562466, -0.09960937500000933,'),
	(14,6,7,NULL,'rental','2010-01-01','2010-01-31',3,'51.70159424562466, -0.09960937500000933,'),
	(15,6,7,NULL,'rental','2010-01-01','2010-01-31',3,'51.70159424562466, -0.09960937500000933,'),
	(16,6,7,NULL,'rental','2010-01-01','2010-01-31',3,'51.70159424562466, -0.09960937500000933,'),
	(17,6,7,NULL,'rental','2010-01-01','2010-01-31',3,'51.70159424562466, -0.09960937500000933,'),
	(53,3,4,NULL,'rental','2010-01-01','2010-01-31',3,'51.70159424562466, -0.09960937500000933,'),
	(52,2,2,'2010-01-01','sale',NULL,NULL,1,'57.68220791347688, -4.625976562500009');

/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`,`username`,`password`,`email`)
VALUES
	(1,'alidrongo','5f4dcc3b5aa765d61d8327deb882cf99','addd@jfhfh.com'),
	(2,'mikos','5f4dcc3b5aa765d61d8327deb882cf99','mikos@hghg.com'),
	(3,'user3','5f4dcc3b5aa765d61d8327deb882cf99','user3@u3.net');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;





/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
