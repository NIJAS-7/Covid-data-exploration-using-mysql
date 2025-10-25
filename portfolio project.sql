CREATE TABLE covid_data (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date varchar(100),
    population BIGINT,
    total_cases DOUBLE,
    new_cases DOUBLE,
    new_cases_smoothed DOUBLE,
    total_deaths DOUBLE,
    new_deaths DOUBLE,
    new_deaths_smoothed DOUBLE,
    total_cases_per_million DOUBLE,
    new_cases_per_million DOUBLE,
    new_cases_smoothed_per_million DOUBLE,
    total_deaths_per_million DOUBLE,
    new_deaths_per_million DOUBLE,
    new_deaths_smoothed_per_million DOUBLE,
    reproduction_rate DOUBLE,
    icu_patients DOUBLE,
    icu_patients_per_million DOUBLE,
    hosp_patients DOUBLE,
    hosp_patients_per_million DOUBLE,
    weekly_icu_admissions DOUBLE,
    weekly_icu_admissions_per_million DOUBLE,
    weekly_hosp_admissions DOUBLE,
    weekly_hosp_admissions_per_million DOUBLE
);

LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidDeaths1.csv"
INTO TABLE covid_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;


select * from covid_data
;

CREATE TABLE covid_vaccination (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date varchar(20),
    new_tests INT,
    total_tests BIGINT,
    total_tests_per_thousand DECIMAL(10,2),
    new_tests_per_thousand DECIMAL(10,2),
    new_tests_smoothed DECIMAL(10,2),
    new_tests_smoothed_per_thousand DECIMAL(10,2),
    positive_rate DECIMAL(5,4),
    tests_per_case DECIMAL(10,2),
    tests_units VARCHAR(50),
    total_vaccinations BIGINT,
    people_vaccinated BIGINT,
    people_fully_vaccinated BIGINT,
    new_vaccinations BIGINT,
    new_vaccinations_smoothed DECIMAL(10,2),
    total_vaccinations_per_hundred DECIMAL(5,2),
    people_vaccinated_per_hundred DECIMAL(5,2),
    people_fully_vaccinated_per_hundred DECIMAL(5,2),
    new_vaccinations_smoothed_per_million DECIMAL(10,2),
    stringency_index DECIMAL(5,2),
    population_density DECIMAL(10,2),
    median_age DECIMAL(4,1),
    aged_65_older DECIMAL(5,2),
    aged_70_older DECIMAL(5,2),
    gdp_per_capita DECIMAL(10,2),
    extreme_poverty DECIMAL(5,2),
    cardiovasc_death_rate DECIMAL(6,2),
    diabetes_prevalence DECIMAL(5,2),
    female_smokers DECIMAL(5,2),
    male_smokers DECIMAL(5,2),
    handwashing_facilities DECIMAL(5,2),
    hospital_beds_per_thousand DECIMAL(5,2),
    life_expectancy DECIMAL(5,2),
    human_development_index DECIMAL(4,3)
);

LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidVaccinations.csv"
INTO TABLE covid_vaccination
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from covid_vaccination;

select location,date,total_cases,new_cases,total_deaths,population
from covid_data
where continent is not null
order by 1,2;

-- Showing the chances of dying in a specific country
select location,
date,
total_cases,total_deaths,
round((total_deaths/total_cases)*100,3) as death_percentage
from covid_data
where location in ('india');

-- Looking at total_cases vs total-deaths 
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as deathpercentage
from covid_data
where location like '%india%'
order by 1,2;

-- Looking at Total_cases vs population

SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    population,
    (total_cases / population) * 100 AS percntpopulationinfected
FROM
    covid_data
WHERE
    location LIKE '%india%'
    and  continent is not null
ORDER BY 1 , 2;




 -- looking at countries with highest infection rate

select location,MAX(date) AS latest_date,population, MAX(total_cases) as highestinfectioncount,max((total_cases/population))*100  as percntpopulationinfected
from covid_data
-- where location like '%india%'
where continent is not null
GROUP BY location, population
ORDER BY percntpopulationinfected desc ;

-- showing countries with highest deadth count per population
select location, MAX(total_deaths) as totaldeathcount
from covid_data
-- where location like '%india%'
WHERE continent IS NOT NULL AND location NOT IN ('Europe', 'Asia', 'Africa', 'World', 'Oceania', 'North America', 'South America','European Union')
GROUP BY location
ORDER BY totaldeathcount desc ;

-- break it down by continent
select location, MAX(total_deaths) as totaldeathcount
from covid_data
-- where location like '%india%'
WHERE continent IS  not null 
GROUP BY location
ORDER BY totaldeathcount desc ;

-- showing continents with the highest death count per population
select continent, MAX(total_deaths) as totaldeathcount
from covid_data
-- where location like '%india%'
WHERE continent IS  not null 
GROUP BY continent
ORDER BY totaldeathcount desc ;

-- Global Numbers
select sum(new_cases) as total_cases,sum(new_deaths) as total_deaths,(sum(new_deaths)/sum(new_cases) )*100 as deathpercentage
from covid_data
-- where location like '%india%'
where continent is not null
group by date
order by 1,2;

-- Looking at total population vs vaccination
-- use cte
with popvsvac (continent,location,date,population,new_vaccinations,rollingpeoplevaccinated)
as
(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location
,dea.date)*100 as rollingpeoplevaccinated
from covid_data dea
join covid_vaccination vac on dea.location =vac.location
and dea.date = vac.date
where dea.continent is not null
-- order by 2,3;
)
select *, (rollingpeoplevaccinated/population)*100
from popvsvac;
  
  
-- creating view to store data for visualization

create view popvsvac as
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location
,dea.date)*100 as rollingpeoplevaccinated
from covid_data dea
join covid_vaccinatpopvsvacpopvsvacion vac on dea.location =vac.location
and dea.date = vac.date
where dea.continent is not null
-- order by 2,3;




























