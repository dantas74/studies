from django.shortcuts import render

from . import data


def get_date(post):
    return post['date']


def index(request):
    sorted_posts = sorted(data.posts, key=get_date)
    latest_posts = sorted_posts[-3:]

    return render(request, 'blog/index.html', {
        'posts': latest_posts
    })


def posts(request):
    return render(request, 'blog/all-posts.html', {
        'posts': data.posts
    })


def post_detail(request, slug):
    post = next(post for post in data.posts if post['slug'] == slug)

    return render(request, 'blog/post-detail.html', {
        'post': post
    })
