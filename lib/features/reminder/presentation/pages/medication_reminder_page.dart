import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_shadows.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/app_cards.dart';
import '../../../../shared/widgets/app_dialogs.dart';
import '../../../../shared/widgets/status_badge.dart';

class MedicationReminderPage extends StatefulWidget {
  const MedicationReminderPage({super.key});

  @override
  State<MedicationReminderPage> createState() => _MedicationReminderPageState();
}

class _MedicationReminderPageState extends State<MedicationReminderPage> {
  int _selectedFilterIndex = 0; // 0: Hari Ini, 1: Terjadwal, 2: Riwayat

  final List<_MedicineItem> _medicines = [
    _MedicineItem(
      id: 'med-1',
      name: 'Amoxicillin 500 mg',
      dosage: '1 Kapsul · Sesudah makan',
      timeSlot: 'Pagi · 07:30 WIB',
      isCompleted: true,
      remainingDays: '3 hari lagi',
      color: AppColors.primary,
      icon: Icons.medication_liquid_rounded,
    ),
    _MedicineItem(
      id: 'med-2',
      name: 'Paracetamol 500 mg',
      dosage: '1 Tablet · Sesudah makan (bila demam/nyeri)',
      timeSlot: 'Siang · 12:30 WIB',
      isCompleted: false,
      remainingDays: '2 hari lagi',
      color: AppColors.accent,
      icon: Icons.medication_rounded,
    ),
    _MedicineItem(
      id: 'med-3',
      name: 'Vitamin C 500 mg',
      dosage: '1 Tablet · Bersama air putih setelah makan',
      timeSlot: 'Malam · 19:30 WIB',
      isCompleted: false,
      remainingDays: '5 hari lagi',
      color: Color(0xFFFFA000),
      icon: Icons.local_pharmacy_rounded,
    ),
  ];

  void _toggleMedication(int index) {
    setState(() {
      _medicines[index].isCompleted = !_medicines[index].isCompleted;
    });

    if (_medicines[index].isCompleted) {
      AppSnackBar.showSuccess(
        context,
        '${_medicines[index].name} ditandai sudah diminum! Semoga lekas pulih.',
      );
    }
  }

  int get _takenCount => _medicines.where((m) => m.isCompleted).length;
  double get _progress =>
      _medicines.isEmpty ? 0.0 : _takenCount / _medicines.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pengingat Minum Obat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded),
            tooltip: 'Tambah Obat Mandiri',
            onPressed: () {
              AppBottomSheet.show(
                context: context,
                title: 'Tambah Pengingat Obat',
                subtitle: 'Atur jadwal minum obat di luar resep dokter',
                content: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Nama Obat',
                        hintText: 'Misal: Multivitamin B Kompleks',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Dosis & Aturan',
                        hintText: 'Misal: 1 tablet 1x sehari',
                      ),
                    ),
                  ],
                ),
                action: AppPrimaryButton(
                  text: 'Simpan Pengingat',
                  onPressed: () {
                    Navigator.pop(context);
                    AppSnackBar.showSuccess(
                      context,
                      'Pengingat obat baru berhasil disimpan',
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Header Card
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(22),
                boxShadow: AppShadows.primaryGlow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kepatuhan Hari Ini',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$_takenCount dari ${_medicines.length} Dosis',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _progress,
                      minHeight: 10,
                      backgroundColor: Colors.white.withAlpha(50),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.accent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _progress == 1.0
                        ? 'Luar biasa! Semua dosis obat hari ini sudah lengkap.'
                        : 'Tetap disiplin minum obat sesuai anjuran dokter agar proses penyembuhan optimal.',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tab Filter Pills
            Row(
              children: [
                CategoryPill(
                  label: 'Hari Ini',
                  isSelected: _selectedFilterIndex == 0,
                  onTap: () => setState(() => _selectedFilterIndex = 0),
                ),
                const SizedBox(width: 8),
                CategoryPill(
                  label: 'Terjadwal',
                  isSelected: _selectedFilterIndex == 1,
                  onTap: () => setState(() => _selectedFilterIndex = 1),
                ),
                const SizedBox(width: 8),
                CategoryPill(
                  label: 'Riwayat Konsumsi',
                  isSelected: _selectedFilterIndex == 2,
                  onTap: () => setState(() => _selectedFilterIndex = 2),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Medication Cards List
            const SectionHeader(
              title: 'Jadwal Obat Anda',
              subtitle: 'Resep terverifikasi dari Apotek Klinik Kampus UAD',
            ),
            const SizedBox(height: 12),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _medicines.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final med = _medicines[index];

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: med.isCompleted
                          ? AppColors.success.withAlpha(100)
                          : AppColors.border,
                      width: med.isCompleted ? 1.5 : 1.0,
                    ),
                    boxShadow: AppShadows.subtle,
                  ),
                  child: Row(
                    children: [
                      // Large Icon
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: med.isCompleted
                              ? AppColors.successContainer
                              : med.color.withAlpha(25),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          med.isCompleted
                              ? Icons.check_circle_rounded
                              : med.icon,
                          color: med.isCompleted
                              ? AppColors.success
                              : med.color,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Medicine Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    med.name,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: med.isCompleted
                                          ? AppColors.textSecondary
                                          : AppColors.textPrimary,
                                      decoration: med.isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                ),
                                StatusBadge(
                                  label: med.remainingDays,
                                  type: BadgeType.neutral,
                                  isSmall: true,
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              med.dosage,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_filled_rounded,
                                  size: 14,
                                  color: med.isCompleted
                                      ? AppColors.success
                                      : AppColors.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  med.timeSlot,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: med.isCompleted
                                        ? AppColors.success
                                        : AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Take / Completed Action
                      InkWell(
                        onTap: () => _toggleMedication(index),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: med.isCompleted
                                ? AppColors.successContainer
                                : AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            med.isCompleted ? 'Sudah' : 'Minum',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: med.isCompleted
                                  ? AppColors.success
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Pharmacy Consult Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.help_outline_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Punya Pertanyaan Efek Samping Obat?',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Hubungi apoteker klinik via telekonsultasi farmasi',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      AppSnackBar.showInfo(
                        context,
                        'Membuka layanan tanya apoteker...',
                      );
                    },
                    child: const Text(
                      'Tanya',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _MedicineItem {
  _MedicineItem({
    required this.id,
    required this.name,
    required this.dosage,
    required this.timeSlot,
    required this.isCompleted,
    required this.remainingDays,
    required this.color,
    required this.icon,
  });

  final String id;
  final String name;
  final String dosage;
  final String timeSlot;
  bool isCompleted;
  final String remainingDays;
  final Color color;
  final IconData icon;
}
