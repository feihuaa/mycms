/*
SQLyog Professional v12.5.1 (64 bit)
MySQL - 8.0.12 : Database - py1807a_web_1
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`py1807a_web_1` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `py1807a_web_1`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can add permission',2,'add_permission'),
(5,'Can change permission',2,'change_permission'),
(6,'Can delete permission',2,'delete_permission'),
(7,'Can add group',3,'add_group'),
(8,'Can change group',3,'change_group'),
(9,'Can delete group',3,'delete_group'),
(10,'Can add user',4,'add_user'),
(11,'Can change user',4,'change_user'),
(12,'Can delete user',4,'delete_user'),
(13,'Can add content type',5,'add_contenttype'),
(14,'Can change content type',5,'change_contenttype'),
(15,'Can delete content type',5,'delete_contenttype'),
(16,'Can add session',6,'add_session'),
(17,'Can change session',6,'change_session'),
(18,'Can delete session',6,'delete_session'),
(19,'Can add user',7,'add_user'),
(20,'Can change user',7,'change_user'),
(21,'Can delete user',7,'delete_user'),
(22,'Can add article',8,'add_article'),
(23,'Can change article',8,'change_article'),
(24,'Can delete article',8,'delete_article');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user` */

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `blog_article` */

DROP TABLE IF EXISTS `blog_article`;

CREATE TABLE `blog_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `publishTime` date NOT NULL,
  `modifyTime` date NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_article_author_id_905add38_fk_blog_user_id` (`author_id`),
  CONSTRAINT `blog_article_author_id_905add38_fk_blog_user_id` FOREIGN KEY (`author_id`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `blog_article` */

insert  into `blog_article`(`id`,`title`,`content`,`publishTime`,`modifyTime`,`author_id`) values 
(2,'云雨成烟','歌名：云烟成雨\r\n\r\n演唱：房东的猫\r\n\r\n作词：墨鱼丝\r\n\r\n作曲：少年佩\r\n\r\n你的晚安 是下意识的恻隐我留至夜深 治疗失眠梦呓\r\n\r\n那封手写信 留在行李箱底来不及 赋予它旅途的意义\r\n\r\n若一切 都已云烟成雨我能否 变成淤泥再一次 沾染你\r\n\r\n若生命 如过场电影Oh 让我再一次 甜梦里惊醒我多想再见你哪怕匆匆一眼就别离\r\n\r\n路灯下昏黄的剪影越走越漫长的林径\r\n\r\n我多想再见你至少玩笑话还能说起\r\n\r\n街巷初次落叶的秋分渐行渐远去的我们\r\n\r\n若一切 都已云烟成雨我能否 变成淤泥\r\n\r\n再一次 沾染你若生命 如过场电影Oh 让我再一次 甜梦里惊醒我多想再见你哪怕匆匆一眼就别离\r\n\r\n路灯下昏黄的剪影越走越漫长的林径\r\n\r\n我多想再见你至少玩笑话还能说起\r\n\r\n街巷初次落叶的秋分渐行渐远去的我们\r\n\r\n站台 汽笛响起想念是你的声音\r\n\r\n我们提着过去 走入人群寻找着一个位置 安放自己我多想再见你哪怕匆匆一眼就别离\r\n\r\n路灯下昏黄的剪影越走越漫长的林径\r\n\r\n我多想再见你至少玩笑话还能说起\r\n\r\n街巷初次落叶的秋分渐行渐远去的我们','2018-10-06','2018-10-06',9),
(3,'纸短情长','《纸短情长》演唱：烟把儿\r\n\r\n歌词：\r\n\r\n你陪我步入蝉夏\r\n\r\n越过城市喧嚣\r\n\r\n歌声还在游走\r\n\r\n你榴花般的双眸\r\n\r\n不见你的温柔\r\n\r\n丢失花间欢笑\r\n\r\n岁月无法停留\r\n\r\n流云的等候\r\n\r\n我真的好想你\r\n\r\n在每一个雨季\r\n\r\n你选择遗忘的\r\n\r\n是我最不舍的\r\n\r\n纸短情长啊\r\n\r\n道不尽太多涟漪\r\n\r\n我的故事都是关于你呀\r\n\r\n怎么会爱上了她\r\n\r\n并决定跟她回家\r\n\r\n放弃了我的所有我的一切无所谓\r\n\r\n纸短情长啊\r\n\r\n诉不完当时年少\r\n\r\n我的故事还是关于你呀\r\n\r\n我真的好想你\r\n\r\n在每一个雨季\r\n\r\n你选择遗忘的\r\n\r\n是我最不舍的\r\n\r\n纸短情长啊\r\n\r\n道不尽太多涟漪\r\n\r\n我的故事都是关于你呀\r\n\r\n怎么会爱上了她\r\n\r\n并决定跟她回家\r\n\r\n放弃了我的所有我的一切无所谓\r\n\r\n纸短情长啊\r\n\r\n诉不完当时年少\r\n\r\n我的故事还是关于你呀\r\n\r\n我的故事还是关于你呀','2018-10-06','2018-10-06',9),
(4,'起风了','这一路上走走停停\r\n顺着少年漂流的痕迹\r\n迈出车站的前一刻\r\n竟有些犹豫\r\n不禁笑这近乡情怯\r\n仍无可避免\r\n而长野的天\r\n依旧那么暖\r\n吹起了从前\r\n从前初识这世间\r\n万般流连\r\n看着天边似在眼前\r\n也甘愿赴汤蹈火去走它一遍\r\n如今走过这世间\r\n万般流连\r\n翻过岁月不同侧脸\r\n措不及防闯入你的笑颜\r\n我曾难自拔于世界之大\r\n也沉溺于其中梦话\r\n不得真假 不做挣扎 不惧笑话\r\n我曾将青春翻涌成她\r\n也曾指尖弹出盛夏\r\n心之所动 且就随缘去吧\r\n逆着光行走 任风吹雨打\r\n短短的路走走停停\r\n也有了几分的距离\r\n不知抚摸的是故事 还是段心情\r\n也许期待的不过是 与时间为敌\r\n再次看到你\r\n微凉晨光里\r\n笑的很甜蜜\r\n从前初识这世间\r\n万般流连\r\n看着天边似在眼前\r\n也甘愿赴汤蹈火去走它一遍\r\n如今走过这世间\r\n万般流连\r\n翻过岁月不同侧脸\r\n措不及防闯入你的笑颜\r\n我曾难自拔于世界之大\r\n也沉溺于其中梦话\r\n不得真假 不做挣扎 不惧笑话\r\n我曾将青春翻涌成她\r\n也曾指尖弹出盛夏\r\n心之所动 且就随缘去吧\r\n晚风吹起你鬓间的白发\r\n抚平回忆留下的疤\r\n你的眼中 明暗交杂 一笑生花\r\n暮色遮住你蹒跚的步伐\r\n走进床头藏起的画\r\n画中的你 低着头说话\r\n我仍感叹于世界之大\r\n也沉醉于儿时情话\r\n不剩真假 不做挣扎 无谓笑话\r\n我终将青春还给了她\r\n连同指尖弹出的盛夏\r\n心之所动 就随风去了\r\n以爱之名 你还愿意吗','2018-10-06','2018-10-06',9),
(5,'你还好澳门','asdasdasdasda我就不信了，这次还不行？dasdfdfgsdd','2018-10-06','2018-10-06',9);

/*Table structure for table `blog_user` */

DROP TABLE IF EXISTS `blog_user`;

CREATE TABLE `blog_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `blog_user` */

insert  into `blog_user`(`id`,`username`,`password`,`nickname`,`age`) values 
(8,'312123','123123','圣诞节',18),
(9,'123455','123456','打算an',18),
(10,'123456786','111111','zhdasnasd',34);

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(8,'blog','article'),
(7,'blog','user'),
(5,'contenttypes','contenttype'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2018-09-29 06:26:50.950237'),
(2,'auth','0001_initial','2018-09-29 06:26:52.517274'),
(3,'admin','0001_initial','2018-09-29 06:26:52.903037'),
(4,'admin','0002_logentry_remove_auto_add','2018-09-29 06:26:52.922026'),
(5,'contenttypes','0002_remove_content_type_name','2018-09-29 06:26:53.204851'),
(6,'auth','0002_alter_permission_name_max_length','2018-09-29 06:26:53.373747'),
(7,'auth','0003_alter_user_email_max_length','2018-09-29 06:26:53.547640'),
(8,'auth','0004_alter_user_username_opts','2018-09-29 06:26:53.568628'),
(9,'auth','0005_alter_user_last_login_null','2018-09-29 06:26:53.722533'),
(10,'auth','0006_require_contenttypes_0002','2018-09-29 06:26:53.731526'),
(11,'auth','0007_alter_validators_add_error_messages','2018-09-29 06:26:53.750516'),
(12,'auth','0008_alter_user_username_max_length','2018-09-29 06:26:53.944396'),
(13,'blog','0001_initial','2018-09-29 06:26:54.031343'),
(14,'blog','0002_auto_20180929_1426','2018-09-29 06:26:54.273193'),
(15,'sessions','0001_initial','2018-09-29 06:26:54.371134'),
(16,'blog','0003_article','2018-10-06 02:11:46.433357');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('6ac39n3e7n3futcnehdp687reu6zwrna','YzZiMjE4M2Q5ZjM3ODY0NmM1MzU1OTEzMWExODNlZTU3YjliNzE3NDqABJX1AAAAAAAAAH2UjAlsb2dpblVzZXKUjBVkamFuZ28uZGIubW9kZWxzLmJhc2WUjA5tb2RlbF91bnBpY2tsZZSTlIwEYmxvZ5SMBFVzZXKUhpSFlFKUfZQojAZfc3RhdGWUaAKMCk1vZGVsU3RhdGWUk5QpgZR9lCiMAmRilIwHZGVmYXVsdJSMBmFkZGluZ5SJdWKMAmlklEsJjAh1c2VybmFtZZSMBjEyMzQ1NZSMCHBhc3N3b3JklIwGMTIzNDU2lIwIbmlja25hbWWUjAjmiZPnrpdhbpSMA2FnZZRLEowPX2RqYW5nb192ZXJzaW9ulIwEMS4xMZR1YnMu','2018-10-21 15:29:10.474217');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
