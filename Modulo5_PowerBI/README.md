# 📊 Power BI: Olist, analisi di un e-commerce brasiliano

Esame finale del **Modulo 5 – Power BI** del Master Data Analyst di Epicode.

**Autore:** Francesco Autorino

> 📋 La traccia completa dell'esercizio è in [TRACCIA.md](TRACCIA.md).

## 🎯 La traccia

Olist Store è un e-commerce brasiliano che permette ai venditori di proporre i propri prodotti nei diversi mercati
del Brasile. Il dataset pubblico contiene gli ordini dal 2016 al 2018.

Il report doveva permettere di analizzare:

1. **gli ordini nel tempo**: conteggio mese per mese dell'anno scelto, confronto con l'anno precedente e variazione
   percentuale, con filtro per stato dell'ordine e per stato geografico del cliente;
2. **i ricavi nel tempo**: ricavo = prezzo + costo di spedizione, con lo stesso confronto con l'anno precedente;
3. **la distribuzione del rating** delle recensioni.

Best practice richieste: riduzione del dataset, **star schema**, **tabella calendario**, buon layout, buona UX
(pulsanti, drill-through) e analisi aggiuntive per prodotto e area geografica.

Tabelle usate: `olist_orders_dataset`, `olist_order_items_dataset`, `olist_products_dataset`,
`olist_order_reviews_dataset`, `olist_customers_dataset`.

## 🗂️ Le pagine del report

| Pagina | Contenuto |
|---|---|
| **Dashboard** | Panoramica: ricavi rispetto all'obiettivo, ricavi per mese, ordini per categoria, categoria principale |
| **Orders** | Ordini nel tempo, con filtri per anno e stato dell'ordine e un pulsante per azzerare i filtri |
| **Revenues** | Ricavi nel tempo, albero di scomposizione, metodi di pagamento, prezzo e spedizione per prodotto |
| **Rating** | Rating medio per categoria, ricavi per stato del cliente su mappa, rapporto tra giorni di consegna e voto |
| **Performance** | Ordini mensili dell'anno scelto contro l'anno precedente, variazione %, distribuzione del rating |
| **Category Detail** | Dettaglio della singola categoria: ricavi rispetto all'anno precedente e ricavi per stato |

## 📁 Il file

Il report (`.pbix`, circa 35 MB) è troppo pesante per GitHub, quindi l'ho caricato su Google Drive:

👉 [Apri il file Power BI su Google Drive](https://drive.google.com/file/d/1CDgPPHdYxWonD1tFYxjdxhn_Rq08V3r1/view?usp=share_link)

Per aprirlo serve **Power BI Desktop** (Windows).

[⬅️ Torna all'indice del Master](../README.md)
