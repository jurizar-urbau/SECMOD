# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.23)
# Database: volcan
# Generation Time: 2017-03-11 20:06:18 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table ADELANTOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ADELANTOS`;

CREATE TABLE `ADELANTOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `EMPLEADO` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `MONTO` double(15,2) DEFAULT NULL,
  `OBSERVACIONES` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table ALIAS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ALIAS`;

CREATE TABLE `ALIAS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(255) DEFAULT NULL,
  `ID_PRODUCTO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table BANCOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `BANCOS`;

CREATE TABLE `BANCOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table BANCOS_MOVIMIENTOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `BANCOS_MOVIMIENTOS`;

CREATE TABLE `BANCOS_MOVIMIENTOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_BANCO` int(11) DEFAULT NULL,
  `FECHA` timestamp NULL DEFAULT NULL,
  `TIPO_MOVIMIENTO` int(11) DEFAULT NULL,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  `MONTO` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table BODEGAS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `BODEGAS`;

CREATE TABLE `BODEGAS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(30) DEFAULT NULL,
  `DIRECCION` varchar(250) DEFAULT NULL,
  `TELEFONO` varchar(15) DEFAULT NULL,
  `ESTADO` tinyint(1) DEFAULT NULL,
  `ID_PUNTO_DE_VENTA` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table BODEGAS_USUARIOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `BODEGAS_USUARIOS`;

CREATE TABLE `BODEGAS_USUARIOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_BODEGA` int(11) DEFAULT NULL,
  `ID_USUARIO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table CAJA_DETALLE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CAJA_DETALLE`;

CREATE TABLE `CAJA_DETALLE` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_CAJA` int(11) DEFAULT NULL,
  `FECHA_APERTURA` timestamp NULL DEFAULT NULL,
  `FECHA_CIERRE` timestamp NULL DEFAULT NULL,
  `USUARIO_APERTURA` int(11) DEFAULT NULL,
  `USUARIO_CIERRE` int(11) DEFAULT NULL,
  `EFECTIVO_APERTURA` double(15,2) DEFAULT NULL,
  `EFECTIVO_CIERRE` double(15,2) DEFAULT NULL,
  `TARJETA_APERTURA` double(15,2) DEFAULT NULL,
  `TARJETA_CIERRE` double(15,2) DEFAULT NULL,
  `CREDITO_APERTURA` double(15,2) DEFAULT NULL,
  `CREDITO_CIERRE` double(15,2) DEFAULT NULL,
  `CHEQUE_APERTURA` double(15,2) DEFAULT NULL,
  `CHEQUE_CIERRE` double(15,2) DEFAULT NULL,
  `CORRELATIVO_CIERRE` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table CAJA_PUNTO_VENTA
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CAJA_PUNTO_VENTA`;

CREATE TABLE `CAJA_PUNTO_VENTA` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PUNTO_VENTA` int(11) DEFAULT NULL,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  `ESTADO` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table CARGAS_BODEGA
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CARGAS_BODEGA`;

CREATE TABLE `CARGAS_BODEGA` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `BODEGA` int(11) DEFAULT NULL,
  `FECHA` timestamp NULL DEFAULT NULL,
  `USUARIO` int(11) DEFAULT NULL,
  `TRANSID` varchar(300) DEFAULT NULL,
  `CORRELATIVO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table CARGAS_BODEGA_DETALLE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CARGAS_BODEGA_DETALLE`;

CREATE TABLE `CARGAS_BODEGA_DETALLE` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_CARGA` int(11) DEFAULT NULL,
  `ID_PRODUCTO` int(11) DEFAULT NULL,
  `UNIDADES_PRODUCTO` int(11) DEFAULT NULL,
  `UNITARIO` int(11) DEFAULT NULL,
  `PACKING_SELECCIONADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table CLASIFICACION_CLIENTES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CLASIFICACION_CLIENTES`;

CREATE TABLE `CLASIFICACION_CLIENTES` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table CLASIFICACION_RUBROS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CLASIFICACION_RUBROS`;

CREATE TABLE `CLASIFICACION_RUBROS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table CLIENTES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CLIENTES`;

CREATE TABLE `CLIENTES` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NIT` varchar(100) NOT NULL DEFAULT '',
  `NOMBRES` varchar(255) DEFAULT NULL,
  `APELLIDOS` varchar(255) DEFAULT NULL,
  `DIRECCION` varchar(255) DEFAULT NULL,
  `TELEFONO` varchar(30) DEFAULT NULL,
  `CORREO` varchar(255) DEFAULT NULL,
  `TIPODECLIENTE` varchar(15) DEFAULT NULL,
  `ACEPTA_CREDITO` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table CLIENTES_CREDITOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CLIENTES_CREDITOS`;

CREATE TABLE `CLIENTES_CREDITOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_CLIENTE` int(11) DEFAULT NULL,
  `ID_ORDEN` int(11) DEFAULT NULL,
  `FECHA_CREDITO` date DEFAULT NULL,
  `MONTO` double(15,2) DEFAULT NULL,
  `ID_USUARIO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table CLIENTES_CREDITOS_PAGOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CLIENTES_CREDITOS_PAGOS`;

CREATE TABLE `CLIENTES_CREDITOS_PAGOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_CREDITO` int(11) DEFAULT NULL,
  `FECHA` timestamp NULL DEFAULT NULL,
  `MONTO` double(15,2) DEFAULT NULL,
  `TIPO_PAGO` varchar(10) DEFAULT NULL,
  `NO_AUTORIZACION` varchar(255) DEFAULT NULL,
  `NO_CHEQUE` varchar(255) DEFAULT NULL,
  `ID_BANCO` int(11) DEFAULT NULL,
  `TIPO_TARJETA` varchar(255) DEFAULT NULL,
  `NO_TARJETA` varchar(255) DEFAULT NULL,
  `ID_USUARIO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table COMPRAS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `COMPRAS`;

CREATE TABLE `COMPRAS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `FECHA` timestamp NULL DEFAULT NULL,
  `ID_PROVEEDOR` int(11) DEFAULT NULL,
  `ID_ORDEN_DE_COMPRA` int(11) DEFAULT NULL,
  `TIPO_DE_PAGO` varchar(300) DEFAULT NULL,
  `FORMA_DE_INGRESO` int(11) DEFAULT NULL,
  `SUBTOTAL` double(15,2) DEFAULT NULL,
  `DESCUENTO` double(15,2) DEFAULT NULL,
  `TOTAL` double(15,2) DEFAULT NULL,
  `GASTOS` double(15,2) DEFAULT NULL,
  `TOTAL_CON_GASTOS` double(15,2) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  `TRANSID` varchar(300) DEFAULT NULL,
  `CHEQUE_REF` varchar(300) DEFAULT NULL,
  `NUMERO_DE_COMPRA` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table COMPRAS_DETALLE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `COMPRAS_DETALLE`;

CREATE TABLE `COMPRAS_DETALLE` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_COMPRA` int(11) DEFAULT NULL,
  `ID_BODEGA` int(11) DEFAULT NULL,
  `ID_PRODUCTO` int(11) DEFAULT NULL,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  `PAQUETES` int(11) DEFAULT NULL,
  `U_C` int(11) DEFAULT NULL,
  `UNIDADES` int(11) DEFAULT NULL,
  `COSTO` double(15,2) DEFAULT NULL,
  `DESCUENTO` double(15,2) DEFAULT NULL,
  `SUBTOTAL` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table CORRELATIVOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CORRELATIVOS`;

CREATE TABLE `CORRELATIVOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  `CORRELATIVO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table CUPONES_DE_DESCUENTO
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CUPONES_DE_DESCUENTO`;

CREATE TABLE `CUPONES_DE_DESCUENTO` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `MONTO` double(15,2) DEFAULT NULL,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  `ID_USUARIO` int(11) DEFAULT NULL,
  `FECHA_CREACION` date DEFAULT NULL,
  `ESTADO` varchar(1) DEFAULT NULL,
  `ID_CLIENTE` int(11) DEFAULT NULL,
  `ID_ORDEN` int(11) DEFAULT NULL,
  `ID_MOTIVO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table EMPLEADOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `EMPLEADOS`;

CREATE TABLE `EMPLEADOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRES` varchar(300) DEFAULT NULL,
  `APELLIDOS` varchar(300) DEFAULT NULL,
  `DIRECCION` varchar(300) DEFAULT NULL,
  `TELEFONO` varchar(100) DEFAULT NULL,
  `NUMERO_CEDULA` varchar(300) DEFAULT NULL,
  `NIT` varchar(20) DEFAULT NULL,
  `ESTADO_CIVIL` varchar(1) DEFAULT NULL,
  `SEXO` varchar(1) DEFAULT NULL,
  `FECHA_DE_NACIMIENTO` date DEFAULT NULL,
  `HIJOS` int(11) DEFAULT NULL,
  `MUNICIPIO` int(11) DEFAULT NULL,
  `PUESTO` int(11) DEFAULT NULL,
  `TIPO_DE_PAGO` int(11) DEFAULT NULL,
  `NUMERO_CUENTA` varchar(300) DEFAULT NULL,
  `SUELDO_BASE` double(15,2) DEFAULT NULL,
  `BONIFICACION` double(15,2) DEFAULT NULL,
  `FECHA_DE_INGRESO` date DEFAULT NULL,
  `FECHA_DE_EGRESO` date DEFAULT NULL,
  `PORCENTAJE_AHORRO` double(15,2) DEFAULT NULL,
  `CANTIDAD_DE_AHORRO` double(15,2) DEFAULT NULL,
  `AHORRO` double(15,2) DEFAULT NULL,
  `PAGA_IGSS` tinyint(1) DEFAULT NULL,
  `AFILIACION_IGSS` varchar(300) DEFAULT NULL,
  `ESTADO` tinyint(1) DEFAULT NULL,
  `BANCO` int(11) DEFAULT NULL,
  `DESCUENTO_FIJO` double(15,2) DEFAULT NULL,
  `ES_TEMPORAL` tinyint(1) DEFAULT NULL,
  `ES_IMPRIMIBLE` tinyint(1) DEFAULT NULL,
  `INCENTIVO` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table ESTADOS_LLAMADA
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ESTADOS_LLAMADA`;

CREATE TABLE `ESTADOS_LLAMADA` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table FACTURAS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `FACTURAS`;

CREATE TABLE `FACTURAS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ORDEN` int(11) DEFAULT NULL,
  `FACTURA` varchar(300) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `SUBTOTAL` double(15,2) DEFAULT NULL,
  `TOTAL` double(15,2) DEFAULT NULL,
  `USUARIO` int(11) DEFAULT NULL,
  `NIT` varchar(300) DEFAULT NULL,
  `NOMBRE` varchar(300) DEFAULT NULL,
  `DIRECCION` varchar(300) DEFAULT NULL,
  `TRANSID` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table FACTURAS_DETALLE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `FACTURAS_DETALLE`;

CREATE TABLE `FACTURAS_DETALLE` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_FACTURA` int(11) DEFAULT NULL,
  `CANTIDAD` int(11) DEFAULT NULL,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  `SUBTOTAL` double(15,2) DEFAULT NULL,
  `TOTAL` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table FAMILIAS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `FAMILIAS`;

CREATE TABLE `FAMILIAS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table FORMAS_DE_PAGO
# ------------------------------------------------------------

DROP TABLE IF EXISTS `FORMAS_DE_PAGO`;

CREATE TABLE `FORMAS_DE_PAGO` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table GASTOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `GASTOS`;

CREATE TABLE `GASTOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `HABER` tinyint(1) DEFAULT NULL,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  `DOCUMENTO_BASE` varchar(300) DEFAULT NULL,
  `MONTO` double(15,2) DEFAULT NULL,
  `CLASIFICACION` varchar(1) DEFAULT NULL,
  `ID_CARGA` int(11) DEFAULT NULL,
  `ID_PLANILLA` int(11) DEFAULT NULL,
  `ID_RUBRO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table INV0
# ------------------------------------------------------------

DROP TABLE IF EXISTS `INV0`;

CREATE TABLE `INV0` (
  `ID_PRODUCT` decimal(11,0) NOT NULL,
  `ESTATUS` varchar(1) NOT NULL,
  `ID_ORDEN` decimal(11,0) NOT NULL DEFAULT '0',
  `AMOUNT` decimal(12,0) DEFAULT NULL,
  `ID_USUARIO` decimal(11,0) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCT`,`ESTATUS`,`ID_ORDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table INV1000002
# ------------------------------------------------------------

DROP TABLE IF EXISTS `INV1000002`;

CREATE TABLE `INV1000002` (
  `ID_PRODUCT` decimal(11,0) NOT NULL,
  `ESTATUS` varchar(1) NOT NULL,
  `ID_ORDEN` decimal(11,0) NOT NULL DEFAULT '0',
  `AMOUNT` decimal(12,0) DEFAULT NULL,
  `ID_USUARIO` decimal(11,0) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCT`,`ESTATUS`,`ID_ORDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table INV1000004
# ------------------------------------------------------------

DROP TABLE IF EXISTS `INV1000004`;

CREATE TABLE `INV1000004` (
  `ID_PRODUCT` decimal(11,0) NOT NULL,
  `ESTATUS` varchar(1) NOT NULL,
  `ID_ORDEN` decimal(11,0) NOT NULL DEFAULT '0',
  `AMOUNT` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCT`,`ESTATUS`,`ID_ORDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table INV1000005
# ------------------------------------------------------------

DROP TABLE IF EXISTS `INV1000005`;

CREATE TABLE `INV1000005` (
  `ID_PRODUCT` decimal(11,0) NOT NULL,
  `ESTATUS` varchar(1) NOT NULL,
  `ID_ORDEN` decimal(11,0) NOT NULL DEFAULT '0',
  `AMOUNT` decimal(12,0) DEFAULT NULL,
  `ID_USUARIO` decimal(11,0) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCT`,`ESTATUS`,`ID_ORDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table INV1000014
# ------------------------------------------------------------

DROP TABLE IF EXISTS `INV1000014`;

CREATE TABLE `INV1000014` (
  `ID_PRODUCT` decimal(11,0) NOT NULL,
  `ESTATUS` varchar(1) NOT NULL,
  `ID_ORDEN` decimal(11,0) NOT NULL DEFAULT '0',
  `AMOUNT` decimal(12,0) DEFAULT NULL,
  `ID_USUARIO` decimal(11,0) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCT`,`ESTATUS`,`ID_ORDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table INV13
# ------------------------------------------------------------

DROP TABLE IF EXISTS `INV13`;

CREATE TABLE `INV13` (
  `ID_PRODUCT` decimal(11,0) NOT NULL,
  `ESTATUS` varchar(1) NOT NULL,
  `ID_ORDEN` decimal(11,0) NOT NULL DEFAULT '0',
  `AMOUNT` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCT`,`ESTATUS`,`ID_ORDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table INV2
# ------------------------------------------------------------

DROP TABLE IF EXISTS `INV2`;

CREATE TABLE `INV2` (
  `ID_PRODUCT` decimal(11,0) NOT NULL,
  `ESTATUS` varchar(1) NOT NULL,
  `ID_ORDEN` decimal(11,0) NOT NULL DEFAULT '0',
  `AMOUNT` decimal(12,0) DEFAULT NULL,
  `ID_USUARIO` decimal(11,0) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCT`,`ESTATUS`,`ID_ORDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table INV4
# ------------------------------------------------------------

DROP TABLE IF EXISTS `INV4`;

CREATE TABLE `INV4` (
  `ID_PRODUCT` decimal(11,0) NOT NULL,
  `ESTATUS` varchar(1) NOT NULL,
  `ID_ORDEN` decimal(11,0) NOT NULL DEFAULT '0',
  `AMOUNT` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCT`,`ESTATUS`,`ID_ORDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table INV5
# ------------------------------------------------------------

DROP TABLE IF EXISTS `INV5`;

CREATE TABLE `INV5` (
  `ID_PRODUCT` decimal(11,0) NOT NULL,
  `ESTATUS` varchar(1) NOT NULL,
  `ID_ORDEN` decimal(11,0) NOT NULL DEFAULT '0',
  `AMOUNT` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCT`,`ESTATUS`,`ID_ORDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table INV6
# ------------------------------------------------------------

DROP TABLE IF EXISTS `INV6`;

CREATE TABLE `INV6` (
  `ID_PRODUCT` decimal(11,0) NOT NULL,
  `ESTATUS` varchar(1) NOT NULL,
  `ID_ORDEN` decimal(11,0) NOT NULL DEFAULT '0',
  `AMOUNT` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCT`,`ESTATUS`,`ID_ORDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table INV7
# ------------------------------------------------------------

DROP TABLE IF EXISTS `INV7`;

CREATE TABLE `INV7` (
  `ID_PRODUCT` decimal(11,0) NOT NULL,
  `ESTATUS` varchar(1) NOT NULL,
  `ID_ORDEN` decimal(11,0) NOT NULL DEFAULT '0',
  `AMOUNT` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCT`,`ESTATUS`,`ID_ORDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table MONEDAS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MONEDAS`;

CREATE TABLE `MONEDAS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(30) DEFAULT NULL,
  `SIMBOLO` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table MOTIVOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MOTIVOS`;

CREATE TABLE `MOTIVOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table MOTIVOS_DE_DESCUENTO
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MOTIVOS_DE_DESCUENTO`;

CREATE TABLE `MOTIVOS_DE_DESCUENTO` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table MUNICIPIOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MUNICIPIOS`;

CREATE TABLE `MUNICIPIOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(300) DEFAULT '',
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



# Dump of table ORDENES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ORDENES`;

CREATE TABLE `ORDENES` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `FECHA` timestamp NULL DEFAULT NULL,
  `ID_CLIENTE` int(11) DEFAULT NULL,
  `ID_BODEGA` int(11) DEFAULT NULL,
  `MONTO` double(15,2) DEFAULT NULL,
  `ID_USUARIO` int(11) DEFAULT NULL,
  `ULTIMA_MODIFICACION` timestamp NULL DEFAULT NULL,
  `ESTADO` varchar(1) DEFAULT NULL,
  `UID` varchar(100) DEFAULT NULL,
  `ID_PUNTO_VENTA` int(11) DEFAULT NULL,
  `NAME` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table ORDENESDETALLE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ORDENESDETALLE`;

CREATE TABLE `ORDENESDETALLE` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ORDEN` int(11) DEFAULT NULL,
  `ID_PRODUCTO` int(11) DEFAULT NULL,
  `PRECIO_UNITARIO` double(15,2) DEFAULT NULL,
  `CANTIDAD` int(11) DEFAULT NULL,
  `TOTAL` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PACKINGS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PACKINGS`;

CREATE TABLE `PACKINGS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(255) DEFAULT NULL,
  `MULTIPLICADOR` int(11) DEFAULT NULL,
  `ID_PRODUCTO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PAGOS_ORDENES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PAGOS_ORDENES`;

CREATE TABLE `PAGOS_ORDENES` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ORDEN` int(11) DEFAULT NULL,
  `FECHA` timestamp NULL DEFAULT NULL,
  `MONTO` double(15,2) DEFAULT NULL,
  `TIPO_PAGO` varchar(10) DEFAULT NULL,
  `NO_AUTORIZACION` varchar(255) DEFAULT NULL,
  `NO_CHEQUE` varchar(255) DEFAULT NULL,
  `ID_BANCO` int(11) DEFAULT NULL,
  `TIPO_TARJETA` varchar(255) DEFAULT NULL,
  `NO_TARJETA` varchar(255) DEFAULT NULL,
  `ID_USUARIO` int(11) DEFAULT NULL,
  `ID_PUNTO_VENTA` int(11) DEFAULT NULL,
  `ID_CAJA_PUNTO_VENTA` int(11) DEFAULT NULL,
  `CERRADO` tinyint(1) DEFAULT NULL,
  `ID_CIERRE` int(11) DEFAULT NULL,
  `ID_CUPON` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PAISES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PAISES`;

CREATE TABLE `PAISES` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(30) DEFAULT NULL,
  `MONEDA` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PERMISOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PERMISOS`;

CREATE TABLE `PERMISOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `EMPLEADO` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `MOTIVO` int(11) DEFAULT NULL,
  `OBSERVACIONES` varchar(500) DEFAULT NULL,
  `GOCE_DE_SUELDO` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PLANILLA_DETAIL
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PLANILLA_DETAIL`;

CREATE TABLE `PLANILLA_DETAIL` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PLANILLA` int(11) DEFAULT NULL,
  `ID_EMPLEADO` int(11) DEFAULT NULL,
  `CLASIFICACION` varchar(30) DEFAULT NULL,
  `DEPARTAMENTO` varchar(30) DEFAULT NULL,
  `FORMA_DE_PAGO` varchar(30) DEFAULT NULL,
  `CUENTA` varchar(100) DEFAULT NULL,
  `BANCO` varchar(100) DEFAULT NULL,
  `DIAS_LABORADOS` int(11) DEFAULT NULL,
  `FECHA_INGRESO` date DEFAULT NULL,
  `SUELDO_BASE` double(15,2) DEFAULT NULL,
  `POR_DIA` double(15,2) DEFAULT NULL,
  `SUELDO_DEVENGADO` double(15,2) DEFAULT NULL,
  `BONIFICACION` double(15,2) DEFAULT NULL,
  `INCENTIVO` double(15,2) DEFAULT NULL,
  `TOTAL_INGRESOS` double(15,2) DEFAULT NULL,
  `IGSS` double(15,2) DEFAULT NULL,
  `ANTICIPO_SUELDO` double(15,2) DEFAULT NULL,
  `PRESTAMO` double(15,2) DEFAULT NULL,
  `TOTAL_DEDUCCIONES` double(15,2) DEFAULT NULL,
  `LIQUIDO` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PLANILLA_HEAD
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PLANILLA_HEAD`;

CREATE TABLE `PLANILLA_HEAD` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DIA` int(11) DEFAULT NULL,
  `MES` int(11) DEFAULT NULL,
  `ANIO` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PRECIOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PRECIOS`;

CREATE TABLE `PRECIOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(100) DEFAULT NULL,
  `COEFICIENTE` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PRECIOS_CLIENTE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PRECIOS_CLIENTE`;

CREATE TABLE `PRECIOS_CLIENTE` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_CLIENTE` int(11) DEFAULT NULL,
  `ID_PRECIO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PRECIOS_PUNTOSDEVENTAS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PRECIOS_PUNTOSDEVENTAS`;

CREATE TABLE `PRECIOS_PUNTOSDEVENTAS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PUNTOSDEVENTAS` int(11) DEFAULT NULL,
  `ID_PRECIO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PRESTAMOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PRESTAMOS`;

CREATE TABLE `PRESTAMOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `EMPLEADO` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `MONTO` double(15,2) DEFAULT NULL,
  `OBSERVACIONES` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PRESUPUESTO
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PRESUPUESTO`;

CREATE TABLE `PRESUPUESTO` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ANIO` int(11) DEFAULT NULL,
  `MES` int(11) DEFAULT NULL,
  `PROYECTADO` double(15,2) DEFAULT NULL,
  `EJECUTADO` double(15,2) DEFAULT NULL,
  `FECHA` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PRESUPUESTO_EJECUCION
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PRESUPUESTO_EJECUCION`;

CREATE TABLE `PRESUPUESTO_EJECUCION` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PRESUPUESTO` int(11) DEFAULT NULL,
  `ANIO` int(11) DEFAULT NULL,
  `MES` int(11) DEFAULT NULL,
  `TIPO_RUBRO` int(11) DEFAULT NULL,
  `MONTO` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PRESUPUESTO_PROYECCION
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PRESUPUESTO_PROYECCION`;

CREATE TABLE `PRESUPUESTO_PROYECCION` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PRESUPUESTO` int(11) DEFAULT NULL,
  `ANIO` int(11) DEFAULT NULL,
  `MES` int(11) DEFAULT NULL,
  `TIPO_RUBRO` int(11) DEFAULT NULL,
  `MONTO` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PRODUCTOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PRODUCTOS`;

CREATE TABLE `PRODUCTOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `CODIGO` varchar(30) DEFAULT NULL,
  `DESCRIPCION` varchar(250) DEFAULT NULL,
  `COEFICIENTE_UNIDAD` int(11) DEFAULT NULL,
  `PROVEEDOR` int(11) DEFAULT NULL,
  `PRECIO` double(15,2) DEFAULT NULL,
  `PRECIO_1` double(15,2) DEFAULT NULL,
  `PRECIO_2` double(15,2) DEFAULT NULL,
  `PRECIO_3` double(15,2) DEFAULT NULL,
  `PRECIO_4` double(15,2) DEFAULT NULL,
  `IMAGE_PATH` varchar(300) DEFAULT NULL,
  `STOCK_MINIMO` int(11) DEFAULT NULL,
  `FAMILIA` int(11) DEFAULT NULL,
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



# Dump of table PROVEEDORES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PROVEEDORES`;

CREATE TABLE `PROVEEDORES` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NIT` varchar(15) DEFAULT NULL,
  `CODIGO` varchar(10) DEFAULT NULL,
  `NOMBRE` varchar(150) DEFAULT NULL,
  `RAZON_SOCIAL` varchar(300) DEFAULT NULL,
  `CONTACTO` varchar(300) DEFAULT NULL,
  `DIRECCION` varchar(500) DEFAULT NULL,
  `TELEFONO` varchar(15) DEFAULT NULL,
  `CORREO` varchar(100) DEFAULT NULL,
  `PAIS` int(11) DEFAULT NULL,
  `MONEDA` int(11) DEFAULT NULL,
  `LIMITE_CREDITO` double(15,2) DEFAULT NULL,
  `SALDO` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PROVEEDORES_PAGOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PROVEEDORES_PAGOS`;

CREATE TABLE `PROVEEDORES_PAGOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_COMPRA` int(11) DEFAULT NULL,
  `FECHA` timestamp NULL DEFAULT NULL,
  `MONTO` double(15,2) DEFAULT NULL,
  `TIPO_PAGO` varchar(10) DEFAULT NULL,
  `NO_AUTORIZACION` varchar(255) DEFAULT NULL,
  `NO_CHEQUE` varchar(255) DEFAULT NULL,
  `ID_BANCO` int(11) DEFAULT NULL,
  `TIPO_TARJETA` varchar(255) DEFAULT NULL,
  `NO_TARJETA` varchar(255) DEFAULT NULL,
  `ID_USUARIO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PUESTOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PUESTOS`;

CREATE TABLE `PUESTOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table PUNTOSDEVENTAS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PUNTOSDEVENTAS`;

CREATE TABLE `PUNTOSDEVENTAS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(255) DEFAULT NULL,
  `DIRECCION` varchar(255) DEFAULT NULL,
  `TELEFONO` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table ROLES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ROLES`;

CREATE TABLE `ROLES` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table SALIDAS_BODEGA
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SALIDAS_BODEGA`;

CREATE TABLE `SALIDAS_BODEGA` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `BODEGA` int(11) DEFAULT NULL,
  `FECHA` timestamp NULL DEFAULT NULL,
  `USUARIO` int(11) DEFAULT NULL,
  `TRANSID` varchar(300) DEFAULT NULL,
  `CORRELATIVO` int(11) DEFAULT NULL,
  `OBSERVACIONES` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table SALIDAS_BODEGA_DETALLE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SALIDAS_BODEGA_DETALLE`;

CREATE TABLE `SALIDAS_BODEGA_DETALLE` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_SALIDA` int(11) DEFAULT NULL,
  `ID_PRODUCTO` int(11) DEFAULT NULL,
  `UNIDADES_PRODUCTO` int(11) DEFAULT NULL,
  `UNITARIO` int(11) DEFAULT NULL,
  `PACKING_SELECCIONADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table TIPO_MOVIMIENTO
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TIPO_MOVIMIENTO`;

CREATE TABLE `TIPO_MOVIMIENTO` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table TIPOS_CLASIFICACION
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TIPOS_CLASIFICACION`;

CREATE TABLE `TIPOS_CLASIFICACION` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table TIPOS_DE_PAGO
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TIPOS_DE_PAGO`;

CREATE TABLE `TIPOS_DE_PAGO` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table TIPOS_RUBRO
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TIPOS_RUBRO`;

CREATE TABLE `TIPOS_RUBRO` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(300) DEFAULT NULL,
  `TIPO` varchar(1) DEFAULT NULL,
  `ID_CLASIFICACION` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table TRASLADOS_DETAIL
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TRASLADOS_DETAIL`;

CREATE TABLE `TRASLADOS_DETAIL` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_TRASLADO` int(11) DEFAULT NULL,
  `PRODUCTO` int(11) DEFAULT NULL,
  `UNIDADES` int(11) DEFAULT NULL,
  `PACKING` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table TRASLADOS_HEADER
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TRASLADOS_HEADER`;

CREATE TABLE `TRASLADOS_HEADER` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `BODEGA_ORIGEN` int(11) DEFAULT NULL,
  `BODEGA_DESTINO` int(11) DEFAULT NULL,
  `FECHA` timestamp NULL DEFAULT NULL,
  `ESTADO` varchar(1) DEFAULT NULL,
  `USUARIO` int(11) DEFAULT NULL,
  `TRANSID` varchar(300) DEFAULT NULL,
  `DESTINATARIO` int(11) DEFAULT NULL,
  `CORRELATIVO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table USUARIOS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `USUARIOS`;

CREATE TABLE `USUARIOS` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `USUARIO` varchar(50) NOT NULL DEFAULT '',
  `NOMBRE` varchar(100) DEFAULT NULL,
  `CLAVE` varchar(50) NOT NULL DEFAULT '',
  `ROL` int(11) DEFAULT NULL,
  `ESTADO` tinyint(1) DEFAULT NULL,
  `CORREO` varchar(255) DEFAULT NULL,
  `TELEFONO` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `USUARIO` (`USUARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
