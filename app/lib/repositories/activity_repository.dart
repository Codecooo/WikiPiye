import 'package:dio/dio.dart';
import 'package:wikipiye/models/activity_history/activity_history.dart';

class ActivityRepository {
  final Dio _dio;

  ActivityRepository(this._dio);

  Future<List<ActivityHistory>> getActivities() async {
    // Implementation to fetch activities from a data source
    final response = await _dio.get('/activity');
    return (response.data as List)
        .map((e) => ActivityHistory.fromJson(e))
        .toList();
  }
}
