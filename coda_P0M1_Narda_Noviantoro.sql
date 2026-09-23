/*
=================================================
Milestone 1

Nama  : Narda Parama Agung Noviantoro
Batch : CODA-RMT-023

Program ini dibuat untuk melakukan proses Load dari ETL pipeline untuk file clean_data_EV_Sustainability.csv.
=================================================
*/

-- Query dibawah digunakan untuk membuat database dalam pgadmin.
CREATE DATABASE hacktiv8_milestone;

-- Query dibawah digunakan untuk membuat table ev_dataset sesuai dengan struktur file clean_data_EV_Sustainability.csv.
CREATE TABLE ev_dataset(
	id SERIAL PRIMARY KEY,
	car_model VARCHAR(300),
	efficiency_wh_km FLOAT,
	range_km FLOAT,
	battery_kwh FLOAT,
	price_gbp FLOAT,
	availability VARCHAR(50)
);

-- Query dibawah digunakan untuk copy file clean_data_EV_Sustainability.csv dan memasuki nya ke dalam table ev_dataset.
COPY ev_dataset(car_model, efficiency_wh_km, range_km, battery_kwh, price_gbp, availability)
FROM '/tmp/ev_data.csv'
DELIMITER ','
CSV HEADER; 
-- Table ev_dataset tidak perlu normalisasi lebih lanjut dikarenakan sudah memenuhi bentuk normal (3NF) dalam satu table.
-- Dimana setiap baris merepresentasikan satu car_model, dan setiap kolom menyimpan satu value per baris (atomic single valued).
-- Juga tidak ada kolom yang memiliki nilai multi-value/repeating, sehingga tidak ada kolom yang perlu dipisah ke table lain.

-- Query dibawah digunakan untuk menampilkan table ev_dataset, dimana file clean_data_EV_Sustainability.csv sudah di copy ke dalam.
SELECT * FROM ev_dataset;