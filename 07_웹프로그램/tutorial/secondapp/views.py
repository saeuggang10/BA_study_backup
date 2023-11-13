from django.shortcuts import render
from django.http import HttpResponse

def getIndex2(request):
    return HttpResponse('<b>secondapp의 index2페이지 입니다.</b>')

def getIndex02(request):
    return HttpResponse('getIndex02 :: 페이지 잘 호출됩니다.')

def getIndex(request):
    return render(request,
                  'secondapp/index.html',
                  {})
    
def html01(request):
    return render(request,
                  'secondapp/html/html01.html',
                  {})

def html02(request):
    return render(request,
                  'secondapp/html/html02.html',
                  {})

from .DB_Sql import sql
def memViews(request):
    return render(request,
                  'secondapp/html/mem_list.html',
                  {'mem_lis':sql.getMem_List})