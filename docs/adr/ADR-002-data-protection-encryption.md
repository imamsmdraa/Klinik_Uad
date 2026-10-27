# ADR 002: Strategi Pelindungan Data & Enkripsi Kriptografis
**Status:** Diterima (Accepted)  
**Tanggal:** Semester Gasal 2026/2027  
**Pengambil Keputusan:** Tim Pengembang Kelompok Klinik Kampus & Analis Keamanan  
**Referensi:** UU PDP No. 27/2022 Pasal 4 Ayat 2 (Data Pribadi Spesifik) & Baseline Keamanan M01

---

## Konteks & Permasalahan
Aplikasi Klinik UAD mengelola data kesehatan, riwayat diagnosis, alergi obat, dan catatan konseling psikologis yang berstatus **Data Pribadi Spesifik**. Jika data disimpan dalam teks polos pada SharedPreferences atau database lokal tanpa enkripsi, pengguna lain atau malware pada ponsel yang di-root dapat membaca data rahasia tersebut.

---

## Keputusan Arsitektur
1. Menggunakan **`flutter_secure_storage`** untuk menyimpan token autentikasi sesi, salt pengguna, dan kunci simetris lokal di dalam **Android Keystore** (hardware-backed).
2. Menerapkan proteksi **PIN 6-digit** untuk mengakses menu Rekam Medis:
   - Nilai PIN **tidak pernah disimpan mentah**.
   - PIN di-hash menggunakan algoritma **PBKDF2-HMAC-SHA256** dengan salt acak 16-byte minimal 10.000 iterasi via pustaka `cryptography`.
   - Pengecekan PIN dilakukan dengan **Constant-Time Comparison** untuk mencegah serangan kebocoran waktu (*timing attacks*).
3. Menonaktifkan pencadangan otomatis OS dengan menyetel `android:allowBackup="false"` pada `AndroidManifest.xml`.
4. Mengunci lalu lintas jaringan agar hanya menerima koneksi aman terenkripsi (HTTPS/TLS) melalui `network_security_config.xml`.

---

## Konsekuensi
- **Positif:** Memenuhi seluruh syarat hukum UU PDP No. 27/2022 dan standar OWASP Mobile Top 10 (M9 & M10). Data tetap aman meskipun file fisik database diekstrak dari perangkat.
- **Tantangan:** Proses hashing PBKDF2 membutuhkan komputasi kecil (~100-200 ms) saat verifikasi PIN, yang justru bermanfaat untuk mencegah serangan brute-force.
