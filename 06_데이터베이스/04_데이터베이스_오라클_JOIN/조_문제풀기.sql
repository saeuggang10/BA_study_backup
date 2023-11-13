/* 1�� */
-- 5~8������ ������ ȸ���� �ֹ��� ��ǰ�� ��ǰ��� �ش� ��ǰ�� �ŷ�ó�� 
-- �׸��� ��ǰ�з����� ������ּ���.                        
Select distinct prod_name, buyer_name, lprod_nm
From cart, member, prod, buyer, lprod
Where cart_member = mem_id
    and cart_prod = prod_id
    and prod_lgu = lprod_gu
    and prod_buyer = buyer_id
    and to_char(mem_bir,'mm') between 5 and 8;
--------------------------------------------------------------------------
-- ���� ������ �����ϴ� ������ ������ ��ǰ�� �����ͷ� 25% �̻��� ������ ��ǰ�� ���ض�
-- �����ͷ� (�ǸŰ� - ���԰�) / ���԰� * 100
-- ����÷� ��ǰ�� �����ͷ�
Select prod_name, nvl(((prod_sale - prod_cost) / prod_cost *100),0) as prod_pure
From cart inner join prod
            On prod_id = cart_prod
            inner join member
            On cart_member = mem_id
                and substr(mem_add1,1,6) = '������ ����'
                and mod(substr(mem_regno2,1,1),2) = 1
Where ((prod_sale - prod_cost) / prod_cost *100) > 25;
-------------------------------------------------------------------------------------------------------
-- �ֹ����� �� ��ǰ�з��� ���ڰ� 'ȭ��ǰ'�� ȸ���� ���̵�� ��й�ȣ�� �빮�ڷ� �����ϱ�
Select distinct upper(mem_id) as mem_id, upper(mem_pass) as mem_pass
From lprod, member, prod, cart
Where cart_prod = prod_id
        and cart_member = mem_id
        and prod_lgu = lprod_gu
        and lprod_nm = 'ȭ��ǰ';

Select distinct cart_member
From cart
Where substr(cart_prod,1,4)='P302'; --Ȯ�ο�
-------------------------------------------------------------------------------
-- ��ǰ ���������̳� �󼼼��� '����'�̶�� �ܾ �ִ� ��ǰ ��, ������������ 20 �̸��� ��ǰ�� �� ��� ��� ȸ������ ��ȸ�ϱ�
Select member.*
From member, prod, cart
Where mem_id = cart_member
    and prod_id = cart_prod
    and (prod_outline like '%����%' or prod_detail like '%����%')
    and prod_properstock < 20;
--------------------------------------------------------------------------------
/* ��� ȸ���� ȸ���̸�, �ֹε�Ϲ�ȣ, ������ ��ȸ���ּ���. */
-- �ֹε�Ϲ�ȣ�� ������ �Ʒ��� ���� ���·� ������ּ���.
-- �ֹε�Ϲ�ȣ 000000-0******
-- �����÷��� ����� '��' or '��' ǥ�����ּ��� 
Select mem_name, (mem_regno1 || '-' || Rpad(substr(mem_regno2,1,1),6,'*')) as mem_regno, decode(mod(substr(mem_regno2,1,1),2),1,'��','��') as mem_sex
From member;
--------------------------------------------------------------------------------
-- ���ϸ����� 2500 �̻��� ������� �� ��ǰ��, �ǸŰ�, ��ǰ�з��� ��ȸ
-- ��ȸ�Ҷ� �ǸŰ��� ���� �������� ��ȸ
Select Distinct prod_name, prod_sale, lprod_nm
From member, prod, lprod, cart
Where cart_member = mem_id
    and cart_prod = prod_id
    and prod_lgu = lprod_gu
    and mem_mileage >= 2500
Order By prod_sale Desc;
--------------------------------------------------------------------------
-- Q) ������� '����'�̰� ��¥�� '9��'�� ȸ������ �ֹ��� ��ǰ�� �԰����ڰ� �������� Ȯ���ϱ�
-- prod ���̺� ��� x
-- �԰��ǰ���� ��ü ��ȸ�ϱ�
-- '����'�� '����' ��� ��ȸ�ϱ�
Select buyprod.*
From buyprod inner join cart
                on buy_prod = cart_prod
                inner join member
                on cart_member = mem_id
                    and mem_memorial like '%����%'
                    and to_char(mem_memorialday, 'mm') = 9;
                    
Select distinct buyprod.*
From buyprod inner join cart
                on buy_prod = cart_prod
                inner join member
                on cart_member = mem_id
                    and (mem_memorial like '%����%' or mem_memorial like '%����%')
                    and to_char(mem_memorialday, 'mm') = 9;
                    
                    

/* 2�� */
--���� 1.
--�Ƿ� �ֹ� �ݾ�(cart_qty*prod_sale)�� 500 ���� �̻��� ȸ�� �̸�, ȸ�� id, �ֹ� �ݾ� ��ȸ
Select mem_name, mem_id, (cart_qty*prod_sale) as cart_price
From cart inner join member
            On cart_member = mem_id
            inner join prod
            on cart_prod = prod_id
                and (cart_qty*prod_sale) >= 5000000;
--���� 2.
--���Ż�ǰ�� ������ ����̰� 9���� ������� �ִ� ȸ���� ���� ��ȸ�ϱ�
Select mem_job
From cart inner join member
            On (cart_member = mem_id
                and to_char(mem_memorialday, 'mm') = 9)
            inner join prod
            on cart_prod = prod_id
                and prod_color = '���';
--����3.
--3-1.��ǰ ���̺� ���ϸ����÷��� ���ϸ��� �� �ֱ�(P1(����) ���� 500P, P2(�Ƿ�) ���� 150P, P3(ȭ��ǰ) ���� 50P)
select prod_mileage
From prod;

Update prod
    set prod_mileage = decode(substr(prod_lgu,1,2),
                                'P1', 500,
                                'P2', 150,
                                'P3', 50);

select prod_mileage
From prod; --Ȯ�ο�
--3-2.���ų������� ���Ÿ��ϸ����÷�(CART_MILEAGE)�� ���� ������ǰ�� ������ ���� �����ڿ��� ���ϸ��� �� �ֱ�
Alter table cart add(CART_MILEAGE number(15)); --col����

Update cart
    set CART_MILEAGE=decode(substr(cart_prod,1,2),
                                'P1', 500*cart_qty,
                                'P2', 150*cart_qty,
                                'P3', 50*cart_qty);
                                
select CART_MILEAGE
From cart; --Ȯ�ο�
--����4.
--������ 3���̰� ������ @hanmail.net���� ������ ����� ��ȸ�ϱ�
Select mem_bir, mem_mail
From member
Where to_char(mem_bir,'mm') = 3
        and mem_mail like '%@hanmail.net';
        
Rollback;
                    
                    

/* 3�� */
--1. ����ȣ�� ������ ��ǰ�� ��ǰ��� �ŷ�ó���� ����ϼ���.
Select prod_name, buyer_name
From member, cart, prod, buyer
Where mem_id = cart_member
    and prod_id = cart_prod
    and prod_buyer = buyer_id
    and mem_name = '����ȣ';

--2. ȸ�� ���ϰ� ���� ���� �� ��ǰ��� ȸ�� ����� ���� �������� �����Ǿ��ִ� ���ο� �÷� ������ �����ּ���
Select prod_name, mem_name, decode(mod(substr(mem_regno2,1,1),2),1,'����','����') as mem_sex
From member, cart, prod
Where mem_id = cart_member
    and prod_id = cart_prod
    and substr(cart_no,5,2) = to_char(mem_bir,'mm');
                    
                    


/* 5�� */
--1. ȸ������ ������ ��ǰ�� �ݾ��� (as mount)�� ���� ���Ͻÿ�
--��ȸ �÷��� mem_name, mem_id, prod_sale , cart_qty, mount, lprod_nm
Select distinct mem_name, mem_id, prod_sale , cart_qty, (cart_qty*prod_sale)as mount, lprod_nm
From member, prod, cart, lprod
Where mem_id = cart_member
    and prod_id = cart_prod
    and prod_lgu = lprod_gu;

--2. �԰� ��ǰ�������� ��ǰ�ڵ庰 ��ǰ��� ��ǰ�� �������� ���ϼ��� .  ? (group by ���)
--���� = ��ǰ����(cart���̺��� �ȸ� ��ǰ�� ���� * �ǸŰ�)  - ��ǰ���Ժ��(���Լ���*���Դܰ�)
Select distinct buy_prod, prod_name, sum((cart_qty*prod_sale)-(buy_qty*buy_cost))as price
From prod, cart, buyprod
Where prod_id = cart_prod
    and prod_id = buy_prod
Group by buy_prod, prod_name;

--3. ���� �� ������ �ִ� �ŷ�ó�� �ŷ��� ��ǰ�� �߿� �԰�� ��ǰ ��ȸ
--- ��ȸ : �ŷ�ó��, ��ǰ��, ��ǰ ��ȭ��ȣ(�ŷ�ó)
--- ���� : �ŷ�ó������ ��������
Select distinct buyer_name, prod_name, buyer_comtel
From buyer, prod
Where prod_buyer = buyer_id
    and substr(buyer_add1,1,2) != '����'
    and prod_lgu = buyer_lgu
Order By buyer_name Asc;

--4.  �������� 10% �����̰�, �ŷ�ó�� �Ｚ�� ���� ��ǰ�� ������ 
--ȸ���� �̸��� ����, ������, ���� ��ǰ�� ��ǰ���� ��ȸ�ϱ�
--- ��ȸ�� ȸ���̸�, ȸ������, ������, ��ǰ��
--- �������� (�Һ��ڰ� - �ǸŰ�/�Һ��ڰ� * 100)
Select mem_name, mem_job, ((prod_price - (prod_sale/prod_price))*100)as sale, prod_name
From member, cart, prod
Where prod_id = cart_prod
    and mem_id = cart_member
    and ((prod_price - (prod_sale/prod_price))*100)<= 10;