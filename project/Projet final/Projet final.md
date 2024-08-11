# Projet final

## Petit rappel: La normalisation des bases

La normalisation est un concept important dans les bases de données pour s'assurer de l'organisation et de la cohérence de la structure de notre base de donnée. Nous avons 3 formes normales essentiellement.

### 1ère forme normale (1FN)

But:

* Éliminer la répétition de groupes dans les différentes tables.
* Créer une table distincte pour chaque jeu de données connexes.
* Identifier chaque jeu de données connexes à l’aide d’une clé primaire.

Exemple:

Pour assurer le suivi d’un article en stock pouvant provenir de deux sources différentes, un enregistrement de stock peut contenir des champs pour le code fournisseur 1 et le code fournisseur 2. Si on veut ajouter un autre fournisseur, on aura à modifier les tables et aussi le programme. Donc conformément à la 1FN, nous allons une table fournisseur pour stocker les fournisseurs à l'aide de leur code

### 2e forme normale (2FN)

But:

* Créer des tables distinctes pour les jeux de valeurs qui s’appliquent à plusieurs enregistrements.
* Établir une relation entre ces tables à l’aide d’une clé étrangère.

Donc ici les enregistrement ne dependent que de la clé primaire de la table

Exemple:

Si on veut enregistrer l'addresse client dans un système de comptabilité par exemple, cette addresse sera importante pour la table **client** mais pas que, elle sera aussi dans les tables commandes, expedition, facture ... Donc il faudra une table addresse dont la clé primaire sera utilisé comme clé étrangère dans toutes les autres tables.

### 3e forme normale (3FN)

But:

* Éliminer les champs qui ne dépendent pas de la clé.

En général, dès lors que le contenu d’un groupe de champs peut s’appliquer à plusieurs enregistrements de la table, envisagez de déplacer ces champs dans une autre table.

Exemple:

Pour le recrutement d'un employé, on souhaiterait enregistrer l'université de provenance de l'employé mais ici.

Par exemple si on souhaite une liste des universités qui n'ont pas d'employé dans notre base alors on ne peut le savoir. Il faudra donc créer une table des universités.

Exception:

La 3FN bien souhaitable théoriquement n'est souvent pas souhaitable.

Comme exemple, si vous possédez une table Clients et souhaitez éliminer toutes les dépendances interchamps possibles, vous devez créer des tables distinctes pour les villes, les codes postaux, les représentants de commerce, les classes de clientèle et tout autre facteur pouvant être dupliqué dans plusieurs enregistrements.

Vous pouvez vous entrainer sur l'exemple ici : [https://learn.microsoft.com/fr-fr/office/troubleshoot/access/database-normalization-description](FN)

Bon bref, on s'arrête ici pour ce petit rappel bien que long mais très important pour la suite....

## Objectifs

Ce projet a pour but de consolider les acquis de la formation

Il se décline en trois principaux objectifs:

1. Création de la structure d'une base de donnéeè
2. Execution de requête SQL
3. Faire des analyses spatiales
4. Présenter les résultats

## Compétences à acquérir

A la suite de ce projet, vous devez être à mesure de:

1. Synthétiser les notions de la formation
2. Exécuter un projet de bases de donnée spatiales de bout en bout
3. Présenter et diffuser les résultats d'une analyse spatiale

## Problématique

Un promoteur immobilier residant à Abidjan souhaiterait diversifier ces activités et s'étendre. Pour cette extension son choix s'est porté sur la ville de Dakar.
Il commence l'étude de marché. Pour avoir une étude de marché plus poussée, il souhaite faire appel à votre expertise et vous fourni plusieurs données sur toutes les annonces de l'immobilier dans cette ville.

Il faudra donc utiliser ces données pour lui fournir toutes les raisons pour s'installer ou pas à Dakar.

## Consignes

1. **Analyse fonctionnel de la problématique:** A partir des données fournies, etablir une base de données cohérentes (MLD, MCD et MPD) à partir des règles que nous avons vu sur les bases et des principes de normalisations
2. **Analyse et traitement des données immobilières:**

   * Importer les données nécessaires csv et les données shp: aeroport, commune du senegal (gadm41_SEN_4.shp)
   * Ajouter une géométrie à la table localisation et créer cette géométrie à l'aide de la latitude et de la longitude
   * Partie 1: Analyse des tendances immobilières
     * Créer une table annonce_all qui regroupe toutes les informations liées aux annonces
     * Transformer cette table en table géométrie en faisant une jointure avec maison
     * Créer un champ contenant l'année de l'annonce de type numeric. Par exemple: 2022
     * Classer les années en fonction des ventes
     * Determiner l'année avec le plus de vente
   * Partie 2: Analyse géospatial
     * Créer un index spatial pour chaque données géographiques dans la base de données
     * Vérifier les géométries et corrigez les
     * Déterminer les 5 premières communes où l'immobilier est le coût de l'immobilier est le plus élévé
     * Pour determiner le poids des routes sur l'immobilier:
       * Importer la couche route
       * determiner la longueur des routes par communes
       * determiner la densité de route par communes
       * Classer les 5 communes par densité de route
     * Pour déterminer le poids de la population sur l'immobilier
       * determiner la densité de la population par commune
       * est-ce que le prix de l'immobilier est lié à la densité de la population
     * Déterminer les communes qui sont à moins de 5 km d'un aéroport
     * Est-ce que le prix de l'immobilier est supérieur à la moyenne dans ces communes
   * Déterminer finalement les facteurs qui influencent sur l'immobilier
3. **Présentation des résultats:**

* Créer un compte d'essai sur neondb:[ https://console.neon.tech/app/projects](neonlink)
* Créer un projet postgresql 16 ou 15
* Copiez les infos de connexion

  ![1723390951462](image/Projetfinal/1723390951462.png)


* Connexion à PostgreSQL
  	![1723393674949](image/Projetfinal/1723393674949.png)

    Ici mettez le nom du serveur par exemple: projet_neon

![1723393756621](image/Projetfinal/1723393756621.png)

Ici vous utiliserez les informations de connexion de neon db sous cette forme

    **postgresql://neondb_owner:xxxxxxxxx@ep-super-pond-a5f5d601.us-east-2.aws.neon.tech/*neondb*?sslmode=require**

![1723394634873](image/Projetfinal/1723394634873.png)

    *Host name* : **1**

   *Maintenance database*:  **2**

   *Username*: **3**

   *Password*:  **4**

et le mode de connexion il faut qu'elle soit Required 

![1723394848345](image/Projetfinal/1723394848345.png)

* Sauvegardez la base de donnée de votre projet:

  Il faut donc créer le fichier de sauuvegarde de ta base du projet

  ![1723394869895](image/Projetfinal/1723394869895.png)

  ![1723394903007](image/Projetfinal/1723394903007.png)
* Restaurez la base de donnée de votre projet sur votre base de donnée créée sur neondb

Il faut ensuite restaurer le projet sur neon db pour le rendre disponible 

    ![1723394996860](image/Projetfinal/1723394996860.png)


    ![1723395042200](image/Projetfinal/1723395042200.png)

Votre projet est sur le cloud et vous pouvez l'utiliser partout et le partager à tout le monde
