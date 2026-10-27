import 'package:flutter_test/flutter_test.dart';
import 'package:klinik_uad/services/pin_service.dart';

void main() {
  group('PinService Security Tests', () {
    late PinService pinService;

    setUp(() {
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
      final result = await pinService.hashPin('123456');

      expect(result.hashBase64.isNotEmpty, isTrue);
      expect(result.saltBase64.isNotEmpty, isTrue);
    });

    test('verifyPin berhasil untuk PIN yang benar dan gagal untuk PIN salah', () async {
      const originalPin = '654321';
      const wrongPin = '123456';

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
    });

    test('constantTimeEquals memeriksa kesamaan byte secara tepat', () {
      final a = [1, 2, 3, 4];
      final b = [1, 2, 3, 4];
      final c = [1, 2, 3, 5];
      final d = [1, 2, 3];

      expect(PinService.constantTimeEquals(a, b), isTrue);
      expect(PinService.constantTimeEquals(a, c), isFalse);
      expect(PinService.constantTimeEquals(a, d), isFalse);
    });
  });
}
