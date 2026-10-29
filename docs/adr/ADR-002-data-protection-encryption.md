# ADR 002: Perlindungan data dan PIN lokal

Status: Diterima; disesuaikan saat sinkronisasi main, 29 Oktober 2026.

## Konteks

Topik Klinik mencakup data kesehatan. M01 memakai contoh sintetis; kode belum menyimpan basis data rekam medis terenkripsi atau menegakkan izin pasien/petugas. Kebijakan implementasi harus sesuai kondisi ini.

## Keputusan

- Gunakan `flutter_secure_storage` untuk hash PIN, salt, jumlah iterasi, versi format, percobaan, dan akhir lockout. Android memakai perlindungan kunci platform; kemampuan hardware bergantung perangkat. `resetOnError=false` menjaga agar error tidak menghapus kredensial otomatis.
- PIN lokal mengikuti keypad empat digit. PIN baru memakai PBKDF2-HMAC-SHA256 120.000 iterasi, salt acak 16 byte, hasil 256 bit. Perbandingan byte tidak berhenti pada perbedaan pertama. Lima kegagalan menunda akses 30 detik.
- Pertahankan PIN lama dari main. Format dua key 10.000 iterasi ditingkatkan setelah PIN benar; format record tunggal branch sebelumnya tetap terbaca. PIN bawaan tidak lagi dibuat pada instalasi baru.
- Tetapkan backup Android nonaktif, larang HTTP, dan periksa APK release tanpa INTERNET. Integrasi HTTPS backend menunggu M05.

## Batas

Kunci layar bukan enkripsi rekam medis atau kontrol lintas pasien/peran. Root, perubahan jam perangkat, PIN empat digit, serta snapshot layar memerlukan penilaian tersendiri. Keamanan native dan waktu KDF perlu diukur pada perangkat. Keputusan ini belum membuktikan seluruh UU PDP atau OWASP terpenuhi.

Lihat [ADR sinkronisasi](001-repository-pattern.md), [R4](../01-compliance/owasp-assessment.md), dan [panduan uji manual](../m01-security-testing.md).
