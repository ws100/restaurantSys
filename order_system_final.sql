/*
 Navicat Premium Data Transfer

 Source Server         : tx
 Source Server Type    : MySQL
 Source Server Version : 50739
 Source Host           : 127.0.0.1:3306
 Source Schema         : order_system

 Target Server Type    : MySQL
 Target Server Version : 50739
 File Encoding         : 65001

 Date: 29/06/2023 13:02:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for food
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food`  (
  `Food_id` int(11) NOT NULL COMMENT '菜品编号',
  `Food_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜品名称',
  `Food_typeid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜品类型',
  `Food_price` int(11) NOT NULL COMMENT '菜品价格',
  `Food_discription` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Food_img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Food_sale` int(11) NOT NULL,
  PRIMARY KEY (`Food_id`) USING BTREE,
  UNIQUE INDEX `food_id_index`(`Food_id`) USING BTREE COMMENT 'food_id索引'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of food
-- ----------------------------
INSERT INTO `food` VALUES (1, '回锅肉', '川菜', 69, '回锅肉：四川特色美食，猪肉煸炒配青椒和豆瓣酱。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/168783872040663887.jpg', 2);
INSERT INTO `food` VALUES (2, '夫妻肺片', 'shabi ', 78, '传统川菜，薄切牛肉拌菜花，豆芽等佐以辣椒油、花椒和其他调料制作。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/168797484700952112.jpg', 1);
INSERT INTO `food` VALUES (3, '宫保鸡丁', '川菜', 58, '宫保鸡丁是一道传统川菜，口味辣酸甜咸，香味浓郁，鸡肉鲜嫩可口，搭配花生豆角，口感丰富。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/168781225473880712.jpg', 1);
INSERT INTO `food` VALUES (4, '鱼香肉丝', '川菜', 38, '鱼香肉丝是一道四川名菜，口味酸甜辣，肉丝嫩爽。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/168783882270844112.jpg', 1);
INSERT INTO `food` VALUES (5, '水煮牛肉', '川菜', 68, '口感麻辣，肉质鲜嫩，是四川传统美食之一。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/168797482309655828.png', 0);
INSERT INTO `food` VALUES (6, '东坡肘子', '川菜', 88, '东坡肘子：猪肘加工砂糖酱油卤煮，风味独特，口感丰富。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/168781228378240159.jpg', 0);
INSERT INTO `food` VALUES (7, '锅贴鱼', '湘菜', 88, '煎炸食材，脆香带汁，口感极佳的一道传统美食。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/168781232104218730.jpg', 0);
INSERT INTO `food` VALUES (8, '三色百叶', '湘菜', 70, '油炸配料三味俱全，中式经典小吃之一。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/sansebaiye.jpg', 0);
INSERT INTO `food` VALUES (9, '湘西酸肉', '湘菜', 68, '湖南特色酸辣味道，五花肉卤煮，口感鲜美有嚼劲。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/xiangxisuanrou.jpg', 0);
INSERT INTO `food` VALUES (10, '麻辣子鸡', '湘菜', 78, '麻辣鸡肉配滑嫩土豆片，奇香脆口，辣而不失鲜美。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/168781232939832185.jpg', 2);
INSERT INTO `food` VALUES (11, '金鱼戏莲', '湘菜', 88, '淮扬名菜，色香味俱佳的传统菜肴。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/jinyuxilian.jpg', 2);
INSERT INTO `food` VALUES (12, '糖醋鲤鱼', '鲁菜', 88, '糖醋鲤鱼是一道香酥可口的传统菜肴。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/tangculiyu.jpg', 2);
INSERT INTO `food` VALUES (13, '三丝鱼翅', '鲁菜', 68, '鲜美细嫩，三丝爽口，鲍汁调味，超值美食。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/sansiyuchi.jpg', 0);
INSERT INTO `food` VALUES (14, '九转大肠', '鲁菜', 78, '浓香鲜辣，口感滋润，传统湖南名菜。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/jiuzhuandachang.jpg', 0);
INSERT INTO `food` VALUES (15, '油焖大虾', '鲁菜', 128, '香鲜可口的大虾，油闷煮至入味，鲜嫩多汁的口感。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/youmendaxia.jpg', 0);
INSERT INTO `food` VALUES (16, '醋椒鱼', '鲁菜', 99, '酸辣口感的热菜，以鱼肉和醋椒为主要食材，鲜香可口。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/cujiaoyu.jpg', 0);
INSERT INTO `food` VALUES (17, '白切鸡', '粤菜', 69, '白切鸡是一道流行于南方地区的热菜，以白净鸡肉和特制酱料为主要特点。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/baiqieji.jpg', 0);
INSERT INTO `food` VALUES (18, '烧鹅', '粤菜', 38, '烤制鹅肉，香味浓郁。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/shaoe.jpg', 0);
INSERT INTO `food` VALUES (19, '烤乳猪', '粤菜', 148, '传统中华美食，用整只乳猪经过特制烤制而成。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/kaoruzhu.jpg', 0);
INSERT INTO `food` VALUES (20, '蜜汁叉烧', '粤菜', 65, '香甜糯滑，口感嫩香，特色美食', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/mizhichashao.jpg', 1);
INSERT INTO `food` VALUES (21, '金陵烤鸭', '江苏菜', 58, '传统南京特色烤鸭，香酥可口，皮脆肉嫩。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/jinlingkaoya.jpg', 0);
INSERT INTO `food` VALUES (22, '凤尾虾', '江苏菜', 118, '炸制海鲜美食，以虾形态呈现出一只凤尾的形象。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/fengweixia.jpg', 1);
INSERT INTO `food` VALUES (23, '无锡肉骨头', '江苏菜', 128, '经典本帮菜，鲜美肥而不腻，细嚼可口。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/wuxirougutou.jpg', 0);
INSERT INTO `food` VALUES (24, '福州鱼丸', '闽菜', 38, '福州特色小吃，以鱼肉为主要原料，口感弹香，颇受欢迎。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/fuzhouyuwan.jpg', 0);
INSERT INTO `food` VALUES (25, '沙县拌面', '闽菜', 28, '传统福建面食，面劲道，汤鲜美，配料丰富，独具特色。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/shaxianbanmian.jpg', 0);
INSERT INTO `food` VALUES (26, '兴化米粉', '闽菜', 18, '兴化米粉是江苏兴化传统名菜，口感细腻，清爽可口。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/xinghuamifen.jpg', 2);
INSERT INTO `food` VALUES (27, '龙身凤尾虾', '闽菜', 88, '地道江苏菜，以虾尾包裹龙身，口感鲜美。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/longshenfengweixia.jpg', 0);
INSERT INTO `food` VALUES (28, '金华火腿', '浙江菜', 48, '金华火腿是浙菜特色菜，口感咸鲜，独具风味。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/jinhuahuotui.jpg', 0);
INSERT INTO `food` VALUES (29, '安吉竹鸡', '浙江菜', 58, '竹林野味佳肴，嫩滑鲜香，品尝无穷乐趣。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/anjizhuji.jpg', 2);
INSERT INTO `food` VALUES (30, '火腿炖甲鱼', '徽菜', 128, '火腿炖甲鱼，口感鲜美，佐以火腿香味，清香适口。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/huotuidunjiayu.jpg', 0);
INSERT INTO `food` VALUES (31, '南湖对虾', '徽菜', 98, '口感鲜美、肉质细嫩、佐以特制酱汁，是特色海鲜美食之一。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/nanhuduixia.jpg', 0);
INSERT INTO `food` VALUES (32, '鱼咬羊', '徽菜', 168, '鲜嫩羊肉与鱼片搭配烹饪的鲜美佳肴。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/yuyaoyang.jpg', 0);
INSERT INTO `food` VALUES (33, '臭鳜鱼', '徽菜', 178, '臭鳜鱼是一道以鲜鳜鱼为主料，配以豆腐、泡菜等佐料制作的传统湘菜。', 'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/food/chouguiyu.jpg', 0);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `Order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `Order_price` float(8, 2) NOT NULL COMMENT '订单价格',
  `Order_time` datetime(2) NOT NULL COMMENT '订单时间',
  `Order_status` int(11) NOT NULL,
  `User_id` int(11) NOT NULL COMMENT '用户编号',
  `Comment_id` int(11) NOT NULL,
  PRIMARY KEY (`Order_id`) USING BTREE,
  UNIQUE INDEX `order_id_index`(`Order_id`) USING BTREE,
  INDEX `user_id_index`(`User_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, 180.00, '2023-06-15 17:12:26.00', 3, 1, 8);
INSERT INTO `order` VALUES (2, 190.00, '2023-06-23 17:17:19.00', 3, 1, 7);
INSERT INTO `order` VALUES (8, 312.00, '2023-06-24 18:19:16.00', 3, 1, 5);
INSERT INTO `order` VALUES (9, 468.00, '2023-06-24 18:35:26.00', 3, 1, 4);
INSERT INTO `order` VALUES (10, 476.00, '2023-06-24 18:53:13.00', 3, 1, 3);
INSERT INTO `order` VALUES (11, 3828.00, '2023-06-24 19:07:32.00', 3, 1, 1);
INSERT INTO `order` VALUES (12, 410.00, '2023-06-24 19:13:53.00', 3, 0, 0);
INSERT INTO `order` VALUES (13, 0.00, '2023-06-25 00:22:53.00', 3, 0, 0);
INSERT INTO `order` VALUES (14, 232.00, '2023-06-25 03:51:55.00', 4, 1, 0);
INSERT INTO `order` VALUES (15, 168.00, '2023-06-25 03:53:04.00', 4, 1, 0);
INSERT INTO `order` VALUES (16, 78.00, '2023-06-25 03:53:13.00', 3, 1, 6);
INSERT INTO `order` VALUES (17, 69.00, '2023-06-27 01:49:13.00', 3, 0, 0);
INSERT INTO `order` VALUES (18, 147.00, '2023-06-27 03:28:45.00', 3, 0, 0);
INSERT INTO `order` VALUES (19, 78.00, '2023-06-27 07:13:31.00', 3, 0, 0);
INSERT INTO `order` VALUES (20, 96.00, '2023-06-27 07:14:03.00', 3, 0, 0);
INSERT INTO `order` VALUES (21, 176.00, '2023-06-27 07:14:07.00', 3, 0, 0);
INSERT INTO `order` VALUES (22, 58.00, '2023-06-27 07:24:18.00', 3, 0, 0);
INSERT INTO `order` VALUES (23, 69.00, '2023-06-27 08:23:50.00', 3, 0, 0);
INSERT INTO `order` VALUES (24, 0.00, '2023-06-29 03:35:21.00', 3, 0, 0);
INSERT INTO `order` VALUES (25, 205.00, '2023-06-29 03:42:33.00', 3, 0, 0);
INSERT INTO `order` VALUES (26, 244.00, '2023-06-29 03:42:37.00', 4, 0, 0);
INSERT INTO `order` VALUES (27, 234.00, '2023-06-29 03:58:28.00', 2, 1, 0);
INSERT INTO `order` VALUES (28, 205.00, '2023-06-29 04:09:11.00', 3, 0, 0);
INSERT INTO `order` VALUES (29, 0.00, '2023-06-29 04:10:00.00', 4, 0, 0);
INSERT INTO `order` VALUES (30, 0.00, '2023-06-29 04:17:40.00', 2, 0, 0);
INSERT INTO `order` VALUES (31, 195.00, '2023-06-29 04:18:14.00', 2, 0, 0);
INSERT INTO `order` VALUES (32, 78.00, '2023-06-29 04:18:52.00', 3, 0, 0);
INSERT INTO `order` VALUES (33, 78.00, '2023-06-29 04:19:13.00', 4, 0, 0);
INSERT INTO `order` VALUES (34, 69.00, '2023-06-29 04:44:06.00', 3, 1, 9);

-- ----------------------------
-- Table structure for order_content
-- ----------------------------
DROP TABLE IF EXISTS `order_content`;
CREATE TABLE `order_content`  (
  `Order_id` int(11) NOT NULL,
  `Food_id` int(11) NOT NULL,
  `Food_number` int(11) NOT NULL,
  PRIMARY KEY (`Order_id`, `Food_id`) USING BTREE,
  INDEX `food_id_fk`(`Food_id`) USING BTREE,
  CONSTRAINT `food_id_fk` FOREIGN KEY (`Food_id`) REFERENCES `food` (`Food_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_id_fk` FOREIGN KEY (`Order_id`) REFERENCES `order` (`Order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_content
-- ----------------------------
INSERT INTO `order_content` VALUES (1, 2, 3);
INSERT INTO `order_content` VALUES (1, 4, 10);
INSERT INTO `order_content` VALUES (2, 2, 9);
INSERT INTO `order_content` VALUES (2, 3, 1);
INSERT INTO `order_content` VALUES (8, 2, 4);
INSERT INTO `order_content` VALUES (9, 2, 6);
INSERT INTO `order_content` VALUES (10, 1, 7);
INSERT INTO `order_content` VALUES (11, 1, 10);
INSERT INTO `order_content` VALUES (11, 2, 14);
INSERT INTO `order_content` VALUES (11, 3, 10);
INSERT INTO `order_content` VALUES (11, 4, 12);
INSERT INTO `order_content` VALUES (11, 5, 15);
INSERT INTO `order_content` VALUES (12, 3, 1);
INSERT INTO `order_content` VALUES (12, 4, 1);
INSERT INTO `order_content` VALUES (12, 5, 1);
INSERT INTO `order_content` VALUES (12, 6, 1);
INSERT INTO `order_content` VALUES (12, 7, 1);
INSERT INTO `order_content` VALUES (12, 8, 1);
INSERT INTO `order_content` VALUES (14, 3, 4);
INSERT INTO `order_content` VALUES (15, 2, 1);
INSERT INTO `order_content` VALUES (16, 2, 1);
INSERT INTO `order_content` VALUES (17, 1, 1);
INSERT INTO `order_content` VALUES (18, 1, 1);
INSERT INTO `order_content` VALUES (18, 2, 1);
INSERT INTO `order_content` VALUES (19, 2, 1);
INSERT INTO `order_content` VALUES (20, 3, 1);
INSERT INTO `order_content` VALUES (20, 4, 1);
INSERT INTO `order_content` VALUES (21, 6, 1);
INSERT INTO `order_content` VALUES (21, 7, 1);
INSERT INTO `order_content` VALUES (22, 3, 1);
INSERT INTO `order_content` VALUES (23, 1, 1);
INSERT INTO `order_content` VALUES (25, 1, 1);
INSERT INTO `order_content` VALUES (25, 2, 1);
INSERT INTO `order_content` VALUES (25, 3, 1);
INSERT INTO `order_content` VALUES (26, 5, 1);
INSERT INTO `order_content` VALUES (26, 6, 1);
INSERT INTO `order_content` VALUES (26, 7, 1);
INSERT INTO `order_content` VALUES (27, 2, 3);
INSERT INTO `order_content` VALUES (28, 1, 1);
INSERT INTO `order_content` VALUES (28, 2, 1);
INSERT INTO `order_content` VALUES (28, 3, 1);
INSERT INTO `order_content` VALUES (31, 1, 1);
INSERT INTO `order_content` VALUES (31, 2, 1);
INSERT INTO `order_content` VALUES (31, 28, 1);
INSERT INTO `order_content` VALUES (32, 2, 1);
INSERT INTO `order_content` VALUES (33, 2, 1);
INSERT INTO `order_content` VALUES (34, 1, 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `User_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `User_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `User_type` int(11) NULL DEFAULT NULL,
  `User_password` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  PRIMARY KEY (`User_id`) USING BTREE,
  UNIQUE INDEX `user_id_index`(`User_id`) USING BTREE,
  INDEX `user_name_index`(`User_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'www', 0, 'www');
INSERT INTO `user` VALUES (2, 'ws', 1, 'ws');
INSERT INTO `user` VALUES (11, 'wsww', 0, 'wsss');
INSERT INTO `user` VALUES (15, 'ws1', 0, 'ws');
INSERT INTO `user` VALUES (16, '111', 0, '111');
INSERT INTO `user` VALUES (17, '1112', 0, '111');
INSERT INTO `user` VALUES (18, '11122', 0, '111');
INSERT INTO `user` VALUES (19, '111223', 0, '111');
INSERT INTO `user` VALUES (20, '111s', 0, '111');
INSERT INTO `user` VALUES (21, 'FANG', 0, 'FANG');

-- ----------------------------
-- Table structure for user_comment
-- ----------------------------
DROP TABLE IF EXISTS `user_comment`;
CREATE TABLE `user_comment`  (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_star` int(11) NULL DEFAULT NULL,
  `comment_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`comment_id`) USING BTREE,
  UNIQUE INDEX `user_comment_index`(`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_comment
-- ----------------------------
INSERT INTO `user_comment` VALUES (1, 5, '未评论');
INSERT INTO `user_comment` VALUES (2, 0, ' ');
INSERT INTO `user_comment` VALUES (3, 0, ' ');
INSERT INTO `user_comment` VALUES (4, 10, '123123');
INSERT INTO `user_comment` VALUES (5, 6, '2323');
INSERT INTO `user_comment` VALUES (6, 0, ' ');
INSERT INTO `user_comment` VALUES (7, 7, '11');
INSERT INTO `user_comment` VALUES (8, 8, 'yyyy');
INSERT INTO `user_comment` VALUES (9, 10, '非常美味，甚是喜欢，下次还来');

-- ----------------------------
-- View structure for hot_food
-- ----------------------------
DROP VIEW IF EXISTS `hot_food`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `hot_food` AS select `food`.`Food_id` AS `Food_id`,`food`.`Food_name` AS `Food_name`,`food`.`Food_typeid` AS `Food_typeid`,`food`.`Food_price` AS `Food_price`,`food`.`Food_discription` AS `Food_discription`,`food`.`Food_img_url` AS `Food_img_url`,`food`.`Food_sale` AS `Food_sale` from `food` where (`food`.`Food_sale` = 1);

-- ----------------------------
-- View structure for sale_food
-- ----------------------------
DROP VIEW IF EXISTS `sale_food`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `sale_food` AS select `food`.`Food_id` AS `Food_id`,`food`.`Food_name` AS `Food_name`,`food`.`Food_typeid` AS `Food_typeid`,`food`.`Food_price` AS `Food_price`,`food`.`Food_discription` AS `Food_discription`,`food`.`Food_img_url` AS `Food_img_url`,`food`.`Food_sale` AS `Food_sale` from `food` where (`food`.`Food_sale` = 2);

-- ----------------------------
-- Triggers structure for table order
-- ----------------------------
DROP TRIGGER IF EXISTS `secure_order_INSERT`;
delimiter ;;
CREATE TRIGGER `secure_order_INSERT` BEFORE INSERT ON `order` FOR EACH ROW BEGIN
    IF (HOUR(NOW()) NOT BETWEEN 9 AND 17) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Orders can only be INSERT during business hours.';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table order
-- ----------------------------
DROP TRIGGER IF EXISTS `secure_order_UPDATE`;
delimiter ;;
CREATE TRIGGER `secure_order_UPDATE` BEFORE UPDATE ON `order` FOR EACH ROW BEGIN
    IF (HOUR(NOW()) NOT BETWEEN 9 AND 17) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Orders can only be UPDATE during business hours.';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table order
-- ----------------------------
DROP TRIGGER IF EXISTS `order_prepare`;
delimiter ;;
CREATE TRIGGER `order_prepare` BEFORE UPDATE ON `order` FOR EACH ROW BEGIN
    IF NEW.order_status = 4 AND OLD.order_status = 2 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update orders with order_status = 4 and previous order_status = 2.';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table order
-- ----------------------------
DROP TRIGGER IF EXISTS `secure_order_DELETE`;
delimiter ;;
CREATE TRIGGER `secure_order_DELETE` BEFORE DELETE ON `order` FOR EACH ROW BEGIN
    IF (HOUR(NOW()) NOT BETWEEN 9 AND 17) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Orders can only be UPDATE during business hours.';
    END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
