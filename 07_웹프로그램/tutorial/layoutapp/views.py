from django.shortcuts import render

# Create your views here.

from django.http import HttpResponse

def main(request):
    return render(request,
                  "layoutapp/01_main.html",
                  {})

def login(request):
    return render(request,
                  "layoutapp/02_login.html",
                  {})
    
def afterlogin(request):
    
    if request.method == "POST" :
        mem_id = request.POST["mem_id"]
        mem_pass = request.POST["mem_pass"]
        
    if (mem_id == "") | (mem_pass == "") :
        msg = """
            <script type="text/javascript">
                alert('아이디 또는 비밀번호를 확인해주세요.');
                history.back();
            </script>
            
        """
    else : 
        msg = """
            <span style="text-align: center;">{} 아이디로 성공적으로 로그인했습니다.</span>
        """.format(mem_id)
        
    return HttpResponse(msg)

def prod(request) :
    return render(request,
                  "layoutapp/04_prod.html",
                  {})
    
def order(request):
    return render(request,
                  "layoutapp/05_order.html",
                  {})
    

def cart(request) : 
    return render(request,
                  "layoutapp/06_cart.html",
                  {})
    
def join(request):
    return render(request,
                  'layoutapp/03_join.html',
                  {})