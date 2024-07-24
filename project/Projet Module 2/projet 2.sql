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

