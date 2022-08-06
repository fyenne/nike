-- Can you write a query to find all the employees whose sales exceed the median sales by product AND by customer country?
SELECT  distinct tbb.employeeID
FROM
(
	SELECT  od.productID
	       ,median(od.quantity) quantityMed
	       ,cus.country
	FROM orderdetails od
	LEFT JOIN
	(
		SELECT  o.Orderid
		       ,o.customerID
		       ,o.employeeID
		       ,cus.country
		FROM orders o
		LEFT JOIN
		(
			SELECT  customerID
			       ,country
			FROM customers
		) cus
		ON o.customerID = cus.customerID
	) o
	ON od.orderID = o.Orderid
	GROUP BY  od.productID
	         ,cus.country
) AS tba
JOIN
(
	SELECT  od.productID
	       ,employeeID
	       ,SUM(od.quantity) quantitySold
	FROM orderdetails od
	LEFT JOIN
	(
		SELECT  employeeID
		FROM employees
	) emp
	ON od.employeeID = emp.employeeID
	GROUP BY  emp.employeeID
	         ,od.productID
) AS tbb
ON tba.productID = tbb.productID
WHERE tba.quantityMed < tbb.quantitySold