-- ============================================
-- Project: Bank Churn Analysis
-- Tool: SQL
-- Description: Analyzing customer churn behavior
-- ============================================

-- 1. Total Customers
SELECT COUNT(customerid) AS total_customers
FROM bank_churn;

-- 2. Churn vs Non-Churn Customers
SELECT 
    exited,
    COUNT(*) AS total_customers
FROM bank_churn
GROUP BY exited;

-- 3. Check Duplicate Customers
SELECT customerid, COUNT(*) 
FROM bank_churn
GROUP BY customerid
HAVING COUNT(*) > 1;

-- 4. Credit Score Range
SELECT 
    MIN(creditscore) AS min_score,
    MAX(creditscore) AS max_score
FROM bank_churn;

-- 5. Age Range
SELECT 
    MIN(age) AS min_age,
    MAX(age) AS max_age
FROM bank_churn;

-- 6. Churn by Activity Status
SELECT 
    isactivemember,
    COUNT(customerid) AS total_customers,
    SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) AS churn_customers
FROM bank_churn
GROUP BY isactivemember;

-- 7. Churn by Number of Products
SELECT 
    numofproducts,
    COUNT(customerid) AS total_customers,
    SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) AS churn_customers
FROM bank_churn
GROUP BY numofproducts;

-- 8. Churn by Balance Category
SELECT
    CASE
        WHEN balance BETWEEN 0 AND 50000 THEN 'Low'
        WHEN balance BETWEEN 50001 AND 150000 THEN 'Medium'
        ELSE 'High'
    END AS balance_category,
    COUNT(customerid) AS total_customers,
    SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) AS churn_customers
FROM bank_churn
GROUP BY balance_category;

-- 9. Churn by Credit Score Category
SELECT
    CASE
        WHEN creditscore BETWEEN 350 AND 500 THEN 'Low'
        WHEN creditscore BETWEEN 501 AND 700 THEN 'Medium'
        ELSE 'High'
    END AS credit_category,
    COUNT(customerid) AS total_customers,
    SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) AS churn_customers
FROM bank_churn
GROUP BY credit_category;

-- 10. Churn by Geography
SELECT 
    geography,
    COUNT(customerid) AS total_customers,
    SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) AS churn_customers
FROM bank_churn
GROUP BY geography
ORDER BY churn_customers DESC;

-- 11. Churn by Age Group (Using CTE)
WITH age_cte AS (
    SELECT
        CASE
            WHEN age BETWEEN 18 AND 30 THEN 'Young'
            WHEN age BETWEEN 31 AND 50 THEN 'Middle'
            ELSE 'Senior'
        END AS age_group,
        customerid,
        exited
    FROM bank_churn
)
SELECT
    age_group,
    COUNT(customerid) AS total_customers,
    SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) AS churn_customers
FROM age_cte
GROUP BY age_group;