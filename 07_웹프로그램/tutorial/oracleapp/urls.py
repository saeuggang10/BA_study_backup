from django.urls import path
from . import views

urlpatterns = [
    # http://127.0.0.1:8000/oracle/test/
    path('', views.index),
    path('index/', views.index),
    path('index.html/', views.index),
    
    path('mem_list/', views.getMemberList),
    path('mem_view/', views.getMemberView),
    path('mem_update_view/', views.getMemberUpdateView),
    path('mem_update/', views.setMemberUpdate),
    
    path('cart_list/', views.getCartList),
    path('cart_view/', views.getCartView),
    path('cart_delete/', views.setCartDelete),
    path('cart_update_view/', views.getCartUpdateView),
    path('cart_update/', views.setCartUpdate),
    path('cart_insert_view/', views.getCartInsertView),
    path('cart_insert/', views.setCartInsert),
    
    path('lprod_list/', views.getLprodList),
    path('lprod_view/', views.getLprodView),
    path('lprod_update_view/', views.getLprodUpdateView),
    path('lprod_update/', views.setLprodUpdate),
    path('lprod_delete/', views.setLprodDelete),
    path('lprod_insert_view/', views.getLprodInsertView),
    path('lprod_insert/', views.setLprodInsert),
    
    path('prod_list/', views.getProdList),
    path('prod_view/', views.getProdView),
    path('prod_update_view/', views.getProdUpdateView),
    path('prod_update/', views.setProdUpdate),
    
    
    # Join
    path('cart_mem_list/', views.getCartMemList),
    path('cart_mem_prod_list/', views.getCartMemProdList),
    
    
    # 상품화면
    path('product/', views.getProduct),
    path('product_insert/', views.setProductInsert),
    path('product2/', views.getProduct2),
    path('product_insert2/', views.setProductInsert2),
]