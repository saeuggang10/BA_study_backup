-- ����_��

-- ��ǰ�ǸŰ��� 17���� �̻��̰�, 20���� ������ ��ǰ���� ��ü�� ��ȸ�ض�.
-- ��ǰ�ڵ带 �������� ��������, ��ǰ���� �������� �������� �����϶�.
Select *
From prod
where prod_sale >= 170000 and prod_sale <= 200000
Order By prod_id Desc, prod_name Asc;

-- ��ǰ�з��ڵ尡 P201�̰�, ��ǰ�ǸŰ����� 17���� �Ǵ� 20������ ��ǰ���� ��ȸ
-- ��ȸ : ��ǰ�з��ڵ�, ��ǰ��, ��ǰ�ǸŰ���
-- ���� : ��ǰ�з��ڵ�-Asc, ��ǰ�ǸŰ���-Desc
Select prod_lgu, prod_name, prod_sale
From prod
Where prod_lgu = 'P201' and (prod_sale = 170000 or prod_sale = 200000)
Order By prod_lgu Asc, prod_sale Desc;

-- Not����
Select prod_lgu, prod_name, prod_sale
From prod
Where prod_lgu = 'P201' and Not (prod_sale = 170000 or prod_sale = 200000)
Order By prod_lgu Asc, prod_sale Desc;

-- ��ǰ �ǸŰ����� 15����, 17����, 33������ ��ǰ�� ��ȸ�ϱ�
-- ��ȸ : ��ǰ�ڵ�, ��ǰ��, �ǸŰ���
-- ���� : ��ǰ�ڵ� ��������, ��ǰ�� ��������, �ǸŰ��� ��������
-- 1. �������� ���
SELECT prod_id, prod_name, prod_sale
From prod
Where prod_sale = 150000 
        or prod_sale = 170000
        or prod_sale = 330000
Order By prod_id Asc, prod_name Desc, prod_sale Asc;

-- 2. in() : ���԰���
SELECT prod_id, prod_name, prod_sale
From prod
Where prod_sale in(150000, 170000, 330000)
Order By prod_id Asc, prod_name Desc, prod_sale Asc;


/* ��������(SubQuery) */
-- 1. ���̺�� ��� ��� : inline View��� ��Ī�� �ִ�.(View Table)
Select *
From(SELECT prod_id, prod_name, prod_sale
        From prod
        Where prod_sale in(150000, 170000, 330000)
        Order By prod_id Asc, prod_name Desc, prod_sale Asc);
        
-- �ֹ������� �ִ�(=Cart table) ȸ�����̵� ��ȸ�ض�
-- �ߺ��� �ִٸ� �ߺ�����ó���ض�
Select DISTINCT cart_member
From Cart;

-- 2. Where���� �������� ����ϱ�
Select prod_id
From prod;
                    
Select *
From prod
where prod_id in (Select prod_id
                    From prod);
                    
-- �ѹ��̶� �ֹ��� ������ �ִ� ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�
Select mem_id, mem_name
From member
Where mem_id in (Select cart_member
                    From cart);
                    
Select Distinct cart.cart_member, member.mem_name
From member, cart
Where cart.cart_member = member.mem_id;

-- 3. select���� �������� ����ϱ�
-- ������(col��ü)���� error -> where�� �� �ϳ��� ���������
-- �д� ���� : Main Query From - cart > Main Query Select�� cart_member�о�� (> SubQuery From - member > Select - mem_name (Error -> Where�߰�) > Where - mem_id=cart_member�̸� ã�� ���� cart_member 1��� ���� ��) mem_name�̶�� ���� ������ ���
Select mem_name
From member
Where mem_id = 'a001';

Select Distinct cart_member,
               (Select mem_name
                From member
                Where mem_id = cart_member) as mem_name
From cart;


/* not in */
-- �ֹ��� �ѹ��� �������� ȸ���� ȸ�����̵�, ȸ���̸��� ��ȸ�ض�
Select mem_id, mem_name
From member
Where mem_id not in (Select cart_member
                    From cart);
                    
Select Distinct cart_member
From cart; -- 23��

Select mem_id
From member; -- 24��

-- ��ǰ������ �������� �ʴ� ��ǰ�з��ڵ�� ��ǰ�з����� ��ȸ�ض�
Select lprod_gu, lprod_nm
From lprod
Where lprod_gu not in (Select prod_lgu
                        From prod);

-- �ǸŰ����� 10���� �̻��̰�, 30���� ������ ��ǰ�ڵ�, ��ǰ�з��ڵ�, �ǸŰ��� ��ȸ
Select prod_id, prod_lgu, prod_sale
From prod
Where prod_sale>=100000 and prod_sale<=300000;


/* ��������(A�̻� B����) : Between A and B */
Select prod_id, prod_lgu, prod_sale
From prod
Where prod_sale Between 100000 and 300000;

-- ȸ�� ������ 75�� 1�� 1�Ϻ��� 76�� 12�� 31�� ���̿� �¾ ȸ���� ��ȸ�ض�
-- ��ȸ : ȸ�����̵�, �̸�, ����
-- ���� : ���� ��������
Select mem_id, mem_name, mem_bir
From member
Where mem_bir Between '75/1/1' and '76/12/31'
Order By mem_bir Asc;

Select mem_id, mem_name, mem_bir
From member
Where mem_bir Between '76/12/31' and '75/1/1'
Order By mem_bir Asc; -- ����� ����

-- �ǸŰ����� 10���� �̻��̰�, 30���� ������ ��ǰ�ڵ�, ��ǰ�з��ڵ�, ��ǰ�з���, �ǸŰ��� ��ȸ
Select prod_id, prod_lgu, prod_sale, (Select lprod_nm
                                    From lprod
                                    Where lprod_gu = prod_lgu) as lprod_nm
From prod
Where prod_sale Between 100000 and 300000;

-- a001 ȸ���� ���ݱ��� �ֹ��� ������ Ȯ���Ϸ��Ѵ�
-- ��ȸ : ȸ�����̵�, ȸ���̸�, �ֹ���ȣ, ��ǰ��, ��ǰ�ڵ�
-- ���� : �ֹ���ȣ Desc
-- ����� Table : cart, prod, member
Select cart_member, cart_no, cart_prod, (Select prod_name
                                        From prod
                                        Where prod_id=cart_prod) as prod_name, (Select mem_name
                                                                                From member
                                                                                Where mem_id=cart_member) as mem_name
From cart
Where cart_member = 'a001'
Order By cart_no Desc;

-- ȸ���̸��� �������� ����� �ֹ��� ��ǰ�� �з��ڵ�� �з����� �˰��� �Ѵ�
-- ��ȸ : ��ǰ�з��ڵ�, ��ǰ�з���
-- cart ����
Select Distinct (Select prod_lgu From prod Where cart_prod = prod_id) as prod_lgu,
                (Select lprod_nm from lprod where lprod_gu = (select prod_lgu from prod where prod_id = cart_prod)) as lprod_nm
From cart
Where cart_member = (Select mem_id From member where mem_name='������');

-- lprod ����
Select lprod_gu, lprod_nm
From lprod
Where lprod_gu in (Select prod_lgu from prod where prod_id in
                    (Select cart_prod from cart where cart_member = (Select mem_id from member where mem_name='������')));

-- prod ����
Select Distinct (Select lprod_gu from lprod where lprod_gu=prod_lgu) as lprod_gu,
        (Select lprod_nm from lprod where lprod_gu=prod_lgu) as lprod_nm
From prod
Where prod_id in (Select cart_prod from cart where cart_member = (Select mem_id from member where mem_name='������'));


-- ȸ�����̵�, ȸ���̸�, ��ǰ�з��ڵ� ,��ǰ�з���, �ŷ�ó�� ��ȸ
Select distinct cart_member,
    (select mem_name from member where mem_id = cart_member)as mem_name,
    (Select lprod_gu from lprod where lprod_gu = (Select prod_lgu from prod where prod_id = cart_prod)) as lprod_gu,
    (Select lprod_nm from lprod where lprod_gu = (Select prod_lgu from prod where prod_id = cart_prod)) as lprod_nm,
    (Select buyer_name from buyer where buyer_id = (Select prod_buyer from prod where prod_id = cart_prod)) as buyer_name
from cart
where cart_member = (Select mem_id from member where mem_name='������');

-- from �������� ����
Select *
From (Select Distinct (Select lprod_gu from lprod where lprod_gu=prod_lgu) as lprod_gu,
        (Select lprod_nm from lprod where lprod_gu=prod_lgu) as lprod_nm
    From prod
    Where prod_id in (Select cart_prod from cart where cart_member = (Select mem_id from member where mem_name='������')));
  
    
---------------------------------------
/* Ư�� �÷��� ���� Ư�����ڰ� ������ ��ȸ�ϱ� */
--�Խù����� �̸��˻�, ����˻��� �� ���Ǵ� SQL����
--Like ��ɾ� ���

-- ȸ���� �̸� �� ������ '��'���� ȸ�� ã��
Select mem_name
From member
Where mem_name Like '��%';

-- '��'�̶�� �ܾ ���ԵǾ� �ִ� ȸ�� ã��
Select mem_name
From member
Where mem_name Like '%��%';

-- '��'�� ������ ȸ�� ã��
Select mem_name
From member
Where mem_name Like '%��';

-- �ι�° �ܾ ������ �����ϴ� ��� ������ ��ȸ
Select mem_name
From member
Where mem_name Like '_��%';

-- ����° �ܾ '��'�� �����ϴ� ��� ������ ��ȸ
Select mem_name
From member
Where mem_name Like '__��%';

-- �ֹε�Ϲ�ȣ �߿� 75����� ��ȸ
Select *
From member
Where mem_regno1 Like '75%';

-- �ֹε�Ϲ�ȣ �߿� 75����� �ƴ� ����� ��ȸ
Select *
From member
Where mem_regno1 not Like '75%';

-- ��ȸ : ȸ�����̵�, ȸ���̸�
-- ȸ���̸��� ������ '��'�� ��� �߿� ��ǰ�� '�Ｚ'�� ���ԵǾ��ִ� ��ǰ�� ������ ȸ������ ��ȸ
select mem_id, mem_name
From member
Where mem_name like '��%' and mem_id in (Select cart_member from cart where cart_prod in (Select prod_id 
                                                                                           from prod where prod_name like '%�Ｚ%'))