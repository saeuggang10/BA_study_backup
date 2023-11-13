from django.shortcuts import render # html파일 따로 만들어 사용할 때 사용
from django.http import HttpResponse # 바로 html값으로 응답할 때 사용

def index(request):
    return render(request,
                  'mainapp/index.html',
                  {})