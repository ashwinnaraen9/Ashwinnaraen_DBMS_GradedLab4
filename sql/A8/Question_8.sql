# Q7) Display the Id and Name of the Product ordered after “2021-10-05”. 
# Identify the TABLES [order,supplier_pricing]
SELECT * FROM  `order`;
#======================================================================================
# from above result we can see that pricing_id is  common between order table and supplier_pricing table so apply join
SELECT * FROM `order` AS o
INNER JOIN supplier_pricing AS sp 
ON o.pricing_id = sp.pricing_id;
#======================================================================================
# Now Apply join between Product table and test table
SELECT test.pro_id, p.pro_name FROM product as p
INNER JOIN (
			SELECT * FROM `order` AS o
			INNER JOIN supplier_pricing AS sp 
			ON o.pricing_id = sp.pricing_id
            ) as test
on test.pro_id= p.pro_id;
# it will give name duplicate column name pricing_id
#======================================================================================
SELECT test.pro_id, p.pro_name FROM product as p
INNER JOIN (
			SELECT o.ord_id, o.ord_date,sp.pro_id FROM `order` AS o
			INNER JOIN supplier_pricing AS sp 
			ON o.pricing_id = sp.pricing_id
            ) as test
on test.pro_id= p.pro_id;
 
#======================================================================================
SELECT product.pro_id, product.pro_name FROM `order`
INNER JOIN supplier_pricing 
ON supplier_pricing.pricing_id = `order`.pricing_id
INNER JOIN product 
ON product.pro_id = supplier_pricing.pro_id
WHERE `order`.ord_date > '2021-10-05';