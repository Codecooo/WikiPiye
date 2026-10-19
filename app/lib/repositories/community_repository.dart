
import '../models/dto/community_feed.dart';
import '../services/wiki_api.dart';

class CommunityRepository {
  Future<CommunityFeed> fetchFeed({int limit = 5}) async {
    final json = await WikiApi.instance.forYou(limit: limit);
    return CommunityFeed.fromJson(json);
  }
}
