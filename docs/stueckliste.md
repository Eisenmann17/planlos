# Stückliste

Stand: November 2026. Das ist eine Planung, noch kein Programm.
Schlosserei-Begriffe wie Geländer oder Kilopreis gehören in die
Daten, nicht in den Code. Dieselbe Stückliste trägt später auch eine
andere Branche.

## Worum es geht

Im Angebot rechnet die Schlosserei oft in Kilogramm und Stunden.
Verkauft wird aber eine Einheit, zum Beispiel ein Meter Geländer.
Die Stückliste fasst die Einzelteile zu dieser einen Position zusammen.

Zwei Stellen:

- In den Stammdaten liegt die wiederverwendbare Stückliste, etwa
  „Geländer Standard“. Sie gehört zu einer Stücklistengruppe, so wie
  ein Artikel zu einer Artikelgruppe gehört.
- Im Beleg kann dieselbe Stückliste übernommen und nur für diese
  Position geändert werden. Eine neue Stückliste kann auch nur im
  Beleg entstehen, ohne vorher in den Stammdaten zu stehen.

## Wie es im alten Programm war

Quelle: `alt/MyOffice/MYOFFICE.SQL`, `UnitStueckListe.pas` und die
Übernahme in `UnitArtikelSammlung.pas`.

Drei Tabellen:

| Tabelle | Rolle |
| --- | --- |
| `stuecklistengruppe` | der Name der Gruppe, sonst nichts |
| `stueckliste` | der Kopf: Name, Gruppe als Text, EK, Aufschlag, Gewicht, vier Kostenarten |
| `stuecklistenartikel` | die Zeilen des Kopfes, verbunden über `Stuecklisten_Nr` |

Eine Zeile hat Menge, Einheit, EK, Aufschlag, VK, Gewicht, die
Berechnungsart als Text (vorn `Menge*EK_Preis`) und die Kostenart
`M`, `D`, `F` oder `S` (Material, Dienstleistung, Fremdleistung,
Sonstiges).

Auf dem Beleg gibt es zwei Tabellen:

- `artikelliste` ist die sichtbare Position. Das Feld `ArtikelArt`
  heißt dort `Stueckliste` oder `Freie Stueckliste`. Menge und
  Einheit dieser Zeile sind die Verkaufseinheit, also zum Beispiel
  1 und Meter.
- `artikellistes` sind die Unterzeilen dieser Position. Ihr Feld
  `Stuecklisten_Nr` zeigt auf die Nummer der Belegposition, nicht
  auf den Stamm.

Beim Aussuchen einer Stamm-Stückliste kopiert das alte Programm die
Zeilen aus `stuecklistenartikel` nach `artikellistes`. Es ist eine
Kopie. Eine Änderung im Beleg lässt den Stamm in Ruhe. Eine freie
Stückliste entsteht leer im Beleg und wird dort gefüllt.

## Kalkulation

Jede Unterzeile rechnet für sich. Fehlt die Formel, gilt
`Menge * EK`. Danach kommt der Aufschlag der Zeile dazu:
VK = Zwischenergebnis × (100 + Aufschlag) / 100.

Beispiel, in Cent gedacht, nicht in den alten Kommazahlen:

- 8,5 kg Flachstahl, EK 2,40 € je kg, Aufschlag 20 %
  ergibt 8,5 × 240 × 1,20 = 2448 Cent
- 0,5 Stunden Schweißen, EK 45 €, ohne Aufschlag
  ergibt 2250 Cent

Die Stückliste summiert die VK der Zeilen. Das Gewicht ist die Summe
aus Gewicht mal Menge. Die vier Kostenarten werden getrennt gesammelt,
damit man sieht, was Material und was Arbeit ist.

Der Verkaufspreis der Belegposition ist diese Summe. Die Menge der
Position bleibt die Verkaufseinheit: 1 m Geländer kostet die Summe,
nicht ein Kilogramm. Will man drei Meter, steht an der Position die
Menge 3, und der Einzelpreis ist der Preis für einen Meter.

Planlos rechnet dabei weiter in ganzen Cent und in Tausendsteln der
Menge, wie bei den Artikeln. Die Formel bleibt ein Text in den Daten.
Keine Schlosserei-Formel steht im Programm.

## Bedienung im Beleg

F2 im Positionsbereich hat dafür schon einen Platz:

- Artikel aus Stammdaten
- Stückliste aus Stammdaten
- Neue Stückliste
- Artikel ohne Vorgabe

„Stückliste aus Stammdaten“ öffnet die Liste der Stücklisten, gefiltert
nach Stücklistengruppe, und kopiert die gewählte in die Position.
„Neue Stückliste“ legt eine leere Stückliste nur an dieser Position an.
Solange das nicht gebaut ist, sagen diese beiden Punkte
„kommt mit der Stückliste“.

Die Unterzeilen bearbeitet man in einem kleinen Fenster an der
Position: Menge, EK, Aufschlag, Einheit. Die Summe schreibt den
Einzelpreis der Position neu.

## Druck

Gedruckt wird die Position als eine Zeile: Text, Verkaufsmenge,
Einheit, Einzelpreis, Gesamt. Die Unterzeilen sind die Kalkulation
und erscheinen im normalen Beleg nicht. Ein Schalter an der Vorlage
kann sie später darunter setzen. Das ist kein Muss für den ersten Bau.

## Umsetzung, der Reihe nach

1. Tabellen `stueckliste` und `stuecklistenposition` in den Stammdaten.
   Die Gruppe ist der vorhandene Nachschlagewert `stuecklistengruppe`.
2. Fenster dafür, analog zum Artikel: Gruppe, Name, Zeilen, Summe.
3. An der Belegposition ein Verweis auf eine Kopie der Zeilen, nicht
   auf den Stamm. Eigene Tabelle, zum Beispiel `belegstueckliste`.
4. Die beiden F2-Punkte füllen: Stamm auswählen und kopieren, oder
   leer anlegen.
5. Summe der Zeilen wird der Einzelpreis der Position. Menge und
   Einheit der Position bleiben die Verkaufseinheit.
6. Druck bleibt eine Zeile. Unterpositionen erst, wenn der Schalter
   in der Druckvorlage gebraucht wird.
