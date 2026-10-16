from articles.models import ArticleEdit


def get_user_activity(user):
    # Hanya suntingan milik user itu sendiri; terbaru lebih dulu
    return (
        ArticleEdit.objects.filter(editor=user)
        .select_related("article")
        .order_by("-edited_at", "-id")
    )
