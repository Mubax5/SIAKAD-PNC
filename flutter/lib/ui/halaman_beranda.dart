import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/warna_aplikasi.dart';
import '../helper/rute_aplikasi.dart';
import '../helper/api_service.dart';
import '../widget/tombol_menu.dart';
import 'halaman_profil.dart';
import 'halaman_jadwal.dart';
import 'halaman_presensi.dart';
import 'halaman_nilai_transkrip.dart';


class HalamanBeranda extends ConsumerStatefulWidget {
  const HalamanBeranda({super.key});

  @override
  ConsumerState<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends ConsumerState<HalamanBeranda> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(RuteAplikasi.login);
      });
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: WarnaAplikasi.utama),
        ),
      );
    }
    return Scaffold(
      backgroundColor: WarnaAplikasi.latarBelakang,
      body: _bangunBody(),
      bottomNavigationBar: _bangunNavigasiBawahKustom(),
    );
  }

  Widget _bangunBody() {
    switch (_currentIndex) {
      case 0:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              _bangunHeaderStack(context),

              const Gap(24),

              
              _bangunMyAcademicGrid(context),

              const Gap(32),

              
              _bangunInformationSection(context),

              const Gap(32),

              
              _bangunPncNewsSection(context),

              const Gap(40),
            ],
          ),
        );
      case 1:
        return const HalamanNilaiTranskrip();
      case 2:
        return const HalamanJadwal();
      case 3:
        return const HalamanProfil();
      case 4:
        return const HalamanPresensi();
      default:
        return const SizedBox();
    }
  }

  
  Widget _bangunHeaderStack(BuildContext context) {
    final user = ref.watch(authProvider);
    final nama = user?['nama'] ?? 'Hilmi Mubarok';
    final prodi = user?['prodi'] ?? 'Teknik Informatika';
    final avatar = user?['avatar'] ?? 'https://avatar.iran.liara.run/public/boy?username=Hilmi';

    return SizedBox(
      height: 290,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          
          Container(
            height: 190,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: WarnaAplikasi.gradasiBiru,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _currentIndex = 3; 
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(avatar),
                                backgroundColor: Colors.white24,
                              ),
                              const Gap(12),
                              
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          nama,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        const Gap(4),
                                        const Icon(
                                          LucideIcons.chevronDown,
                                          color: Colors.white70,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    const Gap(2),
                                    Text(
                                      'Mahasiswa - $prodi',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.white70,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            LucideIcons.messageSquare,
                            color: Colors.white,
                            size: 22,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => _bangunChatBottomSheet(),
                            );
                          },
                        ),
                        const Gap(16),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            LucideIcons.barChart2,
                            color: Colors.white,
                            size: 22,
                          ),
                          onPressed: () {
                            setState(() {
                              _currentIndex = 4;
                            });
                          },
                        ),
                        const Gap(16),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            LucideIcons.bell,
                            color: Colors.white,
                            size: 22,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => _bangunNotifikasiBottomSheet(),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          
          Positioned(
            top: 130,
            left: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Today's Schedule",
                            style: TextStyle(
                              fontSize: 12,
                              color: WarnaAplikasi.teksSekunder,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                          const Gap(4),
                          Text(
                            dapatkanTanggalIndonesian(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: WarnaAplikasi.teksUtama,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      
                      InkWell(
                        onTap: () {
                          setState(() {
                            _currentIndex = 2;
                          });
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: WarnaAplikasi.menuBiruTint,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                LucideIcons.calendar,
                                color: WarnaAplikasi.menuBiruIcon,
                                size: 14,
                              ),
                              Gap(6),
                              Text(
                                'Schedule',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: WarnaAplikasi.menuBiruIcon,
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
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  ref.watch(matkulProvider).when(
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: CircularProgressIndicator(color: WarnaAplikasi.utama),
                      ),
                    ),
                    error: (err, stack) => const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text(
                          'Gagal memuat jadwal',
                          style: TextStyle(fontFamily: 'Inter', fontSize: 13, color: Colors.red),
                        ),
                      ),
                    ),
                    data: (courses) {
                      final today = dapatkanHariIniIndonesian();
                      final todayCourses = courses.where((m) {
                        final j = m['jadwal']?.toString() ?? '';
                        return j.toLowerCase().startsWith(today.toLowerCase());
                      }).toList();

                      if (todayCourses.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Text(
                              'No classes today.',
                              style: TextStyle(
                                fontSize: 13,
                                color: WarnaAplikasi.teksSekunder,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: todayCourses.map((m) {
                          final j = m['jadwal']?.toString() ?? '';
                          final parts = j.split(',');
                          final time = parts.length > 1 ? parts[1].replaceAll('WIB', '').trim() : '08:00 - 10:30';
                          return Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: WarnaAplikasi.menuBiruTint,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(LucideIcons.bookOpen, color: WarnaAplikasi.menuBiruIcon, size: 16),
                                ),
                                const Gap(12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        m['nama'] ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: WarnaAplikasi.teksUtama),
                                      ),
                                      Text(
                                        m['dosen'] ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 11, color: WarnaAplikasi.teksSekunder),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  time,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: WarnaAplikasi.utama),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _bangunMyAcademicGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MyAcademic',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(4),
          const Text(
            'Use this menu to view information and manage your academic data.',
            style: TextStyle(
              fontSize: 12,
              color: WarnaAplikasi.teksSekunder,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(20),
          
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 16,
            childAspectRatio: 0.72,
            children: [
              TombolMenu(
                icon: LucideIcons.trendingUp,
                label: 'Tugas Akhir',
                warnaTint: WarnaAplikasi.transkripTint,
                warnaIcon: WarnaAplikasi.transkripIcon,
                onTap: () {
                  context.push(RuteAplikasi.tugasAkhir);
                },
              ),
              TombolMenu(
                icon: LucideIcons.contact,
                label: 'Student e-Card',
                warnaTint: WarnaAplikasi.menuOranyeTint,
                warnaIcon: WarnaAplikasi.menuOranyeIcon,
                onTap: () {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Layanan ini belum tersedia secara lokal.'),
                    ),
                  );
                },
              ),
              TombolMenu(
                icon: LucideIcons.fileText,
                label: 'Invoice Payment',
                warnaTint: WarnaAplikasi.menuBiruTint,
                warnaIcon: WarnaAplikasi.menuBiruIcon,
                onTap: () {
                  context.push(RuteAplikasi.keuangan);
                },
              ),
              TombolMenu(
                icon: LucideIcons.bookOpen,
                label: 'Registered Course',
                warnaTint: WarnaAplikasi.menuBiruTint,
                warnaIcon: WarnaAplikasi.menuBiruIcon,
                onTap: () {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Layanan ini belum tersedia secara lokal.'),
                    ),
                  );
                },
              ),
              TombolMenu(
                icon: LucideIcons.award,
                label: 'Exam Result',
                warnaTint: WarnaAplikasi.menuBiruTint,
                warnaIcon: WarnaAplikasi.menuBiruIcon,
                onTap: () {
                  context.push(RuteAplikasi.nilaiTranskrip);
                },
              ),
              TombolMenu(
                icon: LucideIcons.fileEdit,
                label: 'Input KRS',
                warnaTint: WarnaAplikasi.menuBiruTint,
                warnaIcon: WarnaAplikasi.menuBiruIcon,
                onTap: () {
                  context.push(RuteAplikasi.inputKrs);
                },
              ),
              TombolMenu(
                icon: LucideIcons.fileText,
                label: 'Surat & Admin',
                warnaTint: WarnaAplikasi.krsTint,
                warnaIcon: WarnaAplikasi.krsIcon,
                onTap: () {
                  context.push(RuteAplikasi.surat);
                },
              ),
              TombolMenu(
                icon: LucideIcons.medal,
                label: 'Transcript',
                warnaTint: WarnaAplikasi.menuOranyeTint,
                warnaIcon: WarnaAplikasi.menuOranyeIcon,
                onTap: () {
                  context.push(RuteAplikasi.nilaiTranskrip);
                },
              ),
              TombolMenu(
                icon: LucideIcons.graduationCap,
                label: 'Program MBKM',
                warnaTint: WarnaAplikasi.menuOranyeTint,
                warnaIcon: WarnaAplikasi.menuOranyeIcon,
                onTap: () {
                  context.push(RuteAplikasi.mbkm);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  
  Widget _bangunInformationSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(4),
          const Text(
            'All information regarding activities at the university will be posted in this section.',
            style: TextStyle(
              fontSize: 12,
              color: WarnaAplikasi.teksSekunder,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          ref.watch(infoProvider).when(
            loading: () => const Center(child: CircularProgressIndicator(color: WarnaAplikasi.utama)),
            error: (_, __) => const Center(child: Text('Gagal memuat informasi', style: TextStyle(fontFamily: 'Inter', fontSize: 13, color: Colors.red))),
            data: (items) {
              if (items.isEmpty) {
                return const Center(
                  child: Text('No information available', style: TextStyle(fontSize: 13, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter')),
                );
              }
              return Column(
                children: items.map((item) {
                  return InkWell(
                    onTap: () => _tampilkanDetailInfo(item),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: WarnaAplikasi.menuBiruTint,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(LucideIcons.megaphone, color: WarnaAplikasi.menuBiruIcon, size: 18),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['judul'] ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: WarnaAplikasi.teksUtama, fontFamily: 'Inter'),
                                ),
                                const Gap(4),
                                Text(
                                  item['tanggal'] ?? '',
                                  style: const TextStyle(fontSize: 11, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter'),
                                ),
                              ],
                            ),
                          ),
                          const Icon(LucideIcons.chevronRight, color: WarnaAplikasi.teksSekunder, size: 16),
                        ],
                      ),
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

  
  Widget _bangunPncNewsSection(BuildContext context) {
    return ref.watch(newsProvider).when(
      loading: () => const Center(child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        child: CircularProgressIndicator(color: WarnaAplikasi.utama),
      )),
      error: (_, __) => const Center(child: Text('Gagal memuat berita', style: TextStyle(fontFamily: 'Inter', fontSize: 13, color: Colors.red))),
      data: (newsList) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'PNC News',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: WarnaAplikasi.teksUtama,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const Gap(4),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Discover good news, stories about education world.',
                style: TextStyle(
                  fontSize: 12,
                  color: WarnaAplikasi.teksSekunder,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const Gap(16),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: newsList.length,
                itemBuilder: (ctx, i) {
                  final berita = newsList[i];
                  return _bangunKartuBeritaDinamis(
                    judul: berita['judul'] ?? '',
                    sumber: berita['sumber'] ?? '',
                    imageUrl: berita['gambar'] ?? '',
                    konten: berita['konten'] ?? '',
                    tanggal: berita['tanggal'] ?? '',
                  );
                },
              ),
            ),
            const Gap(24),
            Center(
              child: InkWell(
                onTap: () => _tampilkanSemuaBerita(newsList),
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4E9FC),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Discover All News',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0058C6),
                          fontFamily: 'Inter',
                        ),
                      ),
                      Gap(6),
                      Icon(
                        LucideIcons.arrowRight,
                        size: 14,
                        color: Color(0xFF0058C6),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  
  Widget _bangunKartuBeritaDinamis({
    required String judul,
    required String sumber,
    required String imageUrl,
    required String konten,
    required String tanggal,
  }) {
    return GestureDetector(
      onTap: () => _tampilkanDetailBerita(judul: judul, sumber: sumber, imageUrl: imageUrl, konten: konten, tanggal: tanggal),
      child: Container(
        width: 270,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: WarnaAplikasi.biruUtama,
                          child: const Center(
                            child: Icon(LucideIcons.image, color: Colors.white30, size: 40),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: WarnaAplikasi.biruUtama,
                      child: const Center(
                        child: Icon(LucideIcons.newspaper, color: Colors.white30, size: 40),
                      ),
                    ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.1),
                      Colors.black.withValues(alpha: 0.85),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      judul,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const Gap(4),
                    Text(
                      sumber,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70, fontSize: 10, fontFamily: 'Inter'),
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0058C6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Read More',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _tampilkanDetailBerita({
    required String judul,
    required String sumber,
    required String imageUrl,
    required String konten,
    required String tanggal,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, sc) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                decoration: BoxDecoration(color: const Color(0xFFCBD5E1), borderRadius: BorderRadius.circular(2)),
              ),
              if (imageUrl.isNotEmpty)
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Image.network(imageUrl, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: WarnaAplikasi.biruUtama)),
                ),
              Expanded(
                child: SingleChildScrollView(
                  controller: sc,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(judul, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: WarnaAplikasi.teksUtama, fontFamily: 'Inter')),
                      const Gap(8),
                      Row(
                        children: [
                          const Icon(LucideIcons.calendar, size: 12, color: WarnaAplikasi.teksSekunder),
                          const Gap(4),
                          Text(tanggal, style: const TextStyle(fontSize: 11, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter')),
                          const Gap(12),
                          const Icon(LucideIcons.globe, size: 12, color: WarnaAplikasi.teksSekunder),
                          const Gap(4),
                          Expanded(child: Text(sumber, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter'))),
                        ],
                      ),
                      const Gap(16),
                      const Divider(),
                      const Gap(16),
                      Text(konten, style: const TextStyle(fontSize: 14, color: WarnaAplikasi.teksUtama, height: 1.6, fontFamily: 'Inter')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _tampilkanDetailInfo(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.93,
        minChildSize: 0.4,
        builder: (_, sc) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(top: 12, bottom: 16),
                  decoration: BoxDecoration(color: const Color(0xFFCBD5E1), borderRadius: BorderRadius.circular(2)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: WarnaAplikasi.menuBiruTint, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(LucideIcons.megaphone, color: WarnaAplikasi.menuBiruIcon, size: 20),
                    ),
                    const Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Informasi', style: TextStyle(fontSize: 11, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter')),
                          Text(item['tanggal'] ?? '', style: const TextStyle(fontSize: 11, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(16),
              Expanded(
                child: SingleChildScrollView(
                  controller: sc,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['judul'] ?? '', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: WarnaAplikasi.teksUtama, fontFamily: 'Inter')),
                      const Gap(12),
                      const Divider(),
                      const Gap(12),
                      Text(item['konten'] ?? '', style: const TextStyle(fontSize: 14, color: WarnaAplikasi.teksUtama, height: 1.6, fontFamily: 'Inter')),
                      const Gap(24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _tampilkanSemuaBerita(List<dynamic> newsList) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, sc) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(top: 12, bottom: 4),
                  decoration: BoxDecoration(color: const Color(0xFFCBD5E1), borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                child: Text('Semua Berita PNC', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: WarnaAplikasi.teksUtama, fontFamily: 'Inter')),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.separated(
                  controller: sc,
                  padding: const EdgeInsets.all(16),
                  itemCount: newsList.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (ctx, i) {
                    final b = newsList[i];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      leading: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: WarnaAplikasi.biruUtama,
                        ),
                        child: (b['gambar'] ?? '').isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(b['gambar'], fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(LucideIcons.newspaper, color: Colors.white60, size: 24)),
                              )
                            : const Icon(LucideIcons.newspaper, color: Colors.white60, size: 24),
                      ),
                      title: Text(b['judul'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Inter', color: WarnaAplikasi.teksUtama)),
                      subtitle: Text(b['sumber'] ?? '', maxLines: 1, style: const TextStyle(fontSize: 11, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter')),
                      onTap: () {
                        Navigator.pop(context);
                        _tampilkanDetailBerita(
                          judul: b['judul'] ?? '',
                          sumber: b['sumber'] ?? '',
                          imageUrl: b['gambar'] ?? '',
                          konten: b['konten'] ?? '',
                          tanggal: b['tanggal'] ?? '',
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bangunChatBottomSheet() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: const Color(0xFFCBD5E1), borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const Gap(16),
          const Text('Pesan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: WarnaAplikasi.teksUtama, fontFamily: 'Inter')),
          const Gap(12),
          const Divider(),
          const Gap(12),
          _bangunChatItem(nama: 'Dosen Wali', pesan: 'Silakan konfirmasi jadwal bimbingan Anda.', waktu: '09:00'),
          _bangunChatItem(nama: 'Admin Akademik', pesan: 'Pengisian KRS dibuka mulai Senin, 14 Juli 2025.', waktu: 'Kemarin'),
          _bangunChatItem(nama: 'BAAK', pesan: 'Dokumen Anda sudah diproses, silakan cek email.', waktu: '2 hr'),
          const Gap(16),
        ],
      ),
    );
  }

  Widget _bangunChatItem({required String nama, required String pesan, required String waktu}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: WarnaAplikasi.menuBiruTint,
            child: Text(nama[0], style: const TextStyle(fontWeight: FontWeight.bold, color: WarnaAplikasi.menuBiruIcon, fontFamily: 'Inter')),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: WarnaAplikasi.teksUtama, fontFamily: 'Inter')),
                Text(pesan, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter')),
              ],
            ),
          ),
          Text(waktu, style: const TextStyle(fontSize: 11, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter')),
        ],
      ),
    );
  }

  Widget _bangunNotifikasiBottomSheet() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: const Color(0xFFCBD5E1), borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const Gap(16),
          const Text('Notifikasi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: WarnaAplikasi.teksUtama, fontFamily: 'Inter')),
          const Gap(12),
          const Divider(),
          const Gap(12),
          _bangunNotifItem(ikon: LucideIcons.calendarCheck, judul: 'Jadwal Kuliah Hari Ini', isi: 'Anda memiliki 2 mata kuliah hari ini.', waktu: 'Baru saja', warna: WarnaAplikasi.menuBiruTint, warnaIkon: WarnaAplikasi.menuBiruIcon),
          _bangunNotifItem(ikon: LucideIcons.fileText, judul: 'Pengisian KRS', isi: 'Periode pengisian KRS dimulai Senin depan.', waktu: '1 jam lalu', warna: WarnaAplikasi.transkripTint, warnaIkon: WarnaAplikasi.transkripIcon),
          _bangunNotifItem(ikon: LucideIcons.megaphone, judul: 'Informasi Kampus', isi: 'Ada pengumuman baru dari rektorat.', waktu: 'Kemarin', warna: const Color(0xFFFFF3CD), warnaIkon: const Color(0xFFD4850A)),
          const Gap(16),
        ],
      ),
    );
  }

  Widget _bangunNotifItem({
    required IconData ikon,
    required String judul,
    required String isi,
    required String waktu,
    required Color warna,
    required Color warnaIkon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: warna, borderRadius: BorderRadius.circular(10)),
            child: Icon(ikon, color: warnaIkon, size: 18),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: WarnaAplikasi.teksUtama, fontFamily: 'Inter')),
                const Gap(2),
                Text(isi, maxLines: 2, style: const TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter')),
              ],
            ),
          ),
          const Gap(8),
          Text(waktu, style: const TextStyle(fontSize: 10, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter')),
        ],
      ),
    );
  }


  Widget _bangunNavigasiBawahKustom() {
    return SizedBox(
      height: 95,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 65,
            child: Container(
              decoration: BoxDecoration(
                gradient: WarnaAplikasi.gradasiBiru,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _bangunNavItem(0, LucideIcons.home, 'Beranda'),
                  _bangunNavItem(1, LucideIcons.fileText, 'Transkrip'),
                  const Expanded(
                    child: SizedBox(),
                  ), 
                  _bangunNavItem(2, LucideIcons.calendar, 'Jadwal'),
                  _bangunNavItem(3, LucideIcons.user, 'Profil'),
                ],
              ),
            ),
          ),

          
          Positioned(
            top: 4,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = 4; 
                  });
                },
                borderRadius: BorderRadius.circular(36),
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        LucideIcons.scan,
                        color: Color(0xFF0F172A),
                        size: 26,
                      ),
                      Gap(4),
                      Text(
                        'Scan',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _bangunNavItem(int index, IconData icon, String label) {
    final bool isActive = _currentIndex == index;
    final Color color = isActive
        ? Colors.white
        : Colors.white.withValues(alpha: 0.65);

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const Gap(4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: color,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  String dapatkanHariIniIndonesian() {
    final now = DateTime.now();
    switch (now.weekday) {
      case DateTime.monday:
        return 'Senin';
      case DateTime.tuesday:
        return 'Selasa';
      case DateTime.wednesday:
        return 'Rabu';
      case DateTime.thursday:
        return 'Kamis';
      case DateTime.friday:
        return 'Jumat';
      case DateTime.saturday:
        return 'Sabtu';
      case DateTime.sunday:
        return 'Minggu';
      default:
        return '';
    }
  }

  String dapatkanTanggalIndonesian() {
    final now = DateTime.now();
    final listBulan = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    final hari = dapatkanHariIniIndonesian();
    return '$hari, ${now.day} ${listBulan[now.month - 1]}';
  }
}
