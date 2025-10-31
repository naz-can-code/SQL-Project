--- Quick Preview of Table (Covid Deaths)

select *
from CovidDeaths

--- Quick Preview of Table (Covid Deaths)

select *
from CovidVaccinations


-- Select essential columns for analysis
select Location,date,total_cases,new_cases,total_deaths,population
from CovidDeaths
order by 1,2

--Total Cases vs Total Deaths (Death %)
select Location,date,total_cases,total_deaths,(total_deaths * 100.0 / total_cases)
 AS DeathPercentage
from CovidDeaths
where Location like '%Pakistan%'
order by 1,2

--- Population Infection Percentage Over Time
select Location,date,population,total_cases,(total_cases * 100.0 / population)
 AS CovidPercentage
from CovidDeaths
order by 1,2

--- Highest Infection Rate by Country (relative to population)
Select
Location,population,
Max(total_cases)AS HighestInfectionCount,
Max((total_cases * 100.0 / population))AS InfectionPercentage
from CovidDeaths
group BY Location,population
order by InfectionPercentage DESC

--- Countries with Highest Death Count 

Select Location,Max(total_deaths)AS TotalDeathCount
from CovidDeaths
Where continent is NOT NULL
group BY Location
order by TotalDeathCount desc

-- Continents with Highest Death Count
Select continent,Max(total_deaths)AS TotalDeathCount
from CovidDeaths
Where continent is not NULL
group BY continent
order by TotalDeathCount desc

-- Global Daily Numbers — Death Percentage per Day
SELECT 
  date,
  SUM(new_cases) AS Total_New_Cases,
  SUM(new_deaths) AS Total_New_Deaths,
  (SUM(new_deaths) * 100.0 / SUM(new_cases))
 AS Death_Percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

-- Worldwide Death Percentage (All-Time Aggregate)
SELECT 
  SUM(new_cases) AS Total_New_Cases,
  SUM(new_deaths) AS Total_New_Deaths,
  (SUM(new_deaths) * 100.0 / SUM(new_cases))
 AS Death_Percentage
FROM CovidDeaths
WHERE continent IS NOT NULL

-- Total Population vs Vaccinations (Using CTE) Cumulative vaccinations by location and date.
  WITH PopvsVac AS (
  SELECT 
    d.continent,
    d.location,
    d.date,
    d.population,
    v.new_vaccinations,
    SUM(CAST(v.new_vaccinations AS BIGINT)) OVER (
      PARTITION BY d.location 
      ORDER BY d.location, d.date
    ) AS Cumulative_Vaccinations
  FROM CovidDeaths d
  JOIN CovidVaccinations v
    ON d.location = v.location 
    AND d.date = v.date
  WHERE d.continent IS NOT NULL
  )
SELECT *,
  (Cumulative_Vaccinations * 100.0 / population) AS Vaccination_Percentage
FROM PopvsVac;

--- Creating View to store Data for later visuallization
Create View PercentPopulationVaccination as
SELECT 
    d.continent,
    d.location,
    d.date,
    d.population,
    v.new_vaccinations,
    SUM(CAST(v.new_vaccinations AS BIGINT)) OVER (
      PARTITION BY d.location 
      ORDER BY d.location, d.date
    ) AS Cumulative_Vaccinations
  FROM CovidDeaths d
  JOIN CovidVaccinations v
    ON d.location = v.location 
    AND d.date = v.date
  WHERE d.continent IS NOT NULL
