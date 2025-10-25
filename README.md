# 🦠 COVID-19 Data Analysis

## 📌 <span style="font-weight:bold; font-size:20px;">Overview</span>
This project analyzes **COVID-19 statistics** across different countries and continents, focusing on:
- Total cases & new cases
- Total deaths & mortality rates
- Population impact (infection %)
- Vaccination progress

The goal is to highlight **infection severity**, **fatality risk**, and **vaccine rollout performance** worldwide.

---

## 📂 Data Sources
The analysis uses datasets from **Our World in Data**:

| Dataset | Description |
|--------|-------------|
| **coviddeath** | COVID-19 cases, deaths & population |
| **covidvaccination** | Vaccination progress data |

---

## 📊 Analysis Summary

### ✅ Basic Data Retrieval
Fetched core statistics: total cases, new cases, total deaths, population.

### ⚰️ Total Cases vs Total Deaths
Calculated **death percentage**, indicating mortality risk upon infection.

### 🇮🇳 Country Focus: India
Examined India's death rate for country-specific insights.

### 🧍 Total Cases vs Population
Computed **infection percentage** to show spread relative to population size.

### 🔝 Highest Infection Rate
Identified regions with **most widespread outbreaks**.

### ☠️ Highest Death Rate
Ranked locations with **severe fatal outcomes**.

### 🌍 Continent-wise Analysis
Summarized deaths and mortality rate by continent.

### 🏆 Continent Most Affected
Highlighted the continent with **highest cumulative deaths**.

### 🌐 Global Metrics
Derived global totals for:
- Cases
- Deaths
- Death percentage

### 💉 Vaccination Impact
Using **CTEs**, calculated:
- Percentage of population vaccinated

This shows global **vaccine rollout success** and areas still lacking coverage.

---

## 🧪 How to Run the Analysis
1. Ensure access to the **portfolio_project** database  
   (tables: `coviddeath`, `covidvaccination`)
2. Execute provided SQL queries
3. Modify filters (location/date) as needed

---

## ✅ Conclusion
This project demonstrates SQL skills including:
- Aggregations
- Window functions
- CTEs 
- Joins & filtering techniques

It provides **data-driven insights** into the pandemic’s human impact and vaccine progress globally & locally.

---

## 📎 Data Source
> **Our World in Data**  
Used under open data license.

