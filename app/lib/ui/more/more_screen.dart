import 'package:flutter/material.dart';

import '../settings/settings_screen.dart';
import '../settings/language_screen.dart';
import 'about_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: const Text(
        'Selebihnya',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
      automaticallyImplyLeading: false,
    ),
    body: ListView(
      children: [
        const ListTile(
          leading: Icon(Icons.public),
          title: Text('Places'),
          subtitle: Text('Jelajahi artikel berdasarkan tempat'),
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Pengaturan'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
        const Divider(height: 1),
        ValueListenableBuilder<List<WikiLanguage>>(
          valueListenable: selectedLanguages,
          builder: (context, langs, _) => ListTile(
            leading: const Icon(Icons.translate),
            title: const Text('Bahasa'),
            subtitle: Text(langs.first.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LanguageScreen()),
              );
            },
          ),
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Tentang WikiPiye'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutScreen()),
            );
          },
        ),
      ],
    ),
  );
}
