import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/app_theme.dart';
import 'routes/app_router.dart';
import 'services/pin_service.dart';
import 'services/secure_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set default PIN (1234) only if no PIN has been stored yet.
  final storage = SecureStorageService();
  final existingHash = await storage.getPinHash();
  if (existingHash == null) {
    await PinService().setupNewPin('1234');
  }
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
      themeMode: ThemeMode.light,
      initialRoute: AppRouter.intro,
      routes: AppRouter.routes,
    );
  }
}

/// Compatibility alias for the default Flutter template entry point.
class MyApp extends KlinikUadApp {
  const MyApp({super.key});
}
