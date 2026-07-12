<?php

namespace App\Controllers;

use CodeIgniter\Controller;

class ApiController extends Controller
{
    public function __construct()
    {
        
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Allow-Headers: X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method, Authorization");
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
        if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
            exit(0);
        }
    }

    private function getDb()
    {
        return \Config\Database::connect();
    }

    public function login()
    {
        $db = $this->getDb();
        $email = '';
        $password = '';

        $rawInput = file_get_contents('php://input');
        if (!empty($rawInput)) {
            $json = json_decode($rawInput, true);
            if (is_array($json)) {
                $email = $json['email'] ?? '';
                $password = $json['password'] ?? '';
            }
        }

        if (empty($email) || empty($password)) {
            $email = $this->request->getPost('email') ?? $this->request->getGet('email') ?? '';
            $password = $this->request->getPost('password') ?? $this->request->getGet('password') ?? '';
        }

        if (empty($email) || empty($password)) {
            return $this->response->setJSON([
                'status' => 'error',
                'message' => 'NIM/Email dan Password wajib diisi.'
            ])->setStatusCode(400);
        }

        $user = $db->table('users')
                   ->groupStart()
                       ->where('email', $email)
                       ->orWhere('nim', $email)
                   ->groupEnd()
                   ->get()
                   ->getRowArray();

        if (!$user) {
            return $this->response->setJSON([
                'status' => 'error',
                'message' => 'Email atau Password salah.'
            ])->setStatusCode(401);
        }

        if (!password_verify($password, $user['password'])) {
            return $this->response->setJSON([
                'status' => 'error',
                'message' => 'Email atau Password salah.'
            ])->setStatusCode(401);
        }

        
        unset($user['password']);

        return $this->response->setJSON([
            'status' => 'success',
            'message' => 'Login berhasil.',
            'user' => $user
        ]);
    }

    public function getUser($userId)
    {
        $db = $this->getDb();
        $user = $db->table('users')->where('id', $userId)->get()->getRowArray();
        if (!$user) {
            return $this->response->setJSON(['status' => 'error', 'message' => 'User tidak ditemukan.'])->setStatusCode(404);
        }
        unset($user['password']);
        return $this->response->setJSON(['status' => 'success', 'user' => $user]);
    }

    public function getMatkul($userId)
    {
        $db = $this->getDb();
        $matkul = $db->table('matkul')->where('user_id', $userId)->get()->getResultArray();
        return $this->response->setJSON([
            'status' => 'success',
            'data' => $matkul
        ]);
    }

    public function getPresensi($userId)
    {
        $db = $this->getDb();
        $user = $db->table('users')->where('id', $userId)->get()->getRowArray();
        
        $presensiCepat = $db->table('presensi_cepat')->where('user_id', $userId)->get()->getResultArray();
        $presensiPerMk = $db->table('presensi_per_mk')->where('user_id', $userId)->get()->getResultArray();
        $presensiAktivitas = $db->table('presensi_aktivitas')->where('user_id', $userId)->get()->getResultArray();
        $presensiJadwal = $db->table('presensi_jadwal_hari_ini')->where('user_id', $userId)->get()->getResultArray();

        return $this->response->setJSON([
            'status' => 'success',
            'persentase_kehadiran' => $user ? $user['presensi_persen'] : 0,
            'ipk' => $user ? $user['ipk'] : 0,
            'sks' => $user ? $user['sks_krs'] : 0,
            'presensi_cepat' => $presensiCepat,
            'presensi_per_mk' => $presensiPerMk,
            'aktivitas_terbaru' => $presensiAktivitas,
            'jadwal_hari_ini' => $presensiJadwal
        ]);
    }

    public function markPresensiCepat($userId)
    {
        $db = $this->getDb();
        $id = $this->request->getVar('id');
        if (empty($id)) {
            $raw = $this->request->getJSON();
            $id = $raw->id ?? null;
        }

        if ($id) {
            $db->table('presensi_cepat')
               ->where('id', $id)
               ->where('user_id', $userId)
               ->update(['is_marked' => 1]);
            return $this->response->setJSON(['status' => 'success', 'message' => 'Kehadiran berhasil ditandai.']);
        }

        return $this->response->setJSON(['status' => 'error', 'message' => 'ID presensi tidak valid.'])->setStatusCode(400);
    }

    public function getTugasAkhir($userId)
    {
        $db = $this->getDb();
        $user = $db->table('users')->where('id', $userId)->get()->getRowArray();
        
        $timeline = $db->table('ta_timeline')->where('user_id', $userId)->get()->getResultArray();
        $catatan = $db->table('ta_catatan_dosen')->where('user_id', $userId)->get()->getResultArray();
        $notifikasi = $db->table('ta_notifikasi')->where('user_id', $userId)->get()->getResultArray();

        return $this->response->setJSON([
            'status' => 'success',
            'ta_progres' => $user ? $user['ta_progres'] : 0,
            'ta_judul' => $user ? $user['ta_judul'] : '',
            'ta_dosen' => $user ? $user['ta_dosen'] : '',
            'ta_mulai' => $user ? $user['ta_mulai'] : '',
            'timeline' => $timeline,
            'catatan' => $catatan,
            'notifikasi' => $notifikasi
        ]);
    }

    public function getNilaiTranskrip($userId)
    {
        $db = $this->getDb();
        $nilai = $db->table('nilai_matkul')->where('user_id', $userId)->get()->getResultArray();
        return $this->response->setJSON([
            'status' => 'success',
            'data' => $nilai
        ]);
    }

    public function getSurat($userId)
    {
        $db = $this->getDb();
        $surat = $db->table('surat_permohonan')->where('user_id', $userId)->get()->getResultArray();
        return $this->response->setJSON([
            'status' => 'success',
            'data' => $surat
        ]);
    }

    public function getKeuangan($userId)
    {
        $db = $this->getDb();
        $user = $db->table('users')->where('id', $userId)->get()->getRowArray();
        $riwayat = $db->table('keuangan_riwayat')->where('user_id', $userId)->get()->getResultArray();

        return $this->response->setJSON([
            'status' => 'success',
            'keuangan_tunggakan' => $user ? $user['keuangan_tunggakan'] : 'Rp 0',
            'keuangan_terbayar' => $user ? $user['keuangan_terbayar'] : 'Rp 0',
            'keuangan_total' => $user ? $user['keuangan_total'] : 'Rp 0',
            'keuangan_status' => $user ? $user['keuangan_status'] : 'Lunas',
            'riwayat' => $riwayat
        ]);
    }

    public function bayarKeuangan($userId)
    {
        $db = $this->getDb();
        $user = $db->table('users')->where('id', $userId)->get()->getRowArray();
        if ($user) {
            $db->table('users')
               ->where('id', $userId)
               ->update([
                   'keuangan_status' => 'Lunas',
                   'keuangan_tunggakan' => 'Rp 0',
                   'keuangan_terbayar' => $user['keuangan_total']
               ]);
            return $this->response->setJSON([
                'status' => 'success',
                'message' => 'Pembayaran SPP/UKT berhasil diselesaikan.'
            ]);
        }
        return $this->response->setJSON(['status' => 'error', 'message' => 'User tidak ditemukan.'])->setStatusCode(404);
    }

    public function getMbkm($userId)
    {
        
        if ($userId == 1) {
            $magang = [
                [
                    'posisi' => 'Software Engineering Internship',
                    'instansi' => 'PT. Tech Solutions Indonesia',
                    'durasi' => '6 bulan',
                    'progres' => 0.65,
                    'persen' => '65%',
                    'status' => 'Aktif',
                    'color' => 'FF10B981'
                ],
                [
                    'posisi' => 'MBKM - Digital Marketing',
                    'instansi' => 'Startup Incubator Program',
                    'durasi' => '4 bulan',
                    'progres' => 0.30,
                    'persen' => '30%',
                    'status' => 'Sedang Berjalan',
                    'color' => 'FF1A73E8'
                ]
            ];
            $evaluasi = [
                [
                    'nama' => 'Rahmawan Bagus Trianto',
                    'role' => 'Software Engineering Supervisor',
                    'komentar' => '"Excellent progress in backend development skills. Shows great initiative in problem-solving."',
                    'rating' => '4.8',
                    'highlight' => 'FF10B981'
                ],
                [
                    'nama' => 'Rahmawan Bagus Trianto',
                    'role' => 'MBKM Program Coordinator',
                    'komentar' => '"Good understanding of marketing concepts. Needs improvement in presentation skills."',
                    'rating' => '4.6',
                    'highlight' => 'FF1A73E8'
                ]
            ];
            $laporan = [
                ['judul' => 'Laporan Mingguan #8', 'sub' => 'Software Engineering Internship', 'status' => 'Disetujui', 'type' => 'sukses'],
                ['judul' => 'Laporan Bulanan #2', 'sub' => 'MBKM - Digital Marketing', 'status' => 'Sedang Ditinjau', 'type' => 'peringatan'],
                ['judul' => 'Laporan Mingguan #7', 'sub' => 'Software Engineering Internship', 'status' => 'Disetujui', 'type' => 'info']
            ];
            $deadline = [
                ['judul' => 'Laporan Mingguan #9', 'sub' => 'Jatuh tempo dalam 2 hari', 'type' => 'bahaya'],
                ['judul' => 'Evaluasi Bulanan', 'sub' => 'Jatuh tempo dalam 1 minggu', 'type' => 'peringatan'],
                ['judul' => 'Presentasi Proyek', 'sub' => 'Jatuh tempo dalam 2 minggu', 'type' => 'info']
            ];
        } else if ($userId == 2) {
            $magang = [
                [
                    'posisi' => 'UI/UX Design Internship',
                    'instansi' => 'PT. Creative Studio',
                    'durasi' => '3 bulan',
                    'progres' => 0.40,
                    'persen' => '40%',
                    'status' => 'Aktif',
                    'color' => 'FF10B981'
                ]
            ];
            $evaluasi = [
                [
                    'nama' => 'Rahmawan Bagus Trianto',
                    'role' => 'UI/UX Lead',
                    'komentar' => '"Great eye for color palettes and layouts. Very responsive to feedback."',
                    'rating' => '4.5',
                    'highlight' => 'FF10B981'
                ]
            ];
            $laporan = [
                ['judul' => 'Laporan Mingguan #2', 'sub' => 'UI/UX Design Internship', 'status' => 'Disetujui', 'type' => 'sukses']
            ];
            $deadline = [
                ['judul' => 'Laporan Mingguan #3', 'sub' => 'Jatuh tempo dalam 3 hari', 'type' => 'bahaya']
            ];
        } else {
            $magang = [
                [
                    'posisi' => 'Mechanical Design Internship',
                    'instansi' => 'PT. Heavy Industries',
                    'durasi' => '6 bulan',
                    'progres' => 0.85,
                    'persen' => '85%',
                    'status' => 'Aktif',
                    'color' => 'FF10B981'
                ]
            ];
            $evaluasi = [
                [
                    'nama' => 'Andesita Prihantara',
                    'role' => 'Mechanical Supervisor',
                    'komentar' => '"Solid understanding of mechanics and physical designs. Excellent CAD work."',
                    'rating' => '4.9',
                    'highlight' => 'FF10B981'
                ]
            ];
            $laporan = [
                ['judul' => 'Laporan Mingguan #20', 'sub' => 'Mechanical Design Internship', 'status' => 'Disetujui', 'type' => 'sukses']
            ];
            $deadline = [
                ['judul' => 'Laporan Akhir Magang', 'sub' => 'Jatuh tempo dalam 1 minggu', 'type' => 'peringatan']
            ];
        }

        return $this->response->setJSON([
            'status' => 'success',
            'magang' => $magang,
            'evaluasi' => $evaluasi,
            'laporan' => $laporan,
            'deadline' => $deadline
        ]);
    }

    public function submitKrs($userId)
    {
        $db = $this->getDb();
        $raw = $this->request->getJSON();
        $sks = $raw->sks ?? 20;

        $user = $db->table('users')->where('id', $userId)->get()->getRowArray();
        if ($user) {
            $db->table('users')
               ->where('id', $userId)
               ->update(['sks_krs' => $sks]);
            return $this->response->setJSON([
                'status' => 'success',
                'message' => 'KRS berhasil diajukan untuk disetujui.'
            ]);
        }
        return $this->response->setJSON(['status' => 'error', 'message' => 'User tidak ditemukan.'])->setStatusCode(404);
    }

    public function addSurat($userId)
    {
        $db = $this->getDb();
        $raw = $this->request->getJSON();
        $jenis = $raw->jenis_surat ?? 'Surat Keterangan Aktif';

        $user = $db->table('users')->where('id', $userId)->get()->getRowArray();
        if ($user) {
            $db->table('surat_permohonan')->insert([
                'user_id'          => $userId,
                'jenis_surat'      => $jenis,
                'status'           => 'Diproses',
                'tanggal_diajukan' => 'Diajukan pada ' . date('d M Y')
            ]);
            return $this->response->setJSON([
                'status' => 'success',
                'message' => 'Permohonan surat berhasil diajukan.'
            ]);
        }
        return $this->response->setJSON(['status' => 'error', 'message' => 'User tidak ditemukan.'])->setStatusCode(404);
    }
}
