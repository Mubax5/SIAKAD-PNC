<?php

namespace App\Database\Seeds;

use CodeIgniter\Database\Seeder;

class SiakadSeeder extends Seeder
{
    public function run()
    {
        $db = \Config\Database::connect();
        $hashedPassword = password_hash('123456', PASSWORD_DEFAULT);

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
                'nim'                => '240102080',
                'nama'               => 'Khalifah Brilianti R',
                'email'              => 'khalifah@siakad.ac.id',
                'password'           => $hashedPassword,
                'prodi'              => 'Teknik Informatika',
                'semester'           => 5,
                'ipk'                => 3.72,
                'avatar'             => 'https://avatar.iran.liara.run/public/girl?username=Khalifah',
                'sks_krs'            => 22,
                'sks_total'          => '98/144',
                'ta_progres'         => 30,
                'ta_judul'           => 'Desain UI/UX Sistem Informasi Akademik Berbasis Mobile',
                'ta_dosen'           => 'Nur Wahyu Rahadi, S.Kom, M.Eng.',
                'ta_mulai'           => 'Maret 2025',
                'presensi_persen'    => 88,
                'keuangan_tunggakan' => 'Rp 0',
                'keuangan_terbayar'  => 'Rp 15.750.000',
                'keuangan_total'     => 'Rp 15.750.000',
                'keuangan_status'    => 'Lunas',
            ],
            [
                'id'                 => 3,
                'nim'                => '240102087',
                'nama'               => 'Nadjwa Naela Aziz',
                'email'              => 'nadjwa@siakad.ac.id',
                'password'           => $hashedPassword,
                'prodi'              => 'Teknik Informatika',
                'semester'           => 3,
                'ipk'                => 3.91,
                'avatar'             => 'https://avatar.iran.liara.run/public/girl?username=Nadjwa',
                'sks_krs'            => 20,
                'sks_total'          => '68/144',
                'ta_progres'         => 0,
                'ta_judul'           => 'Belum Mengajukan Tugas Akhir',
                'ta_dosen'           => 'Belum Ditentukan',
                'ta_mulai'           => 'N/A',
                'presensi_persen'    => 96,
                'keuangan_tunggakan' => 'Rp 5.250.000',
                'keuangan_terbayar'  => 'Rp 10.500.000',
                'keuangan_total'     => 'Rp 15.750.000',
                'keuangan_status'    => 'Belum Terbayar',
            ],
            [
                'id'                 => 4,
                'nim'                => '240202094',
                'nama'               => 'Suryo Nugroho',
                'email'              => 'suryo@siakad.ac.id',
                'password'           => $hashedPassword,
                'prodi'              => 'Teknik Informatika',
                'semester'           => 5,
                'ipk'                => 3.65,
                'avatar'             => 'https://avatar.iran.liara.run/public/boy?username=Suryo',
                'sks_krs'            => 24,
                'sks_total'          => '102/144',
                'ta_progres'         => 45,
                'ta_judul'           => 'Implementasi Web Security pada Sistem Pendataan Penduduk PNC',
                'ta_dosen'           => 'Andesita Prihantara, ST, M.Eng.',
                'ta_mulai'           => 'Januari 2025',
                'presensi_persen'    => 91,
                'keuangan_tunggakan' => 'Rp 5.250.000',
                'keuangan_terbayar'  => 'Rp 10.500.000',
                'keuangan_total'     => 'Rp 15.750.000',
                'keuangan_status'    => 'Belum Terbayar',
            ],
        ];
        $db->table('users')->insertBatch($users);

        $matkul = [];
        foreach ([1, 2, 3, 4] as $uid) {
            $matkul[] = [
                'user_id'   => $uid,
                'kode'      => 'INF2104',
                'nama'      => 'Praktikum Rekayasa Perangkat Lunak',
                'sks'       => 4,
                'dosen'     => 'Cahya Vikasari, S.T., M.Eng.',
                'jadwal'    => 'Senin, 08:00 - 10:30 WIB',
                'kelas'     => 'Kelas A',
                'color_hex' => 'FF1A73E8',
                'bg_hex'    => 'FFF1F7FF',
            ];
            $matkul[] = [
                'user_id'   => $uid,
                'kode'      => 'INF2105',
                'nama'      => 'Desain Interaksi Pengguna',
                'sks'       => 2,
                'dosen'     => 'Fajar Mahardika, S.Kom., M.Kom.',
                'jadwal'    => 'Senin, 13:00 - 14:40 WIB',
                'kelas'     => 'Kelas A',
                'color_hex' => 'FF10B981',
                'bg_hex'    => 'FFE6FDF5',
            ];
            $matkul[] = [
                'user_id'   => $uid,
                'kode'      => 'CS401',
                'nama'      => 'Praktikum Pemrograman Web 2',
                'sks'       => 4,
                'dosen'     => 'Haryanto, S.T., M.T.',
                'jadwal'    => 'Rabu, 08:00 - 10:30 WIB',
                'kelas'     => 'Kelas A',
                'color_hex' => 'FF10B981',
                'bg_hex'    => 'FFE6FDF5',
            ];
            $matkul[] = [
                'user_id'   => $uid,
                'kode'      => 'CS403',
                'nama'      => 'Matematika Diskrit',
                'sks'       => 2,
                'dosen'     => 'Dr. Irwan, M.Si.',
                'jadwal'    => 'Rabu, 13:00 - 14:40 WIB',
                'kelas'     => 'Kelas A',
                'color_hex' => 'FF8B5CF6',
                'bg_hex'    => 'FFF5F3FF',
            ];
        }
        $db->table('matkul')->insertBatch($matkul);

        $presensiCepat = [];
        foreach ([1, 2, 3, 4] as $uid) {
            $presensiCepat[] = [
                'user_id'   => $uid,
                'title'     => 'Data Structures',
                'subtitle'  => 'CS301 • Room A201 • 09:00 AM',
                'is_marked' => 1,
            ];
            $presensiCepat[] = [
                'user_id'   => $uid,
                'title'     => 'Database Systems',
                'subtitle'  => 'CS302 • Room B105 • 11:00 AM',
                'is_marked' => 0,
            ];
        }
        $db->table('presensi_cepat')->insertBatch($presensiCepat);

        $presensiPerMk = [];
        foreach ([1, 2, 3, 4] as $uid) {
            $presensiPerMk[] = ['user_id' => $uid, 'mk_name' => 'Data Structures', 'progress_val' => 0.95, 'persentase_text' => '95%'];
            $presensiPerMk[] = ['user_id' => $uid, 'mk_name' => 'Database Systems', 'progress_val' => 0.88, 'persentase_text' => '88%'];
            $presensiPerMk[] = ['user_id' => $uid, 'mk_name' => 'Web Development', 'progress_val' => 0.75, 'persentase_text' => '75%'];
            $presensiPerMk[] = ['user_id' => $uid, 'mk_name' => 'Software Engineering', 'progress_val' => 0.92, 'persentase_text' => '92%'];
        }
        $db->table('presensi_per_mk')->insertBatch($presensiPerMk);

        $presensiAktivitas = [];
        foreach ([1, 2, 3, 4] as $uid) {
            $presensiAktivitas[] = ['user_id' => $uid, 'desc' => 'Kehadiran ditandai untuk Data Structures', 'time_ago' => '2 jam yang lalu', 'type' => 'sukses'];
            $presensiAktivitas[] = ['user_id' => $uid, 'desc' => 'Tugas dikumpulkan untuk Web Development', 'time_ago' => '1 hari yang lalu', 'type' => 'krs'];
            $presensiAktivitas[] = ['user_id' => $uid, 'desc' => 'Pengingat: Kuis besok', 'time_ago' => '2 hari yang lalu', 'type' => 'peringatan'];
        }
        $db->table('presensi_aktivitas')->insertBatch($presensiAktivitas);

        $presensiJadwal = [];
        foreach ([1, 2, 3, 4] as $uid) {
            $presensiJadwal[] = [
                'user_id'      => $uid,
                'waktu'        => '09:00',
                'ampm'         => 'AM',
                'matkul'       => 'Praktikum Rekayasa Perangkat Lunak',
                'dosen'        => 'Lab A201 • Cahya Vikasari, S.T., M.Eng.',
                'status_text'  => 'Hadir',
                'status_color' => 'FF10B981',
                'status_bg'    => 'FFE6FDF5',
                'accent_color' => 'FF1A73E8',
            ];
            $presensiJadwal[] = [
                'user_id'      => $uid,
                'waktu'        => '11:00',
                'ampm'         => 'AM',
                'matkul'       => 'Praktikum Jaringan Komputer',
                'dosen'        => 'Lab B105 • Andesita Prihantara, ST,M.Eng.',
                'status_text'  => 'Mendatang',
                'status_color' => 'FFF59E0B',
                'status_bg'    => 'FFFDF6E2',
                'accent_color' => '00000000',
            ];
        }
        $db->table('presensi_jadwal_hari_ini')->insertBatch($presensiJadwal);

        $taTimeline = [];
        foreach ([1, 2, 3, 4] as $uid) {
            $taTimeline[] = ['user_id' => $uid, 'step_no' => '1', 'judul' => 'Pengajuan Judul', 'sub' => 'Selesai pada 23 Agustus 2024', 'status' => 'selesai'];
            $taTimeline[] = ['user_id' => $uid, 'step_no' => '2', 'judul' => 'Penetapan Dosen Pembimbing', 'sub' => 'Fajar Mahardika, S.Kom., M.Kom.', 'status' => 'selesai'];
            $taTimeline[] = ['user_id' => $uid, 'step_no' => '3', 'judul' => 'Riset dan Penulisan', 'sub' => 'Sedang berjalan - 65% selesai', 'status' => 'berjalan'];
            $taTimeline[] = ['user_id' => $uid, 'step_no' => '4', 'judul' => 'Seminar Proposal', 'sub' => 'Dijadwalkan untuk Des 2024', 'status' => 'jadwal'];
            $taTimeline[] = ['user_id' => $uid, 'step_no' => '5', 'judul' => 'Sidang Tugas Akhir', 'sub' => 'Menunggu penyelesaian', 'status' => 'tertunda'];
        }
        $db->table('ta_timeline')->insertBatch($taTimeline);

        $taCatatan = [];
        foreach ([1, 2, 3, 4] as $uid) {
            $taCatatan[] = ['user_id' => $uid, 'tanggal' => '5 Oktober 2025 - Literature Review Progress', 'catatan' => 'Lebih diperbaiki dari tata bahasa pada BAB 2, masih terdapat kalimat yang tidak memenuhi EYD'];
            $taCatatan[] = ['user_id' => $uid, 'tanggal' => '24 September 2025 - Perbaikan Metodelogi Penelitian', 'catatan' => 'Metodelogi yang anda tidak masuk akal, gunakan metodelogi yang sekiranya dapat anda implementasikan'];
        }
        $db->table('ta_catatan_dosen')->insertBatch($taCatatan);

        $taNotifikasi = [];
        foreach ([1, 2, 3, 4] as $uid) {
            $taNotifikasi[] = ['user_id' => $uid, 'judul' => 'Pengunduran Jadwal Bimbingan', 'sub' => 'Diundur menjadi tanggal 20 Okt 2025', 'waktu' => '2 jam yang lalu', 'type' => 'bahaya'];
            $taNotifikasi[] = ['user_id' => $uid, 'judul' => 'Revisi Tugas Akhir', 'sub' => 'Periksa kembali dokumen terbaru', 'waktu' => '3 hari yang lalu', 'type' => 'peringatan'];
            $taNotifikasi[] = ['user_id' => $uid, 'judul' => 'Pertemuan Tesis', 'sub' => 'Dijadwalkan untuk 22 Okt, 10:00 AM', 'waktu' => '2 hari yang lalu', 'type' => 'info'];
        }
        $db->table('ta_notifikasi')->insertBatch($taNotifikasi);

        $nilaiMatkul = [];
        foreach ([1, 2, 3, 4] as $uid) {
            $nilaiMatkul[] = [
                'user_id'         => $uid,
                'kode'            => 'CS401',
                'sks'             => '4 SKS',
                'nama'            => 'Praktikum Pemrograman Web 2',
                'predikat'        => 'A',
                'is_graded'       => 1,
                'highlight_color' => 'FF10B981',
                'status_text'     => 'Selesai',
                'status_color'    => 'FF10B981',
                'status_bg'       => 'FFE6FDF5',
            ];
            $nilaiMatkul[] = [
                'user_id'         => $uid,
                'kode'            => 'CS402',
                'sks'             => '2 SKS',
                'nama'            => 'Desain Interaksi Pengguna',
                'predikat'        => 'B',
                'is_graded'       => 1,
                'highlight_color' => 'FF10B981',
                'status_text'     => 'Selesai',
                'status_color'    => 'FF10B981',
                'status_bg'       => 'FFE6FDF5',
            ];
            $nilaiMatkul[] = [
                'user_id'         => $uid,
                'kode'            => 'CS403',
                'sks'             => '2 SKS',
                'nama'            => 'Matematika Diskrit',
                'predikat'        => 'AB',
                'is_graded'       => 1,
                'highlight_color' => 'FF10B981',
                'status_text'     => 'Selesai',
                'status_color'    => 'FF10B981',
                'status_bg'       => 'FFE6FDF5',
            ];
            $nilaiMatkul[] = [
                'user_id'         => $uid,
                'kode'            => 'CS404',
                'sks'             => '4 SKS',
                'nama'            => 'Praktikum Jaringan Komputer',
                'predikat'        => 'n/a',
                'is_graded'       => 0,
                'highlight_color' => 'FFF59E0B',
                'status_text'     => 'Selesai',
                'status_color'    => 'FFF59E0B',
                'status_bg'       => 'FFFDF6E2',
            ];
        }
        $db->table('nilai_matkul')->insertBatch($nilaiMatkul);

        $suratPermohonan = [];
        foreach ([1, 2, 3, 4] as $uid) {
            $suratPermohonan[] = ['user_id' => $uid, 'jenis_surat' => 'Pengajuan Transkrip', 'status' => 'Disetujui', 'tanggal_diajukan' => 'Diajukan pada 15 Des 2024'];
            $suratPermohonan[] = ['user_id' => $uid, 'jenis_surat' => 'Surat Keterangan Aktif', 'status' => 'Diproses', 'tanggal_diajukan' => 'Diajukan pada 10 Des 2024'];
            $suratPermohonan[] = ['user_id' => $uid, 'jenis_surat' => 'Pengajuan Cuti', 'status' => 'Ditolak', 'tanggal_diajukan' => 'Diajukan pada 5 Des 2024'];
        }
        $db->table('surat_permohonan')->insertBatch($suratPermohonan);

        $keuanganRiwayat = [];
        foreach ([1, 2, 3, 4] as $uid) {
            $keuanganRiwayat[] = ['user_id' => $uid, 'title' => 'Semester Genap 2023/2024', 'sub' => 'Pembayaran UKT - Teknik Informatika', 'date' => 'Dibayar pada 10 Februari 2024', 'amount' => 'Rp 5.250.000', 'type' => 'spp'];
            $keuanganRiwayat[] = ['user_id' => $uid, 'title' => 'Semester Ganjil 2023/2024', 'sub' => 'Pembayaran UKT - Teknik Informatika', 'date' => 'Dibayar pada 15 Agustus 2023', 'amount' => 'Rp 5.250.000', 'type' => 'spp'];
            $keuanganRiwayat[] = ['user_id' => $uid, 'title' => 'Biaya Pendaftaran Mandiri', 'sub' => 'Registrasi Awal Mahasiswa Baru', 'date' => 'Dibayar pada 1 Juli 2023', 'amount' => 'Rp 500.000', 'type' => 'daftar'];
        }
        $db->table('keuangan_riwayat')->insertBatch($keuanganRiwayat);
    }
}
