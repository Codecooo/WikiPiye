from django.db import IntegrityError, transaction
from django.db.models import Count
from django.shortcuts import get_object_or_404
from ninja.errors import HttpError

from .models import User


def update_profile(user: User, payload) -> User:
    # user_role sengaja tidak bisa diubah lewat endpoint ini (cegah privilege escalation)
    data = payload.dict(exclude_unset=True)
    fields = []

    name = data.get("name")
    if name is not None:
        first_name, _, last_name = name.strip().partition(" ")
        user.first_name = first_name
        user.last_name = last_name.strip()
        fields += ["first_name", "last_name"]

    email = data.get("email")
    if email is not None:
        if User.objects.filter(email__iexact=email).exclude(pk=user.pk).exists():
            raise HttpError(400, "Email sudah digunakan.")
        user.email = email
        fields.append("email")

    if fields:
        try:
            with transaction.atomic():
                user.save(update_fields=fields)
        except IntegrityError:
            raise HttpError(400, "Email sudah digunakan.")

    return user


def get_public_profile(user_id: int) -> User:
    return get_object_or_404(
        User.objects.annotate(edit_count=Count("articleedit")),
        pk=user_id,
    )