# Spesifikasi Kebutuhan Fungsional & Use Case (Use Cases)
**Proyek:** Klinik UAD — Layanan Kesehatan & Rekam Medis Kampus  

---

## 1. Matriks Aktor Sistem

1. **Pasien (Mahasiswa / Dosen / Karyawan UAD):**
   - Melakukan pendaftaran akun dan verifikasi identitas kampus.
   - Melakukan reservasi tiket antrean poli dokter dan memantau antrean *real-time*.
   - Mengakses riwayat rekam medis pribadi dengan otentikasi PIN.
   - Mengatur alarm pengingat minum obat dan kontrol kesehatan.
   - Menampilkan QR Code Kartu Berobat Digital untuk *check-in* mandiri.

2. **Tenaga Kesehatan (Dokter & Konselor):**
   - Membuka daftar antrean pasien pada poli yang bertugas.
   - Memanggil nomor antrean berikutnya.
   - Mencatat diagnosis, keluhan, dan resep obat ke Rekam Medis Elektronik.

3. **Perawat:**
   - Memindai QR Code Kartu Berobat pasien untuk verifikasi kedatangan (*check-in*).
   - Memeriksa dan mencatat tanda-tanda vital (tekanan darah, suhu badan, berat badan).

4. **Admin Klinik:**
   - Mengelola master data poli, jadwal praktik dokter, dan kuota harian.
   - Mengelola status operasional poliklinik dan laporan kunjungan berkala.

---

## 2. 5 Use Case Utama Aplikasi

### UC-01: Booking Antrean Poli & Dokter Online
- **Aktor:** Pasien
- **Pre-kondisi:** Pasien telah login dan menyetujui kebijakan privasi.
- **Alur Utama:**
  1. Pasien memilih menu "Ambil Antrean".
  2. Pasien memilih kategori poli (Poli Umum, Poli Gigi, Konseling Psikologi).
  3. Pasien memilih dokter yang aktif bertugas dan tanggal kunjungan.
  4. Sistem mengecek ketersediaan kuota dan memastikan pasien tidak memiliki appointment aktif di jam yang sama.
  5. Sistem menerbitkan tiket antrean digital dengan kode nomor (misal: `A-012`).
  6. Pasien memantau status pemanggilan secara langsung di layar utama.

### UC-02: Akses Rekam Medis Terproteksi PIN
- **Aktor:** Pasien
- **Pre-kondisi:** Pasien memiliki riwayat pemeriksaan medis sebelumnya.
- **Alur Utama:**
  1. Pasien menekan kartu riwayat pemeriksaan di menu Rekam Medis.
  2. Sistem menampilkan papan input PIN 6-digit.
  3. Pasien memasukkan PIN.
  4. Sistem memverifikasi hash PIN secara *constant-time*.
  5. Jika valid, sistem mendekripsi catatan diagnosis, keluhan, dan daftar obat untuk ditampilkan di layar.
  6. Jika salah 3 kali berturut-turut, sistem mengunci akses selama 5 menit.

### UC-03: Penjadwalan Pengingat Minum Obat (Local Reminder)
- **Aktor:** Pasien
- **Alur Utama:**
  1. Pasien memilih menu "Pengingat Obat".
  2. Pasien memasukkan nama obat, dosis, instruksi makan (sebelum/sesudah makan), dan jam alarm harian.
  3. Sistem mendaftarkan jadwal ke notification manager lokal Android.
  4. Notifikasi lokal muncul sesuai waktu yang ditentukan meski tanpa koneksi internet.

### UC-04: Pengajuan Konsultasi & Sesi Konseling
- **Aktor:** Pasien & Dokter/Konselor
- **Alur Utama:**
  1. Pasien memilih menu "Konseling & Konsultasi".
  2. Pasien mengisi ringkasan gejala awal atau topik bimbingan konseling.
  3. Data dienkripsi dan hanya diserahkan ke inbox konselor yang dipilih.
  4. Pasien menerima konfirmasi waktu temu konsultasi privat di klinik.

### UC-05: Check-In Digital Kartu Pasien (QR Code)
- **Aktor:** Pasien & Perawat
- **Alur Utama:**
  1. Pasien membuka menu "Kartu Pasien Digital" dan menampilkan kode QR terenkripsi.
  2. Perawat memindai QR code tersebut di meja registrasi menggunakan scanner klinik.
  3. Status antrean pasien otomatis berubah dari "Terdaftar" menjadi "Hadir / Siap Dipanggil".
