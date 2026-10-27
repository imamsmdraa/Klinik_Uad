# Alur Pengguna & Sketsa Antarmuka (Wireframe Flows)
**Proyek:** Klinik UAD — Layanan Kesehatan & Rekam Medis Kampus  

---

## 1. Diagram Alur Pengguna (User Journey)

### Alur A: Pendaftaran Antrean Poliklinik
```text
[Layar Utama / Beranda]
        │
        ▼ (Tekan "Ambil Antrean")
[Pilih Poliklinik] (Poli Umum / Gigi / Psikologi)
        │
        ▼ (Pilih Dokter Aktif)
[Pilih Jadwal & Jam Pemeriksaan]
        │
        ▼ (Isi Keluhan Singkat)
[Konfirmasi Pemesanan & Informed Consent]
        │
        ▼ (Tekan "Konfirmasi & Ambil Nomor")
[Tiket Antrean Digital Terbit] (No Antrean: A-012)
        │
        ▼
[Layar Monitoring Antrean Realtime]
```

### Alur B: Akses Rekam Medis Terproteksi PIN
```text
[Menu Beranda / Rekam Medis]
        │
        ▼ (Pilih Riwayat Pemeriksaan)
[Layar Proteksi PIN Medis]
        │
        ├── Salah PIN -> [Pesan Error & Getar, Kesempatan Berkurang]
        │
        └── Sukses PIN
                │
                ▼
        [Layar Detail Rekam Medis]
        - Tanggal & Dokter Pemeriksa
        - Diagnosis Utama (ICD-10)
        - Catatan Keluhan Pasien
        - Resep Obat & Aturan Pakai
```

---

## 2. Struktur Tata Letak Layar Kunci (Wireframe Layout)

### Layar Beranda (Home Dashboard)
```text
┌──────────────────────────────────────────────┐
│ [Logo UAD]  Klinik UAD        [Notif] [Akun] │
│ Halo, Naufal Adna (2311016061)               │
├──────────────────────────────────────────────┤
│ ┌──────────────────────────────────────────┐ │
│ │ KARTU STATUS ANTREAN HARI INI            │ │
│ │ Poli Umum - dr. Hendra Pratama           │ │
│ │ Nomor Anda: A-012                        │ │
│ │ Sedang Dilayani: A-008  (Estimasi 15 mnt)│ │
│ └──────────────────────────────────────────┘ │
├──────────────────────────────────────────────┤
│ LAYANAN UTAMA                                │
│ [ 🏥 Booking Poli ]    [ 📋 Rekam Medis ]    │
│ [ 💊 Pengingat Obat]   [ 💬 Konseling   ]    │
├──────────────────────────────────────────────┤
│ PENGINGAT HARI INI                           │
│ • Paracetamol 500mg - 12:00 WIB (Setelah mkn)│
│ • Kontrol Poli Gigi - Kamis, 14:00 WIB       │
└──────────────────────────────────────────────┘
```

### Layar Kartu Pasien Digital (Digital Medical Card)
```text
┌──────────────────────────────────────────────┐
│ <- Kembali             Kartu Pasien Digital  │
├──────────────────────────────────────────────┤
│ ┌──────────────────────────────────────────┐ │
│ │ KLINIK UNIVERSITAS AHMAD DAHLAN          │ │
│ │ [Foto]  NAUFAL ADNA GARIBALDI            │ │
│ │         NIM: 2311016061                  │ │
│ │         Golongan Darah: O                │ │
│ │         ─────────────────────────        │ │
│ │         [    KODE QR CHECK-IN   ]        │ │
│ │         [      TERENKRIPSI      ]        │ │
│ │         Pindai di Meja Resepsionis       │ │
│ └──────────────────────────────────────────┘ │
│ [ Tombol Unduh PDF ]    [ Tombol Segarkan QR]│
└──────────────────────────────────────────────┘
```
