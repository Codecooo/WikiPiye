from typing import List, Optional, Any
from ninja import ModelSchema, Schema
from .models import Article, ArticleSection, EditProtectionLevel

class ArticleSectionOut(ModelSchema):
    class Meta:
        model = ArticleSection
        fields = ["id", "heading", "level", "content_delta"]

class DetailArticleOut(ModelSchema):
    sections: List[ArticleSectionOut]

    class Meta:
        model = Article
        fields = "__all__"


class ArticleOut(ModelSchema):
    class Meta:
        model = Article
        fields =  "__all__"


class ArticleSectionIn(Schema):
    heading: str
    level: int = 1
    content_delta: dict

class ArticleIn(Schema):
    title: str
    summary: str
    banner_image_url: Optional[str] = None
    category: Optional[List[str]] = None
    infobox_data: Optional[dict] = None
    is_featured: Optional[bool] = None
    is_in_the_news: Optional[bool] = None
    sections: Optional[List[ArticleSectionIn]] = None

class ArticleCreateIn(Schema):
    title: str
    summary: str
    banner_image_url: Optional[str] = None
    category: Optional[List[str]] = None
    infobox_data: Optional[dict] = None
    sections: Optional[List[ArticleSectionIn]] = []

class ArticleUpdateIn(Schema):
    edit_title: str
    edit_summary: str
    title: Optional[str] = None
    summary: Optional[str] = None
    banner_image_url: Optional[str] = None
    category: Optional[List[str]] = None
    infobox_data: Optional[dict] = None
    edit_protection_level: Optional[EditProtectionLevel] = None