/*31. History table with start/end date overlap, part 2*/
SELECT 
    Calendar.CalendarDate, ProductID, COUNT(*) AS TotalRows
FROM
    Calendar
        JOIN
    ProductListPriceHistory ON ProductListPriceHistory.StartDate <= Calendar.CalendarDate
        AND IFNULL(ProductListPriceHistory.EndDate,
            '2013-05-29') >= Calendar.CalendarDate
GROUP BY Calendar.CalendarDate , ProductID
HAVING COUNT(*) > 1
ORDER BY ProductID , Calendar.CalendarDate;


/*32. Running total of orders in last year*/
WITH FilteredOrders AS (
    SELECT
		C.CalendarMonth ,Count(SalesOrderID) AS TotalOrders
	FROM SalesOrderHeader
        JOIN Calendar C
			ON C.CalendarDate = DATE(OrderDate)
	WHERE
		OrderDate >=
			Date_Add(
				(SELECT DATE(MAX(OrderDate)) FROM SalesOrderHeader) , INTERVAL -1 YEAR)
    GROUP BY CalendarMonth)
    
SELECT
    CalendarMonth
    ,TotalOrders
    ,Sum(TotalOrders)  OVER (ORDER BY CalendarMonth) AS RunningTotal
FROM FilteredOrders
ORDER BY CalendarMonth;


/*33. Total late orders by territory*/
WITH LateOrders AS (
SELECT 
    TerritoryID, COUNT(SalesOrderID) AS TotalLateOrders
FROM
    SalesOrderHeader
WHERE
    DueDate < ShipDate
GROUP BY TerritoryID
)


SELECT 
    O.TerritoryID,
    T.TerritoryName,
    T.CountryCode,
    COUNT(O.SalesOrderID) AS TotalOrders,
    L.TotalLateOrders
FROM
    SalesOrderHeader O
        JOIN
    SalesTerritory T ON T.TerritoryID = O.TerritoryID
        JOIN
    LateOrders L ON L.TerritoryID = O.TerritoryID
GROUP BY O.TerritoryID
ORDER BY O.TerritoryID;


/*34. OrderDate with time component—performance aspects*/
/*solution 3 was the worst, because it has so many sub queries inside*/


/*35. Customer's last purchase—what was the product subcategory?*/
WITH CustomerOrders AS (
SELECT 
    C.CustomerID,
    CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName,
    O.OrderDate,
    O.SalesOrderID,
    OD.ProductID,
    OD.LineTotal,
    PC.ProductSubCategoryName,
    ROW_NUMBER () OVER ( PARTITION BY C.CustomerID ORDER BY O.OrderDate DESC, OD.LineTotal DESC ) AS RowNumber
FROM
    Customer C
        JOIN
    SalesOrderHeader O ON O.CustomerID = C.CustomerID
        JOIN
    SalesOrderDetail OD ON O.SalesOrderID = OD.SalesOrderID
        JOIN
    Product P ON P.ProductID = OD.ProductID
        JOIN
    ProductSubCategory PC ON PC.ProductSubcategoryID = P.ProductSubcategoryID
WHERE
    O.CustomerID IN (19500 , 19792, 24409, 26785)
)

SELECT 
    CustomerID, CustomerName, ProductSubCategoryName
FROM
    CustomerOrders
WHERE
    RowNumber = 1;


/*36. Order processing: time in each stage*/
WITH Main AS (
SELECT 
    SalesOrderID, 
    T.TrackingEventID, 
    EventName, 
    EventDateTime AS TrackingEventDate, 
    LEAD(EventDateTime , 1)
		OVER (PARTITION BY SalesOrderID ORDER BY EventDateTime)
		AS NextTrackingEventDate
FROM
    OrderTracking OT
        JOIN
    TrackingEvent T ON T.TrackingEventID = OT.TrackingEventID
WHERE
    SalesOrderID IN (68857 , 70531, 70421))

SELECT 
    SalesOrderID,
    EventName,
    DATE_FORMAT(TrackingEventDate, '%Y-%m-%d %H:%i') AS TrackingEventDate,
    DATE_FORMAT(NextTrackingEventDate, '%Y-%m-%d %H:%i') AS NextTrackingEventDate,
    TIMESTAMPDIFF(HOUR,
        TrackingEventDate,
        NextTrackingEventDate) AS HoursInStage
FROM
    Main
ORDER BY SalesOrderID , TrackingEventDate;



/*37. Order processing: time in each stage, part 2*/
WITH Main AS (
SELECT 
    OT.SalesOrderID,
    IF(OnlineOrderFlag = 1, 'Online', 'Offline') AS OnlineOfflineStatus,
    T.TrackingEventID, 
    EventName, 
    EventDateTime AS TrackingEventDate, 
    LEAD(EventDateTime , 1)
		OVER (PARTITION BY SalesOrderID ORDER BY EventDateTime)
		AS NextTrackingEventDate
FROM
    OrderTracking OT
        JOIN
    TrackingEvent T ON T.TrackingEventID = OT.TrackingEventID
		JOIN 
	SalesOrderHeader S on S.SalesOrderID = OT.SalesOrderID
)

SELECT 
    OnlineOfflineStatus,
    EventName,
    AVG(TIMESTAMPDIFF(HOUR,
        TrackingEventDate,
        NextTrackingEventDate)) AS AverageHoursInStage
FROM
    Main 
group by OnlineOfflineStatus, TrackingEventID
ORDER BY 1, TrackingEventID;


/*38. Order processing: time in each stage, part 3*/
WITH Main AS (
SELECT 
    OT.SalesOrderID,
    IF(OnlineOrderFlag = 1, 'Online', 'Offline') AS OnlineOfflineStatus,
    T.TrackingEventID, 
    EventName, 
    EventDateTime AS TrackingEventDate, 
    LEAD(EventDateTime , 1)
		OVER (PARTITION BY SalesOrderID ORDER BY EventDateTime)
		AS NextTrackingEventDate
FROM
    OrderTracking OT
        JOIN
    TrackingEvent T ON T.TrackingEventID = OT.TrackingEventID
		JOIN 
	SalesOrderHeader S on S.SalesOrderID = OT.SalesOrderID
), 
MainGrouped AS (
SELECT 
    OnlineOfflineStatus,
    EventName,
    TrackingEventID,
    AVG(TIMESTAMPDIFF(HOUR,
        TrackingEventDate,
        NextTrackingEventDate)) AS AverageHoursSpentInStage
FROM
    Main
GROUP BY OnlineOfflineStatus , EventName , TrackingEventID
)

SELECT 
    Offline.EventName,
    Offline.AverageHoursSpentInStage AS OfflineAvgHoursInStage,
    Online.AverageHoursSpentInStage AS OnlineAvgHoursInStage
FROM
    (SELECT * FROM MainGrouped WHERE OnlineOfflineStatus = 'Offline') Offline
        JOIN
    (SELECT * FROM MainGrouped WHERE OnlineOfflineStatus = 'Online') Online 
        ON Offline.EventName = Online.EventName
ORDER BY Offline.TrackingEventID;



/*39. Top three product subcategories per customer*/
With Main as (
    SELECT 
		Customer.CustomerID,
		CONCAT(FirstName, ' ', LastName) AS CustomerName,
		LineTotal = SUM(LineTotal),
		ProductSubCategoryName,
		ROW_NUMBER() over (Partition By Customer.CustomerID Order by Sum(LineTotal) desc) as RowNumber
    FROM SalesOrderDetail Detail
        JOIN SalesOrderHeader Header
			ON Header.SalesOrderID = Detail.SalesOrderID 
		JOIN Product
			ON Product.ProductID = Detail.ProductID 
		JOIN Customer
			ON Customer.CustomerID =Header.CustomerID 
		LEFT JOIN ProductSubCategory SubCat
			ON SubCat.ProductSubCategoryID = Product.ProductSubCategoryID
	WHERE
		Customer.CustomerID IN (13836, 26313, 20331, 21113, 13763) 
	GROUP BY
		Customer.CustomerID,
        CONCAT(FirstName, ' ', LastName),
        ProductSubCategoryName, 
        LineTotal
) 

SELECT
	ProductSubCat1.CustomerID,
    ProductSubCat1.CustomerName,
    Min(ProductSubCat1.ProductSubCategoryName) as TopProdSubCat1,
    Min(ProductSubCat2.ProductSubCategoryName) as TopProdSubCat2,
    Min(ProductSubCat3.ProductSubCategoryName) as TopProductSubCat3
FROM 
	(SELECT * FROM Main WHERE RowNumber = 1 ) ProductSubCat1
	LEFT JOIN 
		(SELECT * FROM Main WHERE RowNumber = 2 ) ProductSubCat2
			ON ProductSubCat2.CustomerID = ProductSubCat1.CustomerID
	LEFT JOIN (SELECT * FROM Main WHERE RowNumber = 3 ) ProductSubCat3
			ON ProductSubCat3.CustomerID = ProductSubCat1.CustomerID 
GROUP BY
	ProductSubCat1.CustomerID, ProductSubCat1.CustomerName 
ORDER BY
	ProductSubCat1.CustomerID;


/*40. History table with date gaps*/
WITH HistoryWithMinMax AS (
SELECT 
    ProductID,
    MIN(StartDate) AS FirstStartDate,
    MAX(IFNULL(EndDate, '2014-05-29')) AS LastEndDate
FROM
    ProductListPriceHistory
GROUP BY ProductID
)

,ProductWithDates AS (
SELECT 
    HistoryWithMinMax.ProductID, Calendar.CalendarDate
FROM
    HistoryWithMinMax
        LEFT JOIN
    Calendar ON Calendar.CalendarDate BETWEEN HistoryWithMinMax.FirstStartDate AND HistoryWithMinMax.LastEndDate
)

SELECT 
    ProductWithDates.ProductID,
    ProductWithDates.CalendarDate AS DateWithMissingPrice
FROM
    ProductWithDates
        LEFT JOIN
    ProductListPriceHistory History ON ProductWithDates.CalendarDate BETWEEN History.StartDate AND IFNULL(History.EndDate, '2014-05-29')
        AND History.ProductID = ProductWithDates.ProductID
WHERE
    History.ProductID IS NULL;
