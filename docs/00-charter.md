# Charter — Klinik UAD
# Topik: Klinik
# Kelompok: Klinik UAD Anggota: Naufal Adna Garibaldi, Sagara Imam Samudra, MHD Rafy Firdaus, Mohamad Arief Gunadi

## Visi

Membantu sivitas akademika UAD mendaftar layanan klinik, memantau antrean, dan mengakses riwayat kesehatan dengan menjaga privasi pasien.

## Tujuan Terukur

1. Mengurangi waktu pendaftaran pasien minimal 50% dibanding alur manual (ukur: perbandingan waktu penyelesaian skenario pendaftaran yang sama dalam simulasi).
2. Menampilkan perubahan nomor antrean maksimal 3 detik setelah petugas memperbaruinya (ukur: selisih waktu pembaruan petugas dan tampilan pasien pada koneksi internet stabil).
3. Menyelesaikan prototipe lima fitur utama dalam 16 minggu (ukur: tim menjalankan skenario uji booking, rekam medis, pengingat, pengajuan konsultasi, dan profil/kartu pasien).

## Pengguna Sasaran

Mahasiswa, dosen, dan tenaga kependidikan sebagai pasien; dokter/konselor, perawat, dan admin sebagai petugas. Tim mengusulkan uji awal dengan 5 pengguna simulasi pada Android. Jumlah pengguna operasional menunggu konfirmasi pihak klinik.

## Scope

### Must (wajib ada)

- Booking poli, dokter, dan jadwal beserta nomor dan pemantauan antrean.
- Riwayat kunjungan, diagnosis, dan alergi dengan pembatasan akses serta PIN.
- Pengingat lokal minum obat dan jadwal kontrol.
- Pengajuan sesi konseling atau konsultasi awal dengan akses terbatas.
- Profil kesehatan dan kartu pasien digital untuk check-in.
- Autentikasi berbasis peran, informasi privasi, dan persetujuan pengguna yang relevan.

### Won't (tidak dikerjakan sekarang)

- Rilis dan pengujian iOS.
- Integrasi SSO kampus, BPJS, atau sistem rumah sakit eksternal.
- Pembayaran daring dan diagnosis otomatis.
- Penggunaan data pasien nyata serta penerapan sebagai sistem klinik operasional.

## Batasan

Empat mahasiswa mengembangkan prototipe selama 16 minggu menggunakan Flutter, perangkat Android tim, dan Supabase Free Tier. Pada M01, tim memakai data sintetis lokal; integrasi cloud menyusul pada tahap API. Tim perlu memperoleh konfirmasi sebelum melibatkan klinik atau unit TI kampus.

## Risiko Awal

- Kebocoran data kesehatan: kemungkinan meningkat jika tim salah mengatur akses; dampak sangat tinggi. Tim memakai data sintetis, penyimpanan aman, dan pembatasan akses per peran.
- Keterlambatan pengerjaan: kemungkinan sedang karena lingkup fitur dan beban kuliah; dampak tinggi. Tim membagi modul dan meninjau progres mingguan.
- Gangguan jaringan atau izin notifikasi: mungkin terjadi pada perangkat uji; dampaknya antrean terlambat dan pengingat terlewat. Tim menguji izin serta menyediakan pembaruan antrean manual.

## Kriteria Sukses

Tim menuntaskan lima fitur utama dalam 16 minggu, membuktikan dua target waktu melalui pengujian, dan menguji akses sesuai peran. Tim menjalankan aplikasi di Android, menyelesaikan pemeriksaan kode tanpa masalah, serta menyimpan dokumen kepatuhan dan bukti pengujian di repo. Untuk M01, tim melengkapi fondasi kode, enam register, katalog kebutuhan, dan bukti keamanan sebelum membuat tag `m01-initiation`.
