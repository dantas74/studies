from django.contrib import admin

from .models import Author, Tag, Post


class AuthorAdmin(admin.ModelAdmin):
    pass


class TagAdmin(admin.ModelAdmin):
    pass


class PostAdmin(admin.ModelAdmin):
    list_filter = ('author', 'tags', 'date')
    list_display = ('title', 'author', 'date')
    prepopulated_fields = {
        'slug': ('title',)
    }


admin.site.register(Author, AuthorAdmin)
admin.site.register(Tag, TagAdmin)
admin.site.register(Post, PostAdmin)
