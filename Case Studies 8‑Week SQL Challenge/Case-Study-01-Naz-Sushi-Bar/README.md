# Case Study 1: Naz’s Sushi Bar 🍣
![Naz Sushi Bar](Naz%20Sushi%20Bar.png)
## Table of Contents
- Introduction  
- Problem Statement  
- Datasets Used  
- Entity Relationship Diagram  
- Case Study Questions  
- Bonus Questions  
- Technologies Used  
- How to Run the Project  

---

## Introduction

Naz opened a small sushi bar in Newcastle specialising in quick, high-quality Japanese meals such as sushi, ramen, and curry.  
After a few months of operation, Naz collected basic transactional data but lacked insights into customer behaviour, popular menu items, and the effectiveness of the loyalty program.

This case study uses SQL to analyse the restaurant’s data and extract actionable business insights.

---

## Problem Statement

Naz wants to better understand:
- How customers interact with the menu  
- Which items perform best overall and per customer  
- How spending behaviour changes after joining the loyalty program  
- Whether the loyalty points system is working as intended  

These insights will help Naz optimise menu offerings, pricing, and customer retention strategies.

---

## Datasets Used

This case study uses three core datasets:

### 1. `sales`
Captures all customer purchase transactions, including:
- customer ID  
- order date  
- product purchased  
- quantity ordered  

### 2. `menu`
Contains menu item details:
- product ID  
- product name  
- category  
- price  

### 3. `members`
Tracks customer participation in the loyalty program:
- customer ID  
- membership join date  

---

## Entity Relationship Diagram

The data model follows a simple relational structure:
- `sales.product_id` → `menu.product_id`
- `sales.customer_id` → `members.customer_id`

(ERD)

---

## Case Study Questions

1. What is the total amount of money each customer has spent at Naz’s Sushi Bar?  

2. How many distinct days has each customer visited the sushi bar?  

3. What was the first menu item purchased by each customer?  
   If multiple items were purchased on the first visit, return all items.  

4. Which menu item has been purchased the most overall, based on total quantity sold?  

5. What is the most popular menu item for each customer, based on total quantity ordered?  

6. For each customer who joined the loyalty program, what was the first item purchased after becoming a member?  

7. What menu item was purchased immediately before each customer became a member?  

8. For each customer, what is the total number of items purchased and total amount spent **before** joining the loyalty program?  

9. If every £1 spent earns 10 loyalty points and sushi earns double points, how many total loyalty points has each customer earned?  

10. During the first 7 days starting from a customer’s join date (inclusive), all items earn double points.  
    How many loyalty points do Customer A and Customer B have by the end of January 2025?  

---

## Bonus Questions

**Bonus 1 – Join All The Things**  
Create a unified dataset that joins sales, menu, and membership information, including a flag indicating whether each purchase occurred before or after membership.

**Bonus 2 – Rank All The Things**  
Rank each customer’s purchases chronologically, separating member purchases from non-member purchases.

---

## Technologies Used

- SQL Server (T-SQL)  
- SQL Server Management Studio (SSMS)  
- dbdiagram.io for ERD design  

---

## How to Run the Project

1. Open SQL Server Management Studio  
2. Run `01_schema.sql` to create the database and tables  
3. Run `02_data.sql` to insert sample data  
4. Run `03_questions_and_solutions.sql` to view answers for all case study questions  


---

⭐ If this project helped or inspired you, feel free to star the repository!
