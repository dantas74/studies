from django.db import models


class Profile(models.Model):
    class Meta:
        verbose_name = 'Profile'
        verbose_name_plural = 'Profiles'

    image = models.ImageField(upload_to='images')

    def __str__(self):
        return self.image.name
