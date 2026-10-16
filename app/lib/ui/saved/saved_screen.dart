import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});
  @override
  Widget build(BuildContext context) => const _SimplePage(title: 'Tersimpan', icon: Icons.bookmark_border, message: 'Artikel yang kamu simpan akan muncul di sini.');
}

class _SimplePage extends StatelessWidget {
  const _SimplePage({required this.title, required this.icon, required this.message});
  final String title;
  final IconData icon;
  final String message;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(title: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)), automaticallyImplyLeading: false),
    body: Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 54, color: const Color(0xFF72777D)), const SizedBox(height: 18), Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Color(0xFF54595D), height: 1.4))]))),
  );
}
