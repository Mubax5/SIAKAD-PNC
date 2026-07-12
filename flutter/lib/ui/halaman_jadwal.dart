import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/warna_aplikasi.dart';
import '../helper/api_service.dart';


class HalamanJadwal extends ConsumerStatefulWidget {
  const HalamanJadwal({super.key});

  @override
  ConsumerState<HalamanJadwal> createState() => _HalamanJadwalState();
}

class _HalamanJadwalState extends ConsumerState<HalamanJadwal> {
  bool _isTodayView = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WarnaAplikasi.latarBelakang,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Jadwal Mingguan',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              _bangunHeaderRow(),

              const Gap(24),

              
              _isTodayView ? _bangunTodayView() : _bangunWeekView(),

              const Gap(32),

              
              _bangunKalenderAkademikSection(),

              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _bangunHeaderRow() {
    final user = ref.watch(authProvider);
    final String semesterText = 'Semester ${user?['semester'] ?? 3}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          semesterText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: WarnaAplikasi.teksUtama,
            fontFamily: 'Inter',
          ),
        ),

        
        Container(
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(2),
          child: Row(
            children: [
              
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isTodayView = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _isTodayView
                        ? const Color(0xFF01456A)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Today',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _isTodayView
                          ? Colors.white
                          : WarnaAplikasi.teksSekunder,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isTodayView = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: !_isTodayView
                        ? const Color(0xFF01456A)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Week',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: !_isTodayView
                          ? Colors.white
                          : WarnaAplikasi.teksSekunder,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  
  Widget _bangunTodayView() {
    return ref.watch(matkulProvider).when(
      loading: () => const Center(child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: CircularProgressIndicator(color: WarnaAplikasi.utama),
      )),
      error: (e, _) => Center(child: Text('Gagal memuat jadwal: $e', style: const TextStyle(fontFamily: 'Inter', color: Colors.red))),
      data: (courses) {
        final today = _hariIniIndonesian();
        final todayCourses = courses.where((m) {
          final j = m['jadwal']?.toString() ?? '';
          return j.toLowerCase().startsWith(today.toLowerCase());
        }).toList();

        if (todayCourses.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  Icon(Icons.event_available_outlined, size: 48, color: WarnaAplikasi.teksSekunder.withValues(alpha: 0.4)),
                  const Gap(12),
                  Text('Tidak ada kuliah $today', style: const TextStyle(fontSize: 14, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter')),
                ],
              ),
            ),
          );
        }

        final now = TimeOfDay.now();
        return Column(
          children: todayCourses.map((m) {
            final j = m['jadwal']?.toString() ?? '';
            final parts = j.split(',');
            final timeStr = parts.length > 1 ? parts[1].replaceAll('WIB', '').trim() : '';
            final room = m['ruang']?.toString() ?? 'Online';

            bool isOngoing = false;
            if (timeStr.contains('-')) {
              final timeParts = timeStr.split('-');
              if (timeParts.length == 2) {
                final startParts = timeParts[0].trim().split(':');
                final endParts = timeParts[1].trim().split(':');
                if (startParts.length >= 2 && endParts.length >= 2) {
                  final startH = int.tryParse(startParts[0]) ?? 0;
                  final startM = int.tryParse(startParts[1]) ?? 0;
                  final endH = int.tryParse(endParts[0]) ?? 0;
                  final endM = int.tryParse(endParts[1]) ?? 0;
                  final nowMins = now.hour * 60 + now.minute;
                  final startMins = startH * 60 + startM;
                  final endMins = endH * 60 + endM;
                  isOngoing = nowMins >= startMins && nowMins <= endMins;
                }
              }
            }

            return _bangunTodayCard(
              title: m['nama'] ?? '',
              lecturer: m['dosen'] ?? '',
              room: room,
              time: timeStr,
              isOngoing: isOngoing,
            );
          }).toList(),
        );
      },
    );
  }

  
  Widget _bangunTodayCard({
    required String title,
    required String lecturer,
    required String room,
    required String time,
    required bool isOngoing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isOngoing ? const Color(0xFFF0F6FF) : const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isOngoing ? const Color(0xFFBFDBFE) : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          
          Container(
            width: 4,
            height: 80,
            decoration: BoxDecoration(
              color: isOngoing
                  ? const Color(0xFF0058C6)
                  : const Color(0xFFCBD5E1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),

          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                            fontFamily: 'Inter',
                          ),
                        ),
                        const Gap(2),
                        Text(
                          lecturer,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: WarnaAplikasi.teksSekunder,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const Gap(6),
                        Text(
                          room,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isOngoing
                                ? const Color(0xFF0058C6)
                                : WarnaAplikasi.teksSekunder,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),

                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                          fontFamily: 'Inter',
                        ),
                      ),
                      const Gap(8),
                      
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isOngoing
                              ? const Color(0xFFE0EDFF)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          isOngoing ? 'Ongoing' : 'Upcoming',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: isOngoing
                                ? const Color(0xFF0058C6)
                                : const Color(0xFF64748B),
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
    );
  }

  
  Widget _bangunWeekView() {
    return ref.watch(matkulProvider).when(
      loading: () => const Center(child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: CircularProgressIndicator(color: WarnaAplikasi.utama),
      )),
      error: (e, _) => Center(child: Text('Gagal memuat jadwal: $e', style: const TextStyle(fontFamily: 'Inter', color: Colors.red))),
      data: (courses) {
        final urutan = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
        final Map<String, List<Map<String, dynamic>>> grouped = {};
        for (final hari in urutan) {
          final list = courses.where((m) {
            final j = m['jadwal']?.toString() ?? '';
            return j.toLowerCase().startsWith(hari.toLowerCase());
          }).toList();
          if (list.isNotEmpty) grouped[hari] = list;
        }

        if (grouped.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Text('Tidak ada jadwal mingguan.', style: TextStyle(fontSize: 14, color: WarnaAplikasi.teksSekunder, fontFamily: 'Inter')),
            ),
          );
        }

        return Column(
          children: grouped.entries.map((entry) {
            final tags = entry.value.map((m) {
              final sks = m['sks']?.toString() ?? '2';
              return '${m['nama']} | $sks SKS';
            }).toList();
            return _bangunWeekDayBlock(dayName: entry.key, tags: tags);
          }).toList(),
        );
      },
    );
  }

  
  Widget _bangunWeekDayBlock({
    required String dayName,
    required List<String> tags,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F6FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBFDBFE), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Container(
            width: 4,
            height: 90,
            decoration: const BoxDecoration(
              color: Color(0xFF0058C6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),

          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(
                    dayName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                      fontFamily: 'Inter',
                    ),
                  ),
                  const Gap(8),

                  
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: tags.map((t) => _bangunCourseTag(t)).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _bangunCourseTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF01456A),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  
  Widget _bangunKalenderAkademikSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kalender Akademik',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
            fontFamily: 'Inter',
          ),
        ),
        const Gap(2),
        const Text(
          'Important dates & deadlines',
          style: TextStyle(
            fontSize: 12,
            color: WarnaAplikasi.teksSekunder,
            fontFamily: 'Inter',
          ),
        ),
        const Gap(16),

        
        _bangunTimelineItem(
          title: 'Ujian Tengah Semester Gasal (Praktek)',
          dateRange: 'October 13-17, 2025',
          remainingDays: '6 days remaining',
          color: Colors.red,
        ),
        _bangunTimelineItem(
          title: 'Ujian Tengah Semester Gasal (Teori)',
          dateRange: 'October 12, 2025',
          remainingDays: '3 days remaining',
          color: Colors.orange,
        ),
        _bangunTimelineItem(
          title: 'Final Exams (UAS)',
          dateRange: 'December 10-20, 2025',
          remainingDays: '62 days remaining',
          color: Colors.blue,
        ),
      ],
    );
  }

  
  Widget _bangunTimelineItem({
    required String title,
    required String dateRange,
    required String remainingDays,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
          const Gap(14),

          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                    fontFamily: 'Inter',
                  ),
                ),
                const Gap(2),
                Text(
                  dateRange,
                  style: const TextStyle(
                    fontSize: 11,
                    color: WarnaAplikasi.teksSekunder,
                    fontFamily: 'Inter',
                  ),
                ),
                const Gap(2),
                Text(
                  remainingDays,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: color,
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

  String _hariIniIndonesian() {
    final now = DateTime.now();
    switch (now.weekday) {
      case DateTime.monday: return 'Senin';
      case DateTime.tuesday: return 'Selasa';
      case DateTime.wednesday: return 'Rabu';
      case DateTime.thursday: return 'Kamis';
      case DateTime.friday: return 'Jumat';
      case DateTime.saturday: return 'Sabtu';
      case DateTime.sunday: return 'Minggu';
      default: return '';
    }
  }
}
