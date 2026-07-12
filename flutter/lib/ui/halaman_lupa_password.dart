import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../helper/rute_aplikasi.dart';
import '../helper/warna_aplikasi.dart';

class HalamanLupaPassword extends StatefulWidget {
  const HalamanLupaPassword({super.key});

  @override
  State<HalamanLupaPassword> createState() => _HalamanLupaPasswordState();
}

class _HalamanLupaPasswordState extends State<HalamanLupaPassword> {
  int _currentStep = 1; // 1: Email, 2: OTP, 3: Reset Password

  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _sandiBaruController = TextEditingController();
  final _konfirmasiSandiController = TextEditingController();

  bool _sembunyikanSandiBaru = true;
  bool _sembunyikanKonfirmasiSandi = true;

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _sandiBaruController.dispose();
    _konfirmasiSandiController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 1) {
      if (_emailController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Silakan masukkan email Anda!')),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kode OTP berhasil dikirim ke email Anda!'),
        ),
      );
      setState(() {
        _currentStep = 2;
      });
    } else if (_currentStep == 2) {
      if (_otpController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Silakan masukkan kode OTP!')),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP berhasil diverifikasi!')),
      );
      setState(() {
        _currentStep = 3;
      });
    } else if (_currentStep == 3) {
      if (_sandiBaruController.text.isEmpty ||
          _konfirmasiSandiController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Silakan lengkapi semua kolom password!'),
          ),
        );
        return;
      }
      if (_sandiBaruController.text != _konfirmasiSandiController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Konfirmasi password tidak cocok!')),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password berhasil diperbarui! Silakan login.'),
        ),
      );
      // Navigate to login screen
      context.go(RuteAplikasi.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/bg_login.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              WarnaAplikasi.biruUtama.withValues(alpha: 0.85),
              BlendMode.srcOver,
            ),
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Circular Logo
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/logo_pnc.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Gap(16),

                  // Title
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SIAKAD ',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'PNC',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          color: WarnaAplikasi.sekunder,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const Gap(32),

                  // Main Card
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 25,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Curved Blue Header with ClipPath
                          ClipPath(
                            clipper: ResetHeaderClipper(),
                            child: Container(
                              color: WarnaAplikasi.biruUtama,
                              padding: const EdgeInsets.fromLTRB(
                                24,
                                28,
                                24,
                                48,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    _getHeaderTitle(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  const Gap(6),
                                  Text(
                                    _getHeaderSubtitle(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Form Area
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ..._bangunFormFields(),
                                const Gap(24),

                                // Action Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: _nextStep,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: WarnaAplikasi.biruUtama,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      _getButtonText(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(16),

                                // Back to Login Link
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      context.go(RuteAplikasi.login);
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor:
                                          WarnaAplikasi.teksSekunder,
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(LucideIcons.arrowLeft, size: 16),
                                        Gap(6),
                                        Text(
                                          'Kembali ke Login',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
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
                        ],
                      ),
                    ),
                  ),
                  const Gap(48),

                  // Footer Help Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        LucideIcons.headphones,
                        color: Colors.white,
                        size: 16,
                      ),
                      const Gap(8),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                          ),
                          children: [
                            TextSpan(text: 'Layanan Bantuan | '),
                            TextSpan(
                              text: 'PNC CALL',
                              style: TextStyle(
                                color: WarnaAplikasi.sekunder,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getHeaderTitle() {
    switch (_currentStep) {
      case 1:
        return 'Lupa Password';
      case 2:
        return 'Verifikasi OTP';
      case 3:
        return 'Password Baru';
      default:
        return 'Lupa Password';
    }
  }

  String _getHeaderSubtitle() {
    switch (_currentStep) {
      case 1:
        return 'Masukkan email terdaftar Anda untuk menerima kode OTP.';
      case 2:
        return 'Masukkan 6-digit kode OTP yang telah dikirim ke email Anda.';
      case 3:
        return 'Silakan masukkan password baru Anda.';
      default:
        return '';
    }
  }

  String _getButtonText() {
    switch (_currentStep) {
      case 1:
        return 'Kirim Kode OTP';
      case 2:
        return 'Verifikasi Kode';
      case 3:
        return 'Simpan Password';
      default:
        return 'Lanjut';
    }
  }

  List<Widget> _bangunFormFields() {
    if (_currentStep == 1) {
      return [
        const Text(
          'Email',
          style: TextStyle(
            color: WarnaAplikasi.teksUtama,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        const Gap(8),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Masukkan email anda',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ];
    } else if (_currentStep == 2) {
      return [
        const Text(
          'Kode OTP',
          style: TextStyle(
            color: WarnaAplikasi.teksUtama,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        const Gap(8),
        TextFormField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 8,
          ),
          decoration: InputDecoration(
            hintText: 'Masukkan 6-digit OTP',
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 13,
              letterSpacing: 0,
            ),
            counterText: '',
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ];
    } else {
      return [
        const Text(
          'Password Baru',
          style: TextStyle(
            color: WarnaAplikasi.teksUtama,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        const Gap(8),
        TextFormField(
          controller: _sandiBaruController,
          obscureText: _sembunyikanSandiBaru,
          decoration: InputDecoration(
            hintText: 'Masukkan password baru',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            suffixIcon: IconButton(
              icon: Icon(
                _sembunyikanSandiBaru ? LucideIcons.eyeOff : LucideIcons.eye,
                color: Colors.grey.shade600,
                size: 18,
              ),
              onPressed: () {
                setState(() {
                  _sembunyikanSandiBaru = !_sembunyikanSandiBaru;
                });
              },
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
        const Gap(16),
        const Text(
          'Konfirmasi Password',
          style: TextStyle(
            color: WarnaAplikasi.teksUtama,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        const Gap(8),
        TextFormField(
          controller: _konfirmasiSandiController,
          obscureText: _sembunyikanKonfirmasiSandi,
          decoration: InputDecoration(
            hintText: 'Ulangi password baru',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            suffixIcon: IconButton(
              icon: Icon(
                _sembunyikanKonfirmasiSandi
                    ? LucideIcons.eyeOff
                    : LucideIcons.eye,
                color: Colors.grey.shade600,
                size: 18,
              ),
              onPressed: () {
                setState(() {
                  _sembunyikanKonfirmasiSandi = !_sembunyikanKonfirmasiSandi;
                });
              },
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ];
    }
  }
}

class ResetHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.85);
    // Smooth quadratic curve dipping slightly in the center
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 1.15,
      size.width,
      size.height * 0.85,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
