TYPE=VIEW
query=select `order_system`.`food`.`Food_id` AS `Food_id`,`order_system`.`food`.`Food_name` AS `Food_name`,`order_system`.`food`.`Food_typeid` AS `Food_typeid`,`order_system`.`food`.`Food_price` AS `Food_price`,`order_system`.`food`.`Food_discription` AS `Food_discription`,`order_system`.`food`.`Food_img_url` AS `Food_img_url`,`order_system`.`food`.`Food_sale` AS `Food_sale` from `order_system`.`food` where (`order_system`.`food`.`Food_sale` = 2)
md5=0298e7f47422ea8a2a75fb50f06c0083
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=2023-06-29 04:42:26
create-version=1
source=SELECT * FROM food WHERE Food_sale = 2
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select `order_system`.`food`.`Food_id` AS `Food_id`,`order_system`.`food`.`Food_name` AS `Food_name`,`order_system`.`food`.`Food_typeid` AS `Food_typeid`,`order_system`.`food`.`Food_price` AS `Food_price`,`order_system`.`food`.`Food_discription` AS `Food_discription`,`order_system`.`food`.`Food_img_url` AS `Food_img_url`,`order_system`.`food`.`Food_sale` AS `Food_sale` from `order_system`.`food` where (`order_system`.`food`.`Food_sale` = 2)
