import '../models/article/article.dart';

/// Data tiruan artikel. Hapus berkas ini saat endpoint Django Ninja sudah aktif.

/// Membuat daftar op Delta dari paragraf. Teks di antara `**` dicetak tebal.
List<Map<String, dynamic>> _paragraphs(List<String> paragraphs) {
  final ops = <Map<String, dynamic>>[];
  for (final paragraph in paragraphs) {
    final parts = paragraph.split('**');
    for (var i = 0; i < parts.length; i++) {
      if (parts[i].isEmpty) continue;
      ops.add({
        'insert': parts[i],
        if (i.isOdd) 'attributes': {'bold': true},
      });
    }
    ops.add({'insert': '\n'});
  }
  return ops;
}

List<Map<String, dynamic>> _bullets(List<String> items) {
  final ops = <Map<String, dynamic>>[];
  for (final item in items) {
    ops.add({'insert': item});
    ops.add({
      'insert': '\n',
      'attributes': {'list': 'bullet'},
    });
  }
  return ops;
}

String _img(String id) =>
    'https://images.unsplash.com/$id?w=900&h=600&fit=crop';

final List<Article> mockArticles = [
  Article(
    id: 'art-001',
    title: 'Indonesia',
    summary: 'Indonesia adalah negara kepulauan di Asia Tenggara yang dilintasi garis khatulistiwa dan berada di antara Samudra Pasifik dan Samudra Hindia.',
    bannerImageUrl: _img('photo-1555899434-94d1368aa7af'),
    category: ['Negara', 'Asia Tenggara'],
    editProtectionLevel: EditProtectionLevel.full,
    infoboxData: {
      'Ibu kota': 'Jakarta (menuju Nusantara)',
      'Bahasa resmi': 'Indonesia',
      'Bentuk negara': 'Republik',
      'Kemerdekaan': '17 Agustus 1945',
      'Luas wilayah': '1.904.569 km²',
      'Mata uang': 'Rupiah (IDR)',
    },
    sections: [
      ArticleSection(
        id: 'sec-001-1',
        heading: 'Sejarah',
        level: 1,
        contentDelta: _paragraphs([
          'Wilayah Nusantara telah dihuni sejak ribuan tahun lalu dan menjadi jalur perdagangan penting. **Kerajaan Sriwijaya** dan **Majapahit** merupakan dua kemaharajaan besar yang pernah berkuasa.',
          'Proklamasi kemerdekaan dibacakan oleh **Soekarno** dan **Mohammad Hatta** pada 17 Agustus 1945 di Jakarta.',
        ]),
      ),
      ArticleSection(
        id: 'sec-001-2',
        heading: 'Geografi',
        level: 1,
        contentDelta: _paragraphs([
          'Indonesia terdiri dari lebih dari 17.000 pulau. Pulau-pulau terbesarnya adalah Sumatra, Jawa, Kalimantan, Sulawesi, dan Papua.',
        ]),
      ),
      ArticleSection(
        id: 'sec-001-3',
        heading: 'Iklim',
        level: 2,
        contentDelta: _paragraphs([
          'Indonesia beriklim tropis dengan dua musim utama, yaitu musim hujan dan musim kemarau.',
        ]),
      ),
      ArticleSection(
        id: 'sec-001-4',
        heading: 'Budaya',
        level: 1,
        contentDelta: [
          ..._paragraphs([
            'Indonesia memiliki ratusan suku bangsa. Beberapa warisan budaya yang diakui UNESCO:',
          ]),
          ..._bullets(['Batik', 'Wayang', 'Keris', 'Angklung', 'Gamelan']),
        ],
      ),
    ],
    isFeatured: true,
    isInTheNews: false,
    createdAt: DateTime(2023, 1, 12, 9, 30),
    updatedAt: DateTime(2026, 9, 28, 14, 5),
    viewCount: 1250000,
  ),
  Article(
    id: 'art-002',
    title: 'Surabaya',
    summary: 'Surabaya adalah ibu kota Provinsi Jawa Timur dan kota terbesar kedua di Indonesia setelah Jakarta, dijuluki Kota Pahlawan.',
    bannerImageUrl: _img('photo-1588668214407-6ea9a6d8c272'),
    category: ['Kota', 'Jawa Timur'],
    editProtectionLevel: EditProtectionLevel.semi,
    infoboxData: {
      'Provinsi': 'Jawa Timur',
      'Julukan': 'Kota Pahlawan',
      'Hari jadi': '31 Mei 1293',
      'Luas': '326,81 km²',
      'Zona waktu': 'WIB (UTC+7)',
    },
    sections: [
      ArticleSection(
        id: 'sec-002-1',
        heading: 'Sejarah',
        level: 1,
        contentDelta: _paragraphs([
          'Hari jadi Surabaya diperingati setiap 31 Mei. Pertempuran **10 November 1945** menjadikannya simbol perjuangan kemerdekaan dan dikenang sebagai Hari Pahlawan.',
        ]),
      ),
      ArticleSection(
        id: 'sec-002-2',
        heading: 'Ekonomi',
        level: 1,
        contentDelta: _paragraphs([
          'Surabaya adalah pusat perdagangan, industri, dan jasa di kawasan timur Pulau Jawa. Pelabuhan Tanjung Perak merupakan salah satu pelabuhan tersibuk di Indonesia.',
        ]),
      ),
      ArticleSection(
        id: 'sec-002-3',
        heading: 'Tempat wisata',
        level: 1,
        contentDelta: _bullets([
          'Tugu Pahlawan',
          'Jembatan Suramadu',
          'House of Sampoerna',
          'Kebun Binatang Surabaya',
        ]),
      ),
    ],
    isFeatured: false,
    isInTheNews: true,
    createdAt: DateTime(2023, 2, 3, 10, 0),
    updatedAt: DateTime(2026, 10, 2, 8, 45),
    viewCount: 480000,
  ),
  Article(
    id: 'art-003',
    title: 'Kecerdasan buatan',
    summary: 'Kecerdasan buatan adalah simulasi kecerdasan manusia yang diprogram pada mesin agar mampu belajar, bernalar, dan mengambil keputusan.',
    bannerImageUrl: _img('photo-1677442136019-21780ecad995'),
    category: ['Teknologi', 'Sains'],
    editProtectionLevel: EditProtectionLevel.open,
    infoboxData: {
      'Bidang': 'Ilmu komputer',
      'Dicetuskan': '1956 (Konferensi Dartmouth)',
      'Cabang': 'Pembelajaran mesin, visi komputer, NLP',
    },
    sections: [
      ArticleSection(
        id: 'sec-003-1',
        heading: 'Gambaran umum',
        level: 1,
        contentDelta: _paragraphs([
          'Kecerdasan buatan (**artificial intelligence**, AI) mencakup sistem yang dapat mengenali pola, memahami bahasa, dan membuat prediksi dari data.',
        ]),
      ),
      ArticleSection(
        id: 'sec-003-2',
        heading: 'Pembelajaran mesin',
        level: 2,
        contentDelta: _paragraphs([
          'Pembelajaran mesin adalah cabang AI yang memungkinkan komputer belajar dari data tanpa diprogram secara eksplisit.',
        ]),
      ),
      ArticleSection(
        id: 'sec-003-3',
        heading: 'Penerapan',
        level: 1,
        contentDelta: _bullets([
          'Asisten virtual',
          'Pengenalan wajah dan suara',
          'Kendaraan otonom',
          'Diagnosis medis',
        ]),
      ),
    ],
    isFeatured: false,
    isInTheNews: true,
    createdAt: DateTime(2023, 3, 20, 13, 15),
    updatedAt: DateTime(2026, 10, 10, 19, 20),
    viewCount: 910000,
  ),
  Article(
    id: 'art-004',
    title: 'Wikipedia',
    summary: 'Wikipedia adalah ensiklopedia daring bebas yang disusun secara kolaboratif oleh para relawan di seluruh dunia.',
    bannerImageUrl: _img('photo-1457369804613-52c61a468e7d'),
    category: ['Internet', 'Ensiklopedia'],
    editProtectionLevel: EditProtectionLevel.semi,
    infoboxData: {
      'Diluncurkan': '15 Januari 2001',
      'Pendiri': 'Jimmy Wales dan Larry Sanger',
      'Lisensi': 'CC BY-SA',
    },
    sections: [
      ArticleSection(
        id: 'sec-004-1',
        heading: 'Sejarah',
        level: 1,
        contentDelta: _paragraphs([
          'Wikipedia berawal dari proyek **Nupedia**. Edisi bahasa Indonesia mulai berjalan pada tahun 2003.',
        ]),
      ),
      ArticleSection(
        id: 'sec-004-2',
        heading: 'Prinsip',
        level: 1,
        contentDelta: _bullets([
          'Sudut pandang netral',
          'Isi dapat diverifikasi',
          'Konten bebas',
        ]),
      ),
    ],
    isFeatured: true,
    isInTheNews: false,
    createdAt: DateTime(2023, 1, 5, 8, 0),
    updatedAt: DateTime(2026, 8, 15, 11, 10),
    viewCount: 760000,
  ),
  Article(
    id: 'art-005',
    title: 'Soekarno',
    summary: 'Soekarno adalah Presiden pertama Republik Indonesia yang menjabat pada 1945–1967 dan proklamator kemerdekaan bersama Mohammad Hatta.',
    bannerImageUrl: _img('photo-1529156069898-49953e39b3ac'),
    category: ['Tokoh', 'Presiden Indonesia'],
    editProtectionLevel: EditProtectionLevel.full,
    infoboxData: {
      'Lahir': '6 Juni 1901, Surabaya',
      'Wafat': '21 Juni 1970, Jakarta',
      'Jabatan': 'Presiden ke-1 Indonesia',
      'Masa jabatan': '1945 – 1967',
    },
    sections: [
      ArticleSection(
        id: 'sec-005-1',
        heading: 'Kehidupan awal',
        level: 1,
        contentDelta: _paragraphs([
          'Soekarno lahir di Surabaya dan menempuh pendidikan teknik sipil di Bandung. Ia mendirikan **Partai Nasional Indonesia** pada 1927.',
        ]),
      ),
      ArticleSection(
        id: 'sec-005-2',
        heading: 'Proklamasi',
        level: 1,
        contentDelta: _paragraphs([
          'Pada **17 Agustus 1945**, Soekarno membacakan teks proklamasi kemerdekaan di Jalan Pegangsaan Timur 56, Jakarta.',
        ]),
      ),
    ],
    isFeatured: false,
    isInTheNews: false,
    createdAt: DateTime(2023, 4, 1, 7, 30),
    updatedAt: DateTime(2026, 6, 17, 16, 40),
    viewCount: 530000,
  ),
  Article(
    id: 'art-006',
    title: 'Candi Borobudur',
    summary: 'Candi Borobudur adalah candi Buddha abad ke-9 di Magelang, Jawa Tengah, dan merupakan candi Buddha terbesar di dunia.',
    bannerImageUrl: _img('photo-1596402184320-417e7178b2cd'),
    category: ['Candi', 'Warisan Dunia'],
    editProtectionLevel: EditProtectionLevel.open,
    infoboxData: {
      'Lokasi': 'Magelang, Jawa Tengah',
      'Dibangun': 'Abad ke-8 sampai ke-9',
      'Dinasti': 'Syailendra',
      'Status UNESCO': 'Warisan Dunia (1991)',
    },
    sections: [
      ArticleSection(
        id: 'sec-006-1',
        heading: 'Arsitektur',
        level: 1,
        contentDelta: _paragraphs([
          'Borobudur berbentuk stupa raksasa dengan **sembilan tingkat**: enam berbentuk bujur sangkar dan tiga berbentuk lingkaran.',
        ]),
      ),
      ArticleSection(
        id: 'sec-006-2',
        heading: 'Relief',
        level: 2,
        contentDelta: _paragraphs([
          'Dinding candi dihiasi sekitar 2.670 panel relief yang menceritakan ajaran Buddha dan kehidupan masyarakat masa itu.',
        ]),
      ),
    ],
    isFeatured: true,
    isInTheNews: false,
    createdAt: DateTime(2023, 5, 9, 12, 0),
    updatedAt: DateTime(2026, 9, 1, 9, 0),
    viewCount: 680000,
  ),
];
