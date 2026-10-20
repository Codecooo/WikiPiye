/// Memetakan JSON artikel dari Django Ninja ke bentuk yang dipahami model
/// Freezed `Article`.
///
/// Perbedaan yang dijembatani:
/// * kunci `snake_case` di API -> `camelCase` di model;
/// * `id` bertipe integer di API -> `String` di model;
/// * `content_delta` di API berbentuk `{"ops": [...]}` -> list `ops` di model;
/// * endpoint daftar (search/trending/tersimpan) tidak menyertakan `sections`.
class ApiJsonMapper {
  ApiJsonMapper._();

  static Map<String, dynamic> article(Map<String, dynamic> json) {
    final sections = json['sections'] as List<dynamic>? ?? const [];
    return {
      'id': json['id'].toString(),
      'title': json['title'],
      'summary': json['summary'],
      'bannerImageUrl': json['banner_image_url'] ?? '',
      'category': json['category'] ?? const <String>[],
      'editProtectionLevel': json['edit_protection_level'] ?? 'open',
      'infoboxData': json['infobox_data'] ?? const <String, dynamic>{},
      'sections': [
        for (final s in sections) section(s as Map<String, dynamic>),
      ],
      'isFeatured': json['is_featured'] ?? false,
      'isInTheNews': json['is_in_the_news'] ?? false,
      'createdAt': json['created_at'],
      'updatedAt': json['updated_at'],
      'viewCount': json['view_count'],
    };
  }

  static Map<String, dynamic> section(Map<String, dynamic> json) {
    return {
      'id': json['id'].toString(),
      'heading': json['heading'] ?? '',
      'level': json['level'] ?? 1,
      'contentDelta': _ops(json['content_delta']),
    };
  }

  /// Mengambil list `ops` dan memastikan hasilnya valid untuk
  /// `Document.fromJson` (tidak kosong dan diakhiri baris baru).
  static List<Map<String, dynamic>> _ops(Object? delta) {
    final raw = delta is Map ? delta['ops'] : delta;
    final ops = raw is List
        ? [
            for (final op in raw)
              if (op is Map) Map<String, dynamic>.from(op),
          ]
        : <Map<String, dynamic>>[];

    final last = ops.isEmpty ? null : ops.last['insert'];
    if (last is! String || !last.endsWith('\n')) {
      ops.add({'insert': '\n'});
    }
    return ops;
  }
}
