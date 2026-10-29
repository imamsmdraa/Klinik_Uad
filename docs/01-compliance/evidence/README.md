# Bukti baseline M01

Tanggal pemeriksaan: 29 Oktober 2026. Lingkungan: Windows, Flutter 3.47.7, Dart 3.13.5. Target APK: Android API 24 ke atas. Bukti APK/log diperbarui setelah sinkronisasi main. Screenshot storage terdahulu memakai ID com.example.flutter_application_1; aplikasi terbaru memakai id.ac.uad.klinik_uad, sehingga screenshot tersebut adalah bukti historis dan uji native versi terbaru perlu diulang.

## Hasil otomatis

| Pemeriksaan | Hasil | Bukti |
|---|---|---|
| Analisis kode + `avoid_print` | Lulus, tidak ada masalah | `flutter-analyze.txt` |
| Build release dengan obfuscation | Berhasil; simbol terpisah dan diabaikan Git | `build-release.txt` |
| Izin APK release | Tidak ada INTERNET, CAMERA, lokasi, atau kontak; izin internal receiver AndroidX tetap ada | `apk-permissions.txt` |
| Manifest APK | `allowBackup=false`, `usesCleartextTraffic=false`; `debuggable` tidak ada (default Android false) | `apk-manifest.txt` |
| Resource jaringan APK | `cleartextTrafficPermitted=false` | `apk-network-config.txt` |
| Identitas artefak APK | SHA-256 untuk mencocokkan APK yang diuji | `apk-sha256.txt` |
| Pemindaian pola rahasia dan print | Tidak ada kecocokan pola terpilih pada working tree/riwayat Git lokal; enam pola berkas rahasia terabaikan | `source-review.txt` |
| Perangkat Android | Tidak ada perangkat terhubung | `adb-devices.txt` |

Pengguna akan mencoba PIN dan penguncian melalui aplikasi sesuai panduan manual. Berkas tes otomatis tambahan dari branch lama sudah dihapus atas permintaan pengguna. Tes bawaan main tetap dipertahankan untuk menjaga kompatibilitas dan migrasi; pengguna mengikuti panduan manual. Pemeriksaan build/manifest tidak membuktikan enkripsi storage native atau perilaku saat aplikasi berjalan. Pemindaian rahasia memakai pola private key, AWS/GitHub/API token, JWT, serta assignment rahasia. Pemindaian tidak menjamin seluruh rahasia terdeteksi dan tidak menjangkau riwayat remote yang belum tersedia lokal.

## Tinjauan dependensi SEC-09

Main sudah menyediakan paket dari pub.dev: `flutter_secure_storage` 11.2.0 untuk akses penyimpanan aman platform dan `cryptography` 2.9.0 untuk PBKDF2. Lockfile mencatat versi, asal, dan checksum; sinkronisasi mempertahankan dependensi main, termasuk intl dan provider, beserta paket platform/transitif. Paket secure storage mendukung Android API 24 ke atas. Lockfile hasil resolusi ini membutuhkan Dart ≥ 3.13.0 dan Flutter ≥ 3.38.4; gunakan SDK yang memenuhi keduanya, misalnya versi pengujian di atas.

Hasil `pub-outdated.txt` menunjukkan versi lebih baru untuk `flutter_riverpod` 2.6.1, `cupertino_icons` 1.0.9, dan `intl` 0.19.0. Tim mempertahankan versi main agar baseline ini tidak sekaligus memigrasikan state/UI/format tanggal. Paket keamanan tidak tercantum sebagai outdated pada pemeriksaan ini. Pemeriksaan versi dan sumber bukan pemeriksaan advisory/CVE lengkap; anggota lain perlu meninjau lockfile, perubahan paket, dan advisory sebelum rilis berikutnya.

## Pemeriksaan yang masih perlu dilakukan

- Jalankan panduan [uji manual keamanan M01](../../m01-security-testing.md) di HP/emulator: PIN, batas percobaan, persistensi, dan penguncian saat meninggalkan aplikasi. Pemeriksaan enkripsi storage serta log tetap membutuhkan alat teknis terpisah.
- Simpan screenshot dengan nilai sintetis/tersamarkan; catat perangkat, versi OS, tanggal, dan hasil setiap kasus.
- Review lintas anggota sebelum commit/tag M01. M01 belum ditandai selesai.
- Signing APK masih memakai debug key bawaan proyek untuk tes lokal. Tim perlu signing rilis sendiri sebelum distribusi operasional.
- Build memberi peringatan kompatibilitas mendatang untuk Gradle/AGP/Kotlin serta DWARF debug information pada library ELF. Build tetap berhasil; obfuscation pada baseline belum berarti seluruh informasi debug binary sudah hilang. Tinjau artefak native dan stripping sebelum distribusi operasional.

Konfigurasi baseline belum menyediakan autentikasi akun, izin lintas pasien/peran, atau basis data medis terenkripsi. Gunakan data sintetis.

## Sinkronisasi main

Basis main: `6294714`. Cadangan branch lama: `backup/m01-security-baseline-before-sync-20261029` (`32d8d03`). API layanan PIN, ID Android, model/repository janji, tema, dan dokumen desain main tetap dipertahankan. PIN lama dimigrasikan tanpa reset, lalu hash ditingkatkan setelah verifikasi benar. Tag `m01-initiation` yang sudah ada masih menunjuk commit lama `b7568c6`; tag itu belum mencakup perubahan ini dan tidak dipindahkan saat sinkronisasi.

Verifikasi integrasi: 16 tes bawaan proyek lulus, termasuk kompatibilitas format PIN main/branch lama, peningkatan KDF, penolakan PIN salah, lockout antar-instance, serta kegagalan storage. Hasil ini memakai mock penyimpanan dan tidak menggantikan uji manual. Build Windows sempat gagal karena `org.gradle.java.home` menunjuk path Linux; override itu dihapus, kemudian build release berhasil.
