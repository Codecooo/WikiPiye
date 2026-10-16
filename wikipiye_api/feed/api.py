from ninja import Query, Router

from . import services
from .schema import ForYouOut

router = Router()


@router.get("", response=ForYouOut, by_alias=True)
def for_you(
    request,
    limit: int = Query(services.DEFAULT_LIMIT, ge=1, le=services.MAX_LIMIT),
):
    """
    Feed halaman "For you": artikel pilihan, berita, dan populer.
    Publik (tanpa login), sama seperti membaca artikel.
    `limit` = jumlah maksimal kartu per kelompok (1-20).
    """
    return services.get_for_you_feed(limit)
