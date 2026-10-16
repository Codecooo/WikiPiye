from django.test import TestCase
from ninja_jwt.tokens import RefreshToken

from articles.models import Article
from users.models import User

from .models import ReadingList


def bearer(user):
    return {"HTTP_AUTHORIZATION": f"Bearer {RefreshToken.for_user(user).access_token}"}


class ReadingListEndpointsTest(TestCase):
    def setUp(self):
        self.budi = User.objects.create_user("budi", "budi@x.com", "pw12345!")
        self.sari = User.objects.create_user("sari", "sari@x.com", "pw12345!")
        self.bromo = Article.objects.create(title="Bromo", summary="Gunung")
        self.semeru = Article.objects.create(title="Semeru", summary="Gunung")

    def post(self, url, body=None, user=None):
        extra = bearer(user) if user else {}
        return self.client.post(
            url, body or {}, content_type="application/json", **extra
        )

    def patch(self, url, body, user=None):
        extra = bearer(user) if user else {}
        return self.client.patch(url, body, content_type="application/json", **extra)

    def make_list(self, user, title="Favorit"):
        return ReadingList.objects.create(user=user, title=title)

    # --- auth ---
    def test_all_endpoints_require_auth(self):
        rl = self.make_list(self.budi)
        base = "/api/reading-lists"
        self.assertEqual(self.client.get(f"{base}/").status_code, 401)
        self.assertEqual(self.post(f"{base}/", {"title": "x"}).status_code, 401)
        self.assertEqual(self.client.get(f"{base}/{rl.pk}").status_code, 401)
        self.assertEqual(self.patch(f"{base}/{rl.pk}", {"title": "x"}).status_code, 401)
        self.assertEqual(self.client.delete(f"{base}/{rl.pk}").status_code, 401)
        self.assertEqual(
            self.post(f"{base}/{rl.pk}/articles/{self.bromo.pk}").status_code, 401
        )

    # --- create / read ---
    def test_create_matches_flutter_model(self):
        r = self.post(
            "/api/reading-lists/", {"title": "Gunung", "description": "Daftar"}, self.budi
        )
        self.assertEqual(r.status_code, 201)
        data = r.json()
        self.assertEqual(
            set(data),
            {"id", "title", "description", "articleIds", "createdAt", "updatedAt"},
        )
        self.assertEqual(data["articleIds"], [])
        self.assertIsInstance(data["id"], str)

    def test_create_rejects_empty_title(self):
        r = self.post("/api/reading-lists/", {"title": ""}, self.budi)
        self.assertEqual(r.status_code, 422)

    def test_list_only_returns_own(self):
        self.make_list(self.budi, "Milik Budi")
        self.make_list(self.sari, "Milik Sari")
        r = self.client.get("/api/reading-lists/", **bearer(self.budi))
        self.assertEqual([x["title"] for x in r.json()], ["Milik Budi"])

    # --- IDOR ---
    def test_cannot_access_other_users_list(self):
        rl = self.make_list(self.sari)
        base = f"/api/reading-lists/{rl.pk}"
        self.assertEqual(self.client.get(base, **bearer(self.budi)).status_code, 404)
        self.assertEqual(self.patch(base, {"title": "x"}, self.budi).status_code, 404)
        self.assertEqual(self.client.delete(base, **bearer(self.budi)).status_code, 404)
        self.assertEqual(
            self.post(f"{base}/articles/{self.bromo.pk}", user=self.budi).status_code,
            404,
        )
        self.assertTrue(ReadingList.objects.filter(pk=rl.pk).exists())

    # --- update / delete ---
    def test_update_partial_and_clear_description(self):
        rl = ReadingList.objects.create(user=self.budi, title="Lama", description="d")
        r = self.patch(f"/api/reading-lists/{rl.pk}", {"title": "Baru"}, self.budi)
        self.assertEqual(r.status_code, 200)
        self.assertEqual(r.json()["title"], "Baru")
        self.assertEqual(r.json()["description"], "d")
        r = self.patch(f"/api/reading-lists/{rl.pk}", {"description": None}, self.budi)
        self.assertIsNone(r.json()["description"])
        self.assertEqual(r.json()["title"], "Baru")

    def test_delete_keeps_articles(self):
        rl = self.make_list(self.budi)
        r = self.client.delete(f"/api/reading-lists/{rl.pk}", **bearer(self.budi))
        self.assertEqual(r.status_code, 204)
        self.assertFalse(ReadingList.objects.filter(pk=rl.pk).exists())
        self.assertTrue(Article.objects.filter(pk=self.bromo.pk).exists())

    # --- articles in list ---
    def test_add_article_is_idempotent_and_ordered(self):
        rl = self.make_list(self.budi)
        base = f"/api/reading-lists/{rl.pk}/articles"
        self.post(f"{base}/{self.semeru.pk}", user=self.budi)
        self.post(f"{base}/{self.bromo.pk}", user=self.budi)
        r = self.post(f"{base}/{self.bromo.pk}", user=self.budi)
        self.assertEqual(r.status_code, 200)
        self.assertEqual(
            r.json()["articleIds"], [str(self.semeru.pk), str(self.bromo.pk)]
        )

    def test_add_unknown_article_404(self):
        rl = self.make_list(self.budi)
        r = self.post(f"/api/reading-lists/{rl.pk}/articles/99999", user=self.budi)
        self.assertEqual(r.status_code, 404)

    def test_remove_article(self):
        rl = self.make_list(self.budi)
        base = f"/api/reading-lists/{rl.pk}/articles"
        self.post(f"{base}/{self.bromo.pk}", user=self.budi)
        r = self.client.delete(f"{base}/{self.bromo.pk}", **bearer(self.budi))
        self.assertEqual(r.status_code, 200)
        self.assertEqual(r.json()["articleIds"], [])

    def test_list_endpoint_has_no_n_plus_one(self):
        for i in range(5):
            rl = self.make_list(self.budi, f"L{i}")
            self.post(f"/api/reading-lists/{rl.pk}/articles/{self.bromo.pk}", user=self.budi)
        headers = bearer(self.budi)
        with self.assertNumQueries(3):  # user, lists, items (prefetch)
            self.client.get("/api/reading-lists/", **headers)
