# R2 · Matriks Etika
# Kode etik yang digunakan: ACM dan IEEE-CS

| Sumber | Prinsip | Risiko di Aplikasi Kami | Kontrol (ID) |
|--------|---------|------------------------|--------------|
| ACM 1.6 | Hormati privasi | Tim meminta identitas, kontak darurat, atau informasi kesehatan yang tidak diperlukan untuk fitur. | PRV-01: minimisasi data dan penggunaan data sintetis sesuai R1. |
| ACM 1.7 | Jaga kerahasiaan | Admin atau petugas tanpa hubungan pelayanan membaca diagnosis, alergi, atau informasi konseling pasien. | SEC-07: akses berdasarkan peran, kepemilikan, dan hubungan pelayanan; SEC-01: perlindungan penyimpanan; SEC-02: PIN dengan KDF. |
| ACM 1.3 | Jujur dan tepercaya | Penguji menganggap enkripsi, antrean realtime, atau pesan konsultasi sudah berfungsi karena klaim pada layar simulasi. | PRV-05: informasi privasi sesuai versi; UX-04: label simulasi dan klaim sesuai bukti. |
| ACM 2.5 | Evaluasi sistem, dampak, dan risiko | Tim menganggap kunci PIN lokal atau build berhasil cukup membuktikan keamanan rekam medis. | SEC-03: baseline konfigurasi dan bukti pemeriksaan; SEC-01 dan SEC-02: uji penyimpanan serta PIN; penilaian risiko melalui R4. |
| IEEE-CS 1.03 | Nilai keamanan dan dampak terhadap publik sebelum menyetujui perangkat lunak | Penguji menganggap contoh diagnosis/resep sebagai anjuran medis atau layanan resmi klinik. | PRV-01: data sintetis; UX-04: label prototipe akademik dan batas layanan. |
| IEEE-CS 3.10 | Uji, perbaiki, dan tinjau perangkat lunak serta dokumen | Aplikasi menampilkan booking berhasil meskipun belum menyimpan jadwal; dokumen menyatakan kontrol yang belum berjalan. | SEC-08: validasi input dan penanganan kegagalan penyimpanan; UX-04: hasil sesuai operasi dan status simulasi. |

## Catatan: Risiko Khas Topik Ini

- Klinik: data medis tunduk pada kerangka UU PDP, UU Kesehatan, dan aturan rekam medis. Tim perlu memeriksa ketentuan operasional bersama pengelola klinik sebelum memakai pasien nyata; dokumen ini tidak menyatakan kepatuhan hukum telah terpenuhi.
- Pasien hanya membaca data miliknya. Dokter/konselor mengakses pasien yang ditangani; perawat mengakses informasi yang diperlukan untuk pelayanan. Admin mengelola identitas, jadwal, dan antrean tanpa membaca isi diagnosis, resep, atau konseling.
- SEC-07 mengharuskan pemeriksaan izin pada sumber data di M05; menyembunyikan halaman saja tidak cukup. Pengguna tidak boleh menetapkan peran petugas sendiri.
- Tim membatasi konsultasi pada pengajuan jadwal. Chat yang sudah ada merupakan simulasi; tim menunda pengiriman dan penyimpanan percakapan. Penguji memakai identitas serta keluhan sintetis, tanpa kredensial kampus atau data medis pribadi.
- PIN lokal kini memakai PBKDF2, salt acak, secure storage, dan batas percobaan. Tim menyimpan hasil pemeriksaan APK di `evidence/`; uji manual aplikasi dan pemeriksaan penyimpanan native di Android masih menunggu perangkat. Login, akses per peran, dan enkripsi basis data medis belum tersedia.
- SEC-03 mencakup backup Android nonaktif, lint `avoid_print`, dan larangan mencetak data sensitif. SEC-08 mencakup validasi pada batas penerimaan data serta pesan keberhasilan berdasarkan hasil penyimpanan. UX-04 mencakup penandaan simulasi dan klaim sesuai implementasi. Tim memakai ID yang sama pada R4, R5, dan katalog kebutuhan.
