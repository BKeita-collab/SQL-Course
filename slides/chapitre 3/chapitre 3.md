# Chapitre 3 : Base de données Spatiales

## Concept de base de données spatiales

Les bases de données permettent de stocker et de gérer diverses sources de données. Et parmi ces types de données, il y'a les données de localisation.

Pour illustrer le concept de base de données spatiales, prenons un cas pratique.

Supposons le cas d'une chaine de restaurations avec plusieurs restaurants dans differentes villes et pays. La base

Chaque franchise est caractérisé par un :

* code de franchise
* nom
* chiffre d'affaire

Chaque restaurant est caractérisé par un :

* code restaurant
* code de franchise
* nom du restaurant
* chiffre d'affaire

En raison des demandes croissantes et du nombre important, une parmi les chaines de restauration souhaiterait ouvrir un nouveau restaurant. Pour cela il faut avoir la localisation de chaque restaurant dans la base.

Pour pouvoir stocker et manipuler cette information de localisation des restaurants, nous allons ainsi utiliser une base de données spatiales.

*Une base de données spatiales* est une base de données classiques avec un attribut géométrique ou géographique. Cette information géographique peut donc être:

* un point pour répresenter un restaurant
* une ligne pour répresenter une route
* un polygone pour répresenter une ville
* et d'autres types de données comme les rasters, les noeuds ou réseaux ....

Les bases de données permettent également d'utiliser des fonctions spécifiques, des indexes géométriques sous SQL.

## PostGIS

PostGIS est une librairie libre qui permet de gérer les attributs spatiaux dans une base de données relationnelle.

C'est une extension spatiale qui est aussi utilisable sous PostGreSQL.

Il offre la possibilité a plusieurs a plusieurs fonctionnalités.

### Pourquoi PostGIS

Il présente plusieurs avantages:

* Open-Source
* Interopérabilité : il peut être utiliser et intégrer dans plusieurs stack techniques comme QGIS et les outils ESRI
* Standardisation: conformité aux standards de données géographiques comme OGC, ISO
* Multitude de fonctions et de formats de données en entrées
* ...

### Format de données en entrée

PostGIS gère plusieurs format en entrée.

* Les vecteurs comme les données SHP, KML, GeoJSON, XML
* Les rasters
* Les données de typologiques comme la représentation des parcelles
* Les addresses



## Système de référence 

Prenons le cas de deux personnes l'une à Abidjan et l'autre à Paris. Si la personne à Paris organise la réunion en Juin pour 14h cela correspondra à 12h pour la personne à Abidjan. Il s'agit en réalité du principe horaire par rapport au GMT car Abidjan est à GMT+0 et Paris à GMT+2. 

Eh bien, le même concept existe pour les données géographiques il s'agit des système de référence. Il s'agit comme son nom l'indique d'un référentiel pour chaque donnée géographique. Donc à chaque fois que je donne une donnée géographique, je donne par la suite le système dans lequel il est défini. 

Un système de référence est composé: 

* Coordonnée de référence: il s'agit du type de coordonnée. Elle peut être cartesienne ou même géographique en lat, lon, h essentiellement utilisé dans le gps, la cartographie
* Ellipsoïde: c'est le modèle d'éllipsoïde pour répresente par exemple Clarke ou GRS80
* Projection plane: Il s'agit du format papier c'est à dire le passage de la forme ellipsoïdale à la forme papier qui est utilisable sur papier
