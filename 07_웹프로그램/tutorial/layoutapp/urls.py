# from django.contrib import admin -> 삭제
from django.urls import path

### firstapp 폴더 하위에 있는 view.py 파일 읽어들이기
# - 라이브러리 읽어들이는 것과 동일
# - 점(.)은 현재 위치
from . import views

### 사용자가 요청할 수 있는 URL을 정의합니다.
# - url 하나당, views의 함수 한 개를 호출할 수 있도록 매핑합니다.
# - url을 정의한다고 해서, 패턴(pattern)정의라고 합니다.
urlpatterns = [
    path('join/', views.join),
    
    # http://127.0.0.1:8000/layout/cart/
    path('cart/', views.cart),
    
    # http://127.0.0.1:8000/layout/order
    path('order/', views.order),
    
    path('prod/', views.prod),
    
    # - http://127.0.0.1:8000/layout/afterlogin/
    path('afterlogin/', views.afterlogin),
    
    # - http://127.0.0.1:8000/layout/login/
    path('login/', views.login),
    
    # - http://127.0.0.1:8000/layout/main/
    path('main/', views.main),
]
