/*1. Cost changes for each product*/
SELECT 
    ProductID, COUNT(ProductID)
FROM
    ProductCostHistory
GROUP BY ProductID;


/*2. Customers with total orders placed*/
SELECT 
    CustomerID, COUNT(SalesOrderID)
FROM
    SalesOrderHeader
GROUP BY CustomerID
ORDER BY 2 DESC , 1;


/*3. Products with first and last order date*/
SELECT 
    OD.ProductID,
    DATE(MIN(o.orderdate)) AS FirstOrder,
    DATE(MAX(O.OrderDate)) AS LastOrder
FROM
    SalesOrderHeader O
        JOIN
    SalesOrderDetail OD ON O.SalesOrderID = OD.SalesOrderID
GROUP BY OD.ProductID
ORDER BY productid


/*4. Products with first and last order date, including name*/
SELECT 
    OD.ProductID,
    p.ProductName,
    DATE(MIN(o.orderdate)) AS FirstOrder,
    DATE(MAX(O.OrderDate)) AS LastOrder
FROM
    SalesOrderHeader O
        JOIN
    SalesOrderDetail OD ON O.SalesOrderID = OD.SalesOrderID
        JOIN
    Product P ON OD.ProductID = P.ProductID
GROUP BY OD.ProductID
ORDER BY productid



/*5. Product cost on a specific date*/
SELECT 
	ProductID,
    StandardCost
FROM
    ProductCostHistory
WHERE
    StartDate < '2012-04-15'
        AND (EndDate > '2012-04-15'
        OR EndDate IS NULL);


/*6. Product cost on a specific date, part 2*/
SELECT 
    ProductID, StandardCost
FROM
    ProductCostHistory
WHERE
    StartDate < '2014-04-15'
        AND (EndDate > '2014-04-15'
        OR EndDate IS NULL);


/*7. Product List Price: how many price changes?*/
SELECT 
    DATE_FORMAT(StartDate, '%Y/%m') AS ProductListPriceMonth,
    COUNT(*) AS TotalRows
FROM
    ProductListPriceHistory
GROUP BY DATE_FORMAT(StartDate, '%Y/%m');


/*8. Product List Price: months with no price changes?*/
SELECT 
    C.CalendarMonth, COUNT(P.StartDate) AS TotalRows
FROM
    ProductListPriceHistory P
        RIGHT JOIN
    Calendar C ON P.startDate = C.Calendardate
WHERE
    C.CalendarDate >= (SELECT 
            MIN(StartDate)
        FROM
            ProductListPriceHistory)
        AND C.CalendarDate <= (SELECT 
            MAX(StartDate)
        FROM
            ProductListPriceHistory)
GROUP BY c.calendarmonth
ORDER BY CalendarMonth;


/*9. Current list price of every product*/
SELECT 
    ProductID, ListPrice
FROM
    ProductListPriceHistory
WHERE
    EndDate IS NULL;


/*10. Products without a list price history*/
SELECT 
    P.ProductID,
    P.ProductName
FROM
    ProductListPriceHistory H
        RIGHT JOIN
    Product P ON P.ProductID = H.ProductID
WHERE
    H.productID IS NULL
ORDER BY P.ProductID;


/*11. Product cost on a specific date, part 3*/
SELECT 
    ProductID
FROM
    ProductCostHistory
WHERE
    ProductID NOT IN (SELECT 
            ProductID
        FROM
            ProductCostHistory
        WHERE
            StartDate < '2014-04-15'
                AND (EndDate > '2014-04-15'
                OR EndDate IS NULL))


/*12. Products with multiple current list price records*/
SELECT 
    ProductID
FROM
    ProductListPriceHistory
WHERE
    EndDate IS NULL
GROUP BY ProductID
HAVING COUNT(*) > 1;


/*13. Products with their first and last order date, 
including name and subcategory*/
SELECT 
    OD.ProductID,
    p.ProductName,
    C.ProductSubCategoryName,
    DATE(MIN(o.orderdate)) AS FirstOrder,
    DATE(MAX(O.OrderDate)) AS LastOrder
FROM
    product P
        LEFT JOIN
    SalesOrderDetail OD ON OD.ProductID = P.ProductID
        LEFT JOIN
    SalesOrderHeader O ON O.SalesOrderID = OD.SalesOrderID
        LEFT JOIN
    ProductSubCategory C ON C.ProductSubcategoryID = p.productsubcategoryid
GROUP BY P.ProductID
ORDER BY P.ProductName


/*14. Products with list price discrepancies*/
SELECT 
    P.ProductID,
    P.ProductName,
    P.ListPrice AS Prod_ListPrice,
    H.ListPrice AS PriceHist_LatestListPrice,
    P.ListPrice - H.ListPrice AS Diff
FROM
    Product P
        RIGHT JOIN
    (SELECT 
        *
    FROM
        ProductListPriceHistory
    WHERE
        enddate IS NULL) H ON H.productid = p.productid
WHERE
    P.ListPrice != H.ListPrice;


/*15. Orders for products that were unavailable*/
SELECT 
    OD.ProductID,
    DATE(O.OrderDate) AS OrderDate,
    P.ProductName,
    OD.OrderQty AS Qty,
    DATE(P.SellStartDate) AS SellStartDate,
    DATE(P.SellEndDate) AS SellEndDate
FROM
    SalesOrderHeader O
        JOIN
    SalesOrderDetail OD ON OD.SalesOrderID = O.SalesOrderID
        JOIN
    Product P ON OD.ProductID = P.ProductID
WHERE
    P.SellEndDate IS NOT NULL
        AND O.OrderDate NOT BETWEEN P.SellStartDate AND P.SellEndDate
ORDER BY OD.ProductID , O.OrderDate;

