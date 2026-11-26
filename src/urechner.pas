unit urechner;

{ Rechenausdruck für Zahlenfelder. Dezimalkomma, Grundrechenarten,
  Prozent vom linken Wert bei + und -.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

function RechnerAuswerten(const Ausdruck: string; out Wert: Double;
  out Fehler: string): Boolean;
function RechnerText(Wert: Double): string;

implementation

uses
  SysUtils;

type
  TLeser = record
    Text: string;
    Stelle: Integer;
    Fehler: string;
  end;

procedure Luecke(var Leser: TLeser);
begin
  while (Leser.Stelle <= Length(Leser.Text)) and (Leser.Text[Leser.Stelle] = ' ') do
    Inc(Leser.Stelle);
end;

function ZahlLesen(var Leser: TLeser; out Wert: Double): Boolean;
var
  Start, Trenner: Integer;
  Ganz, Bruch: string;
  FS: TFormatSettings;
begin
  Result := False;
  Luecke(Leser);
  Start := Leser.Stelle;
  if (Leser.Stelle <= Length(Leser.Text)) and
     ((Leser.Text[Leser.Stelle] = '+') or (Leser.Text[Leser.Stelle] = '-')) then
    Inc(Leser.Stelle);
  if (Leser.Stelle > Length(Leser.Text)) or
     (Leser.Text[Leser.Stelle] < '0') or (Leser.Text[Leser.Stelle] > '9') then
  begin
    Leser.Fehler := 'Da fehlt eine Zahl.';
    Exit;
  end;
  while (Leser.Stelle <= Length(Leser.Text)) and
        (Leser.Text[Leser.Stelle] >= '0') and (Leser.Text[Leser.Stelle] <= '9') do
    Inc(Leser.Stelle);
  Trenner := 0;
  if (Leser.Stelle <= Length(Leser.Text)) and
     ((Leser.Text[Leser.Stelle] = ',') or (Leser.Text[Leser.Stelle] = '.')) then
  begin
    Trenner := Leser.Stelle;
    Inc(Leser.Stelle);
    while (Leser.Stelle <= Length(Leser.Text)) and
          (Leser.Text[Leser.Stelle] >= '0') and (Leser.Text[Leser.Stelle] <= '9') do
      Inc(Leser.Stelle);
  end;
  Ganz := Copy(Leser.Text, Start, Leser.Stelle - Start);
  if Trenner > 0 then
  begin
    Bruch := Copy(Leser.Text, Trenner + 1, Leser.Stelle - Trenner - 1);
    Ganz := Copy(Leser.Text, Start, Trenner - Start);
    if Ganz = '' then
      Ganz := '0';
    if (Ganz = '+') or (Ganz = '-') then
      Ganz := Ganz + '0';
    Ganz := Ganz + '.' + Bruch;
  end
  else
    Ganz := StringReplace(Ganz, ',', '.', []);
  FS := DefaultFormatSettings;
  FS.DecimalSeparator := '.';
  if not TryStrToFloat(Ganz, Wert, FS) then
  begin
    Leser.Fehler := 'Die Zahl ist ungültig.';
    Exit;
  end;
  Result := True;
end;

function Faktor(var Leser: TLeser; out Wert: Double; out Prozent: Boolean): Boolean;
begin
  Prozent := False;
  if not ZahlLesen(Leser, Wert) then
    Exit(False);
  Luecke(Leser);
  if (Leser.Stelle <= Length(Leser.Text)) and (Leser.Text[Leser.Stelle] = '%') then
  begin
    Prozent := True;
    Inc(Leser.Stelle);
  end;
  Result := True;
end;

function Produkt(var Leser: TLeser; out Wert: Double; out Prozent: Boolean): Boolean;
var
  Rechts: Double;
  RechtsProzent: Boolean;
  Zeichen: Char;
begin
  if not Faktor(Leser, Wert, Prozent) then
    Exit(False);
  Luecke(Leser);
  while (Leser.Stelle <= Length(Leser.Text)) and
        ((Leser.Text[Leser.Stelle] = '*') or (Leser.Text[Leser.Stelle] = '/')) do
  begin
    Zeichen := Leser.Text[Leser.Stelle];
    Inc(Leser.Stelle);
    if Prozent then
      Wert := Wert / 100;
    Prozent := False;
    if not Faktor(Leser, Rechts, RechtsProzent) then
      Exit(False);
    if RechtsProzent then
      Rechts := Rechts / 100;
    if Zeichen = '*' then
      Wert := Wert * Rechts
    else if Rechts = 0 then
    begin
      Leser.Fehler := 'Teilen durch null geht nicht.';
      Exit(False);
    end
    else
      Wert := Wert / Rechts;
    Luecke(Leser);
  end;
  Result := True;
end;

function Summe(var Leser: TLeser; out Wert: Double): Boolean;
var
  Rechts: Double;
  LinksProzent, RechtsProzent: Boolean;
  Zeichen: Char;
begin
  if not Produkt(Leser, Wert, LinksProzent) then
    Exit(False);
  if LinksProzent then
    Wert := Wert / 100;
  Luecke(Leser);
  while (Leser.Stelle <= Length(Leser.Text)) and
        ((Leser.Text[Leser.Stelle] = '+') or (Leser.Text[Leser.Stelle] = '-')) do
  begin
    Zeichen := Leser.Text[Leser.Stelle];
    Inc(Leser.Stelle);
    if not Produkt(Leser, Rechts, RechtsProzent) then
      Exit(False);
    if RechtsProzent and ((Zeichen = '+') or (Zeichen = '-')) then
    begin
      if Zeichen = '+' then
        Wert := Wert + (Wert * Rechts / 100)
      else
        Wert := Wert - (Wert * Rechts / 100);
    end
    else
    begin
      if RechtsProzent then
        Rechts := Rechts / 100;
      if Zeichen = '+' then
        Wert := Wert + Rechts
      else
        Wert := Wert - Rechts;
    end;
    Luecke(Leser);
  end;
  Result := True;
end;

function RechnerAuswerten(const Ausdruck: string; out Wert: Double;
  out Fehler: string): Boolean;
var
  Leser: TLeser;
begin
  Wert := 0;
  Fehler := '';
  Leser.Text := Trim(Ausdruck);
  Leser.Stelle := 1;
  Leser.Fehler := '';
  if Leser.Text = '' then
  begin
    Result := True;
    Exit;
  end;
  if not Summe(Leser, Wert) then
  begin
    if Leser.Fehler = '' then
      Fehler := 'Der Ausdruck ist ungültig.'
    else
      Fehler := Leser.Fehler;
    Exit(False);
  end;
  Luecke(Leser);
  if Leser.Stelle <= Length(Leser.Text) then
  begin
    Fehler := 'Der Ausdruck ist ungültig.';
    Exit(False);
  end;
  Result := True;
end;

function RechnerText(Wert: Double): string;
var
  Negativ: Boolean;
  Gerundet: Int64;
  Ganz, Rest: Int64;
  Nach: string;
begin
  Negativ := Wert < 0;
  if Negativ then
    Wert := -Wert;
  if Wert >= 0 then
    Gerundet := Trunc(Wert * 10000 + 0.5)
  else
    Gerundet := Trunc(Wert * 10000 - 0.5);
  Ganz := Gerundet div 10000;
  Rest := Gerundet mod 10000;
  Result := IntToStr(Ganz);
  if Rest <> 0 then
  begin
    Nach := IntToStr(Rest);
    while Length(Nach) < 4 do
      Nach := '0' + Nach;
    while (Nach <> '') and (Nach[Length(Nach)] = '0') do
      Delete(Nach, Length(Nach), 1);
    Result := Result + ',' + Nach;
  end;
  if Negativ then
    Result := '-' + Result;
end;

end.
