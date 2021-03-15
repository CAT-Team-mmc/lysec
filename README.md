# www.lysec.org
# 效果预览
![img](https://github.com/CAT-Team-mmc/lysec/blob/master/image/%E6%95%88%E6%9E%9C%E5%9B%BE%E5%B1%95%E7%A4%BA%E5%9B%BE.gif)
![img](https://github.com/CAT-Team-mmc/lysec/blob/master/image/%E6%95%88%E6%9E%9C%E5%B1%95%E7%A4%BA.gif)
![img](https://github.com/CAT-Team-mmc/lysec/blob/master/image/%E6%95%88%E6%9E%9C%E5%B1%95%E7%A4%BA1.gif)
## 技术选型 ##

后端部分主要采用PHP，以性能为主，采用[Phalcon](https://phalconphp.com/zh/)框架，利用[composer](https://getcomposer.org/)管理依赖。

前端部分先采用bower管理依赖。

## 项目说明 ##
项目结构在platform目录下
###### 注意在服务器做配置的时候public目录必须配置为入口目录

## 待解决问题 ##
+ 管理后台docker镜像拉去
+ 容器stop的时候不太稳定，有可能造成容易已经结束了，但是数据库container表并没有清理干净
+ 管理后台界面设计问题
+ 用户中心目前还是比较简单
+ docker镜像文件目前还在整理阶段，整理完成以后一起发布
## 安全问题 ##
因为此项目是关于docker的项目，所以在部署的时候注意docker api未授权访问。其他安全问题后续持续跟进

## 项目组介绍 ##
### 项目简介
此项目由CatTeam安全团队的开发组设计完成。主要为想学习安全的朋友提供一个简单直接的安全攻防在线实战平台。
### 项目组成员
- mmc
项目负责人
- 独步清风
后端开发
- Elin
前端开发
- 冰雪绒
前端开发
- vv
UI
## 其它问题 ##
+ 问题反馈
+ 加入我们
+ 合作开发
## 问题反馈 ##
+ QQ: 2022137639
+ 微信：wx_1109

