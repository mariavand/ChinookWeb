USE Chinook;
GO

CREATE VIEW albumsArtist AS
	
	SELECT al.Title SongName, a.Name ArtistName, al.AlbumId
	FROM Artist a
	INNER JOIN Album al
	ON al.ArtistId = a.ArtistId
	
GO

CREATE VIEW plusTrack AS

	SELECT aA.SongName, aA.ArtistName, t.TrackId
	FROM albumsArtist aA
	INNER JOIN Track t
	ON aA.AlbumId = t.AlbumId

GO

CREATE VIEW trackOrdered AS

	SELECT pT.SongName, pT.ArtistName, pT.TrackId, il.InvoiceId, il.Quantity 
	FROM plusTrack pT
	INNER JOIN InvoiceLine il
	ON il.TrackId = pT.TrackId

GO

CREATE PROCEDURE FetchTrackOrders 
	
	@year VARCHAR(5)

AS
	
	DECLARE @date_from DATE
	DECLARE @date_to DATE
	SET @date_from = @year+'-01-01'
	SET @date_to = @year+'-12-31'

BEGIN

	IF @year IS NULL
		BEGIN
			SET @date_from = '2009-01-01'
			SET @date_to = '2013-12-22'
		END

	SELECT trO.SongName, trO.ArtistName, 
		CASE DATEPART(QUARTER, i.InvoiceDate) WHEN 1 THEN COUNT(trO.Quantity) END SoldFirstQuart,
		CASE DATEPART(QUARTER, i.InvoiceDate) WHEN 2 THEN COUNT(trO.Quantity) END SoldSecondQuart,
		CASE DATEPART(QUARTER, i.InvoiceDate) WHEN 3 THEN COUNT(trO.Quantity) END SoldThirdQuart,
		CASE DATEPART(QUARTER, i.InvoiceDate) WHEN 4 THEN COUNT(trO.Quantity) END SoldFourthQuart
	FROM trackOrdered trO
	INNER JOIN Invoice i
	ON i.InvoiceId = trO.InvoiceId
	WHERE i.InvoiceDate BETWEEN @date_from AND @date_to
	GROUP BY trO.SongName, trO.ArtistName, i.InvoiceDate, trO.Quantity
	ORDER BY trO.SongName, trO.ArtistName

END