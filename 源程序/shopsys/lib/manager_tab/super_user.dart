import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopsys/ConstVar.dart';


class SuperUser extends StatefulWidget {
  const SuperUser({super.key});

  @override
  State<SuperUser> createState() => _SuperUserState();
}

class _SuperUserState extends State<SuperUser> {
  void loginOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
    prefs.setInt('userType', 0);
    Navigator.pop(context); // 关闭对话框
    Navigator.of(context).pushReplacementNamed('/');
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("管理员用户:${Const.userId}"),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('确认退出登录'),
                  content: Text('你确定要退出登录吗？'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // 在这里处理退出登录的逻辑
                        loginOut();
                      },
                      child: Text('确定'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // 关闭对话框
                      },
                      child: Text('取消'),
                    ),
                  ],
                ),
              );
            },
            child: Text("退出登录"),
          ),
        ],
      ),
    );
  }
}

