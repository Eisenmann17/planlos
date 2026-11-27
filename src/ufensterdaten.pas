unit ufensterdaten;

{ Gespeicherte Fensterstellung je Fenster und Aufrufkontext.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils;

type
  TFensterSatz = record
    Id: Int64;
    Fenster: string;
    Kontext: string;
    Links: Integer;
    Oben: Integer;
    Breite: Integer;
    Hoehe: Integer;
    Spalten: string;
    Sortierung: string;
    Filter: string;
    SqlText: string;
    HatSatz: Boolean;
  end;

function FensterLesen(const Fenster, Kontext: string; out Satz: TFensterSatz): Boolean;
function FensterWirksam(const Fenster, Kontext: string; out Satz: TFensterSatz): Boolean;
function FensterSpeichern(var Satz: TFensterSatz; out Fehler: string): Boolean;
function BriefkopfStandard: Int64;
function BriefkopfLesen(Id: Int64; out Absender, Fusszeile: string): Boolean;
procedure BriefkoepfeHolen(Namen, Nummern: TStrings);

implementation

uses
  udatenbank;

function Bereit: Boolean;
begin
  Result := (PlanlosDB <> nil) and PlanlosDB.Verbunden;
end;

procedure ZeileLesen(Zeile: TStrings; out Satz: TFensterSatz);
begin
  Satz := Default(TFensterSatz);
  Satz.Id := StrToInt64Def(Zeile.Values['id'], 0);
  Satz.Fenster := Zeile.Values['fenster'];
  Satz.Kontext := Zeile.Values['kontext'];
  Satz.Links := StrToIntDef(Zeile.Values['links'], 0);
  Satz.Oben := StrToIntDef(Zeile.Values['oben'], 0);
  Satz.Breite := StrToIntDef(Zeile.Values['breite'], 0);
  Satz.Hoehe := StrToIntDef(Zeile.Values['hoehe'], 0);
  Satz.Spalten := Zeile.Values['spalten'];
  Satz.Sortierung := Zeile.Values['sortierung'];
  Satz.Filter := Zeile.Values['filter'];
  Satz.SqlText := Zeile.Values['sql_text'];
  Satz.HatSatz := Satz.Id > 0;
end;

function FensterLesen(const Fenster, Kontext: string; out Satz: TFensterSatz): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  Satz := Default(TFensterSatz);
  Satz.Fenster := Fenster;
  Satz.Kontext := Kontext;
  if not Bereit then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['fenster'] := Fenster;
    Parameter.Values['kontext'] := Kontext;
    PlanlosDB.ErsteZeile(
      'SELECT id, fenster, kontext, links, oben, breite, hoehe, spalten, ' +
      'sortierung, filter, sql_text FROM fenstereinstellung ' +
      'WHERE fenster = :fenster AND kontext = :kontext', Parameter, Zeile);
    if Zeile.Values['id'] = '' then
      Exit;
    ZeileLesen(Zeile, Satz);
    Result := True;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function FensterWirksam(const Fenster, Kontext: string; out Satz: TFensterSatz): Boolean;
var
  Allgemein: TFensterSatz;
begin
  Result := FensterLesen(Fenster, Kontext, Satz);
  if Result then
    Exit;
  if (Kontext <> '') and FensterLesen(Fenster, '', Allgemein) then
  begin
    Satz := Allgemein;
    Satz.Kontext := Kontext;
    Satz.HatSatz := False;
    Satz.Id := 0;
    Result := True;
  end;
end;

function FensterSpeichern(var Satz: TFensterSatz; out Fehler: string): Boolean;
var
  Parameter: TStringList;
  Bisher: TFensterSatz;
begin
  Result := False;
  Fehler := '';
  if not Bereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  if Trim(Satz.SqlText) <> '' then
    if not PlanlosDB.AbfragePruefen(Satz.SqlText, Fehler) then
    begin
      Fehler := 'Die Abfrage gilt nicht. Es bleibt die eingebaute Vorgabe.' +
        LineEnding + Fehler;
      Exit;
    end;
  if FensterLesen(Satz.Fenster, Satz.Kontext, Bisher) then
    Satz.Id := Bisher.Id;
  Parameter := TStringList.Create;
  try
    Parameter.Values['fenster'] := Satz.Fenster;
    Parameter.Values['kontext'] := Satz.Kontext;
    Parameter.Values['links'] := IntToStr(Satz.Links);
    Parameter.Values['oben'] := IntToStr(Satz.Oben);
    Parameter.Values['breite'] := IntToStr(Satz.Breite);
    Parameter.Values['hoehe'] := IntToStr(Satz.Hoehe);
    Parameter.Values['spalten'] := Satz.Spalten;
    Parameter.Values['sortierung'] := Satz.Sortierung;
    Parameter.Values['filter'] := Satz.Filter;
    Parameter.Values['sql'] := Satz.SqlText;
    if Satz.Id = 0 then
    begin
      PlanlosDB.Ausfuehren(
        'INSERT INTO fenstereinstellung (fenster, kontext, links, oben, breite, ' +
        'hoehe, spalten, sortierung, filter, sql_text) VALUES (:fenster, :kontext, ' +
        ':links, :oben, :breite, :hoehe, :spalten, :sortierung, :filter, :sql)',
        Parameter);
      Satz.Id := StrToInt64Def(PlanlosDB.Skalar('SELECT last_insert_rowid()'), 0);
    end
    else
    begin
      Parameter.Values['id'] := IntToStr(Satz.Id);
      PlanlosDB.Ausfuehren(
        'UPDATE fenstereinstellung SET links = :links, oben = :oben, ' +
        'breite = :breite, hoehe = :hoehe, spalten = :spalten, ' +
        'sortierung = :sortierung, filter = :filter, sql_text = :sql WHERE id = :id',
        Parameter);
    end;
    Satz.HatSatz := Satz.Id > 0;
    Result := Satz.HatSatz;
    if not Result then
      Fehler := 'Die Fenstereinstellung wurde nicht gespeichert.';
  finally
    Parameter.Free;
  end;
end;

function BriefkopfStandard: Int64;
begin
  Result := 0;
  if not Bereit then
    Exit;
  Result := PlanlosDB.Ganzzahl(
    'SELECT id FROM briefkopf WHERE standard = 1 ORDER BY id LIMIT 1');
  if Result = 0 then
    Result := PlanlosDB.Ganzzahl('SELECT id FROM briefkopf ORDER BY id LIMIT 1');
end;

function BriefkopfLesen(Id: Int64; out Absender, Fusszeile: string): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  Absender := '';
  Fusszeile := '';
  if not Bereit or (Id <= 0) then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT absender, fusszeile FROM briefkopf WHERE id = :id', Parameter, Zeile);
    if Zeile.Count = 0 then
      Exit;
    Absender := Zeile.Values['absender'];
    Fusszeile := Zeile.Values['fusszeile'];
    Result := True;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

procedure BriefkoepfeHolen(Namen, Nummern: TStrings);
var
  Spalten, Zeilen, Teile: TStringList;
  i, Tab: Integer;
begin
  Namen.Clear;
  Nummern.Clear;
  if not Bereit then
    Exit;
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  Teile := TStringList.Create;
  try
    PlanlosDB.AlleZeilen(
      'SELECT id, bezeichnung FROM briefkopf ORDER BY standard DESC, bezeichnung',
      nil, Spalten, Zeilen);
    for i := 0 to Zeilen.Count - 1 do
    begin
      Teile.StrictDelimiter := True;
      Teile.Delimiter := #9;
      Teile.DelimitedText := Zeilen[i];
      Tab := Pos(#9, Zeilen[i]);
      if Tab > 0 then
      begin
        Nummern.Add(Copy(Zeilen[i], 1, Tab - 1));
        Namen.Add(Copy(Zeilen[i], Tab + 1, MaxInt));
      end;
    end;
  finally
    Teile.Free;
    Zeilen.Free;
    Spalten.Free;
  end;
end;

end.
