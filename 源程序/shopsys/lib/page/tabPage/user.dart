import 'package:flutter/material.dart';
import 'package:shopsys/ConstVar.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class UserItemCard extends StatefulWidget {
  UserItemCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed});
  String title;
  IconData icon;
  Function onPressed;
  @override
  State<UserItemCard> createState() => _UserItemCardState();
}

class _UserItemCardState extends State<UserItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange[80],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 3,
            backgroundColor: Colors.white,
          ),
          onPressed: () => {
            widget.onPressed(),
          },
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  widget.icon,
                  color: Color.fromARGB(255, 255, 208, 0),
                ),
                onPressed: () {},
              ),
              Expanded(
                  child: Text(
                widget.title,
                style: TextStyle(fontSize: 20),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class VipIntroduce extends StatefulWidget {
  VipIntroduce(
      {super.key,
      required this.title,
      required this.message,
      required this.icon});
  final Icon icon;
  final String title;
  final String message;
  @override
  State<VipIntroduce> createState() => _VipIntroduceState();
}

class _VipIntroduceState extends State<VipIntroduce> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: widget.icon,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(widget.title),
                  content: Text(widget.message),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('关闭'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        Text(widget.title),
      ],
    );
  }
}

class _UserPageState extends State<UserPage> {

  void loginOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.orange,
                image: DecorationImage(
                  image: NetworkImage(
                    'https://img1.baidu.com/it/u=730870780,1543952458&fm=253&app=120&size=w931&n=0&f=JPEG&fmt=auto?sec=1686848400&t=739fe45a9aad7547f3b2ab6bf799e0d3',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  //用户头像有阴影效果
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(50),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://img2.baidu.com/it/u=6985638,3812677033&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1686848400&t=20b1a2d6d22a4a86e78f94fe9196ead2',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),

                  Const.isLogin
                      ? Text(
                          Const.username,
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        )
                      : TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text("立即登录",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 0, 0, 0))))
                ],
              ),
              Expanded(
                  child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        margin: EdgeInsets.all(8.5),
                        elevation: 5,
                        //渐变色
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.orange[100],
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text(
                                " 会员卡",
                                style: TextStyle(fontSize: 30),
                              )),
                              const Expanded(child: Text("   会员权益")),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  VipIntroduce(
                                    title: "热门推荐",
                                    message: "000",
                                    icon: const Icon(
                                      Icons.star,
                                      color: Colors.orangeAccent,
                                      size: 30,
                                    ),
                                  ),
                                  VipIntroduce(
                                    title: "生日礼品",
                                    message: "000",
                                    icon: const Icon(
                                      Icons.card_giftcard,
                                      color: Colors.orangeAccent,
                                      size: 30,
                                    ),
                                  ),
                                  VipIntroduce(
                                    title: "优惠券",
                                    message: "000",
                                    icon: const Icon(
                                      Icons.local_offer,
                                      color: Colors.orangeAccent,
                                      size: 30,
                                    ),
                                  ),
                                  VipIntroduce(
                                    title: "历史记录",
                                    message: "000",
                                    icon: const Icon(
                                      Icons.access_time,
                                      color: Colors.orangeAccent,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        )),
                  ),
                  UserItemCard(
                    title: "我的钱包",
                    icon: Icons.account_balance_wallet,
                    onPressed: () {},
                  ),
                  UserItemCard(
                    title: "我的订单",
                    icon: Icons.assignment,
                    onPressed: () {},
                  ),
                  UserItemCard(
                    title: "我的收藏",
                    icon: Icons.favorite,
                    onPressed: () {},
                  ),
                  UserItemCard(
                    title: "我的评价",
                    icon: Icons.comment,
                    onPressed: () {},
                  ),
                  UserItemCard(
                    title: "退出登录",
                    icon: Icons.location_on,
                    onPressed: () {
                      setState(() {
                        Const.isLogin = false;
                        Const.username = "";
                        loginOut();
                        final snackBar = SnackBar(
                          content: Text('退出登录成功'),
                          action: SnackBarAction(
                            label: '确定',
                            onPressed: () {},
                          ),
                        );
                        Navigator.of(context).pushReplacementNamed('/');
                      });
                    },
                  ),
                ],
              ))
            ],
          ),
        )
      ],
    );
  }
}
