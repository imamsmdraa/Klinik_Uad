# R5 · Audit Dark Pattern
# Pertanyaan uji ini dijalankan pada setiap rilis milestone

| Pola | Pertanyaan Uji | Harapan di Aplikasi Kami |
|------|----------------|--------------------------|
| Pre-selected options | Apakah tim mencentang Ingat saya, pengingat obat/kontrol, atau persetujuan opsional sebelum pengguna memilih? | Semua sakelar dan pilihan opsional default MATI. Pengguna mengaktifkannya setelah membaca tujuan masing-masing. |
| Trick questions | Apakah pengguna dapat menafsirkan kalimat pilihan dengan dua arti atau keliru karena negasi ganda? | Tim memakai kalimat positif dengan satu tujuan, misalnya 'Aktifkan pengingat minum obat?'. Tim membedakan izin notifikasi dari persetujuan pemrosesan data kesehatan. |
| Roach motel | Apakah pengguna harus menghubungi CS atau melewati langkah berulang untuk keluar, mematikan fitur, atau menghapus data uji? | Pengguna dapat logout dan mematikan fitur dari pengaturan. Penghapusan data uji lokal memerlukan ≤ 2 ketukan dari Privasi & Data, termasuk konfirmasi, tanpa CS. Tim menjelaskan cakupan penghapusan dan batas retensi rekam medis operasional. |
| Confirmshaming | Apakah teks penolakan menyalahkan pengguna, misalnya 'Saya tidak peduli kesehatan saya'? | Tim memakai teks netral seperti 'Tidak sekarang' atau 'Nonaktifkan pengingat', tanpa menyalahkan pengguna. |
| Privacy zuckering | Apakah pengguna harus mencari beberapa halaman untuk membaca kebijakan, mengekspor data, menarik persetujuan, atau mengajukan penghapusan? | Tim menyediakan satu layar Privasi & Data untuk informasi dan tindakan terkait. Tim menampilkan tujuan, dampak pilihan, dan kontak sebelum pengguna memberikan data. |
| Forced consent pada layanan kesehatan | Apakah pasien harus mengaktifkan pengingat, menyerahkan data tambahan, atau menyetujui tujuan opsional agar bisa memesan jadwal? | Tim memisahkan tujuan opsional dari kebutuhan layanan. Penolakan pengingat tidak menghalangi booking; tim menjelaskan alasan jika layanan memerlukan data tertentu. |
| Klaim keamanan atau layanan yang menyesatkan | Apakah teks membuat penguji mengira PIN demo, chat, enkripsi, antrean realtime, atau booking simulasi sudah menjadi layanan nyata? | Tim memberi label prototipe dan data sintetis. Tim menyatakan keberhasilan sesuai hasil operasi dan hanya memakai klaim keamanan/realtime setelah memiliki bukti. |
| Nagging pada pengingat dan izin | Apakah tim terus meminta izin notifikasi atau mengaktifkan kembali pengingat setelah pengguna menolak? | Tim menghormati pilihan pengguna. Pengguna dapat mengaktifkan kembali fitur melalui pengaturan; tim tidak mengulang permintaan saat membuka halaman lain. |

## Requirement yang Lahir dari Register Ini

- UX-01: Tim menjalankan audit dark pattern pada setiap rilis milestone dan memperbaiki temuan sebelum menyatakan rilis lulus audit.
- UX-02: Fitur opsional default MATI; pengguna dapat menarik persetujuan untuk tujuan terkait dan mematikan fitur tanpa tekanan.
- UX-03: Tim memakai teks ≥ 14sp, kontras AA, serta label aksesibilitas pada kontrol utama; tim menguji pembesaran teks dan pembaca layar.
- UX-04: Tim menandai simulasi dan data sintetis serta menyesuaikan klaim keamanan, realtime, dan hasil operasi dengan bukti implementasi, sesuai R2.

PRV-03 mengatur penghapusan data uji dan batas retensi; PRV-05 mengatur informasi privasi serta kontak, sesuai R1 dan R3. Mematikan pengingat tidak otomatis mencabut persetujuan untuk pemrosesan lain atau menghapus rekam medis.

## Status M01 dan Bukti Audit

Tim baru menyusun pertanyaan dan kriteria audit ini; tim belum menyatakan aplikasi lulus. Dari pembacaan kode, pilihan Ingat saya masih memakai nilai awal `true`. Tim perlu mengubahnya menjadi MATI sebelum memenuhi UX-02. Tim juga perlu meninjau klaim enkripsi pada rekam medis dan klaim keberhasilan fitur simulasi sesuai UX-04.

Pada setiap rilis, satu anggota menjalankan skenario dari kondisi awal aplikasi dan satu anggota lain meninjau hasilnya. Tim mencatat tag/commit, tanggal, penguji, pola, langkah uji, hasil aktual, status lulus/gagal/belum tersedia, dan perbaikan. Fitur yang belum tersedia tidak mendapat status lulus; tim mencantumkan milestone targetnya.

Tim menyimpan catatan dan tangkapan layar dengan data sintetis di `evidence/`. Tim menguji UX-03 bersama audit ini; tabel pertanyaan saja belum membuktikan ukuran teks, kontras, atau aksesibilitas kontrol.
