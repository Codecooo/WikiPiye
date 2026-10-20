import 'package:flutter/material.dart';

/// Data satu bahasa Wikipedia.
class WikiLanguage {
  const WikiLanguage(this.code, this.badge, this.name);
  final String code;
  final String badge; // tulisan di kotak kecil, mis. "ID"
  final String name;
}

/// Semua bahasa yang bisa ditambahkan lewat tombol "Tambah bahasa".
const allWikiLanguages = <WikiLanguage>[
  WikiLanguage('id', 'ID', 'Bahasa Indonesia'),
  WikiLanguage('en', 'EN', 'English'),
  WikiLanguage('ja', 'JA', '日本語'),
  WikiLanguage('zh-cn', 'ZH-CN', '中文（中国大陆）'),
  WikiLanguage('zh-tw', 'ZH-TW', '中文（臺灣）'),
  WikiLanguage('arz', 'ARZ', 'مصرى'),
  WikiLanguage('ms', 'MS', 'Bahasa Melayu'),
  WikiLanguage('jv', 'JV', 'Basa Jawa'),
  WikiLanguage('su', 'SU', 'Basa Sunda'),
  WikiLanguage('fr', 'FR', 'Français'),
  WikiLanguage('de', 'DE', 'Deutsch'),
  WikiLanguage('es', 'ES', 'Español'),
  WikiLanguage('ko', 'KO', '한국어'),
];

/// Bahasa yang dipilih. Awalnya hanya Bahasa Indonesia.
/// (Supaya sama seperti screenshot, isi dengan 6 bahasa pertama:
///  allWikiLanguages.sublist(0, 6))
final ValueNotifier<List<WikiLanguage>> selectedLanguages =
    ValueNotifier<List<WikiLanguage>>([allWikiLanguages.first]);

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  static const _blue = Color(0xFF3366CC);
  static const _grey = Color(0xFF72777D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Bahasa Wikipedia',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (_) =>
                selectedLanguages.value = [allWikiLanguages.first],
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'reset', child: Text('Atur ulang bahasa')),
            ],
          ),
        ],
      ),
      body: ValueListenableBuilder<List<WikiLanguage>>(
        valueListenable: selectedLanguages,
        builder: (context, langs, _) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'Bahasa Anda',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                buildDefaultDragHandles: false,
                itemCount: langs.length,
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final list = [...langs];
                  final item = list.removeAt(oldIndex);
                  list.insert(newIndex, item);
                  selectedLanguages.value = list;
                },
                itemBuilder: (context, index) => _row(context, index, langs),
              ),
              InkWell(
                onTap: () => _addLanguage(context),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(20, 16, 16, 16),
                  child: Row(
                    children: [
                      Icon(Icons.add, color: _blue, size: 28),
                      SizedBox(width: 28),
                      Text(
                        'Tambah bahasa',
                        style: TextStyle(
                          color: _blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(BuildContext context, int index, List<WikiLanguage> langs) {
    final lang = langs[index];
    return Dismissible(
      key: ValueKey(lang.code),
      direction: DismissDirection.endToStart,
      background: Container(
        color: const Color(0xFFFDECEA),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_outline, color: Color(0xFFB32424)),
      ),
      confirmDismiss: (_) async {
        if (selectedLanguages.value.length <= 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Minimal satu bahasa harus dipilih')),
          );
          return false;
        }
        return true;
      },
      onDismissed: (_) {
        selectedLanguages.value = selectedLanguages.value
            .where((l) => l != lang)
            .toList();
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 56,
              child: Text(
                '${index + 1}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: _grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _Badge(lang.badge),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                lang.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ReorderableDragStartListener(
              index: index,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Icon(Icons.unfold_more, color: _grey, size: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addLanguage(BuildContext context) {
    final remaining = allWikiLanguages
        .where((l) => !selectedLanguages.value.contains(l))
        .toList();
    if (remaining.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua bahasa sudah ditambahkan')),
      );
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Tambah bahasa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            for (final l in remaining)
              ListTile(
                leading: _Badge(l.badge),
                title: Text(l.name),
                onTap: () {
                  selectedLanguages.value = [...selectedLanguages.value, l];
                  Navigator.pop(ctx);
                },
              ),
          ],
        ),
      ),
    );
  }
}

/// Kotak kecil berisi kode bahasa (ID, EN, ...).
class _Badge extends StatelessWidget {
  const _Badge(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Container(
    width: 48,
    height: 44,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF72777D), width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    child: FittedBox(
      fit: BoxFit.scaleDown,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF54595D),
          ),
        ),
      ),
    ),
  );
}
