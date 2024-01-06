import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopsys/ConstVar.dart';
import 'package:shopsys/getData.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

//每个food的项目
class FoodItem extends StatefulWidget {
  FoodItem({super.key, required this.food, required this.controller});
  Food food;
  StreamController controller;
  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: SizedBox(
              height: 90,
              width: 90,
              child: ClipOval(
                  child: Image.network(
                widget.food.img,
                fit: BoxFit.cover,
              )),
            )),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.food.name,
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        widget.food.description,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            overflow: TextOverflow.fade),
                      ),
                    ),
                  ),
                  Text(
                    '￥${widget.food.price}',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Container(
              height: 35,
              width: 35,
              child: Material(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                elevation: 3,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        foodOrder[widget.food.id] =
                            foodOrder[widget.food.id]! + 1;
                      });
                      widget.controller.add(0);
                    },
                    child: Container(
                        height: 35,
                        width: 35,
                        child: Stack(children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 35,
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      color: foodOrder[widget.food.id] == 0
                                          ? Colors.transparent
                                          : Color.fromARGB(255, 244, 158, 54),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(foodOrder[widget.food.id] == 0
                                      ? ''
                                      : '${foodOrder[widget.food.id]}')))
                        ]))),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}

//菜品类别的显示项
class TypeBtn extends StatefulWidget {
  TypeBtn(
      {super.key,
      required this.title,
      this.isSelect = false,
      required this.onPressed});
  bool isSelect;
  String title;
  Function onPressed;
  @override
  State<TypeBtn> createState() => _TypeBtnState();
}

//菜品类别的显示项
class _TypeBtnState extends State<TypeBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.isSelect
              ? const Color.fromARGB(255, 255, 215, 184)
              : Colors.white),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
          ),
        ),
        onPressed: () => {
          setState(() {
            widget.onPressed();
          })
        },
        child: Container(
          alignment: Alignment.center,
          height: 30,
          width: double.infinity,
          child: Text(widget.title),
        ),
      ),
    );
  }
}

//商品主页显示
class _ShopPageState extends State<ShopPage> {
  int _curSelect = 0;
  List<Food> allFoods = [];
  Map<String, List<Food>> allType = {};
  List<String> allTypeName = [];
  final _streamController = StreamController<Object>();
  void getAllFood() async {
    allFoods = [];
    final url = Uri.parse(Const.baseUrl + 'getAllFood/');
    final response = await http.get(url);
    //解析json
    final data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      final foods = data['data'];
      for (var food in foods) {
        setState(() {
          allFoods.add(Food.fromJson(food));
        });
      }
    }
    allFoods.forEach((element) {
      //如果不存在赋予0
      if (!foodOrder.containsKey(element.id)) foodOrder[element.id] = 0;
      idToFood[element.id] = element;
      if (allType.containsKey(element.type)) {
        allType[element.type]!.add(element);
      } else {
        allType[element.type] = [element];
      }
    });
    allType.forEach((key, value) {
      allTypeName.add(key);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllFood();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          return Stack(children: [
            Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://i0.hdslb.com/bfs/archive/7547380321cc72a2ddeca2155cbaed451e3fe3c2.jpg@672w_378h_1c_!web-search-common-cover.webp"),
                            fit: BoxFit.cover),
                      ),
                      child: const Text(
                        "欢迎点餐",
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(
                    flex: 7,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              child: ListView(
                                children: [
                                      TypeBtn(
                                        title: "全部",
                                        isSelect: _curSelect == 0,
                                        onPressed: () {
                                          setState(() {
                                            _curSelect = 0;
                                          });
                                        },
                                      )
                                    ] +
                                    List.generate(
                                        allTypeName.length,
                                        (index) => TypeBtn(
                                              title: allTypeName[index],
                                              isSelect: index + 1 == _curSelect
                                                  ? true
                                                  : false,
                                              onPressed: () {
                                                setState(() {
                                                  _curSelect = index + 1;
                                                });
                                              },
                                            )),
                              ),
                            )),
                        Expanded(
                            flex: 7,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 242, 242, 242),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5)),
                                ),
                                child: ListView(
                                  children: List.generate(
                                      _curSelect == 0
                                          ? allFoods.length
                                          : allType[
                                                  allTypeName[_curSelect - 1]]!
                                              .length,
                                      (index) => FoodItem(
                                          food: _curSelect == 0
                                              ? allFoods[index]
                                              : allType[allTypeName[
                                                  _curSelect - 1]]![index],
                                          controller: _streamController)),
                                ),
                              ),
                            ))
                      ],
                    )),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SumShop(
                controller: _streamController,
              ),
            )
          ]);
        });
  }
}

//商品主页显示
class SumShop extends StatefulWidget {
  SumShop({super.key, required this.controller});
  StreamController controller;
  @override
  State<SumShop> createState() => _SumShopState();
}

class _SumShopState extends State<SumShop> {
  void postOrder(Map<int, int> order) async {
    final url = Uri.parse(Const.baseUrl + 'postOrder/');
    Map<String, int> foodOrder = {};
    order.forEach((key, value) {
      foodOrder[key.toString()] = value;
    });
    final body =
        '{"orderData": ${jsonEncode(foodOrder)}, "userId": ${Const.userId}}';
    final response = await http.post(url, body: body);
    //解析json
    final data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      print('success');
    } else {
      //显示不在工作时间
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('提示'),
                content: Text('不在工作时间'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('确定'))
                ],
              ));
    }
  }

  double clacSum() {
    double v = 0;
    foodOrder.forEach((key, value) {
      v += idToFood[key]!.price * (value * 1.0);
    });
    return v;
  }

  int calcNumber() {
    int v = 0;
    foodOrder.forEach((key, value) {
      v += value;
    });
    return v;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => ShopCarPage(
                            controller: widget.controller,
                          ));
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      child: Stack(
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 30,
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "${calcNumber()}",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        child: Text(
                      "预估到手价",
                      style: TextStyle(fontSize: 20),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      "￥${clacSum()}",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      children: [
                        Text("提交订单", style: TextStyle(fontSize: 20)),
                        Expanded(child: Center(child: Text("是否提交订单？"))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: () {
                                  if (calcNumber() == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            duration:
                                                Duration(milliseconds: 200),
                                            content: Text("购物车为空")));
                                    Navigator.pop(context);
                                    return;
                                  }
                                  if (!Const.isLogin) {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/login');
                                    return;
                                  }
                                  postOrder(foodOrder);

                                  setState(() {
                                    foodOrder.forEach((key, value) {
                                      foodOrder[key] = 0;
                                    });
                                    widget.controller.add(1);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text("确认")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("取消")),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              child: Container(
                width: 80,
                alignment: Alignment.center,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 164, 7),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  "去结算",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//购物车显示
class ShopCarPage extends StatefulWidget {
  ShopCarPage({super.key, required this.controller});
  StreamController controller;
  @override
  State<ShopCarPage> createState() => _ShopCarPageState();
}

//购物车显示
class _ShopCarPageState extends State<ShopCarPage> {
  List<Food> orderCar = [];
  List<int> orderNum = [];
  List<bool> checkboxList = [];
  void getFoodOrder() {
    foodOrder.forEach((key, value) {
      if (value > 0) {
        orderCar.add(idToFood[key]!);
        orderNum.add(value);
        checkboxList.add(true);
      }
    });
  }

  double getSum() {
    double v = 0;
    for (int i = 0; i < orderCar.length; i++) {
      if (checkboxList[i]) v += orderCar[i].price * orderNum[i];
    }
    return v;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFoodOrder();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.controller.add(0);
    for (int i = 0; i < checkboxList.length; i++) {
      if (!checkboxList[i]) {
        foodOrder[orderCar[i].id] = 0;
      } else {
        foodOrder[orderCar[i].id] = orderNum[i];
      }
    }
    super.dispose();
  }

  int calcNumber() {
    int v = 0;
    foodOrder.forEach((key, value) {
      v += value;
    });
    return v;
  }

  void postOrder(Map<int, int> order) async {
    final url = Uri.parse(Const.baseUrl + 'postOrder/');
    Map<String, int> foodOrder = {};
    order.forEach((key, value) {
      foodOrder[key.toString()] = value;
    });
    final body =
        '{"orderData": ${jsonEncode(foodOrder)}, "userId": ${Const.userId}}';
    final response = await http.post(url, body: body);
    //解析json
    final data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      print('success');
    } else {
      //显示不在工作时间
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('提示'),
                content: Text('不在工作时间'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('确定'))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        height: 800,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
              child: Text(
                "购物车",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 520,
              child: ListView(
                children: List.generate(
                    orderCar.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                //选择按钮
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Checkbox(
                                    value: checkboxList[index],
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == true) {
                                          checkboxList[index] = true;
                                        } else {
                                          checkboxList[index] = false;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: ClipOval(
                                    child: Image.network(
                                      orderCar[index].img,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                      orderCar[index].name,
                                      style: TextStyle(fontSize: 20),
                                    )),
                                    Expanded(
                                      child: Text(
                                        "￥${orderCar[index].price}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      ),
                                    ),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (orderNum[index] > 1) {
                                                    orderNum[index]--;
                                                  }
                                                });
                                              },
                                              icon:
                                                  Icon(Icons.remove, size: 15),
                                            ),
                                            Container(
                                              width: 20,
                                              child: Text(
                                                "${orderNum[index]}",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  orderNum[index]++;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                size: 15,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        )),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const Expanded(
                      child: Text(
                    "总计",
                    style: TextStyle(fontSize: 20),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    "￥${getSum()}",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  )),
                  ElevatedButton(
                      onPressed: () => showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: SizedBox(
                                height: 100,
                                child: Column(
                                  children: [
                                    Text("提交订单",
                                        style: TextStyle(fontSize: 20)),
                                    Expanded(
                                        child: Center(child: Text("是否提交订单？"))),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              if (calcNumber() == 0) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        duration: Duration(
                                                            milliseconds: 200),
                                                        content:
                                                            Text("购物车为空")));
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                return;
                                              }
                                              setState(() {
                                                foodOrder.forEach((key, value) {
                                                  foodOrder[key] = 0;
                                                });
                                                widget.controller.add(1);
                                              });
                                              if (!Const.isLogin) {
                                                Navigator.pop(context);
                                                Navigator.pushNamed(
                                                    context, '/login');
                                                return;
                                              }
                                              postOrder(foodOrder);
                                              Navigator.pop(context);
                                            },
                                            child: Text("确认")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("取消")),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                      child: const Text("去结算")),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
