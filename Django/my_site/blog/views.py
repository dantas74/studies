from django.shortcuts import render, redirect
from django.views import View
from django.views.generic import ListView

from .forms import CommentForm
from .models import Post


class HomeView(ListView):
    template_name = 'blog/index.html'
    model = Post
    context_object_name = 'posts'
    ordering = ['-date']

    def get_queryset(self):
        queryset = super().get_queryset()
        data = queryset[:3]
        return data


class PostList(ListView):
    template_name = 'blog/all-posts.html'
    model = Post
    context_object_name = 'posts'
    ordering = ['-date']


class PostDetail(View):
    @staticmethod
    def render_post_detail(request, post, comment_form):
        stored_posts = request.session.get('stored_posts')
        if stored_posts is not None:
            is_saved_for_later = post.id in stored_posts
        else:
            is_saved_for_later = False

        return render(request, 'blog/post-detail.html', {
            'post': post,
            'tags': post.tags.all(),
            'comments': post.comments.all().order_by('-id'),
            'comment_form': comment_form,
            'is_saved_for_later': is_saved_for_later
        })

    def get(self, request, slug):
        post = Post.objects.get(slug=slug)
        comment_form = CommentForm()

        return self.render_post_detail(request, post, comment_form)

    def post(self, request, slug):
        post = Post.objects.get(slug=slug)
        comment_form = CommentForm(request.POST)

        if comment_form.is_valid():
            comment = comment_form.save(commit=False)
            comment.post = post
            comment.save()
            return redirect('post-detail', slug=slug)

        return self.render_post_detail(request, post, comment_form)


class ReadLaterView(View):
    def get(self, request):
        stored_posts = request.session.get('stored_posts')

        context = {}

        if stored_posts is None or len(stored_posts) == 0:
            context['posts'] = []
            context['has_posts'] = False
        else:
            posts = Post.objects.filter(id__in=stored_posts)
            context['posts'] = posts
            context['has_posts'] = True

        return render(request, 'blog/stored-posts.html', context)

    def post(self, request):
        stored_posts = request.session.get('stored_posts')

        if stored_posts is None:
            stored_posts = []

        post_id = int(request.POST['post_id'])

        if post_id not in stored_posts:
            stored_posts.append(post_id)
        else:
            stored_posts.remove(post_id)

        request.session['stored_posts'] = stored_posts

        return redirect('/')
