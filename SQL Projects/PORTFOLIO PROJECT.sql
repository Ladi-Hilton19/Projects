--checking for imported data in database
select * 
From [Portfolio Project]..CovidDeaths$
order by 3,4

select * 
From [Portfolio Project]..CovidVaccinations$
order by 3,4

--selecting Data we are going to be using

select location, date, total_cases, new_cases, total_deaths, population
From [Portfolio Project]..CovidDeaths$
order by 1,2

--Total Cases vs Total Deaths
--shows the likelihood of dying if you contract Covid in your country
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathRate
From [Portfolio Project]..CovidDeaths$
where location like '%states%'
order by 1,2

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathRate
From [Portfolio Project]..CovidDeaths$
where location like '%Nigeria%'
order by 1,2

--Total Cases vs Population
-- Percentage of Population that contracted Covid
select location, date, total_cases, population, (total_cases/population)*100 as InfectedRate
From [Portfolio Project]..CovidDeaths$
where location like '%States%'
order by 1,2

select location, date, total_cases, population, (total_cases/population)*100 as InfectedRate
From [Portfolio Project]..CovidDeaths$
where location like '%Nigeria%'
order by 1,2

--Countries with Highest Infection Rate compared to Population

select location, population, MAX(total_cases) as HighestInfestions, 
MAX((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio Project]..CovidDeaths$
GROUP BY location, population
order by PercentPopulationInfected desc

--Countries with the Highest Death Count per Population


select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From [Portfolio Project]..CovidDeaths$
where continent is not Null
GROUP BY location
order by TotalDeathCount desc

--Breaking it down per Continent 

select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From [Portfolio Project]..CovidDeaths$
where continent is Null
GROUP BY location
order by TotalDeathCount desc

select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From [Portfolio Project]..CovidDeaths$
where continent is not Null
GROUP BY continent
order by TotalDeathCount desc

select continent, location, date, total_cases, population, (total_cases/population)*100 as InfectedRate
From [Portfolio Project]..CovidDeaths$
where continent like '%North%'
order by InfectedRate desc

select continent, location, date, total_cases, population, (total_cases/population)*100 as InfectedRate
From [Portfolio Project]..CovidDeaths$
where continent like '%Africa%'
order by InfectedRate desc


--WORLD OVERVIEW

select date, SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, SUM(cast(new_deaths as int))/
SUM(new_cases)*100 as DeathPercentage
From [Portfolio Project]..CovidDeaths$
where continent is not Null
GROUP BY date
order by 1,2 desc

select SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, SUM(cast(new_deaths as int))/
SUM(new_cases)*100 as DeathPercentage
From [Portfolio Project]..CovidDeaths$
where continent is not Null
order by 1,2 desc

select *
from [Portfolio Project]..CovidDeaths$ dea
Join [Portfolio Project]..CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date


select *
from [Portfolio Project]..CovidDeaths$ dea
Join [Portfolio Project]..CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from [Portfolio Project]..CovidDeaths$ dea
Join [Portfolio Project]..CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 1,2,3


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int ,vac.new_vaccinations)) OVER (Partition by dea.location Order by
dea.location, dea.date) as RollingPeopleVaccinated
from [Portfolio Project]..CovidDeaths$ dea
Join [Portfolio Project]..CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


--USING CTE

with PopvsVac (Continent, Location, Date, Population, new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int ,vac.new_vaccinations)) OVER (Partition by dea.location Order by 
dea.location, dea.date) as RollingPeopleVaccinated
from [Portfolio Project]..CovidDeaths$ dea
Join [Portfolio Project]..CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac


--Temp Table

DROP TABLE IF EXISTS #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric,
)

Insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int ,vac.new_vaccinations)) OVER (Partition by dea.location Order by 
dea.location, dea.date) as RollingPeopleVaccinated
from [Portfolio Project]..CovidDeaths$ dea
Join [Portfolio Project]..CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated

--Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int ,vac.new_vaccinations)) OVER (Partition by dea.location Order by 
dea.location, dea.date) as RollingPeopleVaccinated
from [Portfolio Project]..CovidDeaths$ dea
Join [Portfolio Project]..CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3

