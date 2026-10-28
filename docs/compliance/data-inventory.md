# R1 · Inventaris Data Pribadi
# Aplikasi: Klinik UAD Topik: Klinik Kelompok: Klinik UAD

Tim memakai data sintetis pada M01. Tabel mencatat kondisi prototipe dan menandai rencana tahap berikutnya. Kategori UU PDP berlaku jika data merujuk pada orang nyata. Tim perlu memastikan contoh tidak berasal dari pasien atau kredensial nyata.

| Data | Kategori UU PDP | Tujuan | Lokasi simpan | Retensi | Perlindungan |
|------|-----------------|--------|---------------|---------|--------------|
| Nama, NIM, status sivitas, dan ID kartu pasien contoh | Umum: identitas pribadi | Menampilkan profil dan kartu pasien | Lokal: kode sumber dan memori | Selama contoh ada di kode; salinan lama dapat tetap ada dalam riwayat Git/APK | Tim memakai identitas fiktif; kontrol akses belum tersedia |
| Nama dokter/konselor, poli, ruang, dan jadwal contoh | Umum jika mengidentifikasi petugas | Menampilkan pilihan layanan | Lokal: kode sumber dan memori | Selama contoh ada di kode | Tim memakai petugas fiktif; jadwal bukan informasi layanan resmi |
| Booking dan antrean: pasien, poli, dokter, tanggal, jam, nomor, dan status | Spesifik jika mengungkap penggunaan layanan kesehatan | Menguji pendaftaran dan antrean | Lokal: contoh dalam kode dan pilihan dalam memori | Pilihan hingga state dilepas/proses berakhir; contoh tetap di kode | Data sintetis; penyimpanan booking dan pemeriksaan peran belum tersedia |
| Golongan darah, tinggi, berat, BMI, alergi, riwayat penyakit, dan vaksinasi contoh | Spesifik: data kesehatan | Menampilkan profil kesehatan simulasi | Lokal: kode sumber dan memori | Selama contoh ada di kode | Data sintetis; enkripsi penyimpanan belum tersedia |
| Kunjungan, diagnosis, gejala, tanda vital, resep, dan hasil laboratorium contoh | Spesifik: data kesehatan | Menguji tampilan rekam medis | Lokal: kode sumber dan memori | Selama contoh ada di kode | PIN demo hanya membatasi tampilan; perlindungan medis belum tersedia |
| Obat, dosis, jadwal, sisa hari, dan status konsumsi | Spesifik jika terkait pasien | Menguji pengingat dan pencatatan konsumsi obat | Lokal: contoh dalam kode dan perubahan dalam memori | Perubahan hingga state dilepas/proses berakhir; contoh tetap di kode | Resep sintetis; penyimpanan permanen dan notifikasi belum tersedia |
| Percakapan contoh dan pesan uji | Spesifik jika memuat kondisi kesehatan atau psikologis | Menguji tampilan chat simulasi | Lokal: contoh dalam kode dan pesan tambahan dalam memori | Pesan tambahan hingga state dilepas/proses berakhir; contoh tetap di kode | Penguji memakai pesan sintetis; aplikasi tidak mengirim pesan ke konselor/server; tim menunda chat operasional |
| Nama, identitas login/email, dan kata sandi uji pada formulir | Umum: identitas akun; kata sandi merupakan rahasia autentikasi | Menguji formulir akun | Lokal: controller dalam memori | Hingga controller dilepas/proses berakhir | Penguji memakai nilai uji; belum ada autentikasi backend atau penyimpanan akun |
| Input PIN dan PIN demo | Rahasia autentikasi | Menguji layar kunci | Lokal: input dalam memori; PIN demo dalam kode | Input hingga state direset/proses berakhir; PIN demo tetap di kode | Sudah memakai PBKDF2‑HMAC‑SHA256 dengan salt acak, secure storage, dan batas percobaan verifikasi; jangan gunakan PIN pribadi |
| Email, ID akun, dan peran pengguna (rencana) | Umum: identitas akun | Autentikasi dan pembatasan layanan | Cloud: Supabase pada M05 | Akun uji hingga pengujian selesai; retensi operasional menunggu pengelola | Rencana: verifikasi akun, HTTPS, akses per peran; pasien tidak dapat menetapkan peran petugas |
| Token sesi (rencana) | Rahasia autentikasi | Mempertahankan sesi | Lokal: secure storage | Hingga logout, kedaluwarsa, atau pencabutan | Rencana: penyimpanan aman; tanpa token di log/repo |
| Hash PIN, salt acak, dan status PIN (rencana) | Turunan kredensial | Verifikasi PIN tanpa menyimpan PIN asli | Lokal: secure storage | Hingga PIN diganti/dihapus atau data aplikasi dihapus | Rencana: PBKDF2, salt acak, dan batas percobaan |
| Permintaan konsultasi: pasien, layanan, jadwal, petugas, dan status (rencana) | Spesifik jika terkait layanan kesehatan | Mengajukan jadwal sesi sesuai charter | Lokal saat simulasi; cloud pada M05 | Data uji hingga pengujian selesai; retensi operasional menunggu klinik | Rencana: akses pasien pemilik dan petugas berwenang; tanpa penyimpanan percakapan |
| Pengenal acak QR (rencana; QR sekarang berupa pola demo) | Umum jika terhubung ke pasien | Check-in kartu pasien | Lokal; pemetaan cloud pada M05 | Hingga kartu dicabut/diganti; batas validitas token ditetapkan sebelum implementasi | Rencana: QR tanpa diagnosis/kredensial; akses pemetaan memerlukan izin |
| Versi kebijakan, ID akun, waktu, dan pilihan persetujuan (rencana) | Umum; terkait pemrosesan kesehatan | Mencatat pilihan dan penarikannya | Lokal saat simulasi; cloud pada M05 | Data uji hingga pengujian selesai; retensi operasional menunggu pengelola | Rencana: akses terbatas dan penarikan persetujuan per tujuan |

Memulai ulang aplikasi tidak menghapus contoh dalam kode, APK, atau riwayat Git. Sebelum memakai cloud, tim memperbarui lokasi, penerima data, retensi, dan perlindungan dalam R1 serta R6. Retensi rekam medis operasional memerlukan keputusan pengelola klinik; tim tidak menetapkan angka tanpa dasar. Bukti uji harus memakai data sintetis atau tersamarkan; tim meninjau kebutuhan arsip setelah penilaian semester selesai.

## Tidak Dikumpulkan (konfirmasi eksplisit)

- [x] Lokasi GPS.
- [x] ID perangkat untuk pelacakan.
- [x] Buku kontak perangkat.
- [x] Foto/video dari kamera; aset gambar aplikasi bukan hasil kamera pengguna. Tim meninjau izin kamera sebelum menambah pemindai QR.
- [x] Data pasien nyata, NIK, dan dokumen identitas resmi.
- [x] Foto wajah, sidik jari, dan templat biometrik mentah.
- [x] Rekaman suara, data pembayaran, dan rekening bank.
- [x] Kontak darurat; tim menunda nama, hubungan, dan nomor telepon sampai kebutuhan layanan jelas.
- [x] Token sesi nyata pada M01; backend autentikasi belum terhubung.

## Requirement yang Lahir dari Register Ini

- PRV-01: Tim membatasi data pada kebutuhan fitur, memakai data sintetis, dan meninjau penambahan jenis data.
- PRV-02: Tim tidak memakai SDK analitik/iklan pihak ketiga yang mengumpulkan data pengguna dan meninjau dependensi sebelum rilis.
- PRV-03: Pengguna dapat menghapus data uji lokal; tim menjelaskan batas retensi sebelum penggunaan operasional.
- PRV-05: Tim menjelaskan data, tujuan, lokasi, akses, retensi, dan kontak dalam kebijakan privasi sesuai versi aplikasi.
- SEC-01: Tim menyimpan kredensial/token dalam secure storage dan menetapkan perlindungan data kesehatan sebelum persistensi.
- SEC-02: Tim mengganti PIN demo dengan PBKDF2 dan salt acak serta membatasi percobaan verifikasi.
- SEC-05: Tim memakai HTTPS saat integrasi dan memverifikasi larangan HTTP sebelum koneksi cloud aktif.

