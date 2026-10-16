from django.utils.text import Truncator

from wikipiye_api.schemas import CamelSchema

EXTRACT_MAX_CHARS = 300


class FeedCardOut(CamelSchema):
    """Satu kartu artikel di halaman "For you"."""

    id: str
    title: str
    extract: str
    banner_image_url: str | None = None
    category: list[str]
    view_count: int

    @staticmethod
    def resolve_id(obj):
        return str(obj.pk)

    @staticmethod
    def resolve_extract(obj):
        # Ringkasan dipotong agar payload feed tetap kecil
        return Truncator(obj.summary).chars(EXTRACT_MAX_CHARS)

    @staticmethod
    def resolve_category(obj):
        return obj.category or []


class ForYouOut(CamelSchema):
    featured: list[FeedCardOut]
    in_the_news: list[FeedCardOut]
    popular: list[FeedCardOut]
