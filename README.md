#Cost-Efficiency-Analysis-of-CNG-vs-PMS-Vehicle-Conversion-in-Nigeria-Option-2-Portfolio-Friendly

## Table of Content 

1. [Project Overview](#project-overview)
2. [Business Context](#business-context)
3. [Dataset Source and Description](#dataset-source-and-description)
4. [Assumptions](#assumptions)
5. [Methodology](#methodology)
6. [Data Analysis](#data-analysis)
7. [Tools Used](#tools-used)
   
10. [Key Metrics Measured](#key-metrics-measured)
11. [Dashboard Overview](#dashboard-overview)
12. [Key Insight and Findings](#key-insight-and-findings) 
13. [Business Implications](#business-implications)
14. [Recommendation](#recommendation)

## Project Overview
With rising fuel costs in Nigeria and increased interest in alternative energy sources, many vehicle owners are considering converting their vehicles from Petrol Motor Spirit (PMS) to Compressed Natural Gas (CNG). This project evaluates whether CNG conversion is financially worthwhile by comparing fuel costs, monthly spending, savings, and payback periods across different vehicle categories, engine types, and brands.

The analysis is designed to answer one core question:
Is CNG truly cheaper than PMS in real-world usage, and how long does it take to recover the conversion cost?


## Business Context
Nigeria’s transportation sector is highly sensitive to fuel price changes. While CNG is often promoted as a cheaper and cleaner alternative, conversion requires a significant upfront investment. Vehicle owners, fleet operators, and policymakers need clear, data-backed insights to understand:
1. How fuel efficiency differs between PMS and CNG
2. How monthly fuel spending compares under a fixed driving distance
3. Whether conversion costs can be recovered within a reasonable timeframe

This project simulates a realistic decision-making scenario using standardized assumptions to support fair comparison.

## Dataset Source and Description
The dataset was self-created to reflect realistic vehicle and fuel scenarios and consists of three main tables:
1. Vehicle Profiles
Contains vehicle-level attributes such as:
 - Vehicle category (Sedan, SUV, Bus)
 - Brand
 - Engine type
 - PMS fuel efficiency (km per liter)
 - CNG fuel efficiency (km per kg)
 - Fuel tank / CNG tank capacity
2. Fuel Prices
Stores current fuel prices in Nigeria:
- PMS price per liter
- CNG price per kg
3. Conversion Costs
Contains the one-time cost required to convert vehicles from PMS to CNG, categorized by vehicle type and engine configuration.

## Assumptions
To ensure consistency across comparisons, the following assumptions were applied:
 - Monthly driving distance is fixed at 1,000 km
 - Fuel prices are constant across vehicle categories
 - Vehicles operate under average driving conditions
 - Conversion cost is paid upfront (no financing considered)
 - Analysis focuses on fuel cost only (maintenance differences excluded)

## Methodology 
The analysis followed a structured, end-to-end workflow:
1. Data Preparation
 - Created and cleaned datasets in Excel
 - Imported data into MySQL
 - Ensured correct data types for numeric calculations
2. Data Modeling
 - Structured relational tables for vehicles, fuel prices, and conversion costs
 - Joined all tables into a single analysis-ready view using SQL
3. Metric Calculations
 - Fuel cost per kilometer for PMS and CNG
 - Monthly fuel spending based on 1,000 km
 - Monthly savings from switching to CNG
 - Payback period (months) for conversion cost recovery
4. Data Export
 - Exported the final joined dataset as CSV for visualization
5. Visualization
 - Built an interactive Tableau dashboard to compare costs, savings, and payback across vehicle attributes

## Data Analysis




## Tools Used
1. Excel – Initial data creation and validation
2. MySQL – Data modeling, joins, and calculations
3. Tableau – Interactive dashboard and visualization
