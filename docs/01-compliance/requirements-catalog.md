# Katalog Requirement Kepatuhan
# Aplikasi: Klinik UAD Topik: Klinik Kelompok: Klinik UAD

Katalog ini memakai ID dari R1–R6. Milestone menunjukkan target pengerjaan, bukan status selesai. Tim memverifikasi implementasi dan menyimpan bukti di `evidence/` sebelum menandai kebutuhan terpenuhi.

Baseline kode 29 Oktober 2026 mencakup secure storage, KDF/batas PIN, konfigurasi Android offline, dan build obfuscation. Lihat [hasil pemeriksaan](evidence/README.md) serta [panduan uji](../m01-security-testing.md). Pemenuhan SEC-01–SEC-10 masih mengikuti batas masing-masing: native storage/log, tinjauan anggota lain, backend/peran, dan enkripsi basis data belum seluruhnya teruji/tersedia.

## Privasi & UX (PRV-xx, UX-xx)

| ID | Requirement | Sumber | Milestone |
|----|-------------|--------|-----------|
| PRV-01 | Tim memakai data sintetis dan membatasi jenis data sesuai fitur. Tim tidak mengumpulkan GPS, ID pelacakan perangkat, buku kontak, biometrik mentah, kamera, kontak darurat, NIK, dokumen identitas, atau pembayaran pada M01; penambahan data/izin memerlukan pembaruan R1 dan R6. | P04/R1; R2; R6 | M01–M05 |
| PRV-02 | Tim tidak memakai SDK analitik/iklan pihak ketiga yang mengumpulkan data pengguna dan meninjau dependensi sebelum rilis. | P04/R1; R6 | M01–M05 |
| PRV-03 | Pengguna dapat menghapus data uji lokal dalam ≤ 2 ketukan dari Privasi & Data, termasuk konfirmasi, tanpa CS. Tim menjelaskan cakupan penghapusan; prosedur retensi rekam medis operasional perlu keputusan klinik sebelum penggunaan nyata. | UU PDP Ps. 8; R1; R3; R5 | M04 lokal; M05 server |
| PRV-04 | Pasien dapat melihat dan mengekspor salinan data miliknya dalam format portabel, tanpa data pasien lain, token sesi, atau hash PIN. | UU PDP Ps. 7 dan 13; R3 | M04 lokal; M05 server |
| PRV-05 | Pengguna dapat membuka kebijakan privasi dari aplikasi sebelum memberi data. Isinya sesuai R1 dan versi aplikasi: identitas pengelola, tujuan/dasar pemrosesan, data, lokasi, akses, retensi, hak, dan kontak 2300016055@webmail.uad.ac.id. | UU PDP Ps. 5; R1–R3; R6 | M03 desain; M04 halaman; M05 pembaruan cloud |
| PRV-06 | Pasien dapat memperbarui profil miliknya dan mengajukan koreksi diagnosis/resep kepada petugas berwenang. Tim mencatat perubahan klinis dan membatasi akses sesuai hubungan pelayanan. | UU PDP Ps. 6; R3 | M04 simulasi; M05 server |
| UX-01 | Tim menjalankan pertanyaan audit R5 pada setiap rilis milestone, mencatat hasil dan perbaikan, serta meminta anggota lain meninjau bukti sebelum menyatakan lulus. Fitur belum tersedia tidak mendapat status lulus. | P04/R5 | M01–M05 |
| UX-02 | Fitur opsional default MATI. Pengguna dapat menarik persetujuan untuk tujuan terkait dan mematikan pengingat tanpa tekanan; tim membatalkan notifikasi terkait. Mematikan pengingat tidak otomatis menghapus rekam medis atau menarik persetujuan tujuan lain. | UU PDP Ps. 9; R3; R5 | M04 pengingat lokal; M05 persetujuan server |
| UX-03 | Tim memakai teks ≥ 14sp, kontras AA, dan label aksesibilitas pada kontrol utama. Tim menguji pembesaran teks dan pembaca layar. | P04/R5 | M03 desain; M04–M05 verifikasi |
| UX-04 | Tim menandai prototipe, data sintetis, dan simulasi. Klaim enkripsi, realtime, pengiriman pesan, keberhasilan booking, atau layanan resmi harus sesuai implementasi dan bukti. | ACM 1.3; IEEE-CS 1.03/3.10; R2; R5 | M01–M05 |

## Keamanan (SEC-xx)

| ID | Requirement | Sumber | Milestone |
|----|-------------|--------|-----------|
| SEC-01 | Tim menyimpan token, hash PIN, salt, dan kunci enkripsi dalam secure storage, bukan SharedPreferences biasa. Sebelum menyimpan data kesehatan secara permanen, tim menetapkan enkripsi penyimpanan dan pengelolaan kunci; secure storage bukan pengganti basis data rekam medis. | P05 M9; R1; R2; R4 | M01 layanan aman; M04 penyimpanan lokal; M05 cloud |
| SEC-02 | Tim mengganti PIN demo dengan PBKDF2, salt acak per PIN, serta batas percobaan. Tim tidak menyimpan PIN asli atau memakai MD5/SHA-1/hash polos sebagai KDF. Pada M05, layanan autentikasi mengelola kata sandi akun. | P05 M1/M3/M10; R1; R2; R4 | M01 PIN lokal; M05 autentikasi akun |
| SEC-03 | Tim menetapkan `allowBackup=false`, mengaktifkan `avoid_print`, dan memastikan kode produksi tidak mencetak data sensitif. Tim memverifikasi build release; banner debug tersembunyi bukan bukti mode release. | P05 M8; R2; R4 | M01 |
| SEC-04 | Tim mengecualikan `.env`, token, berkas signing, dan konfigurasi rahasia dari repo serta memeriksa berkas dan riwayat Git sebelum rilis. Jika rahasia terlanjur masuk riwayat, tim mencabut/menggantinya; menghapus berkas saja tidak cukup. | P05 M1; R4 | M01–M05 |
| SEC-05 | Tim melarang HTTP melalui `network_security_config`, memakai HTTPS saat integrasi backend, dan tidak menonaktifkan pemeriksaan sertifikat. | P05 M5; R1; R4 | M01 konfigurasi; M05 koneksi |
| SEC-06 | Tim membatasi izin sesuai fitur. APK release M01–M04 tanpa INTERNET; izin jaringan baru masuk saat integrasi M05. Tim memeriksa manifest gabungan/izin APK release; kebutuhan jaringan debug untuk pengembangan dinilai terpisah. | P05 M5/M6; R4 | M01–M04 verifikasi; M05 peninjauan izin |
| SEC-07 | Tim membatasi akses berdasarkan peran, pemilik data, dan hubungan pelayanan. Pasien tidak boleh menetapkan peran petugas sendiri; admin tidak mengakses isi diagnosis/resep/konseling. Tim menegakkan izin pada sumber data dan menguji penolakan lintas pasien serta peran. | ACM 1.7; P05 M3/M6; R2; R4 | M04 simulasi; M05 penegakan backend |
| SEC-08 | Tim memvalidasi format, panjang, rentang nilai, dan jadwal pada batas penerimaan data. Tim menangani kegagalan penyimpanan tanpa mengklaim berhasil dan mengulangi validasi pada backend. | IEEE-CS 3.10; P05 M4; R2; R4 | M04 lokal; M05 backend |
| SEC-09 | Tim meninjau sumber, versi, pemeliharaan, dan risiko paket, lalu menyimpan hasil tinjauan. Tim meninjau perubahan dan meng-commit `pubspec.lock` agar anggota memakai versi dependensi yang sama. | P05 M2; R4 | M01–M05 |
| SEC-10 | Tim memakai obfuscation pada build release, memverifikasi hasil, dan menyimpan simbol debug dengan akses terbatas. Tim tidak menanam rahasia dalam APK; obfuscation tidak mengenkripsi data. Sebelum distribusi operasional, tim memakai signing rilis yang sesuai. | P05 M7/M8; R4 | M01 baseline rilis; M04–M05 peninjauan |
