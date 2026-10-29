# Panduan Uji Manual Keamanan M01 · Klinik UAD

Coba langkah berikut langsung melalui aplikasi di HP/emulator. Gunakan identitas fiktif dan PIN uji. Panduan ini tidak memerlukan penulisan kode atau perintah terminal. Catat hasil aktual; langkah di bawah belum berarti aplikasi sudah lulus uji manual.

## 1. Periksa pilihan login

1. Buka aplikasi dan pilih Login.
2. Periksa pilihan Ingat saya sebelum menyentuhnya.
3. Harapan: pilihan belum tercentang.
4. Masuk memakai data fiktif yang lolos formulir. Login masih simulasi, jadi tidak memerlukan akun kampus.

## 2. Buat PIN dan coba konfirmasi berbeda

1. Buka tab Records. Pada instalasi yang belum memiliki PIN, aplikasi menampilkan Buat PIN Rekam Medis.
2. Masukkan PIN uji `8246`.
3. Saat diminta mengulang, masukkan `7319`.
4. Harapan: pesan PIN tidak sama muncul dan rekam medis tetap tertutup.
5. Buat ulang dengan memasukkan `8246` dua kali.
6. Harapan: aplikasi meminta PIN untuk membuka Records; pembuatan PIN tidak langsung membuka data.

Jika PIN sudah pernah dibuat, gunakan PIN tersebut untuk pengujian berikutnya. Aplikasi tidak menyediakan PIN bawaan `1234`.

Setelah sinkronisasi main: instalasi baru meminta pembuatan PIN. Instalasi lama dengan ID `id.ac.uad.klinik_uad` tetap menerima PIN yang sebelumnya dibuat main, termasuk `1234` bila dulu dibuat otomatis. Aplikasi meningkatkan hash setelah PIN benar; tidak mereset PIN. Bukti screenshot sebelumnya berasal dari `com.example.flutter_application_1`, sehingga uji ulang dilakukan pada aplikasi dengan ID terbaru. Data kedua ID aplikasi tidak saling terbagi.

## 3. Coba PIN salah dan PIN benar

1. Masukkan `0000` satu kali.
2. Harapan: aplikasi menampilkan PIN salah dan tidak membuka rekam medis.
3. Masukkan `8246`, atau PIN yang sebelumnya kamu buat.
4. Harapan: contoh rekam medis tampil.
5. Tekan ikon kunci di kanan atas.
6. Harapan: aplikasi kembali meminta PIN.
7. Coba tekan ikon sidik jari pada layar PIN.
8. Harapan: ikon tidak membuka data; fitur biometrik belum tersedia.

## 4. Coba batas lima kesalahan

1. Setelah berhasil membuka Records pada langkah sebelumnya, kunci kembali layarnya. Keberhasilan tadi mereset jumlah kesalahan.
2. Masukkan PIN salah sebanyak lima kali. Tunggu proses setiap percobaan selesai.
3. Harapan: kesalahan kelima memunculkan pesan Terlalu banyak percobaan beserta waktu tunggu.
4. Segera masukkan PIN benar.
5. Harapan: rekam medis tetap tertutup selama masa penguncian.
6. Tunggu lebih dari 30 detik sejak pesan penguncian muncul, lalu masukkan PIN benar.
7. Harapan: rekam medis terbuka kembali.

Angka detik menunjukkan sisa waktu saat percobaan, bukan hitung mundur yang bergerak sendiri.

## 5. Coba tutup paksa saat terkunci

1. Setelah berhasil membuka Records, kunci kembali lalu masukkan PIN salah lima kali.
2. Segera buka Pengaturan Android > Aplikasi > Klinik UAD > Paksa berhenti. Pilih Paksa berhenti, bukan Hapus data.
3. Buka kembali aplikasi, masuk, lalu buka Records dan masukkan PIN benar sebelum 30 detik habis.
4. Harapan: penguncian tetap berlaku selama waktunya belum habis.
5. Setelah lewat 30 detik, coba PIN benar lagi. Harapan: akses terbuka.

Jika 30 detik sudah habis sebelum kamu selesai membuka ulang aplikasi, ulangi pengujian. PIN benar yang diterima setelah waktunya habis merupakan hasil yang sesuai.

## 6. Coba PIN setelah aplikasi dibuka ulang

1. Setelah akses berhasil, tutup paksa aplikasi melalui pengaturan Android.
2. Buka kembali aplikasi, masuk, lalu buka Records.
3. Harapan: aplikasi meminta PIN lama, bukan membuat PIN baru.
4. Masukkan PIN lama. Harapan: rekam medis terbuka.

## 7. Coba pindah tab dan meninggalkan aplikasi

1. Buka Records dengan PIN benar.
2. Pindah ke Home atau Profile, lalu kembali ke Records. Harapan: PIN diminta lagi.
3. Buka Records kembali, tekan tombol Home Android, lalu kembali ke aplikasi. Harapan: PIN diminta lagi.
4. Ulangi dengan membuka daftar aplikasi terbaru dan mengunci layar HP. Setelah kembali, Records harus terkunci.
5. Saat verifikasi PIN masih berjalan, segera pindah tab atau tinggalkan aplikasi. Setelah kembali, hasil verifikasi lama tidak boleh membuka Records.

Baseline belum melarang screenshot atau menyembunyikan gambar aplikasi pada daftar aplikasi terbaru.

## 8. Catat hasil

Catat perangkat, versi Android, tanggal, langkah yang dicoba, hasil aktual, dan status lulus/gagal. Ambil screenshot pesan kesalahan atau penguncian jika perlu; gunakan data sintetis dan jangan menampilkan PIN pribadi.

Mencoba layar aplikasi bisa membuktikan perilaku PIN dan penguncian. Pemeriksaan enkripsi penyimpanan, hash/salt, larangan HTTP, backup, dan izin APK membutuhkan pemeriksaan teknis terpisah. Jangan menandai kontrol tersebut lulus hanya karena layar PIN berfungsi. Perubahan/penghapusan PIN lewat tombol aplikasi, autentikasi akun, dan akses per peran belum tersedia.

## Jika lupa PIN uji

**Hapus data melalui Pengaturan Android > Aplikasi > Klinik UAD > Penyimpanan akan menghapus PIN beserta data lokal aplikasi secara permanen. Lakukan hanya pada instalasi uji dengan data yang boleh dibuang.** Setelah itu buka aplikasi dan buat PIN baru. Contoh bawaan APK tetap tersedia. Menutup paksa atau membuka ulang aplikasi tidak mereset PIN.
