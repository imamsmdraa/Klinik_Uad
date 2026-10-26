import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_shadows.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/app_cards.dart';
import '../../../../shared/widgets/app_dialogs.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/status_badge.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String _selectedSpecialty = 'Semua';
  int _selectedDateIndex = 0;
  String? _selectedTimeSlot;
  _DoctorItem? _selectedDoctor;

  final List<String> _specialties = [
    'Semua',
    'Poli Umum',
    'Poli Gigi',
    'Psikologi',
    'Penyakit Dalam',
    'Gizi Klinik',
  ];

  final List<Map<String, String>> _dates = [
    {'day': 'Sen', 'date': '19', 'full': 'Senin, 19 Okt 2026'},
    {'day': 'Sel', 'date': '20', 'full': 'Selasa, 20 Okt 2026'},
    {'day': 'Rab', 'date': '21', 'full': 'Rabu, 21 Okt 2026'},
    {'day': 'Kam', 'date': '22', 'full': 'Kamis, 22 Okt 2026'},
    {'day': 'Jum', 'date': '23', 'full': 'Jumat, 23 Okt 2026'},
    {'day': 'Sab', 'date': '24', 'full': 'Sabtu, 24 Okt 2026'},
  ];

  final List<String> _morningSlots = [
    '08:00',
    '08:30',
    '09:00',
    '09:30',
    '10:00',
    '10:30',
  ];
  final List<String> _afternoonSlots = [
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
  ];
  final List<String> _eveningSlots = ['16:00', '16:30', '17:00'];

  final List<_DoctorItem> _doctors = const [
    _DoctorItem(
      id: 'doc-1',
      name: 'dr. Alya Rahman',
      specialty: 'Poli Umum',
      hospital: 'Klinik UAD Kampus 4',
      rating: 4.9,
      reviewsCount: 142,
      experience: '7 tahun',
      room: 'Ruang 102',
      isAvailable: true,
      initials: 'AR',
      accentColor: AppColors.primary,
    ),
    _DoctorItem(
      id: 'doc-2',
      name: 'drg. Dimas Prasetyo, Sp.KG',
      specialty: 'Poli Gigi',
      hospital: 'Klinik UAD Kampus 1',
      rating: 4.8,
      reviewsCount: 98,
      experience: '9 tahun',
      room: 'Ruang Gigi 2',
      isAvailable: true,
      initials: 'DP',
      accentColor: AppColors.accent,
    ),
    _DoctorItem(
      id: 'doc-3',
      name: 'Nurlaila Sari, M.Psi., Psikolog',
      specialty: 'Psikologi',
      hospital: 'Unit Konseling Mahasiswa',
      rating: 5.0,
      reviewsCount: 176,
      experience: '6 tahun',
      room: 'Ruang Konseling B',
      isAvailable: true,
      initials: 'NS',
      accentColor: Color(0xFF8E24AA),
    ),
    _DoctorItem(
      id: 'doc-4',
      name: 'dr. Hendra Wicaksono, Sp.PD',
      specialty: 'Penyakit Dalam',
      hospital: 'Klinik UAD Kampus 4',
      rating: 4.9,
      reviewsCount: 110,
      experience: '12 tahun',
      room: 'Ruang 105',
      isAvailable: false,
      initials: 'HW',
      accentColor: Color(0xFFE65100),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedDoctor = _doctors.first;
    _selectedTimeSlot = _morningSlots[1];
  }

  List<_DoctorItem> get _filteredDoctors {
    if (_selectedSpecialty == 'Semua') return _doctors;
    return _doctors.where((d) => d.specialty == _selectedSpecialty).toList();
  }

  void _showBookingConfirmation() {
    if (_selectedDoctor == null || _selectedTimeSlot == null) {
      AppSnackBar.showError(context, 'Pilih dokter dan jam terlebih dahulu');
      return;
    }

    final selectedDate = _dates[_selectedDateIndex];

    AppBottomSheet.show(
      context: context,
      title: 'Konfirmasi Pendaftaran Janji',
      subtitle: 'Periksa kembali detail jadwal pemeriksaan Anda',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor summary
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: _selectedDoctor!.accentColor,
                  radius: 22,
                  child: Text(
                    _selectedDoctor!.initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedDoctor!.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${_selectedDoctor!.specialty} · ${_selectedDoctor!.room}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Schedule Details
          _ConfirmationRow(
            label: 'Waktu Kunjungan',
            value: '${selectedDate['full']!}, Pukul $_selectedTimeSlot WIB',
            icon: Icons.calendar_month_rounded,
          ),
          const SizedBox(height: 10),
          const _ConfirmationRow(
            label: 'Nama Pasien',
            value: 'Ahmad Nur Hidayat (NIM: 2100018099)',
            icon: Icons.person_rounded,
          ),
          const SizedBox(height: 10),
          const _ConfirmationRow(
            label: 'Biaya Layanan',
            value: 'Gratis (Fasilitas Sivitas Akademika UAD)',
            icon: Icons.verified_user_rounded,
            highlightColor: AppColors.success,
          ),
          const SizedBox(height: 10),
          const _ConfirmationRow(
            label: 'Nomor Antrean Didapat',
            value: 'A-14 (Estimasi antrean langsung)',
            icon: Icons.confirmation_number_outlined,
          ),
        ],
      ),
      action: AppPrimaryButton(
        text: 'Konfirmasi & Dapatkan Antrean',
        icon: Icons.check_circle_outline_rounded,
        onPressed: () {
          Navigator.pop(context);
          AppDialog.showConfirmation(
            context: context,
            title: 'Pendaftaran Berhasil!',
            message:
                'Janji temu Anda dengan ${_selectedDoctor!.name} pada ${selectedDate['full']!} pukul $_selectedTimeSlot WIB telah dikonfirmasi dengan nomor antrean A-14.',
            confirmLabel: 'Lihat Tiket Antrean',
            icon: Icons.check_circle_rounded,
            confirmColor: AppColors.primary,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Booking Dokter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            tooltip: 'Riwayat Booking',
            onPressed: () {
              AppSnackBar.showInfo(context, 'Membuka riwayat booking...');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: AppSearchBar(
                hintText: 'Cari nama dokter atau poli...',
                onFilterTap: () {
                  AppSnackBar.showInfo(context, 'Filter jadwal dan fasilitas');
                },
              ),
            ),

            // Horizontal Specialty Chips
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: AppSpacing.screenPaddingHorizontal,
                itemCount: _specialties.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final specialty = _specialties[index];
                  return CategoryPill(
                    label: specialty,
                    isSelected: _selectedSpecialty == specialty,
                    onTap: () => setState(() => _selectedSpecialty = specialty),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Date Selection Header & Strip
            Padding(
              padding: AppSpacing.screenPaddingHorizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pilih Tanggal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );
                    },
                    icon: const Icon(Icons.calendar_month, size: 16),
                    label: const Text(
                      'Kalender',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Horizontal Date Strip
            SizedBox(
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: AppSpacing.screenPaddingHorizontal,
                itemCount: _dates.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final isSelected = _selectedDateIndex == index;
                  final date = _dates[index];

                  return InkWell(
                    onTap: () => setState(() => _selectedDateIndex = index),
                    borderRadius: BorderRadius.circular(16),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 58,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                        boxShadow: isSelected ? AppShadows.subtle : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            date['day']!,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white70
                                  : AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            date['date']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Doctor Selection
            Padding(
              padding: AppSpacing.screenPaddingHorizontal,
              child: const SectionHeader(
                title: 'Pilih Dokter & Praktik',
                subtitle: 'Dokter spesialis dan umum bertugas di Klinik UAD',
              ),
            ),
            const SizedBox(height: 12),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: AppSpacing.screenPaddingHorizontal,
              itemCount: _filteredDoctors.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final doc = _filteredDoctors[index];
                final isSelected = _selectedDoctor?.id == doc.id;

                return InkWell(
                  onTap: doc.isAvailable
                      ? () => setState(() => _selectedDoctor = doc)
                      : null,
                  borderRadius: BorderRadius.circular(18),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? AppShadows.card
                          : AppShadows.subtle,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Doctor Avatar
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: doc.accentColor.withAlpha(25),
                              child: Text(
                                doc.initials,
                                style: TextStyle(
                                  color: doc.accentColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: doc.isAvailable
                                      ? AppColors.success
                                      : AppColors.textTertiary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 14),

                        // Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      doc.name,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    const Icon(
                                      Icons.check_circle_rounded,
                                      color: AppColors.primary,
                                      size: 20,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${doc.specialty} · ${doc.experience} pengalaman',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 16,
                                    color: Color(0xFFFFB300),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    '${doc.rating}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    ' (${doc.reviewsCount})',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: doc.isAvailable
                                          ? AppColors.successContainer
                                          : AppColors.surfaceVariant,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      doc.isAvailable ? doc.room : 'Penuh',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: doc.isAvailable
                                            ? AppColors.success
                                            : AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Time Slots Selection
            Padding(
              padding: AppSpacing.screenPaddingHorizontal,
              child: const SectionHeader(
                title: 'Pilih Jam Praktik',
                subtitle: 'Sesi konsultasi estimasi 20-30 menit per pasien',
              ),
            ),
            const SizedBox(height: 12),

            Padding(
              padding: AppSpacing.screenPaddingHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SlotGroup(
                    title: 'Pagi (08:00 - 11:30)',
                    slots: _morningSlots,
                    selectedSlot: _selectedTimeSlot,
                    onSelected: (slot) =>
                        setState(() => _selectedTimeSlot = slot),
                  ),
                  const SizedBox(height: 14),
                  _SlotGroup(
                    title: 'Siang (13:00 - 15:30)',
                    slots: _afternoonSlots,
                    selectedSlot: _selectedTimeSlot,
                    onSelected: (slot) =>
                        setState(() => _selectedTimeSlot = slot),
                  ),
                  const SizedBox(height: 14),
                  _SlotGroup(
                    title: 'Sore (16:00 - 18:00)',
                    slots: _eveningSlots,
                    selectedSlot: _selectedTimeSlot,
                    onSelected: (slot) =>
                        setState(() => _selectedTimeSlot = slot),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(top: BorderSide(color: AppColors.border)),
          boxShadow: AppShadows.card,
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Biaya Pendaftaran',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: const [
                        Text(
                          'GRATIS',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '· UAD Health Pass',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppPrimaryButton(
                text: 'Lanjutkan Booking',
                icon: Icons.calendar_month_rounded,
                onPressed: _showBookingConfirmation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoctorItem {
  const _DoctorItem({
    required this.id,
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.rating,
    required this.reviewsCount,
    required this.experience,
    required this.room,
    required this.isAvailable,
    required this.initials,
    required this.accentColor,
  });

  final String id;
  final String name;
  final String specialty;
  final String hospital;
  final double rating;
  final int reviewsCount;
  final String experience;
  final String room;
  final bool isAvailable;
  final String initials;
  final Color accentColor;
}

class _SlotGroup extends StatelessWidget {
  const _SlotGroup({
    required this.title,
    required this.slots,
    required this.selectedSlot,
    required this.onSelected,
  });

  final String title;
  final List<String> slots;
  final String? selectedSlot;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: slots.map((slot) {
            final isSelected = selectedSlot == slot;

            return InkWell(
              onTap: () => onSelected(slot),
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: Text(
                  slot,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _ConfirmationRow extends StatelessWidget {
  const _ConfirmationRow({
    required this.label,
    required this.value,
    required this.icon,
    this.highlightColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: highlightColor ?? AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: highlightColor ?? AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
