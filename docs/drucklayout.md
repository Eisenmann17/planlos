# Drucklayout

Stand: November 2026. Die Schritte 1 bis 5 sind umgesetzt: die Spalte
`layout`, der Druck daraus, das Fenster im Reiter Druck, die Vorschau
und Export und Import. Logo und andere Schriften (Schritt 6) fehlen
noch. Ein ungültiges Layout druckt weiter in der bisherigen Anordnung.

## Was heute gedruckt wird

`udruck` schreibt das PDF mit fpPDF. Die Belegart zeigt über
`modulart.druckvorlage_id` auf eine Zeile in `druckvorlage`. Die
mitgelieferte Zeile heißt `standard`. Sie speichert den Absender, die
Fußzeile und fünf Maße in Millimetern: linker Rand 25, rechter Rand 20,
Anschrift ab 45, Text ab 105, unterer Rand 20. Das ist DIN 5008 Form A.
Alles andere, also welche Zeile wo steht, welche Spalten die Tabelle
hat und wie die Summen heißen, steht fest im Programm.

Im Einstellungsfenster der Belegart, Reiter Druck, wählt man nur diese
Vorlage aus. Gestalten kann man sie dort nicht.

## Was das alte Programm gemacht hat

`einstellungmodulart` hat auf Druckmasken verwiesen
(`Druckermaske1` bis `Druckermaske6`). Die Maske selbst lag in
`einstellungdrucken`, eine Zeile je Belegart und Benutzer.
`UnitEinstellungenDrucken` hat daraus Panels gebaut, die man mit der
Maus gezogen hat. Jedes Feld war eine Zeichenkette, ungefähr

`sichtbar;Name;x;y;Breite;Ausrichtung;Schrift;Farbe;Größe;Stil;Rahmen;0;Höhe`.

Zwanzig solcher Ketten hießen `Feld1` bis `Feld20` und waren die
Spalten der Positionstabelle. Absender, Anschrift, Datum, Summen und
Fußzeile hatten zusätzlich je eine eigene Spalte. Dieselbe Packweise
steckte in `monitormaske1` bis `monitormaske20` für den Bildschirm.

Das wollen wir nicht wiederholen. Die Ketten sind schwer zu lesen, ein
neues Feld war eine neue Spalte, und die Vorlage hing am Benutzer.

## Vorschlag

Eine Vorlage beschreibt eine A4-Seite. Acht Bereiche, in dieser
Reihenfolge:

| Bereich | Lage | Inhalt |
| --- | --- | --- |
| Firmenkopf | fest | Absenderzeile über der Anschrift |
| Anschrift | fest | Adressblock, DIN-5008-Fenster |
| Belegkopf | fest | Art, Nummer, Datum, Bearbeiter, Ihr Zeichen |
| Kopftext | fließend | Titel, Bezeichnung, Kopftext |
| Positionstabelle | fließend | Spalten mit Beschriftung und Breite |
| Summen | fließend | Netto, MwSt je Satz, Brutto |
| Fußtext | fließend | Text unter den Summen |
| Fußzeile | fest | Seitenzahl und Fußzeile, auf jeder Seite |

Fest heißt: das Feld hat eine Position in Millimetern, gemessen von
der linken und von der oberen Blattkante. Fließend heißt: der Bereich
beginnt an einem Anker und wächst mit dem Text nach unten. Ein langer
Kopftext schiebt die Tabelle, die Tabelle schiebt die Summen. Der
Seitenumbruch und die Zeile „Übertrag“ bleiben im Programm. Sie sind
kein Feld, das man auf der Seite ablegt.

Jedes Feld hat: Name, sichtbar ja oder nein, Position und Größe in
Millimetern, Schrift, Schriftgröße, fett, Ausrichtung (links, rechts,
mitte), Beschriftung und eine Datenquelle. Die Beschriftung ist der
feste Text davor, zum Beispiel `Nr. `. Die Quelle ist der Wert aus dem
Beleg. Quelle `text` druckt nur die Beschriftung.

Die Positionstabelle hat keine einzelnen Felder, sondern Spalten.
Sichtbar, Beschriftung, Breite, Ausrichtung, Quelle. Die Breiten der
sichtbaren Spalten dürfen zusammen nicht breiter sein als die Seite
abzüglich der beiden Seitenränder. In der Standardvorlage sind das
165 mm.

Die Schrift der ersten Stufe ist Helvetica, fett oder nicht. fpPDF
bringt sie mit, es ist keine Schriftdatei nötig. Farbe bleibt schwarz.
Logo, Rahmen und eine frei gewählte Schrift hatte das alte Fenster.
Das heben wir auf, bis der Rest steht.

### Wohin mit dem Layout

Drei Möglichkeiten:

Eine eigene JSON-Datei liegt neben der Datenbank. Sie lässt sich leicht
verschicken. Die Belegart zeigt aber auf eine Zeile, nicht auf eine
Datei. Datei und Zeile laufen auseinander, sobald jemand nur eines von
beiden ändert. Auf einem zweiten Rechner fehlt die Datei leicht.

Eine breite Tabelle, ein Feld je Spalte, ist das alte
`einstellungdrucken`. Jede neue Quelle wäre eine Schemaänderung, und
die gepackten Ketten will das Konzept in `docs/KONZEPT.md` gerade nicht
wiederhaben.

Die Empfehlung ist eine Textspalte `layout` an der bestehenden Tabelle
`druckvorlage`. Die Belegart behält `druckvorlage_id`. Mehrere
Belegarten können dieselbe Vorlage nutzen, so wie heute alle auf
`standard` zeigen. Der Text ist JSON mit einem Feld `version`. Zum
Austausch zwischen Installationen kopiert man diesen Text, als Datei
oder später als Export der Zeile. Die Datei ist nur der Umschlag. Die
Zeile bleibt die Quelle, auch wenn die Datenbank später PostgreSQL ist.

Die Zahlen-Spalten für die Ränder bleiben. Sie sind der grobe Fallback
und das, was die Belegart heute schon kennt.

### Version und Fallback

`version` ist 1. Ein leerer Text, ungültiges JSON, eine andere Version
oder ein Layout, das die Prüfung ablehnt, druckt wie heute: die Maße
aus der Zeile und der feste Aufbau in `udruck`. Der Anwender sieht
dann einen kurzen Hinweis, der Druck bricht nicht ab. Die mitgelieferte
Vorlage `standard` ist derselbe Aufbau noch einmal als Daten, damit der
spätere Editor etwas zum Ändern hat.

Ändert jemand die Zeile `standard`, ändert das jede Belegart, die
darauf zeigt. Der Editor soll deshalb anbieten, die Vorlage zu kopieren
und nur die eine Belegart auf die Kopie zeigen zu lassen.

## Datenmodell

Die Typen stehen in `src/udrucklayout.pas`. Ein Layout hat Version,
Seite, drei Ränder, die zwei DIN-Anker `anschrift_oben` und
`text_oben`, die Bereiche und die Spalten. `LayoutStandard` baut die
Vorlage, die dem heutigen PDF entspricht. `LayoutPruefen` lehnt eine
fremde Version, ein Blatt außer A4, Ränder außerhalb der Seite, eine
unbekannte Quelle, eine Schriftgröße außer 6 bis 24 und Spalten ab, die
nicht in den Textbereich passen. `LayoutAlsJson` und `LayoutAusJson`
schreiben und lesen den Text. `LayoutSpeichern` und `LayoutLaden` tun
dasselbe mit einer Datei, für den späteren Austausch. `LayoutMitFallback`
nimmt bei leerem oder ungültigem Text die Standardvorlage.

Die Unit hängt nicht am Fenster und nicht an `udruck`. Die Prüfung
läuft in `schema_pruefen` mit.

Quellen, die Version 1 kennt:

`text`, `firma.absender`, `firma.fusszeile`, `beleg.art`,
`beleg.nummer`, `beleg.datum`, `beleg.bearbeiter`, `beleg.ihr_zeichen`,
`beleg.bezeichnung`, `beleg.adresse`, `beleg.kopftext`,
`beleg.fusstext`, `beleg.titel`, `beleg.seite`, `summe.netto`,
`summe.mwst`, `summe.brutto`, `position.pos`, `position.text`,
`position.menge`, `position.einheit`, `position.einzel`,
`position.mwst`, `position.gesamt`.

`beleg.titel` ist Art und Nummer in einer Zeile, so wie der Druck sie
heute über die Tabelle setzt. `beleg.seite` füllt das Programm je
Blatt. `summe.mwst` wiederholt sich je Steuersatz. `beleg.datum` bleibt
im Beleg ein ISO-Datum und wird beim Druck deutsch geschrieben.

y in einem fließenden Feld ist 0. Gezählt wird dort die Reihenfolge,
nicht die millimetergenaue Zeile. Höhe 0 heißt: der Text darf mehrere
Zeilen haben.

### Beispiel, Vorlage standard

Das ist die Ausgabe von `LayoutAlsJson(LayoutStandard)`.

```json
{
  "version" : 1,
  "seite" : "A4",
  "rand" : {
    "links" : 25,
    "rechts" : 20,
    "unten" : 20
  },
  "anschrift_oben" : 45,
  "text_oben" : 105,
  "bereiche" : [
    {
      "id" : "firmenkopf",
      "anker" : "fest",
      "sichtbar" : true,
      "y" : 45,
      "felder" : [
        {
          "id" : "absender",
          "sichtbar" : true,
          "x" : 25,
          "y" : 45,
          "breite" : 80,
          "hoehe" : 4,
          "schrift" : "Helvetica",
          "groesse" : 7,
          "fett" : false,
          "ausrichtung" : "links",
          "beschriftung" : "",
          "quelle" : "firma.absender"
        }
      ]
    },
    {
      "id" : "anschrift",
      "anker" : "fest",
      "sichtbar" : true,
      "y" : 51,
      "felder" : [
        {
          "id" : "adresse",
          "sichtbar" : true,
          "x" : 25,
          "y" : 51,
          "breite" : 80,
          "hoehe" : 40,
          "schrift" : "Helvetica",
          "groesse" : 11,
          "fett" : false,
          "ausrichtung" : "links",
          "beschriftung" : "",
          "quelle" : "beleg.adresse"
        }
      ]
    },
    {
      "id" : "belegkopf",
      "anker" : "fest",
      "sichtbar" : true,
      "y" : 45,
      "felder" : [
        {
          "id" : "art",
          "sichtbar" : true,
          "x" : 125,
          "y" : 45,
          "breite" : 65,
          "hoehe" : 6,
          "schrift" : "Helvetica",
          "groesse" : 11,
          "fett" : true,
          "ausrichtung" : "links",
          "beschriftung" : "",
          "quelle" : "beleg.art"
        },
        {
          "id" : "nummer",
          "sichtbar" : true,
          "x" : 125,
          "y" : 51,
          "breite" : 65,
          "hoehe" : 5,
          "schrift" : "Helvetica",
          "groesse" : 10,
          "fett" : false,
          "ausrichtung" : "links",
          "beschriftung" : "Nr. ",
          "quelle" : "beleg.nummer"
        },
        {
          "id" : "datum",
          "sichtbar" : true,
          "x" : 125,
          "y" : 56,
          "breite" : 65,
          "hoehe" : 5,
          "schrift" : "Helvetica",
          "groesse" : 10,
          "fett" : false,
          "ausrichtung" : "links",
          "beschriftung" : "Datum ",
          "quelle" : "beleg.datum"
        },
        {
          "id" : "bearbeiter",
          "sichtbar" : true,
          "x" : 125,
          "y" : 61,
          "breite" : 65,
          "hoehe" : 5,
          "schrift" : "Helvetica",
          "groesse" : 10,
          "fett" : false,
          "ausrichtung" : "links",
          "beschriftung" : "Bearbeiter ",
          "quelle" : "beleg.bearbeiter"
        },
        {
          "id" : "ihr_zeichen",
          "sichtbar" : true,
          "x" : 125,
          "y" : 66,
          "breite" : 65,
          "hoehe" : 5,
          "schrift" : "Helvetica",
          "groesse" : 10,
          "fett" : false,
          "ausrichtung" : "links",
          "beschriftung" : "Ihr Zeichen ",
          "quelle" : "beleg.ihr_zeichen"
        }
      ]
    },
    {
      "id" : "kopftext",
      "anker" : "fluss",
      "sichtbar" : true,
      "y" : 97,
      "felder" : [
        {
          "id" : "titel",
          "sichtbar" : true,
          "x" : 25,
          "y" : 0,
          "breite" : 165,
          "hoehe" : 8,
          "schrift" : "Helvetica",
          "groesse" : 14,
          "fett" : true,
          "ausrichtung" : "links",
          "beschriftung" : "",
          "quelle" : "beleg.titel"
        },
        {
          "id" : "bezeichnung",
          "sichtbar" : true,
          "x" : 25,
          "y" : 0,
          "breite" : 165,
          "hoehe" : 5,
          "schrift" : "Helvetica",
          "groesse" : 11,
          "fett" : false,
          "ausrichtung" : "links",
          "beschriftung" : "",
          "quelle" : "beleg.bezeichnung"
        },
        {
          "id" : "kopftext",
          "sichtbar" : true,
          "x" : 25,
          "y" : 0,
          "breite" : 165,
          "hoehe" : 0,
          "schrift" : "Helvetica",
          "groesse" : 10,
          "fett" : false,
          "ausrichtung" : "links",
          "beschriftung" : "",
          "quelle" : "beleg.kopftext"
        }
      ]
    },
    {
      "id" : "positionen",
      "anker" : "fluss",
      "sichtbar" : true,
      "y" : 105,
      "felder" : [
      ]
    },
    {
      "id" : "summen",
      "anker" : "fluss",
      "sichtbar" : true,
      "y" : 0,
      "felder" : [
        {
          "id" : "netto",
          "sichtbar" : true,
          "x" : 25,
          "y" : 0,
          "breite" : 165,
          "hoehe" : 5,
          "schrift" : "Helvetica",
          "groesse" : 10,
          "fett" : false,
          "ausrichtung" : "rechts",
          "beschriftung" : "Netto ",
          "quelle" : "summe.netto"
        },
        {
          "id" : "mwst",
          "sichtbar" : true,
          "x" : 25,
          "y" : 0,
          "breite" : 165,
          "hoehe" : 5,
          "schrift" : "Helvetica",
          "groesse" : 10,
          "fett" : false,
          "ausrichtung" : "rechts",
          "beschriftung" : "MwSt ",
          "quelle" : "summe.mwst"
        },
        {
          "id" : "brutto",
          "sichtbar" : true,
          "x" : 25,
          "y" : 0,
          "breite" : 165,
          "hoehe" : 6,
          "schrift" : "Helvetica",
          "groesse" : 11,
          "fett" : true,
          "ausrichtung" : "rechts",
          "beschriftung" : "Brutto ",
          "quelle" : "summe.brutto"
        }
      ]
    },
    {
      "id" : "fusstext",
      "anker" : "fluss",
      "sichtbar" : true,
      "y" : 0,
      "felder" : [
        {
          "id" : "fusstext",
          "sichtbar" : true,
          "x" : 25,
          "y" : 0,
          "breite" : 165,
          "hoehe" : 0,
          "schrift" : "Helvetica",
          "groesse" : 10,
          "fett" : false,
          "ausrichtung" : "links",
          "beschriftung" : "",
          "quelle" : "beleg.fusstext"
        }
      ]
    },
    {
      "id" : "fusszeile",
      "anker" : "fest",
      "sichtbar" : true,
      "y" : 283,
      "felder" : [
        {
          "id" : "seite",
          "sichtbar" : true,
          "x" : 25,
          "y" : 283,
          "breite" : 35,
          "hoehe" : 4,
          "schrift" : "Helvetica",
          "groesse" : 8,
          "fett" : false,
          "ausrichtung" : "links",
          "beschriftung" : "Seite ",
          "quelle" : "beleg.seite"
        },
        {
          "id" : "fuss",
          "sichtbar" : true,
          "x" : 65,
          "y" : 283,
          "breite" : 125,
          "hoehe" : 4,
          "schrift" : "Helvetica",
          "groesse" : 8,
          "fett" : false,
          "ausrichtung" : "links",
          "beschriftung" : "",
          "quelle" : "firma.fusszeile"
        }
      ]
    }
  ],
  "spalten" : [
    {
      "id" : "pos",
      "sichtbar" : true,
      "beschriftung" : "Pos",
      "breite" : 12,
      "ausrichtung" : "links",
      "quelle" : "position.pos"
    },
    {
      "id" : "beschreibung",
      "sichtbar" : true,
      "beschriftung" : "Beschreibung",
      "breite" : 58,
      "ausrichtung" : "links",
      "quelle" : "position.text"
    },
    {
      "id" : "menge",
      "sichtbar" : true,
      "beschriftung" : "Menge",
      "breite" : 22,
      "ausrichtung" : "rechts",
      "quelle" : "position.menge"
    },
    {
      "id" : "einheit",
      "sichtbar" : true,
      "beschriftung" : "Einh.",
      "breite" : 18,
      "ausrichtung" : "links",
      "quelle" : "position.einheit"
    },
    {
      "id" : "einzel",
      "sichtbar" : true,
      "beschriftung" : "Einzel",
      "breite" : 22,
      "ausrichtung" : "rechts",
      "quelle" : "position.einzel"
    },
    {
      "id" : "mwst",
      "sichtbar" : true,
      "beschriftung" : "MwSt",
      "breite" : 16,
      "ausrichtung" : "rechts",
      "quelle" : "position.mwst"
    },
    {
      "id" : "gesamt",
      "sichtbar" : true,
      "beschriftung" : "Gesamt",
      "breite" : 17,
      "ausrichtung" : "rechts",
      "quelle" : "position.gesamt"
    }
  ]
}
```

Die Spaltenbreiten sind an die Abstände in `udruck` angelehnt und so
gelegt, dass sie die 165 mm ausfüllen, ohne sich zu überlappen.

## Editor

Ein eigenes Fenster, kein weiterer Reiter in der Belegart. Der Knopf
sitzt im Reiter Druck neben der Vorlagenauswahl und heißt Layout.

Links die acht Bereiche, aufklappbar, darunter die Felder. Rechts eine
A4-Seite, klein genug für das Fenster, mit den festen Feldern als
Rahmen. Ein festes Feld zieht man mit der Maus. Die Pfeiltasten
rücken es um einen Millimeter. Fließende Bereiche zieht man nur als
Streifen an ihrem Anker, die Zeilen darin bleiben in der Liste.

Zum markierten Feld: sichtbar, Beschriftung, Quelle aus der festen
Liste, Schriftgröße, fett, Ausrichtung. Kein freies Tippen einer
Quelle, sonst landet ein Tippfehler erst beim Druck.

Die Spalten sind eine eigene Liste: sichtbar, Beschriftung, Breite,
Reihenfolge. Die Summe der Breiten steht daneben und wird rot, wenn
sie 165 mm überschreitet. Speichern geht dann nicht.

Unten die gewohnte Leiste. ESC verwirft, F10 speichert. Ein Knopf
Vorschau schreibt ein PDF mit dem Layout und ein paar Beispielzeilen
und öffnet es. Solange die Vorlage `standard` ist und noch eine andere
Belegart darauf zeigt, fragt F10, ob eine Kopie angelegt werden soll.

Das Fenster ersetzt `UnitEinstellungenDrucken` nicht Feld für Feld. Es
gibt die acht Bereiche und die Spalten, nicht zwanzig gepackte Ketten
und kein Logo.

## Nächste Schritte

Die Größe meint den Umfang, nicht einen Termin.

1. Klein. Spalte `layout` an `druckvorlage`, die Standardvorlage als
   JSON in die Zeile `standard` schreiben, Schemaversion erhöhen. Der
   Druck liest sie noch nicht. Leerer Text bleibt erlaubt.
2. Mittel. `udruck` zeichnet aus dem Layout. Seitenumbruch und Übertrag
   bleiben, wo sie sind. Ungültiges Layout fällt auf den heutigen
   Aufbau zurück. Danach muss ein Angebot mit dem neuen Text genauso
   aussehen wie heute.
3. Mittel. Das Editorfenster aus dem Reiter Druck: verschieben,
   ein- und ausblenden, Beschriftung, Spalten. Speichern in die
   Spalte, inklusive der Nachfrage zur Kopie.
4. Klein. Der Knopf Vorschau, sobald Schritt 2 steht.
5. Klein. Den JSON-Text exportieren und in einer anderen Installation
   als neue Vorlage einlesen. Die Belegart zeigt danach auf diese
   Zeile.
6. Später. Logo, Rahmen, andere Schriften. Erst wenn 2 bis 4 stehen.
