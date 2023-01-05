from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models


class Review(models.Model):
    class Meta:
        verbose_name = 'Review'
        verbose_name_plural = 'Reviews'

    username = models.CharField(max_length=96)
    review_text = models.TextField()
    rating = models.IntegerField(validators=[MinValueValidator(1), MaxValueValidator(5)])

    def __str__(self):
        return f'{self.id} - {self.username}'
