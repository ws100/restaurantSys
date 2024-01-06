import 'dart:ffi';

class Food {
  int id;
  String name;
  String type;
  double price;
  String description;
  String empName;
  String img;

  Food({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.description,
    required this.empName,
    required this.img,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      price: (double.parse(json['price'].toString())*1.0),
      description: json['description'],
      empName: json['emp_name']== null ? '':json['emp_name'],
      img: json['img'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'price': price,
      'description': description,
      'img': img,
    };
  }
}

Map<int,int> foodOrder = {};
Map<int,Food> idToFood = {}; 

class Order {
  int id;
  int status;
  double price;
  DateTime time;
  int comment_id;
  List<OrderItem> items;
  
  Order({
    required this.id,
    required this.status,
    required this.time,
    required this.items,
    required this.price,
    required this.comment_id
  });
  
  factory Order.fromJson(Map<String, dynamic> json) {
    var itemList = json['order_content'] as List;
    List<OrderItem> orderItems = itemList.map((item) => OrderItem.fromJson(item)).toList();
    
    return Order(
      id: json['order_id'],
      status: json['order_status'],
      time: DateTime.parse(json['order_time']),
      items: orderItems,
      price: json['order_price'],
      comment_id: json['comment_id'],
    );
  }
}

class OrderItem {
  Food food;
  int num;
  
  OrderItem({
    required this.food,
    required this.num,
  });
  
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      food: Food.fromJson(json['food']),
      num: json['food_num'],
    );
  }
}