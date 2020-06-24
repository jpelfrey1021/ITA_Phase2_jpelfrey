/*1) Which shippers do we have?*/
SELECT 
    *
FROM
    Shippers;


/*2) Certain fields from categories*/
SELECT 
    CategoryName, Description
FROM
    Categories;


/*3) Sales Representatives*/
SELECT 
    FirstName, LastName, HireDate
FROM
    Employees
WHERE
    Title = 'Sales Representative';


/*4) Sales Representatives in the US*/
SELECT 
    FirstName, LastName, HireDate
FROM
    Employees
WHERE
    Title = 'Sales Representative'
        AND Country = 'USA';


/*5) Orders placed by specific EmployeeID*/
SELECT 
    OrderID, OrderDate
FROM
    Orders
WHERE
    EmployeeID = 5;


/*6. Suppliers and ContactTitles*/
SELECT 
    SupplierID, ContactName, ContactTitle
FROM
    Suppliers
WHERE
    contactTitle <> 'marketing manager';


/*7. Products with “queso” in ProductName*/
SELECT 
    ProductID, ProductName
FROM
    Products
WHERE
    ProductName LIKE '%queso%';


/*8. Orders shipping to France or Belgium*/
SELECT 
    OrderID, CustomerID, ShipCountry
FROM
    Orders
WHERE
    ShipCountry IN ('France' , 'Belgium');


/*9. Orders shipping to any country in Latin America*/
SELECT 
    OrderID, CustomerID, ShipCountry
FROM
    Orders
WHERE
    ShipCountry IN ('Brazil' , 'Mexico', 'Argentina', 'Venezuela');


/*10. Employees, in order of age*/
SELECT 
    FirstName, LastName, Title, BirthDate
FROM
    Employees
ORDER BY BirthDate;


/*11. Showing only the Date with a DateTime field*/
SELECT 
    FirstName,
    LastName,
    Title,
    DATE_FORMAT(BirthDate, '%Y-%m-%d') AS DateOnlyBirthDate
FROM
    Employees
ORDER BY BirthDate;


/*12. Employees full name*/
SELECT 
    FirstName,
    LastName,
    CONCAT(FirstName, ' ', lastName) AS FullName
FROM
    Employees;


/*13. OrderDetails amount per line item*/
SELECT 
    OrderId,
    ProductID,
    UnitPrice,
    Quantity,
    (Quantity * UnitPrice) AS TotalPrice
FROM
    OrderDetails
ORDER BY OrderID , ProductID;


/*14. How many customers?*/
SELECT 
    COUNT(CustomerID) AS TotalCustomers
FROM
    Customers;


/*15. When was the first order?*/
SELECT 
    OrderDate AS FirstOrder
FROM
    Orders
ORDER BY orderdate
LIMIT 1;