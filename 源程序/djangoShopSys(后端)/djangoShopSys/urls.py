"""
URL configuration for djangoShopSys project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

import shop_sys.views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('login/', shop_sys.views.userLogin),
    path('getAllFood/', shop_sys.views.getAllFood),
    path('getFoodSale/', shop_sys.views.getFoodSale),
    path('getFoodHot/', shop_sys.views.getFoodHot),
    path('getOrderInfo/', shop_sys.views.getOrderInfo),
    path('reg/', shop_sys.views.reg),
    path('postOrder/', shop_sys.views.postOrder),
    path('pay/', shop_sys.views.pay),
    path('foodEdit/', shop_sys.views.updateFood),
    path('getAllOrder/', shop_sys.views.getAllOrderInfo),
    path('finishPreOrder/', shop_sys.views.finishPreOrder),
    path('finishOrder/', shop_sys.views.finishOrder),
    path('cancelOrder/', shop_sys.views.cancelOrder),
    path('getComment/', shop_sys.views.getComment),
    path('postComment/', shop_sys.views.postComment)

]
