/*16. Orders for products that were unavailable: details*/
SELECT 
    OD.ProductID,
    DATE(O.OrderDate) AS OrderDate,
    P.ProductName,
    OD.OrderQty AS Qty,
    DATE(P.SellStartDate) AS SellStartDate,
    DATE(P.SellEndDate) AS SellEndDate,
    CASE
        WHEN O.OrderDate < P.SellStartDate THEN 'Sold before start date'
        WHEN O.OrderDate > P.SellEndDate THEN 'Sold after end date'
    END AS ProblemType
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

/*17. OrderDate with time component*/
SELECT 
    COUNT(SalesOrderID) AS TotalOrdersWithTime,
    (SELECT 
            COUNT(*)
        FROM
            SalesOrderHeader) AS TotalOrders,
    COUNT(SalesOrderID) / (SELECT 
            COUNT(*)
        FROM
            SalesOrderHeader) AS PercentOrdersWithTime
FROM
    SalesOrderHeader
WHERE
    TIME(OrderDate);


/*18. Fix this SQL! Number 1*/
SELECT 
    Product.ProductID,
    ProductName,
    ProductSubCategoryName,
    DATE(MIN(OrderDate)) AS FirstOrder,
    DATE(MAX(OrderDate)) AS LastOrder
FROM
    Product
        LEFT JOIN
    SalesOrderDetail Detail ON Product.ProductID = Detail.ProductID
        LEFT JOIN
    SalesOrderHeader Header ON Header.SalesOrderID = Detail.SalesOrderID
        LEFT JOIN
    ProductSubCategory ON ProductSubCategory.ProductSubCategoryID = Product.ProductSubCategoryID
WHERE
    Color = 'Silver'
GROUP BY Product.ProductID , ProductName , ProductSubCategoryName
ORDER BY LastOrder DESC;


/*19. Raw margin quartile for products*/
SELECT ProductID, ProductName, StandardCost, ListPrice, ListPrice - StandardCost as RawMargin, NTILE(4) OVER(ORDER BY ListPrice - StandardCost desc) as Quartile
FROM 
Product
where ListPrice != 0 and StandardCost != 0
order by ProductName;


/*20. Customers with purchases from multiple sales people*/
SELECT 
    O.CustomerID,
    CONCAT(C.firstname, ' ', C.lastname) AS CustomerName,
    COUNT(SalesPersonEmployeeID) AS TotalDifferentSalesPeople
FROM
    SalesOrderHeader O
        JOIN
    Customer C ON C.CustomerID = O.CustomerID
GROUP BY O.CustomerID , CONCAT(C.firstname, ' ', C.lastname)
HAVING COUNT(DISTINCT SalesPersonEmployeeID) > 1
ORDER BY 2;


/*21. Fix this SQL! Number 2*/
SELECT 
    C.CustomerID,
    CONCAT(FirstName, ' ', LastName) AS CustomerName,
    OrderDate,
    O.SalesOrderID,
    OD.ProductID,
    P.ProductName,
    LineTotal
FROM
    SalesOrderHeader O
        JOIN
    SalesOrderDetail OD ON O.SalesOrderID = OD.SalesOrderID
        JOIN
    Product P ON P.ProductID = OD.ProductID
        JOIN
    Customer C ON C.CustomerID = O.CustomerID
ORDER BY CustomerID , OrderDate
LIMIT 100;


/*22. Duplicate product*/
SELECT 
    ProductName
FROM
    Product
GROUP BY ProductName
HAVING COUNT(*) > 1;


/*23. Duplicate product: details*/
WITH Main AS (
    SELECT
		ProductID
		,ProductName
		,ROW_NUMBER() OVER (PARTITION BY ProductName ORDER BY ProductID) AS RowNumber
    From Product
)
SELECT
    Main.ProductID AS PotentialDuplicateProductID
    ,ProductName
FROM Main
WHERE
    RowNumber <> 1;


/*24. How many cost changes do products generally have?*/
WITH changes AS (
	SELECT ProductID, count(*) as TotalChanges
	FROM ProductCostHistory 
	GROUP BY ProductID)

SELECT 
    TotalChanges, COUNT(*) AS TotalProducts
FROM
    changes
GROUP BY TotalChanges
ORDER BY TotalChanges


/*25. Size and base ProductNumber for products*/
SELECT 
    ProductID,
    ProductNumber,
    POSITION('-' IN ProductNumber) AS HyphenLocation,
    SUBSTRING_INDEX(ProductNumber, '-', 1) AS BaseProductNumber,
    IF(SUBSTRING_INDEX(ProductNumber, '-', - 1) = SUBSTRING_INDEX(ProductNumber, '-', 1),
        NULL,
        SUBSTRING_INDEX(ProductNumber, '-', - 1)) AS Size
FROM
    Product
WHERE
    ProductID > 533
ORDER BY ProductID


/*26. Number of sizes for each base product number*/
SELECT 
    SUBSTRING_INDEX(ProductNumber, '-', 1) AS BaseProductNumber,
    COUNT(*)
FROM
    Product
        JOIN
    ProductSubCategory ON ProductSubCategory.ProductSubcategoryID = Product.ProductSubCategoryID
WHERE
    ProductSubCategory.ProductCategoryID = 3
GROUP BY SUBSTRING_INDEX(ProductNumber, '-', 1)
ORDER BY 1


/*27. How many cost changes has each product really had?*/
SELECT 
    Product.ProductID,
    ProductName,
    COUNT(DISTINCT (ProductCostHistory.StandardCost)) AS TotalCostChanges
FROM
    ProductCostHistory
        JOIN
    Product ON Product.ProductID = productCostHistory.ProductID
GROUP BY Product.ProductID , ProductName
ORDER BY Product.ProductID;


/*28. Which products had the largest increase in cost?*/
WITH Main AS (
    SELECT
        ProductID
        ,StartDate
        ,StandardCost
        ,LAG(StandardCost, 1) OVER (PARTITION BY ProductID ORDER BY StartDate)
            AS PreviousStandardCost
    FROM ProductCostHistory
) 
SELECT 
    Main.ProductID,
    Main.StartDate AS CostChangeDate,
    Main.StandardCost,
    Main.PreviousStandardCost,
    Main.PreviousStandardCost - Main.StandardCost AS PriceDifference
FROM
    Main
WHERE
    PreviousStandardCost IS NOT NULL
ORDER BY PriceDifference DESC;


/*29. Fix this SQL! Number 3*/
with FraudSuspects as (
SELECT 
    *
FROM
    Customer
WHERE
    CustomerID IN (29401 , 11194,
        16490,
        22698,
        26583,
        12166,
        16036,
        25110,
        18172,
        11997,
        26731)
), 

SampleCustomers as (
SELECT 
    *
FROM
    Customer
WHERE
    CustomerID NOT IN (Select CustomerID From FraudSuspects)
ORDER BY RAND()
LIMIT 100
)

SELECT 
    *
FROM
    FraudSuspects 
UNION ALL SELECT 
    *
FROM
    SampleCustomers;


/*30. History table with start/end date overlap*/
SELECT 
    Calendar.CalendarDate, ProductID, COUNT(*) AS TotalRows
FROM
    Calendar
        JOIN
    ProductListPriceHistory ON ProductListPriceHistory.StartDate <= Calendar.CalendarDate
        AND ProductListPriceHistory.EndDate >= Calendar.CalendarDate
GROUP BY Calendar.CalendarDate , ProductID
HAVING COUNT(*) > 1
ORDER BY Calendar.CalendarDate;

