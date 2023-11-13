from django.shortcuts import render
from django.http import HttpResponse

# 예제3
def getIndex(request):
    return HttpResponse('<b>third/index :: 페이지 호출</b>')

def getIndex2(request):
    return render(request,
                  'thirdapp/index.html',
                  {})
    
def tableView(request):
    context={'prod_id':'상품아이디',
             'prod_name':'제품명',
             'buyer_addr':'주소란'}
    prod_lis = [context]*5
    context2 = {'prod_lis':prod_lis}
    return render(request,
                  'thirdapp/html/table.html',
                  context2)
    
def jsinputformView(request):
    return render(request,
                  'thirdapp/html/jsinputform.html',
                  {})
    
def jsinputformpage(request):
    if request.method == 'POST':
        m_mail = request.POST['mem_mail']
        m_age = request.POST['mem_age']
        m_pass = request.POST['mem_pass']

    else:
        m_mail = request.GET['mem_mail']
        m_age = request.GET['mem_age']
        m_pass = request.GET['mem_pass']
        
    p_mail = 'test@test.co.kr'
    p_age = 18
    p_pass = 'asdf1234' 
    if (m_mail == p_mail) and (int(m_age) == p_age) and (m_pass == p_pass):
        rsmsg = '''<script type="text/javascript">
                    alert("정상입력 입니다.");
                    location.href = "/front/";
                    </script>'''
    else:
        rsmsg = '''<script type="text/javascript">
                    alert("비정상입력 입니다.");
                    history.go(-1);
                    </script>'''
    return HttpResponse(rsmsg)