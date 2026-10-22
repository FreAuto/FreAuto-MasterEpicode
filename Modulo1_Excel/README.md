# 📗 Excel: gestione delle strutture ricettive delle Marche

Esame finale del **Modulo 1 – Excel** del Master Data Analyst di Epicode.

**Autore:** Francesco Autorino

> 📋 La traccia completa dell'esercizio è in [TRACCIA.md](TRACCIA.md).

## 🎯 La traccia

La Regione Marche chiede un sistema per consultare le strutture ricettive del territorio, a partire da due fonti:
l'elenco delle strutture (categoria, nome, indirizzo, città, contatti) e i prezzi medi per città.

## 🛠️ Cosa ho fatto

Il file `EsercizioFinaleExcel_StruttureMarche.xlsx` contiene:

| Foglio | Contenuto |
|---|---|
| `Traccia` | Il testo dell'esercizio |
| `StruttureRicettive` | L'elenco delle strutture (oltre 6.000 righe) |
| `Prezzi` | Il prezzo medio delle strutture per città |
| `Ricerca` | Una maschera di ricerca: scelgo il nome della struttura da un menù a tendina e ottengo città, indirizzo, email, sito web e categoria, più il numero di strutture della regione e della città cercata |
| `Pivot` | Una tabella pivot con il numero di strutture per categoria, filtrabile per città |

L'esercizio 3 (file `MODELLO DATI.xlsx` con Power Query e Power Pivot) non è incluso in questa cartella.

**Funzioni usate:** convalida dei dati (menù a tendina), `CERCA.VERT`, `SE.ERRORE`, `CONTA.VALORI`, `CONTA.SE`,
tabelle pivot.

[⬅️ Torna all'indice del Master](../README.md)
