unit ustueckliste;

{ Stücklisten in den Stammdaten und als Kopie an einer Belegposition.
  Die Kalkulation ist Menge mal EK plus Aufschlag. Die Branche bleibt
  in den Daten.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils;

type
  TStueckZeile = record
    Bezeichnung: string;
    MengeMilli: Int64;
    Einheit: string;
    EkCent: Int64;
    AufschlagBp: Integer;
  end;

  TStueckZeilen = array of TStueckZeile;

  TStueckliste = record
    Id: Int64;
    Bezeichnung: string;
    Gruppe: string;
    Einheit: string;
    Zeilen: TStueckZeilen;
  end;

function ZeilenVkCent(MengeMilli, EkCent: Int64; AufschlagBp: Integer): Int64;
function SummeVkCent(const Zeilen: array of TStueckZeile): Int64;
function SummeEkCent(const Zeilen: array of TStueckZeile): Int64;
function StuecklisteSpeichern(var Liste: TStueckliste; out Fehler: string): Boolean;
function StuecklisteLaden(Id: Int64; out Liste: TStueckliste): Boolean;
function StuecklisteLoeschen(Id: Int64; out Fehler: string): Boolean;
procedure StuecklistenHolen(Namen, Nummern: TStrings);
procedure StueckGruppenHolen(Namen: TStrings);
procedure UnterzeilenSpeichern(PositionId: Int64; const Zeilen: array of TStueckZeile);
procedure UnterzeilenLaden(PositionId: Int64; out Zeilen: TStueckZeilen);

implementation

uses
  udatenbank;

function Bereit: Boolean;
begin
  Result := (PlanlosDB <> nil) and PlanlosDB.Verbunden;
end;

function ZeilenVkCent(MengeMilli, EkCent: Int64; AufschlagBp: Integer): Int64;
var
  Produkt: Int64;
  Negativ: Boolean;
begin
  if (MengeMilli = 0) or (EkCent = 0) then
    Exit(0);
  Negativ := (MengeMilli < 0) xor (EkCent < 0);
  if MengeMilli < 0 then
    MengeMilli := -MengeMilli;
  if EkCent < 0 then
    EkCent := -EkCent;
  Produkt := MengeMilli * EkCent * (Int64(10000) + AufschlagBp);
  Result := (Produkt + 5000000) div 10000000;
  if Negativ then
    Result := -Result;
end;

function SummeVkCent(const Zeilen: array of TStueckZeile): Int64;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to High(Zeilen) do
    Result := Result + ZeilenVkCent(Zeilen[i].MengeMilli, Zeilen[i].EkCent,
      Zeilen[i].AufschlagBp);
end;

function SummeEkCent(const Zeilen: array of TStueckZeile): Int64;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to High(Zeilen) do
    Result := Result + ZeilenVkCent(Zeilen[i].MengeMilli, Zeilen[i].EkCent, 0);
end;

procedure ZeilenLesen(const SQL: string; const Schluessel: string; Id: Int64;
  out Zeilen: TStueckZeilen);
var
  Parameter, Spalten, ZeilenText, Teile: TStringList;
  i, Tab: Integer;
  Rest: string;
begin
  SetLength(Zeilen, 0);
  if not Bereit or (Id <= 0) then
    Exit;
  Parameter := TStringList.Create;
  Spalten := TStringList.Create;
  ZeilenText := TStringList.Create;
  Teile := TStringList.Create;
  try
    Parameter.Values[Schluessel] := IntToStr(Id);
    PlanlosDB.AlleZeilen(SQL, Parameter, Spalten, ZeilenText);
    SetLength(Zeilen, ZeilenText.Count);
    for i := 0 to ZeilenText.Count - 1 do
    begin
      Teile.Clear;
      Rest := ZeilenText[i];
      repeat
        Tab := Pos(#9, Rest);
        if Tab = 0 then
        begin
          Teile.Add(Rest);
          Break;
        end;
        Teile.Add(Copy(Rest, 1, Tab - 1));
        Delete(Rest, 1, Tab);
      until False;
      if Teile.Count < 5 then
        Continue;
      Zeilen[i].Bezeichnung := Teile[0];
      Zeilen[i].MengeMilli := StrToInt64Def(Teile[1], 0);
      Zeilen[i].Einheit := Teile[2];
      Zeilen[i].EkCent := StrToInt64Def(Teile[3], 0);
      Zeilen[i].AufschlagBp := StrToIntDef(Teile[4], 0);
    end;
  finally
    Teile.Free;
    ZeilenText.Free;
    Spalten.Free;
    Parameter.Free;
  end;
end;

procedure ZeilenSchreiben(const Tabelle, Spalte: string; Id: Int64;
  const Zeilen: array of TStueckZeile);
var
  Parameter: TStringList;
  i: Integer;
begin
  if not Bereit or (Id <= 0) then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.Ausfuehren('DELETE FROM ' + Tabelle + ' WHERE ' + Spalte + ' = :id',
      Parameter);
    for i := 0 to High(Zeilen) do
    begin
      if Trim(Zeilen[i].Bezeichnung) = '' then
        Continue;
      Parameter.Clear;
      Parameter.Values['id'] := IntToStr(Id);
      Parameter.Values['nr'] := IntToStr(i + 1);
      Parameter.Values['name'] := Zeilen[i].Bezeichnung;
      Parameter.Values['menge'] := IntToStr(Zeilen[i].MengeMilli);
      Parameter.Values['einheit'] := Zeilen[i].Einheit;
      Parameter.Values['ek'] := IntToStr(Zeilen[i].EkCent);
      Parameter.Values['auf'] := IntToStr(Zeilen[i].AufschlagBp);
      PlanlosDB.Ausfuehren(
        'INSERT INTO ' + Tabelle + ' (' + Spalte + ', position_nr, bezeichnung, ' +
        'menge_milli, einheit, ek_cent, aufschlag_bp) VALUES (:id, :nr, :name, ' +
        ':menge, :einheit, :ek, :auf)', Parameter);
    end;
  finally
    Parameter.Free;
  end;
end;

function StuecklisteSpeichern(var Liste: TStueckliste; out Fehler: string): Boolean;
var
  Parameter: TStringList;
begin
  Result := False;
  Fehler := '';
  if Trim(Liste.Bezeichnung) = '' then
  begin
    Fehler := 'Die Stückliste braucht einen Namen.';
    Exit;
  end;
  if not Bereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  Parameter := TStringList.Create;
  try
    Parameter.Values['name'] := Trim(Liste.Bezeichnung);
    Parameter.Values['gruppe'] := Trim(Liste.Gruppe);
    Parameter.Values['einheit'] := Trim(Liste.Einheit);
    if Liste.Id = 0 then
    begin
      PlanlosDB.Ausfuehren(
        'INSERT INTO stueckliste (bezeichnung, gruppe, einheit) ' +
        'VALUES (:name, :gruppe, :einheit)', Parameter);
      Liste.Id := StrToInt64Def(PlanlosDB.Skalar('SELECT last_insert_rowid()'), 0);
    end
    else
    begin
      Parameter.Values['id'] := IntToStr(Liste.Id);
      if PlanlosDB.Ausfuehren(
        'UPDATE stueckliste SET bezeichnung = :name, gruppe = :gruppe, ' +
        'einheit = :einheit WHERE id = :id', Parameter) < 1 then
      begin
        Fehler := 'Die Stückliste wurde nicht gefunden.';
        Exit;
      end;
    end;
    ZeilenSchreiben('stuecklistenposition', 'stueckliste_id', Liste.Id, Liste.Zeilen);
    Result := Liste.Id > 0;
  finally
    Parameter.Free;
  end;
end;

function StuecklisteLaden(Id: Int64; out Liste: TStueckliste): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  Liste := Default(TStueckliste);
  if not Bereit or (Id <= 0) then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT id, bezeichnung, gruppe, einheit FROM stueckliste WHERE id = :id',
      Parameter, Zeile);
    if Zeile.Values['id'] = '' then
      Exit;
    Liste.Id := Id;
    Liste.Bezeichnung := Zeile.Values['bezeichnung'];
    Liste.Gruppe := Zeile.Values['gruppe'];
    Liste.Einheit := Zeile.Values['einheit'];
    ZeilenLesen(
      'SELECT bezeichnung, menge_milli, einheit, ek_cent, aufschlag_bp ' +
      'FROM stuecklistenposition WHERE stueckliste_id = :id ORDER BY position_nr, id',
      'id', Id, Liste.Zeilen);
    Result := True;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function StuecklisteLoeschen(Id: Int64; out Fehler: string): Boolean;
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
    PlanlosDB.Ausfuehren(
      'DELETE FROM stuecklistenposition WHERE stueckliste_id = :id', Parameter);
    Result := PlanlosDB.Ausfuehren(
      'DELETE FROM stueckliste WHERE id = :id', Parameter) > 0;
    if not Result then
      Fehler := 'Die Stückliste wurde nicht gefunden.';
  finally
    Parameter.Free;
  end;
end;

procedure StuecklistenHolen(Namen, Nummern: TStrings);
var
  Spalten, Zeilen: TStringList;
  i, Tab: Integer;
begin
  Namen.Clear;
  Nummern.Clear;
  if not Bereit then
    Exit;
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  try
    PlanlosDB.AlleZeilen(
      'SELECT id, bezeichnung FROM stueckliste ORDER BY bezeichnung',
      nil, Spalten, Zeilen);
    for i := 0 to Zeilen.Count - 1 do
    begin
      Tab := Pos(#9, Zeilen[i]);
      if Tab > 0 then
      begin
        Nummern.Add(Copy(Zeilen[i], 1, Tab - 1));
        Namen.Add(Copy(Zeilen[i], Tab + 1, MaxInt));
      end;
    end;
  finally
    Zeilen.Free;
    Spalten.Free;
  end;
end;

procedure StueckGruppenHolen(Namen: TStrings);
var
  Spalten, Zeilen: TStringList;
  i: Integer;
begin
  Namen.Clear;
  if not Bereit then
    Exit;
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  try
    PlanlosDB.AlleZeilen(
      'SELECT bezeichnung FROM nachschlage WHERE art = ''stuecklistengruppe'' ' +
      'ORDER BY bezeichnung', nil, Spalten, Zeilen);
    for i := 0 to Zeilen.Count - 1 do
      Namen.Add(Zeilen[i]);
  finally
    Zeilen.Free;
    Spalten.Free;
  end;
end;

procedure UnterzeilenSpeichern(PositionId: Int64; const Zeilen: array of TStueckZeile);
begin
  ZeilenSchreiben('belegstueckliste', 'belegposition_id', PositionId, Zeilen);
end;

procedure UnterzeilenLaden(PositionId: Int64; out Zeilen: TStueckZeilen);
begin
  ZeilenLesen(
    'SELECT bezeichnung, menge_milli, einheit, ek_cent, aufschlag_bp ' +
    'FROM belegstueckliste WHERE belegposition_id = :id ORDER BY position_nr, id',
    'id', PositionId, Zeilen);
end;

end.
