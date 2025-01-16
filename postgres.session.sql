CREATE TABLE taxi_zone_lookup (
    location_id INT PRIMARY KEY,
    borough VARCHAR(255),
    zone VARCHAR(255),
    service_zone VARCHAR(255)
);

CREATE TABLE green_tripdata (
    VendorID INT,
    lpep_pickup_datetime TIMESTAMP,
    lpep_dropoff_datetime TIMESTAMP,
    store_and_fwd_flag CHAR(1),
    RatecodeID INT,
    PULocationID INT,
    DOLocationID INT,
    passenger_count INT,
    trip_distance NUMERIC,
    fare_amount NUMERIC,
    extra NUMERIC,
    mta_tax NUMERIC,
    tip_amount NUMERIC,
    tolls_amount NUMERIC,
    ehail_fee NUMERIC,
    improvement_surcharge NUMERIC,
    total_amount NUMERIC,
    payment_type INT,
    trip_type INT,
    congestion_surcharge NUMERIC
);

-- 1


-- 2
October 1st 2019 (inclusive) and November 1st 2019 (exclusive)

--3
SELECT COUNT(*) 
FROM green_tripdata 
WHERE lpep_pickup_datetime >= '2019-10-01 00:00:00' 
AND lpep_pickup_datetime < '2019-11-01 00:00:00'
AND trip_distance <= 1;

SELECT COUNT(*) 
FROM green_tripdata 
WHERE lpep_pickup_datetime >= '2019-10-01 00:00:00' 
AND lpep_pickup_datetime < '2019-11-01 00:00:00'
AND trip_distance >10;

-- 4
SELECT * FROM green_tripdata ORDER BY trip_distance DESC limit 10;

SELECT * FROM green_tripdata LIMIT 2;
select * FROM taxi_zone_lookup LIMIT 2

SELECT 
   
    green_tripdata.trip_distance,
    green_tripdata.fare_amount
    -- taxi_zone_lookup.Zone AS pickup_zone,
    -- taxi_zone_lookup.Borough AS pickup_borough
FROM 
    green_tripdata

JOIN 
    taxi_zone_lookup 
ON 
    taxi_zone_lookup.location_id = green_tripdata.PULocationID
--5
SELECT COUNT(*),"Zone"
FROM

 (
SELECT 
    green_tripdata.*,
    taxi_zone_lookup.*
FROM 
    taxi_zone_lookup
JOIN 
    green_tripdata 
ON 
    taxi_zone_lookup."LocationID" = green_tripdata."PULocationID"
)
WHERE
lpep_pickup_datetime >= '2019-10-18 00:00:00' 
AND
lpep_pickup_datetime < '2019-10-19 00:00:00' 

GROUP BY "Zone" ORDER BY count DESC;

--6
SELECT 
    COUNT(*) AS trip_count,
    "Zone",
    "tip_amount"
FROM
    (

        SELECT 
            green_tripdata."tip_amount",
            taxi_zone_lookup."Zone"
        FROM 
            taxi_zone_lookup
        JOIN 
            green_tripdata 
        ON 
            taxi_zone_lookup."LocationID" = green_tripdata."PULocationID"
        WHERE
            taxi_zone_lookup."Zone" = 'East Harlem North'
            AND lpep_pickup_datetime >= '2019-10-01 00:00:00'
            AND lpep_pickup_datetime < '2019-11-01 00:00:00'

        UNION ALL

        
        SELECT 
            green_tripdata."tip_amount",
            taxi_zone_lookup."Zone"
        FROM 
            taxi_zone_lookup
        JOIN 
            green_tripdata 
        ON 
            taxi_zone_lookup."LocationID" = green_tripdata."DOLocationID"
    ) AS combined_data
GROUP BY 
    "Zone", 
    "tip_amount"
ORDER BY 
    "tip_amount" DESC;

