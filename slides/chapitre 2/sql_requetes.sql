INSERT INTO "Proprietaire" 
	VALUES 
	('Prop1', 'Franck', 'Yaoundé', '+23709090909'),
	('Prop2', 'Soro', 'Dabou', '+22507090909'),
	('Prop3', 'JP', 'Abidjan', '+22505090909'), 
	('Prop4', 'Ange', 'Saint-Louis', '+22107090909'); 

INSERT INTO "TypeSol"
	VALUES
	('ARG', 'Argileux', 'Meuble'),
	('SIL', 'Silex', 'Permeable'),
	('GRAV', 'Gravier', 'Dur'); 

INSERT INTO "Parcelle"
	VALUES
	('PARC1', 'Parcelle 1', '500', '010100000078A7E9795EB541C09D2080BFE1CA47C0', 'ARG', 'Prop1'),
	('PARC2', 'Parcelle 2', '1500', '01010000004C0B2B60A8DB46C0182AC2A1D0D144C0', 'GRAV', 'Prop2'), 
	('PARC3', 'Parcelle 3', '1000', '0101000000A07D5C1C136A19C0AF29906764BB44C0', 'GRAV', 'Prop3');

INSERT INTO "Culture"
	VALUES
	('MS', 'Maïs', 'Culture Tropicale'); 


INSERT INTO "TransactionFonciere"
	VALUES
	('Trans1', 'PARC1', 'Prop1', 'Prop2', '1973-08-13', 5551.72),
	('Trans2', 'PARC2', 'Prop3', 'Prop1', '2013-08-15', 8851.72),
	('Trans3', 'PARC3', 'Prop2', 'Prop3', '2018-09-15', 1050.99); 


-- LIKE 

SELECT * 
	FROM "Proprietaire"
	WHERE "Nom" LIKE '%ck'; 

SELECT * 
	FROM "Proprietaire"
	WHERE "IDProprietaire" LIKE 'Pro%';

SELECT * 
	FROM "Proprietaire"
	WHERE "IDProprietaire" LIKE '%a%';

SELECT * 
	FROM "Proprietaire"
	WHERE "IDProprietaire" LIKE 'a%9';


-- Fonction d'aggregation 
SELECT COUNT(*)
	FROM "Proprietaire"; 

SELECT COUNT("Nom")
	FROM "Proprietaire"; 

SELECT "IDVendeur", SUM("Prix") AS sum_price
	FROM "TransactionFonciere"
	GROUP BY "IDVendeur";

SELECT "IDVendeur" , SUM("Prix") AS sum_price
	FROM "TransactionFonciere"
	GROUP BY ("IDVendeur")
	ORDER BY sum_price DESC;


SELECT "IDVendeur" , SUM("Prix") AS sum_price
	FROM "TransactionFonciere"
	GROUP BY ("IDVendeur")
	HAVING COUNT("IDVendeur") >= 2 AND COUNT("IDVendeur") <= 4 ;


--Contraintes



-- ON CASCADE
DELETE 
	FROM "TransactionFonciere" 
	WHERE "IDTransaction" = 'Trans1'; 

DELETE 
	FROM "Parcelle" 
	WHERE "IDParcelle" = 'PARC1';

DELETE 
	FROM "Parcelle" 
	WHERE "IDParcelle" = 'PARC1'
	CASCADE;

-----------ON CASCADE TABLE 
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

-----Requête --------------
---DELETE ON CASCADE
DELETE FROM Authors WHERE AuthorID = 4;
----UPDATE ON CASCADE
UPDATE Authors SET AuthorID = 5 WHERE AuthorID = 2;
----INSERT ON CASCADE
INSERT INTO Authors (AuthorID, AuthorName) VALUES (4, 'Sukumar Reddy');
INSERT INTO Books (BookID, Title, AuthorID) VALUES (105, 'Data Science', 4);


---- JOINTURES SYNTAXIQUES
ALTER TABLE "TransactionFonciere"
ADD "Categories" VARCHAR; 


UPDATE "TransactionFonciere"
	SET "Categories" = 
	CASE 
		WHEN "Prix" < 50000 THEN 'FAIBLE'
		WHEN "Prix" = 50000 THEN 'MOYENNE'
		ELSE 'ELEVEE'
	END; 

SELECT *
	FROM "Proprietaire"
	LIMIT 10 OFFSET 5 ; 





