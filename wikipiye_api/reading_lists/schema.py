from datetime import datetime
from ninja import Field, ModelSchema


class ReadingListIn(ModelSchema):
    class Meta:
        model = "reading_lists.ReadingList"
        fields = "__all__"


class ReadingListOut(ModelSchema):
    """Cocok dengan model `ReadingList` di Flutter (lib/models/reading_list/reading_list.dart)."""
    class Meta:
        model = "reading_lists.ReadingList"
        fields = "__all__"
