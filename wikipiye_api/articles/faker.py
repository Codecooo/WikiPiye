from collections import OrderedDict

from articles.models import ArticleEdit


def seed_article_edits(fake, article, users, limit=5):
    """
    Seed the database with fake article edits for a given article.
    """
    generated_edits = []

    for _ in range(limit):
        edit = ArticleEdit.objects.create(
            article=article,
            editor=fake.random_element(elements=OrderedDict([(user, 0.9) for user in users] + [(None, 0.1)])),  # Some edits may not have an associated user
            editor_ip_address=fake.ipv4_private(),
            edit_title=fake.sentence(),
            edit_summary=fake.text(max_nb_chars=200),
        )
        generated_edits.append(edit)

    return generated_edits