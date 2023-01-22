WITH unique_product_count AS
(
	SELECT COUNT(DISTINCT CASE WHEN fiscal_year = 2020 THEN product_code END) AS unique_products_2020,/* count of distinct/unique products sold in 2020 */
		   COUNT(DISTINCT CASE WHEN fiscal_year = 2021 THEN product_code END) AS unique_products_2021 /* count of distinct/unique products sold in 2021 */
		   FROM fact_sales_monthly 
)
SELECT unique_products_2020,
	   unique_products_2020,
	   CONCAT(ROUND(((unique_products_2021-unique_products_2020)*1.0/unique_products_2020)*100,2),'%') AS percentage_chg
FROM unique_product_count;