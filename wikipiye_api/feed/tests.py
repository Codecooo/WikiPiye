from django.test import TestCase

from articles.models import Article


def make(title, **kw):
    return Article.objects.create(title=title, summary=kw.pop("summary", "ringkasan"), **kw)


class ForYouFeedTest(TestCase):
    def get(self, query=""):
        return self.client.get(f"/api/for-you/{query}")

    def test_public_and_shape(self):
        make("Bromo", is_featured=True, category=["Gunung"], banner_image_url="http://x/y.jpg")
        r = self.get()
        self.assertEqual(r.status_code, 200)
        body = r.json()
        self.assertEqual(set(body), {"featured", "inTheNews", "popular"})
        card = body["featured"][0]
        self.assertEqual(
            set(card),
            {"id", "title", "extract", "bannerImageUrl", "category", "viewCount"},
        )
        self.assertIsInstance(card["id"], str)

    def test_groups_and_no_duplicates(self):
        feat = make("Featured", is_featured=True, view_count=999)
        news = make("News", is_in_the_news=True, view_count=500)
        both = make("Both", is_featured=True, is_in_the_news=True)
        pop = make("Popular", view_count=100)
        body = self.get().json()
        ids = lambda k: [c["id"] for c in body[k]]
        self.assertCountEqual(ids("featured"), [str(feat.pk), str(both.pk)])
        self.assertEqual(ids("inTheNews"), [str(news.pk)])
        self.assertEqual(ids("popular"), [str(pop.pk)])

    def test_popular_sorted_by_view_count(self):
        a = make("A", view_count=1)
        b = make("B", view_count=50)
        c = make("C", view_count=10)
        ids = [x["id"] for x in self.get().json()["popular"]]
        self.assertEqual(ids, [str(b.pk), str(c.pk), str(a.pk)])

    def test_limit(self):
        for i in range(8):
            make(f"P{i}", view_count=i)
        self.assertEqual(len(self.get("?limit=3").json()["popular"]), 3)
        self.assertEqual(len(self.get().json()["popular"]), 5)  # default

    def test_limit_validation(self):
        self.assertEqual(self.get("?limit=0").status_code, 422)
        self.assertEqual(self.get("?limit=21").status_code, 422)

    def test_extract_truncated_and_null_category(self):
        make("Panjang", summary="kata " * 200, is_featured=True)
        card = self.get().json()["featured"][0]
        self.assertLessEqual(len(card["extract"]), 300)
        self.assertEqual(card["category"], [])
        self.assertIsNone(card["bannerImageUrl"])

    def test_empty_feed(self):
        self.assertEqual(
            self.get().json(), {"featured": [], "inTheNews": [], "popular": []}
        )

    def test_constant_query_count(self):
        for i in range(10):
            make(f"A{i}", is_featured=(i % 2 == 0), is_in_the_news=(i % 3 == 0))
        with self.assertNumQueries(3):  # featured, news, popular
            self.get()
