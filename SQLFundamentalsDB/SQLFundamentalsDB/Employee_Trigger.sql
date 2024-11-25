USE learn8;
GO

CREATE TRIGGER trg_InsertEmployee
ON Employee
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @AddressId INT, @Street NVARCHAR(50), @City NVARCHAR(20), @State NVARCHAR(50), @ZipCode NVARCHAR(50);

    -- Get the AddressId from the inserted row
    SELECT @AddressId = AddressId FROM inserted;

    -- Get the address details from the Address table
    SELECT @Street = Street, @City = City, @State = State, @ZipCode = ZipCode
    FROM Address
    WHERE Id = @AddressId;

    -- Insert the new address for the company
    DECLARE @NewAddressId INT;
    INSERT INTO Address (Street, City, State, ZipCode)
    VALUES (@Street, @City, @State, @ZipCode);
    SET @NewAddressId = SCOPE_IDENTITY();

    -- Insert the new company with the new address
    INSERT INTO Company (Name, AddressId)
    SELECT CompanyName, @NewAddressId
    FROM inserted;
END
GO