TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER order_prepare\nBEFORE UPDATE ON `order`\nFOR EACH ROW\nBEGIN\n    IF NEW.order_status = 4 AND OLD.order_status = 2 THEN\n        SIGNAL SQLSTATE \'45000\' SET MESSAGE_TEXT = \'Cannot update orders with order_status = 4 and previous order_status = 2.\';\n    END IF;\nEND' 'CREATE DEFINER=`root`@`localhost` TRIGGER secure_order_DELETE\nBEFORE DELETE ON `order`\nFOR EACH ROW\nBEGIN\n    IF (HOUR(NOW()) NOT BETWEEN 9 AND 17) THEN\n        SIGNAL SQLSTATE \'45000\' SET MESSAGE_TEXT = \'Orders can only be UPDATE during business hours.\';\n    END IF;\nEND'
sql_modes=1075838976 1075838976
definers='root@localhost' 'root@localhost'
client_cs_names='utf8' 'utf8'
connection_cl_names='utf8_general_ci' 'utf8_general_ci'
db_cl_names='utf8mb4_general_ci' 'utf8mb4_general_ci'
created=168783432567 168783295524
