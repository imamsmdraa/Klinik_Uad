class ClinicAppointment {
  final String id;
  final String patientName;
  final String studentId;
  final String clinicType;
  final String doctorName;
  final String queueNumber;
  final DateTime appointmentDate;
  final String status;
  final DateTime createdAt;

  const ClinicAppointment({
    required this.id,
    required this.patientName,
    required this.studentId,
    required this.clinicType,
    required this.doctorName,
    required this.queueNumber,
    required this.appointmentDate,
    this.status = 'menunggu',
    required this.createdAt,
  });

  ClinicAppointment copyWith({
    String? id,
    String? patientName,
    String? studentId,
    String? clinicType,
    String? doctorName,
    String? queueNumber,
    DateTime? appointmentDate,
    String? status,
    DateTime? createdAt,
  }) {
    return ClinicAppointment(
      id: id ?? this.id,
      patientName: patientName ?? this.patientName,
      studentId: studentId ?? this.studentId,
      clinicType: clinicType ?? this.clinicType,
      doctorName: doctorName ?? this.doctorName,
      queueNumber: queueNumber ?? this.queueNumber,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientName': patientName,
      'studentId': studentId,
      'clinicType': clinicType,
      'doctorName': doctorName,
      'queueNumber': queueNumber,
      'appointmentDate': appointmentDate.toIso8601String(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ClinicAppointment.fromJson(Map<String, dynamic> json) {
    return ClinicAppointment(
      id: json['id'] as String,
      patientName: json['patientName'] as String,
      studentId: json['studentId'] as String,
      clinicType: json['clinicType'] as String,
      doctorName: json['doctorName'] as String,
      queueNumber: json['queueNumber'] as String,
      appointmentDate: DateTime.parse(json['appointmentDate'] as String),
      status: json['status'] as String? ?? 'menunggu',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
