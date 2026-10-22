-- =====================================================================
--  ESAME FINALE MODULO SQL - ToysGroup
--  Autore: Francesco Autorino
--  DBMS: MySQL 8 (lo script è compatibile anche con MariaDB)
--
--  Il file si esegue dall'inizio alla fine e ricrea il database da zero.
--
--  INDICE
--    TASK 2 - Creazione del database e delle tabelle (DDL)
--    TASK 3 - Popolamento delle tabelle (DML)
--    TASK 4 - Query di analisi e viste
--  Il Task 1 (progettazione concettuale e logica) è nel README.
-- =====================================================================


-- =====================================================================
--  TASK 2 - CREAZIONE DEL DATABASE E DELLE TABELLE
-- =====================================================================

DROP DATABASE IF EXISTS ToysGroup;
CREATE DATABASE ToysGroup CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ToysGroup;

-- Gerarchia del prodotto: Category (1) ---- (N) Product
CREATE TABLE Category (
    CategoryID   INT          NOT NULL,
    CategoryName VARCHAR(50)  NOT NULL,
    CONSTRAINT PK_Category      PRIMARY KEY (CategoryID),
    CONSTRAINT UQ_Category_Name UNIQUE (CategoryName)
);

CREATE TABLE Product (
    ProductID   INT            NOT NULL,
    ProductName VARCHAR(100)   NOT NULL,
    ListPrice   DECIMAL(10,2)  NOT NULL,
    CategoryID  INT            NOT NULL,
    CONSTRAINT PK_Product          PRIMARY KEY (ProductID),
    CONSTRAINT UQ_Product_Name     UNIQUE (ProductName),
    CONSTRAINT CK_Product_Price    CHECK (ListPrice > 0),
    CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryID) REFERENCES Category (CategoryID)
);

-- Gerarchia geografica: Region (1) ---- (N) State
CREATE TABLE Region (
    RegionID   INT         NOT NULL,
    RegionName VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Region      PRIMARY KEY (RegionID),
    CONSTRAINT UQ_Region_Name UNIQUE (RegionName)
);

CREATE TABLE State (
    StateID   INT         NOT NULL,
    StateName VARCHAR(50) NOT NULL,
    RegionID  INT         NOT NULL,
    CONSTRAINT PK_State        PRIMARY KEY (StateID),
    CONSTRAINT UQ_State_Name   UNIQUE (StateName),
    CONSTRAINT FK_State_Region FOREIGN KEY (RegionID) REFERENCES Region (RegionID)
);

-- Tabella dei fatti: una riga = una transazione di vendita.
-- Ogni vendita riguarda un solo prodotto e un solo stato (e quindi una sola regione).
-- UnitPrice salva il prezzo al momento della vendita, che può essere diverso dal listino.
CREATE TABLE Sales (
    SalesOrderNumber VARCHAR(12)    NOT NULL,
    OrderDate        DATE           NOT NULL,
    ProductID        INT            NOT NULL,
    StateID          INT            NOT NULL,
    Quantity         INT            NOT NULL,
    UnitPrice        DECIMAL(10,2)  NOT NULL,
    CONSTRAINT PK_Sales          PRIMARY KEY (SalesOrderNumber),
    CONSTRAINT CK_Sales_Quantity CHECK (Quantity > 0),
    CONSTRAINT CK_Sales_Price    CHECK (UnitPrice > 0),
    CONSTRAINT FK_Sales_Product  FOREIGN KEY (ProductID) REFERENCES Product (ProductID),
    CONSTRAINT FK_Sales_State    FOREIGN KEY (StateID)   REFERENCES State (StateID)
);


-- =====================================================================
--  TASK 3 - POPOLAMENTO DELLE TABELLE
--  Ordine obbligato dalle chiavi esterne: prima le tabelle "padre".
-- =====================================================================

INSERT INTO Category (CategoryID, CategoryName) VALUES
    (1, 'Bikes'),
    (2, 'Clothing'),
    (3, 'Board Games'),
    (4, 'Outdoor Toys');

INSERT INTO Product (ProductID, ProductName, ListPrice, CategoryID) VALUES
    (101, 'Bikes-100',        149.90, 1),
    (102, 'Bikes-200',        199.90, 1),
    (103, 'Balance Bike',      89.90, 1),
    (201, 'Bike Gloves M',     14.90, 2),
    (202, 'Bike Gloves L',     14.90, 2),
    (203, 'Kids Helmet',       29.90, 2),
    (301, 'Family Quiz',       24.90, 3),
    (302, 'Treasure Map Game', 34.90, 3),
    (303, 'Chess Junior',      19.90, 3),
    (401, 'Water Blaster',     12.90, 4),
    (402, 'Kite Rainbow',      17.90, 4),
    (403, 'Garden Tent',       59.90, 4);   -- 202, 303 e 403 restano invenduti (servono alla query 7)

INSERT INTO Region (RegionID, RegionName) VALUES
    (1, 'WestEurope'),
    (2, 'SouthEurope'),
    (3, 'NorthEurope'),
    (4, 'NorthAmerica');

INSERT INTO State (StateID, StateName, RegionID) VALUES
    (1, 'France',        1),
    (2, 'Germany',       1),
    (3, 'Italy',         2),
    (4, 'Greece',        2),
    (5, 'Spain',         2),
    (6, 'Sweden',        3),
    (7, 'United States', 4),
    (8, 'Canada',        4);

INSERT INTO Sales (SalesOrderNumber, OrderDate, ProductID, StateID, Quantity, UnitPrice) VALUES
    ('SO-2024-001', '2024-01-15', 101, 3,  2, 149.90),
    ('SO-2024-002', '2024-02-03', 201, 1,  5,  14.90),
    ('SO-2024-003', '2024-02-20', 301, 2,  3,  24.90),
    ('SO-2024-004', '2024-03-11', 401, 5, 10,  12.90),
    ('SO-2024-005', '2024-04-02', 102, 7,  1, 199.90),
    ('SO-2024-006', '2024-05-18', 302, 3,  4,  34.90),
    ('SO-2024-007', '2024-06-07', 402, 4,  6,  17.90),
    ('SO-2024-008', '2024-07-22', 203, 6,  3,  29.90),
    ('SO-2024-009', '2024-09-09', 103, 8,  2,  89.90),
    ('SO-2024-010', '2024-11-25', 301, 7,  8,  22.90),
    ('SO-2025-001', '2025-01-10', 101, 2,  1, 154.90),
    ('SO-2025-002', '2025-02-14', 201, 3,  6,  14.90),
    ('SO-2025-003', '2025-03-03', 401, 1, 12,  12.90),
    ('SO-2025-004', '2025-04-21', 302, 5,  2,  34.90),
    ('SO-2025-005', '2025-06-30', 102, 3,  2, 199.90),
    ('SO-2025-006', '2025-08-12', 402, 6,  7,  17.90),
    ('SO-2025-007', '2025-10-05', 203, 7,  4,  29.90),
    ('SO-2025-008', '2025-12-01', 301, 4,  5,  24.90),
    ('SO-2026-001', '2026-01-19', 101, 7,  3, 149.90),
    ('SO-2026-002', '2026-02-08', 401, 3, 15,  11.90),
    ('SO-2026-003', '2026-03-17', 201, 2,  4,  14.90),
    ('SO-2026-004', '2026-04-29', 103, 1,  2,  89.90),
    ('SO-2026-005', '2026-06-14', 402, 5,  9,  17.90),
    ('SO-2026-006', '2026-07-30', 302, 8,  3,  34.90),
    ('SO-2026-007', '2026-09-02', 301, 3,  6,  24.90);


-- =====================================================================
--  TASK 4 - QUERY DI ANALISI E VISTE
-- =====================================================================

-- ---------------------------------------------------------------------
-- 4.1 Le chiavi primarie sono univoche?
--     Una query per tabella: se una PK si ripete, la query restituisce
--     il valore duplicato. Un risultato vuoto vuol dire che la PK è univoca.
-- ---------------------------------------------------------------------
SELECT CategoryID, COUNT(*) AS Occorrenze FROM Category GROUP BY CategoryID HAVING COUNT(*) > 1;
SELECT ProductID,  COUNT(*) AS Occorrenze FROM Product  GROUP BY ProductID  HAVING COUNT(*) > 1;
SELECT RegionID,   COUNT(*) AS Occorrenze FROM Region   GROUP BY RegionID   HAVING COUNT(*) > 1;
SELECT StateID,    COUNT(*) AS Occorrenze FROM State    GROUP BY StateID    HAVING COUNT(*) > 1;
SELECT SalesOrderNumber, COUNT(*) AS Occorrenze FROM Sales GROUP BY SalesOrderNumber HAVING COUNT(*) > 1;

-- La stessa verifica in un unico risultato: righe totali e valori distinti devono coincidere.
SELECT 'Category' AS Tabella, COUNT(*) AS Righe, COUNT(DISTINCT CategoryID) AS ValoriDistinti FROM Category
UNION ALL SELECT 'Product', COUNT(*), COUNT(DISTINCT ProductID)        FROM Product
UNION ALL SELECT 'Region',  COUNT(*), COUNT(DISTINCT RegionID)         FROM Region
UNION ALL SELECT 'State',   COUNT(*), COUNT(DISTINCT StateID)          FROM State
UNION ALL SELECT 'Sales',   COUNT(*), COUNT(DISTINCT SalesOrderNumber) FROM Sales;

-- ---------------------------------------------------------------------
-- 4.2 Elenco delle transazioni, con un campo booleano che indica se
--     sono passati più di 180 giorni dalla vendita (1 = True, 0 = False).
-- ---------------------------------------------------------------------
SELECT
    s.SalesOrderNumber                                AS CodiceDocumento,
    s.OrderDate                                       AS DataVendita,
    p.ProductName                                     AS Prodotto,
    c.CategoryName                                    AS Categoria,
    st.StateName                                      AS Stato,
    r.RegionName                                      AS Regione,
    DATEDIFF(CURRENT_DATE, s.OrderDate) > 180         AS PiuDi180Giorni
FROM Sales s
JOIN Product  p  ON p.ProductID  = s.ProductID
JOIN Category c  ON c.CategoryID = p.CategoryID
JOIN State    st ON st.StateID   = s.StateID
JOIN Region   r  ON r.RegionID   = st.RegionID
ORDER BY s.OrderDate;

-- ---------------------------------------------------------------------
-- 4.3 Prodotti che hanno venduto, in totale, una quantità maggiore della
--     media delle vendite dell'ultimo anno censito.
--     Sia l'ultimo anno sia la media sono calcolati da subquery:
--     nessun valore è scritto a mano.
-- ---------------------------------------------------------------------
SELECT
    s.ProductID      AS CodiceProdotto,
    SUM(s.Quantity)  AS TotaleVenduto
FROM Sales s
GROUP BY s.ProductID
HAVING SUM(s.Quantity) > (
    SELECT AVG(s2.Quantity)
    FROM Sales s2
    WHERE YEAR(s2.OrderDate) = (SELECT MAX(YEAR(OrderDate)) FROM Sales)
)
ORDER BY TotaleVenduto DESC;

-- ---------------------------------------------------------------------
-- 4.4 Solo i prodotti venduti, con il fatturato totale per anno.
--     La JOIN interna esclude da sola i prodotti senza vendite.
-- ---------------------------------------------------------------------
SELECT
    p.ProductID                        AS CodiceProdotto,
    p.ProductName                      AS Prodotto,
    YEAR(s.OrderDate)                  AS Anno,
    SUM(s.Quantity * s.UnitPrice)      AS Fatturato
FROM Sales s
JOIN Product p ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, YEAR(s.OrderDate)
ORDER BY p.ProductID, Anno;

-- ---------------------------------------------------------------------
-- 4.5 Fatturato totale per stato e per anno,
--     ordinato per anno e per fatturato decrescente.
-- ---------------------------------------------------------------------
SELECT
    st.StateName                       AS Stato,
    YEAR(s.OrderDate)                  AS Anno,
    SUM(s.Quantity * s.UnitPrice)      AS Fatturato
FROM Sales s
JOIN State st ON st.StateID = s.StateID
GROUP BY st.StateName, YEAR(s.OrderDate)
ORDER BY Anno, Fatturato DESC;

-- ---------------------------------------------------------------------
-- 4.6 Qual è la categoria di articoli più richiesta dal mercato?
--     "Più richiesta" = più pezzi venduti. Il confronto con il massimo
--     (invece di LIMIT 1) mostra tutte le categorie in caso di pareggio.
-- ---------------------------------------------------------------------
SELECT
    c.CategoryName      AS Categoria,
    SUM(s.Quantity)     AS PezziVenduti
FROM Sales s
JOIN Product  p ON p.ProductID  = s.ProductID
JOIN Category c ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName
HAVING SUM(s.Quantity) = (
    SELECT MAX(TotaleCategoria)
    FROM (
        SELECT SUM(s2.Quantity) AS TotaleCategoria
        FROM Sales s2
        JOIN Product p2 ON p2.ProductID = s2.ProductID
        GROUP BY p2.CategoryID
    ) AS TotaliPerCategoria
);

-- ---------------------------------------------------------------------
-- 4.7 Quali sono i prodotti invenduti? Due approcci.
-- ---------------------------------------------------------------------
-- Approccio 1: LEFT JOIN, tengo i prodotti senza nessuna vendita collegata.
SELECT p.ProductID AS CodiceProdotto, p.ProductName AS Prodotto
FROM Product p
LEFT JOIN Sales s ON s.ProductID = p.ProductID
WHERE s.SalesOrderNumber IS NULL;

-- Approccio 2: subquery con NOT EXISTS.
SELECT p.ProductID AS CodiceProdotto, p.ProductName AS Prodotto
FROM Product p
WHERE NOT EXISTS (
    SELECT 1 FROM Sales s WHERE s.ProductID = p.ProductID
);

-- ---------------------------------------------------------------------
-- 4.8 Vista denormalizzata sui prodotti: codice, nome e categoria.
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_Product AS
SELECT
    p.ProductID     AS CodiceProdotto,
    p.ProductName   AS Prodotto,
    c.CategoryName  AS Categoria
FROM Product p
JOIN Category c ON c.CategoryID = p.CategoryID;

SELECT * FROM vw_Product;

-- ---------------------------------------------------------------------
-- 4.9 Vista sulle informazioni geografiche: ogni stato con la sua regione.
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_Geography AS
SELECT
    st.StateID      AS CodiceStato,
    st.StateName    AS Stato,
    r.RegionID      AS CodiceRegione,
    r.RegionName    AS Regione
FROM State st
JOIN Region r ON r.RegionID = st.RegionID;

SELECT * FROM vw_Geography;
