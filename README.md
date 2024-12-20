# Data Analysis - MintClassics Inventory Optimization and Warehouse Evaluation

## Overview

This analysis aims to evaluate the current inventory system for the model car company, Mint Classics, using the historical transactions data from Jan 2003 to May 2005 to assess potential opportunities for warehouse reorganization or reduction, and provide data-driven insights and recommendations.

### Key Questions to Address:

1. **Where are items stored, and could a warehouse be eliminated if the items were rearranged?**
2. **How are inventory numbers related to sales figures? Do the inventory counts seem appropriate for each item?**
3. **Are we storing items that are not moving? Are any items candidates for being dropped from the product line?**

The answers to these questions will help formulate suggestions and recommendations for reducing inventory and potentially closing a warehouse.

## Project Objectives

1. **Explore products** currently in inventory.
2. **Identify important factors** that may influence inventory reorganization or reduction.
3. **Provide analytic insights and recommendations** for warehouse optimization and inventory management.

---

## Data scheme (ERD):

The scheme includes tables:  
- warehouses
- products
- productlines
- orders
- orderdetails
- customers
- payments
- employees

Due to the scope of this project, I only use tables: warehouses, products, orders, orderdetails for analysis.

**Data scheme:**

<img src="./img/image-18.png" alt="My Image" style="width: 600px; height: auto;">

**Relationship explanation:**

<img src="./img/image-1.png" alt="ERD Relationship" style="width: auto; height: auto;">

- ___one to one:___ each record in Entity A is related to exactly one record in Entity B, and vice versa.
- ___one to many:___ each record in Entity A can be related to multiple records in Entity B, but each record in Entity B is related to only one record in Entity A.
- ___many to many:___ multiple records in Entity A can be related to multiple records in Entity B.

---

## Data Insights
### Company Overview

The company has **7 product lines** stored in **4 warehouses**. The products are distributed across warehouses as the below table:

<img src="./img/image-29.png" alt="Warehouse Distribution" style="width: auto; height: auto;">

### Warehouse Layout:

- **East Warehouse**: has 1 product line and contribute ~ 39.48% of total stocks.
- **South Warehouse**: has 3 product lines and contribute ~ 14.3 % of total stocks.
- **West Warehouse**: has 1 product line and contribute ~ 22.5% of total stocks.
- **North Warehouse**: has 2 product lines and contribute ~ 23.72% of total stocks.

<img src="./img/image-26.png" alt="Warehouse Layout" style="width: auto; height: auto;">

**Warehouse Capacity:** None of the four warehouses are operating at full capacity, with the West warehouse running at just 50%, the lowest among others.  

<img src="./img/image-11.png" alt="Warehouse Capacity" style="width: auto; height: auto;">

**Stock Distribution per Product Line:**  The East and West warehouses (b and c) held the largest quantity of the current stock level.  

<img src="./img/image-6.png" alt="Stock Distribution" style="width: auto; height: auto;">

**The stock level and quantity sold per warehouse:** The product lines in the East and North warehouses have the highest sales volume.  

<img src="./img/image-30.png" alt="Stock and Sales Per Warehouse" style="width: auto; height: auto;">

**Comparing Stock Quantity and Sales Volume:** There is an inconsistency between stock levels and sales volume per item, which should be addressed to free up storage space and optimize storage efficiency for sales.  

<img src="./img/image-28.png" alt="Stock vs Sales Inconsistency" style="width: auto; height: auto;">

**Quantity Sold by Month and Year (from Jan 2003 to May 2005):** 
The peak sales season occurs from October to November, followed by a gradual decline until September of the following year.

<img src="./img/image-14.png" alt="Quantity Sold Over Time" style="width: 450px; height: 850;">

As inspected the total revenue for each item, the most profitable products are the classic cars, motorcycles, and planes product lines. These items are stored in the East and North warehouses, and closing these facilities would carry significant risks for the company due to their high profitability.  
<img src="./img/image-15.png" alt="Revenue Per Product" style="width: 450px; height: 550;">

Based on the revenue contribution by each product line, we can see that Classic Car product line is the most popular and most revenue-generating compared to others. The least revenue product lines are the trains, ships, trucks, and buses, all of which are located in the South warehouse. This might have less impact if we want to close this warehouse and reallocate these products to other facilities.  

<img src="./img/image-17.png" alt="Revenue by Product Line" style="width: auto; height: auto;">

__Comparing between South and West warehouses to support the closing facility decision__

I decided to look at the location that has shorter delivery time. Firstly, i want to compare only the orders that have been shipped. The below table shows the company has a total of 303 distinct orders which meet the condition.

<img src="./img/image-22.png" alt="Shipped Orders" style="width: auto; height: auto;">

Secondly, I inspected delivery time of these two warehouses. There is one order that the delivery day is 65 days due to customer credit issue. I decided to remove this order from the result set to avoid the bias in the data.  

<img src="./img/image-23.png" alt="Outlier Shipping Data" style="width: auto; height: auto;">

The total of distinct orders now become 302 orders.   

<img src="./img/image-24.png" alt="Shipping Data After Removing Outlier" style="width: auto; height: auto;">

Look at the shipping day for each product line; it is more common that Vintage Cars product line (the West warehouse) have the most order delivery in 4 days, whereas items in the South warehouse have delivery times varying from 2 to 5 days, which is more flexible than the warehouse in the West. 

<img src="./img/image-25.png" alt="Delivery Times by Product Line" style="width: auto; height: auto;">

___Note: The company should also consider factors that impact on the delivery time such as labor resources, how big and complex the warehouse is for pick and pack, and the order volume.___

## Conclusion

In my opinion, we should keep the warehouses in the North and East because of the sales volume and profitability they bring. We should consider managing the stock level that is suitable for each item by predicting how many items may be sold in the next month or year to optimize storage costs and warehouse efficiency.

To expedite delivery times, I recommend **closing the West facility**, which currently stores the vintage car product line, and transferring the stock to the South warehouse. The South warehouse offers more flexibility in shipping times, typically ranging from 2 to 5 days. However, it is currently operating at 75% capacity. Before proceeding with the reallocation, we should implement clearance strategies for slow-moving stock in both warehouses. This would help minimize transfer costs and free up space in the South warehouse for incoming stock.

This analysis is based on my understanding of the domain, but for a more thorough and precise evaluation, we should consider additional relevant factors to further refine and support these recommendations.