from ninja import Router
from ninja_jwt.authentication import JWTAuth

from . import services
from .schema import ActivityHistoryOut

router = Router()


@router.get("", response=list[ActivityHistoryOut], auth=JWTAuth(), by_alias=True)
def my_activity(request):
    """
    Riwayat suntingan artikel dan aktivitas lainnya yang dilakukan oleh pengguna yang sedang masuk.
    """
    return services.get_user_activity(request.auth)
