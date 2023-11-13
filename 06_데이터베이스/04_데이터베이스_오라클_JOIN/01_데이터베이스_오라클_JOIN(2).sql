-- ��� �ŷ�ó�� ���� ����ݾ��� �� ��ȸ
-- ��ȸ : �ŷ�ó�ڵ�, �ŷ�ó��, ����ݾ��� ��
-- ����ݾ� = �ֹ����� * �ǸŰ���
-- �ֹ����ڰ� 2005�⿡ ���� ��
Select buyer_id, buyer_name, sum(nvl(cart_qty * prod_sale,0)) as price_sum
From buyer left outer join prod
            On buyer_id = prod_buyer
            left outer join cart
            On (cart_prod = prod_id
                and substr(cart_no,1,4) = '2005')
Group By buyer_id, buyer_name;

-- ��� �ŷ�ó�� ���� ���Աݾ��� �� ��ȸ
-- ��ȸ : �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��� ��
-- ���Աݾ� = ���Լ��� * ���Դܰ�
-- �������ڰ� 2005�⿡ ���� ��
Select buyer_id, buyer_name, sum(nvl(buy_qty * buy_cost, 0)) as cost_sum
From buyer left outer join prod
            On buyer_id = prod_buyer
            left outer join buyprod
            On (buy_prod = prod_id
                and to_char(buy_date, 'yyyy') = '2005')
Group By buyer_id, buyer_name;

-- ���� �� ����� ��ġ��
-- ��� �ŷ�ó�� ���� ���Աݾ��� �հ�, ����ݾ��� �հ� ��ȸ
-- ��ȸ : �ŷ�ó�ڵ�, �ŷ�ó��, ����ݾ��� ��, ���Աݾ��� ��
-- ����ݾ� = �ֹ����� * �ǸŰ���
-- ���Աݾ� = ���Լ��� * ���Դܰ�
-- ������ ���, �ֹ����ڰ� 2005�⿡ ���� ��
-- ������ ���, �������ڰ� 2005�⿡ ���� ��
Select buyer_id, buyer_name, sum(nvl(cart_qty * prod_sale,0)) as price_sum, sum(nvl(buy_qty * buy_cost, 0)) as cost_sum
From buyer left outer join prod
            On buyer_id = prod_buyer
            left outer join cart
            On (prod_id = cart_prod
                and substr(cart_no,1,4)='2005')
            left outer join buyprod
            on (buy_prod = prod_id
                and to_char(buy_date, 'yy') = '05')
Group By buyer_id, buyer_name; --���� �̻���

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

--��ġ�� ���� id-cost_sum�� �ִ� ���̺�
Select buyer_id, sum(nvl(buy_qty * buy_cost, 0)) as cost_sum
From buyer left outer join prod
            On buyer_id = prod_buyer
            left outer join buyprod
            on (buy_prod = prod_id
                and to_char(buy_date, 'yy') = '05')
Group by buyer_id;


-- �����.ver
Select TB1.buyer_id, TB1.buyer_name, TB1.price_sum, TB2.cost_sum
From (Select buyer_id, buyer_name, sum(nvl(cart_qty * prod_sale,0)) as price_sum
        From buyer left outer join prod
                    On buyer_id = prod_buyer
                    left outer join cart
                    On (cart_prod = prod_id
                        and substr(cart_no,1,4) = '2005')
        Group By buyer_id, buyer_name) TB1, --����
        (Select buyer_id, buyer_name, sum(nvl(buy_qty * buy_cost, 0)) as cost_sum
        From buyer left outer join prod
                    On buyer_id = prod_buyer
                    left outer join buyprod
                    On (buy_prod = prod_id
                        and to_char(buy_date, 'yyyy') = '2005')
        Group By buyer_id, buyer_name)TB2 --����
Where TB1.buyer_id = TB2.buyer_id
Order By buyer_id Asc;