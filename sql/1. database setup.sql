-- Create Database
CREATE DATABASE DM_KeamananSiber_DW
ON PRIMARY 
(
    NAME = N'DM_KeamananSiber_DW_Data',
    FILENAME = N'D:\Data\DM_KeamananSiber_DW_Data.mdf',
    SIZE = 1GB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 256MB
)
LOG ON
(
    NAME = N'DM_KeamananSiber_DW_Log',
    FILENAME = N'E:\Logs\DM_KeamananSiber_DW_Log.ldf',
    SIZE = 256MB,
    MAXSIZE = 2GB,
    FILEGROWTH = 64MB
);
GO

USE DM_KeamananSiber_DW;
GO
