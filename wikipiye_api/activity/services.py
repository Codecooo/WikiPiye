from ninja.errors import HttpError

from activity.models import ActivityHistory


def get_user_activity(user):
    # Hanya suntingan milik user itu sendiri; terbaru lebih dulu
    activities = ActivityHistory.objects.filter(user=user).order_by('-timestamp', 'id')
    if not activities.exists():
        raise HttpError(404, "Tidak ada aktivitas yang ditemukan untuk pengguna ini.")
    return activities
