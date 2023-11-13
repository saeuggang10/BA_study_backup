### url관리하는 파일
#   함수를 만들면 request를 보낼 url을 만드는 장소


from django.contrib import admin
from django.urls import path


# 1. 두개로 쪼개서 각 앱의 views사용
"""
### from 폴더 import 파일
# firstapp 폴더 하위에 있는 views.py 파일 읽어들인단 의미
# 라이브러리 읽어들이는 것과 동일
from firstapp import views

### 사용자가 요청할 수 있는 URL정의
# URL하나당 views의 함수 한개를 호출할 수 있도록 매핑함
# URL을 정의한다 해서, 패턴(pattern)정의라고 함
urlpatterns = [
    ### 클라이언트(User)가 웹브라우저 URL창에 아래 주소를 입력하면 index함수 호출
    # 예, http://127.0.0.1:8000/index/
    path('index/', views.index), #'함수이름/', py파일이름.함수이름
    path('', views.index), #기본 url인 경우 index/한 것과 같은 페이지를 열어라 #index는 보통 첫페이지를 의미
    path('index.html', views.index), #http://127.0.0.1:8000/index.html
    
    path('index1/', views.getIndex1), #http://127.0.0.1:8000/index1/
    
    path('admin/', admin.site.urls), #로켓 날라가던 첫페이지 URL
]

from secondapp import views

urlpatterns = [
    path('index2', views.getIndex2),
]
"""


# 2. 하나 안에 넣어서 사용하는 방법
"""
from firstapp import views as v1
from secondapp import views as v2

urlpatterns = [
    path('index1/', v1.getIndex1),
    
    path('index2/', v2.getIndex2),
]
"""


# 3. urls을 각각의 app에서 관리하고 어느 앱인지 알 수 있게 해 찾아갈 수 있도록 설정

from django.urls import path, include

### include(폴더.파일) : 원하는 파일을 읽어들일 때 사용
# include가 실행되는 순간 해당파일의 코드에서 처리가 됨

### 원리
# URL뒤의 첫번째 이름과 두번째 이름 분리
# 첫번째 이름을 이용해 앱을 찾아가게 설정할 예정
# 각 앱에서는 두번쨰 이름을 함수를 호출하도록 설정

urlpatterns = [
    path('first/', include('firstapp.urls')), #첫 번째 이름, include('앱이름.urls.py')
    path('second/', include('secondapp.urls')),
    path('third/', include('thirdapp.urls')),
    path('', include('mainapp.urls')),
    path('front/', include('frontapp.urls')),
    path('layout/', include('layoutapp.urls')),
    path('oracle/', include('oracleapp.urls')),
    path('nonmodel/', include('nonmodelapp.urls')),
]