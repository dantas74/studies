from django.urls import path

from . import views

urlpatterns = [
    path('', views.HomeView.as_view(), name='starting-page'),
    path('posts/', views.PostList.as_view(), name='all-posts'),
    path('posts/<slug:slug>/', views.PostDetail.as_view(), name='post-detail'),
    path('read-later/', views.ReadLaterView.as_view(), name='read-later'),
]
