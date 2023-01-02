from django.contrib import admin

from . import models


class BookAdmin(admin.ModelAdmin):
    prepopulated_fields = {
        'slug': ('title',)
    }


admin.site.register(models.Book, BookAdmin)
