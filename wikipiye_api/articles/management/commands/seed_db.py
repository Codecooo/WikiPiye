from django.core.management.base import BaseCommand
from faker import Faker
from faker.providers import internet
from users.faker import seed_users

from articles.faker import seed_article_edits
from articles.models import Article


class Command(BaseCommand):
    help = "Seeding database dengan data fake kecuali articles, karena artikel ada command tersendiri seed_articles."

    def add_arguments(self, parser):
        parser.add_argument("--limit", type=int, default=5000)
    
    def handle(self, *args, **options):
        limit = options["limit"]

        self.stdout.write(self.style.SUCCESS("Seed  database..."))

        fake = Faker("id_ID")
        fake.seed_instance(676769)
        fake.add_provider(internet)

        self.stdout.write(self.style.SUCCESS(f"Seeding {limit} user..."))
        users = seed_users(fake, limit)
        self.stdout.write(self.style.SUCCESS(f"Seed {len(users)} users sukses."))

        articles = Article.objects.all()
        self.stdout.write(self.style.SUCCESS(f"Seeding article edits untuk {len(articles)} articles..."))
        for article in articles:
            seed_article_edits(fake, article=article, users=users)

        self.stdout.write(self.style.SUCCESS("Seeding selesai."))
