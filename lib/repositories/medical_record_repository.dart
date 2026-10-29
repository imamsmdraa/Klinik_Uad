import '../models/medical_record.dart';

abstract class MedicalRecordRepository {
  Future<List<MedicalRecord>> getAll();
  Future<void> add(MedicalRecord record);
  Future<void> update(MedicalRecord record);
  Future<void> remove(String id);
  Future<void> clear();
}
