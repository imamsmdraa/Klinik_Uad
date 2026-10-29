import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/in_memory_medical_record_repository.dart';
import '../repositories/medical_record_repository.dart';
import '../services/pin_service.dart';
import '../services/secure_storage_service.dart';

final medicalRecordRepositoryProvider = Provider<MedicalRecordRepository>(
  (_) => InMemoryMedicalRecordRepository(),
);
final secureStorageProvider = Provider((_) => SecureStorageService());
final pinServiceProvider = Provider(
  (ref) => PinService(storageService: ref.watch(secureStorageProvider)),
);
