# Kelompok 9 – Keamanan Siber  

## Anggota Kelompok
1. **Fadil Prasetyo Alfarizzi** (123450048)  
2. **Reynaldi Rahmad** (122450088)  
3. **Melinza Nabila** (123450122)  
4. **Fathya Intami Gusda** (123450095)

## **Business Requirements Analysis**

# 1. **Identifikasi Stakeholders**

**Pengguna utama data mart:**
- CISO / Manajer Keamanan Informasi
- Koordinator Tim Respon Insiden
- Staf Keamanan IT
- Pimpinan Fakultas / Unit TI

**Pengambil Keputusan:**
- Kepala Pusat Data & Keamanan TI
- Rektor / Wakil Rektor Bidang TI

---

# 2. **Analisis Proses Bisnis**
Proses utama penanganan insiden keamanan:
1. Deteksi insiden  
2. Klasifikasi jenis serangan (DDoS, Malware, SQL Injection, dll)  
3. Identifikasi lokasi & server terdampak  
4. Respon oleh tim penanganan  
5. Pelaporan hasil dan durasi penyelesaian  

**Key Performance Indicators (KPI)**
- Rata-rata waktu respon  
- Jumlah insiden per bulan  
- Frekuensi serangan per unit/fakultas  
- Jumlah data terdampak  
- Persentase insiden selesai tepat waktu  

**Metrik Bisnis**
- Durasi respon (menit)  
- Jumlah data terdampak  
- Status penyelesaian  
- Frekuensi serangan  

---

# 3. **Kebutuhan Analitik**

**Pertanyaan bisnis utama:**
- Berapa banyak insiden terjadi per bulan?  
- Unit/fakultas mana yang paling sering terkena serangan?  
- Jenis serangan yang paling umum terjadi?  
- Berapa lama rata-rata penanganan insiden?  
- Siapa petugas yang paling cepat merespon?

**Jenis Laporan**
- Harian → daftar insiden terbaru  
- Mingguan → tren jenis serangan  
- Bulanan → performa tim, jumlah serangan, rata-rata durasi respon  

**Level Agregasi**
- Harian → Mingguan → Bulanan  
- Unit → Fakultas → Institusi  
- Jenis Serangan → Kategori  

---

## **Conceptual Design**

# 1. **Identifikasi Entitas**
**Entitas dan atribut utamanya:**

| Entitas           | Atribut                                                                 |
|------------------|--------------------------------------------------------------------------|
| **Incident**     | ID_Incident (PK), WaktuKey, LokasiKey, JenisSeranganKey, TimResponKey, DurasiRespon, StatusPenanganan, JumlahDataTerenam |
| **Waktu**        | WaktuKey (PK), Tanggal, Bulan, Tahun, Hari |
| **Lokasi**       | LokasiKey (PK), Fakultas, Server |
| **Jenis_Serangan** | JenisSeranganKey (PK), NamaSerangan, Deskripsi |
| **Tim_Respon**   | TimResponKey (PK), Petugas, Jabatan, Unit |

---

# 2. **Relationships**
Semua relasi adalah **1 – N (One-to-Many)**:

- Waktu → Incident  
- Lokasi → Incident  
- Jenis_Serangan → Incident  
- Tim_Respon → Incident  

Semua mandatory, karena setiap insiden harus memiliki waktu, lokasi, jenis serangan, dan tim respon.

# **Logical Design – Dimensional Model**

# 1. **Fact Table: `Fact_Incident`**
- **Grain:** satu baris = satu insiden  
- **Measures:** DurasiRespon, JumlahDataTerenam  
- **Additivity:** Additive  

---

# 2. **Dimension Tables**
| Dimensi | Fokus Analisis | Atribut |
|--------|----------------|---------|
| **Dim_Waktu** | Kapan insiden terjadi | Tanggal, Bulan, Tahun, Hari |
| **Dim_Lokasi** | Lokasi serangan | Fakultas, Server |
| **Dim_Jenis_Serangan** | Jenis serangan | NamaSerangan, Deskripsi |
| **Dim_Tim_Respon** | Siapa yang menangani | Petugas, Jabatan, Unit |

---

# 3. **Star Schema**

![WhatsApp Image 2025-11-17 at 22 22 15_3cd83ef0](https://github.com/user-attachments/assets/234d3720-374c-479b-b89e-75c297fc9729)

**Foreign Keys**
- Fact_Incident.WaktuKey → Dim_Waktu  
- Fact_Incident.LokasiKey → Dim_Lokasi  
- Fact_Incident.JenisSeranganKey → Dim_Jenis_Serangan  
- Fact_Incident.TimResponKey → Dim_Tim_Respon  

---

# 4. **Surrogate Keys**
- Semua dimensi menggunakan **integer surrogate key**  
- SCD Type 2 untuk histori perubahan (lokasi/tim respon)

---

## **Data Dictionary**

| Tabel              | Kolom            | Tipe Data | Deskripsi                         |
|--------------------|------------------|-----------|-----------------------------------|
| **Fact_Incident**  | ID_Incident      | int (PK)  | Kunci utama insiden               |
|                    | WaktuKey         | int (FK)  | Referensi ke Dim_Waktu            |
|                    | LokasiKey        | int (FK)  | Referensi ke Dim_Lokasi           |
|                    | JenisSeranganKey | int (FK)  | Referensi ke Dim_Jenis_Serangan   |
|                    | TimResponKey     | int (FK)  | Referensi ke Dim_Tim_Respon       |
|                    | DurasiRespon     | int       | Lama penanganan insiden           |
|                    | JumlahDataTerenam| int       | Banyaknya data terdampak          |
|                    | StatusPenanganan | string    | Status: selesai/pending           |
| **Dim_Waktu**      | WaktuKey         | int (PK)  | Surrogate key waktu               |
|                    | Tanggal          | date      | Tanggal kejadian                  |
|                    | Bulan            | int       | Bulan ke-n                        |
|                    | Tahun            | int       | Tahun kejadian                    |
|                    | Hari             | string    | Nama hari                          |
| **Dim_Lokasi**     | LokasiKey        | int (PK)  | Surrogate key lokasi              |
|                    | Fakultas         | string    | Fakultas terkait                  |
|                    | Server           | string    | Nama server terdampak             |
| **Dim_Jenis_Serangan** | JenisSeranganKey | int (PK) | Surrogate key jenis serangan  |
|                        | NamaSerangan      | string   | Nama jenis serangan           |
|                        | Deskripsi         | string   | Penjelasan singkat             |
| **Dim_Tim_Respon**     | TimResponKey      | int (PK) | Surrogate key tim respon      |
|                        | Petugas           | string   | Nama petugas                   |
|                        | Jabatan           | string   | Jabatan petugas                |
|                        | Unit              | string   | Unit kerja tim                 |
---
