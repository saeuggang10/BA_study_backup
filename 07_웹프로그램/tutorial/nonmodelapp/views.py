from django.shortcuts import render
from django.http import HttpResponse
from nonmodelapp.nonmodel import cart
from django.core.paginator import Paginator #페이징처리

def index(request):
    return render(request,
                  'nonmodelapp/index.html',
                  {})
    
### 페이징처리
def getCartListPaging(request):
    # 페이지 번호설정
    now_page = request.GET.get("page", "1") #페이지 번호 설정
    now_page = int(now_page) #request는 무조건 문자열임으로 int로 변환
    
    # 목록 데이터
    cart_list = cart.cart_List()
    
    ### 한 화면에 행 10개씩 보여주기
    num_row = 10
    p = Paginator(cart_list, num_row) #num_row만큼 쪼개서 리스트 형태로 갖고있음
    rows_data = p.get_page(now_page) # 현재 페이지 번호에 해당하는 데이터 읽어들임
    
    # 하단 페이지 번호
    start_page = (now_page - 1) // num_row * num_row + 1
    end_page = start_page + 9
    
    if end_page > p.num_pages : #종료페이지의 번호가 전체 행의 개수보다 클 때(예, 전체 45까지 있는페 페이지:50)
        end_page = p.num_pages
        
    # 다음/이전 버튼 보여줄지 여부에 대한 체크
    is_prev = False #이전버튼 초기값
    if start_page > 1 :
        is_prev = True

    is_next = False #다음버튼 초기값
    if end_page < p.num_pages :
        is_next = True
        
    context = {'cart_list' : rows_data, #데이터목록_list
               'now_page' : now_page, #현재 페이지번호_int #현재 선택된 값 유지하기 위해서  
               'start_page':start_page, #시작페이지
               'end_page':end_page, #마지막페이지
               'page_range':range(start_page, end_page + 1), #페이지범위
               'is_prev':is_prev, #이전버튼
               'is_next':is_next} #다음버튼
    
    return render(request,
                  'nonmodelapp/paging/cart_list.html',
                  context)
    
    
### 비동기 방식
def load_view(request):
    return render(request,
                  'nonmodelapp/jquery_load/load_view.html',
                  {})

def load_view1(request):
    return render(request,
                  'nonmodelapp/jquery_load/load_view1.html',
                  {})

def load_view2(request):
    return render(request,
                  'nonmodelapp/jquery_load/load_view2.html',
                  {})

def load_view3(request):
    return render(request,
                  'nonmodelapp/jquery_load/load_view3.html',
                  {})