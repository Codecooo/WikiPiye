from django.db import transaction
from django.shortcuts import get_object_or_404

from articles.models import Article

from .models import ReadingList, ReadingListItem


def _owned_queryset(user):
    # Selalu difilter berdasarkan user agar tidak terjadi IDOR
    return ReadingList.objects.filter(user=user).prefetch_related("items")


def list_reading_lists(user):
    return _owned_queryset(user)


def get_reading_list(user, list_id: int) -> ReadingList:
    # List milik user lain diperlakukan sama seperti tidak ada (404)
    return get_object_or_404(_owned_queryset(user), pk=list_id)


def create_reading_list(user, payload) -> ReadingList:
    reading_list = ReadingList.objects.create(
        user=user, title=payload.title.strip(), description=payload.description
    )
    return get_reading_list(user, reading_list.pk)


def update_reading_list(user, list_id: int, payload) -> ReadingList:
    reading_list = get_reading_list(user, list_id)
    data = payload.dict(exclude_unset=True)

    if data.get("title") is not None:
        reading_list.title = data["title"].strip()
    if "description" in data:
        reading_list.description = data["description"]

    reading_list.save()
    return get_reading_list(user, list_id)


def delete_reading_list(user, list_id: int) -> None:
    get_reading_list(user, list_id).delete()


@transaction.atomic
def add_article(user, list_id: int, article_id: int) -> ReadingList:
    reading_list = get_reading_list(user, list_id)
    article = get_object_or_404(Article, pk=article_id)

    # Idempotent: menambahkan artikel yang sudah ada tidak menimbulkan error
    _, created = ReadingListItem.objects.get_or_create(
        reading_list=reading_list, article=article
    )
    if created:
        reading_list.save(update_fields=["updated_at"])
    return get_reading_list(user, list_id)


@transaction.atomic
def remove_article(user, list_id: int, article_id: int) -> ReadingList:
    reading_list = get_reading_list(user, list_id)

    deleted, _ = ReadingListItem.objects.filter(
        reading_list=reading_list, article_id=article_id
    ).delete()
    if deleted:
        reading_list.save(update_fields=["updated_at"])
    return get_reading_list(user, list_id)
