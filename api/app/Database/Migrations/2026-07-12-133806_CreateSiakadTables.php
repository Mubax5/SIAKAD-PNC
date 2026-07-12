<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateSiakadTables extends Migration
{
    public function up()
    {
        // 1. Table: users
        $this->forge->addField([
            'id' => [
                'type'           => 'INT',
                'constraint'     => 11,
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'nim' => [
                'type'       => 'VARCHAR',
                'constraint' => '50',
            ],
            'nama' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'email' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'password' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'prodi' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'semester' => [
                'type'       => 'INT',
                'constraint' => 5,
            ],
            'ipk' => [
                'type'       => 'DOUBLE',
            ],
            'avatar' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'sks_krs' => [
                'type'       => 'INT',
                'constraint' => 11,
            ],
            'sks_total' => [
                'type'       => 'VARCHAR',
                'constraint' => '50',
            ],
            'ta_progres' => [
                'type'       => 'INT',
                'constraint' => 11,
            ],
            'ta_judul' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'ta_dosen' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'ta_mulai' => [
                'type'       => 'VARCHAR',
                'constraint' => '50',
            ],
            'presensi_persen' => [
                'type'       => 'INT',
                'constraint' => 11,
            ],
            'keuangan_tunggakan' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'keuangan_terbayar' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'keuangan_total' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'keuangan_status' => [
                'type'       => 'VARCHAR',
                'constraint' => '50',
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('users');

        // 2. Table: matkul
        $this->forge->addField([
            'id' => [
                'type'           => 'INT',
                'constraint'     => 11,
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'user_id' => [
                'type'       => 'INT',
                'constraint' => 11,
                'unsigned'   => true,
            ],
            'kode' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
            'nama' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'sks' => [
                'type'       => 'INT',
                'constraint' => 5,
            ],
            'dosen' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'jadwal' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'kelas' => [
                'type'       => 'VARCHAR',
                'constraint' => '50',
            ],
            'color_hex' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
            'bg_hex' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('matkul');

        // 3. Table: presensi_cepat
        $this->forge->addField([
            'id' => [
                'type'           => 'INT',
                'constraint'     => 11,
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'user_id' => [
                'type'       => 'INT',
                'constraint' => 11,
                'unsigned'   => true,
            ],
            'title' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'subtitle' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'is_marked' => [
                'type'       => 'TINYINT',
                'constraint' => 1,
                'default'    => 0,
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('presensi_cepat');

        // 4. Table: presensi_per_mk
        $this->forge->addField([
            'id' => [
                'type'           => 'INT',
                'constraint'     => 11,
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'user_id' => [
                'type'       => 'INT',
                'constraint' => 11,
                'unsigned'   => true,
            ],
            'mk_name' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'progress_val' => [
                'type'       => 'DOUBLE',
            ],
            'persentase_text' => [
                'type'       => 'VARCHAR',
                'constraint' => '10',
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('presensi_per_mk');

        // 5. Table: presensi_aktivitas
        $this->forge->addField([
            'id' => [
                'type'           => 'INT',
                'constraint'     => 11,
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'user_id' => [
                'type'       => 'INT',
                'constraint' => 11,
                'unsigned'   => true,
            ],
            'desc' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'time_ago' => [
                'type'       => 'VARCHAR',
                'constraint' => '50',
            ],
            'type' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('presensi_aktivitas');

        // 6. Table: presensi_jadwal_hari_ini
        $this->forge->addField([
            'id' => [
                'type'           => 'INT',
                'constraint'     => 11,
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'user_id' => [
                'type'       => 'INT',
                'constraint' => 11,
                'unsigned'   => true,
            ],
            'waktu' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
            'ampm' => [
                'type'       => 'VARCHAR',
                'constraint' => '10',
            ],
            'matkul' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'dosen' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'status_text' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
            'status_color' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
            'status_bg' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
            'accent_color' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('presensi_jadwal_hari_ini');

        // 7. Table: ta_timeline
        $this->forge->addField([
            'id' => [
                'type'           => 'INT',
                'constraint'     => 11,
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'user_id' => [
                'type'       => 'INT',
                'constraint' => 11,
                'unsigned'   => true,
            ],
            'step_no' => [
                'type'       => 'VARCHAR',
                'constraint' => '10',
            ],
            'judul' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'sub' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'status' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('ta_timeline');

        // 8. Table: ta_catatan_dosen
        $this->forge->addField([
            'id' => [
                'type'           => 'INT',
                'constraint'     => 11,
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'user_id' => [
                'type'       => 'INT',
                'constraint' => 11,
                'unsigned'   => true,
            ],
            'tanggal' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'catatan' => [
                'type' => 'TEXT',
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('ta_catatan_dosen');

        // 9. Table: ta_notifikasi
        $this->forge->addField([
            'id' => [
                'type'           => 'INT',
                'constraint'     => 11,
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'user_id' => [
                'type'       => 'INT',
                'constraint' => 11,
                'unsigned'   => true,
            ],
            'judul' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'sub' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'waktu' => [
                'type'       => 'VARCHAR',
                'constraint' => '50',
            ],
            'type' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('ta_notifikasi');

        // 10. Table: nilai_matkul
        $this->forge->addField([
            'id' => [
                'type'           => 'INT',
                'constraint'     => 11,
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'user_id' => [
                'type'       => 'INT',
                'constraint' => 11,
                'unsigned'   => true,
            ],
            'kode' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
            'sks' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
            'nama' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'predikat' => [
                'type'       => 'VARCHAR',
                'constraint' => '10',
            ],
            'is_graded' => [
                'type'       => 'TINYINT',
                'constraint' => 1,
                'default'    => 0,
            ],
            'highlight_color' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
            'status_text' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
            'status_color' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
            'status_bg' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('nilai_matkul');

        // 11. Table: surat_permohonan
        $this->forge->addField([
            'id' => [
                'type'           => 'INT',
                'constraint'     => 11,
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'user_id' => [
                'type'       => 'INT',
                'constraint' => 11,
                'unsigned'   => true,
            ],
            'jenis_surat' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'status' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
            'tanggal_diajukan' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('surat_permohonan');

        // 12. Table: keuangan_riwayat
        $this->forge->addField([
            'id' => [
                'type'           => 'INT',
                'constraint'     => 11,
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'user_id' => [
                'type'       => 'INT',
                'constraint' => 11,
                'unsigned'   => true,
            ],
            'title' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'sub' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'date' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'amount' => [
                'type'       => 'VARCHAR',
                'constraint' => '50',
            ],
            'type' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('keuangan_riwayat');
    }

    public function down()
    {
        $this->forge->dropTable('keuangan_riwayat');
        $this->forge->dropTable('surat_permohonan');
        $this->forge->dropTable('nilai_matkul');
        $this->forge->dropTable('ta_notifikasi');
        $this->forge->dropTable('ta_catatan_dosen');
        $this->forge->dropTable('ta_timeline');
        $this->forge->dropTable('presensi_jadwal_hari_ini');
        $this->forge->dropTable('presensi_aktivitas');
        $this->forge->dropTable('presensi_per_mk');
        $this->forge->dropTable('presensi_cepat');
        $this->forge->dropTable('matkul');
        $this->forge->dropTable('users');
    }
}
