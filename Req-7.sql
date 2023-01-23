SELECT 
       MONTHNAME(date) AS month_name,
       YEAR(date) AS year_, 
       CONCAT('$',ROUND(SUM(a.sold_quantity * b.gross_price)/1000000,2)) AS gross_sales_amount_millions /*value in millions*/
FROM fact_sales_monthly AS a
INNER JOIN fact_gross_price AS b
ON b.product_code = a.product_code
AND b.fiscal_year = a.fiscal_year
INNER JOIN dim_customer AS c
ON c.customer_code = a.customer_code
WHERE c.customer = 'Atliq Exclusive'
GROUP BY month_name, year_
ORDER BY year_;