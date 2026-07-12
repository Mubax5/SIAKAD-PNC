import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/warna_aplikasi.dart';
import '../helper/api_service.dart';



class HalamanProfil extends ConsumerStatefulWidget {
  const HalamanProfil({super.key});

  @override
  ConsumerState<HalamanProfil> createState() => _HalamanProfilState();
}

class _HalamanProfilState extends ConsumerState<HalamanProfil> {
  bool _isEditing = false;

  
  late TextEditingController _emailController;
  late TextEditingController _telpController;
  late TextEditingController _alamatController;

  
  String _prevEmail = '';
  String _prevTelp = '';
  String _prevAlamat = '';

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider);
    _emailController = TextEditingController(text: user?['email'] ?? 'hilmimubarok@pnc.ac.id');
    _telpController = TextEditingController(text: '+62 812-3456-7890');
    _alamatController = TextEditingController(
      text: 'Jl. Margonda Raya No. 100, Depok, Jawa Barat 16424',
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _telpController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    final nama = user?['nama'] ?? 'Hilmi Mubarok';
    final prodi = user?['prodi'] ?? 'Teknik Informatika';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              _bangunProfileCard(),

              const Gap(32),

              
              _bangunSectionHeader('Data Pribadi'),
              const Gap(16),
              _bangunReadOnlyField('Nama Lengkap', nama),
              const Gap(14),
              _bangunReadOnlyField(
                'Tempat, Tanggal Lahir',
                user?['nim'] == '240202001' ? 'Surabaya, 12 April 2004' : (user?['nim'] == '240202002' ? 'Semarang, 24 Desember 2003' : 'Jakarta, 15 Maret 2006'),
              ),
              const Gap(14),
              _bangunReadOnlyField('Jenis Kelamin', 'Laki-laki'),
              const Gap(14),
              _bangunReadOnlyField('Agama', 'Islam'),

              const Gap(32),

              
              _bangunSectionHeader('Kontak & Alamat'),
              const Gap(16),
              _bangunField('Email', _emailController, isEditable: _isEditing),
              const Gap(14),
              _bangunField(
                'No. Telepon',
                _telpController,
                isEditable: _isEditing,
              ),
              const Gap(14),
              _bangunField('Alamat', _alamatController, isEditable: _isEditing),
              const Gap(16),

              
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isEditing) ...[
                      
                      InkWell(
                        onTap: () {
                          setState(() {
                            
                            _emailController.text = _prevEmail;
                            _telpController.text = _prevTelp;
                            _alamatController.text = _prevAlamat;
                            _isEditing = false;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Perubahan dibatalkan',
                                  style: TextStyle(fontFamily: 'Inter'),
                                ),
                                backgroundColor: WarnaAplikasi.teksSekunder,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          });
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                LucideIcons.x,
                                color: Colors.white,
                                size: 14,
                              ),
                              Gap(6),
                              Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(12),
                    ],
                    
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (_isEditing) {
                            
                            _isEditing = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Profil berhasil diperbarui!',
                                  style: TextStyle(fontFamily: 'Inter'),
                                ),
                                backgroundColor: WarnaAplikasi.sukses,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            
                            _prevEmail = _emailController.text;
                            _prevTelp = _telpController.text;
                            _prevAlamat = _alamatController.text;

                            
                            _isEditing = true;
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: _isEditing
                              ? WarnaAplikasi.sukses
                              : const Color(0xFF0058C6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _isEditing
                                  ? LucideIcons.check
                                  : LucideIcons.fileEdit,
                              color: Colors.white,
                              size: 14,
                            ),
                            const Gap(6),
                            Text(
                              _isEditing ? 'Simpan' : 'Edit',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(32),

              
              _bangunSectionHeader('Informasi Akademik'),
              const Gap(16),
              _bangunReadOnlyField('Program Studi', prodi),
              const Gap(14),
              _bangunReadOnlyField('Jurusan', 'Komputer dan Bisnis'),
              const Gap(14),
              _bangunReadOnlyField('Tahun Masuk', '2021'),
              const Gap(14),
              _bangunReadOnlyField(
                'Dosen Pembimbing',
                user?['ta_dosen'] ?? 'Nur Wahyu Rahadi, S.Kom, M.Eng.',
              ),
              const Gap(14),
              _bangunReadOnlyField('Status Mahasiswa', 'Aktif'),
              const Gap(14),
              _bangunReadOnlyField('Target Lulus', '2025'),

              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _bangunProfileCard() {
    final user = ref.watch(authProvider);
    final nama = user?['nama'] ?? 'Hilmi Mubarok';
    final prodi = user?['prodi'] ?? 'Teknik Informatika';
    final semester = user?['semester'] ?? 3;
    final nim = user?['nim'] ?? '240202078';
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

  
  Widget _bangunSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
            fontFamily: 'Inter',
          ),
        ),
        const Gap(4),
        Container(
          width: double.infinity,
          height: 1,
          color: const Color(0xFFF1F5F9),
        ),
      ],
    );
  }

  
  Widget _bangunField(
    String label,
    TextEditingController controller, {
    required bool isEditable,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: WarnaAplikasi.teksSekunder,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
        const Gap(6),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isEditable ? Colors.white : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isEditable
                  ? WarnaAplikasi.biruUtama
                  : const Color(0xFFF1F5F9),
              width: 1,
            ),
          ),
          child: isEditable
              ? TextField(
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                    fontFamily: 'Inter',
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Text(
                    controller.text,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  
  Widget _bangunReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: WarnaAplikasi.teksSekunder,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
        const Gap(6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFF1F5F9), width: 1),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }
}
