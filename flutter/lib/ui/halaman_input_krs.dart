import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/warna_aplikasi.dart';
import '../helper/rute_aplikasi.dart';
import '../helper/api_service.dart';


class MataKuliahKRS {
  final String id;
  final String nama;
  final int sks;
  final bool isWajib;
  final int kapasitasMax;
  final int kapasitasTerisi;
  final String kelas;
  final String hariJam;
  final String dosen;
  bool isChecked;

  MataKuliahKRS({
    required this.id,
    required this.nama,
    required this.sks,
    required this.isWajib,
    required this.kapasitasMax,
    required this.kapasitasTerisi,
    required this.kelas,
    required this.hariJam,
    required this.dosen,
    this.isChecked = false,
  });
}

class HalamanInputKrs extends ConsumerStatefulWidget {
  const HalamanInputKrs({super.key});

  @override
  ConsumerState<HalamanInputKrs> createState() => _HalamanInputKrsState();
}

class _HalamanInputKrsState extends ConsumerState<HalamanInputKrs> {
  
  late List<MataKuliahKRS> _daftarMatkul;
  bool _sudahDiajukan = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider);
    _sudahDiajukan = user != null && (user['sks_krs'] ?? 0) > 0;
    
    _daftarMatkul = [
      
      MataKuliahKRS(
        id: 'INF2104',
        nama: 'Praktikum Rekayasa Perangkat Lunak',
        sks: 4,
        isWajib: true,
        kapasitasMax: 50,
        kapasitasTerisi: 40,
        kelas: 'Kelas A',
        hariJam: 'Sen, Rab 08:00-10:00',
        dosen: 'Cahya Vikasari, S.T., M.Eng.',
        isChecked: false,
      ),
      MataKuliahKRS(
        id: 'INF2105',
        nama: 'Desain Interaksi Pengguna',
        sks: 2,
        isWajib: true,
        kapasitasMax: 50,
        kapasitasTerisi: 40,
        kelas: 'Kelas A',
        hariJam: 'Sen, Rab 08:00-10:00',
        dosen: 'Fajar Mahardika, S.Kom., M.Kom.',
        isChecked: false,
      ),
      MataKuliahKRS(
        id: 'INF2106',
        nama: 'Pemrograman Berorientasi Objek',
        sks: 2,
        isWajib: false,
        kapasitasMax: 50,
        kapasitasTerisi: 40,
        kelas: 'Kelas A',
        hariJam: 'Sen, Rab 08:00-10:00',
        dosen: 'Nur Wahyu Rahadi, S.Kom, M.Eng.',
        isChecked: false,
      ),

      
      MataKuliahKRS(
        id: 'INF2107',
        nama: 'Jaringan Komputer Lanjut',
        sks: 2,
        isWajib: true,
        kapasitasMax: 50,
        kapasitasTerisi: 35,
        kelas: 'Kelas A',
        hariJam: 'Sel 10:00-12:00',
        dosen: 'Lecturer A',
        isChecked: false,
      ),
      MataKuliahKRS(
        id: 'INF2108',
        nama: 'Basis Data Terdistribusi',
        sks: 2,
        isWajib: true,
        kapasitasMax: 50,
        kapasitasTerisi: 45,
        kelas: 'Kelas A',
        hariJam: 'Kam 08:00-10:00',
        dosen: 'Lecturer B',
        isChecked: false,
      ),
      MataKuliahKRS(
        id: 'INF2109',
        nama: 'Struktur Data Lanjut',
        sks: 2,
        isWajib: true,
        kapasitasMax: 50,
        kapasitasTerisi: 30,
        kelas: 'Kelas B',
        hariJam: 'Jum 13:30-15:30',
        dosen: 'Lecturer C',
        isChecked: false,
      ),
      MataKuliahKRS(
        id: 'INF2110',
        nama: 'Matematika Diskrit II',
        sks: 2,
        isWajib: true,
        kapasitasMax: 50,
        kapasitasTerisi: 42,
        kelas: 'Kelas A',
        hariJam: 'Sel 08:00-10:00',
        dosen: 'Lecturer D',
        isChecked: false,
      ),
      MataKuliahKRS(
        id: 'INF2111',
        nama: 'Pemrograman Web Lanjut',
        sks: 2,
        isWajib: false,
        kapasitasMax: 50,
        kapasitasTerisi: 38,
        kelas: 'Kelas A',
        hariJam: 'Kam 10:00-12:00',
        dosen: 'Lecturer E',
        isChecked: false,
      ),
      MataKuliahKRS(
        id: 'INF2112',
        nama: 'Arsitektur Cloud Computing',
        sks: 1,
        isWajib: false,
        kapasitasMax: 50,
        kapasitasTerisi: 28,
        kelas: 'Kelas A',
        hariJam: 'Jum 08:00-09:00',
        dosen: 'Lecturer F',
        isChecked: false,
      ),
      MataKuliahKRS(
        id: 'INF2113',
        nama: 'Dasar Machine Learning',
        sks: 1,
        isWajib: false,
        kapasitasMax: 50,
        kapasitasTerisi: 32,
        kelas: 'Kelas A',
        hariJam: 'Jum 09:00-10:00',
        dosen: 'Lecturer G',
        isChecked: false,
      ),
    ];
  }

  
  int get _totalSKS =>
      _daftarMatkul.where((m) => m.isChecked).fold(0, (sum, m) => sum + m.sks);
  int get _wajibCount =>
      _daftarMatkul.where((m) => m.isChecked && m.isWajib).length;
  int get _pilihanCount =>
      _daftarMatkul.where((m) => m.isChecked && !m.isWajib).length;
  bool get _isSksValid => _totalSKS <= 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Input KRS',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: _sudahDiajukan
              ? _bangunBodySudahDiajukan()
              : _bangunBodySelection(),
        ),
      ),
    );
  }

  Widget _bangunBodySudahDiajukan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(12),
        
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'ANDA SUDAH MENGAJUKAN KRS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  fontFamily: 'Inter',
                  letterSpacing: 0.5,
                ),
              ),
              Gap(8),
              Text(
                'Harap untuk menunggu konfirmasi\ndari wali dosen anda',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: WarnaAplikasi.teksSekunder,
                  fontFamily: 'Inter',
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        const Gap(24),

        
        _bangunCatatanPentingSection(),
      ],
    );
  }

  Widget _bangunBodySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        _bangunProfileCard(),

        const Gap(32),

        
        const Text(
          'Pilih Mata Kuliah',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
            fontFamily: 'Inter',
          ),
        ),
        const Gap(16),

        
        _bangunFilterDropdowns(),

        const Gap(16),

        
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _daftarMatkul.length,
          itemBuilder: (context, index) {
            final matkul = _daftarMatkul[index];
            return _bangunKartuMatkul(matkul);
          },
        ),

        const Gap(16),

        
        _bangunActionButtonsRow(),

        const Gap(32),

        
        _bangunRingkasanKrsSection(),

        const Gap(32),

        
        _bangunPersetujuanDosenPaSection(),

        const Gap(32),

        
        _bangunCatatanPentingSection(),
      ],
    );
  }

  
  Widget _bangunProfileCard() {
    final user = ref.watch(authProvider);
    final nama = user?['nama'] ?? 'Hilmi Mubarok';
    final nim = user?['nim'] ?? '240202078';
    final prodi = user?['prodi'] ?? 'Teknik Informatika';
    final semester = user?['semester'] ?? 3;
    final avatar = user?['avatar'] ?? 'https://avatar.iran.liara.run/public/boy?username=Hilmi';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: WarnaAplikasi.gradasiBiru,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: WarnaAplikasi.biruGradasiMulai.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.5),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(avatar),
              backgroundColor: Colors.white24,
            ),
          ),
          const Gap(16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                const Gap(3),
                Text(
                  'NIM: $nim',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
                const Gap(1),
                Text(
                  '$prodi - Semester $semester',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
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

  
  Widget _bangunFilterDropdowns() {
    final user = ref.read(authProvider);
    final semester = user?['semester'] ?? 3;

    return Row(
      children: [
        
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE2E8F0)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Semester $semester',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                    fontFamily: 'Inter',
                  ),
                ),
                const Icon(
                  LucideIcons.chevronDown,
                  size: 16,
                  color: Color(0xFF64748B),
                ),
              ],
            ),
          ),
        ),
        const Gap(12),
        
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE2E8F0)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Kurikulum 2021',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                    fontFamily: 'Inter',
                  ),
                ),
                Icon(
                  LucideIcons.chevronDown,
                  size: 16,
                  color: Color(0xFF64748B),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  
  Widget _bangunKartuMatkul(MataKuliahKRS matkul) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: matkul.isChecked
              ? WarnaAplikasi.biruUtama
              : const Color(0xFFE2E8F0),
          width: matkul.isChecked ? 1.5 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Checkbox(
            value: matkul.isChecked,
            activeColor: WarnaAplikasi.biruUtama,
            onChanged: (val) {
              setState(() {
                matkul.isChecked = val ?? false;
              });
            },
          ),
          const Gap(4),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Expanded(
                      child: Text(
                        matkul.nama,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const Gap(12),
                    
                    Text(
                      matkul.hariJam.split(' ').first,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),

                const Gap(2),

                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${matkul.id} • ${matkul.sks} SKS • ${matkul.isWajib ? "Wajib" : "Pilihan"}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: WarnaAplikasi.teksSekunder,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Text(
                      matkul.hariJam.split(' ').skip(1).join(' '),
                      style: const TextStyle(
                        fontSize: 11,
                        color: WarnaAplikasi.teksSekunder,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),

                const Gap(8),

                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2F9EE),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Kapasitas: ${matkul.kapasitasTerisi}/${matkul.kapasitasMax}',
                            style: const TextStyle(
                              color: Color(0xFF00A254),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        const Gap(6),
                        
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: WarnaAplikasi.menuBiruTint,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            matkul.kelas,
                            style: const TextStyle(
                              color: WarnaAplikasi.menuBiruIcon,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Expanded(
                      child: Text(
                        matkul.dosen,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: WarnaAplikasi.teksSekunder,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _bangunActionButtonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(
            LucideIcons.plus,
            size: 16,
            color: Color(0xFF0058C6),
          ),
          label: const Text(
            'Tambah Mata Kuliah Lain',
            style: TextStyle(
              color: Color(0xFF0058C6),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ),

        ElevatedButton(
          onPressed: () async {
            final user = ref.read(authProvider);
            if (user != null) {
              try {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(child: CircularProgressIndicator()),
                );
                await ref.read(apiServiceProvider).submitKrs(user['id'], _totalSKS);
                await ref.read(authProvider.notifier).refreshProfile();
                if (!mounted) return;
                Navigator.pop(context);
                setState(() {
                  _sudahDiajukan = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'KRS berhasil diajukan!',
                      style: TextStyle(fontFamily: 'Inter'),
                    ),
                    backgroundColor: WarnaAplikasi.sukses,
                  ),
                );
              } catch (e) {
                if (!mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Gagal mengajukan KRS: $e')),
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF01456A),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Simpan Pilihan',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }

  
  Widget _bangunRingkasanKrsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ringkasan KRS',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
            fontFamily: 'Inter',
          ),
        ),
        const Gap(12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
          ),
          child: Column(
            children: [
              
              _bangunSummaryRow('Total SKS Dipilih:', '$_totalSKS SKS'),
              const Gap(10),
              
              _bangunSummaryRow('Mata Kuliah Wajib:', '$_wajibCount'),
              const Gap(10),
              
              _bangunSummaryRow('Mata Kuliah Pilihan:', '$_pilihanCount'),
              const Gap(12),

              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              const Gap(12),

              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Status Limit SKS:',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                      fontFamily: 'Inter',
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        _isSksValid
                            ? LucideIcons.checkCircle2
                            : LucideIcons.alertTriangle,
                        color: _isSksValid
                            ? const Color(0xFF00A254)
                            : Colors.red,
                        size: 16,
                      ),
                      const Gap(6),
                      Text(
                        _isSksValid ? 'Valid' : 'Batas Terlampaui',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _isSksValid
                              ? const Color(0xFF00A254)
                              : Colors.red,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  
  Widget _bangunSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: WarnaAplikasi.teksSekunder,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  
  Widget _bangunPersetujuanDosenPaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Persetujuan Dosen PA',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
            fontFamily: 'Inter',
          ),
        ),
        const Gap(12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
          ),
          child: Column(
            children: [
              
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://ui-avatars.com/api/?name=Nur+Wahyu+Rahadi&background=0284C7&color=fff&size=128',
                    ),
                    backgroundColor: Color(0xFFE2E8F0),
                  ),
                  const Gap(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Nur Wahyu Rahadi, S.Kom, M.Eng.',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                          fontFamily: 'Inter',
                        ),
                      ),
                      Gap(2),
                      Text(
                        'Dosen Pembimbing Akademik',
                        style: TextStyle(
                          fontSize: 11,
                          color: WarnaAplikasi.teksSekunder,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(16),

              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _sudahDiajukan ? const Color(0xFFFFFBEB) : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _sudahDiajukan ? const Color(0xFFFEF3C7) : const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      _sudahDiajukan ? LucideIcons.clock : LucideIcons.edit2,
                      size: 16,
                      color: _sudahDiajukan ? const Color(0xFFD97706) : const Color(0xFF64748B),
                    ),
                    const Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _sudahDiajukan ? 'Menunggu Persetujuan' : 'Belum Diajukan',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _sudahDiajukan ? const Color(0xFFB45309) : const Color(0xFF334155),
                              fontFamily: 'Inter',
                            ),
                          ),
                          const Gap(3),
                          Text(
                            _sudahDiajukan
                                ? 'KRS Anda telah dikirim untuk persetujuan pada 15 Jan 2026, 14:30'
                                : 'Silakan pilih mata kuliah di atas dan simpan pilihan KRS Anda.',
                            style: TextStyle(
                              fontSize: 11,
                              color: _sudahDiajukan ? const Color(0xFFB45309) : const Color(0xFF64748B),
                              height: 1.3,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(16),

              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: null, 
                  icon: Icon(_sudahDiajukan ? LucideIcons.send : LucideIcons.circleDot, size: 14),
                  label: Text(
                    _sudahDiajukan ? 'Terkirim untuk Persetujuan' : 'Kirim setelah Simpan Pilihan',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F5F9),
                    foregroundColor: const Color(0xFF94A3B8),
                    disabledBackgroundColor: const Color(0xFFF1F5F9),
                    disabledForegroundColor: const Color(0xFF94A3B8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  
  Widget _bangunCatatanPentingSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDBEAFE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            children: const [
              Icon(LucideIcons.info, size: 16, color: Color(0xFF1D4ED8)),
              Gap(8),
              Text(
                'Catatan Penting',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D4ED8),
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const Gap(12),

          
          _bangunBulletPoint('Batas pengajuan KRS: 31 Januari 2026'),
          _bangunBulletPoint('Maksimal 20 SKS per semester'),
          _bangunBulletPoint('Periksa prasyarat mata kuliah'),
          _bangunBulletPoint('Konsultasi dengan Dosen PA jika diperlukan'),
        ],
      ),
    );
  }

  
  Widget _bangunBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              color: Color(0xFF1D4ED8),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF1D4ED8),
                fontSize: 12,
                height: 1.2,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
