# Panduan Instalasi dan Menjalankan SIAKAD PNC Lokal

Sistem SIAKAD PNC Mobile terdiri dari dua komponen utama:
1. **Backend**: CodeIgniter 4 REST API dengan database MySQL.
2. **Frontend**: Aplikasi Mobile Flutter menggunakan Riverpod 3.x.

---

## Prasyarat Sistem
Sebelum memulai, pastikan perangkat Anda sudah terinstal:
- **PHP 8.1 atau lebih baru** (Aktifkan ekstensi `mysqli` dan `pdo_mysql` di `php.ini` Anda)
- **MySQL Server** (bisa menggunakan Laragon, XAMPP, atau instalasi lokal MySQL lainnya)
- **Composer** (untuk dependensi PHP)
- **Flutter SDK** (versi stabil terbaru)
- **Git**

---

## 1. Konfigurasi Database MySQL

1. Aktifkan service **MySQL** di Laragon / XAMPP Anda.
2. Buat database baru bernama **`siakad`** melalui phpMyAdmin, DBeaver, atau klien database pilihan Anda.
3. Import file **`database.sql`** yang terletak pada root direktori proyek ini ke dalam database `siakad` tersebut. 
   *(File ini sudah memuat seluruh tabel lengkap beserta data awal/seed untuk 3 user berbeda).*

> [!NOTE]
> Secara default, konfigurasi database di `api/app/Config/Database.php` menggunakan:
> - Hostname: `localhost`
> - Username: `root`
> - Password: `` (kosong)
> - Database: `siakad`
>
> Jika kredensial MySQL lokal Anda berbeda, silakan ubah pengaturan default group pada file `api/app/Config/Database.php` sesuai dengan konfigurasi Anda.

---

## 2. Menjalankan Backend (CodeIgniter 4 API)

Masuk ke direktori `api` dari terminal:
```bash
cd api
```

### A. Instal Dependensi Composer
Instal library php yang dibutuhkan:
```bash
composer install
```

### B. Jalankan Server API Lokal
Jalankan server spark dev pada port 8080:
```bash
php spark serve --port 8080
```
Server API sekarang berjalan di alamat: **`http://127.0.0.1:8080`**

---

## 3. Menjalankan Frontend (Flutter Mobile)

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

## Informasi Akun Uji Coba (4 User Berbeda)

Anda dapat login menggunakan **Email** atau **NIM** dengan password **`123456`**. Masing-masing akun menampilkan data akademis, jadwal, nilai, presensi, keuangan, dan MBKM yang unik:

1. **Hilmi Mubarok** (Teknik Informatika - Semester 3)
   - NIM: `240202078`
   - Email: `hilmi@siakad.ac.id`

2. **Khalifah Brilianti R** (Teknik Informatika - Semester 5)
   - NIM: `240102080`
   - Email: `khalifah@siakad.ac.id`

3. **Nadjwa Naela Aziz** (Teknik Informatika - Semester 3)
   - NIM: `240102087`
   - Email: `nadjwa@siakad.ac.id`

4. **Suryo Nugroho** (Teknik Informatika - Semester 5)
   - NIM: `240202094`
   - Email: `suryo@siakad.ac.id`

---

## Fitur Interaktif Database
- **Tandai Kehadiran** (Presensi Cepat): Mengubah status menjadi "Hadir" di database MySQL dan merefresh halaman secara instan.
- **Proses Pembayaran** (Keuangan/UKT): Menekan tombol "Bayar" akan mengubah status tagihan menjadi "Lunas", nominal tunggakan menjadi "Rp 0", dan memindahkan nominal saldo ke terbayar di database MySQL.
