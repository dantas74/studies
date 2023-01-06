from django.shortcuts import reverse
from django.views.generic import ListView
from django.views.generic.edit import CreateView

from .models import Profile


class CreateProfileView(CreateView):
    template_name = 'profiles/create-profile.html'
    model = Profile
    fields = '__all__'

    def get_success_url(self):
        return reverse('profiles-index')


class ProfilesView(ListView):
    template_name = 'profiles/user-profile.html'
    model = Profile
    context_object_name = 'profiles'
