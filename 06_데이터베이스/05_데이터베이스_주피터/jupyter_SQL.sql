-- ����1.
Select mem_id, mem_name, sum(nvl(cart_qty,0)) as qty_sum
From member left outer join cart
            On mem_id = cart_member
Group by mem_id, mem_name
Order By mem_id Asc;

-- ����2.
Select Distinct mem_id, mem_name, substr(mem_add1,1,2) as mem_add, substr(cart_no,1,8) as cart_date, cart_qty
From member Inner join cart
            On mem_id = cart_member
Order By mem_id Asc;

-- ����3.
Select Distinct mem_id, mem_name
From member
Where mem_id Not in (Select cart_member From cart);

--����4
Select *
From member
Where mem_id like '%';

--����5
Select Distinct substr(mem_add1,1,2) as mem_add, sum(cart_qty) as qty_sum
From member, cart, prod, lprod, buyer
Where mem_id = cart_member
    and cart_prod = prod_id
    and prod_buyer = buyer_id
    and prod_lgu = lprod_gu
    and lprod_nm like '%������ǰ%'
    and buyer_name like '%�������%'
Group By substr(mem_add1,1,2)
Order By mem_add Asc;

--����6
Select decode(Mod(substr(mem_regno2,1,1),2), 1, '����', '����') as mem_sex,
            (case when (extract(year from sysdate) - extract(year from mem_bir))< 10 then '10�� �̸�'
            when (extract(year from sysdate) - extract(year from mem_bir))< 80 then '10��~70��'
            Else '80�� �̻�' End) as mem_age,
            prod_name, sum(nvl(cart_qty,0)) as qty_sum
From member, cart, prod
Where mem_id = cart_member
    and cart_prod = prod_id
Group BY decode(Mod(substr(mem_regno2,1,1),2), 1, '����', '����',
            (case when (extract(year from sysdate) - extract(year from mem_bir))< 10 then '10�� �̸�'
            when (extract(year from sysdate) - extract(year from mem_bir))< 80 then '10��~70��'
            Else '80�� �̻�' End),
            prod_name;