import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopsys/ConstVar.dart';
import 'package:shopsys/getData.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class OrderCard extends StatefulWidget {
  OrderCard(
      {super.key,
      required this.order,
      required this.type,
      required this.refresh});
  Function refresh;
  Order order;
  int type;
  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  int _star = 0;
  String _comment = '';
  int _rating = 0;
  String _commentText = ' ';
  void postComment() async{
    final url = Uri.parse(Const.baseUrl + 'postComment/');
    final body = {
      'order_id': widget.order.id.toString(),
      'comment_star':_rating.toString(),
      'comment_content':_commentText
    };
    print(jsonEncode(body));
    final response =
        await http.post(url, body: jsonEncode(body));
    //解析json
    
    final data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      print('评论成功');
      setState(() {
        widget.order.comment_id = data['data'];
      });
    }
    getComment(widget.order.comment_id);
    widget.refresh();
  }
  void getComment(int comment_id) async {
    final url = Uri.parse(Const.baseUrl + 'getComment/?commentId='+comment_id.toString());
    final response =
        await http.get(url);
    //解析json
    final data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      final datap = data["data"][0];
      setState(() {
        _star = datap['comment_star'];
        _comment = datap['comment_content'];
      });
    }
  }
  void pay(int orderId) async {
    final url = Uri.parse(Const.baseUrl + 'pay/');
    final response =
        await http.post(url, body: {'orderId': orderId.toString()});
    //解析json
    final data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      print('支付成功');
    }
    widget.refresh();
  }
  void cancelOrder(int orderId) async {
    final url = Uri.parse(Const.baseUrl + 'cancelOrder/');
    final response =
        await http.post(url, body: {'orderId': orderId.toString()});
    //解析json
    final data = jsonDecode(response.body);
    print("dd");
    if (data['status'] == 'success') {
      print('取消成功');
    }
    else{
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: Text('取消失败'),
        content: Text('不在工作时间,或订单正在制作'),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('确定'))
        ],
      ));
    }
    widget.refresh();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("初始化");
    if(widget.order.comment_id != 0)getComment(widget.order.comment_id);
  }
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('订单号:${widget.order.id}',
                        style: TextStyle(fontSize: 20)),
                    Text(
                        Const.status[widget.type],
                        style: TextStyle(fontSize: 20, color: Colors.green)),
                  ],
                ),
                Column(
                  children: List.generate(
                    widget.order.items.length,
                    (index) => Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //图片显示
                          SizedBox(
                            width: 90,
                            height: 90,
                            child: ClipOval(
                              child: Image.network(
                                widget.order.items[index].food.img,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: Container(
                                  width: double.infinity,
                                  height: 70,
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.order.items[index].food.name}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        "单价:${widget.order.items[index].food.price}",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                      Text(
                                        "￥${widget.order.items[index].food.price * widget.order.items[index].num}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Color.fromARGB(255, 255, 0, 0)),
                                      ),
                                    ],
                                  ))),
                          Text('x${widget.order.items[index].num}',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        widget.order.time.toString().substring(
                            0, widget.order.time.toString().length - 4),
                        style: TextStyle(fontSize: 20, color: Colors.grey)),
                    Text('￥${widget.order.price}',
                        style: TextStyle(fontSize: 20, color: Colors.red)),
                  ],
                ),
                widget.type == 0
                    ? ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        onPressed: () {
                          //支付弹窗
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('支付'),
                                  content: Text('是否支付${widget.order.price}元'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('取消')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          pay(widget.order.id);
                                        },
                                        child: Text('确定')),
                                  ],
                                );
                              });
                        },
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text('立即支付')))
                    : widget.type == 1
                        ? ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 0, 166, 255)),
                            ),
                            onPressed: () {
                              //取消订单弹窗
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('取消订单'),
                                      content: Text('是否取消订单'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('取消')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              cancelOrder(widget.order.id);
                                            },
                                            child: Text('确定')),
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text('取消订单')))
                        : widget.type == 2?
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 0, 166, 255)),
                            ),
                            onPressed: () {},
                            child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text('制作中')))
                        :widget.type == 3?
                        ((widget.order.comment_id == 0)?
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 229, 255, 0)),
                            ),
                            onPressed: () {
                              //评论框
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('评论'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Text('评分:'),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              RatingBar.builder(
                                                initialRating: 0,
                                                minRating: 0,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 30,
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Color.fromARGB(
                                                      255, 255, 0, 0),
                                                ),
                                                onRatingUpdate: (rating) {
                                                  _rating = (rating*2+0.01).toInt();
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextField(
                                            maxLines: 5,
                                            decoration: InputDecoration(
                                              hintText: '请输入评论内容',
                                              border: OutlineInputBorder(),
                                              
                                            ),
                                            onChanged: (value) {
                                              _commentText = value;
                                            },
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('取消')),
                                        TextButton(
                                            onPressed: () {
                                              postComment();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('确定')),
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text('立即评论'))):
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text("评论星级${_star}",textAlign: TextAlign.start,),
                        Text("评论内容:\n${_comment},",textAlign: TextAlign.start,)
                      ],),
                    )
                                ):
                    ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 0, 166, 255)),
                            ),
                            onPressed: () {},
                            child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text('已取消')))  
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderItemCard extends StatefulWidget {
  OrderItemCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.isEnable,
      required this.onPressed});
  bool isEnable;
  String title;
  IconData icon;
  Function onPressed;
  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        //width: 100,
        width: 40,
        color: widget.isEnable ? Colors.orange : Colors.white,
        child: InkWell(
          onTap: () {
            widget.onPressed();
          },
          child: Column(
            children: [
              Icon(widget.icon),
              Text(widget.title),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderPageState extends State<OrderPage> {
  List<Order> _orders = [];
  List<Order> unPayOrders = [];
  List<Order> preOrders = [];
  List<Order> makingOrders = [];
  List<Order> finishOrders = [];
  List<Order> cancelOrders = [];
  void getOrders() async {
    List<Order> _orders = [];

    final response = await http
        .get(Uri.parse(Const.baseUrl + 'getOrderInfo/?userId=${Const.userId}'));
    print(Const.baseUrl + 'getOrderInfo/?userId=${Const.userId}');
    if (response.statusCode == 200) {
      setState(() {
        final o = jsonDecode(response.body)['data'];
        _orders = o.map<Order>((item) => Order.fromJson(item)).toList();
      });
    }
    setState(() {
      unPayOrders = [];
      preOrders = [];
      makingOrders = [];
      finishOrders = [];
      cancelOrders = [];
      _orders.forEach((element) {
        print(element.status);
        if(element.status == 0) unPayOrders.add(element);
      if(element.status == 1) preOrders.add(element);
      if(element.status == 2) makingOrders.add(element);
      if(element.status == 3) finishOrders.add(element);
      if(element.status == 4) cancelOrders.add(element);
    });
  });
  }

  int _curSelect = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
  }
  Future<void> ref() async{
    getOrders();
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 5),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            5,
            (index) => OrderItemCard(
              title: Const.status[index],
              icon: Icons.rate_review,
              isEnable: _curSelect == index,
              onPressed: () {
                setState(() {
                  _curSelect = index;
                });
              },
            ),
          )),
      Expanded(
        child: RefreshIndicator(
          onRefresh: ref,
          child: ListView(
            children: [
              if (_curSelect == 0)
                for (var i in unPayOrders.reversed)
                  OrderCard(
                      order: i,
                      type: 0,
                      refresh: () {
                        getOrders();
                      }),
              if (_curSelect == 1)
                for (var i in preOrders.reversed)
                  OrderCard(
                    order: i,
                    type: 1,
                    refresh: () {
                      getOrders();
                    },
                  ),
              if (_curSelect == 2)
                for (var i in makingOrders.reversed)
                  OrderCard(
                    order: i,
                    type: 2,
                    refresh: () {
                      getOrders();
                    },
                  ),
              if (_curSelect == 3)
                for (var i in finishOrders.reversed)
                  OrderCard(
                    order: i,
                    type: 3,
                    refresh: () {
                      getOrders();
                    },
                  ),
              if (_curSelect == 4)
                for (var i in cancelOrders.reversed)
                  OrderCard(
                    order: i,
                    type: 4,
                    refresh: () {
                      getOrders();
                    },
                  ),
            ],
          ),
        ),
      )
    ]);
  }
}
