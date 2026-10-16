from datetime import datetime

from wikipiye_api.schemas import CamelSchema


class ActivityOut(CamelSchema):
    """
    Satu entri riwayat suntingan milik user.
    Sengaja tidak menyertakan `editor_ip_address`.
    """

    id: str
    article_id: str
    article_title: str
    edit_summary: str
    edited_at: datetime

    @staticmethod
    def resolve_id(obj):
        return str(obj.pk)

    @staticmethod
    def resolve_article_id(obj):
        return str(obj.article_id)

    @staticmethod
    def resolve_article_title(obj):
        return obj.article.title

    @staticmethod
    def resolve_edit_summary(obj):
        return obj.edit_summary or ""
