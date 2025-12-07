-- Full Backup
BACKUP DATABASE DM_KeamananSiber_DW
TO DISK = N'C:\Backup\DM_KeamananSiber_DW_Full.bak'
WITH
    COMPRESSION, -- Mengurangi ukuran file backup
    INIT,        -- Menimpa file backup yang ada
    NAME = N'Full Database Backup',
    STATS = 10;
GO
