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
13. [Limitations & Future Improvements](#limitations-and-future-improvements)

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
This phase focused on answering business-driven questions using cleaned and validated data.
``` SQL QUERY USED 
-- Create a consolidated analysis view combining vehicle profiles,
-- fuel prices, and conversion costs

CREATE OR REPLACE VIEW vehicle_cost_analysis AS
SELECT
    v.vehicle_category,
    v.brand,
    v.engine_type,

    -- Fuel efficiency
    v.pms_efficiency_km_per_liter,
    v.cng_efficiency_km_per_kg,

    -- Fuel prices (converted from text to numeric)
    CAST(REPLACE(f_pms.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) AS pms_price_per_liter,
    CAST(REPLACE(f_cng.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) AS cng_price_per_kg,

    -- Cost per kilometer
    ROUND(
        CAST(REPLACE(f_pms.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) 
        / v.pms_efficiency_km_per_liter, 2
    ) AS pms_cost_per_km,

    ROUND(
        CAST(REPLACE(f_cng.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) 
        / v.cng_efficiency_km_per_kg, 2
    ) AS cng_cost_per_km,

    -- Monthly spending (assumed 1,000 km/month)
    ROUND(
        (CAST(REPLACE(f_pms.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) 
        / v.pms_efficiency_km_per_liter) * 1000, 2
    ) AS pms_monthly_spending,

    ROUND(
        (CAST(REPLACE(f_cng.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) 
        / v.cng_efficiency_km_per_kg) * 1000, 2
    ) AS cng_monthly_spending,

    -- Monthly savings
    ROUND(
        (
            (CAST(REPLACE(f_pms.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) 
            / v.pms_efficiency_km_per_liter)
            -
            (CAST(REPLACE(f_cng.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) 
            / v.cng_efficiency_km_per_kg)
        ) * 1000, 2
    ) AS monthly_savings,

    -- Conversion cost
    c.conversion_cost_naira,

    -- Payback period (months)
    ROUND(
        CAST(REPLACE(REPLACE(c.conversion_cost_naira, 'NGN ', ''), ',', '') AS DECIMAL(15,2))
        /
        (
            (
                (CAST(REPLACE(f_pms.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) 
                / v.pms_efficiency_km_per_liter)
                -
                (CAST(REPLACE(f_cng.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) 
                / v.cng_efficiency_km_per_kg)
            ) * 1000
        ), 2
    ) AS payback_period_months

FROM vehicle_profiles v
JOIN conversion_costs c
    ON v.vehicle_category = c.vehicle_category
   AND v.engine_type = c.engine_type
JOIN fuel_price f_pms
    ON f_pms.fuel_type = 'PMS'
JOIN fuel_price f_cng
    ON f_cng.fuel_type = 'CNG';
```

## Tools Used
1. Excel – Initial data creation and validation
2. MySQL – Data modeling, joins, and calculations
3. Tableau – Interactive dashboard and visualization

## Key Metrics Measured
The following KPIs were calculated and visualized:
 - PMS Cost per Kilometer (NGN/km)
 - CNG Cost per Kilometer (NGN/km)
 - PMS Monthly Fuel Spending (NGN)
 - CNG Monthly Fuel Spending (NGN)
 - Monthly Fuel Savings (NGN)
 - Conversion Cost (NGN)
 - Payback Period (Months)

## Dashboard Overview
The final dashboard provides:
 - Side-by-side comparison of PMS vs CNG costs
 - Brand-level and category-level cost visibility
 - Monthly spending breakdowns
 - Payback period visualization for conversion decisions
 - Clear KPIs displayed in NGN for easy interpretation
The dashboard is designed to be understandable by both technical and non-technical audiences.
<img width="1246" height="700" alt="Screenshot 2026-01-20 at 9 36 29 PM" src="https://github.com/user-attachments/assets/3e9a11ed-10bb-4f2b-b420-bc726417916f" />
<img width="1270" height="771" alt="Screenshot 2026-01-20 at 9 36 39 PM" src="https://github.com/user-attachments/assets/a9632c72-4383-49e6-8b64-60ddc43b2dcc" />

## Key Insight and Findings
CNG demonstrates a significantly lower cost per kilometer compared to PMS across all vehicle categories
Monthly fuel spending is substantially reduced after conversion
Despite high upfront conversion costs, payback periods are achievable within a realistic timeframe depending on vehicle type and usage
Fuel efficiency and tank capacity play a major role in overall cost outcomes

## Limitations and Future Improvements
 - Maintenance and servicing costs were not included
 - Fuel price volatility was not modeled
 - Real-world driving behavior may vary from assumptions
 - Future versions could include sensitivity analysis, mileage scenarios, and emissions impact

