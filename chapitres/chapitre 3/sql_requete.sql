-- Chapitre 3 et 4 SQl

-- shp2pgsql countries_invalid.shp countries_invalid -s 4326 -I | psql -U postgres -d nomdb

-- Verifier la validité et raison
select gid, name, st_isvalidreason(geom)
from ch03_04.countries_invalid
where not st_isvalid(geom);

-- utiliser une géométrie invalide
-- Union entre Erythrée et Ethiopie
select array_agg(name), st_union(geom)
from ch03_04.countries_invalid
where name in ('Kenya', 'Ethiopia');


-- Réparation de la géométrie
update countries_invalid set geom = st_collectionextract(st_makeValid(geom), 3)
where not st_isvalid(geom);


select gid, name, st_isvalidreason(geom)
from countries_invalid
where not st_isvalid(geom);

-- Union des géométries
select 1 as id, string_agg(name, ', ') as names, st_union(geom) as geom
from countries_invalid
where name in ('Kenya', 'Ethiopia');

select * from countries;

--- Fonction géométrique--------------

--- WKB et WKT

SELECT geom::geometry(LineString,4326) INTO constrained_geoms
FROM (
    VALUES
        (ST_GeomFromText('LINESTRING(-80 28, -90 29)', 4326)),
        (ST_GeomFromText('LINESTRING(10 28, 9 29, 7 30)', 4326 ))
) As x(geom);
--
SELECT ST_GeomFromWKB(
    E'\\001\\001\\000\\000\\000\\321\\256B\\312O
    \\304Q\\300\\347\\030\\220\\275\\336%E@',
    4326
);

-- Avec les géométries 
SELECT ST_Perimeter('POLYGON((
    145.007 13.581,144.765 13.21,
    144.602 13.2,144.589 13.494,
    144.845 13.705,145.007 13.581
))');
-- Ici ST_Perimeter existe pour ST_Geometrie et pour ST_Geography donc 
-- ST_Perimeter ne sait pas ce qu'il faut appliquer 

SELECT ST_Perimeter(ST_GeomFromText('POLYGON((
    145.007 13.581,144.765 13.21,
    144.602 13.2,144.589 13.494,
    144.845 13.705,145.007 13.581
))'));

SELECT (ST_Centroid('LINESTRING(1 2,3 4)'));
-- ST_Centroid existe unniquement pour les ST_geometries donc ça marche 
-- mais il faut avoir l'habitude de preciser ST_GeomFromText, ST_GeogFromText

SELECT ST_Centroid('LINESTRING(1 2, 3 4)'::geometry);



--- Systeme de reference
-- ST_SRID, ST_SetSRID

SELECT ST_SRID(ST_GeomFromText('POLYGON((1 1,2 2,2 0,1 1))',4326));


SELECT
    ST_SRID(geom) As srid,
    ST_SRID(ST_SetSRID(geom,4326)) as srid_new
FROM ( VALUES
        (ST_GeomFromText('POLYGON((70 20,71 21,71 19,70 20))',4269)),
        (ST_Point(1,2))
) As X (geom);


--ST_Transform
SELECT ST_AsText(
    ST_Transform('SRID=4326;LINESTRING(-73 41,-72 42)'::geometry,32618)
);

-- ST_GeometryType
SELECT CASE
	WHEN GeometryType(geom) = 'POLYGON' THEN ST_Area(geom)
	WHEN GeometryType(geom) = 'LINESTRING' THEN ST_Length(geom)
	ELSE NULL
            END As measure
        FROM sometable;

-- ST_X, ST_Y, ST_Z

-- ST_Xmin, ST_Xmax, ST_Ymin, ST_Ymax, ST_Zmin, ST_Zmax, ST_NPoints


-- calcul
SELECT ST_Length(geom) As length_2d, ST_3DLength(geom) As length_3d
        FROM (
            VALUES
                (ST_GeomFromText('LINESTRING(1 2 3,4 5 6)')),
                (ST_GeomFromText('LINESTRING(1 2,4 5)')))
As x(geom);

SELECT ST_Length(
    ST_GeomFromText('LINESTRING(-95.40 29.77,72.82 19.07)')
);

SELECT ST_Length(
    ST_GeogFromText('LINESTRING(-95.40 29.77,72.82 19.07)')
);


SELECT ST_LengthSpheroid(
    ST_GeomFromText('LINESTRING(-95.40 29.77,72.82 19.07)'),
    'SPHEROID["GRS_1980",6378137,298.257222101]'
);














