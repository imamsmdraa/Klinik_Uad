# Klinik UAD — Kelompok Klinik UAD

Topik: Klinik

Anggota:

- Naufal Adna Garibaldi — 2311016061
- Sagara Imam Samudra — 2300016062
- MHD Rafy Firdaus — 2300016055
- Mohamad Arief Gunadi — 2300016031

## Cara Menjalankan

```bash
flutter pub get
flutter run
```

Baseline ini diuji dengan Flutter 3.47.7 / Dart 3.13.5, Android API 24 ke atas. Lockfile saat ini membutuhkan Dart ≥ 3.13.0 dan Flutter ≥ 3.38.4. Gunakan SDK yang memenuhi keduanya.

Langkah mencoba PIN dan penguncian langsung di aplikasi: [Uji manual keamanan M01](docs/m01-security-testing.md). Bukti pemeriksaan teknis: [Bukti baseline](docs/01-compliance/evidence/README.md). Keputusan fondasi kode: [ADR 001](docs/adr/001-repository-pattern.md).

Sinkronisasi memakai ID Android dari main: `id.ac.uad.klinik_uad`. PIN lama dengan ID yang sama tetap berlaku; instalasi baru membuat PIN sendiri. Model/repository janji, dokumen desain, dan ADR anggota lain tetap tersedia. Enam register dan ID kepatuhan berpusat di `docs/01-compliance/`.

## Status Milestone

| Milestone | Status | Tag git |
|-----------|--------|---------|
| M01 Inisiasi | Selesai | m01-initiation |
| M02 Spesifikasi | Dalam proses | - |
| M03 Prototipe | Dalam proses | - |
| M04 Frontend | Dalam proses | - |
| M05 API | Belum mulai | - |
