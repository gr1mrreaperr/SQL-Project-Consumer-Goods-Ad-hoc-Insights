WITH unique_product AS
(
 SELECT
      b.segment AS segment,
      COUNT(DISTINCT
          (CASE 
              WHEN fiscal_year = 2020 THEN a.product_code END)) AS product_count_2020,
       COUNT(DISTINCT
          (CASE 
              WHEN fiscal_year = 2021 THEN a.product_code END)) AS product_count_2021        
 FROM fact_sales_monthly AS a
 INNER JOIN dim_product AS b
 ON a.product_code = b.product_code
 GROUP BY b.segment
)
SELECT segment, product_count_2020, product_count_2021, (product_count_2021-product_count_2020) AS difference
FROM unique_product
ORDER BY difference DESC;