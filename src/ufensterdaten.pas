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
function FensterSpeichern(var Satz: TFensterSatz; out Fehler: string;
  PruefeSql: Boolean = True): Boolean;
{ Legt den Satz an, wenn er fehlt. Übernimmt dann Spalten, Sortierung,
  Filter und Abfrage aus der allgemeinen Vorgabe des Fensters. }
function FensterMitVorgabe(const Fenster, Kontext: string;
  Links, Oben, Breite, Hoehe: Integer; out Satz: TFensterSatz;
  out Fehler: string): Boolean;
procedure FensterAlle(Ziel: TStrings);
function FensterLoeschen(Id: Int64; out Fehler: string): Boolean;
function BriefkopfStandard: Int64;
function BriefkopfLesen(Id: Int64; out Absender, Fusszeile: string): Boolean;
function BriefkopfDaten(Id: Int64; out Bezeichnung, Absender, Fusszeile: string;
  out GrafikId: Int64; out IstStandard: Boolean): Boolean;
function BriefkopfSpeichern(var Id: Int64; const Bezeichnung, Absender,
  Fusszeile: string; GrafikId: Int64; IstStandard: Boolean;
  out Fehler: string): Boolean;
function BriefkopfLoeschen(Id: Int64; out Fehler: string): Boolean;
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

function FensterSpeichern(var Satz: TFensterSatz; out Fehler: string;
  PruefeSql: Boolean): Boolean;
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
  if PruefeSql and (Trim(Satz.SqlText) <> '') then
    if not PlanlosDB.AbfragePruefen(Satz.SqlText, Fehler) then
    begin
      Fehler := 'Die Abfrage gilt nicht. Es bleibt die eingebaute Vorgabe.' +
        LineEnding + Fehler;
      Exit;
    end;
  if FensterLesen(Satz.Fenster, Satz.Kontext, Bisher) then
  begin
    Satz.Id := Bisher.Id;
    if not PruefeSql then
      Satz.SqlText := Bisher.SqlText;
  end;
  Parameter := TStringList.Create;
  try
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
    except
      on E: Exception do
      begin
        PlanlosDB.TransaktionAbbrechen;
        Fehler := E.Message;
        Result := False;
      end;
    end;
  finally
    Parameter.Free;
  end;
end;

function FensterMitVorgabe(const Fenster, Kontext: string;
  Links, Oben, Breite, Hoehe: Integer; out Satz: TFensterSatz;
  out Fehler: string): Boolean;
var
  Allgemein: TFensterSatz;
begin
  Fehler := '';
  if FensterLesen(Fenster, Kontext, Satz) then
  begin
    Satz.Links := Links;
    Satz.Oben := Oben;
    Satz.Breite := Breite;
    Satz.Hoehe := Hoehe;
    Result := FensterSpeichern(Satz, Fehler, False);
    Exit;
  end;
  Satz := Default(TFensterSatz);
  Satz.Fenster := Fenster;
  Satz.Kontext := Kontext;
  Satz.Links := Links;
  Satz.Oben := Oben;
  Satz.Breite := Breite;
  Satz.Hoehe := Hoehe;
  if (Kontext <> '') and FensterLesen(Fenster, '', Allgemein) then
  begin
    Satz.Spalten := Allgemein.Spalten;
    Satz.Sortierung := Allgemein.Sortierung;
    Satz.Filter := Allgemein.Filter;
    Satz.SqlText := Allgemein.SqlText;
  end;
  Result := FensterSpeichern(Satz, Fehler, False);
end;

procedure FensterAlle(Ziel: TStrings);
var
  Spalten, Zeilen: TStringList;
begin
  Ziel.Clear;
  if not Bereit then
    Exit;
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  try
    PlanlosDB.AlleZeilen(
      'SELECT id, fenster, kontext, sql_text FROM fenstereinstellung ' +
      'ORDER BY fenster, kontext, id', nil, Spalten, Zeilen);
    Ziel.Assign(Zeilen);
  finally
    Zeilen.Free;
    Spalten.Free;
  end;
end;

function FensterLoeschen(Id: Int64; out Fehler: string): Boolean;
var
  Parameter: TStringList;
begin
  Result := False;
  Fehler := '';
  if not Bereit or (Id <= 0) then
  begin
    Fehler := 'Die Fenstereinstellung wurde nicht gefunden.';
    Exit;
  end;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    Result := PlanlosDB.Ausfuehren(
      'DELETE FROM fenstereinstellung WHERE id = :id', Parameter) > 0;
    if not Result then
      Fehler := 'Die Fenstereinstellung wurde nicht gefunden.';
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

function BriefkopfDaten(Id: Int64; out Bezeichnung, Absender, Fusszeile: string;
  out GrafikId: Int64; out IstStandard: Boolean): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  Bezeichnung := '';
  Absender := '';
  Fusszeile := '';
  GrafikId := 0;
  IstStandard := False;
  if not Bereit or (Id <= 0) then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT bezeichnung, absender, fusszeile, grafik_id, standard ' +
      'FROM briefkopf WHERE id = :id', Parameter, Zeile);
    if Zeile.Count = 0 then
      Exit;
    Bezeichnung := Zeile.Values['bezeichnung'];
    Absender := Zeile.Values['absender'];
    Fusszeile := Zeile.Values['fusszeile'];
    GrafikId := StrToInt64Def(Zeile.Values['grafik_id'], 0);
    IstStandard := Zeile.Values['standard'] = '1';
    Result := True;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function BriefkopfSpeichern(var Id: Int64; const Bezeichnung, Absender,
  Fusszeile: string; GrafikId: Int64; IstStandard: Boolean;
  out Fehler: string): Boolean;
var
  Parameter: TStringList;
  Name: string;
begin
  Result := False;
  Fehler := '';
  Name := Trim(Bezeichnung);
  if Name = '' then
  begin
    Fehler := 'Der Briefkopf braucht einen Namen.';
    Exit;
  end;
  if not Bereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  Parameter := TStringList.Create;
  try
    try
      if IstStandard then
        PlanlosDB.Ausfuehren('UPDATE briefkopf SET standard = 0', nil);
      Parameter.Values['name'] := Name;
      Parameter.Values['absender'] := Absender;
      Parameter.Values['fuss'] := Fusszeile;
      if GrafikId > 0 then
        Parameter.Values['grafik'] := IntToStr(GrafikId)
      else
        Parameter.Values['grafik'] := '0';
      if IstStandard then
        Parameter.Values['standard'] := '1'
      else
        Parameter.Values['standard'] := '0';
      if Id = 0 then
      begin
        PlanlosDB.Ausfuehren(
          'INSERT INTO briefkopf (bezeichnung, absender, fusszeile, grafik_id, standard) ' +
          'VALUES (:name, :absender, :fuss, NULLIF(:grafik, ''0''), :standard)',
          Parameter);
        Id := StrToInt64Def(PlanlosDB.Skalar('SELECT last_insert_rowid()'), 0);
      end
      else
      begin
        Parameter.Values['id'] := IntToStr(Id);
        if PlanlosDB.Ausfuehren(
          'UPDATE briefkopf SET bezeichnung = :name, absender = :absender, ' +
          'fusszeile = :fuss, grafik_id = NULLIF(:grafik, ''0''), standard = :standard ' +
          'WHERE id = :id', Parameter) < 1 then
        begin
          Fehler := 'Der Briefkopf wurde nicht gefunden.';
          Exit;
        end;
      end;
      Result := Id > 0;
      if not Result then
        Fehler := 'Der Briefkopf wurde nicht gespeichert.';
    except
      on E: Exception do
      begin
        PlanlosDB.TransaktionAbbrechen;
        if Pos('UNIQUE', UpperCase(E.Message)) > 0 then
          Fehler := 'Diesen Namen gibt es schon.'
        else
          Fehler := E.Message;
      end;
    end;
  finally
    Parameter.Free;
  end;
end;

function BriefkopfLoeschen(Id: Int64; out Fehler: string): Boolean;
var
  Parameter: TStringList;
begin
  Result := False;
  Fehler := '';
  if not Bereit or (Id <= 0) then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    if PlanlosDB.Ganzzahl(
      'SELECT COUNT(*) FROM beleg WHERE briefkopf_id = ' + IntToStr(Id)) > 0 then
    begin
      Fehler := 'Der Briefkopf wird von Belegen verwendet.';
      Exit;
    end;
    Result := PlanlosDB.Ausfuehren('DELETE FROM briefkopf WHERE id = :id', Parameter) > 0;
    if not Result then
      Fehler := 'Der Briefkopf wurde nicht gefunden.';
  finally
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
