USE Chinook
GO

CREATE VIEW bestArtist AS
	
	SELECT a.Name, i.InvoiceId, i.InvoiceDate
	FROM InvoiceLine il, Track t, Album al, Artist a, Invoice i
	WHERE il.TrackId = t.Trackid 
		AND al.AlbumId = t.AlbumId 
		AND a.ArtistId = al.ArtistId	
	GROUP BY a.Name, i.InvoiceId, i.InvoiceDate
	
GO

CREATE PROCEDURE topArtist

	(@date_from DATE, @date_to DATE, @x INTEGER)

AS
BEGIN
	
	IF @date_to IS NULL AND @date_from IS NULL
		BEGIN
			SET @date_from = '2009-01-01'
			SET @date_to = '2013-12-22'
		END

	ELSE IF @date_from IS NULL
		BEGIN
			SET @date_from = '2009-01-01'
		END

	ELSE IF @date_to IS NULL
		BEGIN
			SET @date_to = '2013-12-22'
		END

	
	IF @x IS NULL
		BEGIN
			SET @x = 170
		END

	SELECT TOP (@x) bA.Name
	FROM bestArtist bA	
	WHERE bA.InvoiceDate BETWEEN @date_from AND @date_to
	GROUP BY bA.Name

END