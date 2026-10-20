from django.db import models
from django.contrib.postgres.fields import ArrayField
from users.models import User

class EditProtectionLevel(models.TextChoices):
    OPEN = 'open',
    SEMI = 'semi',
    FULL = 'full',

class Article(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=255)
    summary = models.TextField()
    banner_image_url = models.URLField(max_length=10000, blank=True, null=True)
    category = ArrayField(models.CharField(max_length=100), blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    view_count = models.BigIntegerField(default=0)
    edit_protection_level = models.CharField(max_length=50, choices=EditProtectionLevel.choices, default=EditProtectionLevel.OPEN)
    infobox_data = models.JSONField(default=dict, blank=True)
    is_featured = models.BooleanField(default=False)
    is_in_the_news = models.BooleanField(default=False)

class ArticleSection(models.Model):
    id = models.AutoField(primary_key=True)
    heading = models.TextField()
    level = models.IntegerField()
    content_delta = models.JSONField()
    article = models.ForeignKey(Article, related_name='sections', on_delete=models.CASCADE)

class ArticleEdit(models.Model):
    id = models.AutoField(primary_key=True)
    article = models.ForeignKey(Article, related_name='edits', on_delete=models.CASCADE)
    editor = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    editor_ip_address = models.GenericIPAddressField(null=True, blank=True)
    edit_summary = models.TextField(blank=True, null=True)
    edited_at = models.DateTimeField(auto_now_add=True)