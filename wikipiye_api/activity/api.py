from ninja import Router
from ninja.pagination import LimitOffsetPagination, paginate
from ninja_jwt.authentication import JWTAuth

from . import services
from .schema import ActivityOut

router = Router()


@router.get("", response=list[ActivityOut], auth=JWTAuth(), by_alias=True)
@paginate(LimitOffsetPagination)
def my_activity(request):
    """
    Riwayat suntingan artikel milik user yang sedang login.
    Mendukung query `limit` dan `offset`.
    """
    return services.get_user_activity(request.auth)
