/*46. Late orders vs. total orders—percentage*/
WITH LateOrders as (
SELECT 
    O.EmployeeID, COUNT(*) AS LateOrders
FROM
    Orders O
WHERE
    O.ShippedDate >= O.RequiredDate
GROUP BY O.EmployeeID),
TotalOrders as (
SELECT 
    O.EmployeeID, COUNT(*) AS AllOrders
FROM
    Orders O
        JOIN
    Employees E ON O.EmployeeID = E.EmployeeID
GROUP BY O.EmployeeID , E.LastName)

SELECT 
    T.EmployeeID,
    E.LastName,
    T.AllOrders,
    IFNULL(L.LateOrders,0) as LateOrders,
    (IFNULL(L.LateOrders,0) / T.AllOrders) as PercentLateOrders
FROM
    Employees E
        LEFT JOIN
    TotalOrders T ON T.EmployeeID = E.EmployeeID
        LEFT JOIN
    LateOrders L ON L.Employeeid = E.employeeid
ORDER BY E.EmployeeID


/*47. Late orders vs. total orders—fix decimal*/
WITH LateOrders as (
SELECT 
    O.EmployeeID, COUNT(*) AS LateOrders
FROM
    Orders O
WHERE
    O.ShippedDate >= O.RequiredDate
GROUP BY O.EmployeeID),
TotalOrders as (
SELECT 
    O.EmployeeID, COUNT(*) AS AllOrders
FROM
    Orders O
        JOIN
    Employees E ON O.EmployeeID = E.EmployeeID
GROUP BY O.EmployeeID , E.LastName)

SELECT 
    T.EmployeeID,
    E.LastName,
    T.AllOrders,
    IFNULL(L.LateOrders,0) as LateOrders,
    Round((IFNULL(L.LateOrders,0) / T.AllOrders),2) as PercentLateOrders
FROM
    Employees E
        LEFT JOIN
    TotalOrders T ON T.EmployeeID = E.EmployeeID
        LEFT JOIN
    LateOrders L ON L.Employeeid = E.employeeid
ORDER BY E.EmployeeID


/*48. Customer grouping*/
SELECT 
    c.CustomerID,
    c.CompanyName,
    SUM(od.UnitPrice * od.quantity) AS TotalOrderAmount,
    CASE
        WHEN SUM(od.UnitPrice * od.quantity) < 1000 THEN 'Low'
        WHEN
            SUM(od.UnitPrice * od.quantity) > 1000
                AND SUM(od.UnitPrice * od.quantity) < 5000
        THEN
            'Medium'
        WHEN
            SUM(od.UnitPrice * od.quantity) > 5000
                AND SUM(od.UnitPrice * od.quantity) < 10000
        THEN
            'High'
        ELSE 'Very High'
    END AS CustomerGroup
FROM
    Orders o
        JOIN
    customers c ON o.customerId = c.customerID
        JOIN
    OrderDetails od ON o.orderId = od.orderID
WHERE
    YEAR(o.OrderDate) = 2016
GROUP BY c.customerid , c.companyname
ORDER BY CustomerID


/*49. Customer grouping—fix null*/
/*did it right the first time*/
SELECT 
    c.CustomerID,
    c.CompanyName,
    SUM(od.UnitPrice * od.quantity) AS TotalOrderAmount,
    CASE
        WHEN SUM(od.UnitPrice * od.quantity) < 1000 THEN 'Low'
        WHEN
            SUM(od.UnitPrice * od.quantity) > 1000
                AND SUM(od.UnitPrice * od.quantity) < 5000
        THEN
            'Medium'
        WHEN
            SUM(od.UnitPrice * od.quantity) > 5000
                AND SUM(od.UnitPrice * od.quantity) < 10000
        THEN
            'High'
        ELSE 'Very High'
    END AS CustomerGroup
FROM
    Orders o
        JOIN
    customers c ON o.customerId = c.customerID
        JOIN
    OrderDetails od ON o.orderId = od.orderID
WHERE
    YEAR(o.OrderDate) = 2016
GROUP BY c.customerid , c.companyname
ORDER BY CustomerID


/*50. Customer grouping with percentage*/
with customerGrouping as (
SELECT 
        c.CustomerID,
            c.CompanyName,
            CASE
                WHEN SUM(od.UnitPrice * od.quantity) < 1000 THEN 'Low'
                WHEN
                    SUM(od.UnitPrice * od.quantity) > 1000
                        AND SUM(od.UnitPrice * od.quantity) < 5000
                THEN
                    'Medium'
                WHEN
                    SUM(od.UnitPrice * od.quantity) > 5000
                        AND SUM(od.UnitPrice * od.quantity) < 10000
                THEN
                    'High'
                ELSE 'Very High'
            END AS customerGroup
    FROM
        Orders o
    JOIN customers c ON o.customerId = c.customerID
    JOIN OrderDetails od ON o.orderId = od.orderID
    WHERE
        YEAR(o.OrderDate) = 2016
    GROUP BY c.customerid , c.companyname
    ORDER BY CustomerID
)

SELECT 
    CustomerGroup,
    COUNT(*) AS TotalInGroup,
    COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            CustomerGrouping) AS PercentageInGroup
FROM
    CustomerGrouping
GROUP BY CustomerGroup
ORDER BY TotalInGroup DESC;


/*51. Customer grouping—flexible*/
with Orders2016 as (
    Select
        Customers.CustomerID
		,Customers.CompanyName
        ,SUM(Quantity * UnitPrice) as TotalOrderAmount
    From Customers
        Join Orders
            on Orders.CustomerID = Customers.CustomerID
        Join OrderDetails
            on Orders.OrderID = OrderDetails.OrderID
    Where
        YEAR(OrderDate) = 2016
    Group by Customers.CustomerID ,Customers.CompanyName
) 

Select
    CustomerID
    ,CompanyName
    ,TotalOrderAmount
    ,CustomerGroupName
from Orders2016
    Join CustomerGroupThresholds
        on Orders2016.TotalOrderAmount between
            CustomerGroupThresholds.RangeBottom
            and CustomerGroupThresholds.RangeTop
Order by CustomerID;


/*52. Countries with suppliers or customers*/
SELECT 
    Country
FROM
    Customers 
UNION SELECT 
    Country
FROM
    Suppliers
ORDER BY Country;


/*53. Countries with suppliers or customers, version 2*/
WITH AllCountries AS
(SELECT 
    Country
FROM
    Suppliers 
UNION SELECT 
    Country
FROM
    Customers
),

SupplierCountries AS
(SELECT DISTINCT
    Country
FROM
    Suppliers),

CustomerCountries AS
(SELECT DISTINCT
    Country
FROM
    Customers)

SELECT 
    s.Country AS SupplierCountry, c.Country AS CustomerCountry
FROM
    AllCountries a
        LEFT JOIN
    CustomerCountries c ON a.Country = c.Country
        LEFT JOIN
    SupplierCountries s ON a.Country = s.Country
ORDER BY a.Country;



/*54. Countries with suppliers or customers, version 3*/
WITH AllCountries AS
(SELECT DISTINCT
    Country
FROM
    Suppliers 
UNION SELECT DISTINCT
    Country
FROM
    Customers
),

SupplierCountries AS
(SELECT 
    Country, COUNT(*) AS Total
FROM
    Suppliers
GROUP BY Country),

CustomerCountries AS
(SELECT 
    Country, COUNT(*) AS Total
FROM
    Customers
GROUP BY Country)

SELECT 
    a.Country,
    IFNULL(s.Total,0) AS TotalSuppliers,
    IFNULL(c.Total,0) AS TotalCustomers
FROM
    AllCountries a
        LEFT JOIN
    CustomerCountries c ON a.Country = c.Country
        LEFT JOIN
    SupplierCountries s ON a.Country = s.Country
ORDER BY a.Country;


/*55. First order in each country*/
WITH OrdersByCountry AS (
    SELECT
        ShipCountry
        ,CustomerID
        ,OrderID
        ,DATE(OrderDate) AS OrderDate
        ,ROW_NUMBER()
            OVER (PARTITION BY ShipCountry ORDER BY ShipCountry, OrderID)
            AS RowNumberPerCountry
    FROM Orders
) 

SELECT 
    ShipCountry, CustomerID, OrderID, OrderDate
FROM
    OrdersByCountry
WHERE
    RowNumberPerCountry = 1
ORDER BY ShipCountry;


/*56. Customers with multiple orders in 5 day period*/
SELECT 
    init.CustomerID,
    init.OrderID AS InitialOrderID,
    DATE(init.OrderDate) AS InitialOrderDate,
    nex.OrderID AS NextOrderID,
    DATE(nex.orderdate) AS NextOrderDate,
    DATEDIFF(Nex.OrderDate, init.OrderDate) AS DaysBetweenOrders
FROM
    Orders init
        JOIN
    orders nex ON nex.customerid = init.customerid
WHERE
    init.orderid < nex.orderid
        AND DATEDIFF(Nex.OrderDate, init.OrderDate) <= 5
ORDER BY customerid , init.OrderID;


/*57. Customers with multiple orders in 5 day period, version 2*/
WITH NextOrderDate AS (
    SELECT
        CustomerID
        ,DATE(OrderDate) AS InitialOrderDate
        ,DATE(LEAD(OrderDate,1)
            OVER (PARTITION BY CustomerID ORDER BY CustomerID, OrderDate)
            ) AS NextOrderDate
    FROM Orders
) 
SELECT 
    CustomerID,
    InitialOrderDate,
    NextOrderDate,
    DATEDIFF(NextOrderDate, InitialOrderDate) AS DaysBetweenOrders
FROM
    NextOrderDate
WHERE
    DATEDIFF(NextOrderDate, InitialOrderDate) <= 5;

