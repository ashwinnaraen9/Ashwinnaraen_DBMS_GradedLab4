# Que 8. 
# Display customer name and gender whose names start or end with character 'A'.
SELECT * FROM customer AS c;

# Exact Match
SELECT * FROM customer AS c WHERE c.CUS_NAME = 'MEGHA';

# Partial Match
# Names starting with A or names ending with c.
 
SELECT c.CUS_NAME,c.CUS_GENDER FROM customer AS c WHERE (c.CUS_NAME LIKE  'A%' OR c.CUS_NAME LIKE  '%A');
# Name starting with A and ending with N
SELECT * FROM customer AS c WHERE c.CUS_NAME LIKE  'A%N';