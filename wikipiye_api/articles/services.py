import json
from pathlib import Path
import random


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