CREATE TABLE test.nyc_taxi ( VendorID int,
tpep_pickup_datetime timestamp,
tpep_dropoff_datetime timestamp,
passenger_count int,
trip_distance float,
RatecodeID int,
store_and_fwd_flag text,
PULocationID int,
DOLocationID int,
payment_type int,
fare_amount float,
extra float,
mta_tax float,
tip_amount float,
tolls_amount float,
improvement_surcharge float,
total_amount float,
ratio_amaunt_distance float,
trip_category text,
PRIMARY KEY (tpep_pickup_datetime, tpep_dropoff_datetime));

CREATE TABLE test.nyc_taxi_1 (
VendorID int,
tpep_pickup_datetime timestamp,
tpep_dropoff_datetime timestamp,
passenger_count int,
trip_distance float,
RatecodeID int,
store_and_fwd_flag text,
PULocationID int,
DOLocationID int,
PRIMARY KEY (tpep_pickup_datetime, tpep_dropoff_datetime));

copy test.nyc_taxi_1 (VendorID,tpep_pickup_datetime,tpep_dropoff_datetime,passenger_count,trip_distance,RatecodeID,store_and_fwd_flag,PULocationID,DOLocationID) from '/tmp/yellow_tripdata_10000_1.csv' with header=true and delimiter=';' and datetimeformat='%d-%m-%Y %H:%M';


CREATE TABLE test.nyc_taxi_2 (
VendorID int,
tpep_pickup_datetime timestamp,
tpep_dropoff_datetime timestamp,
payment_type int,
fare_amount float,
extra float,
mta_tax float,
tip_amount float,
tolls_amount float,
improvement_surcharge float,
total_amount float,
PRIMARY KEY (tpep_pickup_datetime, tpep_dropoff_datetime));
copy test.nyc_taxi_2 (VendorID,tpep_pickup_datetime,tpep_dropoff_datetime,payment_type,fare_amount,extra,mta_tax,tip_amount,tolls_amount,improvement_surcharge,total_amount) from '/tmp/yellow_tripdata_10000_2.csv' with header=true and delimiter=';' and datetimeformat='%d-%m-%Y %H:%M';

