from ninja import Router
from ninja_jwt.authentication import JWTAuth

from wikipiye_api.schemas import ErrorOut

from . import services
from .schema import UserOut, UserPublicOut, UserUpdateIn

router = Router()


@router.get("/me", response=UserOut, auth=JWTAuth(), by_alias=True)
def get_me(request):
    """
    Profil user yang sedang login (format sesuai model User Flutter).
    """
    return request.auth


@router.patch(
    "/me", response={200: UserOut, 400: ErrorOut}, auth=JWTAuth(), by_alias=True
)
def update_me(request, payload: UserUpdateIn):
    """
    Memperbarui nama dan/atau email user yang sedang login.
    """
    return services.update_profile(request.auth, payload)


@router.get(
    "/{user_id}", response={200: UserPublicOut, 404: ErrorOut}, auth=None, by_alias=True
)
def get_user_profile(request, user_id: int):
    """
    Profil publik user (tanpa email) beserta jumlah suntingannya.
    """
    return services.get_public_profile(user_id)
