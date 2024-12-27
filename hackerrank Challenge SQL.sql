--'Query the two cities in STATION with the shortest and longest CITY names,
--as well as their respective lengths (i.e.: number of characters in the name).
--If there is more than one smallest or largest city, choose the one that comes
--first when ordered alphabetically.(SELECT city, length(city)
--ANSWER:

FROM station
WHERE length(city) = (SELECT MIN(length(city))FROM station)
ORDER BY 1  ASC
LIMIT 1)
UNION ALL
(SELECT city, length(city)
FROM station
WHERE length(city) = (SELECT MAX(length(city))FROM station)
ORDER BY 1  ASC
LIMIT 1)

--Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u)
--from STATION. Your result cannot contain duplicates.
--ANSWER:

SELECT DISTINCT city
FROM station
WHERE city LIKE 'a%' or city like 'e%' OR city like 'i%'
OR city LIKE 'o%' OR city LIKE 'u%'

--Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION.
--Your result cannot contain duplicates.


--Query the list of CITY names from STATION that do not end with vowels.
--Your result cannot contain duplicates.
SELECT DISTINCT city
FROM station
WHERE city NOT LIKE '%a' AND city NOT LIKE '%e' AND city NOT LIKE '%i'
AND city NOT LIKE '%o' AND city NOT LIKE '%u'

--Query the list of CITY names from STATION that either do not start with vowels
--or do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT city
FROM station
WHERE (city NOT LIKE '%a' AND city NOT LIKE '%e' AND city NOT LIKE '%i'
      AND city NOT LIKE '%o' AND city NOT LIKE '%u')
OR (city NOT LIKE 'a%' AND city NOT LIKE 'e%' AND city NOT LIKE 'i%'
    AND city NOT LIKE 'o%' AND city NOT LIKE 'u%')

--Query the list of CITY names from STATION that do not start with vowels and
--do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT city
FROM station
WHERE (city NOT LIKE '%a' AND city NOT LIKE '%e' AND city NOT LIKE '%i'
      AND city NOT LIKE '%o' AND city NOT LIKE '%u')
AND (city NOT LIKE 'a%' AND city NOT LIKE 'e%' AND city NOT LIKE 'i%'
    AND city NOT LIKE 'o%' AND city NOT LIKE 'u%')

--Query the Name of any student in STUDENTS who scored higher than 75 Marks.
--Order your output by the last three characters of each name. If two or more
--students both have names ending in the same last three characters
--(i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
SELECT name
FROM students
WHERE marks > 75
ORDER BY RIGHT(name, 3), id ASC

--Write a query that prints a list of employee names (i.e.: the name attribute)
--from the Employee table in alphabetical order.
SELECT name
FROM employee
ORDER BY name

--Write a query that prints a list of employee names (i.e.: the name attribute)
--for employees in Employee having a salary greater than $2000 per month who have been
--employees for less than 10 months. Sort your result by ascending employee_id.
SELECT name
FROM employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id;

--Query the average population of all cities in CITY where District is California.
SELECT AVG(population)
FROM city
WHERE district = 'California'

--Query the average population for all cities in CITY, rounded down to the nearest integer.
SELECT ROUND(AVG(population))
FROM city

--Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.
SELECT SUM(population)
FROM city
WHERE countrycode = 'JPN'

--Query the difference between the maximum and minimum populations in CITY.
SELECT (MAX(population) - MIN(population))
FROM city

--Samantha was tasked with calculating the average monthly salaries for all
--employees in the EMPLOYEES table, but did not realize her keyboard's  key was
--broken until after completing the calculation. She wants your help finding
--the difference between her miscalculation (using salaries with any zeros
--removed), and the actual average salary.

--Write a query calculating the amount of error (i.e.: Actual - Miscalculated
--average monthly salaries), and round it up to the next integer.
SELECT CEIL(ABS(AVG(salary) - AVG(CAST(REPLACE(CAST(salary AS CHAR), '0', '') AS UNSIGNED))))
FROM employees --MYSQL Syntax ...CEIL(ABS(...)) == ROUND

--We define an employee's total earnings to be their monthly  SALARY X MONTHS worked, and the
--maximum total earnings to be the maximum total earnings for any employee in
--the Employee table. Write a query to find the maximum total earnings for all
--employees as well as the total number of employees who have maximum total earnings.
--Then print these values as 2 space-separated integers.
SELECT *, count(*)
FROM (                                      --WRONG ANSWER
    SELECT MAX(salary*months) max FROM employee) sub
group by sub.max

--CORRECT ANSWER
SELECT MAX(salary*months), COUNT(*)
FROM employee
WHERE salary*months = (SELECT MAX(salary*months) FROM employee);

--EXPANATION:
--1. Subquery for MAX Value:
(SELECT MAX(your_column) FROM your_table) --finds the maximum value in the column your_column.

--2. COUNT Occurrences:
COUNT(*) --counts the number of rows in your_table where your_column is equal
--to the maximum value obtained from the subquery.

--3. Filtering:
WHERE --clause ensures that the count is only for rows where the column value matches the maximum value.

--*Query the following two values from the STATION table:
--1. The sum of all values in LAT_N rounded to a scale of  decimal places.
--2. The sum of all values in LONG_W rounded to a scale of  decimal places.
SELECT ROUND(SUM(lat_n), 2), ROUND(SUM(long_w), 2)
FROM station

--Query the sum of Northern Latitudes (LAT_N) from STATION having values greater
--than 38.7880 and less than 137.2345. Truncate your answer to 4 decimal places.
SELECT ROUND(SUM(lat_n), 4)
FROM station
WHERE lat_n > 38.7880 AND lat_n < 137.2345

--Query the greatest value of the Northern Latitudes (LAT_N) from STATION that
--is less than 137.2345 . Truncate your answer to 4 decimal places.
SELECT ROUND(lat_n, 4)
FROM station
WHERE lat_n < 137.2345
ORDER  BY lat_n DESC
LIMIT 1

--Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N)
--in STATION that is less than 137.2345. Round your answer to 4 decimal places.
SELECT ROUND(long_w, 4)
FROM station
WHERE lat_n < 137.2345
ORDER  BY lat_n DESC
LIMIT 1

--Query the smallest Northern Latitude (LAT_N) from STATION that is greater than
--38.7880 . Round your answer to 4 decimal places.
SELECT ROUND(lat_n, 4)
FROM station
WHERE lat_n > 38.7780
ORDER BY lat_n
LIMIT 1

--Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N)
--in STATION is greater than 38.7880. Round your answer to 4 decimal places.
SELECT ROUND(long_w, 4)
FROM station
WHERE lat_n > 38.7780
ORDER BY lat_n
LIMIT 1

--Consider P1(a,b) and P2(c,d) to be two points on a 2D plane.
-- a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
-- b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
-- c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
-- d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
--Query the Manhattan Distance between points P1 and P2 and round it to a
--scale of 4 decimal places.
--Manhattan Distance:The distance between two points measured along axes at right angles.
--In a plane with p1 at (x1, y1) and p2 at (x2, y2), it is |x1 - x2| + |y1 - y2|
SELECT ROUND((ABS(MIN(lat_n) - MAX(lat_n)) + (ABS(MIN(long_w) - MAX(long_w)))), 4)
FROM station

--Consider P1(a,c) and P2(b,d) to be two points on a 2D plane where (a,b) are the respective minimum
--and maximum values of Northern Latitude (LAT_N) and (c,d) are the respective minimum
--and maximum values of Western Longitude (LONG_W) in STATION.
--Query the Euclidean Distance between points P1 and P2 and format your answer to
--display 4 decimal digits.
--the Euclidean Distance = sqrt {(a - b)^2 + (c - d)^2}
SELECT ROUND(SQRT(POW(MIN(lat_n) - MAX(lat_n), 2) +  POW(MIN(long_w) - MAX(long_w), 2)), 4)
FROM station

--A median is defined as a number separating the higher half of a data set from
--the lower half. Query the median of the Northern Latitudes (LAT_N) from STATION
--and round your answer to 4 decimal places.
SELECT ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY lat_n), 4)
FROM station; --WRITTEN in ORACLE

--Write a query identifying the type of each record in the TRIANGLES table using
--its three side lengths. Output one of the following statements for each record in the table:
--*Equilateral: It's a triangle with 3 sides of equal length.
--*Isosceles: It's a triangle with 2 sides of equal length.
--*Scalene: It's a triangle with 3 sides of differing lengths.
--*Not A Triangle: The given values of A, B, and C don't form a triangle.
SELECT CASE
          WHEN (a + b <= c) or (b + c <= a) or (a+c <= b) THEN 'Not A Triangle'
          WHEN a = b and b = c and a = c THEN 'Equilateral'
          WHEN (a = b and a != c and b != c) OR (a = c and a != b and c !=b) or (b = c and b != a and c != a ) THEN 'Isosceles'
          ELSE 'Scalene'
      END
FROM triangles

--Generate the following two result sets:

--Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
--Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
--There are a total of [occupation_count] [occupation]s.
--where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

--Note: There will be at least two entries in the table for each type of occupation.
SELECT CONCAT(name, '(', LEFT(occupation, 1), ')')
FROM occupations
ORDER BY name;

SELECT CONCAT('There are a total of ', COUNT(occupation), ' ', LOWER(occupation), 's.')
FROM occupations
GROUP BY occupation
ORDER BY COUNT(occupation), occupation;

--Pivot the Occupation column in OCCUPATIONS so that each Name is sorted
--alphabetically and displayed underneath its corresponding Occupation. The output
--column headers should be Doctor, Professor, Singer, and Actor, respectively.

--Note: Print NULL when there are no more names corresponding to an occupation.
