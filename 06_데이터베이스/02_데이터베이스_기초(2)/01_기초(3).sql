-- 02_데이터베이스_기초(2)

/* 어제 연습한 모든 테이블 삭제하기 */
Drop Table test_TB;
Drop Table Test_TB2;
Drop Table test01;
Drop Table test02;


/* IT 프로젝트 진행 순서 */
-- 1. 계획(기획)
-- 2. 요구사항 수렴
-- 3. 요구분석
-- 4. 분석설계
-- 5. 구현
-- 6. 테스트
-- 7. 서비스
-- 8. 유지보수

/* 분석 프로젝트 진행 순서 */
-- 1. 사전계획
-- 2. 사전 데이터 샘플링
-- 3. 사전 분석
-- 4. 본계획 (1차프로젝트~)
-- 5. 본 데이터 수집
-- 6. 전처리
-- 7. 가공
-- 8. 후처리
-- 9. 시각화 (1차프로젝트//)
-- 10. 추가 자동화 필요한 데이터가 있는 경우 -> 딥러닝/머신러닝
-- 11. 빅데이터 플랫폼 구축(경우에 따라, 인프라 구축을 하는 경우 수행. IT프로젝트 순서에 따름)
-- 12. 서비스


/* oracle_base_table.sql실행 */
/* oracle_base_table.sql 데이터 확인 */
select * from buyer;
select * from buyprod;
select * from cart;
select * from lprod;
select * from member;
select * from prod;


/* 1. 테이블 정의서 작성 */
-- ->테이블정의서_강민지.xlsx

/* 2. 테이블 관계도(=ERD) 작성 */
-- ->ERD_강민지.png

/* 3. 회원정보 중 아래와 같은 정보를 조회해 주세요 */
-- 회원아이디, 회원이름, 생일, 이동전화번호, 이메일주소, 직업, 취미 조회
SELECT mem_id, mem_name, mem_bir, mem_hp, mem_mail, mem_job, mem_like
FROM MEMBER;

-- 상품 이름, 상품 매입가, 소비자가, 판매가 조회
SELECT prod_name, prod_cost, prod_price, prod_sale
FROM PROD;

-- 회원마일리지값을 조회하려고 한다. 마일리지 값을 12로 나눈 값을 조회하라
SELECT mem_mileage / 12
FROM member;

-- 상품코드, 상품명, 판매금액을 조회하려 한다. 판매금액 = 판매단가*55
SELECT PROD_ID, PROD_NAME, PROD_SALE * 55
FROM PROD;
-- 계산식이 그대로 COL이름으로 나온다 -> 별칭(ALIAS)을 만들어줌
-- 띄워쓰기가 있다면 쌍따옴표("")/언더바(_)를 이용해서 묶어주면 된다
-- pandas >>as<< pd처럼 as 붙이면 된다
SELECT PROD_ID, PROD_NAME, (PROD_SALE * 55) AS PROD_SALE, (PROD_SALE * 55) AS "PROD SS", (PROD_SALE * 55) "판매금액2", (PROD_SALE * 55) SS3, (PROD_SALE * 55) 판매_금액4
FROM PROD;

-- 정렬하기
    -- 오름차순 : ASC
    -- 내림차순 : DESC
-- select 가장 마지막에 작성(오라클이 해석될 때 가장 마지막에 해석됨)
-- 방법1, COL명을 이용한 방법
SELECT mem_name, mem_like
FROM member
ORDER BY mem_name ASC;

-- 방법2, COL INDEX를 이용한 방법
SELECT mem_name, mem_like
FROM member
ORDER BY 1 ASC;

SELECT mem_name AS name, mem_like
FROM member
ORDER BY name DESC;

-- 상품분류코드와 거래처코드를 조회해주세요. 상품분류코드를 기준으로 오름차순, 거래처코드를 내림차순 정렬
SELECT prod_lgu, prod_buyer
FROM PROD
ORDER BY prod_lgu ASC, prod_buyer DESC;

-- 상품분류코드와 거래처코드를 조회해주세요. 상품분류코드를 기준으로 오름차순, 거래처코드를 내림차순 정렬 후 중복제거(DISTINCT)하기
-- 행단위만 중복제거
SELECT DISTINCT prod_lgu, prod_buyer
FROM PROD
ORDER BY prod_lgu ASC, prod_buyer DESC;

-- 상품의 판매가격이 17만원 이상(조건 : WHERE)인 모든 데이터를 조회
-- 상품 판매가격이 가장 높은 순으로 정렬
SELECT prod_sale
FROM prod
WHERE prod_sale >= 170000
ORDER BY 1 DESC;