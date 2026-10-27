import '../models/clinic_appointment.dart';

/// Kontrak abstraksi data layanan klinik.
/// Memungkinkan UI tetap independen dari sumber data nyata (Clean Architecture).
abstract class ClinicRepository {
  Future<List<ClinicAppointment>> getAppointments();
  Future<ClinicAppointment?> getAppointmentById(String id);
  Future<ClinicAppointment> createAppointment(ClinicAppointment appointment);
  Future<bool> updateAppointmentStatus(String id, String status);
  Future<String> getCurrentQueueNumber(String clinicType);
}

/// Implementasi in-memory repository untuk fase M01 (data sintetis lokal).
class InMemoryClinicRepository implements ClinicRepository {
  final List<ClinicAppointment> _items = [];

  InMemoryClinicRepository() {
    _seedInitialData();
  }

  void _seedInitialData() {
    final now = DateTime.now();
    _items.addAll([
      ClinicAppointment(
        id: 'apt-001',
        patientName: 'Naufal Adna Garibaldi',
        studentId: '2311016061',
        clinicType: 'Poli Umum',
        doctorName: 'dr. Hendra Pratama, Sp.PD',
        queueNumber: 'A-005',
        appointmentDate: now,
        status: 'menunggu',
        createdAt: now.subtract(const Duration(minutes: 30)),
      ),
      ClinicAppointment(
        id: 'apt-002',
        patientName: 'Sagara Imam Samudra',
        studentId: '2300016062',
        clinicType: 'Poli Gigi',
        doctorName: 'drg. Annisa Rahmawati',
        queueNumber: 'B-002',
        appointmentDate: now,
        status: 'selesai',
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
    ]);
  }

  @override
  Future<List<ClinicAppointment>> getAppointments() async {
    // Simulasi delay jaringan lokal
    await Future.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(_items);
  }

  @override
  Future<ClinicAppointment?> getAppointmentById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      return _items.firstWhere((element) => element.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ClinicAppointment> createAppointment(ClinicAppointment appointment) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _items.insert(0, appointment);
    return appointment;
  }

  @override
  Future<bool> updateAppointmentStatus(String id, String status) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final index = _items.indexWhere((element) => element.id == id);
    if (index == -1) return false;

    _items[index] = _items[index].copyWith(status: status);
    return true;
  }

  @override
  Future<String> getCurrentQueueNumber(String clinicType) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final matching = _items.where((e) => e.clinicType == clinicType && e.status == 'dilayani');
    if (matching.isNotEmpty) {
      return matching.first.queueNumber;
    }
    return clinicType.contains('Gigi') ? 'B-001' : 'A-004';
  }
}
