import '../models/medical_record.dart';
import 'medical_record_repository.dart';

class InMemoryMedicalRecordRepository implements MedicalRecordRepository {
  InMemoryMedicalRecordRepository({Iterable<MedicalRecord>? seed}) {
    for (final record in seed ?? _demoRecords) {
      if (_items.containsKey(record.id)) throw StateError('ID duplikat.');
      _items[record.id] = record;
    }
  }

  // ponytail: synthetic M01 fixtures only; add encrypted persistence and per-user scope in M04/M05.
  final _items = <String, MedicalRecord>{};

  @override
  Future<List<MedicalRecord>> getAll() async =>
      List.unmodifiable(_items.values);

  @override
  Future<void> add(MedicalRecord record) async {
    if (_items.containsKey(record.id)) throw StateError('ID sudah ada.');
    _items[record.id] = record;
  }

  @override
  Future<void> update(MedicalRecord record) async {
    if (!_items.containsKey(record.id)) throw StateError('ID tidak ditemukan.');
    _items[record.id] = record;
  }

  @override
  Future<void> remove(String id) async {
    if (id.trim().isEmpty) throw ArgumentError('ID wajib diisi.');
    _items.remove(id);
  }

  @override
  Future<void> clear() async => _items.clear();
}

final _demoRecords = [
  MedicalRecord(
    id: 'REC-2026-004',
    date: '12 Okt 2026',
    clinic: 'Poli Umum',
    doctor: 'dr. Alya Rahman',
    diagnosis: 'Faringitis Akut (J02.9)',
    symptoms: 'Nyeri menelan, demam 38°C, tenggorokan merah sejak 2 hari.',
    vitalSigns: 'TD: 118/76 mmHg · Suhu: 38.0°C · Nadi: 84 bpm · RR: 18x/m',
    prescriptions: [
      'Amoxicillin 500 mg (3x1 sesudah makan - 5 hari)',
      'Paracetamol 500 mg (3x1 bila demam)',
      'Vitamin C 500 mg (1x1 sesudah makan)',
    ],
    labResults: 'Rapid Antigen Negatif · Leukosit dalam batas wajar',
    status: 'Selesai',
  ),
  MedicalRecord(
    id: 'REC-2026-003',
    date: '15 Sep 2026',
    clinic: 'Poli Gigi',
    doctor: 'drg. Dimas Prasetyo, Sp.KG',
    diagnosis: 'Pembersihan Karang Gigi / Scaling (K03.6)',
    symptoms:
        'Pemeriksaan rutin semesteran, gusi mudah berdarah saat sikat gigi.',
    vitalSigns: 'TD: 120/80 mmHg · Suhu: 36.5°C · Nadi: 76 bpm',
    prescriptions: [
      'Chlorhexidine Mouthwash 0.2% (2x sehari kumur)',
      'Asam Mefenamat 500 mg (prn bila linu)',
    ],
    labResults: 'Indeks Plak: 18% (Kategori Baik Pasca Pembersihan)',
    status: 'Selesai',
  ),
  MedicalRecord(
    id: 'REC-2026-002',
    date: '28 Mei 2026',
    clinic: 'Poli Umum',
    doctor: 'dr. Hendra Wicaksono, Sp.PD',
    diagnosis: 'Dispepsia Fungsional / Maag (K30)',
    symptoms:
        'Nyeri ulu hati perih, mual di pagi hari, kembung setelah konsumsi kopi.',
    vitalSigns: 'TD: 115/75 mmHg · Suhu: 36.7°C · Nadi: 78 bpm',
    prescriptions: [
      'Omeprazole 20 mg (1x1 sebelum makan pagi)',
      'Antasida Doen Suspensi (3x1 sendok takar 1 jam sebelum makan)',
      'Domperidone 10 mg (3x1 bila mual)',
    ],
    labResults: 'Ureum: 22 mg/dL · Kreatinin: 0.9 mg/dL (Normal)',
    status: 'Selesai',
  ),
];
