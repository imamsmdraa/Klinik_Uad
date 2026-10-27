# ADR 003: Penerapan Feature-First Clean Architecture
**Status:** Diterima (Accepted)  
**Tanggal:** Semester Gasal 2026/2027  
**Pengambil Keputusan:** Tim Pengembang Kelompok Klinik Kampus  
**Referensi:** Dokumen Arsitektur Aplikasi Klinik UAD & Panduan Scaffolding M01

---

## Konteks & Permasalahan
Aplikasi memiliki 5 modul fitur utama yang dikerjakan bersama oleh 4 anggota tim. Pendekatan arsitektur tradisional (*layer-first* tanpa pemisahan modul) sering menyebabkan konflik kode (*merge conflict*), keterikatan erat antarkomponen (*tight coupling*), serta kesulitan pengujian antarmuka tanpa server database aktif.

---

## Keputusan Arsitektur
Menerapkan arsitektur **Feature-First Clean Architecture** yang dipadukan dengan **Repository Pattern**:

1. **Presentation Layer:** Berisi UI (Pages & Widgets) dan pengelola status (*State Management* / Notifier).
2. **Domain Layer:** Berisi Entitas murni dan Kontrak Antarmuka Repositori (*Repository Contract*). Lapisan ini sepenuhnya independen dari Flutter SDK maupun library pihak ketiga.
3. **Data Layer:** Berisi Model DTO, implementasi repositori (*Data Source* lokal / remote), dan mapper.
4. **Penyediaan Abstraksi In-Memory di Fase Awal:**  
   Di fase M01, seluruh data antrean dan rekam medis dilayani oleh `InMemoryClinicRepository` sehingga UI dapat diuji secara mandiri tanpa ketergantungan koneksi internet.

---

## Konsekuensi
- **Positif:** Kode terisolasi rapi per fitur, mudah dilakukan unit testing, pergantian sumber data dari data simulasi lokal ke Supabase di kemudian hari tidak merusak antarmuka UI.
- **Tantangan:** Jumlah berkas yang dibuat lebih banyak karena adanya pemisahan kontrak dan implementasi, namun sangat sebanding dengan kemudahan kolaborasi tim.
