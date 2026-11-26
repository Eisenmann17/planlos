program schema_pruefen;

{ Prüft das erste Planlos-Schema, ohne ein Fenster zu öffnen.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

uses
  {$IFDEF UNIX}
  cwstring,
  {$ENDIF}
  Classes, SysUtils,
  udatenbank, umaske, ubeleg, ubenutzer, uartikel, unachschlage, uprojekt,
  utextbaustein, udruck, umodulart, urechner, udatum;

var
  DB: TPlanlosDatenbank;
  Pfad, Id1, Eltern, Name, Fehler, Aktion: string;
  Frisch, Erlaubt: Boolean;
  Werte, Gelesen: TStringList;
  MitarbeiterId, KundeId, AngebotId, RechnungId, ZweitesId, KopieId: Int64;
  Tasten: TTastenListe;
  Positionen: TPosListe;
  Summe: TBelegSumme;
  Kopf: TBelegKopf;
  Art: TBelegart;
  FolgeFehler, Meldung, Hash, Salz: string;
  FS: TFormatSettings;
  Rabatt: Double;
  Filter: TExplorerFilter;
  Sitz: TSitzung;
  SpaltenX, ZeilenX: TStringList;
  ProjektStamm: TProjekt;
  Baustein: TTextbaustein;
  Vorlage: TDruckvorlage;
  SeitenZahl, iPos: Integer;
  DatumJahr, DatumMonat, DatumTag: Word;
  Inhalt: RawByteString;

  procedure Fehlschlag(const Text: string);
  begin
    WriteLn(StdErr, 'Fehler: ', Text);
    Halt(1);
  end;

begin
  if Sha256Hex('abc') <>
    'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad' then
    Fehlschlag('SHA-256 von abc stimmt nicht.');
  if Sha256Hex('') <>
    'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855' then
    Fehlschlag('SHA-256 der leeren Zeichenkette stimmt nicht.');

  Frisch := ParamCount = 0;
  if Frisch then
    Pfad := IncludeTrailingPathDelimiter(GetTempDir) + 'planlos-pruefung.sqlite'
  else
    Pfad := ParamStr(1);

  if Frisch and FileExists(Pfad) then
    DeleteFile(Pfad);

  DB := TPlanlosDatenbank.Create;
  PlanlosDB := DB;
  try
    DB.VerbindenSQLite(Pfad);
    DB.SchemaSicherstellen;
    if Frisch then
    begin
      if not DB.FremdschluesselAktiv then
        Fehlschlag('Fremdschlüssel sind aus.');
      if DB.Ganzzahl('SELECT COUNT(*) FROM modulart') <> 5 then
        Fehlschlag('Es sollen 5 Belegarten angelegt sein.');
      if DB.Ganzzahl('SELECT COUNT(*) FROM adresskategorie') <> 4 then
        Fehlschlag('Es sollen 4 Adressarten angelegt sein.');
      if DB.Ganzzahl('SELECT COUNT(*) FROM adresse') <> 1 then
        Fehlschlag('Es soll genau der Mitarbeiter Admin angelegt sein.');
      if DB.Skalar(
        'SELECT nachname FROM adresse a JOIN adresskategorie k ON k.id = a.kategorie_id ' +
        'WHERE k.bezeichnung = ''Mitarbeiter''') <> 'Admin' then
        Fehlschlag('Der erste Mitarbeiter soll Admin heißen.');
      if DB.Ganzzahl('SELECT COUNT(*) FROM benutzer') <> 1 then
        Fehlschlag('Es soll einen Anwender geben.');
      if DB.Skalar(
        'SELECT r.bezeichnung FROM benutzer b JOIN rolle r ON r.id = b.rolle_id ' +
        'WHERE b.name = ''Admin''') <> 'Administrator' then
        Fehlschlag('Admin soll die Rolle Administrator haben.');
      if DB.Skalar(
        'SELECT a.nachname FROM benutzer b JOIN adresse a ON a.id = b.adresse_id ' +
        'WHERE b.name = ''Admin''') <> 'Admin' then
        Fehlschlag('Der Anwender Admin ist nicht mit dem Mitarbeiter verknüpft.');
      Hash := DB.Skalar('SELECT passwort_hash FROM benutzer WHERE name = ''Admin''');
      Salz := DB.Skalar('SELECT passwort_salz FROM benutzer WHERE name = ''Admin''');
      if (Length(Hash) <> 64) or (Length(Salz) < 16) or (Hash = '0000') then
        Fehlschlag('Das Passwort darf nicht im Klartext liegen.');
      if not Anmelden('Admin', '0000', Meldung) then
        Fehlschlag('Anmeldung Admin/0000: ' + Meldung);
      if DB.Ganzzahl('SELECT COUNT(*) FROM rolle') <> 3 then
        Fehlschlag('Es sollen 3 Rollen angelegt sein.');
      if DB.Ganzzahl('SELECT COUNT(*) FROM recht') <> 15 then
        Fehlschlag('Es sollen 15 Rechte angelegt sein.');
      Name := DB.Skalar(
        'SELECT bezeichnung FROM modulart WHERE kuerzel = ''auftragsbestaetigung''');
      if Name <> 'Auftragsbestätigung' then
        Fehlschlag('Bezeichnung falsch gelesen: ' + Name);
      Eltern := DB.Skalar(
        'SELECT h.kuerzel FROM modulart m ' +
        'JOIN modulart h ON h.id = m.hauptmodul_id ' +
        'WHERE m.kuerzel = ''rechnung''');
      if Eltern <> 'auftragsbestaetigung' then
        Fehlschlag('Die Rechnung soll auf die Auftragsbestätigung folgen.');
      Id1 := DB.ParameterLesen('installation_id', '');
      if Length(Id1) < 30 then
        Fehlschlag('Die Installationskennung fehlt.');
      DB.ParameterSetzen('kaskade', '0');
      DB.SchemaSicherstellen;
      if DB.ParameterLesen('kaskade', '') <> '0' then
        Fehlschlag('Ein geänderter Parameter wurde vom Schema überschrieben.');
      if DB.ParameterLesen('installation_id', '') <> Id1 then
        Fehlschlag('Die Installationskennung hat sich geändert.');
      if DB.Ganzzahl('SELECT COUNT(*) FROM modulart') <> 5 then
        Fehlschlag('Das Schema hat Belegarten verdoppelt.');
      if DB.Ganzzahl('SELECT version FROM schema_info WHERE id = 1') <> 11 then
        Fehlschlag('Das Schema soll auf Version 11 stehen.');
      if not RechnerAuswerten('1,5 + 2,5', Rabatt, FolgeFehler) or
         (Abs(Rabatt - 4) > 0.0001) then
        Fehlschlag('1,5 + 2,5 ist nicht 4.');
      if not RechnerAuswerten('10*3', Rabatt, FolgeFehler) or (Abs(Rabatt - 30) > 0.0001) then
        Fehlschlag('10 mal 3 ist nicht 30.');
      if not RechnerAuswerten('100/4', Rabatt, FolgeFehler) or (Abs(Rabatt - 25) > 0.0001) then
        Fehlschlag('100 geteilt durch 4 ist nicht 25.');
      if not RechnerAuswerten('200+10%', Rabatt, FolgeFehler) or
         (Abs(Rabatt - 220) > 0.0001) then
        Fehlschlag('200 plus 10 Prozent sind nicht 220.');
      if not RechnerAuswerten('200-10%', Rabatt, FolgeFehler) or
         (Abs(Rabatt - 180) > 0.0001) then
        Fehlschlag('200 minus 10 Prozent sind nicht 180.');
      if not RechnerAuswerten('50*10%', Rabatt, FolgeFehler) or (Abs(Rabatt - 5) > 0.0001) then
        Fehlschlag('50 mal 10 Prozent sind nicht 5.');
      if RechnerAuswerten('1/0', Rabatt, FolgeFehler) then
        Fehlschlag('Teilen durch null hätte scheitern müssen.');
      if RechnerText(12.5) <> '12,5' then
        Fehlschlag('12,5 wird falsch geschrieben: ' + RechnerText(12.5));
      if RechnerText(-3) <> '-3' then
        Fehlschlag('Minus 3 wird falsch geschrieben.');
      if not DatumLesen('2026-11-26', DatumJahr, DatumMonat, DatumTag) or
         (DatumJahr <> 2026) or (DatumMonat <> 11) or (DatumTag <> 26) then
        Fehlschlag('Das ISO-Datum wird falsch gelesen.');
      if not DatumLesen('26.11.2026', DatumJahr, DatumMonat, DatumTag) or
         (DatumIso(DatumJahr, DatumMonat, DatumTag) <> '2026-11-26') then
        Fehlschlag('Das deutsche Datum wird falsch gelesen.');
      if not DatumLesen('1.2.2024', DatumJahr, DatumMonat, DatumTag) or
         (DatumIso(DatumJahr, DatumMonat, DatumTag) <> '2024-02-01') then
        Fehlschlag('Das kurze deutsche Datum wird falsch gelesen.');
      if not DatumLesen('29.02.2024', DatumJahr, DatumMonat, DatumTag) then
        Fehlschlag('Der 29. Februar 2024 ist ein gültiger Tag.');
      if DatumLesen('29.02.2025', DatumJahr, DatumMonat, DatumTag) then
        Fehlschlag('Der 29. Februar 2025 ist kein gültiger Tag.');
      if DatumLesen('31.04.2026', DatumJahr, DatumMonat, DatumTag) then
        Fehlschlag('Der 31. April ist kein gültiger Tag.');
      if DatumLesen('', DatumJahr, DatumMonat, DatumTag) then
        Fehlschlag('Ein leeres Datum hätte scheitern müssen.');
      if not DatumLesen('2026-11-05T08:00:00', DatumJahr, DatumMonat, DatumTag) or
         (DatumIso(DatumJahr, DatumMonat, DatumTag) <> '2026-11-05') then
        Fehlschlag('Ein Datum mit Uhrzeit wird falsch gelesen.');
      if DatumIso(2026, 11, 5) <> '2026-11-05' then
        Fehlschlag('Das Datum wird falsch geschrieben.');
      if not DruckvorlageFuer('angebot', Vorlage) or (Vorlage.RandLinksMm <> 25) or
         (Vorlage.AnschriftObenMm <> 45) or (Vorlage.TextObenMm <> 105) then
        Fehlschlag('Die Standard-Druckvorlage fehlt oder hat nicht die DIN-Maße.');
      if DB.Ganzzahl(
        'SELECT druckvorlage_id FROM modulart WHERE kuerzel = ''rechnung''') <> 1 then
        Fehlschlag('Jede Belegart soll die Standardvorlage nutzen.');
      Kopf := Default(TBelegKopf);
      Kopf.Nummer := 'ANG-1';
      Kopf.Bezeichnung := 'Fenstertest';
      Kopf.AdresseText := 'Meier GmbH' + LineEnding + 'Hauptstraße 1' + LineEnding +
        '12345 Musterstadt';
      Kopf.Erfasst := '2026-11-26';
      Kopf.Kopftext := 'Guten Tag';
      Kopf.Fusstext := 'Mit freundlichen Grüßen';
      Kopf.MwstRechnen := True;
      SetLength(Positionen, 40);
      for iPos := 0 to High(Positionen) do
      begin
        Positionen[iPos] := Default(TBelegPosition);
        Positionen[iPos].Text := 'Position ' + IntToStr(iPos + 1);
        Positionen[iPos].MengeMilli := 1000;
        Positionen[iPos].EinzelpreisCent := 100;
        Positionen[iPos].MwstSatz := 19;
        Positionen[iPos].Einheit := 'Stück';
      end;
      if not BelegPdfSchreiben(Kopf, Positionen, Vorlage, 'Angebot', 'Admin',
        GetTempDir + 'planlos-druck.pdf', SeitenZahl, FolgeFehler) then
        Fehlschlag(FolgeFehler);
      if SeitenZahl < 2 then
        Fehlschlag('Vierzig Positionen sollen auf mehr als eine Seite.');
      Inhalt := '';
      with TFileStream.Create(GetTempDir + 'planlos-druck.pdf', fmOpenRead) do
      try
        SetLength(Inhalt, Size);
        if Size > 0 then
          ReadBuffer(Inhalt[1], Size);
      finally
        Free;
      end;
      if Copy(Inhalt, 1, 5) <> '%PDF-' then
        Fehlschlag('Die Datei ist kein PDF.');
      if Pos('ANG-1', Inhalt) = 0 then
        Fehlschlag('Die Belegnummer fehlt im PDF.');
      if Pos('bertrag', Inhalt) = 0 then
        Fehlschlag('Der Übertrag auf der Folgeseite fehlt.');
      SetLength(Positionen, 1);
      if not BelegPdfSchreiben(Kopf, Positionen, Vorlage, 'Angebot', 'Admin',
        GetTempDir + 'planlos-druck.pdf', SeitenZahl, FolgeFehler) then
        Fehlschlag(FolgeFehler);
      if SeitenZahl <> 1 then
        Fehlschlag('Eine Position soll auf eine Seite passen.');
      SetLength(Positionen, 0);
      if DB.Ganzzahl(
        'SELECT datensatz_kopieren FROM modulart WHERE kuerzel = ''angebot''') <> 1 then
        Fehlschlag('DatensatzKopieren soll für Angebote an sein.');
      if DB.Ganzzahl(
        'SELECT kopieren_an FROM maske WHERE kuerzel = ''kunde''') <> 1 then
        Fehlschlag('KopierenAn soll für Kunden an sein.');
      if DB.Ganzzahl('SELECT COUNT(*) FROM maske') <> 15 then
        Fehlschlag('Es sollen 15 Masken angelegt sein.');
      if DB.Ganzzahl('SELECT COUNT(*) FROM maskenfeld') < 80 then
        Fehlschlag('Die Maskenfelder fehlen.');
      if DB.Skalar(
        'SELECT links || ''/'' || oben || ''/'' || beschriftung FROM maskenfeld f ' +
        'JOIN maske m ON m.id = f.maske_id WHERE m.kuerzel = ''kunde'' AND f.spalte = ''nachname''')
        <> '79/50/Nachname' then
        Fehlschlag('Nachname steht nicht wie in der alten Maske.');
      if DB.Skalar(
        'SELECT feldart || ''/'' || beschriftung FROM maskenfeld f ' +
        'JOIN maske m ON m.id = f.maske_id WHERE m.kuerzel = ''kunde'' AND f.spalte = ''kategorie''')
        <> 'auswahl/Kategorie>' then
        Fehlschlag('Kategorie soll eine Auswahlliste sein.');
      if DB.Skalar(
        'SELECT hintergrund FROM maskenfeld f JOIN maske m ON m.id = f.maske_id ' +
        'WHERE m.kuerzel = ''kunde'' AND f.spalte = ''firma''') <> 'lime' then
        Fehlschlag('Die Firma soll die grüne Hinterlegung haben.');
      if not FeldSichtbar('kunde', 'firma') then
        Fehlschlag('Die Kundenmaske soll die Firma zeigen.');
      if not FeldSichtbar('kunde', 'rabatt_prozent') then
        Fehlschlag('Die Kundenmaske soll den Rabatt zeigen.');
      if FeldSichtbar('mitarbeiter', 'firma') then
        Fehlschlag('Die Mitarbeitermaske soll die Firma verstecken.');
      if FeldSichtbar('mitarbeiter', 'rabatt_prozent') then
        Fehlschlag('Die Mitarbeitermaske soll den Rabatt verstecken.');
      if FeldSichtbar('lieferant', 'rabatt_prozent') then
        Fehlschlag('Die Lieferantenmaske soll den Rabatt verstecken.');
      if not FeldSichtbar('lieferant', 'telefax') then
        Fehlschlag('Die Lieferantenmaske soll das Telefax zeigen.');
      if not MaskenRecht('Administrator', 'mitarbeiter', 'loeschen') then
        Fehlschlag('Der Administrator darf Mitarbeiter löschen.');
      if MaskenRecht('Gruppenleiter', 'kunde', 'loeschen') then
        Fehlschlag('Der Gruppenleiter darf nicht löschen.');
      if not MaskenRecht('Gruppenleiter', 'kunde', 'neu') then
        Fehlschlag('Der Gruppenleiter darf anlegen.');
      if MaskenRecht('Abteilungsleiter', 'kontakt', 'loeschen') then
        Fehlschlag('Der Abteilungsleiter darf nicht löschen.');

      Werte := TStringList.Create;
      Gelesen := TStringList.Create;
      try
        Werte.Values['vorname'] := 'Eva';
        MitarbeiterId := AdresseSpeichern('mitarbeiter', 0, Werte, Fehler);
        if MitarbeiterId <> 0 then
          Fehlschlag('Ohne Nachname darf kein Mitarbeiter entstehen.');
        Werte.Values['nachname'] := 'Meier';
        MitarbeiterId := AdresseSpeichern('mitarbeiter', 0, Werte, Fehler);
        if MitarbeiterId = 0 then
          Fehlschlag(Fehler);
        Werte.Clear;
        Werte.Values['firma'] := 'Müller GmbH';
        Werte.Values['nachname'] := 'Müller';
        Werte.Values['rabatt_prozent'] := '5,5';
        Werte.Values['frei1'] := 'Regal 3';
        Werte.Values['telefon_privat'] := '040-1';
        KundeId := AdresseSpeichern('kunde', 0, Werte, Fehler);
        if KundeId = 0 then
          Fehlschlag(Fehler);
        if TrefferZahl('kunde', 'Meier') <> 0 then
          Fehlschlag('Meier ist als Kunde sichtbar.');
        if TrefferZahl('mitarbeiter', 'Meier') <> 1 then
          Fehlschlag('Meier ist als Mitarbeiter nicht auffindbar.');
        if TrefferZahl('kunde', 'Müller') <> 1 then
          Fehlschlag('Müller ist als Kunde nicht auffindbar.');
        if TrefferZahl('mitarbeiter', 'Müller') <> 0 then
          Fehlschlag('Müller ist als Mitarbeiter sichtbar.');
        if TrefferZahl('lieferant', '') <> 0 then
          Fehlschlag('Die Lieferantensuche ist nicht leer.');
        AdresseLesen(KundeId, Gelesen);
        FS := DefaultFormatSettings;
        FS.DecimalSeparator := '.';
        if not TryStrToFloat(StringReplace(Gelesen.Values['rabatt_prozent'],
          ',', '.', []), Rabatt, FS) then
          Fehlschlag('Rabatt nicht lesbar: ' + Gelesen.Values['rabatt_prozent']);
        if Abs(Rabatt - 5.5) > 0.001 then
          Fehlschlag('Rabatt falsch gespeichert: ' + Gelesen.Values['rabatt_prozent']);
        if Gelesen.Values['frei1'] <> 'Regal 3' then
          Fehlschlag('Frei1 wurde nicht gespeichert.');
        if Gelesen.Values['telefon_privat'] <> '040-1' then
          Fehlschlag('Tel_Privat wurde nicht gespeichert.');
      finally
        Gelesen.Free;
        Werte.Free;
      end;

      Tasten := TastenLaden('kunde', 'suche');
      if not TasteFinden(Tasten, 1, 2, Aktion, Erlaubt) or (Aktion <> 'neu') or
         not Erlaubt then
        Fehlschlag('F2 der Kundensuche soll Neu und freigeschaltet sein.');
      Tasten := TastenLaden('kontakt', 'suche');
      if not TasteFinden(Tasten, 1, 8, Aktion, Erlaubt) or Erlaubt then
        Fehlschlag('Bei Kontakten ist Löschen in der Tastenbelegung aus.');
      Tasten := TastenLaden('kunde', 'eingabe');
      if not TasteFinden(Tasten, 1, 10, Aktion, Erlaubt) or (Aktion <> 'speichern') then
        Fehlschlag('F10 der Eingabe soll Speichern sein.');

      SetLength(Positionen, 2);
      Positionen[0].Text := 'Beratung';
      Positionen[0].MengeMilli := 1000;
      Positionen[0].Einheit := 'Stück';
      Positionen[0].EinzelpreisCent := 1001;
      Positionen[0].MwstSatz := 19;
      Positionen[1].Text := 'Material';
      Positionen[1].MengeMilli := 2500;
      Positionen[1].Einheit := 'Stück';
      Positionen[1].EinzelpreisCent := 333;
      Positionen[1].MwstSatz := 7;
      if PositionNetto(Positionen[0]) <> 1001 then
        Fehlschlag('Netto der ersten Position ist falsch.');
      if PositionNetto(Positionen[1]) <> 833 then
        Fehlschlag('Netto der zweiten Position rundet nicht kaufmännisch.');
      Summe := SummeRechnen(Positionen, True);
      if Summe.NettoCent <> 1834 then
        Fehlschlag('Netto gesamt ist ' + IntToStr(Summe.NettoCent));
      if Summe.SteuerCent <> 248 then
        Fehlschlag('MwSt gesamt ist ' + IntToStr(Summe.SteuerCent));
      if Summe.BruttoCent <> 2082 then
        Fehlschlag('Brutto ist ' + IntToStr(Summe.BruttoCent));
      Kopf.Modulart := 'angebot';
      Kopf.AdresseId := KundeId;
      Kopf.Bezeichnung := 'Testangebot';
      Kopf.Id := 0;
      AngebotId := BelegSpeichern(Kopf, Positionen, FolgeFehler);
      if AngebotId = 0 then
        Fehlschlag(FolgeFehler);
      if BelegNummer(AngebotId) <> 'ANG-1' then
        Fehlschlag('Angebotsnummer ist ' + BelegNummer(AngebotId));
      if BelegartEinstellungLoeschen(1, FolgeFehler) then
        Fehlschlag('Eine benutzte Belegart wurde gelöscht.')
      else if Pos('Belege', FolgeFehler) = 0 then
        Fehlschlag('Die Meldung beim Löschen der Belegart ist unklar: ' + FolgeFehler);
      KopieId := BelegartEinstellungKopieren(1, FolgeFehler);
      if KopieId = 0 then
        Fehlschlag(FolgeFehler);
      if not BelegartEinstellungLoeschen(KopieId, FolgeFehler) then
        Fehlschlag(FolgeFehler);
      RechnungId := FolgebelegErzeugen(AngebotId, 'rechnung', FolgeFehler);
      if RechnungId = 0 then
        Fehlschlag(FolgeFehler);
      if BelegNummer(RechnungId) <> 'RE-1' then
        Fehlschlag('Rechnungsnummer ist ' + BelegNummer(RechnungId));
      if not BelegLaden(RechnungId, Kopf, Positionen) then
        Fehlschlag('Die Rechnung lässt sich nicht lesen.');
      if Kopf.BezugNummer <> 'ANG-1' then
        Fehlschlag('Die Rechnung merkt sich das Angebot nicht.');
      if Length(Positionen) <> 2 then
        Fehlschlag('Die Rechnung hat die Positionen nicht übernommen.');
      Summe := SummeRechnen(Positionen, Kopf.MwstRechnen);
      if Summe.BruttoCent <> 2082 then
        Fehlschlag('Die Rechnungssumme weicht ab.');
      if (Positionen[0].MwstSatz <> 19) or (Positionen[1].MwstSatz <> 7) then
        Fehlschlag('Die Steuersätze wurden nicht kopiert.');
      Kopf.Id := 0;
      Kopf.Modulart := 'angebot';
      Kopf.AdresseId := KundeId;
      Kopf.Bezeichnung := 'Zweites Angebot';
      Kopf.BezugId := 0;
      SetLength(Positionen, 0);
      ZweitesId := BelegSpeichern(Kopf, Positionen, FolgeFehler);
      if ZweitesId = 0 then
        Fehlschlag(FolgeFehler);
      if BelegNummer(ZweitesId) <> 'ANG-2' then
        Fehlschlag('Das zweite Angebot hat die Nummer ' + BelegNummer(ZweitesId));
      KopieId := BelegKopieren(AngebotId, FolgeFehler);
      if KopieId = 0 then
        Fehlschlag(FolgeFehler);
      if BelegNummer(KopieId) <> 'ANG-3' then
        Fehlschlag('Die Kopie hat die Nummer ' + BelegNummer(KopieId));
      if not BelegLaden(KopieId, Kopf, Positionen) then
        Fehlschlag('Die Kopie lässt sich nicht lesen.');
      if (Kopf.Bezeichnung <> 'Testangebot') or (Length(Positionen) <> 2) then
        Fehlschlag('Die Kopie übernimmt Kopf oder Positionen nicht.');
      if not BelegLoeschen(KopieId, FolgeFehler) then
        Fehlschlag(FolgeFehler);
      if BelegLaden(KopieId, Kopf, Positionen) then
        Fehlschlag('Der gelöschte Beleg ist noch da.');
      if FolgebelegErzeugen(AngebotId, 'bestellung', FolgeFehler) <> 0 then
        Fehlschlag('Aus einem Angebot darf keine Bestellung entstehen.');
      if not BelegartLaden('bestellung', Art) or (Art.EmpfaengerMaske <> 'lieferant') then
        Fehlschlag('Eine Bestellung sucht den Lieferanten.');
      if not BelegartLaden('projekt', Art) or Art.Summe or Art.Mwst or Art.Positionen then
        Fehlschlag('Ein Projekt hat keine Positionen und keine MwSt.');
      if not Art.Intern then
        Fehlschlag('Ein Projekt zeigt den internen Bereich.');
      if not BelegartLaden('angebot', Art) or (Art.Breite <> 793) or
         (Art.ZeichenText <> 'Ihr Zeichen:') or not Art.ZeigeKopftext then
        Fehlschlag('Die Angebotsmaske hat nicht die alten Maße oder Felder.');
      if BereichHoehe('summe', False) <> 23 then
        Fehlschlag('Zugeklappte Summen dürfen nicht die Fußhöhe bekommen.');
      if BereichHoehe('fuss', False) <> 17 then
        Fehlschlag('Der zugeklappte Fuß ist 17 hoch.');
      if BereichHoehe('summe', True) <> 94 then
        Fehlschlag('Offene Summen sind 94 hoch.');
      if VkCent(1000, 1500, 0) <> 1150 then
        Fehlschlag('15 Prozent auf 10 Euro sind nicht 11,50.');
      if VkCent(1000, 1500, 1000) <> 1035 then
        Fehlschlag('10 Prozent Rabatt auf 11,50 Euro sind nicht 10,35.');
      SetLength(Positionen, 1);
      Positionen[0] := Default(TBelegPosition);
      Positionen[0].MengeMilli := 1000;
      Positionen[0].EkCent := 1000;
      Positionen[0].EinzelpreisCent := 1150;
      if InternRechnen(Positionen).GewinnCent <> 150 then
        Fehlschlag('Der Gewinn aus 10 Euro EK und 11,50 VK ist nicht 1,50.');
      KlappMerken('Admin', 1, 'summe', False);
      if KlappOffen('Admin', 1, 'summe', True) then
        Fehlschlag('Der zugeklappte Bereich wurde nicht gemerkt.');
      if not BelegLaden(AngebotId, Kopf, Positionen) then
        Fehlschlag('Das Angebot lässt sich für den Preis nicht lesen.');
      Positionen[0].EkCent := 2500;
      Positionen[0].AufschlagBp := 1000;
      Positionen[0].RabattBp := 500;
      Kopf.IhrZeichen := 'AZ-9';
      if BelegSpeichern(Kopf, Positionen, FolgeFehler) = 0 then
        Fehlschlag(FolgeFehler);
      if not BelegLaden(AngebotId, Kopf, Positionen) then
        Fehlschlag('Das Angebot lässt sich nach dem Preis nicht lesen.');
      if (Positionen[0].EkCent <> 2500) or (Positionen[0].AufschlagBp <> 1000) or
         (Positionen[0].RabattBp <> 500) or (Kopf.IhrZeichen <> 'AZ-9') then
        Fehlschlag('EK, Aufschlag, Rabatt oder Ihr Zeichen bleiben nicht stehen.');
      if SummeRechnen(Positionen, Kopf.MwstRechnen).BruttoCent <> 2082 then
        Fehlschlag('Der gespeicherte EK darf die VK-Summe nicht ändern.');
      Positionen[0].EkCent := 0;
      Positionen[0].AufschlagBp := 0;
      Positionen[0].RabattBp := 0;
      Kopf.IhrZeichen := '';
      if BelegSpeichern(Kopf, Positionen, FolgeFehler) = 0 then
        Fehlschlag(FolgeFehler);
      if BelegAnzahl('angebot', 'Meier') <> 0 then
        Fehlschlag('Die Belegsuche findet einen falschen Namen.');
      if BelegAnzahl('angebot', 'ANG-1') <> 1 then
        Fehlschlag('Die Belegsuche findet ANG-1 nicht.');
      if BelegAnzahl('rechnung', '') <> 1 then
        Fehlschlag('Es soll genau eine Rechnung geben.');

      if not Anmelden('Admin', '0000', Meldung) then
        Fehlschlag('Anmeldung Admin/0000: ' + Meldung);
      if not Anmelden('Admin', '9999', Meldung) then
      begin
        if Pos('Passwort', Meldung) = 0 then
          Fehlschlag('Falsches Passwort ohne klare Meldung: ' + Meldung);
      end
      else
        Fehlschlag('Ein falsches Passwort wurde angenommen.');
      if Anmelden('Niemand', '0000', Meldung) then
        Fehlschlag('Einen unbekannten Anwender gibt es nicht.')
      else if Pos('Anwender', Meldung) = 0 then
        Fehlschlag('Unbekannter Anwender ohne klare Meldung: ' + Meldung);
      if not Anmelden('Admin', '0000', Meldung) then
        Fehlschlag('Die zweite Anmeldung schlägt fehl: ' + Meldung);
      if not AktionZulaessig('maske', 'mitarbeiter', 'loeschen', Meldung) then
        Fehlschlag('Admin darf Mitarbeiter löschen: ' + Meldung);
      if not AktionZulaessig('beleg', 'rechnung', 'drucken', Meldung) then
        Fehlschlag('Admin darf drucken: ' + Meldung);
      if not AktionZulaessig('beleg', 'angebot', 'kopieren', Meldung) then
        Fehlschlag('Admin darf Angebote kopieren: ' + Meldung);
      if VerkaufspreisCent(1000, 1500) <> 1150 then
        Fehlschlag('15 Prozent auf 10 Euro sind nicht 11,50.');
      if BruttoCent(1150, 19) <> 1369 then
        Fehlschlag('19 Prozent auf 11,50 Euro sind nicht 13,69.');
      if DB.Ganzzahl('SELECT COUNT(*) FROM einheit') <> 4 then
        Fehlschlag('Die vier alten Einheiten fehlen.');
      if DB.Ganzzahl(
        'SELECT COUNT(*) FROM nachschlage WHERE art = ''einheit'' AND bezeichnung = ''Stück''') <> 1 then
        Fehlschlag('Die Einheit Stück wurde nicht in die gemeinsame Liste übernommen.');
      if not NachschlageLoeschen(DB.Ganzzahl(
        'SELECT id FROM nachschlage WHERE art = ''kategorie'' AND bezeichnung = ''Kunde'''),
        FolgeFehler) then
      begin
        if Pos('fest', FolgeFehler) = 0 then
          Fehlschlag('Kunde soll fest sein: ' + FolgeFehler);
      end
      else
        Fehlschlag('Die feste Kategorie Kunde wurde gelöscht.');
      KopieId := NachschlageSpeichern('einheit', 0, 'Testrolle', FolgeFehler);
      if KopieId = 0 then
        Fehlschlag(FolgeFehler);
      DB.Ausfuehren(
        'INSERT INTO artikel (bezeichnung, einheit_ek) VALUES (''Probe'', ''Testrolle'')', nil);
      if NachschlageLoeschen(KopieId, FolgeFehler) then
        Fehlschlag('Eine benutzte Einheit wurde gelöscht.')
      else if Pos('verwendet', FolgeFehler) = 0 then
        Fehlschlag('Die Meldung beim Löschen ist unklar: ' + FolgeFehler);
      DB.Ausfuehren('DELETE FROM artikel WHERE bezeichnung = ''Probe''', nil);
      if not NachschlageLoeschen(KopieId, FolgeFehler) then
        Fehlschlag(FolgeFehler);
      ProjektStamm := Default(TProjekt);
      ProjektStamm.Bezeichnung := 'Probeprojekt';
      KopieId := ProjektSpeichern(ProjektStamm, FolgeFehler);
      if KopieId = 0 then
        Fehlschlag(FolgeFehler);
      SpaltenX := TStringList.Create;
      ZeilenX := TStringList.Create;
      try
        ProjektLesen('', SpaltenX, ZeilenX);
        if ZeilenX.Count <> 1 then
          Fehlschlag('Das Probeprojekt erscheint nicht in der Liste.');
        ProjektLesen('nichts', SpaltenX, ZeilenX);
        if ZeilenX.Count <> 0 then
          Fehlschlag('Der Projektfilter lässt Unpassendes durch.');
      finally
        ZeilenX.Free;
        SpaltenX.Free;
      end;
      DB.Ausfuehren(
        'UPDATE beleg SET projekt_stamm_id = ' + IntToStr(KopieId) +
        ' WHERE id = ' + IntToStr(AngebotId), nil);
      if ProjektLoeschen(KopieId, FolgeFehler) then
        Fehlschlag('Ein benutztes Projekt wurde gelöscht.')
      else if Pos('Belege', FolgeFehler) = 0 then
        Fehlschlag('Die Meldung beim Projektlöschen ist unklar: ' + FolgeFehler);
      DB.Ausfuehren('UPDATE beleg SET projekt_stamm_id = NULL WHERE id = ' +
        IntToStr(AngebotId), nil);
      if not ProjektLoeschen(KopieId, FolgeFehler) then
        Fehlschlag(FolgeFehler);
      Baustein := Default(TTextbaustein);
      Baustein.Textart := 'Kopftext';
      Baustein.Text := 'Guten Tag';
      Baustein.Beschreibung := 'Gruss';
      if TextbausteinSpeichern(Baustein, FolgeFehler) = 0 then
        Fehlschlag(FolgeFehler);
      SpaltenX := TStringList.Create;
      ZeilenX := TStringList.Create;
      try
        TextbausteinLesen('', 'Kopftext', SpaltenX, ZeilenX);
        if ZeilenX.Count <> 1 then
          Fehlschlag('Der Kopftext wird nicht gefunden.');
        TextbausteinLesen('', 'Fusstext', SpaltenX, ZeilenX);
        if ZeilenX.Count <> 0 then
          Fehlschlag('Ein Kopftext erscheint bei den Fußtexten.');
      finally
        ZeilenX.Free;
        SpaltenX.Free;
      end;
      DB.Ausfuehren(
        'UPDATE beleg SET kopf_baustein_id = ' + IntToStr(Baustein.Id) +
        ' WHERE id = ' + IntToStr(AngebotId), nil);
      if TextbausteinLoeschen(Baustein.Id, FolgeFehler) then
        Fehlschlag('Ein benutzter Textbaustein wurde gelöscht.')
      else if Pos('verwendet', FolgeFehler) = 0 then
        Fehlschlag('Die Meldung beim Textlöschen ist unklar: ' + FolgeFehler);
      DB.Ausfuehren(
        'UPDATE beleg SET kopf_baustein_id = NULL WHERE id = ' +
        IntToStr(AngebotId), nil);
      if not TextbausteinLoeschen(Baustein.Id, FolgeFehler) then
        Fehlschlag(FolgeFehler);
      if not AktionZulaessig('maske', 'artikel', 'loeschen', Meldung) then
        Fehlschlag('Admin darf Artikel löschen: ' + Meldung);
      DB.Ausfuehren(
        'UPDATE modulart SET datensatz_kopieren = 0 WHERE kuerzel = ''angebot''', nil);
      if AktionZulaessig('beleg', 'angebot', 'kopieren', Meldung) then
        Fehlschlag('DatensatzKopieren aus schaltet den Knopf nicht ab.');
      DB.Ausfuehren(
        'UPDATE modulart SET datensatz_kopieren = 1 WHERE kuerzel = ''angebot''', nil);
      DB.Ausfuehren(
        'UPDATE maske SET kopieren_an = 0 WHERE kuerzel = ''kunde''', nil);
      if AktionZulaessig('maske', 'kunde', 'kopieren', Meldung) then
        Fehlschlag('KopierenAn aus schaltet die Liste nicht ab.');
      DB.Ausfuehren(
        'UPDATE maske SET kopieren_an = 1 WHERE kuerzel = ''kunde''', nil);
      Sitz := Sitzung;
      Sitz.Rolle := 'Gruppenleiter';
      SitzungSetzen(Sitz);
      if AktionZulaessig('maske', 'mitarbeiter', 'loeschen', Meldung) then
        Fehlschlag('Der Gruppenleiter darf nicht löschen.');
      if not AktionZulaessig('maske', 'kunde', 'neu', Meldung) then
        Fehlschlag('Der Gruppenleiter darf anlegen.');
      if not AktionZulaessig('beleg', 'angebot', 'kopieren', Meldung) then
        Fehlschlag('Der Gruppenleiter darf kopieren.');
      if AktionZulaessig('beleg', 'angebot', 'aendern', Meldung) then
        Fehlschlag('Der Gruppenleiter darf nicht ändern.');
      if AktionZulaessig('beleg', 'rechnung', 'drucken', Meldung) then
        Fehlschlag('Der Gruppenleiter darf nicht drucken.');
      if not Anmelden('Admin', '0000', Meldung) then
        Fehlschlag('Zurück zu Admin: ' + Meldung);

      Filter := Default(TExplorerFilter);
      Filter.Modulart := 'angebot';
      Filter.ModulFilter := mfBezeichnung;
      Filter.Suchtext := 'Testangebot';
      SpaltenX := TStringList.Create;
      ZeilenX := TStringList.Create;
      try
        ExplorerLesen(Filter, SpaltenX, ZeilenX);
        if ZeilenX.Count <> 1 then
          Fehlschlag('Der Explorer findet das Testangebot nicht.');
        if Pos('Admin', ZeilenX[0]) = 0 then
          Fehlschlag('Der Bearbeiter Admin fehlt in der Liste.');
        Filter.ModulFilter := mfNummer;
        Filter.Suchtext := 'ANG-1';
        ExplorerLesen(Filter, SpaltenX, ZeilenX);
        if ZeilenX.Count <> 1 then
          Fehlschlag('Der Explorer findet ANG-1 nicht.');
        Filter := Default(TExplorerFilter);
        Filter.Modulart := 'angebot';
        Filter.Zeitraum := zrJahr;
        Filter.Jahr := StrToIntDef(FormatDateTime('yyyy', Now), 0);
        ExplorerLesen(Filter, SpaltenX, ZeilenX);
        if ZeilenX.Count < 1 then
          Fehlschlag('Der Jahresfilter findet das Angebot nicht.');
        DB.Ausfuehren('UPDATE beleg SET gruppierung = ''Buero'' WHERE nummer = ''ANG-1''', nil);
        Filter.Sonstiges := soGruppe;
        Filter.Gruppe := 'Buero';
        ExplorerLesen(Filter, SpaltenX, ZeilenX);
        if ZeilenX.Count <> 1 then
          Fehlschlag('Der Gruppenfilter findet Buero nicht.');
        Filter.Gruppe := 'Andere';
        ExplorerLesen(Filter, SpaltenX, ZeilenX);
        if ZeilenX.Count <> 0 then
          Fehlschlag('Der Gruppenfilter lässt eine fremde Gruppe durch.');
        Filter := Default(TExplorerFilter);
        Filter.Modulart := 'angebot';
        Filter.Sortierung := 2;
        ExplorerLesen(Filter, SpaltenX, ZeilenX);
        if (ZeilenX.Count < 2) or (Pos('ANG-1', ZeilenX[0]) = 0) then
          Fehlschlag('Die Sortierung nach Nummer stellt ANG-1 nicht nach vorn.');
        Filter.Sortierung := 0;
        ExplorerLesen(Filter, SpaltenX, ZeilenX);
        if (ZeilenX.Count < 2) or (Pos('ANG-2', ZeilenX[0]) = 0) then
          Fehlschlag('Die Standardsortierung stellt das neuere Angebot nicht nach vorn.');
      finally
        ZeilenX.Free;
        SpaltenX.Free;
      end;

      DB.SchemaSicherstellen;
      if TrefferZahl('mitarbeiter', 'Meier') <> 1 then
        Fehlschlag('Der Mitarbeiter wurde vom erneuten Schema verändert.');
      if DB.Ganzzahl('SELECT COUNT(*) FROM maske') <> 15 then
        Fehlschlag('Die Masken wurden verdoppelt.');
      if DB.Ganzzahl('SELECT COUNT(*) FROM benutzer') <> 1 then
        Fehlschlag('Der Anwender wurde beim erneuten Schema verdoppelt.');
    end
    else
    begin
      if DB.Ganzzahl('SELECT COUNT(*) FROM schema_info') < 1 then
        Fehlschlag('schema_info fehlt.');
    end;
    WriteLn(DB.Bericht);
    WriteLn('OK');
  finally
    PlanlosDB := nil;
    DB.Free;
  end;
end.
