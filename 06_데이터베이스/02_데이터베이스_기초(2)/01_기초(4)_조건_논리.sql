-- 조건_논리

-- 상품판매가가 17만원 이상이고, 20만원 이하인 상품정보 전체를 조회해라.
-- 상품코드를 기준으로 내림차순, 상품명을 기준으로 오름차순 정렬하라.
Select *
From prod
where prod_sale >= 170000 and prod_sale <= 200000
Order By prod_id Desc, prod_name Asc;

-- 상품분류코드가 P201이고, 상품판매가격이 17만원 또는 20만원인 상품정보 조회
-- 조회 : 상품분류코드, 상품명, 상품판매가격
-- 정렬 : 상품분류코드-Asc, 상품판매가격-Desc
Select prod_lgu, prod_name, prod_sale
From prod
Where prod_lgu = 'P201' and (prod_sale = 170000 or prod_sale = 200000)
Order By prod_lgu Asc, prod_sale Desc;

-- Not조건
Select prod_lgu, prod_name, prod_sale
From prod
Where prod_lgu = 'P201' and Not (prod_sale = 170000 or prod_sale = 200000)
Order By prod_lgu Asc, prod_sale Desc;

-- 상품 판매가격이 15만원, 17만원, 33만원인 상품들 조회하기
-- 조회 : 상품코드, 상품명, 판매가격
-- 정렬 : 상품코드 오름차순, 상품명 내림차순, 판매가격 오름차순
-- 1. 논리연산자 사용
SELECT prod_id, prod_name, prod_sale
From prod
Where prod_sale = 150000 
        or prod_sale = 170000
        or prod_sale = 330000
Order By prod_id Asc, prod_name Desc, prod_sale Asc;

-- 2. in() : 포함관계
SELECT prod_id, prod_name, prod_sale
From prod
Where prod_sale in(150000, 170000, 330000)
Order By prod_id Asc, prod_name Desc, prod_sale Asc;


/* 서브쿼리(SubQuery) */
-- 1. 테이블명 대신 사용 : inline View라는 명칭이 있다.(View Table)
Select *
From(SELECT prod_id, prod_name, prod_sale
        From prod
        Where prod_sale in(150000, 170000, 330000)
        Order By prod_id Asc, prod_name Desc, prod_sale Asc);
        
-- 주문내역이 있는(=Cart table) 회원아이디를 조회해라
-- 중복이 있다면 중복삭제처리해라
Select DISTINCT cart_member
From Cart;

-- 2. Where절에 서브쿼리 사용하기
Select prod_id
From prod;
                    
Select *
From prod
where prod_id in (Select prod_id
                    From prod);
                    
-- 한번이라도 주문한 내역이 있는 회원아이디, 회원이름 조회하기
Select mem_id, mem_name
From member
Where mem_id in (Select cart_member
                    From cart);
                    
Select Distinct cart.cart_member, member.mem_name
From member, cart
Where cart.cart_member = member.mem_id;

-- 3. select절에 서브쿼리 사용하기
-- 여러개(col전체)여서 error -> where로 값 하나씩 조건줘야함
-- 읽는 순서 : Main Query From - cart > Main Query Select의 cart_member읽어옴 (> SubQuery From - member > Select - mem_name (Error -> Where추가) > Where - mem_id=cart_member이름 찾은 값을 cart_member 1행과 대조 후) mem_name이라는 열의 값으로 출력
Select mem_name
From member
Where mem_id = 'a001';

Select Distinct cart_member,
               (Select mem_name
                From member
                Where mem_id = cart_member) as mem_name
From cart;


/* not in */
-- 주문을 한번도 한적없는 회원의 회원아이디, 회원이름을 조회해라
Select mem_id, mem_name
From member
Where mem_id not in (Select cart_member
                    From cart);
                    
Select Distinct cart_member
From cart; -- 23명

Select mem_id
From member; -- 24명

-- 상품정보에 존재하지 않는 상품분류코드와 상품분류명을 조회해라
Select lprod_gu, lprod_nm
From lprod
Where lprod_gu not in (Select prod_lgu
                        From prod);

-- 판매가격이 10만원 이상이고, 30만원 이하인 상품코드, 상품분류코드, 판매가격 조회
Select prod_id, prod_lgu, prod_sale
From prod
Where prod_sale>=100000 and prod_sale<=300000;


/* 범위연산(A이상 B이하) : Between A and B */
Select prod_id, prod_lgu, prod_sale
From prod
Where prod_sale Between 100000 and 300000;

-- 회원 생일이 75년 1월 1일부터 76년 12월 31일 사이에 태어난 회원을 조회해라
-- 조회 : 회원아이디, 이름, 생일
-- 정렬 : 생일 오름차순
Select mem_id, mem_name, mem_bir
From member
Where mem_bir Between '75/1/1' and '76/12/31'
Order By mem_bir Asc;

Select mem_id, mem_name, mem_bir
From member
Where mem_bir Between '76/12/31' and '75/1/1'
Order By mem_bir Asc; -- 결과값 없음

-- 판매가격이 10만원 이상이고, 30만원 이하인 상품코드, 상품분류코드, 상품분류명, 판매가격 조회
Select prod_id, prod_lgu, prod_sale, (Select lprod_nm
                                    From lprod
                                    Where lprod_gu = prod_lgu) as lprod_nm
From prod
Where prod_sale Between 100000 and 300000;

-- a001 회원이 지금까지 주문한 정보를 확인하려한다
-- 조회 : 회원아이디, 회원이름, 주문번호, 상품명, 상품코드
-- 정렬 : 주문번호 Desc
-- 사용할 Table : cart, prod, member
Select cart_member, cart_no, cart_prod, (Select prod_name
                                        From prod
                                        Where prod_id=cart_prod) as prod_name, (Select mem_name
                                                                                From member
                                                                                Where mem_id=cart_member) as mem_name
From cart
Where cart_member = 'a001'
Order By cart_no Desc;

-- 회원이름이 김은대인 사람이 주문한 상품의 분류코드와 분류명을 알고자 한다
-- 조회 : 상품분류코드, 상품분류명
-- cart 기준
Select Distinct (Select prod_lgu From prod Where cart_prod = prod_id) as prod_lgu,
                (Select lprod_nm from lprod where lprod_gu = (select prod_lgu from prod where prod_id = cart_prod)) as lprod_nm
From cart
Where cart_member = (Select mem_id From member where mem_name='김은대');

-- lprod 기준
Select lprod_gu, lprod_nm
From lprod
Where lprod_gu in (Select prod_lgu from prod where prod_id in
                    (Select cart_prod from cart where cart_member = (Select mem_id from member where mem_name='김은대')));

-- prod 기준
Select Distinct (Select lprod_gu from lprod where lprod_gu=prod_lgu) as lprod_gu,
        (Select lprod_nm from lprod where lprod_gu=prod_lgu) as lprod_nm
From prod
Where prod_id in (Select cart_prod from cart where cart_member = (Select mem_id from member where mem_name='김은대'));


-- 회원아이디, 회원이름, 상품분류코드 ,상품분류명, 거래처명 조회
Select distinct cart_member,
    (select mem_name from member where mem_id = cart_member)as mem_name,
    (Select lprod_gu from lprod where lprod_gu = (Select prod_lgu from prod where prod_id = cart_prod)) as lprod_gu,
    (Select lprod_nm from lprod where lprod_gu = (Select prod_lgu from prod where prod_id = cart_prod)) as lprod_nm,
    (Select buyer_name from buyer where buyer_id = (Select prod_buyer from prod where prod_id = cart_prod)) as buyer_name
from cart
where cart_member = (Select mem_id from member where mem_name='김은대');

-- from 서브쿼리 연습
Select *
From (Select Distinct (Select lprod_gu from lprod where lprod_gu=prod_lgu) as lprod_gu,
        (Select lprod_nm from lprod where lprod_gu=prod_lgu) as lprod_nm
    From prod
    Where prod_id in (Select cart_prod from cart where cart_member = (Select mem_id from member where mem_name='김은대')));
  
    
---------------------------------------
/* 특정 컬럼의 값에 특정문자가 있으면 조회하기 */
--게시물에서 이름검색, 제목검색할 때 사용되는 SQL구문
--Like 명령어 사용

-- 회원의 이름 중 성씨가 '이'씨인 회원 찾기
Select mem_name
From member
Where mem_name Like '이%';

-- '쁜'이라는 단어가 포함되어 있는 회원 찾기
Select mem_name
From member
Where mem_name Like '%쁜%';

-- '이'로 끝나는 회원 찾기
Select mem_name
From member
Where mem_name Like '%이';

-- 두번째 단어가 은으로 시작하는 모든 데이터 조회
Select mem_name
From member
Where mem_name Like '_은%';

-- 세번째 단어가 '대'로 시작하는 모든 데이터 조회
Select mem_name
From member
Where mem_name Like '__대%';

-- 주민등록번호 중에 75년생만 조회
Select *
From member
Where mem_regno1 Like '75%';

-- 주민등록번호 중에 75년생이 아닌 사람만 조회
Select *
From member
Where mem_regno1 not Like '75%';

-- 조회 : 회원아이디, 회원이름
-- 회원이름의 성씨가 '김'인 사람 중에 상품명에 '삼성'이 포함되어있는 상품을 구매한 회원들을 조회
select mem_id, mem_name
From member
Where mem_name like '김%' and mem_id in (Select cart_member from cart where cart_prod in (Select prod_id 
                                                                                           from prod where prod_name like '%삼성%'))