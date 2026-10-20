from ninja import Router
from ninja_jwt.authentication import JWTAuth

from wikipiye_api.schemas import ErrorOut

from . import services
from .schema import ReadingListIn, ReadingListOut, ReadingListUpdateIn

router = Router()


@router.get("", response=list[ReadingListOut], auth=JWTAuth(), by_alias=True)
def list_reading_lists(request):
    """
    Semua daftar bacaan milik user yang sedang login.
    """
    return services.list_reading_lists(request.auth)


@router.post("", response={201: ReadingListOut}, auth=JWTAuth(), by_alias=True)
def create_reading_list(request, payload: ReadingListIn):
    """
    Membuat daftar bacaan baru.
    """
    return 201, services.create_reading_list(request.auth, payload)


@router.get(
    "/{list_id}",
    response={200: ReadingListOut, 404: ErrorOut},
    auth=JWTAuth(),
    by_alias=True,
)
def get_reading_list(request, list_id: int):
    """
    Detail satu daftar bacaan (hanya milik sendiri).
    """
    return services.get_reading_list(request.auth, list_id)


@router.patch(
    "/{list_id}",
    response={200: ReadingListOut, 404: ErrorOut},
    auth=JWTAuth(),
    by_alias=True,
)
def update_reading_list(request, list_id: int, payload: ReadingListUpdateIn):
    """
    Mengubah judul dan/atau deskripsi daftar bacaan.
    """
    return services.update_reading_list(request.auth, list_id, payload)


@router.delete("/{list_id}", response={204: None, 404: ErrorOut}, auth=JWTAuth())
def delete_reading_list(request, list_id: int):
    """
    Menghapus daftar bacaan (artikelnya sendiri tidak ikut terhapus).
    """
    services.delete_reading_list(request.auth, list_id)
    return 204, None


@router.post(
    "/{list_id}/articles/{article_id}",
    response={200: ReadingListOut, 404: ErrorOut},
    auth=JWTAuth(),
    by_alias=True,
)
def add_article(request, list_id: int, article_id: int):
    """
    Menambahkan artikel ke daftar bacaan (idempotent).
    """
    return services.add_article(request.auth, list_id, article_id)


@router.delete(
    "/{list_id}/articles/{article_id}",
    response={200: ReadingListOut, 404: ErrorOut},
    auth=JWTAuth(),
    by_alias=True,
)
def remove_article(request, list_id: int, article_id: int):
    """
    Menghapus artikel dari daftar bacaan.
    """
    return services.remove_article(request.auth, list_id, article_id)
