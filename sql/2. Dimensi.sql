CREATE TABLE dbo.Dim_Waktu (
    WaktuKey INT PRIMARY KEY NOT NULL,
    Tanggal DATE NOT NULL,
    Bulan TINYINT NOT NULL,
    Tahun SMALLINT NOT NULL,
    Hari VARCHAR(15) NOT NULL,

    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE dbo.Dim_Lokasi (
    LokasiKey INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Fakultas VARCHAR(50) NOT NULL,
    Server VARCHAR(100) NOT NULL,

    -- Metadata
    EffectiveDate DATE NOT NULL DEFAULT GETDATE(),
    ExpiryDate DATE NULL,
    IsCurrent BIT NOT NULL DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE dbo.Dim_Jenis_Serangan (
    JenisSeranganKey INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    NamaSerangan VARCHAR(100) NOT NULL,
    Deskripsi VARCHAR(255) NULL,

    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE dbo.Dim_Jenis_Serangan (
    JenisSeranganKey INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    NamaSerangan VARCHAR(100) NOT NULL,
    Deskripsi VARCHAR(255) NULL,

    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE dbo.Dim_Tim_Respon (
    TimResponKey INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Petugas VARCHAR(100) NOT NULL,
    Jabatan VARCHAR(50) NOT NULL,
    Unit VARCHAR(50) NOT NULL,

    -- SCD2
    EffectiveDate DATE NOT NULL DEFAULT GETDATE(),
    ExpiryDate DATE NULL,
    IsCurrent BIT NOT NULL DEFAULT 1,

    -- Metadata
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

