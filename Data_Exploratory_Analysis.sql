
-- Total records of each table in the database

SELECT 
    'warehouses' AS table_name, COUNT(*) AS total_records
FROM
    warehouses 
UNION ALL SELECT 
    'product', COUNT(*)
FROM
    products 
UNION ALL SELECT 
    'productlines', COUNT(*)
FROM
    productlines 
UNION ALL SELECT 
    'orders', COUNT(*)
FROM
    orders 
UNION ALL SELECT 
    'orderdetails', COUNT(*)
FROM
    orderdetails 
UNION ALL SELECT 
    'customers', COUNT(*)
FROM
    customers 
UNION ALL SELECT 
    'payments', COUNT(*)
FROM
    payments 
UNION ALL SELECT 
    'employees', COUNT(*)
FROM
    employees 
UNION ALL SELECT 
    'offices', COUNT(*)
FROM
    offices;

-- Total records of all tabels in the database

SELECT 
    SUM(total_records)
FROM
    (SELECT 
        'warehouses' AS table_name, COUNT(*) AS total_records
    FROM
        warehouses UNION ALL SELECT 
        'product', COUNT(*)
    FROM
        products UNION ALL SELECT 
        'productlines', COUNT(*)
    FROM
        productlines UNION ALL SELECT 
        'orders', COUNT(*)
    FROM
        orders UNION ALL SELECT 
        'orderdetails', COUNT(*)
    FROM
        orderdetails UNION ALL SELECT 
        'customers', COUNT(*)
    FROM
        customers UNION ALL SELECT 
        'payments', COUNT(*)
    FROM
        payments UNION ALL SELECT 
        'employees', COUNT(*)
    FROM
        employees UNION ALL SELECT 
        'offices', COUNT(*)
    FROM
        offices) temp;

-- Export the CSV file for visualization
with cte as (
    SELECT 
    od.orderNumber, od.productCode, od.quantityOrdered, od.priceEach, od.orderLineNumber, o.orderDate, o.requiredDate, o.shippedDate, o.status, o.comments, p.productName, p.productLine,
    p.productScale, p.productVendor, p.quantityInStock, p.buyPrice, w.warehouseName, w.warehousePctCap, w.warehouseCode
FROM
    orderdetails od
        JOIN
    orders o ON od.orderNumber = o.orderNumber
        JOIN
    products p ON p.productCode = od.productCode
        JOIN
    warehouses w ON p.warehouseCode = w.warehouseCode)
select * from cte;