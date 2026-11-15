# Konzept für Planlos

Stand: November 2026, zum Grundgerüst.

Dieses Blatt hält fest, was am alten „Mein kleines Büro“ (Ordner
`alt/MyOffice/`) die tragende Idee war, wie die alten Tabellen gebaut
sind, und wie das neue Programm dieselben Aufgaben mit weniger
Sonderfällen lösen soll. Es ist die Arbeitsgrundlage für die nächsten
Ausbaustufen, kein Pflichtenheft bis zur letzten Spalte.

## Die Idee, die bleibt

Es gibt ein Belegfenster. Ob der Beleg ein Angebot, eine
Auftragsbestätigung, eine Bestellung oder eine Rechnung ist, steht in
einem Datensatz der Tabelle für die Belegart, nicht in einer eigenen
Unit.

Dieselbe Denkweise gilt für Listen. Das alte `TempForm.pas` ist ein
einziges Such- und Listenfenster. Was es anzeigt, kommt aus
`einstellungform1`: Tabelle, Spalten, Filter, Sortierung, Fenstergröße
und welche Funktionstasten an sind. So wurde aus derselben Form mal
„Kunde aussuchen“, mal „Mitarbeiter“ und mal „Artikel“.

Neu soll es zwei generische Fenster geben, beide über Datensätze
gesteuert:

- ein Suchfenster
- ein Eingabefenster

Damit ist auch eine vom Benutzer angelegte Maske möglich, zum Beispiel
„Arbeitsschuhe der Mitarbeiter“, ohne eine neue Unit.

Der Ablauf, den die Masken tragen müssen: Angebot neu, Kunde suchen,
wenn keiner passt Kunde neu, zurück ins Angebot, danach Kontakt suchen
oder neu anlegen.

## Die alten 22 Tabellen

Quelle: `alt/MyOffice/MYOFFICE.SQL`, MySQL 4, Tabellentyp MyISAM.
Zugriff im Programm über Zeos (`TZConnection`, Protokoll `mysql-4.0`,
Einstellungen in `DB.INI`).

| Tabelle | Rolle |
| --- | --- |
| `einstellungmodulart` | eine Belegart: Aussehen, Tasten, Rechte, Filter |
| `module` | der Beleg selbst (Angebot, Projekt, …) |
| `artikelliste` | Positionen eines Belegs |
| `artikellistes` | Positionen, die aus einer Stückliste stammen |
| `artikellistetemp` | dieselben Spalten noch einmal, als Zwischenlager |
| `adressen` | Kunde, Lieferant, Mitarbeiter, Privat in einer Tabelle |
| `kategorie` | die vier Adressarten als Text |
| `artikel` | Artikelstamm |
| `artikelgruppe` | Gruppe, und zugleich welche Artikelfelder sichtbar sind |
| `einheit` | Meter, Stunden, Stück, Sortiment |
| `berechnungsart` | Formel als Text, zum Beispiel `Menge*EK_Preis` |
| `stueckliste`, `stuecklistenartikel`, `stuecklistengruppe` | Stücklisten |
| `benutzer` | Name, Passwort, ein paar Projektrechte |
| `einstellungform1` | das generische Listenfenster |
| `einstellungdrucken` | Druckbild, Felder als gepackte Zeichenketten |
| `einstellungenallgemein` | eine Zeile Firma: MwSt, Namen der freien Zahlenfelder |
| `textbaustein` | Kopf- und Fußtexte je Belegart |
| `nummer` | welcher Beleg auf welchen Hauptbeleg folgt, für Nummern |
| `fensterdesign` | Farben und ob Fenster kaskadiert öffnen |
| `gruppierung` | freie Gruppenbezeichnung an Belegen |

Fast jede Tabelle hat eine Spalte `ReadOnly`. Eine `1` sperrt den Satz.

### einstellungmodulart

Das ist der Kern. Eine Zeile beschreibt eine Belegart für einen Benutzer.
Im mitgelieferten Bestand gibt es eine Zeile: Modulart `Angebot`,
Benutzer `Standard`. Weitere Arten (Auftrag, Bestellung) waren vorgesehen,
im Auszug aber nicht gefüllt. Das Hauptfenster liest alle Zeilen und
baut daraus die Knöpfe (`UnitModule.pas`).

Die Spalten vermischen mehrere Themen in einer sehr breiten Zeile:

1. **Identität.** `Modulart`, `Benutzer`, `Beschreibung`. Der Benutzername
   steht als Text, nicht als Nummer.
2. **Fenster.** `FensterTop`, `FensterLeft`, `FensterWidth`, `FensterHoehe`,
   Mindest- und Höchstbreite, und Schalter für die Bereiche:
   `FensterInternAn`, `FensterKopfAn`, `FensterSummeAn`, `FensterFussAn`,
   `FensterButtonAn`.
3. **Rechte am Datensatz und am Modul.** `DatensatzNeu`, `DatensatzAendern`,
   `Datensatzloeschen`, `DatensatzKopieren`, `DatensatzSpeichern`,
   `DatensatzAusgabe`, `Datensatzsuchen`, dazu `Modulneu`, `Modulaendern`,
   `Modulloeschen`, `Modulkopieren`. Eine `1` heißt erlaubt.
   Das Hauptfenster schaltet damit die Knöpfe.
4. **Welche Felder man sieht.** Eigene Schalter für Projekt, Adresse,
   Bezeichnung, Gruppierung, Notiz, Adressfeld, Datum, Bearbeiter,
   Transaktionsnummer, „Ihr Zeichen“, Kopftext, Fußtext.
5. **Beziehung zum vorherigen Beleg.** `Beziehungs_Nr`, `Beziehungs_Name`,
   `HauptModulNr`, `HauptModulName`. Dazu die Tabelle `nummer` mit
   Hauptmodul und Nebenmodul. So weiß das Programm, dass aus einem
   Angebot eine nächste Belegart werden kann.
6. **Artikelsuche im Beleg.** Acht Filter für Artikel (`AASQLFilterArtikel1`
   bis `8`), acht für Gruppen, acht Beschriftungen (`AACaption1` bis `8`),
   acht Schalter für F2 bis F9 (`AAEnaF2` bis `AAEnaF9`). Die Filter sind
   SQL-Bruchstücke.
7. **Darstellung der Positionen.** Zwanzig Spalten `monitormaske1` bis
   `monitormaske20`. Jede Zelle ist ein Strichpunkt-Text aus Sichtbarkeit,
   Feldname, Position, Breite, Schrift und Farbe. Sechs weitere Felder
   verweisen auf Druckmasken.

Dazu kommen Farben für den Zeilenwechsel, ein Schalter `Lagerverwaltung`
und ein eigener `MwSt`-Satz je Belegart. Der allgemeine Satz liegt
außerdem in `einstellungenallgemein` (im Auszug 16, der Satz jener Jahre).

### module

Ein Beleg ist eine Zeile in `module`.

Wichtige Spalten: `Bezeichnung`, `Projekt_Nr`, `Adress_Nr`, `Modul_Nr`
(Verweis auf einen anderen Beleg), `Modulart` als Text und `Modulart_Nr`,
`Erfassungsdatum`, `LetzteBearbeitung`, `Bearbeiter` als Text,
`Gruppierung` als Text, `Projektname` und `Adressname` als Kopie des
Namens, `Notiz`, `Kopftext`, `Fusstext`, `Adresse` als Textblock,
`IhrZeichen`, `BMPLogo`.

`Adress_Nr` ist eine echte Nummer. Daneben steht der Name noch einmal
als Text. Das ist für einen gedruckten Beleg richtig, weil der Name
sich später ändern kann. Für die Stammdaten ist die doppelte Textkopie
(`Modulart` und `Modulart_Nr` gleichzeitig) die Stelle, an der die Daten
auseinanderlaufen, sobald jemand eine Belegart umbenennt.

### adressen

Eine Tabelle für alle Personen und Firmen. Die Spalte `Kategorie` ist
Text (`Kunde`, `Mitarbeiter`, `Privat`, `Lieferant` im Auszug). Weitere
Felder: Name, Titel, Firma, vier Telefonfelder, E-Mail, Straße, PLZ, Ort,
Land, Notiz, ein zusammengesetzter Adressblock, `Frei1` bis `Frei4`,
`Rabatt`. Es gibt eine Leerzeile mit `Nr` 0, damit Verweise auf „keine
Adresse“ eine Nummer haben.

Die Kategorie steuert die Suche. In `einstellungform1` steht zum Beispiel
`Kategorie = "Kunde"` als Zusatzfilter, und `FelderWennNeu` setzt beim
Neuanlegen `Kategorie` auf `"Lieferant"`. Genau das ist der Ablauf
„Kunde suchen, sonst Kunde neu“.

### artikel

Stammdaten mit `Artikelgruppe` und `Artikel` als Text, Einkaufspreis,
Einheit, Aufschlag, Gewicht, drei freie Zahlen (`Zahl1` bis `Zahl3`) und
drei freie Namen, Lieferant als Text, Lieferanten-Artikelnummer,
Positionstext, Berechnungsart als Text, Kostenart als ein Buchstabe,
Bestand und Mindestbestand.

`artikelgruppe` wiederholt einen Teil davon und hält fest, welche dieser
Felder in der Erfassung sichtbar sind (`S_Gewicht`, `S_Zahl1`, …) und
welche Vorgaben eine neue Zeile bekommt (`V_EK_Preis`, …). Die Gruppe
ist damit schon eine kleine Maskenbeschreibung.

Positionen liegen in `artikelliste`. Sie kopieren Preis, Text, Menge und
Aufschlag in die Belegzeile. Das ist richtig: die Rechnung darf sich
nicht ändern, nur weil der Stammpreis sich ändert. `Erledigt1` bis
`Erledigt5` sind fünf Schalter ohne festes Bedeutungsfeld.

### benutzer

`Benutzer`, `Passwort`, `Projektneu`, `Projektaendern`, `Projektloeschen`,
dazu ein Verweis auf `fensterdesign`. Ein mitgelieferter Benutzer heißt
`Standard`. Das Passwort ist mit einer selbst gebauten Umkehrung
gespeichert, nicht mit einem heute üblichen Verfahren. Diese Funktion
wird nicht übernommen.

Rechte an Belegarten liegen nicht in `benutzer`, sondern in den Schaltern
der jeweiligen `einstellungmodulart`-Zeile. Eine Rolle „Abteilungsleiter“,
die mehrere Benutzer teilen, gibt es nicht. Jeder Benutzer braucht eigene
Zeilen, sonst gilt `Standard`.

### einstellungform1, fensterdesign, Tasten

`einstellungform1` ist die Maskenbeschreibung der Liste: `SQLFrom`,
`SQLSelect`, `SQLWhere`, `SQLOrder`, Fenstertitel, Position und Größe,
und die Schalter `NeuAn`, `AendernAn`, `LoeschenAn`, `KopierenAn`,
`AusgabeAn`. In `TempForm.pas` gilt: ist `NeuAn` ungleich 0, ist F2 an.

Die Tasten der Liste, ohne Umschalt:

| Taste | Wirkung |
| --- | --- |
| Esc | zurück, ohne Übernahme |
| F2 | neuer Satz, wenn erlaubt |
| F3 | Ausgabe |
| F5 | kopieren |
| F6 | ändern |
| F7 | sortieren |
| F8 | löschen |
| F9 | Filter |
| Eingabe | übernehmen und schließen |

Mit Umschalt liegen unter anderem F6 (Einstellungen der Liste), F8
(alle gezeigten Sätze löschen) und F9 (Fenstergröße speichern). Eine
eigene Alt-Ebene als Daten gibt es nicht. Die Beschriftung steht fest
im Formular, nur das An- und Ausschalten kommt aus den Daten.

`fensterdesign.Cascad` schaltet die Kaskade. In `UnitModule.pas` stehen
die Schrittweiten `GTopSchritte := 26` und `GLeftSchritte := 9`. Jedes
Fenster zählt beim Öffnen `GOffeneFenster` hoch und setzt
`Top` und `Left` auf Anzahl mal Schritt, wenn die Kaskade an ist.

Das Listenfenster gibt es höchstens zehnmal (`Form1` bis `Form10` in
`TempForm.pas`). Danach ist Schluss, auch wenn der Ablauf mehr Suchen
braucht.

## Was nicht mit hinübergenommen wird

- Verknüpfungen über den Namen (`Modulart`, `Kategorie`, `Benutzer`,
  `Artikelgruppe`, `Lieferant`). Umbenennen bricht die Verbindung.
  Neu: Nummer als Verweis, Name nur als Beschriftung oder als bewusste
  Kopie auf dem Beleg.
- Eine Zeile mit über hundert Spalten für die Belegart. Neu: eine schmale
  Zeile für die Art, und eigene Tabellen für Tasten, Rechte und Felder.
- SQL-Bruchstücke in Tabellenzellen (`SQLWhere`, `AASQLFilterArtikel1`).
  Eine Eingabe könnte damit mehr ändern als ein Filter. Neu: Filter als
  Feld und Wert, das Programm baut die Abfrage.
- Das selbst gebaute Passwortverfahren.
- `artikellistetemp` als gemeinsame Kratzliste in der Datenbank.
- Fünf `Erledigt`-Schalter und vier `Frei`-Felder ohne Bedeutung.
  Zusätzliche Felder bekommen einen Namen in der Maskenbeschreibung.
- Geldbeträge als `double`. Der einzige Gleitkommawert im jetzigen Schema
  ist `rabatt_prozent` auf der Adresse. Beträge auf Belegen werden später
  in Cent als ganze Zahl gespeichert, damit 0,1 Euro nicht zu
  Rundungsfehlern wird.
- Bis zu zehn fest verdrahtete Kopien des Suchfensters. Neu werden die
  Fenster nach Bedarf erzeugt.

Was bleibt, auch wenn die Tabellen anders heißen: die Belegart als
Datensatz, das eine Listenfenster, die Kopie von Preis und Text in die
Position, Berechnungsarten als Daten, Textbausteine, Nummernkreis je
Belegart, und die Kaskade mit 26 und 9.

## Neues Datenmodell

### Schon angelegt, Schema-Version 2

Die Unit `src/udatenbank.pas` legt die Tabellen beim ersten Start an.
Vorhandene Zeilen werden nicht überschrieben. Wer „Angebot“ umbenennt,
behält den neuen Namen beim nächsten Start.

Die Typen sind so gewählt, dass SQLite und PostgreSQL dieselben
Anweisungen verstehen: `INTEGER`, `TEXT`, `REAL`, `COALESCE`,
`CREATE TABLE IF NOT EXISTS`. Nur das Einschalten der Fremdschlüssel
(`PRAGMA foreign_keys`) ist SQLite und steht nicht in den gemeinsamen
Anweisungen.

**schema_info** — `id`, `version`, `angelegt`.

**parameter** — `schluessel`, `wert`. Startwerte:

| Schlüssel | Wert | Bedeutung |
| --- | --- | --- |
| `kaskade` | `1` | Fenster versetzt öffnen |
| `schritt_oben` | `26` | wie früher `GTopSchritte` |
| `schritt_links` | `9` | wie früher `GLeftSchritte` |
| `datenbank_art` | `sqlite` | Merker, welche Ablage läuft |
| `mwst_satz` | `19` | Regelsteuersatz nach § 12 Abs. 1 UStG, noch ohne Rechnung |
| `installation_id` | eine Kennung | einmal je Datei, für den späteren Belegaustausch |

**modulart** — die Belegart, schmal.

| Spalte | Inhalt |
| --- | --- |
| `kuerzel` | fest, zum Beispiel `angebot`, ändert sich nicht |
| `bezeichnung` | sichtbar, zum Beispiel Angebot |
| `beschreibung` | ein Satz, wofür die Art da ist |
| `fenster_oben`, `fenster_links`, `fenster_breite`, `fenster_hoehe` | Startgröße, 0 heißt „Kaskade entscheiden lassen“ |
| `bereich_kopf`, `bereich_summe`, `bereich_fuss` | 1 sichtbar, 0 versteckt |
| `hauptmodul_id` | die vorherige Art, etwa Rechnung folgt auf Auftragsbestätigung |
| `nummernkreis` | `ANG`, `AB`, `BES`, `RE`, `PRJ` |
| `sortierung`, `aktiv` | Reihenfolge und ob die Art benutzt wird |

Eingetragen: Angebot, Auftragsbestätigung (folgt auf Angebot),
Bestellung, Rechnung (folgt auf Auftragsbestätigung), Projekt
(nur Kopf, ohne Summe und Fuß).

**adresskategorie** — Kunde, Lieferant, Kontakt, Mitarbeiter.
Kontakt ist neu gegenüber dem alten Bestand und gehört zum Ablauf
„erst der Kunde, dann die Ansprechperson“.

**adresse** — `kategorie_id` als Nummer, Firma, Anrede, Titel, Vorname,
Nachname, Straße, PLZ, Ort, Land, Telefon, Telefax, E-Mail, Notiz,
`rabatt_prozent`, `angelegt`, `geaendert`. Noch keine Beispielzeile.
Die alten Felder `Frei1` bis `Frei4` gibt es nicht.

**rolle** — Administrator, Abteilungsleiter, Gruppenleiter, jeweils mit
einem Satz Beschreibung.

**recht** — je Rolle und Belegart die fünf Schalter `sehen`, `neu`,
`aendern`, `loeschen`, `drucken`.

| Rolle | Rechte an allen fünf Belegarten |
| --- | --- |
| Administrator | sehen, neu, ändern, löschen, drucken |
| Abteilungsleiter | sehen, neu, ändern, drucken |
| Gruppenleiter | sehen, neu |

Eine Anmeldung, die diese Belegrechte durchsetzt, gibt es noch nicht.

**maske**, **maskenfeld**, **tastenbelegung**, **maskenrecht.** Es gibt
ein Suchfenster (`usuche.pas`) und ein Eingabefenster (`ueingabe.pas`).
Welche Adressart, welche Felder, welche Beschriftung, welche Fenstergröße
und welche Tasten gelten, steht in der Maske. Mitgeliefert:

| Kürzel | Sichtbarer Unterschied |
| --- | --- |
| `kunde` | Firma und Rabatt sind sichtbar, Nachname ist Pflicht |
| `lieferant` | Firma ist Pflicht, Rabatt ist versteckt, Telefax steht in der Liste |
| `kontakt` | Vorname und Nachname sind Pflicht, Land ist versteckt, Löschen ist aus |
| `mitarbeiter` | Firma und Rabatt sind versteckt |

Die Suche filtert über `kategorie_id`. F2 öffnet die Eingabe derselben
Maske. Nach dem Speichern ist der neue Satz in der Suche ausgewählt.
Die Tastenbeschriftung und ob die Taste frei ist, kommt aus
`tastenbelegung` (`kontext` `suche` oder `eingabe`). `maskenrecht` hält
je Rolle sehen, neu, ändern und löschen bereit. Ohne Anmeldung schaltet
das Fenster diese Rollenrechte noch nicht scharf; die Tastenfreigabe
aus `tastenbelegung` gilt schon.

### Vorgesehen, noch nicht angelegt

Eigene Felder des Benutzers, die keine echte Spalte sind, landen später in
**zusatzwert** (`maske_id`, `datensatz_id`, `feld_kuerzel`, `wert`).
So entsteht „Arbeitsschuhe“ ohne `CREATE TABLE` durch den Benutzer.

**benutzer** mit Name, Passwort als heutiger Hash, und `rolle_id`.
Dann gelten die Zeilen in `maskenrecht` und `recht` für die Tasten.

**beleg** als Nachfolger von `module`: `modulart_id`, Nummer aus dem
Nummernkreis, `adresse_id`, später `kontakt_id`, `bezug_beleg_id` für
den Vorgänger, Bezeichnung, Kopftext, Fußtext, Notiz, Ihr Zeichen,
Erfassung, letzte Bearbeitung, Status `entwurf` oder `festgeschrieben`,
Währung, und der MwSt-Satz als Kopie zum Zeitpunkt des Belegs.

**belegposition** als Nachfolger von `artikelliste`: Beleg, Positionsnummer,
optionale `artikel_id`, Text, Menge, Einheit, Einzelpreis in Cent,
Rabatt. Die `artikel_id` darf leer werden, der Text und der Preis bleiben.
Stücklisten werden später eine Position mit Unterpositionen, nicht eine
zweite fast gleiche Tabelle.

**artikel**, **artikelgruppe**, **einheit**, **berechnungsart** folgen,
wenn die Positionen einen Stamm brauchen. Die Berechnungsart bleibt ein
Datensatz, aber mit einer kleinen festen Liste von Rechenwegen, nicht
mit einem frei eingetippten Formeltext.

## Architektur

Vier Schichten. Die oberen kennen die unteren, nicht umgekehrt.

1. **Fenster**, LCL. `uhaupt.pas` ist das Hauptfenster, `ukindfenster.pas`
   öffnet leere Zusatzfenster, `utastenleiste.pas` ist die Leiste.
   `usuche.pas` und `ueingabe.pas` sind das eine Kontaktfenster.
   Diese Units enthalten kein SQL.
2. **Masken**, `umaske.pas`: Maske laden, Adresse speichern und suchen.
   Beleg anlegen und Nummern vergeben kommen später.
3. **Metadaten**, die Tabellen `modulart`, `maske`, `maskenfeld` und
   `tastenbelegung`. Sie steuern, was die generischen Fenster zeigen.
4. **Datenzugriff**, nur `udatenbank.pas`. Klasse `TPlanlosDatenbank`.

### Tasten

Drei Ebenen. Ebene 1 normal, Ebene 2 bei gehaltener Umschalttaste,
Ebene 3 bei gehaltener Alt-Taste. Ist die Taste nicht gehalten, gilt
der Knopf Normal, Umschalt oder Alt in der Leiste. Eine wirklich
gehaltene Umschalt- oder Alt-Taste gewinnt über den Knopf. Klick und
Taste rufen dieselbe Prozedur auf.

Im Hauptfenster tun das schon F1 (Hilfe), F3 (leeres Fenster), F4
(Kundensuche), F11 (Datenbanktext), F12 (beenden) und die Umschalt-
und Alt-Ebene für Kaskade und Programmende. Die übrigen Beschriftungen
sagen, dass die Wirkung noch fehlt.

Im Kontaktfenster kommt die Beschriftung aus `tastenbelegung`. Ist
`erlaubt` 0, bleibt die Taste sichtbar und gesperrt. Bei Kontakten
ist Löschen so aus. Die Rollenrechte in `maskenrecht` warten auf die
Anmeldung.

### Kaskade

`KindfensterOeffnen` zählt die offenen Zusatzfenster. Ist `kaskade`
gleich `1`, liegt das neue Fenster bei 24 plus Anzahl mal Schritt.
Nach 15 Fenstern beginnt der Versatz von vorn, damit sie auf dem
Bildschirm bleiben. Ist die Kaskade aus, liegen alle bei links 24 und
oben 24. Persönliche Werte je Benutzer kommen mit der Tabelle
`benutzer`; bis dahin gilt der eine Parametersatz für die Installation.

### Warum SQLdb und nicht Zeos

Das alte Programm brauchte Zeos, weil es das Protokoll `mysql-4.0`
gesprochen hat. Planlos spricht SQLite für den einzelnen Nutzer und
PostgreSQL für die Firma. Beides bringt Free Pascal in der Bibliothek
SQLdb mit: `TSQLite3Connection` und später `TPQConnection`. Beide
benutzen dieselben Klassen für Abfrage und Transaktion. Die Fenster
sehen davon nichts.

SQLdb ist dabei, sobald Lazarus installiert ist. Zeos wäre ein weiteres
Paket, das man laden und übersetzen müsste. Wenn SQLdb später an einer
konkreten Stelle nicht reicht, wechselt nur `udatenbank.pas`. Die
Formulare bleiben.

`VerbindenPostgreSQL` ist schon als Prozedur da und meldet, dass der
Anschluss fehlt. Sie schreibt ein übergebenes Passwort nicht in die
Meldung.

Die Datenbankdatei liegt im Ordner `data` neben dem Programm und heißt
`planlos.sqlite`. Unter Linux wird `libsqlite3.so.0` geladen, unter
Windows `sqlite3.dll` neben der Programmdatei.

## Austausch zwischen Installationen

Jede Datei bekommt beim ersten Anlegen `installation_id`. Ein Beleg,
der später exportiert wird, trägt diese Kennung und seine eigene Nummer.
Die empfangende Installation legt einen neuen Beleg der passenden Art an
und übernimmt die Positionen als Kopie, nicht als Verweis in die fremde
Datenbank. Dieselbe Kennung und Nummer ein zweites Mal wird abgelehnt.

Wer ein Angebot annimmt, kann die Artikel, die er noch nicht hat, in
den eigenen Stamm übernehmen. Die Preise auf dem Beleg bleiben die
Kopie aus der Datei. Das Dateiformat wird erst festgelegt, wenn der
Beleg selbst existiert. Für Rechnungen ist das Ziel danach XRechnung
und ZUGFeRD, nicht ein privates Format allein.

## Nächste Ausbaustufen

Jede Stufe ist für sich benutzbar. Die Reihenfolge ist die Abhängigkeit,
nicht ein Zeitplan.

1. **Suchfenster für Adressen.** Erledigt. Eine Unit, vier Masken.
2. **Eingabefenster derselben Maske.** Erledigt. F2 legt an und wählt
   den neuen Satz in der Suche aus.
3. **Benutzer und Anmeldung.** Passwort als Hash, eine Rolle je Benutzer.
   Dann schalten `maskenrecht` und `recht` die Tasten aus.
4. **Belegfenster.** Eine Form liest `modulart` und blendet Kopf, Summe
   und Fuß nach den Schaltern ein. Tabellen `beleg` und `belegposition`,
   Nummernkreis, Positionen zuerst als freie Zeile ohne Artikelstamm.
5. **Artikelstamm.** Übernahme in die Position kopiert Text und Preis.
   Die `artikel_id` bleibt ein Verweis, der Text auf dem Beleg bleibt
   stehen, wenn der Artikel sich ändert.
6. **PostgreSQL** in `VerbindenPostgreSQL`, Auswahl über `datenbank_art`.
   Dieselben Anweisungen, ein Verbindungstest gegen einen Server.
7. **PDF.** Eine Druckbeschreibung als Daten, Nachfolger von
   `einstellungdrucken`, ohne die gepackten Zwanzig-Felder-Ketten.
8. **Festschreiben.** Status Entwurf oder festgeschrieben. Ein
   festgeschriebener Beleg nimmt keine Änderung mehr an. Das ist die
   Vorstufe zur GoBD, noch ohne die volle Verfahrensdokumentation.
9. **XRechnung und ZUGFeRD** für festgeschriebene Rechnungen.
10. **Belegdatei.** Export, Import in einer anderen Installation,
    Artikel übernehmen, doppelten Import an `installation_id` und
    Belegnummer erkennen.

## Bewusst noch nicht in diesem Stand

Kein Angebot, kein Druck, keine Anmeldung, kein Netzwerk.
Die leeren Zusatzfenster zeigen weiter nur die Kaskade.
Der nächste sinnvolle Schritt ist die Anmeldung, damit die vorbereiteten
Rechte gelten, und danach das Belegfenster, das die Kundensuche aufruft.
