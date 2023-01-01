from django.http import HttpResponseNotFound, HttpResponseRedirect, Http404
from django.shortcuts import render
from django.urls import reverse

monthly_challenges = {
    'january': 'The challenge for january',
    'february': 'The challenge for february',
    'march': 'The challenge for march',
    'april': 'The challenge for april',
    'may': 'The challenge for may',
    'june': 'The challenge for june',
    'july': 'The challenge for july',
    'august': 'The challenge for august',
    'september': 'The challenge for september',
    'october': 'The challenge for october',
    'november': 'The challenge for november',
    'december': None,
}


def index(request):
    months = monthly_challenges.keys()

    return render(request, 'challenges/index.html', {
        'months': months
    })


def monthly_challenge_by_number(request, month):
    if month not in range(1, 13):
        return HttpResponseNotFound('<h1>This month is not supported</h1>')

    redirect_month = list(monthly_challenges.keys())[month - 1]
    redirect_url = reverse('month-challenge', args=[redirect_month])

    return HttpResponseRedirect(redirect_url)


def monthly_challenge(request, month):
    if month not in monthly_challenges:
        raise Http404()

    challenge_text = monthly_challenges[month]

    return render(request, 'challenges/challenge.html', {
        'month': month,
        'challenge_text': challenge_text,
    })
