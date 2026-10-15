from typing import List, Optional, Any
from ninja import ModelSchema, Schema
from .models import Article, ArticleSection, EditProtectionLevel

class ArticleSectionOut(ModelSchema):
    class Meta:
        model = ArticleSection
        fields = ["id", "heading", "level", "content_delta"]

class ArticleOut(ModelSchema):
    sections: List[ArticleSectionOut]

    class Meta:
        model = Article
        fields = [
            "id",
            "title",
            "summary",
            "banner_image_url",
            "category",
            "view_count",
            "edit_protection_level",
            "infobox_data",
            "created_at",
            "updated_at",
        ]

class ArticleIn(Schema):
    title: str
    summary: str
    banner_image_url: Optional[str] = None
    category: Optional[List[str]] = None
    infobox_data: Optional[dict] = None
    sections: Optional[List[ArticleSectionIn]] = None

class ArticleSectionIn(Schema):
    heading: str
    level: int = 1
    content_delta: dict

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