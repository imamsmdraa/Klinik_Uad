import 'dart:convert';
import 'dart:math';

import 'package:cryptography/cryptography.dart';

import 'secure_storage_service.dart';

class PinHashResult {
  const PinHashResult({required this.hashBase64, required this.saltBase64});
  final String hashBase64;
  final String saltBase64;
}

class PinLockedException implements Exception {
  const PinLockedException(this.until);
  final DateTime until;
}

class PinService {
  PinService({SecureStorageService? storageService, DateTime Function()? now})
    : _storageService = storageService ?? SecureStorageService(),
      _now = now ?? DateTime.now;

  static const storageKey = 'klinik_pin_v1';
  static const iterations = 120000;
  static const maxAttempts = 5;
  static const lockDuration = Duration(seconds: 30);
  final SecureStorageService _storageService;
  final DateTime Function() _now;
  bool _busy = false;

  Future<T> _exclusive<T>(Future<T> Function() action) async {
    if (_busy) throw StateError('Operasi PIN masih berjalan.');
    _busy = true;
    try {
      return await action();
    } finally {
      _busy = false;
    }
  }

  void _validate(String pin) {
    if (!RegExp(r'^[0-9]{4}$').hasMatch(pin)) {
      throw ArgumentError('PIN harus terdiri dari 4 digit.');
    }
  }

  List<int> generateSalt([int length = 16]) {
    if (length != 16) throw ArgumentError('Salt harus 16 byte.');
    final random = Random.secure();
    return List<int>.generate(length, (_) => random.nextInt(256));
  }

  Future<PinHashResult> _hash(String pin, List<int> salt, int rounds) async {
    _validate(pin);
    if (salt.length != 16) throw ArgumentError('Salt harus 16 byte.');
    final key = await Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: rounds,
      bits: 256,
    ).deriveKey(secretKey: SecretKey(utf8.encode(pin)), nonce: salt);
    return PinHashResult(
      hashBase64: base64Encode(await key.extractBytes()),
      saltBase64: base64Encode(salt),
    );
  }

  Future<PinHashResult> hashPin(String pin, {List<int>? salt}) =>
      _hash(pin, salt ?? generateSalt(), iterations);

  // Pure KDF helper retained from main; UI uses validateStoredPin for lockout.
  Future<bool> verifyPin(
    String pin,
    String expectedHashBase64,
    String saltBase64,
  ) async {
    final expected = base64Decode(expectedHashBase64);
    if (expected.length != 32) throw const FormatException('Hash tidak valid.');
    final result = await hashPin(pin, salt: base64Decode(saltBase64));
    return constantTimeEquals(base64Decode(result.hashBase64), expected);
  }

  static bool constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var difference = 0;
    for (var i = 0; i < a.length; i++) {
      difference |= a[i] ^ b[i];
    }
    return difference == 0;
  }

  Future<void> _save(Map<String, dynamic> record) =>
      _storageService.write(storageKey, jsonEncode(record));

  Future<Map<String, dynamic>?> _load() async {
    final raw = await _storageService.read(storageKey);
    Map<String, dynamic> record;
    if (raw == null) {
      // Migrate main's two-key / 10,000-round format without resetting the PIN.
      final hash = await _storageService.getPinHash();
      final salt = await _storageService.getPinSalt();
      if (hash == null && salt == null) return null;
      record = {
        'version': 1,
        'hash': hash,
        'salt': salt,
        'iterations': 10000,
        'attempts': 0,
        'lockedUntil': 0,
      };
    } else {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Data PIN tidak valid.');
      }
      record = decoded;
      // The previous baseline record omitted iterations and used 120,000.
      record.putIfAbsent('iterations', () => iterations);
    }
    if (record['version'] != 1 ||
        record['hash'] is! String ||
        record['salt'] is! String ||
        !{10000, iterations}.contains(record['iterations']) ||
        record['attempts'] is! int ||
        record['attempts'] < 0 ||
        record['attempts'] > maxAttempts ||
        record['lockedUntil'] is! int ||
        record['lockedUntil'] < 0 ||
        base64Decode(record['hash'] as String).length != 32 ||
        base64Decode(record['salt'] as String).length != 16 ||
        (record['attempts'] == maxAttempts && record['lockedUntil'] == 0)) {
      throw const FormatException('Data PIN tidak valid.');
    }
    if (raw == null) await _save(record);
    return record;
  }

  Future<Map<String, dynamic>> _newRecord(String pin) async {
    final result = await hashPin(pin);
    return {
      'version': 1,
      'hash': result.hashBase64,
      'salt': result.saltBase64,
      'iterations': iterations,
      'attempts': 0,
      'lockedUntil': 0,
    };
  }

  Future<bool> isPinEnabled() => _exclusive(() async => await _load() != null);

  Future<void> setupNewPin(String pin) => _exclusive(() async {
    _validate(pin);
    if (await _load() != null) throw StateError('PIN sudah ada.');
    await _save(await _newRecord(pin));
  });

  Future<bool> _verify(String pin) async {
    _validate(pin);
    final record = await _load();
    if (record == null) return false;
    final now = _now().millisecondsSinceEpoch;
    final until = record['lockedUntil'] as int;
    if (until > now) {
      throw PinLockedException(DateTime.fromMillisecondsSinceEpoch(until));
    }
    if (until != 0) record['attempts'] = 0;
    // Reserve before hashing so interruption cannot discard the attempt.
    record['attempts'] = (record['attempts'] as int) + 1;
    record['lockedUntil'] = record['attempts'] >= maxAttempts
        ? now + lockDuration.inMilliseconds
        : 0;
    await _save(record);
    final result = await _hash(
      pin,
      base64Decode(record['salt'] as String),
      record['iterations'] as int,
    );
    if (constantTimeEquals(
      base64Decode(result.hashBase64),
      base64Decode(record['hash'] as String),
    )) {
      if (record['iterations'] == iterations) {
        record['attempts'] = 0;
        record['lockedUntil'] = 0;
        await _save(record);
      } else {
        await _save(await _newRecord(pin));
      }
      // Delete legacy hashes only after the replacement record is durable.
      await _storageService.deleteLegacyPinData();
      return true;
    }
    if (record['attempts'] >= maxAttempts) {
      throw PinLockedException(
        DateTime.fromMillisecondsSinceEpoch(record['lockedUntil'] as int),
      );
    }
    return false;
  }

  Future<bool> validateStoredPin(String pin) => _exclusive(() => _verify(pin));

  Future<void> changePin(String currentPin, String newPin) =>
      _exclusive(() async {
        _validate(newPin);
        if (!await _verify(currentPin)) throw StateError('PIN lama salah.');
        await _save(await _newRecord(newPin));
      });

  Future<void> removePin(String currentPin) => _exclusive(() async {
    if (!await _verify(currentPin)) throw StateError('PIN salah.');
    await _storageService.delete(storageKey);
  });
}
