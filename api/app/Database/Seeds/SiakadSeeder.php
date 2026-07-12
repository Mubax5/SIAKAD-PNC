<?php

namespace App\Database\Seeds;

use CodeIgniter\Database\Seeder;

class SiakadSeeder extends Seeder
{
    public function run()
    {
        $db = \Config\Database::connect();
        $hashedPassword = password_hash('123456', PASSWORD_DEFAULT);

        // 1. Insert 3 Users
        $users = [
            [
                'id'                 => 1,
                'nim'                => '240202078',
                'nama'               => 'Hilmi Mubarok',
                'email'              => 'hilmi@siakad.ac.id',
                'password'           => $hashedPassword,
                'prodi'              => 'Teknik Informatika',
                'semester'           => 3,
                'ipk'                => 3.85,
                'avatar'             => 'https://avatar.iran.liara.run/public/boy?username=Hilmi',
                'sks_krs'            => 20,
                'sks_total'          => '124/144',
                'ta_progres'         => 65,
                'ta_judul'           => 'Machine Learning Application for Student Performance Prediction',
                'ta_dosen'           => 'Fajar Mahardika, S.Kom., M.Kom.',
                'ta_mulai'           => 'Sep 2024',
                'presensi_persen'    => 92,
                'keuangan_tunggakan' => 'Rp 5.250.000',
                'keuangan_terbayar'  => 'Rp 10.500.000',
                'keuangan_total'     => 'Rp 15.750.000',
                'keuangan_status'    => 'Belum Terbayar',
            ],
            [
                'id'                 => 2,
                'nim'                => '240202001',
                'nama'               => 'Budi Santoso',
                'email'              => 'budi@siakad.ac.id',
                'password'           => $hashedPassword,
                'prodi'              => 'Sistem Informasi',
                'semester'           => 5,
                'ipk'                => 3.62,
                'avatar'             => 'https://avatar.iran.liara.run/public/boy?username=Budi',
                'sks_krs'            => 22,
                'sks_total'          => '90/144',
                'ta_progres'         => 0,
                'ta_judul'           => 'Belum Mengajukan Judul',
                'ta_dosen'           => 'Belum Ditentukan',
                'ta_mulai'           => 'N/A',
                'presensi_persen'    => 85,
                'keuangan_tunggakan' => 'Rp 0',
                'keuangan_terbayar'  => 'Rp 4.500.000',
                'keuangan_total'     => 'Rp 4.500.000',
                'keuangan_status'    => 'Lunas',
            ],
            [
                'id'                 => 3,
                'nim'                => '240202002',
                'nama'               => 'Siti Aminah',
                'email'              => 'siti@siakad.ac.id',
                'password'           => $hashedPassword,
                'prodi'              => 'Teknik Mesin',
                'semester'           => 7,
                'ipk'                => 3.90,
                'avatar'             => 'https://avatar.iran.liara.run/public/girl?username=Siti',
                'sks_krs'            => 18,
                'sks_total'          => '135/144',
                'ta_progres'         => 80,
                'ta_judul'           => 'Perancangan Mesin Pengering Padi Tenaga Surya',
                'ta_dosen'           => 'Andesita Prihantara, ST, M.Eng.',
                'ta_mulai'           => 'Maret 2024',
                'presensi_persen'    => 96,
                'keuangan_tunggakan' => 'Rp 6.000.000',
                'keuangan_terbayar'  => 'Rp 6.000.000',
                'keuangan_total'     => 'Rp 12.000.000',
                'keuangan_status'    => 'Belum Terbayar',
            ],
        ];
        $db->table('users')->insertBatch($users);

        // 2. Insert Matkul
        $matkul = [
            // User 1 Matkul (Hilmi - Semester 3)
            [
                'user_id'   => 1,
                'kode'      => 'INF2104',
                'nama'      => 'Praktikum Rekayasa Perangkat Lunak',
                'sks'       => 4,
                'dosen'     => 'Cahya Vikasari, S.T., M.Eng.',
                'jadwal'    => 'Senin, 08:00 - 10:30 WIB',
                'kelas'     => 'Kelas A',
                'color_hex' => 'FF1A73E8', // WarnaAplikasi.krsIcon
                'bg_hex'    => 'FFF1F7FF',    // WarnaAplikasi.krsTint
            ],
            [
                'user_id'   => 1,
                'kode'      => 'INF2105',
                'nama'      => 'Desain Interaksi Pengguna',
                'sks'       => 2,
                'dosen'     => 'Fajar Mahardika, S.Kom., M.Kom.',
                'jadwal'    => 'Senin, 13:00 - 14:40 WIB',
                'kelas'     => 'Kelas A',
                'color_hex' => 'FF10B981', // WarnaAplikasi.presensiIcon
                'bg_hex'    => 'FFE6FDF5',    // WarnaAplikasi.presensiTint
            ],
            [
                'user_id'   => 1,
                'kode'      => 'CS401',
                'nama'      => 'Praktikum Pemrograman Web 2',
                'sks'       => 4,
                'dosen'     => 'Haryanto, S.T., M.T.',
                'jadwal'    => 'Rabu, 08:00 - 10:30 WIB',
                'kelas'     => 'Kelas A',
                'color_hex' => 'FF10B981', // WarnaAplikasi.sukses
                'bg_hex'    => 'FFE6FDF5',    // WarnaAplikasi.suksesTint
            ],
            [
                'user_id'   => 1,
                'kode'      => 'CS403',
                'nama'      => 'Matematika Diskrit',
                'sks'       => 2,
                'dosen'     => 'Dr. Irwan, M.Si.',
                'jadwal'    => 'Rabu, 13:00 - 14:40 WIB',
                'kelas'     => 'Kelas A',
                'color_hex' => 'FF8B5CF6', // WarnaAplikasi.transkripIcon
                'bg_hex'    => 'FFF5F3FF',    // WarnaAplikasi.transkripTint
            ],

            // User 2 Matkul (Budi - Semester 5)
            [
                'user_id'   => 2,
                'kode'      => 'SI301',
                'nama'      => 'Analisis Desain Sistem Informasi',
                'sks'       => 3,
                'dosen'     => 'Fajar Mahardika, S.Kom., M.Kom.',
                'jadwal'    => 'Senin, 09:00 - 11:30 WIB',
                'kelas'     => 'Kelas B',
                'color_hex' => 'FF1A73E8',
                'bg_hex'    => 'FFF1F7FF',
            ],
            [
                'user_id'   => 2,
                'kode'      => 'SI302',
                'nama'      => 'Manajemen Proyek TI',
                'sks'       => 3,
                'dosen'     => 'Nur Wahyu Rahadi, S.Kom, M.Eng.',
                'jadwal'    => 'Rabu, 10:00 - 12:30 WIB',
                'kelas'     => 'Kelas B',
                'color_hex' => 'FF10B981',
                'bg_hex'    => 'FFE6FDF5',
            ],

            // User 3 Matkul (Siti - Semester 7)
            [
                'user_id'   => 3,
                'kode'      => 'ME701',
                'nama'      => 'Termodinamika Lanjut',
                'sks'       => 3,
                'dosen'     => 'Andesita Prihantara, ST, M.Eng.',
                'jadwal'    => 'Selasa, 08:00 - 10:30 WIB',
                'kelas'     => 'Kelas C',
                'color_hex' => 'FFF59E0B',
                'bg_hex'    => 'FFFDF6E2',
            ],
            [
                'user_id'   => 3,
                'kode'      => 'ME702',
                'nama'      => 'Perancangan Elemen Mesin',
                'sks'       => 4,
                'dosen'     => 'Riyadi Purwanto, S.T., M.Eng.',
                'jadwal'    => 'Kamis, 09:00 - 12:20 WIB',
                'kelas'     => 'Kelas C',
                'color_hex' => 'FFEF4444',
                'bg_hex'    => 'FFFDF2F2',
            ],
        ];
        $db->table('matkul')->insertBatch($matkul);

        // 3. Insert Presensi Cepat
        $presensiCepat = [
            // User 1
            [
                'user_id'   => 1,
                'title'     => 'Data Structures',
                'subtitle'  => 'CS301 • Room A201 • 09:00 AM',
                'is_marked' => 1,
            ],
            [
                'user_id'   => 1,
                'title'     => 'Database Systems',
                'subtitle'  => 'CS302 • Room B105 • 11:00 AM',
                'is_marked' => 0,
            ],
            // User 2
            [
                'user_id'   => 2,
                'title'     => 'Enterprise Architecture',
                'subtitle'  => 'SI501 • Room C102 • 08:00 AM',
                'is_marked' => 0,
            ],
        ];
        $db->table('presensi_cepat')->insertBatch($presensiCepat);

        // 4. Insert Presensi Per MK
        $presensiPerMk = [
            // User 1
            ['user_id' => 1, 'mk_name' => 'Data Structures', 'progress_val' => 0.95, 'persentase_text' => '95%'],
            ['user_id' => 1, 'mk_name' => 'Database Systems', 'progress_val' => 0.88, 'persentase_text' => '88%'],
            ['user_id' => 1, 'mk_name' => 'Web Development', 'progress_val' => 0.75, 'persentase_text' => '75%'],
            ['user_id' => 1, 'mk_name' => 'Software Engineering', 'progress_val' => 0.92, 'persentase_text' => '92%'],
            // User 2
            ['user_id' => 2, 'mk_name' => 'Project Management', 'progress_val' => 0.82, 'persentase_text' => '82%'],
        ];
        $db->table('presensi_per_mk')->insertBatch($presensiPerMk);

        // 5. Insert Presensi Aktivitas
        $presensiAktivitas = [
            ['user_id' => 1, 'desc' => 'Kehadiran ditandai untuk Data Structures', 'time_ago' => '2 jam yang lalu', 'type' => 'sukses'],
            ['user_id' => 1, 'desc' => 'Tugas dikumpulkan untuk Web Development', 'time_ago' => '1 hari yang lalu', 'type' => 'krs'],
            ['user_id' => 1, 'desc' => 'Pengingat: Kuis besok', 'time_ago' => '2 hari yang lalu', 'type' => 'peringatan'],
        ];
        $db->table('presensi_aktivitas')->insertBatch($presensiAktivitas);

        // 6. Insert Presensi Jadwal Hari Ini
        $presensiJadwal = [
            [
                'user_id'      => 1,
                'waktu'        => '09:00',
                'ampm'         => 'AM',
                'matkul'       => 'Praktikum Rekayasa Perangkat Lunak',
                'dosen'        => 'Lab A201 • Cahya Vikasari, S.T., M.Eng.',
                'status_text'  => 'Hadir',
                'status_color' => 'FF10B981',
                'status_bg'    => 'FFE6FDF5',
                'accent_color' => 'FF1A73E8',
            ],
            [
                'user_id'      => 1,
                'waktu'        => '11:00',
                'ampm'         => 'AM',
                'matkul'       => 'Praktikum Jaringan Komputer',
                'dosen'        => 'Lab B105 • Andesita Prihantara, ST,M.Eng.',
                'status_text'  => 'Mendatang',
                'status_color' => 'FFF59E0B',
                'status_bg'    => 'FFFDF6E2',
                'accent_color' => '00000000',
            ],
        ];
        $db->table('presensi_jadwal_hari_ini')->insertBatch($presensiJadwal);

        // 7. Insert TA Timeline
        $taTimeline = [
            ['user_id' => 1, 'step_no' => '1', 'judul' => 'Pengajuan Judul', 'sub' => 'Selesai pada 23 Agustus 2024', 'status' => 'selesai'],
            ['user_id' => 1, 'step_no' => '2', 'judul' => 'Penetapan Dosen Pembimbing', 'sub' => 'Fajar Mahardika, S.Kom., M.Kom.', 'status' => 'selesai'],
            ['user_id' => 1, 'step_no' => '3', 'judul' => 'Riset dan Penulisan', 'sub' => 'Sedang berjalan - 65% selesai', 'status' => 'berjalan'],
            ['user_id' => 1, 'step_no' => '4', 'judul' => 'Seminar Proposal', 'sub' => 'Dijadwalkan untuk Des 2024', 'status' => 'jadwal'],
            ['user_id' => 1, 'step_no' => '5', 'judul' => 'Sidang Tugas Akhir', 'sub' => 'Menunggu penyelesaian', 'status' => 'tertunda'],
        ];
        $db->table('ta_timeline')->insertBatch($taTimeline);

        // 8. Insert TA Catatan Dosen
        $taCatatan = [
            ['user_id' => 1, 'tanggal' => '5 Oktober 2025 - Literature Review Progress', 'catatan' => 'Lebih diperbaiki dari tata bahasa pada BAB 2, masih terdapat kalimat yang tidak memenuhi EYD'],
            ['user_id' => 1, 'tanggal' => '24 September 2025 - Perbaikan Metodelogi Penelitian', 'catatan' => 'Metodelogi yang anda tidak masuk akal, gunakan metodelogi yang sekiranya dapat anda implementasikan'],
        ];
        $db->table('ta_catatan_dosen')->insertBatch($taCatatan);

        // 9. Insert TA Notifikasi
        $taNotifikasi = [
            ['user_id' => 1, 'judul' => 'Pengunduran Jadwal Bimbingan', 'sub' => 'Diundur menjadi tanggal 20 Okt 2025', 'waktu' => '2 jam yang lalu', 'type' => 'bahaya'],
            ['user_id' => 1, 'judul' => 'Revisi Tugas Akhir', 'sub' => 'Periksa kembali dokumen terbaru', 'waktu' => '3 hari yang lalu', 'type' => 'peringatan'],
            ['user_id' => 1, 'judul' => 'Pertemuan Tesis', 'sub' => 'Dijadwalkan untuk 22 Okt, 10:00 AM', 'waktu' => '2 hari yang lalu', 'type' => 'info'],
        ];
        $db->table('ta_notifikasi')->insertBatch($taNotifikasi);

        // 10. Insert Nilai Matkul
        $nilaiMatkul = [
            [
                'user_id'         => 1,
                'kode'            => 'CS401',
                'sks'             => '4 SKS',
                'nama'            => 'Praktikum Pemrograman Web 2',
                'predikat'        => 'A',
                'is_graded'       => 1,
                'highlight_color' => 'FF10B981',
                'status_text'     => 'Selesai',
                'status_color'    => 'FF10B981',
                'status_bg'       => 'FFE6FDF5',
            ],
            [
                'user_id'         => 1,
                'kode'            => 'CS402',
                'sks'             => '2 SKS',
                'nama'            => 'Desain Interaksi Pengguna',
                'predikat'        => 'B',
                'is_graded'       => 1,
                'highlight_color' => 'FF10B981',
                'status_text'     => 'Selesai',
                'status_color'    => 'FF10B981',
                'status_bg'       => 'FFE6FDF5',
            ],
            [
                'user_id'         => 1,
                'kode'            => 'CS403',
                'sks'             => '2 SKS',
                'nama'            => 'Matematika Diskrit',
                'predikat'        => 'AB',
                'is_graded'       => 1,
                'highlight_color' => 'FF10B981',
                'status_text'     => 'Selesai',
                'status_color'    => 'FF10B981',
                'status_bg'       => 'FFE6FDF5',
            ],
            [
                'user_id'         => 1,
                'kode'            => 'CS404',
                'sks'             => '4 SKS',
                'nama'            => 'Praktikum Jaringan Komputer',
                'predikat'        => 'n/a',
                'is_graded'       => 0,
                'highlight_color' => 'FFF59E0B',
                'status_text'     => 'Selesai',
                'status_color'    => 'FFF59E0B',
                'status_bg'       => 'FFFDF6E2',
            ],
        ];
        $db->table('nilai_matkul')->insertBatch($nilaiMatkul);

        // 11. Insert Surat Permohonan
        $suratPermohonan = [
            ['user_id' => 1, 'jenis_surat' => 'Pengajuan Transkrip', 'status' => 'Disetujui', 'tanggal_diajukan' => 'Diajukan pada 15 Des 2024'],
            ['user_id' => 1, 'jenis_surat' => 'Surat Keterangan Aktif', 'status' => 'Diproses', 'tanggal_diajukan' => 'Diajukan pada 10 Des 2024'],
            ['user_id' => 1, 'jenis_surat' => 'Pengajuan Cuti', 'status' => 'Ditolak', 'tanggal_diajukan' => 'Diajukan pada 5 Des 2024'],
        ];
        $db->table('surat_permohonan')->insertBatch($suratPermohonan);

        // 12. Insert Keuangan Riwayat
        $keuanganRiwayat = [
            ['user_id' => 1, 'title' => 'Semester Genap 2023/2024', 'sub' => 'Pembayaran UKT - Teknik Informatika', 'date' => 'Dibayar pada 10 Februari 2024', 'amount' => 'Rp 5.250.000', 'type' => 'spp'],
            ['user_id' => 1, 'title' => 'Semester Ganjil 2023/2024', 'sub' => 'Pembayaran UKT - Teknik Informatika', 'date' => 'Dibayar pada 15 Agustus 2023', 'amount' => 'Rp 5.250.000', 'type' => 'spp'],
            ['user_id' => 1, 'title' => 'Biaya Pendaftaran Mandiri', 'sub' => 'Registrasi Awal Mahasiswa Baru', 'date' => 'Dibayar pada 1 Juli 2023', 'amount' => 'Rp 500.000', 'type' => 'daftar'],
        ];
        $db->table('keuangan_riwayat')->insertBatch($keuanganRiwayat);
    }
}
