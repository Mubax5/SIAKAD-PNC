# Panduan Instalasi dan Menjalankan SIAKAD PNC Lokal

Sistem SIAKAD PNC Mobile terdiri dari dua komponen utama:
1. **Backend**: CodeIgniter 4 REST API dengan database SQLite3.
2. **Frontend**: Aplikasi Mobile Flutter menggunakan Riverpod 3.x.

---

## Prasyarat Sistem
Sebelum memulai, pastikan perangkat Anda sudah terinstal:
- **PHP 8.1 atau lebih baru** (Aktifkan ekstensi `sqlite3` dan `pdo_sqlite` di `php.ini` Anda)
- **Composer** (untuk dependensi PHP)
- **Flutter SDK** (versi stabil terbaru)
- **Git**

---

## 1. Langkah Konfigurasi & Menjalankan Backend (CodeIgniter 4 API)

Masuk ke direktori `api` dari terminal:
```bash
cd api
```

### A. Instal Dependensi Composer
Instal library php yang dibutuhkan:
```bash
composer install
```

### B. Migrasi dan Seeding Database
Jalankan perintah ini untuk membuat struktur tabel dan mengisi data awal (3 user uji coba):
```bash
php spark migrate
php spark db:seed SiakadSeeder
```
*Database SQLite3 akan tersimpan otomatis secara lokal di `writable/database.db`.*

### C. Jalankan Server API Lokal
Jalankan server spark dev pada port 8080:
```bash
php spark serve --port 8080
```
Server API sekarang berjalan di alamat: **`http://127.0.0.1:8080`**

---

## 2. Langkah Konfigurasi & Menjalankan Frontend (Flutter Mobile)

Buka terminal baru dan masuk ke direktori `flutter`:
```bash
cd flutter
```

### A. Ambil Dependensi Flutter
Ambil paket/package pub yang digunakan (seperti `http` dan `flutter_riverpod`):
```bash
flutter pub get
```

### B. Menjalankan Aplikasi
Jalankan aplikasi ke emulator, perangkat fisik, atau browser web yang terhubung:
```bash
flutter run
```

---

## Informasi Akun Uji Coba (3 User Berbeda)

Anda dapat login menggunakan **Email** atau **NIM** dengan password **`123456`**. Masing-masing akun menampilkan data akademis, jadwal, nilai, presensi, keuangan, dan MBKM yang unik:

1. **Hilmi Mubarok** (Teknik Informatika - Semester 3)
   - NIM: `240202078`
   - Email: `hilmi@siakad.ac.id`

2. **Budi Santoso** (Sistem Informasi - Semester 5)
   - NIM: `240202001`
   - Email: `budi@siakad.ac.id`

3. **Siti Aminah** (Teknik Mesin - Semester 7)
   - NIM: `240202002`
   - Email: `siti@siakad.ac.id`

---

## Fitur Interaktif Database
- **Tandai Kehadiran** (Presensi Cepat): Mengubah status menjadi "Hadir" di database dan merefresh halaman secara instan.
- **Proses Pembayaran** (Keuangan/UKT): Menekan tombol "Bayar" akan mengubah status tagihan menjadi "Lunas", nominal tunggakan menjadi "Rp 0", dan memindahkan nominal saldo ke terbayar di database SQLite.
