/* ==============================================================================
   PROJET : Retail Orders Performance Analytics
   STACK  : SQL Server (T-SQL)
   AUTEUR : Cédric Njamen
============================================================================== */

USE RetailDB;
GO

-- 1. Indicateurs globaux (Volume, Chiffre d'affaires net, Panier moyen)
SELECT 
    COUNT(DISTINCT Order_Id) AS total_orders,
    ROUND(SUM(List_Price * (1 - Discount_Percent / 100.0) * Quantity), 2) AS total_revenue,
    ROUND(AVG(List_Price * (1 - Discount_Percent / 100.0) * Quantity), 2) AS average_order_value
FROM retail_orders;

-- 2. Top 10 des produits générant le plus de chiffre d'affaires (T-SQL TOP)
SELECT TOP 10 
    Product_Id, 
    ROUND(SUM(List_Price * (1 - Discount_Percent / 100.0) * Quantity), 2) AS total_sales
FROM retail_orders
GROUP BY Product_Id
ORDER BY total_sales DESC;

-- 3. Rentabilité et marge par catégorie de produits
SELECT 
    Category,
    COUNT(DISTINCT Order_Id) AS total_orders,
    ROUND(SUM(List_Price * (1 - Discount_Percent / 100.0) * Quantity), 2) AS total_sales,
    ROUND(AVG((List_Price * (1 - Discount_Percent / 100.0) - cost_price) * Quantity), 2) AS average_profit
FROM retail_orders
GROUP BY Category
ORDER BY total_sales DESC;

-- 4. Répartition géographique du chiffre d'affaires par région
SELECT 
    Region,
    COUNT(DISTINCT Order_Id) AS orders_count,
    ROUND(SUM(List_Price * (1 - Discount_Percent / 100.0) * Quantity), 2) AS regional_sales
FROM retail_orders
GROUP BY Region
ORDER BY regional_sales DESC;

-- 5. Segmentation de la valeur des commandes (CASE WHEN & CTE)
WITH OrderValues AS (
    SELECT 
        Order_Id,
        ROUND(SUM(List_Price * (1 - Discount_Percent / 100.0) * Quantity), 2) AS total_order_value
    FROM retail_orders
    GROUP BY Order_Id
)
SELECT 
    order_tier,
    COUNT(Order_Id) AS total_orders,
    ROUND(SUM(total_order_value), 2) AS segment_revenue
FROM (
    SELECT 
        Order_Id,
        total_order_value,
        CASE 
            WHEN total_order_value >= 500 THEN 'Panier Élevé (>= 500$)'
            WHEN total_order_value >= 100 THEN 'Panier Moyen (100$ - 499$)'
            ELSE 'Petit Panier (< 100$)'
        END AS order_tier
    FROM OrderValues
) Sub
GROUP BY order_tier
ORDER BY segment_revenue DESC;

-- 6. Sous-catégories stratégiques générant plus de 50 000 $ de CA (HAVING)
SELECT 
    Sub_Category,
    ROUND(SUM(List_Price * (1 - Discount_Percent / 100.0) * Quantity), 2) AS total_sales
FROM retail_orders
GROUP BY Sub_Category
HAVING SUM(List_Price * (1 - Discount_Percent / 100.0) * Quantity) > 50000
ORDER BY total_sales DESC;

-- 7. Évolution annuelle du chiffre d'affaires et croissance N vs N-1 (LAG)
WITH YearlySales AS (
    SELECT 
        YEAR(Order_Date) AS sales_year,
        ROUND(SUM(List_Price * (1 - Discount_Percent / 100.0) * Quantity), 2) AS annual_revenue
    FROM retail_orders
    GROUP BY YEAR(Order_Date)
)
SELECT 
    sales_year,
    annual_revenue,
    LAG(annual_revenue, 1) OVER (ORDER BY sales_year) AS previous_year_revenue,
    ROUND(
        (annual_revenue - LAG(annual_revenue, 1) OVER (ORDER BY sales_year)) 
        / NULLIF(LAG(annual_revenue, 1) OVER (ORDER BY sales_year), 0) * 100, 
        2
    ) AS yoy_growth_percent
FROM YearlySales;
