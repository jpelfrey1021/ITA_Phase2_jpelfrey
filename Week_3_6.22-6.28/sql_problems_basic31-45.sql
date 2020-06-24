/*31. Customers with no orders for EmployeeID 4*/
SELECT 
    c.CustomerID, o.CustomerID
FROM
    Customers c
        LEFT JOIN
    orders o ON o.CustomerID = c.CustomerID
        AND o.EmployeeID = 4
WHERE
    o.CustomerID IS NULL;

/*32. High-value customers*/
SELECT 
    c.CustomerID,
    c.CompanyName,
    o.OrderID,
    SUM(od.UnitPrice * od.quantity) AS TotalOrderAmount
FROM
    Orders o
        JOIN
    customers c ON o.customerId = c.customerID
        JOIN
    OrderDetails od ON o.orderId = od.orderID
WHERE
    YEAR(o.OrderDate) = 2016
GROUP BY c.customerid , c.companyname , o.orderid
HAVING SUM(od.UnitPrice * od.quantity) > 10000
ORDER BY TotalOrderAmount DESC


/*33. High-value customers—total orders*/
SELECT 
    c.CustomerID,
    c.CompanyName,
    /*o.OrderID,*/
    SUM(od.UnitPrice * od.quantity) AS TotalOrderAmount
FROM
    Orders o
        JOIN
    customers c ON o.customerId = c.customerID
        JOIN
    OrderDetails od ON o.orderId = od.orderID
WHERE
    YEAR(o.OrderDate) = 2016
GROUP BY c.customerid, c.companyname /*o.orderid*/
HAVING SUM(od.UnitPrice * od.quantity) > 15000
ORDER BY TotalOrderAmount DESC


/*34. High-value customers—with discount*/
SELECT 
    c.CustomerID,
    c.CompanyName,
    SUM(od.UnitPrice * od.quantity) AS TotalsWithoutDiscount,
    SUM(od.UnitPrice * od.quantity * (1 - od.discount)) AS TotalsWithDiscount
FROM
    Orders o
        JOIN
    customers c ON o.customerId = c.customerID
        JOIN
    OrderDetails od ON o.orderId = od.orderID
WHERE
    YEAR(o.OrderDate) = 2016
GROUP BY c.customerid , c.companyname
HAVING SUM(od.UnitPrice * od.quantity) > 10000
ORDER BY TotalsWithDiscount DESC


/*35. Month-end orders*/
SELECT 
    EmployeeID, OrderID, OrderDate
FROM
    Orders
WHERE
    DATE(OrderDate) = LAST_DAY(OrderDate)
ORDER BY employeeid;


/*36. Orders with many line items*/
SELECT 
    OrderID, COUNT(orderID) AS TotalOrderDetails
FROM
    OrderDetails
GROUP BY orderid
ORDER BY 2 DESC
LIMIT 10;


/*37. Orders—random assortment*/
SELECT 
    OrderID
FROM
    OrderDetails
GROUP BY orderid
ORDER BY RAND()
LIMIT 10;


/*38. Orders—accidental double-entry*/
SELECT 
    OrderID
FROM
    OrderDetails
WHERE
    Quantity > 60
GROUP BY orderid , quantity
HAVING COUNT(Quantity) > 1
ORDER BY orderid;


/*39. Orders—accidental double-entry details*/
WITH totalOrders AS (SELECT 
    OrderID
FROM
    OrderDetails
WHERE
    Quantity > 60
GROUP BY orderid , quantity
HAVING COUNT(Quantity) > 1
ORDER BY orderid)

SELECT 
    *
FROM
    orderdetails
WHERE
    orderid IN (SELECT 
            orderid
        FROM
            totalOrders)
ORDER BY orderid , quantity;


/*40. Orders—accidental double-entry details, derived table*/
 SELECT 
    OrderDetails.OrderID,
    ProductID,
    UnitPrice,
    Quantity,
    Discount
FROM
    OrderDetails
        JOIN
    (SELECT DISTINCT
        (OrderID)
    FROM
        OrderDetails
    WHERE
        Quantity >= 60
    GROUP BY OrderID , Quantity
    HAVING COUNT(*) > 1) PotentialProblemOrders ON PotentialProblemOrders.OrderID = OrderDetails.OrderID
WHERE
    OrderDetails.OrderID IN (PotentialProblemOrders.OrderID)
ORDER BY OrderID , ProductID;


/*41. Late orders*/
SELECT 
    OrderID, OrderDate, RequiredDate, ShippedDate
FROM
    Orders
WHERE
    ShippedDate >= RequiredDate
ORDER BY OrderID;


/*42. Late orders—which employees?*/
SELECT 
    O.EmployeeID, E.LastName, COUNT(*) AS TotalLateOrders
FROM
    Orders O
        JOIN
    Employees E ON O.EmployeeID = E.EmployeeID
WHERE
    O.ShippedDate >= O.RequiredDate
GROUP BY O.EmployeeID , E.LastName
ORDER BY TotalLateOrders DESC , E.LastName;


/*43. Late orders vs. total orders*/
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
    L.LateOrders
FROM
    Employees E
        JOIN
    TotalOrders T ON T.EmployeeID = E.EmployeeID
        JOIN
    LateOrders L ON L.Employeeid = E.employeeid
ORDER BY L.EmployeeID


/*44. Late orders vs. total orders—missing employee*/
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
    L.LateOrders
FROM
    Employees E
        LEFT JOIN
    TotalOrders T ON T.EmployeeID = E.EmployeeID
        LEFT JOIN
    LateOrders L ON L.Employeeid = E.employeeid
ORDER BY E.EmployeeID


/*45. Late orders vs. total orders—fix null*/
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
    IFNULL(L.LateOrders,0) as LateOrders
FROM
    Employees E
        LEFT JOIN
    TotalOrders T ON T.EmployeeID = E.EmployeeID
        LEFT JOIN
    LateOrders L ON L.Employeeid = E.employeeid
ORDER BY E.EmployeeID

