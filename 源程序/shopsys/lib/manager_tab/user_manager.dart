
import 'package:flutter/material.dart';

class UserManager extends StatefulWidget {
  const UserManager({Key? key}) : super(key: key);

  @override
  State<UserManager> createState() => _UserManagerState();
}

class _UserManagerState extends State<UserManager> {
  final List<Map<String, dynamic>> _users = [
    {'id': 1, 'name': '张三', 'email': 'zhangsan@example.com', 'phone': '13800000001'},
    {'id': 2, 'name': '李四', 'email': 'lisi@example.com', 'phone': '13800000002'},
    {'id': 3, 'name': '王五', 'email': 'wangwu@example.com', 'phone': '13800000003'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户管理'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            title: Text(user['name']),
            subtitle: Text('邮箱：${user['email']}，电话：${user['phone']}'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserDetail(user: user)));
            },
          );
        },
      ),
    );
  }
}

class UserDetail extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserDetail({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户详情'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(user['name']),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('邮箱：${user['email']}'),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('电话：${user['phone']}'),
          ),
        ],
      ),
    );
  }
}