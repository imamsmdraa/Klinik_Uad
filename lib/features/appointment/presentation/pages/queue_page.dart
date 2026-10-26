import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_shadows.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/app_cards.dart';
import '../../../../shared/widgets/app_dialogs.dart';
import '../../../../shared/widgets/status_badge.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({super.key});

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _refreshQueue() async {
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      setState(() => _isRefreshing = false);
      AppSnackBar.showSuccess(
        context,
        'Data antrean diperbarui secara realtime',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Antrean Pemeriksaan'),
        actions: [
          IconButton(
            icon: _isRefreshing
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh_rounded),
            onPressed: _isRefreshing ? null : _refreshQueue,
            tooltip: 'Perbarui Status',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshQueue,
        color: AppColors.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Queue Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.primary.withAlpha(60),
                    width: 1.5,
                  ),
                  boxShadow: AppShadows.card,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const StatusBadge(
                          label: 'Hari Ini · Poli Umum',
                          type: BadgeType.primary,
                          icon: Icons.calendar_today_rounded,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accentContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.room_rounded,
                                size: 14,
                                color: AppColors.onAccent,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Ruang 102 · dr. Alya Rahman',
                                style: TextStyle(
                                  color: AppColors.onAccent,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Big Animated Queue Badge
                    const Text(
                      'Nomor Antrean Anda',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ScaleTransition(
                      scale: _pulseAnimation,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(40),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Text(
                          'A-12',
                          style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        value: 0.67,
                        minHeight: 8,
                        backgroundColor: AppColors.surfaceVariant,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Metrics Strip
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sedang Dilayani',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'A-08 (4 pasien lagi)',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Estimasi Waktu Tunggu',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timer_outlined,
                                  size: 14,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '~18 Menit',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Queue Timeline Steps
              const SectionHeader(
                title: 'Tahapan Pemeriksaan',
                subtitle: 'Alur proses konsultasi klinik hari ini',
              ),
              const SizedBox(height: 12),
              AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    _TimelineStep(
                      stepNumber: 1,
                      title: 'Pendaftaran Janji Online',
                      subtitle: 'Selesai pukul 08:30 via aplikasi Klinik UAD',
                      isCompleted: true,
                      isActive: false,
                    ),
                    _TimelineStep(
                      stepNumber: 2,
                      title: 'Skrining & Tanda Vital',
                      subtitle: 'Tekanan darah 118/78 mmHg · Suhu 36.6°C',
                      isCompleted: true,
                      isActive: false,
                    ),
                    _TimelineStep(
                      stepNumber: 3,
                      title: 'Ruang Tunggu Poli',
                      subtitle: 'Menunggu panggilan antrean dokter di Lantai 1',
                      isCompleted: false,
                      isActive: true,
                    ),
                    _TimelineStep(
                      stepNumber: 4,
                      title: 'Pemeriksaan Dokter',
                      subtitle: 'Konsultasi keluhan dengan dr. Alya Rahman',
                      isCompleted: false,
                      isActive: false,
                    ),
                    _TimelineStep(
                      stepNumber: 5,
                      title: 'Pengambilan Resep Farmasi',
                      subtitle: 'Pengambilan obat di loket apotek klinik',
                      isCompleted: false,
                      isActive: false,
                      isLast: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Notification Advice Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.notifications_active_outlined,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Aplikasi akan mengirimkan getaran dan notifikasi suara saat nomor Anda tersisa 2 antrean lagi.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Emergency Assistance
              AppOutlinedButton(
                text: 'Bantuan Antrean / Reschedule',
                icon: Icons.support_agent_rounded,
                onPressed: () {
                  AppBottomSheet.show(
                    context: context,
                    title: 'Bantuan Antrean',
                    subtitle: 'Pilih layanan bantuan antrean klinik',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.edit_calendar_rounded,
                            color: AppColors.primary,
                          ),
                          title: const Text('Ubah Jadwal Jam Periksa'),
                          subtitle: const Text(
                            'Pindahkan janji temu ke slot sore',
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            AppSnackBar.showInfo(
                              context,
                              'Membuka pilihan jadwal dokter...',
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.cancel_outlined,
                            color: AppColors.danger,
                          ),
                          title: const Text('Batalkan Antrean'),
                          subtitle: const Text('Batalkan nomor antrean A-12'),
                          onTap: () {
                            Navigator.pop(context);
                            AppDialog.showConfirmation(
                              context: context,
                              title: 'Batalkan Antrean?',
                              message:
                                  'Apakah Anda yakin ingin membatalkan antrean A-12 hari ini?',
                              confirmLabel: 'Ya, Batalkan',
                              confirmColor: AppColors.danger,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.stepNumber,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isActive,
    this.isLast = false,
  });

  final int stepNumber;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isActive;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    Color indicatorBg;
    Color indicatorFg;

    if (isCompleted) {
      indicatorBg = AppColors.primary;
      indicatorFg = Colors.white;
    } else if (isActive) {
      indicatorBg = AppColors.warning;
      indicatorFg = Colors.white;
    } else {
      indicatorBg = AppColors.surfaceVariant;
      indicatorFg = AppColors.textTertiary;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Icon & Line
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: indicatorBg,
                  shape: BoxShape.circle,
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.warning.withAlpha(80),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 16,
                        )
                      : Text(
                          '$stepNumber',
                          style: TextStyle(
                            color: indicatorFg,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? AppColors.primary : AppColors.border,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isActive
                              ? FontWeight.w800
                              : FontWeight.w600,
                          color: isActive
                              ? AppColors.textPrimary
                              : (isCompleted
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary),
                        ),
                      ),
                      if (isActive) ...[
                        const SizedBox(width: 8),
                        const StatusBadge(
                          label: 'Sekarang',
                          type: BadgeType.warning,
                          isSmall: true,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
