USE Chinook;
GO

CREATE VIEW populartr AS
	
	SELECT t.Name, il.Quantity, i.InvoiceDate
	FROM Track t
	INNER JOIN InvoiceLine il
	ON il.TrackId = t.TrackId
	INNER JOIN Invoice i 
	ON il.InvoiceId = i.InvoiceId

GO


CREATE PROCEDURE topTrack

	(@date_from DATE, @date_to DATE)

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

	SELECT TOP 10 Name, SUM(Quantity) Sold
	FROM populartr
	WHERE InvoiceDate BETWEEN @date_from AND @date_to
	GROUP BY Name
	ORDER BY 2 DESC

END
