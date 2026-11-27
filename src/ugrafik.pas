unit ugrafik;

{ Bilder für Briefköpfe. Der Inhalt liegt als Text, damit das Speichern
  denselben Weg nimmt wie die übrigen Datensätze.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils;

function GrafikArtErkennen(const Daten: RawByteString): string;
function GrafikSpeichern(var Id: Int64; const Bezeichnung, Art: string;
  const Daten: RawByteString; out Fehler: string): Boolean;
function GrafikLoeschen(Id: Int64; out Fehler: string): Boolean;
function GrafikInhalt(Id: Int64; out Art: string; out Daten: RawByteString): Boolean;
function GrafikVonBriefkopf(BriefkopfId: Int64; out Art: string;
  out Daten: RawByteString): Boolean;
procedure GrafikenHolen(Namen, Nummern: TStrings);

implementation

uses
  base64, udatenbank;

function Bereit: Boolean;
begin
  Result := (PlanlosDB <> nil) and PlanlosDB.Verbunden;
end;

function GrafikArtErkennen(const Daten: RawByteString): string;
begin
  Result := '';
  if (Length(Daten) >= 8) and (Daten[1] = #$89) and (Copy(Daten, 2, 3) = 'PNG') then
    Result := 'png'
  else if (Length(Daten) >= 3) and (Ord(Daten[1]) = $FF) and (Ord(Daten[2]) = $D8) then
    Result := 'jpg';
end;

function GrafikSpeichern(var Id: Int64; const Bezeichnung, Art: string;
  const Daten: RawByteString; out Fehler: string): Boolean;
var
  Parameter: TStringList;
  Name, ArtName, Kodiert: string;
begin
  Result := False;
  Fehler := '';
  Name := Trim(Bezeichnung);
  ArtName := LowerCase(Trim(Art));
  if Name = '' then
  begin
    Fehler := 'Die Grafik braucht einen Namen.';
    Exit;
  end;
  if (ArtName <> 'png') and (ArtName <> 'jpg') then
  begin
    Fehler := 'Erlaubt sind PNG und JPG.';
    Exit;
  end;
  if Daten = '' then
  begin
    Fehler := 'Die Grafik hat keinen Inhalt.';
    Exit;
  end;
  if Length(Daten) > 1500000 then
  begin
    Fehler := 'Die Grafik ist größer als 1,5 MB.';
    Exit;
  end;
  if not Bereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  Kodiert := EncodeStringBase64(Daten);
  Parameter := TStringList.Create;
  try
    try
      Parameter.Values['name'] := Name;
      Parameter.Values['art'] := ArtName;
      Parameter.Values['daten'] := Kodiert;
      if Id = 0 then
      begin
        PlanlosDB.Ausfuehren(
          'INSERT INTO grafik (bezeichnung, art, daten) VALUES (:name, :art, :daten)',
          Parameter);
        Id := StrToInt64Def(PlanlosDB.Skalar('SELECT last_insert_rowid()'), 0);
      end
      else
      begin
        Parameter.Values['id'] := IntToStr(Id);
        if PlanlosDB.Ausfuehren(
          'UPDATE grafik SET bezeichnung = :name, art = :art, daten = :daten ' +
          'WHERE id = :id', Parameter) < 1 then
        begin
          Fehler := 'Die Grafik wurde nicht gefunden.';
          Exit;
        end;
      end;
      Result := Id > 0;
      if not Result then
        Fehler := 'Die Grafik wurde nicht gespeichert.';
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

function GrafikLoeschen(Id: Int64; out Fehler: string): Boolean;
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
      'UPDATE briefkopf SET grafik_id = NULL WHERE grafik_id = :id', Parameter);
    Result := PlanlosDB.Ausfuehren('DELETE FROM grafik WHERE id = :id', Parameter) > 0;
    if not Result then
      Fehler := 'Die Grafik wurde nicht gefunden.';
  finally
    Parameter.Free;
  end;
end;

function GrafikInhalt(Id: Int64; out Art: string; out Daten: RawByteString): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  Art := '';
  Daten := '';
  if not Bereit or (Id <= 0) then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT art, daten FROM grafik WHERE id = :id', Parameter, Zeile);
    if Zeile.Values['art'] = '' then
      Exit;
    Art := Zeile.Values['art'];
    Daten := DecodeStringBase64(Zeile.Values['daten']);
    Result := Daten <> '';
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function GrafikVonBriefkopf(BriefkopfId: Int64; out Art: string;
  out Daten: RawByteString): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  Art := '';
  Daten := '';
  if not Bereit or (BriefkopfId <= 0) then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(BriefkopfId);
    PlanlosDB.ErsteZeile(
      'SELECT g.art, g.daten FROM briefkopf b JOIN grafik g ON g.id = b.grafik_id ' +
      'WHERE b.id = :id', Parameter, Zeile);
    if Zeile.Values['art'] = '' then
      Exit;
    Art := Zeile.Values['art'];
    Daten := DecodeStringBase64(Zeile.Values['daten']);
    Result := Daten <> '';
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

procedure GrafikenHolen(Namen, Nummern: TStrings);
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
      'SELECT id, bezeichnung FROM grafik ORDER BY bezeichnung', nil, Spalten, Zeilen);
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

end.
