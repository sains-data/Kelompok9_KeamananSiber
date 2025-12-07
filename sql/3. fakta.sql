-- Fact Table: Fact_Incident
CREATE TABLE dbo.Fact_Incident (
    IncidentKey BIGINT IDENTITY(1,1) PRIMARY KEY NOT NULL,

    -- Foreign Keys
    WaktuKey INT NOT NULL,
    LokasiKey INT NOT NULL,
    JenisSeranganKey INT NOT NULL,
    TimResponKey INT NOT NULL,

    -- Degenerate Dimension
    IncidentCode VARCHAR(50) NULL,

    -- Measures
    DurasiRespon INT NOT NULL,
    JumlahDataTerenam INT NOT NULL,
    StatusPenanganan VARCHAR(20) NOT NULL,

    -- Metadata
    SourceSystem VARCHAR(50) NOT NULL DEFAULT 'SYNTHETIC_GENERATOR',
    LoadDate DATETIME DEFAULT GETDATE(),

    -- FK Constraints
    CONSTRAINT FK_FactIncident_Waktu
        FOREIGN KEY (WaktuKey) REFERENCES dbo.Dim_Waktu(WaktuKey),

    CONSTRAINT FK_FactIncident_Lokasi
        FOREIGN KEY (LokasiKey) REFERENCES dbo.Dim_Lokasi(LokasiKey),

    CONSTRAINT FK_FactIncident_JSerangan
        FOREIGN KEY (JenisSeranganKey) REFERENCES dbo.Dim_Jenis_Serangan(JenisSeranganKey),

    CONSTRAINT FK_FactIncident_TimRespon
        FOREIGN KEY (TimResponKey) REFERENCES dbo.Dim_Tim_Respon(TimResponKey)
);
GO
