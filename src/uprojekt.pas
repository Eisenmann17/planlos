unit uprojekt;

{ Projekte wie in der alten Maske: Bezeichnung, Kunde, Gruppierung,
  Bearbeiter, Beschreibung und die beiden Daten.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils;

type
  TProjekt = record
    Id: Int64;
    Bezeichnung: string;
    KundeId: Int64;
    Kunde: string;
    Gruppierung: string;
    BearbeiterId: Int64;
    Bearbeiter: string;
    Notiz: string;
    Erfasst: string;
    Geaendert: string;
  end;

function Heute: string;
function ProjektLaden(Id: Int64; out Projekt: TProjekt): Boolean;
function ProjektSpeichern(var Projekt: TProjekt; out Fehler: string): Int64;
function ProjektLoeschen(Id: Int64; out Fehler: string): Boolean;
function ProjektKopieren(Id: Int64; out Fehler: string): Int64;
procedure ProjektLesen(const Suchtext: string; Spalten, Zeilen: TStrings);

implementation

uses
  udatenbank, ubeleg;

function DatenbankBereit: Boolean;
begin
  Result := (PlanlosDB <> nil) and PlanlosDB.Verbunden;
end;

function Heute: string;
begin
  Result := FormatDateTime('yyyy-mm-dd', Date);
end;

function ProjektLaden(Id: Int64; out Projekt: TProjekt): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  Projekt := Default(TProjekt);
  if not DatenbankBereit then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT id, bezeichnung, kunde_id, gruppierung, bearbeiter_id, notiz, ' +
      'erfasst, geaendert FROM projekt WHERE id = :id', Parameter, Zeile);
    if Zeile.Count = 0 then
      Exit;
    Projekt.Id := StrToInt64Def(Zeile.Values['id'], 0);
    Projekt.Bezeichnung := Zeile.Values['bezeichnung'];
    Projekt.KundeId := StrToInt64Def(Zeile.Values['kunde_id'], 0);
    Projekt.Kunde := AdressKurzname(Projekt.KundeId);
    Projekt.Gruppierung := Zeile.Values['gruppierung'];
    Projekt.BearbeiterId := StrToInt64Def(Zeile.Values['bearbeiter_id'], 0);
    Projekt.Bearbeiter := AdressKurzname(Projekt.BearbeiterId);
    Projekt.Notiz := Zeile.Values['notiz'];
    Projekt.Erfasst := Zeile.Values['erfasst'];
    Projekt.Geaendert := Zeile.Values['geaendert'];
    Result := True;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function ProjektSpeichern(var Projekt: TProjekt; out Fehler: string): Int64;
var
  Parameter: TStringList;
begin
  Result := 0;
  Fehler := '';
  if Trim(Projekt.Bezeichnung) = '' then
  begin
    Fehler := 'Das Projekt braucht eine Bezeichnung.';
    Exit;
  end;
  if not DatenbankBereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  if Projekt.Erfasst = '' then
    Projekt.Erfasst := Heute;
  Projekt.Geaendert := Heute;
  Parameter := TStringList.Create;
  try
    Parameter.Values['name'] := Trim(Projekt.Bezeichnung);
    if Projekt.KundeId = 0 then
      Parameter.Values['kunde'] := ''
    else
      Parameter.Values['kunde'] := IntToStr(Projekt.KundeId);
    Parameter.Values['gruppe'] := Projekt.Gruppierung;
    if Projekt.BearbeiterId = 0 then
      Parameter.Values['bearbeiter'] := ''
    else
      Parameter.Values['bearbeiter'] := IntToStr(Projekt.BearbeiterId);
    Parameter.Values['notiz'] := Projekt.Notiz;
    Parameter.Values['erfasst'] := Projekt.Erfasst;
    Parameter.Values['geaendert'] := Projekt.Geaendert;
    if Projekt.Id = 0 then
    begin
      PlanlosDB.Ausfuehren(
        'INSERT INTO projekt (bezeichnung, kunde_id, gruppierung, bearbeiter_id, ' +
        'notiz, erfasst, geaendert) VALUES (:name, NULLIF(:kunde, ''''), :gruppe, ' +
        'NULLIF(:bearbeiter, ''''), :notiz, :erfasst, :geaendert)', Parameter);
      Result := StrToInt64Def(Trim(PlanlosDB.Skalar('SELECT last_insert_rowid()')), 0);
    end
    else
    begin
      Parameter.Values['id'] := IntToStr(Projekt.Id);
      if PlanlosDB.Ausfuehren(
        'UPDATE projekt SET bezeichnung = :name, kunde_id = NULLIF(:kunde, ''''), ' +
        'gruppierung = :gruppe, bearbeiter_id = NULLIF(:bearbeiter, ''''), ' +
        'notiz = :notiz, erfasst = :erfasst, geaendert = :geaendert WHERE id = :id',
        Parameter) < 1 then
      begin
        Fehler := 'Das Projekt wurde nicht gefunden.';
        Exit;
      end;
      Result := Projekt.Id;
    end;
    if Result = 0 then
      Fehler := 'Das Projekt wurde nicht gespeichert.'
    else
      Projekt.Id := Result;
  finally
    Parameter.Free;
  end;
end;

function ProjektLoeschen(Id: Int64; out Fehler: string): Boolean;
var
  Parameter: TStringList;
begin
  Fehler := '';
  Result := False;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    if StrToIntDef(PlanlosDB.SkalarMit(
      'SELECT COUNT(*) FROM beleg WHERE projekt_stamm_id = :id', Parameter), 0) > 0 then
    begin
      Fehler := 'An diesem Projekt hängen noch Belege. Es kann nicht gelöscht werden.';
      Exit;
    end;
    Result := PlanlosDB.Ausfuehren('DELETE FROM projekt WHERE id = :id', Parameter) > 0;
    if not Result then
      Fehler := 'Das Projekt konnte nicht gelöscht werden.';
  finally
    Parameter.Free;
  end;
end;

function ProjektKopieren(Id: Int64; out Fehler: string): Int64;
var
  Projekt: TProjekt;
begin
  Result := 0;
  if not ProjektLaden(Id, Projekt) then
  begin
    Fehler := 'Das Projekt wurde nicht gefunden.';
    Exit;
  end;
  Projekt.Id := 0;
  Projekt.Bezeichnung := Projekt.Bezeichnung + ' Kopie';
  Projekt.Erfasst := '';
  Result := ProjektSpeichern(Projekt, Fehler);
end;

procedure ProjektLesen(const Suchtext: string; Spalten, Zeilen: TStrings);
var
  Parameter: TStringList;
begin
  Spalten.Clear;
  Zeilen.Clear;
  if not DatenbankBereit then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['muster'] := '%' + Trim(StringReplace(StringReplace(Suchtext,
      '%', '', [rfReplaceAll]), '_', '', [rfReplaceAll])) + '%';
    if Trim(Suchtext) = '' then
      Parameter.Values['leer'] := '1'
    else
      Parameter.Values['leer'] := '0';
    PlanlosDB.AlleZeilen(
      'SELECT p.id, p.bezeichnung, COALESCE(a.firma, a.nachname, ''''), p.gruppierung ' +
      'FROM projekt p LEFT JOIN adresse a ON a.id = p.kunde_id ' +
      'WHERE :leer = ''1'' OR p.bezeichnung LIKE :muster OR a.nachname LIKE :muster ' +
      'OR a.firma LIKE :muster ORDER BY p.bezeichnung, p.id',
      Parameter, Spalten, Zeilen);
  finally
    Parameter.Free;
  end;
  Spalten.Clear;
  Spalten.Add('id');
  Spalten.Add('Bezeichnung');
  Spalten.Add('Kunde');
  Spalten.Add('Gruppierung');
end;

end.
