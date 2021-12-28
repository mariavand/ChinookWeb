USE Chinook;
GO

CREATE VIEW neededInvoices AS

	SELECT InvoiceId, InvoiceDate, 
		c.FirstName cust_FirstName, c.LastName cust_LastName,
		e.FirstName emp_FirstName, e.LastName emp_LastName
	FROM Customer c
	INNER JOIN Invoice i
	ON i.CustomerId = c.CustomerId
	INNER JOIN Employee e
	ON c.SupportRepId = e.EmployeeId

GO

CREATE PROCEDURE FetchInvoices
	
	(@date_from DATE, @date_to DATE,
	@cust_firstName NVARCHAR(40),
	@cust_lastName NVARCHAR(20),
	@emp_firstName NVARCHAR(20),
	@emp_lastName NVARCHAR(20))

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

	
	IF @cust_firstName IS NOT NULL AND @cust_lastName IS NOT NULL 
		AND @emp_firstName IS NOT NULL AND @emp_lastName IS NOT NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND
				(cust_FirstName = @cust_firstName AND cust_LastName = @cust_lastName) AND
				(emp_FirstName = @emp_firstName AND emp_LastName = @emp_lastName);
		END

	ELSE IF @cust_firstName IS NULL AND @cust_lastName IS NULL
		AND @emp_firstName IS NULL AND @emp_lastName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to;
		END

	ELSE IF @cust_firstName IS NULL AND @cust_lastName IS NULL AND @emp_firstName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND
				emp_LastName = @emp_lastName;
		END

	ELSE IF @cust_firstName IS NULL AND @cust_lastName IS NULL AND @emp_lastName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND
				emp_FirstName = @emp_firstName;
		END

	ELSE IF @cust_firstName IS NULL AND @emp_firstName IS NULL AND @emp_lastName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND
				cust_LastName = @cust_lastName;
		END

	ELSE IF @cust_lastName IS NULL AND @emp_firstName IS NULL AND @emp_lastName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND
				cust_FirstName = @cust_firstName;
		END

	ELSE IF @cust_firstName IS NULL AND @cust_lastName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND 
				emp_FirstName = @emp_firstName AND emp_LastName = @emp_lastName;
		END

	ELSE IF @emp_firstName IS NULL AND @emp_lastName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND
				cust_FirstName = @cust_firstName AND cust_LastName = @cust_lastName;
		END

	ELSE IF @cust_firstName IS NULL AND @emp_firstName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND 
				cust_LastName = @cust_lastName AND emp_LastName = @emp_lastName;
		END

	ELSE IF @cust_firstName IS NULL AND @emp_lastName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND 
				cust_LastName = @cust_lastName AND emp_FirstName = @emp_firstName;
		END

	ELSE IF @cust_lastName IS NULL AND @emp_firstName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND 
				cust_FirstName = @cust_firstName AND emp_LastName = @emp_lastName;
		END

	ELSE IF @cust_lastName IS NULL AND @emp_lastName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND 
				cust_FirstName = @cust_firstName AND emp_FirstName = @emp_firstName;
		END
	
	ELSE IF @cust_firstName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND
				cust_LastName = @cust_lastName AND
				emp_FirstName = @emp_firstName AND emp_LastName = @emp_lastName;
		END
	
	ELSE IF @cust_lastName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND
				cust_FirstName = @cust_firstName AND cust_LastName = @cust_lastName AND 
				emp_FirstName = @emp_firstName;
		END
	
	ELSE IF @emp_firstName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND 
				cust_FirstName = @cust_firstName AND cust_LastName = @cust_lastName AND
				emp_LastName = @emp_lastName;
		END
	
	ELSE IF @emp_lastName IS NULL
		BEGIN
			SELECT *
			FROM neededInvoices
			WHERE InvoiceDate BETWEEN @date_from AND @date_to AND
				cust_FirstName = @cust_firstName AND cust_LastName = @cust_lastName AND 
				emp_FirstName = @emp_firstName;
		END

END