from django.urls import path
from . import views

urlpatterns = [
    # http://127.0.0.1:8000/testapp/test/
    path('', views.index),
    path('index/', views.index),
    path('index.html/', views.index),
]