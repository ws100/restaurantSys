import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopsys/ConstVar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isManager = false;
  String _username = '';
  String _password = '';

  void _login(int type) async {
    final url = Uri.parse(Const.baseUrl + 'login/');
    //post请求加数据
    final data = {'username': _username, 'password': _password,'type':type.toString()};
    final response = await http.post(url, body: data);
    //解析json
    final result = jsonDecode(response.body);
    if (result['status'] == 'success') {
      //登录成功
      //保存登录状态
      Const.isLogin = true;
      Const.userType = type;
      Const.username = _username;
      Const.userId = result['data'];
      //本地存储
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLogin', true);
      prefs.setInt('userType', type);
      prefs.setString('username', _username);
      prefs.setInt('userId', result['data']);
      //跳转到首页
      if(type == 0)Navigator.of(context).pushReplacementNamed('/');
      else {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/manager');
      }
    } else {
      //登录失败
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('登录失败'),
            content: Text("用户不存在或密码错误"),
            actions: <Widget>[
              TextButton(
                child: Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录页面')
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '用户登录',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: '帐号',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _username = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: '密码',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('用户登录'),
                Radio(
                  value: false,
                  groupValue: _isManager,
                  onChanged: (value) {
                    setState(() {
                      _isManager = value!;
                    });
                  },
                ),
                SizedBox(width: 20),
                Text('管理员登录'),
                Radio(
                  value: true,
                  groupValue: _isManager,
                  onChanged: (value) {
                    setState(() {
                      _isManager = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_isManager) {
                    // Handle manager login
                    _login(1);
                  } else {
                    // Handle normal login
                    _login(0);
                  }
                },
                child: Text('登录'),
              ),
            ),
            TextButton(onPressed: (){
                Navigator.of(context).pushNamed('/reg');
            }, child: Text("没有帐号,立即注册"))
          ],
        ),
      ),
    );
  }
}
