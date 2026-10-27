# Katalog Kebutuhan Sistem (Requirements Catalog)
**Proyek:** Klinik UAD — Layanan Kesehatan & Rekam Medis Kampus  
**Kategori:** Kebutuhan Non-Fungsional (NFR) Terstandarisasi  

---

## 1. Kebutuhan Privasi & Tata Kelola Data (PRV)

| ID Kebutuhan | Nama Kebutuhan | Deskripsi Spesifikasi | Verifikasi / Kriteria Sukses |
|---|---|---|---|
| **PRV-01** | Informed Consent Explicit | Pengguna wajib menyetujui lembar persetujuan privasi secara eksplisit (kotak centang tidak boleh tercentang otomatis) sebelum data diproses. | Kotak persetujuan wajib bernilai `false` saat inisialisasi; tombol lanjutkan nonaktif hingga kotak dicentang. |
| **PRV-02** | Minimalisasi Data Pribadi | Sistem hanya meminta field data yang mutlak diperlukan untuk layanan medis (nama, NIM, email kampus, nomor telepon, golongan darah). | Tidak ada izin akses lokasi GPS, kontak, SMS, atau kamera tanpa kebutuhan fitur QR. |
| **PRV-03** | Pembatasan Retensi Akun | Akun mahasiswa yang lulus akan diarsipkan dan dianonimkan setelah periode retensi 2 tahun. | Pengujian fungsi anonymization data akun di database. |
| **PRV-04** | Pemisahan Akses Data Medis | Catatan konseling psikologi diisolasi ketat dan hanya dapat dibaca oleh konselor/psikolog yang ditugaskan. | Pengujian hak akses (RBAC test) dengan akun selain konselor terkait menghasilkan error `403 Forbidden`. |
| **PRV-05** | Hak Portabilitas & Ekspor | Pengguna dapat meminta salinan riwayat kunjungan dan resep dalam format digital terstruktur. | Fitur ekspor riwayat medis menghasilkan dokumen digital siap unduh. |

---

## 2. Kebutuhan Keamanan Sistem & Perangkat (SEC)

| ID Kebutuhan | Nama Kebutuhan | Deskripsi Spesifikasi | Verifikasi / Kriteria Sukses |
|---|---|---|---|
| **SEC-01** | Larangan Android Auto Backup | Mencegah dump data aplikasi dan catatan medis ke cadangan Google Drive melalui `adb backup`. | `android:allowBackup="false"` terpasang pada `AndroidManifest.xml`. |
| **SEC-02** | Larangan Lalu Lintas Cleartext | Seluruh komunikasi HTTP polos wajib ditolak oleh sistem operasi Android. | `cleartextTrafficPermitted="false"` aktif di `network_security_config.xml`. |
| **SEC-03** | Least Privilege Izin Internet M01 | Pada tahap baseline M01 (data lokal in-memory), izin `android.permission.INTERNET` tidak boleh dipasang. | Tidak ditemukan entri `uses-permission android:name="android.permission.INTERNET"` pada file manifest rilis M01. |
| **SEC-04** | Kebersihan Log Konsol (Linter) | Tidak ada data rekam medis, PIN, atau token sesi yang dicetak ke konsol debug. | Rule linter `avoid_print: true` aktif di `analysis_options.yaml` dan lolos `flutter analyze`. |
| **SEC-05** | Penyimpanan Kredensial Aman | Token sesi dan konfigurasi sensitif disimpan menggunakan enkripsi hardware-backed (Android Keystore). | Implementasi `flutter_secure_storage` pada layer `lib/services/secure_storage_service.dart`. |
| **SEC-06** | Hashing PIN & Constant-Time | PIN autentikasi rekam medis di-hash menggunakan PBKDF2 dengan salt acak dan diverifikasi secara constant-time. | Perbandingan hash menggunakan waktu konstan untuk mencegah serangan analisis jeda waktu (*timing attack*). |

---

## 3. Kebutuhan Kualitas Antarmuka & Responsivitas (UX)

| ID Kebutuhan | Nama Kebutuhan | Deskripsi Spesifikasi | Verifikasi / Kriteria Sukses |
|---|---|---|---|
| **UX-01** | Latensi Pembaruan Antrean | Perubahan nomor antrean yang diperbarui petugas wajib tampil pada layar pasien maksimal dalam 3 detik. | Pengukuran waktu propagasi pembaruan pada jaringan normal ≤ 3,0 detik. |
| **UX-02** | Desain Aksesibilitas Medis | Target sentuh tombol dan elemen interaktif minimal berukuran 48×48 dp dengan kontras rasio WCAG AA. | Audit tata letak Material 3 dan keterbacaan tipografi pada layar kecil. |
| **UX-03** | Ketahanan Offline Pengingat | Notifikasi lokal pengingat obat dan kontrol jadwal harus tetap berbunyi meskipun ponsel dalam mode pesawat. | Alarm tetap terpicu menggunakan scheduler lokal sistem operasi. |
| **UX-04** | Konfirmasi Pembatalan Antrean | Pasien yang membatalkan tiket antrean mendapatkan dialog konfirmasi ganda guna mencegah klik tidak sengaja. | Dialog konfirmasi muncul dengan pilihan "Tetap Antre" dan "Ya, Batalkan". |
