-- phpMyAdmin SQL Dump
-- version 4.6.2
-- https://www.phpmyadmin.net/
--
-- Host: 10.236.158.100:4879
-- Generation Time: 2016-09-27 00:30:04
-- 服务器版本： 5.5.24-CDB-2.0.0-log
-- PHP Version: 5.6.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `platform`
--

-- --------------------------------------------------------

--
-- 表的结构 `container`
--

CREATE TABLE `container` (
  `id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `course_id` int(11) NOT NULL COMMENT '课程id',
  `image` varchar(100) NOT NULL COMMENT '镜像名',
  `port` varchar(25) DEFAULT NULL COMMENT '端口号',
  `status` int(11) NOT NULL COMMENT '状态',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `cmd` varchar(100) DEFAULT NULL COMMENT '启动命令',
  `container_id` varchar(100) DEFAULT '',
  `domain` varchar(32) DEFAULT NULL COMMENT '二级域名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='容器状态表';

-- --------------------------------------------------------

--
-- 表的结构 `courses`
--

CREATE TABLE `courses` (
  `id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '名字',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `report` text,
  `category` int(10) DEFAULT '0' COMMENT '分类id',
  `url` varchar(100) NOT NULL COMMENT '链接',
  `image` varchar(100) NOT NULL COMMENT '镜像',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1表公开',
  `config` text,
  `analysis` text COMMENT '课程分析',
  `is_web` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是web镜像',
  `afterclass` text COMMENT '课后扩展'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程表';

-- --------------------------------------------------------

--
-- 表的结构 `course_access`
--

CREATE TABLE `course_access` (
  `id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `course_id` int(10) NOT NULL COMMENT '课程id',
  `state` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限表';

-- --------------------------------------------------------

--
-- 表的结构 `course_category`
--

CREATE TABLE `course_category` (
  `id` int(11) UNSIGNED NOT NULL,
  `cate_name` varchar(30) NOT NULL COMMENT '分类名称',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '分类父类id',
  `sort_order` tinyint(3) NOT NULL DEFAULT '0' COMMENT '顺序',
  `code` varchar(20) DEFAULT NULL COMMENT '分类的代码标识'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `qa`
--

CREATE TABLE `qa` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(100) DEFAULT NULL,
  `meta_value` text,
  `type` varchar(20) DEFAULT NULL,
  `sort_order` tinyint(3) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password` char(40) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user',
  `email` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `phone` char(11) CHARACTER SET utf8 DEFAULT NULL COMMENT '手机号',
  `icon_url` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '头像url',
  `login_last_ip` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT ' ' COMMENT '用户最后登陆的ip',
  `pay_flag` int(3) NOT NULL DEFAULT '0' COMMENT '付费标识'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `container`
--
ALTER TABLE `container`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_access`
--
ALTER TABLE `course_access`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `course_category`
--
ALTER TABLE `course_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qa`
--
ALTER TABLE `qa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `container`
--
ALTER TABLE `container`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- 使用表AUTO_INCREMENT `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- 使用表AUTO_INCREMENT `course_access`
--
ALTER TABLE `course_access`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1815;
--
-- 使用表AUTO_INCREMENT `course_category`
--
ALTER TABLE `course_category`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- 使用表AUTO_INCREMENT `qa`
--
ALTER TABLE `qa`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- 使用表AUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=930;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
