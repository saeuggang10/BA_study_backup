-- 회원 마일리지의 값이 1000인 회원이 주문한 상품코드, 상품명 조회
Select prod_id, prod_name
From prod
Where prod_id in (Select cart_prod from cart where cart_member in (Select mem_id from member Where mem_mileage = 1000));


----------------------------------------------
/* 오라클에서만 사용 가능한 함수들임 */

/* 문자합치기 */
-- Select문과 Where문에 사용가능
-- 주소1과 주소2 합치기
Select (mem_add1 || ' ' || mem_add2) as mem_add
From member;

-- concat은 2개만 합칠 수 있음
Select (mem_add1 || ' ' || mem_add2) as mem_add,
        concat(mem_add1, mem_add2) as mem_add
From member;

-- concat 합쳐 사용하기
Select concat(mem_add1, concat(' ', mem_add2)) as mem_add
From member;

-- 아스키번호 숫자를 문자로 바꾸기
Select Chr(65), Chr(66), Chr(67)
From member;

Select Ascii('a'), Ascii('A'), Ascii('z')
From member;

-- 대소문자 바꾸기
-- Upper : 대문자로 모두 바꾸기
-- Lower : 소문자로 모두 바꾸기
-- InitCap : 단어 중 첫글자만 대문자로 바꾸기
Select mem_id, Upper(mem_id) as up_mem_id, initcap('abcd efg hi'), Lower('AbcD')
From member;

-- 공간 채우기
-- lpad : 오른쪽부터 값을 채운 후 빈 공간에 지정문자로 채운다
-- rpad : 왼쪽부터 값을 채운 후 빈 공간에 지정문자로 채운다
-- 값이 한글이 아닌 경우 : 공간 1개씩 차지
-- 값이 한글인 경우 : 공간 2개씩 차지
Select Lpad(mem_id, 2, '*') as lpad_mem_id,
        Lpad(mem_id, 6, '*') as lpad_mem_id,
        Rpad(mem_id, 6, '*') as rpad_mem_id,
        Lpad(mem_name, 10, '*') as lpad_mem_name,
        Rpad(mem_name, 10, '*') as rpad_mem_name
From member;

-- 회원의 주민등록번호를 아래와 같은 형태로 출력해라
-- 000000-*******
select (mem_regno1 || '-' || '*******') as mem_regno
from member;

select Rpad((mem_regno1 || '-'), 14, '*') as mem_regno
from member;

-- 공백제거
Select LTrim('   abdc  bdbe w b ') as LT,
        RTrim('   abdc  bdbe w b ') as RT,
        Trim('   abdc  bdbe w b ') as T
From member;

-- 문자열 자르기
-- 0, 1모두 1번째로 인식
SELECT substr('a001',0,2) as s1,
        substr('a001',1,2) as s2,
        substr('a001',-1) as s3,
        substr('a001',-3) as s4
From member;

-- 주문번호 규칙 : 앞 4자리는 연도, 2자리는 월, 2자리는 일, 나머지 2자리는 순차적으로 1씩 증가
-- 상품코드 규칙 : 앞4자리는 상품분류코드
Select *
From cart;
-- 김씨 성을 가진 회원이 주문한 상품들의 분류가 어떤 것인지 확인하기
-- prod테이블을 사용하지 않고, 상품분류코드, 상품분류명 조회
Select lprod_gu, lprod_nm
From lprod
Where lprod_gu in (Select substr(cart_prod,1,4) from cart where cart_member in (Select mem_id from member where mem_name like '김%'));

Select distinct substr(cart_prod,1,4) as cart_p, (Select lprod_nm From lprod where lprod_gu = substr(cart_prod,1,4)) as lprod_nm
From cart
Where cart_member in (Select mem_id from member where mem_name like '김%');


/* PK, Fk, index, 프로시저, 트리거, View, 함수 등등 개념 */
Select *
From member
Where mem_name Like '김%'; -- 24행 모두 체크

-- 데이터 치환하기
Select mem_id,
        Replace(mem_id, '001', '**1'),
        Replace('안녕 하세요! 파이썬!', '하세요', '반가워')
From member;

-- 회원 이름 중에 이씨를 리씨로 바꿔 전체조회
Select mem_id, (Replace(substr(mem_name,1,1),'이','리') || substr(mem_name,2,3)) as mem_name
From member; 

-- 문자열이 갯수 확인하기
-- length : 문자의 순수 갯수
-- lengthB : 문자의 바이트 개수
Select length(mem_id), length(mem_name),
        lengthB(mem_id), lengthB(mem_name)
From member;

-- 임시테이블 : 함수 및 문자열 처리 등에 대한 테스트용 (1행 1열만 들어있음)
Select *
From Dual;

-- 절대값
Select Abs(-365), Abs(365), Abs(null)
From Dual;

-- 제곱
Select Power(2,2), Power(2,3)
From Dual;

-- Greatest : 가장 큰 값 조회
-- Least : 가장 작은 값 조회
Select Greatest(10, 50, 20, 40), Greatest('b', 'a', 'A'),
        Least(10, 50, 20, 40), Least('b', 'a', 'A')
From Dual;

-- 회원 전체에 대한 이름, 마일리지 조회하기
-- 단, 마일리지의 값이 1000보다 작은 경우 1000으로 변경하여 조회하기
Select mem_name, Greatest(mem_mileage, 1000), mem_mileage
From member;

-- 반올림 : round
Select Round(1234.567, -4) as r1,
        Round(1234.567, -3) as r2,
        Round(1234.567, -2) as r3,
        Round(1234.567, -1) as r4,
        Round(1234.567, 0) as r5,
        Round(1234.567, 1) as r6,
        Round(1234.567, 2) as r7,
        Round(1234.567, 3) as r8,
        Round(1234.567, 4) as r9
From Dual;

-- 상품테이블에서 상품명, 원가율(매입가/판매가 *100) 조회하기
-- 운가율은 소수점 첫째자리까지 표현
-- 단, 상품명에 삼성이라는 단어가 있는 데이터만 추출
Select prod_name, round(prod_cost/prod_sale*100,1) as cost
From prod
Where prod_name Like '%삼성%';

-- 절삭 : Trunc()
-- 나눈 나머지의 값 추출하기
Select Mod(10,2), Mod(10,3)
From Dual;

-- 회원 성별을 구분하려 한다. 남자는 1, 여자는 0
-- 조회 : 회원이름, 성별(별칭 m1)
Select mem_name, mod(substr(mem_regno2,1,1),2) as m1
From member;


/* 조별로, 가장 어렵게 문제 4개씩 만든다. 답까지 만들기 */
-- 지금까지 배운 모든 것 응용(테이블생성 및 값 추가도 가능)
-- 문제는 0조.txt파일로 정리해서 구글드라이브에 제출
-- 1. 주소1이 대전으로 시작하는 사람들의 테이블을 만든다
-- 이 테이블을 이용해 김씨가 아니고, 거래처의 우편번호 앞자리 3자리와 회원의 우편번호 앞자리 3자리가 같은 사람을 구해라
Select *
From (Select * from member where mem_add1 Like '대전%')
Where substr(mem_zip,1,3) in (select substr(buyer_zip,1,3) from buyer) and mem_name not like '김%';

-- 확인용
select Distinct buyer.buyer_zip
from buyer;

select Distinct member.mem_zip
from member;