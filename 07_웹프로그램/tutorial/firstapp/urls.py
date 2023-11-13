from django.urls import path

### from 폴더 import 파일
# firstapp 폴더 하위에 있는 views.py 파일 읽어들인단 의미
# 라이브러리 읽어들이는 것과 동일
from . import views

### 사용자가 요청할 수 있는 URL정의
# URL하나당 views의 함수 한개를 호출할 수 있도록 매핑함
# URL을 정의한다 해서, 패턴(pattern)정의라고 함
urlpatterns = [
    ### 클라이언트(User)가 웹브라우저 URL창에 아래 주소를 입력하면 index함수 호출
    # firstapp의 url이라는 것을 알려주기 위해 url 사이에 first/dlqfur
    # 예, http://127.0.0.1:8000/first/index/
    
    path('index/', views.index), #'함수이름/', py파일이름.함수이름
    # path('', views.index), #기본 url인 경우 index/한 것과 같은 페이지를 열어라 #index는 보통 첫페이지를 의미
    path('index.html/', views.index), #http://127.0.0.1:8000/first/index.html
    
    path('index1/', views.getIndex1), #http://127.0.0.1:8000/first/index1/
    
    path('', views.index2),
    path('template01/', views.getTemplate01),
]