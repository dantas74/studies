from django.db.models import Avg
from django.shortcuts import render, get_object_or_404

from .models import Book


def index(request):
    books = Book.objects.all().order_by('-rating')
    total_number_of_books = books.count()
    average_book_rating = books.aggregate(Avg('rating'))

    return render(request, 'book_outlet/index.html', {
        'books': books,
        'total_number_of_books': total_number_of_books,
        'average_book_rating': average_book_rating,
    })


def book_detail(request, slug):
    book = get_object_or_404(Book, slug=slug)

    return render(request, 'book_outlet/book-detail.html', {
        'book': book,
    })
