/* 1 List each country name where the population is larger than that of 'Russia'.*/
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

/* 2 Show the countries in Europe with a per capita GDP greater than 'United Kingdom'. */
SELECT name FROM world
WHERE continent = 'Europe' 
AND gdp/population >
     (SELECT gdp/population FROM world
      WHERE name='United Kingdom')

/* 3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.*/
SELECT name,continent FROM world
WHERE continent IN
     (SELECT DISTINCT continent FROM world
      WHERE name IN('Australia','Argentina'))
ORDER BY name

/* 4. Which country has a population that is more than Canada but less than Poland? Show the name and the population.*/
SELECT name, population FROM world
WHERE population > (SELECT population FROM world
      WHERE name = 'Canada') 
AND population < (SELECT population FROM world
      WHERE name = 'Poland')

/* 5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.*/
SELECT name, CONCAT(ROUND(population/(SELECT population 
                   FROM world WHERE name = 'Germany')*100),'%')
FROM world
WHERE continent = 'Europe';
