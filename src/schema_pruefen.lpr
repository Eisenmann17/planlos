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
  SysUtils,
  udatenbank;

var
  DB: TPlanlosDatenbank;
  Pfad, Id1, Eltern, Name: string;
  Frisch: Boolean;

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
    end
    else
    begin
      if DB.Ganzzahl('SELECT COUNT(*) FROM schema_info') < 1 then
        Fehlschlag('schema_info fehlt.');
    end;
    WriteLn(DB.Bericht);
    WriteLn('OK');
  finally
    DB.Free;
  end;
end.
