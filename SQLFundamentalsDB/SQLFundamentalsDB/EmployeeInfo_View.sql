USE learn8;
GO

CREATE VIEW EmployeeInfo AS
SELECT TOP 1000
    T1.Id AS EmployeeId,
    COALESCE(T1.EmployeeName, T2.FirstName + ' ' + T2.LastName) AS EmployeeFullName,
    T3.ZipCode + '_' + T3.State + ', ' + T3.City + '-' + T3.Street AS EmployeeFullAddress,
    T1.CompanyName + '(' + ISNULL(T1.Position, '') + ')' AS EmployeeCompanyInfo
FROM 
    Employee T1
JOIN
    Person T2 ON T2.Id = T1.PersonId
JOIN
    Address T3 ON T3.Id = T1.AddressId
ORDER BY 
    T1.CompanyName, T3.City;
GO