-- MySQL dump 10.13  Distrib 5.7.13, for Linux (x86_64)
--
-- Host: localhost    Database: platform
-- ------------------------------------------------------
-- Server version	5.7.13-0ubuntu0.16.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `container`
--

DROP TABLE IF EXISTS `container`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `container` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `course_id` int(11) NOT NULL COMMENT '课程id',
  `image` varchar(100) NOT NULL COMMENT '镜像名',
  `port` int(6) DEFAULT NULL COMMENT '端口号',
  `status` int(11) NOT NULL COMMENT '状态',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `cmd` varchar(100) DEFAULT NULL COMMENT '启动命令',
  `container_id` varchar(100) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='容器状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `container`
--

LOCK TABLES `container` WRITE;
/*!40000 ALTER TABLE `container` DISABLE KEYS */;
INSERT INTO `container` VALUES (10,2,4,'index.alauda.cn/dubuqingfeng/docker-web-game',32774,1,'2016-08-10 01:48:57',NULL,'6df6b0ea78aef93419d76e72231c372b5eff89f9ca76612b5d3efd24b572193a');
/*!40000 ALTER TABLE `container` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_access`
--

DROP TABLE IF EXISTS `course_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_access` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `course_id` int(10) NOT NULL COMMENT '课程id',
  `state` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `course_id` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_access`
--

LOCK TABLES `course_access` WRITE;
/*!40000 ALTER TABLE `course_access` DISABLE KEYS */;
INSERT INTO `course_access` VALUES (2,1,2,1,'2016-08-02 07:50:25'),(3,1,3,1,'2016-08-02 07:56:24'),(4,1,4,1,'2016-08-02 08:35:43'),(5,2,4,1,'2016-08-02 12:53:29'),(6,2,5,1,'2016-08-10 01:06:22');
/*!40000 ALTER TABLE `course_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_category`
--

DROP TABLE IF EXISTS `course_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cate_name` varchar(30) NOT NULL COMMENT '分类名称',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '分类父类id',
  `sort_order` tinyint(3) NOT NULL DEFAULT '0' COMMENT '顺序',
  `code` varchar(20) DEFAULT NULL COMMENT '分类的代码标识',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_category`
--

LOCK TABLES `course_category` WRITE;
/*!40000 ALTER TABLE `course_category` DISABLE KEYS */;
INSERT INTO `course_category` VALUES (1,'移动安全',0,100,''),(2,'web安全',0,100,'');
/*!40000 ALTER TABLE `course_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '名字',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `report` text,
  `category` int(10) DEFAULT '0',
  `url` varchar(100) NOT NULL COMMENT '链接',
  `image` varchar(100) NOT NULL COMMENT '镜像',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '状态1表公开',
  `config` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='课程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (4,'一些童年里的游戏','年少的游戏梦，瑰丽而又美好。培养情操，放松心情，家庭常备，出门远行，随时消遣。','#**一些童年里的游戏**\n集成了超级玛丽，坦克大战，吃豆人经典游戏。\n###0x01 镜像说明\n#####本镜像是一个集成了超级玛丽、坦克大战、吃豆人的经典游戏的应用，在您加班之余，或者休息之时，又或亲朋好友回味童年之时，即可创建服务，迅速开几把，结束之后，迅速结束服务，培养情操，锻炼意志，放松心情，家庭常备，出门远行随时消遣。\n\n###0x02 部署说明\n\n1.安装并测试Docker，可以参考[官方文档](https://docs.docker.com/installation/ubuntulinux/)。或者是《Docker入门与实践》[安装](http://yeasy.gitbooks.io/docker_practice/content/install/index.html)一节。\n\n2.拉取镜像\n\n    docker pull index.alauda.cn/dubuqingfeng/docker-web-game\n\n3.运行容器\n\n    docker run -i -t -p 80:80 index.alauda.cn/dubuqingfeng/docker-web-game\n\n3.测试运行\n\n    docker ps -a\n\n如果出现```up```即为安装成功。\n\n###0x03 平台部署说明\n\n1.选择这个镜像，点击创建服务。\n\n2.进入控制台，查看地址，点击地址运行。\n\n###0x04 致谢\n\n童年，以及所有给我们带来美好的人。\n\n###0x05 后续思考\n\n有什么后续思考呢？欢迎一块回味童年，又或组织一些业余Dota赛，又或组织一些童年的环境。\n\n珍惜拥有。\n\n###0x06 反馈\n\n####协议\n####更新记录\n####反馈\n\n###0x07 后记\n\n那年年少，虽是无知，可却令人回味无穷。\n\n亦越行越远，此时的我们为了理想和现实而奋斗。\n\n却忘了那些角落里残留的游戏卡。\n\n却忘了那些伴我同行的哆啦A梦越走越远。\n\n那些经历让一个懵懂的小孩逐渐成长。\n\n也让一位在事业打拼的人士意味深长。\n\n//曾经和她一起去大学自习室，一起吃饭，一起逛校园，一起逛街，一起看天上的星星，一起讨论着未来。\n\n还是否依稀记得当初。\n\n当初的美梦已离开。\n\n留给我们的只是瑰丽的回忆。\n\n最后以一首曾是拥有作为结束，希望不忘初心。\n\nhttps://www.youtube.com/watch?v=W393coF35GY',1,'fwrrwr','index.alauda.cn/dubuqingfeng/docker-web-game','2016-08-02 08:05:59',1,'a:1:{s:5:\"ports\";a:1:{i:0;s:6:\"80/tcp\";}}'),(5,'ubuntu镜像示例','ubuntu14.04','##linux+nginx+mysql+php 安装\n###实验简介：\n搭建PHP+MYSQL的运行环境，以便后面课程的正常测试\n\n###实验步骤：\n1.关闭SELINUX\n```\nvi /etc/selinux/config\n#SELINUX=enforcing #注释掉\n#SELINUXTYPE=targeted #注释掉\nSELINUX=disabled #增加\nshutdown -r now #重启系统\n```\n\n2.安装ngnix\n\n需要创建一个文/etc/yum.repos.d/nginx.repo，并将下面的内容复制进去： \n\n```\n[nginx]\nname=nginx repo\nbaseurl=http://nginx.org/packages/centos/$releasever/$basearch/\ngpgcheck=0\nenabled=1\n```\n\n2.编辑并保存/etc/yum.repos.d/nginx.repo文件后，在命令行下执行 \nYum list | grep nginx 出现如下则表示成功\n\n```\nnginx.x86_64                           1.8.0-1.el6.ngx                   nginx  \nnginx-debug.x86_64                     1.8.0-1.el6.ngx                   nginx  \nnginx-debuginfo.x86_64                 1.8.0-1.el6.ngx                   nginx  \nnginx-nr-agent.noarch                  2.0.0-7.el6.ngx                   nginx  \n```\n直接yum安装\n```\nyum install -y nginx\n```\n将安装在/usr/share/nginx/\n启动nginx\n```\nservice ngnix start\n```\n3.安装PHP\n```\ncd /etc/yum.repos.d\nwget http://dev.centos.org/centos/5/CentOS-Testing.repo\nrpm –import http://dev.centos.org/centos/RPM-GPG-KEY-CentOS-testing\nyum install -y php php-mysql php-gd libjpeg* php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-mcrypt php-bcmath php-mhash libmcrypt libmcrypt-devel php-fpm\n```\n启动php-fpm\n```\n/etc/rc.d/init.d/php-fpm start\n```\n设置自动启动\n```\nchkconfig php-fpm on\n```\n4.配置nginx支持php\n```\ncp /etc/nginx/nginx.conf /etc/nginx/nginx.confbak\nvi /etc/nginx/nginx.conf\ncp /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.confbak\nvi /etc/nginx/conf.d/default.conf\n```\n增加index.php\n```\nindex index.php index.html index.htm;\n```\n取消FastCGI server部分location的注释,并要注意fastcgi_param行的参数,改为:绝对路径$fastcgi_script_name, \n\n配置php-fpm\n```\ncp /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.confbak\nvi /etc/php-fpm.d/www.conf\n```\n修改用户为nginx\n```\nuser = nginx\n```\n修改组为nginx\n```\ngroup = nginx\n```\n5.安装MYSQL\n```\nyum -y install mysql mysql-server\n```\n启动mysql\n```\nservice mysqld start\nchkconfig mysqld on #设为开机启动\n```\n为root账户设置密码\n```\nmysql_secure_installation\n```\n重启所有服务\n```\nservice mysqld restart\nservice nginx restart\n/etc/rc.d/init.d/php-fpm restart\n```\n\n测试成功浏览http://localhost\n\n###分析与思考：\n测试环境搭建完以后，要注意哪些安全配置？？',2,'url','ubuntu:14.04.4','2016-08-10 01:03:53',1,NULL);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password` char(40) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user',
  `email` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `phone` char(11) CHARACTER SET utf8 DEFAULT NULL COMMENT '手机号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'username','7c4a8d09ca3762af61e59520943dc26494f8941b','username','user','111@qq.com','2016-08-02 02:59:42','1',NULL),(2,'admin','7c4a8d09ca3762af61e59520943dc26494f8941b','admin','admin','1135326346@qq.com','2016-08-02 09:52:59','1',NULL),(3,'qeqq','7c4a8d09ca3762af61e59520943dc26494f8941b',NULL,'user','11@qq.com','2016-08-02 16:19:02','1',NULL),(4,'moyishizhe','032f46dd08c4842c59a7c80f4c30b4a9048a3e04',NULL,'Admin','moyishizhe@gmail.com','2016-08-15 05:19:47','1','18404968744');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-15 16:42:39
