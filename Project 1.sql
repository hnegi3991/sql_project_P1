#----SqlRetail Sales Analysis Project--------
create database sql_project_p1;
use sql_project_p1;
# ----------Create-Table---------
Create table Retail_Sales_tb
(
		transactions_id int Primary key,
		sale_date date,
		sale_time time,	
		customer_id int,	
		gender Varchar(15),
		age int,
		category varchar(15),	
		quantiy int,
		price_per_unit float,
		cogs float ,	
		total_sale float

);

Select count(transactions_id) from retail_sales_tb order by Transactions_id;
Select count(*) from retail_sales_tb ;

#checking for NUll values
Select  *from retail_sales_tb where transactions_id is null or sale_date is null or sale_time is null or customer_id is null or
gender is null or age is null or category is null or  quantity is null or price_per_unit is null or cogs is null or total_sale is null ;
# Deleting the NULL Values -------------------------------------------------------------
DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;


-----------------------------------------------------
-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

 -- Answers 
 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
 select * from retail_sales_tb 
   where 
       sale_date="2022-11-05" order by transactions_id;
       
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
Select * from retail_sales_tb 
where category='Clothing' and quantiy>=4 and Month(sale_date)=11;

-- Q.3 Write a SQL query  calculate the total sales (total_sale) for each category.
select category,sum(total_sale) as totalSale, count(*) as totalorders from retail_sales_tb
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(Avg(age),2) from retail_sales_tb 
where category ="Beauty";

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select Transactions_id,total_sale from retail_sales_tb
 where total_sale>1000;
 ----- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 select category,gender,sum(transactions_id) as No_of_transactions from retail_sales_tb
 group by category,gender
 order by 1;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
Select *
From (select Year(sale_date) as SaleYear, monthname(sale_date) as SaleMonth, round(avg(total_sale),2) as AvgSale,
rank() Over(partition by Year(sale_date) order by Avg(total_sale) Desc)as ranknum
from  retail_sales_tb 
Group by 
     SaleYear,SaleMonth
     order by SaleYear,AvgSale Desc) As sub	
     where ranknum=1;
     
     -- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
     
     select Customer_id,sum(total_sale) as Total from retail_sales_tb
     group by customer_id
     order by Total desc limit 5;
     
     -- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
     select category, count( distinct customer_id) from retail_sales_tb
     group by category;
     -- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
     Select 
     Case
       when Hour(sale_time)<12 then "Morning"
       when hour(sale_time) between 12 and 17 then "Afternoon"
	   else "Evening"
    End as shift, count(*) as Orders from retail_sales_tb
    group by shift;
    
  
     
	
     
     
     

     
     



 

