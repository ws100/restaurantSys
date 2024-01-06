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
        cursor.execute('SELECT * FROM `sale_food`')
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
        cursor.execute('SELECT * FROM `hot_food`')
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
        cursor.execute('SELECT * FROM `user` WHERE `user_name`=%s AND `user_type`=%s', [username, userType])
        result = cursor.fetchone()
        print(result)
        if result is not None:
            return JsonResponse({'status': 'fail'})

        cursor.execute('INSERT INTO `user` (`user_name`,`user_password`,`user_type`) VALUES (%s,%s,%s)', [username, password, userType])

        return JsonResponse({'status': 'success'})


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
            order = {'order_id': i[0], 'order_time': i[2], 'order_price': i[1], 'order_status': i[3],'comment_id':i[5], 'order_content': orderContentList}
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
            try:
                cursor.execute('INSERT INTO `order` (`user_id`,`order_price`,`order_time`,`order_status`,`comment_id`) VALUES (%s,%s,%s,%s,%s)', [user_id, 0, formatted_time, 0,0])
                cursor.execute('SELECT LAST_INSERT_ID()')
                order_id = cursor.fetchone()[0]
                order_price = 0
                for i, j in food_order.items():
                    if j > 0:
                        order_price += data[int(i)]['price'] * j
                        cursor.execute('INSERT INTO `order_content` (`order_id`,`food_id`,`food_number`) VALUES (%s,%s,%s)', [order_id, i, j])
                cursor.execute('UPDATE `order` SET `order_price`=%s WHERE `order_id`=%s', [order_price, order_id])
            except Exception:
                return JsonResponse({'status': 'error', 'message': 'Invalid request method'})
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
def finishPreOrder(request):
    if request.method == 'POST':
        order_id = request.POST.get('orderId')
        with connection.cursor() as cursor:
            cursor.execute('UPDATE `order` SET `order_status`= 2 WHERE `order_id`=%s', [order_id])
        return JsonResponse({'status': 'success'})
    else:
        return JsonResponse({'status': 'error', 'message': 'Invalid request method'})

@csrf_exempt
def finishOrder(request):
    if request.method == 'POST':
        order_id = request.POST.get('orderId')
        with connection.cursor() as cursor:
            cursor.execute('UPDATE `order` SET `order_status`=3 WHERE `order_id`=%s', [order_id])
        return JsonResponse({'status': 'success'})
    else:
        return JsonResponse({'status': 'error', 'message': 'Invalid request method'})

@csrf_exempt
def cancelOrder(request):
    if request.method == 'POST':
        order_id = request.POST.get('orderId')
        with connection.cursor() as cursor:
            try:
                cursor.execute('UPDATE `order` SET `order_status`= 4 WHERE `order_id`=%s', [order_id])
            except Exception:
                return JsonResponse({'status': 'error', 'message': 'Invalid request method'})
        return JsonResponse({'status': 'success'})
    else:
        return JsonResponse({'status': 'error', 'message': 'Invalid request method'})

@csrf_exempt
def updateFood(request):
    if request.method == 'POST':
        print(request.body)
        food_data = json.loads(request.body)
        food_id = food_data['id']
        food_name = food_data['name']
        food_type = food_data['type']
        food_price = food_data['price']
        food_description = food_data['description']
        food_img = food_data['img']
        with connection.cursor() as cursor:
            cursor.execute('UPDATE `food` SET `food_name`=%s,`food_typeid`=%s,`food_price`=%s,`food_discription`=%s,`food_img_url`=%s WHERE `food_id`=%s', [food_name, food_type, food_price, food_description, food_img, food_id])
        return JsonResponse({'status': 'success'})



def getAllOrderInfo(request):
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
        cursor.execute('SELECT * FROM `order`')
        result = cursor.fetchall()
        for i in result:
            cursor.execute('SELECT * FROM `order_content` where order_id = %s', [i[0]])
            subResult = cursor.fetchall()
            orderContentList = []
            for j in subResult:
                orderContent = {'food': data[j[1]], 'food_num': j[2]}
                orderContentList.append(orderContent)
            order = {'order_id': i[0], 'order_time': i[2], 'order_price': i[1], 'order_status': i[3],'comment_id':i[5], 'order_content': orderContentList}
            orderList.append(order)
    return JsonResponse({'status': 'success', 'data': orderList})


def getComment(request):
    commentList = []
    commentId = request.GET.get('commentId')
    with connection.cursor() as cursor:
        cursor.execute('SELECT * FROM `user_comment` WHERE `comment_id`=%s', [commentId])
        result = cursor.fetchall()
        for i in result:
            comment = {'comment_id': i[0], 'comment_content': i[2], 'comment_star': i[1]}
            commentList.append(comment)
    return JsonResponse({'status': 'success', 'data': commentList})

@csrf_exempt
def postComment(request):
    if request.method == 'POST':
        comment_data = json.loads(request.body)
        comment_content = comment_data['comment_content']
        comment_star = comment_data['comment_star']
        with connection.cursor() as cursor:
            cursor.execute('INSERT INTO `user_comment` (`comment_content`,`comment_star`) VALUES (%s,%s)', [comment_content, comment_star])
            cursor.execute('SELECT LAST_INSERT_ID()')
            comment_id = cursor.fetchone()[0]
            cursor.execute('UPDATE `order` SET `comment_id`=%s WHERE `order_id`=%s', [comment_id, comment_data['order_id']])
        return JsonResponse({'status': 'success', 'data': comment_id})
    else:
        return JsonResponse({'status': 'error', 'message': 'Invalid request method'})
