import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import '../ConstVar.dart';
import '../getData.dart';

class OrderManager extends StatefulWidget {
  const OrderManager({Key? key}) : super(key: key);

  @override
  State<OrderManager> createState() => _OrderManagerState();
}


class OrderCard extends StatefulWidget {
  OrderCard({super.key, required this.order,required this.type,required this.refresh});
  Function refresh;
  Order order;
  int type;
  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
int _star = 0;
String _comment = '';
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

  void pay(int orderId) async{
  final url = Uri.parse(Const.baseUrl+'pay/');
  final response = await http.post(url,body: {'orderId':orderId.toString()});
  //解析json
  final data = jsonDecode(response.body);
  if (data['status'] == 'success') {
    print('支付成功');
  }
  widget.refresh();
}

void preFinish(int orderId) async {
    print("pre");
    final url = Uri.parse(Const.baseUrl+'finishPreOrder/');
    final response = await http.post(url,body: {'orderId':orderId.toString()});
    final data = jsonDecode(response.body);
    if(data['status'] == 'success'){
      print("准备成功");
    }
    else{
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: Text('取消失败'),
        content: Text('不在工作时间'),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('确定'))
        ],
      ));
    }
    widget.refresh();
  }
  void Finish(int orderId) async {
    print("fininsh");
    final url = Uri.parse(Const.baseUrl+'finishOrder/');
    final response = await http.post(url,body: {'orderId':orderId.toString()});
    final data = jsonDecode(response.body);
    if(data['status'] == 'success'){
      print("准备成功");
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
                    Text('订单号:${widget.order.id}', style: TextStyle(fontSize: 20)),
                    Text(Const.status[widget.type], style: TextStyle(fontSize: 20, color: Colors.green)),
                  ],
                ),
                Column(
                  children: List.generate(widget.order.items.length, (index) => 
                    Container(
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
                          SizedBox(width: 20,), 
                          Expanded(child: Container(
                            width: double.infinity,
                            height: 70,
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${widget.order.items[index].food.name}",style: TextStyle(fontSize: 18),),
                                Text("单价:${widget.order.items[index].food.price}",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                Text("￥${widget.order.items[index].food.price * widget.order.items[index].num}",style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 255, 0, 0)),),
                              ],
                            ))),   
                          Text('x${widget.order.items[index].num}', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.order.time.toString().substring(0,widget.order.time.toString().length-4), style: TextStyle(fontSize: 20, color: Colors.grey)),
                    Text('￥${widget.order.price}', style: TextStyle(fontSize: 20, color: Colors.red)),

                  ],
                ),
                widget.type == 0?
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: (){
                    //支付弹窗
                    
                }, child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('等待用户支付'))):
                widget.type == 1?
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 166, 255)),
                  ),
                  onPressed: (){
                      preFinish(widget.order.id);
                }, child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('完成准备'))):
                widget.type == 2?
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 166, 255)),
                  ),
                  onPressed: (){
                    Finish(widget.order.id);

                }, child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('完成'))):
                widget.type == 3?(widget.order.comment_id == 0?
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 166, 255)),
                  ),
                  onPressed: (){
                    Finish(widget.order.id);

                }, child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('等待用户评价')))
                :
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
                ):ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 166, 255)),
                  ),
                  onPressed: (){

                }, child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('用户已取消')))
              ],
            ),
          ),
        ),
    
      ),
    );
  }
}


class _OrderManagerState extends State<OrderManager> {
  List<Order> _orders = [];

  List<Order> unPayOrders = [];
  List<Order> preOrders = [];
  List<Order> makingOrders = [];
  List<Order> finishOrders = [];
  List<Order> cancelOrders = [];

  void getOrders() async {
    List<Order> _orders = [];
    
    final response = await http.get(Uri.parse(Const.baseUrl+'getAllOrder/'));
    print(Const.baseUrl+'getAllOrder/');
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
  Future<void> ref() async{
    getOrders();
  }
  int _curSelect = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
  }
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: 
              List.generate(5, (index) =>
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _curSelect = index;
                  });
                },
                child: Text(
                  Const.status[index],
                  style: TextStyle(
                    color: _curSelect == index?Colors.white:Colors.black,
                  ),
                ),
              )
              )),
          ),
          Expanded(child: RefreshIndicator(
            onRefresh: ref,
            child: ListView(
              children: [
            if(_curSelect == 0)
            for(var i in unPayOrders.reversed)
            OrderCard(order: i,type: 0,refresh:(){
              getOrders();
            }),
            if(_curSelect == 1)
            for(var i in preOrders.reversed)
            OrderCard(order: i,type: 1,refresh: (){
              getOrders();
            },),
            if(_curSelect == 2)
            for(var i in makingOrders.reversed)
            OrderCard(order: i,type: 2,refresh: (){
              getOrders();
            },),
            if(_curSelect == 3)
            for(var i in finishOrders.reversed)
            OrderCard(order: i,type: 3,refresh: (){
              getOrders();
            },),
            if(_curSelect == 4)
            for(var i in cancelOrders.reversed)
            OrderCard(order: i,type: 4,refresh: (){
              getOrders();
            },),
                  ],
            ),
          ))
        ],
      ),
    );
  }
}
