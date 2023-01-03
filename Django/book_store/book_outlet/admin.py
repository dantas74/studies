from django.contrib import admin

from .models import Book, Author, Address, Country


class BookAdmin(admin.ModelAdmin):
    list_filter = ('author', 'rating')
    list_display = ('title', 'author')
    prepopulated_fields = {
        'slug': ('title',)
    }


class AuthorAdmin(admin.ModelAdmin):
    pass


class AddressAdmin(admin.ModelAdmin):
    pass


class CountryAdmin(admin.ModelAdmin):
    pass


admin.site.register(Book, BookAdmin)
admin.site.register(Author, AuthorAdmin)
admin.site.register(Address, AddressAdmin)
admin.site.register(Country, CountryAdmin)
