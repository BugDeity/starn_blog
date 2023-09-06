/*
 Navicat Premium Data Transfer

 Source Server         : 42.192.150.44
 Source Server Type    : MySQL
 Source Server Version : 50742
 Source Host           : 42.192.150.44:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 50742
 File Encoding         : 65001

 Date: 15/08/2023 08:38:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for b_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `b_admin_log`;
CREATE TABLE `b_admin_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作用户',
  `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求接口',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方式',
  `operation_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作名称',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `spend_time` bigint(20) NULL DEFAULT NULL COMMENT '请求接口耗时',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `params_json` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求参数',
  `class_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类地址',
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1407 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for b_article
-- ----------------------------
DROP TABLE IF EXISTS `b_article`;
CREATE TABLE `b_article`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `category_id` bigint(20) NULL DEFAULT NULL COMMENT '分类id',
  `title` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文章标题',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文章封面地址',
  `summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文章简介',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文章内容 （最多两百字）',
  `content_md` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文章内容md版',
  `read_type` int(2) NULL DEFAULT 0 COMMENT '阅读方式 0无需验证 1：评论阅读 2：点赞阅读 3：扫码阅读',
  `is_stick` int(11) NULL DEFAULT 0 COMMENT '是否置顶 0否 1是',
  `is_publish` int(11) NULL DEFAULT 0 COMMENT '是否发布 0：下架 1：发布',
  `is_original` int(11) NULL DEFAULT 1 COMMENT '是否原创  0：转载 1:原创',
  `original_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '转载地址',
  `quantity` bigint(20) NULL DEFAULT 0 COMMENT '文章阅读量',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `is_carousel` int(11) NULL DEFAULT 0 COMMENT '是否首页轮播',
  `is_recommend` int(11) DEFAULT '0' COMMENT '是否推荐 0:否 1：是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 166 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '博客文章表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_article
-- ----------------------------
INSERT INTO `b_article` VALUES (14, '1', 12, '关于博客', 'https://tva2.sinaimg.cn/large/9bd9b167ly1g2rmpwaxkkj21hc0u0e81.jpg', '关于博客的一些介绍。', '<blockquote>\n<p>本文主要介绍博客用到的技术和一些功能详情</p>\n</blockquote>\n<h4><a id=\"1_1\"></a>1、博客使用到的技术</h4>\n<ol>\n<li>后端：springboot，mysql，es搜索引擎，以及redis</li>\n<li>前端：vue</li>\n</ol>\n<h4><a id=\"2_5\"></a>2、首页登录</h4>\n<p>本博客支持<a href=\"https://connect.qq.com/index.html\" target=\"_blank\">QQ</a>、<a href=\"https://gitee.com/api/v5/oauth_doc#/\" target=\"_blank\">gitee</a>、<a href=\"https://open.weibo.com/?bottomnav=1&amp;wvr=6\" target=\"_blank\">微博</a>、邮箱登录</p>\n<h4><a id=\"3_7\"></a>3、图片的存储</h4>\n<p>项目中图片存储采用的是<a href=\"https://www.qiniu.com/products/kodo\" target=\"_blank\">七牛云</a>平台的对象存储，因为只有七牛云每个月会有免费的一个额度，其他的都是需要收费的。</p>\n<h4><a id=\"4_9\"></a>4、首页的搜索</h4>\n<p>首页的搜索采用的是es的搜索，eslinux启动的话会占用比较高的一个内存，所以博主介意如需要使用es搜索的购买服务器时资金允许的情况下尽可能购买内存比较多的服务器。然后项目搜索的话主要是围绕文章的标题和内容进行的分词搜索。</p>\n<blockquote>\n<p>上面的话都是一些首页的介绍，原作者只是提供了一个模板，并没有提供后台管理的一个功能，所以我就自己写了一个后台管理，主要借用的是比较火的一个<a href=\"https://gitee.com/panjiachen/vue-admin-template\" target=\"_blank\">vue-admin-template</a>项目模板来进行的二次开发，由于时间有限，所以后台管理开发的功能并不是很多，但是也能进行一个简单的博客管理了。</p>\n</blockquote>\n<h3><a id=\"_14\"></a>后台管理</h3>\n<blockquote>\n<p><a href=\"http://www.shiyit.com/admin\" target=\"_blank\">后台地址</a><br />\n演示账号：test,密码：test</p>\n</blockquote>\n<h4><a id=\"1_17\"></a>1、登录界面</h4>\n<p><img src=\"http://img.shiyit.com/1639989154384.jpg\" alt=\"login.jpg\" /></p>\n<h4><a id=\"2_19\"></a>2、后台首页</h4>\n<p><img src=\"http://img.shiyit.com/1639989162006.png\" alt=\"adminhome1.png\" /><br />\n<img src=\"http://img.shiyit.com/1639989170907.png\" alt=\"adminhome2.png\" /></p>\n<h4><a id=\"3_22\"></a>3、文章管理</h4>\n<ol>\n<li>列表页<br />\n<img src=\"http://img.shiyit.com/1639989186471.png\" alt=\"文章列表.png\" /></li>\n<li>文章添加<br />\n<img src=\"http://img.shiyit.com/1639989202706.png\" alt=\"文章添加.png\" /><br />\n编辑器使用的是mavon-editor编辑器，如不会使用的可以点击下面的链接查看<br />\n<a href=\"https://blog.csdn.net/qq_43681948/article/details/101531303\" target=\"_blank\">Vue markdown编辑器</a></li>\n</ol>\n<h4><a id=\"4_29\"></a>4、标签管理</h4>\n<p><img src=\"http://img.shiyit.com/1639989247680.png\" alt=\"标签列表.png\" /></p>\n<h4><a id=\"5_31\"></a>5、日志管理</h4>\n<ol>\n<li>针对用户访问以及管理员操作和异常信息都做了一个日志的记录</li>\n</ol>\n<p><img src=\"http://img.shiyit.com/1639989291127.png\" alt=\"日志管理.png\" /></p>\n<h4><a id=\"6_35\"></a>6、系统管理</h4>\n<p><img src=\"http://img.shiyit.com/1639989383160.png\" alt=\"系统配置.png\" /></p>\n<h4><a id=\"7_37\"></a>7、监控中心</h4>\n<ol>\n<li>监控中心主要有服务器的监控和定时任务，定时任务支持自动添加修改删除功能，改了时间无需修改代码<br />\n<img src=\"http://img.shiyit.com/1639989456867.png\" alt=\"定时任务.png\" /></li>\n</ol>\n<h4><a id=\"_40\"></a>结尾</h4>\n<p>上述只是项目的一些基础的功能图片，小伙伴们可以自行登录去查看，后台管理所看到的菜单功能都已实现，还在着手后续的一些功能开发。后台管理全由我自己根据模板改造而来，毕竟我只会业余的前端技术，所以有所缺陷也属正常。如有比较有意思的功能欢迎各位小伙伴给我留言，作者觉得有意思的话就会着手开发。如本项目小伙伴觉得可以，希望能够码云star一下，万分感谢！！</p>\n<blockquote>\n<p>码云地址：<a href=\"https://gitee.com/quequnlong/vue-admin-blog\" target=\"_blank\">点我进入</a></p>\n</blockquote>\n<h1><a id=\"bye_43\"></a>bye</h1>\n', '> 本文主要介绍博客用到的技术和一些功能详情\n#### 1、博客使用到的技术\n1. 后端：springboot，mysql，es搜索引擎，以及redis\n2. 前端：vue\n\n#### 2、首页登录\n本博客支持[QQ](https://connect.qq.com/index.html)、[gitee](https://gitee.com/api/v5/oauth_doc#/)、[微博](https://open.weibo.com/?bottomnav=1&wvr=6)、邮箱登录\n#### 3、图片的存储\n项目中图片存储采用的是[七牛云](https://www.qiniu.com/products/kodo)平台的对象存储，因为只有七牛云每个月会有免费的一个额度，其他的都是需要收费的。\n#### 4、首页的搜索\n首页的搜索采用的是es的搜索，eslinux启动的话会占用比较高的一个内存，所以博主介意如需要使用es搜索的购买服务器时资金允许的情况下尽可能购买内存比较多的服务器。然后项目搜索的话主要是围绕文章的标题和内容进行的分词搜索。\n\n> 上面的话都是一些首页的介绍，原作者只是提供了一个模板，并没有提供后台管理的一个功能，所以我就自己写了一个后台管理，主要借用的是比较火的一个[vue-admin-template](https://gitee.com/panjiachen/vue-admin-template)项目模板来进行的二次开发，由于时间有限，所以后台管理开发的功能并不是很多，但是也能进行一个简单的博客管理了。\n\n###  后台管理\n> [后台地址](http://www.shiyit.com/admin)\n演示账号：test,密码：test\n#### 1、登录界面\n![login.jpg](http://img.shiyit.com/1639989154384.jpg)\n#### 2、后台首页\n![adminhome1.png](http://img.shiyit.com/1639989162006.png)\n![adminhome2.png](http://img.shiyit.com/1639989170907.png)\n#### 3、文章管理\n1. 列表页\n![文章列表.png](http://img.shiyit.com/1639989186471.png)\n2. 文章添加\n![文章添加.png](http://img.shiyit.com/1639989202706.png)\n编辑器使用的是mavon-editor编辑器，如不会使用的可以点击下面的链接查看\n[Vue markdown编辑器](https://blog.csdn.net/qq_43681948/article/details/101531303)\n#### 4、标签管理\n![标签列表.png](http://img.shiyit.com/1639989247680.png)\n#### 5、日志管理\n1. 针对用户访问以及管理员操作和异常信息都做了一个日志的记录\n\n![日志管理.png](http://img.shiyit.com/1639989291127.png)\n#### 6、系统管理\n![系统配置.png](http://img.shiyit.com/1639989383160.png)\n#### 7、监控中心\n1. 监控中心主要有服务器的监控和定时任务，定时任务支持自动添加修改删除功能，改了时间无需修改代码\n![定时任务.png](http://img.shiyit.com/1639989456867.png)\n#### 结尾\n上述只是项目的一些基础的功能图片，小伙伴们可以自行登录去查看，后台管理所看到的菜单功能都已实现，还在着手后续的一些功能开发。后台管理全由我自己根据模板改造而来，毕竟我只会业余的前端技术，所以有所缺陷也属正常。如有比较有意思的功能欢迎各位小伙伴给我留言，作者觉得有意思的话就会着手开发。如本项目小伙伴觉得可以，希望能够码云star一下，万分感谢！！\n> 码云地址：[点我进入](https://gitee.com/quequnlong/vue-admin-blog)\n# bye\n\n', 0, 0, 1, 1, NULL, 87, '', '2021-10-15 09:57:22', 'blog,拾壹博客,博客', '2023-08-14 12:00:00', 0);

-- ----------------------------
-- Table structure for b_article_tag
-- ----------------------------
DROP TABLE IF EXISTS `b_article_tag`;
CREATE TABLE `b_article_tag`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL COMMENT '文章id',
  `tag_id` int(11) NOT NULL COMMENT '标签id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `fk_article_tag_1`(`article_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 847 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_article_tag
-- ----------------------------
INSERT INTO `b_article_tag` VALUES (779, 14, 10);

-- ----------------------------
-- Table structure for b_category
-- ----------------------------
DROP TABLE IF EXISTS `b_category`;
CREATE TABLE `b_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `click_volume` int(11) NULL DEFAULT 0,
  `sort` int(11) NOT NULL COMMENT '排序',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后更新时间',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_name`(`name`) USING BTREE COMMENT '博客分类名称'
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '博客分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_category
-- ----------------------------
INSERT INTO `b_category` VALUES (12, '项目介绍', 0, 8, '2021-12-29 10:21:40', '2022-01-20 17:50:32', 'el-icon-position');
INSERT INTO `b_category` VALUES (13, '生活随笔', 0, 4, '2021-12-29 10:22:09', '2021-12-29 10:23:40', 'el-icon-hot-water');
INSERT INTO `b_category` VALUES (16, '运维部署', 0, 6, '2021-12-29 10:41:45', '2023-06-01 17:50:57', 'el-icon-lightning');
INSERT INTO `b_category` VALUES (17, '后端开发', 0, 10, '2021-12-29 14:00:49', '2022-01-21 10:23:18', 'el-icon-monitor');
INSERT INTO `b_category` VALUES (19, '网络爬虫', 1, 5, '2022-01-07 17:08:57', '2022-01-21 10:23:01', 'el-icon-cpu');
INSERT INTO `b_category` VALUES (20, '小工具', 0, 0, '2022-01-14 15:05:58', '2022-01-20 17:46:18', 'el-icon-suitcase-1');
INSERT INTO `b_category` VALUES (28, '数据库', 0, 7, '2022-02-18 16:01:07', '2022-02-18 08:01:06', 'el-icon-coin');
INSERT INTO `b_category` VALUES (31, '前端开发', 0, 9, '2023-06-21 15:04:31', '2023-06-21 07:04:30', 'el-icon-mouse');

-- ----------------------------
-- Table structure for b_collect
-- ----------------------------
DROP TABLE IF EXISTS `b_collect`;
CREATE TABLE `b_collect`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户id',
  `article_id` bigint(20) NOT NULL COMMENT '文章id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_collect
-- ----------------------------

-- ----------------------------
-- Table structure for b_comment
-- ----------------------------
DROP TABLE IF EXISTS `b_comment`;
CREATE TABLE `b_comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评论人ID',
  `article_id` bigint(20) NOT NULL COMMENT '文章id',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `reply_user_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回复人id',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '评论时间',
  `browser` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `browser_version` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `system` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `system_version` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ip_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 627 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_comment
-- ----------------------------

-- ----------------------------
-- Table structure for b_dict
-- ----------------------------
DROP TABLE IF EXISTS `b_dict`;
CREATE TABLE `b_dict`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典名称',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典类型',
  `is_publish` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '是否发布(1:是，0:否)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_dict
-- ----------------------------
INSERT INTO `b_dict` VALUES (1, '用户性别', 'sys_user_sex', '1', '用户性别', '2021-11-19 09:24:23', '2021-11-27 22:03:54', 0);
INSERT INTO `b_dict` VALUES (2, '发布状态', 'sys_publish_status', '1', '发布状态列表', '2021-11-19 17:12:51', '2021-11-19 17:12:51', 0);
INSERT INTO `b_dict` VALUES (3, '搜索模式', 'sys_search_model', '1', '搜索模式：SQL搜索、全文检索', '2021-11-26 08:57:47', '2021-11-26 08:57:47', 2);
INSERT INTO `b_dict` VALUES (4, '系统是否', 'sys_yes_no', '1', '系统是否列表', '2021-11-26 14:03:12', '2021-11-26 14:03:12', 2);
INSERT INTO `b_dict` VALUES (5, '系统开关', 'sys_normal_disable', '1', '系统开关列表', '2021-11-26 15:16:43', '2021-11-26 15:16:43', 3);
INSERT INTO `b_dict` VALUES (6, '博客登录方式', 'sys_login_method', '1', '博客登录方式 账号密码、QQ、微博', '2021-11-27 13:52:38', '2021-11-27 13:52:38', 0);
INSERT INTO `b_dict` VALUES (7, '定时任务分组', 'sys_job_group', '1', '定时任务分组列表', '2021-12-10 08:53:30', '2021-12-10 08:53:30', 2);
INSERT INTO `b_dict` VALUES (8, '任务状态', 'sys_job_status', '1', '任务状态列表', '2021-12-10 09:01:10', '2021-12-10 09:01:10', 2);
INSERT INTO `b_dict` VALUES (9, '任务执行策略', 'sys_job_misfire', '1', '任务执行策略列表', '2021-12-10 11:11:48', '2021-12-10 11:12:04', 2);

-- ----------------------------
-- Table structure for b_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `b_dict_data`;
CREATE TABLE `b_dict_data`  (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dict_id` bigint(10) NOT NULL COMMENT '字典类型id',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典标签',
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典键值',
  `style` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回显样式',
  `is_default` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否默认（1是 0否）',
  `sort` int(10) NULL DEFAULT NULL COMMENT '排序',
  `is_publish` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否发布(1:是，0:否)',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_dict_data
-- ----------------------------
INSERT INTO `b_dict_data` VALUES (1, 2, '发布', '1', 'success', '1', 1, '1', NULL);
INSERT INTO `b_dict_data` VALUES (2, 2, '下架', '0', 'danger', '0', 0, '1', NULL);
INSERT INTO `b_dict_data` VALUES (3, 4, '是', '1', 'success', '1', 1, '1', '系统是否 是');
INSERT INTO `b_dict_data` VALUES (4, 4, '否', '0', 'warning', '0', 0, '1', '系统是否 否');
INSERT INTO `b_dict_data` VALUES (5, 5, '开启', '1', 'success', '1', 1, '1', '系统开关 开启');
INSERT INTO `b_dict_data` VALUES (6, 5, '关闭', '0', 'warning', '0', 2, '1', '系统开关 关闭');
INSERT INTO `b_dict_data` VALUES (7, 3, 'ES搜素', '1', 'success', '0', 1, '1', '搜索模式：开启ElasticSearch全文检索');
INSERT INTO `b_dict_data` VALUES (8, 3, 'SQL搜索', '0', 'warning', '1', 2, '1', '搜索模式：SQL搜索');
INSERT INTO `b_dict_data` VALUES (9, 6, '账号', '1', 'primary', '0', 1, '1', '账号密码登录');
INSERT INTO `b_dict_data` VALUES (10, 6, 'QQ', '2', 'success', '1', 2, '1', 'QQ登录');
INSERT INTO `b_dict_data` VALUES (11, 6, '微博', '3', 'danger', '0', 3, '1', '微博登录');
INSERT INTO `b_dict_data` VALUES (12, 1, '男', '1', '', '1', 1, '1', '性别 男');
INSERT INTO `b_dict_data` VALUES (13, 1, '女', '0', '', '1', 0, '1', '性别 女');
INSERT INTO `b_dict_data` VALUES (14, 7, '默认', 'DEFAULT', 'primary', '1', 1, '1', '默认分组');
INSERT INTO `b_dict_data` VALUES (15, 7, '系统', 'SYSTEM', 'warning', '0', 2, '1', '系统分组');
INSERT INTO `b_dict_data` VALUES (16, 8, '正常', '0', 'primary', '0', 1, '1', '正常状态');
INSERT INTO `b_dict_data` VALUES (17, 8, '暂停', '1', 'danger', '1', 2, '1', '暂停状态');
INSERT INTO `b_dict_data` VALUES (18, 9, '默认策略', '0', '', '1', 1, '1', '默认策略');
INSERT INTO `b_dict_data` VALUES (19, 9, '立即执行', '1', '', '0', 2, '1', '立即执行');
INSERT INTO `b_dict_data` VALUES (20, 9, '执行一次', '2', '', '0', 3, '1', '执行一次');
INSERT INTO `b_dict_data` VALUES (21, 9, '放弃执行', '3', '', '0', 4, '1', '放弃执行');
INSERT INTO `b_dict_data` VALUES (22, 6, '码云', '4', 'danger', '0', 4, '1', 'gitee登录');
INSERT INTO `b_dict_data` VALUES (23, 6, '微信', '5', 'success', '1', 5, '1', '微信登录');
INSERT INTO `b_dict_data` VALUES (24, 2, '待审批', '2', 'info', '1', 0, '1', NULL);
INSERT INTO `b_dict_data` VALUES (25, 6, 'github', '6', 'info', '1', 0, '1', 'github登录');

-- ----------------------------
-- Table structure for b_exception_log
-- ----------------------------
DROP TABLE IF EXISTS `b_exception_log`;
CREATE TABLE `b_exception_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `operation` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '描述',
  `params` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '参数',
  `exception_json` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '异常对象json格式',
  `exception_message` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '异常简单信息,等同于e.getMessage',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '发生时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 84 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_exception_log
-- ----------------------------

-- ----------------------------
-- Table structure for b_feed_back
-- ----------------------------
DROP TABLE IF EXISTS `b_feed_back`;
CREATE TABLE `b_feed_back`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户id',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详细内容',
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '添加时间',
  `type` int(11) NOT NULL COMMENT '反馈类型 1:需求 2：缺陷',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_feed_back
-- ----------------------------

-- ----------------------------
-- Table structure for b_followed
-- ----------------------------
DROP TABLE IF EXISTS `b_followed`;
CREATE TABLE `b_followed`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci NOT NULL COMMENT '用户id',
  `followed_user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci NULL DEFAULT NULL COMMENT '关注的用户id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '关注时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_german2_ci COMMENT = '用户关注表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_followed
-- ----------------------------

-- ----------------------------
-- Table structure for b_friend_link
-- ----------------------------
DROP TABLE IF EXISTS `b_friend_link`;
CREATE TABLE `b_friend_link`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '网站名称',
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '网站地址',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网站头像地址',
  `info` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '网站描述',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `reason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '下架原因',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT 'ENUM-状态:\"0,下架;1,申请;2:上架\"',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '友情链接表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_friend_link
-- ----------------------------
INSERT INTO `b_friend_link` VALUES (4, '拾壹博客', 'http://www.shiyit.com', 'http://img.shiyit.com/logo-ico.png', '一个专注技术分享的平台', '2484913345@qq.com', 1, NULL, 2, '2022-12-13 09:16:15', '2022-12-13 09:16:15');

-- ----------------------------
-- Table structure for b_im_message
-- ----------------------------
DROP TABLE IF EXISTS `b_im_message`;
CREATE TABLE `b_im_message`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci NOT NULL COMMENT '主键',
  `to_user_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci NULL DEFAULT NULL COMMENT '发送用户id',
  `from_user_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci NULL DEFAULT NULL COMMENT '接收用户id',
  `to_user_avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci NULL DEFAULT NULL COMMENT '发送用户头像',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci NULL COMMENT '发送内容',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '发送时间',
  `ip_source` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `ip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci NULL DEFAULT NULL COMMENT '发送用户ip',
  `is_withdraw` int(1) NULL DEFAULT 0 COMMENT '消息是否撤回 0：未撤回  1：撤回',
  `is_read` int(1) NULL DEFAULT 0 COMMENT '是否已读',
  `type` int(1) NULL DEFAULT NULL COMMENT '消息类型 1普通消息 2图片',
  `code` int(1) NULL DEFAULT NULL,
  `article_id` int(11) NULL DEFAULT NULL COMMENT '文章id',
  `notice_type` int(11) NULL DEFAULT NULL COMMENT '通知类型 0系统通知 1：评论 2：关注 3点赞 4收藏 5私信',
  `comment_mark` int(11) NULL DEFAULT NULL COMMENT '评论标记 1回复评论 2发表评论',
  `at_user_id` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci NULL DEFAULT NULL COMMENT '@用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_german2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_im_message
-- ----------------------------

-- ----------------------------
-- Table structure for b_im_room
-- ----------------------------
DROP TABLE IF EXISTS `b_im_room`;
CREATE TABLE `b_im_room`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `type` int(11) NOT NULL COMMENT '房间类型 0：群聊 1私聊',
  `from_user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属用户id',
  `to_user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接收用户id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户消息房间表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_im_room
-- ----------------------------

-- ----------------------------
-- Table structure for b_job
-- ----------------------------
DROP TABLE IF EXISTS `b_job`;
CREATE TABLE `b_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_job
-- ----------------------------
INSERT INTO `b_job` VALUES (2, '系统默认（无参）', 'DEFAULT', 'blogQuartz.ryNoParams', '0/10 * * * * ?', '3', '1', '1', '拾壹', '2021-12-09 09:09:21', '', '2023-06-30 14:50:29', '');
INSERT INTO `b_job` VALUES (3, '系统默认（有参）', 'DEFAULT', 'blogQuartz.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', '拾壹', '2021-12-09 09:09:21', '', NULL, '');
INSERT INTO `b_job` VALUES (6, '定时修改标签的点击量', 'DEFAULT', 'blogQuartz.updateTagsClickVolume', '0 0 3 * * ?', '0', '1', '1', '拾壹', '2021-12-17 15:37:20', 'shiyi', '2022-12-13 09:23:50', '1');
INSERT INTO `b_job` VALUES (8, '定时修改文章阅读量', 'SYSTEM', 'blogQuartz.updateReadQuantity', '0 0 4 * * ?', '0', '1', '0', 'shiyi', '2023-06-30 10:55:03', '', NULL, '1');
INSERT INTO `b_job` VALUES (9, '定时删除当天校验通过的IP', 'SYSTEM', 'blogQuartz.removeCodePassInIp', '0 30 23 * * ?', '0', '0', '0', 'shiyi', '2023-06-30 10:56:31', 'shiyi', '2023-06-30 10:56:35', '1');

-- ----------------------------
-- Table structure for b_job_log
-- ----------------------------
DROP TABLE IF EXISTS `b_job_log`;
CREATE TABLE `b_job_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_id` bigint(20) NOT NULL COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始时间',
  `stop_time` datetime(0) NULL DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1565 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for b_medal
-- ----------------------------
DROP TABLE IF EXISTS `b_medal`;
CREATE TABLE `b_medal`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '勋章名',
  `category_id` int(11) NULL DEFAULT NULL COMMENT '勋章分类id',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `info` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '勋章描述',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型 1svg 2图片',
  `create_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_medal
-- ----------------------------
INSERT INTO `b_medal` VALUES ('1', '官方', NULL, 'guanfang', '拾壹博客官方', 1, NULL);
INSERT INTO `b_medal` VALUES ('2', '前一百', NULL, '100', '拾壹博客前一百名注册用户', 1, NULL);

-- ----------------------------
-- Table structure for b_menu
-- ----------------------------
DROP TABLE IF EXISTS `b_menu`;
CREATE TABLE `b_menu`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上级资源ID',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'url',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源编码',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源名称',
  `level` int(11) NULL DEFAULT NULL COMMENT '资源级别',
  `sort_no` int(11) NULL DEFAULT NULL COMMENT '排序',
  `icon` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源图标',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型 menu、button',
  `remarks` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `redirect` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '重定向地址',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转地址',
  `hidden` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否隐藏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 285 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统管理-权限资源表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_menu
-- ----------------------------
INSERT INTO `b_menu` VALUES (1, '0', '/system', 'Layout', '系统管理', 0, 5, 'el-icon-setting', 'menu', '', '2019-03-28 18:51:08', '2021-12-17 15:26:06', '/system/menu', 'system', '1');
INSERT INTO `b_menu` VALUES (2, '1', '/role', '/system/role', '角色管理', 1, 2, 'el-icon-user-solid', 'menu', '', '2019-03-30 14:00:03', '2021-11-16 15:40:42', '', 'role', '1');
INSERT INTO `b_menu` VALUES (3, '2', '/system/role/list', NULL, '列表', 2, NULL, NULL, 'btn', NULL, NULL, NULL, '', NULL, '0');
INSERT INTO `b_menu` VALUES (4, '2', '/system/role/queryUserRole', NULL, '获取当前登录用户所拥有的权限', 2, NULL, NULL, 'btn', NULL, NULL, '2021-11-27 12:46:57', '', NULL, '0');
INSERT INTO `b_menu` VALUES (5, '2', '/system/role/update', '/system/role/update', '修改', 2, NULL, NULL, 'btn', '', '2021-09-24 15:57:33', '2021-11-11 18:09:44', '', NULL, '0');
INSERT INTO `b_menu` VALUES (6, '2', '/system/role/remove', '/system/role/update', '删除', 2, NULL, NULL, 'btn', '', '2021-09-27 11:33:32', '2021-11-11 18:09:36', '', NULL, '0');
INSERT INTO `b_menu` VALUES (7, '2', '/system/role/create', NULL, '添加', 2, 1, NULL, 'btn', NULL, '2021-11-13 21:14:07', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (8, '1', '/menu', '/system/menu', '菜单管理', 1, 5, 'el-icon-menu', 'menu', NULL, NULL, '2021-11-18 11:26:00', '', 'menu', '1');
INSERT INTO `b_menu` VALUES (9, '8', '/system/menu/getMenuTree', NULL, '列表', 2, NULL, NULL, 'btn', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (10, '8', '/system/menu/create', NULL, '添加', 2, NULL, NULL, 'btn', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (11, '8', '/system/menu/update', '/system/menu/update', '修改', 2, 2, NULL, 'btn', NULL, '2021-11-11 16:56:34', '2021-11-11 18:10:09', NULL, '/system/menu/update', '0');
INSERT INTO `b_menu` VALUES (12, '8', '/system/menu/getMenuList', NULL, '获取所有的url', 2, 6, NULL, 'btn', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (13, '8', '/system/menu/remove', '/system/menu/remove', '删除', 2, NULL, NULL, 'btn', '', '2021-09-27 11:45:33', '2021-11-11 18:10:03', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (14, '1', '/user', '/system/user', '用户管理', 1, 1, 'el-icon-user', 'menu', NULL, NULL, '2021-11-16 12:01:51', NULL, 'user', '1');
INSERT INTO `b_menu` VALUES (15, '14', '/system/user/list', '', '列表', 2, NULL, NULL, 'btn', '', '2021-09-27 15:33:19', '2021-11-11 18:10:22', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (16, '14', '/system/user/remove', '', '删除', 2, NULL, NULL, 'btn', '', '2021-09-27 16:36:42', '2021-11-11 18:10:27', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (17, '14', '/system/user/create', '', '添加', 2, NULL, NULL, 'btn', NULL, '2021-09-27 16:36:54', '2021-11-11 18:10:30', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (18, '14', '/system/user/update', '', '修改', 2, NULL, NULL, 'btn', '', '2021-09-27 16:59:38', '2021-11-11 18:10:34', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (19, '14', '/system/user/info', '', '详情', 2, NULL, NULL, 'btn', NULL, '2021-09-27 16:59:50', '2021-11-11 18:10:37', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (20, '14', '/system/user/getUserMenu', '', '获取用户权限', 2, NULL, NULL, 'btn', NULL, NULL, '2021-11-11 18:10:40', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (21, '14', '/system/user/updatePassword', '', '修改密码', 2, NULL, NULL, 'btn', NULL, '2021-11-09 17:23:58', '2021-11-11 18:10:51', NULL, '/system/user/update_password', '0');
INSERT INTO `b_menu` VALUES (22, '14', '/generateCode', NULL, '生成用户邀请码', 2, 5, NULL, 'btn', NULL, '2021-08-13 09:20:25', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (23, '14', '/system/user/logout', '', '退出登录', 2, NULL, NULL, 'btn', '', '2021-09-26 10:21:27', '2021-11-11 18:10:46', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (24, '1', '/api', '/system/api', '接口管理', 1, 4, 'el-icon-edit', 'menu', NULL, '2021-11-12 09:26:01', '2021-11-20 13:58:15', NULL, 'api', '1');
INSERT INTO `b_menu` VALUES (25, '24', '/system/menu/getMenuApi', '', '列表', 2, 1, '1', 'btn', NULL, '2021-11-12 10:55:11', NULL, NULL, '', '0');
INSERT INTO `b_menu` VALUES (26, '0', '/articles', 'Layout', '文章管理', 0, 1, 'el-icon-document-copy', 'menu', NULL, NULL, '2021-11-16 15:45:14', '/articles/index', '', '1');
INSERT INTO `b_menu` VALUES (27, '26', 'index', '/articles/index', '文章管理', 1, 1, 'el-icon-notebook-2', 'menu', NULL, NULL, '2021-11-16 15:41:57', '/articles/index', 'Articles', '1');
INSERT INTO `b_menu` VALUES (28, '27', '/system/article/list', '', '列表', 2, NULL, NULL, 'btn', NULL, NULL, '2021-11-11 18:11:17', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (29, '27', '/system/article/delete', '', '删除', 2, NULL, NULL, 'btn', NULL, NULL, '2021-11-11 18:11:21', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (30, '27', '/system/article/update', '', '修改', 2, NULL, NULL, 'btn', NULL, NULL, '2021-11-11 18:11:25', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (31, '27', '/system/article/add', '', '添加', 2, NULL, NULL, 'btn', NULL, NULL, '2021-11-11 18:11:32', NULL, '2', '0');
INSERT INTO `b_menu` VALUES (32, '27', '/system/article/info', '', '详情', 2, NULL, NULL, 'btn', NULL, NULL, '2021-11-11 18:11:35', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (33, '27', '/system/article/baiduSeo', '', 'SEO', 2, NULL, NULL, 'btn', '', '2021-10-15 10:38:19', '2021-11-11 18:11:41', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (35, '26', 'tags', '/articles/tags', '标签管理', 1, 2, 'el-icon-collection-tag', 'menu', NULL, NULL, '2021-11-18 11:25:18', NULL, 'Tags', '1');
INSERT INTO `b_menu` VALUES (36, '35', '/system/tags/list', NULL, '列表', 2, NULL, NULL, 'btn', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (37, '35', '/system/tags/add', '', '新增', 2, NULL, NULL, 'btn', NULL, NULL, '2021-11-11 18:11:54', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (38, '35', '/system/tags/info', '', '详情', 2, NULL, NULL, 'btn', NULL, NULL, '2021-11-11 18:11:58', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (39, '35', '/system/tags/update', '', '修改', 2, NULL, NULL, 'btn', NULL, NULL, '2021-11-11 18:12:08', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (40, '35', '/system/tags/remove', '/sys/tags/remove', '删除', 2, NULL, NULL, 'btn', NULL, '2021-11-10 17:34:38', '2021-11-11 18:12:01', NULL, '/sys/tags/remove', '0');
INSERT INTO `b_menu` VALUES (41, '0', '/site', 'Layout', '网站管理', 0, 2, 'el-icon-guide', 'menu', NULL, NULL, '2021-11-16 15:48:41', '/friendLink/index', '', '1');
INSERT INTO `b_menu` VALUES (47, '245', '/messages', '/news/message', '留言管理', 1, 2, 'el-icon-message', 'menu', NULL, NULL, '2021-11-16 15:43:46', '/message/index', '/message', '1');
INSERT INTO `b_menu` VALUES (48, '47', '/system/message/list', '', '列表', 2, NULL, NULL, 'btn', NULL, '2021-09-26 11:50:33', '2021-11-11 18:12:56', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (49, '47', '/system/message/remove', NULL, '删除', 2, 1, NULL, NULL, NULL, NULL, '2021-11-15 15:36:28', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (50, '47', 'test', NULL, '回复', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (51, '41', 'friendLink', '/site/friendLink/index', '友情链接', 1, 3, 'el-icon-link', 'menu', NULL, NULL, '2021-11-16 15:43:55', NULL, 'friendLink', '1');
INSERT INTO `b_menu` VALUES (52, '51', '/system/friend/list', NULL, '列表', 2, NULL, NULL, 'btn', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (53, '51', '/system/friend/create', NULL, '添加', 2, 1, NULL, 'btn', NULL, '2021-11-12 16:52:26', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (54, '51', '/system/friend/update', NULL, '修改', 2, 1, NULL, 'btn', NULL, '2021-11-12 16:52:08', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (55, '51', '/system/friend/remove', NULL, '删除', 2, 1, NULL, 'btn', NULL, '2021-11-14 12:18:00', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (56, '0', '/logs', 'Layout', '日志管理', 0, 4, 'el-icon-document', 'menu', NULL, NULL, '2021-12-31 14:46:11', NULL, NULL, '1');
INSERT INTO `b_menu` VALUES (57, '56', 'userLog', '/logs/userLog', '用户日志', 1, 1, 'el-icon-coordinate', 'menu', NULL, NULL, '2021-11-17 10:02:31', NULL, 'userLogs', '1');
INSERT INTO `b_menu` VALUES (58, '57', '/system/userLog/list', '', '列表', 2, NULL, '', 'btn', NULL, NULL, '2021-11-11 18:13:47', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (59, '56', 'adminLog', '/logs/adminLog', '操作日志', 1, 2, 'el-icon-magic-stick', 'menu', NULL, '2021-11-10 17:49:02', '2021-11-17 10:02:41', NULL, 'adminLog', '1');
INSERT INTO `b_menu` VALUES (60, '59', '/system/adminLog/list', '/sys/adminLog/query_log', '列表', 2, NULL, NULL, 'btn', NULL, '2021-11-10 17:49:27', '2021-11-11 18:13:54', NULL, '/zwblog/adminLog', '0');
INSERT INTO `b_menu` VALUES (61, '56', 'exceptionLog', '/logs/exceptionLog', '异常日志', 1, 3, 'el-icon-cpu', 'menu', NULL, '2021-11-11 10:57:42', '2021-11-17 10:02:47', NULL, 'exceptionLog', '1');
INSERT INTO `b_menu` VALUES (62, '61', '/system/exceptionLog/list', '/sys/exceptionLog/query_log', '列表', 2, NULL, NULL, 'btn', NULL, '2021-11-11 11:05:47', '2021-11-11 18:13:59', NULL, '/sys/exceptionLog/query_log', '0');
INSERT INTO `b_menu` VALUES (63, '0', '/other', 'Layout', '其他', 0, 1, 'el-icon-more-outline', 'menu', NULL, '2021-11-12 09:29:15', NULL, NULL, 'other', '0');
INSERT INTO `b_menu` VALUES (64, '63', '/image', '/image', '图片管理', 1, 1, 'el-icon-picture-outline', 'menu', NULL, '2021-11-12 09:31:24', '2021-11-16 15:47:05', NULL, '/image', '0');
INSERT INTO `b_menu` VALUES (65, '64', '/file/delBatchFile', '', '删除', 2, NULL, NULL, 'btn', '', '2021-09-27 11:53:16', '2021-11-11 18:10:55', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (66, '63', '/home', '', '首页', 1, NULL, 'el-icon-s-home', 'menu', '', '2021-10-16 15:46:06', '2021-11-12 09:30:39', NULL, 'home', '0');
INSERT INTO `b_menu` VALUES (67, '66', '/system/home/lineCount', '', '顶部统计信息', 2, NULL, NULL, 'btn', NULL, '2021-10-16 15:46:56', '2021-11-27 11:51:56', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (164, '0', '/listener', 'Layout', '监控中心', 0, 6, 'el-icon-monitor', 'menu', NULL, '2021-11-16 11:48:04', NULL, NULL, 'listener', '1');
INSERT INTO `b_menu` VALUES (165, '164', '/server', '/listener/server', '服务监控', 1, 1, 'el-icon-light-rain', 'menu', NULL, '2021-11-16 11:49:16', '2021-12-10 08:47:17', NULL, 'server', '1');
INSERT INTO `b_menu` VALUES (166, '165', '/system/home/systemInfo', NULL, '查看', 2, 1, NULL, 'btn', NULL, '2021-11-16 11:50:03', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (169, '41', '/dict', '/site/dict/index', '字典管理', 1, 1, 'el-icon-heavy-rain', 'menu', NULL, '2021-11-25 17:37:43', '2021-12-10 15:28:52', NULL, 'dict', '1');
INSERT INTO `b_menu` VALUES (170, '169', '/system/dict/list', NULL, '列表', 2, 1, NULL, 'btn', NULL, '2021-11-25 17:38:04', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (171, '41', '/dictData', '/site/dict/data', '字典数据', 1, 2, 'el-icon-sunset', 'menu', NULL, '2021-11-25 17:53:25', '2021-12-11 20:11:50', NULL, 'dictData', '0');
INSERT INTO `b_menu` VALUES (172, '171', '/system/dictData/list', NULL, '列表', 2, 1, NULL, 'btn', NULL, '2021-11-25 17:53:52', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (173, '169', '/system/dict/add', NULL, '添加', 2, 1, NULL, 'btn', NULL, '2021-11-26 08:57:12', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (174, '169', '/system/dict/update', NULL, '修改', 2, 2, NULL, 'btn', NULL, '2021-11-26 08:57:29', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (175, '171', '/system/dictData/getDataByDictType', NULL, '类型集合字典数据', 2, 2, NULL, 'btn', NULL, '2021-11-26 09:55:27', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (176, '169', '/system/dict/delete', NULL, '删除', 2, 3, NULL, 'btn', NULL, '2021-11-26 11:22:21', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (177, '169', '/system/dict/deleteBatch', NULL, '批量删除', 2, NULL, '4', 'btn', NULL, '2021-11-26 11:22:37', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (178, '171', '/system/dictData/add', NULL, '添加', 2, 1, NULL, 'btn', NULL, '2021-11-26 14:06:04', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (179, '171', '/system/dictData/update', NULL, '修改', 2, 2, NULL, 'btn', NULL, '2021-11-26 14:06:18', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (180, '171', '/system/dictData/delete', NULL, '删除', 2, 3, NULL, 'btn', NULL, '2021-11-26 14:06:31', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (181, '171', '/system/dictData/deleteBatch', NULL, '批量删除', 2, 4, NULL, 'btn', NULL, '2021-11-26 14:06:46', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (182, '1', 'systemconfig', '/system/config', '系统配置', 1, 2, 'el-icon-setting', 'menu', NULL, '2021-11-26 15:06:11', '2021-11-27 12:53:08', NULL, 'systemconfig', '1');
INSERT INTO `b_menu` VALUES (183, '182', '/system/config/getConfig', NULL, '查询', 2, 1, NULL, 'btn', NULL, '2021-11-26 15:06:39', '2021-11-26 15:45:36', NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (184, '182', '/system/config/update', NULL, '修改', 2, 2, NULL, 'btn', NULL, '2021-11-26 15:55:47', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (185, '2', '/system/role/queryRoleId', NULL, '获取该角色所拥有的权限', 2, 1, NULL, 'btn', NULL, '2021-11-27 12:47:27', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (186, '41', 'webConfig', '/site/webConfig/index', '网站配置', 1, 3, 'el-icon-setting', 'menu', NULL, '2021-11-27 13:48:02', NULL, NULL, 'webConfig', '1');
INSERT INTO `b_menu` VALUES (187, '186', '/system/webConfig/list', NULL, '查询', 2, 1, NULL, 'btn', NULL, '2021-11-27 13:48:33', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (188, '186', '/system/webConfig/update', NULL, '修改', 2, 1, NULL, 'btn', NULL, '2021-11-27 14:12:42', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (189, '35', '/system/tags/deleteBatch', '', '批量删除', 2, 1, NULL, 'btn', '', '2021-11-28 12:44:48', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (191, '164', '/quartz', '/listener/quartz', '定时任务', 1, 2, 'el-icon-coordinate', 'menu', '', '2021-12-10 08:46:08', NULL, NULL, 'quartz', '1');
INSERT INTO `b_menu` VALUES (192, '191', '/system/job/list', '', '列表', 2, 1, NULL, 'btn', '', '2021-12-10 08:47:52', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (193, '191', '/system/job/add', '', '添加', 2, 2, NULL, 'btn', '', '2021-12-10 08:48:13', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (194, '191', '/system/job/update', '', '修改', 2, 3, NULL, 'btn', '', '2021-12-10 08:48:27', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (195, '191', '/system/job/delete', '', '删除', 2, 4, NULL, 'btn', '', '2021-12-10 08:48:45', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (196, '191', '/system/job/run', '', '立即执行', 2, 5, NULL, 'btn', '', '2021-12-10 08:52:15', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (197, '191', '/system/job/change', '', '修改状态', 2, 6, NULL, 'btn', '', '2021-12-10 08:52:42', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (198, '191', '/system/job/info', '', '详情', 2, 7, NULL, 'btn', '', '2021-12-10 10:09:27', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (199, '164', '/jobLog', '/listener/quartz/log', '任务日志', 1, 3, 'el-icon-help', 'menu', '', '2021-12-10 11:45:00', NULL, NULL, 'log', '0');
INSERT INTO `b_menu` VALUES (200, '199', '/system/jobLog/list', '', '列表', 2, 1, NULL, 'btn', '', '2021-12-10 11:45:23', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (201, '199', '/system/jobLog/deleteBatch', '', '批量删除', 2, 2, NULL, 'btn', '', '2021-12-10 13:50:17', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (202, '199', '/system/jobLog/clean', '', '清空', 2, 3, NULL, 'btn', '', '2021-12-10 13:50:28', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (203, '191', '/system/job/deleteBatch', '', '批量删除', 2, 8, NULL, 'btn', '', '2021-12-10 14:23:21', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (215, '27', '/system/article/reptile', '', '爬虫', 2, 6, NULL, 'btn', '', '2021-12-24 09:00:15', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (216, '35', '/system/tags/top', '', '标签置顶', 2, 5, NULL, 'btn', '', '2021-12-24 09:00:36', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (223, '26', 'category', '/articles/category', '分类管理', 1, 3, 'el-icon-files', 'menu', '', '2021-12-29 10:05:12', '2021-12-29 10:08:05', NULL, '/category', '1');
INSERT INTO `b_menu` VALUES (224, '223', '/system/category/list', '', '列表', 2, 1, NULL, 'btn', '', '2021-12-29 10:05:38', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (225, '223', '/system/category/info', '', '详情', 2, 2, NULL, 'btn', '', '2021-12-29 10:05:58', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (226, '223', '/system/category/add', '', '新增', 2, 3, NULL, 'btn', '', '2021-12-29 10:06:18', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (227, '223', '/system/category/update', '', '修改', 2, 4, NULL, 'btn', '', '2021-12-29 10:06:33', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (228, '223', '/system/category/deleteBatch', '', '批量删除', 2, 5, NULL, 'btn', '', '2021-12-29 10:06:47', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (229, '223', '/system/category/top', '', '置顶', 2, 6, NULL, 'btn', '', '2021-12-29 10:07:06', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (230, '223', '/system/category/delete', '', '删除', 2, 7, NULL, 'btn', '', '2021-12-29 10:27:55', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (231, '249', '/albums', '/site/album/album', '相册列表', 1, 1, 'el-icon-camera', 'menu', '', '2021-12-30 16:29:09', '2022-01-06 15:00:26', NULL, '/album', '1');
INSERT INTO `b_menu` VALUES (232, '231', '/system/album/list', '', '列表', 2, 1, NULL, 'btn', '', '2021-12-30 16:31:50', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (233, '231', '/system/album/info', '', '详情', 2, 2, NULL, 'btn', '', '2021-12-30 16:32:15', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (234, '231', '/system/album/add', '', '新增', 2, 3, NULL, 'btn', '', '2021-12-30 16:32:33', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (235, '231', '/system/album/update', '', '修改', 2, 4, NULL, 'btn', '', '2021-12-30 16:42:49', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (236, '231', '/system/album/delete', '', '删除', 2, 5, NULL, 'btn', '', '2021-12-30 16:43:13', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (237, '249', '/photos', '/site/album/photo', '照片管理', 1, 2, 'el-icon-camera', 'menu', '', '2021-12-31 08:49:19', NULL, NULL, '/photo', '0');
INSERT INTO `b_menu` VALUES (238, '237', '/system/photo/list', '', '列表', 2, 1, NULL, 'btn', '', '2021-12-31 08:49:42', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (239, '237', '/system/photo/info', '', '详情', 2, 2, NULL, 'btn', '', '2021-12-31 08:50:10', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (241, '237', '/system/photo/add', '', '新增', 2, 3, NULL, 'btn', '', '2021-12-31 08:50:38', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (242, '237', '/system/photo/update', '', '修改', 2, 4, NULL, 'btn', '', '2021-12-31 08:50:52', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (243, '237', '/system/photo/deleteBatch', '', '批量删除', 2, 5, NULL, 'btn', '', '2021-12-31 08:51:08', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (244, '237', '/system/photo/movePhoto', '', '移动照片', 2, 5, NULL, 'btn', '', '2021-12-31 08:51:08', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (245, '0', '/news', 'Layout', '消息管理', 0, 3, 'el-icon-bell', 'menu', '', '2021-12-31 14:21:26', NULL, NULL, '/new', '1');
INSERT INTO `b_menu` VALUES (246, '47', '/system/message/passBatch', '', '批量通过', 2, 3, NULL, 'btn', '', '2021-12-31 14:35:29', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (247, '47', '/system/message/deleteBatch', '', '批量删除', 2, 4, NULL, 'btn', '', '2021-12-31 14:35:47', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (248, '66', '/web/comment/addComment', '', '发表评论', 2, 5, NULL, 'btn', '', '2022-01-06 09:27:46', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (249, '0', '/album', 'Layout', '相册管理', 0, 3, 'el-icon-picture-outline', 'menu', '', '2021-12-31 14:21:26', '2022-01-06 15:00:44', NULL, '/album', '1');
INSERT INTO `b_menu` VALUES (250, '57', '/system/userLog/delete', '', '删除', 2, 2, NULL, 'btn', '', '2022-01-06 15:41:01', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (251, '59', '/system/adminLog/delete', '', '删除', 2, 2, NULL, 'btn', '', '2022-01-06 15:41:27', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (252, '61', '/system/exceptionLog/delete', '', '删除', 2, 2, NULL, 'btn', '', '2022-01-06 15:41:49', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (253, '27', '/system/article/deleteBatch', '', '批量删除', 2, 6, NULL, 'btn', '', '2022-01-06 18:00:24', NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (254, '51', '/system/friend/top', '', '置顶', 2, 4, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (256, '245', '/feedbacks', '/news/feedback', '反馈管理', 1, 2, 'el-icon-warning-outline', 'menu', '', NULL, NULL, NULL, '/feedback', '1');
INSERT INTO `b_menu` VALUES (257, '256', '/system/feedback/list', '', '列表', 2, 1, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (258, '256', '/system/feedback/deleteBatch', '', '批量删除', 2, 2, NULL, 'btn', '批量删除反馈', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (260, '64', '/file/upload', '', '上传图片', 2, 1, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (261, '66', '/system/home/init', '', '首页各种统计信息', 2, 3, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (262, '27', '/system/article/pubOrShelf', '', '发布或下架文章', 2, 4, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (263, '164', 'onlineUser', '/listener/user/index', '在线用户', 1, 3, 'el-icon-user', 'menu', '', NULL, NULL, NULL, 'online', '1');
INSERT INTO `b_menu` VALUES (264, '263', '/system/user/kick', '', '踢人下线', 2, 1, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (265, '164', 'druids', '/listener/druid/index', 'druid监控', 1, 4, 'el-icon-help', 'menu', '', NULL, NULL, NULL, 'druid', '1');
INSERT INTO `b_menu` VALUES (266, '245', 'comment', '/news/comment', '评论管理', 1, 1, 'el-icon-chat-dot-round', 'menu', '', NULL, NULL, NULL, 'comments', '1');
INSERT INTO `b_menu` VALUES (267, '266', '/system/comment/list', '', '评论列表', 2, 1, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (268, '266', '/system/comment/deleteBatch', '', '批量删除评论', 2, 2, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (269, '164', 'cache', '/listener/cache', '缓存监控', 1, 5, 'el-icon-hot-water', 'menu', '', NULL, NULL, NULL, 'caches', '1');
INSERT INTO `b_menu` VALUES (270, '269', '/system/home/cache', '', '获取缓存监控', 2, 1, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (271, '27', '/system/article/top', '', '置顶文章', 2, 5, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (272, '26', 'note', '/articles/note', '笔记管理', 1, 4, 'el-icon-notebook-1', 'menu', '', NULL, NULL, NULL, 'note', '1');
INSERT INTO `b_menu` VALUES (273, '272', '/system/note/list', '', '列表', 2, 1, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (274, '272', '/system/note/delete', '', '删除', 2, 2, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (275, '41', 'siteClass', '/site/navigation/index', '导航管理', 1, 4, 'el-icon-s-operation', 'menu', '', NULL, NULL, NULL, 'siteClass', '1');
INSERT INTO `b_menu` VALUES (276, '275', '/system/siteClass/list', '', '网站分类列表', 2, 1, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (277, '275', '/system/siteClass/insert', '', '添加网站分类', 2, 2, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (278, '275', '/system/siteClass/update', '', '修改网站分类', 2, 3, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (279, '275', '/system/siteClass/deleteBatch', '', '删除网站导航', 2, 4, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (280, '41', 'navigation', '/site/navigation/navigation', '网址管理', 1, 1, 'el-icon-more', 'menu', '', NULL, NULL, NULL, 'navigation', '0');
INSERT INTO `b_menu` VALUES (281, '280', '/system/navigation/list', '', '列表', 2, 1, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (282, '280', '/system/navigation/insert', '', '添加', 2, 2, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (283, '280', '/system/navigation/update', '', '修改', 2, 3, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');
INSERT INTO `b_menu` VALUES (284, '280', '/system/navigation/deleteBatch', '', '删除', 2, 4, NULL, 'btn', '', NULL, NULL, NULL, NULL, '0');

-- ----------------------------
-- Table structure for b_message
-- ----------------------------
DROP TABLE IF EXISTS `b_message`;
CREATE TABLE `b_message`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `time` tinyint(10) NULL DEFAULT NULL,
  `status` int(1) NULL DEFAULT NULL COMMENT '状态 0:审核  1：正常',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 712 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_message
-- ----------------------------

-- ----------------------------
-- Table structure for b_navigation
-- ----------------------------
DROP TABLE IF EXISTS `b_navigation`;
CREATE TABLE `b_navigation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `site_class_id` int(11) NOT NULL COMMENT '网站分类id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '网站标题',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网址地址',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网站logo',
  `info` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网站描述',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '网站导航表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_navigation
-- ----------------------------
INSERT INTO `b_navigation` VALUES (1, 1, '博客园', 'https://www.cnblog_demos.com/', 'http://img.shiyit.com/50708941a28144479fc624e9a84c4773.png', '开发者的网上家园', '2023-08-01 09:00:19', '2023-08-01 09:00:21');
INSERT INTO `b_navigation` VALUES (2, 1, 'CSDN', 'https://www.csdn.net/', 'http://cxy521.com/static/img/index/tech/csdn.png', '中文最大的技术社区', NULL, NULL);
INSERT INTO `b_navigation` VALUES (3, 1, '开源中国', 'https://www.oschina.net/', 'http://cxy521.com/static/img/index/tech/oschina.ico', '目前国内最大的开源技术社区', NULL, NULL);
INSERT INTO `b_navigation` VALUES (4, 1, '掘金', 'https://juejin.cn/', 'http://cxy521.com/static/img/index/tech/juejin.png', '一个帮助开发者成长的社区', NULL, NULL);
INSERT INTO `b_navigation` VALUES (5, 1, 'StackOverflow', 'https://stackoverflow.com/', 'http://cxy521.com/static/img/index/tech/stackoverflow.svg', '全球最大的技术问答社区', NULL, NULL);
INSERT INTO `b_navigation` VALUES (6, 1, '简书', 'https://www.jianshu.com/', 'http://img.shiyit.com/14e0d6d549664ee0a02ba6205fa0bb86.jpg', '创作你的创作', NULL, '2023-08-03 09:02:07');
INSERT INTO `b_navigation` VALUES (10, 2, 'Cron表达式', 'https://www.matools.com/cron/', 'http://img.shiyit.com/c2408e7dd86d41478bf36c66869966a1.jpg', '在线Cron表达式生成器', '2023-08-03 11:12:31', NULL);
INSERT INTO `b_navigation` VALUES (11, 7, 'Element UI', 'https://element.eleme.cn/#/zh-CN', 'http://img.shiyit.com/7ea049e2eadb4505b1775cd558cd3d0f.jpg', 'Element，一套为开发者、设计师和产品经理准备的基于 Vue 2.0 的桌面端组件库', '2023-08-03 11:17:58', NULL);
INSERT INTO `b_navigation` VALUES (12, 7, 'Vue.js', 'https://vuejs.org/', 'http://img.shiyit.com/d0c356bfecc2463aaf1841d4708a222b.png', '渐进式JavaScript框架、流行的前端开发框架！', '2023-08-03 11:19:27', NULL);

-- ----------------------------
-- Table structure for b_note
-- ----------------------------
DROP TABLE IF EXISTS `b_note`;
CREATE TABLE `b_note`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `category_id` int(11) NULL DEFAULT NULL COMMENT '分类id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '笔记' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_note
-- ----------------------------

-- ----------------------------
-- Table structure for b_photo
-- ----------------------------
DROP TABLE IF EXISTS `b_photo`;
CREATE TABLE `b_photo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `album_id` int(11) NOT NULL COMMENT '相册id',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '照片名',
  `info` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '照片描述',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '照片地址',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '照片' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_photo
-- ----------------------------
INSERT INTO `b_photo` VALUES (1, 2, '壁纸1', '壁纸1', 'http://img.shiyit.com/24f7b723309b46eba38cca127ea2bcc2jpg', '2022-06-29 09:29:18', NULL);
INSERT INTO `b_photo` VALUES (2, 1, '背景2', '背景2', 'http://img.shiyit.com/d11d3ced99b343458f70f1f861e96828jpg', '2022-06-29 09:29:31', NULL);
INSERT INTO `b_photo` VALUES (3, 1, '背景3', '背景3', 'http://img.shiyit.com/1642481190129.jpg', '2022-06-29 09:30:25', NULL);
INSERT INTO `b_photo` VALUES (4, 2, '壁纸2', '壁纸1', 'http://img.shiyit.com/deca5c2423cc4e2d987b53e9d8177e68.png', '2023-06-15 11:11:45', NULL);

-- ----------------------------
-- Table structure for b_photo_album
-- ----------------------------
DROP TABLE IF EXISTS `b_photo_album`;
CREATE TABLE `b_photo_album`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '相册名',
  `info` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '相册描述',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '相册封面',
  `status` int(1) NOT NULL DEFAULT 0 COMMENT '状态值 0公开 1私密',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '相册' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_photo_album
-- ----------------------------
INSERT INTO `b_photo_album` VALUES (1, '背景图', '背景图', 'http://img.shiyit.com/ec708c8859474e3496ab64fc98b2d1c1jpg', 0, '2022-06-29 09:16:13', NULL);
INSERT INTO `b_photo_album` VALUES (2, '壁纸', '壁纸', '', 0, '2023-06-15 11:10:51', NULL);

-- ----------------------------
-- Table structure for b_prop
-- ----------------------------
DROP TABLE IF EXISTS `b_prop`;
CREATE TABLE `b_prop`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `max_num` int(11) NULL DEFAULT NULL COMMENT '拥有最大上限',
  `type` int(11) NOT NULL COMMENT '类型 1:补签卡 2:积分',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '道具表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_prop
-- ----------------------------
INSERT INTO `b_prop` VALUES (1, '补签卡', 9999, 1, '2023-07-13 16:33:59');

-- ----------------------------
-- Table structure for b_role
-- ----------------------------
DROP TABLE IF EXISTS `b_role`;
CREATE TABLE `b_role`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色编码',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `remarks` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色描述',
  `created_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统管理-角色表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_role
-- ----------------------------
INSERT INTO `b_role` VALUES (1, 'admin', '管理员', '系统管理员', '2019-03-28 15:51:56', '2022-01-06 18:03:34');
INSERT INTO `b_role` VALUES (2, 'user', '用户', '用户', '2021-12-27 07:01:39', '2021-12-27 07:01:39');
INSERT INTO `b_role` VALUES (5, 'demonstrate', '演示', '演示账号', '2021-11-14 12:23:25', '2022-01-06 18:03:43');

-- ----------------------------
-- Table structure for b_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `b_role_menu`;
CREATE TABLE `b_role_menu`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(10) NULL DEFAULT NULL COMMENT '角色ID',
  `menu_id` int(10) NULL DEFAULT NULL COMMENT '菜单ID',
  `created_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `last_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `role_id`(`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12431 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统管理 - 角色-权限资源关联表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_role_menu
-- ----------------------------
INSERT INTO `b_role_menu` VALUES (12121, 1, 1, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12122, 1, 2, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12123, 1, 3, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12124, 1, 4, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12125, 1, 5, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12126, 1, 6, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12127, 1, 7, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12128, 1, 185, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12129, 1, 8, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12130, 1, 9, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12131, 1, 10, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12132, 1, 11, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12133, 1, 12, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12134, 1, 13, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12135, 1, 14, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12136, 1, 15, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12137, 1, 16, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12138, 1, 17, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12139, 1, 18, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12140, 1, 19, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12141, 1, 20, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12142, 1, 21, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12143, 1, 22, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12144, 1, 23, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12145, 1, 24, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12146, 1, 25, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12147, 1, 182, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12148, 1, 183, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12149, 1, 184, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12150, 1, 26, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12151, 1, 27, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12152, 1, 28, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12153, 1, 29, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12154, 1, 30, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12155, 1, 31, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12156, 1, 32, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12157, 1, 33, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12158, 1, 215, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12159, 1, 253, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12160, 1, 262, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12161, 1, 271, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12162, 1, 35, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12163, 1, 36, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12164, 1, 37, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12165, 1, 38, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12166, 1, 39, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12167, 1, 40, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12168, 1, 189, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12169, 1, 216, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12170, 1, 223, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12171, 1, 224, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12172, 1, 225, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12173, 1, 226, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12174, 1, 227, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12175, 1, 228, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12176, 1, 229, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12177, 1, 230, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12178, 1, 272, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12179, 1, 273, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12180, 1, 274, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12181, 1, 41, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12182, 1, 51, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12183, 1, 52, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12184, 1, 53, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12185, 1, 54, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12186, 1, 55, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12187, 1, 254, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12188, 1, 169, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12189, 1, 170, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12190, 1, 173, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12191, 1, 174, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12192, 1, 176, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12193, 1, 177, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12194, 1, 171, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12195, 1, 172, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12196, 1, 175, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12197, 1, 178, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12198, 1, 179, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12199, 1, 180, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12200, 1, 181, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12201, 1, 186, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12202, 1, 187, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12203, 1, 188, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12204, 1, 275, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12205, 1, 276, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12206, 1, 277, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12207, 1, 278, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12208, 1, 279, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12209, 1, 280, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12210, 1, 281, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12211, 1, 282, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12212, 1, 283, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12213, 1, 284, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12214, 1, 56, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12215, 1, 57, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12216, 1, 58, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12217, 1, 250, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12218, 1, 59, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12219, 1, 60, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12220, 1, 251, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12221, 1, 61, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12222, 1, 62, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12223, 1, 252, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12224, 1, 63, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12225, 1, 64, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12226, 1, 65, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12227, 1, 260, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12228, 1, 66, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12229, 1, 67, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12230, 1, 248, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12231, 1, 261, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12232, 1, 164, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12233, 1, 165, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12234, 1, 166, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12235, 1, 191, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12236, 1, 192, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12237, 1, 193, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12238, 1, 194, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12239, 1, 195, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12240, 1, 196, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12241, 1, 197, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12242, 1, 198, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12243, 1, 203, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12244, 1, 199, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12245, 1, 200, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12246, 1, 201, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12247, 1, 202, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12248, 1, 263, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12249, 1, 264, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12250, 1, 265, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12251, 1, 269, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12252, 1, 270, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12253, 1, 245, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12254, 1, 47, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12255, 1, 48, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12256, 1, 49, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12257, 1, 50, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12258, 1, 246, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12259, 1, 247, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12260, 1, 256, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12261, 1, 257, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12262, 1, 258, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12263, 1, 266, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12264, 1, 267, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12265, 1, 268, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12266, 1, 249, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12267, 1, 231, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12268, 1, 232, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12269, 1, 233, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12270, 1, 234, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12271, 1, 235, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12272, 1, 236, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12273, 1, 237, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12274, 1, 238, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12275, 1, 239, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12276, 1, 241, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12277, 1, 242, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12278, 1, 243, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12279, 1, 244, '2023-08-03 03:10:10', '2023-08-03 03:10:10');
INSERT INTO `b_role_menu` VALUES (12280, 5, 1, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12281, 5, 2, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12282, 5, 3, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12283, 5, 4, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12284, 5, 5, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12285, 5, 6, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12286, 5, 7, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12287, 5, 185, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12288, 5, 8, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12289, 5, 9, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12290, 5, 10, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12291, 5, 11, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12292, 5, 12, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12293, 5, 13, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12294, 5, 14, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12295, 5, 15, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12296, 5, 16, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12297, 5, 17, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12298, 5, 18, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12299, 5, 19, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12300, 5, 20, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12301, 5, 21, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12302, 5, 22, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12303, 5, 23, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12304, 5, 24, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12305, 5, 25, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12306, 5, 182, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12307, 5, 183, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12308, 5, 184, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12309, 5, 28, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12310, 5, 29, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12311, 5, 30, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12312, 5, 31, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12313, 5, 32, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12314, 5, 33, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12315, 5, 215, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12316, 5, 253, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12317, 5, 262, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12318, 5, 35, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12319, 5, 36, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12320, 5, 37, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12321, 5, 38, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12322, 5, 39, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12323, 5, 40, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12324, 5, 189, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12325, 5, 216, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12326, 5, 223, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12327, 5, 224, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12328, 5, 225, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12329, 5, 226, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12330, 5, 227, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12331, 5, 228, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12332, 5, 229, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12333, 5, 230, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12334, 5, 273, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12335, 5, 51, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12336, 5, 52, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12337, 5, 53, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12338, 5, 54, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12339, 5, 55, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12340, 5, 254, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12341, 5, 169, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12342, 5, 170, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12343, 5, 173, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12344, 5, 174, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12345, 5, 176, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12346, 5, 177, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12347, 5, 171, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12348, 5, 172, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12349, 5, 175, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12350, 5, 178, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12351, 5, 179, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12352, 5, 180, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12353, 5, 181, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12354, 5, 186, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12355, 5, 187, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12356, 5, 188, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12357, 5, 276, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12358, 5, 277, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12359, 5, 281, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12360, 5, 56, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12361, 5, 57, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12362, 5, 58, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12363, 5, 250, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12364, 5, 59, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12365, 5, 60, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12366, 5, 251, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12367, 5, 61, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12368, 5, 62, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12369, 5, 252, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12370, 5, 65, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12371, 5, 66, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12372, 5, 67, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12373, 5, 248, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12374, 5, 261, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12375, 5, 164, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12376, 5, 165, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12377, 5, 166, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12378, 5, 191, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12379, 5, 192, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12380, 5, 193, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12381, 5, 194, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12382, 5, 195, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12383, 5, 196, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12384, 5, 197, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12385, 5, 198, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12386, 5, 203, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12387, 5, 199, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12388, 5, 200, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12389, 5, 201, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12390, 5, 202, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12391, 5, 263, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12392, 5, 264, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12393, 5, 265, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12394, 5, 269, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12395, 5, 270, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12396, 5, 245, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12397, 5, 47, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12398, 5, 48, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12399, 5, 49, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12400, 5, 50, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12401, 5, 246, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12402, 5, 247, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12403, 5, 256, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12404, 5, 257, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12405, 5, 258, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12406, 5, 266, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12407, 5, 267, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12408, 5, 268, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12409, 5, 249, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12410, 5, 231, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12411, 5, 232, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12412, 5, 233, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12413, 5, 234, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12414, 5, 235, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12415, 5, 236, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12416, 5, 237, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12417, 5, 238, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12418, 5, 239, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12419, 5, 241, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12420, 5, 242, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12421, 5, 243, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12422, 5, 244, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12423, 5, 26, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12424, 5, 27, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12425, 5, 272, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12426, 5, 41, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12427, 5, 275, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12428, 5, 280, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12429, 5, 63, '2023-08-03 03:23:46', '2023-08-03 03:23:46');
INSERT INTO `b_role_menu` VALUES (12430, 5, 64, '2023-08-03 03:23:46', '2023-08-03 03:23:46');

-- ----------------------------
-- Table structure for b_sign
-- ----------------------------
DROP TABLE IF EXISTS `b_sign`;
CREATE TABLE `b_sign`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户id',
  `create_time` date NOT NULL COMMENT '签到时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_sign
-- ----------------------------

-- ----------------------------
-- Table structure for b_site_class
-- ----------------------------
DROP TABLE IF EXISTS `b_site_class`;
CREATE TABLE `b_site_class`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '网址分类名',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '网址分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_site_class
-- ----------------------------
INSERT INTO `b_site_class` VALUES (1, '技术社区', 9, '2023-08-02 15:05:57', '2023-08-02 15:08:13');
INSERT INTO `b_site_class` VALUES (2, '常用推荐', 10, '2023-08-02 15:05:57', '2023-08-03 09:06:56');
INSERT INTO `b_site_class` VALUES (3, '站长工具', 6, '2023-08-02 15:05:57', '2023-08-03 09:07:13');
INSERT INTO `b_site_class` VALUES (7, '前端开发', 7, '2023-08-02 15:14:10', '2023-08-03 09:07:10');
INSERT INTO `b_site_class` VALUES (8, '后端开发', 8, '2023-08-02 15:14:16', '2023-08-03 09:07:08');

-- ----------------------------
-- Table structure for b_sponsor
-- ----------------------------
DROP TABLE IF EXISTS `b_sponsor`;
CREATE TABLE `b_sponsor`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `order_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '翼支付订单id',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '打赏金额',
  `is_pay` int(11) NULL DEFAULT NULL COMMENT '是否支付',
  `pay_type` int(11) NULL DEFAULT NULL COMMENT '支付方式',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_sponsor
-- ----------------------------

-- ----------------------------
-- Table structure for b_system_config
-- ----------------------------
DROP TABLE IF EXISTS `b_system_config`;
CREATE TABLE `b_system_config`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `qi_niu_access_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '七牛云公钥',
  `qi_niu_secret_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '七牛云私钥',
  `qi_niu_area` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '七牛云存储区域 华东（z0），华北(z1)，华南(z2)，北美(na0)，东南亚(as0)',
  `qi_niu_bucket` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '七牛云上传空间',
  `qi_niu_picture_base_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '七牛云域名前缀：http://images.moguit.cn',
  `upload_qi_niu` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件上传七牛云(0:否， 1:是)',
  `open_email_activate` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否开启注册用户邮件激活(0:否， 1:是)',
  `start_email_notification` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '是否开启邮件通知(0:否， 1:是)',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `open_dashboard_notification` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '是否开启仪表盘通知(0:否， 1:是)',
  `dashboard_notification_md` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '仪表盘通知【用于首次登录弹框】MD',
  `dashboard_notification` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '仪表盘通知【用于首次登录弹框】',
  `search_model` int(1) NOT NULL DEFAULT 0 COMMENT '搜索模式【0:SQL搜索 、1：全文检索】',
  `email_host` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱地址',
  `email_username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱发件人',
  `email_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱授权码',
  `email_port` int(10) NULL DEFAULT NULL COMMENT '邮箱发送端口',
  `open_email` int(1) NULL DEFAULT NULL COMMENT '启用邮箱发送',
  `local_file_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '本地文件地址',
  `file_upload_way` int(1) NULL DEFAULT NULL COMMENT '文件上传方式 1:本地 2：七牛云',
  `ali_yun_access_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '阿里云ak',
  `ali_yun_secret_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '阿里云sk',
  `ali_yun_bucket` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '阿里云存储桶名',
  `ali_yun_endpoint` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '阿里云Endpoint',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_system_config
-- ----------------------------
INSERT INTO `b_system_config` VALUES (1, '', '', 'z0', 'shiyi-blog', 'http://img.shiyit.com/', '1', '0', '0', '2021-11-26 15:41:36', '2021-11-26 15:41:36', '1', '欢迎来到拾壹博客项目，开源项目离不开大家的支持，希望小伙伴能随手点赞一下，你的点赞就是我维护的动力~\n\n博主使用笔记本开发的项目，所以页面中表格的列在大屏显示器中会显示宽度的不均衡，如需要可以自行调整。\n\n项目源码：[点我传送](https://gitee.com/quequnlong/shiyi-blog)，项目官网：[点我传送](http://www.shiyit.com)\n\n项目还在开发阶段，如有不善的地方欢迎各位小伙伴多多反馈\n\n最低配置：1核2G \n\n推荐配置：2核4G [【狂欢特惠】](https://cloud.tencent.com/act/new?channel=sp&fromSource=gwzcw.5433948.5433948.5433948&utm_medium=cpc&utm_id=gwzcw.5433948.5433948.5433948&bd_vid=6261311440599794431)\n\n服务器和域名等服务的购买和续费都会产生一定的费用，为了维持项目的正常运作，如果觉得本项目对您有帮助的话\n\n欢迎朋友能够给予一些支持，非常感谢~（ps.. 小伙伴赞赏的时候可以备注一下下~）\n|支付宝|微信|\n|-|-|-|\n|<img src=\"http://img.shiyit.com/alipay.jpg\" width=\"50%\">|<img src=\"http://img.shiyit.com/wxpay.jpg\" width=\"50%\">\n', '<p>欢迎来到拾壹博客项目，开源项目离不开大家的支持，希望小伙伴能随手点赞一下，你的点赞就是我维护的动力~</p>\n<p>博主使用笔记本开发的项目，所以页面中表格的列在大屏显示器中会显示宽度的不均衡，如需要可以自行调整。</p>\n<p>项目源码：<a href=\"https://gitee.com/quequnlong/shiyi-blog\" target=\"_blank\">点我传送</a>，项目官网：<a href=\"http://www.shiyit.com\" target=\"_blank\">点我传送</a></p>\n<p>项目还在开发阶段，如有不善的地方欢迎各位小伙伴多多反馈</p>\n<p>最低配置：1核2G</p>\n<p>推荐配置：2核4G <a href=\"https://cloud.tencent.com/act/new?channel=sp&amp;fromSource=gwzcw.5433948.5433948.5433948&amp;utm_medium=cpc&amp;utm_id=gwzcw.5433948.5433948.5433948&amp;bd_vid=6261311440599794431\" target=\"_blank\">【狂欢特惠】</a></p>\n<p>服务器和域名等服务的购买和续费都会产生一定的费用，为了维持项目的正常运作，如果觉得本项目对您有帮助的话</p>\n<p>欢迎朋友能够给予一些支持，非常感谢~（ps… 小伙伴赞赏的时候可以备注一下下~）</p>\n<table>\n<thead>\n<tr>\n<th>支付宝</th>\n<th>微信</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td><img src=\"http://img.shiyit.com/alipay.jpg\" width=\"50%\"></td>\n<td><img src=\"http://img.shiyit.com/wxpay.jpg\" width=\"50%\"></td>\n</tr>\n</tbody>\n</table>\n', 0, '', '', '', 587, 1, 'http://www.shiyit.com/shiyi/img/', 1, '', '', '', '');
INSERT INTO `b_system_config` VALUES (2, '', '', 'z0', '', 'http://img.shiyit.com/', '1', '1', '1', '2021-11-26 15:41:36', '2021-11-26 15:41:36', '1', '欢迎来到拾壹博客项目，开源项目离不开大家的支持，希望小伙伴能随手点赞一下，你的点赞就是我维护的动力~\n\n博主使用笔记本开发的项目，所以页面中表格的列在大屏显示器中会显示宽度的不均衡，如需要可以自行调整。\n\n项目源码：[点我传送](https://gitee.com/quequnlong/shiyi-blog)，项目官网：[点我传送](http://www.shiyit.com)\n\n项目还在开发阶段，如有不善的地方欢迎各位小伙伴多多反馈\n\n最低配置：1核2G \n\n推荐配置：2核4G [【狂欢特惠】](https://cloud.tencent.com/act/new?channel=sp&fromSource=gwzcw.5433948.5433948.5433948&utm_medium=cpc&utm_id=gwzcw.5433948.5433948.5433948&bd_vid=6261311440599794431)\n\n服务器和域名等服务的购买和续费都会产生一定的费用，为了维持项目的正常运作，如果觉得本项目对您有帮助的话\n\n欢迎朋友能够给予一些支持，非常感谢~（ps.. 小伙伴赞赏的时候可以备注一下下~）\n|支付宝|微信|\n|-|-|-|\n|![支付宝](http://img.shiyit.com/1639990067114.png)|![微信](http://img.shiyit.com/1639990061772.png)|\n', '<p>欢迎来到拾壹博客项目，开源项目离不开大家的支持，希望小伙伴能随手点赞一下，你的点赞就是我维护的动力~</p>\n<p>博主使用笔记本开发的项目，所以页面中表格的列在大屏显示器中会显示宽度的不均衡，如需要可以自行调整。</p>\n<p>项目源码：<a href=\"https://gitee.com/quequnlong/shiyi-blog\" target=\"_blank\">点我传送</a>，项目官网：<a href=\"http://www.shiyit.com\" target=\"_blank\">点我传送</a></p>\n<p>项目还在开发阶段，如有不善的地方欢迎各位小伙伴多多反馈</p>\n<p>最低配置：1核2G</p>\n<p>推荐配置：2核4G <a href=\"https://cloud.tencent.com/act/new?channel=sp&amp;fromSource=gwzcw.5433948.5433948.5433948&amp;utm_medium=cpc&amp;utm_id=gwzcw.5433948.5433948.5433948&amp;bd_vid=6261311440599794431\" target=\"_blank\">【狂欢特惠】</a></p>\n<p>服务器和域名等服务的购买和续费都会产生一定的费用，为了维持项目的正常运作，如果觉得本项目对您有帮助的话</p>\n<p>欢迎朋友能够给予一些支持，非常感谢~（ps… 小伙伴赞赏的时候可以备注一下下~）</p>\n<table>\n<thead>\n<tr>\n<th>支付宝</th>\n<th>微信</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td><img src=\"http://img.shiyit.com/1639990067114.png\" alt=\"支付宝\" /></td>\n<td><img src=\"http://img.shiyit.com/1639990061772.png\" alt=\"微信\" /></td>\n</tr>\n</tbody>\n</table>\n', 1, 'smtp.qq.com', 'xxx@qq.com', NULL, 587, 1, NULL, 1, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for b_tags
-- ----------------------------
DROP TABLE IF EXISTS `b_tags`;
CREATE TABLE `b_tags`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标签名称',
  `click_volume` int(10) NULL DEFAULT 0,
  `sort` int(11) NOT NULL COMMENT '排序',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tag_name`(`name`) USING BTREE COMMENT '博客标签名称'
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '博客标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_tags
-- ----------------------------
INSERT INTO `b_tags` VALUES (1, 'Spring Boot', 842, 20, '2021-11-12 14:43:27', '2023-06-05 03:00:00');
INSERT INTO `b_tags` VALUES (2, 'Elasticsearch', 737, 6, '2021-11-12 14:43:27', '2023-06-05 03:00:00');
INSERT INTO `b_tags` VALUES (10, 'blog', 679, 9, '2021-11-12 14:43:27', '2023-06-05 03:00:00');
INSERT INTO `b_tags` VALUES (12, 'Vue', 300, 18, '2021-12-29 14:01:50', '2023-06-05 03:00:00');
INSERT INTO `b_tags` VALUES (13, 'Spring Cloud', 759, 19, '2021-12-29 14:02:32', '2023-06-05 03:00:00');
INSERT INTO `b_tags` VALUES (17, 'Redis', 395, 7, '2022-01-25 14:09:03', '2023-06-05 03:00:00');
INSERT INTO `b_tags` VALUES (18, 'Linux', 491, 10, '2022-01-25 14:09:17', '2023-06-05 03:00:00');
INSERT INTO `b_tags` VALUES (31, 'Mysql', 516, 10, '2022-02-18 16:01:07', '2023-06-05 03:00:00');
INSERT INTO `b_tags` VALUES (32, 'Nginx', 442, 5, '2022-04-13 17:48:08', '2023-06-05 03:00:00');
INSERT INTO `b_tags` VALUES (51, '异步', 92, 5, '2023-04-03 11:30:54', '2023-06-05 03:00:00');
INSERT INTO `b_tags` VALUES (56, 'Css', 0, 8, '2023-06-27 16:02:14', '2023-06-27 08:02:14');
INSERT INTO `b_tags` VALUES (57, 'Java Script', 0, 1, '2023-06-27 16:02:33', '2023-06-27 08:02:32');
INSERT INTO `b_tags` VALUES (59, 'Dcoker', 0, 12, '2023-07-13 15:51:12', '2023-07-13 07:51:12');
INSERT INTO `b_tags` VALUES (60, 'Aspect', 0, 0, '2023-07-25 17:07:19', '2023-07-25 09:07:18');

-- ----------------------------
-- Table structure for b_user
-- ----------------------------
DROP TABLE IF EXISTS `b_user`;
CREATE TABLE `b_user`  (
  `id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录密码',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `status` int(10) NULL DEFAULT 1 COMMENT '状态 0:禁用 1:正常',
  `login_type` int(10) NULL DEFAULT NULL COMMENT '登录方式',
  `user_info_id` bigint(10) NULL DEFAULT NULL COMMENT '用户详情id',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色id',
  `ip_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `ip_source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录系统',
  `last_login_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后登录时间',
  `browser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统管理-用户基础信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_user
-- ----------------------------
INSERT INTO `b_user` VALUES ('1', 'admin', 'NLJ3Gidivf3vouOjYLIvuA==', '2021-09-27 15:43:45', '2022-03-10 17:59:40', 1, 1, 1, 1, '183.214.109.163', '中国-湖南省-长沙市', 'Windows 10', '2023-08-11 00:24:08', 'Chrome 11');
INSERT INTO `b_user` VALUES ('15', 'test', 'NLJ3Gidivf3vouOjYLIvuA==', '2021-11-14 12:35:03', '2022-12-13 14:08:33', 1, 1, 2, 5, '171.221.43.99', '中国-四川省-成都市', 'Windows 10', '2023-08-14 15:55:55', 'Chrome 11');

-- ----------------------------
-- Table structure for b_user_info
-- ----------------------------
DROP TABLE IF EXISTS `b_user_info`;
CREATE TABLE `b_user_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱号',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `avatar` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户头像',
  `intro` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户简介',
  `web_site` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人网站',
  `is_disable` int(1) NOT NULL DEFAULT 1 COMMENT '是否禁用',
  `bj_cover` varchar(255) DEFAULT NULL COMMENT '个人中心背景图',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1140 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_user_info
-- ----------------------------
INSERT INTO `b_user_info` VALUES (1, 'shiyi@blog.com', '拾壹', 'http://img.shiyit.com/chihuo.png', '努力努力再努力', 'www.shiyit.com', 1, NULL, '2023-07-11 16:10:08');
INSERT INTO `b_user_info` VALUES (2, 'test', '演示账号', 'http://img.shiyit.com/1645512111007.png', NULL, NULL, 1, NULL, '2023-06-12 09:50:23');

-- ----------------------------
-- Table structure for b_user_log
-- ----------------------------
DROP TABLE IF EXISTS `b_user_log`;
CREATE TABLE `b_user_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '操作用户ID',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作地址',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作类型',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作日志',
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作模块',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '操作时间',
  `result` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作结果',
  `access_os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `client_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 264606 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_user_log
-- ----------------------------

-- ----------------------------
-- Table structure for b_user_medal
-- ----------------------------
DROP TABLE IF EXISTS `b_user_medal`;
CREATE TABLE `b_user_medal`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户id',
  `medal_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '勋章id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '获取时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 503 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_user_medal
-- ----------------------------
INSERT INTO `b_user_medal` VALUES (1, '1', '1', '2023-07-21 10:05:46');
INSERT INTO `b_user_medal` VALUES (2, '929', '2', '2023-07-21 10:06:02');
INSERT INTO `b_user_medal` VALUES (403, '927', '2', '2023-06-08 16:03:15');
INSERT INTO `b_user_medal` VALUES (404, '930', '2', '2023-06-08 20:37:49');
INSERT INTO `b_user_medal` VALUES (405, '931', '2', '2023-06-08 20:39:40');
INSERT INTO `b_user_medal` VALUES (406, '932', '2', '2023-06-08 22:39:22');
INSERT INTO `b_user_medal` VALUES (407, '933', '2', '2023-06-08 22:58:30');
INSERT INTO `b_user_medal` VALUES (408, '934', '2', '2023-06-09 10:30:19');
INSERT INTO `b_user_medal` VALUES (409, '935', '2', '2023-06-09 11:00:09');
INSERT INTO `b_user_medal` VALUES (410, '936', '2', '2023-06-09 14:23:00');
INSERT INTO `b_user_medal` VALUES (411, '937', '2', '2023-06-09 16:46:40');
INSERT INTO `b_user_medal` VALUES (412, '938', '2', '2023-06-09 16:51:03');
INSERT INTO `b_user_medal` VALUES (413, '939', '2', '2023-06-09 19:08:52');
INSERT INTO `b_user_medal` VALUES (414, '7698f8d9308765444d2120d2cce49de1', '2', '2023-06-09 22:32:22');
INSERT INTO `b_user_medal` VALUES (415, '941', '2', '2023-06-10 13:03:15');
INSERT INTO `b_user_medal` VALUES (416, '942', '2', '2023-06-10 15:40:53');
INSERT INTO `b_user_medal` VALUES (417, '943', '2', '2023-06-10 22:00:22');
INSERT INTO `b_user_medal` VALUES (418, '944', '2', '2023-06-11 16:26:00');
INSERT INTO `b_user_medal` VALUES (419, '945', '2', '2023-06-12 09:00:29');
INSERT INTO `b_user_medal` VALUES (420, '946', '2', '2023-06-12 09:53:08');
INSERT INTO `b_user_medal` VALUES (421, 'aec06919a4c188e6a0b72a2245a3fb49', '2', '2023-06-12 12:11:15');
INSERT INTO `b_user_medal` VALUES (422, '7698f8d9308765444d2f50d2cce49de1', '2', '2023-06-12 14:55:59');
INSERT INTO `b_user_medal` VALUES (423, '009e0a2a476ffb7365b8912e7606170c', '2', '2023-06-12 16:27:02');
INSERT INTO `b_user_medal` VALUES (424, '9977e3e8f25755fdc08685d7a64d7bc6', '2', '2023-06-12 17:18:32');
INSERT INTO `b_user_medal` VALUES (425, 'f82d94a60163f81ef9663f40a0c16fc5', '2', '2023-06-12 17:29:56');
INSERT INTO `b_user_medal` VALUES (426, '19d10fcf3c001389ece110848be4b5ad', '2', '2023-06-13 15:41:14');
INSERT INTO `b_user_medal` VALUES (427, 'fc137a2ce36487bbdb9b2f6588a4b16e', '2', '2023-06-13 17:26:44');
INSERT INTO `b_user_medal` VALUES (428, 'd1a5750cba48a84a96c2d87a7c33fdcd', '2', '2023-06-13 20:50:32');
INSERT INTO `b_user_medal` VALUES (429, '89bf71d1eb32076ee33993cd0477cc85', '2', '2023-06-13 22:48:43');
INSERT INTO `b_user_medal` VALUES (430, 'c1abc6d04c29ab64a6e28ffcd599f851', '2', '2023-06-13 23:07:15');
INSERT INTO `b_user_medal` VALUES (431, '27fb199257d247885092a134532ca1fb', '2', '2023-06-14 20:33:29');
INSERT INTO `b_user_medal` VALUES (432, '679bc441d9a92fb2f06d9771fa0a5814', '2', '2023-06-15 10:02:38');
INSERT INTO `b_user_medal` VALUES (433, '039f94b579d65c2b1677cd54f1d4bb04', '2', '2023-06-15 12:10:26');
INSERT INTO `b_user_medal` VALUES (434, '96b54cbabf3e18c4d1580d5164e8bbb1', '2', '2023-06-15 17:44:25');
INSERT INTO `b_user_medal` VALUES (435, '8bded79c820cd49dc07bcd41f4d79c71', '2', '2023-06-15 18:38:26');
INSERT INTO `b_user_medal` VALUES (436, 'c933e51a14f7ff6c00c1d8de9305fae2', '2', '2023-06-15 22:33:48');
INSERT INTO `b_user_medal` VALUES (437, 'd2d11dfd3736660835b31e85fa8e34e9', '2', '2023-06-16 11:19:25');
INSERT INTO `b_user_medal` VALUES (438, '27ee2501ffe88c03b0c1d39846428917', '2', '2023-06-17 15:59:04');
INSERT INTO `b_user_medal` VALUES (439, '18728115403dcb2d2c9e097834edc0cf', '2', '2023-06-17 17:38:16');
INSERT INTO `b_user_medal` VALUES (440, '68f825b622bcb42bf3cc7b950ba9b7c8', '2', '2023-06-17 19:38:18');
INSERT INTO `b_user_medal` VALUES (441, '25e13b555ad21b0e4eb7fd844c90fc20', '2', '2023-06-17 22:30:53');
INSERT INTO `b_user_medal` VALUES (442, 'c7c073f732599d6af963f3bc90f378ea', '2', '2023-06-17 22:51:19');
INSERT INTO `b_user_medal` VALUES (443, '2316dbb76c3a67f5bfffaad07a190787', '2', '2023-06-18 09:26:48');
INSERT INTO `b_user_medal` VALUES (444, '650b2561860791bf48c9e885fe835aff', '2', '2023-06-18 14:32:36');
INSERT INTO `b_user_medal` VALUES (445, 'c66883b62b22c821dc2b3b948a1c213a', '2', '2023-06-18 20:30:23');
INSERT INTO `b_user_medal` VALUES (446, '8b12417691410605836209e8b98037d7', '2', '2023-06-19 01:30:48');
INSERT INTO `b_user_medal` VALUES (447, '785e478c5fb63157beb1d389b111a157', '2', '2023-06-19 09:51:45');
INSERT INTO `b_user_medal` VALUES (448, '66f627aa4957f0e5588522e8265e685d', '2', '2023-06-19 09:53:30');
INSERT INTO `b_user_medal` VALUES (449, 'c8a023c6d373d68c4615f52de79340ee', '2', '2023-06-19 15:16:56');
INSERT INTO `b_user_medal` VALUES (450, '340e096cc89d5a22d2c648bee352d9b6', '2', '2023-06-19 15:22:19');
INSERT INTO `b_user_medal` VALUES (451, '393d8433a1550f43a2f9446e0eabf806', '2', '2023-06-20 13:33:29');
INSERT INTO `b_user_medal` VALUES (452, '2b6984d7b244822365d586463e9f9f40', '2', '2023-06-20 17:18:45');
INSERT INTO `b_user_medal` VALUES (453, 'c133947a34d41c3bdce11ae56c4b1a31', '2', '2023-06-20 22:03:18');
INSERT INTO `b_user_medal` VALUES (454, 'db76ffba188cc1d5bd70f8c9b1934173', '2', '2023-06-21 10:37:12');
INSERT INTO `b_user_medal` VALUES (455, 'f4bb89c7b85fecec0f32e861e13b7439', '2', '2023-06-21 11:10:32');
INSERT INTO `b_user_medal` VALUES (456, '6a1a69a1122b79e645e620e69f8666bb', '2', '2023-06-21 14:55:32');
INSERT INTO `b_user_medal` VALUES (457, 'a3374b46abbbf5a3f6f910f714973e52', '2', '2023-06-21 15:11:17');
INSERT INTO `b_user_medal` VALUES (458, 'f8bc4eceb7146536580a67354d161966', '2', '2023-06-21 23:06:49');
INSERT INTO `b_user_medal` VALUES (459, '615a9624126d496fb187b73199c0caac', '2', '2023-06-22 01:38:55');
INSERT INTO `b_user_medal` VALUES (460, 'fe8301891b40ff3645ddf0233783d3a7', '2', '2023-06-23 09:19:43');
INSERT INTO `b_user_medal` VALUES (461, 'e2a7905c05e3b0b337774e43af6b4ef0', '2', '2023-06-25 09:44:51');
INSERT INTO `b_user_medal` VALUES (462, '0bf074b63c5548efe89bca817697919b', '2', '2023-06-25 13:46:35');
INSERT INTO `b_user_medal` VALUES (463, 'd5fc59663b9767b057019e06340f0114', '2', '2023-06-26 21:38:57');
INSERT INTO `b_user_medal` VALUES (464, '3864ca75648af72a74b291ed9c74a313', '2', '2023-06-26 23:17:30');
INSERT INTO `b_user_medal` VALUES (465, '2dd97c307ae6b6ae20d1cdae164e5a24', '2', '2023-06-27 22:22:35');
INSERT INTO `b_user_medal` VALUES (466, '260337a6a428863034fd3c2395ee387e', '2', '2023-06-27 23:19:54');
INSERT INTO `b_user_medal` VALUES (467, '39a688eaebfe17bdbaa50b30b03c0fe9', '2', '2023-06-28 15:02:25');
INSERT INTO `b_user_medal` VALUES (468, 'd5c7f1af42b996602314ae36628fc0c7', '2', '2023-06-28 16:15:50');
INSERT INTO `b_user_medal` VALUES (469, '7819c0ee4a5928ac48a9f0b626da13db', '2', '2023-06-28 16:38:20');
INSERT INTO `b_user_medal` VALUES (470, '5a619ed7bf3021604ab89a04f7eda918', '2', '2023-06-29 11:39:35');
INSERT INTO `b_user_medal` VALUES (471, 'd0c904e14c812911d0a3754a4240321a', '2', '2023-06-29 15:09:44');
INSERT INTO `b_user_medal` VALUES (472, 'dd69f5db201dffc913a4aa88b0e5660f', '2', '2023-06-29 18:04:27');
INSERT INTO `b_user_medal` VALUES (473, 'ff0b1fea32c5d1216f927f401eede347', '2', '2023-06-29 19:38:27');
INSERT INTO `b_user_medal` VALUES (474, '032785b636f5eef2f1e2b69c23eec123', '2', '2023-06-29 19:59:29');
INSERT INTO `b_user_medal` VALUES (475, '1937488cbb2d1a70c3bb286cab1a7992', '2', '2023-06-29 21:19:02');
INSERT INTO `b_user_medal` VALUES (476, 'b8eb692952b8f2663c0f960ae0b778e4', '2', '2023-06-29 22:01:32');
INSERT INTO `b_user_medal` VALUES (477, 'a8fe315ff32ce4c0e631ef7c102f7e6b', '2', '2023-06-30 15:48:14');
INSERT INTO `b_user_medal` VALUES (478, 'a49ded846d22280b73492d413bf24d96', '2', '2023-07-01 09:12:03');
INSERT INTO `b_user_medal` VALUES (479, '455e9916956b14f05c4ef420233f6bb2', '2', '2023-07-01 19:03:32');
INSERT INTO `b_user_medal` VALUES (480, '6a0786064af2fe9a6cf82f0d5e2c81e1', '2', '2023-07-02 16:33:08');
INSERT INTO `b_user_medal` VALUES (481, 'e3e83979e8698e0626ff4536b0aef8d4', '2', '2023-07-02 16:44:14');
INSERT INTO `b_user_medal` VALUES (482, '3b171eddf6d980b7e1af31a5f59a9bce', '2', '2023-07-02 20:09:57');
INSERT INTO `b_user_medal` VALUES (483, 'b9ee320bea8cc666e49eefdb52014d6a', '2', '2023-07-02 21:29:41');
INSERT INTO `b_user_medal` VALUES (484, 'a21f007d32e7cb66d6059a81b8bf33e4', '2', '2023-07-03 01:11:06');
INSERT INTO `b_user_medal` VALUES (485, '57020cc3c23f4e270400e4d684b62a0d', '2', '2023-07-03 11:03:07');
INSERT INTO `b_user_medal` VALUES (486, '9e115f65ecbc5f24b9357464d917a51f', '2', '2023-07-03 12:59:33');
INSERT INTO `b_user_medal` VALUES (487, '43b0e81da9b946618cd76714a38c8c5b', '2', '2023-07-03 18:02:06');
INSERT INTO `b_user_medal` VALUES (488, '445bc0870594a456e72ee8688fac51cd', '2', '2023-07-03 22:05:43');
INSERT INTO `b_user_medal` VALUES (489, '7cb9a164e7c8010cb892bd91c7f866ce', '2', '2023-07-03 22:21:38');
INSERT INTO `b_user_medal` VALUES (490, '0c55e8f776a869cc23b06ed7679036ce', '2', '2023-07-03 22:58:48');
INSERT INTO `b_user_medal` VALUES (491, '8bc5d2d859430a6b4bf126c23073415a', '2', '2023-07-04 12:39:12');
INSERT INTO `b_user_medal` VALUES (492, '89b8f7845bfaac9e8ea26d2628edb16c', '2', '2023-07-04 19:17:55');
INSERT INTO `b_user_medal` VALUES (493, '50d7518c5a7aa9b50f0ba75b8c1639fa', '2', '2023-07-05 11:05:56');
INSERT INTO `b_user_medal` VALUES (494, '46b788187561d8d41cf55836d587d1d9', '2', '2023-07-05 12:03:09');
INSERT INTO `b_user_medal` VALUES (495, '012008d5b798c3574b962ce60746b961', '2', '2023-07-05 12:49:30');
INSERT INTO `b_user_medal` VALUES (496, '8672f29cbc56b58b39cfecb8f78d3d24', '2', '2023-07-05 14:03:57');
INSERT INTO `b_user_medal` VALUES (497, '274ea6a35c17c1fb08d8ebb28d979a4d', '2', '2023-07-05 14:46:17');
INSERT INTO `b_user_medal` VALUES (498, '968fd4ea43d15bed0ad4b753c0637c08', '2', '2023-07-05 15:19:35');
INSERT INTO `b_user_medal` VALUES (499, 'b1baa682ce4b627550c2e1e3d4484574', '2', '2023-07-05 16:10:11');
INSERT INTO `b_user_medal` VALUES (500, 'e92f968f915fb46463ba1181d207e0ae', '2', '2023-07-05 17:20:47');
INSERT INTO `b_user_medal` VALUES (501, 'c4052b72c56e1d8430285cc98edc8a33', '2', '2023-07-05 20:06:36');
INSERT INTO `b_user_medal` VALUES (502, '145b318a4f221ab6a703e736a1a043d0', '2', '2023-07-05 20:47:06');

-- ----------------------------
-- Table structure for b_user_prop
-- ----------------------------
DROP TABLE IF EXISTS `b_user_prop`;
CREATE TABLE `b_user_prop`  (
  `id` int(11) NOT NULL COMMENT 'id',
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户id',
  `prop_id` int(11) NULL DEFAULT NULL COMMENT '道具id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '获取时间',
  `num` int(11) NULL DEFAULT NULL COMMENT '持有数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_user_prop
-- ----------------------------
INSERT INTO `b_user_prop` VALUES (1, '1', 1, '2023-07-14 15:51:35', 57);

-- ----------------------------
-- Table structure for b_user_role
-- ----------------------------
DROP TABLE IF EXISTS `b_user_role`;
CREATE TABLE `b_user_role`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(10) NULL DEFAULT NULL COMMENT '角色ID',
  `user_id` int(10) NULL DEFAULT NULL COMMENT '用户ID',
  `created_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `last_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统管理 - 用户角色关联表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_user_role
-- ----------------------------
INSERT INTO `b_user_role` VALUES (12, 1, 1, '2019-08-21 10:49:41', '2019-08-21 10:49:41');
INSERT INTO `b_user_role` VALUES (34, 5, 15, '2021-11-14 12:35:03', '2021-11-14 12:35:03');

-- ----------------------------
-- Table structure for b_web_config
-- ----------------------------
DROP TABLE IF EXISTS `b_web_config`;
CREATE TABLE `b_web_config`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'logo(文件UID)',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网站名称',
  `summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '介绍',
  `keyword` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关键字',
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `record_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备案号',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `web_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网站地址',
  `ali_pay` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付宝收款码FileId',
  `weixin_pay` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信收款码FileId',
  `github` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'github地址',
  `gitee` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'gitee地址',
  `qq_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'QQ号',
  `qq_group` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'QQ群',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `wechat` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信',
  `show_list` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '显示的列表（用于控制邮箱、QQ、QQ群、Github、Gitee、微信是否显示在前端）',
  `login_type_list` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录方式列表（用于控制前端登录方式，如账号密码,码云,Github,QQ,微信）',
  `open_comment` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否开启评论(0:否 1:是)',
  `open_admiration` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否开启赞赏(0:否， 1:是)',
  `tourist_avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游客头像',
  `bulletin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公告',
  `author_info` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者简介',
  `author_avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者头像',
  `about_me` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '关于我',
  `is_music_player` int(10) NULL DEFAULT 0 COMMENT '是否开启音乐播放器',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '网站配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_web_config
-- ----------------------------
INSERT INTO `b_web_config` VALUES (1, 'http://img.shiyit.com/logo-ico.png', '拾壹博客', '一个专注技术分享的平台', '拾壹,拾壹博客', '拾壹', '湘ICP备2022002110号-1', '2021-11-27 13:43:16', '2022-01-20 13:30:44', 'http://www.shiyit.com', 'http://img.shiyit.com/alipay.jpg', '\r\nhttp://img.shiyit.com/wxpay.jpg', 'https://github.com/quequnlong', 'https://gitee.com/quequnlong', '1248954763', '779881756', '1248954763@qq.com', '1248954763', '1,3,4,2,5,6', '1,2,5,6,4', '1', 1, 'http://img.shiyit.com/66bb121d47e94b89945d29bb6e3e6cab.jpg', '如果本项目对你有帮助，请前往码云给仓库点上你的小星星', '正在努力搬砖~~~~', 'http://img.shiyit.com/chihuo.png', '#### 关于我\n拾壹是一个并非科班的java博主，目前正在努力学习Java和前端技术\n\n#### 源码\n目前博客源码已经开源至[码云](https://gitee.com/quequnlong/shiyi-blog)，感兴趣的小伙伴可以star fork关注一下下~\nGitee地址：[https://gitee.com/quequnlong/shiyi-blog](https://gitee.com/quequnlong/shiyi-blog)\n#### 项目框架\n前端使用了vue+elmentui，可以使小伙伴们能够更加容易得进行扩展\n后端使用的springboot框架\n本项目UI部分借鉴于[蘑菇博客](https://gitee.com/moxi159753/mogu_blog_v2)\n\n\n\n\n\n', 0);

SET FOREIGN_KEY_CHECKS = 1;
