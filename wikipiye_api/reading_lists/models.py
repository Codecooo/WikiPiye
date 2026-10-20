from django.conf import settings
from django.db import models

from articles.models import Article


class ReadingList(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
    )
    articles = models.ForeignKey(
        Article, on_delete=models.CASCADE
    )
    created_at = models.DateTimeField(auto_now_add=True)
