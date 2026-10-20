import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wikipiye/main.dart';
import 'package:wikipiye/models/activity_history/activity_history.dart';
import 'package:wikipiye/repositories/activity_repository.dart';

part 'activity_viewmodel.g.dart';

@riverpod
class ActivityViewmodel extends _$ActivityViewmodel {
  final _activityRepository = getIt<ActivityRepository>();

  @override
  Future<List<ActivityHistory>> build() {
    return _activityRepository.getActivities();
  }
}
