/* Null ó���ϱ� */

/* ����ġ �ִ� ���̺� ����� */
-- �Ϻ� �����͸� null�� ������Ʈ(=����) �� null üũ

-- 1. ������ ������ ������ Select�� �����
-- �ŷ�ó ����� �� '��'���� ���� ��ȸ�϶�
Select *
From buyer
Where buyer_charger like '��%';
-- ��ȸ��� : 2��(�̼���, ������)

-- 2. ��ȸ���(����� �̸�) -> Null�� ����(Update)
Update buyer
    Set buyer_charger = null
    Where buyer_charger like '��%';
    
-- 3. ������ Select�� �̿��� �����Ǿ����� Ȯ��
Select *
From buyer
Where buyer_charger like '��%';
-- ��ȸ��� : 0��

-- nullȮ��
-- null�� �޸� ������ �������� �ʴ´� -> ����, ���� ���� �񱳺Ұ�
Select buyer_charger
From buyer
Where buyer_charger is null; --is null : Where������ ��밡����

-- null ��ü�� �ֱ� : nvl, nvl2()
-- nvl���� ���� ���
Select buyer_charger, nvl(buyer_charger, '�� ����?'), nvl2(buyer_charger, 'null�� �ƴ�', 'null�̳�')
From buyer
Where buyer_charger is null;


-- ȸ�� �߿� '��'���� ������ ��ǰ���� ��ȸ�ϱ�
-- ��ȸ : ��ǰ�ڵ� ,��ǰ��, �Һ��� ����
Select prod_id, prod_name, prod_price
From prod
Where prod_id in (Select cart_prod From cart
                                    where cart_member in (Select mem_id From member
                                                                        where mem_name like '��%'));

-- �� ���ǿ� ���� �Һ��ڰ����� ���� null�� �����ϱ�
Update prod
    Set prod_price = 0
    Where prod_id in (Select cart_prod From cart
                                    where cart_member in (Select mem_id From member
                                                                        where mem_name like '��%'));
                                                                        
-- Ȯ��
Select prod_id, prod_name, prod_price
From prod
Where prod_id in (Select cart_prod From cart
                                    where cart_member in (Select mem_id From member
                                                                        where mem_name like '��%'));
                                                                        
-- ���� ������ ó��
-- �Һ��� ������ 0�ΰ�� �Һ��ڰ����� ��ü ��հ����� ����    
Select avg(nvl(prod_price,0)), sum(nvl(prod_price,0))
From prod;

Select avg(nvl(prod_price,0))
From prod
Where prod_price != 0;

Update prod
    Set prod_price = (Select avg(nvl(prod_price,0))
                      From prod
                      Where prod_price != 0)
    Where prod_price = 0;
    

-- ��ȸ : �ŷ�ó��, �ŷ�ó�����
-- null�� ����ڴ� '�� ����?'�� ��ȸ�ϱ�
-- ��, �ŷ�ó������ '��������'�� �����Ϳ����ؼ��� ��ȸ
-- ���� : �ŷ�ó����� Asc
Select buyer_name, nvl(buyer_charger, '�� ����?') as buyer_charger
From buyer
Where buyer_bank = '��������'
Order By buyer_charger Asc;

-- ��ȸ : ȸ�����̵�, ȸ�����ϸ����� ���/ ����/�ִ밪/�ּҰ� ��ȸ�ϱ�
-- ��, ������ ���￡ �������� ���ϸ����� ��� �̻��� ȸ���鿡 ���ؼ��� ��ȸ
Select mem_id, avg(nvl(mem_mileage,0)) as avg, sum(nvl(mem_mileage,0)) as sum, max(nvl(mem_mileage,0)) as max, min(nvl(mem_mileage,0)) as min
From member
Where mem_mileage >= (Select avg(mem_mileage)
                        From member
                        Where substr(mem_add1,1,2) = '����')
Group by mem_id;

-- null�� ��ȯ�ϴ� �Լ�
Select Nullif('abc','abc'), Nullif('abc', 'ab')
From dual;

-- ������ ������ ��쿡 null�� ��ȯ�ؼ� ��ȸ�϶�
-- ��ȸ : ȸ�����̵�, ����
Select mem_id, nullif(substr(mem_add1,1,2), '����') as mem_add
From member;


/* if���� ������ �Լ� : Decode() */
-- �÷� ��� ���
-- Decode(���ǰ�, �񱳰�1, ó����1,
--                �񱳰�2, ó����2)
--                �񱳰�n, ó����n
--                ��Ÿ��)
Select Decode(substr(mem_add1, 1, 2),
                '����', '��������',
                '��Ÿ') as add1
From member; 

-- ��ȸ : ��ǰ��, ��ǰ�з���
-- ��ǰ�з��ڵ� ���ڸ� 2���� P1�̸� ��ǻ��/���� ��ǰ, p2�� �Ƿ�, p3�� ��ȭ, �� �� ��Ÿ�з��� ��ȸ�϶�
Select prod_name, Decode(substr(prod_lgu, 1, 2),
                        'P1', '��ǻ��/���� ��ǰ',
                        'P2', '�Ƿ�',
                        'P3', '��ȭ',
                        '��Ÿ�з�') as prod_lgu
From prod;

-- ��ȸ : ȸ�����̵�, ȸ���̸�, ����
-- ������ ����, ���ڷ� ���
Select mem_id, mem_name, Decode(Mod(Substr(mem_regno2, 1, 1), 2),
                                1, '����',
                                '����') as ����
From member;

-- ��ȸ : ��ǰ��, ��ǰ�ǸŰ���, ��ǰ�ǸŰ����� �λ�
-- ��ǰ�ǸŰ����� �λ� : ��ǰ�з��ڵ��� �� 2�ڸ��� �������� 'P1'�̸� �ǸŰ��� 10%�λ�� ������ ��ȸ, 'P2'�� 15%�λ�� ������ ��ȸ �������� �״�� ��ȸ
-- ���� : �λ� Desc
Select prod_name, prod_sale, Decode(substr(prod_lgu,1,2),
                                    'P1', prod_sale+(prod_sale*0.1),
                                    'P2', prod_sale+(prod_sale*0.15),
                                    prod_sale)as prod_price_up
From prod
Order by prod_price_up Desc;

-- ��ȸ : ��ǰ�з��ڵ庰 ��ǰ���
-- ��ǰ����� �Ʒ��� ���� ó��
/* ��ǰ�з��ڵ庰�� ��ǰ�� ������ üũ�Ͽ�
5���� -> A���
10���� -> B���
15���� -> C���
20���� -> D���
25���� -> E���
�� �� -> F��� */
Select prod_lgu, count(prod_lgu), (case
                                    When count(prod_lgu)<=5 Then 'A���'
                                    When count(prod_lgu)<=10 Then 'B���'
                                    When count(prod_lgu)<=15 Then 'C���'
                                    When count(prod_lgu)<=20 Then 'D���'
                                    When count(prod_lgu)<=25 Then 'E���'
                                    Else 'F���'
                                    End) as prod_cnt_rank
From prod
Group By prod_lgu;

--ȸ���̸�, ���� ��ȸ ->case����ؼ�
Select mem_name, (Case
                    When Mod(Substr(mem_regno2,1,1), 2) = 0 Then '����'
                    Else '����'
                    End) as mem_sex
From member;

--��ǰ ���ſ��� ���ż����� ���, ����� ��ȸ
-- ����� ����� 10���� ũ�� A���, �ܴ̿� B������� ó��
-- ��, ���� ��ǰ�з� �߿� 'ĳ�־�'�̶�� �з����� ���Ե� ����, ��ǰ�� '����'�� ���Ե� ��츸 ��ȸ
Select substr(cart_no,5,2) as chart_mon,
    avg(cart_qty) as qty_avg,
    (Case When avg(cart_qty)>10 Then 'A���' --�׷��Լ��� �̿��� ó�������� group by�� ���� �ʾƵ� �ȴ�
        Else 'B���'
        End) as qty_rank
From cart
Where cart_prod in (Select prod_id From prod Where prod_name like '%����%')
    and cart_prod in (Select prod_id From prod Where prod_lgu in (Select lprod_gu from lprod where lprod_nm like '%ĳ�־�%'))
Group By substr(cart_no,5,2);


/* Exists()�Լ� : Where���� �������� ��� */
-- �ֹ������� �ִ� ȸ������
Select *
From member
Where Exists(Select * From cart Where cart_member = mem_id);