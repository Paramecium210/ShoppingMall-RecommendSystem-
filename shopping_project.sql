/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50722 (5.7.22-log)
 Source Host           : localhost:3306
 Source Schema         : shopping_project

 Target Server Type    : MySQL
 Target Server Version : 50722 (5.7.22-log)
 File Encoding         : 65001

 Date: 10/09/2025 18:40:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NULL DEFAULT NULL COMMENT 'userID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'userName',
  `useraddress` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'userAddress',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Phone',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '地址信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (2, 1, 'Wiliam', 'Tokyo4564', '123459787');
INSERT INTO `address` VALUES (3, 7, 'Jam', 'Shinjuku46879', '79845642312');
INSERT INTO `address` VALUES (4, 9, 'Gary', 'Beijing123', '123465464');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', 'ADMIN', 'http://localhost:9090/files/1756554842017-wallhaven-e7w5zl.jpg', 'ADMIN', '13677889922', 'admin@xm.com');
INSERT INTO `admin` VALUES (2, '123', '123', '123', 'http://localhost:9090/files/1756598484038-电脑.png', 'ADMIN', '123', '123');

-- ----------------------------
-- Table structure for business
-- ----------------------------
DROP TABLE IF EXISTS `business`;
CREATE TABLE `business`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '店铺名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商家介绍',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '商家信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of business
-- ----------------------------
INSERT INTO `business` VALUES (3, 'Meshe', '123', 'ifashionddd', 'http://localhost:9090/files/1756604068987-wallhaven-e76vo8.png', 'BUSINESS', '132564897', 'Meshe@mail.com', '始建于1987年，一家传统老店', 'CHECK_OK');
INSERT INTO `business` VALUES (4, 'ME', '123', 'ime', 'http://localhost:9090/files/1756604389116-wallhaven-e7w5zl.jpg', 'BUSINESS', '124654879784', 'wjfoi@mail.com', '非常好店铺啊，值得你们来啊，推荐一波', 'CHECK_NO');
INSERT INTO `business` VALUES (5, 'fhla.123', '123', 'fhla.123', 'http://localhost:9090/files/1756612373270-OIP-C.jpg', 'BUSINESS', '12348979845', 'fhla.123@mail.com', 'wfwwgwgwgwgwgwgw', 'CHECK_OK');
INSERT INTO `business` VALUES (6, 'wef', '123', 'wefwef789', NULL, 'BUSINESS', NULL, NULL, NULL, 'CHECK_OK');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NULL DEFAULT NULL COMMENT '用户ID',
  `goods_id` int(10) NULL DEFAULT NULL COMMENT '商品ID',
  `business_id` int(10) NULL DEFAULT NULL COMMENT '店铺ID',
  `num` int(10) NULL DEFAULT NULL COMMENT '商品数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '购物车表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (18, 9, 6, 3, 1);
INSERT INTO `cart` VALUES (19, 9, 7, 3, 1);
INSERT INTO `cart` VALUES (23, 8, 2, 5, 1);
INSERT INTO `cart` VALUES (25, 8, 6, 3, 1);
INSERT INTO `cart` VALUES (26, 5, 12, 5, 1);

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `goods_id` int(10) NULL DEFAULT NULL COMMENT '商品ID',
  `business_id` int(10) NULL DEFAULT NULL COMMENT '店铺ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '收藏信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES (16, 9, 6, 3);
INSERT INTO `collect` VALUES (17, 9, 7, 3);
INSERT INTO `collect` VALUES (19, 8, 2, 5);
INSERT INTO `collect` VALUES (20, 8, 7, 3);
INSERT INTO `collect` VALUES (21, 8, 4, 4);
INSERT INTO `collect` VALUES (22, 5, 10, 5);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NULL DEFAULT NULL COMMENT 'userID\r\n',
  `goods_id` int(10) NULL DEFAULT NULL COMMENT 'goodsID',
  `business_id` int(10) NULL DEFAULT NULL COMMENT 'businessID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'content',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'time',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'name',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'img',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT 'description',
  `price` double(10, 2) NULL DEFAULT NULL COMMENT 'price',
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'unit',
  `count` int(10) NULL DEFAULT NULL COMMENT 'count',
  `type_id` int(10) NULL DEFAULT NULL COMMENT 'type_id',
  `business_id` int(10) NULL DEFAULT NULL COMMENT 'business_id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '商品信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (2, 'Hamburger', 'http://localhost:9090/files/1756628773067-下载 (1).jpg', NULL, 456.00, 'set', 0, 9, 5);
INSERT INTO `goods` VALUES (4, 'Jeans', 'http://localhost:9090/files/1757141592197-无标题.jpg', NULL, 89.00, 'cloth', 0, 15, 4);
INSERT INTO `goods` VALUES (5, 'Orange tea', 'http://localhost:9090/files/1757407444544-carousel_top.jpg', NULL, 120.00, 'box', 0, 9, 3);
INSERT INTO `goods` VALUES (6, 'Fanta', 'http://localhost:9090/files/1757407500989-home_carousel2.jpg', NULL, 50.00, 'case', 0, 9, 3);
INSERT INTO `goods` VALUES (7, 'Lay\'s', 'http://localhost:9090/files/1757407521445-home_carousel3.jpg', NULL, 10.00, 'bag', 0, 9, 3);
INSERT INTO `goods` VALUES (8, 'shower gel', 'http://localhost:9090/files/1757491491611-home_carousel1.jpg', NULL, 48.00, 'bottle', 0, 3, 5);
INSERT INTO `goods` VALUES (9, 'apple tea', 'http://localhost:9090/files/1757491595925-carousel_top2.jpg', NULL, 120.00, 'box', 0, 9, 5);
INSERT INTO `goods` VALUES (10, 'lemon tea', 'http://localhost:9090/files/1757491622699-carousel_top3.jpg', NULL, 120.00, 'box', 0, 9, 5);
INSERT INTO `goods` VALUES (11, 'lipstick', 'http://localhost:9090/files/1757491731185-bg.jpg', NULL, 500.00, 'stick', 0, 3, 5);
INSERT INTO `goods` VALUES (12, 'boots', 'http://localhost:9090/files/1757491855166-shoes.jpg', NULL, 50.00, 'pair', 0, 15, 5);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公告信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, 'What a nice day', 'What a nice day', '2025-09-05', 'admin');
INSERT INTO `notice` VALUES (2, '一緒に散歩しましょう', '一緒に散歩しましょう', '2025-09-05', 'admin');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `orders_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `goods_id` int(11) NULL DEFAULT NULL,
  `business_id` int(11) NULL DEFAULT NULL,
  `num` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `price` double(10, 2) NULL DEFAULT NULL,
  `address_id` int(11) NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '订单信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类描述',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES (1, 'Books', '图书音像', 'http://localhost:9090/files/1756594145325-图书音像.png');
INSERT INTO `type` VALUES (2, 'Kitchenware', '厨具', 'http://localhost:9090/files/1756594226252-居家.png');
INSERT INTO `type` VALUES (3, 'Medicine', '医药', 'http://localhost:9090/files/1756594242989-医药保健.png');
INSERT INTO `type` VALUES (4, 'Home Textiles', '家纺', 'http://localhost:9090/files/1756594266297-家纺家饰.png');
INSERT INTO `type` VALUES (5, 'Auto Parts', '汽车配件', 'http://localhost:9090/files/1756594282428-汽车配件.png');
INSERT INTO `type` VALUES (6, 'Furniture', '家具', 'http://localhost:9090/files/1756594312912-家具建材.png');
INSERT INTO `type` VALUES (7, 'Daily Necessities', '生活用品', 'http://localhost:9090/files/1756594340927-家用电器.png');
INSERT INTO `type` VALUES (8, 'Fruits', '水果生鲜', 'http://localhost:9090/files/1756594365712-喵鲜生.png');
INSERT INTO `type` VALUES (9, 'Foods', '食品', 'http://localhost:9090/files/1756594383212-食品.png');
INSERT INTO `type` VALUES (10, 'Maternal and Baby Products', '母婴用品', 'http://localhost:9090/files/1756594406070-母婴玩具.png');
INSERT INTO `type` VALUES (11, 'Digital Products', '数码产品', 'http://localhost:9090/files/1756594427383-数码手机.png');
INSERT INTO `type` VALUES (12, 'Office Electronics', '电子办公', 'http://localhost:9090/files/1756594456098-电脑.png');
INSERT INTO `type` VALUES (13, 'Jewellery', '珠宝', 'http://localhost:9090/files/1756594478165-珠宝饰品.png');
INSERT INTO `type` VALUES (14, 'Bags And Suitcases', '箱包', 'http://localhost:9090/files/1756594500622-鞋_箱包.png');
INSERT INTO `type` VALUES (15, 'Menswear', '男装', 'http://localhost:9090/files/1756594522574-男装.png');
INSERT INTO `type` VALUES (16, 'Womenswear', '女装', 'http://localhost:9090/files/1756594535326-女装内衣.png');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'handsome', '123', 'guy', 'http://localhost:9090/files/1756620077405-下载.jpg', 'USER', '231546', 'booy@mail.com');
INSERT INTO `user` VALUES (7, 'papa', '123', 'Yumeu55', 'http://localhost:9090/files/1756618835042-下载 (1).jpg', 'USER', '123456897', 'oarao@mail.com');
INSERT INTO `user` VALUES (8, 'lisa', '123', 'lisa', NULL, 'USER', NULL, NULL);
INSERT INTO `user` VALUES (9, 'Gary', '123', 'Gary', 'http://localhost:9090/files/1757408064194-bg.png', 'USER', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
