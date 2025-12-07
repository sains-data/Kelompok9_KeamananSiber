SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. PROSEDUR LOAD DIMENSI (DIMENSIONS LOAD PROCEDURES)
-- (Dihilangkan untuk fokus pada perbaikan Fact Load)

-- Prosedur: Load Dim_Waktu (Type 1 Load / Pre-Loaded)
CREATE OR ALTER PROCEDURE dbo.usp_Load_Dim_Waktu
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO dbo.Dim_Waktu (WaktuKey, Tanggal, Bulan, Tahun, Hari)
    SELECT s.WaktuKey, s.Tanggal, s.Bulan, s.Tahun, s.Hari
    FROM stg.Dim_Waktu s
    WHERE NOT EXISTS (SELECT 1 FROM dbo.Dim_Waktu dw WHERE dw.WaktuKey = s.WaktuKey);
END;
GO

-- Prosedur: Load Dim_Lokasi, Dim_JenisSerangan, Dim_TimRespon (Asumsi sudah dibuat)
-- ... (Prosedur SCD Type 2 lainnya diabaikan di sini)
GO

-- =================================================================================
-- 2. PROCEDURE LOAD FACT TABLE (SOLUSI TANPA ERROR KOLOM)
--    Asumsi: stg.Fact_Incident sudah memiliki semua Foreign Key
-- =================================================================================

CREATE OR ALTER PROCEDURE dbo.usp_Load_Fact_Incident
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Fact_Incident (
        ID_Incident, WaktuKey, LokasiKey, JenisSeranganKey, TimResponKey,
        DurasiRespon, JumlahDataTerenam, StatusPenanganan,
        CreatedDate, ModifiedDate
    )
    SELECT
        s.ID_Incident,
        s.WaktuKey,              -- AMBIL LANGSUNG DARI STAGING
        s.LokasiKey,             -- AMBIL LANGSUNG DARI STAGING
        s.JenisSeranganKey,      -- AMBIL LANGSUNG DARI STAGING
        s.TimResponKey,          -- AMBIL LANGSUNG DARI STAGING
        
        s.DurasiRespon,
        s.JumlahDataTerenam,
        UPPER(s.StatusPenanganan),
        GETDATE(),
        GETDATE()
    FROM stg.Fact_Incident s 
    
    -- Mencegah duplikasi Fact
    WHERE NOT EXISTS (
        SELECT 1
        FROM dbo.Fact_Incident f
        WHERE f.ID_Incident = s.ID_Incident
    );
END;
GO

-- =================================================================================
-- 3. MASTER ETL PROCEDURE
-- =================================================================================

CREATE OR ALTER PROCEDURE dbo.usp_Master_ETL_KeamananSiber
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Step 1: Load Dimensions
        EXEC dbo.usp_Load_Dim_Waktu; 
        EXEC dbo.usp_Load_Dim_Lokasi;
        EXEC dbo.usp_Load_Dim_JenisSerangan; 
        EXEC dbo.usp_Load_Dim_TimRespon;    

        -- Step 2: Load Facts
        EXEC dbo.usp_Load_Fact_Incident;

        -- Step 3: Optimization & Finalization
        EXEC sp_updatestats; 

        COMMIT TRANSACTION;

        PRINT 'ETL Keamanan Siber Completed Successfully';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        THROW; 
    END CATCH
END;
GO
