from django.shortcuts import redirect
from django.views import View
from django.views.generic import ListView, DetailView
from django.views.generic.base import TemplateView
from django.views.generic.edit import CreateView

from .forms import ReviewForm
from .models import Review


# Is used when you want to create a form with get and post

# class ReviewView(FormView):
#     form_class = ReviewForm
#     template_name = 'reviews/review.html'
#     success_url = 'thank-you'
#
#     def form_valid(self, form):
#         form.save()
#         return super().form_valid(form)

# Is used when you want to create a form that is used to create a model

class ReviewView(CreateView):
    model = Review
    form_class = ReviewForm
    template_name = 'reviews/review.html'
    success_url = 'thank-you'


# Is used to render a template

class ThankYouView(TemplateView):
    template_name = 'reviews/thank-you.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['message'] = 'This works'
        return context


# Is used when you want to list models to a template
class ReviewListView(ListView):
    template_name = 'reviews/review-list.html'
    model = Review
    context_object_name = 'reviews'


# Is used when you want to get the details about one model finding by its pk or slug
class ReviewDetailView(DetailView):
    template_name = 'reviews/review-detail.html'
    model = Review

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        favorite_id = self.request.session.get('favorite_review')
        context['is_favorite'] = favorite_id == str(self.object.id)
        return context


class FavoriteView(View):
    def post(self, request):
        review_id = request.POST['review_id']
        request.session['favorite_review'] = review_id
        return redirect('review-detail', pk=review_id)
