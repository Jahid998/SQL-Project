create table practice(

			transactions_id	int,
			sale_date	date,
			sale_time	time,
			customer_id	int,
			gender	varchar(20),
			age	int,
			category	varchar,
			quantiy	int,
			price_per_unit	float,
			cogs	float,
			total_sale float



);

select * from practice

select 
	count(*) from practice

--Data cleaning


select * from practice
where transactions_id is null

select * from practice


select * from practice
where	
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or 
	category is null
	or
	quantiy is null
	or
	price_per_Unit is null
	or
	cogs is null
	or
	total_sale is null;


delete from practice
where	
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or 
	category is null
	or
	quantiy is null
	or
	price_per_Unit is null
	or
	cogs is null
	or
	total_sale is null;

select * from practice



--Exploration

--How many sales we have?
select count(*) total_sales from practice

--How many uniuque customer we have??
select 
	count(distinct customer_id) 
	as total_sale from practice


	

--Data Analysis & Business key problems with questions

--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT *
FROM practice
WHERE sale_date = '2022-11-05';



--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT *
	FROM practice
	where 
	category = 'Clothing'
	and
	to_char(sale_date, 'YYYY-MM') = '2022-11'
	and
	quantiy >= 4;


--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
	FROM practice
	GROUP BY 1

--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
	round(avg(age),2) as avg_age
	from practice
	where category = 'Beauty'


--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * 
	FROM practice
	WHERE total_sale > 1000

--Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM practice
GROUP BY 
    category,
    gender
	ORDER BY 1



--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.


select * from
(
SELECT 
	extract (year from sale_date) as year,
	extract (month from sale_date) as month,
	avg(total_sale) as avg_sale,
	rank() 
	over(partition by extract 
								(year from sale_date)
								order by avg(total_sale)desc) as rank
	FROM practice
	group by 1,2

) as t1
	where rank = 1

	
--order by 1,3 desc
	


--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM practice
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.


select
	category,
	count(distinct(customer_id)) as unique_customer
	from practice
	group by 1
	

--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).


with hourly_sales
as
(
select *,

	CASE
		when extract (hour from sale_time) <12 then 'Morning'
		when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
			end as shift
		
from practice 

)

select shift,
count(*) as total_order
from hourly_sales
group by shift


--End of Project