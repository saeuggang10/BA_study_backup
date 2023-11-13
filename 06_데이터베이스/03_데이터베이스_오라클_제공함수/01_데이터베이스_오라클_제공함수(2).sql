/* 뇌풀기 */
--김은대 회원이 구매한 상품 중에 상품명에 '모니터'가 포함된 상품의 구매일자를 확인하려한다
회원아이디, 회원이름, 주문일자, 상품명을 조회
--이름을 기준으로 오름차순정렬
Select (Select mem_id from member where mem_id = cart_member) as mem_id,
        (Select mem_name from member where mem_id = cart_member) as mem_name,
        substr(cart_no,1,8) as cart_date,
        (Select prod_name from prod where prod_id = cart_prod) as prod_name
From cart
Where cart_member in (Select mem_id from member where mem_name = '김은대')
        and cart_prod in (Select prod_id from prod where prod_name like '%모니터%')
Order By (Select mem_name from member where mem_id = cart_member) Asc;

-- 상품분류명, 상품명, 거래처명을 조회하라. 단, 상품명에 삼성이 포함된 경우만
Select (Select lprod_nm from lprod where lprod_gu = prod_lgu) as lprod_nm,
        prod_name,
        (Select buyer_name from buyer where buyer_id = prod_buyer) as buyer_name
From prod
Where prod_name like '%삼성%';

-- 회원아이디, 회원이름을 조회해 주세요
-- 단, 상품분류명 중에 '컴퓨터제품'명을 가지는 상품을 구매한 회원에 대해서만
Select Distinct (Select mem_id from member where mem_id = cart_member) as mem_id,
                (Select mem_name from member where mem_id = cart_member) as mem_name
From cart
Where cart_prod in (Select prod_id from prod where prod_lgu in (Select lprod_gu from lprod where lprod_nm = '컴퓨터제품'));

--prod 없는 버전
Select Distinct (Select mem_id from member where mem_id = cart_member) as mem_id,
                (Select mem_name from member where mem_id = cart_member) as mem_name
From cart
Where substr(cart_prod,1,4) in (Select lprod_gu from lprod where lprod_nm = '컴퓨터제품');

--from : member
Select mem_id, mem_name
From member
Where mem_id in (Select cart_member from cart where cart_prod in (Select prod_id from prod where prod_lgu in (Select lprod_gu from lprod where lprod_nm = '컴퓨터제품')));


/* 날짜 함수 */
-- 날짜와 관련해서는 데이터베이스 시스템마다 다름

-- 시스템 날짜 가져오기
Select sysdate FROM dual;

-- 시스템 날짜에 1더하거나 빼기
Select sysdate, sysdate + 1, sysdate -1
From dual;

-- 회원의 이름, 생일, 12000일째 되는 날을 조회하라
-- 12000일째 되는 날의 별칭은 bir2라 명명
Select mem_name, mem_bir, (mem_bir + 12000) as bir2
From member;

-- 월 더하고 빼기
Select Add_months(sysdate,1), Add_months(sysdate,-1)
From dual;

-- 가장 빠른 요일에 대한 날짜찾기
Select Next_day(sysdate,'일요일')
From dual;

-- 해당 월의 마지막 일자 찾기
Select Last_day(sysdate)
From dual;

Select Last_day('2023-06-23'), Last_day('2023/06/23'), Last_day('20230623')
From dual;

-- 이번달이 몇일남았는가?
Select (Last_day(sysdate)-sysdate) as 남은_날짜
From dual;

-- 
-- q : 분기
Select round(sysdate), round(sysdate, 'yyyy'), round(sysdate, 'mm'), round(sysdate, 'dd'), round(sysdate, 'q')
From dual;

-- 자주 사용되는 함수들
-- 필요한 부분만 발췌
Select Extract(Year from sysdate),
        Extract(Month from sysdate),
        Extract(Day from sysdate)
From dual;

-- 회원의 생일이 3원인 회원만 조회해라
Select *
From member
Where Extract(Month from mem_bir) = 3;

Select *
From member
Where Extract(Month from mem_bir) = '3';

Select 3+3, '3'+3, '3'+'3'
From dual;

-- 타입 변환하기(형변환)
SELECT '-' || cast(123 as char(5)) || '-',
        '-' || cast(123 as varchar2(5)) || '-',
        '-' || cast('20230626' as date) || '-',
        cast('123' as number(5))
From dual;

Select to_char(123), to_date('2023-06-14'), to_number('23456')
From dual;

Select to_char(sysdate),
        to_char(sysdate, 'yyyy-mm-dd') as y1,
        to_char(sysdate, 'yyyy.mm.dd') as y2,
        to_char(sysdate, 'yyyy/mm/dd') as y3,
        to_char(sysdate, 'yyyy*mm*dd') as y4,
        to_char(sysdate, 'yyyy-mm-dd (am)hh24:mi:ss [day]') as y5,
        to_char(sysdate, 'yyyy-mm-dd (am)hh:mi:ss [day]') as y6 -- 12시간 표시
From dual;

-- 상품명, 상품등록일 조회
-- 상품등록일은 '0000-00-00'형태로 조회
Select prod_name, to_char(prod_insdate, 'yyyy-mm-dd') as yy
From prod;

-- 회원 정보를 아래처럼 조회되도록 처리하라
-- '김은대님은 0000년 0월 출생이고, 태어난 요일은 0요일'
SELECT mem_name || '님은 '
    || Extract(Year from mem_bir) || '년 '
    || Extract(Month from mem_bir) || '월 출생이고, 태어난 요일은 '
    || to_char(mem_bir, 'day') as 출생
From member;

-- 숫자포맷 적용하기
Select to_char(1234556, '999,999,999') as num,
        to_char(1234556, 'L999,999,999') as num,
        to_char(1234556, '999,999,999L') as num,
        to_char(1234556, '$999,999,999') as num,
        to_char(-1234556, 'L999,999,999PR') as num,
        '-' || to_char(-1234556, 'L999,999,999PR') || '-' as num, --왼쪽에 공백이 있음을 알 수 있다
        '-' || to_char(-1234556, 'L999,999,999,999,999PR') || '-' as num --더 늘어남 --적당히 값보고 넣어야함. 그냥 막 크게하면 바이트만 잡아먹음
From dual;


-- 회원이 태어난지 몇개월 째인지 조회하라
-- 소수점이 있는 경우 소숫점 첫째자리에서 반올림
-- 조회컬럼 : 회원이름, 회원생일, 태어난지 몇 개월(day2)
Select mem_name, mem_bir,
        round(months_between(sysdate, mem_bir),1) as bir2
From member;

-- 상품코드, 상품명, 매입가격, 소비자가격, 판매가격 조회하기
-- 가격은 천단위 구분 및 원화표시
-- 단, 상품명에 '삼성'이 포함되어있어야 하고, 김씨 성을 가진 회원이 구매한 상품정보만 조회
Select prod_id, prod_name, to_char(prod_cost, 'L999,999,999') as cost, to_char(prod_price, 'L999,999,999') as price, to_char(prod_sale, 'L999,999,999') as sale
From prod
Where prod_name like '%삼성%' and
      prod_id in (Select cart_prod from cart where cart_member in (Select mem_id from member where mem_name like '김%'));
      
-- 아이디 뒷자리 2자리를 추출하여 10을 더한 다음, 원래 앞자리 2자리와 합쳐서 조회하라
Select substr(mem_id,1,2) || (substr(mem_id,3,4)+10) as mem_id_new
From member;

Select substr(mem_id,3,-1)
From member;

-- 주문번호 증가시키기
-- 오늘 년월일 기준으로 최초에 주문이 발생하면 주문번호를 생성해야 합니다
-- 오늘 기준의 주문번호를 생성해라. 주문번호 데이터 확인 후 생성하기
Select to_char(sysdate, 'yyyymmdd') || Lpad(1, 5, '0') as char_no_new
From dual;


/* 그룹함수 (= 기초통계함수) */
-- count, min, max, avg, sum

-- 상품판매가격의 데이터 건수, 최초가격, 최대가격, 평균, 총합 조회하기
Select count(prod_sale), min(prod_sale), max(prod_sale), avg(prod_sale), sum(prod_sale)
From prod;

-- 위의 문제에서 상품명까지 조회하라
-- 일반 col와 그룹함수를 동시에 Select하려면 Group By 함수를 써야한다
Select count(prod_sale), min(prod_sale), max(prod_sale), avg(prod_sale), sum(prod_sale), prod_name
From prod
Group By prod_name;

-- 상품테이블에서 상품분류코드별로 상품의 갯수를 조회하기
Select prod_lgu, count(prod_lgu) as cnt
From prod
Group By prod_lgu
Order By cnt Asc;

Select substr(cart_prod,1,4) as lgu, count(substr(cart_prod,1,4))
From cart
Group By substr(cart_prod,1,4)
Order By lgu Asc;

Select substr(cart_prod,1,4) as lgu, count(substr(cart_prod,1,4))
From cart
Group By substr(cart_prod,1,4) --그룹화
HAVING count(substr(cart_prod,1,4)) > 20 --그룹에 대한 조건
Order By lgu Asc;

-- 그룹함수 + 일반조건
Select substr(cart_prod,1,4) as lgu, count(substr(cart_prod,1,4))
From cart
Where cart_member = 'a001' --일반조건
Group By substr(cart_prod,1,4) --그룹화
HAVING count(substr(cart_prod,1,4)) > 20 --그룹에 대한 조건
Order By lgu Asc;


--상품분류코드별로 상품소비자가격의 평균을 조회하라
--평균은 소수점 2자리까지 표현하라
Select prod_lgu, round(avg(prod_price),2) as price_avg
From prod
Group By prod_lgu;

-- 회원의 성씨 별로 갯수를 조회하라
-- 조회 : 회원성씨, 갯수
Select substr(mem_name,1,1) as 회원성씨, count(substr(mem_name,1,1)) as cnt
From member
Group By substr(mem_name,1,1)
Order By 회원성씨 Asc;

-- 조회 : 회원의 아이디, 이름, 마일리지
-- 단, 회원 전체에 대한 평균값보다 큰 마일리지 값을 가지는 회원만 조회
Select mem_id, mem_name, mem_mileage
From member
Where mem_mileage > (Select avg(mem_mileage)
                        From member);
                        
-- 회원 중에 '김'씨 성을 가진 회원이 주문한 상품에 대해 상품분류코드별로 주문수량의 총합을 조회하려한다.
-- 단, 상품명에 '삼성'이 포함된 상품을 구매한 회원에 대해서만
-- 조회 : 상품분류코드, 주문수량의 총합
Select substr(cart_prod,1,4) as prod_lgu, sum(cart_qty)
From cart
Where cart_member in (Select mem_id from member where mem_name like '김%')
    and cart_prod in (Select prod_id from prod where prod_name like '%삼성%')
Group by substr(cart_prod,1,4);


-- 회원 지역별(서울, 대전 ...) 생일의 년도별로
-- 회원이름, 지역, 출생년도, 마일리지 평균/합계 조회
-- 단, 회원 성씨가 '이'씨
-- 정렬 : 지역기준으로 내림차순, 생일 년도 기준 오름차순

Select mem_name,
        substr(mem_add1,1,2) as mem_loc,
        to_char(mem_bir, 'yyyy') as mem_yyyy,
        sum(mem_mileage) as mil_sum,
        avg(mem_mileage) as mil_avg
From member
Where mem_name like '이%'
Group By mem_name,
        substr(mem_add1,1,2),
        to_char(mem_bir, 'yyyy')
Order By mem_loc Desc, mem_yyyy Asc;

Select substr(mem_name,1,1),
        substr(mem_add1,1,2) as mem_loc,
        to_char(mem_bir, 'yyyy') as mem_yyyy,
        sum(mem_mileage) as mil_sum,
        avg(mem_mileage) as mil_avg
From member
Where mem_name like '이%'
Group By substr(mem_name,1,1),
        substr(mem_add1,1,2),
        to_char(mem_bir, 'yyyy')
Order By mem_loc Desc, mem_yyyy Asc;

-- 서울-대전
Select substr(mem_name,1,1),
        substr(mem_add1,1,2) as mem_loc,
        sum(mem_mileage) as mil_sum,
        avg(mem_mileage) as mil_avg
From member
Where mem_name like '이%'
Group By substr(mem_name,1,1),
        substr(mem_add1,1,2)
Order By mem_loc Desc;