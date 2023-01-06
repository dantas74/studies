from django.urls import path

from . import views

urlpatterns = [
    path('', views.CreateProfileView.as_view(), name='profiles-index'),
    path('list/', views.ProfilesView.as_view(), name='profiles-list')
]
