from django.shortcuts import render

def index(request):
    return render(request,
                  'frontapp/index.html',
                  {})
    
def htmlVeiw01(request):
    return render(request,
                  'frontapp/html/01_html.html',
                  {})

def linkView(request):
    return render(request,
                  'frontapp/html/02_link.html',
                  {})

def htmlView03(request):
    return render(request,
                  'frontapp/html/03_css.html',
                  {})
                  
def cssView04(request):
    return render(request,
                  'frontapp/html/04_css.html',
                  {})

def cssView05(request):
    return render(request,
                  'frontapp/html/05_css.html',
                  {})

def cssView06(request):
    return render(request,
                  'frontapp/html/06_css.html',
                  {})
    
def tableView(request):
    return render(request,
                  'frontapp/html/07_table.html',
                  {})

### 기존 파이썬 변수값 html출력방식
# def tableView02(request):
#     mem_id = 'a001'
#     mem_name = '이순신'
#     mem_addr = '부산 수영구 수연동'
#     return render(request,
#                   'frontapp/html/08_table.html',
#                   {'mem_id':mem_id,
#                    'mem_name':mem_name,
#                    'mem_addr':mem_addr})

### for문 사용
# dict1개 = row1개
def tableView02(request):
    context = {'mem_id':'b001',
                'mem_name':'홍길동',
                'mem_addr':'부산시 해운대구 우동'}
    mem_lis = [context,
               context,
               context]
    context2 = {'mem_lis':mem_lis,
                'mem_id':'b001',
                'mem_name':'홍길동',
                'mem_addr':'부산시 해운대구 우동'}
    return render(request,
                  'frontapp/html/08_table.html',
                  context2)
    
# from .DB_Sql.member import testData
from .DB_Sql import member # 주로 작성하는 방식
def mem_View(request):
    return render(request,
                  'frontapp/html/09_mem.html',
                  {'test' : member.testData})

def mem_View02(request):
    return render(request,
                  'frontapp/html/10_mem_list.html',
                  {'mem_list' : member.mem_List})
    
def ulView(request):
    return render(request,
                  'frontapp/html/11_ul.html',
                  {})
    
def divView(request):
    return render(request,
                  'frontapp/html/12_div.html',
                  {})
    
def divView02(request):
    return render(request,
                  'frontapp/html/13_div.html',
                  {})
    
def iframeView(request):
    return render(request,
                  'frontapp/html/14_iframe.html',
                  {})
    
def cssTableView(request):
    return render(request,
                  'frontapp/html/15_cssTable.html',
                  {})
    
def cssTableView02(request):
    return render(request,
                  'frontapp/html/16_cssTable.html',
                  {})
    
def cssNavView(request):
    return render(request,
                  'frontapp/html/17_cssNav.html',
                  {})
    
def jsInputFormView(request):
    mem_id ='b001'
    mem_pass = '1234'
    context = {'mem_id':mem_id,
                'mem_pass':mem_pass}
    return render(request,
                  'frontapp/html/18_jsInputForm.html',
                  context)
    
from django.http import HttpResponse
def jsLogin(request):
    # request가 모든 정보를 가지고 있음
    # method : 요청시에 필요한 정보만 뱉는 것
        # method={'POST':{mem_id:어쩌고, mem_pass:저쩌고}}
    if request.method == 'POST':
        mem_id = request.POST['mem_id']
        mem_pass = request.POST['mem_pass']
    elif request.method == 'GET':
        mem_id = request.GET['mem_id']
        mem_pass = request.GET['mem_pass']
    
    # DB조회 후 가입회원여부 확인 조건문
    p_id = 'b001'
    p_pw = '1357'
    if (mem_id == p_id) and (mem_pass == p_pw):
        rsmsg = '''<script type="text/javascript">
                alert("아이디 {}님 정상적으로 로그인 되었습니다.");
                location.href = '/front/';
                </script>'''.format(mem_id)
    else:
        rsmsg = '''<script type="text/javascript">
                alert("아이디 또는 패스워드를 확인해 주세요.");
                history.go(-1);
                </script>'''
    return HttpResponse(rsmsg)


def radioButtonView(request):
    return render(request,
                  'frontapp/html/20_radioButton.html',
                  {})

# 오류 없이 출력하기 위해 방비책 잔뜩 넣은 ver
def jsRadio(request):
    try:
        #값 받아오기
        if request.method == 'POST':
            if request.POST.get('mem_addr') is not None:
                mem_add = request.POST['mem_addr']
                mem_add = request.POST.get('mem_addr', 'None')
                mem_add1 = request.POST['mem_addr1']
            else:
                rsmsg = '''
                        <script type = 'text/javascript'>
                            alert('잘못된 접근입니다1');
                            history.go(-1);
                        </script>'''
                return HttpResponse(rsmsg)

        elif request.method == 'GET':
            if request.GET.get('mem_addr') is not None:
                mem_add = request.GET['mem_addr']
                mem_add = request.GET.get('mem_addr', 'None')
                mem_add1 = request.GET['mem_addr1']
            else:
                rsmsg = '''
                        <script type = 'text/javascript'>
                            alert('잘못된 접근입니다3');
                            history.go(-1);
                        </script>'''
                return HttpResponse(rsmsg)

        # radio따라 이동
        if mem_add1 == '부산':
            rsmsg = '''<script type = 'text/javascript'>
                            alert('{} 지역을 선택하셨습니다');
                            location.href = '/front/';
                        </script>'''.format(mem_add1)
        else:
            rsmsg = '''<script type = 'text/javascript'>
                            alert('부산 지역이 아닙니다. 다시 선택해 주세요!');
                            history.go(-1);
                        </script>'''
        return HttpResponse(rsmsg)
    
    except:
        rsmsg = '''
                <script type = 'text/javascript'>
                    alert('잘못된 접근입니다2');
                    history.go(-1)
                </script>'''
        return HttpResponse(rsmsg)
    
def radioButton2View2(request):
    return render(request,
                    'frontapp/html/22_radioButton2.html',
                    {"mem_addr":'부산',
                     "mem_addr1":"부산"})

def jsRadio2(request):
    try:
        if request.method == 'POST':
            if request.POST.get('mem_addr') is not None:
                mem_add = request.POST['mem_addr']
                mem_add = request.POST.get('mem_addr', 'None')
                mem_add1 = request.POST['mem_addr1']
            else:
                rsmsg = '''
                        <script type = 'text/javascript'>
                            alert('잘못된 접근입니다1');
                            history.go(-1);
                        </script>'''
                return HttpResponse(rsmsg)

        elif request.method == 'GET':
            if request.GET.get('mem_addr') is not None:
                mem_add = request.GET['mem_addr']
                mem_add = request.GET.get('mem_addr', 'None')
                mem_add1 = request.GET['mem_addr1']
            else:
                rsmsg = '''
                        <script type = 'text/javascript'>
                            alert('잘못된 접근입니다3');
                            history.go(-1);
                        </script>'''
                return HttpResponse(rsmsg)

        # radio따라 이동
        if mem_add1 == '부산':
            rsmsg = '''<script type = 'text/javascript'>
                            alert('{} 지역을 선택하셨습니다');
                            location.href = '/front/';
                        </script>'''.format(mem_add1)
        else:
            rsmsg = '''<script type = 'text/javascript'>
                            alert('부산 지역이 아닙니다. 다시 선택해 주세요!');
                            history.go(-1);
                        </script>'''
        return HttpResponse(rsmsg)
    
    except:
        rsmsg = '''
                <script type = 'text/javascript'>
                    alert('잘못된 접근입니다2');
                    history.go(-1)
                </script>'''
        return HttpResponse(rsmsg)
    
def checkBoxView(request):
    return render(request,
                  'frontapp/html/24_checkbox.html',
                  {})

def checkBoxView2(request):
    if request.POST.get("mem_addr") is not None:
        mem_addr = request.POST.get("mem_addr")
        mem_addr_lis = request.POST.getlist("mem_addr") #리스트로 값을 넘기는 데이터 받아오기
        str_list = "'"
        for val in mem_addr_lis:
            if val == mem_addr_lis[-1]:
                str_list += val + "'"
            else:
                str_list += val + ','
        
    return render(request,
                'frontapp/html/25_checkbox.html',
                {'mem_addr' : mem_addr,
                 'mem_addr_lis':mem_addr_lis,
                 'str_list':str_list})
    
def selectBoxView(request):
    return render(request,
                  'frontapp/html/26_selectbox.html',
                  {})
    
def selectBoxView2(request):
    mem_addr = request.POST.getlist('mem_addr_multi')
    return render(request,
                  'frontapp/html/27_selectbox2.html',
                  {'mem_addr':mem_addr})
    
def bootstrapView(request):
    return render(request,
                  'frontapp/bootstrap/28_bootstrap.html',
                  {})

def bootstrapTableView(request):
    return render(request,
                  'frontapp/bootstrap/29_bootstrap_table.html',
                  {})
    
def bootstrapFormView(request):
    return render(request,
                  'frontapp/bootstrap/30_bootstrap_form.html',
                  {})
    
def bootstrapLayoutView(request):
    return render(request,
                  'frontapp/bootstrap/31_bootstrap_layout.html',
                  {})
    
def includeindexView(request):
    return render(request,
                  'frontapp/include/32_include_index.html',
                  {})
    
def mainIndexView(request):
    return render(request,
                  'frontapp/include/33_main_index.html',
                  {})
    
def extendLayoutView(request):
    return render(request,
                  'frontapp/extend/34_extend_layout.html',
                  {})
    
def extendHello(request):
    return render(request,
                  'frontapp/extend/35_hello.html',
                  {})