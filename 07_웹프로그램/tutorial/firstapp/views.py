from django.shortcuts import render

# Create your views here.
### 웹프로그램 최초에 작성하는 파일
# - views.py 내에 작성하는 모든 프로그램은 함수로 만들어야 한다
# - 장고 웹프로그램은 함수 호출기반으로 구조화됨
from django.http import HttpResponse

### 함수 생성
#### 함수 1개 -> 웹페이지 1개 라고 인지
def index(request):
    # request : 클라이언트 요청을 받아오기
    #           - 요청 정보가 request에 들어가는 것
    #           - 요청에 대한 응답은 response
    return HttpResponse('<b>안녕하세요~ 장고...</b>') # 바로 html값으로 응답할 때 사용

## 연습1
def getIndex1(request):
    return HttpResponse('<b>index12 페이지 입니다.</b>')

# index.html파일 사용하기
def index2(request):
    # request : 클라이언트 요청을 받아오기
    #           - 요청 정보가 request에 들어가는 것
    #           - 요청에 대한 응답은 response
    return render(request, # html파일 따로 만들어 사용할 때 사용
                  'firstapp/index.html', # html파일 위치 작성 # templates는 config\settings에 작성해 뒀음으로 firstapp부터 작성
                  ### 데이터를 html에서 출력하고자 할 때 지정
                  # key(변수 / 보통 문자열로 정의) : values(값 / 변수 또는 직접입력형태로 넣음)
                  # 없다면 비워놓으면 됨
                  {})
    
# html파일에 데이터를 넘겨서 출력시키기
def getTemplate01(request):
    mem_name = '이순신'
    mem_add = '부산 수영구 ~'
    return render(request,
                  'firstapp/template01.html',
                  {'mem_name':mem_name,
                   'mem_add':mem_add})