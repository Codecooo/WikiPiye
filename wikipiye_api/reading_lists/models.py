from django.conf import settings
from django.db import models

from articles.models import Article


class ReadingList(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        related_name="reading_lists",
        on_delete=models.CASCADE,
    )
    title = models.CharField(max_length=150)
    description = models.TextField(blank=True, null=True)
    articles = models.ManyToManyField(
        Article, through="ReadingListItem", related_name="reading_lists"
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ["-updated_at", "-id"]


class ReadingListItem(models.Model):
    reading_list = models.ForeignKey(
        ReadingList, related_name="items", on_delete=models.CASCADE
    )
    article = models.ForeignKey(Article, on_delete=models.CASCADE)
    added_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["added_at", "id"]
        constraints = [
            models.UniqueConstraint(
                fields=["reading_list", "article"],
                name="unique_article_per_reading_list",
            )
        ]
