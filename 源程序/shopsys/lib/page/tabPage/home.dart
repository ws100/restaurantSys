import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shopsys/ConstVar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../getData.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Food> hotFoods = [];
  List<Food> discountFoods = [];
  late SharedPreferences prefs;
  void getData() async{
    prefs = await SharedPreferences.getInstance();
    String orderData = prefs.getString('orderData') ?? '[]';
    jsonDecode(orderData).forEach((element) {
      foodOrder[element['id']] = element['num'];
    });
  }
  void getHot() async {
    hotFoods = [];
    final url = Uri.parse(Const.baseUrl+'getFoodHot/');
    print(url);
    final response = await http.get(url);
    //解析json
    final data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      final foods = data['data'];
      for (var food in foods) {
        setState(() {
          hotFoods.add(Food.fromJson(food));
        });
      }
    }
  }
  void getDiscount() async {
    discountFoods = [];
    final url = Uri.parse(Const.baseUrl+'getFoodSale/');
    final response = await http.get(url);
    //解析json
    final data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      final foods = data['data'];
      for (var food in foods) {
        setState(() {
          discountFoods.add(Food.fromJson(food));
        });
      }
    }
  }
  void getLoginData() async{
    prefs = await SharedPreferences.getInstance();
    Const.isLogin = prefs.getBool('isLogin') ?? false;
    Const.userType = prefs.getInt('userType') ?? 0;
    Const.username = prefs.getString('username') ?? '';
    Const.userId = prefs.getInt('userId') ?? 0;
    if(Const.userType == 1){
      Navigator.of(context).pushReplacementNamed('/manager');
    }
  }
  //初始生命周期
  @override
  void initState() {
    super.initState();
    getHot();
    getDiscount();
    getLoginData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 200,
          child: Image.network(
            'https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/mainBar.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '餐厅活动',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '欢迎光临本店，本月特别优惠：满100元减20元！',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.yellow[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '折扣商品',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '本店特别推荐以下折扣商品：',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    discountFoods.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Column(
                        children: [
                          Image.network(
                            discountFoods[index].img,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          Text(discountFoods[index].name),
                          Text('¥${discountFoods[index].price}'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Color.fromARGB(255, 255, 228, 196),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '热门商品',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '本店特别推荐以下热门商品：',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    hotFoods.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Column(
                        children: [
                          Image.network(
                            hotFoods[index].img,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          Text(hotFoods[index].name),
                          Text('¥${hotFoods[index].price}'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}