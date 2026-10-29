class MedicalRecord {
  MedicalRecord({
    required this.id,
    required this.date,
    required this.clinic,
    required this.doctor,
    required this.diagnosis,
    required this.symptoms,
    required this.vitalSigns,
    required List<String> prescriptions,
    required this.labResults,
    required this.status,
  }) : prescriptions = List.unmodifiable(prescriptions) {
    if (id.trim().isEmpty) throw ArgumentError('ID rekam medis wajib diisi.');
  }

  final String id;
  // ponytail: M01 retains display dates; introduce structured dates with the M02 schema.
  final String date;
  final String clinic;
  final String doctor;
  final String diagnosis;
  final String symptoms;
  final String vitalSigns;
  final List<String> prescriptions;
  final String labResults;
  final String status;
}
