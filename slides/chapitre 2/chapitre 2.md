# Chapitre 2: Le Language SQL 

## SQL Data Type

### Data Type

| Import    | Stocké          | Rôles                                                     |
| --------- | ---------------- | ---------------------------------------------------------- |
| String    | VARCHAR()        | enregistrement des caractères                             |
| Date/Time | TIMESTAMP        | enregistrement des dates comme année, mois ...., temps... |
| Number    | DOUBLE PRECISION | Pour les valeurs numériques                               |
| Boolean   | BOOLEAN          | Deux valeurs TRUE ou FALSE                                 |

### Change Data Type 

* CAST

  ```sql
  CAST(nom_colonne AS integer)
  ```
* Syntaxe ( :: )

  ```sql
  nom_colonne::integer
  ```

## Requêtes SQL

### Requête de création 

* CREATE

```sql
-- Creation de base de donnée
CREATE DATABASE entreprise ;

-- Creation de table 
CREATE TABLE Customer(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Age INT CHECK (Age >= 0 AND Age <= 99),
    Phone int(10)
);
```

### Insertion et Import de données

* INSERT INTO
  ```sql
  INSERT INTO table_name (column1, column2, …) VALUES (value1, value2, …);

  INSERT INTO Customer (CustomerID, CustomerName, LastName, Country, Age, Phone)
  VALUES (1, 'Shubham', 'Thakur', 'India','23','xxxxxxxxxx'),
         (2, 'Aman ', 'Chopra', 'Australia','21','xxxxxxxxxx'),
         (3, 'Naveen', 'Tulasi', 'Sri lanka','24','xxxxxxxxxx'),
         (4, 'Aditya', 'Arpan', 'Austria','21','xxxxxxxxxx'),
         (5, 'Nishant. Salchichas S.A.', 'Jain', 'Spain','22','xxxxxxxxxx');
  ```
* COPY FROM
  ```sql
  COPY table_name FROM 'file path' DELIMITER "," CSV HEADER;
  ```

### Modification et Suppression

* ALTER TABLE

  ```sql
  -- ajouter une colonne 
  ALTER TABLE nom_table
  ADD nom_colonne type_donnees

  ALTER TABLE Customer
  ADD Salaire DOUBLE;

  -- changer le type de données
  ALTER TABLE nom_table
  ALTER COLUMN nom_colonne TYPE type_donnees

  ALTER TABLE Customer
  ALTER COLUMN LastName TYPE VARCHAR(25);

  -- Renommer une colonne 
  ALTER TABLE Customer RENAME CustomerName TO CustomerNom;

  ```
* DELETE

  ```sql
  -- suppression par condition
  DELETE FROM nom_table
  WHERE condition; 

  -- tout supprimer
  DELETE FROM nom_table; 
  TRUNCATE TABLE nom_table; -
  ```

  Ici TRUNCATE réinitialise l'auto-incrementation contrairement à Delete
* DROP

  ```sql
  DROP TABLE nom_table;
  ```
* UPDATE

  ```sql
  UPDATE table
  SET colonne_1 = 'valeur 1', colonne_2 = 'valeur 2', colonne_3 = 'valeur 3'
  WHERE condition;
  ```
* CASCADE

### Export de données

* COPY TO


## Fonctions SQL et Jointures Syntaxiques

### Fonctions d'aggregation

* SUM, AVG
* GROUP BY, ORDER BY,
* HAVING

### Contraintes

* Clé Primaire
* Clé Secondaire
* CASCADE
* ```sql
  CREATE TABLE Authors (
      AuthorID INT PRIMARY KEY,
      AuthorName VARCHAR(200)
  );

  CREATE TABLE Books (
      BookID INT PRIMARY KEY,
      Title VARCHAR(255),
      AuthorID INT,
      FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
  );


  INSERT INTO Authors (AuthorID, AuthorName) VALUES (1, 'John Doe');
  INSERT INTO Authors (AuthorID, AuthorName) VALUES (2, 'Minal Pandey');
  INSERT INTO Authors (AuthorID, AuthorName) VALUES (3, 'Mahi Pandey');

  INSERT INTO Books (BookID, Title, AuthorID) VALUES (101, 'Introduction to SQL', 1);
  INSERT INTO Books (BookID, Title, AuthorID) VALUES (102, 'Database Fundamentals', 2);
  INSERT INTO Books (BookID, Title, AuthorID) VALUES (103, 'Advanced SQL', 2);
  INSERT INTO Books (BookID, Title, AuthorID) VALUES (104, 'Web Development', 3);
  ```

  * ON DELETE : quand la clé primaire dans la table parent est supprimé alors la clé étrangère dans la table fille est automatiquement mis à jour

    ```sql
    DELETE FROM Authors WHERE AuthorID = 2;
    ```
  * ON UPDATE : quand la clé primaire dans la table parent est mis à jour alors la clé étrangère dans la table fille est automatiquement mis à jour

    ```sql
    UPDATE Authors SET AuthorID = 1 WHERE AuthorID = 2;
    ```
  * ON INSERT : On peut ajouter un nouvel élement dans la table référencé quand il est ajouté à la table mère
* ```sql
  INSERT INTO Authors (AuthorID, AuthorName) VALUES (4, 'Sukumar Reddy');
  INSERT INTO Books (BookID, Title, AuthorID) VALUES (105, 'Data Science', 4);
  ```

### Jointures syntaxiques

* Types de Jointures
* Syntaxe

## Requêtes Avancées

### Sous-Requêtes

```sql
SELECT table.champ1, table.champ2  
	FROM (
		SELECT champ1, champ2, ...
			FROM table 
		)
```

### Requête WITH

```sql
WITH table_temporaire AS (
	SELECT champ1, champ2, ...
		FROM table ) , 
	SELECT table.champ1, table.champ2, ....
		FROM table, table_temporaire
```



```
UPDATE table
SET colonne_1 = 'valeur 1', colonne_2 = 'valeur 2', colonne_3 = 'valeur 3'
WHERE condition
```
