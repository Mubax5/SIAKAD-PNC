import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/rute_aplikasi.dart';
import '../helper/warna_aplikasi.dart';
import '../helper/api_service.dart';

class HalamanLogin extends ConsumerStatefulWidget {
  const HalamanLogin({super.key});

  @override
  ConsumerState<HalamanLogin> createState() => _HalamanLoginState();
}

class _HalamanLoginState extends ConsumerState<HalamanLogin> {
  bool _sembunyikanSandi = true;
  final _npmController = TextEditingController();
  final _sandiController = TextEditingController();

  @override
  void dispose() {
    _npmController.dispose();
    _sandiController.dispose();
    super.dispose();
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
                          
                          ClipPath(
                            clipper: HeaderClipper(),
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
                                  const Text(
                                    'Log in',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  const Gap(6),
                                  RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: 'Inter',
                                      ),
                                      children: [
                                        TextSpan(text: 'Masuk ke akun '),
                                        TextSpan(
                                          text: 'Siakad',
                                          style: TextStyle(
                                            color: WarnaAplikasi.sekunder,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(text: ' anda.'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                const Text(
                                  'NPM',
                                  style: TextStyle(
                                    color: WarnaAplikasi.teksUtama,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                const Gap(8),
                                
                                TextFormField(
                                  controller: _npmController,
                                  decoration: InputDecoration(
                                    hintText: 'Masukan NPM anda',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 13,
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
                                  'Password',
                                  style: TextStyle(
                                    color: WarnaAplikasi.teksUtama,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                const Gap(8),
                                
                                TextFormField(
                                  controller: _sandiController,
                                  obscureText: _sembunyikanSandi,
                                  decoration: InputDecoration(
                                    hintText: 'Masukan password anda',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 13,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _sembunyikanSandi
                                            ? LucideIcons.eyeOff
                                            : LucideIcons.eye,
                                        color: Colors.grey.shade600,
                                        size: 18,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _sembunyikanSandi =
                                              !_sembunyikanSandi;
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
                                const Gap(10),

                                
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      context.push(RuteAplikasi.lupaPassword);
                                    },
                                    child: RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          color: WarnaAplikasi.teksSekunder,
                                        ),
                                        children: [
                                          TextSpan(text: 'Lupa password? '),
                                          TextSpan(
                                            text: 'Klik di sini',
                                            style: TextStyle(
                                              color: WarnaAplikasi.sekunder,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(24),

                                
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final email = _npmController.text.trim();
                                      final password = _sandiController.text.trim();
                                      if (email.isEmpty || password.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Email/NIM dan Password wajib diisi!')),
                                        );
                                        return;
                                      }
                                      try {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => const Center(child: CircularProgressIndicator()),
                                        );
                                        await ref.read(authProvider.notifier).login(email, password);
                                        if (context.mounted) {
                                          Navigator.pop(context); 
                                          context.go(RuteAplikasi.utama);
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          Navigator.pop(context); 
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Login gagal: ${e.toString().replaceAll('Exception:', '')}')),
                                          );
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: WarnaAplikasi.biruUtama,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter',
                                      ),
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
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.85);
    
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
