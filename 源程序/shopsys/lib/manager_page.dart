import 'package:flutter/material.dart';
import 'package:shopsys/manager_tab/food_manger.dart';
import 'package:shopsys/manager_tab/order_manager.dart';
import 'package:shopsys/manager_tab/super_user.dart';
import 'package:shopsys/manager_tab/user_manager.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  int _selectedIndex = 0;
  List<Widget> _page = [
      FoodManager(),
      OrderManager(),
      SuperUser()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("管理员页面"),
      ),
      body: _page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: "菜品管理"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "订单管理"),
          BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings), label: "管理员用户")
        ],
      ),
    );
  }
}
