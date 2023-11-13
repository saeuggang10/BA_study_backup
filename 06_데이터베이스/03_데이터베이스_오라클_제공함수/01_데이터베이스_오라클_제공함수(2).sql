/* ��Ǯ�� */
--������ ȸ���� ������ ��ǰ �߿� ��ǰ�� '�����'�� ���Ե� ��ǰ�� �������ڸ� Ȯ���Ϸ��Ѵ�
ȸ�����̵�, ȸ���̸�, �ֹ�����, ��ǰ���� ��ȸ
--�̸��� �������� ������������
Select (Select mem_id from member where mem_id = cart_member) as mem_id,
        (Select mem_name from member where mem_id = cart_member) as mem_name,
        substr(cart_no,1,8) as cart_date,
        (Select prod_name from prod where prod_id = cart_prod) as prod_name
From cart
Where cart_member in (Select mem_id from member where mem_name = '������')
        and cart_prod in (Select prod_id from prod where prod_name like '%�����%')
Order By (Select mem_name from member where mem_id = cart_member) Asc;

-- ��ǰ�з���, ��ǰ��, �ŷ�ó���� ��ȸ�϶�. ��, ��ǰ�� �Ｚ�� ���Ե� ��츸
Select (Select lprod_nm from lprod where lprod_gu = prod_lgu) as lprod_nm,
        prod_name,
        (Select buyer_name from buyer where buyer_id = prod_buyer) as buyer_name
From prod
Where prod_name like '%�Ｚ%';

-- ȸ�����̵�, ȸ���̸��� ��ȸ�� �ּ���
-- ��, ��ǰ�з��� �߿� '��ǻ����ǰ'���� ������ ��ǰ�� ������ ȸ���� ���ؼ���
Select Distinct (Select mem_id from member where mem_id = cart_member) as mem_id,
                (Select mem_name from member where mem_id = cart_member) as mem_name
From cart
Where cart_prod in (Select prod_id from prod where prod_lgu in (Select lprod_gu from lprod where lprod_nm = '��ǻ����ǰ'));

--prod ���� ����
Select Distinct (Select mem_id from member where mem_id = cart_member) as mem_id,
                (Select mem_name from member where mem_id = cart_member) as mem_name
From cart
Where substr(cart_prod,1,4) in (Select lprod_gu from lprod where lprod_nm = '��ǻ����ǰ');

--from : member
Select mem_id, mem_name
From member
Where mem_id in (Select cart_member from cart where cart_prod in (Select prod_id from prod where prod_lgu in (Select lprod_gu from lprod where lprod_nm = '��ǻ����ǰ')));


/* ��¥ �Լ� */
-- ��¥�� �����ؼ��� �����ͺ��̽� �ý��۸��� �ٸ�

-- �ý��� ��¥ ��������
Select sysdate FROM dual;

-- �ý��� ��¥�� 1���ϰų� ����
Select sysdate, sysdate + 1, sysdate -1
From dual;

-- ȸ���� �̸�, ����, 12000��° �Ǵ� ���� ��ȸ�϶�
-- 12000��° �Ǵ� ���� ��Ī�� bir2�� ���
Select mem_name, mem_bir, (mem_bir + 12000) as bir2
From member;

-- �� ���ϰ� ����
Select Add_months(sysdate,1), Add_months(sysdate,-1)
From dual;

-- ���� ���� ���Ͽ� ���� ��¥ã��
Select Next_day(sysdate,'�Ͽ���')
From dual;

-- �ش� ���� ������ ���� ã��
Select Last_day(sysdate)
From dual;

Select Last_day('2023-06-23'), Last_day('2023/06/23'), Last_day('20230623')
From dual;

-- �̹����� ���ϳ��Ҵ°�?
Select (Last_day(sysdate)-sysdate) as ����_��¥
From dual;

-- 
-- q : �б�
Select round(sysdate), round(sysdate, 'yyyy'), round(sysdate, 'mm'), round(sysdate, 'dd'), round(sysdate, 'q')
From dual;

-- ���� ���Ǵ� �Լ���
-- �ʿ��� �κи� ����
Select Extract(Year from sysdate),
        Extract(Month from sysdate),
        Extract(Day from sysdate)
From dual;

-- ȸ���� ������ 3���� ȸ���� ��ȸ�ض�
Select *
From member
Where Extract(Month from mem_bir) = 3;

Select *
From member
Where Extract(Month from mem_bir) = '3';

Select 3+3, '3'+3, '3'+'3'
From dual;

-- Ÿ�� ��ȯ�ϱ�(����ȯ)
SELECT '-' || cast(123 as char(5)) || '-',
        '-' || cast(123 as varchar2(5)) || '-',
        '-' || cast('20230626' as date) || '-',
        cast('123' as number(5))
From dual;

Select to_char(123), to_date('2023-06-14'), to_number('23456')
From dual;

Select to_char(sysdate),
        to_char(sysdate, 'yyyy-mm-dd') as y1,
        to_char(sysdate, 'yyyy.mm.dd') as y2,
        to_char(sysdate, 'yyyy/mm/dd') as y3,
        to_char(sysdate, 'yyyy*mm*dd') as y4,
        to_char(sysdate, 'yyyy-mm-dd (am)hh24:mi:ss [day]') as y5,
        to_char(sysdate, 'yyyy-mm-dd (am)hh:mi:ss [day]') as y6 -- 12�ð� ǥ��
From dual;

-- ��ǰ��, ��ǰ����� ��ȸ
-- ��ǰ������� '0000-00-00'���·� ��ȸ
Select prod_name, to_char(prod_insdate, 'yyyy-mm-dd') as yy
From prod;

-- ȸ�� ������ �Ʒ�ó�� ��ȸ�ǵ��� ó���϶�
-- '��������� 0000�� 0�� ����̰�, �¾ ������ 0����'
SELECT mem_name || '���� '
    || Extract(Year from mem_bir) || '�� '
    || Extract(Month from mem_bir) || '�� ����̰�, �¾ ������ '
    || to_char(mem_bir, 'day') as ���
From member;

-- �������� �����ϱ�
Select to_char(1234556, '999,999,999') as num,
        to_char(1234556, 'L999,999,999') as num,
        to_char(1234556, '999,999,999L') as num,
        to_char(1234556, '$999,999,999') as num,
        to_char(-1234556, 'L999,999,999PR') as num,
        '-' || to_char(-1234556, 'L999,999,999PR') || '-' as num, --���ʿ� ������ ������ �� �� �ִ�
        '-' || to_char(-1234556, 'L999,999,999,999,999PR') || '-' as num --�� �þ --������ ������ �־����. �׳� �� ũ���ϸ� ����Ʈ�� ��Ƹ���
From dual;


-- ȸ���� �¾�� ��� °���� ��ȸ�϶�
-- �Ҽ����� �ִ� ��� �Ҽ��� ù°�ڸ����� �ݿø�
-- ��ȸ�÷� : ȸ���̸�, ȸ������, �¾�� �� ����(day2)
Select mem_name, mem_bir,
        round(months_between(sysdate, mem_bir),1) as bir2
From member;

-- ��ǰ�ڵ�, ��ǰ��, ���԰���, �Һ��ڰ���, �ǸŰ��� ��ȸ�ϱ�
-- ������ õ���� ���� �� ��ȭǥ��
-- ��, ��ǰ�� '�Ｚ'�� ���ԵǾ��־�� �ϰ�, �达 ���� ���� ȸ���� ������ ��ǰ������ ��ȸ
Select prod_id, prod_name, to_char(prod_cost, 'L999,999,999') as cost, to_char(prod_price, 'L999,999,999') as price, to_char(prod_sale, 'L999,999,999') as sale
From prod
Where prod_name like '%�Ｚ%' and
      prod_id in (Select cart_prod from cart where cart_member in (Select mem_id from member where mem_name like '��%'));
      
-- ���̵� ���ڸ� 2�ڸ��� �����Ͽ� 10�� ���� ����, ���� ���ڸ� 2�ڸ��� ���ļ� ��ȸ�϶�
Select substr(mem_id,1,2) || (substr(mem_id,3,4)+10) as mem_id_new
From member;

Select substr(mem_id,3,-1)
From member;

-- �ֹ���ȣ ������Ű��
-- ���� ����� �������� ���ʿ� �ֹ��� �߻��ϸ� �ֹ���ȣ�� �����ؾ� �մϴ�
-- ���� ������ �ֹ���ȣ�� �����ض�. �ֹ���ȣ ������ Ȯ�� �� �����ϱ�
Select to_char(sysdate, 'yyyymmdd') || Lpad(1, 5, '0') as char_no_new
From dual;


/* �׷��Լ� (= ��������Լ�) */
-- count, min, max, avg, sum

-- ��ǰ�ǸŰ����� ������ �Ǽ�, ���ʰ���, �ִ밡��, ���, ���� ��ȸ�ϱ�
Select count(prod_sale), min(prod_sale), max(prod_sale), avg(prod_sale), sum(prod_sale)
From prod;

-- ���� �������� ��ǰ����� ��ȸ�϶�
-- �Ϲ� col�� �׷��Լ��� ���ÿ� Select�Ϸ��� Group By �Լ��� ����Ѵ�
Select count(prod_sale), min(prod_sale), max(prod_sale), avg(prod_sale), sum(prod_sale), prod_name
From prod
Group By prod_name;

-- ��ǰ���̺��� ��ǰ�з��ڵ庰�� ��ǰ�� ������ ��ȸ�ϱ�
Select prod_lgu, count(prod_lgu) as cnt
From prod
Group By prod_lgu
Order By cnt Asc;

Select substr(cart_prod,1,4) as lgu, count(substr(cart_prod,1,4))
From cart
Group By substr(cart_prod,1,4)
Order By lgu Asc;

Select substr(cart_prod,1,4) as lgu, count(substr(cart_prod,1,4))
From cart
Group By substr(cart_prod,1,4) --�׷�ȭ
HAVING count(substr(cart_prod,1,4)) > 20 --�׷쿡 ���� ����
Order By lgu Asc;

-- �׷��Լ� + �Ϲ�����
Select substr(cart_prod,1,4) as lgu, count(substr(cart_prod,1,4))
From cart
Where cart_member = 'a001' --�Ϲ�����
Group By substr(cart_prod,1,4) --�׷�ȭ
HAVING count(substr(cart_prod,1,4)) > 20 --�׷쿡 ���� ����
Order By lgu Asc;


--��ǰ�з��ڵ庰�� ��ǰ�Һ��ڰ����� ����� ��ȸ�϶�
--����� �Ҽ��� 2�ڸ����� ǥ���϶�
Select prod_lgu, round(avg(prod_price),2) as price_avg
From prod
Group By prod_lgu;

-- ȸ���� ���� ���� ������ ��ȸ�϶�
-- ��ȸ : ȸ������, ����
Select substr(mem_name,1,1) as ȸ������, count(substr(mem_name,1,1)) as cnt
From member
Group By substr(mem_name,1,1)
Order By ȸ������ Asc;

-- ��ȸ : ȸ���� ���̵�, �̸�, ���ϸ���
-- ��, ȸ�� ��ü�� ���� ��հ����� ū ���ϸ��� ���� ������ ȸ���� ��ȸ
Select mem_id, mem_name, mem_mileage
From member
Where mem_mileage > (Select avg(mem_mileage)
                        From member);
                        
-- ȸ�� �߿� '��'�� ���� ���� ȸ���� �ֹ��� ��ǰ�� ���� ��ǰ�з��ڵ庰�� �ֹ������� ������ ��ȸ�Ϸ��Ѵ�.
-- ��, ��ǰ�� '�Ｚ'�� ���Ե� ��ǰ�� ������ ȸ���� ���ؼ���
-- ��ȸ : ��ǰ�з��ڵ�, �ֹ������� ����
Select substr(cart_prod,1,4) as prod_lgu, sum(cart_qty)
From cart
Where cart_member in (Select mem_id from member where mem_name like '��%')
    and cart_prod in (Select prod_id from prod where prod_name like '%�Ｚ%')
Group by substr(cart_prod,1,4);


-- ȸ�� ������(����, ���� ...) ������ �⵵����
-- ȸ���̸�, ����, ����⵵, ���ϸ��� ���/�հ� ��ȸ
-- ��, ȸ�� ������ '��'��
-- ���� : ������������ ��������, ���� �⵵ ���� ��������

Select mem_name,
        substr(mem_add1,1,2) as mem_loc,
        to_char(mem_bir, 'yyyy') as mem_yyyy,
        sum(mem_mileage) as mil_sum,
        avg(mem_mileage) as mil_avg
From member
Where mem_name like '��%'
Group By mem_name,
        substr(mem_add1,1,2),
        to_char(mem_bir, 'yyyy')
Order By mem_loc Desc, mem_yyyy Asc;

Select substr(mem_name,1,1),
        substr(mem_add1,1,2) as mem_loc,
        to_char(mem_bir, 'yyyy') as mem_yyyy,
        sum(mem_mileage) as mil_sum,
        avg(mem_mileage) as mil_avg
From member
Where mem_name like '��%'
Group By substr(mem_name,1,1),
        substr(mem_add1,1,2),
        to_char(mem_bir, 'yyyy')
Order By mem_loc Desc, mem_yyyy Asc;

-- ����-����
Select substr(mem_name,1,1),
        substr(mem_add1,1,2) as mem_loc,
        sum(mem_mileage) as mil_sum,
        avg(mem_mileage) as mil_avg
From member
Where mem_name like '��%'
Group By substr(mem_name,1,1),
        substr(mem_add1,1,2)
Order By mem_loc Desc;