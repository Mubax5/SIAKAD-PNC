import 'package:go_router/go_router.dart';
import 'package:siakad_app/ui/halaman_login.dart';
import 'package:siakad_app/ui/halaman_beranda.dart';
import 'package:siakad_app/ui/halaman_lupa_password.dart';
import 'package:siakad_app/ui/halaman_input_krs.dart';
import 'package:siakad_app/ui/halaman_tugas_akhir.dart';
import 'package:siakad_app/ui/halaman_nilai_transkrip.dart';
import 'package:siakad_app/ui/halaman_surat.dart';
import 'package:siakad_app/ui/halaman_mbkm.dart';
import 'package:siakad_app/ui/halaman_keuangan.dart';

class RuteAplikasi {
  static const String login = '/login';
  static const String utama = '/utama';
  static const String lupaPassword = '/lupa-password';
  static const String inputKrs = '/input-krs';
  static const String tugasAkhir = '/tugas-akhir';
  static const String nilaiTranskrip = '/nilai-transkrip';
  static const String surat = '/surat';
  static const String mbkm = '/mbkm';
  static const String keuangan = '/keuangan';

  static final GoRouter rute = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(path: login, builder: (context, state) => const HalamanLogin()),
      GoRoute(path: utama, builder: (context, state) => const HalamanBeranda()),
      GoRoute(
        path: lupaPassword,
        builder: (context, state) => const HalamanLupaPassword(),
      ),
      GoRoute(
        path: inputKrs,
        builder: (context, state) => const HalamanInputKrs(),
      ),
      GoRoute(
        path: tugasAkhir,
        builder: (context, state) => const HalamanTugasAkhir(),
      ),
      GoRoute(
        path: nilaiTranskrip,
        builder: (context, state) => const HalamanNilaiTranskrip(),
      ),
      GoRoute(path: surat, builder: (context, state) => const HalamanSurat()),
      GoRoute(path: mbkm, builder: (context, state) => const HalamanMbkm()),
      GoRoute(
        path: keuangan,
        builder: (context, state) => const HalamanKeuangan(),
      ),
    ],
  );
}
