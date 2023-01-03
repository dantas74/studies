from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models
from django.urls import reverse


class Country(models.Model):
    class Meta:
        verbose_name = 'Country'
        verbose_name_plural = 'Countries'

    name = models.CharField(max_length=72)
    code = models.CharField(max_length=2)

    def __str__(self):
        return f'{self.code} - {self.name}'


class Address(models.Model):
    class Meta:
        verbose_name = 'Address'
        verbose_name_plural = 'Address Entries'

    street = models.CharField(max_length=60)
    postal_code = models.CharField(max_length=5)
    city = models.CharField(max_length=48)

    def __str__(self):
        return f'{self.city}, {self.postal_code}, {self.street}'


class Author(models.Model):
    class Meta:
        verbose_name = 'Author'
        verbose_name_plural = 'Authors'

    fist_name = models.CharField(max_length=36, null=False)
    last_name = models.CharField(max_length=62)
    address = models.OneToOneField(Address, on_delete=models.CASCADE, null=True)

    def get_full_name(self):
        return f'{self.fist_name} {self.last_name}'

    def __str__(self):
        return self.get_full_name()


class Book(models.Model):
    class Meta:
        verbose_name = 'Book'
        verbose_name_plural = 'Books'

    title = models.CharField(max_length=36)
    rating = models.IntegerField(validators=[MinValueValidator(1), MaxValueValidator(5)])
    author = models.ForeignKey(Author, on_delete=models.CASCADE, null=True, related_name='books')
    is_bestseller = models.BooleanField(default=False)
    slug = models.SlugField(default='', null=False, db_index=True, unique=True, blank=True)
    published_countries = models.ManyToManyField(Country, related_name='books')

    def get_absolute_url(self):
        return reverse('book-detail', args=[self.slug])

    def __str__(self):
        return f'{self.title} ({self.rating})'
