WITH gross_sales AS
( 
 SELECT c.channel AS channel_,
        ROUND(SUM(b.gross_price*a.sold_quantity)/1000000,2) /* converting values to millions*/
 AS gross_sales_million
 FROM fact_sales_monthly AS a
 LEFT JOIN fact_gross_price AS b
 ON a.product_code = b.product_code
 AND a.fiscal_year = b.fiscal_year
LEFT JOIN dim_customer AS c
 ON 
 a.customer_code = c.customer_code
 WHERE a.fiscal_year = 2021
 GROUP BY c.channel
)

SELECT channel_,
       CONCAT('$',gross_sales_million) AS gross_sales_million,
	CONCAT(ROUND(gross_sales_million/ SUM(gross_sales_million) OVER()*100,2),'%') AS percentage
FROM gross_sales
ORDER BY percentage DESC;