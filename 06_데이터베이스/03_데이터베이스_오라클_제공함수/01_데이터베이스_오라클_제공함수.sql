-- ȸ�� ���ϸ����� ���� 1000�� ȸ���� �ֹ��� ��ǰ�ڵ�, ��ǰ�� ��ȸ
Select prod_id, prod_name
From prod
Where prod_id in (Select cart_prod from cart where cart_member in (Select mem_id from member Where mem_mileage = 1000));


----------------------------------------------
/* ����Ŭ������ ��� ������ �Լ����� */

/* ������ġ�� */
-- Select���� Where���� ��밡��
-- �ּ�1�� �ּ�2 ��ġ��
Select (mem_add1 || ' ' || mem_add2) as mem_add
From member;

-- concat�� 2���� ��ĥ �� ����
Select (mem_add1 || ' ' || mem_add2) as mem_add,
        concat(mem_add1, mem_add2) as mem_add
From member;

-- concat ���� ����ϱ�
Select concat(mem_add1, concat(' ', mem_add2)) as mem_add
From member;

-- �ƽ�Ű��ȣ ���ڸ� ���ڷ� �ٲٱ�
Select Chr(65), Chr(66), Chr(67)
From member;

Select Ascii('a'), Ascii('A'), Ascii('z')
From member;

-- ��ҹ��� �ٲٱ�
-- Upper : �빮�ڷ� ��� �ٲٱ�
-- Lower : �ҹ��ڷ� ��� �ٲٱ�
-- InitCap : �ܾ� �� ù���ڸ� �빮�ڷ� �ٲٱ�
Select mem_id, Upper(mem_id) as up_mem_id, initcap('abcd efg hi'), Lower('AbcD')
From member;

-- ���� ä���
-- lpad : �����ʺ��� ���� ä�� �� �� ������ �������ڷ� ä���
-- rpad : ���ʺ��� ���� ä�� �� �� ������ �������ڷ� ä���
-- ���� �ѱ��� �ƴ� ��� : ���� 1���� ����
-- ���� �ѱ��� ��� : ���� 2���� ����
Select Lpad(mem_id, 2, '*') as lpad_mem_id,
        Lpad(mem_id, 6, '*') as lpad_mem_id,
        Rpad(mem_id, 6, '*') as rpad_mem_id,
        Lpad(mem_name, 10, '*') as lpad_mem_name,
        Rpad(mem_name, 10, '*') as rpad_mem_name
From member;

-- ȸ���� �ֹε�Ϲ�ȣ�� �Ʒ��� ���� ���·� ����ض�
-- 000000-*******
select (mem_regno1 || '-' || '*******') as mem_regno
from member;

select Rpad((mem_regno1 || '-'), 14, '*') as mem_regno
from member;

-- ��������
Select LTrim('   abdc  bdbe w b ') as LT,
        RTrim('   abdc  bdbe w b ') as RT,
        Trim('   abdc  bdbe w b ') as T
From member;

-- ���ڿ� �ڸ���
-- 0, 1��� 1��°�� �ν�
SELECT substr('a001',0,2) as s1,
        substr('a001',1,2) as s2,
        substr('a001',-1) as s3,
        substr('a001',-3) as s4
From member;

-- �ֹ���ȣ ��Ģ : �� 4�ڸ��� ����, 2�ڸ��� ��, 2�ڸ��� ��, ������ 2�ڸ��� ���������� 1�� ����
-- ��ǰ�ڵ� ��Ģ : ��4�ڸ��� ��ǰ�з��ڵ�
Select *
From cart;
-- �达 ���� ���� ȸ���� �ֹ��� ��ǰ���� �з��� � ������ Ȯ���ϱ�
-- prod���̺��� ������� �ʰ�, ��ǰ�з��ڵ�, ��ǰ�з��� ��ȸ
Select lprod_gu, lprod_nm
From lprod
Where lprod_gu in (Select substr(cart_prod,1,4) from cart where cart_member in (Select mem_id from member where mem_name like '��%'));

Select distinct substr(cart_prod,1,4) as cart_p, (Select lprod_nm From lprod where lprod_gu = substr(cart_prod,1,4)) as lprod_nm
From cart
Where cart_member in (Select mem_id from member where mem_name like '��%');


/* PK, Fk, index, ���ν���, Ʈ����, View, �Լ� ��� ���� */
Select *
From member
Where mem_name Like '��%'; -- 24�� ��� üũ

-- ������ ġȯ�ϱ�
Select mem_id,
        Replace(mem_id, '001', '**1'),
        Replace('�ȳ� �ϼ���! ���̽�!', '�ϼ���', '�ݰ���')
From member;

-- ȸ�� �̸� �߿� �̾��� ������ �ٲ� ��ü��ȸ
Select mem_id, (Replace(substr(mem_name,1,1),'��','��') || substr(mem_name,2,3)) as mem_name
From member; 

-- ���ڿ��� ���� Ȯ���ϱ�
-- length : ������ ���� ����
-- lengthB : ������ ����Ʈ ����
Select length(mem_id), length(mem_name),
        lengthB(mem_id), lengthB(mem_name)
From member;

-- �ӽ����̺� : �Լ� �� ���ڿ� ó�� � ���� �׽�Ʈ�� (1�� 1���� �������)
Select *
From Dual;

-- ���밪
Select Abs(-365), Abs(365), Abs(null)
From Dual;

-- ����
Select Power(2,2), Power(2,3)
From Dual;

-- Greatest : ���� ū �� ��ȸ
-- Least : ���� ���� �� ��ȸ
Select Greatest(10, 50, 20, 40), Greatest('b', 'a', 'A'),
        Least(10, 50, 20, 40), Least('b', 'a', 'A')
From Dual;

-- ȸ�� ��ü�� ���� �̸�, ���ϸ��� ��ȸ�ϱ�
-- ��, ���ϸ����� ���� 1000���� ���� ��� 1000���� �����Ͽ� ��ȸ�ϱ�
Select mem_name, Greatest(mem_mileage, 1000), mem_mileage
From member;

-- �ݿø� : round
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

-- ��ǰ���̺��� ��ǰ��, ������(���԰�/�ǸŰ� *100) ��ȸ�ϱ�
-- ����� �Ҽ��� ù°�ڸ����� ǥ��
-- ��, ��ǰ�� �Ｚ�̶�� �ܾ �ִ� �����͸� ����
Select prod_name, round(prod_cost/prod_sale*100,1) as cost
From prod
Where prod_name Like '%�Ｚ%';

-- ���� : Trunc()
-- ���� �������� �� �����ϱ�
Select Mod(10,2), Mod(10,3)
From Dual;

-- ȸ�� ������ �����Ϸ� �Ѵ�. ���ڴ� 1, ���ڴ� 0
-- ��ȸ : ȸ���̸�, ����(��Ī m1)
Select mem_name, mod(substr(mem_regno2,1,1),2) as m1
From member;


/* ������, ���� ��ư� ���� 4���� �����. ����� ����� */
-- ���ݱ��� ��� ��� �� ����(���̺���� �� �� �߰��� ����)
-- ������ 0��.txt���Ϸ� �����ؼ� ���۵���̺꿡 ����
-- 1. �ּ�1�� �������� �����ϴ� ������� ���̺��� �����
-- �� ���̺��� �̿��� �达�� �ƴϰ�, �ŷ�ó�� �����ȣ ���ڸ� 3�ڸ��� ȸ���� �����ȣ ���ڸ� 3�ڸ��� ���� ����� ���ض�
Select *
From (Select * from member where mem_add1 Like '����%')
Where substr(mem_zip,1,3) in (select substr(buyer_zip,1,3) from buyer) and mem_name not like '��%';

-- Ȯ�ο�
select Distinct buyer.buyer_zip
from buyer;

select Distinct member.mem_zip
from member;