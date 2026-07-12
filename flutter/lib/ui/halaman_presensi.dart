import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/warna_aplikasi.dart';
import '../helper/api_service.dart';

class HalamanPresensi extends ConsumerStatefulWidget {
  const HalamanPresensi({super.key});

  @override
  ConsumerState<HalamanPresensi> createState() => _HalamanPresensiState();
}

class _HalamanPresensiState extends ConsumerState<HalamanPresensi> {
  @override
  Widget build(BuildContext context) {
    final presensiAsync = ref.watch(presensiProvider);

    return Scaffold(
      backgroundColor: WarnaAplikasi.latarBelakang,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Presensi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: WarnaAplikasi.teksUtama,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: presensiAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: WarnaAplikasi.utama),
          ),
          error: (err, stack) => Center(
            child: Text(
              'Gagal memuat data presensi: $err',
              style: const TextStyle(fontFamily: 'Inter'),
            ),
          ),
          data: (data) {
            final List<dynamic> presensiCepat = data['presensi_cepat'] ?? [];
            final List<dynamic> presensiPerMk = data['presensi_per_mk'] ?? [];
            final List<dynamic> aktivitasTerbaru = data['aktivitas_terbaru'] ?? [];
            final List<dynamic> jadwalHariIni = data['jadwal_hari_ini'] ?? [];
            final int totalMk = presensiPerMk.length;
            final String persenKehadiran = '${data['persentase_kehadiran']}%';
            final String ipk = '${data['ipk']}';
            final String sks = '${data['sks']}/20';

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  _bangunGridMetrik(totalMk, persenKehadiran, ipk, sks),

                  const Gap(28),

                  
                  _bangunPresensiCepat(presensiCepat),

                  const Gap(28),

                  
                  _bangunPresentasiPerMK(presensiPerMk),

                  const Gap(28),

                  
                  _bangunAktivitasTerbaru(aktivitasTerbaru),

                  const Gap(28),

                  
                  _bangunJadwalHariIni(jadwalHariIni),

                  const Gap(20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _bangunGridMetrik(int totalMk, String persenKehadiran, String ipk, String sks) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _bangunKartuMetrik(
                judul: 'Mata Kuliah',
                nilai: '$totalMk',
                warnaIcon: WarnaAplikasi.menuBiruIcon,
                warnaTint: WarnaAplikasi.menuBiruTint,
                icon: LucideIcons.bookOpen,
              ),
            ),
            const Gap(16),
            Expanded(
              child: _bangunKartuMetrik(
                judul: 'Persentase Kehadiran',
                nilai: persenKehadiran,
                warnaIcon: WarnaAplikasi.presensiIcon,
                warnaTint: WarnaAplikasi.presensiTint,
                icon: LucideIcons.calendarCheck,
              ),
            ),
          ],
        ),
        const Gap(16),
        Row(
          children: [
            Expanded(
              child: _bangunKartuMetrik(
                judul: 'IPK Sementara',
                nilai: ipk,
                warnaIcon: WarnaAplikasi.krsIcon,
                warnaTint: WarnaAplikasi.krsTint,
                icon: LucideIcons.trendingUp,
              ),
            ),
            const Gap(16),
            Expanded(
              child: _bangunKartuMetrik(
                judul: 'SKS',
                nilai: sks,
                warnaIcon: WarnaAplikasi.menuOranyeIcon,
                warnaTint: WarnaAplikasi.menuOranyeTint,
                icon: LucideIcons.graduationCap,
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
                    fontSize: 22,
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

  Widget _bangunPresensiCepat(List<dynamic> items) {
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
                'Presensi Cepat',
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
                      content: Text('Memulai pemindaian kode QR...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: WarnaAplikasi.krsTint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        LucideIcons.scan,
                        color: WarnaAplikasi.krsIcon,
                        size: 14,
                      ),
                      Gap(6),
                      Text(
                        'Pindai QR',
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
          if (items.isEmpty)
            const Text(
              'Tidak ada jadwal presensi cepat saat ini.',
              style: TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter'),
            )
          else
            ...items.map((item) {
              final isMarked = item['is_marked'] == 1 || item['is_marked'] == true;
              final isDb = item['title'].toString().contains('Database');
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _bangunItemPresensiCepat(
                  title: item['title'],
                  subtitle: item['subtitle'],
                  iconData: isDb ? LucideIcons.database : LucideIcons.bookOpen,
                  iconColor: isDb ? WarnaAplikasi.presensiIcon : WarnaAplikasi.menuBiruIcon,
                  iconBg: isDb ? WarnaAplikasi.presensiTint : WarnaAplikasi.menuBiruTint,
                  isMarked: isMarked,
                  onMarkPress: () async {
                    try {
                      final user = ref.read(authProvider);
                      if (user != null) {
                        await ref.read(apiServiceProvider).markPresensiCepat(user['id'], int.parse(item['id'].toString()));
                        ref.invalidate(presensiProvider);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Kehadiran berhasil ditandai!'),
                              backgroundColor: WarnaAplikasi.sukses,
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gagal menandai kehadiran: $e')),
                        );
                      }
                    }
                  },
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _bangunItemPresensiCepat({
    required String title,
    required String subtitle,
    required IconData iconData,
    required Color iconColor,
    required Color iconBg,
    required bool isMarked,
    VoidCallback? onMarkPress,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: WarnaAplikasi.latarBelakang,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              iconData,
              color: iconColor,
              size: 20,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: WarnaAplikasi.teksUtama,
                    fontFamily: 'Inter',
                  ),
                ),
                const Gap(4),
                Text(
                  subtitle,
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
          isMarked
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: WarnaAplikasi.suksesTint,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Hadir',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: WarnaAplikasi.sukses,
                      fontFamily: 'Inter',
                    ),
                  ),
                )
              : ElevatedButton(
                  onPressed: onMarkPress,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    backgroundColor: WarnaAplikasi.utama,
                    foregroundColor: Colors.white,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Tandai Kehadiran',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _bangunPresentasiPerMK(List<dynamic> items) {
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
            'Presentasi Per MK',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          if (items.isEmpty)
            const Text(
              'Tidak ada statistik mata kuliah.',
              style: TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter'),
            )
          else
            ...items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: _bangunBarisProgresPresentase(
                  item['mk_name'],
                  (item['progress_val'] as num).toDouble(),
                  item['persentase_text'],
                ),
              );
            }),
          const Gap(6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: WarnaAplikasi.infoTint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: const [
                Icon(
                  LucideIcons.info,
                  color: WarnaAplikasi.krsIcon,
                  size: 16,
                ),
                Gap(8),
                Expanded(
                  child: Text(
                    'Syarat Kehadiran Minimum: 75%',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: WarnaAplikasi.krsIcon,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bangunBarisProgresPresentase(String mk, double progressValue, String persentaseText) {
    final Color barColor = progressValue <= 0.75 ? WarnaAplikasi.peringatan : WarnaAplikasi.sukses;

    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            mk,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
        ),
        const Gap(12),
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            value: progressValue,
            backgroundColor: const Color(0xFFE2E8F0),
            color: barColor,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const Gap(12),
        SizedBox(
          width: 32,
          child: Text(
            persentaseText,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: barColor,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }

  Widget _bangunAktivitasTerbaru(List<dynamic> items) {
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
            'Aktivitas Terbaru',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
                ),
              ),
          const Gap(16),
          if (items.isEmpty)
            const Text(
              'Tidak ada aktivitas terbaru.',
              style: TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter'),
            )
          else
            ...items.map((item) {
              final type = item['type'];
              IconData iconData = LucideIcons.check;
              Color iconColor = WarnaAplikasi.sukses;
              Color iconBg = WarnaAplikasi.suksesTint;
              if (type == 'peringatan') {
                iconData = LucideIcons.clock;
                iconColor = WarnaAplikasi.peringatan;
                iconBg = WarnaAplikasi.peringatanTint;
              } else if (type == 'krs') {
                iconData = LucideIcons.fileText;
                iconColor = WarnaAplikasi.krsIcon;
                iconBg = WarnaAplikasi.krsTint;
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: _bangunBarisAktivitas(
                  desc: item['desc'],
                  time: item['time_ago'],
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

  Widget _bangunBarisAktivitas({
    required String desc,
    required String time,
    required IconData iconData,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            color: iconColor,
            size: 14,
          ),
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: WarnaAplikasi.teksUtama,
                  fontFamily: 'Inter',
                ),
              ),
              const Gap(4),
              Text(
                time,
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
    );
  }

  Widget _bangunJadwalHariIni(List<dynamic> items) {
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
            'Jadwal Hari Ini',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          if (items.isEmpty)
            const Text(
              'Tidak ada jadwal kuliah hari ini.',
              style: TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter'),
            )
          else
            ...items.map((item) {
              final String status = item['status_text'];
              final Color statusColor = Color(int.parse(item['status_color'].replaceAll('FF', ''), radix: 16) | 0xFF000000);
              final Color statusBg = Color(int.parse(item['status_bg'].replaceAll('FF', ''), radix: 16) | 0xFF000000);
              final Color accentColor = item['accent_color'] == '00000000'
                  ? Colors.transparent
                  : Color(int.parse(item['accent_color'].replaceAll('FF', ''), radix: 16) | 0xFF000000);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _bangunItemJadwal(
                  waktu: item['waktu'],
                  ampm: item['ampm'],
                  matkul: item['matkul'],
                  dosen: item['dosen'],
                  statusText: status,
                  statusColor: statusColor,
                  statusBg: statusBg,
                  accentColor: accentColor,
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _bangunItemJadwal({
    required String waktu,
    required String ampm,
    required String matkul,
    required String dosen,
    required String statusText,
    required Color statusColor,
    required Color statusBg,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: WarnaAplikasi.latarBelakang,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          if (accentColor != Colors.transparent)
            Container(
              width: 4,
              height: 48,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          if (accentColor != Colors.transparent) const Gap(8),
          Column(
            children: [
              Text(
                waktu,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: WarnaAplikasi.teksUtama,
                  fontFamily: 'Inter',
                ),
              ),
              Text(
                ampm,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: WarnaAplikasi.teksSekunder,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  matkul,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: WarnaAplikasi.teksUtama,
                    fontFamily: 'Inter',
                  ),
                ),
                const Gap(4),
                Text(
                  dosen,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
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
    );
  }
}
