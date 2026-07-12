import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:siakad_app/helper/tema_aplikasi.dart';

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WarnaAplikasi.latar,
      body: CustomScrollView(
        slivers: [
          _bangunSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bangunKartuRingkasan(),
                  const Gap(32),
                  Text(
                    'Menu Utama',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  _bangunGridMenu(context),
                  const Gap(32),
                  Text(
                    'Jadwal Hari Ini',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  _bangunDaftarJadwal(),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bangunNavigasiBawah(),
    );
  }

  Widget _bangunSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 140.0,
      floating: false,
      pinned: true,
      backgroundColor: WarnaAplikasi.utama,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: WarnaAplikasi.permukaan,
              child: Icon(
                LucideIcons.user,
                color: WarnaAplikasi.utama,
                size: 24,
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang,',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const Text(
                    'Muba Sayang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(LucideIcons.bell, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        background: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
            gradient: LinearGradient(
              colors: [WarnaAplikasi.utamaGelap, WarnaAplikasi.utama],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
    );
  }

  Widget _bangunKartuRingkasan() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: WarnaAplikasi.permukaan,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bangunItemStatistik(
            'IPK',
            '3.88',
            LucideIcons.trendingUp,
            WarnaAplikasi.sukses,
          ),
          Container(width: 1, height: 40, color: Colors.grey.shade200),
          _bangunItemStatistik(
            'SKS',
            '114',
            LucideIcons.bookOpen,
            WarnaAplikasi.info,
          ),
          Container(width: 1, height: 40, color: Colors.grey.shade200),
          _bangunItemStatistik(
            'Semester',
            '5',
            LucideIcons.calendarDays,
            WarnaAplikasi.peringatan,
          ),
        ],
      ),
    );
  }

  Widget _bangunItemStatistik(
    String label,
    String nilai,
    IconData ikon,
    Color warna,
  ) {
    return Column(
      children: [
        Icon(ikon, color: warna, size: 28),
        const Gap(8),
        Text(
          nilai,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: WarnaAplikasi.teksUtama,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: WarnaAplikasi.teksSekunder,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _bangunGridMenu(BuildContext context) {
    final daftarMenu = [
      {
        'title': 'KRS',
        'icon': LucideIcons.fileEdit,
        'color': WarnaAplikasi.krsIcon,
        'tint': WarnaAplikasi.krsTint,
      },
      {
        'title': 'Jadwal',
        'icon': LucideIcons.calendar,
        'color': WarnaAplikasi.jadwalIcon,
        'tint': WarnaAplikasi.jadwalTint,
      },
      {
        'title': 'Nilai',
        'icon': LucideIcons.award,
        'color': WarnaAplikasi.nilaiIcon,
        'tint': WarnaAplikasi.nilaiTint,
      },
      {
        'title': 'Keuangan',
        'icon': LucideIcons.wallet,
        'color': WarnaAplikasi.keuanganIcon,
        'tint': WarnaAplikasi.keuanganTint,
      },
      {
        'title': 'Presensi',
        'icon': LucideIcons.checkCircle,
        'color': WarnaAplikasi.presensiIcon,
        'tint': WarnaAplikasi.presensiTint,
      },
      {
        'title': 'Transkrip',
        'icon': LucideIcons.fileText,
        'color': WarnaAplikasi.transkripIcon,
        'tint': WarnaAplikasi.transkripTint,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: daftarMenu.length,
      itemBuilder: (context, index) {
        final menu = daftarMenu[index];
        return _bangunItemMenu(
          judul: menu['title'] as String,
          ikon: menu['icon'] as IconData,
          warna: menu['color'] as Color,
          tint: menu['tint'] as Color,
        );
      },
    );
  }

  Widget _bangunItemMenu({
    required String judul,
    required IconData ikon,
    required Color warna,
    required Color tint,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(ikon, color: warna, size: 28),
          ),
          const Gap(8),
          Text(
            judul,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: WarnaAplikasi.teksUtama,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bangunDaftarJadwal() {
    return Column(
      children: [
        _bangunKartuJadwal(
          mataKuliah: 'Pemrograman Mobile',
          waktu: '08:00 - 10:30',
          ruangan: 'Lab Komputer A',
          sedangBerlangsung: true,
        ),
        const Gap(12),
        _bangunKartuJadwal(
          mataKuliah: 'Kecerdasan Buatan',
          waktu: '13:00 - 15:30',
          ruangan: 'Ruang 402',
          sedangBerlangsung: false,
        ),
      ],
    );
  }

  Widget _bangunKartuJadwal({
    required String mataKuliah,
    required String waktu,
    required String ruangan,
    required bool sedangBerlangsung,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: sedangBerlangsung
            ? WarnaAplikasi.utama
            : WarnaAplikasi.permukaan,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!sedangBerlangsung)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: sedangBerlangsung
                  ? Colors.white.withValues(alpha: 0.2)
                  : WarnaAplikasi.latar,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  waktu.split(' ')[0],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: sedangBerlangsung
                        ? Colors.white
                        : WarnaAplikasi.teksUtama,
                  ),
                ),
                Text(
                  'WIB',
                  style: TextStyle(
                    fontSize: 10,
                    color: sedangBerlangsung
                        ? Colors.white70
                        : WarnaAplikasi.teksSekunder,
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mataKuliah,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: sedangBerlangsung
                        ? Colors.white
                        : WarnaAplikasi.teksUtama,
                  ),
                ),
                const Gap(4),
                Row(
                  children: [
                    Icon(
                      LucideIcons.mapPin,
                      size: 14,
                      color: sedangBerlangsung
                          ? Colors.white70
                          : WarnaAplikasi.teksSekunder,
                    ),
                    const Gap(4),
                    Text(
                      ruangan,
                      style: TextStyle(
                        fontSize: 12,
                        color: sedangBerlangsung
                            ? Colors.white70
                            : WarnaAplikasi.teksSekunder,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (sedangBerlangsung)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: WarnaAplikasi.sekunder,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Sekarang',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: WarnaAplikasi.utamaGelap,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _bangunNavigasiBawah() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: WarnaAplikasi.permukaan,
      selectedItemColor: WarnaAplikasi.utama,
      unselectedItemColor: WarnaAplikasi.teksSekunder,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      items: const [
        BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.calendar),
          label: 'Jadwal',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.bell),
          label: 'Notifikasi',
        ),
        BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: 'Profil'),
      ],
    );
  }
}
