USE Chinook

GO

CREATE VIEW popular AS
	
	SELECT g.Name, il.Quantity
	FROM Track t
	INNER JOIN InvoiceLine il 
	ON il.TrackId = t.TrackId
	INNER JOIN Genre g 
	ON g.GenreId = t.GenreId

GO

CREATE PROCEDURE timelessGenres AS

BEGIN

	SELECT Name, SUM(Quantity) Sold
	FROM popular
	GROUP BY Name
	ORDER BY 2 DESC
	
END

