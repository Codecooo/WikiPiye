from django.db import models
from users.models import User


class ActivityHistory(models.Model):
    """
    Model to store the history of activities performed by users.
    """
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    activity_type = models.CharField(max_length=255)
    article = models.ForeignKey("articles.Article", on_delete=models.CASCADE, null=True, blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.activity_type} at {self.timestamp}"


class ActivityType(models.Choices):
    """
    Enum for different types of activities.
    """
    ARTICLE_EDIT = "ARTICLE_EDIT"
    ARTICLE_VIEW = "ARTICLE_VIEW"
    ARTICLE_CREATE = "ARTICLE_CREATE"