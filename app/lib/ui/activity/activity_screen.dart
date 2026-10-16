import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(title: const Text('Aktivitas', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)), automaticallyImplyLeading: false),
    body: const Center(child: Padding(padding: EdgeInsets.all(30), child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.history, size: 54, color: Color(0xFF72777D)), SizedBox(height: 18), Text('Artikel yang baru kamu baca akan muncul di sini.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Color(0xFF54595D), height: 1.4))]))),
  );
}
