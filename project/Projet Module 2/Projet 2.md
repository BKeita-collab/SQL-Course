# Projet du module 2

## Objectifs

Ce projet a pour but de consolider les acquis du module 2 sur le langage SQL.

Il se décline en trois principaux objectifs:

1. De passer d'un modèle physique de donnée à la création d'une base de donnée à l'aide du langage SQL
2. Insérer manuellement ou en batch des données dans une base de donnée
3. Manipulation d'une base de données à l'aide de requêtes et sous-requêtes
4. Effectuer les jointures syntaxiques

## Compétences à acquérir

A la suite de ce projet, vous devez être à mesure de:

1. Créer une base de donnée à l'aide du langage SQL
2. Manipuler des données dans une base de données
3. Exécuter et comprendre les jointures syntaxiques

## Problématique

**Pour rappel:**

Nous souhaitons à travers ce projet déterminer tous les restaurants de type rapide qui se trouve à proximité de 10 Kilomètre autour d'une route de niveau 1 (autoroute).

Il se décline en plusieurs sous projets. Ainsi nous procédérons à la résolution de ce problème au fur et à mesure de notre montée en compétence.

Dans ce 2e sous-projet, nous travaillerons sur l'analyse syntaxique et relationnel de la base de donnée à l'aide du langage SQL.

Les données sont disponibles sur ce lien: 

* restaurants: [https://github.com/BKeita-collab/SQL-Course/blob/6b59475f3ffda7cfbc9ce1ca98ef9f156b0ebdf0/project/Projet%20Module%202/restaurants.csv](données restaurants csv)
* franchises: [https://github.com/BKeita-collab/SQL-Course/blob/7e86589f9590780daed3b3406f65bf00c7747f54/project/Projet%20Module%202/franchises.csv](lien franchises csv)
* Client : [https://github.com/BKeita-collab/SQL-Course/blob/7e86589f9590780daed3b3406f65bf00c7747f54/project/Projet%20Module%202/client_restaurant_data.csv](client csv)

## Consignes

1. Créer la base de donnée à partir du langage SQL en vous servant du schéma que nous avons créer lors du [projet 1](https://github.com/BKeita-collab/SQL-Course/blob/76a864b8f28a9d4f491eab9bb5efc255e546b61d/project/Projet%20Module%201/Projet%201.md)
2. Pour cette partie nous cherchons à determiner des résultats en utilisant les requuêtes SQL:
   * Quels sont le Nombre de franchises et les différentes franchises ?
   * Quel est le restaurant le mieux noté ?
   * Quelle est la note moyenne de chaque franchise et donner leur "Nom" ?
   * Déterminer les restaurants avec au moins 3 clients dans la liste

## Bonus

* Classer les restaurants par catégories (*préférence elévée*: plus de 5 clients dans la liste , *préférence moyenne*: entre 3 et 5 clients dans la liste, *préférence faible*: moins de 3 clients dans la liste).
* Exporter la table restaurant au format **.*csv***
