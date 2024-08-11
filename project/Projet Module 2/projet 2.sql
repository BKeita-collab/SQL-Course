-- Creation des tables
BEGIN;


ALTER TABLE IF EXISTS ch01.restaurants DROP CONSTRAINT IF EXISTS "id franchise";

ALTER TABLE IF EXISTS ch01."Client" DROP CONSTRAINT IF EXISTS id_restaurant;



DROP TABLE IF EXISTS ch01.restaurants;

CREATE TABLE IF NOT EXISTS ch01.restaurants
(
    "Id_Restaurant" character varying NOT NULL,
    ""Nom"m"_restaurant" character varying NOT NULL,
    id_franchise character varying NOT NULL,
    geometry geometry,
    CONSTRAINT "cle primaire" PRIMARY KEY ("Id_Restaurant")
);

DROP TABLE IF EXISTS ch01.route;

CREATE TABLE IF NOT EXISTS ch01.route
(
    id_route integer NOT NULL,
    type character varying NOT NULL,
    "Nom"m"_route character varying NOT NULL,
    etat character varying NOT NULL,
    geometry geometry NOT NULL,
    PRIMARY KEY (id_route)
);

DROP TABLE IF EXISTS ch01.franchise;

CREATE TABLE IF NOT EXISTS ch01.franchise
(
    id_franchise character varying NOT NULL,
    "Nom"m" character varying NOT NULL,
    CONSTRAINT cle_primaire PRIMARY KEY (id_franchise)
);

DROP TABLE IF EXISTS ch01."Client";

CREATE TABLE IF NOT EXISTS ch01."Client"
(
    id_client character varying NOT NULL,
    "id_Restaurant" character varying NOT NULL,
    "Nom"m" "char" NOT NULL,
    date date NOT NULL,
    CONSTRAINT cle_primaire PRIMARY KEY (id_client)
);

ALTER TABLE IF EXISTS ch01.restaurants
    ADD CONSTRAINT "id franchise" FOREIGN KEY (id_franchise)
    REFERENCES ch01.franchise (id_franchise) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS ch01."Client"
    ADD CONSTRAINT id_restaurant FOREIGN KEY ("id_Restaurant")
    REFERENCES ch01.restaurants ("Id_Restaurant") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;

-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://github.com/pgadmin-org/pgadmin4/issues/new/choose if you find any bugs, including reproduction steps.


-------------------------------------
-----------PROJET 2------------------
-------------------------------------


--- Partie 1


BEGIN;

ALTER TABLE IF EXISTS projet.restaurants DROP CONSTRAINT IF EXISTS fkey1_restaurants;

ALTER TABLE IF EXISTS projet."Client" DROP CONSTRAINT IF EXISTS fkey1_client;



DROP TABLE IF EXISTS projet.restaurants;

CREATE TABLE IF NOT EXISTS projet.restaurants
(
    "Id_Restaurant" serial NOT NULL,
    id_franchise character varying NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    "Score" double precision NOT NULL,
    CONSTRAINT pkey_restaurants PRIMARY KEY ("Id_Restaurant")
);

DROP TABLE IF EXISTS projet.route;

CREATE TABLE IF NOT EXISTS projet.route
(
    id_route integer NOT NULL,
    type character varying NOT NULL,
    "Nom"m"_route character varying NOT NULL,
    etat character varying NOT NULL,
    geometry geometry NOT NULL,
    CONSTRAINT pkey_route PRIMARY KEY (id_route)
);

DROP TABLE IF EXISTS projet.franchise;

CREATE TABLE IF NOT EXISTS projet.franchise
(
    id_franchise character varying NOT NULL,
    "Nom"m" character varying NOT NULL,
    CONSTRAINT pkey_franchise PRIMARY KEY (id_franchise)
);

DROP TABLE IF EXISTS projet."Client";

CREATE TABLE IF NOT EXISTS projet."Client"
(
    id_client integer NOT NULL,
    "id_Restaurant" integer NOT NULL,
    date date NOT NULL,
    CONSTRAINT pkey_client PRIMARY KEY (id_client)
);

DROP TABLE IF EXISTS projet.staging_client;

CREATE TABLE IF NOT EXISTS projet.staging_client
(
    id_client integer NOT NULL,
    "id_Restaurant" integer NOT NULL,
    date date NOT NULL,
    CONSTRAINT pkey_sclient PRIMARY KEY (id_client)
);

DROP TABLE IF EXISTS projet.staging_franchise;

CREATE TABLE IF NOT EXISTS projet.staging_franchise
(
    id_franchise character varying NOT NULL,
    "Nom"m" character varying NOT NULL,
    CONSTRAINT pkey_sfranchise PRIMARY KEY (id_franchise)
);

DROP TABLE IF EXISTS projet.staging_restaurants;

CREATE TABLE IF NOT EXISTS projet.staging_restaurants
(
    id_franchise character varying NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    "Score" double precision NOT NULL
);

ALTER TABLE IF EXISTS projet.restaurants
    ADD CONSTRAINT fkey1_restaurants FOREIGN KEY (id_franchise)
    REFERENCES projet.franchise (id_franchise) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS projet."Client"
    ADD CONSTRAINT fkey1_client FOREIGN KEY ("id_Restaurant")
    REFERENCES projet.restaurants ("Id_Restaurant") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;

---- Partie 2----------

/*
--------------------------------------------------
-- CREATION OF THE SCORE TO STAGGING 

ALTER TABLE projet.staging_restaurants 
ADD COLUMN Score FLOAT; 

UPDATE projet.staging_restaurants
SET Score = RANDOM()*3+2; 

copy projet.staging_restaurants
         TO '/Users/brahimakeita/Documents/GitHub/SQL-Course/project/Projet Module 2/stagging_restaurant.csv' DELIMITER as ',';
--------------------------------------------------
*/


copy projet.staging_restaurants
	FROM '/Users/brahimakeita/Documents/GitHub/SQL-Course/project/Projet Module 2/stagging_restaurant.csv' DELIMITER as ',';

	
copy projet.staging_franchise
         FROM '/Users/brahimakeita/Documents/GitHub/SQL-Course/project/Projet Module 2/franchises.csv' DELIMITER as ',';

SELECT TO_CHAR(date, 'dd-mm-yyyy hh:mm:ss')
	from projet.staging_client; 

SET datestyle = 'ISO, DMY';
copy projet.staging_client
         FROM '/Users/brahimakeita/Documents/GitHub/SQL-Course/project/Projet Module 2/client_restaurant_data.csv' DELIMITER as ',';





---- Partie 3----------

INSERT INTO projet.franchise
	SELECT * 
	FROM projet.staging_franchise; 

INSERT INTO projet.restaurants(id_franchise, latitude,longitude, "Score" )
	SELECT id_franchise,latitude,longitude, "Score"
	FROM projet.staging_restaurants;

INSERT INTO projet."Client"
	SELECT * 
	FROM projet.staging_client; 
---- Partie 4----------

--
SELECT COUNT(*) AS "Nom"m"bre_franchise
	FROM projet.franchise;  

SELECT "Nom"m"
	FROM projet.staging_franchise;  

--
WITH max_score AS (
	SELECT MAX("Score") AS score_max
	FROM projet.restaurants
)
SELECT "Id_Restaurant", "Score"
	FROM projet.restaurants,max_score 
	WHERE "Score" = score_max;

--

SELECT frc.id_franchise, frc."Nom"m", AVG(resto."Score") AS score_moyen
	FROM 
	projet.franchise AS frc INNER JOIN projet.restaurants AS resto
	ON frc.id_franchise = resto.id_franchise
	GROUP BY (frc.id_franchise) 
	ORDER BY score_moyen ASC; 


EXPLAIN ANALYZE
QUERY PLAN 
SELECT resto."Id_Restaurant", COUNT(cl.id_client) AS count_client
	FROM projet."Client" AS cl INNER JOIN projet.restaurants AS resto
	ON  cl."id_Restaurant" = resto."Id_Restaurant"
	GROUP BY (resto."Id_Restaurant")
	HAVING COUNT(cl.id_client) > 3; 

VACUUM VERBOSE ANALYZE projet.restaurants; 

---- BONUS 
ALTER TABLE projet.restaurants
DROP COLUMN appreciation; 

ALTER TABLE projet.restaurants
ADD COLUMN appreciation character varying; 

CREATE INDEX fki_restaurants ON projet.restaurants ("Id_Restaurant", id_franchise, "Score", appreciation );
CREATE INDEX fki_client ON projet."Client" (id_client, date );

EXPLAIN ANALYZE
WITH count_client AS(
	SELECT COUNT(cl.id_client) AS count_client
	FROM projet."Client" AS cl INNER JOIN projet.restaurants AS resto
	ON  cl."id_Restaurant" = resto."Id_Restaurant"
	GROUP BY (resto."Id_Restaurant")
	ORDER BY count_client
), 
	appreciation_restaurants AS(
	SELECT 
	CASE 
		WHEN count_client.count_client > 5 THEN 'préférence elévée'
		WHEN count_client.count_client < 3 THEN 'préférence elévée'
		ELSE 'préférence moyenne'
	END AS appreciation_resto
	FROM count_client)

	UPDATE projet.restaurants
	SET appreciation = appreciation_restaurants.appreciation_resto
	
	FROM projet.restaurants AS resto, appreciation_restaurants
/*
	temp_resto AS (
	SELECT resto."Id_Restaurant", resto.id_franchise, resto.latitude, resto.longitude, resto."Score", 
		count_client.count_client 
	FROM projet.restaurants AS resto, count_client)

UPDATE projet.restaurants
SET appreciation = 
	CASE 
		WHEN count_client.count_client > 5 THEN 'préférence elévée'
		WHEN count_client.count_client < 3 THEN 'préférence elévée'
		ELSE 'préférence moyenne'
	END
FROM projet.restaurants AS resto, count_client

*/