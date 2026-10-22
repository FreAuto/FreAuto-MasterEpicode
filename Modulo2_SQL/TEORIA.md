# Risposte alle domande di teoria

## 1. Cosa si intende per database?

Un database è una raccolta di dati organizzata e strutturata, salvata in forma elettronica, in modo che i dati si
possano consultare, aggiornare e gestire facilmente. In un database relazionale i dati sono divisi in tabelle
collegate tra loro, così da evitare ripetizioni e mantenere le informazioni coerenti.

## 2. Cos'è un DBMS?

Il DBMS (Database Management System) è il software che crea e gestisce il database: memorizza i dati, esegue le
interrogazioni, controlla gli accessi e garantisce l'integrità dei dati. È l'intermediario tra l'utente e i dati.
Esempi: MySQL, SQL Server, PostgreSQL, Oracle.

## 3. Le clausole di una SELECT in ordine di esecuzione logica

L'ordine in cui SQL esegue le clausole è diverso dall'ordine in cui le scriviamo:

1. **FROM / JOIN**: sceglie le tabelle da cui leggere e le unisce;
2. **WHERE**: filtra le singole righe, prima di qualsiasi raggruppamento;
3. **GROUP BY**: raggruppa le righe che hanno gli stessi valori nelle colonne indicate;
4. **HAVING**: filtra i gruppi, di solito con una condizione su una funzione di aggregazione;
5. **SELECT**: sceglie le colonne da mostrare e calcola le espressioni e le aggregazioni;
6. **DISTINCT**: elimina le righe duplicate dal risultato;
7. **ORDER BY**: ordina il risultato;
8. **LIMIT / TOP**: limita il numero di righe restituite.

Per questo un alias definito nella SELECT si può usare in ORDER BY, ma non in WHERE.

## 4. Il GROUP BY con un esempio

Immagino di gestire una fumetteria e di avere la tabella delle vendite:

| Categoria | Quantità |
|---|---|
| Manga | 5 |
| Marvel | 3 |
| Manga | 4 |
| DC | 2 |
| Marvel | 1 |
| DC | 6 |

Voglio sapere quante copie ho venduto per ogni categoria:

```sql
SELECT Categoria, SUM(Quantità) AS CopieVendute
FROM Vendite
GROUP BY Categoria;
```

| Categoria | CopieVendute |
|---|---|
| Manga | 9 |
| Marvel | 4 |
| DC | 8 |

Il GROUP BY mette insieme le righe con la stessa categoria e su ogni gruppo applica la funzione di aggregazione
(qui `SUM`): da 6 righe di dettaglio ottengo 3 righe, una per categoria.

## 5. Differenza tra uno schema OLTP e uno schema OLAP

- **OLTP** (Online Transaction Processing) serve all'attività quotidiana: tante operazioni brevi di inserimento,
  modifica e lettura di singoli record (per esempio gli ordini di un negozio online). Lo schema è **normalizzato**,
  con molte tabelle, per evitare ridondanze e garantire l'integrità.
- **OLAP** (Online Analytical Processing) serve all'analisi di grandi volumi di dati storici. Lo schema è
  **denormalizzato**, di solito a stella (una tabella dei fatti e alcune tabelle delle dimensioni), per rendere più
  veloci le query di aggregazione.

## 6. Join e subquery: che differenza c'è nel risultato?

- Una **JOIN** affianca le colonne di più tabelle: nel risultato posso mostrare campi di tutte le tabelle coinvolte.
  Se a una riga ne corrispondono più di una, la riga si ripete.
- Una **subquery** usata come filtro (per esempio con `IN` o `EXISTS`) restituisce solo le colonne della query
  esterna e non duplica le righe.

```sql
-- JOIN: vedo il prodotto e anche i dati di ogni vendita
SELECT p.ProductName, s.OrderDate, s.Quantity
FROM Product p
JOIN Sales s ON s.ProductID = p.ProductID;

-- Subquery: vedo solo i prodotti venduti almeno una volta, ciascuno una volta sola
SELECT p.ProductName
FROM Product p
WHERE p.ProductID IN (SELECT ProductID FROM Sales);
```

## 7. Cosa si intende per DML e DDL?

- **DDL** (Data Definition Language): le istruzioni che definiscono la **struttura** del database, cioè tabelle,
  viste e vincoli: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`.
- **DML** (Data Manipulation Language): le istruzioni che lavorano sui **dati** contenuti nelle tabelle:
  `SELECT`, `INSERT`, `UPDATE`, `DELETE`.

## 8. Come si estrae l'anno da un campo data?

```sql
SELECT YEAR(OrderDate)              FROM Sales;   -- MySQL e SQL Server
SELECT EXTRACT(YEAR FROM OrderDate) FROM Sales;   -- standard SQL (MySQL, PostgreSQL)
SELECT DATEPART(YEAR, OrderDate)    FROM Sales;   -- SQL Server
SELECT DATE_FORMAT(OrderDate, '%Y') FROM Sales;   -- MySQL, restituisce un testo
```

## 9. Differenza tra AND e OR

- **AND** restituisce vero solo se **tutte** le condizioni sono vere: restringe il risultato.
- **OR** restituisce vero se **almeno una** condizione è vera: allarga il risultato.

```sql
WHERE Categoria = 'Manga' AND Prezzo > 10   -- solo i manga che costano più di 10 €
WHERE Categoria = 'Manga' OR  Prezzo > 10   -- tutti i manga e tutti gli articoli sopra i 10 €
```

## 10. Si può innestare una query nella clausola SELECT?

Sì. Una subquery nella SELECT deve restituire **un solo valore** (subquery scalare) per ogni riga.

```sql
SELECT p.ProductName,
       (SELECT SUM(s.Quantity) FROM Sales s WHERE s.ProductID = p.ProductID) AS TotaleVenduto
FROM Product p;
```

## 11. Differenza tra OR e IN

`IN` è un modo più compatto di scrivere più condizioni in `OR` **sulla stessa colonna**: il risultato è lo stesso.

```sql
WHERE StateName = 'Italy' OR StateName = 'Spain' OR StateName = 'Greece'
WHERE StateName IN ('Italy', 'Spain', 'Greece')
```

`OR` però può combinare condizioni su colonne diverse, mentre `IN` accetta anche una lista prodotta da una subquery.

## 12. BETWEEN include gli estremi?

Sì: `BETWEEN 10 AND 20` equivale a `>= 10 AND <= 20`.
Con le date bisogna fare attenzione: se il campo contiene anche l'ora, `BETWEEN '2025-01-01' AND '2025-12-31'`
esclude le vendite del 31 dicembre successive alla mezzanotte.
