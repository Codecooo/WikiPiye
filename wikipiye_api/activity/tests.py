from django.test import TestCase
from ninja_jwt.tokens import RefreshToken

from articles.models import Article, ArticleEdit
from users.models import User


def bearer(user):
    return {"HTTP_AUTHORIZATION": f"Bearer {RefreshToken.for_user(user).access_token}"}


class ActivityEndpointTest(TestCase):
    def setUp(self):
        self.budi = User.objects.create_user("budi", "budi@x.com", "pw12345!")
        self.sari = User.objects.create_user("sari", "sari@x.com", "pw12345!")
        self.bromo = Article.objects.create(title="Bromo", summary="Gunung")

    def edit(self, user, summary="fix", ip=None):
        return ArticleEdit.objects.create(
            article=self.bromo, editor=user, edit_summary=summary, editor_ip_address=ip
        )

    def get(self, user=None, query=""):
        extra = bearer(user) if user else {}
        return self.client.get(f"/api/activity/{query}", **extra)

    def test_requires_auth(self):
        self.assertEqual(self.get().status_code, 401)

    def test_returns_only_own_edits_newest_first(self):
        first = self.edit(self.budi, "pertama")
        self.edit(self.sari, "milik sari")
        second = self.edit(self.budi, "kedua")
        r = self.get(self.budi)
        self.assertEqual(r.status_code, 200)
        body = r.json()
        self.assertEqual(body["count"], 2)
        self.assertEqual(
            [i["id"] for i in body["items"]], [str(second.pk), str(first.pk)]
        )

    def test_item_shape_and_no_ip_leak(self):
        self.edit(self.budi, ip="10.0.0.1")
        item = self.get(self.budi).json()["items"][0]
        self.assertEqual(
            set(item),
            {"id", "articleId", "articleTitle", "editSummary", "editedAt"},
        )
        self.assertEqual(item["articleTitle"], "Bromo")
        self.assertEqual(item["articleId"], str(self.bromo.pk))

    def test_null_summary_becomes_empty_string(self):
        ArticleEdit.objects.create(article=self.bromo, editor=self.budi)
        self.assertEqual(self.get(self.budi).json()["items"][0]["editSummary"], "")

    def test_pagination(self):
        for i in range(5):
            self.edit(self.budi, f"e{i}")
        body = self.get(self.budi, "?limit=2&offset=2").json()
        self.assertEqual(body["count"], 5)
        self.assertEqual(len(body["items"]), 2)

    def test_no_n_plus_one(self):
        for i in range(5):
            self.edit(self.budi, f"e{i}")
        headers = bearer(self.budi)
        with self.assertNumQueries(3):  # user, count, items+article (join)
            self.client.get("/api/activity/", **headers)
