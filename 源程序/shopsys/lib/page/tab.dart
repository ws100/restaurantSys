import 'package:flutter/material.dart';
import 'package:shopsys/page/tabPage/home.dart';

import 'tabPage/order.dart';
import 'tabPage/user.dart';
import 'tabPage/shop.dart';
class ShopHomePage extends StatefulWidget {
  const ShopHomePage({super.key});

  @override
  State<ShopHomePage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  int _pageIndex = 0;
  List<Widget> pages = [
    HomePage(),
    const ShopPage(),
    const OrderPage(),
    const UserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('食堂点餐系统'),
      ),
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(

        //显示4个
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: '点餐',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '订单',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
