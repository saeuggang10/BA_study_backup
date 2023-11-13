-- 테이블 join
--여러개의 테이블을 메모리에 올려놓고 자유롭게 사용가능
--테이블 조인의 개념은 PK=FK관계에 따라서 사용됨
--테이블 조인을 사용할 때는 관계조건(PK=FK)을 사용해서 테이블과 연결함 (서브쿼리 PK=FK와 같은 원리)
--테이블 조인에는 Inner Join, Outer Join(left, right), Self Join이 대표적
--PK=FK는 관계없지만 값을 이용해 연결할 때는 자연적인 조인이라 한다
--국제표준(ANSI)와 일반방식(데이터베이스 시스템 종속 코드)이 있음
--ANSI방식의 조인은 어느 데이터베이스 시스템에도 사용가능

/* Cross Join */
-- 일반 방식
-- 테이블1 행 수 * 테이블2 행 수 만큼 조회됨
-- 관계조건 없음 (무조건 모든 행과 행을 크로스 해서 조회)
-- 데이터가 매우 많은 경우 굉장히 오래 걸림으로 위험 ! 잘 생각하고 사용 !!
Select mem_id, cart_no, prod_name, lprod_nm, buyer_name
From member, cart, prod, lprod, buyer
Where mem_id = 'a001';

-- 국제표준 방식
Select *
From member Cross Join cart
            Cross Join prod
            Cross Join lprod
            Cross Join buyer
Where mem_id = 'a001' and prod_name like '%삼성%';


/* Inner Join */
/* 주문 내역이 있는 회원에 대하여 회원아이디, 회원이름, 주문수량, 상품코드 조회 */
-- 일반 방식
Select mem_id, mem_name, cart_qty, cart_prod
From member, cart
Where mem_id = cart_member; --관계조건식 작성(PK=FK 정의)

-- 국제표준 방식
Select mem_id, mem_name, cart_qty, cart_prod
From member Inner Join cart
            On (mem_id = cart_member
                and substr(mem_name,1,1) = '이');
                
-- 상품 테이블까지 추가.ver
-- 일반 방식
Select mem_id, mem_name, cart_qty, cart_prod, prod_name
From member, cart, prod
Where mem_id = cart_member
        and cart_prod = prod_id
        and substr(mem_name,1,1) = '이';

-- 국제표준 방식     
Select mem_id, mem_name, cart_qty, cart_prod, prod_name
From member Inner Join cart
            On (mem_id = cart_member
                and substr(mem_name,1,1) = '이')
            Inner Join prod
            On (prod_id = cart_prod);
            
            
-- 조회 : 회원아이디, 회원이름, 주문번호, 상품명, 상품분류명, 거래처명
-- 정렬 : 회원이름 Asc
-- 테이블에 문제가 있어서 lprod와 buyer는 연관관계(lprod_gu = buyer_lgu)가 없다 생각할 것
-- 일반 방식
Select mem_id, mem_name, cart_no, prod_name, lprod_nm, buyer_name
From member, cart, prod, lprod, buyer
Where mem_id = cart_member
    and prod_id = cart_prod
    and prod_lgu = lprod_gu
    and prod_buyer = buyer_id
Order By mem_name Asc;

-- ANSI
Select mem_id, mem_name, cart_no, prod_name, lprod_nm, buyer_name
From cart Inner Join member
            On cart_member = mem_id
            Inner Join prod
            On cart_prod = prod_id
            Inner Join lprod
            On prod_lgu = lprod_gu
            Inner Join buyer
            On prod_buyer = buyer_id
Order By mem_name;

-- 상품분류별로 상품의 개수를 조회
-- 조회 : 상품분류코드, 상품분류명, 상품의 개수(별칭 cnt)
-- 정렬 : cnt기준 Desc
Select lprod_gu, lprod_nm, count(prod_id) as cnt
From lprod, prod
Where prod_lgu = lprod_gu
Group By lprod_gu, lprod_nm
Order By cnt Desc;

Select lprod_gu, lprod_nm, count(prod_id) as cnt
From lprod Inner Join prod
            On prod_lgu = lprod_gu
Group By lprod_gu, lprod_nm
Order By cnt Desc;


/* 테이블 별칭 */
-- 테이블 내에 같은 이름의 변수가 존재한다면 꼭 사용해야 함
Select LP.lprod_gu, lprod_nm, count(prod_id) as cnt
From lprod LP, prod P
Where prod_lgu = lprod_gu
Group By lprod_gu, lprod_nm
Order By cnt Desc;

-- '서울' 또는 '대전'지역에 거주하는 회원이 구매한 상품정보를 조회
-- 상품명에 '삼성'이 포함되어야 한다
-- 조회 : 회원이름, 거주지역, 상품명, 상품분류명, 거래처명
-- 정렬 : 회원이름 Asc
-- 일반
Select Distinct mem_name, substr(mem_add1,1,2) as mem_add, prod_name, lprod_nm, buyer_name
From member, prod, lprod, buyer, cart
Where mem_id = cart_member
    and prod_id = cart_prod
    and prod_lgu = lprod_gu
    and prod_buyer = buyer_id
    and (substr(mem_add1,1,2) = '서울' or substr(mem_add1,1,2) = '대전')
    and prod_name like '%삼성%'
Order By mem_name Asc;

-- ANSI
Select Distinct mem_name, substr(mem_add1,1,2) as mem_add, prod_name, lprod_nm, buyer_name
From cart Inner Join member
        On (mem_id = cart_member
            and substr(mem_add1,1,2) in ('서울', '대전'))
        Inner Join prod
        On (prod_id = cart_prod
            and prod_name like '%삼성%')
        Inner Join lprod
        On prod_lgu = lprod_gu
        Inner Join buyer
        On prod_buyer = buyer_id
Order By mem_name Asc;