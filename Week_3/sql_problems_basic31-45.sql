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



