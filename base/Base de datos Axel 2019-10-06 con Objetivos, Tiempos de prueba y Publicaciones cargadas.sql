/*
SQLyog Community v13.1.5  (64 bit)
MySQL - 5.7.26 : Database - seminario1
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`seminario1` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `seminario1`;

/*Table structure for table `objetivo` */

DROP TABLE IF EXISTS `objetivo`;

CREATE TABLE `objetivo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `descripcion` text,
  `activo` tinyint(1) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `objetivo` */

insert  into `objetivo`(`id`,`nombre`,`alias`,`descripcion`,`activo`) values 
(1,'Objetivo 1','objetivo-1',NULL,1),
(2,'Objetivo 2','objetivo-2',NULL,1),
(3,'Objetivo 3','objetivo-3',NULL,1);

/*Table structure for table `objetivo_tiempo` */

DROP TABLE IF EXISTS `objetivo_tiempo`;

CREATE TABLE `objetivo_tiempo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_objetivo` int(11) DEFAULT NULL,
  `tiempo` varchar(255) DEFAULT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `objetivo_tiempo` */

insert  into `objetivo_tiempo`(`id`,`id_objetivo`,`tiempo`,`alias`,`activo`) values 
(1,1,'Tiempo 1','tiempo-1',1),
(2,1,'Tiempo 2','tiempo-2',1),
(3,1,'Tiempo 3','tiempo-3',1),
(4,2,'Tiempo 1','tiempo-1',1),
(5,2,'Tiempo 2','tiempo-2',1);

/*Table structure for table `publicacion` */

DROP TABLE IF EXISTS `publicacion`;

CREATE TABLE `publicacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `descripcion` text,
  `texto` text,
  `estado` int(5) DEFAULT NULL,
  `valoracion` int(11) DEFAULT '0',
  `activo` tinyint(1) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `publicacion` */

insert  into `publicacion`(`id`,`id_usuario`,`fecha`,`titulo`,`alias`,`descripcion`,`texto`,`estado`,`valoracion`,`activo`) values 
(1,1,'2019-10-06 14:01:14','Publicacion 1','publicacion-1','Esta es la descripcion de la publicacion 1. Aca va a ir todo lo relacionado a la publicacion.','Este es el contenido de la publicación 1. Acá va a ir todo lo relacionado a la publicación.',1,2,1),
(2,2,'2019-10-06 14:02:37','Publicacion 2','publicacion-2','Esta es la descripcion de la publicacion 2. Aca va a ir todo lo relacionado a la publicacion.','Este es el contenido de la publicación 2. Acá va a ir todo lo relacionado a la publicación.',1,0,1),
(3,1,'2019-10-06 14:02:49','Publicacion 3','publicacion-3','Esta es la descripcion de la publicacion 3. Aca va a ir todo lo relacionado a la publicacion.','Este es el contenido de la publicación 1. Acá va a ir todo lo relacionado a la publicación.',1,0,1);

/*Table structure for table `publicacion_comentario` */

DROP TABLE IF EXISTS `publicacion_comentario`;

CREATE TABLE `publicacion_comentario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_publicacion` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `texto` text,
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `publicacion_comentario` */

/*Table structure for table `publicacion_imagen` */

DROP TABLE IF EXISTS `publicacion_imagen`;

CREATE TABLE `publicacion_imagen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_publicacion` int(11) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `archivo` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `publicacion_imagen` */

insert  into `publicacion_imagen`(`id`,`id_publicacion`,`imagen`,`archivo`,`activo`) values 
(1,1,'1.jpg','1.jpg',1),
(2,2,'2.jpg','2.jpg',1),
(3,3,'3.jpg','3.jpg',1);

/*Table structure for table `publicacion_like` */

DROP TABLE IF EXISTS `publicacion_like`;

CREATE TABLE `publicacion_like` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_publicacion` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `tipo` int(4) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `publicacion_like` */

insert  into `publicacion_like`(`id`,`id_publicacion`,`id_usuario`,`tipo`,`activo`) values 
(1,1,2,1,1),
(2,1,1,1,1);

/*Table structure for table `publicacion_objetivo` */

DROP TABLE IF EXISTS `publicacion_objetivo`;

CREATE TABLE `publicacion_objetivo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_publicacion` int(11) DEFAULT NULL,
  `id_objetivo` int(11) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `publicacion_objetivo` */

insert  into `publicacion_objetivo`(`id`,`id_publicacion`,`id_objetivo`) values 
(1,1,1),
(2,1,2),
(3,2,3),
(4,3,2);

/*Table structure for table `publicacion_tiempo` */

DROP TABLE IF EXISTS `publicacion_tiempo`;

CREATE TABLE `publicacion_tiempo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_publicacion` int(11) DEFAULT NULL,
  `id_tiempo` int(11) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `publicacion_tiempo` */

insert  into `publicacion_tiempo`(`id`,`id_publicacion`,`id_tiempo`) values 
(1,1,1);

/*Table structure for table `usuario` */

DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail` varchar(255) DEFAULT NULL,
  `usuario` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `archivo` varchar(255) DEFAULT NULL,
  `activado` tinyint(1) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  `creado_fecha` datetime DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `usuario` */

insert  into `usuario`(`id`,`mail`,`usuario`,`password`,`nombre`,`apellido`,`fecha_nacimiento`,`imagen`,`archivo`,`activado`,`activo`,`creado_fecha`) values 
(1,'u1@gmail.com','Usuario 1',NULL,'Ricardo','Gomez','1979-05-15',NULL,NULL,1,1,'2019-10-01 13:59:24'),
(2,'u2@hotmail.com','Usuario 2',NULL,'Maria Julia','Bustamante','1997-06-25',NULL,NULL,1,1,'2019-10-06 14:00:51');

/*Table structure for table `usuario_objetivo` */

DROP TABLE IF EXISTS `usuario_objetivo`;

CREATE TABLE `usuario_objetivo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `id_objetivo` int(11) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `usuario_objetivo` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;