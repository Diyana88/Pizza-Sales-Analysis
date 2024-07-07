
--**KPI Requirements**
-- 1) Find Total Revenue
select sum(total_price) as Total_Revenue from pizza_sales

-- 2) Find Average Order Value
select * from pizza_sales
select sum(total_price)/ count(DISTINCT order_id) as Average_Order_Value from pizza_sales

--3) Find Total Pizza Sold
select * from pizza_sales
select sum(quantity) as Total_Pizza_Sold from pizza_sales

--4) Find Total Order
select * from pizza_sales
select count(distinct order_id) as Total_Order from pizza_sales

--5) Find Average Pizzas Per Order
select * from pizza_sales
select cast(cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id)as decimal (10,2)) as decimal (10,2)) as Average_Pizzas_Per_Order from pizza_sales

--**Charts Requirement**

--1) Daily Trend For Total Orders
select * from pizza_sales
select DATENAME(DW, order_date) as order_day, count(distinct order_id) as Total_Orders from pizza_sales
GROUP BY DATENAME(DW, order_date)

--2) Hourly Trend for Total Orders
select * from pizza_sales
select DATEPART(HOUR, order_time) as order_hours, count(distinct order_id) as Total_Orders from pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

--3) Percentage of Sales by Pizza Category
select * from pizza_sales
select pizza_category, sum(total_price) as Total_Sales, sum(total_price) *100/ (select sum(total_price) from pizza_sales) as Percentage_of_Total_Sales from pizza_sales
GROUP BY pizza_category

--WANT TO APPLY MONTH, QUARTER OR WEEK FILTER FOR THE PERCENTAGE AND TOTAL SALES
--for month = January
select pizza_category, sum(total_price) as Total_Sales, sum(total_price) *100/ 
(select sum(total_price) from pizza_sales where MONTH(order_date)=1) as Percentage_of_Total_Sales 
from pizza_sales
WHERE MONTH(order_date)=1
GROUP BY pizza_category

--4) Percentage of Sales by Pizza Size
select pizza_size, cast(sum(total_price) as decimal (10,2)) as Total_Sales, cast(sum(total_price) *100/ 
(select sum(total_price) from pizza_sales) as decimal (10,2)) as Percentage_of_Total_Sales 
from pizza_sales
GROUP BY pizza_size
ORDER BY Percentage_of_Total_Sales desc

--WANT TO APPLY QUARTER
select pizza_size, cast(sum(total_price) as decimal (10,2)) as Total_Sales, cast(sum(total_price) *100/ 
(select sum(total_price) from pizza_sales) as decimal (10,2)) as Percentage_of_Total_Sales 
from pizza_sales
where DATEPART (quarter, order_date)=1
GROUP BY pizza_size
ORDER BY Percentage_of_Total_Sales desc

--5) Total Pizzas Sold by Pizza Category
select pizza_category, sum(quantity) as Total_Pizzas_Sold from pizza_sales
GROUP BY pizza_category

--6 Top 5 Best Sellers by Total Pizza Sold
select  top 5 pizza_name, sum(quantity) as Total_Pizza_Sold from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold desc

--7 Bottom 5 Worst Sellers by Total Pizza Sold
select top 5 pizza_name, sum(quantity) as Total_Pizza_Sold from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC


