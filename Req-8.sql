SELECT CASE
		WHEN MONTH(date) IN (9,10,11) THEN 'Q1' /* Atliq hardware has september as it's first financial month*/
		WHEN MONTH(date) IN (12,1,2) THEN 'Q2'
		WHEN MONTH(date) IN (3,4,5) THEN 'Q3'
		ELSE 'Q4'
		END AS quarters,
	   SUM(sold_quantity) AS total_quantity_sold
FROM fact_sales_monthly
WHERE fiscal_year = 2020
GROUP BY quarters
ORDER BY total_quantity_sold DESC;