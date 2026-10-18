# Panduan Integrasi API WikiiPiye (Flutter & Dio)

Panduan ini berisi petunjuk praktis bagi tim *frontend* untuk membaca dokumentasi OpenAPI/Swagger dari Django Ninja dan mengintegrasikannya dengan aplikasi Flutter WikiiPiye menggunakan **Dio**, **Freezed**, dan **Riverpod**. INI CUMA CONTOH TIDAK LENGKAP, BUKAN IMPLEMENTASI PENUH. BUAT IMPLEMENTASI SENDIRI.

---

## I. Cara Membaca Dokumentasi API (Swagger / OpenAPI Django Ninja)

 Django Ninja secara otomatis menyediakan antarmuka Swagger UI (biasanya di URL `http://<base_url>/api/docs`). Berikut adalah cara menerjemahkan dokumentasi API ke dalam kode Flutter:

```
+-----------------------------------------------------------------------+
|  GET /api/articles/trending                                           |  <-- 1. HTTP Method & Endpoint
|  Summary: Fetch trending articles list                                |
+-----------------------------------------------------------------------+
|  PARAMETERS                                                           |  <-- 2. Query/Path Parameters
|  - limit (query, integer, optional, default: 10)                      |
|  - category (query, string, optional)                                 |
+-----------------------------------------------------------------------+
|  RESPONSES                                                            |
|  200 OK                                                               |  <-- 3. HTTP Status Code
|  [                                                                    |  <-- 4. Response Schema JSON
|    {                                                                  |
|      "id": "art-001",                                                 |
|      "title": "Kecerdasan Buatan",                                    |
|      "summary": "Simulasi dari kecerdasan manusia...",                |
|      "banner_image_url": "https://...",                               |
|      "edit_protection_level": "open",                                 |
|      "created_at": "2026-03-31T10:00:00Z",                            |
|      "updated_at": "2026-03-31T10:00:00Z"                             |
|    }                                                                  |
|  ]                                                                    |
+-----------------------------------------------------------------------+
```

### Langkah Identifikasi:
1. **HTTP Method & Endpoint:** Tentukan metode HTTP (`GET`, `POST`, `PUT`, `DELETE`) dan *path* URL (misal: `/articles/trending`).
2. **Request Payload / Parameters:**
   - **Query Parameters:** Ditambahkan ke `queryParameters` pada Dio (`?limit=10`).
   - **Path Parameters:** Dimasukkan langsung ke URL (`/articles/{id}`).
   - **Request Body (JSON Schema):** Jika bertipe `POST`/`PUT`, periksa skema JSON yang dibutuhkan. Buat DTO jika strukturnya tidak cocok 1:1 dengan model domain.
3. **Naming Convention (snake_case vs camelCase):** Backend Django Ninja mengirimkan JSON dalam format `snake_case` (`banner_image_url`). Di Flutter, gunakan `camelCase` (`bannerImageUrl`) dan biarkan `json_serializable` menangani pemetaannya secara otomatis.

---

## II. Pengaturan Dio & Service Autentikasi

Semua *request* harus melalui *instance* Dio terpusat yang memanfaatkan `ApiConfig` dan Interceptor untuk menangani Token JWT secara otomatis.

### `lib/services/api_service.dart`

```dart
import 'package0:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/api_config.dart';

class ApiService {
  final Dio dio;
  final FlutterSecureStorage storage;

  ApiService(this.storage)
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiConfig.baseUrl,
            connectTimeout: ApiConfig.connectionTimeout,
            receiveTimeout: ApiConfig.receiveTimeout,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Sisipkan Bearer Token jika tersimpan di Secure Storage
          final token = await storage.read(key: ApiConfig.tokenKey);
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) {
          // Tangani global error (misal: 401 Unauthorized)
          if (error.response?.statusCode == 401) {
            // Logic token expired / logout
          }
          return handler.next(error);
        },
      ),
    );
  }
}
```

---

## III. Contoh-Contoh Integrasi API

### Contoh 1: GET Request (Fetch List Data - `ArticleRepository`)

**Skenario API Docs:**
- **Endpoint:** `GET /api/articles/trending`
- **Query Params:** `limit` (int, optional)
- **Response 200:** Array of `Article`

#### `lib/repositories/article_repository.dart`

```dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/article/article.dart';
import '../services/api_service.dart';

class ArticleRepository {
  final ApiService _apiService;

  ArticleRepository(this._apiService);

  Future<List<Article>> fetchTrendingArticles({int limit = 10}) async {
    try {
      final response = await _apiService.dio.get(
        '/articles/trending',
        queryParameters: {'limit': limit},
      );

      final List<dynamic> data = response.data;
      return data.map((json) => Article.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      return 'Koneksi internet lambat. Coba lagi.';
    }
    return error.response?.data['detail'] ?? 'Gagal mengambil data artikel.';
  }
}

// Provider untuk Repositori
final articleRepositoryProvider = Provider<ArticleRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ArticleRepository(apiService);
});
```

---

### Contoh 2: POST Request & Penggunaan DTO (Buat Artikel Baru - `ArticleCreateRequestDTO`)

**Skenario API Docs:**
- **Endpoint:** `POST /api/articles`
- **Request Body:**
  ```json
  {
    "title": "Kecerdasan Buatan",
    "summary": "Artikel tentang kecerdasan buatan modern",
    "banner_image_url": "https://example.com/image.jpg",
    "category": [
      "Teknologi",
      "Sains"
    ],
    "infobox_data": {
      "Kategori Utama": "Informatika"
    },
    "sections": []
  }
  ```
- **Response 201:** `Article` (Objek artikel yang berhasil dibuat)

#### 1. Buat DTO jika skema payload request tidak cocok 1:1 dengan Model Domain
`lib/models/dto/dto.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dto.freezed.dart';
part 'dto.g.dart';

@freezed
abstract class ArticleCreateRequestDTO with _$ArticleCreateRequestDTO {
  const factory ArticleCreateRequestDTO({
    required String title,
    required String summary,
    @JsonKey(name: 'banner_image_url') String? bannerImageUrl,
    @Default([]) List<String> category,
    @JsonKey(name: 'infobox_data') Map<String, dynamic>? infoboxData,
    @Default([]) List<Map<String, dynamic>> sections,
  }) = _ArticleCreateRequestDTO;

  factory ArticleCreateRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$ArticleCreateRequestDTOFromJson(json);
}
```

#### 2. Implementasi di Repositori (`ArticleRepository`)

```dart
Future<Article> createArticle(ArticleCreateRequestDTO request) async {
  try {
    final response = await _apiService.dio.post(
      '/articles',
      data: request.toJson(), // Konversi otomatis DTO ke JSON payload dengan snake_case
    );

    return Article.fromJson(response.data);
  } on DioException catch (e) {
    throw _handleError(e);
  }
}
```

---

### Contoh 3: PUT/PATCH Request (Editor Delta JSON / WYSIWYG)

**Skenario API Docs:**
- **Endpoint:** `PUT /api/articles/{id}/sections/{section_id}`
- **Request Body:**
  ```json
  {
    "heading": "Latar Belakang",
    "level": 2,
    "content_delta": [
      {"insert": "Teks baru dari editor...\n"}
    ]
  }
  ```

#### Implementasi di Repositori

```dart
Future<void> updateArticleSection({
  required String articleId,
  required String sectionId,
  required String heading,
  required int level,
  required List<Map<String, dynamic>> contentDelta,
}) async {
  try {
    await _apiService.dio.put(
      '/articles/$articleId/sections/$sectionId',
      data: {
        'heading': heading,
        'level': level,
        'content_delta': contentDelta, // Format Delta JSON langsung dikirim
      },
    );
  } on DioException catch (e) {
    throw _handleError(e);
  }
}
```

---

## IV. Menghubungkan Repositori ke UI dengan Riverpod Generator

Gunakan `@riverpod` untuk menangani *loading state*, *error handling*, dan konsumsi data di widget UI secara aman.

### 1. State Notifier (`lib/ui/create_article/create_article_notifier.dart`)

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/article/article.dart';
import '../../models/dto/dto.dart';
import '../../repositories/article_repository.dart';

part 'create_article_notifier.g.dart';

@riverpod
class CreateArticleNotifier extends _$CreateArticleNotifier {
  @override
  FutureOr<Article?> build() {
    return null; // Initial state kosong sebelum aksi submit
  }

  Future<void> submitArticle(ArticleCreateRequestDTO dto) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(articleRepositoryProvider);
      return repo.createArticle(dto);
    });
  }
}
```

### 2. Widget UI (`lib/ui/create_article/create_article_screen.dart`)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/dto/dto.dart';
import 'create_article_notifier.dart';

class CreateArticleScreen extends ConsumerStatefulWidget {
  const CreateArticleScreen({super.key});

  @override
  ConsumerState<CreateArticleScreen> createState() => _CreateArticleScreenState();
}

class _CreateArticleScreenState extends ConsumerState<CreateArticleScreen> {
  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  void _onCreateSubmitted() {
    final dto = ArticleCreateRequestDTO(
      title: _titleController.text.trim(),
      summary: _summaryController.text.trim(),
      category: ['Umum'],
      infoboxData: {},
      sections: [],
    );

    ref.read(createArticleNotifierProvider.notifier).submitArticle(dto);
  }

  @override
  Widget build(BuildContext context) {
    final createState = ref.watch(createArticleNotifierProvider);

    // Mendengarkan perubahan state untuk feedback UI (misal: navigasi setelah sukses)
    ref.listen(createArticleNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (article) {
          if (article != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Artikel "${article.title}" berhasil dibuat!')),
            );
            Navigator.pop(context);
          }
        },
        error: (err, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal membuat artikel: $err'), backgroundColor: Colors.red),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Buat Artikel Baru')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul Artikel'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _summaryController,
              decoration: const InputDecoration(labelText: 'Ringkasan'),
            ),
            const SizedBox(height: 24),
            createState.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _onCreateSubmitted,
                    child: const Text('Simpan Artikel'),
                  ),
          ],
        ),
      ),
    );
  }
}
```

---

## V. Daftar Periksa (Checklist) Integrasi API

Sebelum membuat Pull Request (PR), pastikan tim *frontend* memeriksa hal-hal berikut:

- [ ] **Tidak ada Hardcoded URL:** Semua *base URL* dan *timeout* mengacu pada `ApiConfig`.
- [ ] **Code Generation Active:** Jalankan `dart run build_runner build --delete-conflicting-outputs` setiap kali mengubah DTO atau model Freezed.
- [ ] **Handling Error Berasal dari Dio:** Pastikan semua panggilan jaringan dibungkus dengan `try-catch` (`DioException`) dan memberikan pesan kesalahan yang *user-friendly*.
- [ ] **Sesuai Konvensi Model:** Model domain diletakkan di `lib/models/[nama_domain]/`, sedangkan payload API sementara diletakkan di `lib/models/dto/dto.dart`.
- [ ] **Model tetap Imutabel:** Menggunakan anotasi Freezed untuk semua model data dan DTO.