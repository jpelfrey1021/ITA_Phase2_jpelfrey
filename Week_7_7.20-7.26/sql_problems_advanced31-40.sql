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



/*33. Total late orders by territory*/



/*34. OrderDate with time component—performance aspects*/



/*35. Customer's last purchase—what was the product subcategory?*/



/*36. Order processing: time in each stage*/



/*37. Order processing: time in each stage, part 2*/



/*38. Order processing: time in each stage, part 3*/



/*39. Top three product subcategories per customer*/


/*40. History table with date gaps*/


