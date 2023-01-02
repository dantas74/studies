from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models
from django.urls import reverse


class Book(models.Model):
    title = models.CharField(max_length=36)
    rating = models.IntegerField(validators=[MinValueValidator(1), MaxValueValidator(5)])
    author = models.CharField(max_length=98, null=True)
    is_bestseller = models.BooleanField(default=False)
    slug = models.SlugField(default='', null=False, db_index=True, unique=True, blank=True)

    def get_absolute_url(self):
        return reverse('book-detail', args=[self.slug])

    def __str__(self):
        return f'{self.title} ({self.rating})'
