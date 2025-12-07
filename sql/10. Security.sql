USE [DM_KeamananSiber_DW]; 
GO

-- CATATAN: Perintah CREATE ROLE dilewati karena Roles sudah ada di database.

-- =========================================================
-- Grant Permissions for ETL Operator (Izin untuk Proses ETL)
-- =========================================================
-- Memberikan hak EXECUTE untuk menjalankan Master Stored Procedure
GRANT EXECUTE ON dbo.usp_Master_ETL_KeamananSiber TO db_etl_operator; 
-- Memberikan hak penuh pada Staging Area (untuk memuat dan membersihkan data)
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::stg TO db_etl_operator;
-- Memberikan hak INSERT pada skema dbo (untuk memuat data ke Fact/Dimensi)
GRANT INSERT ON SCHEMA::dbo TO db_etl_operator;
GO

-- =========================================================
-- Grant Permissions for Executive (Izin untuk Pengambilan Keputusan Tingkat Tinggi)
-- =========================================================
-- Memberikan hak SELECT pada skema dbo (semua data final di DW)
GRANT SELECT ON SCHEMA::dbo TO db_executive; 
-- Memberikan hak untuk menjalankan Master SP (untuk pengawasan atau eksekusi darurat)
GRANT EXECUTE ON dbo.usp_Master_ETL_KeamananSiber TO db_executive; 
GO

-- =========================================================
-- Grant Permissions for Analyst (Izin untuk Analisis dan Transformasi Data)
-- =========================================================
-- Memberikan hak SELECT pada skema dbo (untuk melakukan analisis pada data final)
GRANT SELECT ON SCHEMA::dbo TO db_analyst; 
-- Memberikan hak penuh pada Staging Area (untuk membersihkan dan memanipulasi data sebelum Load)
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::stg TO db_analyst;
GO

-- =========================================================
-- Grant Permissions for Viewer (Izin Baca-Saja pada View Analitik & Dimensi Dasar)
-- (Disini menggunakan tabel dasar yang pasti ada, karena Views sebelumnya tidak ditemukan)
-- =========================================================
GRANT SELECT ON dbo.Fact_Incident TO db_viewer; -- Akses ke Fact Table
GRANT SELECT ON dbo.Dim_Waktu TO db_viewer; 
GRANT SELECT ON dbo.Dim_Lokasi TO db_viewer;
GO
