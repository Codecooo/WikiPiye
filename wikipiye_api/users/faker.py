from users.models import User, UserRole


def seed_users(fake, limit=1000):
    """
    Seed the database with fake users.
    """
    generated_users = []

    for _ in range(limit):
        user = User.objects.create(
            username=fake.unique.user_name(),
            email=fake.unique.email(),
            password=fake.password(),
            role=fake.random_element(elements=UserRole.choices),
        )
        generated_users.append(user)

    return generated_users