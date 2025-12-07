-- Create Partition Function (by Incident Year)
CREATE PARTITION FUNCTION PF_IncidentYear (INT)
AS RANGE RIGHT FOR VALUES
(
    20230101,  -- Tahun 2023
    20240101,  -- Tahun 2024
    20250101   -- Tahun 2025
);
GO
-- Create Partition Scheme
CREATE PARTITION SCHEME PS_IncidentYear
AS PARTITION PF_IncidentYear
ALL TO ([PRIMARY]);
GO
