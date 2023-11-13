## py파일
### urls.py
- 사용자가 요청할 수 있는 URL정의
- URL하나당 views의 함수 한개를 호출할 수 있도록 매핑함
- URL을 정의한다 해서, 패턴(pattern)정의라고 함
```python
# config/urls.py
from django.urls import path, include

urlpatterns = [
    # http://127.0.0.1:8000/testapp/
    path('testapp/', include('testapp.urls')),
]
```
```python
# firstapp/urls.py
from django.urls import path
from . import views

urlpatterns = [
    # http://127.0.0.1:8000/testapp/test/
    path('test/', views.getTest),
]
```
<br/>

### views.py
- 모든 프로그램은 함수로 만들어야 함
- 함수 1개당 웹페이지 1개라고 인지
- 기본 라이브러리 : HttpResponse
  - 인터넷 서버를 왔다갔다 할 수 있게 해줌
```python
# firstapp/views.py
from django.shortcuts import render
from django.http import HttpResponse

def getTest(resquest):
    return HttpResponse('<b>tutorial2/testapp/test ::: test페이지</b>')
```
<br/>

## 설명
### app페이지가 여러개인 경우
* app별로 url을 관리할 수 있도록 분리하기
    - 각 앱에 URL을 관리할 수 있는 파일이 필요함 : config/urls.py을 각 app에 복붙
    - firstapp/urls.py에 firstapp의 내용만 작성