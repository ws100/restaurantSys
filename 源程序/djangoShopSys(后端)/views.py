import datetime
import json

from django.db import connection
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render
from django.contrib.auth import authenticate, login
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt


# Create your views here.


def getAllFood(request):
    with connection.cursor() as cursor:
        cursor.execute('SELECT * FROM `food`')
        result = cursor.fetchall()
        # 将查询结果转换为字典
        data = []
        for row in result:
            data.append({
                'id': row[0],
                'name': row[1],
                'type': row[2],
                'price': row[3],
                'description': row[4],
                'img': row[5]
            })
    return JsonResponse({'status': 'success', 'data': data})


def getFoodSale(request):
    with connection.cursor() as cursor:
        cursor.execute('SELECT * FROM `food` where food_sale = 1')
        result = cursor.fetchall()
        # 将查询结果转换为字典
        data = []
        for row in result:
            data.append({
                'id': row[0],
                'name': row[1],
                'type': row[2],
                'price': row[3],
                'description': row[4],
                'img': row[5]
            })
    return JsonResponse({'status': 'success', 'data': data})


def getFoodHot(request):
    with connection.cursor() as cursor:
        cursor.execute('SELECT * FROM `food` where food_sale = 2')
        result = cursor.fetchall()
        # 将查询结果转换为字典
        data = []
        for row in result:
            data.append({
                'id': row[0],
                'name': row[1],
                'type': row[2],
                'price': row[3],
                'description': row[4],
                'img': row[5]
            })
    return JsonResponse({'status': 'success', 'data': data})


@csrf_exempt
# 用户登录
def userLogin(request):
    username = request.POST.get('username')
    password = request.POST.get('password')
    userType = request.POST.get('type')
    print(username, password)
    with connection.cursor() as cursor:
        cursor.execute('SELECT * FROM `user` WHERE `user_name`=%s AND `user_password`=%s AND `user_type`=%s', [username, password, userType])
        result = cursor.fetchone()
    if result:
        return JsonResponse({'status': 'success', 'data': result[0]})
    else:
        return JsonResponse({'status': 'fail'})


@csrf_exempt
# 用户注册
def reg(req):
    username = req.POST.get('username')
    password = req.POST.get('password')
    userType = req.POST.get('type')
    print(username, password)
    with connection.cursor() as cursor:
        cursor.execute('INSERT INTO `user` (`user_name`,`user_password`,`user_type`) VALUES (%s,%s,%s)', [username, password, userType])
        result = cursor.fetchone()
    if result:
        return JsonResponse({'status': 'success', 'data': result[0]})
    else:
        return JsonResponse({'status': 'fail'})


# 获取订单信息
def getOrderInfo(request):
    userId = request.GET.get('userId')
    orderList = []
    with connection.cursor() as cursor:
        cursor.execute('SELECT * FROM `food`')
        allFood = cursor.fetchall()
        data = {}
        for row in allFood:
            data[row[0]] = {
                'id': row[0],
                'name': row[1],
                'type': row[2],
                'price': row[3],
                'description': row[4],
                'img': row[5]
            }
        cursor.execute('SELECT * FROM `order` where user_id = %s', [userId])
        result = cursor.fetchall()
        for i in result:
            cursor.execute('SELECT * FROM `order_content` where order_id = %s', [i[0]])
            subResult = cursor.fetchall()
            orderContentList = []
            for j in subResult:
                orderContent = {'food': data[j[1]], 'food_num': j[2]}
                orderContentList.append(orderContent)
            order = {'order_id': i[0], 'order_time': i[2], 'order_price': i[1], 'order_status': i[3], 'order_content': orderContentList}
            orderList.append(order)
    return JsonResponse({'status': 'success', 'data': orderList})


@csrf_exempt
def postOrder(request):
    if request.method == 'POST':
        order_data = json.loads(request.body)
        user_id = order_data['userId']
        food_order = order_data['orderData']
        with connection.cursor() as cursor:
            cursor.execute('SELECT * FROM `food`')
            allFood = cursor.fetchall()
            data = {}
            for row in allFood:
                data[row[0]] = {
                    'id': row[0],
                    'name': row[1],
                    'type': row[2],
                    'price': row[3],
                    'description': row[4],
                    'img': row[5]
                }
            now = datetime.datetime.now()
            formatted_time = now.strftime('%Y-%m-%d %H:%M:%S')
            cursor.execute('INSERT INTO `order` (`user_id`,`order_price`,`order_time`,`order_status`) VALUES (%s,%s,%s,%s)', [user_id, 0, formatted_time, 0])
            cursor.execute('SELECT LAST_INSERT_ID()')
            order_id = cursor.fetchone()[0]
            order_price = 0
            for i,j in food_order.items():
                if j > 0:
                    order_price += data[int(i)]['price'] * j
                    cursor.execute('INSERT INTO `order_content` (`order_id`,`food_id`,`food_number`) VALUES (%s,%s,%s)', [order_id, i, j])
            cursor.execute('UPDATE `order` SET `order_price`=%s WHERE `order_id`=%s', [order_price, order_id])
        # 将order_data和user_id转换为服务器端的数据结构
        # ...
        # 返回响应
        return JsonResponse({'status': 'success'})
    else:
        return JsonResponse({'status': 'error', 'message': 'Invalid request method'})


@csrf_exempt
def pay(request):
    if request.method == 'POST':
        order_id = request.POST.get('orderId')
        with connection.cursor() as cursor:
            cursor.execute('UPDATE `order` SET `order_status`=1 WHERE `order_id`=%s', [order_id])
        return JsonResponse({'status': 'success'})
    else:
        return JsonResponse({'status': 'error', 'message': 'Invalid request method'})

@csrf_exempt
def updateFood(request):
    if request.method == 'POST':
        food_data = json.loads(request.body)
        food_id = food_data['id']
        food_name = food_data['name']
        food_type = food_data['type']
        food_price = food_data['price']
        food_description = food_data['description']
        food_img = food_data['img']
        with connection.cursor() as cursor:
            cursor.execute('UPDATE `food` SET `food_name`=%s,`food_typeid`=%s,`food_price`=%s,`food_description`=%s,`food_img_url`=%s WHERE `food_id`=%s', [food_name, food_type, food_price, food_description, food_img, food_id])
        return JsonResponse({'status': 'success'})