# ev-market-decarbonization-analysis
ETL pipeline analyzing EV efficiency, range, and price data to explore decarbonization trends in the electric vehicle market.

# ETL Pipeline: EV Market Decarbonization Analysis

## Overview
This project builds an end-to-end ETL (Extract, Transform, Load) pipeline analyzing electric vehicle specifications to explore how efficiency and affordability are evolving in the EV market — two key indicators of how accessible clean transport is becoming.

Data is scraped from [ev-database.org](https://ev-database.org), covering 200 EV models across efficiency (Wh/km), range, battery capacity, price, and availability status.

## Why This Matters
As a sustainability-focused analyst, I wanted to move beyond spec-sheet comparisons and ask real market questions:
- Is EV efficiency actually improving, or is the industry just building bigger batteries to fake better range?
- Is there a price penalty for efficiency — i.e., is decarbonized transport becoming affordable, or still a luxury feature?
- Which brands are leading (or lagging) on efficiency?

## Tech Stack
- **Extraction:** Selenium (browser automation), BeautifulSoup (HTML parsing)
- **Transformation:** Pandas
- **Storage:** PostgreSQL
- **Language:** Python

## Pipeline Overview
1. **Extract** — Selenium automates a Chrome browser to load ev-database.org, BeautifulSoup parses the rendered HTML to pull structured data across 200 vehicle listings
2. **Transform** — Cleans unit-embedded text (e.g. `"133 Wh/km"` → `133.0`), converts columns to proper numeric types, documents missing-value handling decisions
3. **Load** — Loads the cleaned dataset into a PostgreSQL database, with reasoning documented for why normalization wasn't required for this schema

## Key Findings
*(fill in once you've run the portfolio analysis — see below)*

## Repository Structure
- `coda_P0M1_Narda_Noviantoro.ipynb` — Extract + Transform
- `coda_P0M1_Narda_Noviantoro.sql` — Load (PostgreSQL)
- `raw_data_EV_Sustainability.csv` — Scraped, unprocessed data
- `clean_data_EV_Sustainability.csv` — Cleaned, analysis-ready data

## How to Run
1. Install dependencies: `pip install pandas selenium beautifulsoup4`
2. Run the notebook cells in order to scrape and clean the data
3. Set up a PostgreSQL database and run `coda_P0M1_Narda_Noviantoro.sql` to load the cleaned data
