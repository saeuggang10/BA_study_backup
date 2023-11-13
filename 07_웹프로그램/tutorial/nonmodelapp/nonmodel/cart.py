import cx_Oracle
from datetime import datetime

def cart_List():
    dsn = cx_Oracle.makedsn('localhost', 1521, 'xe')
    conn = cx_Oracle.connect('busan','dbdb', dsn)
    cursor = conn.cursor()

    sql = '''
            Select cart_member, cart_no, cart_prod, cart_qty
            From cart
            Order By cart_no Desc'''
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
            dic.update({cols[i].lower():val[i]})
        list_dict.append(dic)
            
    return list_dict