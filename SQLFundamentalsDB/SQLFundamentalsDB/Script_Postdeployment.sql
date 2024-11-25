USE learn8;
GO

-- Insert default data into Person table
INSERT INTO Person (FirstName, LastName) VALUES ('Volodymyr', 'Voitovych');
INSERT INTO Person (FirstName, LastName) VALUES ('John', 'Smith');

-- Insert default data into Address table
INSERT INTO Address (Street, City, State, ZipCode) VALUES ('111 Green Str', 'Emerald City', 'Nebraska', '12345');
INSERT INTO Address (Street, City, State, ZipCode) VALUES ('222 Red Str', 'Ruby City', 'Texas', '56789');

-- Insert default data into Company table
INSERT INTO Company (Name, AddressId) VALUES ('Epam', 1);
INSERT INTO Company (Name, AddressId) VALUES ('Microsoft', 2);

-- Insert default data into Employee table
INSERT INTO Employee (AddressId, PersonId, CompanyName, Position, EmployeeName) VALUES (1, 1, 'Epam', 'Developer', 'Volodymyr Voitovych');
INSERT INTO Employee (AddressId, PersonId, CompanyName, Position, EmployeeName) VALUES (2, 2, 'Microsoft', 'Tester', 'John Smith');
GO
