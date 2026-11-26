unit udatum;

{ Datum lesen und schreiben, ohne Fenster.
  ISO-Datum jjjj-mm-tt und deutsches tt.mm.jjjj.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

function TageImMonat(Jahr, Monat: Word): Word;
function DatumGueltig(Jahr, Monat, Tag: Word): Boolean;
function DatumLesen(const Text: string; out Jahr, Monat, Tag: Word): Boolean;
function DatumIso(Jahr, Monat, Tag: Word): string;

implementation

uses
  SysUtils;

function Schaltjahr(Jahr: Word): Boolean;
begin
  Result := (Jahr mod 4 = 0) and ((Jahr mod 100 <> 0) or (Jahr mod 400 = 0));
end;

function TageImMonat(Jahr, Monat: Word): Word;
begin
  case Monat of
    1, 3, 5, 7, 8, 10, 12: Result := 31;
    4, 6, 9, 11: Result := 30;
    2:
      if Schaltjahr(Jahr) then
        Result := 29
      else
        Result := 28;
  else
    Result := 0;
  end;
end;

function DatumGueltig(Jahr, Monat, Tag: Word): Boolean;
begin
  Result := (Jahr >= 1) and (Jahr <= 9999) and (Monat >= 1) and (Monat <= 12) and
    (Tag >= 1) and (Tag <= TageImMonat(Jahr, Monat));
end;

function Ziffern(const Text: string): Boolean;
var
  i: Integer;
begin
  Result := Text <> '';
  for i := 1 to Length(Text) do
    if (Text[i] < '0') or (Text[i] > '9') then
      Exit(False);
end;

function Zahl(const Text: string; out Wert: Word): Boolean;
var
  N: Integer;
begin
  Result := Ziffern(Text);
  if not Result then
    Exit;
  N := StrToIntDef(Text, -1);
  Result := (N >= 0) and (N <= 9999);
  if Result then
    Wert := Word(N);
end;

function DatumLesen(const Text: string; out Jahr, Monat, Tag: Word): Boolean;
var
  S, Teil: string;
  Punkt1, Punkt2: Integer;
begin
  Jahr := 0;
  Monat := 0;
  Tag := 0;
  S := Trim(Text);
  Result := False;
  if (Length(S) >= 10) and (S[5] = '-') and (S[8] = '-') then
  begin
    if Length(S) > 10 then
    begin
      if (S[11] <> 'T') and (S[11] <> ' ') then
        Exit;
    end;
    if not Zahl(Copy(S, 1, 4), Jahr) or not Zahl(Copy(S, 6, 2), Monat) or
       not Zahl(Copy(S, 9, 2), Tag) then
      Exit;
    Result := DatumGueltig(Jahr, Monat, Tag);
    Exit;
  end;
  Punkt1 := Pos('.', S);
  if Punkt1 = 0 then
    Exit;
  Punkt2 := Pos('.', Copy(S, Punkt1 + 1, MaxInt));
  if Punkt2 = 0 then
    Exit;
  Punkt2 := Punkt1 + Punkt2;
  if Pos('.', Copy(S, Punkt2 + 1, MaxInt)) > 0 then
    Exit;
  Teil := Copy(S, 1, Punkt1 - 1);
  if not Zahl(Teil, Tag) then
    Exit;
  Teil := Copy(S, Punkt1 + 1, Punkt2 - Punkt1 - 1);
  if not Zahl(Teil, Monat) then
    Exit;
  Teil := Copy(S, Punkt2 + 1, MaxInt);
  if Length(Teil) <> 4 then
    Exit;
  if not Zahl(Teil, Jahr) then
    Exit;
  Result := DatumGueltig(Jahr, Monat, Tag);
end;

function DatumIso(Jahr, Monat, Tag: Word): string;
begin
  Result := Format('%.4d-%.2d-%.2d', [Jahr, Monat, Tag]);
end;

end.
