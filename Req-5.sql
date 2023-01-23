SELECT  a.product_code AS product_code /*here a is alias for dim_product table*/,
         a.product AS product,
		 CONCAT('$',ROUND(b.manufacturing_cost,2)) AS manufacturing_cost /*here b is alias for fact_manufacturing_cost table*/
FROM
dim_product AS a 
INNER JOIN
fact_manufacturing_cost AS b
ON a.product_code = b.product_code /* joining on key ie. product_code*/
WHERE b.manufacturing_cost = (SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost) /* filter to fetch product having max manufacturing cost*/
OR    b.manufacturing_cost = (SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost) /* filter to fetch product having min manufacturing cost*/
ORDER BY b.manufacturing_cost DESC;