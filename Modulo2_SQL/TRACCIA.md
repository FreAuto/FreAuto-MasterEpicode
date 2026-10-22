# Traccia dell'esercizio – Esame finale SQL

## Domande di teoria

1. Cosa si intende per database?
2. Cos'è un DBMS?
3. Indica le principali clausole di uno statement SELECT in ordine di esecuzione logica. Descrivi per ciascuna delle
   clausole indicate la logica di funzionamento.
4. Descrivi, immaginando uno scenario a te familiare, il concetto di GROUP BY. Utilizza l'approccio che ritieni più
   efficiente per trasmettere il concetto (suggerimento: disegna anche una sola tabella con poche colonne e pochi
   record e descrivi, basandoti sulla tabella stessa, un esempio di GROUP BY).
5. Descrivi la differenza tra uno schema OLTP e uno schema OLAP.
6. Dato un medesimo scenario di analisi, qual è la differenza in termini di risultato ottenibile tra una join e una
   subquery?
7. Cosa si intende per DML e DDL?
8. Quali istruzioni si possono utilizzare per estrarre l'anno da un campo data? Proponi degli esempi.
9. Qual è la differenza tra gli operatori logici AND e OR?
10. È possibile innestare una query nella clausola SELECT?
11. Qual è la differenza tra l'operatore logico OR e l'operatore logico IN?
12. L'operatore logico BETWEEN include anche gli estremi del range specificato?

## Case study

ToysGroup è un'azienda che distribuisce articoli (giocattoli) in diverse aree geografiche del mondo.
I prodotti sono classificati in categorie e i mercati di riferimento dell'azienda sono classificati in regioni di
vendita.

Le entità individuabili in questo scenario sono: **Product**, **Region**, **Sales**.

Relazioni tra le entità:

- **Product e Sales**: un prodotto può essere venduto tante volte (o nessuna), quindi è contenuto in una o più
  transazioni di vendita. Ciascuna transazione di vendita è riferita a un solo prodotto.
- **Region e Sales**: possono esserci molte o nessuna transazione per ciascuna regione. Ciascuna transazione di
  vendita è riferita a una sola regione.

Le entità Product e Region presentano delle gerarchie:

- un prodotto può appartenere a una sola categoria, mentre la stessa categoria può essere associata a molti prodotti
  diversi. Esempio: gli articoli "Bikes-100" e "Bikes-200" appartengono alla categoria Bikes; gli articoli
  "Bike Gloves M" e "Bike Gloves L" sono classificati come Clothing;
- più stati sono classificati in una stessa regione di vendita e una stessa regione include molti stati.
  Esempio: "France" e "Germany" sono nella regione WestEurope; "Italy" e "Greece" nella regione SouthEurope.

È necessario progettare e implementare fisicamente un database che modelli lo scenario garantendo l'integrità
referenziale e la minimizzazione della ridondanza dei dati.

### Task 1
Proponi una progettazione concettuale e logica della base dati. La progettazione concettuale deve includere tutte le
entità coinvolte e le relazioni tra queste; per ciascuna entità indica l'attributo chiave e i principali attributi
descrittivi. La progettazione logica deve includere, per ciascuna tabella, tutte le colonne che poi verranno
implementate fisicamente e deve esplicitare la cardinalità dei campi utilizzati per definire la relazione.

### Task 2
Descrivi la struttura delle tabelle che reputi utili e sufficienti a modellare lo scenario proposto tramite la
sintassi DDL. Implementa fisicamente le tabelle utilizzando il DBMS SQL Server (o altro).

### Task 3
Popola le tabelle utilizzando dati a tua discrezione (sono sufficienti pochi record per tabella; riporta le query
utilizzate).

### Task 4
Dopo aver popolato le tabelle, scrivi delle query utili a:

1. verificare che i campi definiti come PK siano univoci (una query per tabella implementata);
2. esporre l'elenco delle transazioni indicando nel result set il codice documento, la data, il nome del prodotto,
   la categoria del prodotto, il nome dello stato, il nome della regione di vendita e un campo booleano valorizzato
   in base alla condizione che siano passati più di 180 giorni dalla data vendita o meno
   (> 180 → True, <= 180 → False);
3. esporre l'elenco dei prodotti che hanno venduto, in totale, una quantità maggiore della media delle vendite
   realizzate nell'ultimo anno censito (ogni valore della condizione deve risultare da una query e non deve essere
   inserito a mano). Nel result set devono comparire solo il codice prodotto e il totale venduto;
4. esporre l'elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno;
5. esporre il fatturato totale per stato per anno, ordinando il risultato per data e per fatturato decrescente;
6. rispondere alla domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?
7. rispondere alla domanda: quali sono i prodotti invenduti? Proponi due approcci risolutivi differenti;
8. creare una vista sui prodotti in modo tale da esporre una "versione denormalizzata" delle informazioni utili
   (codice prodotto, nome prodotto, nome categoria);
9. creare una vista per le informazioni geografiche.
