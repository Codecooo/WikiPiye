from articles.models import Article

DEFAULT_LIMIT = 5
MAX_LIMIT = 20

_CARD_FIELDS = ("id", "title", "summary", "banner_image_url", "category", "view_count")


def get_for_you_feed(limit: int = DEFAULT_LIMIT) -> dict:
    """
    Feed non-personalisasi: artikel pilihan, berita, lalu populer.
    Satu artikel hanya muncul di satu kelompok (tidak ada kartu ganda).
    """
    base = Article.objects.only(*_CARD_FIELDS)

    featured = list(
        base.filter(is_featured=True).order_by("-updated_at", "-id")[:limit]
    )
    used_ids = [article.pk for article in featured]

    in_the_news = list(
        base.filter(is_in_the_news=True)
        .exclude(pk__in=used_ids)
        .order_by("-updated_at", "-id")[:limit]
    )
    used_ids += [article.pk for article in in_the_news]

    popular = list(
        base.exclude(pk__in=used_ids).order_by("-view_count", "-id")[:limit]
    )

    return {"featured": featured, "in_the_news": in_the_news, "popular": popular}
