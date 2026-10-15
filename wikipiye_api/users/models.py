from django.db import models
from django.contrib.auth.models import AbstractUser

class UserRole(models.TextChoices):
    ADMIN = 'ADMIN',
    VIEWER = 'VIEWER',
    EDITOR = 'EDITOR',
    GUEST = 'GUEST'

class User(AbstractUser):
    user_role = models.CharField(
        max_length=20,
        choices=UserRole.choices,
        default=UserRole.GUEST,
    )