

#  COVID-19 Data Analysis Using SQL

##  Overview

This project analyzes global **COVID-19 data** using SQL.
It explores **infection rates**, **death percentages**, **vaccination progress**, and **global trends** using two main datasets:

* **CovidDeaths** — contains information about total cases, deaths, and population.
* **CovidVaccinations** — contains vaccination data by country and date.

The purpose of this analysis is to extract **meaningful insights** about the pandemic’s spread, severity, and global response.

---

## Tools & Technologies

* **SQL Server / MySQL**
* **COVID-19 Worldwide Dataset (from Our World in Data)**
* **CTEs and Window Functions**
* **Views for Visualization (Power BI, Tableau, etc.)**

---

##  SQL Queries and Analysis

### 1️⃣ Preview the Data

```sql
-- Preview COVID Deaths dataset
SELECT *
FROM CovidDeaths
ORDER BY 3, 4;

-- Preview COVID Vaccinations dataset
 SELECT * FROM CovidVaccinations ORDER BY 3, 4;
```

---

### 2️⃣ Basic Data Selection

```sql
-- Select essential columns for analysis
SELECT 
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM CovidDeaths
ORDER BY 1, 2;
```

---

### 3️⃣ Total Cases vs Total Deaths

Shows the **death percentage** relative to total cases.

```sql
SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths * 100.0 / total_cases) AS DeathPercentage
FROM CovidDeaths
WHERE location LIKE '%Pakistan%'
ORDER BY 1, 2;
```

---

### 4️⃣ Infection Percentage by Population

Displays what percentage of each country’s population was infected.

```sql
SELECT 
    location,
    date,
    population,
    total_cases,
    (total_cases * 100.0 / population) AS CovidPercentage
FROM CovidDeaths
ORDER BY 1, 2;
```

---

### 5️⃣ Highest Infection Rate by Country

Finds the countries with the **highest infection rate** compared to their population.

```sql
SELECT 
    location,
    population,
    MAX(total_cases) AS HighestInfectionCount,
    MAX((total_cases * 100.0 / population)) AS InfectionPercentage
FROM CovidDeaths
GROUP BY location, population
ORDER BY InfectionPercentage DESC;
```

---

### 6️⃣ Countries with the Highest Death Count

Identifies the countries with the most total deaths.

```sql
SELECT 
    location,
    MAX(total_deaths) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;
```

---

### 7️⃣ Continents with the Highest Death Count

```sql
SELECT 
    continent,
    MAX(total_deaths) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;
```

---

### 8️⃣ Global Numbers — Daily Death Percentage

Calculates global **daily death percentages** based on new cases and deaths.

```sql
SELECT 
    date,
    SUM(new_cases) AS Total_New_Cases,
    SUM(new_deaths) AS Total_New_Deaths,
    (SUM(new_deaths) * 100.0 / SUM(new_cases)) AS Death_Percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;
```

---

### 9️⃣ Worldwide Death Percentage (All Time)

Aggregates totals across all dates to show the **global death percentage**.

```sql
SELECT 
    SUM(new_cases) AS Total_New_Cases,
    SUM(new_deaths) AS Total_New_Deaths,
    (SUM(new_deaths) * 100.0 / SUM(new_cases)) AS Death_Percentage
FROM CovidDeaths
WHERE continent IS NOT NULL;
```

---

### 🔟 Population vs Vaccination (Using CTE)

Analyzes population vs vaccination progress using a **Common Table Expression (CTE)**.

```sql
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
```

---

### 1️⃣1️⃣ Create a View for Visualization

This view stores vaccination progress by country for future use in dashboards.

```sql
CREATE VIEW PercentPopulationVaccination AS
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
WHERE d.continent IS NOT NULL;
```

---

##  Conclusion

This project demonstrates how **SQL** can be used to:

* Clean and explore real-world pandemic data,
* Perform aggregations and trend analysis, and
* Generate insights for reporting and visualization.
