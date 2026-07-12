import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/warna_aplikasi.dart';
import '../helper/rute_aplikasi.dart';
import '../helper/api_service.dart';

class HalamanSurat extends ConsumerWidget {
  const HalamanSurat({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suratAsync = ref.watch(suratProvider);

    return Scaffold(
      backgroundColor: WarnaAplikasi.latarBelakang,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Color(0xFF0F172A)),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(RuteAplikasi.utama);
            }
          },
        ),
        title: const Text(
          'Surat & Administrasi',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: WarnaAplikasi.teksUtama,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              _bangunGridPengajuan(context),

              const Gap(28),

              
              _bangunPermohonanTerbaru(context, suratAsync),

              const Gap(28),

              
              _bangunAksiCepat(context),

              const Gap(28),

              
              _bangunNotifikasiAdministrasi(),

              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bangunGridPengajuan(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _bangunKartuPengajuan(
                context: context,
                judul: 'Pengajuan Cuti',
                status: 'Tersedia',
                statusBg: WarnaAplikasi.suksesTint,
                statusTextColor: WarnaAplikasi.sukses,
                iconData: LucideIcons.pause,
                iconColor: WarnaAplikasi.menuBiruIcon,
                iconBg: WarnaAplikasi.menuBiruTint,
              ),
            ),
            const Gap(16),
            Expanded(
              child: _bangunKartuPengajuan(
                context: context,
                judul: 'Pengajuan Transkrip',
                status: 'Tersedia',
                statusBg: WarnaAplikasi.suksesTint,
                statusTextColor: WarnaAplikasi.sukses,
                iconData: LucideIcons.fileCheck,
                iconColor: WarnaAplikasi.presensiIcon,
                iconBg: WarnaAplikasi.presensiTint,
              ),
            ),
          ],
        ),
        const Gap(16),
        Row(
          children: [
            Expanded(
              child: _bangunKartuPengajuan(
                context: context,
                judul: 'Surat Keterangan Aktif',
                status: 'Tersedia',
                statusBg: WarnaAplikasi.suksesTint,
                statusTextColor: WarnaAplikasi.sukses,
                iconData: LucideIcons.contact,
                iconColor: WarnaAplikasi.transkripIcon,
                iconBg: WarnaAplikasi.transkripTint,
              ),
            ),
            const Gap(16),
            Expanded(
              child: _bangunKartuPengajuan(
                context: context,
                judul: 'Pendaftaran Wisuda',
                status: 'Cek Persyaratan',
                statusBg: WarnaAplikasi.peringatanTint,
                statusTextColor: WarnaAplikasi.peringatan,
                iconData: LucideIcons.graduationCap,
                iconColor: WarnaAplikasi.menuOranyeIcon,
                iconBg: WarnaAplikasi.menuOranyeTint,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _bangunKartuPengajuan({
    required BuildContext context,
    required String judul,
    required String status,
    required Color statusBg,
    required Color statusTextColor,
    required IconData iconData,
    required Color iconColor,
    required Color iconBg,
  }) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Memulai pengajuan $judul...'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                color: iconColor,
                size: 24,
              ),
            ),
            const Gap(14),
            Text(
              judul,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: WarnaAplikasi.teksUtama,
                fontFamily: 'Inter',
                height: 1.2,
              ),
            ),
            const Gap(10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: statusTextColor,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bangunPermohonanTerbaru(BuildContext context, AsyncValue<List<Map<String, dynamic>>> suratAsync) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Permohonan Terbaru',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          suratAsync.when(
            loading: () => const Center(child: CircularProgressIndicator(color: WarnaAplikasi.utama)),
            error: (err, stack) => Text('Gagal memuat: $err'),
            data: (list) {
              if (list.isEmpty) {
                return const Text(
                  'Tidak ada permohonan terbaru.',
                  style: TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter'),
                );
              }
              return Column(
                children: list.map((item) {
                  final jenis = item['jenis_surat'];
                  final status = item['status'];
                  final date = item['tanggal_diajukan'];

                  IconData leftIcon = LucideIcons.fileCheck;
                  Color leftIconColor = WarnaAplikasi.sukses;
                  Color leftIconBg = WarnaAplikasi.suksesTint;
                  Widget rightWidget = const SizedBox();

                  Color statusColor = WarnaAplikasi.sukses;
                  Color statusBg = WarnaAplikasi.suksesTint;

                  if (status == 'Diproses') {
                    statusColor = WarnaAplikasi.peringatan;
                    statusBg = WarnaAplikasi.peringatanTint;
                    leftIcon = LucideIcons.contact;
                    leftIconColor = WarnaAplikasi.krsIcon;
                    leftIconBg = WarnaAplikasi.krsTint;
                    rightWidget = const Icon(LucideIcons.clock, color: WarnaAplikasi.teksSekunder, size: 18);
                  } else if (status == 'Ditolak') {
                    statusColor = WarnaAplikasi.bahaya;
                    statusBg = WarnaAplikasi.bahayaTint;
                    leftIcon = LucideIcons.pause;
                    leftIconColor = WarnaAplikasi.transkripIcon;
                    leftIconBg = WarnaAplikasi.transkripTint;
                    rightWidget = const Icon(LucideIcons.info, color: WarnaAplikasi.teksSekunder, size: 18);
                  } else {
                    rightWidget = IconButton(
                      icon: const Icon(LucideIcons.download, color: WarnaAplikasi.krsIcon, size: 18),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Mengunduh dokumen $jenis...'),
                          ),
                        );
                      },
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _bangunItemPermohonan(
                      judul: jenis,
                      tanggal: date,
                      statusText: status,
                      statusColor: statusColor,
                      statusBg: statusBg,
                      leftIcon: leftIcon,
                      leftIconColor: leftIconColor,
                      leftIconBg: leftIconBg,
                      rightWidget: rightWidget,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _bangunItemPermohonan({
    required String judul,
    required String tanggal,
    required String statusText,
    required Color statusColor,
    required Color statusBg,
    required IconData leftIcon,
    required Color leftIconColor,
    required Color leftIconBg,
    required Widget rightWidget,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: leftIconBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            leftIcon,
            color: leftIconColor,
            size: 20,
          ),
        ),
        const Gap(14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: WarnaAplikasi.teksUtama,
                  fontFamily: 'Inter',
                ),
              ),
              const Gap(4),
              Text(
                tanggal,
                style: const TextStyle(
                  fontSize: 10,
                  color: WarnaAplikasi.teksSekunder,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
        const Gap(12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusBg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: statusColor,
              fontFamily: 'Inter',
            ),
          ),
        ),
        const Gap(12),
        rightWidget,
      ],
    );
  }

  Widget _bangunAksiCepat(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Aksi Cepat',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          _bangunItemAksiCepat(
            context: context,
            label: 'Lihat Jadwal',
            iconData: LucideIcons.calendar,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Membuka Jadwal Kuliah...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          const Gap(12),
          _bangunItemAksiCepat(
            context: context,
            label: 'Cek Nilai',
            iconData: LucideIcons.trendingUp,
            onTap: () {
              context.push(RuteAplikasi.nilaiTranskrip);
            },
          ),
          const Gap(12),
          _bangunItemAksiCepat(
            context: context,
            label: 'Status Pembayaran',
            iconData: LucideIcons.creditCard,
            onTap: () {
              context.push(RuteAplikasi.keuangan);
            },
          ),
        ],
      ),
    );
  }

  Widget _bangunItemAksiCepat({
    required BuildContext context,
    required String label,
    required IconData iconData,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: WarnaAplikasi.latarBelakang,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Icon(iconData, color: WarnaAplikasi.krsIcon, size: 16),
            const Gap(12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: WarnaAplikasi.teksUtama,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const Icon(LucideIcons.chevronRight, size: 16, color: WarnaAplikasi.teksSekunder),
          ],
        ),
      ),
    );
  }

  Widget _bangunNotifikasiAdministrasi() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notifikasi',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          _bangunItemNotifAdmin(
            judul: 'Transkrip Siap',
            sub: 'Pengajuan transkrip Anda telah diproses',
            iconData: LucideIcons.info,
            iconColor: WarnaAplikasi.krsIcon,
            bgColor: WarnaAplikasi.infoTint,
          ),
          const Gap(12),
          _bangunItemNotifAdmin(
            judul: 'Pengingat Pembayaran',
            sub: 'Pembayaran UKT jatuh tempo dalam 5 hari',
            iconData: LucideIcons.alertTriangle,
            iconColor: WarnaAplikasi.peringatan,
            bgColor: WarnaAplikasi.peringatanTint,
          ),
          const Gap(12),
          _bangunItemNotifAdmin(
            judul: 'Registrasi Mata Kuliah',
            sub: 'Berhasil registrasi untuk semester berikutnya',
            iconData: LucideIcons.checkCircle,
            iconColor: WarnaAplikasi.sukses,
            bgColor: WarnaAplikasi.suksesTint,
          ),
        ],
      ),
    );
  }

  Widget _bangunItemNotifAdmin({
    required String judul,
    required String sub,
    required IconData iconData,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: iconColor,
            size: 18,
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: WarnaAplikasi.teksUtama,
                    fontFamily: 'Inter',
                  ),
                ),
                const Gap(4),
                Text(
                  sub,
                  style: const TextStyle(
                    fontSize: 10,
                    color: WarnaAplikasi.teksSekunder,
                    fontFamily: 'Inter',
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
