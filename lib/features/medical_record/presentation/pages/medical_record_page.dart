import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/medical_record.dart';
import '../../../../providers/app_providers.dart';
import '../../../../services/pin_service.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_shadows.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/widgets/app_cards.dart';
import '../../../../shared/widgets/app_dialogs.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/status_badge.dart';

class MedicalRecordPage extends ConsumerStatefulWidget {
  const MedicalRecordPage({super.key, this.active = true});

  final bool active;

  @override
  ConsumerState<MedicalRecordPage> createState() => _MedicalRecordPageState();
}

class _MedicalRecordPageState extends ConsumerState<MedicalRecordPage>
    with WidgetsBindingObserver {
  bool _isUnlocked = false;
  String _pin = '';
  String? _firstPin;
  bool _hasPin = false;
  bool _ready = false;
  bool _busy = false;
  String? _error;
  int _session = 0;
  String _searchQuery = '';
  String _selectedYear = 'Semua Tahun';

  final List<String> _years = ['Semua Tahun', '2026', '2025', '2024'];

  List<MedicalRecord> _records = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadPin();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _lock() {
    setState(() {
      _session++;
      _isUnlocked = false;
      _pin = '';
      _firstPin = null;
      _records = [];
    });
  }

  @override
  void didUpdateWidget(covariant MedicalRecordPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.active && oldWidget.active) _lock();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) _lock();
  }

  Future<void> _loadPin() async {
    try {
      final hasPin = await ref.read(pinServiceProvider).isPinEnabled();
      if (!mounted) return;
      setState(() {
        _hasPin = hasPin;
        _ready = true;
        _error = null;
      });
    } catch (_) {
      if (mounted) {
        setState(
          () => _error = 'Penyimpanan aman tidak dapat dibuka. Coba lagi.',
        );
      }
    }
  }

  void _onKeypadTap(String digit) {
    if (_ready && !_busy && _pin.length < 4) {
      final newPin = _pin + digit;
      setState(() => _pin = newPin);
      if (newPin.length == 4) {
        _verifyPin(newPin);
      }
    }
  }

  void _onBackspace() {
    if (_busy) return;
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  Future<void> _verifyPin(String inputPin) async {
    if (!_hasPin && _firstPin == null) {
      setState(() {
        _firstPin = inputPin;
        _pin = '';
        _error = null;
      });
      return;
    }
    if (!_hasPin && inputPin != _firstPin) {
      setState(() {
        _firstPin = null;
        _pin = '';
        _error = 'PIN tidak sama. Buat PIN kembali.';
      });
      return;
    }
    final session = _session;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final service = ref.read(pinServiceProvider);
      if (!_hasPin) {
        await service.setupNewPin(inputPin);
        if (mounted) setState(() => _hasPin = true);
      } else if (await service.validateStoredPin(inputPin)) {
        final records = await ref
            .read(medicalRecordRepositoryProvider)
            .getAll();
        if (mounted && session == _session && widget.active) {
          setState(() {
            _records = records;
            _isUnlocked = true;
          });
        }
      } else if (mounted) {
        setState(() => _error = 'PIN salah. Coba kembali.');
      }
    } on PinLockedException catch (error) {
      if (mounted) {
        final seconds = error.until.difference(DateTime.now()).inSeconds + 1;
        setState(
          () => _error = 'Terlalu banyak percobaan. Tunggu $seconds detik.',
        );
      }
    } catch (_) {
      if (mounted) {
        setState(
          () => _error = 'Verifikasi gagal. Akses tetap terkunci. Coba lagi.',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _pin = '';
          _firstPin = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return Scaffold(
        appBar: AppBar(title: const Text('Keamanan Rekam Medis')),
        body: Center(
          child: _error == null
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_error!, textAlign: TextAlign.center),
                    TextButton(
                      onPressed: _loadPin,
                      child: const Text('Coba lagi'),
                    ),
                  ],
                ),
        ),
      );
    }
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
              _lock();
              AppSnackBar.showInfo(context, 'Akses rekam medis telah dikunci');
            },
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_rounded),
            tooltip: 'Unduh EMR',
            onPressed: () {
              AppSnackBar.showSuccess(
                context,
                'Simulasi: ekspor PDF belum tersedia.',
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
                        'Prototipe M01: data sintetis dalam memori, belum untuk pelayanan pasien nyata.',
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
                Text(
                  _hasPin
                      ? 'Buka Rekam Medis dengan PIN'
                      : 'Buat PIN Rekam Medis',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _hasPin
                      ? 'Masukkan PIN 4 digit. Setelah 5 kesalahan, akses ditunda 30 detik.'
                      : _firstPin == null
                      ? 'Buat PIN 4 digit untuk prototipe ini. Gunakan PIN uji, bukan PIN pribadi.'
                      : 'Ulangi PIN untuk konfirmasi.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                if (_busy) const LinearProgressIndicator(),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Semantics(
                      liveRegion: true,
                      child: Text(
                        _error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.danger,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

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
                          tooltip: 'Biometrik belum tersedia',
                          onPressed: null,
                          icon: const Icon(
                            Icons.fingerprint_rounded,
                            size: 28,
                            color: AppColors.primary,
                          ),
                        ),
                        _buildKeypadButton('0'),
                        IconButton(
                          tooltip: 'Hapus digit PIN',
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
    return Semantics(
      label: 'Digit $digit',
      button: true,
      child: InkWell(
        onTap: _busy ? null : () => _onKeypadTap(digit),
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
      ),
    );
  }
}

class _MedicalRecordCard extends StatelessWidget {
  const _MedicalRecordCard({required this.entry});

  final MedicalRecord entry;

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
                    'Simulasi: ekspor PDF belum tersedia.',
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
