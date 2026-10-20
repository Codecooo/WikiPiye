import 'package:flutter/material.dart';

/// Halaman "Tentang" WikiiPiye (berdiri sendiri, tidak butuh paket tambahan).
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const _blue = Color(0xFF3366CC);

  // Ganti sesuai versi / build aplikasi tim.
  static const _version = '1.0.0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Tentang',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
        children: [
          // ---- Logo + nama + versi ----
          Center(
            child: Image.asset(
              'assets/images/wikipedia_logo.png',
              height: 120,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.public, size: 120, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'WikiPiye',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              _version,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 40),

          // ---- Kontributor ----
          _heading('Kontributor'),
          _link(context, 'Halaman tim'),
          const SizedBox(height: 28),

          // ---- Penerjemah ----
          _heading('Penerjemah'),
          Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 16, height: 1.5),
              children: [
                const TextSpan(
                  text:
                      'Aplikasi ini telah diterjemahkan oleh penerjemah '
                      'sukarela di ',
                ),
                _linkSpan(context, 'translatewiki.net'),
                const TextSpan(text: '.'),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ---- Pustaka ----
          _heading('Pustaka yang digunakan'),
          Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 16, height: 1.5),
              children: [
                for (var i = 0; i < _libs.length; i++) ...[
                  _linkSpan(context, '${_libs[i]} (license)'),
                  if (i < _libs.length - 1) const TextSpan(text: ', '),
                ],
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ---- Lisensi ----
          _heading('Lisensi'),
          Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 16, height: 1.5),
              children: [
                const TextSpan(text: 'Kode sumber tersedia di '),
                _linkSpan(context, 'GitHub'),
                const TextSpan(text: ' di bawah '),
                _linkSpan(context, 'Lisensi Apache 2.0'),
                const TextSpan(text: '. Konten tersedia di bawah '),
                _linkSpan(
                  context,
                  'Lisensi Atribusi-BerbagiSerupa Creative Commons',
                ),
                const TextSpan(text: ' kecuali dinyatakan lain.'),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // ---- Footer ----
          const Center(
            child: Icon(Icons.hub_outlined, size: 48, color: Colors.black45),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
                children: [
                  const TextSpan(text: 'Sebuah produk dari '),
                  _linkSpan(context, 'Wikimedia Foundation'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Daftar pustaka — sesuaikan dengan pubspec.yaml tim.
  static const _libs = ['Flutter', 'Freezed', 'json_serializable'];

  Widget _heading(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    ),
  );

  Widget _link(BuildContext context, String text) => InkWell(
    onTap: () => _soon(context),
    child: Text(
      text,
      style: const TextStyle(
        color: _blue,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  /// Teks biru yang bisa ditekan di dalam kalimat.
  /// Catatan: tanpa url_launcher, tap hanya menampilkan snackbar.
  /// Kalau mau buka browser, tambahkan paket url_launcher lalu ganti _soon.
  InlineSpan _linkSpan(BuildContext context, String text) => WidgetSpan(
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.alphabetic,
    child: GestureDetector(
      onTap: () => _soon(context),
      child: Text(
        text,
        style: const TextStyle(
          color: _blue,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
      ),
    ),
  );

  void _soon(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Fitur ini belum tersedia')));
  }
}
