# class Hello :
#     def __init__(self, a, b):
#         self.a = 10
#         self.b = 20
        
#     def getPlus(self):
#         return self.a+self.b
# 위 내용을 module/util.py에 분리함

from module.util import Hello

def viewPrint():
    h = Hello(20,30)
    print(h.getPlus())

### 프로그램 최초 시작 위치
# 클래스 또는 함수 형태로 프로그램을 구성하는 경우 -> 프로그램 시작점이 필요함. '__main__'은 프로그램의 시작을 의미
# 서버 구동시 최초 실행됨
if __name__ == '__main__':
    viewPrint()