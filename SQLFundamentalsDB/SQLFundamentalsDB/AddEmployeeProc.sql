USE learn8;
GO

CREATE PROCEDURE InsertEmployeeInfo
    @EmployeeName NVARCHAR(100) = NULL,
    @FirstName NVARCHAR(50) = NULL,
    @LastName NVARCHAR(50) = NULL,
    @CompanyName NVARCHAR(20),
    @Position NVARCHAR(30) = NULL,
    @Street NVARCHAR(50),
    @City NVARCHAR(20) = NULL,
    @State NVARCHAR(50) = NULL,
    @ZipCode NVARCHAR(50) = NULL
AS
BEGIN
    -- Check if at least one field is not empty: EmployeeName, FirstName, LastName
    IF (TRIM(ISNULL(@EmployeeName, '')) = '' AND TRIM(ISNULL(@FirstName, '')) = '' AND TRIM(ISNULL(@LastName, '')) = '')
    BEGIN
        RAISERROR('You must provide data for at least one of these fields: EmployeeName, FirstName, or LastName.', 16, 1);
        RETURN;
    END

    -- Truncate CompanyName if length is more than 20
    SET @CompanyName = LEFT(@CompanyName, 20);

    -- Get FirstName and LastName from EmployeeName if they are empty
    IF (@FirstName IS NULL OR @LastName IS NULL)
    BEGIN
        DECLARE @SpaceIndex INT;
        SET @SpaceIndex = CHARINDEX(' ', @EmployeeName);

        IF (@SpaceIndex > 0)
        BEGIN
            SET @FirstName = ISNULL(@FirstName, SUBSTRING(@EmployeeName, 1, @SpaceIndex - 1));
            SET @LastName = ISNULL(@LastName, SUBSTRING(@EmployeeName, @SpaceIndex + 1, LEN(@EmployeeName) - @SpaceIndex));
        END
        ELSE
        BEGIN
            SET @FirstName = ISNULL(@FirstName, @EmployeeName);
            SET @LastName = ISNULL(@LastName, '');
        END
    END

    -- Generate EmployeeName if it's empty
    IF (@EmployeeName IS NULL)
    BEGIN
        SET @EmployeeName = TRIM(ISNULL(@FirstName, '') + ' ' + ISNULL(@LastName, ''));
    END

    -- Insert Address
    DECLARE @AddressId INT;
    INSERT INTO Address (Street, City, State, ZipCode)
    VALUES (@Street, @City, @State, @ZipCode);
    SET @AddressId = SCOPE_IDENTITY();

    -- Insert Person
    DECLARE @PersonId INT;
    INSERT INTO Person (FirstName, LastName)
    VALUES (@FirstName, @LastName);
    SET @PersonId = SCOPE_IDENTITY();

    -- Insert Employee
    INSERT INTO Employee (AddressId, PersonId, CompanyName, Position, EmployeeName)
    VALUES (@AddressId, @PersonId, @CompanyName, @Position, @EmployeeName);
END
GO