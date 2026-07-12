import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/warna_aplikasi.dart';
import '../helper/rute_aplikasi.dart';
import '../helper/api_service.dart';

class HalamanKeuangan extends ConsumerStatefulWidget {
  const HalamanKeuangan({super.key});

  @override
  ConsumerState<HalamanKeuangan> createState() => _HalamanKeuanganState();
}

class _HalamanKeuanganState extends ConsumerState<HalamanKeuangan> {
  bool _isProcessingPayment = false;

  void _simulasiPembayaran(int userId) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Metode Pembayaran',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: WarnaAplikasi.teksUtama,
                  fontFamily: 'Inter',
                ),
              ),
              const Gap(16),
              _bangunPilihanMetode(
                label: 'Transfer Bank (Virtual Account)',
                iconData: LucideIcons.landmark,
                iconColor: WarnaAplikasi.krsIcon,
                iconBg: WarnaAplikasi.krsTint,
              ),
              const Gap(12),
              _bangunPilihanMetode(
                label: 'E-Wallet (OVO, GoPay, DANA)',
                iconData: LucideIcons.wallet,
                iconColor: WarnaAplikasi.transkripIcon,
                iconBg: WarnaAplikasi.transkripTint,
              ),
              const Gap(24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _prosesTransaksi(userId);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 0),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: WarnaAplikasi.utama,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Konfirmasi & Bayar',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _bangunPilihanMetode({
    required String label,
    required IconData iconData,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: WarnaAplikasi.latarBelakang,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 16),
          ),
          const Gap(12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: WarnaAplikasi.teksUtama,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const Icon(LucideIcons.circle, size: 16, color: WarnaAplikasi.teksSekunder),
        ],
      ),
    );
  }

  void _prosesTransaksi(int userId) async {
    setState(() {
      _isProcessingPayment = true;
    });

    try {
      await ref.read(apiServiceProvider).bayarKeuangan(userId);
      ref.invalidate(keuanganProvider);
      await ref.read(authProvider.notifier).refreshProfile();
      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pembayaran UKT berhasil diselesaikan!'),
            backgroundColor: WarnaAplikasi.sukses,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memproses transaksi: $e'),
            backgroundColor: WarnaAplikasi.bahaya,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    final keuanganAsync = ref.watch(keuanganProvider);

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
          'Keuangan',
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
        child: _isProcessingPayment
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: WarnaAplikasi.utama),
                    Gap(16),
                    Text(
                      'Memproses transaksi Anda...',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: WarnaAplikasi.teksSekunder,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              )
            : keuanganAsync.when(
                loading: () => const Center(child: CircularProgressIndicator(color: WarnaAplikasi.utama)),
                error: (err, stack) => Center(child: Text('Gagal memuat keuangan: $err')),
                data: (data) {
                  final String tunggakan = data['keuangan_tunggakan'] ?? 'Rp 0';
                  final String terbayar = data['keuangan_terbayar'] ?? 'Rp 0';
                  final String total = data['keuangan_total'] ?? 'Rp 0';
                  final String status = data['keuangan_status'] ?? 'Lunas';
                  final List<dynamic> riwayat = data['riwayat'] ?? [];
                  final bool isPaid = status == 'Lunas';

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        _bangunSummaryHeader(tunggakan, isPaid),

                        const Gap(24),

                        
                        _bangunGridRincian(total, tunggakan, terbayar, isPaid),

                        const Gap(28),

                        
                        _bangunKartuTagihanSPP(user?['id'] ?? 0, isPaid),

                        const Gap(28),

                        
                        _bangunRiwayatPembayaran(riwayat),

                        const Gap(28),

                        
                        _bangunMetodePembayaran(),

                        const Gap(20),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _bangunSummaryHeader(String tunggakan, bool isPaid) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Belum Terbayar',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: WarnaAplikasi.teksSekunder,
                  fontFamily: 'Inter',
                ),
              ),
              const Gap(6),
              Text(
                isPaid ? 'Rp 0' : '${tunggakan.replaceAll('Rp ', 'Rp').replaceAll('000', '').substring(0, tunggakan.length > 9 ? 8 : 7)} jt',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: WarnaAplikasi.bahaya,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          if (!isPaid)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: WarnaAplikasi.bahayaTint,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '15 Hari lagi',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: WarnaAplikasi.bahaya,
                  fontFamily: 'Inter',
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _bangunGridRincian(String total, String tunggakan, String terbayar, bool isPaid) {
    return Column(
      children: [
        _bangunKartuDetailSaldo(
          judul: 'Total Tagihan',
          nilai: total,
          sub: '+2.5% dari semester lalu',
          icon: LucideIcons.wallet,
          iconBg: WarnaAplikasi.menuBiruTint,
          iconColor: WarnaAplikasi.menuBiruIcon,
          nilaiColor: WarnaAplikasi.krsIcon,
        ),
        const Gap(16),
        _bangunKartuDetailSaldo(
          judul: 'Tunggakan',
          nilai: tunggakan,
          sub: isPaid ? 'Lunas' : 'Jatuh tempo dalam 15 hari',
          icon: LucideIcons.alertTriangle,
          iconBg: WarnaAplikasi.bahayaTint,
          iconColor: WarnaAplikasi.bahaya,
          nilaiColor: isPaid ? WarnaAplikasi.sukses : WarnaAplikasi.bahaya,
        ),
        const Gap(16),
        _bangunKartuDetailSaldo(
          judul: 'Terbayar Semester Ini',
          nilai: terbayar,
          sub: isPaid ? '100% selesai' : '67% selesai',
          icon: LucideIcons.checkCircle,
          iconBg: WarnaAplikasi.suksesTint,
          iconColor: WarnaAplikasi.sukses,
          nilaiColor: WarnaAplikasi.sukses,
        ),
      ],
    );
  }

  Widget _bangunKartuDetailSaldo({
    required String judul,
    required String nilai,
    required String sub,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required Color nilaiColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
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
              children: [
                Text(
                  judul,
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: nilaiColor,
                    fontFamily: 'Inter',
                  ),
                ),
                const Gap(6),
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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _bangunKartuTagihanSPP(int userId, bool isPaid) {
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
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: WarnaAplikasi.menuOranyeTint,
                  shape: BoxShape.circle,
                ),
                child: const Icon(LucideIcons.fileText, color: WarnaAplikasi.menuOranyeIcon, size: 20),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Semester Ganjil 2024/2025',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: WarnaAplikasi.teksUtama,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Gap(4),
                    Text(
                      'UKT - Teknik Informatika',
                      style: TextStyle(
                        fontSize: 11,
                        color: WarnaAplikasi.teksSekunder,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPaid ? WarnaAplikasi.suksesTint : WarnaAplikasi.bahayaTint,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isPaid ? 'Lunas' : 'Belum Terbayar',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: isPaid ? WarnaAplikasi.sukses : WarnaAplikasi.bahaya,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  const Gap(8),
                  const Text(
                    'Tagihan #INV-2024-001',
                    style: TextStyle(
                      fontSize: 10,
                      color: WarnaAplikasi.teksSekunder,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Membuka rincian invoice tagihan...'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: const Text(
                      'Lihat Detail',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: WarnaAplikasi.krsIcon,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  if (!isPaid) ...[
                    const Gap(8),
                    ElevatedButton(
                      onPressed: () => _simulasiPembayaran(userId),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        backgroundColor: WarnaAplikasi.krsIcon,
                        foregroundColor: Colors.white,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Bayar',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bangunRiwayatPembayaran(List<dynamic> riwayat) {
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
            'Riwayat Pembayaran',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          if (riwayat.isEmpty)
            const Text('Tidak ada riwayat pembayaran.', style: TextStyle(fontSize: 12, color: WarnaAplikasi.teksSekunder))
          else
            ...riwayat.map((item) {
              final isDaftar = item['type'] == 'daftar';
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _bangunItemRiwayat(
                  title: item['title'],
                  sub: item['sub'],
                  date: item['date'],
                  amount: item['amount'],
                  icon: isDaftar ? LucideIcons.creditCard : LucideIcons.check,
                  iconBg: isDaftar ? WarnaAplikasi.menuBiruTint : WarnaAplikasi.suksesTint,
                  iconColor: isDaftar ? WarnaAplikasi.menuBiruIcon : WarnaAplikasi.sukses,
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _bangunItemRiwayat({
    required String title,
    required String sub,
    required String date,
    required String amount,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 16),
        ),
        const Gap(14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
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
              const Gap(4),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 9,
                  color: WarnaAplikasi.teksSekunder,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
        const Gap(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: WarnaAplikasi.teksUtama,
                fontFamily: 'Inter',
              ),
            ),
            const Gap(4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: WarnaAplikasi.suksesTint,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Selesai',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: WarnaAplikasi.sukses,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _bangunMetodePembayaran() {
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
            'Metode Pembayaran',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: WarnaAplikasi.teksUtama,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(4),
          const Text(
            'Pilih metode pembayaran pilihan Anda',
            style: TextStyle(
              fontSize: 11,
              color: WarnaAplikasi.teksSekunder,
              fontFamily: 'Inter',
            ),
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _bangunMetodeIconCard(
                iconData: LucideIcons.landmark,
                iconColor: WarnaAplikasi.krsIcon,
                iconBg: WarnaAplikasi.krsTint,
              ),
              _bangunMetodeIconCard(
                iconData: LucideIcons.smartphone,
                iconColor: WarnaAplikasi.presensiIcon,
                iconBg: WarnaAplikasi.presensiTint,
              ),
              _bangunMetodeIconCard(
                iconData: LucideIcons.wallet,
                iconColor: WarnaAplikasi.transkripIcon,
                iconBg: WarnaAplikasi.transkripTint,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bangunMetodeIconCard({
    required IconData iconData,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: WarnaAplikasi.latarBelakang,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(iconData, color: iconColor, size: 20),
        ),
      ),
    );
  }
}
