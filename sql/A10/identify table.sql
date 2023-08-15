# IDENTIFIED the TABLE [ rating, `ORDER`] and apply join 
 select *  from `order` as o
 inner join rating as r
 on o.ORD_ID = r.ORD_ID;
#======================================================================================
 # fetch only relevant COLUMNS
 
 select o.PRICING_ID,r.ORD_ID,r.RAT_RATSTARS  from `order` as o
 inner join 
 rating as r
 on o.ORD_ID = r.ORD_ID;
#======================================================================================
# Join between supplier_pricing and test TABLE
 select * from supplier_pricing as sp
 inner join (
 select o.PRICING_ID,r.ORD_ID,r.RAT_RATSTARS  from `order` as o
 inner join 
 rating as r
 on o.ORD_ID = r.ORD_ID) as test
 on test.PRICING_ID = sp.PRICING_ID;
#======================================================================================
# taking relevant COLUMNS only

 select sp.SUPP_ID,test.ord_id,test.rat_ratstars from supplier_pricing as sp
 inner join (
 select o.PRICING_ID,r.ORD_ID,r.RAT_RATSTARS  from `order` as o
 inner join 
 rating as r
 on o.ORD_ID = r.ORD_ID) as test
 on test.PRICING_ID = sp.PRICING_ID;
#======================================================================================
# TAKING Average RAT_RATSTARS AS Average
 select test2.supp_id, sum(test2.rat_ratstars)/count(test2.rat_ratstars)  as Average from
 (select sp.SUPP_ID,test.ord_id,test.rat_ratstars from supplier_pricing as sp
 inner join (
 select o.PRICING_ID,r.ORD_ID,r.RAT_RATSTARS  from `order` as o
 inner join 
 rating as r
 on o.ORD_ID = r.ORD_ID) as test
 on test.PRICING_ID = sp.PRICING_ID) AS test2
 group by test2.supp_id;
#======================================================================================
# Apply Join between final and supplier TABLE

 select final.supp_id, supplier.SUPP_Name, final.Average from
 (select test2.supp_id, sum(test2.rat_ratstars)/count(test2.rat_ratstars)  as Average from
 (select sp.SUPP_ID,test.ord_id,test.rat_ratstars from supplier_pricing as sp
 inner join (
 select o.PRICING_ID,r.ORD_ID,r.RAT_RATSTARS  from `order` as o
 inner join 
 rating as r
 on o.ORD_ID = r.ORD_ID) as test
 on test.PRICING_ID = sp.PRICING_ID) AS test2
 group by test2.supp_id) as final
 inner join supplier 
 on supplier.SUPP_ID = final.supp_id;
#======================================================================================

#Apply CASE

SELECT report.supp_id, report.supp_name, report.Average,
    CASE
        WHEN report.Average = 5 THEN 'Excellent Service'
        WHEN report.Average > 4 THEN 'Good Service'
        WHEN report.Average > 2 THEN 'Average Service'
        ELSE 'Poor Service'
    END AS Type_of_Service FROM 
    (
		SELECT final.supp_id, supplier.supp_name, final.Average  FROM 
        (
			SELECT test2.supp_id,SUM(test2.rat_ratstars) / COUNT(test2.rat_ratstars) AS Average FROM 
            (
				SELECT supplier_pricing.supp_id, test.ORD_ID, test.RAT_RATSTARS FROM supplier_pricing
				INNER JOIN 
                (
					SELECT `order`.pricing_id, rating.ORD_ID, rating.RAT_RATSTARS FROM `order`
					INNER JOIN rating 
                    ON rating.`ord_id` = `order`.ord_id
				) AS test 
                ON test.pricing_id = supplier_pricing.pricing_id
			) AS test2 GROUP BY supplier_pricing.supp_id
        ) AS final 
        INNER JOIN supplier 
        ON final.supp_id = supplier.supp_id 
	) AS report;



