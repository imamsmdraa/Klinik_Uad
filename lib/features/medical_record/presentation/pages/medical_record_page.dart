import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_shadows.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/widgets/app_cards.dart';
import '../../../../shared/widgets/app_dialogs.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/status_badge.dart';

class MedicalRecordPage extends StatefulWidget {
  const MedicalRecordPage({super.key});

  @override
  State<MedicalRecordPage> createState() => _MedicalRecordPageState();
}

class _MedicalRecordPageState extends State<MedicalRecordPage> {
  bool _isUnlocked = false;
  String _pin = '';
  final String _correctPin = '1234';
  String _searchQuery = '';
  String _selectedYear = 'Semua Tahun';

  final List<String> _years = ['Semua Tahun', '2026', '2025', '2024'];

  final List<_MedicalRecordEntry> _records = const [
    _MedicalRecordEntry(
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
    _MedicalRecordEntry(
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
    _MedicalRecordEntry(
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

  void _onKeypadTap(String digit) {
    if (_pin.length < 4) {
      final newPin = _pin + digit;
      setState(() => _pin = newPin);
      if (newPin.length == 4) {
        _verifyPin(newPin);
      }
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  void _verifyPin(String inputPin) {
    if (inputPin == _correctPin) {
      setState(() {
        _isUnlocked = true;
      });
      AppSnackBar.showSuccess(
        context,
        'Rekam medis berhasil dibuka secara aman',
      );
    } else {
      AppSnackBar.showError(context, 'PIN Keamanan salah (Gunakan 1234)');
      setState(() => _pin = '');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isUnlocked) {
      return _buildPinLockScreen();
    }

    final filteredRecords = _records.where((r) {
      final matchesQuery =
          _searchQuery.isEmpty ||
          r.diagnosis.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          r.doctor.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          r.clinic.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesYear =
          _selectedYear == 'Semua Tahun' || r.date.contains(_selectedYear);
      return matchesQuery && matchesYear;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Rekam Medis & EMR'),
        actions: [
          IconButton(
            icon: const Icon(Icons.lock_rounded),
            tooltip: 'Kunci Kembali',
            onPressed: () {
              setState(() {
                _isUnlocked = false;
                _pin = '';
              });
              AppSnackBar.showInfo(context, 'Akses rekam medis telah dikunci');
            },
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_rounded),
            tooltip: 'Unduh EMR',
            onPressed: () {
              AppSnackBar.showSuccess(
                context,
                'Mengunduh resume medis PDF terenkripsi...',
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search & Filter Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Column(
                children: [
                  AppSearchBar(
                    hintText: 'Cari diagnosis, nama dokter, poli...',
                    onChanged: (val) => setState(() => _searchQuery = val),
                    onFilterTap: () {
                      AppSnackBar.showInfo(
                        context,
                        'Filter berdasarkan poli dan tahun',
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _years.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final yr = _years[index];
                        final isSel = _selectedYear == yr;
                        return CategoryPill(
                          label: yr,
                          isSelected: isSel,
                          onTap: () => setState(() => _selectedYear = yr),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Privacy Notice Badge
            Padding(
              padding: AppSpacing.screenPaddingHorizontal,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Data rekam medis terlindungi UU PDP & standar kerahasiaan medis Permenkes No. 24 Tahun 2022.',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Records Timeline List
            Padding(
              padding: AppSpacing.screenPaddingHorizontal,
              child: const SectionHeader(
                title: 'Riwayat Kunjungan Medis',
                subtitle: 'Ringkasan diagnosis, tindakan, dan resep obat',
              ),
            ),
            const SizedBox(height: 12),

            if (filteredRecords.isEmpty)
              Padding(
                padding: const EdgeInsets.all(40),
                child: Center(
                  child: Column(
                    children: const [
                      Icon(
                        Icons.folder_off_outlined,
                        size: 48,
                        color: AppColors.textTertiary,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Tidak ada rekam medis yang sesuai',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: AppSpacing.screenPaddingHorizontal,
                itemCount: filteredRecords.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final rec = filteredRecords[index];
                  return _MedicalRecordCard(entry: rec);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinLockScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Keamanan Rekam Medis'), elevation: 0),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    shape: BoxShape.circle,
                    boxShadow: AppShadows.subtle,
                  ),
                  child: const Icon(
                    Icons.lock_person_rounded,
                    size: 32,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Akses Terenkripsi EMR Pasien',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Masukkan 4 digit PIN keamanan Anda untuk membuka riwayat diagnosis dan resep obat.\n(PIN Demo: 1234)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),

                // PIN Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    final isFilled = index < _pin.length;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: isFilled
                            ? AppColors.primary
                            : AppColors.surfaceVariant,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isFilled
                              ? AppColors.primary
                              : AppColors.border,
                          width: 1.5,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 28),

                // Keypad
                Column(
                  children: [
                    _buildKeypadRow(['1', '2', '3']),
                    const SizedBox(height: 12),
                    _buildKeypadRow(['4', '5', '6']),
                    const SizedBox(height: 12),
                    _buildKeypadRow(['7', '8', '9']),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Biometric simulation
                            setState(() => _isUnlocked = true);
                            AppSnackBar.showSuccess(
                              context,
                              'Biometrik Face/Fingerprint Terverifikasi',
                            );
                          },
                          icon: const Icon(
                            Icons.fingerprint_rounded,
                            size: 28,
                            color: AppColors.primary,
                          ),
                        ),
                        _buildKeypadButton('0'),
                        IconButton(
                          onPressed: _onBackspace,
                          icon: const Icon(
                            Icons.backspace_outlined,
                            size: 22,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKeypadRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map((d) => _buildKeypadButton(d)).toList(),
    );
  }

  Widget _buildKeypadButton(String digit) {
    return InkWell(
      onTap: () => _onKeypadTap(digit),
      borderRadius: BorderRadius.circular(36),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Center(
          child: Text(
            digit,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _MedicalRecordEntry {
  const _MedicalRecordEntry({
    required this.id,
    required this.date,
    required this.clinic,
    required this.doctor,
    required this.diagnosis,
    required this.symptoms,
    required this.vitalSigns,
    required this.prescriptions,
    required this.labResults,
    required this.status,
  });

  final String id;
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

class _MedicalRecordCard extends StatelessWidget {
  const _MedicalRecordCard({required this.entry});

  final _MedicalRecordEntry entry;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Date & Clinic Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.event_note_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    entry.date,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              StatusBadge(
                label: entry.clinic,
                type: BadgeType.primary,
                isSmall: true,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Diagnosis
          Text(
            entry.diagnosis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Dokter Pemeriksa: ${entry.doctor}',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),

          // Symptoms & Vital Signs
          _DetailField(
            icon: Icons.personal_injury_outlined,
            title: 'Keluhan & Gejala Klinis',
            value: entry.symptoms,
          ),
          const SizedBox(height: 8),
          _DetailField(
            icon: Icons.monitor_heart_outlined,
            title: 'Tanda-Tanda Vital',
            value: entry.vitalSigns,
          ),
          const SizedBox(height: 12),

          // Prescriptions
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.medication_outlined,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Resep Obat Diberikan:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                for (final p in entry.prescriptions)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• ',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            p,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Download PDF Action Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  AppSnackBar.showSuccess(
                    context,
                    'Mengunduh resep & resume ${entry.id}.pdf',
                  );
                },
                icon: const Icon(
                  Icons.download_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
                label: const Text(
                  'Unduh PDF Resume',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailField extends StatelessWidget {
  const _DetailField({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: AppColors.textPrimary,
                height: 1.35,
              ),
              children: [
                TextSpan(
                  text: '$title: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
