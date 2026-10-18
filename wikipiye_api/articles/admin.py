from django.contrib import admin

from .models import Article, ArticleEdit, ArticleSection

# Register your models here.
admin.site.register(Article)
admin.site.register(ArticleSection)
admin.site.register(ArticleEdit)