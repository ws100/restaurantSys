/*
 Navicat Premium Data Transfer

 Source Server         : tx
 Source Server Type    : MySQL
 Source Server Version : 50739
 Source Host           : 127.0.0.1:3306
 Source Schema         : shopsys

 Target Server Type    : MySQL
 Target Server Version : 50739
 File Encoding         : 65001

 Date: 15/06/2023 15:02:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for discount_rules
-- ----------------------------
DROP TABLE IF EXISTS `discount_rules`;
CREATE TABLE `discount_rules`  (
  `Je` float NOT NULL,
  `Zk` float NULL DEFAULT NULL,
  PRIMARY KEY (`Je`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of discount_rules
-- ----------------------------
INSERT INTO `discount_rules` VALUES (100, 9.9);
INSERT INTO `discount_rules` VALUES (200, 9.5);
INSERT INTO `discount_rules` VALUES (300, 9.2);
INSERT INTO `discount_rules` VALUES (500, 9);
INSERT INTO `discount_rules` VALUES (1000, 8.5);

-- ----------------------------
-- Table structure for foodtable
-- ----------------------------
DROP TABLE IF EXISTS `foodtable`;
CREATE TABLE `foodtable`  (
  `Cz_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Cz_number` int(11) NOT NULL,
  `Cz_zt` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Cz_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of foodtable
-- ----------------------------
INSERT INTO `foodtable` VALUES ('1', 6, '有人');
INSERT INTO `foodtable` VALUES ('2', 6, '空');
INSERT INTO `foodtable` VALUES ('3', 6, '空');
INSERT INTO `foodtable` VALUES ('4', 6, '空');
INSERT INTO `foodtable` VALUES ('5', 8, '空');
INSERT INTO `foodtable` VALUES ('6', 8, '有人');
INSERT INTO `foodtable` VALUES ('7', 8, '有人');
INSERT INTO `foodtable` VALUES ('8', 8, '空');
INSERT INTO `foodtable` VALUES ('9', 10, '有人');

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus`  (
  `M_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `M_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `M_class` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `M_price` float NULL DEFAULT NULL,
  PRIMARY KEY (`M_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menus
-- ----------------------------
INSERT INTO `menus` VALUES ('001', '小鸡炖蘑菇', '荤素搭配', 49.99);
INSERT INTO `menus` VALUES ('002', '黄焖鸡', '荤', 12);
INSERT INTO `menus` VALUES ('003', '混沌', '荤', 10);
INSERT INTO `menus` VALUES ('004', '混沌', '素', 8);
INSERT INTO `menus` VALUES ('005', '兰州拉面', '素', 10);
INSERT INTO `menus` VALUES ('006', '鸭血粉丝', '荤素搭配', 9.99);
INSERT INTO `menus` VALUES ('007', '小酥肉', '荤', 11.99);
INSERT INTO `menus` VALUES ('008', '大盘鸡', '荤', 55.99);
INSERT INTO `menus` VALUES ('009', '烤鱼', '荤', 20.99);
INSERT INTO `menus` VALUES ('010', '花生米', '小吃', 5.99);
INSERT INTO `menus` VALUES ('011', '啤酒', '饮品', 4.5);
INSERT INTO `menus` VALUES ('012', '腐竹', '素', 10);
INSERT INTO `menus` VALUES ('013', '拍黄瓜', '素', 5.5);

-- ----------------------------
-- Table structure for menus_oder
-- ----------------------------
DROP TABLE IF EXISTS `menus_oder`;
CREATE TABLE `menus_oder`  (
  `O_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `M_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `M_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `M_number` int(11) NOT NULL,
  PRIMARY KEY (`M_id`, `O_id`) USING BTREE,
  INDEX `O_id`(`O_id`) USING BTREE,
  CONSTRAINT `menus_oder_ibfk_1` FOREIGN KEY (`M_id`) REFERENCES `menus` (`M_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `menus_oder_ibfk_2` FOREIGN KEY (`O_id`) REFERENCES `oder` (`O_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menus_oder
-- ----------------------------
INSERT INTO `menus_oder` VALUES ('000001', '001', '小鸡炖蘑菇', 20);
INSERT INTO `menus_oder` VALUES ('000020', '001', '兰州拉面', 23);
INSERT INTO `menus_oder` VALUES ('000002', '002', '黄焖鸡', 24);
INSERT INTO `menus_oder` VALUES ('000003', '003', '混沌', 25);
INSERT INTO `menus_oder` VALUES ('000007', '003', '混沌', 40);
INSERT INTO `menus_oder` VALUES ('000013', '003', '小鸡炖蘑菇', 25);
INSERT INTO `menus_oder` VALUES ('000015', '003', '腐竹', 38);
INSERT INTO `menus_oder` VALUES ('000018', '003', '鸭血粉丝', 50);
INSERT INTO `menus_oder` VALUES ('000004', '004', '混沌', 23);
INSERT INTO `menus_oder` VALUES ('000014', '004', '兰州拉面', 23);
INSERT INTO `menus_oder` VALUES ('000005', '005', '兰州拉面', 28);
INSERT INTO `menus_oder` VALUES ('000008', '005', '烤鱼', 50);
INSERT INTO `menus_oder` VALUES ('000016', '005', '兰州拉面', 40);
INSERT INTO `menus_oder` VALUES ('000005', '006', '鸭血粉丝', 38);
INSERT INTO `menus_oder` VALUES ('000010', '006', '兰州拉面', 23);
INSERT INTO `menus_oder` VALUES ('000014', '006', '花生米', 28);
INSERT INTO `menus_oder` VALUES ('000017', '006', '混沌', 40);
INSERT INTO `menus_oder` VALUES ('000006', '007', '小酥肉', 40);
INSERT INTO `menus_oder` VALUES ('000009', '008', '烤鱼', 46);
INSERT INTO `menus_oder` VALUES ('000012', '008', '黄焖鸡', 24);
INSERT INTO `menus_oder` VALUES ('000019', '008', '拌黄瓜', 46);
INSERT INTO `menus_oder` VALUES ('000011', '009', '鸭血粉丝', 20);

-- ----------------------------
-- Table structure for oder
-- ----------------------------
DROP TABLE IF EXISTS `oder`;
CREATE TABLE `oder`  (
  `O_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `T_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time` datetime(0) NOT NULL,
  `Cz_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `W_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`O_id`) USING BTREE,
  INDEX `T_id`(`T_id`) USING BTREE,
  INDEX `Cz_id`(`Cz_id`) USING BTREE,
  INDEX `W_id`(`W_id`) USING BTREE,
  CONSTRAINT `oder_ibfk_1` FOREIGN KEY (`T_id`) REFERENCES `tomer` (`T_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `oder_ibfk_2` FOREIGN KEY (`Cz_id`) REFERENCES `foodtable` (`Cz_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `oder_ibfk_3` FOREIGN KEY (`W_id`) REFERENCES `worke` (`W_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oder
-- ----------------------------
INSERT INTO `oder` VALUES ('000001', '00001', '2020-06-01 09:30:45', '1', '01');
INSERT INTO `oder` VALUES ('000002', '00002', '2021-06-22 16:15:31', '2', '02');
INSERT INTO `oder` VALUES ('000003', '00003', '2021-06-22 16:15:57', '3', '03');
INSERT INTO `oder` VALUES ('000004', '00004', '2021-06-22 16:16:19', '4', '04');
INSERT INTO `oder` VALUES ('000005', '00005', '2021-06-22 16:16:40', '5', '05');
INSERT INTO `oder` VALUES ('000006', '00006', '2021-06-22 16:17:01', '6', '06');
INSERT INTO `oder` VALUES ('000007', '00007', '2021-06-22 16:17:23', '7', '07');
INSERT INTO `oder` VALUES ('000008', '00008', '2021-06-22 16:17:47', '8', '08');
INSERT INTO `oder` VALUES ('000009', '00009', '2021-06-22 16:18:07', '9', '09');
INSERT INTO `oder` VALUES ('000010', '00010', '2021-06-22 16:18:30', '1', '10');
INSERT INTO `oder` VALUES ('000011', '00011', '2021-06-22 16:19:08', '2', '01');
INSERT INTO `oder` VALUES ('000012', '00012 ', '2021-06-22 16:19:28', '3', '02');
INSERT INTO `oder` VALUES ('000013', '00013', '2021-06-22 16:19:53', '4', '03');
INSERT INTO `oder` VALUES ('000014', '00014', '2021-06-22 16:20:17', '5', '04');
INSERT INTO `oder` VALUES ('000015', '00015', '2021-06-22 16:20:40', '6', '05');
INSERT INTO `oder` VALUES ('000016', '00016', '2021-06-22 16:21:08', '7', '06');
INSERT INTO `oder` VALUES ('000017', '00017', '2021-06-22 16:21:33', '8', '07');
INSERT INTO `oder` VALUES ('000018', '00018', '2021-06-22 16:21:54', '9', '08');
INSERT INTO `oder` VALUES ('000019', '00019', '2021-06-22 16:22:12', '1', '09');
INSERT INTO `oder` VALUES ('000020', '00020', '2021-06-22 16:22:34', '2', '10');

-- ----------------------------
-- Table structure for sales_bill
-- ----------------------------
DROP TABLE IF EXISTS `sales_bill`;
CREATE TABLE `sales_bill`  (
  `O_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `S_price` float NULL DEFAULT NULL,
  `S_priceafter` float NULL DEFAULT NULL,
  `time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`O_id`) USING BTREE,
  CONSTRAINT `sales_bill_ibfk_1` FOREIGN KEY (`O_id`) REFERENCES `oder` (`O_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sales_bill
-- ----------------------------
INSERT INTO `sales_bill` VALUES ('000001', 100.07, 99.0693, '2021-06-22 16:42:22');
INSERT INTO `sales_bill` VALUES ('000002', 120.25, 119.048, '2021-06-22 16:42:24');
INSERT INTO `sales_bill` VALUES ('000003', 132.52, 131.195, '2021-06-22 16:42:28');
INSERT INTO `sales_bill` VALUES ('000004', 154.42, 152.876, '2021-06-22 16:42:31');
INSERT INTO `sales_bill` VALUES ('000005', 2546.2, 2164.27, '2021-06-22 16:42:35');
INSERT INTO `sales_bill` VALUES ('000006', 487.45, 448.454, '2021-06-22 16:42:38');
INSERT INTO `sales_bill` VALUES ('000007', 165.23, 163.578, '2021-06-22 16:42:41');
INSERT INTO `sales_bill` VALUES ('000008', 235.55, 223.773, '2021-06-22 16:42:44');
INSERT INTO `sales_bill` VALUES ('000009', 345.26, 317.639, '2021-06-22 16:42:47');
INSERT INTO `sales_bill` VALUES ('000010', 256.42, 243.599, '2021-06-22 16:42:50');
INSERT INTO `sales_bill` VALUES ('000011', 354.42, 326.006, '2021-06-22 16:42:52');
INSERT INTO `sales_bill` VALUES ('000012', 145.23, 143.778, '2021-06-22 16:42:54');
INSERT INTO `sales_bill` VALUES ('000013', 200.12, 190.114, '2021-06-22 16:42:57');
INSERT INTO `sales_bill` VALUES ('000014', 300.14, 276.129, '2021-06-22 16:42:59');
INSERT INTO `sales_bill` VALUES ('000015', 1000.23, 850.195, '2021-06-22 16:43:01');
INSERT INTO `sales_bill` VALUES ('000016', 154.15, 152.609, '2021-06-22 16:43:03');
INSERT INTO `sales_bill` VALUES ('000017', 1120.23, 952.192, '2021-06-22 16:43:05');
INSERT INTO `sales_bill` VALUES ('000018', 1523.45, 1294.93, '2021-06-22 16:43:08');
INSERT INTO `sales_bill` VALUES ('000019', 123.23, 121.998, '2021-06-22 16:43:11');
INSERT INTO `sales_bill` VALUES ('000020', 154.5, 326.14, '2021-06-22 16:43:14');

-- ----------------------------
-- Table structure for tomer
-- ----------------------------
DROP TABLE IF EXISTS `tomer`;
CREATE TABLE `tomer`  (
  `T_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `T_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `T_rsex` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `T_phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`T_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tomer
-- ----------------------------
INSERT INTO `tomer` VALUES ('00001', '刘备', '男', '12345678910');
INSERT INTO `tomer` VALUES ('00002', '关羽', '男', '11345678910');
INSERT INTO `tomer` VALUES ('00003', '张飞', '男', '12145678910');
INSERT INTO `tomer` VALUES ('00004', '马超', '男', '12315678910');
INSERT INTO `tomer` VALUES ('00005', '黄忠', '男', '12341678910');
INSERT INTO `tomer` VALUES ('00006', '诸葛亮', '男', '12345178910');
INSERT INTO `tomer` VALUES ('00007', '王昭君', '女', '15936053010');
INSERT INTO `tomer` VALUES ('00008', '小乔', '女', '12345671910');
INSERT INTO `tomer` VALUES ('00009', '大桥', '女', '12345678110');
INSERT INTO `tomer` VALUES ('00010', '周瑜', '男', '12345678900');
INSERT INTO `tomer` VALUES ('00011', '孙策', '男', '12345678911');
INSERT INTO `tomer` VALUES ('00012 ', '孙斌', '男', '10345678910');
INSERT INTO `tomer` VALUES ('00013', '白起', '男', '12045678910');
INSERT INTO `tomer` VALUES ('00014', '嬴政', '男', '12305678910');
INSERT INTO `tomer` VALUES ('00015', '武则天', '女', '12340678910');
INSERT INTO `tomer` VALUES ('00016', '公孙离', '女', '12345078910');
INSERT INTO `tomer` VALUES ('00017', '瑶瑶', '女', '12345608910');
INSERT INTO `tomer` VALUES ('00018', '蔡文姬', '女', '12345670910');
INSERT INTO `tomer` VALUES ('00019', '典韦', '男', '12345678010');
INSERT INTO `tomer` VALUES ('00020', '曹操', '男', '12345678920');

-- ----------------------------
-- Table structure for worke
-- ----------------------------
DROP TABLE IF EXISTS `worke`;
CREATE TABLE `worke`  (
  `W_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `W_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `W_sex` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `W_age` int(11) NULL DEFAULT NULL,
  `W_salary` float NULL DEFAULT NULL,
  PRIMARY KEY (`W_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of worke
-- ----------------------------
INSERT INTO `worke` VALUES ('01', '张豪辉', '男', 21, 5200);
INSERT INTO `worke` VALUES ('02', '张伟', '男', 21, 5100);
INSERT INTO `worke` VALUES ('03', '奎奎', '男', 22, 5000);
INSERT INTO `worke` VALUES ('04', '朱阳', '男', 22, 4900);
INSERT INTO `worke` VALUES ('05', '吕宇', '男', 22, 4800);
INSERT INTO `worke` VALUES ('06', '小白', '女', 21, 5200);
INSERT INTO `worke` VALUES ('07', '小世界', '女', 20, 5100);
INSERT INTO `worke` VALUES ('08', '许小柒', '女', 20, 5000);
INSERT INTO `worke` VALUES ('09', '爱笑的彩彩', '女', 20, 5000);
INSERT INTO `worke` VALUES ('10', 'abc', '女', 20, 5000);

-- ----------------------------
-- View structure for tomer_t
-- ----------------------------
DROP VIEW IF EXISTS `tomer_t`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `tomer_t` AS select `tomer`.`T_id` AS `T_id`,`tomer`.`T_name` AS `T_name`,`tomer`.`T_rsex` AS `T_rsex`,`tomer`.`T_phone` AS `T_phone` from `tomer` where (`tomer`.`T_rsex` = '女');

SET FOREIGN_KEY_CHECKS = 1;
