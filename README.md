# Kelompok 9 – Keamanan Siber  

## Anggota Kelompok
1. **Fadil Prasetyo Alfarizzi** (123450048)  
2. **Reynaldi Rahmad** (122450088)  
3. **Melinza Nabila** (123450122)  
4. **Fathya Intami Gusda** (123450095)

## **3.5.1 Step 1: Business Requirements Analysis**

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

## **3.5.2 Step 2: Conceptual Design**

# 1. **Identifikasi Entitas**
**Entitas dan atribut utamanya:**

| Entitas           | Atribut                                                                 |
|------------------|--------------------------------------------------------------------------|
| **Incident**     | ID_Incident (PK), WaktuKey, LokasiKey, JenisSeranganKey, TimResponKey, DurasiRespon, StatusPenanganan, JumlahDataTerenam |
| **Waktu**        | WaktuKey (PK), Tanggal, Bulan, Tahun, Hari |
| **Lokasi**       | LokasiKey (PK), Unit, Fakultas, Server |
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

