USE Chinook;  
GO 
CREATE VIEW TempHelper
	WITH SCHEMABINDING AS
	SELECT T.GenreId, T.TrackId
	FROM Track T
	inner join Genre G on T.GenreId=G.GenreId
GO
CREATE VIEW View_BQuest
	WITH SCHEMABINDING AS
	SELECT T.GenreId GenreId, T.TrackId TrackId, IL.UnitPrice*IL.Quantity TotalTrackCharge, I.InvoiceDate TimeCreated
	FROM TempHelper T, InvoiceLine IL
	inner join Invoice I on IL.InvoiceId=I.InvoiceId	
GO
CREATE PROCEDURE BQuestion AS
BEGIN TRY
DECLARE @CreateStatistics NVARCHAR(55)='A transaction that creates Statistics from B question.'
	BEGIN TRAN
		IF OBJECT_ID (N'dbo.InvoiceStatistics', N'U') IS NOT NULL  
			DROP STATISTICS dbo.InvoiceStatistics;	
		ELSE
			BEGIN			
				CREATE STATISTICS InvoiceStatistics
				ON Views.dbo.View_BQuest (GenreId, TrackId, TotalTrackCharge, TimeCreated)
				WITH FULLSCAN
			END
	commit;
END TRY
BEGIN CATCH
	BEGIN TRAN		
		IF (SELECT ERROR_MESSAGE ())='%create%'
			BEGIN
				PRINT '-1 Table creation is failed.'
			END
		ELSE IF (SELECT ERROR_MESSAGE ())='%drop%'
			BEGIN
				PRINT '-2 Storage engine cannot drop table.'
			END
		ELSE IF (SELECT ERROR_MESSAGE ())='%insert%'
			BEGIN
				PRINT '-3 Insertion Error.'
			END	
	rollback tran @CreateStatistics;
END CATCH
GO

