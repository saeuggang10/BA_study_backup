def testData():
    return '홍길동'

def mem_List():
    import cx_Oracle
    from datetime import datetime

    dsn = cx_Oracle.makedsn('localhost', 1521, 'xe')
    conn = cx_Oracle.connect('busan','dbdb', dsn)
    cursor = conn.cursor()

    sql = '''select mem_name, substr(cart_no,1,8) as cart_date, prod_name 
            From cart inner join member
                        on cart_member = mem_id
                        inner join prod
                        on cart_prod = prod_id
            Where prod_name like '%컴퓨터%'
            Order By mem_name Asc'''
    cursor.execute(sql)

    rows = cursor.fetchall() # 관측값
    colnames = cursor.description # 변수정보
    cols = [colnames[i][0] for i in range(len(colnames))] # 변수명

    cursor.close()
    conn.close()

    list_dict = []
    for val in rows:
        dic = {}
        for i in range(len(val)):
            if cols[i] == 'CART_DATE':
                temp = val[i]
                temp2 = '{}-{}-{}'.format(temp[:4], temp[4:6], temp[6:])
                dic.update({cols[i].lower():temp2})
            else:
                dic.update({cols[i].lower():val[i]})
        list_dict.append(dic)
           
    return list_dict