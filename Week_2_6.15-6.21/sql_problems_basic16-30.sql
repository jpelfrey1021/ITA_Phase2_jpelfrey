/*16. Countries where there are customers*/
SELECT 
    Country
FROM
    Customers
GROUP BY Country
ORDER BY Country;


/*17. Contact titles for customers*/
SELECT 
    ContactTitle, COUNT(ContactTitle) AS TotalContactTitle
FROM
    Customers
GROUP BY ContactTitle
ORDER BY COUNT(ContactTitle) DESC , ContactTitle;


/*18. Products with associated supplier names*/
SELECT 
    p.ProductID, P.ProductName, S.CompanyName AS Supplier
FROM
    Products P
        INNER JOIN
    Suppliers S ON P.SupplierID = S.SupplierID;


/*19. Orders and the Shipper that was used*/
SELECT 
    O.OrderID,
    DATE_FORMAT(O.OrderDate, '%Y-%m-%d') AS OrderDate,
    S.CompanyName AS Shipper
FROM
    Orders O
        INNER JOIN
    Shippers S ON O.ShipVia = S.ShipperID
WHERE
    O.OrderID < 10270
ORDER BY S.OrderID;


/*20. Categories, and the total products in each category*/
SELECT 
    c.CategoryName, COUNT(p.productID) AS TotalProducts
FROM
    Products p
        INNER JOIN
    categories c ON p.categoryid = c.categoryid
GROUP BY c.categoryName
ORDER BY COUNT(p.productID) DESC;


/*21. Total customers per country/city*/
SELECT 
    Country, City, COUNT(CustomerID) AS TotalCustomers
FROM
    Customers
GROUP BY city , country
ORDER BY TotalCustomers DESC , city , country;


/*22. Products that need reordering*/
SELECT 
    ProductID, ProductName, UnitsInStock, ReorderLevel
FROM
    Products
WHERE
    UnitsInStock <= ReorderLevel;


/*23. Products that need reordering, continued*/
SELECT 
    ProductID,
    ProductName,
    UnitsInStock,
    UnitsOnOrder,
    ReorderLevel,
    Discontinued
FROM
    Products
WHERE
    (UnitsInStock + UnitsOnOrder) <= ReorderLevel
        AND Discontinued = 0;


/*24. Customer list by region*/
SELECT 
    CustomerID, CompanyName, Region
FROM
    Customers
ORDER BY - region DESC , region , CustomerID;


/*25. High freight charges*/
SELECT 
    ShipCountry, AVG(Freight) AS AverageFreight
FROM
    Orders
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;


/*26. High freight charges—2015*/
SELECT 
    ShipCountry, AVG(Freight) AS AverageFreight
FROM
    Orders
WHERE
    YEAR(OrderDate) = 2015
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;


/*27. High freight charges with between*/
OrderID = 10806;

/*28. High freight charges—last year*/
SELECT 
    ShipCountry, AVG(Freight) AS AverageFreight
FROM
    Orders
WHERE
    DATE_ADD((SELECT 
                MAX(OrderDate)
            FROM
                Orders),
        INTERVAL - 1 YEAR)
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;


/*29. Employee/Order Detail report*/
SELECT 
    o.EmployeeID,
    e.lastName,
    o.OrderID,
    p.ProductName,
    od.Quantity
FROM
    Orders o
        INNER JOIN
    orderdetails od ON o.OrderID = od.OrderID
        INNER JOIN
    products p ON od.productid = p.productid
        INNER JOIN
    employees e ON o.employeeid = e.employeeid
;

/*30. Customers with no orders*/
SELECT 
    c.customerId AS Customers_CustomerID,
    o.customerid AS Orders_CustomerID
FROM
    customers c
        LEFT JOIN
    orders o ON c.customerid = o.customerid
WHERE
    o.customerid IS NULL;
