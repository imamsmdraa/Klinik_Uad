import 'dart:convert';
import 'dart:math';
import 'package:cryptography/cryptography.dart';
import 'secure_storage_service.dart';

/// Hasil hashing PIN mencakup nilai hash dan salt acak dalam format Base64.
class PinHashResult {
  final String hashBase64;
  final String saltBase64;

  const PinHashResult({
    required this.hashBase64,
    required this.saltBase64,
  });
}

/// Layanan keamanan autentikasi PIN Rekam Medis.
/// Menggunakan algoritma PBKDF2-HMAC-SHA256 dengan 10.000 iterasi
/// dan perbandingan constant-time untuk mencegah serangan timing attacks.
class PinService {
  final SecureStorageService _storageService;
  final Pbkdf2 _pbkdf2;

  PinService({SecureStorageService? storageService})
      : _storageService = storageService ?? SecureStorageService(),
        _pbkdf2 = Pbkdf2(
          macAlgorithm: Hmac.sha256(),
          iterations: 10000,
          bits: 256,
        );

  /// Menghasilkan 16-byte salt acak berbasis cryptographic PRNG
  List<int> generateSalt([int length = 16]) {
    final random = Random.secure();
    return List<int>.generate(length, (_) => random.nextInt(256));
  }

  /// Melakukan hashing PIN dengan salt menggunakan PBKDF2
  Future<PinHashResult> hashPin(String pin, {List<int>? salt}) async {
    final saltBytes = salt ?? generateSalt(16);
    final secretKey = SecretKey(utf8.encode(pin));

    final derivedKey = await _pbkdf2.deriveKey(
      secretKey: secretKey,
      nonce: saltBytes,
    );

    final keyBytes = await derivedKey.extractBytes();

    return PinHashResult(
      hashBase64: base64Encode(keyBytes),
      saltBase64: base64Encode(saltBytes),
    );
  }

  /// Memverifikasi PIN yang dimasukkan dengan hash dan salt yang tersimpan.
  /// Menggunakan perbandingan Constant-Time.
  Future<bool> verifyPin(String pin, String expectedHashBase64, String saltBase64) async {
    final saltBytes = base64Decode(saltBase64);
    final expectedBytes = base64Decode(expectedHashBase64);

    final result = await hashPin(pin, salt: saltBytes);
    final actualBytes = base64Decode(result.hashBase64);

    return constantTimeEquals(actualBytes, expectedBytes);
  }

  /// Menyimpan PIN baru secara aman ke Secure Storage
  Future<void> setupNewPin(String pin) async {
    final result = await hashPin(pin);
    await _storageService.savePinData(
      hash: result.hashBase64,
      salt: result.saltBase64,
    );
  }

  /// Memvalidasi PIN terhadap data yang tersimpan di Secure Storage
  Future<bool> validateStoredPin(String pin) async {
    final hash = await _storageService.getPinHash();
    final salt = await _storageService.getPinSalt();

    if (hash == null || salt == null) {
      return false;
    }

    return await verifyPin(pin, hash, salt);
  }

  /// Perbandingan dua byte array dengan waktu konstan (Constant-Time Comparison).
  /// Mencegah penyerang menebak PIN berdasarkan selisih waktu eksekusi CPU.
  static bool constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) {
      return false;
    }

    int result = 0;
    for (int i = 0; i < a.length; i++) {
      result |= a[i] ^ b[i];
    }

    return result == 0;
  }
}
