# from django.contrib import admin -> 삭제
from django.urls import path
from . import views

urlpatterns = [    
    # - http://127.0.0.1:8000/nonmodel/main/
    path('', views.index),
    
    path('cart_list/', views.getCartListPaging),
    
    path('load_view/', views.load_view),
    path('load_view1/', views.load_view1),
    path('load_view2/', views.load_view2),
    path('load_view3/', views.load_view3),
]
