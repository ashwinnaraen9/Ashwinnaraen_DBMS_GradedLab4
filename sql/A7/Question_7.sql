#Q6) Find the least expensive product from each category and print the table with category id, name, 
# and price of the product
# Identify tables[supplier_pricing]
SELECT * FROM supplier_pricing;
# sort the PRO_ID column, we found that for each pro_id we have different supplier with different price so find least expensive
select PRO_ID, min(SUPP_PRICE) AS Min_Price from supplier_pricing GROUP BY PRO_ID;
#===================================================================================================
#APPLY JOIN  BETWEEN PRODUCT AND ABOVE RESULT
SELECT * FROM PRODUCT
INNER JOIN 
	(
		select PRO_ID, min(SUPP_PRICE) AS Min_Price from supplier_pricing GROUP BY PRO_ID
	) AS T1 ON PRODUCT.PRO_ID = T1.PRO_ID;

#===================================================================================================
#APPLY JOIN  BETWEEN CATEGORY AND ABOVE RESULT
SELECT * FROM CATEGORY
INNER JOIN
(
	SELECT * FROM PRODUCT
	INNER JOIN 
	(
		select PRO_ID, min(SUPP_PRICE) AS Min_Price from supplier_pricing GROUP BY PRO_ID
	) AS T1 ON PRODUCT.PRO_ID = T1.PRO_ID
) AS T2 ON T2.CAT_ID= CATEGORY.CAT_ID;
#===================================================================================================
# IT GIVES DUPLICATE COLUMN ERRO PRO_ID THERFORE WE HAVE TO REFINE T1 RESULT
SELECT * FROM CATEGORY
INNER JOIN
(
	SELECT PRODUCT.PRO_ID, PRODUCT.PRO_NAME,PRODUCT.CAT_ID,T1.Min_Price FROM PRODUCT
	INNER JOIN 
	(
		select PRO_ID, min(SUPP_PRICE) AS Min_Price from supplier_pricing GROUP BY PRO_ID
	) AS T1 ON PRODUCT.PRO_ID = T1.PRO_ID
) AS T2 ON T2.CAT_ID= CATEGORY.CAT_ID;

#===================================================================================================
#WHEN WE SORT WE FOUND MORE THAN ONE CAT_ID WITH DIFFRENT PRICE SO WE HAVE TO select MINIMUM PRICE FROM 
# ABOVE RESULT AND JOIN WITH CATEGORY TABLE

SELECT category.cat_id, category.cat_name, MIN(t3.min_price) AS Min_Price FROM category 
INNER JOIN 
(
	SELECT product.cat_id, product.pro_name, t2.* FROM product
    INNER JOIN 
    (
		SELECT pro_id, MIN(supp_price) AS Min_Price FROM supplier_pricing  GROUP BY pro_id
	) AS t2 WHERE t2.pro_id = product.pro_id
) AS t3 WHERE t3.cat_id = category.cat_id
GROUP BY t3.cat_id;
#===================================================================================================

SELECT category.cat_id, category.cat_name, MIN(t3.min_price) AS Min_Price FROM category 
INNER JOIN 
(
	SELECT product.cat_id, product.pro_name, t2.* FROM product
    INNER JOIN 
    (
		SELECT pro_id, MIN(supp_price) AS Min_Price FROM supplier_pricing  GROUP BY pro_id
	) AS t2 WHERE t2.pro_id = product.pro_id
) AS t3 WHERE t3.cat_id = category.cat_id
GROUP BY t3.cat_id;

