import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart'
    show FlutterQuillLocalizations;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wikipiye/repositories/article_repository.dart';
import 'package:wikipiye/repositories/auth_repository.dart';
import 'package:wikipiye/repositories/saved_repository.dart';
import 'package:wikipiye/services/api_service.dart';

import 'ui/home/home_screen.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DateFormatter memakai locale 'id_ID'; datanya harus dimuat lebih dulu.
  await initializeDateFormatting('id_ID');
  _registerServices();
  runApp(
    ProviderScope(
      // Riverpod 3 mencoba ulang provider yang gagal secara otomatis. Untuk
      // 401/404 itu hanya membuat layar loading terlalu lama, jadi dimatikan.
      retry: (retryCount, error) => null,
      child: const MyApp(),
    ),
  );
}

void _registerServices() {
  getIt.registerSingleton(ApiService());
  getIt.registerSingleton(ArticleRepository(getIt<ApiService>()));
  getIt.registerSingleton(SavedRepository(getIt<ApiService>()));
  getIt.registerSingleton(AuthRepository(getIt<ApiService>()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WikiPiye',
      // flutter_quill (dipakai WikiSectionView) membutuhkan delegate ini.
      localizationsDelegates: FlutterQuillLocalizations.localizationsDelegates,
      supportedLocales: FlutterQuillLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF366B4D)),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}
