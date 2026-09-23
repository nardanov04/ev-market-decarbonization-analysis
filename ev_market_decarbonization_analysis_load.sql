/*
=================================================
EV Market Decarbonization Analysis: Load & SQL Analysis

Author: Narda Parama Agung Noviantoro

This script handles the Load stage of the pipeline, creating a 
PostgreSQL database and table, then loading the cleaned dataset 
(clean_data_EV_Sustainability.csv) into it.

See the notebook and README for the full Extract, Transform, and 
analysis steps.
=================================================
*/

-- Creates the database for this project.
CREATE DATABASE ev_market_analysis;

-- Creates the ev_dataset table, with column names and types matching clean_data_EV_Sustainability.csv
CREATE TABLE ev_dataset(
	id SERIAL PRIMARY KEY,
	car_model VARCHAR(300),
	efficiency_wh_km FLOAT,
	range_km FLOAT,
	battery_kwh FLOAT,
	price_gbp FLOAT,
	availability VARCHAR(50)
);

-- Loads the cleaned CSV data into the ev_dataset table.
COPY ev_dataset(car_model, efficiency_wh_km, range_km, battery_kwh, price_gbp, availability)
FROM '/tmp/ev_data.csv'
DELIMITER ','
CSV HEADER; 
-- No further normalization was needed for this table as it already satisfies 3NF as a single table: 
-- Each row represents one car_model
-- Each column holds a single atomic value
-- There are no multi-valued or repeating fields that would require splitting into separate tables.

-- Confirms the data loaded correctly.
SELECT * FROM ev_dataset;


/*
=================================================
Exploratory Queries

These queries deliberately mirror the three analyses already done in 
the notebook using Pandas, not as redundant work, but to demonstrate 
that the same analytical questions can be answered directly at the 
database layer using SQL. 

This reflects a common real-world pattern: 
Not every stakeholder or tool has access to a Python environment, so 
being able to reproduce key findings in pure SQL is a practical, 
transferable skill.
=================================================
*/

-- Confirms the row count loaded correctly.
SELECT COUNT(*) FROM ev_dataset;

-- Is there a price penalty for efficiency?
-- Buckets vehicles into price tiers and compares average efficiency across them.
SELECT
    CASE
        WHEN price_gbp < 30000 THEN 'Budget'
        WHEN price_gbp < 50000 THEN 'Mid-range'
        WHEN price_gbp < 100000 THEN 'Premium'
        ELSE 'Luxury'
    END AS price_category,
    ROUND(AVG(efficiency_wh_km)::numeric, 1) AS avg_efficiency_wh_km
FROM ev_dataset
WHERE price_gbp IS NOT NULL
GROUP BY price_category
ORDER BY avg_efficiency_wh_km;

-- Which brands lead on efficiency?
-- Extracts the brand as the first word of car_model, then ranks by average efficiency.
SELECT
    SPLIT_PART(car_model, ' ', 1) AS brand,
    ROUND(AVG(efficiency_wh_km)::numeric, 1) AS avg_efficiency_wh_km
FROM ev_dataset
GROUP BY brand
ORDER BY avg_efficiency_wh_km ASC
LIMIT 10;

-- Which models deliver the most range per kWh of battery?
SELECT
    car_model,
    ROUND((range_km / battery_kwh)::numeric, 2) AS range_per_kwh
FROM ev_dataset
ORDER BY range_per_kwh DESC
LIMIT 10;

-- See the notebook and README for the full interpretation of these results.