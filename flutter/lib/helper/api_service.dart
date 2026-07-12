import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ApiService {
  
  static const String baseUrl = 'http://127.0.0.1:8080/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(data['message'] ?? 'Gagal masuk.');
    }
  }

  Future<Map<String, dynamic>> getProfile(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/profile/$userId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Gagal memuat profil.');
  }

  Future<List<Map<String, dynamic>>> getMatkul(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/matkul/$userId'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(json['data'] ?? []);
    }
    throw Exception('Gagal memuat daftar mata kuliah.');
  }

  Future<Map<String, dynamic>> getPresensi(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/presensi/$userId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Gagal memuat data presensi.');
  }

  Future<void> markPresensiCepat(int userId, int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/presensi/mark/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal menandai kehadiran.');
    }
  }

  Future<Map<String, dynamic>> getTugasAkhir(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/tugas-akhir/$userId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Gagal memuat data tugas akhir.');
  }

  Future<List<Map<String, dynamic>>> getNilaiTranskrip(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/nilai-transkrip/$userId'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(json['data'] ?? []);
    }
    throw Exception('Gagal memuat transkrip nilai.');
  }

  Future<List<Map<String, dynamic>>> getSurat(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/surat/$userId'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(json['data'] ?? []);
    }
    throw Exception('Gagal memuat permohonan surat.');
  }

  Future<Map<String, dynamic>> getKeuangan(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/keuangan/$userId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Gagal memuat data keuangan.');
  }

  Future<void> bayarKeuangan(int userId) async {
    final response = await http.post(Uri.parse('$baseUrl/user/keuangan/bayar/$userId'));
    if (response.statusCode != 200) {
      throw Exception('Gagal memproses pembayaran.');
    }
  }

  Future<Map<String, dynamic>> getMbkm(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/mbkm/$userId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Gagal memuat data MBKM.');
  }

  Future<void> submitKrs(int userId, int sks) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/krs/submit/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'sks': sks}),
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal mengajukan KRS.');
    }
  }

  Future<void> addSurat(int userId, String jenis) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/surat/add/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'jenis_surat': jenis}),
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal mengajukan permohonan surat.');
    }
  }
}


final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class AuthNotifier extends Notifier<Map<String, dynamic>?> {
  @override
  Map<String, dynamic>? build() {
    return null;
  }

  Future<void> login(String email, String password) async {
    final res = await ref.read(apiServiceProvider).login(email, password);
    state = Map<String, dynamic>.from(res['user']);
  }

  void logout() {
    state = null;
  }

  void updateProfile(Map<String, dynamic> newProfile) {
    state = newProfile;
  }

  Future<void> refreshProfile() async {
    if (state == null) return;
    final userId = state!['id'];
    final res = await ref.read(apiServiceProvider).getProfile(userId);
    state = Map<String, dynamic>.from(res['user']);
  }
}

final authProvider = NotifierProvider<AuthNotifier, Map<String, dynamic>?>(AuthNotifier.new);


final matkulProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final user = ref.watch(authProvider);
  if (user == null) return [];
  return ref.read(apiServiceProvider).getMatkul(user['id']);
});

final presensiProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final user = ref.watch(authProvider);
  if (user == null) return {};
  return ref.read(apiServiceProvider).getPresensi(user['id']);
});

final tugasAkhirProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final user = ref.watch(authProvider);
  if (user == null) return {};
  return ref.read(apiServiceProvider).getTugasAkhir(user['id']);
});

final nilaiProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final user = ref.watch(authProvider);
  if (user == null) return [];
  return ref.read(apiServiceProvider).getNilaiTranskrip(user['id']);
});

final suratProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final user = ref.watch(authProvider);
  if (user == null) return [];
  return ref.read(apiServiceProvider).getSurat(user['id']);
});

final keuanganProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final user = ref.watch(authProvider);
  if (user == null) return {};
  return ref.read(apiServiceProvider).getKeuangan(user['id']);
});

final mbkmProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final user = ref.watch(authProvider);
  if (user == null) return {};
  return ref.read(apiServiceProvider).getMbkm(user['id']);
});
