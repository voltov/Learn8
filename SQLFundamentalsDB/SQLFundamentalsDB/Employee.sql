CREATE TABLE Employee (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    AddressId INT NOT NULL,
    PersonId INT NOT NULL,
    CompanyName NVARCHAR(20) NOT NULL,
    Position NVARCHAR(30) NULL,
    EmployeeName NVARCHAR(100) NULL,
    CONSTRAINT FK_Employee_Address FOREIGN KEY (AddressId) REFERENCES Address(Id),
    CONSTRAINT FK_Employee_Person FOREIGN KEY (PersonId) REFERENCES Person(Id)
);
GO