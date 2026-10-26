import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_shadows.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/app_cards.dart';
import '../../../../shared/widgets/app_dialogs.dart';

class ConsultationPage extends StatefulWidget {
  const ConsultationPage({super.key});

  @override
  State<ConsultationPage> createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
  int _tabIndex = 0; // 0: Konselor & Psikolog, 1: Chat Konsultasi

  final List<_ChatMessage> _messages = [
    _ChatMessage(
      sender: 'Nurlaila Sari, M.Psi., Psikolog',
      text:
          'Halo Ahmad, selamat datang di layanan konseling Klinik UAD. Ruang ini dijamin kerahasiaannya. Bagaimana kabarmu hari ini?',
      time: '14:00',
      isMe: false,
    ),
    _ChatMessage(
      sender: 'Ahmad Nur Hidayat',
      text:
          'Halo Ibu Nurlaila. Akhir-akhir ini saya merasa cukup kewalahan membagi waktu antara tugas akhir skripsi dan jadwal magang kampus.',
      time: '14:02',
      isMe: true,
    ),
    _ChatMessage(
      sender: 'Nurlaila Sari, M.Psi., Psikolog',
      text:
          'Terima kasih sudah mau berbagi, Ahmad. Perasaan kewalahan itu sangat wajar di fase ini. Mari kita pelan-pelan urai beban pikiranmu bersama ya.',
      time: '14:03',
      isMe: false,
    ),
  ];

  final TextEditingController _chatController = TextEditingController();

  void _sendMessage() {
    if (_chatController.text.trim().isEmpty) return;
    setState(() {
      _messages.add(
        _ChatMessage(
          sender: 'Ahmad Nur Hidayat',
          text: _chatController.text.trim(),
          time: '14:05',
          isMe: true,
        ),
      );
    });
    _chatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Konseling & Psikologi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'Kebijakan Kerahasiaan',
            onPressed: () {
              AppDialog.showConfirmation(
                context: context,
                title: 'Kerahasiaan Terjamin',
                message:
                    'Konseling di Klinik UAD mematuhi Kode Etik Psikologi Indonesia. Data percakapan dienkripsi end-to-end dan tidak dibagikan ke pihak akademik.',
                confirmLabel: 'Mengerti',
                icon: Icons.verified_user_rounded,
                confirmColor: AppColors.primary,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Sub-Tab Switcher
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: _TabButton(
                    title: 'Daftar Psikolog',
                    isSelected: _tabIndex == 0,
                    onTap: () => setState(() => _tabIndex = 0),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _TabButton(
                    title: 'Sesi Chat Aktif',
                    isSelected: _tabIndex == 1,
                    onTap: () => setState(() => _tabIndex = 1),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),

          // Body Views
          Expanded(
            child: _tabIndex == 0 ? _buildPsychologistList() : _buildChatView(),
          ),
        ],
      ),
    );
  }

  Widget _buildPsychologistList() {
    const psychologists = [
      (
        name: 'Nurlaila Sari, M.Psi., Psikolog',
        specialty: 'Psikolog Klinis & Konseling Remaja',
        tags: ['Manajemen Stres', 'Masalah Akademik', 'Kecemasan'],
        rating: 5.0,
        experience: '6 tahun',
        available: 'Hari Ini · 14:00 - 17:00 WIB',
        initials: 'NS',
        color: Color(0xFF8E24AA),
      ),
      (
        name: 'Rahmat Hidayat, M.Psi., Psikolog',
        specialty: 'Psikolog Perkembangan & Karir',
        tags: ['Pengembangan Diri', 'Motivasi Belajar', 'Relasi Sosial'],
        rating: 4.9,
        experience: '8 tahun',
        available: 'Besok · 09:00 - 12:00 WIB',
        initials: 'RH',
        color: AppColors.primary,
      ),
    ];

    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Security Badge
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withAlpha(40)),
            ),
            child: const Row(
              children: [
                Icon(Icons.shield_outlined, color: AppColors.primary, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Layanan Konseling Rahasia & Terenkripsi Kampus UAD.\nPrivasi cerita Anda 100% terjaga dan aman.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDark,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const SectionHeader(
            title: 'Tim Psikolog Profesional',
            subtitle:
                'Konselor berlisensi siap mendengarkan dan mendampingi Anda',
          ),
          const SizedBox(height: 12),

          for (final p in psychologists) ...[
            AppCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: p.color.withAlpha(25),
                        child: Text(
                          p.initials,
                          style: TextStyle(
                            color: p.color,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              p.specialty,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  size: 16,
                                  color: Color(0xFFFFB300),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  '${p.rating}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '· ${p.experience}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Topic Tags
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: p.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 14),
                  const Divider(color: AppColors.border, height: 1),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule_rounded,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            p.available,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      AppPrimaryButton(
                        text: 'Mulai Konsultasi',
                        height: 36,
                        onPressed: () {
                          setState(() => _tabIndex = 1);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }

  Widget _buildChatView() {
    return Column(
      children: [
        // Active Chat Header Banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: AppColors.surfaceSubtle,
          child: Row(
            children: [
              const Icon(
                Icons.lock_rounded,
                size: 14,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'Sesi Konseling Aktif · drg/Psi. Nurlaila Sari · Enkripsi 256-bit',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  AppDialog.showConfirmation(
                    context: context,
                    title: 'Akhiri Sesi Konseling?',
                    message:
                        'Apakah Anda ingin menyelesaikan sesi konsultasi ini?',
                    confirmLabel: 'Akhiri',
                    confirmColor: AppColors.danger,
                  );
                },
                child: const Text(
                  'Selesai',
                  style: TextStyle(fontSize: 12, color: AppColors.danger),
                ),
              ),
            ],
          ),
        ),

        // Messages List
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final msg = _messages[index];
              return Align(
                alignment: msg.isMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.78,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: msg.isMe ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(msg.isMe ? 16 : 4),
                      bottomRight: Radius.circular(msg.isMe ? 4 : 16),
                    ),
                    boxShadow: AppShadows.subtle,
                    border: msg.isMe
                        ? null
                        : Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: msg.isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        msg.text,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: msg.isMe
                              ? Colors.white
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        msg.time,
                        style: TextStyle(
                          fontSize: 10,
                          color: msg.isMe
                              ? Colors.white70
                              : AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Quick Suggestions
        SizedBox(
          height: 38,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              _QuickReplyChip(
                label: 'Tentu, terima kasih banyak Ibu.',
                onTap: () =>
                    _chatController.text = 'Tentu, terima kasih banyak Ibu.',
              ),
              _QuickReplyChip(
                label: 'Saya ingin tips mengatasi panik saat presentasi.',
                onTap: () => _chatController.text =
                    'Saya ingin tips mengatasi panik saat presentasi.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Chat Input Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _chatController,
                      decoration: const InputDecoration(
                        hintText: 'Ketik pesan konseling rahasia...',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(
                    Icons.send_rounded,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({
    required this.sender,
    required this.text,
    required this.time,
    required this.isMe,
  });

  final String sender;
  final String text;
  final String time;
  final bool isMe;
}

class _QuickReplyChip extends StatelessWidget {
  const _QuickReplyChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textPrimary),
        ),
        backgroundColor: Colors.white,
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: onTap,
      ),
    );
  }
}
