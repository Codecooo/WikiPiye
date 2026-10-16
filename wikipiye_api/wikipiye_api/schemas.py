from ninja import Schema
from pydantic import ConfigDict
from pydantic.alias_generators import to_camel


class ErrorOut(Schema):
    detail: str


class CamelSchema(Schema):
    """
    Base schema untuk response/request yang dikonsumsi Flutter.
    Field ditulis snake_case di Python, tetapi di JSON menjadi camelCase
    (misalnya created_at -> createdAt). Gunakan by_alias=True di route.
    """

    model_config = ConfigDict(alias_generator=to_camel, populate_by_name=True)
