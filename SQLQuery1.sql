/* ==============================================================================
   PROJET : Analyse Commerciale & Ventes Retail
============================================================================== */

-- 1. Aperçu général et volume total de ventes
SELECT 
    COUNT(order_id) AS total_orders,
    ROUND(SUM(sale_price), 2) AS total_revenue,
    ROUND(AVG(sale_price), 2) AS average_order_value
FROM retail_orders;

-- 2. Top 10 des produits les plus vendus en chiffre d'affaires
SELECT 
    product_id, 
    ROUND(SUM(sale_price), 2) AS total_sales
FROM retail_orders
GROUP BY product_id
ORDER BY total_sales DESC
LIMIT 10;

-- 3. Répartition des ventes et marge par catégorie de produits
SELECT 
    category,
    COUNT(order_id) AS number_of_orders,
    ROUND(SUM(sale_price), 2) AS total_sales,
    ROUND(AVG(profit), 2) AS average_profit
FROM retail_orders
GROUP BY category
ORDER BY total_sales DESC;

-- 4. Analyse de la performance régionale
SELECT 
    region,
    COUNT(order_id) AS orders_count,
    ROUND(SUM(sale_price), 2) AS regional_sales
FROM retail_orders
GROUP BY region
ORDER BY regional_sales DESC;

-- 5. Catégorisation des commandes selon leur valeur (CASE WHEN)
SELECT 
    order_id,
    sale_price,
    CASE 
        WHEN sale_price >= 500 THEN 'Panier Élevé'
        WHEN sale_price >= 100 THEN 'Panier Moyen'
        ELSE 'Petit Panier'
    END AS order_tier
FROM retail_orders;

-- 6. Sous-catégories générant plus de 50 000 $ de chiffre d'affaires (Filtre HAVING)
SELECT 
    sub_category,
    ROUND(SUM(sale_price), 2) AS total_sales
FROM retail_orders
GROUP BY sub_category
HAVING SUM(sale_price) > 50000
ORDER BY total_sales DESC;
