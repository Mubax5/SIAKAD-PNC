import 'package:flutter/material.dart';
export 'warna_aplikasi.dart';
import 'warna_aplikasi.dart';

class TemaAplikasi {
  static ThemeData get temaSistem {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.fromSeed(
        seedColor: WarnaAplikasi.utama,
        primary: WarnaAplikasi.utama,
        secondary: WarnaAplikasi.sekunder,
        surface: WarnaAplikasi.permukaan,
        error: WarnaAplikasi.bahaya,
      ),
      scaffoldBackgroundColor: WarnaAplikasi.latar,
      appBarTheme: const AppBarTheme(
        backgroundColor: WarnaAplikasi.permukaan,
        foregroundColor: WarnaAplikasi.teksUtama,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: WarnaAplikasi.utama,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}
