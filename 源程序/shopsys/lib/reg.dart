import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopsys/ConstVar.dart';
import 'package:http/http.dart' as http;
class RegisterPage extends StatefulWidget {
  const RegisterPage() : super();

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  void reg () async{
    var url = Uri.parse(Const.baseUrl+'reg/');
    var response = await http.post(url, body: {
      'username': _usernameController.text,
      'password': _passwordController.text,
      'type':'0',
    });
    print(response.body);
    final data = jsonDecode(response.body);
    if(data["status"] == 'success'){
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('注册成功'),
            content: Text("请登录"),
            actions: <Widget>[
              TextButton(
                child: Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    else{
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('注册失败'),
            content: Text("用户名已存在"),
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
        title: Text('注册'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      reg();
                    }
                  },
                  child: Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}