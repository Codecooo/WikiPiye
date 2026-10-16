# Panduan Implementasi UI Artikel Wiki di Flutter dari Artikel

Panduan ini menjelaskan konsep dasar pemrosesan data model **Freezed** (`Article`, `ArticleSection`, `EditProtectionLevel`) dan cara mengolahnya menjadi antarmuka artikel bergaya Wikipedia yang bersih dan modern di Flutter. INI HANYA PANDUAN SIMPEL AGAR TAHU CARA MENGGUNAKAN DATA ARTIEKL BUKAN KODE PENUH.

---

## I. Konsep Utama & Alur Pemrosesan Data Model

### 1. Apa itu `contentDelta`?

`contentDelta` adalah format penyimpanan teks kaya (*rich-text*) standar yang dipelopori oleh Quill JS. Daripada menyimpan teks sebagai HTML (yang rawan celah keamanan dan sulit diubah menjadi widget *native* di mobile), teks disimpan dalam bentuk daftar instruksi operasi (*operations* / `ops`).

* **Cara Kerja:**
  * Setiap elemen dalam `contentDelta` menentukan teks yang akan ditampilkan (`insert`) beserta gaya/atributnya (`attributes` seperti `bold`, `italic`, `heading`, `link`, atau `list`).
* **Contoh Struktur Data:**
  ```json
  [
    {"insert": "Soekarno "},
    {"insert": "adalah", "attributes": {"bold": true}},
    {"insert": " Presiden pertama Indonesia.\n"}
  ]
  ```
* **Cara Menggunakannya di Flutter:**
  1. Jangan memproses array JSON ini secara manual dengan `Text()` standar.
  2. Gunakan library `flutter_quill`. Bisa kalian download.
  3. Konversi array `contentDelta` menjadi objek `Document`:
     ```dart
     final doc = Document.fromJson(section.contentDelta);
     ```
  4. Buat controller `QuillController` dengan mode `readOnly: true`:
     ```dart
     final controller = QuillController(
       document: doc,
       selection: const TextSelection.collapsed(offset: 0),
       readOnly: true,
     );
     ```
  5. Tampilkan menggunakan widget `QuillEditor.basic(controller: controller)`.

---

### 2. Cara Menggunakan `infoboxData`

`infoboxData` memiliki tipe `Map<String, dynamic>` yang memuat fakta-fakta ringkas artikel dalam bentuk *key-value* (misalnya: `"Lahir": "5 Maret 1909"`).

* **Langkah Implementasi UI:**
  1. **Cek Ketersediaan:** Periksa apakah `article.infoboxData.isNotEmpty`. Jika kosong, sembunyikan komponen ini.
  2. **Render Pasangan Data:** Gunakan metode `.entries.map(...)` untuk mengubah setiap entri *key-value* menjadi baris (`Row`).
  3. **Penataan Layout:** Tempatkan *Key* di sebelah kiri (dengan teks cetak tebal/medium) dan *Value* di sebelah kanan.

---

### 3. Hirarki Heading & Table of Contents (TOC)

Setiap `ArticleSection` memiliki properti `heading` (judul bagian) dan `level` (tingkat kedalaman: 1 untuk H1, 2 untuk H2, 3 untuk H3).

* **Cara Membuat Daftar Isi (TOC) Dinamis:**
  * Iterasi seluruh `article.sections` dan hitung indentasi berdasarkan *level*-nya.
  * $$\text{Indentation} = (\text{level} \times 12.0) + 16.0$$
* **Penerapan Gaya Heading:**
  * Ubah ukuran font judul sesuai level:
    * `level == 1`: Font besar (H1 / Heading Utama).
    * `level == 2`: Font sedang dengan garis pemisah (*Divider*).
    * `level >= 3`: Font reguler/sub-heading.

---

## II. Contoh Implementasi Simpel

Berikut adalah contoh implementasi sederhana komponen utama untuk merender artikel Wiki menggunakan model data tersebut:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

// 1. Widget Komponen Infobox
class WikiInfobox extends StatelessWidget {
  final Map<String, dynamic> infoboxData;

  const WikiInfobox({super.key, required this.infoboxData});

  @override
  Widget build(BuildContext context) {
    if (infoboxData.isEmpty) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: infoboxData.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      entry.key,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(entry.value.toString()),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// 2. Widget Komponen Renderer Section Rich-Text
class WikiSectionView extends StatelessWidget {
  final ArticleSection section;

  const WikiSectionView({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final doc = Document.fromJson(section.contentDelta);
    final controller = QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
      readOnly: true,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (section.heading.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            section.heading,
            style: TextStyle(
              fontSize: section.level == 1 ? 22 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
        ],
        QuillEditor.basic(
          controller: controller,
          config: const QuillEditorConfig(
            scrollable: false,
            autoFocus: false,
            expands: false,
            showCursor: false,
          ),
        ),
      ],
    );
  }
}
```