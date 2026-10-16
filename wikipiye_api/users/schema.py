from datetime import datetime

from ninja import Field
from pydantic import EmailStr

from wikipiye_api.schemas import CamelSchema


class UserOut(CamelSchema):
    """Cocok dengan model `User` di Flutter (lib/models/user/user.dart)."""

    id: str
    name: str
    email: str
    role: str
    created_at: datetime

    @staticmethod
    def resolve_id(obj):
        return str(obj.pk)

    @staticmethod
    def resolve_name(obj):
        return obj.get_full_name() or obj.username

    @staticmethod
    def resolve_role(obj):
        return obj.user_role.lower()

    @staticmethod
    def resolve_created_at(obj):
        return obj.date_joined


class UserUpdateIn(CamelSchema):
    name: str | None = Field(None, min_length=1, max_length=150)
    email: EmailStr | None = None


class UserPublicOut(CamelSchema):
    """Profil publik: sengaja tanpa email dan username."""

    id: str
    name: str
    role: str
    created_at: datetime
    edit_count: int

    @staticmethod
    def resolve_id(obj):
        return str(obj.pk)

    @staticmethod
    def resolve_name(obj):
        return obj.get_full_name() or obj.username

    @staticmethod
    def resolve_role(obj):
        return obj.user_role.lower()

    @staticmethod
    def resolve_created_at(obj):
        return obj.date_joined
