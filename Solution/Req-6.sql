SELECT a.customer_code ,
       b.customer,
       CONCAT(ROUND(AVG(pre_invoice_discount_pct)*100,2),'%') AS average_discount_percentage
FROM fact_pre_invoice_deductions AS a
INNER JOIN 
dim_customer AS b
ON a.customer_code = b.customer_code
WHERE market = 'India'
AND fiscal_year = 2021
GROUP BY customer, customer_code
ORDER BY AVG(pre_invoice_discount_pct) DESC
LIMIT 5;