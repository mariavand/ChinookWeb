USE Chinook

GO

CREATE VIEW persData AS
	
	SELECT c.CustomerId, c.FirstName, c.LastName, 
		c.Company, c.Address, c.City, c.State, 
		c.PostalCode, c.Phone, c.Fax, c.Email, 
		i.InvoiceDate, i.Total
	FROM Customer c
	INNER JOIN Invoice i
	ON c.CustomerId = i.CustomerId	

GO

CREATE PROCEDURE printPersData

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
	
	SELECT *
	FROM persData
	WHERE InvoiceDate BETWEEN @date_from AND @date_to
	ORDER BY Total DESC

END