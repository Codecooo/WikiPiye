import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(title: const Text('Selebihnya', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)), automaticallyImplyLeading: false),
    body: ListView(children: const [
      ListTile(leading: Icon(Icons.public), title: Text('Places'), subtitle: Text('Jelajahi artikel berdasarkan tempat')),
      Divider(height: 1),
      ListTile(leading: Icon(Icons.settings_outlined), title: Text('Pengaturan')),
      Divider(height: 1),
      ListTile(leading: Icon(Icons.translate), title: Text('Bahasa'), subtitle: Text('Indonesia')),
      Divider(height: 1),
      ListTile(leading: Icon(Icons.info_outline), title: Text('Tentang WikiiPiye')),
    ]),
  );
}
