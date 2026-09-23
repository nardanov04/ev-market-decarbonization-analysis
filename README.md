# ETL Pipeline: EV Market Decarbonization Analysis

ETL pipeline analyzing EV efficiency, range, and price data to explore decarbonization trends in the electric vehicle market.

**Author:** Narda Parama Agung Noviantoro

## Overview
This project builds an end-to-end ETL (Extract, Transform, Load) pipeline analyzing electric vehicle specifications to explore how efficiency and affordability are evolving in the EV market, two key indicators of how accessible clean transport is becoming.

Data is scraped from [ev-database.org](https://ev-database.org), covering 200 EV models across efficiency (Wh/km), range, battery capacity, price, and availability.

## Why This Matters
As a sustainability-focused analyst, I wanted to move beyond spec-sheet comparisons and ask real market questions:
- Is EV efficiency actually improving, or is the industry just building bigger batteries to fake better range?
- Is there a price penalty for efficiency, meaning is decarbonized transport becoming affordable, or still a luxury feature?
- Which brands are leading (or lagging) on efficiency?

## Tech Stack
- **Extraction:** Selenium (browser automation), BeautifulSoup (HTML parsing)
- **Transformation:** Pandas
- **Visualization:** Matplotlib
- **Storage:** PostgreSQL
- **Language:** Python, SQL

## Pipeline Overview
1. **Extract:** Selenium automates a Chrome browser to load ev-database.org, BeautifulSoup parses the rendered HTML to pull structured data across 200 vehicle listings
2. **Transform:** Cleans unit-embedded text (e.g. `"133 Wh/km"` becomes `133.0`), converts columns to proper numeric types, documents missing-value handling decisions
3. **Load:** Loads the cleaned dataset into a PostgreSQL database, with reasoning documented for why normalization wasn't required for this schema

## Key Findings

Note: lower Wh/km indicates higher efficiency, meaning the vehicle uses less energy per kilometer traveled. All findings below are based on 200 EV models.

### No Price Penalty for Efficiency, If Anything, the Opposite

![Average efficiency by price tier](images/price_tier_efficiency.png)

Average efficiency gets *worse* as price increases, from 163 Wh/km in the Budget tier up to 211 Wh/km in Luxury. Budget EVs are the most efficient segment, not the least.

### Tesla Leads on Efficiency Without Being a Budget Brand

![Top 10 most efficient brands](images/brand_efficiency.png)

Tesla ranks 4th out of all brands on average efficiency (156 Wh/km), ahead of most competitors despite not being a budget manufacturer. Luxury-oriented brands are absent from the top 10 entirely.

### Battery Size Alone Doesn't Predict Range

![Top 10 models by range per kWh](images/range_per_kwh.png)

Across the dataset, a bigger battery doesn't reliably translate to more range per kWh, several models with smaller batteries achieve a better ratio than larger-battery competitors. Tesla Model 3 variants take 7 of the top 10 spots on this measure, indicating engineering efficiency rather than simply installing a bigger battery.

This challenges a common assumption that premium innovation trickles down to make clean transport more accessible over time. Instead, the data suggests genuine decarbonization progress is currently led by manufacturers designing for efficiency from the ground up, often in accessible segments, rather than by luxury models setting the pace. For a market still working toward making clean transport genuinely accessible, the more useful question may not be "how do we make efficient EVs cheaper," but "why aren't more manufacturers building as efficiently as the segment leaders already are."

All three findings are demonstrated twice in this project: once in Pandas (notebook, with the charts above) and once in pure SQL (`ev_market_decarbonization_analysis_load.sql`), to show the same analytical questions can be answered at either the application layer or the database layer.

## Repository Structure
- `ev_market_decarbonization_analysis_extract_transform.ipynb`: Extract, Transform, and Key Findings (Pandas)
- `ev_market_decarbonization_analysis_load.sql`: Load and Exploratory Queries (SQL)
- `raw_data_EV_Sustainability.csv`: Scraped, unprocessed data
- `clean_data_EV_Sustainability.csv`: Cleaned, analysis-ready data
- `images/`: Chart images referenced in this README
- `README.md`

## How to Run
1. Install dependencies: `pip install pandas selenium beautifulsoup4 matplotlib`
2. Run the notebook cells in order to scrape, clean, and visualize the data
3. Copy the cleaned CSV to a location PostgreSQL can read (e.g. `/tmp/`), matching the path used in the `COPY` statement
4. Set up a PostgreSQL database and run `ev_market_decarbonization_analysis_load.sql` to load the cleaned data and run the exploratory queries
