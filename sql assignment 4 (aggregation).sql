use world;

##Answer 1
SELECT CountryCode, COUNT(*) AS TotalCities
FROM city
GROUP BY CountryCode;

##Answer 2
SELECT Continent, COUNT(*) AS TotalCountries
FROM country
GROUP BY Continent
HAVING COUNT(*) > 30;

##Answer 3
SELECT Region, SUM(Population) AS TotalPopulation
FROM country
GROUP BY Region
HAVING SUM(Population) > 200000000;

##Answer 4
SELECT Continent, 
ROUND(AVG(GNP),2) AS AvgGNP
FROM country
GROUP BY Continent
ORDER BY AvgGNP DESC
LIMIT 5;

##Answer 5
SELECT c.Continent, COUNT(DISTINCT cl.Language) AS TotalOfficialLanguages
FROM country c
JOIN countrylanguage cl
    ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T'
GROUP BY c.Continent;

##Answer 6
SELECT Continent,
       MAX(GNP) AS MaxGNP,
       MIN(GNP) AS MinGNP
FROM country
GROUP BY Continent;

##Answer7
SELECT country_Name AS countryName,
       AVG(ci.Population) AS AvgCityPopulation
FROM country c
JOIN city ci
    ON c.Code = ci.CountryCode
GROUP BY c.Code
ORDER BY AvgCityPopulation DESC
LIMIT 1;

##Answer 8
SELECT c.Continent,
      AVG (ci.Population)AS AvgCityPopulation
FROM country c
JOIN city ci
    ON c.Code = ci.CountryCode
GROUP BY c.Continent
HAVING AVG(ci.Population) > 200000;

##Answer 9
SELECT Continent,
       SUM(Population) AS TotalPopulation,
       AVG(LifeExpectancy) AS AvgLifeExpectancy
FROM country
GROUP BY Continent
ORDER BY AvgLifeExpectancy DESC;

##Answer 10
SELECT Continent,
       SUM(Population) AS TotalPopulation,
       AVG(LifeExpectancy) AS AvgLifeExpectancy
FROM country
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY AvgLifeExpectancy DESC
LIMIT 3;






