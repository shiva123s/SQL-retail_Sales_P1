create database sql_project;
use sql_project;
create table retail_sales
(
    transactions_id int primary key,
    sale_date date,
    sale_time time,
    customer_id int,
    gender varchar (15),
    age int,
    category varchar (15), 
    quantiy float,
    price_per_unit float,	
    cogs float,
    total_sale float
    );
    select * from retail_sales;
   SET SQL_SAFE_UPDATES = 0;
   select * from retail_sales
   where 
   transaction_id is NULL
   or 
   sale_date is NULL
   or
   sale_time is NULL
   or
   customer_id is NULL
   or
   gender is NULL
   or 
   age is NULL
   or
   category is NULL
   or 
   quantity is NULL
   or 
   price_per_unit is NULL
   or 
   cogs is NULL
   or
   total_sale is NULL;
   delete from retail_sales 
   where 
   transaction_id is NULL
   or 
   sale_date is NULL
   or
   sale_time is NULL
   or
   customer_id is NULL
   or
   gender is NULL
   or 
   age is NULL
   or
   category is NULL
   or 
   quantity is NULL
   or 
   price_per_unit is NULL
   or 
   cogs is NULL
   or
   total_sale is NULL;
   select count(distinct customer_id) as total_sale from retail_sales;
   select count(distinct category) as total_sale from retail_sales;
   select distinct category from retail_sales;
   select distinct customer_id from retail_sales;
-- data analysis and bussiness key problems and answer 
/*
Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05
Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
Q3. Write a SQL query to calculate the total sales (total_sale) for each category.:
Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
Q8. Write a SQL query to find the top 5 customers based on the highest total sales:
Q9. Write a SQL query to find the number of unique customers who purchased items from each category.:
Q10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
*/
-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * 
from retail_sales
where sale_date = '2022-11-05';
-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND quantity ='4'
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.:
select 
category,
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1;
-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select
round (avg(age),2) as avg_age
from retail_sales
where category='beauty';
-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select *
from retail_sales 
where total_sale >1000;
-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select
category, gender,
count(*) as total_transaction
from retail_sales
group by category, gender
order by 1;
-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select * from(
select 
year(sale_date) as year,
month (sale_date) as month,
avg(total_sale) as avg_sale,
rank ()over(partition by (year(sale_date))order by avg(total_sale)desc) as rank_done
from retail_sales
group by 1,2
) as t1
where rank_done= 1;
-- 8. Write a SQL query to find the top 5 customers based on the highest total sales:
select
customer_id,
sum(total_sale) as total_saless
from retail_sales
group by 1
order by 1, 2 desc
limit 5;
-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.:
select 
category,
count(distinct customer_id ) as cs_unq_id
from retail_sales
group by category;
-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
with hourly_sales
as
(select *, 
case when hour(sale_time) <12 then 'morning'
when hour(sale_time) between 12 and 16 then 'afternoon'
else 'evening'
end as shifts
from retail_sales)
select shifts, 
count(*)  as total_orders
from hourly_sales
group by shifts;
-- end thank you --