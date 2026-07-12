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
import 'halaman_matkul.dart';


class HalamanBeranda extends ConsumerStatefulWidget {
  const HalamanBeranda({super.key});

  @override
  ConsumerState<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends ConsumerState<HalamanBeranda> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
        return const HalamanMatkul();
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
                          onPressed: () {},
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
                          onPressed: () {},
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
                          onPressed: () {},
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
                        children: const [
                          Text(
                            "Today's Schedule",
                            style: TextStyle(
                              fontSize: 12,
                              color: WarnaAplikasi.teksSekunder,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Gap(4),
                          Text(
                            "Sunday, 07 Jun",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: WarnaAplikasi.teksUtama,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      
                      Container(
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
                    ],
                  ),
                  const Gap(16),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  const Gap(16),
                  
                  const Center(
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
          const Gap(24),
          const Center(
            child: Text(
              'No news has been shared',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: WarnaAplikasi.teksSekunder,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _bangunPncNewsSection(BuildContext context) {
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
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                _bangunKartuBerita(
                  title:
                      'Kampus Kesehatan Punya Beban Administrasi Dua Kali Lipat, dan Banyak yang Belum Sadar Ini Bisa...',
                  source:
                      'SEVIMA - SEVIMA.COM - Setiap menjelang siklus akreditasi,...',
                  imageUrl:
                      'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?auto=format&fit=crop&w=400&q=80',
                ),
                _bangunKartuBerita(
                  title:
                      'Skema Digital Hari Ini Menjadi Kunci Utama Untuk Efisiensi Kampus...',
                  source:
                      'SEVIMA - Kehadiran teknologi digital mempermudah seluruh...',
                  imageUrl:
                      'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=400&q=80',
                ),
              ],
            ),
          ),
        ),

        const Gap(16),

        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _bangunDot(false),
            _bangunDot(true),
            _bangunDot(false),
            _bangunDot(false),
          ],
        ),

        const Gap(24),

        
        Center(
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
      ],
    );
  }

  
  Widget _bangunKartuBerita({
    required String title,
    required String source,
    required String imageUrl,
  }) {
    return Container(
      width: 270,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: WarnaAplikasi.biruUtama,
                  child: const Center(
                    child: Icon(
                      LucideIcons.image,
                      color: Colors.white30,
                      size: 40,
                    ),
                  ),
                );
              },
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
                    title,
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
                    source,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const Gap(10),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0058C6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Read More',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _bangunDot(bool active) {
    return Container(
      width: 6,
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF0058C6) : const Color(0xFFCBD5E1),
        shape: BoxShape.circle,
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
                  _bangunNavItem(1, LucideIcons.bookOpen, 'Matkul'),
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
}
