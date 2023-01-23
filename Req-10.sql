WITH top_sold_products AS /*creating a CTE for getting top selling products for all divisions*/
(
	SELECT b.division AS division,
		   b.product_code AS product_code,
		   b.product AS product,
		   SUM(a.sold_quantity) AS total_sold_quantity
	FROM fact_sales_monthly AS a
	INNER JOIN dim_product AS b
	ON a.product_code = b.product_code
	WHERE a.fiscal_year = 2021
	GROUP BY  b.division, b.product_code, b.product /* to get total sold quantity we will need to group it as shown in this part of query */
	ORDER BY total_sold_quantity DESC
),
top_sold_per_division AS /*creating this CTE to get top 3 based on total_sold quantity per division*/
(
 SELECT division,
	    product_code,
        product,
        total_sold_quantity,
        DENSE_RANK() OVER(PARTITION BY division ORDER BY total_sold_quantity DESC) AS rank_order /* using dense rank so that we can handle ties and still grab top 3 products*/
 FROM top_sold_products
 )
 SELECT * FROM top_sold_per_division
 WHERE rank_order <= 3;