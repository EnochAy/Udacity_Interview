---HARKERRANK
---Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
SELECT DISTINCT CITY 
FROM STATION 
WHERE (CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%') 
AND (CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u') 
order by city;      


-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY 
FROM STATION 
WHERE upper(SUBSTR(CITY,1,1)) 
NOT IN ('A','E','I','O','U') 
AND lower(SUBSTR(CITY,1,1)) 
NOT IN ('a','e','i','o','u');

SELECT DISTINCT CITY 
FROM STATION 
WHERE CITY NOT LIKE '^[aeiouAEIOU].*$'

    

SELECT DISTINCT CITY 
FROM STATION 
WHERE UPPER(SUBSTR(CITY, LENGTH(CITY), 1)) 
NOT IN ('A','E','I','O','U') 
AND LOWER(SUBSTR(CITY, LENGTH(CITY),1)) 
NOT IN ('a','e','i','o','u');


---Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY 
FROM STATION 
WHERE (CITY NOT IN (SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u'))
OR 
(CITY NOT IN (SELECT CITY FROM STATION WHERE CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%'));

SELECT DISTINCT CITY 
FROM station 
--WHERE CITY RLIKE '^[^aeiouAEIOU].*|.*[^AEIOUaeiou]$';

---Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY 
FROM STATION 
WHERE (CITY NOT IN (SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u'))
AND
(CITY NOT IN (SELECT CITY FROM STATION WHERE CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%'));

---Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
SELECT NAME 
FROM STUDENTS 
WHERE MARKS > 75 
ORDER BY SUBSTR(NAME, LENGTH(NAME)-2, 3), ID;  

---Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
SELECT name
FROM Employee
ORDER BY name;


---Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than $2000 per month who have been employees for less than  10 months. Sort your result by ascending employee_id.
SELECT name
FROM Employee
WHERE salary > 2000
AND months <10
ORDER BY employee_id;

---Query a count of the number of cities in CITY having a Population larger than 100,000.
SELECT COUNT(ID)
FROM CITY
WHERE POPULATION > 100000;

--Query the total population(SUM) of all cities in CITY where District is California(VARCHAR(20), USE STRING).
SELECT SUM(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';

--Query the average population of all cities in CITY where District is California.
SELECT AVG(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';

--Query the average population for all cities in CITY, rounded down to the nearest integer.
SELECT ROUND(AVG(POPULATION)) AS AvgPop
FROM CITY;

--Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.
SELECT SUM(POPULATION)
FROM CITY
WHERE COUNTRYCODE = 'JPN';

--Query the difference between the maximum and minimum populations in CITY.
SELECT MAX(POPULATION) - MIN(POPULATION)
FROM CITY;

---Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's  key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.

--Write a query calculating the amount of error (i.e.: Actual Miscalculated average monthly salaries), and round it up to the next integer.
SELECT ceil(AVG(SALARY) - AVG(replace(SALARY, '0', '')))
FROM EMPLOYEES;

--We define an employee's total earnings to be their monthly sALARY X MONTHS worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as 2 space-separated integers.
select (months * salary) as earnings, -- select employee's total earnings to be their monthly  worked
count(*) -- select all data
from Employee 
group by earnings -- group by earnings to find the count of the number of employees who have earned max 
order by earnings desc -- order by descending to get the height earning to lowest earning 
--limit 1 -- get the height earning and total number of employees who have maximum total earnings

--SELECT MAX(months * salary), COUNT(months * salary) FROM Employee WHERE (months * salary) = (SELECT MAX(months * salary) FROM Employee);
select max(months * salary), count(months * salary) 
from Employee where (months * salary) 
= (select max(months * salary) from Employee);


--The sum of all values in LAT_N rounded to a scale of decimal places. The sum of all values in LONG_W rounded to a scale of decimal places.
SELECT ROUND(SUM(lat_n), 2), ROUND(SUM(long_w), 2) 
FROM station;



---Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than  and less than . Truncate your answer to  decimal places
SELECT ROUND(SUM(LAT_N), 4)
FROM STATION
WHERE LAT_N >38.7880 AND LAT_N < 137.2345;

SELECT ROUND(SUM(LAT_N),4)
FROM STATION 
WHERE LAT_N BETWEEN 38.7880 AND 137.2345;

--Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to  4 decimal places.
SELECT ROUND(MAX(LAT_N), 4)
FROM STATION
WHERE LAT_N < 137.2345;

--Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. Round your answer to 4 decimal places.
SELECT ROUND(LONG_W,4)
FROM STATION
WHERE LAT_N = (SELECT MAX(LAT_N) FROM STATION WHERE LAT_N < 137.2345);

--Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780. Round your answer to  4 decimal places.
SELECT ROUND(MIN(LAT_N), 4)
FROM STATION
WHERE LAT_N > 38.7780;

--Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780. Round your answer to  4 decimal places.
SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N = (SELECT MIN(LAT_N) FROM STATION WHERE LAT_N > 38.7780);

--Query the Manhattan Distance between points  and  and round it to a scale of 4  decimal places.

SELECT ROUND(ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MAX(LONG_W) - MIN(LONG_W)),4) FROM STATION;

--Query the Euclidean Distance between points  and  and format your answer to display  decimal digits.
select round(sqrt(power(max(LAT_N) - min(LAT_N), 2) + power(max(LONG_W) - min(LONG_W), 2)), 4)
FROM STATION;