# Mint Classics Inventory and Warehouse Management

# Table of Contents
<!-- TOC -->

- [Project Background](#project-background)
- [Data Structure & Initial Checks](#data-structure--initial-checks)
- [Executive Summary](#executive-summary)
- [Insights Deep Dive](#insights-deep-dive)
- [Recommendations](#recommendations)
- [Assumptions and Caveats](#assumptions-and-caveats)

<!-- /TOC -->

# Project Background

Mint Classics Company, a retailer specializing in classic model cars and vehicles, is evaluating the possibility of closing one of its storage facilities. To make an informed, data-driven decision, the company seeks insights into how inventory could be reorganized or reduced, while still ensuring timely customer service—specifically, the ability to ship products within 24 hours of an order being placed.

As part of this effort, I was tasked with conducting an exploratory data analysis (EDA) to identify any patterns or trends that could influence decisions around warehouse operations and inventory management.

Insights and recommendations are provided on the following key areas:

- **Category 1:** Where are items stored and if they were rearranged?
- **Category 2:** How are inventory numbers related to sales figures? Do the inventory counts seem appropriate for each item?
- **Category 3:** What is the average shipping time for each product line?
- **Category 4:** Are we storing items that are not moving? Are any items candidates for being dropped from the product line?

The SQL queries for the data cheme are available here [link](./Data_Scheme.sql).

The SQL queries for exploring the data can be found here [link](./Data_Exploratory_Analysis.sql).

The SQL queries regarding various business questions can be found here [link](./Data_Analysis.sql).

An interactive Google Looker dashboard used to report and explore inventory data can be found here [link](https://lookerstudio.google.com/reporting/af75d590-c579-4f56-a0ef-7c823bff2abe).

# Data Structure & Initial Checks

The companies main database structure as seen below consists of nine tables: warehouses, products, productlines, orders, orderdetails, customers, payments, employees, offices, with a total row count of 3,868 records. A description of each table is as follows:

- __warehouses (4 records):__ Stores information about the company's warehouses, including location and capacity.
- __products (110 records):__ Contains details about the products available for sale, such as name, price, and stock.
- __productlines (7 records):__ Categorizes products into different lines or types.
- __orders (326 records):__ Stores customer orders, including order dates, status, and total amounts.
- __orderdetails (2,996 orders):__ Contains individual product details for each order, such as quantity, price, and discount.
- __customers (122 records):__  Contains customer information, such as names, contact details, and shipping addresses.
- __payments (273 records):__ Tracks customer payments, including amount, date, and payment method.
- __employees (23 records):__ Stores details about employees, including positions, hire dates, and salaries.
- __offices (7 records):__ Information about the company's offices, including location and contact details.

__Entity Relationship Diagram here__

  <img src="./img/erd.png" alt="My Image" style="width: 600px; height: auto;">

  **Relationship explaination:**
  
  ![alt text](img/img.png)
  
  - ___one to one:___ each record in Entity A is related to exactly one record in Entity B, and vice versa.
  - ___one to many:___ each record in Entity A can be related to multiple records in Entity B, but each record in Entity B is related to only one record in Entity A.
  - ___many to many:___ multiple records in Entity A can be related to multiple records in Entity B.

# Executive Summary

### Overview of Findings

After conducting a thorough analysis of Mint Classics' warehouse operations, several key insights were identified to assist in optimizing the company’s warehouse and inventory management. Below are the highlights:

- West Warehouse: This facility has the lowest sales volume and revenue, and it only stores a single product line (Vintage Cars). Shipping times are also notably slower (5 days), which could impact customer satisfaction. Additionally, its capacity utilization is only 50%, the lowest among all warehouses.

- South Warehouse: While this warehouse has slower-moving products and lower operational efficiency compared to the East and North Warehouses, it stores multiple product lines (Trains, Ships, Trucks, and Buses), and its delivery times are more flexible.

- East and North Warehouses: Both of these facilities are more profitable, with high sales and relatively underutilized capacity. These warehouses are key assets for the company's growth, and their operational efficiency presents an opportunity for further improvement.

  <img width="1035" alt="image" src="https://github.com/user-attachments/assets/0ffe3698-f1b9-4936-b6e5-7062aa9cc75a" />

# Insights Deep Dive

### Category 1: Where are items stored and if they were rearranged?

* **Main insight 1.** The items of each prodiucts line are arranged and stored seprately each warehouse.
    - **West Warehouse**: Vintage Cars (contribute 21.9% of current total stocks)
    - **South Warehouse**: Trains, Ship, Trucks and Buses (contribute 21.2% of current total stocks)
    - **East Warehouse**: Classic Cars (contribute 33,7% of current total stocks)
    - **North Warehouse**: Motorcycles, Planes (contribute 23.2% of current total stocks)
  
* **Main insight 2.** None of the four warehouses are operating at full capacity, with the West warehouse running at just 50%, the lowest among others.

  ![alt text](img/image-3.png)
  ![alt text](img/image-4.png)

### Category 2: How are inventory numbers related to sales figures? Do the inventory counts seem appropriate for each item?

* **Main insight 1.** The East Warehouse generated the most revenue ($3.85M), while the West Warehouse generated the least ($1.8M). The North Warehouse and South Warehouse generated $2.08M and $1.88M, respectively.
  
* **Main insight 2.** The inventory distribution is aligned with sales capacity. For example:

    - The East Warehouse holds a large inventory due to high sales volume (5.6M vs. 35.6K units sold).
    - The South Warehouse holds the least inventory due to its lower sales capacity (2.2M vs. 22.4K units sold).
  
* **Main insight 3.** There is a significant excess inventory compared to actual sales. The average sales percentage is only 0.7% of the total stock.

  ![alt text](img/image-5.png)


### Category 3: What is the average shipping time for each product line?

* **Main insight.** Shipping times vary between warehouses and product lines:

    - Trains: Fastest shipping time (2 days).
    -  Ships and Vintage Cars: Slowest shipping times (average 5 days).

  ![alt text](img/shipday.png)


### Category 4: Are we storing items that are not moving? Are any items candidates for being dropped from the product line?

* **Main insight 1.** The company offers the total of 109 products. The Classic Cars product line has the most variety (37 products), while Ships has the fewest (9 products). The Vintage Cars line consists of 24 products, and the Motorcycles, Planes, Trucks, and Buses lines have similar numbers (13, 12, and 11 products, respectively).
  
* **Main insight 2.** Both Vintage Cars and Classic Cars have a significant number of slow-moving products. These items should be considered for clearance or rearrangement to optimize stock levels.

  ![alt text](img/productdetail.png)

# Recommendations:

Based on the findings, here are several key areas to focus on:

* **Assess Warehouse Utilization and Performance**:  
   The West Warehouse is underperforming in terms of sales and capacity utilization. It only stores one product line, which might limit its potential for growth. A closer look at its long-term profitability and shipping times compared to other warehouses is recommended.

* **Consolidate Product Lines**:  
   While the South Warehouse stores a diverse range of products, it may benefit from better organization of slower-moving stock. However, its flexibility in shipping times makes it a potentially valuable warehouse for handling more diverse product lines, especially when combined with a strategy to move slower products elsewhere.

* **Focus on High-Performing Warehouses**:  
   The East and North Warehouses demonstrate high sales and profitability. These warehouses have more underutilized capacity, presenting an opportunity to optimize their operations and potentially absorb products or operations from other facilities.

* **Review Slow-Moving Inventory**:  
   Vintage Cars and Classic Cars are slow-moving product lines, especially in the West Warehouse. A strategy to review, possibly reorganize or offload these slower-moving products, could free up valuable storage space and improve overall efficiency.

# Assumptions and Caveats:

Several assumptions and considerations were made during the analysis to ensure the data was accurately interpreted, and to account for any limitations or anomalies. These are outlined below:

* **Exclusion of Outliers**:  
   Outliers, particularly orders with unusually long delivery times (over 65 days), were excluded from the analysis. These outliers were considered exceptional cases, such as customer-specific issues, and could distort overall trends in shipping times. Removing these extreme data points ensures that the analysis accurately reflects typical operational performance.

* **Data Completeness and Consistency**:  
   Some records may have missing or inconsistent data, which could potentially affect certain analyses. Where possible, missing values were handled or excluded, but the quality and completeness of data should be continuously monitored to ensure future analyses remain robust and reliable.

* **Changes in Customer Behavior**:  
   Customer behavior, such as demand for specific product lines, may have shifted during the study period, especially as new products or promotions were introduced. These changes could impact trends in inventory needs and shipping efficiency, and should be considered when making any forward-looking decisions about warehouse operations.
