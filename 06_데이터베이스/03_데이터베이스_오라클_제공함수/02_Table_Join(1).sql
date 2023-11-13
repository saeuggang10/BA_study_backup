-- ���̺� join
--�������� ���̺��� �޸𸮿� �÷����� �����Ӱ� ��밡��
--���̺� ������ ������ PK=FK���迡 ���� ����
--���̺� ������ ����� ���� ��������(PK=FK)�� ����ؼ� ���̺�� ������ (�������� PK=FK�� ���� ����)
--���̺� ���ο��� Inner Join, Outer Join(left, right), Self Join�� ��ǥ��
--PK=FK�� ��������� ���� �̿��� ������ ���� �ڿ����� �����̶� �Ѵ�
--����ǥ��(ANSI)�� �Ϲݹ��(�����ͺ��̽� �ý��� ���� �ڵ�)�� ����
--ANSI����� ������ ��� �����ͺ��̽� �ý��ۿ��� ��밡��

/* Cross Join */
-- �Ϲ� ���
-- ���̺�1 �� �� * ���̺�2 �� �� ��ŭ ��ȸ��
-- �������� ���� (������ ��� ��� ���� ũ�ν� �ؼ� ��ȸ)
-- �����Ͱ� �ſ� ���� ��� ������ ���� �ɸ����� ���� ! �� �����ϰ� ��� !!
Select mem_id, cart_no, prod_name, lprod_nm, buyer_name
From member, cart, prod, lprod, buyer
Where mem_id = 'a001';

-- ����ǥ�� ���
Select *
From member Cross Join cart
            Cross Join prod
            Cross Join lprod
            Cross Join buyer
Where mem_id = 'a001' and prod_name like '%�Ｚ%';


/* Inner Join */
/* �ֹ� ������ �ִ� ȸ���� ���Ͽ� ȸ�����̵�, ȸ���̸�, �ֹ�����, ��ǰ�ڵ� ��ȸ */
-- �Ϲ� ���
Select mem_id, mem_name, cart_qty, cart_prod
From member, cart
Where mem_id = cart_member; --�������ǽ� �ۼ�(PK=FK ����)

-- ����ǥ�� ���
Select mem_id, mem_name, cart_qty, cart_prod
From member Inner Join cart
            On (mem_id = cart_member
                and substr(mem_name,1,1) = '��');
                
-- ��ǰ ���̺���� �߰�.ver
-- �Ϲ� ���
Select mem_id, mem_name, cart_qty, cart_prod, prod_name
From member, cart, prod
Where mem_id = cart_member
        and cart_prod = prod_id
        and substr(mem_name,1,1) = '��';

-- ����ǥ�� ���     
Select mem_id, mem_name, cart_qty, cart_prod, prod_name
From member Inner Join cart
            On (mem_id = cart_member
                and substr(mem_name,1,1) = '��')
            Inner Join prod
            On (prod_id = cart_prod);
            
            
-- ��ȸ : ȸ�����̵�, ȸ���̸�, �ֹ���ȣ, ��ǰ��, ��ǰ�з���, �ŷ�ó��
-- ���� : ȸ���̸� Asc
-- ���̺� ������ �־ lprod�� buyer�� ��������(lprod_gu = buyer_lgu)�� ���� ������ ��
-- �Ϲ� ���
Select mem_id, mem_name, cart_no, prod_name, lprod_nm, buyer_name
From member, cart, prod, lprod, buyer
Where mem_id = cart_member
    and prod_id = cart_prod
    and prod_lgu = lprod_gu
    and prod_buyer = buyer_id
Order By mem_name Asc;

-- ANSI
Select mem_id, mem_name, cart_no, prod_name, lprod_nm, buyer_name
From cart Inner Join member
            On cart_member = mem_id
            Inner Join prod
            On cart_prod = prod_id
            Inner Join lprod
            On prod_lgu = lprod_gu
            Inner Join buyer
            On prod_buyer = buyer_id
Order By mem_name;

-- ��ǰ�з����� ��ǰ�� ������ ��ȸ
-- ��ȸ : ��ǰ�з��ڵ�, ��ǰ�з���, ��ǰ�� ����(��Ī cnt)
-- ���� : cnt���� Desc
Select lprod_gu, lprod_nm, count(prod_id) as cnt
From lprod, prod
Where prod_lgu = lprod_gu
Group By lprod_gu, lprod_nm
Order By cnt Desc;

Select lprod_gu, lprod_nm, count(prod_id) as cnt
From lprod Inner Join prod
            On prod_lgu = lprod_gu
Group By lprod_gu, lprod_nm
Order By cnt Desc;


/* ���̺� ��Ī */
-- ���̺� ���� ���� �̸��� ������ �����Ѵٸ� �� ����ؾ� ��
Select LP.lprod_gu, lprod_nm, count(prod_id) as cnt
From lprod LP, prod P
Where prod_lgu = lprod_gu
Group By lprod_gu, lprod_nm
Order By cnt Desc;

-- '����' �Ǵ� '����'������ �����ϴ� ȸ���� ������ ��ǰ������ ��ȸ
-- ��ǰ�� '�Ｚ'�� ���ԵǾ�� �Ѵ�
-- ��ȸ : ȸ���̸�, ��������, ��ǰ��, ��ǰ�з���, �ŷ�ó��
-- ���� : ȸ���̸� Asc
-- �Ϲ�
Select Distinct mem_name, substr(mem_add1,1,2) as mem_add, prod_name, lprod_nm, buyer_name
From member, prod, lprod, buyer, cart
Where mem_id = cart_member
    and prod_id = cart_prod
    and prod_lgu = lprod_gu
    and prod_buyer = buyer_id
    and (substr(mem_add1,1,2) = '����' or substr(mem_add1,1,2) = '����')
    and prod_name like '%�Ｚ%'
Order By mem_name Asc;

-- ANSI
Select Distinct mem_name, substr(mem_add1,1,2) as mem_add, prod_name, lprod_nm, buyer_name
From cart Inner Join member
        On (mem_id = cart_member
            and substr(mem_add1,1,2) in ('����', '����'))
        Inner Join prod
        On (prod_id = cart_prod
            and prod_name like '%�Ｚ%')
        Inner Join lprod
        On prod_lgu = lprod_gu
        Inner Join buyer
        On prod_buyer = buyer_id
Order By mem_name Asc;