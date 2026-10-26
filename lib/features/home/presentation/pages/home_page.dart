// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_shadows.dart';
import '../../../../shared/widgets/app_cards.dart';
import '../../../../shared/widgets/app_dialogs.dart';
import '../../../../shared/widgets/responsive_layout.dart';
import '../../../../shared/widgets/status_badge.dart';
import '../../../appointment/presentation/pages/booking_page.dart';
import '../../../consultation/presentation/pages/consultation_page.dart';
import '../../../medical_record/presentation/pages/medical_record_page.dart';
import '../../../profile/presentation/pages/digital_medical_card_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../reminder/presentation/pages/medication_reminder_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<NavigationItemData> _navItems = [
    NavigationItemData(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      label: 'Home',
    ),
    NavigationItemData(
      icon: Icons.calendar_month_outlined,
      selectedIcon: Icons.calendar_month_rounded,
      label: 'Appointments',
    ),
    NavigationItemData(
      icon: Icons.receipt_long_outlined,
      selectedIcon: Icons.receipt_long_rounded,
      label: 'Records',
    ),
    NavigationItemData(
      icon: Icons.notifications_none_outlined,
      selectedIcon: Icons.notifications_rounded,
      label: 'Alerts',
    ),
    NavigationItemData(
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveNavigationScaffold(
      currentIndex: _selectedIndex,
      onNavigationIndexChanged: (index) {
        setState(() => _selectedIndex = index);
      },
      items: _navItems,
      children: [
        _HomeOverview(
          onBookAppointment: () => setState(() => _selectedIndex = 1),
          onNavigateToTab: (index) => setState(() => _selectedIndex = index),
        ),
        const BookingPage(),
        const MedicalRecordPage(),
        const MedicationReminderPage(),
        const ProfilePage(),
      ],
    );
  }
}

class _HomeOverview extends StatelessWidget {
  const _HomeOverview({
    required this.onBookAppointment,
    required this.onNavigateToTab,
  });

  final VoidCallback onBookAppointment;
  final ValueChanged<int> onNavigateToTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _ReferenceHomeHeader(
              onNotificationTap: () => onNavigateToTab(3),
              onProfileTap: () => onNavigateToTab(4),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _ReferenceHeroCard(onTap: onBookAppointment),
                const SizedBox(height: 28),
                _ReferenceSectionTitle(
                  title: 'Tips & Articles',
                  action: 'Explore',
                  onTap: () => AppSnackBar.showInfo(
                    context,
                    'Artikel kesehatan Klinik UAD',
                  ),
                ),
                const SizedBox(height: 14),
                const _ArticleRow(),
                const SizedBox(height: 28),
                _ReferenceSectionTitle(
                  title: 'Today’s Summary',
                  action: 'See all',
                  onTap: () => onNavigateToTab(2),
                ),
                const SizedBox(height: 14),
                const _SummaryRow(),
                const SizedBox(height: 24),
                const _HealthChartGrid(),
                const SizedBox(height: 24),
                _LegacyQuickAccess(
                  onBookAppointment: onBookAppointment,
                  onMedicalRecord: () => onNavigateToTab(2),
                  onMedication: () => onNavigateToTab(3),
                  onConsultation: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ConsultationPage()),
                  ),
                  onDigitalCard: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const DigitalMedicalCardPage(),
                    ),
                  ),
                  onHealthProfile: () => onNavigateToTab(4),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferenceHomeHeader extends StatelessWidget {
  const _ReferenceHomeHeader({
    required this.onNotificationTap,
    required this.onProfileTap,
  });

  final VoidCallback onNotificationTap;
  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 4),
      child: Row(
        children: [
          Image.asset('assets/icon/logo_klinik_uad.png', width: 48, height: 48),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'KLINIK UAD',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  'Layanan kesehatan kampus',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onNotificationTap,
            icon: const Icon(
              Icons.notifications_none_rounded,
              size: 29,
              color: AppColors.primaryDark,
            ),
            tooltip: 'Notifikasi',
          ),
          GestureDetector(
            onTap: onProfileTap,
            child: const CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.primaryContainer,
              child: Text(
                'AN',
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferenceHeroCard extends StatelessWidget {
  const _ReferenceHeroCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: SizedBox(
        height: 212,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/background/background.png', fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryDark.withAlpha(220),
                    AppColors.primary.withAlpha(45),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 28, 20, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello, Ahmad',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 29,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Here’s your daily health snapshot.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      _HeroTag(label: 'Klinik UAD', onTap: onTap),
                      const SizedBox(width: 8),
                      const _HeroTag(label: 'Good Health'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_Dot(active: true), _Dot(), _Dot()],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroTag extends StatelessWidget {
  const _HeroTag({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white70),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

class _Dot extends StatelessWidget {
  const _Dot({this.active = false});

  final bool active;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 3),
    width: 16,
    height: 16,
    decoration: BoxDecoration(
      color: active ? Colors.white : Colors.white70,
      shape: BoxShape.circle,
    ),
  );
}

class _ReferenceSectionTitle extends StatelessWidget {
  const _ReferenceSectionTitle({
    required this.title,
    required this.action,
    required this.onTap,
  });

  final String title;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: AppColors.primaryDark,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      ),
      TextButton(
        onPressed: onTap,
        child: Text(
          action,
          style: const TextStyle(
            color: AppColors.success,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}

class _ArticleRow extends StatelessWidget {
  const _ArticleRow();

  @override
  Widget build(BuildContext context) => const Row(
    children: [
      Expanded(
        child: _ArticleCard(
          title: 'Start your day right',
          subtitle: '3 min read • Nutrition',
        ),
      ),
      SizedBox(width: 14),
      Expanded(
        child: _ArticleCard(
          title: '5-min breathing',
          subtitle: '2 min read • Mindfulness',
        ),
      ),
    ],
  );
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Container(
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppColors.border),
    ),
    child: Column(
      children: [
        Image.asset(
          'assets/background/background.png',
          height: 108,
          width: double.infinity,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow();

  @override
  Widget build(BuildContext context) => const Row(
    children: [
      Expanded(
        child: _SummaryItem(
          value: '72',
          label: 'Heart Rate',
          color: AppColors.success,
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: _SummaryItem(
          value: '92%',
          label: 'Sleep Score',
          color: Color(0xFF62C6EC),
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: _SummaryItem(
          value: 'Low',
          label: 'Stress',
          color: Color(0xFFFFB23F),
        ),
      ),
    ],
  );
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      color: const Color(0xFFE9F7FA),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: AppColors.borderLight),
    ),
    child: Column(
      children: [
        CircleAvatar(
          radius: 31,
          backgroundColor: color,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

class _HealthChartGrid extends StatelessWidget {
  const _HealthChartGrid();

  @override
  Widget build(BuildContext context) => GridView.count(
    crossAxisCount: 2,
    mainAxisSpacing: 14,
    crossAxisSpacing: 14,
    childAspectRatio: 1.25,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    children: const [
      _HealthChart(
        title: 'Heart Rate',
        value: '72 bpm',
        icon: Icons.monitor_heart_outlined,
      ),
      _HealthChart(
        title: 'Sleep',
        value: '7h 45m',
        icon: Icons.nightlight_outlined,
      ),
      _HealthChart(
        title: 'BP & SpO₂',
        value: '118/76',
        icon: Icons.favorite_border_rounded,
      ),
      _HealthChart(
        title: 'Stress',
        value: 'Low',
        icon: Icons.psychology_outlined,
      ),
    ],
  );
}

class _HealthChart extends StatelessWidget {
  const _HealthChart({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(18, 14, 14, 12),
    decoration: BoxDecoration(
      color: const Color(0xFFE9F7FA),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFD4DDE0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(icon, color: AppColors.primaryDark, size: 26),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.primaryDark,
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Spacer(),
        const _BarChart(),
      ],
    ),
  );
}

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [34, 24, 42, 48, 34, 24, 40]
        .map(
          (height) => Container(
            width: 18,
            height: height.toDouble(),
            decoration: const BoxDecoration(
              color: Color(0xFF4CAF50),
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
            ),
          ),
        )
        .toList(),
  );
}

class _LegacyQuickAccess extends StatelessWidget {
  const _LegacyQuickAccess({
    required this.onBookAppointment,
    required this.onMedicalRecord,
    required this.onMedication,
    required this.onConsultation,
    required this.onDigitalCard,
    required this.onHealthProfile,
  });

  final VoidCallback onBookAppointment;
  final VoidCallback onMedicalRecord;
  final VoidCallback onMedication;
  final VoidCallback onConsultation;
  final VoidCallback onDigitalCard;
  final VoidCallback onHealthProfile;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Quick access',
        style: TextStyle(
          color: AppColors.primaryDark,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 12),
      _QuickAccessGrid(
        onBookAppointment: onBookAppointment,
        onMedicalRecord: onMedicalRecord,
        onMedication: onMedication,
        onConsultation: onConsultation,
        onDigitalCard: onDigitalCard,
        onHealthProfile: onHealthProfile,
      ),
    ],
  );
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader({
    required this.onProfileTap,
    required this.onNotificationTap,
  });

  final VoidCallback onProfileTap;
  final VoidCallback onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
      decoration: const BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Bar: Logo & Avatar
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: AppShadows.subtle,
                ),
                child: const Icon(
                  Icons.local_hospital_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              const SizedBox(width: 13),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Klinik UAD',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const Text(
                    'Universitas Ahmad Dahlan',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Profile Avatar with Status Dot
              InkWell(
                onTap: onProfileTap,
                borderRadius: BorderRadius.circular(29),
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF8AC792),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Text(
                        'AN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 2,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryContainer,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 35),

          // Greeting & User Name
          const Text(
            'Good morning,',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF7D8580),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Ahmad Nur Hidayat',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: const Color(0xFF202522),
              fontWeight: FontWeight.w900,
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: 26),

          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: AppShadows.subtle,
            ),
            child: TextField(
              readOnly: true,
              onTap: () {
                AppSnackBar.showInfo(context, 'Fitur pencarian terintegrasi');
              },
              decoration: InputDecoration(
                hintText: 'Search doctors,\nservices...',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF8A948E),
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF7A867F),
                  size: 22,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.tune_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  onPressed: () {
                    AppSnackBar.showInfo(context, 'Filter poli dan jadwal');
                  },
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                filled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QueueCard extends StatelessWidget {
  const _QueueCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primary, width: 2),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(20),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE5F4E7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Today',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'General Consultation',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: const [
                              Icon(
                                Icons.access_time_filled_rounded,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                              SizedBox(width: 6),
                              Text(
                                '10:30 · dr. Alya Rahman',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Queue Pill Box
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7F4E9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: const [
                          Text(
                            'Queue',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'A-12',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const LinearProgressIndicator(
                    value: 0.67,
                    minHeight: 6,
                    backgroundColor: Color(0xFFE4EAE5),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Now serving A-08',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF7D8580),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '~18 min',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
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
}

class _QuickAccessGrid extends StatelessWidget {
  const _QuickAccessGrid({
    required this.onBookAppointment,
    required this.onMedicalRecord,
    required this.onMedication,
    required this.onConsultation,
    required this.onDigitalCard,
    required this.onHealthProfile,
  });

  final VoidCallback onBookAppointment;
  final VoidCallback onMedicalRecord;
  final VoidCallback onMedication;
  final VoidCallback onConsultation;
  final VoidCallback onDigitalCard;
  final VoidCallback onHealthProfile;

  @override
  Widget build(BuildContext context) {
    final services = [
      (Icons.event_available_rounded, 'Book Doctor', onBookAppointment),
      (Icons.article_rounded, 'Medical Record', onMedicalRecord),
      (Icons.medication_rounded, 'Medication', onMedication),
      (Icons.psychology_rounded, 'Consultation', onConsultation),
      (Icons.badge_rounded, 'Digital Card', onDigitalCard),
      (Icons.monitor_heart_rounded, 'Health Profile', onHealthProfile),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 18,
        crossAxisSpacing: 14,
        childAspectRatio: 0.88,
      ),
      itemBuilder: (context, index) {
        final item = services[index];
        return _QuickAccessItem(
          icon: item.$1,
          label: item.$2,
          onPressed: item.$3,
        );
      },
    );
  }
}

class _QuickAccessItem extends StatelessWidget {
  const _QuickAccessItem({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.borderLight),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 14,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicationReminderCard extends StatelessWidget {
  const _MedicationReminderCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFE0F8FC),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.medication_rounded,
              color: Color(0xFF00ACC1),
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'UPCOMING · 12:30',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Paracetamol 500 mg',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'After lunch · 1 tablet',
                  style: TextStyle(fontSize: 12, color: Color(0xFF7D8580)),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 26,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}

class _HealthArticleCard extends StatelessWidget {
  const _HealthArticleCard({
    required this.category,
    required this.title,
    required this.readTime,
    required this.date,
    required this.onTap,
  });

  final String category;
  final String title;
  final String readTime;
  final String date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.article_outlined,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatusBadge(
                      label: category,
                      type: BadgeType.primary,
                      isSmall: true,
                    ),
                    Text(
                      readTime,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
