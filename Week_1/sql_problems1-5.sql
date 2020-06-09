/*1) Which shippers do we have?*/
SELECT * 
FROM Shippers;

/*2) Certain fields from categories*/
SELECT CategoryName, Description
FROM Categories;

/*3) Sales Representatives*/
SELECT FirstName, LastName, HireDate 
FROM Employees
WHERE Title = 'Sales Representative';

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