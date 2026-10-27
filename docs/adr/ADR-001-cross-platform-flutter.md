# ADR 001: Pemilihan Framework Cross-Platform Flutter
**Status:** Diterima (Accepted)  
**Tanggal:** Semester Gasal 2026/2027  
**Pengambil Keputusan:** Tim Pengembang Kelompok Klinik Kampus  
**Referensi:** Laporan Tugas 1 Bab III (Analisis Perbandingan Metode Pengembangan)

---

## Konteks & Permasalahan
Tim pengembang yang beranggotakan 4 mahasiswa memiliki batas waktu pengerjaan 16 minggu (satu semester) untuk membangun aplikasi mobile Klinik UAD. Sistem membutuhkan antarmuka yang cepat, konsisten, serta akses langsung ke fitur keamanan perangkat keras (Keystore/Keychain) untuk pelindungan data rekam medis. Perangkat pengembangan fisik tim berbasis Android.

Terdapat tiga pilihan pendekatan:
1. **Native Development (Kotlin & Swift):** Membutuhkan 2 basis kode terpisah.
2. **Hybrid WebView (Cordova / Ionic / Capacitor):** Membungkus HTML/CSS di dalam WebView.
3. **Cross-Platform Compiled (Flutter / Dart):** Satu basis kode dikompilasi langsung ke binary mesin native ARM.

---

## Keputusan Arsitektur
Memilih **Flutter (Dart)** sebagai teknologi utama pengembangan aplikasi mobile Klinik UAD.

---

## Alasan & Justifikasi
1. **Efisiensi Biaya & Waktu (Hemat 40–60%):**  
   Dengan basis kode tunggal Dart, tim tidak perlu membagi tenaga untuk menulis dua bahasa berbeda. Pembuatan fitur dan perbaikan bug dapat diselesaikan dua kali lebih cepat.
2. **Performa Rendering Tinggi (Impeller Engine):**  
   Flutter tidak bergantung pada jembatan JavaScript runtime atau browser WebView yang lambat. Tampilan antrean *real-time* dan animasi halaman berjalan mulus pada 60 fps.
3. **Dukungan Keamanan Data Medis yang Kuat:**  
   Ekosistem Flutter di `pub.dev` menyediakan paket keamanan resmi yang matang (`flutter_secure_storage`, `cryptography`, `encrypt`) dengan jembatan langsung ke Android Keystore.
4. **Kesesuaian Sumber Daya Tim:**  
   Aplikasi difokuskan untuk platform Android selama masa studi satu semester, dengan kesiapan ekspansi ke iOS di masa mendatang tanpa menulis ulang logika bisnis.

---

## Konsekuensi
- **Positif:** Satu codebase mudah dirawat, tampilan seragam, proses onboarding tenaga medis cepat.
- **Tantangan:** Ukuran berkas APK awal sedikit lebih besar (~15-20 MB) dibanding native murni karena menyertakan engine Flutter, namun sangat wajar untuk perangkat modern saat ini.
