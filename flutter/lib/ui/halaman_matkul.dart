import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/warna_aplikasi.dart';
import '../helper/api_service.dart';

class HalamanMatkul extends ConsumerWidget {
  const HalamanMatkul({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matkulAsync = ref.watch(matkulProvider);

    return Scaffold(
      backgroundColor: WarnaAplikasi.latarBelakang,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Daftar Kuliah Saya',
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
        child: matkulAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: WarnaAplikasi.utama),
          ),
          error: (err, stack) => Center(
            child: Text(
              'Gagal memuat mata kuliah: $err',
              style: const TextStyle(fontFamily: 'Inter'),
            ),
          ),
          data: (daftarMatkul) {
            if (daftarMatkul.isEmpty) {
              return const Center(
                child: Text(
                  'Tidak ada mata kuliah terdaftar.',
                  style: TextStyle(
                    fontSize: 14,
                    color: WarnaAplikasi.teksSekunder,
                    fontFamily: 'Inter',
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              itemCount: daftarMatkul.length,
              itemBuilder: (context, index) {
                final item = daftarMatkul[index];
                final Color borderClr = Color(
                  int.parse(item['color'].replaceAll('FF', ''), radix: 16) | 0xFF000000,
                );
                final Color bgClr = Color(
                  int.parse(item['bg'].replaceAll('FF', ''), radix: 16) | 0xFF000000,
                );

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
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
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        
                        Container(
                          width: 4,
                          decoration: BoxDecoration(
                            color: borderClr,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: bgClr,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        item['kode'] ?? '',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: borderClr,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ),
                                    const Gap(8),
                                    Text(
                                      '${item['sks']} SKS',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: WarnaAplikasi.teksSekunder,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: WarnaAplikasi.latarBelakang,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: const Color(0xFFE2E8F0)),
                                      ),
                                      child: Text(
                                        item['kelas'] ?? 'Kelas A',
                                        style: const TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: WarnaAplikasi.teksSekunder,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(12),
                                
                                Text(
                                  item['nama'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: WarnaAplikasi.teksUtama,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                const Gap(12),
                                
                                Row(
                                  children: [
                                    const Icon(
                                      LucideIcons.user,
                                      size: 14,
                                      color: WarnaAplikasi.teksSekunder,
                                    ),
                                    const Gap(8),
                                    Expanded(
                                      child: Text(
                                        item['dosen'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: WarnaAplikasi.teksSekunder,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(6),
                                
                                Row(
                                  children: [
                                    const Icon(
                                      LucideIcons.clock,
                                      size: 14,
                                      color: WarnaAplikasi.teksSekunder,
                                    ),
                                    const Gap(8),
                                    Expanded(
                                      child: Text(
                                        item['jadwal'] ?? '',
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
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
