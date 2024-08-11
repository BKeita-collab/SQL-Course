-------------------------------------
-----------PROJET 3------------------
-------------------------------------

----
ALTER TABLE projet.restaurants 
ADD COLUMN geom geometry('POINT', 2163); 

UPDATE projet.restaurants
SET geom = ST_Transform(ST_SetSRID(ST_Point(longitude,latitude),4326),2163)

-- Nous allons utiliser le terminal pour intégrer les données dans la table route
-- shp2pgsql "SQL-Course/data/Module 3/roadtrl020.shp" projet.route | psql -U postgres -d brahimakeita
DROP TABLE IF EXISTS projet.route; 
CREATE TABLE projet.route (
	gid integer NOT NULL,
	feature character varying(80),
	name character varying(120),
	state character varying(2),
	geom geometry(multilinestring,2163),
	CONSTRAINT pk_route PRIMARY KEY (gid)
	);



--- 
SELECT resto."Id_Restaurant", route.gid, route.name, route.state, resto.geom <-> route.geom AS dist
	FROM projet.restaurants AS resto, projet.route AS route
	WHERE ST_DWithin(resto.geom, route.geom, 1.6*10)
	AND route.feature LIKE 'Principal Highway%';




select st_crs(resto.geom)
FROM projet.restaurants AS resto


SHOW SERVER_VERSION;

SELECT short_name, long_name
FROM ST_GdalDrivers()
ORDER BY short_name;