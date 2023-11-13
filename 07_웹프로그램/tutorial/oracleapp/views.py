from django.shortcuts import render
from django.http import HttpResponse
from .models import Member

# Create your views here.
def index(request):
    return render(request,
                  'oracleapp/index.html',
                  {})

# 회원정보 전체 행 조회하기
# objects.get() : 1행
# objects.all() : 전체 행 / [{key1:val1, key2:val2 ...}, {}, ...]
def getMemberList(request):
    mem_list = Member.objects.all()
    # sql = 'select mem_id, mem_pass, mem_name, mem_addr1
    #        from member'
    return render(request,
                  'oracleapp/member/mem_list.html',
                  {'mem_list':mem_list})

"""sql = "select mem_id, mem_pass, mem_name, mem_addr1
#        from member
#        where mem_id='a001'"""
def getMemberView(request):
    mem_id = request.GET['mem_id']
    mem_view = Member.objects.get(mem_id = mem_id) #col명=변수명
    return render(request,
                  'oracleapp/member/mem_view.html',
                  {'mem_id':mem_id,
                   'mem_view':mem_view})
    
# 회원정보 수정 페이지
def getMemberUpdateView(request):
    mem_id = request.GET['mem_id']
    mem_view = Member.objects.get(mem_id = mem_id) #col명=변수명
    return render(request,
                  'oracleapp/member/mem_update_view.html',
                  {'mem_id':mem_id,
                   'mem_view':mem_view})
    
# 회원정보 수정하기
# DB처리 후 목록페이지로 돌아가면 됨. 따로 페이지 필요X
"""sql = Update member : member테이블에서
            Set mem_pass = mem_pass(<-변수명) : 넘겨받은 값으로 수정하라
                mem_add1 = mem_add1
         Where mem_id=mem_izd(<-변수명) : 아이디가 mem_id인 것인 행들의 """
def setMemberUpdate(request):
    try:
        mem_id = request.POST['mem_id']
        mem_pass = request.POST.get('mem_pass')
        mem_add1 = request.POST.get('mem_add1')
        
        Member.objects.filter(mem_id = mem_id).update(mem_pass = mem_pass,
                                                    mem_add1 = mem_add1)
        
        # msg = "아이디 : {} <br/>비밀번호 : {} <br/>주소 : {}".format(mem_id, mem_pass, mem_add1)
    
    except:
        msg = """
            <script type="text/javascript">
                alert('오류발생');
                history.go(-1);
            </script>
        """
        return HttpResponse(msg)
    msg = """
            <script type="text/javascript">
                alert('정상적으로 수정되었습니다');
                location.href='/oracle/mem_view/?mem_id={}';
            </script>
        """.format(mem_id) #history안되는 이유 : 수정된 값이 반영된 DB로 새로 불러야 함으로
    return HttpResponse(msg)



### Cart
from .models import Cart
# 조회
def getCartList(request):
    cart_list = Cart.objects.all().order_by('-cart_no', "cart_member")
    return render(request,
                  'oracleapp/cart/cart_list.html',
                  {'cart_list':cart_list})
    
# 상세조회
def getCartView(request):
    cart_no = request.GET['cart_no']
    cart_prod = request.GET['cart_prod']
    cart_view = Cart.objects.get(cart_no = cart_no, cart_prod = cart_prod)
    return render(request,
                  'oracleapp/cart/cart_view.html/',
                  {'cart_view':cart_view,
                   'cart_no':cart_no,
                   'cart_prod':cart_prod})
    
# 삭제
def setCartDelete(request):
    try:
        cart_no = request.GET['cart_no']
        cart_prod = request.GET['cart_prod']
        cart_view = Cart.objects.filter(cart_no = cart_no, cart_prod = cart_prod).delete()
    
    except:
        msg = """
            <script type="text/javascript">
                alert('오류발생');
                history.go(-1);
            </script>
        """
        return HttpResponse(msg)
    
    msg = """
            <script type="text/javascript">
                alert('정상적으로 삭제되었습니다');
                location.href='/oracle/cart_list/';
            </script>
        """
    return HttpResponse(msg)

# 수정
def getCartUpdateView(request):
    cart_no = request.GET['cart_no']
    cart_prod = request.GET['cart_prod']
    
    cart_view = Cart.objects.get(cart_no = cart_no, cart_prod = cart_prod)
    return render(request,
                  'oracleapp/cart/cart_update_view.html',
                  {'cart_view':cart_view})
    
def setCartUpdate(request):
    try:
        cart_no = request.POST.get('cart_no')
        cart_prod = request.POST.get('cart_prod')
        cart_qty = request.POST.get('cart_qty')
        
        Cart.objects.filter(cart_no = cart_no, cart_prod = cart_prod).update(cart_qty = cart_qty)
        
    except:
        msg = """
            <script type="text/javascript">
                alert('오류발생');
                history.go(-1);
            </script> 
        """
        return HttpResponse(msg)
    
    msg = """
            <script type="text/javascript">
                alert('정상적으로 수정되었습니다');
                location.href='/oracle/cart_view/?cart_no={}&cart_prod={}';
            </script> 
        """.format(cart_no, cart_prod)
    return HttpResponse(msg)

# 입력
def getCartInsertView(request):
    return render(request,
                  'oracleapp/cart/cart_insert_view2.html',
                  {})
    
def setCartInsert(request):
    try:
        cart_member = request.POST.get('cart_member')
        cart_no = request.POST.get('cart_no')
        cart_prod = request.POST.get('cart_prod')
        cart_qty = request.POST.get('cart_qty')
        Cart.objects.create(cart_member = cart_member,
                            cart_no = cart_no,
                            cart_prod = cart_prod,
                            cart_qty = cart_qty)
    except:
        msg = """
            <script type="text/javascript">
                alert('오류발생');
                history.go(-1);
            </script> 
        """
        return HttpResponse(msg)
    
    msg = """
            <script type="text/javascript">
                alert('정상적으로 수정되었습니다');
                location.href='/oracle/cart_list/';
            </script> 
        """
    return HttpResponse(msg)


### Lprod
from .models import Lprod
# 조회
def getLprodList(request):
    lprod_list = Lprod.objects.all()
    return render(request,
                  'oracleapp/lprod/lprod_list.html',
                  {'lprod_list':lprod_list})

# 상세조회
def getLprodView(request):
    lprod_gu = request.GET.get('lprod_gu')
    lprod_gu = request.GET.get('lprod_gu')
    
    lprod_view = Lprod.objects.get(lprod_gu = lprod_gu)
    return render(request,
                  'oracleapp/lprod/lprod_view.html',
                  {'lprod_view':lprod_view,
                   'lprod_gu':lprod_gu}) #버튼링크용
    
# 수정하기
def getLprodUpdateView(request):
    lprod_gu = request.GET.get('lprod_gu')
    
    lprod_view = Lprod.objects.get(lprod_gu = lprod_gu)
    return render(request,
                  'oracleapp/lprod/lprod_update_view.html',
                  {'lprod_view':lprod_view})
    
def setLprodUpdate(request):
    try:
        lprod_gu = request.POST.get('lprod_gu')
        lprod_id = request.POST.get('lprod_id')
        lprod_nm = request.POST.get('lprod_nm')
        
        Lprod.objects.filter(lprod_gu = lprod_gu).update(lprod_id = lprod_id,
                                                            lprod_nm = lprod_nm)
        
    except:
        msg = """
            <script type="text/javascript">
                alert('오류발생');
                history.go(-1);
            </script> 
        """
        return HttpResponse(msg)

    msg = """
        <script type="text/javascript">
            alert('정상적으로 수정되었습니다');
            location.href='/oracle/lprod_view/?lprod_gu={}';
        </script> 
        """.format(lprod_gu)
    return HttpResponse(msg)

# 삭제
def setLprodDelete(request):
    try:
        lprod_gu = request.GET.get('lprod_gu')
        
        Lprod.objects.filter(lprod_gu = lprod_gu).delete()
        
    except:
        msg = """
            <script type="text/javascript">
                alert('오류발생');
                history.go(-1);
            </script>
        """
        return HttpResponse(msg)
    
    msg = """
            <script type="text/javascript">
                alert('정상적으로 삭제되었습니다');
                location.href='/oracle/lprod_list/';
            </script>
        """
    return HttpResponse(msg)

# 입력
def getLprodInsertView(request):
    return render(request,
                  'oracleapp/lprod/lprod_insert_view.html',
                  {})
    
def setLprodInsert(request):
    try:
        lprod_id = request.POST.get('lprod_id')
        lprod_gu = request.POST.get('lprod_gu')
        lprod_nm = request.POST.get('lprod_nm')
        
        Lprod.objects.create(lprod_id = lprod_id,
                             lprod_gu = lprod_gu,
                             lprod_nm = lprod_nm)
        
    except:
        msg = """
            <script type="text/javascript">
                alert('오류발생');
                history.go(-1);
            </script> 
        """
        return HttpResponse(msg)
    
    msg = """
            <script type="text/javascript">
                alert('정상적으로 추가되었습니다');
                location.href='/oracle/lprod_list/';
            </script> 
        """
    return HttpResponse(msg)


### Prod
from .models import Prod
# 조회
def getProdList(request):
    prod_list = Prod.objects.all()
    return render(request,
                  'oracleapp/prod/prod_list.html',
                  {'prod_list':prod_list})
    
# 상세조회
def getProdView(request):
    prod_id = request.GET.get('prod_id')
    
    prod_view = Prod.objects.get(prod_id = prod_id)
    return render(request,
                  'oracleapp/prod/prod_view.html',
                  {'prod_view':prod_view,
                   'prod_id':prod_id})
    
# 수정
def getProdUpdateView(request):
    prod_id = request.GET.get('prod_id')
    
    prod_view = Prod.objects.get(prod_id = prod_id)
    return render(request,
                  'oracleapp/prod/prod_update_view.html',
                  {'prod_view':prod_view,
                   'prod_id':prod_id})
    
def setProdUpdate(request):
    try:
        prod_id = request.POST.get('prod_id')
        prod_cost = request.POST.get('prod_cost')
        prod_price = request.POST.get('prod_price')
        prod_sale = request.POST.get('prod_sale')
        
        Prod.objects.filter(prod_id = prod_id).update(prod_cost = prod_cost,
                                                         prod_price = prod_price,
                                                         prod_sale = prod_sale)
        
    except:
        msg = """
        <script type="text/javascript">
            alert('오류발생');
            history.go(-1);
        <script> 
        """
        return HttpResponse(msg)

    msg = """
            <script type="text/javascript">
                alert('정상적으로 수정되었습니다');
                location.href='/oracle/prod_view/?prod_id={}';
            </script>
        """.format(prod_id)
    return HttpResponse(msg)


### Join
from .models import CartMember
def getCartMemList(request):
    cart_list = CartMember.objects.all().order_by('-cart_no', "cart_member")
    return render(request,
                  'oracleapp/cartmem/cart_mem_list.html',
                  {'cart_list':cart_list})
    
from .models import CartMemberProd
def getCartMemProdList(request):
    cart_list = CartMemberProd.objects.all().order_by('-cart_no', "cart_member")
    return render(request,
                  'oracleapp/cartmem/cart_mem_prod_list.html',
                  {'cart_list':cart_list})
    

# Product
def getProduct(request):
    lprod_list = Lprod.objects.all()
    
    # 상품명
    lprod_gu = request.POST.get('lprod_gu', "")
    
    if lprod_gu == "":
        prod_list = Prod.objects.filter(prod_lgu = lprod_list[0].lprod_gu)
    else :
        prod_list = Prod.objects.filter(prod_lgu = lprod_gu)
    
    
    # 테이블 만들기
    prod_name = request.POST.get('prod_nm', "")

    prod_cost = Prod.objects.filter(prod_id = prod_name)
    
    return render(request,
                  'oracleapp/product/product.html',
                  {'lprod_list':lprod_list,
                   'prod_list':prod_list,
                   'lprod_gu':lprod_gu,
                   'prod_cost':prod_cost})
    
def setProductInsert(request):
    try:
        cart_member = "a001"
        cart_no = "2023071400001"
        cart_prod = request.POST.get('prod_id')
        cart_qty = request.POST.get('cart_qty')
        Cart.objects.create(cart_member = cart_member,
                            cart_no = cart_no,
                            cart_prod = cart_prod,
                            cart_qty = cart_qty)
    except:
        msg = """
            <script type="text/javascript">
                alert('오류발생');
                history.go(-1);
            </script> 
        """
        return HttpResponse(msg)
    
    msg = """
            <script type="text/javascript">
                alert('정상적으로 수정되었습니다');
                location.href='/oracle/cart_list/';
            </script> 
        """
    return HttpResponse(msg)


### 상품검색에 따른 주문정보 저장하기
def setProductInsert2(request):   
    try :
        cart_no     = "2023071400002"
        cart_member   = "a001"
        cart_prod   = request.POST.get("prod_nm")
        cart_qty   = request.POST.get("cart_qty")
        
        Cart.objects.create(cart_no = cart_no,                            
                            cart_member = cart_member,
                            cart_prod = cart_prod,
                            cart_qty = cart_qty)
    except :        
        ### 오류처리
        msg = """
            <script type='text/javascript'>
                alert('오류발생');
                history.go(-1);
            </script>
        """    
        return HttpResponse(msg)
    
    ### 정상처리
    msg = """
        <script type='text/javascript'>
            alert('정상적으로 입력되었습니다!!');
            location.href='/oracle/product_list2/';
        </script>
    """   
    return HttpResponse(msg)

### [상품검색에 따른 주문정보 조회 하기] ############
### - 조별실습.ppt 화면 참고..
def getProduct2(request):
    lprod_gu = request.POST.get("lprod_gu", "")
    prod_id  = request.POST.get("prod_id", "")
    change  = request.POST.get("change", "False")
    
    ### 상품분류 select option태그 내용 조회
    lprod_selbox = Lprod.objects.all().order_by("lprod_id") 

    if lprod_gu == "" : 
        ### 상품 select option태그 내용 조회 : 최초 페이지 로딩시
        prod_selbox  = Prod.objects.filter(prod_lgu = lprod_selbox[0].lprod_gu)
        lprod_gu = lprod_selbox[0].lprod_gu
        prod_id  = prod_selbox[0].prod_id
        
    else :
        ### 상품 select option태그 내용 조회 : 상품분류가 선택되었을 때
        prod_selbox  = Prod.objects.filter(prod_lgu = lprod_gu)
    
    ### 검색 버튼이 클릭 되었을 때만 조회시키기
    if change == "True" :
        prod_view = Prod.objects.get(prod_id = prod_id)
        
    ### 검색 버튼이 클릭 되지 않으면, 조회 안시키기
    # - 아래 딕셔너리에 변수는 무조건 넣어주어야 하기 때문에 
    #   형태만 갖추어서 넣어주었을 뿐임..
    else :
        prod_view = {"" : ""}
            
    return render(request, 
                  "oracleapp/product/product_pro.html",
                  {"lprod_selbox" : lprod_selbox,
                   "prod_selbox" : prod_selbox,
                   "lprod_gu" : lprod_gu,
                   "prod_id" : prod_id,
                   "prod_view" : prod_view,
                   "change" : change})