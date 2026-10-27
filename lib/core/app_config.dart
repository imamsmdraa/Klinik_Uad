/// Konfigurasi lingkungan aplikasi dan saklar mode (data simulasi vs remote API).
/// Menggunakan parameter --dart-define saat build atau run.
enum AppEnvironment { dev, staging, prod }

abstract final class AppConfig {
  static const String appName = 'Klinik UAD';
  static const String appVersion = '1.0.0';

  /// Saklar mode data:
  /// false = menggunakan data sintetis lokal (In-Memory / SQLite)
  /// true = terhubung ke server remote (Supabase / REST API)
  static const bool useRemote = bool.fromEnvironment(
    'USE_REMOTE',
    defaultValue: false,
  );

  /// Nama environment: 'dev', 'staging', atau 'prod'
  static const String environmentName = String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );

  /// Alamat URL API backend
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.klinik.uad.ac.id/v1',
  );

  /// Status environment saat ini
  static AppEnvironment get environment {
    switch (environmentName.toLowerCase()) {
      case 'prod':
      case 'production':
        return AppEnvironment.prod;
      case 'staging':
        return AppEnvironment.staging;
      default:
        return AppEnvironment.dev;
    }
  }

  static bool get isDev => environment == AppEnvironment.dev;
  static bool get isStaging => environment == AppEnvironment.staging;
  static bool get isProd => environment == AppEnvironment.prod;
}
