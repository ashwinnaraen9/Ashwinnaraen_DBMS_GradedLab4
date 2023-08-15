# Q3) Display the total number of customers based on gender who have placed orders of worth at least Rs.3000.
#Identify tables [order]
SELECT * FROM `ORDER`;
#------------------------------------------------------------------------------------------------------
#Identify tables [order,CUSTOMER] AND APPLY JOIN
SELECT * FROM `ORDER` AS O
INNER JOIN CUSTOMER AS  C
ON O.CUS_ID = C.CUS_ID;
#------------------------------------------------------------------------------------------------------
# THOSE CUSTOMERS who have placed orders of worth at least Rs.3000
SELECT * FROM `ORDER` AS O
INNER JOIN CUSTOMER AS  C
ON O.CUS_ID = C.CUS_ID
HAVING O.ORD_AMOUNT>=3000;
#------------------------------------------------------------------------------------------------------
# REFINE COLUMNS ONLY RELEVANT
SELECT C.CUS_ID,CUS_NAME,CUS_GENDER,O.ORD_ID,O.ORD_AMOUNT FROM `ORDER` AS O
INNER JOIN CUSTOMER AS  C
ON O.CUS_ID = C.CUS_ID
HAVING O.ORD_AMOUNT>=3000;
#------------------------------------------------------------------------------------------------------
# SORT GENDER COLUMN WE HAVE ONE F AND 3 MALE SO COUNT CUS_GENDER 
SELECT COUNT(TEST.CUS_GENDER) AS NoOfCustomer, TEST.CUS_GENDER FROM
(
	SELECT C.CUS_ID,CUS_NAME,CUS_GENDER,O.ORD_ID,O.ORD_AMOUNT FROM `ORDER` AS O
	INNER JOIN CUSTOMER AS  C
	ON O.CUS_ID = C.CUS_ID
	HAVING O.ORD_AMOUNT>=3000
) AS TEST 
GROUP BY TEST.CUS_GENDER;
#------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------

SELECT COUNT(t2.cus_gender) AS NoOfCustomers, t2.cus_gender FROM
(
	SELECT t1.cus_id, t1.cus_gender, t1.ord_amount, t1.cus_name FROM 
	(
		SELECT `order`.*, customer.cus_gender, customer.cus_name FROM `order`
		INNER JOIN customer
		WHERE `order`.cus_id = customer.cus_id
		HAVING `order`.ord_amount >= 3000
	) AS t1  
) AS t2 GROUP BY t2.cus_gender;
