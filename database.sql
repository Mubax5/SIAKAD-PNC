-- SIAKAD PNC Database Dump for MySQL
-- Generated dynamically from SQLite3 local database

CREATE DATABASE IF NOT EXISTS `siakad` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `siakad`;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `nim` varchar(50) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `prodi` varchar(100) NOT NULL,
  `semester` int(5) NOT NULL,
  `ipk` double NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `sks_krs` int(11) NOT NULL,
  `sks_total` varchar(50) NOT NULL,
  `ta_progres` int(11) NOT NULL,
  `ta_judul` varchar(255) NOT NULL,
  `ta_dosen` varchar(255) NOT NULL,
  `ta_mulai` varchar(50) NOT NULL,
  `presensi_persen` int(11) NOT NULL,
  `keuangan_tunggakan` varchar(100) NOT NULL,
  `keuangan_terbayar` varchar(100) NOT NULL,
  `keuangan_total` varchar(100) NOT NULL,
  `keuangan_status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `users` (`id`, `nim`, `nama`, `email`, `password`, `prodi`, `semester`, `ipk`, `avatar`, `sks_krs`, `sks_total`, `ta_progres`, `ta_judul`, `ta_dosen`, `ta_mulai`, `presensi_persen`, `keuangan_tunggakan`, `keuangan_terbayar`, `keuangan_total`, `keuangan_status`) VALUES
(1, '240202078', 'Hilmi Mubarok', 'hilmi@siakad.ac.id', '$2y$10$2epBg/NoIPlyC2xoveD43O1qETAL3XTYRtECYBOugqiDWi3jX0ww.', 'Teknik Informatika', 3, 3.85, 'https://avatar.iran.liara.run/public/boy?username=Hilmi', 20, '124/144', 65, 'Machine Learning Application for Student Performance Prediction', 'Fajar Mahardika, S.Kom., M.Kom.', 'Sep 2024', 92, 'Rp 5.250.000', 'Rp 10.500.000', 'Rp 15.750.000', 'Belum Terbayar'),
(2, '240102080', 'Khalifah Brilianti R', 'khalifah@siakad.ac.id', '$2y$10$2epBg/NoIPlyC2xoveD43O1qETAL3XTYRtECYBOugqiDWi3jX0ww.', 'Teknik Informatika', 5, 3.72, 'https://avatar.iran.liara.run/public/girl?username=Khalifah', 22, '98/144', 30, 'Desain UI/UX Sistem Informasi Akademik Berbasis Mobile', 'Nur Wahyu Rahadi, S.Kom, M.Eng.', 'Maret 2025', 88, 'Rp 0', 'Rp 15.750.000', 'Rp 15.750.000', 'Lunas'),
(3, '240102087', 'Nadjwa Naela Aziz', 'nadjwa@siakad.ac.id', '$2y$10$2epBg/NoIPlyC2xoveD43O1qETAL3XTYRtECYBOugqiDWi3jX0ww.', 'Teknik Informatika', 3, 3.91, 'https://avatar.iran.liara.run/public/girl?username=Nadjwa', 20, '68/144', 0, 'Belum Mengajukan Tugas Akhir', 'Belum Ditentukan', 'N/A', 96, 'Rp 5.250.000', 'Rp 10.500.000', 'Rp 15.750.000', 'Belum Terbayar'),
(4, '240202094', 'Suryo Nugroho', 'suryo@siakad.ac.id', '$2y$10$2epBg/NoIPlyC2xoveD43O1qETAL3XTYRtECYBOugqiDWi3jX0ww.', 'Teknik Informatika', 5, 3.65, 'https://avatar.iran.liara.run/public/boy?username=Suryo', 24, '102/144', 45, 'Implementasi Web Security pada Sistem Pendataan Penduduk PNC', 'Andesita Prihantara, ST, M.Eng.', 'Januari 2025', 91, 'Rp 5.250.000', 'Rp 10.500.000', 'Rp 15.750.000', 'Belum Terbayar');

DROP TABLE IF EXISTS `matkul`;
CREATE TABLE `matkul` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) UNSIGNED NOT NULL,
  `kode` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `sks` int(5) NOT NULL,
  `dosen` varchar(100) NOT NULL,
  `jadwal` varchar(150) NOT NULL,
  `ruang` varchar(50) NOT NULL,
  `kelas` varchar(50) NOT NULL,
  `color_hex` varchar(20) NOT NULL,
  `bg_hex` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `matkul` (`id`, `user_id`, `kode`, `nama`, `sks`, `dosen`, `jadwal`, `ruang`, `kelas`, `color_hex`, `bg_hex`) VALUES
-- User 1 (Hilmi Mubarok) - Semester 4 TI
(1,  1, 'TI4201', 'Pemrograman Mobile',             4, 'Fajar Jm, S.Kom., M.Kom.',          'Senin, 07:30 - 11:10 WIB', 'J.5.7',  'Kelas A', 'FF1A73E8', 'FFF1F7FF'),
(2,  1, 'TI4202', 'Basis Data Lanjut',              4, 'Annas Setiawan P., S.Kom., M.Eng.', 'Senin, 11:15 - 15:30 WIB', 'J.5.6',  'Kelas A', 'FF10B981', 'FFE6FDF5'),
(3,  1, 'TI4203', 'Pemrograman Berorientasi Objek', 4, 'Nur Wahyu Rahadi, S.Kom, M.Eng.',  'Selasa, 11:15 - 15:30 WIB','J.4.10', 'Kelas A', 'FF8B5CF6', 'FFF5F3FF'),
(4,  1, 'TI4204', 'Manajemen Informasi & Sistem',   4, 'A. Dwi Setiyawan, S.Kom., M.Cs.',  'Rabu, 07:30 - 11:10 WIB',  'J.5.10', 'Kelas A', 'FFEF4444', 'FFFEF2F2'),
(5,  1, 'TI4205', 'Etika Profesi',                  2, 'Luthfi Fatah S., S.T., M.T.',       'Rabu, 11:15 - 13:50 WIB',  'I.3.7',  'Kelas A', 'FFF97316', 'FFFFF7ED'),
(6,  1, 'TI4206', 'Statistika',                    2, 'Laut Ayu U., S.Si., M.Si.',         'Rabu, 13:50 - 15:30 WIB',  'I.4.5',  'Kelas A', 'FF0EA5E9', 'FFF0F9FF'),
(7,  1, 'TI4207', 'Metodologi Penelitian TI',      2, 'Mulyono Irianto, S.T., M.T.',       'Kamis, 07:30 - 09:10 WIB', 'I.3.5',  'Kelas A', 'FF14B8A6', 'FFF0FDFA'),
(8,  1, 'TI4208', 'Manajemen Proyek',              2, 'Riyanto Darmawan, S.Kom., M.T.',    'Kamis, 09:25 - 11:10 WIB', 'I.3.5',  'Kelas A', 'FFEC4899', 'FFFFF0F7'),
(9,  1, 'TI4209', 'Pemrograman Framework',         4, 'Fajar Jm, S.Kom., M.Kom.',          'Kamis, 11:15 - 15:30 WIB', 'J.5.7',  'Kelas A', 'FF6366F1', 'FFEEF2FF'),
-- User 2 (Khalifah Brilianti)
(10, 2, 'TI4201', 'Pemrograman Mobile',             4, 'Fajar Jm, S.Kom., M.Kom.',          'Senin, 07:30 - 11:10 WIB', 'J.5.7',  'Kelas A', 'FF1A73E8', 'FFF1F7FF'),
(11, 2, 'TI4202', 'Basis Data Lanjut',              4, 'Annas Setiawan P., S.Kom., M.Eng.', 'Senin, 11:15 - 15:30 WIB', 'J.5.6',  'Kelas A', 'FF10B981', 'FFE6FDF5'),
(12, 2, 'TI4203', 'Pemrograman Berorientasi Objek', 4, 'Nur Wahyu Rahadi, S.Kom, M.Eng.',  'Selasa, 11:15 - 15:30 WIB','J.4.10', 'Kelas A', 'FF8B5CF6', 'FFF5F3FF'),
(13, 2, 'TI4204', 'Manajemen Informasi & Sistem',   4, 'A. Dwi Setiyawan, S.Kom., M.Cs.',  'Rabu, 07:30 - 11:10 WIB',  'J.5.10', 'Kelas A', 'FFEF4444', 'FFFEF2F2'),
(14, 2, 'TI4205', 'Etika Profesi',                  2, 'Luthfi Fatah S., S.T., M.T.',       'Rabu, 11:15 - 13:50 WIB',  'I.3.7',  'Kelas A', 'FFF97316', 'FFFFF7ED'),
(15, 2, 'TI4206', 'Statistika',                    2, 'Laut Ayu U., S.Si., M.Si.',         'Rabu, 13:50 - 15:30 WIB',  'I.4.5',  'Kelas A', 'FF0EA5E9', 'FFF0F9FF'),
(16, 2, 'TI4207', 'Metodologi Penelitian TI',      2, 'Mulyono Irianto, S.T., M.T.',       'Kamis, 07:30 - 09:10 WIB', 'I.3.5',  'Kelas A', 'FF14B8A6', 'FFF0FDFA'),
(17, 2, 'TI4208', 'Manajemen Proyek',              2, 'Riyanto Darmawan, S.Kom., M.T.',    'Kamis, 09:25 - 11:10 WIB', 'I.3.5',  'Kelas A', 'FFEC4899', 'FFFFF0F7'),
(18, 2, 'TI4209', 'Pemrograman Framework',         4, 'Fajar Jm, S.Kom., M.Kom.',          'Kamis, 11:15 - 15:30 WIB', 'J.5.7',  'Kelas A', 'FF6366F1', 'FFEEF2FF'),
-- User 3 (Nadjwa Naela)
(19, 3, 'TI4201', 'Pemrograman Mobile',             4, 'Fajar Jm, S.Kom., M.Kom.',          'Senin, 07:30 - 11:10 WIB', 'J.5.7',  'Kelas A', 'FF1A73E8', 'FFF1F7FF'),
(20, 3, 'TI4202', 'Basis Data Lanjut',              4, 'Annas Setiawan P., S.Kom., M.Eng.', 'Senin, 11:15 - 15:30 WIB', 'J.5.6',  'Kelas A', 'FF10B981', 'FFE6FDF5'),
(21, 3, 'TI4203', 'Pemrograman Berorientasi Objek', 4, 'Nur Wahyu Rahadi, S.Kom, M.Eng.',  'Selasa, 11:15 - 15:30 WIB','J.4.10', 'Kelas A', 'FF8B5CF6', 'FFF5F3FF'),
(22, 3, 'TI4204', 'Manajemen Informasi & Sistem',   4, 'A. Dwi Setiyawan, S.Kom., M.Cs.',  'Rabu, 07:30 - 11:10 WIB',  'J.5.10', 'Kelas A', 'FFEF4444', 'FFFEF2F2'),
(23, 3, 'TI4205', 'Etika Profesi',                  2, 'Luthfi Fatah S., S.T., M.T.',       'Rabu, 11:15 - 13:50 WIB',  'I.3.7',  'Kelas A', 'FFF97316', 'FFFFF7ED'),
(24, 3, 'TI4206', 'Statistika',                    2, 'Laut Ayu U., S.Si., M.Si.',         'Rabu, 13:50 - 15:30 WIB',  'I.4.5',  'Kelas A', 'FF0EA5E9', 'FFF0F9FF'),
(25, 3, 'TI4207', 'Metodologi Penelitian TI',      2, 'Mulyono Irianto, S.T., M.T.',       'Kamis, 07:30 - 09:10 WIB', 'I.3.5',  'Kelas A', 'FF14B8A6', 'FFF0FDFA'),
(26, 3, 'TI4208', 'Manajemen Proyek',              2, 'Riyanto Darmawan, S.Kom., M.T.',    'Kamis, 09:25 - 11:10 WIB', 'I.3.5',  'Kelas A', 'FFEC4899', 'FFFFF0F7'),
(27, 3, 'TI4209', 'Pemrograman Framework',         4, 'Fajar Jm, S.Kom., M.Kom.',          'Kamis, 11:15 - 15:30 WIB', 'J.5.7',  'Kelas A', 'FF6366F1', 'FFEEF2FF'),
-- User 4 (Suryo Nugroho)
(28, 4, 'TI4201', 'Pemrograman Mobile',             4, 'Fajar Jm, S.Kom., M.Kom.',          'Senin, 07:30 - 11:10 WIB', 'J.5.7',  'Kelas A', 'FF1A73E8', 'FFF1F7FF'),
(29, 4, 'TI4202', 'Basis Data Lanjut',              4, 'Annas Setiawan P., S.Kom., M.Eng.', 'Senin, 11:15 - 15:30 WIB', 'J.5.6',  'Kelas A', 'FF10B981', 'FFE6FDF5'),
(30, 4, 'TI4203', 'Pemrograman Berorientasi Objek', 4, 'Nur Wahyu Rahadi, S.Kom, M.Eng.',  'Selasa, 11:15 - 15:30 WIB','J.4.10', 'Kelas A', 'FF8B5CF6', 'FFF5F3FF'),
(31, 4, 'TI4204', 'Manajemen Informasi & Sistem',   4, 'A. Dwi Setiyawan, S.Kom., M.Cs.',  'Rabu, 07:30 - 11:10 WIB',  'J.5.10', 'Kelas A', 'FFEF4444', 'FFFEF2F2'),
(32, 4, 'TI4205', 'Etika Profesi',                  2, 'Luthfi Fatah S., S.T., M.T.',       'Rabu, 11:15 - 13:50 WIB',  'I.3.7',  'Kelas A', 'FFF97316', 'FFFFF7ED'),
(33, 4, 'TI4206', 'Statistika',                    2, 'Laut Ayu U., S.Si., M.Si.',         'Rabu, 13:50 - 15:30 WIB',  'I.4.5',  'Kelas A', 'FF0EA5E9', 'FFF0F9FF'),
(34, 4, 'TI4207', 'Metodologi Penelitian TI',      2, 'Mulyono Irianto, S.T., M.T.',       'Kamis, 07:30 - 09:10 WIB', 'I.3.5',  'Kelas A', 'FF14B8A6', 'FFF0FDFA'),
(35, 4, 'TI4208', 'Manajemen Proyek',              2, 'Riyanto Darmawan, S.Kom., M.T.',    'Kamis, 09:25 - 11:10 WIB', 'I.3.5',  'Kelas A', 'FFEC4899', 'FFFFF0F7'),
(36, 4, 'TI4209', 'Pemrograman Framework',         4, 'Fajar Jm, S.Kom., M.Kom.',          'Kamis, 11:15 - 15:30 WIB', 'J.5.7',  'Kelas A', 'FF6366F1', 'FFEEF2FF');

DROP TABLE IF EXISTS `presensi_cepat`;
CREATE TABLE `presensi_cepat` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `subtitle` varchar(100) NOT NULL,
  `is_marked` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `presensi_cepat` (`id`, `user_id`, `title`, `subtitle`, `is_marked`) VALUES
(1, 1, 'Data Structures', 'CS301 • Room A201 • 09:00 AM', 1),
(2, 1, 'Database Systems', 'CS302 • Room B105 • 11:00 AM', 0),
(3, 2, 'Data Structures', 'CS301 • Room A201 • 09:00 AM', 1),
(4, 2, 'Database Systems', 'CS302 • Room B105 • 11:00 AM', 0),
(5, 3, 'Data Structures', 'CS301 • Room A201 • 09:00 AM', 1),
(6, 3, 'Database Systems', 'CS302 • Room B105 • 11:00 AM', 0),
(7, 4, 'Data Structures', 'CS301 • Room A201 • 09:00 AM', 1),
(8, 4, 'Database Systems', 'CS302 • Room B105 • 11:00 AM', 0);

DROP TABLE IF EXISTS `presensi_per_mk`;
CREATE TABLE `presensi_per_mk` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) UNSIGNED NOT NULL,
  `mk_name` varchar(100) NOT NULL,
  `progress_val` double NOT NULL,
  `persentase_text` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `presensi_per_mk` (`id`, `user_id`, `mk_name`, `progress_val`, `persentase_text`) VALUES
(1, 1, 'Data Structures', 0.95, '95%'),
(2, 1, 'Database Systems', 0.88, '88%'),
(3, 1, 'Web Development', 0.75, '75%'),
(4, 1, 'Software Engineering', 0.92, '92%'),
(5, 2, 'Data Structures', 0.95, '95%'),
(6, 2, 'Database Systems', 0.88, '88%'),
(7, 2, 'Web Development', 0.75, '75%'),
(8, 2, 'Software Engineering', 0.92, '92%'),
(9, 3, 'Data Structures', 0.95, '95%'),
(10, 3, 'Database Systems', 0.88, '88%'),
(11, 3, 'Web Development', 0.75, '75%'),
(12, 3, 'Software Engineering', 0.92, '92%'),
(13, 4, 'Data Structures', 0.95, '95%'),
(14, 4, 'Database Systems', 0.88, '88%'),
(15, 4, 'Web Development', 0.75, '75%'),
(16, 4, 'Software Engineering', 0.92, '92%');

DROP TABLE IF EXISTS `presensi_aktivitas`;
CREATE TABLE `presensi_aktivitas` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) UNSIGNED NOT NULL,
  `desc` varchar(255) NOT NULL,
  `time_ago` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `presensi_aktivitas` (`id`, `user_id`, `desc`, `time_ago`, `type`) VALUES
(1, 1, 'Kehadiran ditandai untuk Data Structures', '2 jam yang lalu', 'sukses'),
(2, 1, 'Tugas dikumpulkan untuk Web Development', '1 hari yang lalu', 'krs'),
(3, 1, 'Pengingat: Kuis besok', '2 hari yang lalu', 'peringatan'),
(4, 2, 'Kehadiran ditandai untuk Data Structures', '2 jam yang lalu', 'sukses'),
(5, 2, 'Tugas dikumpulkan untuk Web Development', '1 hari yang lalu', 'krs'),
(6, 2, 'Pengingat: Kuis besok', '2 hari yang lalu', 'peringatan'),
(7, 3, 'Kehadiran ditandai untuk Data Structures', '2 jam yang lalu', 'sukses'),
(8, 3, 'Tugas dikumpulkan untuk Web Development', '1 hari yang lalu', 'krs'),
(9, 3, 'Pengingat: Kuis besok', '2 hari yang lalu', 'peringatan'),
(10, 4, 'Kehadiran ditandai untuk Data Structures', '2 jam yang lalu', 'sukses'),
(11, 4, 'Tugas dikumpulkan untuk Web Development', '1 hari yang lalu', 'krs'),
(12, 4, 'Pengingat: Kuis besok', '2 hari yang lalu', 'peringatan');

DROP TABLE IF EXISTS `presensi_jadwal_hari_ini`;
CREATE TABLE `presensi_jadwal_hari_ini` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) UNSIGNED NOT NULL,
  `waktu` varchar(20) NOT NULL,
  `ampm` varchar(10) NOT NULL,
  `matkul` varchar(100) NOT NULL,
  `dosen` varchar(100) NOT NULL,
  `status_text` varchar(50) NOT NULL,
  `status_color` varchar(20) NOT NULL,
  `status_bg` varchar(20) NOT NULL,
  `accent_color` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `presensi_jadwal_hari_ini` (`id`, `user_id`, `waktu`, `ampm`, `matkul`, `dosen`, `status_text`, `status_color`, `status_bg`, `accent_color`) VALUES
(1, 1, '09:00', 'AM', 'Praktikum Rekayasa Perangkat Lunak', 'Lab A201 • Cahya Vikasari, S.T., M.Eng.', 'Hadir', 'FF10B981', 'FFE6FDF5', 'FF1A73E8'),
(2, 1, '11:00', 'AM', 'Praktikum Jaringan Komputer', 'Lab B105 • Andesita Prihantara, ST,M.Eng.', 'Mendatang', 'FFF59E0B', 'FFFDF6E2', '00000000'),
(3, 2, '09:00', 'AM', 'Praktikum Rekayasa Perangkat Lunak', 'Lab A201 • Cahya Vikasari, S.T., M.Eng.', 'Hadir', 'FF10B981', 'FFE6FDF5', 'FF1A73E8'),
(4, 2, '11:00', 'AM', 'Praktikum Jaringan Komputer', 'Lab B105 • Andesita Prihantara, ST,M.Eng.', 'Mendatang', 'FFF59E0B', 'FFFDF6E2', '00000000'),
(5, 3, '09:00', 'AM', 'Praktikum Rekayasa Perangkat Lunak', 'Lab A201 • Cahya Vikasari, S.T., M.Eng.', 'Hadir', 'FF10B981', 'FFE6FDF5', 'FF1A73E8'),
(6, 3, '11:00', 'AM', 'Praktikum Jaringan Komputer', 'Lab B105 • Andesita Prihantara, ST,M.Eng.', 'Mendatang', 'FFF59E0B', 'FFFDF6E2', '00000000'),
(7, 4, '09:00', 'AM', 'Praktikum Rekayasa Perangkat Lunak', 'Lab A201 • Cahya Vikasari, S.T., M.Eng.', 'Hadir', 'FF10B981', 'FFE6FDF5', 'FF1A73E8'),
(8, 4, '11:00', 'AM', 'Praktikum Jaringan Komputer', 'Lab B105 • Andesita Prihantara, ST,M.Eng.', 'Mendatang', 'FFF59E0B', 'FFFDF6E2', '00000000');

DROP TABLE IF EXISTS `ta_timeline`;
CREATE TABLE `ta_timeline` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) UNSIGNED NOT NULL,
  `step_no` varchar(10) NOT NULL,
  `judul` varchar(100) NOT NULL,
  `sub` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `ta_timeline` (`id`, `user_id`, `step_no`, `judul`, `sub`, `status`) VALUES
(1, 1, '1', 'Pengajuan Judul', 'Selesai pada 23 Agustus 2024', 'selesai'),
(2, 1, '2', 'Penetapan Dosen Pembimbing', 'Fajar Mahardika, S.Kom., M.Kom.', 'selesai'),
(3, 1, '3', 'Riset dan Penulisan', 'Sedang berjalan - 65% selesai', 'berjalan'),
(4, 1, '4', 'Seminar Proposal', 'Dijadwalkan untuk Des 2024', 'jadwal'),
(5, 1, '5', 'Sidang Tugas Akhir', 'Menunggu penyelesaian', 'tertunda'),
(6, 2, '1', 'Pengajuan Judul', 'Selesai pada 23 Agustus 2024', 'selesai'),
(7, 2, '2', 'Penetapan Dosen Pembimbing', 'Fajar Mahardika, S.Kom., M.Kom.', 'selesai'),
(8, 2, '3', 'Riset dan Penulisan', 'Sedang berjalan - 65% selesai', 'berjalan'),
(9, 2, '4', 'Seminar Proposal', 'Dijadwalkan untuk Des 2024', 'jadwal'),
(10, 2, '5', 'Sidang Tugas Akhir', 'Menunggu penyelesaian', 'tertunda'),
(11, 3, '1', 'Pengajuan Judul', 'Selesai pada 23 Agustus 2024', 'selesai'),
(12, 3, '2', 'Penetapan Dosen Pembimbing', 'Fajar Mahardika, S.Kom., M.Kom.', 'selesai'),
(13, 3, '3', 'Riset dan Penulisan', 'Sedang berjalan - 65% selesai', 'berjalan'),
(14, 3, '4', 'Seminar Proposal', 'Dijadwalkan untuk Des 2024', 'jadwal'),
(15, 3, '5', 'Sidang Tugas Akhir', 'Menunggu penyelesaian', 'tertunda'),
(16, 4, '1', 'Pengajuan Judul', 'Selesai pada 23 Agustus 2024', 'selesai'),
(17, 4, '2', 'Penetapan Dosen Pembimbing', 'Fajar Mahardika, S.Kom., M.Kom.', 'selesai'),
(18, 4, '3', 'Riset dan Penulisan', 'Sedang berjalan - 65% selesai', 'berjalan'),
(19, 4, '4', 'Seminar Proposal', 'Dijadwalkan untuk Des 2024', 'jadwal'),
(20, 4, '5', 'Sidang Tugas Akhir', 'Menunggu penyelesaian', 'tertunda');

DROP TABLE IF EXISTS `ta_catatan_dosen`;
CREATE TABLE `ta_catatan_dosen` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) UNSIGNED NOT NULL,
  `tanggal` varchar(255) NOT NULL,
  `catatan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `ta_catatan_dosen` (`id`, `user_id`, `tanggal`, `catatan`) VALUES
(1, 1, '5 Oktober 2025 - Literature Review Progress', 'Lebih diperbaiki dari tata bahasa pada BAB 2, masih terdapat kalimat yang tidak memenuhi EYD'),
(2, 1, '24 September 2025 - Perbaikan Metodelogi Penelitian', 'Metodelogi yang anda tidak masuk akal, gunakan metodelogi yang sekiranya dapat anda implementasikan'),
(3, 2, '5 Oktober 2025 - Literature Review Progress', 'Lebih diperbaiki dari tata bahasa pada BAB 2, masih terdapat kalimat yang tidak memenuhi EYD'),
(4, 2, '24 September 2025 - Perbaikan Metodelogi Penelitian', 'Metodelogi yang anda tidak masuk akal, gunakan metodelogi yang sekiranya dapat anda implementasikan'),
(5, 3, '5 Oktober 2025 - Literature Review Progress', 'Lebih diperbaiki dari tata bahasa pada BAB 2, masih terdapat kalimat yang tidak memenuhi EYD'),
(6, 3, '24 September 2025 - Perbaikan Metodelogi Penelitian', 'Metodelogi yang anda tidak masuk akal, gunakan metodelogi yang sekiranya dapat anda implementasikan'),
(7, 4, '5 Oktober 2025 - Literature Review Progress', 'Lebih diperbaiki dari tata bahasa pada BAB 2, masih terdapat kalimat yang tidak memenuhi EYD'),
(8, 4, '24 September 2025 - Perbaikan Metodelogi Penelitian', 'Metodelogi yang anda tidak masuk akal, gunakan metodelogi yang sekiranya dapat anda implementasikan');

DROP TABLE IF EXISTS `ta_notifikasi`;
CREATE TABLE `ta_notifikasi` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) UNSIGNED NOT NULL,
  `judul` varchar(100) NOT NULL,
  `sub` varchar(255) NOT NULL,
  `waktu` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `ta_notifikasi` (`id`, `user_id`, `judul`, `sub`, `waktu`, `type`) VALUES
(1, 1, 'Pengunduran Jadwal Bimbingan', 'Diundur menjadi tanggal 20 Okt 2025', '2 jam yang lalu', 'bahaya'),
(2, 1, 'Revisi Tugas Akhir', 'Periksa kembali dokumen terbaru', '3 hari yang lalu', 'peringatan'),
(3, 1, 'Pertemuan Tesis', 'Dijadwalkan untuk 22 Okt, 10:00 AM', '2 hari yang lalu', 'info'),
(4, 2, 'Pengunduran Jadwal Bimbingan', 'Diundur menjadi tanggal 20 Okt 2025', '2 jam yang lalu', 'bahaya'),
(5, 2, 'Revisi Tugas Akhir', 'Periksa kembali dokumen terbaru', '3 hari yang lalu', 'peringatan'),
(6, 2, 'Pertemuan Tesis', 'Dijadwalkan untuk 22 Okt, 10:00 AM', '2 hari yang lalu', 'info'),
(7, 3, 'Pengunduran Jadwal Bimbingan', 'Diundur menjadi tanggal 20 Okt 2025', '2 jam yang lalu', 'bahaya'),
(8, 3, 'Revisi Tugas Akhir', 'Periksa kembali dokumen terbaru', '3 hari yang lalu', 'peringatan'),
(9, 3, 'Pertemuan Tesis', 'Dijadwalkan untuk 22 Okt, 10:00 AM', '2 hari yang lalu', 'info'),
(10, 4, 'Pengunduran Jadwal Bimbingan', 'Diundur menjadi tanggal 20 Okt 2025', '2 jam yang lalu', 'bahaya'),
(11, 4, 'Revisi Tugas Akhir', 'Periksa kembali dokumen terbaru', '3 hari yang lalu', 'peringatan'),
(12, 4, 'Pertemuan Tesis', 'Dijadwalkan untuk 22 Okt, 10:00 AM', '2 hari yang lalu', 'info');

DROP TABLE IF EXISTS `nilai_matkul`;
CREATE TABLE `nilai_matkul` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) UNSIGNED NOT NULL,
  `kode` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `sks` varchar(20) NOT NULL,
  `predikat` varchar(10) NOT NULL,
  `is_graded` tinyint(1) NOT NULL DEFAULT 0,
  `highlight_color` varchar(20) NOT NULL,
  `status_text` varchar(50) NOT NULL,
  `status_color` varchar(20) NOT NULL,
  `status_bg` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `nilai_matkul` (`id`, `user_id`, `kode`, `sks`, `nama`, `predikat`, `is_graded`, `highlight_color`, `status_text`, `status_color`, `status_bg`) VALUES
(1, 1, 'CS401', '4 SKS', 'Praktikum Pemrograman Web 2', 'A', 1, 'FF10B981', 'Selesai', 'FF10B981', 'FFE6FDF5'),
(2, 1, 'CS402', '2 SKS', 'Desain Interaksi Pengguna', 'B', 1, 'FF10B981', 'Selesai', 'FF10B981', 'FFE6FDF5'),
(3, 1, 'CS403', '2 SKS', 'Matematika Diskrit', 'AB', 1, 'FF10B981', 'Selesai', 'FF10B981', 'FFE6FDF5'),
(4, 1, 'CS404', '4 SKS', 'Praktikum Jaringan Komputer', 'n/a', 0, 'FFF59E0B', 'Selesai', 'FFF59E0B', 'FFFDF6E2'),
(5, 2, 'CS401', '4 SKS', 'Praktikum Pemrograman Web 2', 'A', 1, 'FF10B981', 'Selesai', 'FF10B981', 'FFE6FDF5'),
(6, 2, 'CS402', '2 SKS', 'Desain Interaksi Pengguna', 'B', 1, 'FF10B981', 'Selesai', 'FF10B981', 'FFE6FDF5'),
(7, 2, 'CS403', '2 SKS', 'Matematika Diskrit', 'AB', 1, 'FF10B981', 'Selesai', 'FF10B981', 'FFE6FDF5'),
(8, 2, 'CS404', '4 SKS', 'Praktikum Jaringan Komputer', 'n/a', 0, 'FFF59E0B', 'Selesai', 'FFF59E0B', 'FFFDF6E2'),
(9, 3, 'CS401', '4 SKS', 'Praktikum Pemrograman Web 2', 'A', 1, 'FF10B981', 'Selesai', 'FF10B981', 'FFE6FDF5'),
(10, 3, 'CS402', '2 SKS', 'Desain Interaksi Pengguna', 'B', 1, 'FF10B981', 'Selesai', 'FF10B981', 'FFE6FDF5'),
(11, 3, 'CS403', '2 SKS', 'Matematika Diskrit', 'AB', 1, 'FF10B981', 'Selesai', 'FF10B981', 'FFE6FDF5'),
(12, 3, 'CS404', '4 SKS', 'Praktikum Jaringan Komputer', 'n/a', 0, 'FFF59E0B', 'Selesai', 'FFF59E0B', 'FFFDF6E2'),
(13, 4, 'CS401', '4 SKS', 'Praktikum Pemrograman Web 2', 'A', 1, 'FF10B981', 'Selesai', 'FF10B981', 'FFE6FDF5'),
(14, 4, 'CS402', '2 SKS', 'Desain Interaksi Pengguna', 'B', 1, 'FF10B981', 'Selesai', 'FF10B981', 'FFE6FDF5'),
(15, 4, 'CS403', '2 SKS', 'Matematika Diskrit', 'AB', 1, 'FF10B981', 'Selesai', 'FF10B981', 'FFE6FDF5'),
(16, 4, 'CS404', '4 SKS', 'Praktikum Jaringan Komputer', 'n/a', 0, 'FFF59E0B', 'Selesai', 'FFF59E0B', 'FFFDF6E2');

DROP TABLE IF EXISTS `surat_permohonan`;
CREATE TABLE `surat_permohonan` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) UNSIGNED NOT NULL,
  `jenis_surat` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  `tanggal_diajukan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `surat_permohonan` (`id`, `user_id`, `jenis_surat`, `status`, `tanggal_diajukan`) VALUES
(1, 1, 'Pengajuan Transkrip', 'Disetujui', 'Diajukan pada 15 Des 2024'),
(2, 1, 'Surat Keterangan Aktif', 'Diproses', 'Diajukan pada 10 Des 2024'),
(3, 1, 'Pengajuan Cuti', 'Ditolak', 'Diajukan pada 5 Des 2024'),
(4, 2, 'Pengajuan Transkrip', 'Disetujui', 'Diajukan pada 15 Des 2024'),
(5, 2, 'Surat Keterangan Aktif', 'Diproses', 'Diajukan pada 10 Des 2024'),
(6, 2, 'Pengajuan Cuti', 'Ditolak', 'Diajukan pada 5 Des 2024'),
(7, 3, 'Pengajuan Transkrip', 'Disetujui', 'Diajukan pada 15 Des 2024'),
(8, 3, 'Surat Keterangan Aktif', 'Diproses', 'Diajukan pada 10 Des 2024'),
(9, 3, 'Pengajuan Cuti', 'Ditolak', 'Diajukan pada 5 Des 2024'),
(10, 4, 'Pengajuan Transkrip', 'Disetujui', 'Diajukan pada 15 Des 2024'),
(11, 4, 'Surat Keterangan Aktif', 'Diproses', 'Diajukan pada 10 Des 2024'),
(12, 4, 'Pengajuan Cuti', 'Ditolak', 'Diajukan pada 5 Des 2024');

DROP TABLE IF EXISTS `keuangan_riwayat`;
CREATE TABLE `keuangan_riwayat` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `sub` varchar(100) NOT NULL,
  `date` varchar(50) NOT NULL,
  `amount` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `keuangan_riwayat` (`id`, `user_id`, `title`, `sub`, `date`, `amount`, `type`) VALUES
(1, 1, 'Semester Genap 2023/2024', 'Pembayaran UKT - Teknik Informatika', 'Dibayar pada 10 Februari 2024', 'Rp 5.250.000', 'spp'),
(2, 1, 'Semester Ganjil 2023/2024', 'Pembayaran UKT - Teknik Informatika', 'Dibayar pada 15 Agustus 2023', 'Rp 5.250.000', 'spp'),
(3, 1, 'Biaya Pendaftaran Mandiri', 'Registrasi Awal Mahasiswa Baru', 'Dibayar pada 1 Juli 2023', 'Rp 500.000', 'daftar'),
(4, 2, 'Semester Genap 2023/2024', 'Pembayaran UKT - Teknik Informatika', 'Dibayar pada 10 Februari 2024', 'Rp 5.250.000', 'spp'),
(5, 2, 'Semester Ganjil 2023/2024', 'Pembayaran UKT - Teknik Informatika', 'Dibayar pada 15 Agustus 2023', 'Rp 5.250.000', 'spp'),
(6, 2, 'Biaya Pendaftaran Mandiri', 'Registrasi Awal Mahasiswa Baru', 'Dibayar pada 1 Juli 2023', 'Rp 500.000', 'daftar'),
(7, 3, 'Semester Genap 2023/2024', 'Pembayaran UKT - Teknik Informatika', 'Dibayar pada 10 Februari 2024', 'Rp 5.250.000', 'spp'),
(8, 3, 'Semester Ganjil 2023/2024', 'Pembayaran UKT - Teknik Informatika', 'Dibayar pada 15 Agustus 2023', 'Rp 5.250.000', 'spp'),
(9, 3, 'Biaya Pendaftaran Mandiri', 'Registrasi Awal Mahasiswa Baru', 'Dibayar pada 1 Juli 2023', 'Rp 500.000', 'daftar'),
(10, 4, 'Semester Genap 2023/2024', 'Pembayaran UKT - Teknik Informatika', 'Dibayar pada 10 Februari 2024', 'Rp 5.250.000', 'spp'),
(11, 4, 'Semester Ganjil 2023/2024', 'Pembayaran UKT - Teknik Informatika', 'Dibayar pada 15 Agustus 2023', 'Rp 5.250.000', 'spp'),
(12, 4, 'Biaya Pendaftaran Mandiri', 'Registrasi Awal Mahasiswa Baru', 'Dibayar pada 1 Juli 2023', 'Rp 500.000', 'daftar');

DROP TABLE IF EXISTS `informasi`;
CREATE TABLE `informasi` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `judul` varchar(255) NOT NULL,
  `konten` text NOT NULL,
  `tanggal` varchar(50) NOT NULL,
  `tipe` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `informasi` (`id`, `judul`, `konten`, `tanggal`, `tipe`) VALUES
(1, 'Pengisian KRS Ganjil 2026/2027', 'Batas pengisian KRS diperpanjang sampai 15 Agustus 2026. Segera hubungi dosen wali.', '12 Jul 2026', 'krs'),
(2, 'Pembayaran UKT Tahap I', 'Batas akhir pembayaran UKT untuk semester ganjil adalah 10 Agustus 2026.', '10 Jul 2026', 'peringatan'),
(3, 'Sosialisasi Magang MBKM', 'Sosialisasi daring program magang dan studi independen hari Jumat jam 09.00 WIB.', '08 Jul 2026', 'info');

DROP TABLE IF EXISTS `pnc_news`;
CREATE TABLE `pnc_news` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `judul` varchar(255) NOT NULL,
  `sumber` varchar(100) NOT NULL,
  `konten` text NOT NULL,
  `gambar_url` varchar(255) NOT NULL,
  `tanggal` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `pnc_news` (`id`, `judul`, `sumber`, `konten`, `gambar_url`, `tanggal`) VALUES
(1, 'Kampus Kesehatan Punya Beban Administrasi Dua Kali Lipat, dan Banyak yang Belum Sadar Ini Bisa...', 'SEVIMA.COM - Setiap menjelang siklus akreditasi...', 'Setiap menjelang siklus akreditasi, kampus kesehatan sering kali menghadapi beban administrasi yang berlipat ganda karena standarisasi klinis dan akademik yang sangat ketat.', 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?auto=format&fit=crop&w=400&q=80', '12 Jul 2026'),
(2, 'Skema Digital Hari Ini Menjadi Kunci Utama Untuk Efisiensi Kampus...', 'SEVIMA - Kehadiran teknologi digital mempermudah...', 'Kehadiran teknologi digital mempermudah seluruh pengelolaan administrasi mahasiswa, pembayaran UKT, hingga presensi cepat di lingkungan kampus.', 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=400&q=80', '11 Jul 2026');


