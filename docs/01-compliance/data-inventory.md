# R1 · Inventaris Data Pribadi

- **Aplikasi:** Klinik UAD
- **Topik:** Klinik
- **Kelompok:** Klinik UAD
- **Versi:** M01, 26 Oktober 2026

## Cakupan dan Kondisi M01

Tim memakai data sintetis untuk prototipe akademik. Tim belum menghubungkan aplikasi ke Supabase atau memakai data pasien nyata. Nama dan identitas pada layar contoh harus merujuk pada tokoh fiktif; tim perlu memastikan asal data sebelum membagikan prototipe.

Kode saat ini memuat contoh profil, jadwal, rekam medis, pengingat, dan percakapan. Pengguna juga dapat mengetik identitas login, kata sandi, PIN, serta pesan simulasi. Penguji harus memakai nilai uji, bukan kredensial kampus atau keluhan kesehatan pribadi.

Kategori UU PDP pada tabel menunjukkan perlakuan yang tim perlukan jika data merujuk pada orang nyata. Sebutan data sintetis tidak menghapus kewajiban tim untuk memeriksa asal contoh dan membatasi input penguji.

## Inventaris Data M01

| Data | Kategori UU PDP | Tujuan | Lokasi simpan | Retensi | Perlindungan |
|------|-----------------|--------|---------------|---------|--------------|
| Nama pasien, NIM, status sivitas, dan ID kartu pasien contoh | Umum: identitas pribadi | Menampilkan profil dan mengaitkan pasien dengan layanan | Kode sumber dan memori aplikasi | Contoh tetap ada di repo/APK hingga tim mengubah kode; lihat aturan retensi | Tim wajib memakai identitas fiktif; pembatasan akses belum tersedia |
| Nama dokter/konselor, poli, ruang, dan jadwal praktik contoh | Umum jika mengidentifikasi tenaga kesehatan | Menampilkan pilihan layanan | Kode sumber dan memori aplikasi | Selama contoh masih ada dalam kode | Tim memakai profil petugas fiktif; jadwal bukan informasi layanan resmi |
| Booking dan antrean: pasien, dokter, poli, tanggal, jam, nomor, status, dan estimasi | Berpotensi spesifik ketika mengungkap penggunaan layanan kesehatan | Menyimulasikan pendaftaran dan pemantauan antrean | Nilai contoh dalam kode; pilihan pengguna dalam memori halaman | Pilihan sementara hingga halaman dibuat ulang atau proses berakhir; nilai contoh tetap di repo/APK | Tim memakai data sintetis; belum ada penyimpanan booking atau pemeriksaan peran |
| Golongan darah, tinggi, berat, BMI, alergi, riwayat penyakit, dan vaksinasi contoh | Spesifik: data kesehatan | Menampilkan profil kesehatan simulasi | Kode sumber dan memori aplikasi | Selama contoh masih ada dalam kode | Data sintetis; belum ada enkripsi penyimpanan atau kontrol akses medis |
| Kunjungan, diagnosis, gejala, tanda vital, resep, dan hasil laboratorium contoh | Spesifik: data kesehatan | Menyimulasikan akses riwayat pemeriksaan | Kode sumber dan memori aplikasi | Selama contoh masih ada dalam kode | PIN demo hanya membatasi tampilan; tim belum menerapkan perlindungan rekam medis |
| Nama obat, dosis, jadwal, sisa hari, dan status sudah diminum | Spesifik jika terkait dengan pasien | Menyimulasikan pengingat dan pencatatan konsumsi obat | Contoh dalam kode; perubahan status dalam memori halaman | Perubahan hilang saat state halaman dibuat ulang atau proses berakhir; contoh tetap di kode | Tim memakai resep sintetis; belum ada notifikasi lokal atau penyimpanan permanen |
| Contoh percakapan konseling dan pesan yang penguji ketik | Spesifik jika memuat kesehatan atau kondisi psikologis | Menguji tampilan percakapan yang sudah ada | Contoh dalam kode; pesan tambahan dalam memori halaman | Pesan tambahan hilang saat state halaman dibuat ulang atau proses berakhir; contoh tetap di kode | Pesan tidak dikirim ke konselor/server; penguji dilarang memasukkan keluhan pribadi |
| Identitas login dan kata sandi uji | Umum: identitas akun; kata sandi merupakan rahasia autentikasi | Menguji formulir login | Controller formulir dalam memori perangkat | Hingga controller dilepas atau proses berakhir; aplikasi belum menyimpan akun | Tim memakai akun uji; validasi formulir belum membuktikan identitas atau hak akses |
| PIN yang penguji masukkan dan PIN demo tetap | Rahasia autentikasi yang melindungi akses data | Menguji layar kunci rekam medis | Input dalam memori; PIN demo berada dalam kode | Input hingga state direset/proses berakhir; PIN demo tetap di repo/APK | Belum ada hash, salt, penyimpanan aman, atau pembatasan percobaan; jangan gunakan PIN pribadi |

## Aturan Retensi Prototipe

- Tim tidak menyimpan input penguji ke server atau basis data pada M01. Penutupan halaman hanya menghapus input jika aplikasi melepas state/controller terkait; memulai ulang proses menghapus state memori.
- Memulai ulang aplikasi tidak menghapus contoh dalam kode, repo, atau APK. Tim hanya boleh memasukkan data sintetis ke berkas tersebut.
- Jika tahap berikutnya memakai penyimpanan lokal, tim menyediakan penghapusan data uji dan menjalankannya setelah sesi pengujian selesai.
- Tim menyimpan bukti pengujian yang sudah disamarkan sampai penilaian semester selesai, lalu meninjau kebutuhan arsip. Bukti tidak boleh memuat kredensial atau identitas pasien nyata.

## Rencana Data Tahap Berikutnya

Tabel berikut berisi keputusan rancangan, bukan kontrol yang sudah tim terapkan. Tim memperbarui inventaris sebelum mengaktifkan pengumpulan atau pengiriman data.

| Data | Kategori UU PDP | Tujuan | Lokasi simpan | Retensi | Perlindungan yang direncanakan |
|------|-----------------|--------|---------------|---------|-------------------------------|
| Email, ID akun, dan peran pengguna | Umum: identitas akun | Login serta pembatasan layanan pasien/petugas | Supabase pada tahap API | Akun uji hingga pengujian selesai; retensi operasional menunggu keputusan pengelola | Verifikasi akun, pembatasan akses per peran, dan HTTPS; pasien tidak boleh menetapkan peran petugas |
| Token sesi | Rahasia autentikasi | Mempertahankan sesi pengguna | Penyimpanan aman perangkat | Hingga logout, kedaluwarsa, atau pencabutan sesi | Penyimpanan aman; tim tidak menulis token ke log atau repo |
| Hash PIN, salt acak, dan status PIN | Turunan kredensial | Memverifikasi PIN tanpa menyimpan PIN asli | Penyimpanan aman perangkat | Hingga pengguna mengganti/menghapus PIN atau menghapus data aplikasi | PBKDF2 dengan salt acak, batas percobaan, dan penghapusan PIN demo |
| Permintaan konsultasi: ID pasien, layanan, jadwal, petugas, dan status | Spesifik jika terkait layanan kesehatan | Mengajukan sesi sesuai charter | Memori/lokal saat simulasi; Supabase setelah integrasi | Data uji hingga pengujian selesai; retensi operasional menunggu keputusan klinik | Akses pasien pemilik dan petugas berwenang; tim menunda penyimpanan percakapan |
| Pengenal acak untuk QR kartu pasien | Umum jika dapat dihubungkan ke pasien | Menghubungkan check-in dengan kartu pasien | Perangkat; pemetaan pada backend setelah integrasi | Hingga kartu dicabut atau diganti; token check-in mengikuti batas validitas yang tim tetapkan sebelum implementasi | QR tidak memuat diagnosis atau kredensial; petugas memerlukan izin untuk mengakses pemetaan |
| Versi kebijakan dan catatan persetujuan: ID akun, waktu, pilihan | Umum; terkait pemrosesan data kesehatan | Mencatat pilihan pengguna | Lokal saat simulasi; backend setelah integrasi | Data uji hingga pengujian selesai; retensi operasional perlu penetapan pengelola | Tim membatasi akses catatan dan menyediakan penarikan persetujuan untuk fitur opsional |

Sebelum mengirim profil, booking, atau rekam medis ke cloud, tim menetapkan lokasi layanan, penerima data, hak akses, retensi, dan prosedur penghapusan. Tim menyelaraskan keputusan tersebut dengan R3 dan R6. Tim tidak menjanjikan penghapusan rekam medis operasional sebelum pengelola klinik menetapkan prosedur retensinya.

## Tidak Dikumpulkan dalam M01

- [x] Data pasien nyata, NIK, dan dokumen identitas resmi.
- [x] Lokasi GPS, ID perangkat untuk pelacakan, dan buku kontak.
- [x] Foto wajah, sidik jari, atau templat biometrik mentah.
- [x] Rekaman suara, video, dan foto dari kamera perangkat. Gambar aset aplikasi bukan hasil pengambilan kamera pengguna.
- [x] Data pembayaran dan rekening bank.
- [x] Nama, nomor telepon, dan hubungan kontak darurat; tim menunda fitur ini sampai kebutuhan layanan jelas.
- [x] Token sesi autentikasi nyata; aplikasi belum terhubung ke layanan autentikasi.

Tim belum memakai SDK analitik atau iklan dalam dependensi aplikasi. Jika tim menambah pemindai QR, tim meninjau kebutuhan izin kamera dan memperbarui inventaris sebelum meminta izin pengguna.

## Requirement yang Lahir dari Register Ini

| ID | Requirement | Target | Status M01 |
|----|-------------|--------|------------|
| PRV-01 | Tim membatasi data pada kebutuhan fitur, memakai data sintetis untuk pengujian, dan meninjau setiap penambahan kolom data. | M01–M05 | Keputusan terdokumentasi; asal contoh dan input penguji perlu pemeriksaan |
| PRV-02 | Tim tidak menambahkan SDK analitik/iklan yang mengumpulkan data pengguna; tim meninjau dependensi sebelum rilis. | M01–M05 | Belum ada SDK tersebut dalam dependensi; peninjauan rilis masih perlu bukti |
| PRV-03 | Tim menyediakan penghapusan data uji lokal dan menjelaskan pengecualian retensi sebelum penggunaan operasional. | M04–M05 | Belum tersedia |
| PRV-05 | Tim menjelaskan data, lokasi, akses, dan retensi dalam kebijakan privasi yang sesuai versi aplikasi. | M03–M05 | Kebijakan R6 belum tersedia |
| SEC-01 | Tim menyimpan kredensial dan token pada penyimpanan aman serta menetapkan perlindungan data kesehatan sebelum persistensi. | M01, dilengkapi M04–M05 | Belum tersedia |
| SEC-02 | Tim mengganti PIN demo dengan hash PBKDF2 dan salt acak, serta membatasi percobaan verifikasi. | M01 | Belum tersedia |
| SEC-05 | Tim memakai HTTPS untuk komunikasi backend dan memverifikasi larangan HTTP sebelum integrasi cloud. | M01–M05 | Koneksi backend belum aktif; konfigurasi masih perlu verifikasi |

Tim memakai ID yang sama pada R2–R6 dan katalog kebutuhan. Daftar ini memuat kebutuhan yang berasal dari R1; katalog akan menampung kebutuhan register lain.
