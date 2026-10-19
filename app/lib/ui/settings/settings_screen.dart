import 'package:flutter/material.dart';

import '../more/about_screen.dart';
import 'language_screen.dart';

/// Halaman Pengaturan (berdiri sendiri, tidak butuh file lain).
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, this.username = 'User123'});

  /// Nama akun (dummy). Ganti dengan data login tim kalau sudah ada.
  final String username;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const _blue = Color(0xFF3366CC);
  static const _red = Color(0xFFB32424);

  bool _linkPreview = true;
  bool _collapseTables = true;
  bool _syncReadingList = true;
  bool _downloadReadingList = true;
  bool _wifiOnly = false;
  bool _showImages = true;
  bool _offlineFirst = false;
  String _theme = 'Terang';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Pengaturan',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        children: [
          _section('Umum'),
          ValueListenableBuilder<List<WikiLanguage>>(
            valueListenable: selectedLanguages,
            builder: (context, langs, _) => ListTile(
              title: const Text('Bahasa Wikipedia'),
              subtitle: Text(langs.map((l) => l.name).join(', ')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LanguageScreen(),
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: const Text('Beranda'),
            subtitle: const Text('Sesuaikan beranda Anda'),
            onTap: _soon,
          ),
          _switch(
            'Tampilkan pratayang pranala',
            'Tampilkan pratayang singkat artikel setelah menekan pranala.',
            _linkPreview,
            (v) => setState(() => _linkPreview = v),
          ),
          _switch(
            'Ciutkan tabel',
            'Secara otomatis menciutkan tabel dalam artikel, seperti kotak info, referensi, dan catatan.',
            _collapseTables,
            (v) => setState(() => _collapseTables = v),
          ),
          ListTile(
            title: const Text('Tema aplikasi'),
            subtitle: Text(_theme),
            onTap: _pickTheme,
          ),
          ListTile(
            title: const Text('Preferensi suntingan'),
            subtitle: const Text('Visual editing'),
            onTap: _soon,
          ),

          _section('Recommendations'),
          ListTile(
            title: const Text('Discover collection'),
            subtitle: const Text(
              "Discover is off. Wikipedia won't recommend you articles to read.",
            ),
            onTap: _soon,
          ),

          _section('Donations'),
          ListTile(
            title: const Text('Hapus riwayat sumbangan'),
            onTap: () => _confirm(
              'Hapus riwayat sumbangan?',
              'Riwayat sumbangan di perangkat ini akan dihapus.',
              'Hapus',
            ),
          ),

          _section('Sinkronisasi'),
          _switch(
            'Sinkronisasi daftar bacaan',
            'Sinkronkan daftar bacaan di berbagai perangkat dengan akun Wikipedia Anda.',
            _syncReadingList,
            (v) => setState(() => _syncReadingList = v),
          ),
          _switch(
            'Unduh artikel di daftar bacaan',
            null,
            _downloadReadingList,
            (v) => setState(() => _downloadReadingList = v),
          ),

          _section('Penggunaan data'),
          _switch(
            'Unduh hanya melalui Wi-Fi',
            null,
            _wifiOnly,
            (v) => setState(() => _wifiOnly = v),
          ),
          _switch(
            'Tampilkan gambar',
            'Mengaktifkan atau menonaktifkan pemuatan gambar dalam halaman. Hapus centang pengaturan ini jika sambungan Internet Anda lambat, atau jika paket data Anda terbatas.',
            _showImages,
            (v) => setState(() => _showImages = v),
          ),
          _switch(
            'Tampilkan konten luring dahulu',
            'Menghemat penggunaan data dengan memuat artikel yang tersedia secara luring daripada selalu memuat versi terbaru artikel',
            _offlineFirst,
            (v) => setState(() => _offlineFirst = v),
          ),

          _section('Tentang'),
          ListTile(
            title: const Text('Tentang aplikasi WikiiPiye'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutScreen()),
            ),
          ),
          _external('Kirim saran untuk aplikasi'),
          _external('Pertanyaan Umum'),
          _external('Kebijakan privasi'),
          _external('Ketentuan penggunaan'),
          _external('Kontak hukum dan keselamatan'),

          _section('Akun'),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.person, size: 32),
            title: Text(widget.username),
            trailing: TextButton(
              onPressed: () => _confirm(
                'Keluar log?',
                'Anda akan keluar dari akun ${widget.username}.',
                'Keluar',
              ),
              child: const Text(
                'Keluar log',
                style: TextStyle(color: _red, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_remove, color: _red),
            title: const Text(
              'Hilangkan akun',
              style: TextStyle(color: _red, fontWeight: FontWeight.w600),
            ),
            onTap: () => _confirm(
              'Hilangkan akun?',
              'Akun ${widget.username} akan dihilangkan dari perangkat ini.',
              'Hilangkan',
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ---------- komponen kecil ----------

  Widget _section(String text) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 28, 16, 4),
    child: Text(
      text,
      style: const TextStyle(
        color: _blue,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    ),
  );

  Widget _switch(
    String title,
    String? subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) => SwitchListTile(
    title: Text(title),
    subtitle: subtitle == null ? null : Text(subtitle),
    value: value,
    onChanged: onChanged,
  );

  Widget _external(String title) => ListTile(
    title: Text(title),
    trailing: const Icon(Icons.open_in_new),
    onTap: _soon,
  );

  // ---------- aksi ----------

  void _soon() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Fitur ini belum tersedia')));
  }

  Future<void> _pickTheme() {
    return showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Tema aplikasi'),
        children: [
          for (final name in const ['Terang', 'Gelap', 'Ikuti sistem'])
            ListTile(
              leading: Icon(
                name == _theme
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
              ),
              title: Text(name),
              onTap: () {
                setState(() => _theme = name);
                Navigator.pop(ctx);
              },
            ),
        ],
      ),
    );
  }

  Future<void> _confirm(String title, String message, String action) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: sambungkan ke logika login / hapus data dari tim
            },
            child: Text(action),
          ),
        ],
      ),
    );
  }
}
