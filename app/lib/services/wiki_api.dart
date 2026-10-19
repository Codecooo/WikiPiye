import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/api_config.dart';

class WikiApi {
  WikiApi._();

  static final WikiApi instance = WikiApi._();

  final http.Client _client = http.Client();

  Uri _uri(String path, [Map<String, String>? query]) {
    return Uri.parse('${ApiConfig.baseUrl}$path')
        .replace(queryParameters: query);
  }

  Future<dynamic> _get(String path, [Map<String, String>? query]) async {
    final response = await _client
        .get(_uri(path, query), headers: const {'Accept': 'application/json'})
        .timeout(const Duration(seconds: 12));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('API ${response.statusCode}: ${response.body}');
    }

    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  Future<List<Map<String, dynamic>>> trending({int limit = 10}) async {
    final data = await _get('/articles/trending', {'limit': '$limit'});

    return _mapList(data);
  }

  Future<List<Map<String, dynamic>>> featuredNews() async {
    final data = await _get('/articles/featured-news');
    return _mapList(data);
  }

  Future<List<String>> facts() async {
    final data = await _get('/articles/fyi/facts');

    if (data is List) {
      return data.map((item) => item.toString()).toList();
    }

    return <String>[];
  }

  Future<Map<String, dynamic>> forYou({int limit = 5}) async {
    final data = await _get('/for-you/', {'limit': '$limit'});

    if (data is Map<String, dynamic>) {
      return data;
    }

    return <String, dynamic>{};
  }

  Future<List<Map<String, dynamic>>> search(String query) async {
    final data = await _get('/articles/search', {
      'query': query,
      'limit': '10',
    });

    return _mapList(data);
  }

  Future<Map<String, dynamic>> community({int limit = 5}) async {
    final data = await _get('/community/', {'limit': '$limit'});

    if (data is Map<String, dynamic>) {
      return data;
    }

    throw Exception('Format respons API Community tidak sesuai.');
  }

  List<Map<String, dynamic>> _mapList(dynamic data) {
    if (data is List) {
      return data
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }

    return <Map<String, dynamic>>[];
  }
}
