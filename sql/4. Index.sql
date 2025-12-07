CREATE CLUSTERED INDEX CIX_Fact_Enrollment_DateKey
ON dbo.Fact_Enrollment(DateKey, EnrollmentKey);

-- Clustered Index
CREATE CLUSTERED INDEX CIX_Fact_Incident_WaktuKey
ON dbo.Fact_Incident(WaktuKey, IncidentKey);
GO

CREATE NONCLUSTERED INDEX IX_Fact_Incident_Lokasi
ON dbo.Fact_Incident(LokasiKey)
INCLUDE (DurasiRespon, JumlahDataTerenam);
GO

CREATE NONCLUSTERED INDEX IX_Fact_Incident_JenisSerangan
ON dbo.Fact_Incident(JenisSeranganKey)
INCLUDE (DurasiRespon, JumlahDataTerenam);
GO

CREATE NONCLUSTERED INDEX IX_Fact_Incident_TimRespon
ON dbo.Fact_Incident(TimResponKey)
INCLUDE (DurasiRespon, StatusPenanganan);
GO

CREATE NONCLUSTERED INDEX IX_Fact_Incident_Cover
ON dbo.Fact_Incident(WaktuKey, LokasiKey)
INCLUDE (JenisSeranganKey, DurasiRespon, JumlahDataTerenam, StatusPenanganan);
GO


CREATE NONCLUSTERED COLUMNSTORE INDEX NCCIX_Fact_Incident
ON dbo.Fact_Incident
(
    WaktuKey,
    LokasiKey,
    JenisSeranganKey,
    TimResponKey,
    DurasiRespon,
    JumlahDataTerenam,
    StatusPenanganan
);
GO
