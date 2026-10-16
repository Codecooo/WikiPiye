from django.contrib.auth.models import AbstractUser
from django.db import models
from django.db.models import Q
from django.db.models.functions import Lower


class UserRole(models.TextChoices):
    ADMIN = "ADMIN"
    VIEWER = "VIEWER"
    EDITOR = "EDITOR"
    GUEST = "GUEST"


class User(AbstractUser):
    role = models.CharField(
        max_length=20,
        choices=UserRole.choices,
        default=UserRole.GUEST,
    )

    class Meta(AbstractUser.Meta):
        constraints = [
            models.UniqueConstraint(
                Lower("email"),
                condition=~Q(email=""),
                name="unique_user_email_ci",
            )
        ]