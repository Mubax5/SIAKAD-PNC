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
(1, '240202078', 'Hilmi Mubarok', 'hilmi@siakad.ac.id', '$2y$10$CmQYza3yvJzfQ4jdW1WOJecS3R93mbrlvU8f.g.WFqYud0NEtCY1W', 'Teknik Informatika', 3, 3.85, 'https://avatar.iran.liara.run/public/boy?username=Hilmi', 20, '124/144', 65, 'Machine Learning Application for Student Performance Prediction', 'Fajar Mahardika, S.Kom., M.Kom.', 'Sep 2024', 92, 'Rp 5.250.000', 'Rp 10.500.000', 'Rp 15.750.000', 'Belum Terbayar'),
(2, '240202001', 'Budi Santoso', 'budi@siakad.ac.id', '$2y$10$CmQYza3yvJzfQ4jdW1WOJecS3R93mbrlvU8f.g.WFqYud0NEtCY1W', 'Sistem Informasi', 5, 3.62, 'https://avatar.iran.liara.run/public/boy?username=Budi', 22, '90/144', 0, 'Belum Mengajukan Judul', 'Belum Ditentukan', 'N/A', 85, 'Rp 0', 'Rp 4.500.000', 'Rp 4.500.000', 'Lunas'),
(3, '240202002', 'Siti Aminah', 'siti@siakad.ac.id', '$2y$10$CmQYza3yvJzfQ4jdW1WOJecS3R93mbrlvU8f.g.WFqYud0NEtCY1W', 'Teknik Mesin', 7, 3.9, 'https://avatar.iran.liara.run/public/girl?username=Siti', 18, '135/144', 80, 'Perancangan Mesin Pengering Padi Tenaga Surya', 'Andesita Prihantara, ST, M.Eng.', 'Maret 2024', 96, 'Rp 6.000.000', 'Rp 6.000.000', 'Rp 12.000.000', 'Belum Terbayar');

DROP TABLE IF EXISTS `matkul`;
CREATE TABLE `matkul` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) UNSIGNED NOT NULL,
  `kode` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `sks` int(5) NOT NULL,
  `dosen` varchar(100) NOT NULL,
  `jadwal` varchar(100) NOT NULL,
  `kelas` varchar(50) NOT NULL,
  `color_hex` varchar(20) NOT NULL,
  `bg_hex` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `matkul` (`id`, `user_id`, `kode`, `nama`, `sks`, `dosen`, `jadwal`, `kelas`, `color_hex`, `bg_hex`) VALUES
(1, 1, 'INF2104', 'Praktikum Rekayasa Perangkat Lunak', 4, 'Cahya Vikasari, S.T., M.Eng.', 'Senin, 08:00 - 10:30 WIB', 'Kelas A', 'FF1A73E8', 'FFF1F7FF'),
(2, 1, 'INF2105', 'Desain Interaksi Pengguna', 2, 'Fajar Mahardika, S.Kom., M.Kom.', 'Senin, 13:00 - 14:40 WIB', 'Kelas A', 'FF10B981', 'FFE6FDF5'),
(3, 1, 'CS401', 'Praktikum Pemrograman Web 2', 4, 'Haryanto, S.T., M.T.', 'Rabu, 08:00 - 10:30 WIB', 'Kelas A', 'FF10B981', 'FFE6FDF5'),
(4, 1, 'CS403', 'Matematika Diskrit', 2, 'Dr. Irwan, M.Si.', 'Rabu, 13:00 - 14:40 WIB', 'Kelas A', 'FF8B5CF6', 'FFF5F3FF'),
(5, 2, 'SI301', 'Analisis Desain Sistem Informasi', 3, 'Fajar Mahardika, S.Kom., M.Kom.', 'Senin, 09:00 - 11:30 WIB', 'Kelas B', 'FF1A73E8', 'FFF1F7FF'),
(6, 2, 'SI302', 'Manajemen Proyek TI', 3, 'Nur Wahyu Rahadi, S.Kom, M.Eng.', 'Rabu, 10:00 - 12:30 WIB', 'Kelas B', 'FF10B981', 'FFE6FDF5'),
(7, 3, 'ME701', 'Termodinamika Lanjut', 3, 'Andesita Prihantara, ST, M.Eng.', 'Selasa, 08:00 - 10:30 WIB', 'Kelas C', 'FFF59E0B', 'FFFDF6E2'),
(8, 3, 'ME702', 'Perancangan Elemen Mesin', 4, 'Riyadi Purwanto, S.T., M.Eng.', 'Kamis, 09:00 - 12:20 WIB', 'Kelas C', 'FFEF4444', 'FFFDF2F2');

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
(3, 2, 'Enterprise Architecture', 'SI501 • Room C102 • 08:00 AM', 0);

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
(5, 2, 'Project Management', 0.82, '82%');

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
(3, 1, 'Pengingat: Kuis besok', '2 hari yang lalu', 'peringatan');

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
(2, 1, '11:00', 'AM', 'Praktikum Jaringan Komputer', 'Lab B105 • Andesita Prihantara, ST,M.Eng.', 'Mendatang', 'FFF59E0B', 'FFFDF6E2', '00000000');

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
(5, 1, '5', 'Sidang Tugas Akhir', 'Menunggu penyelesaian', 'tertunda');

DROP TABLE IF EXISTS `ta_catatan_dosen`;
CREATE TABLE `ta_catatan_dosen` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) UNSIGNED NOT NULL,
  `tanggal` varchar(50) NOT NULL,
  `catatan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `ta_catatan_dosen` (`id`, `user_id`, `tanggal`, `catatan`) VALUES
(1, 1, '5 Oktober 2025 - Literature Review Progress', 'Lebih diperbaiki dari tata bahasa pada BAB 2, masih terdapat kalimat yang tidak memenuhi EYD'),
(2, 1, '24 September 2025 - Perbaikan Metodelogi Penelitian', 'Metodelogi yang anda tidak masuk akal, gunakan metodelogi yang sekiranya dapat anda implementasikan');

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
(3, 1, 'Pertemuan Tesis', 'Dijadwalkan untuk 22 Okt, 10:00 AM', '2 hari yang lalu', 'info');

DROP TABLE IF EXISTS `nilai_matkul`;
CREATE TABLE `nilai_matkul` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) UNSIGNED NOT NULL,
  `kode` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `sks` int(5) NOT NULL,
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
(4, 1, 'CS404', '4 SKS', 'Praktikum Jaringan Komputer', 'n/a', 0, 'FFF59E0B', 'Selesai', 'FFF59E0B', 'FFFDF6E2');

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
(3, 1, 'Pengajuan Cuti', 'Ditolak', 'Diajukan pada 5 Des 2024');

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
(3, 1, 'Biaya Pendaftaran Mandiri', 'Registrasi Awal Mahasiswa Baru', 'Dibayar pada 1 Juli 2023', 'Rp 500.000', 'daftar');

