ALTER TABLE IF EXISTS projet.annonce DROP CONSTRAINT IF EXISTS fk1_annonce;

ALTER TABLE IF EXISTS projet.annonce DROP CONSTRAINT IF EXISTS fk2_annonce;

ALTER TABLE IF EXISTS projet.annonce DROP CONSTRAINT IF EXISTS fk3_annonce;

ALTER TABLE IF EXISTS projet.annonce DROP CONSTRAINT IF EXISTS fk4_annonce;

ALTER TABLE IF EXISTS projet.maison DROP CONSTRAINT IF EXISTS fk2_maison;

ALTER TABLE IF EXISTS projet.maison DROP CONSTRAINT IF EXISTS fk1_maison;



DROP TABLE IF EXISTS projet.publication;

CREATE TABLE IF NOT EXISTS projet.publication
(
    publicationn_id integer NOT NULL,
    date_publication date,
    CONSTRAINT pk_publication PRIMARY KEY (publicationn_id)
);

DROP TABLE IF EXISTS projet.prix;

CREATE TABLE IF NOT EXISTS projet.prix
(
    id_prix integer NOT NULL,
    prix double precision NOT NULL,
    monnaie character varying NOT NULL,
    prix_cfa double precision NOT NULL,
    CONSTRAINT pk_prix PRIMARY KEY (id_prix)
);

DROP TABLE IF EXISTS projet.categorie;

CREATE TABLE IF NOT EXISTS projet.categorie
(
    id_categorie integer NOT NULL,
    nom character varying NOT NULL,
    CONSTRAINT pk_categorie PRIMARY KEY (id_categorie)
);

DROP TABLE IF EXISTS projet.source;

CREATE TABLE IF NOT EXISTS projet.source
(
    id_source integer NOT NULL,
    nom character varying NOT NULL,
    CONSTRAINT pk_source PRIMARY KEY (id_source)
);

DROP TABLE IF EXISTS projet.vendeur;

CREATE TABLE IF NOT EXISTS projet.vendeur
(
    id_vendeur integer NOT NULL,
    nom character varying NOT NULL,
    abonnement date NOT NULL,
    CONSTRAINT pk_vendeur PRIMARY KEY (id_vendeur)
);

DROP TABLE IF EXISTS projet.annonce;

CREATE TABLE IF NOT EXISTS projet.annonce
(
    id_annonce integer NOT NULL,
    ref_annonce character varying NOT NULL,
    titre_annonce character varying NOT NULL,
    url_annonce character varying NOT NULL,
    id_categorie integer NOT NULL,
    id_prix integer NOT NULL,
    id_publication integer NOT NULL,
    id_maison integer,
    id_source integer NOT NULL,
    CONSTRAINT pk_annnonce PRIMARY KEY (id_annonce)
);

DROP TABLE IF EXISTS projet.localisation;

CREATE TABLE IF NOT EXISTS projet.localisation
(
    id_localisation integer NOT NULL,
    lat double precision NOT NULL,
    lon double precision NOT NULL,
    addresse_complete character varying,
    region character varying,
    contee character varying,
    CONSTRAINT pk_localisation PRIMARY KEY (id_localisation)
);

DROP TABLE IF EXISTS projet.maison;

CREATE TABLE IF NOT EXISTS projet.maison
(
    id_maison integer NOT NULL,
    chambre double precision,
    salle_bain double precision,
    surface double precision,
    description character varying,
    img_url character varying,
    id_localisation integer,
    id_vendeur integer,
    CONSTRAINT pk_maison PRIMARY KEY (id_maison)
);
DROP TABLE IF EXISTS projet.rgpd;

CREATE TABLE IF NOT EXISTS projet.rgpd
(
    id integer NOT NULL,
    region character varying NOT NULL,
    departement character varying NOT NULL,
    arrondissement character varying NOT NULL,
    commune character varying NOT NULL,
    quartier character varying NOT NULL,
    village character varying NOT NULL,
    concession character varying NOT NULL,
    menage character varying NOT NULL,
    nombre_hommes integer NOT NULL,
    nombre_femmes integer NOT NULL,
    population integer NOT NULL,
    CONSTRAINT pk_rgpd PRIMARY KEY (id)
);

DROP TABLE IF EXISTS projet.commune;

CREATE TABLE IF NOT EXISTS projet.commune
(
    code_commune character varying NOT NULL,
    code_pays character varying NOT NULL,
    pays character varying NOT NULL,
    code_region character varying NOT NULL,
    region character varying NOT NULL,
    code_departement character varying NOT NULL,
    departement character varying NOT NULL,
    code_arrondissement character varying NOT NULL,
    arrondissement character varying NOT NULL,
    nom_commune character varying NOT NULL,
    varname character varying NOT NULL,
    type_admin character varying NOT NULL,
    engtype character varying NOT NULL,
    cc4 integer NOT NULL,
    CONSTRAINT pk_commune PRIMARY KEY (code_commune)
);

ALTER TABLE IF EXISTS projet.annonce
    ADD CONSTRAINT fk1_annonce FOREIGN KEY (id_publication)
    REFERENCES projet.publication (publicationn_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS projet.annonce
    ADD CONSTRAINT fk2_annonce FOREIGN KEY (id_source)
    REFERENCES projet.source (id_source) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS projet.annonce
    ADD CONSTRAINT fk3_annonce FOREIGN KEY (id_prix)
    REFERENCES projet.prix (id_prix) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS projet.annonce
    ADD CONSTRAINT fk4_annonce FOREIGN KEY (id_maison)
    REFERENCES projet.maison (id_maison) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS projet.maison
    ADD CONSTRAINT fk2_maison FOREIGN KEY (id_vendeur)
    REFERENCES projet.vendeur (id_vendeur) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS projet.maison
    ADD CONSTRAINT fk1_maison FOREIGN KEY (id_localisation)
    REFERENCES projet.localisation (id_localisation) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;