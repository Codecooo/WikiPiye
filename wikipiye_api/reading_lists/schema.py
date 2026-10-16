from datetime import datetime

from ninja import Field

from wikipiye_api.schemas import CamelSchema


class ReadingListIn(CamelSchema):
    title: str = Field(..., min_length=1, max_length=150, pattern=r".*\S.*")
    description: str | None = None


class ReadingListUpdateIn(CamelSchema):
    title: str | None = Field(None, min_length=1, max_length=150)
    description: str | None = None


class ReadingListOut(CamelSchema):
    """Cocok dengan model `ReadingList` di Flutter (lib/models/reading_list/reading_list.dart)."""

    id: str
    title: str
    description: str | None = None
    article_ids: list[str]
    created_at: datetime
    updated_at: datetime

    @staticmethod
    def resolve_id(obj):
        return str(obj.pk)

    @staticmethod
    def resolve_article_ids(obj):
        # `items` sudah di-prefetch di services; urutan mengikuti added_at
        return [str(item.article_id) for item in obj.items.all()]
