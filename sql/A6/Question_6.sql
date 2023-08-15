#Q5) Display the Supplier details of who is supplying more than one product.
# Identfiy tables supplier_pricing
select * from supplier_pricing;
#==================================================================================================
# sort the supp_id column we found that each supplier having more than one pro_id so we have 
SELECT supp_id FROM supplier_pricing GROUP BY supp_id HAVING COUNT(supp_id) > 1;
#==================================================================================================
# Now Join above result with supplier table
SELECT supplier.* FROM supplier
WHERE supplier.supp_id IN (SELECT supp_id FROM supplier_pricing GROUP BY supp_id HAVING COUNT(supp_id) > 1)
GROUP BY supplier.supp_id;
