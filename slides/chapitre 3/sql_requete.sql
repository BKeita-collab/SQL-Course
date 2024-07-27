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

