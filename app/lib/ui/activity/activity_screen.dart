import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikipiye/ui/activity/viewmodels/activity_viewmodel.dart';

/// Tab Aktivitas (berdiri sendiri, tidak butuh file lain).
class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key, this.username = 'User123'});

  /// Nama pengguna yang ditampilkan di bagian atas.
  final String username;

  static const _blue = Color(0xFF3366CC);
  static const _ink = Color(0xFF202122);
  static const _muted = Color(0xFF54595D);

  static void _soon(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Fitur ini belum tersedia')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(activityViewmodelProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _topSection(context),
            _impactSection(context),
            _todaySection(),
          ],
        ),
      ),
    );
  }

  // ---------- Bagian atas: sedang membaca ----------

  Widget _topSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFFEAF1FF)],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 36),
      child: Column(
        children: [
          Text(
            '$username sedang membaca',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFDDE8FB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'DI WIKIPIYE',
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600,
                color: _ink,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFFD9531E), Color(0xFFFFC107), Color(0xFF9FB4D9)],
            ).createShader(bounds),
            child: const Text(
              '0j 0m',
              style: TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Waktu yang dihabiskan untuk membaca minggu ini',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _ink,
            ),
          ),
          const SizedBox(height: 28),
          _StatCard(
            icon: Icons.bar_chart,
            title: 'Artikel yang dibaca bulan ini',
            value: '0',
            showDashes: true,
            onTap: () => _soon(context),
          ),
          const SizedBox(height: 16),
          _StatCard(
            icon: Icons.bookmark_border,
            title: 'Artikel yang disimpan bulan ini',
            value: '0',
            onTap: () => _soon(context),
          ),
          const SizedBox(height: 32),
          const Text(
            'Mencari sesuatu yang baru untuk dibaca?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _ink,
            ),
          ),
          const SizedBox(height: 16),
          _pillButton('Temukan melalui Wikipedia', null, () => _soon(context)),
        ],
      ),
    );
  }

  // ---------- Bagian dampak ----------

  Widget _impactSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFFEAF1FF)],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Dampak Anda',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: _ink, width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'ID',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => _soon(context),
                  child: const Row(
                    children: [
                      Icon(Icons.format_list_bulleted, size: 24),
                      SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          'Kontribusi bulan ini',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(Icons.chevron_right, size: 30, color: _muted),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const _CountLine('0', 'suntingan bulan ini'),
                const SizedBox(height: 12),
                const _CountLine('0', 'suntingan bulan lalu'),
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    '0 suntingan pada artikel baru-baru ini',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Sepertinya Anda belum melakukan penyuntingan bulan ini. '
                    'Perluas pengetahuan gratis ini dengan menyunting topik '
                    'yang menarik minat Anda.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: _pillButton(
                    'Lakukan suntingan',
                    Icons.edit,
                    () => _soon(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _card(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dampak sepanjang masa',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _ImpactItem(
                            icon: Icons.edit,
                            value: '0',
                            label: 'total suntingan',
                          ),
                          SizedBox(height: 20),
                          _ImpactItem(
                            icon: Icons.chat_bubble,
                            value: '0',
                            label: 'terima kasih',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          _ImpactItem(
                            icon: Icons.star,
                            value: '-',
                            label: 'rekor terbaik',
                            circle: true,
                          ),
                          SizedBox(height: 20),
                          _ImpactItem(
                            icon: Icons.update,
                            value: '-',
                            label: 'terakhir diubah',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _StatCard(
            icon: Icons.public,
            title: 'Total suntingan di seluruh proyek',
            value: '0',
            onTap: () => _soon(context),
          ),
        ],
      ),
    );
  }

  // ---------- Bagian hari ini ----------

  Widget _todaySection() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hari ini',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
          const SizedBox(height: 56),
          const Center(child: _EmptyIllustration()),
          const SizedBox(height: 28),
          const Center(
            child: Text(
              'Tidak ada yang bisa ditunjukkan',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Mulailah membaca dan menyunting untuk membangun riwayat Anda.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- komponen bersama ----------

  static Widget _card({required Widget child}) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: const Color(0xFFE1E4E8)),
    ),
    child: child,
  );

  static Widget _pillButton(
    String label,
    IconData? icon,
    VoidCallback onPressed,
  ) {
    final style = FilledButton.styleFrom(
      backgroundColor: _blue,
      foregroundColor: Colors.white,
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
    );
    if (icon == null) {
      return FilledButton(
        style: style,
        onPressed: onPressed,
        child: Text(label),
      );
    }
    return FilledButton.icon(
      style: style,
      onPressed: onPressed,
      icon: Icon(icon, size: 22),
      label: Text(label),
    );
  }
}

/// Kartu statistik dengan ikon, judul, tanda panah, dan angka besar.
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
    this.showDashes = false,
  });

  final IconData icon;
  final String title;
  final String value;
  final bool showDashes;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: Color(0xFFE1E4E8)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 24),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 30,
                    color: Color(0xFF54595D),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  if (showDashes)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          for (var i = 0; i < 4; i++)
                            Container(
                              width: 36,
                              height: 8,
                              margin: EdgeInsets.only(left: i == 0 ? 0 : 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFC8CCD1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Baris "0  suntingan bulan ini".
class _CountLine extends StatelessWidget {
  const _CountLine(this.value, this.label);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 14),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF54595D),
          ),
        ),
      ],
    );
  }
}

/// Satu item di kartu "Dampak sepanjang masa".
class _ImpactItem extends StatelessWidget {
  const _ImpactItem({
    required this.icon,
    required this.value,
    required this.label,
    this.circle = false,
  });

  final IconData icon;
  final String value;
  final String label;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF3366CC);
    return Row(
      children: [
        SizedBox(
          width: 44,
          child: circle
              ? Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                )
              : Icon(icon, color: blue, size: 36),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Ilustrasi sederhana untuk keadaan kosong (dokumen + jam).
class _EmptyIllustration extends StatelessWidget {
  const _EmptyIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 130,
              height: 170,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF3FB),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.article_outlined,
                size: 80,
                color: Color(0xFFB6CBF2),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 62,
              height: 62,
              decoration: const BoxDecoration(
                color: Color(0xFF5B8DEF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.access_time,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
