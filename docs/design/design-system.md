# Sistem Desain Klinik UAD (Design System & Tokens)
**Proyek:** Klinik UAD — Layanan Kesehatan & Rekam Medis Kampus  
**Prinsip Desain:** Bersih, Empatis, Aksesibel, dan Standar Medis Profesional (Material 3)

---

## 1. Palet Warna (Color Palette Tokens)

Desain menggunakan warna utama hijau klinis Universitas Ahmad Dahlan yang dipadukan dengan aksen medis yang menenangkan:

```text
Brand & Theme Colors:
- Primary Brand       : #2E8B3C (UAD Clinical Green)
- Primary Dark        : #064E3B (Deep Forest Green - Kontras Teks)
- Primary Light       : #4CAF50 (Fresh Medical Green)
- Primary Container   : #E6F4E8 (Soft Mint - Latar Belakang Kartu Utama)

Secondary & Accent:
- Secondary           : #66BB6A (Subtle Mint Accent)
- Secondary Container : #EAF6EB (Soft Secondary Fill)
- Accent / Teal       : #26A69A (Positive Healthcare Teal)
- Accent Container    : #E0F2F1 (Light Cyan Tint)

Neutral & Background:
- Scaffold Background : #F7F9FC (Clean Clinical Cool White)
- Surface             : #FFFFFF (White Pure Card)
- Surface Variant     : #F1F4F8 (Cool Gray Card Tint)
- Border / Outline    : #E5E9F0 (Subtle Border Gray)

Status & Feedback:
- Success (Dilayani)  : #43A047 / Container #E8F5E9
- Warning (Menunggu)  : #FFC107 / Container #FFF8E1
- Danger (Batal/Sakit): #EF5350 / Container #FFEBEE
- Info (Jadwal Dokter): #1E88E5 / Container #E3F2FD
```

---

## 2. Tipografi (Typography Scale)

Menggunakan standar font sistem bawaan Google Fonts (Inter / Roboto) yang dirancang untuk keterbacaan tinggi pada teks data medis:

| Role Tipografi | Ukuran (sp) | Bobot (Weight) | Penggunaan |
|---|---|---|---|
| **Display Large** | 32 | Bold (700) | Nomor Antrean Utama di Beranda |
| **Headline Medium** | 24 | SemiBold (600) | Judul Halaman Fitur |
| **Title Large** | 20 | SemiBold (600) | Judul Kartu Janji Temu & Dokter |
| **Title Medium** | 16 | Medium (500) | Nama Pasien & Dokter |
| **Body Large** | 16 | Regular (400) | Paragraf Informasi & Rekam Medis |
| **Body Medium** | 14 | Regular (400) | Keterangan Detail, Keluhan, Dosis Obat |
| **Label Medium** | 12 | SemiBold (600) | Status Badge ("Menunggu", "Selesai") |

---

## 3. Sistem Jarak Grid 8-Point (Spacing & Radius)

- **Grid Spacing:**
  - `xxs`: 4 dp
  - `xs` : 8 dp
  - `sm` : 12 dp
  - `md` : 16 dp (Standar padding isi kartu)
  - `lg` : 20 dp (Standar padding horizontal layar)
  - `xl` : 24 dp (Jarak antar seksi kartu)
  - `xxl`: 32 dp (Jarak judul halaman ke konten)
- **Radius Sudut Elemen:**
  - `radiusSm`: 10 dp (Input field & dialog kecil)
  - `radiusMd`: 14 dp (Tombol utama / Button)
  - `radiusLg`: 18 dp (Kartu antrean & kartu pasien digital)
  - `radiusFull`: 999 dp (Kapsul Status Badge)

---

## 4. Standar Aksesibilitas
- Target sentuh minimal tombol (*touch target*) adalah 48×48 dp.
- Rasio kontras teks terhadap latar belakang minimal 4.5:1 (memenuhi WCAG 2.1 AA).
- Elemen interaktif memberikan umpan balik visual (*haptic/ripple effect*).
