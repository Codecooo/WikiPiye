from ninja import ModelSchema


class ActivityHistoryOut(ModelSchema):
    class Meta:
        model = "activity.ActivityHistory"
        fields = "__all__"
