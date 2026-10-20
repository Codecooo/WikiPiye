import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final _articles = const ['Indonesia', 'Wikipedia', 'Surabaya', 'Kecerdasan buatan', 'Sejarah dunia', 'Sistem informasi'];
  String _query = '';
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final results = _articles.where((e) => e.toLowerCase().contains(_query.toLowerCase())).toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Cari', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)), automaticallyImplyLeading: false),
      body: Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(16, 8, 16, 12), child: TextField(controller: _controller, onChanged: (value) => setState(() => _query = value), decoration: InputDecoration(hintText: 'Cari di WikiiPiye', prefixIcon: const Icon(Icons.search), suffixIcon: _query.isEmpty ? null : IconButton(onPressed: () { _controller.clear(); setState(() => _query = ''); }, icon: const Icon(Icons.close)), filled: true, fillColor: const Color(0xFFF8F9FA), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF72777D))), contentPadding: const EdgeInsets.symmetric(vertical: 12)))),
        Expanded(child: ListView(children: results.map((title) => ListTile(leading: const Icon(Icons.article_outlined, color: Color(0xFF54595D)), title: Text(title), subtitle: const Text('Artikel ensiklopedia'), trailing: const Icon(Icons.chevron_right), onTap: () {})).toList())),
      ]),
    );
  }
}
