import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klinik_uad/services/pin_service.dart';
import 'package:klinik_uad/services/secure_storage_service.dart';

class _UnavailableStorage extends SecureStorageService {
  bool failRead = false;
  bool failWrite = false;

  @override
  Future<String?> read(String key) {
    if (failRead) throw PlatformException(code: 'storage-unavailable');
    return super.read(key);
  }

  @override
  Future<void> write(String key, String value) {
    if (failWrite) throw PlatformException(code: 'storage-unavailable');
    return super.write(key, value);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('PinService Security Tests', () {
    late PinService pinService;

    setUp(() {
      FlutterSecureStorage.setMockInitialValues({});
      pinService = PinService();
    });

    test('generateSalt menghasilkan 16 bytes unik', () {
      final salt1 = pinService.generateSalt();
      final salt2 = pinService.generateSalt();

      expect(salt1.length, equals(16));
      expect(salt2.length, equals(16));
      expect(salt1, isNot(equals(salt2)));
    });

    test('hashPin menghasilkan hash dan salt Base64 yang valid', () async {
      final result = await pinService.hashPin('8246');

      expect(result.hashBase64.isNotEmpty, isTrue);
      expect(result.saltBase64.isNotEmpty, isTrue);
    });

    test(
      'verifyPin berhasil untuk PIN yang benar dan gagal untuk PIN salah',
      () async {
        const originalPin = '8246';
        const wrongPin = '0000';

        final result = await pinService.hashPin(originalPin);

        final isValid = await pinService.verifyPin(
          originalPin,
          result.hashBase64,
          result.saltBase64,
        );
        expect(isValid, isTrue);

        final isInvalid = await pinService.verifyPin(
          wrongPin,
          result.hashBase64,
          result.saltBase64,
        );
        expect(isInvalid, isFalse);
      },
    );

    test('constantTimeEquals memeriksa kesamaan byte secara tepat', () {
      final a = [1, 2, 3, 4];
      final b = [1, 2, 3, 4];
      final c = [1, 2, 3, 5];
      final d = [1, 2, 3];

      expect(PinService.constantTimeEquals(a, b), isTrue);
      expect(PinService.constantTimeEquals(a, c), isFalse);
      expect(PinService.constantTimeEquals(a, d), isFalse);
    });

    test(
      'PIN lama main tetap berlaku lalu hash ditingkatkan tanpa reset',
      () async {
        final storage = SecureStorageService();
        final salt = List<int>.generate(16, (i) => i);
        final key = await Pbkdf2(
          macAlgorithm: Hmac.sha256(),
          iterations: 10000,
          bits: 256,
        ).deriveKey(secretKey: SecretKey(utf8.encode('8246')), nonce: salt);
        final legacyHash = base64Encode(await key.extractBytes());
        await storage.savePinData(hash: legacyHash, salt: base64Encode(salt));
        expect(await pinService.isPinEnabled(), isTrue);
        await expectLater(pinService.setupNewPin('7319'), throwsStateError);
        expect(await pinService.validateStoredPin('0000'), isFalse);
        expect(await pinService.validateStoredPin('8246'), isTrue);
        final record = jsonDecode((await storage.read(PinService.storageKey))!);
        expect(record['iterations'], 120000);
        expect(record['hash'], isNot(legacyHash));
        expect(await storage.getPinHash(), isNull);
        expect(await storage.getPinSalt(), isNull);
        expect(await PinService().validateStoredPin('8246'), isTrue);
      },
    );

    test(
      'record branch lama terbaca dan lockout bertahan setelah reopen',
      () async {
        final storage = SecureStorageService();
        final hash = await pinService.hashPin('8246');
        await storage.write(
          PinService.storageKey,
          jsonEncode({
            'version': 1,
            'hash': hash.hashBase64,
            'salt': hash.saltBase64,
            'attempts': 4,
            'lockedUntil': 0,
          }),
        );
        var now = DateTime.utc(2026, 10, 29);
        pinService = PinService(now: () => now);
        await expectLater(
          pinService.validateStoredPin('0000'),
          throwsA(isA<PinLockedException>()),
        );
        final reopened = PinService(now: () => now);
        await expectLater(
          reopened.validateStoredPin('8246'),
          throwsA(isA<PinLockedException>()),
        );
        now = now.add(const Duration(seconds: 31));
        expect(await reopened.validateStoredPin('8246'), isTrue);
      },
    );

    test(
      'format lama tidak lengkap atau record rusak tidak membuka setup',
      () async {
        final storage = SecureStorageService();
        await storage.write('user_pin_hash', 'incomplete');
        await expectLater(pinService.isPinEnabled(), throwsFormatException);
        await expectLater(
          pinService.setupNewPin('8246'),
          throwsFormatException,
        );
        await storage.write(PinService.storageKey, '{"version":1}');
        await expectLater(
          pinService.validateStoredPin('8246'),
          throwsFormatException,
        );
        expect(await storage.getPinHash(), 'incomplete');
      },
    );

    test('gagal baca/tulis menolak akses dan tidak menghapus PIN', () async {
      final storage = _UnavailableStorage();
      pinService = PinService(storageService: storage);
      await pinService.setupNewPin('8246');
      storage.failRead = true;
      await expectLater(
        pinService.isPinEnabled(),
        throwsA(isA<PlatformException>()),
      );
      storage.failRead = false;
      storage.failWrite = true;
      await expectLater(
        pinService.validateStoredPin('8246'),
        throwsA(isA<PlatformException>()),
      );
      storage.failWrite = false;
      final first = pinService.validateStoredPin('8246');
      await expectLater(pinService.validateStoredPin('0000'), throwsStateError);
      expect(await first, isTrue);
    });

    test(
      'setup validasi empat digit, ganti dan hapus meminta PIN lama',
      () async {
        await expectLater(pinService.setupNewPin('12x4'), throwsArgumentError);
        await pinService.setupNewPin('8246');
        await expectLater(
          pinService.changePin('0000', '7319'),
          throwsStateError,
        );
        await pinService.changePin('8246', '7319');
        expect(await pinService.validateStoredPin('7319'), isTrue);
        await expectLater(pinService.removePin('0000'), throwsStateError);
        await pinService.removePin('7319');
        expect(await pinService.isPinEnabled(), isFalse);
      },
    );
  });
}
