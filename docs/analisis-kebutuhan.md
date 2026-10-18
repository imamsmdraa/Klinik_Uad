# Tahap 1 - Analisis Kebutuhan Klinik UAD

## Tujuan

Klinik UAD membutuhkan satu kanal layanan kesehatan kampus yang aman dan
terukur. Aplikasi harus mengurangi antrean manual, mempercepat akses rekam
medis, dan memberi petugas satu sumber data operasional.

## Aktor dan kebutuhan

| Aktor | Kebutuhan utama |
| --- | --- |
| Pasien | Autentikasi, profil kesehatan, booking, antrean realtime, kartu digital, rekam medis, reminder, dan konsultasi |
| Dokter | Jadwal, antrean, pemeriksaan, diagnosis, resep, catatan, dan status pasien |
| Perawat | Antrean, QR check-in, data pasien, dan tanda vital |
| Admin klinik | CRUD master data, manajemen user, antrean, laporan, dan statistik |

## Kebutuhan fungsional

1. Sistem mengautentikasi pengguna melalui Supabase Auth dan mengikat setiap
   akun ke satu role RBAC.
2. Pasien dapat memilih poli, dokter, jadwal, dan memperoleh nomor antrean
   tanpa bentrok pada slot yang sama.
3. Perubahan antrean terlihat realtime bagi pasien dan petugas berwenang.
4. Catatan medis hanya dapat diakses pasien pemilik dan petugas klinik sesuai
   kewenangannya.
5. Dokter dapat membuat diagnosis, resep, dan catatan pemeriksaan yang
   terhubung ke appointment.
6. Reminder obat/kontrol dapat dibuat, diubah, ditandai selesai, dan
   menghasilkan notifikasi lokal.
7. QR kartu digital dapat dipindai perawat/admin untuk check-in appointment
   yang valid.
8. Admin dapat mengelola master poli, dokter, jadwal, user, dan laporan.
9. Pasien harus menyetujui informed consent dan kebijakan privasi sebelum
   menggunakan layanan.

## Kebutuhan nonfungsional

- **Keamanan:** TLS, JWT/session refresh, RLS PostgreSQL, RBAC, validasi input,
  audit timestamp, minimisasi data, dan enkripsi data sensitif di perangkat.
- **Ketersediaan:** kegagalan jaringan harus menghasilkan error yang jelas,
  bukan data palsu; antrean realtime memiliki fallback refresh manual.
- **Kinerja:** halaman utama tampil dengan data lokal/cache yang aman dan
  operasi database menggunakan indeks serta pagination.
- **Aksesibilitas:** Material 3, kontras memadai, ukuran teks adaptif,
  label semantik, dan target sentuh yang cukup.
- **Pemeliharaan:** Clean Architecture, Repository Pattern, Riverpod, model
  immutable, serta test unit/widget/integrasi.

## Aturan bisnis penting

- Satu pasien tidak boleh memiliki dua appointment aktif pada slot yang sama.
- Nomor antrean diurutkan berdasarkan pendaftaran valid dan tidak boleh
  ditentukan oleh klien.
- Hanya appointment pada tanggal dan status yang sesuai yang dapat di-check-in.
- Dokter hanya dapat menulis rekam medis pada pasien yang memiliki appointment
  dengannya.
- Soft delete dipakai untuk master data; histori medis tidak dihapus secara
  fisik tanpa prosedur retensi resmi.

## Acceptance criteria tahap ini

- Aktor, kebutuhan, aturan bisnis, dan risiko utama terdokumentasi.
- Batas modul dan keputusan arsitektur memiliki alasan yang jelas.
- Struktur proyek siap menerima implementasi fitur tanpa mengulang fondasi.
