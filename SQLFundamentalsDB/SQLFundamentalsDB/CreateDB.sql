USE master
GO

-- DROP DB IF EXISTS
DECLARE @SQL AS NVARCHAR (1000);

IF EXISTS (SELECT 1
           FROM sys.databases
           WHERE [name] = N'learn8')
    BEGIN
        SET @SQL = N'USE [learn8];

                 ALTER DATABASE learn8 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
                 USE [master];

                 DROP DATABASE learn8;';
        EXECUTE (@SQL);
    END

-- CREATE DB
CREATE DATABASE learn8