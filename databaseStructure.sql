# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.24)
# Database: urbausec
# Generation Time: 2015-05-27 05:33:44 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table CALLS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CALLS`;

CREATE TABLE `CALLS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `TOPIC` varchar(255) DEFAULT NULL,
  `DATE_CALL` date DEFAULT NULL,
  `REASON` int(11) unsigned DEFAULT NULL,
  `CLIENT` int(11) unsigned DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `TYPE` int(11) unsigned DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `SELLER` int(11) DEFAULT NULL,
  `CONTACT` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table CLIENTS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CLIENTS`;

CREATE TABLE `CLIENTS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `RZSOCIAL` varchar(255) DEFAULT NULL,
  `CLIENT` varchar(255) DEFAULT NULL,
  `FAX` varchar(25) DEFAULT NULL,
  `FAXALT` int(25) DEFAULT NULL,
  `TEL` varchar(25) DEFAULT NULL,
  `TELALT` varchar(25) DEFAULT NULL,
  `NUMFISCAL` varchar(25) DEFAULT NULL,
  `ADDRFISCAL` varchar(255) DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `RATING` int(2) DEFAULT NULL,
  `ADDRSHIP` varchar(255) DEFAULT NULL,
  `COUNTRY` int(11) unsigned NOT NULL,
  `TIPO_CLIENTE` int(11) unsigned NOT NULL,
  `SELLER` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table CONTACTS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CONTACTS`;

CREATE TABLE `CONTACTS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(25) DEFAULT NULL,
  `SURNAME` varchar(25) DEFAULT NULL,
  `TEL1` varchar(25) DEFAULT NULL,
  `TEL2` varchar(25) DEFAULT NULL,
  `MOBILE` varchar(25) DEFAULT NULL,
  `ASINGMENT` varchar(25) DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `EMAIL2` varchar(100) DEFAULT NULL,
  `COMMENT` varchar(255) DEFAULT NULL,
  `AREA` varchar(100) DEFAULT NULL,
  `FAX` varchar(25) DEFAULT NULL,
  `COUNTRY` int(11) unsigned DEFAULT NULL,
  `USER` int(11) unsigned DEFAULT NULL,
  `CLIENT` int(11) unsigned DEFAULT NULL,
  `ADDRR1LINE1` varchar(255) DEFAULT NULL,
  `ADDRR1LINE2` varchar(255) DEFAULT NULL,
  `MUNICIPALITY1` int(11) unsigned DEFAULT NULL,
  `DEPTO1` int(11) unsigned DEFAULT NULL,
  `ADDRR2LINE1` varchar(255) DEFAULT NULL,
  `ADDRR2LINE2` varchar(255) DEFAULT NULL,
  `DEPTO2` int(11) unsigned DEFAULT NULL,
  `MUNICIPALITY2` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table COUNTRIES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `COUNTRIES`;

CREATE TABLE `COUNTRIES` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `COUNTRY` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table DEPTOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `DEPTOS`;

CREATE TABLE `DEPTOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DEPTO` varchar(50) DEFAULT NULL,
  `COUNTRY` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table MUNICIPALITIES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MUNICIPALITIES`;

CREATE TABLE `MUNICIPALITIES` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `MUNICIPALITY` varchar(50) DEFAULT NULL,
  `COUNTRY` int(11) unsigned DEFAULT NULL,
  `DEPTO` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table OPCIONES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `OPCIONES`;

CREATE TABLE `OPCIONES` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table OPCIONESXPROGRAMA
# ------------------------------------------------------------

DROP TABLE IF EXISTS `OPCIONESXPROGRAMA`;

CREATE TABLE `OPCIONESXPROGRAMA` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PROGRAMA` int(11) DEFAULT NULL,
  `ID_OPCION` int(11) DEFAULT NULL,
  `ID_ROL` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PLACES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PLACES`;

CREATE TABLE `PLACES` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(25) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `ADDRESS_LINE1` varchar(255) DEFAULT NULL,
  `ADDRESS_LINE2` varchar(255) DEFAULT NULL,
  `DEPARTMENT` int(3) DEFAULT NULL,
  `MUNICIPALITY` int(3) DEFAULT NULL,
  `COUNTRY` int(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PROGRAMAS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PROGRAMAS`;

CREATE TABLE `PROGRAMAS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(50) DEFAULT NULL,
  `PROGRAM_NAME` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table ROLES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ROLES`;

CREATE TABLE `ROLES` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table SELLERS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SELLERS`;

CREATE TABLE `SELLERS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL,
  `SURNAME` varchar(255) DEFAULT NULL,
  `USER` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table SHOWS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SHOWS`;

CREATE TABLE `SHOWS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(25) DEFAULT NULL,
  `DATE` date DEFAULT NULL,
  `CLIENT` int(11) unsigned DEFAULT NULL,
  `PLACE` int(11) DEFAULT NULL,
  `LENGHT` varchar(25) DEFAULT NULL,
  `SELLER` int(11) unsigned DEFAULT NULL,
  `FISCAL_NUM` varchar(50) DEFAULT NULL,
  `BALANCE` int(25) DEFAULT NULL,
  `STATUS` int(11) unsigned DEFAULT NULL,
  `TYPE` int(11) unsigned DEFAULT NULL,
  `HOUR` timestamp NULL DEFAULT NULL,
  `CONTACT` int(11) unsigned DEFAULT NULL,
  `DESCRIPTION` longtext,
  `MELODY` varchar(50) DEFAULT NULL,
  `TOTAL` float DEFAULT NULL,
  `INVOICE_NAME` varchar(50) DEFAULT NULL,
  `OBSERVATIONS` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table STATUS_CALL
# ------------------------------------------------------------

DROP TABLE IF EXISTS `STATUS_CALL`;

CREATE TABLE `STATUS_CALL` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `STATUS` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table STATUS_SHOWS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `STATUS_SHOWS`;

CREATE TABLE `STATUS_SHOWS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `STATUS` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table TIPO_CLIENTES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TIPO_CLIENTES`;

CREATE TABLE `TIPO_CLIENTES` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `TIPO` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table REASONS_CALL
# ------------------------------------------------------------

DROP TABLE IF EXISTS `REASONS_CALL`;

CREATE TABLE `REASONS_CALL` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `REASON` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table TYPES_CALL
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TYPES_CALL`;

CREATE TABLE `TYPES_CALL` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `TYPE` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table TYPES_SHOWS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TYPES_SHOWS`;

CREATE TABLE `TYPES_SHOWS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `TYPE` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table USUARIOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `USUARIOS`;

CREATE TABLE `USUARIOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `USUARIO` varchar(10) NOT NULL DEFAULT '',
  `NOMBRE` varchar(50) DEFAULT NULL,
  `CLAVE` varchar(20) NOT NULL DEFAULT '',
  `ROL` int(11) DEFAULT NULL,
  `ESTADO` tinyint(1) DEFAULT NULL,
  `CORREO` varchar(100) DEFAULT NULL,
  `TELEFONO` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `USUARIO` (`USUARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table VEHICLES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `VEHICLES`;

CREATE TABLE `VEHICLES` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `MARCA` varchar(50) DEFAULT NULL,
  `MODELO` varchar(25) DEFAULT NULL,
  `NOPLACA` varchar(25) DEFAULT NULL,
  `NOCHASIS` varchar(25) DEFAULT NULL,
  `ESTADO` varchar(25) DEFAULT NULL,
  `LICPIROTECNIA` varchar(25) DEFAULT NULL,
  `LICVENCIMIENTO` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
