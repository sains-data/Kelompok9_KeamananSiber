# 3.5.2 Step 2: Data Source Identification

Tujuan: Mengidentifikasi serta menganalisis sumber data yang digunakan dalam pembangunan Data Warehouse insiden keamanan siber berdasarkan dataset hasil proses data generation.

---

## 1. Identifikasi Sumber Data

### a. Database Operasional (OLTP)
Merupakan sumber data utama yang merepresentasikan log insiden keamanan digital. Data ini digunakan untuk membangun tabel fakta **Fact_Incident** dengan total **10.000 record** hasil simulasi.

### b. File Excel / CSV
Seluruh hasil generate Python disimpan dalam format CSV untuk keperluan ETL:

- `Dim_Waktu.csv`
- `Dim_Lokasi.csv`
- `Dim_Jenis_Serangan.csv`
- `Dim_Tim_Respon.csv`
- `Fact_Incident.csv`

### c. External / Synthetic Data Generation
Generator Python (Faker, NumPy, pandas) digunakan untuk menghasilkan data berikut:

- Nama petugas
- Deskripsi serangan
- Unit kerja
- Jabatan
- Nilai durasi respon, jumlah data terenam, dan status penanganan

### d. Manual Data Entry
Tidak digunakan dalam studi kasus ini.

### e. Python Script sebagai Internal API
Script generator berfungsi sebagai “internal API” yang menghasilkan seluruh dataset DW.

---

## 2. Data Source Analysis

### a. Struktur dan Schema Data Source

#### 1. Dim_Waktu
- Range tanggal: 2023-01-01 sampai 2025-12-31  
- Kolom: `WaktuKey`, `Tanggal`, `Bulan`, `Tahun`, `Hari`  

#### 2. Dim_Lokasi
- Fakultas: FS, FTI, FTIK  
- Server: FS-SRV01, FTI-SRV01, FTIK-SRV01  

#### 3. Dim_JenisSerangan
- Jenis: DDoS, SQL Injection, Phishing, Malware, Brute Force, Ransomware  
- Deskripsi: dibangkitkan secara acak oleh Faker  

#### 4. Dim_TimRespon
- Jumlah petugas: 20  
- Jabatan: Staff, Supervisor, Koordinator  
- Unit: PUSDATIN, Network Security, Incident Response  

#### 5. Fact_Incident
- Total: 10.000 record  
- Mengandung foreign key ke seluruh dimensi  
- Field utama: `DurasiRespon`, `JumlahDataTerenam`, `StatusPenanganan`  
- Distribusi status: 85% selesai, 15% pending  

### b. Volume dan Laju Pertumbuhan

| Tabel               | Volume         | Catatan                      |
|--------------------|----------------|------------------------------|
| Dim_Waktu          | 1.095 rows     | Statis                       |
| Dim_Lokasi         | 3 rows         | Statis                       |
| Dim_JenisSerangan  | 6 rows         | Statis                       |
| Dim_TimRespon      | 20 rows        | Dinamis (regenerasi)         |
| Fact_Incident      | 10.000 rows    | Batch incremental            |

### c. Kualitas Data
- Tidak ada nilai null  
- Format konsisten  
- Deskripsi serangan acak namun valid  
- Fakultas dan server tersentralisasi  

### d. Frekuensi Update Data
- Dim waktu: tidak berubah  
- Dim lokasi: sangat jarang berubah  
- Dim jenis serangan: berubah jika API security di-update  
- Dim tim: berubah jika struktur tim diperbarui  
- Fact incident: setiap batch data generator  

---

## 3. Data Profiling

### a. Analisis Distribusi
- Distribusi tanggal merata pada periode 2023–2025  
- Lokasi mengacu pada 3 fakultas  
- Seluruh jenis serangan terdistribusi merata  
- Tim respon muncul secara acak  
- Status “selesai” mendominasi

### b. Identifikasi Null dan Outliers
- Tidak ada nilai null  
- Nilai DurasiRespon hingga 500 menit berpotensi menjadi outlier  

### c. Deteksi Duplikasi
- Dimensi tidak memiliki nilai duplikat  
- Faktual mengandung kejadian repetitif yang valid  

### d. Konsistensi Data
- Format tanggal: `YYYY-MM-DD`  
- Fakultas: FS, FTI, FTIK  
- Status penanganan: selesai, pending  

---

## Output Summary

| Data Source             | Type             | Volume      | Update Frequency  |
|-------------------------|------------------|-------------|-------------------|
| Simulator OLTP Log      | Python/NumPy     | 10.000 rows | Batch             |
| Dim_Waktu              | CSV              | 1.095 rows  | One-time          |
| Dim_Lokasi             | CSV              | 3 rows      | One-time          |
| Dim_JenisSerangan      | CSV              | 6 rows      | One-time          |
| Dim_TimRespon          | CSV              | 20 rows     | Per regenerasi    |
| Fact_Incident          | CSV              | 10.000 rows | Per batch         |

---
