import 'package:flutter/material.dart';
import 'package:shopsys/page/login.dart';
import 'manager_page.dart';
import 'page/tab.dart';
import 'reg.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ShopHomePage(),
        '/login': (context) => LoginPage(),
        '/manager': (context) => const ManagerPage(),
        '/reg':(context) => const RegisterPage(),
      },

    );
  }
}

