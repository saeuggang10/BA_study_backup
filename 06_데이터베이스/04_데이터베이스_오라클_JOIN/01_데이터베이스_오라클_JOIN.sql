/* ��Ǯ�� */
--��ȸ : ��ǰ�з���, ��ǰ���̵�, ��ǰ�ǸŰ�, �ŷ�ó�����, ȸ�����̵�, �ֹ�����
--��, ��ǰ�з��ڵ尡 P101�� �Ϳ� ���ؼ�
--�Ϲ� ���
Select lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
From lprod, prod, buyer, cart
Where cart_prod = prod_id
    and prod_lgu = lprod_gu
    and prod_buyer = buyer_id
    and prod_lgu = 'P101';

--ANSI ���
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
          

-- ȸ�� ���ϸ����� ��ü ��� �̻��� ȸ���鿡 ���� ��̺� ȸ������ ��ȸ�ض�
-- ��ȸ : ȸ�����, ȸ����
Select mem_like, count(mem_id)
From member
Where mem_mileage >= (Select avg(mem_mileage)
                        From member)
Group by mem_like;


-- ȸ���� ������ '��'���̰�, '����, ����, �λ�, ����'�� �����ϴ� ȸ������ ��� ���ϸ��� �̻��� ȸ���� ������ ��ǰ���� ��ȸ�ϱ�
-- ��ȸ : ��ǰ�ڵ�, ��ǰ��, �ֹ�����, �ֹ�����, ȸ�����̵�, ȸ������, ���ϸ��� ��ȸ
-- ��, ��ǰ�� '�Ｚ'�� ���Ե� ���
Select cart_prod, prod_name, to_char(substr(cart_no,1,8),'yyyy-mm-dd') as cart_date,
        cart_qty, mem_id, substr(mem_add1,1,2) as mem_add, mem_mileage
From cart Inner join prod
            On (cart_prod = prod_id
                and prod_name like '%�Ｚ%')
          Inner Join member
            On (cart_member = mem_id
                and substr(mem_name,1,1) = '��'
                and (substr(mem_add1,1,2) = '����' or substr(mem_add1,1,2) = '����' or substr(mem_add1,1,2) = '�λ�' or substr(mem_add1,1,2) = '����'))
Where mem_mileage >= (Select avg(mem_mileage)
                        From member);
-- ��� 0��
                        
Select cart_prod, prod_name, substr(cart_no,1,8) as cart_date,
        cart_qty, mem_id, substr(mem_add1,1,2) as mem_add, mem_mileage
From cart Inner join prod
            On (cart_prod = prod_id
                and prod_name like '%�Ｚ%')
          Inner Join member
            On cart_member = mem_id
                and mem_mileage >= (Select avg(mem_mileage)
                                    From member
                                    Where substr(mem_name,1,1) = '��'
                                        and substr(mem_add1,1,2) in ('����', '����', '�λ�', '����'));
-- ��� 1��

-- ��ȸ : ��ǰ�ڵ�, ��ǰ��, ��ǰ�з���, �ŷ�ó��, �ŷ�ó����
-- ��ǰ�ǸŰ����� 10���� �����̰�, �ŷ�ó ������ '�λ�'�� ��츸 ��ȸ�ϱ�
Select prod_id, prod_name, lprod_nm, buyer_name, substr(buyer_add1,1,2) as buyer_add
From prod Inner Join lprod
          On (prod_lgu = lprod_gu
            and prod_sale <= 100000)
          Inner Join Buyer
          On (prod_buyer = buyer_id
            and substr(buyer_add1,1,2) = '�λ�');
            
-- ��ȸ : ��ǰ�з���, �ŷ�ó��
-- ��, ��ǰ�з��ڵ尡 P101, P201, P301�� ��, ���Լ����� 15�� �̻��� ��, ���￡ �����ϰ� ������ 1974����� ȸ���� ���Ͽ�
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
            and substr(mem_add1,1,2) = '����');
            
            
-- ��ȸ : �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��� ��
-- �������ڰ� 2005�� 1���� �Ϳ� ���ؼ�
-- ���Աݾ� = ���Լ��� * ���Դܰ�
-- ���Աݾ��� null�̸� 0���� ��ȯ
Select buyer_id, buyer_name, to_char(sum(nvl((buy_qty * buy_cost),0)), 'L999,999,999') as buy_price_sum
From prod Inner Join buyer
          On prod_buyer = buyer_id
          Inner Join buyprod
          On prod_id = buy_prod
            and to_char(buy_date,'yymm') = '0501'
Group By buyer_id, buyer_name;


/* Outer Join */
-- ȸ���� �ֹ������� �� ��ȸ
-- ��ȸ : ȸ�����̵�, ȸ���̸�, �ֹ������� ��
-- ȸ�� ��ü(�� 24��)�� ���� �ֹ������� �� !
Select cart_member, mem_name, sum(nvl(cart_qty,0)) as qty_sum
From cart, member
Where mem_id = cart_member(+) -- outer join�̶� ��
Group by cart_member, mem_name; --24��

Select cart_member, mem_name, sum(nvl(cart_qty,0)) as qty_sum
From cart, member
Where cart_member = mem_id(+) -- outer join�̶� ��
Group by cart_member, mem_name; --23��

Select cart_member, mem_name, sum(nvl(cart_qty,0)) as qty_sum
From member Left Outer Join cart
          On mem_id = cart_member
Group by cart_member, mem_name;

-- Outer join + �Ϲ�����
-- ���ϸ����� 3000�̻��� ȸ�� ��ȸ
Select cart_member, mem_name, sum(nvl(cart_qty,0)) as qty_sum
From cart, member
Where mem_id = cart_member(+) -- outer join�̶� ��
    and mem_mileage >= 3000
Group by cart_member, mem_name; -- 7��

Select cart_member, mem_name, sum(nvl(cart_qty,0)) as qty_sum
From member Left Outer Join cart
          On (mem_id = cart_member
            and mem_mileage >= 3000)
Group by cart_member, mem_name; -- 24��

Select cart_member, mem_name, sum(nvl(cart_qty,0)) as qty_sum
From member Left Outer Join cart
          On mem_id = cart_member
Where mem_mileage >= 3000
Group by cart_member, mem_name; -- 7��


-- ��ǰ�з� >>��ü�� ����<< ��ǰ�� ������ ��ȸ
-- ��ȸ : ��ǰ�з��ڵ�, ��ǰ�з���, ��ǰ�� ����
-- ��, ��ǰ�� '�Ｚ'�� ������ ���
Select lprod_gu, lprod_nm, count(nvl(prod_id, 0)) as cnt
From lprod left outer join prod
            On (prod_lgu = lprod_gu
                and prod_name like '%�Ｚ%')
Group By lprod_gu, lprod_nm;
--Having count(prod_id) > 1; --������ �����鼭 ��ü��� ���������� ����

-- ��ü ��ǰ�� ���� ��ǰ�ڵ�, ��ǰ��, ���Լ����� �� ��ȸ
-- �԰����ڰ� 2005�� 1���� ���� ��ü ��ȸ
Select prod_id, prod_name, sum(nvl(buy_qty, 0)) as qty_sum
From prod left outer join buyprod
            On (prod_id = buy_prod
                and to_char(buy_date,'yyyymm') = '200501')
Group By prod_id, prod_name;


-- ���̵� h001�� ȸ���� ���ϸ������� ����(�̻�) ȸ������ ��ȸ
-- ��ȸ : ȸ�����̵�, �̸�, ���ϸ���
Select mem_id, mem_name, mem_mileage
From member
Where mem_mileage >= (Select mem_mileage
                        From member
                        Where mem_id = 'h001');
                        
/* Self Join */
-- �ڱ� ���̺��� 2���� ���� ��� ( ����˻��� / ���ǿ�)
Select M1.mem_id, m1.mem_name, m1.mem_mileage
        ,m2.mem_id, m2.mem_name, m2.mem_mileage
From member m1, member m2
Where m2.mem_id = 'h001'
    and m1.mem_mileage >= m2.mem_mileage;
    
    
/* ����Ǯ�� */
-- ��ǰ ��ü�� ���� ��ȸ : ��ǰ���̵�, ��ǰ��, ���Լ����� ��, �ֹ������� ��
-- �԰����ڰ� 2005�� 04�� 16���� ��
-- �ֹ����ڰ� 2005�� 04�� 16���� ��
Select prod_id, prod_name, sum(nvl(buy_qty,0)) as b_qty_sum, sum(nvl(cart_qty,0)) as c_qty_sum
From prod left outer join cart
            On cart_prod = prod_id
                and substr(cart_no,1,8) = '20050416'
            left outer join buyprod
            On prod_id = buy_prod
                and buy_date = '05/04/16'
Group By prod_id, prod_name;

-- dateŸ�� Ȯ�ο�
Select cart_no
From cart
Where substr(cart_no,1,8) = '20050416';

Select buy_date
From buyprod
Where buy_date = '05/04/16';


-- �԰� ���� ���Լ����� ��, ���� �ݾ��� ���� ��ȸ
-- �԰� �⵵�� 2005����
-- ���Աݾ� = ���Լ��� * ���԰���
Select to_char(buy_date,'mm') as buy_mon, sum(nvl(buy_qty,0)) as b_qty_sum, to_char(sum(nvl(buy_qty*prod_cost,0)), 'L999,999,999') as b_cost_sum
From buyprod left outer join prod
                on buy_prod = prod_id
                    and to_char(buy_date,'yyyy') = '2005'
Group By to_char(buy_date,'mm')
Order By buy_mon;

-- 2005�⵵ �Ǹ�����, �Ǹ��Ѿ��� ��, �Ǹż����� ����, �Ǹż����� �Ѱ��� ��ȸ
-- �ǸŴ� �ֹ��� ����. �Ǹ��Ѿ� = �Ǹż���*�ǸŰ���
-- �Ǹ��Ѿ��� ���� 5�鸸�� �̻�, �Ǹż����� ������ 50�̻�, �Ǹż����� �Ѱ����� 8�̻�
Select substr(cart_no,1,8) as cart_date, sum(nvl(cart_qty*prod_sale,0)) as sale_sum, sum(cart_qty) as qty_sum, count(cart_qty) as qty_cnt
From cart left outer join prod
            on (cart_prod = prod_id
                and substr(cart_no,1,4) = 2005)
Group By substr(cart_no,1,8)
Having sum(cart_qty*prod_sale) >= 5000000
        and sum(cart_qty) >= 50
        and count(cart_qty)>= 8;