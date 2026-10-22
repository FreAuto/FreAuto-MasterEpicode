# 😷🦠 Analisi Diffusione COVID-19

Esame finale del **Modulo 3 – Python (W12D4)** del Master Data Analyst di Epicode, incentrato sull'analisi dell'andamento della pandemia di COVID-19 a livello globale e su un focus specifico su alcune nazioni europee (Italia, Germania, Francia, Spagna).

L'analisi è sviluppata in **Jupyter Notebook** e si basa sul dataset ufficiale di **Our World in Data (OWID)**, scaricato direttamente dalla fonte ad ogni esecuzione.

**Autore:** Francesco Autorino

> 📋 La traccia originale dell'esercizio è in [TRACCIA.md](TRACCIA.md).

## 🎯 Obiettivi del progetto

Il notebook affronta i 5 punti richiesti dalla traccia, con l'aggiunta di un mini-extra personale:

1. **EDA e metadati**: dimensioni del dataset, tipi di dato, percentuale di valori mancanti per colonna, e distinzione tra righe-Paese (`continent` valorizzato) e righe-aggregato (continenti, gruppi di reddito, *World*).
2. **Casi per continente**: numero totale di casi dall'inizio della pandemia per ciascun continente e relativa percentuale sul totale mondiale, mostrati sia con un grafico a barre sia con un grafico a torta. Include un controllo di coerenza tra la somma dei casi sui 6 continenti e il totale ufficiale della riga `World` di OWID.
3. **Focus Italia 2022**: filtro dei giorni privi di una misurazione reale (`new_cases` nullo o pari a zero, dato che OWID registra i nuovi casi settimanalmente), con grafici sull'evoluzione dei casi totali e dei nuovi casi settimanali.
4. **Confronto terapie intensive (Italia, Germania, Francia)**: boxplot dei pazienti in ICU da maggio 2022 ad aprile 2023, con localizzazione temporale dei dati mancanti, una tabella statistica di sintesi (mediana, quartili, dev. standard), una verifica di robustezza sulla finestra comune priva del mese mancante alla Francia, e un richiamo al contesto demografico (i valori sono assoluti, non normalizzati per popolazione).
5. **Ricoveri 2021 (Italia, Germania, Francia, Spagna)**: somma dei pazienti ospedalizzati per nazione, gestione esplicita del missing rate del 100% della Germania (`sum(min_count=1)` per non confondere "dato mancante" con "zero pazienti"), e commento motivato sul perché non si è proceduto a un'imputazione dei dati.
6. **Mini-extra (oltre la traccia)**: calcolo del Case-Fatality Ratio (CFR) per le stesse quattro nazioni, con commento sui limiti dell'indicatore (dipendenza dalla capacità di testing di ciascun Paese).

## 🛠️ Librerie utilizzate

- **Pandas**: caricamento, pulizia, filtraggio e aggregazione dei dati
- **NumPy**: supporto per calcoli numerici
- **Matplotlib**: gestione dei layout e formattazione dei grafici
- **Seaborn**: grafici statistici (barplot, lineplot, boxplot) con palette coerenti

## 📊 Principali evidenze

- Asia ed Europa concentrano insieme oltre il 70% dei casi mondiali; l'Africa pesa molto meno del previsto, verosimilmente per una minore capacità di testing più che per una minore diffusione reale.
- In Italia, nel 2022, i nuovi casi settimanali mostrano un picco a inizio anno (ondata Omicron) seguito da un calo progressivo.
- Il confronto ICU (2022-2023) mostra una pressione ospedaliera nettamente maggiore in Germania rispetto a Italia e Francia.
- Sui ricoveri 2021, la Germania presenta dati interamente mancanti per `hosp_patients`: la scelta più corretta è escluderla esplicitamente dal confronto, anziché imputare un valore che rischierebbe di falsare l'analisi.

## 📁 File

- `EsameFinalePython_COVID19.ipynb`: il notebook con l'analisi completa
- `TRACCIA.md`: la traccia originale dell'esercizio
- `README.md`: questo file

[⬅️ Torna all'indice del Master](../README.md)
