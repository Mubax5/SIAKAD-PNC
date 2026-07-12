import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/warna_aplikasi.dart';
import '../helper/rute_aplikasi.dart';
import '../helper/api_service.dart';

class HalamanNilaiTranskrip extends ConsumerStatefulWidget {
  const HalamanNilaiTranskrip({super.key});

  @override
  ConsumerState<HalamanNilaiTranskrip> createState() => _HalamanNilaiTranskripState();
}

class _HalamanNilaiTranskripState extends ConsumerState<HalamanNilaiTranskrip> {
  bool _isDownloading = false;

  void _simulasiDownload(String jenisDokumen) {
    setState(() {
      _isDownloading = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Memulai pengunduhan $jenisDokumen...'),
        duration: const Duration(seconds: 1),
      ),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$jenisDokumen berhasil diunduh!'),
            backgroundColor: WarnaAplikasi.sukses,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    final nilaiAsync = ref.watch(nilaiProvider);
    final int semester = user?['semester'] ?? 3;

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
          'Nilai & Transkrip',
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
        child: _isDownloading
            ? const Center(
                child: CircularProgressIndicator(
                  color: WarnaAplikasi.utama,
                ),
              )
            : nilaiAsync.when(
                loading: () => const Center(child: CircularProgressIndicator(color: WarnaAplikasi.utama)),
                error: (err, stack) => Center(child: Text('Gagal memuat data nilai: $err')),
                data: (nilaiList) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        _bangunNilaiMataKuliah(semester, nilaiList),

                        const Gap(28),

                        
                        _bangunUnduhTranskrip(),

                        const Gap(20),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _bangunNilaiMataKuliah(int semester, List<Map<String, dynamic>> nilaiList) {
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
              const Expanded(
                child: Text(
                  'Nilai Mata Kuliah',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: WarnaAplikasi.teksUtama,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Membuka pencarian/filter nilai...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: WarnaAplikasi.abuMuda,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: const [
                      Icon(LucideIcons.sliders, size: 12, color: WarnaAplikasi.teksSekunder),
                      Gap(6),
                      Text(
                        'Cari',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
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
          const Gap(4),
          Text(
            'Semester $semester - Tahun 2025',
            style: const TextStyle(
              fontSize: 12,
              color: WarnaAplikasi.teksSekunder,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(20),

          if (nilaiList.isEmpty)
            const Text(
              'Tidak ada data nilai untuk semester ini.',
              style: TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter'),
            )
          else
            ...nilaiList.map((item) {
              final isGraded = item['is_graded'] == 1 || item['is_graded'] == true;
              final Color highlightColor = Color(int.parse(item['highlight_color'].replaceAll('FF', ''), radix: 16) | 0xFF000000);
              final Color statusColor = Color(int.parse(item['status_color'].replaceAll('FF', ''), radix: 16) | 0xFF000000);
              final Color statusBg = Color(int.parse(item['status_bg'].replaceAll('FF', ''), radix: 16) | 0xFF000000);

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _bangunKartuMataKuliah(
                  kode: item['kode'],
                  sks: item['sks'],
                  nama: item['nama'],
                  predikat: item['predikat'],
                  isGraded: isGraded,
                  highlightColor: highlightColor,
                  statusText: item['status_text'],
                  statusColor: statusColor,
                  statusBg: statusBg,
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _bangunKartuMataKuliah({
    required String kode,
    required String sks,
    required String nama,
    required String predikat,
    required bool isGraded,
    required Color highlightColor,
    required String statusText,
    required Color statusColor,
    required Color statusBg,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: highlightColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: WarnaAplikasi.krsIcon,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Gap(8),
                              Text(
                                '$kode  |  $sks SKS',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: WarnaAplikasi.teksSekunder,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                          const Gap(8),
                          Text(
                            nama,
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
                              ElevatedButton(
                                onPressed: () {
                                  _showDetailDialog(kode, nama, predikat, '$sks SKS');
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  backgroundColor: WarnaAplikasi.utama,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: const Text(
                                  'Detail',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Predikat',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: WarnaAplikasi.teksSekunder,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const Gap(4),
                        Text(
                          predikat,
                          style: TextStyle(
                            fontSize: predikat.length > 1 ? 26 : 32,
                            fontWeight: FontWeight.bold,
                            color: isGraded ? WarnaAplikasi.teksUtama : WarnaAplikasi.teksSekunder,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
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

  Widget _bangunUnduhTranskrip() {
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
            'Unduh Transkrip',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          _bangunItemDownload(
            judul: 'Semester Saat Ini (KHS)',
            sub: 'Unduh transkrip semester',
            iconData: LucideIcons.fileDown,
            onTap: () => _simulasiDownload('Semester Saat Ini (KHS)'),
          ),
          const Gap(12),
          _bangunItemDownload(
            judul: 'Transkrip Resmi',
            sub: 'Rekam akademik lengkap',
            iconData: LucideIcons.fileText,
            onTap: () => _simulasiDownload('Transkrip Resmi'),
          ),
          const Gap(12),
          _bangunItemDownload(
            judul: 'Laporan Nilai',
            sub: 'Analisis nilai rinci',
            iconData: LucideIcons.barChart2,
            onTap: () => _simulasiDownload('Laporan Nilai'),
          ),
        ],
      ),
    );
  }

  Widget _bangunItemDownload({
    required String judul,
    required String sub,
    required IconData iconData,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFCBD5E1),
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: WarnaAplikasi.teksSekunder,
              size: 24,
            ),
            const Gap(16),
            Expanded(
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
                      fontSize: 10,
                      color: WarnaAplikasi.teksSekunder,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              LucideIcons.chevronRight,
              size: 16,
              color: WarnaAplikasi.teksSekunder,
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailDialog(String kode, String nama, String predikat, String sks) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            kode,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nama,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              const Gap(12),
              Text(
                'Bobot SKS: $sks',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: WarnaAplikasi.teksSekunder,
                ),
              ),
              const Gap(8),
              Text(
                'Predikat Nilai: $predikat',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: WarnaAplikasi.teksSekunder,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Tutup',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
