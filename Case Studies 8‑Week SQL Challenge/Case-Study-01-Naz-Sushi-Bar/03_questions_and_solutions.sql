--Q1. Total Sales by each customer
select 
	s.customer_id,
	sum(m.price_gbp*quantity) as total_spend
from sales s
join menu m
on s.product_id=m.product_id
group by customer_id

-- Q2: How many distinct days each customer visited 
 select 
	Count(Distinct order_date) as total_days,
	customer_id
from sales
group by customer_id

-- Q3: First item purchased by each customer (if multiple items same first day, returns all) 
with cust_orders as(
select 
	order_id,
	customer_id,
	order_date,
	product_id,
	dense_rank() over(partition by customer_id order by order_date) as Ranks,
	MIN(order_date) over(partition by customer_id order by order_date) AS first_order_date
from sales
),

first_order as(
select *
from cust_orders 
where ranks=1 and order_date=first_order_date
)

select 
	fo.order_id,
	fo.customer_id,
	fo.order_date,
	fo.product_id,
	m.product_name
from first_order fo
join menu m
on fo.product_id=m.product_id


-- Q4: Most purchased item overall by quantity 
select 
	top 1 sum(s.quantity) as total_sold_qty,
	m.product_id,
	m.product_name
from sales s
join menu m
on s.product_id=m.product_id
group by m.product_id,m.product_name
order by total_sold_qty desc

-- Q5. What is the most popular menu item for each customer, based on total quantity ordered? 
with quantity_order as(
SELECT 
     SUM(quantity)AS total_units,
     customer_id,
     product_id
FROM dbo.sales 
GROUP BY customer_id,product_id
),

ranked AS (
    SELECT
        qo.*,
        DENSE_RANK() OVER (
            PARTITION BY qo.customer_id
            ORDER BY qo.total_units DESC
        ) AS rn
    FROM quantity_order qo
    )

select 
    r.customer_id,
    r.total_units,
    m.product_name
from ranked  r
join menu m
on r.product_id=m.product_id
where r.rn =1 



/* Q6. For each customer who joined the loyalty program, what was the first menu item purchased after they became a member?
If multiple items were purchased on the first post-membership day, return all items. */

WITH post_member_sales AS (
    SELECT
        s.customer_id,
        s.order_date,
        s.product_id
    FROM dbo.sales s
    JOIN dbo.members mb
      ON mb.customer_id = s.customer_id
    WHERE s.order_date >= mb.join_date
),
first_post_day AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date
    FROM post_member_sales
    GROUP BY customer_id
)
SELECT
    p.customer_id,
    p.order_date,
    m.product_name
FROM post_member_sales p
JOIN first_post_day f
  ON f.customer_id = p.customer_id
 AND f.first_order_date = p.order_date
JOIN dbo.menu m
  ON m.product_id = p.product_id
ORDER BY p.customer_id, m.product_name;
GO


/* Q7 – Last Purchase Before Membership
What menu item was purchased immediately before each customer became a member?
If multiple items were purchased on the last pre-membership day, return all items. */

WITH pre_member_sales AS (
    SELECT
        s.customer_id,
        s.order_date,
        s.product_id
    FROM dbo.sales s
    JOIN dbo.members mb
      ON mb.customer_id = s.customer_id
    WHERE s.order_date < mb.join_date
),
last_pre_day AS (
    SELECT
        customer_id,
        MAX(order_date) AS last_order_date
    FROM pre_member_sales
    GROUP BY customer_id
)
SELECT
    p.customer_id,
    p.order_date,
    m.product_name
FROM pre_member_sales p
JOIN last_pre_day l
  ON l.customer_id = p.customer_id
 AND l.last_order_date = p.order_date
JOIN dbo.menu m
  ON m.product_id = p.product_id
ORDER BY p.customer_id, m.product_name;
GO


/* Q8. For each customer, what is the total number of items purchased and total amount spent before membership?
(Only customers who are in members are included.) */

SELECT
    s.customer_id,
    SUM(s.quantity) AS total_items_before_member,
    CAST(SUM(s.quantity * m.price_gbp) AS DECIMAL(10,2)) AS total_spend_before_member_gbp
FROM dbo.sales s
JOIN dbo.menu m
  ON m.product_id = s.product_id
JOIN dbo.members mb
  ON mb.customer_id = s.customer_id
WHERE s.order_date < mb.join_date
GROUP BY s.customer_id
ORDER BY s.customer_id;
GO


/* Q9. Every £1 spent earns 10 points; Sushi earns 2x points. */

SELECT
    s.customer_id,
    SUM(
        CASE
            WHEN m.product_name = 'Sushi' THEN (m.price_gbp * s.quantity) * 10 * 2
            ELSE (m.price_gbp * s.quantity) * 10
        END
    ) AS total_points
FROM dbo.sales s
JOIN dbo.menu m
  ON m.product_id = s.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;
GO


/* Q10.In the first 7 days from join_date (inclusive), all items earn 2x points.
Calculate points for Customer A and B by end of January 2025. */

SELECT
    s.customer_id,
    SUM(
        CASE
            WHEN s.order_date >= mb.join_date
             AND s.order_date < DATEADD(DAY, 7, mb.join_date)
                THEN (m.price_gbp * s.quantity) * 10 * 2
            WHEN m.product_name = 'Sushi'
                THEN (m.price_gbp * s.quantity) * 10 * 2
            ELSE (m.price_gbp * s.quantity) * 10
        END
    ) AS points_by_end_of_jan
FROM dbo.sales s
JOIN dbo.menu m
  ON m.product_id = s.product_id
JOIN dbo.members mb
  ON mb.customer_id = s.customer_id
WHERE s.customer_id IN ('A','B')
  AND s.order_date <= '2025-01-31'
GROUP BY s.customer_id
ORDER BY s.custom
::contentReference[oaicite:0]{index=0}

