## Case Study Questions

1. What is the total amount of money each customer has spent at Naz’s Sushi Bar?

2. How many distinct days has each customer visited the sushi bar?

3. What was the first menu item purchased by each customer?
If a customer ordered multiple items on their first visit, return all items.

4. Which menu item has been purchased the most overall, based on total quantity sold?

5. What is the most popular menu item for each customer, based on total quantity ordered?

6. For each customer who joined the loyalty program, what was the first item purchased after becoming a member?

7. What menu item was purchased immediately before each customer became a member?

8. For each customer, what is the total number of items purchased and the total amount spent before they joined the loyalty program?

9. If each £1 spent earns 10 loyalty points and sushi earns double points, how many total loyalty points has each customer earned?

10. During the first 7 days starting from a customer’s membership join date (inclusive), all menu items earn double points.
How many loyalty points do customers A and B have by the end of January 2025?
<br>

**BONUS questions** :

i. Join all the things

ii. Rank all the things

---



### 1. What is the total amount each customer spent at the restaurant?

```sql
select 
	s.customer_id,
	sum(m.price_gbp*quantity) as total_spend
from sales s
join menu m
on s.product_id=m.product_id
group by customer_id
```

#### Result set:

| customer_id | total_spend |
| ----------- | ----------- |
| A           | 60.5        |
| B           | 57.50       |
| C           | 50          |

---

### 2. How many days has each customer visited the restaurant?

```sql
 select 
		customer_id,
    Count(Distinct order_date) as total_days
from sales
group by customer_id
```

#### Result set:

| customer_id | total_days  |
| ----------- | ----------- |
| A           | 5           |
| B           | 6           |
| C           | 5           |

---

### 3. What was the first item from the menu purchased by each customer?

```sql
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

```

#### Result set:
| order_id | customer_id | order_date  | product_id | product_name |
|----------|-------------|-------------|-------------|---------------|
| 1        | A           | 2025-01-01  | 1           | Sushi         |
| 2        | A           | 2025-01-01  | 4           | Miso Soup     |
| 7        | B           | 2025-01-01  | 2           | Ramen         |
| 13       | C           | 2025-01-03  | 3           | Curry         |

---

### 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

```sql
select 
	top 1 sum(s.quantity) as total_sold_qty,
	m.product_id,
	m.product_name
from sales s
join menu m
on s.product_id=m.product_id
group by m.product_id,m.product_name
order by total_sold_qty desc

```

#### Result set:

| total_sold_qty | product_id | product_name |
|----------------|------------|--------------|
| 7              | 1          | Sushi        |

---

### 5. Which item was the most popular for each customer?

```sql
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

```

#### Result set:

| customer_id | total_units | product_name |
|-------------|-------------|--------------|
| A           | 3           | Sushi        |
| B           | 2           | Ramen        |
| B           | 2           | Sushi        |
| C           | 2           | Miso Soup    |
| C           | 2           | Sushi        |

---

### 6. Which item was purchased first by the customer after they became a member?

```sql
WITH post_member_sales AS (
    SELECT
        s.customer_id,
        s.order_date,
        s.product_id,
        mb.join_date
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
    m.product_name,
    p.join_date
FROM post_member_sales p
JOIN first_post_day f
  ON f.customer_id = p.customer_id
 AND f.first_order_date = p.order_date
JOIN dbo.menu m
  ON m.product_id = p.product_id
ORDER BY p.customer_id, m.product_name;


```

#### Result set:

| customer_id | order_date   | product_name | join_date   |
|-------------|--------------|--------------|-------------|
| A           | 2025-01-08   | Curry        | 2025-01-07  |
| B           | 2025-01-11   | Curry        | 2025-01-09  |
| C           | 2025-01-18   | Sushi        | 2025-01-15  |

---

### 7. Which item was purchased just before the customer became a member?

```sql
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

```

#### Result set:

| customer_id | product_name | order_date               | join_date                |
| ----------- | ------------ | ------------------------ | ------------------------ |
| A           | sushi        | 2021-01-01T00:00:00.000Z | 2021-01-07T00:00:00.000Z |
| A           | curry        | 2021-01-01T00:00:00.000Z | 2021-01-07T00:00:00.000Z |
| B           | sushi        | 2021-01-04T00:00:00.000Z | 2021-01-09T00:00:00.000Z |

---

### 8. What is the total items and amount spent for each member before they became a member?

```sql
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

```

#### Result set:

| customer_id | total_items_before_member | total_spend_before_member_gbp |
|-------------|---------------------------|--------------------------------|
| A           | 5                         | 45.50                          |
| B           | 4                         | 34.50                          |
| C           | 5                         | 40.00                          |
---

### 9. If each £1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

```sql
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
```

#### Result set:

| customer_id | total_points |
|-------------|--------------|
| A           | 905.00       |
| B           | 775.00       |
| C           | 700.00       |

---

### 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January

```sql
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
```

#### Result set:

| customer_id | points_by_end_of_jan |
|-------------|-----------------------|
| A           | 1055.00               |
| B           | 885.00                |

---

### **Bonus Questions**

#### i. Join All The Things

Create basic data tables that Naz and her team can use to quickly derive insights without needing to join the underlying tables using SQL. Fill Member column as 'N' if the purchase was made before becoming a member and 'Y' if the after is made after joining the membership.

```sql
/* Bonus 1 – Join All The Things
Fill member flag as 'N' for purchases before membership
and 'Y' for purchases on or after joining */

SELECT
    s.customer_id,
    s.order_date,
    m.product_name,
    m.price_gbp,
    CASE
        WHEN mb.join_date IS NOT NULL
         AND s.order_date >= mb.join_date THEN 'Y'
        ELSE 'N'
    END AS member
FROM dbo.sales s
LEFT JOIN dbo.members mb
  ON mb.customer_id = s.customer_id
JOIN dbo.menu m
  ON m.product_id = s.product_id
ORDER BY s.customer_id, s.order_date;

```

#### Result set:

| customer_id | order_date   | product_name | price_gbp | member |
|-------------|--------------|--------------|-----------|--------|
| A           | 2025-01-01   | Sushi        | 10.00     | N      |
| A           | 2025-01-01   | Miso Soup    | 3.50      | N      |
| A           | 2025-01-04   | Ramen        | 12.00     | N      |
| A           | 2025-01-06   | Sushi        | 10.00     | N      |
| A           | 2025-01-08   | Curry        | 11.00     | Y      |
| A           | 2025-01-10   | Mochi        | 4.00      | Y      |
| B           | 2025-01-01   | Ramen        | 12.00     | N      |
| B           | 2025-01-02   | Green Tea    | 2.50      | N      |
| B           | 2025-01-04   | Sushi        | 10.00     | N      |
| B           | 2025-01-08   | Sushi        | 10.00     | N      |
| B           | 2025-01-11   | Curry        | 11.00     | Y      |
| B           | 2025-01-16   | Ramen        | 12.00     | Y      |
| C           | 2025-01-03   | Curry        | 11.00     | N      |
| C           | 2025-01-05   | Sushi        | 10.00     | N      |
| C           | 2025-01-07   | Miso Soup    | 3.50      | N      |
| C           | 2025-01-12   | Ramen        | 12.00     | N      |
| C           | 2025-01-18   | Sushi        | 10.00     | Y      |

---

#### ii. Rank All The Things

Naz also requires further information about the ranking of customer products, but she purposely does not need the ranking for non-member purchases so she expects null ranking values for the records when customers are not yet part of the loyalty program.

```sql
/* Bonus 2 – Rank All The Things
Rank purchases for each customer, but only when they are a member.
Non-member purchases show NULL rank. */

WITH joined AS (
    SELECT
        s.customer_id,
        s.order_date,
        m.product_name,
        m.price_gbp,
        CASE
            WHEN mb.join_date IS NOT NULL
             AND s.order_date >= mb.join_date THEN 'Y'
            ELSE 'N'
        END AS member
    FROM dbo.sales s
    LEFT JOIN dbo.members mb
      ON mb.customer_id = s.customer_id
    JOIN dbo.menu m
      ON m.product_id = s.product_id
),
ranked AS (
    SELECT
        j.*,
        CASE
            WHEN j.member = 'Y' THEN
                DENSE_RANK() OVER (
                    PARTITION BY j.customer_id
                    ORDER BY j.order_date
                )
            ELSE NULL
        END AS member_rank
    FROM joined j
)
SELECT
    customer_id,
    order_date,
    product_name,
    price_gbp,
    member,
    member_rank
FROM ranked
ORDER BY customer_id, order_date, product_name;

```

#### Result set:

| customer_id | order_date   | product_name | price_gbp | member | member_rank |
|-------------|--------------|--------------|-----------|--------|-------------|
| A           | 2025-01-01   | Miso Soup    | 3.50      | N      | NULL        |
| A           | 2025-01-01   | Sushi        | 10.00     | N      | NULL        |
| A           | 2025-01-04   | Ramen        | 12.00     | N      | NULL        |
| A           | 2025-01-06   | Sushi        | 10.00     | N      | NULL        |
| A           | 2025-01-08   | Curry        | 11.00     | Y      | 4           |
| A           | 2025-01-10   | Mochi        | 4.00      | Y      | 5           |
| B           | 2025-01-01   | Ramen        | 12.00     | N      | NULL        |
| B           | 2025-01-02   | Green Tea    | 2.50      | N      | NULL        |
| B           | 2025-01-04   | Sushi        | 10.00     | N      | NULL        |
| B           | 2025-01-08   | Sushi        | 10.00     | N      | NULL        |
| B           | 2025-01-11   | Curry        | 11.00     | Y      | 5           |
| B           | 2025-01-16   | Ramen        | 12.00     | Y      | 6           |
| C           | 2025-01-03   | Curry        | 11.00     | N      | NULL        |
| C           | 2025-01-05   | Sushi        | 10.00     | N      | NULL        |
| C           | 2025-01-07   | Miso Soup    | 3.50      | N      | NULL        |
| C           | 2025-01-12   | Ramen        | 12.00     | N      | NULL        |
| C           | 2025-01-18   | Sushi        | 10.00     | Y      | 5           |
---
