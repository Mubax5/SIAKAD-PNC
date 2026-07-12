import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/warna_aplikasi.dart';
import '../helper/rute_aplikasi.dart';
import '../helper/api_service.dart';

class HalamanMbkm extends ConsumerStatefulWidget {
  const HalamanMbkm({super.key});

  @override
  ConsumerState<HalamanMbkm> createState() => _HalamanMbkmState();
}

class _HalamanMbkmState extends ConsumerState<HalamanMbkm> {
  bool _isUploading = false;

  void _simulasiUpload(String judulLaporan) {
    setState(() {
      _isUploading = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mengunggah $judulLaporan...'),
        duration: const Duration(seconds: 1),
      ),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Laporan berhasil diunggah!'),
            backgroundColor: WarnaAplikasi.sukses,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mbkmAsync = ref.watch(mbkmProvider);

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
          'MBKM',
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
        child: _isUploading
            ? const Center(
                child: CircularProgressIndicator(
                  color: WarnaAplikasi.utama,
                ),
              )
            : mbkmAsync.when(
                loading: () => const Center(child: CircularProgressIndicator(color: WarnaAplikasi.utama)),
                error: (err, stack) => Center(child: Text('Gagal memuat MBKM: $err')),
                data: (data) {
                  final List<dynamic> magang = data['magang'] ?? [];
                  final List<dynamic> evaluasi = data['evaluasi'] ?? [];
                  final List<dynamic> laporan = data['laporan'] ?? [];
                  final List<dynamic> deadline = data['deadline'] ?? [];

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        _bangunProgramMagang(magang),

                        const Gap(28),

                        
                        _bangunEvaluasi(evaluasi),

                        const Gap(28),

                        
                        _bangunLaporanTerbaru(laporan),

                        const Gap(28),

                        
                        _bangunTenggatWaktu(deadline),

                        const Gap(28),

                        
                        _bangunAksiCepatMagang(),

                        const Gap(20),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _bangunProgramMagang(List<dynamic> magangList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Program Magang Saat Ini',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: WarnaAplikasi.teksUtama,
                fontFamily: 'Inter',
              ),
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Membuka pendaftaran program baru...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: WarnaAplikasi.krsTint,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Icon(LucideIcons.plus, size: 12, color: WarnaAplikasi.krsIcon),
                    Gap(4),
                    Text(
                      'Daftar Baru',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: WarnaAplikasi.krsIcon,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Gap(16),
        if (magangList.isEmpty)
          const Text('Tidak ada program magang aktif.', style: TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder))
        else
          ...magangList.map((item) {
            final String status = item['status'];
            final Color statusColor = Color(int.parse(item['color'].replaceAll('FF', ''), radix: 16) | 0xFF000000);
            final Color statusBg = status == 'Aktif' ? WarnaAplikasi.suksesTint : WarnaAplikasi.krsTint;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _bangunKartuMagang(
                posisi: item['posisi'],
                instansi: item['instansi'],
                durasi: item['durasi'],
                progres: (item['progres'] as num).toDouble(),
                persenText: item['persen'],
                statusText: status,
                statusColor: statusColor,
                statusBg: statusBg,
                onUpload: () => _simulasiUpload('Laporan (PT. Tech Solutions)'),
              ),
            );
          }),
      ],
    );
  }

  Widget _bangunKartuMagang({
    required String posisi,
    required String instansi,
    required String durasi,
    required double progres,
    required String persenText,
    required String statusText,
    required Color statusColor,
    required Color statusBg,
    required VoidCallback onUpload,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      posisi,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: WarnaAplikasi.teksUtama,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const Gap(4),
                    Text(
                      instansi,
                      style: const TextStyle(
                        fontSize: 11,
                        color: WarnaAplikasi.teksSekunder,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
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
            ],
          ),
          const Gap(16),
          const Text(
            'Durasi',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: WarnaAplikasi.teksSekunder,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(4),
          Text(
            durasi,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(12),
          const Text(
            'Progres',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: WarnaAplikasi.teksSekunder,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(6),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progres,
                  backgroundColor: const Color(0xFFE2E8F0),
                  color: statusColor,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const Gap(12),
              Text(
                persenText,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: WarnaAplikasi.teksUtama,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onUpload,
                  icon: const Icon(LucideIcons.uploadCloud, size: 14),
                  label: const Text(
                    'Unggah Laporan',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: WarnaAplikasi.abuMuda,
                    foregroundColor: WarnaAplikasi.teksUtama,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Membuka rincian magang untuk $posisi...'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(LucideIcons.eye, size: 14),
                  label: const Text(
                    'Lihat Detail',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: WarnaAplikasi.utama,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bangunEvaluasi(List<dynamic> evaluasiList) {
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
            'Evaluasi',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          if (evaluasiList.isEmpty)
            const Text('Belum ada evaluasi dari pembimbing.', style: TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder))
          else
            ...evaluasiList.map((item) {
              final Color highlightColor = Color(int.parse(item['highlight'].replaceAll('FF', ''), radix: 16) | 0xFF000000);
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _bangunItemEvaluasi(
                  nama: item['nama'],
                  role: item['role'],
                  komentar: item['komentar'],
                  rating: item['rating'],
                  highlightColor: highlightColor,
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _bangunItemEvaluasi({
    required String nama,
    required String role,
    required String komentar,
    required String rating,
    required Color highlightColor,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: highlightColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            nama,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: WarnaAplikasi.teksUtama,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        const Gap(8),
                        Row(
                          children: [
                            const Icon(LucideIcons.star, size: 12, color: Colors.orange),
                            const Gap(4),
                            Text(
                              rating,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: WarnaAplikasi.teksUtama,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Gap(2),
                    Text(
                      role,
                      style: const TextStyle(
                        fontSize: 10,
                        color: WarnaAplikasi.teksSekunder,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const Gap(8),
                    Text(
                      komentar,
                      style: const TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: WarnaAplikasi.teksUtama,
                        fontFamily: 'Inter',
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bangunLaporanTerbaru(List<dynamic> laporanList) {
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
            'Laporan Terbaru',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          if (laporanList.isEmpty)
            const Text('Belum ada laporan yang diunggah.', style: TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder))
          else
            ...laporanList.map((item) {
              final type = item['type'];
              IconData iconData = LucideIcons.check;
              Color iconColor = WarnaAplikasi.sukses;
              Color iconBg = WarnaAplikasi.suksesTint;
              if (type == 'peringatan') {
                iconData = LucideIcons.clock;
                iconColor = WarnaAplikasi.peringatan;
                iconBg = WarnaAplikasi.peringatanTint;
              } else if (type == 'info') {
                iconColor = WarnaAplikasi.krsIcon;
                iconBg = WarnaAplikasi.krsTint;
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: _bangunItemLaporan(
                  judul: item['judul'],
                  sub: item['sub'],
                  status: item['status'],
                  statusColor: item['status'] == 'Disetujui' ? WarnaAplikasi.sukses : WarnaAplikasi.peringatan,
                  statusBg: item['status'] == 'Disetujui' ? WarnaAplikasi.suksesTint : WarnaAplikasi.peringatanTint,
                  iconData: iconData,
                  iconColor: iconColor,
                  iconBg: iconBg,
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _bangunItemLaporan({
    required String judul,
    required String sub,
    required String status,
    required Color statusColor,
    required Color statusBg,
    required IconData iconData,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            color: iconColor,
            size: 16,
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
        const Gap(12),
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
              color: statusColor,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }

  Widget _bangunTenggatWaktu(List<dynamic> deadlineList) {
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
            'Tenggat Waktu',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          if (deadlineList.isEmpty)
            const Text('Tidak ada tenggat waktu terdekat.', style: TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder))
          else
            ...deadlineList.map((item) {
              final type = item['type'];
              Color bgColor = WarnaAplikasi.infoTint;
              Color dotColor = WarnaAplikasi.krsIcon;
              if (type == 'bahaya') {
                bgColor = WarnaAplikasi.bahayaTint;
                dotColor = WarnaAplikasi.bahaya;
              } else if (type == 'peringatan') {
                bgColor = WarnaAplikasi.peringatanTint;
                dotColor = WarnaAplikasi.peringatan;
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _bangunItemTenggat(
                  judul: item['judul'],
                  sub: item['sub'],
                  bgColor: bgColor,
                  dotColor: dotColor,
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _bangunItemTenggat({
    required String judul,
    required String sub,
    required Color bgColor,
    required Color dotColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
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
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
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

  Widget _bangunAksiCepatMagang() {
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
          _bangunTombolAksiCepat(
            label: 'Daftar Program Baru',
            iconData: LucideIcons.plus,
            bgColor: WarnaAplikasi.utama,
            textColor: Colors.white,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Membuka formulir pendaftaran program baru...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          const Gap(12),
          _bangunTombolAksiCepat(
            label: 'Unggah Laporan',
            iconData: LucideIcons.uploadCloud,
            bgColor: WarnaAplikasi.abuMuda,
            textColor: WarnaAplikasi.teksUtama,
            onTap: () => _simulasiUpload('Laporan Tambahan'),
          ),
          const Gap(12),
          _bangunTombolAksiCepat(
            label: 'Jadwalkan Pertemuan',
            iconData: LucideIcons.calendar,
            bgColor: WarnaAplikasi.abuMuda,
            textColor: WarnaAplikasi.teksUtama,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Membuka formulir penjadwalan pertemuan...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          const Gap(12),
          _bangunTombolAksiCepat(
            label: 'Unduh Sertifikat',
            iconData: LucideIcons.download,
            bgColor: WarnaAplikasi.abuMuda,
            textColor: WarnaAplikasi.teksUtama,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Memulai pengunduhan Sertifikat Magang...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _bangunTombolAksiCepat({
    required String label,
    required IconData iconData,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(iconData, size: 16),
      label: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: bgColor,
        foregroundColor: textColor,
        elevation: 0,
        minimumSize: const Size(double.infinity, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: bgColor == WarnaAplikasi.abuMuda
              ? const BorderSide(color: Color(0xFFCBD5E1))
              : BorderSide.none,
        ),
      ),
    );
  }
}
