-- Staging Schema
CREATE SCHEMA stg;
GO

-- Staging Table for Dim_Waktu
CREATE TABLE stg.Dim_Waktu (
    WaktuKey INT,
    Tanggal DATE,
    Bulan INT,
    Tahun INT,
    Hari VARCHAR(20),
    LoadDate DATETIME DEFAULT GETDATE()
);
GO

-- Staging Table for Dim_Lokasi
CREATE TABLE stg.Dim_Lokasi (
    LokasiKey INT,
    Fakultas VARCHAR(50),
    Server VARCHAR(50),
    LoadDate DATETIME DEFAULT GETDATE()
);
GO

-- Staging Table for Dim_JenisSerangan
CREATE TABLE stg.Dim_JenisSerangan (
    JenisSeranganKey INT,
    NamaSerangan VARCHAR(100),
    Deskripsi VARCHAR(255),
    LoadDate DATETIME DEFAULT GETDATE()
);
GO

-- Staging Table for Dim_TimRespon
CREATE TABLE stg.Dim_TimRespon (
    TimResponKey INT,
    Petugas VARCHAR(150),
    Jabatan VARCHAR(50),
    Unit VARCHAR(50),
    LoadDate DATETIME DEFAULT GETDATE()
);
GO


-- Staging Table for Fact_Incident
CREATE TABLE stg.Fact_Incident (
    ID_Incident INT,
    WaktuKey INT,
    LokasiKey INT,
    JenisSeranganKey INT,
    TimResponKey INT,
    DurasiRespon INT,
    JumlahDataTerenam INT,
    StatusPenanganan VARCHAR(20),
    LoadDate DATETIME DEFAULT GETDATE()
);
GO
