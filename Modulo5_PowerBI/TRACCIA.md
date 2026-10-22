# Traccia dell'esercizio – Esame finale Power BI

## Scenario

Olist Store è un sito di e-commerce brasiliano per seller (venditori).
La piattaforma consente ai seller di proporre i propri prodotti ai diversi mercati brasiliani.
Il dataset pubblico (e anonimizzato) espone gli ordini di vendita dal 2016 al 2018 e consente di quantificarli,
misurarli e analizzarli rispetto a dimensioni di analisi diverse: cliente, prodotto, metodi di pagamento, status
dell'ordine, …

## Obiettivi di analisi

È necessario sviluppare un report di BI che consenta di analizzare:

1. l'andamento degli ordini nel tempo per stato*;
2. l'andamento dei ricavi nel tempo per stato**;
3. la distribuzione del rating***.

**Tip**

\* L'utente, dato un particolare anno selezionato, vorrebbe poter visualizzare il conteggio degli ordini mese per
mese. Inoltre, vorrebbe poter confrontare i risultati con quelli dell'anno precedente e, rispetto a questi,
visualizzare la variazione percentuale mese per mese. È fondamentale poter filtrare rispetto allo status dell'ordine.
- Il campo da considerare per la metrica è `olist_order_items_dataset|order_item_id`.
- Per i dati geografici bisogna fare riferimento al campo `olist_customers_dataset|customer_state`.
- Per applicare il filtro sullo status degli ordini utilizza il campo `olist_orders_dataset|order_status`.

\*\* L'utente, dato un particolare anno selezionato, vorrebbe poter visualizzare i ricavi totali mese per mese.
Inoltre, vorrebbe poter confrontare i risultati con quelli dell'anno precedente e, rispetto a questi, visualizzare la
variazione percentuale mese per mese. È fondamentale poter filtrare rispetto allo status dell'ordine.
- Per calcolare il ricavo della singola transazione è necessario considerare la somma di
  `olist_order_items_dataset|price` e `olist_order_items_dataset|freight_value`, cioè la somma del prezzo di vendita
  e del costo di spedizione/consegna.

\*\*\* Utilizza il campo `olist_order_reviews_dataset|review_score`.

## Best practice da applicare

- Riduci il volume del dataset
- Ristruttura i dati grezzi in modo tale da ottenere uno star schema
- Utilizza una dimensione calendario
- Progetta un buon layout
- Progetta una buona UX (bottoni, drill-through per esporre maggiori livelli di dettaglio rispetto a certe aggregazioni…)
- Arricchisci il report anche di altre analisi: distribuzione del rating (tabella `olist_order_reviews_dataset`),
  analisi per prodotto e/o per area geografica

## Tabelle necessarie

- `olist_orders_dataset`
- `olist_order_items_dataset`
- `olist_products_dataset`
- `olist_order_reviews_dataset`
- `olist_customers_dataset`

Nota bene: viene fornita l'estrazione dati completa, qualora si voglia approfondire lo scenario proposto.
