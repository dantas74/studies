from django.urls import path

from . import views

urlpatterns = [
    path('', views.ReviewView.as_view()),
    path('thank-you/', views.ThankYouView.as_view(), name='thank-you'),
    path('reviews/', views.ReviewListView.as_view(), name='all-reviews'),
    path('reviews/favorite/', views.FavoriteView.as_view(), name='favorite-review'),
    path('reviews/<int:pk>/', views.ReviewDetailView.as_view(), name='review-detail')
]
