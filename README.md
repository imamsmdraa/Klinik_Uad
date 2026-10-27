# Klinik UAD — Layanan Kesehatan & Rekam Medis Kampus

Aplikasi mobile berbasis **Flutter** yang mendigitalisasi layanan kesehatan bagi mahasiswa, dosen, dan tenaga kependidikan UAD. Fokus utama:
* Efisiensi antrean
* Enkripsi rekam medis (sesuai UU PDP)
* Kepatuhan pada regulasi UU No. 27/2022

--- 

## Tim Pengembang
| No | Nama | NIM | Peran |
|---|---|---|---|
| 1 | **Naufal Adna Garibaldi** | 2311016061 | Project Manager / Mobile Developer |
| 2 | **Sagara Imam Samudra** | 2300016062 | UI/UX Designer / Frontend Developer |
| 3 | **MHD Rafy Firdaus** | 2300016055 | Backend & Security Analyst |
| 4 | **Mohamad Arief Gunadi** | 2300016031 | QA & Documentation |

--- 

## Fitur Utama
1. **Booking Antrean & Jadwal Dokter Online** – pilih poli (Umum, Gigi, Psikologi), reservasi nomor, lihat estimasi real‑time.  
2. **Rekam Medis Elektronik Terenkripsi** – akses riwayat medis dengan autentikasi PIN/biometrik; data disimpan lokal terenkripsi.  
3. **Pengingat Jadwal & Minum Obat** – notifikasi offline untuk kontrol dan konsumsi obat.  
4. **Konseling & Konsultasi Awal** – layanan kesehatan mental dengan privasi ketat.  
5. **Profil Kesehatan & Kartu Digital** – data pasien, QR‑code untuk check‑in cepat.

--- 

## Struktur Folder Proyek
Proyek mengikuti **Clean Architecture** dan standar M01:
```
Klinik_Uad/
├─ android/               # Konfigurasi Android native
├─ assets/                # Gambar, ikon, background
├─ design/                # Wireframe & token UI/UX
├─ docs/
│  ├─ 00-charter.md       # Project Charter (M01)
│  ├─ 01-compliance/      # Register kepatuhan (UU PDP, OWASP, Etika)
│  ├─ requirements/       # Katalog kebutuhan NFR (PRV, SEC, UX) & use‑cases
│  ├─ design/             # Sistem desain token & flow
│  └─ adr/                # Architecture Decision Records
└─ lib/
   ├─ core/               # Konfigurasi, tema, keamanan dasar
   ├─ features/           # Modul fitur (Clean Architecture)
   ├─ models/             # Entitas data
   ├─ providers/          # State management
   ├─ repositories/       # Abstraksi data
   ├─ routes/             # Navigasi
   ├─ screens/            # Halaman utama
   ├─ services/           # Secure storage, kriptografi PIN
   ├─ shared/             # Widget & tema bersama
   └─ widgets/            # Widget reusable umum
```

---

## Persyaratan Pengembangan
* **Flutter SDK** ≥ 3.11.0 (stable)  
* **Dart SDK** ≥ 3.11.0  
* **Java** OpenJDK 17  
* **Target Android** Min SDK 21, Target SDK 34

---

## Cara Menjalankan Aplikasi
1. **Clone repositori**
   ```bash
   git clone https://github.com/imamsmdraa/Klinik_Uad.git
   cd Klinik_Uad
   ```
2. **Install dependensi**
   ```bash
   flutter pub get
   ```
3. **Analisis kode**
   ```bash
   flutter analyze
   ```
4. **Jalankan di emulator atau perangkat**
   ```bash
   flutter run
   ```

--- 

## Status Milestone
| Milestone | Status | Tag Git |
|---|---|---|
| **M01 Inisiasi Proyek & Scaffolding** | Finalisasi | `m01-initiation` |
| **M02 Spesifikasi Kebutuhan & Desain** | Dalam proses | - |
| **M03 Prototipe & Penyimpanan Lokal** | Dalam proses | - |
| **M04 Frontend & Integrasi UI** | Dalam proses | - |
| **M05 API & Rilis APK** | Belum dimulai | - |
