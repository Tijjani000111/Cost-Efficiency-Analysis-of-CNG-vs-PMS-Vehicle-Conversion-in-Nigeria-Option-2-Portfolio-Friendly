Select *
from vehicle_profiles;

SHOW TABLE;

USE cng_vs_pms;
SHOW TABLES;

SELECT * FROM `vehicle profiles`;
SELECT * FROM `fuel price`;
SELECT * FROM `conversion`;

RENAME TABLE `vehicle profiles` TO vehicle_profiles;
RENAME TABLE `fuel price` TO fuel_price;
RENAME TABLE `conversion` TO conversion_costs;

Select *
from vehicle_profiles;

Select *
From fuel_price;

Select * 
from conversion_costs
;

DESCRIBE vehicle_profiles;

ALTER TABLE vehicle_profiles
MODIFY pms_efficiency_km_per_liter DECIMAL(5,2),
MODIFY cng_efficiency_km_per_kg DECIMAL(5,2);


SELECT
    vehicle_category,
    engine_type,
    pms_efficiency_km_per_liter,
    cng_efficiency_km_per_kg
FROM vehicle_profiles;

SELECT
  v.vehicle_category,
  v.engine_type,
  f_pms.price_per_unit AS pms_price,
  v.pms_efficiency_km_per_liter,
  ROUND(f_pms.price_per_unit / v.pms_efficiency_km_per_liter, 2) AS pms_cost_per_km,
  f_cng.price_per_unit AS cng_price,
  v.cng_efficiency_km_per_kg,
  ROUND(f_cng.price_per_unit / v.cng_efficiency_km_per_kg, 2) AS cng_cost_per_km
FROM vehicle_profiles v
JOIN fuel_price f_pms ON f_pms.fuel_type = 'PMS'
JOIN fuel_price f_cng ON f_cng.fuel_type = 'CNG';

DESCRIBE fuel_price;

SELECT
  v.vehicle_category,
  v.engine_type,
  CAST(f_pms.price_per_unit_naira AS DECIMAL(10,2)) AS pms_price,
  v.pms_efficiency_km_per_liter,
  ROUND(CAST(f_pms.price_per_unit_naira AS DECIMAL(10,2)) / v.pms_efficiency_km_per_liter, 2) AS pms_cost_per_km,
  CAST(f_cng.price_per_unit_naira AS DECIMAL(10,2)) AS cng_price,
  v.cng_efficiency_km_per_kg,
  ROUND(CAST(f_cng.price_per_unit_naira AS DECIMAL(10,2)) / v.cng_efficiency_km_per_kg, 2) AS cng_cost_per_km
FROM vehicle_profiles v
JOIN fuel_price f_pms ON f_pms.fuel_type = 'PMS'
JOIN fuel_price f_cng ON f_cng.fuel_type = 'CNG';

SELECT fuel_type, price_per_unit_naira FROM fuel_price;

SELECT
  v.vehicle_category,
  v.engine_type,
  CAST(REPLACE(f_pms.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) AS pms_price,
  v.pms_efficiency_km_per_liter,
  ROUND(CAST(REPLACE(f_pms.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) / v.pms_efficiency_km_per_liter, 2) AS pms_cost_per_km,
  CAST(REPLACE(f_cng.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) AS cng_price,
  v.cng_efficiency_km_per_kg,
  ROUND(CAST(REPLACE(f_cng.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) / v.cng_efficiency_km_per_kg, 2) AS cng_cost_per_km
FROM vehicle_profiles v
JOIN fuel_price f_pms ON f_pms.fuel_type = 'PMS'
JOIN fuel_price f_cng ON f_cng.fuel_type = 'CNG';

SELECT
  v.vehicle_category,
  v.engine_type,
  ROUND(floor_pms / v.pms_efficiency_km_per_liter, 2) AS pms_cost_per_km,
  ROUND(floor_cng / v.cng_efficiency_km_per_kg, 2) AS cng_cost_per_km,
  ((ROUND(floor_pms / v.pms_efficiency_km_per_liter, 2) - ROUND(floor_cng / v.cng_efficiency_km_per_kg, 2)) * 1000) AS monthly_savings
FROM vehicle_profiles v
JOIN
  (SELECT fuel_type, CAST(REPLACE(price_per_unit_naira, 'NGN ', '') AS DECIMAL(10, 2)) AS floor_pms FROM fuel_price WHERE fuel_type = 'PMS') pms ON 1=1
JOIN
  (SELECT fuel_type, CAST(REPLACE(price_per_unit_naira, 'NGN ', '') AS DECIMAL(10, 2)) AS floor_cng FROM fuel_price WHERE fuel_type = 'CNG') cng ON 1=1;


SELECT
  v.vehicle_category,
  v.engine_type,
  ROUND(floor_pms / v.pms_efficiency_km_per_liter, 2) AS pms_cost_per_km,
  ROUND(floor_cng / v.cng_efficiency_km_per_kg, 2) AS cng_cost_per_km,
  ((ROUND(floor_pms / v.pms_efficiency_km_per_liter, 2) - ROUND(floor_cng / v.cng_efficiency_km_per_kg, 2)) * 1000) AS monthly_savings,
  v.conversion_cost_naira,
  ROUND(v.conversion_cost_naira / ((ROUND(floor_pms / v.pms_efficiency_km_per_liter, 2) - ROUND(floor_cng / v.cng_efficiency_km_per_kg, 2)) * 1000), 2) AS payback_period_months
FROM vehicle_profiles v
JOIN
  (SELECT fuel_type, CAST(REPLACE(price_per_unit_naira, 'NGN ', '') AS DECIMAL(10, 2)) AS floor_pms FROM fuel_price WHERE fuel_type = 'PMS') pms ON 1=1
JOIN
  (SELECT fuel_type, CAST(REPLACE(price_per_unit_naira, 'NGN ', '') AS DECIMAL(10, 2)) AS floor_cng FROM fuel_price WHERE fuel_type = 'CNG') cng ON 1=1;

SHOW TABLES;

DESCRIBE conversion_costs;

SELECT
  v.vehicle_category,
  v.engine_type,
  ROUND(floor_pms / v.pms_efficiency_km_per_liter, 2) AS pms_cost_per_km,
  ROUND(floor_cng / v.cng_efficiency_km_per_kg, 2) AS cng_cost_per_km,
  ((ROUND(floor_pms / v.pms_efficiency_km_per_liter, 2) - ROUND(floor_cng / v.cng_efficiency_km_per_kg, 2)) * 1000) AS monthly_savings,
  c.conversion_cost_naira,
  ROUND(c.conversion_cost_naira / ((ROUND(floor_pms / v.pms_efficiency_km_per_liter, 2) - ROUND(floor_cng / v.cng_efficiency_km_per_kg, 2)) * 1000), 2) AS payback_period_months
FROM vehicle_profiles v
JOIN conversion_costs c ON v.vehicle_category = c.vehicle_category AND v.engine_type = c.engine_type
JOIN
  (SELECT fuel_type, CAST(REPLACE(price_per_unit_naira, 'NGN ', '') AS DECIMAL(10, 2)) AS floor_pms FROM fuel_price WHERE fuel_type = 'PMS') pms ON 1=1
JOIN
  (SELECT fuel_type, CAST(REPLACE(price_per_unit_naira, 'NGN ', '') AS DECIMAL(10, 2)) AS floor_cng FROM fuel_price WHERE fuel_type = 'CNG') cng ON 1=1;

SELECT
  v.vehicle_category,
  v.engine_type,
  ROUND(floor_pms / v.pms_efficiency_km_per_liter, 2) AS pms_cost_per_km,
  ROUND(floor_cng / v.cng_efficiency_km_per_kg, 2) AS cng_cost_per_km,
  ((ROUND(floor_pms / v.pms_efficiency_km_per_liter, 2) - ROUND(floor_cng / v.cng_efficiency_km_per_kg, 2)) * 1000) AS monthly_savings,
  c.conversion_cost_naira,
  ROUND(
    CAST(
      REPLACE(
        REPLACE(c.conversion_cost_naira, 'NGN ', ''), ',', ''
      ) AS DECIMAL(15, 2)
    ) / ((ROUND(floor_pms / v.pms_efficiency_km_per_liter, 2) - ROUND(floor_cng / v.cng_efficiency_km_per_kg, 2)) * 1000), 2
  ) AS payback_period_months
FROM vehicle_profiles v
JOIN conversion_costs c ON v.vehicle_category = c.vehicle_category AND v.engine_type = c.engine_type
JOIN
  (SELECT fuel_type, CAST(REPLACE(price_per_unit_naira, 'NGN ', '') AS DECIMAL(10, 2)) AS floor_pms FROM fuel_price WHERE fuel_type = 'PMS') pms ON 1=1
JOIN
  (SELECT fuel_type, CAST(REPLACE(price_per_unit_naira, 'NGN ', '') AS DECIMAL(10, 2)) AS floor_cng FROM fuel_price WHERE fuel_type = 'CNG') cng ON 1=1;


CREATE OR REPLACE VIEW vehicle_cost_analysis AS
SELECT
  v.vehicle_category,
  v.engine_type,
  
  -- Cost per km
  ROUND(CAST(REPLACE(f_pms.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) / v.pms_efficiency_km_per_liter, 2) AS pms_cost_per_km,
  ROUND(CAST(REPLACE(f_cng.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) / v.cng_efficiency_km_per_kg, 2) AS cng_cost_per_km,
  
  -- Monthly spending (assuming 1000 km/month)
  ROUND(ROUND(CAST(REPLACE(f_pms.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) / v.pms_efficiency_km_per_liter, 2) * 1000, 2) AS pms_monthly_spending,
  ROUND(ROUND(CAST(REPLACE(f_cng.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) / v.cng_efficiency_km_per_kg, 2) * 1000, 2) AS cng_monthly_spending,
  
  -- Monthly savings
  ((ROUND(CAST(REPLACE(f_pms.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) / v.pms_efficiency_km_per_liter, 2) -
    ROUND(CAST(REPLACE(f_cng.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) / v.cng_efficiency_km_per_kg, 2)) * 1000) AS monthly_savings,
  
  -- Conversion cost (text, but included for reference)
  c.conversion_cost_naira,
  
  -- Payback period in months
  ROUND(
    CAST(REPLACE(REPLACE(c.conversion_cost_naira, 'NGN ', ''), ',', '') AS DECIMAL(15, 2)) /
    ((ROUND(CAST(REPLACE(f_pms.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) / v.pms_efficiency_km_per_liter, 2) -
      ROUND(CAST(REPLACE(f_cng.price_per_unit_naira, 'NGN ', '') AS DECIMAL(10,2)) / v.cng_efficiency_km_per_kg, 2)) * 1000), 2
  ) AS payback_period_months

FROM vehicle_profiles v
JOIN conversion_costs c ON v.vehicle_category = c.vehicle_category AND v.engine_type = c.engine_type
JOIN fuel_price f_pms ON f_pms.fuel_type = 'PMS'
JOIN fuel_price f_cng ON f_cng.fuel_type = 'CNG';

SELECT * FROM vehicle_cost_analysis;


