/* 1조 */
-- 5~8월달이 생일인 회원이 주문한 제품의 제품명과 해당 제품의 거래처명 
-- 그리고 상품분류명을 출력해주세요.                        
Select distinct prod_name, buyer_name, lprod_nm
From cart, member, prod, buyer, lprod
Where cart_member = mem_id
    and cart_prod = prod_id
    and prod_lgu = lprod_gu
    and prod_buyer = buyer_id
    and to_char(mem_bir,'mm') between 5 and 8;
--------------------------------------------------------------------------
-- 대전 동구에 거주하는 남성이 구매한 상품중 순수익률 25% 이상을 가지는 상품을 구해라
-- 순수익률 (판매가 - 매입가) / 매입가 * 100
-- 출력컬럼 상품명 순수익률
Select prod_name, nvl(((prod_sale - prod_cost) / prod_cost *100),0) as prod_pure
From cart inner join prod
            On prod_id = cart_prod
            inner join member
            On cart_member = mem_id
                and substr(mem_add1,1,6) = '대전시 동구'
                and mod(substr(mem_regno2,1,1),2) = 1
Where ((prod_sale - prod_cost) / prod_cost *100) > 25;
-------------------------------------------------------------------------------------------------------
-- 주문내역 중 상품분류명 글자가 '화장품'인 회원의 아이디와 비밀번호를 대문자로 변경하기
Select distinct upper(mem_id) as mem_id, upper(mem_pass) as mem_pass
From lprod, member, prod, cart
Where cart_prod = prod_id
        and cart_member = mem_id
        and prod_lgu = lprod_gu
        and lprod_nm = '화장품';

Select distinct cart_member
From cart
Where substr(cart_prod,1,4)='P302'; --확인용
-------------------------------------------------------------------------------
-- 상품 개략설명이나 상세설명에 '편리한'이라는 단어가 있는 제품 중, 안전재고수량이 20 미만인 제품을 산 사람 모든 회원정보 조회하기
Select member.*
From member, prod, cart
Where mem_id = cart_member
    and prod_id = cart_prod
    and (prod_outline like '%편리한%' or prod_detail like '%편리한%')
    and prod_properstock < 20;
--------------------------------------------------------------------------------
/* 모든 회원의 회원이름, 주민등록번호, 성별을 조회해주세요. */
-- 주민등록번호와 성별은 아래와 같은 형태로 출력해주세요.
-- 주민등록번호 000000-0******
-- 성별컬럼을 만들어 '남' or '여' 표기해주세요 
Select mem_name, (mem_regno1 || '-' || Rpad(substr(mem_regno2,1,1),6,'*')) as mem_regno, decode(mod(substr(mem_regno2,1,1),2),1,'남','여') as mem_sex
From member;
--------------------------------------------------------------------------------
-- 마일리지가 2500 이상인 사람들이 산 상품명, 판매가, 상품분류명를 조회
-- 조회할때 판매가가 높은 순서부터 조회
Select Distinct prod_name, prod_sale, lprod_nm
From member, prod, lprod, cart
Where cart_member = mem_id
    and cart_prod = prod_id
    and prod_lgu = lprod_gu
    and mem_mileage >= 2500
Order By prod_sale Desc;
--------------------------------------------------------------------------
-- Q) 기념일이 '생일'이고 날짜가 '9월'인 회원들의 주문한 상품의 입고일자가 언제인지 확인하기
-- prod 테이블 사용 x
-- 입고상품정보 전체 조회하기
-- '생일'과 '생신' 모두 조회하기
Select buyprod.*
From buyprod inner join cart
                on buy_prod = cart_prod
                inner join member
                on cart_member = mem_id
                    and mem_memorial like '%생일%'
                    and to_char(mem_memorialday, 'mm') = 9;
                    
Select distinct buyprod.*
From buyprod inner join cart
                on buy_prod = cart_prod
                inner join member
                on cart_member = mem_id
                    and (mem_memorial like '%생신%' or mem_memorial like '%생일%')
                    and to_char(mem_memorialday, 'mm') = 9;
                    
                    

/* 2조 */
--문제 1.
--의류 주문 금액(cart_qty*prod_sale)이 500 만원 이상인 회원 이름, 회원 id, 주문 금액 조회
Select mem_name, mem_id, (cart_qty*prod_sale) as cart_price
From cart inner join member
            On cart_member = mem_id
            inner join prod
            on cart_prod = prod_id
                and (cart_qty*prod_sale) >= 5000000;
--문제 2.
--구매상품의 색상이 흑색이고 9월에 기념일이 있는 회원의 직업 조회하기
Select mem_job
From cart inner join member
            On (cart_member = mem_id
                and to_char(mem_memorialday, 'mm') = 9)
            inner join prod
            on cart_prod = prod_id
                and prod_color = '흑색';
--문제3.
--3-1.상품 테이블에 마일리지컬럼에 마일리지 값 넣기(P1(전자) 개당 500P, P2(의류) 개당 150P, P3(화장품) 개당 50P)
select prod_mileage
From prod;

Update prod
    set prod_mileage = decode(substr(prod_lgu,1,2),
                                'P1', 500,
                                'P2', 150,
                                'P3', 50);

select prod_mileage
From prod; --확인용
--3-2.구매내역에도 구매마일리지컬럼(CART_MILEAGE)을 만들어서 구매제품과 수량에 맞춰 구매자에게 마일리지 값 넣기
Alter table cart add(CART_MILEAGE number(15)); --col생성

Update cart
    set CART_MILEAGE=decode(substr(cart_prod,1,2),
                                'P1', 500*cart_qty,
                                'P2', 150*cart_qty,
                                'P3', 50*cart_qty);
                                
select CART_MILEAGE
From cart; --확인용
--문제4.
--생일이 3월이고 메일이 @hanmail.net으로 끝나는 사람을 조회하기
Select mem_bir, mem_mail
From member
Where to_char(mem_bir,'mm') = 3
        and mem_mail like '%@hanmail.net';
        
Rollback;
                    
                    

/* 3조 */
--1. 라준호가 구매한 물품의 물품명과 거래처명을 출력하세요.
Select prod_name, buyer_name
From member, cart, prod, buyer
Where mem_id = cart_member
    and prod_id = cart_prod
    and prod_buyer = buyer_id
    and mem_name = '라준호';

--2. 회원 생일과 같은 월에 산 제품명과 회원 성명과 남성 여성으로 구성되어있는 새로운 컬럼 성별을 보여주세요
Select prod_name, mem_name, decode(mod(substr(mem_regno2,1,1),2),1,'남성','여성') as mem_sex
From member, cart, prod
Where mem_id = cart_member
    and prod_id = cart_prod
    and substr(cart_no,5,2) = to_char(mem_bir,'mm');
                    
                    


/* 5조 */
--1. 회원들이 구매한 물품의 금액을 (as mount)을 각각 구하시오
--조회 컬럼은 mem_name, mem_id, prod_sale , cart_qty, mount, lprod_nm
Select distinct mem_name, mem_id, prod_sale , cart_qty, (cart_qty*prod_sale)as mount, lprod_nm
From member, prod, cart, lprod
Where mem_id = cart_member
    and prod_id = cart_prod
    and prod_lgu = lprod_gu;

--2. 입고 상품정보에서 상품코드별 상품명과 상품의 이윤값을 구하세요 .  ? (group by 사용)
--이윤 = 상품매출(cart테이블에서 팔린 제품의 수량 * 판매가)  - 상품매입비용(매입수량*매입단가)
Select distinct buy_prod, prod_name, sum((cart_qty*prod_sale)-(buy_qty*buy_cost))as price
From prod, cart, buyprod
Where prod_id = cart_prod
    and prod_id = buy_prod
Group by buy_prod, prod_name;

--3. 서울 외 지역에 있는 거래처와 거래한 상품들 중에 입고된 상품 조회
--- 조회 : 거래처명, 상품명, 상품 전화번호(거래처)
--- 정렬 : 거래처명으로 오름차순
Select distinct buyer_name, prod_name, buyer_comtel
From buyer, prod
Where prod_buyer = buyer_id
    and substr(buyer_add1,1,2) != '서울'
    and prod_lgu = buyer_lgu
Order By buyer_name Asc;

--4.  할인율이 10% 이하이고, 거래처명에 삼성이 들어가는 상품을 구매한 
--회원의 이름과 직업, 할인율, 구매 상품의 상품명을 조회하기
--- 조회는 회원이름, 회원직업, 할인율, 상품명
--- 할인율은 (소비자가 - 판매가/소비자가 * 100)
Select mem_name, mem_job, ((prod_price - (prod_sale/prod_price))*100)as sale, prod_name
From member, cart, prod
Where prod_id = cart_prod
    and mem_id = cart_member
    and ((prod_price - (prod_sale/prod_price))*100)<= 10;