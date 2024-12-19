/*
1) Where are items stored and if they were rearranged, could a warehouse be eliminated?

2) How are inventory numbers related to sales figures? Do the inventory counts seem appropriate for each item?

3) Are we storing items that are not moving? Are any items candidates for being dropped from the product line?

The answers to questions like those should help you to formulate suggestions and recommendations for reducing inventory with the goal of closing one of the storage facilities. 

Project Objectives

1. Explore products currently in inventory.

2. Determine important factors that may influence inventory reorganization/reduction.

3. Provide analytic insights and data-driven recommendations.
*/

-- Query 1: Where are items stored and how many products in each warehouse?

SELECT 
    p.warehouseCode, w.warehouseName, count(distinct p.productLine) AS productLineQty, sum(p.quantityInStock) AS itemQty
FROM
    products p
        JOIN
    warehouses w ON w.warehouseCode = p.warehouseCode
GROUP BY warehouseCode , warehouseName;

-- Query 4: Total orders placed in each warehouse
SELECT 
    w.warehouseName, SUM(quantityOrdered) AS ProductSold
FROM
    orderdetails o
        JOIN
    products p ON o.productCode = p.productCode
        JOIN
    warehouses w ON p.warehouseCode = w.warehouseCode
GROUP BY w.warehouseName;

-- Query 15: Product stock and order summary for each product line per warehouse
SELECT 
    p.warehouseCode,
    p.productLine,
    p.productCode,
    SUM(p.quantityInStock) AS InStocks,
    SUM(o.quantityOrdered) AS qtyordered
FROM
    products p
        JOIN
    orderdetails o ON o.productCode = p.productCode
GROUP BY p.warehouseCode , p.productCode , p.productLine
ORDER BY qtyordered;

-- Query 5: Product sold quantity by product code and inventory count
SELECT 
    o.productCode,
    p.quantityinStock,
    SUM(quantityOrdered) AS ProductSold
FROM
    orderdetails o
        JOIN
    products p ON o.productCode = p.productCode
GROUP BY o.productCode , p.quantityinStock
ORDER BY ProductSold DESC;

-- Query 6: Quantity sold monthly and yearly
WITH cte AS (
    SELECT 
        MONTH(orderDate) AS mm, 
        YEAR(orderDate) AS yy, 
        SUM(od.quantityOrdered) AS totalqtyOrders
    FROM orders o 
    JOIN orderdetails od ON o.orderNumber = od.orderNumber 
    GROUP BY MONTH(orderDate), YEAR(orderDate)
)
SELECT 
    mm,
    yy, 
    SUM(totalqtyOrders) OVER (PARTITION BY mm) AS qtySoldMonthly, 
    SUM(totalqtyOrders) OVER (PARTITION BY yy) AS qtySoldYearly 
FROM cte 
GROUP BY mm, yy
ORDER BY yy, mm;

-- Query 7: Average product quantities sold monthly and yearly
WITH combined_tbl AS (
    SELECT 
        MONTH(orderDate) AS mm,
        YEAR(orderDate) AS yy,
        w.warehouseName,
        od.productCode,
        SUM(od.quantityOrdered) AS totalqtyOrders
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber 
    JOIN products p ON p.productCode = od.productCode
    JOIN warehouses w ON w.warehouseCode = p.warehouseCode
    GROUP BY MONTH(orderDate), YEAR(orderDate), od.productCode, w.warehouseName
),
tbl1 AS (
    SELECT mm, warehouseName, productCode, AVG(totalqtyOrders) AS avgQty
    FROM combined_tbl
    GROUP BY productCode, mm, warehouseName
    ORDER BY mm
)
SELECT * FROM tbl1;

-- Query 8: Number of distinct product lines
SELECT DISTINCT
    productLine
FROM
    products;


-- Query 11: Stock quantity and order quantity per warehouse and product line
SELECT 
    warehouseCode,
    productLine,
    SUM(quantityInStock) AS InStocks,
    SUM(quantityOrdered) AS qtyordered,
    SUM(quantityOrdered) / SUM(quantityInStock) AS ratio
FROM
    products p
        JOIN
    orderdetails o ON o.productCode = p.productCode
GROUP BY warehouseCode , productLine
ORDER BY qtyordered DESC;

-- Query 13: Number of products per warehouse and product line
SELECT 
    warehouseCode,
    productLine,
    p.productCode,
    SUM(quantityInStock) AS InStocks,
    SUM(quantityOrdered) AS qtyordered
FROM
    products p
        JOIN
    orderdetails o ON o.productCode = p.productCode
GROUP BY warehouseCode , productLine , p.productCode
ORDER BY qtyordered DESC;

-- Query 14: Warehouse stock and order quantity summary
SELECT 
    w.warehouseCode, 
    w.warehouseName, 
    SUM(quantityInStock) AS InStocks, 
    SUM(quantityOrdered) AS qtyordered 
FROM
    products p 
        JOIN
    orderdetails o ON o.productCode = p.productCode 
        JOIN
    warehouses w ON w.warehouseCode = p.warehouseCode 
GROUP BY w.warehouseCode, w.warehouseName;



-- Query 16: Stock and order quantity for each product line across warehouses
SELECT 
    p.productCode,
    p.productLine,
    SUM(quantityInStock) AS instocks,
    SUM(quantityOrdered) AS ordered
FROM
    products p
        JOIN
    orderdetails o ON p.productcode = o.productCode
GROUP BY p.productCode , p.productLine
ORDER BY ordered;

-- Query 17: Warehouse stock and order percentages
WITH cte AS (
    SELECT 
        p.warehouseCode, 
        p.productLine,
        p.productCode, 
        SUM(p.quantityInStock) AS InStocks, 
        SUM(o.quantityOrdered) AS qtyordered
    FROM products p
    JOIN orderdetails o ON o.productCode = p.productCode
    GROUP BY p.warehouseCode, p.productCode, p.productLine
),
cte1 AS (
    SELECT *,
        SUM(InStocks) OVER (PARTITION BY warehouseCode) AS warehouseStocks,
        ROUND(InStocks / SUM(InStocks) OVER (PARTITION BY warehouseCode) * 100, 2) AS percent
    FROM cte
)
SELECT warehouseCode, AVG(qtyordered) AS avgQtyOrdered, AVG(percent) AS avgPercent
FROM cte1
GROUP BY warehouseCode;

-- Query 18: Warehouse capacity and stock levels
SELECT 
    w.warehouseCode,
    w.warehouseName,
    w.warehousepctCap,
    SUM(quantityInStock) AS InStocks,
    SUM(quantityOrdered) AS qtyordered
FROM
    products p
        JOIN
    orderdetails o ON o.productCode = p.productCode
        JOIN
    warehouses w ON w.warehouseCode = p.warehouseCode
GROUP BY w.warehouseCode , w.warehouseName , w.warehousePctCap;
