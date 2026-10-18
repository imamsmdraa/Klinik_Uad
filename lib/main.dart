import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/app_theme.dart';
import 'routes/app_router.dart';

void main() {
  runApp(const ProviderScope(child: KlinikUadApp()));
}

class KlinikUadApp extends StatelessWidget {
  const KlinikUadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klinik UAD',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: AppRouter.home,
      routes: AppRouter.routes,
    );
  }
}

/// Compatibility alias for the default Flutter template entry point.
class MyApp extends KlinikUadApp {
  const MyApp({super.key});
}
