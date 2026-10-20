from ninja import Router
from ninja_jwt.authentication import JWTAuth
from django.shortcuts import get_object_or_404
from reading_lists.models import ReadingList
from wikipiye_api.schemas import ErrorOut

from .schema import ReadingListIn, ReadingListOut

router = Router()


@router.get("", response=list[ReadingListOut], auth=JWTAuth(), by_alias=True)
def list_reading_lists(request):
    """
    Semua daftar bacaan milik user yang sedang login.
    """
    return get_object_or_404(ReadingList.objects.filter(user=request.auth), "Tidak ada daftar bacaan.")


@router.post("", response={201: ReadingListOut}, auth=JWTAuth(), by_alias=True)
def create_reading_list(request, payload: ReadingListIn):
    """
    Membuat daftar bacaan baru.
    """
    return ReadingList.objects.create(user=request.auth, **payload.dict())


@router.delete("/{list_id}", response={204: None, 404: ErrorOut}, auth=JWTAuth())
def delete_reading_list(request, list_id: int):
    """
    Menghapus daftar bacaan (artikelnya sendiri tidak ikut terhapus).
    """
    reading_list = get_object_or_404(ReadingList.objects.filter(user=request.auth), id=list_id)
    reading_list.delete()
    return 204, None
