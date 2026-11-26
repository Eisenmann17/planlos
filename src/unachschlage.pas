unit unachschlage;

{ Eine Liste für Einheit, Kategorie, Gruppierung und Stücklistengruppe.
  Die Art steht im Feld art, wie früher jede Tabelle für sich, nur gemeinsam
  geführt.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils;

function NachschlageArt(const Kuerzel: string): Boolean;
function NachschlageBeschriftung(const Kuerzel: string): string;
procedure NachschlageLesen(const Kuerzel, Suchtext: string; Spalten, Zeilen: TStrings);
function NachschlageName(Id: Int64): string;
function NachschlageSpeichern(const Kuerzel: string; Id: Int64; const Name: string;
  out Fehler: string): Int64;
function NachschlageLoeschen(Id: Int64; out Fehler: string): Boolean;
function NachschlageKopieren(Id: Int64; out Fehler: string): Int64;

implementation

uses
  udatenbank;

function DatenbankBereit: Boolean;
begin
  Result := (PlanlosDB <> nil) and PlanlosDB.Verbunden;
end;

function NachschlageArt(const Kuerzel: string): Boolean;
begin
  Result := (Kuerzel = 'einheit') or (Kuerzel = 'kategorie') or
    (Kuerzel = 'gruppierung') or (Kuerzel = 'stuecklistengruppe');
end;

function NachschlageBeschriftung(const Kuerzel: string): string;
begin
  if Kuerzel = 'einheit' then
    Result := 'Einheit:'
  else if Kuerzel = 'kategorie' then
    Result := 'Kategorie:'
  else if Kuerzel = 'gruppierung' then
    Result := 'Gruppierung:'
  else if Kuerzel = 'stuecklistengruppe' then
    Result := 'Stücklistengruppe:'
  else
    Result := 'Name:';
end;

function NachschlageSpalte(const Kuerzel: string): string;
begin
  if Kuerzel = 'einheit' then
    Result := 'Einheit'
  else if Kuerzel = 'kategorie' then
    Result := 'Kategorie'
  else if Kuerzel = 'gruppierung' then
    Result := 'Gruppierung'
  else
    Result := 'Stücklistengruppe';
end;

procedure NachschlageLesen(const Kuerzel, Suchtext: string; Spalten, Zeilen: TStrings);
var
  Parameter: TStringList;
begin
  Spalten.Clear;
  Zeilen.Clear;
  if not DatenbankBereit then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['art'] := Kuerzel;
    Parameter.Values['muster'] := '%' + Trim(StringReplace(StringReplace(Suchtext,
      '%', '', [rfReplaceAll]), '_', '', [rfReplaceAll])) + '%';
    if Trim(Suchtext) = '' then
      Parameter.Values['leer'] := '1'
    else
      Parameter.Values['leer'] := '0';
    PlanlosDB.AlleZeilen(
      'SELECT id, bezeichnung FROM nachschlage WHERE art = :art AND ' +
      '(:leer = ''1'' OR bezeichnung LIKE :muster) ORDER BY bezeichnung, id',
      Parameter, Spalten, Zeilen);
  finally
    Parameter.Free;
  end;
  Spalten.Clear;
  Spalten.Add('id');
  Spalten.Add(NachschlageSpalte(Kuerzel));
end;

function NachschlageName(Id: Int64): string;
var
  Parameter: TStringList;
begin
  Result := '';
  if not DatenbankBereit then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    Result := PlanlosDB.SkalarMit(
      'SELECT bezeichnung FROM nachschlage WHERE id = :id', Parameter);
  finally
    Parameter.Free;
  end;
end;

function Zeile(const SQL, Name: string): string;
var
  Parameter: TStringList;
begin
  Parameter := TStringList.Create;
  try
    Parameter.Values['name'] := Name;
    Result := PlanlosDB.SkalarMit(SQL, Parameter);
  finally
    Parameter.Free;
  end;
end;

function Verwendungszahl(const Art, Name: string): Integer;
begin
  Result := 0;
  if not DatenbankBereit then
    Exit;
  if Art = 'einheit' then
  begin
    Result := StrToIntDef(Zeile(
      'SELECT COUNT(*) FROM artikel WHERE einheit_ek = :name OR einheit_menge = :name',
      Name), 0);
    Result := Result + StrToIntDef(Zeile(
      'SELECT COUNT(*) FROM artikelgruppe WHERE vorgabe_einheit_ek = :name OR ' +
      'vorgabe_einheit_menge = :name', Name), 0);
  end
  else if Art = 'kategorie' then
    Result := StrToIntDef(Zeile(
      'SELECT COUNT(*) FROM adresskategorie WHERE bezeichnung = :name', Name), 0)
  else if Art = 'gruppierung' then
    Result := StrToIntDef(Zeile(
      'SELECT COUNT(*) FROM beleg WHERE gruppierung = :name', Name), 0);
end;

procedure VerweiseUmbenennen(const Art, Alt, Neu: string);
var
  Parameter: TStringList;
begin
  if (Alt = '') or (Alt = Neu) then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['alt'] := Alt;
    Parameter.Values['neu'] := Neu;
    if Art = 'einheit' then
    begin
      PlanlosDB.Ausfuehren(
        'UPDATE artikel SET einheit_ek = :neu WHERE einheit_ek = :alt', Parameter);
      PlanlosDB.Ausfuehren(
        'UPDATE artikel SET einheit_menge = :neu WHERE einheit_menge = :alt', Parameter);
      PlanlosDB.Ausfuehren(
        'UPDATE artikelgruppe SET vorgabe_einheit_ek = :neu WHERE vorgabe_einheit_ek = :alt',
        Parameter);
      PlanlosDB.Ausfuehren(
        'UPDATE artikelgruppe SET vorgabe_einheit_menge = :neu ' +
        'WHERE vorgabe_einheit_menge = :alt', Parameter);
    end
    else if Art = 'gruppierung' then
      PlanlosDB.Ausfuehren(
        'UPDATE beleg SET gruppierung = :neu WHERE gruppierung = :alt', Parameter);
  finally
    Parameter.Free;
  end;
end;

function NachschlageSpeichern(const Kuerzel: string; Id: Int64; const Name: string;
  out Fehler: string): Int64;
var
  Parameter, Zeile: TStringList;
  Alt, Fest: string;
begin
  Result := 0;
  Fehler := '';
  if Trim(Name) = '' then
  begin
    Fehler := 'Der Name darf nicht leer sein.';
    Exit;
  end;
  if not DatenbankBereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Alt := '';
    Fest := '0';
    if Id > 0 then
    begin
      Parameter.Values['id'] := IntToStr(Id);
      PlanlosDB.ErsteZeile(
        'SELECT bezeichnung, nur_lesen, art FROM nachschlage WHERE id = :id',
        Parameter, Zeile);
      if Zeile.Count = 0 then
      begin
        Fehler := 'Der Eintrag wurde nicht gefunden.';
        Exit;
      end;
      Alt := Zeile.Values['bezeichnung'];
      Fest := Zeile.Values['nur_lesen'];
      if (Fest = '1') and (Trim(Name) <> Alt) then
      begin
        Fehler := 'Dieser Wert ist fest und kann nicht umbenannt werden.';
        Exit;
      end;
    end;
    Parameter.Values['name'] := Trim(Name);
    Parameter.Values['art'] := Kuerzel;
    if Id = 0 then
    begin
      PlanlosDB.Ausfuehren(
        'INSERT INTO nachschlage (art, bezeichnung, nur_lesen) VALUES (:art, :name, 0)',
        Parameter);
      Result := StrToInt64Def(Trim(PlanlosDB.Skalar('SELECT last_insert_rowid()')), 0);
    end
    else
    begin
      VerweiseUmbenennen(Kuerzel, Alt, Trim(Name));
      if PlanlosDB.Ausfuehren(
        'UPDATE nachschlage SET bezeichnung = :name WHERE id = :id', Parameter) < 1 then
      begin
        Fehler := 'Der Eintrag wurde nicht gespeichert.';
        Exit;
      end;
      Result := Id;
    end;
    if Result = 0 then
      Fehler := 'Der Eintrag wurde nicht gespeichert.';
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function NachschlageLoeschen(Id: Int64; out Fehler: string): Boolean;
var
  Parameter, Zeile: TStringList;
  Name, Art: string;
begin
  Fehler := '';
  Result := False;
  if not DatenbankBereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT art, bezeichnung, nur_lesen FROM nachschlage WHERE id = :id',
      Parameter, Zeile);
    if Zeile.Count = 0 then
    begin
      Fehler := 'Der Eintrag wurde nicht gefunden.';
      Exit;
    end;
    Art := Zeile.Values['art'];
    Name := Zeile.Values['bezeichnung'];
    if Zeile.Values['nur_lesen'] = '1' then
    begin
      Fehler := 'Dieser Wert ist fest und kann nicht gelöscht werden.';
      Exit;
    end;
    if Verwendungszahl(Art, Name) > 0 then
    begin
      Fehler := '"' + Name + '" wird noch verwendet und kann nicht gelöscht werden.';
      Exit;
    end;
    Result := PlanlosDB.Ausfuehren(
      'DELETE FROM nachschlage WHERE id = :id', Parameter) > 0;
    if not Result then
      Fehler := 'Der Eintrag konnte nicht gelöscht werden.';
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function NachschlageKopieren(Id: Int64; out Fehler: string): Int64;
var
  Name, Art: string;
  Parameter, Zeile: TStringList;
begin
  Result := 0;
  Fehler := '';
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT art, bezeichnung FROM nachschlage WHERE id = :id', Parameter, Zeile);
    if Zeile.Count = 0 then
    begin
      Fehler := 'Der Eintrag wurde nicht gefunden.';
      Exit;
    end;
    Art := Zeile.Values['art'];
    Name := Zeile.Values['bezeichnung'] + ' Kopie';
    Result := NachschlageSpeichern(Art, 0, Name, Fehler);
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

end.
