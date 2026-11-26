unit utextbaustein;

{ Kopf- und Fußtexte. Textart ist Kopftext oder Fusstext, damit ein späteres
  Belegfenster nur die passende Art aussuchen kann.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils;

type
  TTextbaustein = record
    Id: Int64;
    Modulart: string;
    Benutzer: string;
    Textart: string;
    Beschreibung: string;
    Text: string;
  end;

function TextbausteinLaden(Id: Int64; out Baustein: TTextbaustein): Boolean;
function TextbausteinSpeichern(var Baustein: TTextbaustein; out Fehler: string): Int64;
function TextbausteinLoeschen(Id: Int64; out Fehler: string): Boolean;
function TextbausteinKopieren(Id: Int64; out Fehler: string): Int64;
procedure TextbausteinLesen(const Suchtext, Textart: string; Spalten, Zeilen: TStrings);
function TextbausteinInhalt(Id: Int64): string;
procedure ModulartLesen(const Suchtext: string; Spalten, Zeilen: TStrings);
procedure BenutzerLesen(const Suchtext: string; Spalten, Zeilen: TStrings);
function ListenName(const Kuerzel: string; Id: Int64): string;

implementation

uses
  udatenbank;

function DatenbankBereit: Boolean;
begin
  Result := (PlanlosDB <> nil) and PlanlosDB.Verbunden;
end;

function Muster(const Suchtext: string; Parameter: TStrings): string;
begin
  Parameter.Values['muster'] := '%' + Trim(StringReplace(StringReplace(Suchtext,
    '%', '', [rfReplaceAll]), '_', '', [rfReplaceAll])) + '%';
  if Trim(Suchtext) = '' then
    Parameter.Values['leer'] := '1'
  else
    Parameter.Values['leer'] := '0';
  Result := '(:leer = ''1'' OR beschreibung LIKE :muster OR textart LIKE :muster ' +
    'OR modulart LIKE :muster)';
end;

function TextbausteinLaden(Id: Int64; out Baustein: TTextbaustein): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  Baustein := Default(TTextbaustein);
  if not DatenbankBereit then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT id, modulart, benutzer, textart, beschreibung, inhalt FROM textbaustein ' +
      'WHERE id = :id', Parameter, Zeile);
    if Zeile.Count = 0 then
      Exit;
    Baustein.Id := StrToInt64Def(Zeile.Values['id'], 0);
    Baustein.Modulart := Zeile.Values['modulart'];
    Baustein.Benutzer := Zeile.Values['benutzer'];
    Baustein.Textart := Zeile.Values['textart'];
    Baustein.Beschreibung := Zeile.Values['beschreibung'];
    Baustein.Text := Zeile.Values['inhalt'];
    Result := True;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function TextbausteinSpeichern(var Baustein: TTextbaustein; out Fehler: string): Int64;
var
  Parameter: TStringList;
begin
  Result := 0;
  Fehler := '';
  if Trim(Baustein.Text) = '' then
  begin
    Fehler := 'Der Textbaustein ist leer.';
    Exit;
  end;
  if (Baustein.Textart <> 'Kopftext') and (Baustein.Textart <> 'Fusstext') then
  begin
    Fehler := 'Die Textart ist Kopftext oder Fusstext.';
    Exit;
  end;
  if Trim(Baustein.Beschreibung) = '' then
    Baustein.Beschreibung := Copy(Trim(Baustein.Text), 1, 60);
  if Baustein.Modulart = '' then
    Baustein.Modulart := 'Standard';
  if not DatenbankBereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  Parameter := TStringList.Create;
  try
    Parameter.Values['modul'] := Baustein.Modulart;
    Parameter.Values['benutzer'] := Baustein.Benutzer;
    Parameter.Values['art'] := Baustein.Textart;
    Parameter.Values['beschreibung'] := Baustein.Beschreibung;
    Parameter.Values['inhalt'] := Baustein.Text;
    if Baustein.Id = 0 then
    begin
      PlanlosDB.Ausfuehren(
        'INSERT INTO textbaustein (modulart, benutzer, textart, beschreibung, inhalt) ' +
        'VALUES (:modul, :benutzer, :art, :beschreibung, :inhalt)', Parameter);
      Result := StrToInt64Def(Trim(PlanlosDB.Skalar('SELECT last_insert_rowid()')), 0);
    end
    else
    begin
      Parameter.Values['id'] := IntToStr(Baustein.Id);
      if PlanlosDB.Ausfuehren(
        'UPDATE textbaustein SET modulart = :modul, benutzer = :benutzer, ' +
        'textart = :art, beschreibung = :beschreibung, inhalt = :inhalt WHERE id = :id',
        Parameter) < 1 then
      begin
        Fehler := 'Der Textbaustein wurde nicht gefunden.';
        Exit;
      end;
      Result := Baustein.Id;
    end;
    if Result = 0 then
      Fehler := 'Der Textbaustein wurde nicht gespeichert.'
    else
      Baustein.Id := Result;
  finally
    Parameter.Free;
  end;
end;

function TextbausteinLoeschen(Id: Int64; out Fehler: string): Boolean;
var
  Parameter: TStringList;
begin
  Fehler := '';
  Result := False;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    if StrToIntDef(PlanlosDB.SkalarMit(
      'SELECT COUNT(*) FROM beleg WHERE kopf_baustein_id = :id OR fuss_baustein_id = :id',
      Parameter), 0) > 0 then
    begin
      Fehler := 'Der Textbaustein wird noch in einem Beleg verwendet.';
      Exit;
    end;
    Result := PlanlosDB.Ausfuehren(
      'DELETE FROM textbaustein WHERE id = :id', Parameter) > 0;
    if not Result then
      Fehler := 'Der Textbaustein konnte nicht gelöscht werden.';
  finally
    Parameter.Free;
  end;
end;

function TextbausteinKopieren(Id: Int64; out Fehler: string): Int64;
var
  Baustein: TTextbaustein;
begin
  Result := 0;
  if not TextbausteinLaden(Id, Baustein) then
  begin
    Fehler := 'Der Textbaustein wurde nicht gefunden.';
    Exit;
  end;
  Baustein.Id := 0;
  Baustein.Beschreibung := Baustein.Beschreibung + ' Kopie';
  Result := TextbausteinSpeichern(Baustein, Fehler);
end;

procedure TextbausteinLesen(const Suchtext, Textart: string; Spalten, Zeilen: TStrings);
var
  Parameter: TStringList;
  SQL: string;
begin
  Spalten.Clear;
  Zeilen.Clear;
  if not DatenbankBereit then
    Exit;
  Parameter := TStringList.Create;
  try
    SQL := 'SELECT id, beschreibung, textart, modulart FROM textbaustein WHERE ' +
      Muster(Suchtext, Parameter);
    if (Textart = 'Kopftext') or (Textart = 'Fusstext') then
    begin
      SQL := SQL + ' AND textart = :art';
      Parameter.Values['art'] := Textart;
    end;
    SQL := SQL + ' ORDER BY textart, beschreibung, id';
    PlanlosDB.AlleZeilen(SQL, Parameter, Spalten, Zeilen);
  finally
    Parameter.Free;
  end;
  Spalten.Clear;
  Spalten.Add('id');
  Spalten.Add('Beschreibung');
  Spalten.Add('Textart');
  Spalten.Add('Modulart');
end;

function TextbausteinInhalt(Id: Int64): string;
var
  Baustein: TTextbaustein;
begin
  if TextbausteinLaden(Id, Baustein) then
    Result := Baustein.Text
  else
    Result := '';
end;

procedure ModulartLesen(const Suchtext: string; Spalten, Zeilen: TStrings);
var
  Parameter: TStringList;
begin
  Spalten.Clear;
  Zeilen.Clear;
  if not DatenbankBereit then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['muster'] := '%' + Trim(Suchtext) + '%';
    if Trim(Suchtext) = '' then
      Parameter.Values['leer'] := '1'
    else
      Parameter.Values['leer'] := '0';
    PlanlosDB.AlleZeilen(
      'SELECT id, bezeichnung FROM modulart WHERE aktiv = 1 AND ' +
      '(:leer = ''1'' OR bezeichnung LIKE :muster OR kuerzel LIKE :muster) ' +
      'ORDER BY sortierung, id', Parameter, Spalten, Zeilen);
  finally
    Parameter.Free;
  end;
  Spalten.Clear;
  Spalten.Add('id');
  Spalten.Add('Modulart');
end;

procedure BenutzerLesen(const Suchtext: string; Spalten, Zeilen: TStrings);
var
  Parameter: TStringList;
begin
  Spalten.Clear;
  Zeilen.Clear;
  if not DatenbankBereit then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['muster'] := '%' + Trim(Suchtext) + '%';
    if Trim(Suchtext) = '' then
      Parameter.Values['leer'] := '1'
    else
      Parameter.Values['leer'] := '0';
    PlanlosDB.AlleZeilen(
      'SELECT id, name FROM benutzer WHERE aktiv = 1 AND ' +
      '(:leer = ''1'' OR name LIKE :muster) ORDER BY name, id',
      Parameter, Spalten, Zeilen);
  finally
    Parameter.Free;
  end;
  Spalten.Clear;
  Spalten.Add('id');
  Spalten.Add('Benutzer');
end;

function ListenName(const Kuerzel: string; Id: Int64): string;
var
  Parameter: TStringList;
  SQL: string;
begin
  Result := '';
  if Kuerzel = 'modulart' then
    SQL := 'SELECT bezeichnung FROM modulart WHERE id = :id'
  else if Kuerzel = 'benutzer' then
    SQL := 'SELECT name FROM benutzer WHERE id = :id'
  else
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    Result := PlanlosDB.SkalarMit(SQL, Parameter);
  finally
    Parameter.Free;
  end;
end;

end.
