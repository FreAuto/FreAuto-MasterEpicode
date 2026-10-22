# 🎤 Looker Studio: Sanremo 1951-2023, dal palco a Spotify

Esame finale del **Modulo 4 – Looker Studio** del Master Data Analyst di Epicode.

**Autore:** Francesco Autorino

👉 [Apri il report interattivo su Looker Studio](https://datastudio.google.com/reporting/9f07f90d-1d3a-4e99-b2c5-1d94ff14735b)

## 🎯 Il tema

La storia del Festival di Sanremo e l'eredità delle sue canzoni oggi su Spotify: 73 edizioni, i conduttori, le sedi,
i vincitori, la rappresentanza di genere tra i vincitori e la popolarità dei brani in streaming.

## 📁 File

| File | Contenuto |
|---|---|
| `Sanremo_Report.pdf` | Il report di Looker Studio esportato in PDF (6 pagine) |
| `unione_dati_sanremo.ipynb` | Il notebook Python con cui ho preparato i dati per il report |
| `Data/` | I tre file originali (Festival, Classifica, Spotify) e il dataset unito `dati-sanremo-uniti-completo.xlsx`, collegato a Looker Studio |

## 🛠️ La preparazione dei dati

Prima del report ho unito e pulito in Python le tre tabelle fornite (Festival, Classifica, Spotify):

1. **Pulizia della posizione in classifica**, che mescolava numeri e testo ("1º", "3º (ex aequo)", "F", "NF");
2. **Pulizia dei nomi** dei conduttori e calcolo del **decennio** di ogni edizione;
3. **Unione** di classifica ed edizioni;
4. **Unione con Spotify** sul titolo del brano: alcuni titoli si ripetono in edizioni diverse, quindi per ogni brano
   tengo il risultato Spotify con l'artista più simile all'interprete originale;
5. **Campi calcolati** per il racconto: presenza su Spotify, fascia di popolarità, anni tra il festival e l'ultima
   ripubblicazione del brano;
6. **Genere dei vincitori**, classificato a mano edizione per edizione, perché il dataset non lo contiene.

Il risultato è un file Excel caricato su Google Sheets e collegato a Looker Studio.

[⬅️ Torna all'indice del Master](../README.md)
