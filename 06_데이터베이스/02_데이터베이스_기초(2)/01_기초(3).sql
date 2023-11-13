-- 02_�����ͺ��̽�_����(2)

/* ���� ������ ��� ���̺� �����ϱ� */
Drop Table test_TB;
Drop Table Test_TB2;
Drop Table test01;
Drop Table test02;


/* IT ������Ʈ ���� ���� */
-- 1. ��ȹ(��ȹ)
-- 2. �䱸���� ����
-- 3. �䱸�м�
-- 4. �м�����
-- 5. ����
-- 6. �׽�Ʈ
-- 7. ����
-- 8. ��������

/* �м� ������Ʈ ���� ���� */
-- 1. ������ȹ
-- 2. ���� ������ ���ø�
-- 3. ���� �м�
-- 4. ����ȹ (1��������Ʈ~)
-- 5. �� ������ ����
-- 6. ��ó��
-- 7. ����
-- 8. ��ó��
-- 9. �ð�ȭ (1��������Ʈ//)
-- 10. �߰� �ڵ�ȭ �ʿ��� �����Ͱ� �ִ� ��� -> ������/�ӽŷ���
-- 11. ������ �÷��� ����(��쿡 ����, ������ ������ �ϴ� ��� ����. IT������Ʈ ������ ����)
-- 12. ����


/* oracle_base_table.sql���� */
/* oracle_base_table.sql ������ Ȯ�� */
select * from buyer;
select * from buyprod;
select * from cart;
select * from lprod;
select * from member;
select * from prod;


/* 1. ���̺� ���Ǽ� �ۼ� */
-- ->���̺����Ǽ�_������.xlsx

/* 2. ���̺� ���赵(=ERD) �ۼ� */
-- ->ERD_������.png

/* 3. ȸ������ �� �Ʒ��� ���� ������ ��ȸ�� �ּ��� */
-- ȸ�����̵�, ȸ���̸�, ����, �̵���ȭ��ȣ, �̸����ּ�, ����, ��� ��ȸ
SELECT mem_id, mem_name, mem_bir, mem_hp, mem_mail, mem_job, mem_like
FROM MEMBER;

-- ��ǰ �̸�, ��ǰ ���԰�, �Һ��ڰ�, �ǸŰ� ��ȸ
SELECT prod_name, prod_cost, prod_price, prod_sale
FROM PROD;

-- ȸ�����ϸ������� ��ȸ�Ϸ��� �Ѵ�. ���ϸ��� ���� 12�� ���� ���� ��ȸ�϶�
SELECT mem_mileage / 12
FROM member;

-- ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ��� ��ȸ�Ϸ� �Ѵ�. �Ǹűݾ� = �ǸŴܰ�*55
SELECT PROD_ID, PROD_NAME, PROD_SALE * 55
FROM PROD;
-- ������ �״�� COL�̸����� ���´� -> ��Ī(ALIAS)�� �������
-- ������Ⱑ �ִٸ� �ֵ���ǥ("")/�����(_)�� �̿��ؼ� �����ָ� �ȴ�
-- pandas >>as<< pdó�� as ���̸� �ȴ�
SELECT PROD_ID, PROD_NAME, (PROD_SALE * 55) AS PROD_SALE, (PROD_SALE * 55) AS "PROD SS", (PROD_SALE * 55) "�Ǹűݾ�2", (PROD_SALE * 55) SS3, (PROD_SALE * 55) �Ǹ�_�ݾ�4
FROM PROD;

-- �����ϱ�
    -- �������� : ASC
    -- �������� : DESC
-- select ���� �������� �ۼ�(����Ŭ�� �ؼ��� �� ���� �������� �ؼ���)
-- ���1, COL���� �̿��� ���
SELECT mem_name, mem_like
FROM member
ORDER BY mem_name ASC;

-- ���2, COL INDEX�� �̿��� ���
SELECT mem_name, mem_like
FROM member
ORDER BY 1 ASC;

SELECT mem_name AS name, mem_like
FROM member
ORDER BY name DESC;

-- ��ǰ�з��ڵ�� �ŷ�ó�ڵ带 ��ȸ���ּ���. ��ǰ�з��ڵ带 �������� ��������, �ŷ�ó�ڵ带 �������� ����
SELECT prod_lgu, prod_buyer
FROM PROD
ORDER BY prod_lgu ASC, prod_buyer DESC;

-- ��ǰ�з��ڵ�� �ŷ�ó�ڵ带 ��ȸ���ּ���. ��ǰ�з��ڵ带 �������� ��������, �ŷ�ó�ڵ带 �������� ���� �� �ߺ�����(DISTINCT)�ϱ�
-- ������� �ߺ�����
SELECT DISTINCT prod_lgu, prod_buyer
FROM PROD
ORDER BY prod_lgu ASC, prod_buyer DESC;

-- ��ǰ�� �ǸŰ����� 17���� �̻�(���� : WHERE)�� ��� �����͸� ��ȸ
-- ��ǰ �ǸŰ����� ���� ���� ������ ����
SELECT prod_sale
FROM prod
WHERE prod_sale >= 170000
ORDER BY 1 DESC;