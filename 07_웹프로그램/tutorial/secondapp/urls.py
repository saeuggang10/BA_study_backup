### url관리하는 파일
#   함수를 만들면 request를 보낼 url을 만드는 장소


from django.urls import path
from . import views

urlpatterns = [
    path('mem_list/', views.memViews),
    
    path('html02/', views.html02),
    path('html01/', views.html01),
    
    path('index02/', views.getIndex02),
    path('', views.getIndex),
]