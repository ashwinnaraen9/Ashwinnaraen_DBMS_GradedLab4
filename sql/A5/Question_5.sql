# Q4) Display all the orders along with product name ordered by a customer having Customer_Id=2
# Identfiy tables [Order, supplier_pricing]
SELECT O.ORD_ID,O.ORD_DATE,O.ORD_AMOUNT,O.CUS_ID, SP.PRO_ID FROM `order` AS O
INNER JOIN supplier_pricing AS SP
ON O.PRICING_ID=SP.PRICING_ID;
#==========================================================================================
# Identfiy tables [Order, supplier_pricing,PRODUCT]
# APPLY JOIN BETWEEN PRODUCT AND ABOVE RESULT
SELECT * FROM PRODUCT AS P
INNER JOIN
(
	SELECT O.ORD_ID,O.ORD_DATE,O.ORD_AMOUNT,O.CUS_ID, SP.PRO_ID FROM `order` AS O
	INNER JOIN supplier_pricing AS SP
	ON O.PRICING_ID=SP.PRICING_ID
) AS T1 ON T1.PRO_ID = P.PRO_ID;
#==========================================================================================
# REFINE RELEVENT COLUMN ONLY 
SELECT T1.ORD_ID,T1.ORD_DATE,T1.ORD_AMOUNT,T1.CUS_ID, P.PRO_ID FROM PRODUCT AS P
INNER JOIN
(
	SELECT O.ORD_ID,O.ORD_DATE,O.ORD_AMOUNT,O.CUS_ID, SP.PRO_ID FROM `order` AS O
	INNER JOIN supplier_pricing AS SP
	ON O.PRICING_ID=SP.PRICING_ID
) AS T1 ON T1.PRO_ID = P.PRO_ID;
#==========================================================================================
# APPLY JOIN WITH CUSTOMER TABLE
SELECT C.CUS_ID,C.CUS_NAME, T2.ORD_ID,T2.ORD_DATE,T2.ORD_AMOUNT, T2.PRO_NAME FROM CUSTOMER AS C
INNER JOIN
(
	SELECT T1.ORD_ID,T1.ORD_DATE,T1.ORD_AMOUNT,T1.CUS_ID, P.PRO_ID , P.PRO_NAME FROM PRODUCT AS P
	INNER JOIN
	(
		SELECT O.ORD_ID,O.ORD_DATE,O.ORD_AMOUNT,O.CUS_ID, SP.PRO_ID FROM `order` AS O
		INNER JOIN supplier_pricing AS SP
		ON O.PRICING_ID=SP.PRICING_ID
	) AS T1 ON T1.PRO_ID = P.PRO_ID
) AS T2 ON T2.CUS_ID = C.CUS_ID;
#==========================================================================================
# DISPLAY ONLY THAT CUSTOMER WHOSE ID =2
SELECT C.CUS_ID,C.CUS_NAME, T2.ORD_ID,T2.ORD_DATE,T2.ORD_AMOUNT, T2.PRO_NAME FROM CUSTOMER AS C
INNER JOIN
(
	SELECT T1.ORD_ID,T1.ORD_DATE,T1.ORD_AMOUNT,T1.CUS_ID, P.PRO_ID , P.PRO_NAME FROM PRODUCT AS P
	INNER JOIN
	(
		SELECT O.ORD_ID,O.ORD_DATE,O.ORD_AMOUNT,O.CUS_ID, SP.PRO_ID FROM `order` AS O
		INNER JOIN supplier_pricing AS SP
		ON O.PRICING_ID=SP.PRICING_ID
	) AS T1 ON T1.PRO_ID = P.PRO_ID
) AS T2 ON T2.CUS_ID = C.CUS_ID AND C.CUS_ID=2;

#==========================================================================================
# Alternative approach.

SELECT  product.pro_name, `order`.* FROM `order`, supplier_pricing, product
WHERE `order`.cus_id = 2
AND `order`.pricing_id = supplier_pricing.pricing_id
AND supplier_pricing.pro_id = product.pro_id;
