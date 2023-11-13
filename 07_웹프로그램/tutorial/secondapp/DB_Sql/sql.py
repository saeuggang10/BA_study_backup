def getMem_List():
    import cx_Oracle
    
    dsn = cx_Oracle.makedsn('localhost', 1521, 'xe')
    conn = cx_Oracle.connect('busan','dbdb', dsn)
    cursor = conn.cursor()

    sql = '''Select mem_id, mem_name, to_char(sysdate,'yyyy')-to_char(mem_bir,'yyyy') as mem_age, to_char(mem_bir,'yyyy-mm-dd') as mem_bir
        From member'''
    cursor.execute(sql)

    rows = cursor.fetchall() # 관측값
    colnames = cursor.description # 변수정보
    cols = [colnames[i][0] for i in range(len(colnames))] # 변수명

    cursor.close()
    conn.close()
    
    lis=[]
    for val in rows:
        dic={}
        for i in range(len(val)):
            dic.update({cols[i].lower():val[i]})
        lis.append(dic)
        
    return lis