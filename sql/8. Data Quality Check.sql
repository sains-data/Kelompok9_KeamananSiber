-- Pastikan Anda menjalankan script ini dengan koneksi ke database DM_KeamananSiber_DW

-- =========================================================
-- Check 1: Completeness - NULL values (Cek Dimensi & Fact)
-- =========================================================
SELECT
    'Dim_Lokasi' AS TableName,
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN LokasiKey IS NULL THEN 1 ELSE 0 END) AS NullLokasiKey,
    SUM(CASE WHEN Fakultas IS NULL THEN 1 ELSE 0 END) AS NullFakultas,
    SUM(CASE WHEN Server IS NULL THEN 1 ELSE 0 END) AS NullServer
FROM dbo.Dim_Lokasi
UNION ALL
SELECT
    'Fact_Incident' AS TableName,
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN ID_Incident IS NULL THEN 1 ELSE 0 END) AS NullIDIncident,
    SUM(CASE WHEN DurasiRespon IS NULL THEN 1 ELSE 0 END) AS NullDurasi,
    SUM(CASE WHEN StatusPenanganan IS NULL THEN 1 ELSE 0 END) AS NullStatus
FROM dbo.Fact_Incident;

---

-- =========================================================
-- Check 2: Consistency - Referential Integrity (Orphan Records)
-- =========================================================
SELECT
    'TimResponKey' AS OrphanKey,
    COUNT(*) AS OrphanRecords
FROM dbo.Fact_Incident f
LEFT JOIN dbo.Dim_TimRespon dtr ON f.TimResponKey = dtr.TimResponKey
WHERE dtr.TimResponKey IS NULL -- Baris Fact yang tidak punya Tim Respon yang valid
UNION ALL
SELECT
    'LokasiKey' AS OrphanKey,
    COUNT(*) AS OrphanRecords
FROM dbo.Fact_Incident f
LEFT JOIN dbo.Dim_Lokasi dl ON f.LokasiKey = dl.LokasiKey
WHERE dl.LokasiKey IS NULL;

---

-- =========================================================
-- Check 3: Accuracy - Valid Ranges/Domain (Durasi dan Status)
-- =========================================================
SELECT
    'Fact_Incident' AS TableName,
    SUM(CASE WHEN DurasiRespon < 0 THEN 1 ELSE 0 END) AS InvalidDurasiRespon, -- Durasi tidak boleh negatif
    SUM(CASE WHEN StatusPenanganan NOT IN ('SELESAI', 'PENDING') THEN 1 ELSE 0 END) AS InvalidStatusDomain -- Cek domain status
FROM dbo.Fact_Incident;

---

-- =========================================================
-- Check 4: Duplicates (Memastikan ID_Incident unik)
-- =========================================================
SELECT
    ID_Incident,
    COUNT(*) AS DuplicateCount
FROM dbo.Fact_Incident
GROUP BY ID_Incident
HAVING COUNT(*) > 1;

---

-- =========================================================
-- Check 5: Record Counts Reconciliation (Membandingkan jumlah baris Staging vs Warehouse)
-- =========================================================
SELECT
    'Staging' AS DataSource,
    COUNT(*) AS RecordCount
FROM stg.Fact_Incident -- DIGANTI ke stg.Fact_Incident untuk menghindari Error 208
UNION ALL
SELECT
    'Warehouse' AS DataSource,
    COUNT(*) AS RecordCount
FROM dbo.Fact_Incident;
