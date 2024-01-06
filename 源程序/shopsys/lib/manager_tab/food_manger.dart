import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopsys/ConstVar.dart';
import 'package:shopsys/cos.dart';
import 'package:shopsys/getData.dart';
import 'package:http/http.dart' as http;

class FoodManager extends StatefulWidget {
  FoodManager({Key? key}) : super(key: key);
  
  @override
  State<FoodManager> createState() => _FoodManagerState();
}

class FoodCard extends StatefulWidget {
  FoodCard({super.key,required this.food,required this.update});
  Food food;
  Function update;
  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: 
        BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 120,
        child: Row(
          children: [
            SizedBox(width: 20,),
            SizedBox(
              height: 100,
              width: 100,
              child: ClipOval(child: Image.network(widget.food.img,
              fit: BoxFit.cover,),
              
              ),
              
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('菜名:${widget.food.name}'),
                  Text('价格:${widget.food.price}'),
                  Text('类型:${widget.food.type}'),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(context: context, builder: (context) {
                  return UpDataDialog(food: widget.food,update: widget.update,);
                  
                });
              },
              icon: Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
class UpDataDialog extends StatefulWidget {
  UpDataDialog({super.key,required this.food,required this.update});
  Food food;
  Function update;
  @override
  State<UpDataDialog> createState() => _UpDataDialogState();
}

class _UpDataDialogState extends State<UpDataDialog> {
  PickedFile _imageFile = PickedFile('');
  String generateFileName() {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final random = Random().nextInt(100000);
  return '$timestamp$random';
}
  void postImage() async {
  // 打开系统相册
    print("090");
    final picker = ImagePicker();
    final imageFile = (await picker.getImage(source: ImageSource.gallery));
    if(imageFile == null) return;
    print(imageFile.path);
    setState(() {
      _imageFile = imageFile;
    });
  }
  void commitPhoto() async {
    if (_imageFile.path == '') {
      editFood(widget.food);
      return;
    };
    //提取文件后缀
    var suffix = _imageFile.path.substring(_imageFile.path.lastIndexOf('.'));
    String name = generateFileName();
    final urlString = "https://pbcd-1315149677.cos.ap-nanjing.myqcloud.com/"+name+suffix;
    var url = Uri.parse(urlString);
    var request = http.Request('PUT', url);
    request.bodyBytes = await File(_imageFile.path).readAsBytes();
    request.headers['Authorization'] = generateKey(name+suffix);
    request.headers['Content-Type'] = 'image/jpg';
    request.send();
    widget.food.img = urlString;
    editFood(widget.food);

  }
  void editFood(Food food) async {
    var url = Uri.parse(Const.baseUrl + 'foodEdit/');
    var response = await post(url, body: jsonEncode(food.toJson()));
    if (response.statusCode == 200) {
      widget.update();
      print(response.body);
      Navigator.pop(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
        child: Material(
      
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("修改菜品"),
              TextField(
                decoration: InputDecoration(
                  hintText: widget.food.name,
                  labelText: '菜名',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  if (value == '') return;
                  setState(() {
                    widget.food.name = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: widget.food.type,
                  labelText: '菜品类型',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  if (value == '') return;
                  setState(() {
                    widget.food.type = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: widget.food.price.toString(),

                  labelText: '价格',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (value) {
                  if (value == '') return;
                  //不满足条件正则判断
                  if (double.parse(value) < 0) return;

                  setState(() {
                    widget.food.price = double.parse(value);
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: (_imageFile.path != '')?Image(image: FileImage(File(_imageFile.path))):Image.network(widget.food.img)),
              ElevatedButton(
                onPressed: (){
                  postImage();
                },
                child: Text("上传"),
              ),
                  
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  commitPhoto();
                  //editFood(widget.food);
                  
                },
                child: Text("提交"),
              ),
            ],
          ),
        ),
      
    );
  }
}

class _FoodManagerState extends State<FoodManager> {
  List<Food> allFoods = [];
  Map<String, List<Food>> allType = {};
  List<String> allTypeName = [];
  final _categoryController = TextEditingController();
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
    void editFood(Food food) async{
      final url = Uri.parse(Const.baseUrl + 'editFood/');
      final response = await http.post(url,body: {
        'id':food.id.toString(),
        'name':food.name,
        'price':food.price.toString(),
        'type':food.type,
        'img':food.img,
      });
      final data = jsonDecode(response.body);
      if(data['status'] == 'success'){
        print('修改成功');
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
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(allFoods.length, (index) => FoodCard(food:allFoods[index],update: getAllFood,))
    );
  }
}
