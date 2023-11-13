from django.db import models

# 변수 타입
from django.db.models.fields import CharField # DB에서 타입이 문자열인 경우
from django.db.models.fields import IntegerField # DB에서 타입이 숫자값인 경우

# 회원정보 : Member
class Member(models.Model) :
    mem_id = CharField(primary_key=True, max_length = 15, null=False) #Oracle DB값과 동일하게 설정
    mem_pass = CharField(max_length = 15, null=False)
    mem_name = CharField(max_length = 20, null=False)
    mem_add1 = CharField(max_length = 100, null=False)
    
    # 내부클래스 정의 : 메타클래스
    class Meta:
        db_table = "member" #실제 사용할 테이블 이름
        app_label = "oracleapp" #사용할 app이름
        managed = False #외부 DB에 테이블이 존재하는가? : 존재->F / 존재X->T
                        #DBMS와 같은 외부서버와 연결할 때 일반적으로 DB가 설계되어 만들어진 상태임으로 False로 설정 후 사용하는 것이 일반적

# 주문정보 : Cart
class Cart(models.Model) :
    cart_member = CharField(max_length=15, null=False)
    cart_no = CharField(primary_key=True, max_length=13, null=False) #PK
    cart_prod = CharField(max_length=10, null=False) #PK는 대표적인 값만 추가함
    cart_qty = IntegerField(null=False)
    
    class Meta:
        db_table = 'cart'
        app_label = 'oracleapp'
        managed = False
        
# 상품분류정보 : Lprod
class Lprod(models.Model):
    lprod_id = IntegerField(null=False)
    lprod_gu = CharField(primary_key=True, max_length=4, null=False) #PK
    lprod_nm = CharField(max_length=40, null=False)
    
    class Meta:
        db_table = 'lprod'
        app_label = 'oracleapp'
        managed = False
        
# 상품정보 : Prod
class Prod(models.Model):
    prod_id = CharField(primary_key=True, max_length=10, null=False) #PK
    prod_name = CharField(max_length=40, null=False)
    prod_lgu = CharField(max_length=4, null=False)
    prod_cost = IntegerField(null=False)
    prod_price = IntegerField(null=False)
    prod_sale = IntegerField(null=False)
    
    class Meta:
        db_table = 'prod'
        app_label = 'oracleapp'
        managed = False
        
### Join
# Cart + Member
class CartMember(models.Model) :
    cart_member = models.ForeignKey(Member, to_field="mem_id", db_column="cart_member", on_delete=models.PROTECT)
    cart_no = CharField(primary_key=True, max_length=13, null=False) #PK
    cart_prod = CharField(max_length=10, null=False) #PK는 대표적인 값만 추가함
    cart_qty = IntegerField(null=False)
    
    class Meta:
        db_table = 'cart'
        app_label = 'oracleapp'
        managed = False

# Cart + Member + Prod
class CartMemberProd(models.Model) :
    cart_member = models.ForeignKey(Member, to_field="mem_id", db_column="cart_member", on_delete=models.PROTECT) #FK : Member
    cart_no = CharField(primary_key=True, max_length=13, null=False) #PK
    cart_prod = models.ForeignKey(Prod, to_field="prod_id", db_column="cart_prod", on_delete=models.PROTECT) #PK는 대표적인 값만 추가함 #FK : Prod
    cart_qty = IntegerField(null=False)
    
    class Meta:
        db_table = 'cart'
        app_label = 'oracleapp'
        managed = False
        
class Product(models.Model) :
    cart_member = models.ForeignKey(Member, to_field="mem_id", db_column="cart_member", on_delete=models.PROTECT) #FK : Member
    cart_no = CharField(primary_key=True, max_length=13, null=False) #PK
    cart_prod = models.ForeignKey(Prod, to_field="prod_id", db_column="cart_prod", on_delete=models.PROTECT) #PK는 대표적인 값만 추가함 #FK : Prod
    cart_qty = IntegerField(null=False)
    prod_lgu = models.ForeignKey(Lprod, to_field="lprod_gu", db_column="prod_lgu", on_delete=models.PROTECT)
    
    class Meta:
        db_table = 'cart'
        app_label = 'oracleapp'
        managed = False