# R2 · Matriks Etika

- **Aplikasi:** Klinik UAD
- **Topik:** Klinik
- **Kelompok:** Klinik UAD
- **Versi:** M01, 26 Oktober 2026
- **Kode etik:** ACM Code of Ethics and Professional Conduct (2018) serta Software Engineering Code of Ethics and Professional Practice (IEEE-CS/ACM, versi 5.2).

## Dasar Penyusunan

Tim mengembangkan prototipe akademik sesuai [charter](../00-charter.md) dan [inventaris data R1](data-inventory.md). Tim memakai identitas serta data kesehatan sintetis. Penguji tidak boleh memasukkan kredensial kampus, identitas pasien nyata, atau keluhan pribadi.

Tim membatasi fitur konsultasi pada pengajuan jadwal sesi. Percakapan pada tampilan saat ini merupakan simulasi; tim menunda pengiriman dan penyimpanan riwayat chat.

Tim merangkum prinsip dalam bahasa Indonesia pada tabel berikut. Risiko dan kontrol merupakan penerapan tim untuk Klinik UAD, bukan kutipan kode etik. Sebutan IEEE-CS merujuk pada kode rekayasa perangkat lunak yang disusun bersama ACM, berbeda dari ACM Code of Ethics (2018).

## Matriks Prinsip, Risiko, dan Kontrol

| Sumber | Prinsip | Risiko di Aplikasi Kami | Kontrol (ID) |
|--------|---------|------------------------|--------------|
| ACM 1.6 | Hormati privasi | Tim meminta identitas, kontak darurat, atau informasi kesehatan yang tidak diperlukan untuk fitur. | PRV-01: tim membatasi data sesuai R1 dan memakai data sintetis. PRV-05: tim menjelaskan tujuan, lokasi, akses, dan retensi dalam kebijakan privasi. |
| ACM 1.7 | Jaga kerahasiaan | Admin atau petugas yang tidak menangani pasien membaca diagnosis, alergi, atau informasi konseling. Orang lain membuka data melalui perangkat pasien. | SEC-07: tim membatasi akses berdasarkan peran dan hubungan pelayanan. SEC-01 dan SEC-02: tim melindungi penyimpanan sensitif dan mengganti PIN demo dengan verifikasi PIN yang aman. |
| ACM 1.3 | Bersikap jujur dan dapat dipercaya | Penguji mengira fitur sudah terenkripsi, mengirim pesan ke konselor, atau mengambil antrean realtime karena teks keberhasilan pada layar. | UX-04: tim menandai simulasi dan menyesuaikan klaim dengan bukti implementasi. PRV-05: kebijakan privasi menjelaskan kondisi versi yang pengguna jalankan. |
| ACM 2.5 | Evaluasi sistem, dampak, dan risikonya | Tim menganggap tampilan kunci PIN atau keberhasilan build sebagai bukti keamanan, lalu melewatkan pemeriksaan penyimpanan dan akses. | Tim menilai risiko melalui R4 dan menyimpan bukti pemeriksaan SEC-01, SEC-02, dan SEC-03. Tim mencatat kontrol yang belum tersedia sebagai rencana, lalu mengujinya sebelum rilis terkait. |
| IEEE-CS 1.03 | Setujui perangkat lunak setelah menilai keamanan, spesifikasi, pengujian, dan dampaknya terhadap publik | Penguji menganggap contoh diagnosis atau resep sebagai anjuran medis dan mengira prototipe merupakan layanan resmi klinik. | UX-04: tim memberi label prototipe akademik dan data sintetis. PRV-01: tim tidak memakai pasien nyata; penerapan operasional berada di luar lingkup semester ini. |
| IEEE-CS 3.10 | Lakukan pengujian, perbaikan, dan peninjauan perangkat lunak serta dokumennya | Pasien mendapat pesan booking berhasil meskipun aplikasi belum menyimpan jadwal; dokumen menyebut perlindungan yang belum ada dalam kode. | SEC-08: tim memvalidasi input, menguji penyimpanan, dan menampilkan hasil sesuai operasi. UX-04: selama fitur masih simulasi, tim menyatakan status tersebut. Anggota lain meninjau kecocokan kode, dokumen, dan hasil uji. |

## Batas Akses yang Disepakati

| Peran | Akses yang Direncanakan | Batas |
|-------|------------------------|-------|
| Pasien | Membaca profil, booking, dan rekam medis miliknya; mengajukan layanan. | Tidak mengakses data pasien lain atau mengubah diagnosis/resep petugas. Koreksi catatan klinis mengikuti prosedur klinik. |
| Dokter/konselor | Membaca data pasien yang ditangani dan mencatat hasil pelayanan sesuai kewenangan. | Tidak memperoleh akses ke pasien atau catatan konseling di luar hubungan pelayanan dan kewenangannya. |
| Perawat | Membaca informasi yang diperlukan untuk pelayanan, memproses check-in, dan mencatat tanda vital. | Tidak memperoleh akses penuh ke diagnosis atau isi konseling melalui peran perawat. |
| Admin | Mengelola identitas administratif, petugas, jadwal, booking, dan antrean. | Tidak membaca isi diagnosis, resep, atau catatan konseling melalui peran admin. |

Tim belum menerapkan kontrol akses tersebut. Pada integrasi backend, tim harus memeriksa izin pada sumber data; menyembunyikan tombol atau halaman saja tidak cukup. Tim memisahkan data administratif dari isi medis agar admin dapat mengelola layanan tanpa memperoleh isi rekam medis.

## Requirement dan Bukti yang Diperlukan

ID PRV-01, PRV-05, SEC-01, dan SEC-02 mengikuti R1. SEC-03 mengikuti baseline M01 pada panduan dosen. Tim menambahkan SEC-07, SEC-08, dan UX-04 untuk kebutuhan berikut; ID yang sama harus dipakai pada R4, R5, dan katalog kebutuhan jika relevan.

| ID | Requirement | Target | Bukti yang Harus Disiapkan |
|----|-------------|--------|---------------------------|
| SEC-03 | Tim menonaktifkan backup Android, mengaktifkan lint `avoid_print`, dan memastikan kode produksi tidak mencetak data sensitif. | M01 | Konfigurasi, hasil pemeriksaan kode, dan pemeriksaan output yang disamarkan. |
| SEC-07 | Tim membatasi data berdasarkan peran, kepemilikan, dan hubungan pelayanan; pengguna tidak boleh menetapkan peran petugas sendiri. | M04 simulasi; M05 penegakan backend | Uji pasien A terhadap data pasien B; uji dokter di luar hubungan pelayanan; uji admin terhadap isi medis. Pada M05, sertakan bukti penolakan langsung dari sumber data. |
| SEC-08 | Tim memvalidasi input pada batas penerimaan data dan menangani kegagalan penyimpanan tanpa mengklaim keberhasilan. | M04–M05 | Uji input tidak valid, penyimpanan gagal, dan penyimpanan berhasil; pesan hasil harus sesuai kondisi. |
| UX-04 | Tim menandai fitur simulasi dan data sintetis serta hanya menyatakan enkripsi, realtime, pengiriman pesan, atau layanan resmi setelah memiliki bukti pendukung. | M01–M05 | Tinjauan teks layar dan README terhadap implementasi serta hasil uji versi yang sama. |

## Status dan Risiko Khas Klinik

- PIN masih memakai nilai demo `1234`. Formulir login belum memverifikasi identitas melalui layanan autentikasi. Tim belum boleh menyatakan keduanya sebagai kontrol akses operasional.
- Layar rekam medis menyebut akses terenkripsi, sementara refresh antrean menyebut realtime. Tim perlu menyesuaikan teks simulasi atau menyediakan implementasi beserta bukti sebelum membuat klaim tersebut.
- Data kesehatan dan konteks konseling dapat menimbulkan kerugian jika tim mengaitkannya dengan orang nyata. Tim harus memeriksa contoh, tangkapan layar, dan bahan presentasi sebelum memasukkannya ke repo.
- Tim belum membuktikan kontrol dalam matriks melalui pengujian keamanan. Persetujuan atas rancangan akses tidak berarti kontrol tersebut sudah berjalan.

Sebelum menandai kontrol selesai, tim menyimpan bukti di `evidence/` dan meminta satu anggota lain meninjau hasil. Tim tidak memasukkan kredensial atau data pasien nyata ke bukti tersebut.

## Referensi

1. ACM. [ACM Code of Ethics and Professional Conduct (2018)](https://www.acm.org/code-of-ethics), prinsip 1.3, 1.6, 1.7, dan 2.5.
2. IEEE Computer Society/ACM. [Software Engineering Code of Ethics and Professional Practice, versi 5.2](https://www.computer.org/education/code-of-ethics), klausul 1.03 dan 3.10.
