------------------------------------------------------------------------------
-------------------------------- PROJET FINAL --------------------------------
------------------------------------------------------------------------------

-------Import -------


COPY projet.publication 
	FROM '/Users/brahimakeita/Library/CloudStorage/OneDrive-Personal/Documents/GitHub/SQL-Course/data/Projet final/publication_table.csv'
	DELIMITER ',' CSV HEADER ; 

COPY projet.prix 
	FROM '/Users/brahimakeita/Library/CloudStorage/OneDrive-Personal/Documents/GitHub/SQL-Course/data/Projet final/price_table.csv'
	DELIMITER ',' CSV HEADER ; 

COPY projet.categorie 
	FROM '/Users/brahimakeita/Library/CloudStorage/OneDrive-Personal/Documents/GitHub/SQL-Course/data/Projet final/announcment_category_table.csv'
	DELIMITER ',' CSV HEADER ; 

COPY projet.source 
	FROM '/Users/brahimakeita/Library/CloudStorage/OneDrive-Personal/Documents/GitHub/SQL-Course/data/Projet final/source_table.csv'
	DELIMITER ',' CSV HEADER ;

COPY projet.vendeur 
	FROM '/Users/brahimakeita/Library/CloudStorage/OneDrive-Personal/Documents/GitHub/SQL-Course/data/Projet final/seller_table.csv'
	DELIMITER ',' CSV HEADER ;

COPY projet.localisation 
	FROM '/Users/brahimakeita/Library/CloudStorage/OneDrive-Personal/Documents/GitHub/SQL-Course/data/Projet final/location_table.csv'
	DELIMITER ',' CSV HEADER ;

COPY projet.maison 
	FROM '/Users/brahimakeita/Library/CloudStorage/OneDrive-Personal/Documents/GitHub/SQL-Course/data/Projet final/house_table.csv'
	DELIMITER ',' CSV HEADER ;

COPY projet.annonce 
	FROM '/Users/brahimakeita/Library/CloudStorage/OneDrive-Personal/Documents/GitHub/SQL-Course/data/Projet final/annonce_table.csv'
	DELIMITER ',' CSV HEADER ;

----------------------------------------------------------------------


---- Ajouut de la géometrie à restaurant avec geom

ALTER TABLE projet.localisation 
ADD COLUMN geom GEOMETRY (POINT, 4326); 

UPDATE projet.localisation
SET geom = ST_SetSRID(
	ST_makePoint(
	lon, 
	CASE 
		when lat = -90 then -89.9 
		when lat = 90 then 89.9
		else lat
	END
	), 4326
)

--- IMPORT DES AUUTRES TABLES
COPY projet.rgpd 
	FROM 'SQL-Course/data/Projet final/rgpd.csv'
	DELIMITER ',' CSV HEADER ;

--shp2pgsql SQL-Course/data/Projet final/gadm41_SEN_4.shp gadm_commune -s 4326 -I | psql -U postgres -d projet_final


-- Part 1 

-- Classer les annonces par date de publication du plus récent au moins 

SELECT a.*, pub.date_publication 
	FROM projet.annonce AS a INNER JOIN projet.publication AS pub
	ON a.id_publication = pub.publicationn_id
	ORDER BY (pub.date_publication) DESC 

--- Créer une colonne annee_publication dans la table publicatiton 
ALTER TABLE projet.publication
	ADD COLUMN annee_publication NUMERIC; 

select extract (year from date_publication) from projet.publication 

UPDATE projet.publication 
	SET annee_publication = extract (year from date_publication::date)

-- Classer les années en fonction des ventes 
	
SELECT pub.annee_publication, SUM(p.prix) AS total_prix_annuel
	FROM projet.annonce AS a INNER JOIN projet.publication AS pub
	ON a.id_publication = pub.publicationn_id 
	INNER JOIN projet.prix as p 
	ON a.id_prix = p.id_prix
	GROUP BY pub.annee_publication
	ORDER BY (total_prix_annuel) DESC

--- regrouper tous les élements dans annonces all
CREATE TABLE projet.annonces_all AS 
	(
	SELECT a.*, v.id_vendeur, v.nom, v.abonnement, 
	pub.date_publication, pub.annee_publication,
	p.prix, p.monnaie, p.prix_cfa, 
	m.chambre, m.salle_bain, m.surface, m.img_url, m.description, 
	l.addresse_complete, l.region, l.contee, l.geom 
	FROM projet.annonce a 
--	INNER JOIN  projet.source AS s ON a.id_source = s.id_source
	INNER JOIN projet.prix p ON a.id_prix = p.id_prix 
	INNER JOIN projet.publication pub ON a.id_publication = pub.publicationn_id 
	INNER JOIN projet.maison m ON a.id_maison = m.id_maison
	INNER JOIN projet.vendeur v ON m.id_vendeur = v.id_vendeur
	INNER JOIN projet.localisation l ON m.id_localisation = l.id_localisation
	)

--- Pour le reste du projet, nous travaillerons avec l'année où il y'a eu le plus de vente 



	
-- determiner l'année avec le plus de vente

SELECT pub.annee_publication, SUM(p.prix) AS total_prix_annuel
	FROM projet.annonce AS a INNER JOIN projet.publication AS pub
	ON a.id_publication = pub.publicationn_id 
	INNER JOIN projet.prix as p 
	ON a.id_prix = p.id_prix
	GROUP BY pub.annee_publication
	ORDER BY (total_prix_annuel) DESC
	LIMIT 1

	
--- Annonnce 2022


CREATE TABLE projet.annonces_2022 AS 
	(
	SELECT * 
		FROM projet.annonces_all
		WHERE annee_publication = 2022
	)

-- verifier les géométries des tables localisationn et commune 

SELECT * ,ST_ISVALIDREASON(geom) 
	FROM projet.gadm_commune
	WHERE NOT ST_ISVALID(geom)

SELECT * ,ST_ISVALIDREASON(geom) 
	FROM projet.localisation
	WHERE NOT ST_ISVALID(geom)

-- Creation d'index spatial 
-- les index spatiales permettent de réduire considerablement les temps de calculs des opérations sur 
-- les opérateurs Bounding Box 

CREATE INDEX gist_annonce ON projet.annonces_all USING GIST (geom);

CREATE INDEX gist_annonce2022 ON projet.annonces_2022 USING GIST (geom);

CREATE INDEX gist_annonce ON projet.annonces_all USING GIST (geom);


-- Determiner spatialement où il y'a plus de mouvement immobilière
SELECT com.code_commune, com.commune ,  COUNT(a.id_annonce) AS nombre_annonces
	FROM projet.annonces_2022 AS a INNER JOIN projet.gadm_commune AS com
	ON ST_Contains(com.geom, a.geom)
	GROUP BY (com.code_commune, com.commune)

-- Determiner alors les 5 communes où le coût de l'immobilier est le plus élévé
SELECT com.code_commune, com.commune ,  ROUND(AVG(a.prix)) AS prix_moyen
	FROM projet.annonces_2022 AS a INNER JOIN projet.gadm_commune AS com
	ON ST_Contains(com.geom, a.geom)
	GROUP BY (com.code_commune, com.commune)
	ORDER BY prix_moyen DESC
	LIMIT 5

--- Dans le reste du projet de trouver quelques indicateurs qui ont de l'infu
-- Importer les données: route_SN et aeroport_SN

--shp2pgsql SQL-Course/data/Projet final/route_SN.shp gadm_commune -s 4326 -I | psql -U postgres -d projet_final
--shp2pgsql SQL-Course/data/Projet final/aeroport.shp gadm_commune -s 4326 -I | psql -U postgres -d projet_final

---- Impact des routes sur le prix 
	
--Déterminer pour chaque commune la longueur des troncons de route et donc la densité de route
CREATE INDEX gist_route ON projet."route_SN" USING GIST (geom);
CREATE INDEX gist_route_senegal ON projet.route_senegal USING GIST (geom);

CREATE VIEW projet.route_par_commune AS (
SELECT com.code_commune, com.commune , SUM(ST_Length(route.geom)) AS longueur_route_m
	FROM projet.gadm_commune AS com INNER JOIN projet.route_senegal AS route
	ON ST_Contains(com.geom, route.geom)
	GROUP BY (com.code_commune, com.commune)
	ORDER BY  longueur_route_m DESC)

CREATE VIEW projet.prix_commune AS(
SELECT com.code_commune, com.commune ,  ROUND(AVG(a.prix)) AS prix_moyen
	FROM projet.annonces_2022 AS a INNER JOIN projet.gadm_commune AS com
	ON ST_Contains(com.geom, a.geom)
	GROUP BY (com.code_commune, com.commune)
	ORDER BY prix_moyen DESC )

-- Pour déterminer le poids de la longueur des routes sur l'immobilier 

SELECT 
	prix_commune.code_commune, 
	prix_commune.commune , 
	prix_commune.prix_moyen,
	route_par_commune.longueur_route_m, 
	AVG (prix_commune.prix_moyen / prix_commune.prix_moyen + route_par_commune.longueur_route_m) AS rapport_prix_route
	FROM projet.prix_commune
	INNER JOIN projet.route_par_commune 
	ON prix_commune.code_commune = route_par_commune.code_commune
	GROUP BY (prix_commune.code_commune, prix_commune.commune, prix_commune.prix_moyen,route_par_commune.longueur_route_m )
	ORDER BY rapport_prix_route DESC
	--LIMIT 5



