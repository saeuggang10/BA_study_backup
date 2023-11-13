/* Null 처리하기 */

/* 결측치 있는 테이블 만들기 */
-- 일부 데이터를 null로 업데이트(=수정) 후 null 체크

-- 1. 수정할 데이터 검증용 Select문 만들기
-- 거래처 담당자 중 '이'씨에 대해 조회하라
Select *
From buyer
Where buyer_charger like '이%';
-- 조회결과 : 2건(이수나, 이진영)

-- 2. 조회결과(담당자 이름) -> Null로 수정(Update)
Update buyer
    Set buyer_charger = null
    Where buyer_charger like '이%';
    
-- 3. 검증용 Select을 이용해 수정되었는지 확인
Select *
From buyer
Where buyer_charger like '이%';
-- 조회결과 : 0건

-- null확인
-- null은 메모리 공간을 차지하지 않는다 -> 따라서, 값에 대한 비교불가
Select buyer_charger
From buyer
Where buyer_charger is null; --is null : Where에서만 사용가능함

-- null 대체값 넣기 : nvl, nvl2()
-- nvl가장 많이 사용
Select buyer_charger, nvl(buyer_charger, '넌 누구?'), nvl2(buyer_charger, 'null이 아님', 'null이네')
From buyer
Where buyer_charger is null;


-- 회원 중에 '이'씨가 구매한 상품정보 조회하기
-- 조회 : 상품코드 ,상품명, 소비자 가격
Select prod_id, prod_name, prod_price
From prod
Where prod_id in (Select cart_prod From cart
                                    where cart_member in (Select mem_id From member
                                                                        where mem_name like '이%'));

-- 위 조건에 대한 소비자가격의 값을 null로 수정하기
Update prod
    Set prod_price = 0
    Where prod_id in (Select cart_prod From cart
                                    where cart_member in (Select mem_id From member
                                                                        where mem_name like '이%'));
                                                                        
-- 확인
Select prod_id, prod_name, prod_price
From prod
Where prod_id in (Select cart_prod From cart
                                    where cart_member in (Select mem_id From member
                                                                        where mem_name like '이%'));
                                                                        
-- 결측 데이터 처리
-- 소비자 가격이 0인경우 소비자가격의 전체 평균값으로 수정    
Select avg(nvl(prod_price,0)), sum(nvl(prod_price,0))
From prod;

Select avg(nvl(prod_price,0))
From prod
Where prod_price != 0;

Update prod
    Set prod_price = (Select avg(nvl(prod_price,0))
                      From prod
                      Where prod_price != 0)
    Where prod_price = 0;
    

-- 조회 : 거래처명, 거래처담당자
-- null인 담당자는 '넌 누구?'로 조회하기
-- 단, 거래처은행이 '주택은행'인 데이터에대해서만 조회
-- 정렬 : 거래처담당자 Asc
Select buyer_name, nvl(buyer_charger, '넌 누구?') as buyer_charger
From buyer
Where buyer_bank = '주택은행'
Order By buyer_charger Asc;

-- 조회 : 회원아이디, 회원마일리지의 평균/ 총합/최대값/최소값 조회하기
-- 단, 지역이 서울에 사람사람의 마일리지가 평균 이상인 회원들에 대해서만 조회
Select mem_id, avg(nvl(mem_mileage,0)) as avg, sum(nvl(mem_mileage,0)) as sum, max(nvl(mem_mileage,0)) as max, min(nvl(mem_mileage,0)) as min
From member
Where mem_mileage >= (Select avg(mem_mileage)
                        From member
                        Where substr(mem_add1,1,2) = '서울')
Group by mem_id;

-- null로 변환하는 함수
Select Nullif('abc','abc'), Nullif('abc', 'ab')
From dual;

-- 지역이 대전인 경우에 null로 변환해서 조회하라
-- 조회 : 회원아이디, 지역
Select mem_id, nullif(substr(mem_add1,1,2), '대전') as mem_add
From member;


/* if문과 동일한 함수 : Decode() */
-- 컬럼 대신 사용
-- Decode(조건값, 비교값1, 처리값1,
--                비교값2, 처리값2)
--                비교값n, 처리값n
--                기타값)
Select Decode(substr(mem_add1, 1, 2),
                '대전', '대전지역',
                '기타') as add1
From member; 

-- 조회 : 상품명, 상품분류명
-- 상품분류코드 앞자리 2개가 P1이면 컴퓨터/전자 제품, p2면 의류, p3면 잡화, 그 외 기타분류로 조회하라
Select prod_name, Decode(substr(prod_lgu, 1, 2),
                        'P1', '컴퓨터/전자 제품',
                        'P2', '의류',
                        'P3', '잡화',
                        '기타분류') as prod_lgu
From prod;

-- 조회 : 회원아이디, 회원이름, 성별
-- 성별은 남자, 여자로 출력
Select mem_id, mem_name, Decode(Mod(Substr(mem_regno2, 1, 1), 2),
                                1, '남자',
                                '여자') as 성별
From member;

-- 조회 : 상품명, 상품판매가격, 상품판매가격의 인상값
-- 상품판매가격의 인상값 : 상품분류코드의 앞 2자리를 기준으로 'P1'이면 판매가격 10%인상된 값으로 조회, 'P2'면 15%인상된 값으로 조회 나머지는 그대로 조회
-- 정렬 : 인상값 Desc
Select prod_name, prod_sale, Decode(substr(prod_lgu,1,2),
                                    'P1', prod_sale+(prod_sale*0.1),
                                    'P2', prod_sale+(prod_sale*0.15),
                                    prod_sale)as prod_price_up
From prod
Order by prod_price_up Desc;

-- 조회 : 상품분류코드별 상품등급
-- 상품등급은 아래와 같이 처리
/* 상품분류코드별로 상품의 개수를 체크하여
5이하 -> A등급
10이하 -> B등급
15이하 -> C등급
20이하 -> D등급
25이하 -> E등급
그 외 -> F등급 */
Select prod_lgu, count(prod_lgu), (case
                                    When count(prod_lgu)<=5 Then 'A등급'
                                    When count(prod_lgu)<=10 Then 'B등급'
                                    When count(prod_lgu)<=15 Then 'C등급'
                                    When count(prod_lgu)<=20 Then 'D등급'
                                    When count(prod_lgu)<=25 Then 'E등급'
                                    Else 'F등급'
                                    End) as prod_cnt_rank
From prod
Group By prod_lgu;

--회원이름, 성별 조회 ->case사용해서
Select mem_name, (Case
                    When Mod(Substr(mem_regno2,1,1), 2) = 0 Then '여성'
                    Else '남성'
                    End) as mem_sex
From member;

--상품 구매월별 구매수량의 평균, 등급을 조회
-- 등급은 평균이 10보다 크면 A등급, 이외는 B등급으로 처리
-- 단, 구매 상품분류 중에 '캐주얼'이라는 분류명이 포함된 경우와, 상품명에 '바지'가 포함된 경우만 조회
Select substr(cart_no,5,2) as chart_mon,
    avg(cart_qty) as qty_avg,
    (Case When avg(cart_qty)>10 Then 'A등급' --그룹함수를 이용해 처리함으로 group by에 넣지 않아도 된다
        Else 'B등급'
        End) as qty_rank
From cart
Where cart_prod in (Select prod_id From prod Where prod_name like '%바지%')
    and cart_prod in (Select prod_id From prod Where prod_lgu in (Select lprod_gu from lprod where lprod_nm like '%캐주얼%'))
Group By substr(cart_no,5,2);


/* Exists()함수 : Where절에 조건으로 사용 */
-- 주문내역이 있는 회원정보
Select *
From member
Where Exists(Select * From cart Where cart_member = mem_id);