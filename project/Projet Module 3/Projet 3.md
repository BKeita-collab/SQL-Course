# Projet du module 3

## Objectifs

Ce projet a pour but de consolider les acquis du module 3 sur le langage SQL.

Il se décline en trois principaux objectifs:

1. Passer d'un modèle classique ou standard de données à un modèle spatial de données
2. Comprendre et savoir manipuler les système de références
3. Vérifier et corriger les géométries
4. Manipulation d'une base de données spatiales à l'aide de requêtes et sous-requêtes
5. Effectuer les jointures spatiales

## Compétences à acquérir

A la suite de ce projet, vous devez être à mesure de:

1. Ajouter la composantes spatiale à une base de données classique
2. Comprendre et valider les géométries
3. Exécuter des requêtes spatiales
4. Comprendre les jointures spatiales

## Problématique

**Pour rappel:**

Nous souhaitons à travers ce projet déterminer tous les restaurants de type rapide qui se trouve à proximité de 10 Kilomètre autour d'une route de niveau 1 (autoroute).

Il se décline en plusieurs sous projets. Ainsi nous procédérons à la résolution de ce problème au fur et à mesure de notre montée en compétence.

Dans dernier sous-projet, nous travaillerons sur l'analyse spatiale en utilisant la composante spatiale de PostGreSQL, l'extension PostGIS.

## Consignes

1. Ajouter un champ géométrie à la table restaurant et  importer des données dans la table route créée lors du [projet 1](https://github.com/BKeita-collab/SQL-Course/blob/76a864b8f28a9d4f491eab9bb5efc255e546b61d/project/Projet%20Module%201/Projet%201.md) et [projet 2](https://github.com/BKeita-collab/SQL-Course/blob/6b59475f3ffda7cfbc9ce1ca98ef9f156b0ebdf0/project/Projet%20Module%202/Projet%202.md)
2. Vérifier les géométries et valider les géométries des tables
3. Pour cette partie nous cherchons à determiner des résultats en utilisant les requêtes SQL:
   * Quel est le système de coordonnée de la route?
   * Déterminer les restaurants qui sont à moins de 10km de toutes les autoroutes ?
   * Bonus: **shp2pgsql "data/Module 3/roadtrl020.shp"**  **projet.route | psql -U postgres -d brahimakeita**
