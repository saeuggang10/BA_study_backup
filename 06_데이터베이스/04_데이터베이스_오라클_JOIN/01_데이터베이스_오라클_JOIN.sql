/* 뇌풀기 */
--조회 : 상품분류명, 상품아이디, 상품판매가, 거래처담당자, 회원아이디, 주문수량
--단, 상품분류코드가 P101인 것에 대해서
--일반 방식
Select lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
From lprod, prod, buyer, cart
Where cart_prod = prod_id
    and prod_lgu = lprod_gu
    and prod_buyer = buyer_id
    and prod_lgu = 'P101';

--ANSI 방식
Select lprod_nm, prod_id, prod_sale, buyer_charger, mem_id, cart_qty
From cart Inner Join member
          On cart_member = mem_id
          Inner Join prod
          On (cart_prod = prod_id)
            and (prod_lgu = 'P101')
          Inner Join lprod
          On prod_lgu = lprod_gu
          Inner Join buyer
          On prod_buyer = buyer_id;
          

-- 회원 마일리지의 전체 평균 이상인 회원들에 대한 취미별 회원수를 조회해라
-- 조회 : 회원취미, 회원수
Select mem_like, count(mem_id)
From member
Where mem_mileage >= (Select avg(mem_mileage)
                        From member)
Group by mem_like;


-- 회원의 성씨가 '이'씨이고, '서울, 대전, 부산, 광주'에 거주하는 회원들의 평균 마일리지 이상인 회원이 구매한 상품정보 조회하기
-- 조회 : 상품코드, 상품명, 주문일자, 주문수량, 회원아이디, 회원지역, 마일리지 조회
-- 단, 상품명에 '삼성'이 포함된 경우
Select cart_prod, prod_name, to_char(substr(cart_no,1,8),'yyyy-mm-dd') as cart_date,
        cart_qty, mem_id, substr(mem_add1,1,2) as mem_add, mem_mileage
From cart Inner join prod
            On (cart_prod = prod_id
                and prod_name like '%삼성%')
          Inner Join member
            On (cart_member = mem_id
                and substr(mem_name,1,1) = '이'
                and (substr(mem_add1,1,2) = '서울' or substr(mem_add1,1,2) = '대전' or substr(mem_add1,1,2) = '부산' or substr(mem_add1,1,2) = '광주'))
Where mem_mileage >= (Select avg(mem_mileage)
                        From member);
-- 결과 0개
                        
Select cart_prod, prod_name, substr(cart_no,1,8) as cart_date,
        cart_qty, mem_id, substr(mem_add1,1,2) as mem_add, mem_mileage
From cart Inner join prod
            On (cart_prod = prod_id
                and prod_name like '%삼성%')
          Inner Join member
            On cart_member = mem_id
                and mem_mileage >= (Select avg(mem_mileage)
                                    From member
                                    Where substr(mem_name,1,1) = '이'
                                        and substr(mem_add1,1,2) in ('서울', '대전', '부산', '광주'));
-- 결과 1개

-- 조회 : 상품코드, 상품명, 상품분류명, 거래처명, 거래처지역
-- 상품판매가격이 10만원 이하이고, 거래처 지역이 '부산'인 경우만 조회하기
Select prod_id, prod_name, lprod_nm, buyer_name, substr(buyer_add1,1,2) as buyer_add
From prod Inner Join lprod
          On (prod_lgu = lprod_gu
            and prod_sale <= 100000)
          Inner Join Buyer
          On (prod_buyer = buyer_id
            and substr(buyer_add1,1,2) = '부산');
            
-- 조회 : 상품분류명, 거래처명
-- 단, 상품분류코드가 P101, P201, P301인 것, 매입수량이 15개 이상인 것, 서울에 거주하고 생일이 1974년생인 회원에 대하여
Select distinct lprod_nm, buyer_name
From prod Inner Join lprod
          On (prod_lgu = lprod_gu
            and lprod_gu in ('P101', 'P201', 'P301'))
          Inner Join buyer
          On prod_buyer = buyer_id
          Inner Join buyprod
          On prod_id = buy_prod
            and buy_qty >= 15
          Inner Join cart
          On prod_id = cart_prod
          Inner Join member
          On (cart_member = mem_id
            and substr(mem_regno1,1,2) = '74'
            and substr(mem_add1,1,2) = '서울');
            
            
-- 조회 : 거래처코드, 거래처명, 매입금액의 합
-- 매입일자가 2005년 1월인 것에 대해서
-- 매입금액 = 매입수량 * 매입단가
-- 매입금액이 null이면 0으로 변환
Select buyer_id, buyer_name, to_char(sum(nvl((buy_qty * buy_cost),0)), 'L999,999,999') as buy_price_sum
From prod Inner Join buyer
          On prod_buyer = buyer_id
          Inner Join buyprod
          On prod_id = buy_prod
            and to_char(buy_date,'yymm') = '0501'
Group By buyer_id, buyer_name;


/* Outer Join */
-- 회원별 주문수량의 합 조회
-- 조회 : 회원아이디, 회원이름, 주문수량의 합
-- 회원 전체(총 24명)에 대한 주문수량의 합 !
Select cart_member, mem_name, sum(nvl(cart_qty,0)) as qty_sum
From cart, member
Where mem_id = cart_member(+) -- outer join이란 뜻
Group by cart_member, mem_name; --24행

Select cart_member, mem_name, sum(nvl(cart_qty,0)) as qty_sum
From cart, member
Where cart_member = mem_id(+) -- outer join이란 뜻
Group by cart_member, mem_name; --23행

Select cart_member, mem_name, sum(nvl(cart_qty,0)) as qty_sum
From member Left Outer Join cart
          On mem_id = cart_member
Group by cart_member, mem_name;

-- Outer join + 일반조건
-- 마일리지가 3000이상인 회원 조회
Select cart_member, mem_name, sum(nvl(cart_qty,0)) as qty_sum
From cart, member
Where mem_id = cart_member(+) -- outer join이란 뜻
    and mem_mileage >= 3000
Group by cart_member, mem_name; -- 7행

Select cart_member, mem_name, sum(nvl(cart_qty,0)) as qty_sum
From member Left Outer Join cart
          On (mem_id = cart_member
            and mem_mileage >= 3000)
Group by cart_member, mem_name; -- 24행

Select cart_member, mem_name, sum(nvl(cart_qty,0)) as qty_sum
From member Left Outer Join cart
          On mem_id = cart_member
Where mem_mileage >= 3000
Group by cart_member, mem_name; -- 7행


-- 상품분류 >>전체에 대한<< 상품의 개수를 조회
-- 조회 : 상품분류코드, 상품분류명, 상품의 개수
-- 단, 상품명에 '삼성'이 포함인 경우
Select lprod_gu, lprod_nm, count(nvl(prod_id, 0)) as cnt
From lprod left outer join prod
            On (prod_lgu = lprod_gu
                and prod_name like '%삼성%')
Group By lprod_gu, lprod_nm;
--Having count(prod_id) > 1; --조건이 붙으면서 전체라는 전제조건이 깨짐

-- 전체 상품에 대한 상품코드, 상품명, 매입수량의 합 조회
-- 입고일자가 2005년 1월에 대한 전체 조회
Select prod_id, prod_name, sum(nvl(buy_qty, 0)) as qty_sum
From prod left outer join buyprod
            On (prod_id = buy_prod
                and to_char(buy_date,'yyyymm') = '200501')
Group By prod_id, prod_name;


-- 아이디가 h001인 회원의 마일리지보다 높은(이상) 회원들을 조회
-- 조회 : 회원아이디, 이름, 마일리지
Select mem_id, mem_name, mem_mileage
From member
Where mem_mileage >= (Select mem_mileage
                        From member
                        Where mem_id = 'h001');
                        
/* Self Join */
-- 자기 테이블을 2개로 나눠 사용 ( 결과검색용 / 조건용)
Select M1.mem_id, m1.mem_name, m1.mem_mileage
        ,m2.mem_id, m2.mem_name, m2.mem_mileage
From member m1, member m2
Where m2.mem_id = 'h001'
    and m1.mem_mileage >= m2.mem_mileage;
    
    
/* 문제풀기 */
-- 상품 전체에 대한 조회 : 상품아이디, 상품명, 매입수량의 합, 주문수량의 합
-- 입고일자가 2005년 04월 16일인 것
-- 주문일자가 2005년 04월 16일인 것
Select prod_id, prod_name, sum(nvl(buy_qty,0)) as b_qty_sum, sum(nvl(cart_qty,0)) as c_qty_sum
From prod left outer join cart
            On cart_prod = prod_id
                and substr(cart_no,1,8) = '20050416'
            left outer join buyprod
            On prod_id = buy_prod
                and buy_date = '05/04/16'
Group By prod_id, prod_name;

-- date타입 확인용
Select cart_no
From cart
Where substr(cart_no,1,8) = '20050416';

Select buy_date
From buyprod
Where buy_date = '05/04/16';


-- 입고 월별 매입수량의 합, 매입 금액의 합을 조회
-- 입고 년도가 2005년임
-- 매입금액 = 매입수량 * 매입가격
Select to_char(buy_date,'mm') as buy_mon, sum(nvl(buy_qty,0)) as b_qty_sum, to_char(sum(nvl(buy_qty*prod_cost,0)), 'L999,999,999') as b_cost_sum
From buyprod left outer join prod
                on buy_prod = prod_id
                    and to_char(buy_date,'yyyy') = '2005'
Group By to_char(buy_date,'mm')
Order By buy_mon;

-- 2005년도 판매일자, 판매총액의 합, 판매수량의 총합, 판매수량의 총갯수 조회
-- 판매는 주문과 동일. 판매총액 = 판매수량*판매가격
-- 판매총액의 합이 5백만원 이상, 판매수량의 총합이 50이상, 판매수량의 총갯수가 8이상
Select substr(cart_no,1,8) as cart_date, sum(nvl(cart_qty*prod_sale,0)) as sale_sum, sum(cart_qty) as qty_sum, count(cart_qty) as qty_cnt
From cart left outer join prod
            on (cart_prod = prod_id
                and substr(cart_no,1,4) = 2005)
Group By substr(cart_no,1,8)
Having sum(cart_qty*prod_sale) >= 5000000
        and sum(cart_qty) >= 50
        and count(cart_qty)>= 8;