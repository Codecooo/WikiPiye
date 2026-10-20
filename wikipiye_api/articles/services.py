import json
import random
from pathlib import Path


def retrieve_facts_fyi():
    """
    Retrieve facts did you know from JSON.
    """
    file_path = Path(__file__).parent / "facts_fyi.json"
    with open(file_path, "r") as file:
        facts = json.load(file)
    return facts

def chosen_facts_fyi():
    """
    Choose a random fact from the list of facts.
    """
    facts = retrieve_facts_fyi()
    return random.sample(facts, 10)


def add_history_activity(user, activity_type, article):
    """
    Add a new activity history record for the user.
    """
    from activity.models import ActivityHistory
    ActivityHistory.objects.create(
        user=user,
        activity_type=activity_type,
        article=article,
    )