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

 Date: 29/06/2023 23:29:13
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
  INDEX `user_id_index`(`User_id`) USING BTREE,
  INDEX `commit_id_fk`(`Comment_id`) USING BTREE,
  CONSTRAINT `commit_id_fk` FOREIGN KEY (`Comment_id`) REFERENCES `user_comment` (`comment_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_fk` FOREIGN KEY (`User_id`) REFERENCES `user` (`User_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
-- Table structure for user_comment
-- ----------------------------
DROP TABLE IF EXISTS `user_comment`;
CREATE TABLE `user_comment`  (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_star` int(11) NULL DEFAULT NULL,
  `comment_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`comment_id`) USING BTREE,
  UNIQUE INDEX `user_comment_index`(`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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
