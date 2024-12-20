-- 1. Where are items stored and how many items in tocks per warehouse?

SELECT 
    p.warehouseCode,
    w.warehouseName,
    COUNT(DISTINCT p.productLine) AS productLineQty,
    SUM(p.quantityInStock) AS numberInStocks,
    ROUND(SUM(p.quantityInStock) / 
                (SELECT SUM(quantityInStock)
                FROM products) * 100, 2) percent
FROM products p
JOIN warehouses w 
    ON w.warehouseCode = p.warehouseCode
GROUP BY warehouseCode , warehouseName;

-- 2. Product lines distribution by warehouses

SELECT DISTINCT w.warehouseCode, 
    w.warehouseName, 
    productLine
FROM products p
JOIN warehouses w 
    ON w.warehouseCode = p.warehouseCode
ORDER BY w.warehouseCode;

-- 3. Items Sold per warehouse

SELECT 
    w.warehouseName, SUM(quantityOrdered) AS itemsSold
FROM orderdetails o
JOIN products p 
    ON o.productCode = p.productCode
JOIN warehouses w 
    ON p.warehouseCode = w.warehouseCode
GROUP BY w.warehouseName;

-- 4. Items in stock and quantity sold group by product and warehouse code

SELECT 
    p.warehouseCode,
    p.productLine,
    p.productCode,
    SUM(p.quantityInStock) AS InStocks,
    SUM(o.quantityOrdered) AS qtyordered
FROM products p
JOIN orderdetails o 
    ON o.productCode = p.productCode
GROUP BY p.warehouseCode , p.productCode , p.productLine
ORDER BY qtyordered;

-- 5. Quantity sold monthly and yearly

WITH cte AS (
    SELECT 
        MONTH(orderDate) AS mm, 
        YEAR(orderDate) AS yy, 
        SUM(od.quantityOrdered) AS totalqtyOrders
    FROM orders o 
    JOIN orderdetails od 
        ON o.orderNumber = od.orderNumber 
    GROUP BY 
        MONTH(orderDate), YEAR(orderDate)
)
SELECT 
    mm, 
    yy, 
    SUM(totalqtyOrders) OVER (PARTITION BY mm) AS qtySoldMonthly, 
    SUM(totalqtyOrders) OVER (PARTITION BY yy) AS qtySoldYearly 
FROM cte 
GROUP BY mm, yy
ORDER BY yy, mm;

-- 6. The stock level and quantiy sold per warehouse

SELECT 
    w.warehouseCode,
    w.warehouseName,
    SUM(quantityInStock) AS InStocks,
    SUM(quantityOrdered) AS qtyordered
FROM products p
JOIN orderdetails o 
    ON o.productCode = p.productCode
JOIN warehouses w 
    ON w.warehouseCode = p.warehouseCode
GROUP BY w.warehouseCode , w.warehouseName;

-- 7. Total Revenue of each items order by highest revenue

SELECT 
    p.productLine, tem.productCode, SUM(totalPrice) totalRevenue
FROM
    (SELECT 
        productCode, quantityOrdered * priceEach totalPrice
    FROM orderdetails) tem
JOIN products p 
    ON p.productCode = tem.productCode
GROUP BY tem.productCode , p.productLine
ORDER BY totalRevenue DESC;
    
-- 8. Total Revenue of each items order by lowest revenue
    
SELECT 
    p.productLine, tem.productCode, SUM(totalPrice) totalRevenue
FROM
    (SELECT 
        productCode, quantityOrdered * priceEach totalPrice
    FROM
        orderdetails) tem
JOIN products p 
    ON p.productCode = tem.productCode
GROUP BY tem.productCode , p.productLine
ORDER BY totalRevenue ASC;
    
-- 9. Revenue distribution by each product line
SELECT 
    p.productLine,
    SUM(totalPrice) totalRevenue,
    ROUND(SUM(totalPrice) / 
                    (SELECT SUM(quantityOrdered * priceEach) totalPrice FROM orderdetails) * 100, 2) percent
FROM
    (SELECT 
        productCode, quantityOrdered * priceEach totalPrice
    FROM
        orderdetails) tem
JOIN products p 
    ON p.productCode = tem.productCode
GROUP BY p.productLine
ORDER BY totalRevenue ASC;
    
-- 10. Number of distinct orders
SELECT 
    COUNT(DISTINCT o.orderNumber) distinctOrders
FROM
    orderdetails od
JOIN orders o 
    ON o.orderNumber = od.orderNumber
WHERE status = 'shipped';

-- 11. Shipping duration by each orders
SELECT 
    o.orderNumber,
    DATEDIFF(shippedDate, orderDate) duration,
    comments
FROM
    orderdetails od
JOIN orders o 
    ON o.orderNumber = od.orderNumber
WHERE
    status = 'shipped'
GROUP BY o.orderNumber , DATEDIFF(shippedDate, orderDate)
ORDER BY duration DESC;

-- 12. Number of distinct orders after removing order that are over 10 days
SELECT 
    COUNT(DISTINCT orderNumber) distinctOrders
FROM
    (SELECT 
        o.orderNumber,
            DATEDIFF(shippedDate, orderDate) duration,
            comments
    FROM orderdetails od
JOIN orders o 
    ON o.orderNumber = od.orderNumber
WHERE status = 'shipped'
    AND DATEDIFF(shippedDate, orderDate) < 10
GROUP BY o.orderNumber , DATEDIFF(shippedDate, orderDate)) temp;

-- 13. The common duration of shipping date per productLine for warehosue c and d

SELECT 
    p.productLine,
    DATEDIFF(shippedDate, orderDate) day,
    SUM(quantityOrdered) totalQuantity
FROM orders o
JOIN orderdetails od 
    ON od.orderNumber = o.orderNumber
JOIN products p 
    ON p.productCode = od.productCode
JOIN warehouses w 
    ON w.warehouseCode = p.warehouseCode
WHERE status <> 'shipped'
        AND w.warehouseCode IN ('c' , 'd')
        AND DATEDIFF(shippedDate, orderDate) < 10
GROUP BY p.productLine , DATEDIFF(shippedDate, orderDate)
ORDER BY productLine , DATEDIFF(shippedDate, orderDate) DESC;




