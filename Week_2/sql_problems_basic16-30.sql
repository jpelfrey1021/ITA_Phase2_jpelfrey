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



/*21. Total customers per country/city*/



/*22. Products that need reordering*/



/*23. Products that need reordering, continued*/



/*24. Customer list by region*/



/*25. High freight charges*/



/*26. High freight charges—2015*/



/*27. High freight charges with between*/


/*28. High freight charges—last year*/



/*29. Employee/Order Detail report*/



/*30. Customers with no orders*/