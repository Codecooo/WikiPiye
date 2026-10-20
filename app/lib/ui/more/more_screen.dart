import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikipiye/ui/auth/auth_notifier.dart';
import 'package:wikipiye/ui/auth/login_screen.dart';
import 'package:wikipiye/ui/auth/register_screen.dart';

import '../settings/language_screen.dart';
import '../settings/settings_screen.dart';
import 'about_screen.dart';

/// Halaman "Selebihnya" (More) WikiPiye.
/// Memuat profil pengguna, tombol Masuk/Daftar (jika belum login),
/// serta menu navigasi pengaturan dan informasi aplikasi.
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: const Text(
            'Selebihnya',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202122),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: [
            const _AuthMoreCard(),
            const Divider(height: 1),
            const ListTile(
              leading: Icon(Icons.public, color: Color(0xFF202122)),
              title: Text('Places'),
              subtitle: Text('Jelajahi artikel berdasarkan tempat'),
            ),
            const Divider(height: 1),
            ListTile(
              leading:
                  const Icon(Icons.settings_outlined, color: Color(0xFF202122)),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
            const Divider(height: 1),
            ValueListenableBuilder<List<WikiLanguage>>(
              valueListenable: selectedLanguages,
              builder: (context, langs, _) => ListTile(
                leading:
                    const Icon(Icons.translate, color: Color(0xFF202122)),
                title: const Text('Bahasa'),
                subtitle: Text(langs.first.name),
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
            const Divider(height: 1),
            ListTile(
              leading:
                  const Icon(Icons.info_outline, color: Color(0xFF202122)),
              title: const Text('Tentang WikiPiye'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
            const Divider(height: 1),
          ],
        ),
      );
}

// ── Kartu Autentikasi di Selebihnya ──────────────────────────────────────────

class _AuthMoreCard extends ConsumerWidget {
  const _AuthMoreCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    // Kasus 1: Pengguna sudah login
    if (authState is AuthStateAuthenticated) {
      final user = authState.user;
      final initial = user.username.isNotEmpty
          ? user.username[0].toUpperCase()
          : 'U';

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E5E8)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFF202122),
              child: Text(
                initial,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202122),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.email.isNotEmpty ? user.email : user.role,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF54595D),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Color(0xFFB32424),
                size: 22,
              ),
              tooltip: 'Keluar',
              onPressed: () => _showLogoutDialog(context, ref),
            ),
          ],
        ),
      );
    }

    // Kasus 2: Pengguna belum login (Tampilkan tombol Masuk & Buat akun)
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E5E8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFE8ECEF),
                child: Icon(
                  Icons.person_outline,
                  color: Color(0xFF54595D),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Masuk ke WikiPiye',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202122),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Simpan artikel favorit dan sinkronkan riwayat bacaan Anda.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF54595D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: FilledButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF202122), // Tanpa warna biru
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: FilledButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterScreen(),
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFEFEFF2), // Tanpa warna biru
                      foregroundColor: const Color(0xFF202122),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Buat akun',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Keluar dari Akun?',
          style: TextStyle(color: Color(0xFF202122), fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'Anda dapat masuk kembali kapan saja dari halaman Selebihnya.',
          style: TextStyle(color: Color(0xFF54595D)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Batal',
              style: TextStyle(color: Color(0xFF54595D)),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFB32424),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Anda telah keluar dari akun.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}
