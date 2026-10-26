import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_shadows.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/app_cards.dart';
import '../../../../shared/widgets/app_dialogs.dart';
import '../../../../shared/widgets/status_badge.dart';
import 'digital_medical_card_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profil & Kesehatan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              AppSnackBar.showInfo(context, 'Pengaturan akun dan preferensi');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          children: [
            // User Header Card
            AppCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 68,
                            height: 68,
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              shape: BoxShape.circle,
                              boxShadow: AppShadows.subtle,
                            ),
                            child: const Center(
                              child: Text(
                                'AN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.success,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ahmad Nur Hidayat',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'NIM: 2100018099 · Mahasiswa Aktif',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryContainer,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Fakultas Teknologi Industri',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Divider(color: AppColors.border, height: 1),
                  const SizedBox(height: 14),

                  // Digital Card Banner trigger
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const DigitalMedicalCardPage(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.cardGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.badge_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Buka Kartu Pasien Digital (QR Check-in)',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white70,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Health Biometrics Row (Blood, Height, Weight, BMI)
            const SectionHeader(title: 'Parameter Fisik & Medis'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _BiometricItem(
                    label: 'Gol. Darah',
                    value: 'O+',
                    unit: 'Rhesus Positif',
                    color: AppColors.danger,
                    icon: Icons.water_drop_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _BiometricItem(
                    label: 'Tinggi Badan',
                    value: '175',
                    unit: 'cm',
                    color: AppColors.primary,
                    icon: Icons.height_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _BiometricItem(
                    label: 'Berat Badan',
                    value: '68',
                    unit: 'kg',
                    color: AppColors.accent,
                    icon: Icons.monitor_weight_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // BMI Status Card
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.successContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.accessibility_new_rounded,
                      color: AppColors.success,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Indeks Massa Tubuh (BMI): ',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              '22.2',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Kategori: Berat Badan Ideal & Sehat',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const StatusBadge(label: 'Normal', type: BadgeType.success),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Allergy & Medical Notes Card
            const SectionHeader(title: 'Riwayat Kesehatan & Alergi'),
            const SizedBox(height: 10),
            AppCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  _InfoRow(
                    icon: Icons.warning_amber_rounded,
                    iconColor: AppColors.warning,
                    title: 'Alergi Obat & Makanan',
                    value: 'Penisilin, Makanan Laut (Seafood)',
                  ),
                  const Divider(color: AppColors.border, height: 20),
                  _InfoRow(
                    icon: Icons.history_edu_rounded,
                    iconColor: AppColors.info,
                    title: 'Riwayat Penyakit Kronis',
                    value: 'Tidak ada catatan penyakit kronis aktif',
                  ),
                  const Divider(color: AppColors.border, height: 20),
                  _InfoRow(
                    icon: Icons.medical_services_outlined,
                    iconColor: AppColors.primary,
                    title: 'Vaksinasi Terakhir',
                    value: 'COVID-19 Booster 2, Influenza (Okt 2025)',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Emergency Contact Card
            const SectionHeader(title: 'Kontak Darurat'),
            const SizedBox(height: 10),
            AppCard(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.dangerContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.phone_in_talk_rounded,
                      color: AppColors.danger,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ibu Hj. Maryam (Ibu Kandung)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '0812-3456-7890 · Terverifikasi',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppTonalButton(
                    text: 'Hubungi',
                    color: AppColors.dangerContainer,
                    textColor: AppColors.danger,
                    height: 36,
                    onPressed: () {
                      AppSnackBar.showInfo(
                        context,
                        'Menghubungkan ke kontak darurat...',
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Settings & Logout
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _SettingsTile(
                    icon: Icons.lock_outline_rounded,
                    title: 'Keamanan & PIN Rekam Medis',
                    onTap: () {
                      AppSnackBar.showInfo(
                        context,
                        'Pengaturan keamanan rekam medis',
                      );
                    },
                  ),
                  const Divider(color: AppColors.border, height: 1),
                  _SettingsTile(
                    icon: Icons.notifications_none_rounded,
                    title: 'Notifikasi Pengingat Obat & Kontrol',
                    onTap: () {
                      AppSnackBar.showInfo(
                        context,
                        'Pengaturan notifikasi pengingat',
                      );
                    },
                  ),
                  const Divider(color: AppColors.border, height: 1),
                  _SettingsTile(
                    icon: Icons.help_outline_rounded,
                    title: 'Pusat Bantuan & Kebijakan Klinik',
                    onTap: () {
                      AppSnackBar.showInfo(context, 'Pusat bantuan Klinik UAD');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Logout Button
            AppOutlinedButton(
              text: 'Keluar dari Akun',
              icon: Icons.logout_rounded,
              onPressed: () {
                AppDialog.showConfirmation(
                  context: context,
                  title: 'Konfirmasi Keluar',
                  message:
                      'Apakah Anda yakin ingin keluar dari aplikasi Klinik UAD?',
                  confirmLabel: 'Keluar',
                  confirmColor: AppColors.danger,
                  icon: Icons.logout_rounded,
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _BiometricItem extends StatelessWidget {
  const _BiometricItem({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
    required this.icon,
  });

  final String label;
  final String value;
  final String unit;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              Icon(icon, size: 16, color: color),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  unit,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary, size: 22),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14,
        color: AppColors.textTertiary,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
    );
  }
}
