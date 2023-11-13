-- 모든 거래처에 대한 매출금액의 합 조회
-- 조회 : 거래처코드, 거래처명, 매출금액의 합
-- 매출금액 = 주문수량 * 판매가격
-- 주문일자가 2005년에 대한 것
Select buyer_id, buyer_name, sum(nvl(cart_qty * prod_sale,0)) as price_sum
From buyer left outer join prod
            On buyer_id = prod_buyer
            left outer join cart
            On (cart_prod = prod_id
                and substr(cart_no,1,4) = '2005')
Group By buyer_id, buyer_name;

-- 모든 거래처에 대한 매입금액의 합 조회
-- 조회 : 거래처코드, 거래처명, 매입금액의 합
-- 매입금액 = 매입수량 * 매입단가
-- 매입일자가 2005년에 대한 것
Select buyer_id, buyer_name, sum(nvl(buy_qty * buy_cost, 0)) as cost_sum
From buyer left outer join prod
            On buyer_id = prod_buyer
            left outer join buyprod
            On (buy_prod = prod_id
                and to_char(buy_date, 'yyyy') = '2005')
Group By buyer_id, buyer_name;

-- 위의 두 결과를 합치기
-- 모든 거래처에 대한 매입금액의 합계, 매출금액의 합계 조회
-- 조회 : 거래처코드, 거래처명, 매출금액의 합, 매입금액의 합
-- 매출금액 = 주문수량 * 판매가격
-- 매입금액 = 매입수량 * 매입단가
-- 매출의 경우, 주문일자가 2005년에 대한 것
-- 매입의 경우, 매입일자가 2005년에 대한 것
Select buyer_id, buyer_name, sum(nvl(cart_qty * prod_sale,0)) as price_sum, sum(nvl(buy_qty * buy_cost, 0)) as cost_sum
From buyer left outer join prod
            On buyer_id = prod_buyer
            left outer join cart
            On (prod_id = cart_prod
                and substr(cart_no,1,4)='2005')
            left outer join buyprod
            on (buy_prod = prod_id
                and to_char(buy_date, 'yy') = '05')
Group By buyer_id, buyer_name; --값이 이상함

Select buyer_id, buyer_name, sum(nvl(cart_qty * prod_sale,0)) as price_sum, cost_sum
From buyer left outer join prod
            On buyer_id = prod_buyer
            left outer join cart
            On (prod_id = cart_prod
                and substr(cart_no,1,4)='2005')
            left outer join (Select buyer_id as b22, sum(nvl(buy_qty * buy_cost, 0)) as cost_sum
                                From buyer left outer join prod
                                            On buyer_id = prod_buyer
                                            left outer join buyprod
                                            on (buy_prod = prod_id
                                                and to_char(buy_date, 'yy') = '05')
                                Group by buyer_id)
           on buyer_id = b22  
Group By buyer_id, buyer_name, cost_sum
Order By buyer_id Asc;

--합치기 위한 id-cost_sum만 있는 테이블
Select buyer_id, sum(nvl(buy_qty * buy_cost, 0)) as cost_sum
From buyer left outer join prod
            On buyer_id = prod_buyer
            left outer join buyprod
            on (buy_prod = prod_id
                and to_char(buy_date, 'yy') = '05')
Group by buyer_id;


-- 강사님.ver
Select TB1.buyer_id, TB1.buyer_name, TB1.price_sum, TB2.cost_sum
From (Select buyer_id, buyer_name, sum(nvl(cart_qty * prod_sale,0)) as price_sum
        From buyer left outer join prod
                    On buyer_id = prod_buyer
                    left outer join cart
                    On (cart_prod = prod_id
                        and substr(cart_no,1,4) = '2005')
        Group By buyer_id, buyer_name) TB1, --매출
        (Select buyer_id, buyer_name, sum(nvl(buy_qty * buy_cost, 0)) as cost_sum
        From buyer left outer join prod
                    On buyer_id = prod_buyer
                    left outer join buyprod
                    On (buy_prod = prod_id
                        and to_char(buy_date, 'yyyy') = '2005')
        Group By buyer_id, buyer_name)TB2 --매입
Where TB1.buyer_id = TB2.buyer_id
Order By buyer_id Asc;