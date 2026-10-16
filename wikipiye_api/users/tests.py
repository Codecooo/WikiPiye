from django.test import TestCase
from ninja_jwt.tokens import RefreshToken

from articles.models import Article, ArticleEdit

from .models import User, UserRole


def bearer(user):
    return {"HTTP_AUTHORIZATION": f"Bearer {RefreshToken.for_user(user).access_token}"}


class UserEndpointsTest(TestCase):
    def setUp(self):
        self.budi = User.objects.create_user(
            "budi",
            "budi@x.com",
            "pw12345!",
            first_name="Budi",
            last_name="Santoso",
            user_role=UserRole.EDITOR,
        )
        self.sari = User.objects.create_user("sari", "sari@x.com", "pw12345!")

    def patch(self, body, user=None):
        extra = bearer(user) if user else {}
        return self.client.patch(
            "/api/users/me", body, content_type="application/json", **extra
        )

    def test_me_requires_auth(self):
        self.assertEqual(self.client.get("/api/users/me").status_code, 401)

    def test_me_matches_flutter_user_model(self):
        r = self.client.get("/api/users/me", **bearer(self.budi))
        self.assertEqual(r.status_code, 200)
        data = r.json()
        self.assertEqual(set(data), {"id", "name", "email", "role", "createdAt"})
        self.assertEqual(data["id"], str(self.budi.pk))
        self.assertEqual(data["name"], "Budi Santoso")
        self.assertEqual(data["role"], "editor")

    def test_name_falls_back_to_username(self):
        r = self.client.get("/api/users/me", **bearer(self.sari))
        self.assertEqual(r.json()["name"], "sari")
        self.assertEqual(r.json()["role"], "guest")

    def test_update_name_and_email(self):
        r = self.patch({"name": "Budi Eka Santoso", "email": "baru@x.com"}, self.budi)
        self.assertEqual(r.status_code, 200)
        self.assertEqual(r.json()["name"], "Budi Eka Santoso")
        self.budi.refresh_from_db()
        self.assertEqual(
            (self.budi.first_name, self.budi.last_name), ("Budi", "Eka Santoso")
        )
        self.assertEqual(self.budi.email, "baru@x.com")

    def test_update_requires_auth(self):
        self.assertEqual(self.patch({"name": "X"}).status_code, 401)

    def test_role_cannot_be_changed(self):
        r = self.patch(
            {"name": "Sari", "role": "admin", "userRole": "ADMIN"}, self.sari
        )
        self.assertEqual(r.status_code, 200)
        self.sari.refresh_from_db()
        self.assertEqual(self.sari.user_role, UserRole.GUEST)

    def test_duplicate_email_rejected(self):
        self.assertEqual(
            self.patch({"email": "BUDI@x.com"}, self.sari).status_code, 400
        )

    def test_invalid_email_rejected(self):
        self.assertEqual(
            self.patch({"email": "bukan-email"}, self.sari).status_code, 422
        )

    def test_public_profile_hides_private_data(self):
        article = Article.objects.create(title="Bromo", summary="Gunung")
        ArticleEdit.objects.create(
            article=article, editor=self.budi, edit_summary="fix"
        )
        r = self.client.get(f"/api/users/{self.budi.pk}")
        self.assertEqual(r.status_code, 200)
        data = r.json()
        self.assertEqual(data["editCount"], 1)
        self.assertNotIn("email", data)
        self.assertNotIn("username", data)

    def test_public_profile_not_found(self):
        self.assertEqual(self.client.get("/api/users/99999").status_code, 404)
