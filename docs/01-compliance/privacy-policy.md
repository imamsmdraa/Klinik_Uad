# Kebijakan Privasi — Klinik UAD

Versi M01 · 29 Oktober 2026 (Data lokal — belum ada server)

## 1. Data yang Kami Simpan

Tim pengembang menyediakan prototipe akademik dengan data sintetis untuk menguji layanan. Contohnya mencakup nama/NIM, status sivitas, ID kartu dan pola QR demo, profil petugas, poli, ruang, jadwal, serta booking/antrean. Contoh kesehatan mencakup golongan darah, tinggi/berat, BMI, alergi, penyakit, vaksinasi, kunjungan, diagnosis, gejala, tanda vital, resep/hasil lab, jadwal dan status konsumsi obat, serta percakapan konseling.

Kamu dapat memasukkan nama, identitas login/email, kata sandi uji, PIN, pilihan jadwal, status konsumsi obat, dan pesan simulasi. Gunakan nilai fiktif, tanpa kredensial kampus atau keluhan pribadi.

Untuk kunci Records, kami menyimpan hash PIN, salt acak, versi format, jumlah iterasi KDF, jumlah percobaan, dan waktu akhir penguncian. Kami tidak menyimpan PIN asli secara permanen. Saat memperbarui versi lama dengan ID aplikasi yang sama, kami mempertahankan PIN lama dan meningkatkan hash setelah verifikasi berhasil.

Kami tidak mengumpulkan data pasien nyata, NIK/dokumen identitas, GPS, ID pelacakan perangkat, buku kontak, kamera, biometrik mentah, rekaman suara, kontak darurat, pembayaran/rekening bank, atau token sesi nyata pada M01. Kami tidak memakai SDK analitik atau iklan yang mengumpulkan data pengguna.

## 2. Di Mana Data Disimpan

Contoh berada dalam berkas aplikasi dan memori perangkatmu. Hash PIN serta metadata keamanannya berada dalam secure storage terenkripsi di perangkat. Input uji lain berada dalam memori. Aplikasi belum mengirim data ke server atau menyimpan akun. Login, pendaftaran, chat, dan booking masih simulasi.

Input dalam memori hilang saat aplikasi melepas halaman terkait atau kamu menghentikan prosesnya. Hash PIN dan metadata tetap ada sampai diganti/dihapus melalui layanan internal atau kamu menghapus data aplikasi. Memulai ulang tidak menghapus contoh bawaan. Riwayat kode dapat menyimpan contoh lama meskipun tim memperbaruinya.

## 3. Siapa yang Bisa Melihat

Orang yang membuka aplikasi di perangkatmu dapat melihat contoh dan input yang masih tampil. Layar Records meminta PIN lokal dan mengunci kembali saat kamu pindah tab atau meninggalkan aplikasi. Kunci ini hanya melindungi tampilan Records: contoh tetap ada dalam kode/APK dan halaman lain. Tim belum menerapkan basis data medis terenkripsi, akun pasien, atau pembatasan akses petugas. Tim masih perlu menguji secure storage pada Android.

Tim dapat melihat layar saat mendampingi pengujian. Kami memakai bukti sintetis/tersamarkan dan meninjau kebutuhan arsip setelah penilaian semester.

## 4. Hakmu

- **Lihat dan ubah:** kamu dapat melihat contoh; edit profil dan permintaan koreksi medis belum tersedia.
- **Salin atau unduh:** ekspor belum tersedia. Hubungi tim untuk bantuan terkait input uji.
- **Hapus:** tombol hapus belum tersedia. Menghentikan proses aplikasi menghilangkan input memori, tetapi hash PIN tetap ada. Menghapus data aplikasi melalui pengaturan Android menghapus hash PIN beserta metadata dan data lokal lain secara permanen; contoh bawaan tetap ada. Penggantian/penghapusan PIN melalui layar aplikasi belum tersedia.
- **Pilihanmu:** pengaturan persetujuan belum tersedia. Kamu dapat berhenti menguji dan menghubungi tim tentang inputmu.

## 5. Perubahan Kebijakan

Sebelum mengirim data ke server, kami akan menjelaskan data, tujuan, penerima, dan masa simpannya, meminta izinmu, serta memperbarui kebijakan ini. Tim perlu menetapkan retensi rekam medis bersama klinik sebelum penggunaan operasional.

Rencana berikutnya mencakup akun/peran, token sesi, permintaan jadwal konsultasi, pengenal QR acak, serta catatan versi kebijakan dan persetujuan. Rencana ini belum aktif pada M01.

## 6. Kontak

2300016055@webmail.uad.ac.id
