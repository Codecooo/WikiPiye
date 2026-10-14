# PETUNJUK & PANDUAN PENGEMBANGAN WIKIIPIYE

Baca panduan ini dengan cermat untuk memahami latar belakang proyek aplikasi, sistem desain, arsitektur, batasan teknis, dan konvensi pengembangan. Semua asisten AI, generator kode, dan peninjau kode (*code reviewer*) WAJIB mematuhi panduan ini secara ketat.

## 1. Latar Belakang Proyek & Domain

**WikiiPiye** adalah aplikasi klien seluler klon Wikipedia modern dengan backend berbasis API kustom. Aplikasi ini memfasilitasi pembacaan artikel berstruktur, pencarian cepat, mode *offline/bookmark*, serta penyuntingan artikel secara kolaboratif menggunakan **Editor WYSIWYG (Delta JSON)**.

### Identitas Visual & UI Utama

* **Elemen UI:** Salinan ketat 1:1 mendekati aplikasi seluler Wikipedia (minimalis, responsif, tipografi jernih, navigasi cepat, dan mode gelap/terang).

## 2. Struktur Proyek

Basis kode (*codebase*) mengikuti struktur modular berbasis fitur dan lapisan responsibilitas yang ketat. Setiap model domain di dalam `lib/models/` diletakkan di dalam folder khususnya masing-masing. **JANGAN membuat folder tingkat teratas (*top-level*) baru atau arsitektur kustom tanpa persetujuan eksplisit dari pengguna.**

```
lib/
├── models/             # Entitas domain bisnis (Model imutabel Freezed)
│   ├── user/
│   │   └── user.dart   # Entitas User & Role (Profil aman tanpa IP)
│   ├── article/
│   │   └── article.dart # Entitas Artikel & Delta Content (WYSIWYG)
│   ├── article_edit/
│   │   └── article_edit.dart # Riwayat revisi/edit artikel
│   ├── reading_list/
│   │   └── reading_list.dart # Daftar bacaan & bookmark pengguna
│   └── dto/
│       └── dto.dart    # DTO khusus untuk payload API mentah & SearchResult
├── repositories/       # Lapisan komunikasi API (Django Ninja) & penyimpanan lokal
│   ├── article_repository.dart
│   ├── user_repository.dart
│   └── reading_list_repository.dart
├── services/           # Layanan berstatus (stateful) yang dapat digunakan kembali (mis. Secure Storage, Dio/HTTP Client)
├── ui/                 # Semua layar dan widget UI Flutter
│   ├── components/     # Widget UI atomik yang dapat digunakan kembali (tombol, kartu, input)
│   │   ├── custom_button.dart
│   │   └── article_card.dart
│   └── [nama_fitur]/   # Layar & komponen lokal khusus fitur (mis. article_detail, editor, search)
│       ├── widgets/    # Komponen UI privat khusus untuk halaman ini
│       └── [fitur]_screen.dart
├── utils/              # Fungsi pembantu (helper) statis murni dan formatters
└── main.dart
```

## 3. Tumpukan Arsitektur (Architecture Stack)

* **Kerangka Kerja (Framework):** Flutter (Menargetkan Android & iOS)
* **API Backend:** Django Ninja (Spesifikasi REST / OpenAPI JSON)
* **Format Konten WYSIWYG:** Delta JSON / Block-based Format (Compatible dengan `flutter_quill`)
* **Manajemen State:** `flutter_riverpod` dengan anotasi `riverpod_generator` (`@riverpod`)
* **Imutabilitas & Codegen:** `freezed` + `json_serializable` (`build_runner`)
* **Strategi Autentikasi:** JWT Bearer token yang disimpan di `flutter_secure_storage`

## 4. Standar Pengodean & Aturan Pemeliharaan Kode

### Aturan A: Komponentisasi Wajib (Dilarang Layar Monolitik)

Jangan pernah menulis struktur widget (*widget tree*) yang besar dan monolitik dalam satu berkas layar.
* Jika fungsi `build` melebihi **120 baris**, pisahkan menjadi berkas komponen khusus di dalam `ui/components/` (jika digunakan bersama) atau `ui/[nama_fitur]/widgets/` (jika bersifat lokal).
* Isolasi logika UI yang kompleks (misalnya, rendering editor Delta, daftar riwayat edit, kartu referensi) ke dalam kelas `StatelessWidget` atau `ConsumerWidget` terpisah.

### Aturan B: Imutabilitas & Keamanan Model

1. **Jangan pernah mengubah model domain yang ada** di `lib/models/` tanpa izin eksplisit dari pengguna.
2. Setiap model domain wajib berada dalam sub-folder khususnya (misal: `lib/models/user/user.dart`).
3. Semua model data di dalam `lib/models/` WAJIB menggunakan paket **Freezed** untuk menjamin imutabilitas.
4. **Privasi & Keamanan Data:** Dilarang memasukkan data sensitif pengguna (seperti `ipAddress` atau password) ke dalam model `User` di sisi klien.
5. Jika sebuah endpoint API membutuhkan bentuk permintaan/respons yang tidak cocok 1:1 dengan model domain (misalnya `ArticleSearchResult` atau payload ringkas), letakkan di dalam `lib/models/dto/dto.dart`.

#### Pola Kode Model (Freezed + Sub-Folder Structure)

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
abstract class Article with _$Article {
  const factory Article({
    required String id,
    required String title,
    required String summary,
    required String bannerImageUrl,
    required List<ArticleSection> sections,
    @Default([]) List<String> tags,
    required EditProtectionLevel editProtectionLevel,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}

@freezed
abstract class ArticleSection with _$ArticleSection {
  const factory ArticleSection({
    required String id,
    required String heading,
    @Default(1) int level,
    required List<Map<String, dynamic>> contentDelta, // Format Delta JSON untuk WYSIWYG
  }) = _ArticleSection;

  factory ArticleSection.fromJson(Map<String, dynamic> json) => _$ArticleSectionFromJson(json);
}

enum EditProtectionLevel {
  @JsonValue('open') open,
  @JsonValue('semi') semi,
  @JsonValue('full') full,
}
```

### Aturan C: Pola Repositori & Data Tiruan (Fake Data)

Repositori bertindak sebagai sumber kebenaran tunggal (*single source of truth*) untuk pengambilan data mentah dari Django Ninja backend atau cache lokal.
* Selalu definisikan antarmuka (*interface*) atau kelas repositori yang bersih.
* Ketika endpoint API belum siap, terapkan **penundaan data tiruan (mock/fake data delay)** di dalam repositori alih-alih menuliskan daftar mock statis secara *hardcode* di dalam widget UI.

#### Pola Kode Repositori (WikiiPiye Domain)

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/article/article.dart';

class ArticleRepository {
  // TODO: Ganti dengan klien Dio/Http saat endpoint Django Ninja sudah aktif
  Future<List<Article>> fetchTrendingArticles() async {
    await Future.delayed(const Duration(milliseconds: 600)); // Simulasi latensi API
    return [
      Article(
        id: 'art-001',
        title: 'Kecerdasan Buatan',
        summary: 'Kecerdasan Buatan adalah simulasi dari kecerdasan manusia...',
        bannerImageUrl: 'https://example.com/ai.jpg',
        sections: [],
        tags: ['Teknologi', 'Sains'],
        editProtectionLevel: EditProtectionLevel.open,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
  }
}

final articleRepositoryProvider = Provider<ArticleRepository>((ref) {
  return ArticleRepository();
});
```

### Aturan D: Manajemen State dengan Riverpod Generator

* **JANGAN menggunakan `ChangeNotifier`**, `StatefulWidget` untuk state global, atau `setState()` manual untuk data jarak jauh yang asinkron.
* Gunakan `riverpod_annotation` (`@riverpod`) untuk menghasilkan kelas `Notifier` dan `AsyncNotifier` yang bersih.

#### Pola Kode Manajemen State

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/article/article.dart';
import '../../repositories/article_repository.dart';

part 'article_list_notifier.g.dart';

@riverpod
class ArticleListNotifier extends _$ArticleListNotifier {
  @override
  FutureOr<List<Article>> build() async {
    final repository = ref.watch(articleRepositoryProvider);
    return repository.fetchTrendingArticles();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(articleRepositoryProvider).fetchTrendingArticles());
  }
}
```

### Aturan E: Fungsi Pembantu Statis di Utils

Jika fungsi pembantu (*helper*) atau utilitas bersifat murni, deterministik, dan tidak memiliki state internal (seperti formatting tanggal, parser URL, atau sanitasi teks), buat menjadi **kelas statis atau fungsi tingkat teratas (*top-level function*)** di `lib/utils/`.

#### Pola Kode Utilitas

```dart
import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._(); // Konstruktor privat untuk mencegah instansiasi

  static String toReadableArticleDate(DateTime dateTime) {
    return DateFormat('d MMMM yyyy, HH:mm', 'id_ID').format(dateTime);
  }
}
```

## 5. Instruksi Khusus untuk AI Code Reviewer & Copilot

Jika Anda adalah peninjau kode AI otomatis (misalnya, CodeRabbit, GitHub Copilot, atau peninjau PR otomatis):

1. **Persyaratan Bahasa:** Tulis semua tinjauan kode, komentar, dan ringkasan PR dalam **Bahasa Indonesia**, kecuali untuk istilah teknis/kode standar (seperti *state management*, *provider*, *repository*, *widget tree*, *null safety*, *delta json*).
2. **Nada & Fokus Tinjauan:**
   * Bersifat konstruktif, presisi, dan ringkas. Hindari pengantar yang tidak perlu.
   * Tunjukkan pelanggaran arsitektur secara langsung (misalnya, menempatkan panggilan jaringan mentah di dalam metode `build`, anotasi Freezed yang hilang, menaruh data IP di model `User`, penempatan berkas model di luar sub-folder khusus, atau mengubah model di `lib/models/` tanpa persetujuan).
3. **Daftar Periksa (Checklist) untuk Persetujuan PR:**
   * [ ] Tidak ada `ChangeNotifier` atau manajemen state usang yang diperkenalkan.
   * [ ] Setiap model diletakkan dalam direktori khusus (contoh: `lib/models/user/user.dart`).
   * [ ] Kode UI dipecah menjadi komponen atomik (tidak ada berkas `build` monolitik yang raksasa > 120 baris).
   * [ ] Semua model di dalam `lib/models/` tetap imutabel dan memanfaatkan Freezed.
   * [ ] Tidak ada pencatatan/penyimpanan `ipAddress` di model `User` sisi klien.
   * [ ] Format konten artikel konsisten mendukung Delta JSON / WYSIWYG block.
   * [ ] Kode berhasil dikompilasi tanpa *error/warning* menggunakan `flutter analyze`.