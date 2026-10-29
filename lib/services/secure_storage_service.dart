import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Layanan penyimpanan kredensial dan data sensitif lokal (Android Keystore / iOS Keychain).
/// Perlindungan platform tidak menjamin keamanan perangkat yang sudah dikuasai penyerang.
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(resetOnError: false),
          );

  /// Menyimpan pasangan key-value secara terenkripsi
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Membaca nilai terenkripsi berdasarkan key
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Menghapus item berdasarkan key
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Menghapus seluruh data sensitif (misal saat logout atau reset akun)
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Memeriksa apakah suatu key tersimpan
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  // --- Helper spesifik aplikasi Klinik UAD ---

  static const String _keyAuthToken = 'auth_token';
  static const String _keyUserPinHash = 'user_pin_hash';
  static const String _keyUserPinSalt = 'user_pin_salt';
  static const String _keyPrivacyConsent = 'privacy_consent_accepted';

  Future<void> saveAuthToken(String token) async => write(_keyAuthToken, token);
  Future<String?> getAuthToken() async => read(_keyAuthToken);

  Future<void> savePinData({required String hash, required String salt}) async {
    await write(_keyUserPinHash, hash);
    await write(_keyUserPinSalt, salt);
  }

  Future<String?> getPinHash() async => read(_keyUserPinHash);
  Future<String?> getPinSalt() async => read(_keyUserPinSalt);

  /// Hanya hapus format lama setelah record pengganti berhasil tersimpan.
  Future<void> deleteLegacyPinData() async {
    await delete(_keyUserPinHash);
    await delete(_keyUserPinSalt);
  }

  Future<void> savePrivacyConsent(bool accepted) async {
    await write(_keyPrivacyConsent, accepted.toString());
  }

  Future<bool> isPrivacyConsentAccepted() async {
    final value = await read(_keyPrivacyConsent);
    return value == 'true';
  }
}
