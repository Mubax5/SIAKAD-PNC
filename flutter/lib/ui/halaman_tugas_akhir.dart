import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/warna_aplikasi.dart';
import '../helper/rute_aplikasi.dart';
import '../helper/api_service.dart';

class HalamanTugasAkhir extends ConsumerWidget {
  const HalamanTugasAkhir({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final taAsync = ref.watch(tugasAkhirProvider);

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
          'Tugas Akhir',
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
        child: taAsync.when(
          loading: () => const Center(child: CircularProgressIndicator(color: WarnaAplikasi.utama)),
          error: (err, stack) => Center(child: Text('Gagal memuat data Tugas Akhir: $err')),
          data: (data) {
            final List<dynamic> timeline = data['timeline'] ?? [];
            final List<dynamic> catatan = data['catatan'] ?? [];
            final List<dynamic> notifikasi = data['notifikasi'] ?? [];

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  _bangunGridMetrik(user, data['ta_progres'] ?? 0),

                  const Gap(28),

                  
                  _bangunProgresTugasAkhir(context, data, timeline),

                  const Gap(28),

                  
                  _bangunCatatanDosen(catatan),

                  const Gap(28),

                  
                  _bangunNotifikasi(context, notifikasi),

                  const Gap(28),

                  
                  _bangunJadwalPertemuan(context),

                  const Gap(20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _bangunGridMetrik(Map<String, dynamic>? user, int taProgres) {
    final String ipk = '${user?['ipk'] ?? '3.85'}';
    final String sks = '${user?['sks_total'] ?? '124/144'}';
    final String semester = '${user?['semester'] ?? '7'}';

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _bangunKartuMetrik(
                judul: 'IPK Sementara',
                nilai: ipk,
                warnaIcon: WarnaAplikasi.sukses,
                warnaTint: WarnaAplikasi.suksesTint,
                icon: LucideIcons.trendingUp,
              ),
            ),
            const Gap(16),
            Expanded(
              child: _bangunKartuMetrik(
                judul: 'Total SKS',
                nilai: sks,
                warnaIcon: WarnaAplikasi.menuBiruIcon,
                warnaTint: WarnaAplikasi.menuBiruTint,
                icon: LucideIcons.bookOpen,
              ),
            ),
          ],
        ),
        const Gap(16),
        Row(
          children: [
            Expanded(
              child: _bangunKartuMetrik(
                judul: 'Semester',
                nilai: semester,
                warnaIcon: WarnaAplikasi.peringatan,
                warnaTint: WarnaAplikasi.peringatanTint,
                icon: LucideIcons.calendar,
              ),
            ),
            const Gap(16),
            Expanded(
              child: _bangunKartuMetrik(
                judul: 'Progres TA',
                nilai: '$taProgres%',
                warnaIcon: WarnaAplikasi.transkripIcon,
                warnaTint: WarnaAplikasi.transkripTint,
                icon: LucideIcons.fileCheck,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _bangunKartuMetrik({
    required String judul,
    required String nilai,
    required Color warnaIcon,
    required Color warnaTint,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  judul,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: WarnaAplikasi.teksSekunder,
                    fontFamily: 'Inter',
                  ),
                ),
                const Gap(6),
                Text(
                  nilai,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: WarnaAplikasi.teksUtama,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: warnaTint,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: warnaIcon,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bangunProgresTugasAkhir(BuildContext context, Map<String, dynamic> data, List<dynamic> timeline) {
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
            'Progres Tugas Akhir',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          Text(
            data['ta_judul'] ?? '',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(12),
          Row(
            children: [
              const Icon(LucideIcons.user, size: 14, color: WarnaAplikasi.teksSekunder),
              const Gap(8),
              Expanded(
                child: Text(
                  data['ta_dosen'] ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: WarnaAplikasi.teksSekunder,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
          const Gap(8),
          Row(
            children: [
              const Icon(LucideIcons.calendar, size: 14, color: WarnaAplikasi.teksSekunder),
              const Gap(8),
              Expanded(
                child: Text(
                  'Dimulai: ${data['ta_mulai']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: WarnaAplikasi.teksSekunder,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
          const Gap(24),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const Gap(24),

          if (timeline.isEmpty)
            const Text('Tidak ada langkah timeline.', style: TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder))
          else
            ...timeline.asMap().entries.map((entry) {
              final idx = entry.key;
              final item = entry.value;
              final isLast = idx == timeline.length - 1;
              return _bangunLangkahTimeline(
                no: item['step_no'],
                judul: item['judul'],
                sub: item['sub'],
                status: item['status'],
                isLast: isLast,
              );
            }),
        ],
      ),
    );
  }

  Widget _bangunLangkahTimeline({
    required String no,
    required String judul,
    required String sub,
    required String status,
    bool isLast = false,
  }) {
    Color stepColor;
    Widget stepWidget;

    if (status == 'selesai') {
      stepColor = WarnaAplikasi.sukses;
      stepWidget = Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: WarnaAplikasi.suksesTint,
          shape: BoxShape.circle,
        ),
        child: const Icon(LucideIcons.check, size: 12, color: WarnaAplikasi.sukses),
      );
    } else if (status == 'berjalan') {
      stepColor = WarnaAplikasi.krsIcon;
      stepWidget = Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: WarnaAplikasi.krsTint,
          shape: BoxShape.circle,
        ),
        child: const Icon(LucideIcons.clock, size: 12, color: WarnaAplikasi.krsIcon),
      );
    } else if (status == 'jadwal') {
      stepColor = WarnaAplikasi.teksSekunder;
      stepWidget = Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: WarnaAplikasi.abuMuda,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            no,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksSekunder,
              fontFamily: 'Inter',
            ),
          ),
        ),
      );
    } else {
      stepColor = WarnaAplikasi.teksSekunder.withValues(alpha: 0.4);
      stepWidget = Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: WarnaAplikasi.abuMuda.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            no,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksSekunder.withValues(alpha: 0.5),
              fontFamily: 'Inter',
            ),
          ),
        ),
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              stepWidget,
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: stepColor.withValues(alpha: 0.3),
                  ),
                ),
            ],
          ),
          const Gap(16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: WarnaAplikasi.teksUtama,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const Gap(4),
                  Text(
                    sub,
                    style: const TextStyle(
                      fontSize: 11,
                      color: WarnaAplikasi.teksSekunder,
                      fontFamily: 'Inter',
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

  Widget _bangunCatatanDosen(List<dynamic> catatan) {
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
            'Catatan Online Dosen Pembimbing',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          if (catatan.isEmpty)
            const Text('Tidak ada catatan bimbingan.', style: TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter'))
          else
            ...catatan.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _bangunKartuCatatan(
                  tanggal: item['tanggal'],
                  catatan: item['catatan'],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _bangunKartuCatatan({required String tanggal, required String catatan}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: WarnaAplikasi.infoTint,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: WarnaAplikasi.krsTint),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tanggal,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.krsIcon,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(6),
          Text(
            catatan,
            style: const TextStyle(
              fontSize: 11,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bangunNotifikasi(BuildContext context, List<dynamic> notifList) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              if (notifList.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: WarnaAplikasi.bahaya,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${notifList.length} Baru',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
            ],
          ),
          const Gap(16),
          if (notifList.isEmpty)
            const Text('Tidak ada notifikasi baru.', style: TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter'))
          else
            ...notifList.map((item) {
              final type = item['type'];
              Color dotColor = WarnaAplikasi.krsIcon;
              Color bgColor = WarnaAplikasi.krsTint;
              if (type == 'bahaya') {
                dotColor = WarnaAplikasi.bahaya;
                bgColor = WarnaAplikasi.bahayaTint;
              } else if (type == 'peringatan') {
                dotColor = WarnaAplikasi.peringatan;
                bgColor = WarnaAplikasi.peringatanTint;
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _bangunItemNotif(
                  judul: item['judul'],
                  sub: item['sub'],
                  waktu: item['waktu'],
                  dotColor: dotColor,
                  bgColor: bgColor,
                ),
              );
            }),
          const Gap(4),
          Center(
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Membuka semua notifikasi...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                'Lihat Semua Notifikasi',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: WarnaAplikasi.krsIcon,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bangunItemNotif({
    required String judul,
    required String sub,
    required String waktu,
    required Color dotColor,
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
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
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
                    fontSize: 11,
                    color: WarnaAplikasi.teksSekunder,
                    fontFamily: 'Inter',
                  ),
                ),
                const Gap(4),
                Text(
                  waktu,
                  style: const TextStyle(
                    fontSize: 9,
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

  Widget _bangunJadwalPertemuan(BuildContext context) {
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
            'Jadwal Pertemuan',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Membuka jadwal pertemuan bimbingan...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              backgroundColor: WarnaAplikasi.suksesTint,
              foregroundColor: WarnaAplikasi.sukses,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFC2F0D5)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(LucideIcons.calendar, size: 16, color: WarnaAplikasi.sukses),
                Gap(8),
                Text(
                  'Lihat Jadwal Pertemuan',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
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
