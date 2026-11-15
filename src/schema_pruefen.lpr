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
  udatenbank, umaske;

var
  DB: TPlanlosDatenbank;
  Pfad, Id1, Eltern, Name, Fehler, Aktion: string;
  Frisch, Erlaubt: Boolean;
  Werte, Gelesen: TStringList;
  MitarbeiterId, KundeId: Int64;
  Tasten: TTastenListe;
  FS: TFormatSettings;
  Rabatt: Double;

  procedure Fehlschlag(const Text: string);
  begin
    WriteLn(StdErr, 'Fehler: ', Text);
    Halt(1);
  end;

begin
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
      if DB.Ganzzahl('SELECT COUNT(*) FROM adresse') <> 0 then
        Fehlschlag('Die Adressliste soll leer starten.');
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
      if DB.Ganzzahl('SELECT version FROM schema_info WHERE id = 1') <> 2 then
        Fehlschlag('Das Schema soll auf Version 2 stehen.');
      if DB.Ganzzahl('SELECT COUNT(*) FROM maske') <> 4 then
        Fehlschlag('Es sollen 4 Kontaktmasken angelegt sein.');
      if DB.Ganzzahl('SELECT COUNT(*) FROM maskenfeld') < 56 then
        Fehlschlag('Die Maskenfelder fehlen.');
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

      DB.SchemaSicherstellen;
      if TrefferZahl('mitarbeiter', 'Meier') <> 1 then
        Fehlschlag('Der Mitarbeiter wurde vom erneuten Schema verändert.');
      if DB.Ganzzahl('SELECT COUNT(*) FROM maske') <> 4 then
        Fehlschlag('Die Masken wurden verdoppelt.');
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
