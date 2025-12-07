-- Perintah ini diaktifkan untuk menganalisis kinerja query
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

-- =========================================================
-- Query 1: Total Insiden per Jenis Serangan dan Status (Modifikasi Query 1 Template)
-- =========================================================

SELECT
    djs.NamaSerangan,
    f.StatusPenanganan,
    COUNT(f.ID_Incident) AS TotalIncidents,
    AVG(f.DurasiRespon) AS AvgResponseDuration,
    SUM(f.JumlahDataTerenam) AS TotalDataExposed
FROM dbo.Fact_Incident f
INNER JOIN dbo.Dim_JenisSerangan djs ON f.JenisSeranganKey = djs.JenisSeranganKey
INNER JOIN dbo.Dim_Waktu dw ON f.WaktuKey = dw.WaktuKey
WHERE dw.Tahun = 2024 -- Batasi analisis pada tahun tertentu
GROUP BY djs.NamaSerangan, f.StatusPenanganan
ORDER BY TotalIncidents DESC;

---

-- =========================================================
-- Query 2: Tren Insiden Bulanan/Harian (Modifikasi Query 2 Template)
-- =========================================================

SELECT
    dw.Tahun,
    dw.Bulan,
    dw.Hari AS HariKejadian,
    COUNT(f.ID_Incident) AS TotalIncidents,
    AVG(f.DurasiRespon) AS AvgDuration
FROM dbo.Fact_Incident f
INNER JOIN dbo.Dim_Waktu dw ON f.WaktuKey = dw.WaktuKey
GROUP BY dw.Tahun, dw.Bulan, dw.Hari
ORDER BY dw.Tahun, dw.Bulan, dw.Hari;

---

-- =========================================================
-- Query 3: Analisis Lokasi dan Tim Respon
-- =========================================================

SELECT
    dl.Fakultas,
    dl.Server,
    dtr.Unit AS UnitRespon,
    COUNT(f.ID_Incident) AS TotalIncidents,
    AVG(f.DurasiRespon) AS AvgDuration
FROM dbo.Fact_Incident f
INNER JOIN dbo.Dim_Lokasi dl ON f.LokasiKey = dl.LokasiKey
INNER JOIN dbo.Dim_TimRespon dtr ON f.TimResponKey = dtr.TimResponKey
GROUP BY dl.Fakultas, dl.Server, dtr.Unit
ORDER BY TotalIncidents DESC;
