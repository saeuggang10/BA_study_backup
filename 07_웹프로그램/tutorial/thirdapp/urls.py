from django.urls import path
from . import views

urlpatterns = [
    path('index/', views.getIndex), #http://127.0.0.1:8000/third/index/
    path('', views.getIndex2),
    path('table/', views.tableView),
    path('jsinputform/', views.jsinputformView),
    path('login/', views.jsinputformpage),
]