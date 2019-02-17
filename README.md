# lysec
#效果预览
[img](https://github.com/CAT-Team-mmc/lysec/blob/master/%E6%95%88%E6%9E%9C%E5%B1%95%E7%A4%BA.gif)

## 技术选型 ##

后端部分主要采用PHP，以性能为主，采用[Phalcon](https://phalconphp.com/zh/)框架，利用[composer](https://getcomposer.org/)管理依赖。

前端部分先采用bower管理依赖。

## 框架搭建 ##

```
一 服务器版本
   ubuntu16.04
二 基本模块
   2.1： mysql+PHP7+apache2或者nginx 安装 //必须
   apache2 web目录 /var/www/html/platform
   nginx web目录 /usr/share/nginx/html/platform
   其它的都是常规安装自行谷歌。
   2.3： etcd 安装 //必须
	$ mkdir -p $GOPATH/src/github.com/coreos
	$ cd !$
	$ git clone https://github.com/coreos/etcd.git
	$ cd etcd
	$ ./build
	$ ./bin/etcd
	参考 https://blog.csdn.net/skh2015java/article/details/80714661
   2.4： docker安装 //必须
      更新APT包索引：sudo apt-get update
　　　安装docker：sudo apt-get install docker-engine
　　　开启docker后台进程：sudo service docker start
　　　校验docker是否安装成功：sudo docker run hello-world
      参考 https://www.cnblogs.com/lighten/p/6034984.html
   2.5： phalcon安装 //必须
        sudo git clone --depth=1 git://github.com/phalcon/cphalcon.git
	sudo apt-get install make
	cd cphalcon/build/
	sudo ./install
        cd /etc/php/7.0/apache2/conf.d
        vi 30-phalcon.ini
        extension=phalcon.so
	参考 https://blog.csdn.net/StimmerLove/article/details/82657190
   2.6： HAProxy安装
         参考 https://blog.csdn.net/qq_32911237/article/details/79545909
   2.7： RabbitMQ 安装
         参考 https://blog.csdn.net/rickey17/article/details/72756766/
   2.8： bower和composer包管理器安装 //必须
	//安装composer
	curl -sS https://getcomposer.org/installer | php
	sudo mv composer.phar /usr/local/bin/composer
三 项目安装
	//如果没权限设置755
	git clone https://github.com/CAT-Team-mmc/lysec.git
	cd /usr/share/nginx/html/platform
	composer install
	cd app/
	mkdir cache
	chmod -R 777 cache/
	sudo apt-get install mysql-server
	mysql -u root -p
	CREATE DATABASE platform;
	use platform;
	source ../sql/platform.sql
	//这里需要添加密钥认证
       sudo docker daemon -H unix:///var/run/docker.sock -H 0.0.0.0:4243
