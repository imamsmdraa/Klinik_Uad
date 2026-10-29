# ADR 001 · Repository rekam medis M01

Tanggal: 29 Oktober 2026
Status: Diterapkan pada prototipe lokal

## Konteks

Layar Records sebelumnya menyimpan daftar contoh dan membandingkan PIN tetap di widget. Panduan M01 meminta pemisahan akses data, konfigurasi lingkungan, serta layanan keamanan sebelum integrasi backend.

## Keputusan

- Gunakan `MedicalRecordRepository` dengan implementasi `InMemoryMedicalRecordRepository`. Operasi `getAll/add/update/remove/clear` memakai data sintetis. UI membaca repository setelah PIN valid; kontrak ini menyesuaikan contoh repository pada materi dengan topik Klinik.
- Pertahankan Riverpod yang sudah dipakai proyek untuk menyediakan repository, `SecureStorageService`, dan `PinService`. Tidak menambah pengelola state kedua.
- Pertahankan `AppConfig` dari main, dengan `ENV=dev/test/staging/prod/production` dan `USE_REMOTE=false`. Nilai lingkungan tidak menyimpan rahasia. Aplikasi menolak konfigurasi tidak valid dan remote yang belum tersedia; URL backend belum diisi.
- Gunakan kembali tema/token yang sudah ada melalui `core/app_theme.dart`.
- Simpan satu record hash PIN, salt, versi, percobaan, dan akhir lockout melalui secure storage. Gunakan PBKDF2-HMAC-SHA256 120.000 iterasi, salt 16 byte, hasil 256 bit. Batasi 5 kesalahan selama 30 detik. Android tidak menghapus record otomatis saat gagal baca.

## Batas dan tahap berikutnya

Repository memori tidak menyimpan perubahan setelah proses berhenti; fixture bawaan tetap ada dalam APK. Kunci Records melindungi tampilan saja. Login, pembagian pasien/peran, ekspor, penghapusan lewat UI, dan basis data medis terenkripsi menunggu M04/M05. Penggantian/penghapusan PIN tersedia sebagai metode layanan yang meminta PIN lama, belum sebagai tombol aplikasi.

Sinkronisasi main mempertahankan `ClinicAppointment`, `ClinicRepository`, tema, dan tiga ADR yang sudah dibuat anggota lain. `MedicalRecordRepository` melengkapi akses data Records; API PIN tetap memakai `setupNewPin` dan `validateStoredPin` dari main. Hash/salt format lama 10.000 iterasi dimigrasikan ke record tunggal dengan metadata lockout, lalu di-hash ulang menjadi 120.000 iterasi setelah PIN benar. Format record branch lama juga tetap terbaca. Instalasi baru tidak membuat PIN `1234` otomatis; PIN yang sudah tersimpan tetap berlaku. Migrasi hanya menjangkau storage dalam ID aplikasi yang sama, bukan lintas ID aplikasi.

Saat menambah persistensi/backend, tim mengganti implementasi repository, memvalidasi data, dan menegakkan izin pada sumber data. Tim memperbarui R1/R6 serta meninjau izin jaringan sebelum mengaktifkan remote. Tim masih perlu mencoba penguncian pada perangkat Android dan memeriksa penyimpanan native; membuka layar aplikasi saja tidak membuktikan enkripsi berkas.
