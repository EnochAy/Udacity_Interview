---Health Analytics Case Study (Quiz: Query Debugging)
-- 1. How many unique users exist in the logs dataset?
SELECT
  COUNT(DISTINCT id)
FROM health.user_logs;

-- for questions 2-8 we created a temporary table

DROP TABLE IF EXISTS user_measure_count;

CREATE TEMP TABLE user_measure_count AS

SELECT

    id,

    COUNT(*) AS measure_count,

    COUNT(DISTINCT measure) as unique_measures

  FROM health.user_logs

  GROUP BY 1; 

-- 2. How many total measurements do we have per user on average?

SELECT

  ROUND(AVG(measure_count)) AS average_value

FROM user_measure_count;


-- 3. What about the median number of measurements per user?
SELECT

  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY measure_count) AS median_value

FROM user_measure_count;


-- 4. How many users have 3 or more measurements?

SELECT

  COUNT(*)

FROM user_measure_count

WHERE measure_count >= 3;

-- 5. How many users have 1,000 or more measurements?

SELECT

  COUNT(*)

FROM user_measure_count

WHERE measure_count >= 1000;


-- 6. Have only logged blood glucose measurements?

SELECT

  COUNT(DISTINCT id)

FROM health.user_logs

WHERE measure = 'blood_glucose';

-- 7. Have at least 2 types of measurements?

SELECT

  COUNT(*)

FROM user_measure_count

WHERE unique_measures >= 2;

-- 8. Have all 3 measures - blood glucose, weight and blood pressure?

SELECT

  COUNT(*)

FROM user_measure_count

WHERE unique_measures = 3;


-- 9.  What is the median systolic/diastolic blood pressure values?

SELECT

  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY systolic) AS median_systolic,

  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diastolic) AS median_diastolic

FROM health.user_logs

WHERE measure = 'blood_pressure';


-- Marketing Analytics
SELECT *
FROM dvd_rentals.rental
WHERE customer_id = 130;

--Note that this query shows the film_id = 1 records only!
SELECT *
FROM dvd_rentals.inventory
WHERE film_id = 1;

SELECT *
FROM dvd_rentals.film
--LIMIT 5;

SELECT *
FROM dvd_rentals.film_category
--LIMIT 5;

SELECT *
FROM dvd_rentals.film_actor
WHERE actor_id = 1;

SELECT *
FROM dvd_rentals.actor
--LIMIT 5;



----The ERD used for this tutorial was created using the amazing online tool dbdiagram.io. You can try recreating it by copy pasting the code below. I’ve used exactly this code to create the diagram you’ve seen above. Please feel free to use this as a base to create ERDs of your own for future projects of your own or in the workplace! Note that there is additional information in the code chunk below regarding the indexes which are optional - but often very useful!
Table "rental" {
  "rental_id" integer [not null]
  "rental_date" timestamp [not null]
  "inventory_id" integer [not null]
  "customer_id" smallint [not null]
  "return_date" timestamp
  "staff_id" smallint [not null]
  "last_update" timestamp [not null, default: `now()`]

Indexes {
  inventory_id [type: btree, name: "idx_fk_inventory_id"]
  (rental_date, inventory_id, customer_id) [type: btree, unique, name: "idx_unq_rental_rental_date_inventory_id_customer_id"]
}
}

Table "inventory" {
  "inventory_id" integer [not null, default: `nextval('inventory_inventory_id_seq'::regclass)`]
  "film_id" smallint [not null]
  "store_id" smallint [not null]
  "last_update" timestamp [not null, default: `now()`]

Indexes {
  (store_id, film_id) [type: btree, name: "idx_store_id_film_id"]
}
}


Table "film" {
  "film_id" integer [not null, default: `nextval('film_film_id_seq'::regclass)`]
  "title" "character varying(255)" [not null]
  "description" text
  "release_year" year
  "language_id" smallint [not null]
  "original_language_id" smallint
  "rental_duration" smallint [not null, default: 3]
  "rental_rate" "numeric(4, 2)" [not null, default: 4.99]
  "length" smallint
  "replacement_cost" "numeric(5, 2)" [not null, default: 19.99]
  "rating" "character varying(5)" [default: "G"]
  "last_update" timestamp [not null, default: `now()`]
  "special_features" text
  "fulltext" tsvector [not null]

Indexes {
  fulltext [type: btree, name: "film_fulltext_idx"]
  language_id [type: btree, name: "idx_fk_language_id"]
  original_language_id [type: btree, name: "idx_fk_original_language_id"]
  title [type: btree, name: "idx_title"]
}
}

Table "film_category" {
  "film_id" smallint [not null]
  "category_id" smallint [not null]
  "last_update" timestamp [not null, default: `now()`]
}

Table "category" {
  "category_id" integer [not null, default: `nextval('category_category_id_seq'::regclass)`]
  "name" "character varying(25)" [not null]
  "last_update" timestamp [not null, default: `now()`]
}

Table "film_actor" {
  "actor_id" smallint [not null]
  "film_id" smallint [not null]
  "last_update" timestamp [not null, default: `now()`]

Indexes {
  film_id [type: btree, name: "idx_fk_film_id"]
}
}

Table "actor" {
  "actor_id" integer [not null, default: `nextval('actor_actor_id_seq'::regclass)`]
  "first_name" varchar(45) [not null]
  "last_name" varchar(45) [not null]
  "last_update" timestamp [not null, default: `now()`]

Indexes {
  last_name [type: btree, name: "idx_actor_last_name"]
}
}

-- many to one relationship between rental & inventory
Ref: "rental"."inventory_id" > "inventory"."inventory_id"

-- many to one inventory to film
Ref: "inventory"."film_id" > "film"."film_id"

-- one to one relationship between film_category and film 
Ref: "film_category"."film_id" - "film"."film_id"

-- many to one relationship between film_category and category
Ref: "film_category"."category_id" > "category"."category_id"

-- one to many relationship between film ands film_actor
Ref: "film"."film_id" < "film_actor"."film_id"

-- many to one relationship between film_actor and actor
Ref: "film_actor"."actor_id" > "actor"."actor_id"

-- there is also an additional relationship, however we exclude it to reduce
-- any confusion!

-- many to many relationship between inventory and film_actor
-- however dbdiagram.io only lets you refer to each combination once...
-- so we only show one direction of relationship!
-- Ref: "inventory"."film_id" > "film_actor"."film_id"