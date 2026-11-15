# Planlos

Planlos ist ein freies Programm zum Schreiben von Angeboten, Aufträgen
und Rechnungen. Es ist die Neuauflage von „Mein kleines Büro“ (MyOffice),
das früher mit Delphi 4 und MySQL gelaufen ist.

Der Name ist ernst gemeint: man soll das Programm aufmachen können, ohne
vorher einen Ablauf auswendig zu lernen. Was ein Fenster zeigt und welche
Tasten gelten, soll in der Datenbank stehen, nicht in einem eigenen
Programmstück für jede Maske.

## Für wen

Zuerst für den eigenen Gebrauch und für kleine Büros. Die Datenbank ist
dann eine einzige Datei, die man sichern kann, indem man sie kopiert.

Später auch für Firmen, mit PostgreSQL auf einem Server. Dasselbe Programm,
dieselbe Bedienung. Nur der Ablageort der Daten wechselt.

Planlos ist nicht kommerziell. Es steht unter der
[GNU General Public License, Version 3](LICENSE) (GPL-3.0).
Sie dürfen es benutzen, weitergeben und verändern. Wenn Sie es weitergeben
oder verändern, bleibt diese Freiheit für den nächsten Menschen erhalten.
Es gilt Version 3, nicht automatisch eine spätere Fassung.

## Die Idee

Es gibt **ein** Fenster für Belege. Ob daraus ein Angebot, eine
Auftragsbestätigung, eine Bestellung oder eine Rechnung wird, entscheidet
ein Datensatz, keine eigene Programmdatei.

Dieselbe Idee gilt für Suchen und Eingeben. Ein Suchfenster und ein
Eingabefenster richten sich nach einer Maskenbeschreibung. Damit kann
später auch eine eigene Liste entstehen, zum Beispiel die Arbeitsschuhe
der Mitarbeiter, ohne dass jemand dafür ein neues Fenster programmiert.

Der Ablauf, den das alte Programm schon konnte und den das neue wieder
können soll: Angebot neu, Kunde suchen, und wenn es den Kunden noch nicht
gibt, ihn an dieser Stelle anlegen. Danach zurück ins Angebot.

## Bedienung

Unten im Fenster liegt eine Leiste mit F1 bis F12. Die Tasten kann man
drücken oder mit der Maus anklicken. Hält man die Umschalttaste, wechselt
die Beschriftung auf eine zweite Ebene, mit der Alt-Taste auf eine dritte.
Dieselben drei Ebenen kann man auch anklicken (Normal, Umschalt, Alt),
falls man die Taste nicht gedrückt halten will.

Weitere Fenster öffnen sich von links oben versetzt, eines unter und neben
dem anderen. In den Parametern kann man das abschalten. Dann öffnen sie
sich alle an derselben Stelle. Die Schrittweite ist wie früher: 26 Punkte
nach unten, 9 nach rechts.

## Ziele

1. Alltagsfähig für Angebote und Rechnungen, nach deutschen Regeln.
2. Später GoBD: ein festgeschriebener Beleg bleibt nachvollziehbar und
   wird nicht mehr stillschweigend verändert.
3. Später elektronische Rechnungen, XRechnung und ZUGFeRD.
4. Ausbaufähig vom einzelnen Nutzer bis zu einem Programm für größere
   Firmen, mit frei definierbaren Rollen. Mitgeliefert werden
   Administrator, Abteilungsleiter und Gruppenleiter. Rechte je Belegart:
   sehen, neu, ändern, löschen, drucken.
5. Langfristig tauschen zwei Planlos-Installationen Belege aus. Wer ein
   Angebot annimmt, kann die Artikel in die eigene Datenbank übernehmen.

## Stand

Das hier ist der Anfang, bewusst klein.

Vorhanden:

- diese Erklärung, die Lizenz und das Konzept in `docs/KONZEPT.md`
- der alte Quellcode unter `alt/MyOffice/`, nur zum Nachlesen
- ein Lazarus-Programm unter `src/`: Hauptfenster wie früher mit den
  Reitern Explorer, Stammdaten, Einstellungen und Wartung/Hilfe,
  Tastenleiste und kaskadierte Zusatzfenster
- beim ersten Start der Anwender Admin mit dem Passwort 0000. Das
  Passwort liegt nur als gesalzener Hash. Danach gilt die Rolle, für
  Admin mit allen Rechten
- das Kontaktfenster ist eines und sieht aus wie die alte Adressmaske.
  Die Maske in der Datenbank macht daraus Kunde, Lieferant, Kontakt
  oder Mitarbeiter. Ein Feld mit > öffnet eine Auswahlliste
- das Belegfenster ist eines. Im Explorer legt Neu einen Beleg an,
  ein Doppelklick öffnet ihn

Noch nicht vorhanden:

- kein Artikelstamm, kein Druck, kein PDF, keine E-Rechnung
- PostgreSQL ist vorgesehen, aber noch nicht angeschlossen

Die Datenbankdatei heißt `planlos.sqlite`. Sie entsteht beim ersten Start
im Ordner `data` neben dem Programm. Wenn dieser Ordner nicht beschreibbar
ist, liegt die Datei im persönlichen Ordner des Benutzers. Darin stehen
fünf Belegarten, vier Adressmasken, die drei Rollen und den Mitarbeiter
Admin. Weitere Adressen legen Sie selbst an.

## Ausprobieren unter Windows

Dafür brauchen Sie kein Git und kein Lazarus.

1. Öffnen Sie die [Veröffentlichungen](https://github.com/Eisenmann17/planlos/releases).
2. Laden Sie bei der neuesten Fassung die Datei `planlos-windows.zip` herunter.
3. Entpacken Sie die ZIP, zum Beispiel auf den Desktop.
4. Starten Sie `planlos.exe` mit einem Doppelklick.

`sqlite3.dll` muss im selben Ordner bleiben wie `planlos.exe`. Ihre Daten
legt das Programm selbst an, im Ordner `data` daneben. Eine kurze Anleitung
liegt als `LIESMICH.txt` in der ZIP.

Die ZIP entsteht automatisch, wenn eine Versionsmarke wie `v0.1.0` gesetzt
wird, oder wenn der Ablauf „Windows-Paket“ von Hand gestartet wird.

## Bauen und starten

Voraussetzung ist [Lazarus](https://www.lazarus-ide.org/) mit Free Pascal.
Gedacht ist zuerst Windows, derselbe Quelltext soll auch unter Linux laufen.
Gebaut wurde dieses Grundgerüst mit Lazarus 3.0 und Free Pascal 3.2.

Im Lazarus die Datei `src/planlos.lpi` öffnen und starten.
Oder auf der Kommandozeile:

```
lazbuild src/planlos.lpi
```

Das Programm liegt danach unter `bin/planlos` (unter Windows `planlos.exe`).

Unter Linux wird die Bibliothek `libsqlite3` gebraucht, Paketname
meist `libsqlite3-0`. Wer selbst unter Windows baut, legt `sqlite3.dll`
(64 Bit, von [sqlite.org](https://sqlite.org/)) neben die Programmdatei.
In der fertigen ZIP ist sie schon enthalten.

Wer nur die Tabellen prüfen will, ohne Fenster:

```
fpc -Mobjfpc -FcUTF8 -Fusrc -obin/schema_pruefen src/schema_pruefen.lpr
bin/schema_pruefen
```

Der Übersetzer kann Hinweise zu AnsiString und UnicodeString ausgeben.
Die Umlaute bleiben erhalten. Geprüft ist das an der Bezeichnung
„Auftragsbestätigung“.

## Masken selbst anpassen in Lazarus

Drei Fenster sind echte Formulare. Sie lassen sich im Lazarus-Designer
öffnen, ohne den Ablauf im Programmtext anzufassen.

| Datei | Fenster |
| --- | --- |
| `src/uanmeldung.lfm` | die Anmeldung |
| `src/uhaupt.lfm` | das Hauptfenster „Mein kleines Büro“ |
| `src/ueingabe.lfm` | die Adressmaske |

Im Lazarus `src/planlos.lpi` öffnen, links die Unit anklicken und das
Formular mit Doppelklick aufmachen. Rechts liegt der Objektinspektor.

- **Height** und **Width** ändern die Höhe und Breite des markierten
  Feldes oder Knopfes.
- **Color** ändert die Farbe. Bei der Firma ist das Grün schon gesetzt.
- **Anchors** sagt, an welchen Rändern das Teil klebt, wenn das Fenster
  größer gezogen wird. Die Belegliste und die rechte Spalte der Adresse
  wachsen mit. Wer ein Feld festnageln will, nimmt die Haken weg.
- **Caption** ändert die Beschriftung.
- **Left** und **Top** verschieben das Teil.

Speichern, danach das Programm neu bauen und starten. Die Stelle im
Formular gilt. Welche Felder bei Kunde, Lieferant, Mitarbeiter oder
Kontakt sichtbar sind, steht weiter in der Datenbank.

## Ordner

| Ordner | Inhalt |
| --- | --- |
| `src/` | das neue Programm |
| `docs/` | Konzept und spätere Beschreibungen |
| `alt/MyOffice/` | der alte Delphi-Quellcode, unverändert als Referenz |
| `data/` | entsteht beim Start, die Datenbankdatei, wird nicht mitgeliefert |

## Kontakt

Projekt von Günther Stadtler (GitHub: Eisenmann17).
