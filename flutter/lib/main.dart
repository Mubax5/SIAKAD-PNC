import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'helper/rute_aplikasi.dart';
import 'helper/tema_aplikasi.dart';

void main() {
  runApp(const ProviderScope(child: AplikasiSiakad()));
}

class AplikasiSiakad extends ConsumerWidget {
  const AplikasiSiakad({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'SIAKAD Pro',
      theme: TemaAplikasi.temaSistem,
      routerConfig: RuteAplikasi.rute,
      debugShowCheckedModeBanner: false,
    );
  }
}
