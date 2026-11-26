unit udrucklayout;

{ Typen für ein gestaltbares Drucklayout. Noch nicht an das PDF und
  nicht an ein Fenster gebunden. Die Standardvorlage entspricht dem
  heutigen Aufbau in udruck.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  SysUtils;

const
  LayoutVersion = 1;
  SeiteBreite = 210;
  SeiteHoehe = 297;

type
  TLayoutFeld = record
    Id: string;
    Sichtbar: Boolean;
    XMm: Integer;
    YMm: Integer;
    BreiteMm: Integer;
    HoeheMm: Integer;
    Schrift: string;
    Groesse: Integer;
    Fett: Boolean;
    Ausrichtung: string;
    Beschriftung: string;
    Quelle: string;
  end;

  TLayoutSpalte = record
    Id: string;
    Sichtbar: Boolean;
    Beschriftung: string;
    BreiteMm: Integer;
    Ausrichtung: string;
    Quelle: string;
  end;

  TLayoutBereich = record
    Id: string;
    Anker: string;
    Sichtbar: Boolean;
    YMm: Integer;
    Felder: array of TLayoutFeld;
  end;

  TDruckLayout = record
    Version: Integer;
    Seite: string;
    RandLinks: Integer;
    RandRechts: Integer;
    RandUnten: Integer;
    AnschriftOben: Integer;
    TextOben: Integer;
    Bereiche: array of TLayoutBereich;
    Spalten: array of TLayoutSpalte;
  end;

function LayoutStandard: TDruckLayout;
function LayoutPruefen(const Layout: TDruckLayout; out Fehler: string): Boolean;
function LayoutAlsJson(const Layout: TDruckLayout): string;
function LayoutAusJson(const Text: string; out Layout: TDruckLayout;
  out Fehler: string): Boolean;
function LayoutLaden(const Datei: string; out Layout: TDruckLayout;
  out Fehler: string): Boolean;
function LayoutSpeichern(const Datei: string; const Layout: TDruckLayout;
  out Fehler: string): Boolean;
procedure LayoutMitFallback(const Text: string; out Layout: TDruckLayout;
  out Hinweis: string);

implementation

uses
  Classes, fpjson, jsonparser;

const
  BereicheBekannt: array[0..7] of string = (
    'firmenkopf', 'anschrift', 'belegkopf', 'kopftext',
    'positionen', 'summen', 'fusstext', 'fusszeile'
  );
  QuellenBekannt: array[0..23] of string = (
    'text', 'firma.absender', 'firma.fusszeile',
    'beleg.art', 'beleg.nummer', 'beleg.datum', 'beleg.bearbeiter',
    'beleg.ihr_zeichen', 'beleg.bezeichnung', 'beleg.adresse',
    'beleg.kopftext', 'beleg.fusstext', 'beleg.titel', 'beleg.seite',
    'summe.netto', 'summe.mwst', 'summe.brutto',
    'position.pos', 'position.text', 'position.menge',
    'position.einheit', 'position.einzel', 'position.mwst',
    'position.gesamt'
  );

function Feld(const Id, Quelle, Beschriftung, Ausrichtung: string;
  X, Y, Breite, Hoehe, Groesse: Integer; Fett: Boolean): TLayoutFeld;
begin
  Result := Default(TLayoutFeld);
  Result.Id := Id;
  Result.Sichtbar := True;
  Result.XMm := X;
  Result.YMm := Y;
  Result.BreiteMm := Breite;
  Result.HoeheMm := Hoehe;
  Result.Schrift := 'Helvetica';
  Result.Groesse := Groesse;
  Result.Fett := Fett;
  Result.Ausrichtung := Ausrichtung;
  Result.Beschriftung := Beschriftung;
  Result.Quelle := Quelle;
end;

function Spalte(const Id, Beschriftung, Ausrichtung, Quelle: string;
  Breite: Integer): TLayoutSpalte;
begin
  Result := Default(TLayoutSpalte);
  Result.Id := Id;
  Result.Sichtbar := True;
  Result.Beschriftung := Beschriftung;
  Result.BreiteMm := Breite;
  Result.Ausrichtung := Ausrichtung;
  Result.Quelle := Quelle;
end;

function Bereich(const Id, Anker: string; Y: Integer;
  const Felder: array of TLayoutFeld): TLayoutBereich;
var
  i: Integer;
begin
  Result := Default(TLayoutBereich);
  Result.Id := Id;
  Result.Anker := Anker;
  Result.Sichtbar := True;
  Result.YMm := Y;
  SetLength(Result.Felder, Length(Felder));
  for i := 0 to High(Felder) do
    Result.Felder[i] := Felder[i];
end;

function LayoutStandard: TDruckLayout;
begin
  Result := Default(TDruckLayout);
  Result.Version := LayoutVersion;
  Result.Seite := 'A4';
  Result.RandLinks := 25;
  Result.RandRechts := 20;
  Result.RandUnten := 20;
  Result.AnschriftOben := 45;
  Result.TextOben := 105;
  SetLength(Result.Bereiche, 8);
  Result.Bereiche[0] := Bereich('firmenkopf', 'fest', 45,
    [Feld('absender', 'firma.absender', '', 'links', 25, 45, 80, 4, 7, False)]);
  Result.Bereiche[1] := Bereich('anschrift', 'fest', 51,
    [Feld('adresse', 'beleg.adresse', '', 'links', 25, 51, 80, 40, 11, False)]);
  Result.Bereiche[2] := Bereich('belegkopf', 'fest', 45, [
    Feld('art', 'beleg.art', '', 'links', 125, 45, 65, 6, 11, True),
    Feld('nummer', 'beleg.nummer', 'Nr. ', 'links', 125, 51, 65, 5, 10, False),
    Feld('datum', 'beleg.datum', 'Datum ', 'links', 125, 56, 65, 5, 10, False),
    Feld('bearbeiter', 'beleg.bearbeiter', 'Bearbeiter ', 'links', 125, 61, 65, 5, 10, False),
    Feld('ihr_zeichen', 'beleg.ihr_zeichen', 'Ihr Zeichen ', 'links', 125, 66, 65, 5, 10, False)
  ]);
  Result.Bereiche[3] := Bereich('kopftext', 'fluss', 97, [
    Feld('titel', 'beleg.titel', '', 'links', 25, 0, 165, 8, 14, True),
    Feld('bezeichnung', 'beleg.bezeichnung', '', 'links', 25, 0, 165, 5, 11, False),
    Feld('kopftext', 'beleg.kopftext', '', 'links', 25, 0, 165, 0, 10, False)
  ]);
  Result.Bereiche[4] := Bereich('positionen', 'fluss', 105, []);
  Result.Bereiche[5] := Bereich('summen', 'fluss', 0, [
    Feld('netto', 'summe.netto', 'Netto ', 'rechts', 25, 0, 165, 5, 10, False),
    Feld('mwst', 'summe.mwst', 'MwSt ', 'rechts', 25, 0, 165, 5, 10, False),
    Feld('brutto', 'summe.brutto', 'Brutto ', 'rechts', 25, 0, 165, 6, 11, True)
  ]);
  Result.Bereiche[6] := Bereich('fusstext', 'fluss', 0,
    [Feld('fusstext', 'beleg.fusstext', '', 'links', 25, 0, 165, 0, 10, False)]);
  Result.Bereiche[7] := Bereich('fusszeile', 'fest', 283, [
    Feld('seite', 'beleg.seite', 'Seite ', 'links', 25, 283, 35, 4, 8, False),
    Feld('fuss', 'firma.fusszeile', '', 'links', 65, 283, 125, 4, 8, False)
  ]);
  SetLength(Result.Spalten, 7);
  Result.Spalten[0] := Spalte('pos', 'Pos', 'links', 'position.pos', 12);
  Result.Spalten[1] := Spalte('beschreibung', 'Beschreibung', 'links', 'position.text', 68);
  Result.Spalten[2] := Spalte('menge', 'Menge', 'rechts', 'position.menge', 16);
  Result.Spalten[3] := Spalte('einheit', 'Einh.', 'links', 'position.einheit', 14);
  Result.Spalten[4] := Spalte('einzel', 'Einzel', 'rechts', 'position.einzel', 20);
  Result.Spalten[5] := Spalte('mwst', 'MwSt', 'rechts', 'position.mwst', 16);
  Result.Spalten[6] := Spalte('gesamt', 'Gesamt', 'rechts', 'position.gesamt', 19);
end;

function Dabei(const Wert: string; const Liste: array of string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to High(Liste) do
    if Liste[i] = Wert then
      Exit(True);
end;

function QuelleBekannt(const Quelle: string): Boolean;
begin
  Result := Dabei(Quelle, QuellenBekannt);
end;

function LayoutPruefen(const Layout: TDruckLayout; out Fehler: string): Boolean;
var
  i, k, Breite, Nutzbar: Integer;
  Gesehen: TStringList;
  FeldId: string;
begin
  Result := False;
  Fehler := '';
  if Layout.Version <> LayoutVersion then
  begin
    Fehler := 'Die Layoutversion wird nicht unterstützt.';
    Exit;
  end;
  if Layout.Seite <> 'A4' then
  begin
    Fehler := 'Unterstützt wird vorerst nur A4.';
    Exit;
  end;
  if (Layout.RandLinks < 0) or (Layout.RandRechts < 0) or (Layout.RandUnten < 0) or
     (Layout.RandLinks + Layout.RandRechts >= SeiteBreite) or
     (Layout.RandUnten >= SeiteHoehe) then
  begin
    Fehler := 'Die Ränder passen nicht auf das Blatt.';
    Exit;
  end;
  if (Layout.AnschriftOben < 0) or (Layout.AnschriftOben >= SeiteHoehe) or
     (Layout.TextOben < 0) or (Layout.TextOben >= SeiteHoehe) then
  begin
    Fehler := 'Anschrift oder Textbeginn liegen außerhalb des Blatts.';
    Exit;
  end;
  Gesehen := TStringList.Create;
  try
    Gesehen.Sorted := True;
    Gesehen.Duplicates := dupError;
    for i := 0 to High(Layout.Bereiche) do
    begin
      if not Dabei(Layout.Bereiche[i].Id, BereicheBekannt) then
      begin
        Fehler := 'Unbekannter Bereich: ' + Layout.Bereiche[i].Id;
        Exit;
      end;
      if (Layout.Bereiche[i].Anker <> 'fest') and
         (Layout.Bereiche[i].Anker <> 'fluss') then
      begin
        Fehler := 'Der Bereich ' + Layout.Bereiche[i].Id +
          ' braucht den Anker fest oder fluss.';
        Exit;
      end;
      try
        Gesehen.Add('bereich:' + Layout.Bereiche[i].Id);
      except
        Fehler := 'Der Bereich ' + Layout.Bereiche[i].Id + ' kommt doppelt vor.';
        Exit;
      end;
      for k := 0 to High(Layout.Bereiche[i].Felder) do
      begin
        FeldId := Layout.Bereiche[i].Felder[k].Id;
        if FeldId = '' then
        begin
          Fehler := 'Ein Feld hat keinen Namen.';
          Exit;
        end;
        if not QuelleBekannt(Layout.Bereiche[i].Felder[k].Quelle) then
        begin
          Fehler := 'Unbekannte Datenquelle: ' +
            Layout.Bereiche[i].Felder[k].Quelle;
          Exit;
        end;
        if not Dabei(Layout.Bereiche[i].Felder[k].Ausrichtung,
          ['links', 'rechts', 'mitte']) then
        begin
          Fehler := 'Unbekannte Ausrichtung bei ' + FeldId + '.';
          Exit;
        end;
        if (Layout.Bereiche[i].Felder[k].Groesse < 6) or
           (Layout.Bereiche[i].Felder[k].Groesse > 24) then
        begin
          Fehler := 'Die Schriftgröße von ' + FeldId + ' liegt außerhalb von 6 bis 24.';
          Exit;
        end;
        if Layout.Bereiche[i].Anker = 'fest' then
        begin
          if (Layout.Bereiche[i].Felder[k].XMm < 0) or
             (Layout.Bereiche[i].Felder[k].YMm < 0) or
             (Layout.Bereiche[i].Felder[k].XMm +
              Layout.Bereiche[i].Felder[k].BreiteMm > SeiteBreite) or
             (Layout.Bereiche[i].Felder[k].YMm +
              Layout.Bereiche[i].Felder[k].HoeheMm > SeiteHoehe) then
          begin
            Fehler := 'Das Feld ' + FeldId + ' ragt über das Blatt.';
            Exit;
          end;
        end;
        try
          Gesehen.Add('feld:' + FeldId);
        except
          Fehler := 'Das Feld ' + FeldId + ' kommt doppelt vor.';
          Exit;
        end;
      end;
    end;
    Nutzbar := SeiteBreite - Layout.RandLinks - Layout.RandRechts;
    Breite := 0;
    for i := 0 to High(Layout.Spalten) do
    begin
      if Layout.Spalten[i].Id = '' then
      begin
        Fehler := 'Eine Spalte hat keinen Namen.';
        Exit;
      end;
      if not QuelleBekannt(Layout.Spalten[i].Quelle) then
      begin
        Fehler := 'Unbekannte Spaltenquelle: ' + Layout.Spalten[i].Quelle;
        Exit;
      end;
      if not Dabei(Layout.Spalten[i].Ausrichtung, ['links', 'rechts', 'mitte']) then
      begin
        Fehler := 'Unbekannte Ausrichtung bei Spalte ' + Layout.Spalten[i].Id + '.';
        Exit;
      end;
      if Layout.Spalten[i].Sichtbar then
      begin
        if Layout.Spalten[i].BreiteMm <= 0 then
        begin
          Fehler := 'Die Spalte ' + Layout.Spalten[i].Id + ' braucht eine Breite.';
          Exit;
        end;
        Breite := Breite + Layout.Spalten[i].BreiteMm;
      end;
      try
        Gesehen.Add('spalte:' + Layout.Spalten[i].Id);
      except
        Fehler := 'Die Spalte ' + Layout.Spalten[i].Id + ' kommt doppelt vor.';
        Exit;
      end;
    end;
    if Breite > Nutzbar then
    begin
      Fehler := 'Die Spalten sind zusammen breiter als der Textbereich.';
      Exit;
    end;
  finally
    Gesehen.Free;
  end;
  Result := True;
end;

function LayoutAlsJson(const Layout: TDruckLayout): string;
var
  Wurzel, Rand, Bereich, EinFeld, EineSpalte: TJSONObject;
  Liste, Felder, Spalten: TJSONArray;
  i, k: Integer;
begin
  Wurzel := TJSONObject.Create;
  try
    Wurzel.Add('version', Layout.Version);
    Wurzel.Add('seite', Layout.Seite);
    Rand := TJSONObject.Create;
    Rand.Add('links', Layout.RandLinks);
    Rand.Add('rechts', Layout.RandRechts);
    Rand.Add('unten', Layout.RandUnten);
    Wurzel.Add('rand', Rand);
    Wurzel.Add('anschrift_oben', Layout.AnschriftOben);
    Wurzel.Add('text_oben', Layout.TextOben);
    Liste := TJSONArray.Create;
    for i := 0 to High(Layout.Bereiche) do
    begin
      Bereich := TJSONObject.Create;
      Bereich.Add('id', Layout.Bereiche[i].Id);
      Bereich.Add('anker', Layout.Bereiche[i].Anker);
      Bereich.Add('sichtbar', Layout.Bereiche[i].Sichtbar);
      Bereich.Add('y', Layout.Bereiche[i].YMm);
      Felder := TJSONArray.Create;
      for k := 0 to High(Layout.Bereiche[i].Felder) do
      begin
        EinFeld := TJSONObject.Create;
        EinFeld.Add('id', Layout.Bereiche[i].Felder[k].Id);
        EinFeld.Add('sichtbar', Layout.Bereiche[i].Felder[k].Sichtbar);
        EinFeld.Add('x', Layout.Bereiche[i].Felder[k].XMm);
        EinFeld.Add('y', Layout.Bereiche[i].Felder[k].YMm);
        EinFeld.Add('breite', Layout.Bereiche[i].Felder[k].BreiteMm);
        EinFeld.Add('hoehe', Layout.Bereiche[i].Felder[k].HoeheMm);
        EinFeld.Add('schrift', Layout.Bereiche[i].Felder[k].Schrift);
        EinFeld.Add('groesse', Layout.Bereiche[i].Felder[k].Groesse);
        EinFeld.Add('fett', Layout.Bereiche[i].Felder[k].Fett);
        EinFeld.Add('ausrichtung', Layout.Bereiche[i].Felder[k].Ausrichtung);
        EinFeld.Add('beschriftung', Layout.Bereiche[i].Felder[k].Beschriftung);
        EinFeld.Add('quelle', Layout.Bereiche[i].Felder[k].Quelle);
        Felder.Add(EinFeld);
      end;
      Bereich.Add('felder', Felder);
      Liste.Add(Bereich);
    end;
    Wurzel.Add('bereiche', Liste);
    Spalten := TJSONArray.Create;
    for i := 0 to High(Layout.Spalten) do
    begin
      EineSpalte := TJSONObject.Create;
      EineSpalte.Add('id', Layout.Spalten[i].Id);
      EineSpalte.Add('sichtbar', Layout.Spalten[i].Sichtbar);
      EineSpalte.Add('beschriftung', Layout.Spalten[i].Beschriftung);
      EineSpalte.Add('breite', Layout.Spalten[i].BreiteMm);
      EineSpalte.Add('ausrichtung', Layout.Spalten[i].Ausrichtung);
      EineSpalte.Add('quelle', Layout.Spalten[i].Quelle);
      Spalten.Add(EineSpalte);
    end;
    Wurzel.Add('spalten', Spalten);
    Result := Wurzel.FormatJSON;
  finally
    Wurzel.Free;
  end;
end;

function Ganzzahl(Obj: TJSONObject; const Schluessel: string;
  Vorgabe: Integer): Integer;
var
  Daten: TJSONData;
begin
  Daten := Obj.Find(Schluessel);
  if (Daten = nil) or (Daten.JSONType <> jtNumber) then
    Result := Vorgabe
  else
    Result := Daten.AsInteger;
end;

function Wahr(Obj: TJSONObject; const Schluessel: string; Vorgabe: Boolean): Boolean;
var
  Daten: TJSONData;
begin
  Daten := Obj.Find(Schluessel);
  if (Daten = nil) or (Daten.JSONType <> jtBoolean) then
    Result := Vorgabe
  else
    Result := Daten.AsBoolean;
end;

function Textwert(Obj: TJSONObject; const Schluessel, Vorgabe: string): string;
var
  Daten: TJSONData;
begin
  Daten := Obj.Find(Schluessel);
  if (Daten = nil) or (Daten.JSONType <> jtString) then
    Result := Vorgabe
  else
    Result := Daten.AsString;
end;

function FeldLesen(Obj: TJSONObject): TLayoutFeld;
begin
  Result := Default(TLayoutFeld);
  Result.Id := Textwert(Obj, 'id', '');
  Result.Sichtbar := Wahr(Obj, 'sichtbar', True);
  Result.XMm := Ganzzahl(Obj, 'x', 0);
  Result.YMm := Ganzzahl(Obj, 'y', 0);
  Result.BreiteMm := Ganzzahl(Obj, 'breite', 0);
  Result.HoeheMm := Ganzzahl(Obj, 'hoehe', 0);
  Result.Schrift := Textwert(Obj, 'schrift', 'Helvetica');
  Result.Groesse := Ganzzahl(Obj, 'groesse', 10);
  Result.Fett := Wahr(Obj, 'fett', False);
  Result.Ausrichtung := Textwert(Obj, 'ausrichtung', 'links');
  Result.Beschriftung := Textwert(Obj, 'beschriftung', '');
  Result.Quelle := Textwert(Obj, 'quelle', '');
end;

function LayoutAusJson(const Text: string; out Layout: TDruckLayout;
  out Fehler: string): Boolean;
var
  Daten, BereichDaten, FeldDaten, SpaltenDaten: TJSONData;
  Wurzel, Rand, Bereich, EinFeld, EineSpalte: TJSONObject;
  Liste, Felder, Spalten: TJSONArray;
  i, k: Integer;
begin
  Result := False;
  Fehler := '';
  Layout := Default(TDruckLayout);
  Daten := nil;
  try
    try
      Daten := GetJSON(Text);
    except
      on E: Exception do
      begin
        Fehler := 'Das Layout ist kein gültiges JSON.';
        Exit;
      end;
    end;
    if not (Daten is TJSONObject) then
    begin
      Fehler := 'Das Layout ist kein JSON-Objekt.';
      Exit;
    end;
    Wurzel := TJSONObject(Daten);
    Layout.Version := Ganzzahl(Wurzel, 'version', 0);
    if Layout.Version <> LayoutVersion then
    begin
      Fehler := 'Die Layoutversion wird nicht unterstützt.';
      Exit;
    end;
    Layout.Seite := Textwert(Wurzel, 'seite', 'A4');
    if Wurzel.Find('rand') is TJSONObject then
    begin
      Rand := TJSONObject(Wurzel.Find('rand'));
      Layout.RandLinks := Ganzzahl(Rand, 'links', 25);
      Layout.RandRechts := Ganzzahl(Rand, 'rechts', 20);
      Layout.RandUnten := Ganzzahl(Rand, 'unten', 20);
    end
    else
    begin
      Layout.RandLinks := 25;
      Layout.RandRechts := 20;
      Layout.RandUnten := 20;
    end;
    Layout.AnschriftOben := Ganzzahl(Wurzel, 'anschrift_oben', 45);
    Layout.TextOben := Ganzzahl(Wurzel, 'text_oben', 105);
    BereichDaten := Wurzel.Find('bereiche');
    if BereichDaten is TJSONArray then
    begin
      Liste := TJSONArray(BereichDaten);
      SetLength(Layout.Bereiche, Liste.Count);
      for i := 0 to Liste.Count - 1 do
      begin
        if not (Liste.Items[i] is TJSONObject) then
        begin
          Fehler := 'Ein Bereich ist kein JSON-Objekt.';
          Exit;
        end;
        Bereich := TJSONObject(Liste.Items[i]);
        Layout.Bereiche[i].Id := Textwert(Bereich, 'id', '');
        Layout.Bereiche[i].Anker := Textwert(Bereich, 'anker', 'fest');
        Layout.Bereiche[i].Sichtbar := Wahr(Bereich, 'sichtbar', True);
        Layout.Bereiche[i].YMm := Ganzzahl(Bereich, 'y', 0);
        FeldDaten := Bereich.Find('felder');
        if FeldDaten is TJSONArray then
        begin
          Felder := TJSONArray(FeldDaten);
          SetLength(Layout.Bereiche[i].Felder, Felder.Count);
          for k := 0 to Felder.Count - 1 do
          begin
            if not (Felder.Items[k] is TJSONObject) then
            begin
              Fehler := 'Ein Feld ist kein JSON-Objekt.';
              Exit;
            end;
            EinFeld := TJSONObject(Felder.Items[k]);
            Layout.Bereiche[i].Felder[k] := FeldLesen(EinFeld);
          end;
        end;
      end;
    end;
    SpaltenDaten := Wurzel.Find('spalten');
    if SpaltenDaten is TJSONArray then
    begin
      Spalten := TJSONArray(SpaltenDaten);
      SetLength(Layout.Spalten, Spalten.Count);
      for i := 0 to Spalten.Count - 1 do
      begin
        if not (Spalten.Items[i] is TJSONObject) then
        begin
          Fehler := 'Eine Spalte ist kein JSON-Objekt.';
          Exit;
        end;
        EineSpalte := TJSONObject(Spalten.Items[i]);
        Layout.Spalten[i].Id := Textwert(EineSpalte, 'id', '');
        Layout.Spalten[i].Sichtbar := Wahr(EineSpalte, 'sichtbar', True);
        Layout.Spalten[i].Beschriftung := Textwert(EineSpalte, 'beschriftung', '');
        Layout.Spalten[i].BreiteMm := Ganzzahl(EineSpalte, 'breite', 0);
        Layout.Spalten[i].Ausrichtung := Textwert(EineSpalte, 'ausrichtung', 'links');
        Layout.Spalten[i].Quelle := Textwert(EineSpalte, 'quelle', '');
      end;
    end;
    Result := LayoutPruefen(Layout, Fehler);
  finally
    Daten.Free;
  end;
end;

function LayoutLaden(const Datei: string; out Layout: TDruckLayout;
  out Fehler: string): Boolean;
var
  Inhalt: TStringList;
begin
  Result := False;
  Layout := Default(TDruckLayout);
  if not FileExists(Datei) then
  begin
    Fehler := 'Die Layoutdatei fehlt.';
    Exit;
  end;
  Inhalt := TStringList.Create;
  try
    Inhalt.LoadFromFile(Datei);
    Result := LayoutAusJson(Inhalt.Text, Layout, Fehler);
  finally
    Inhalt.Free;
  end;
end;

function LayoutSpeichern(const Datei: string; const Layout: TDruckLayout;
  out Fehler: string): Boolean;
var
  Inhalt: TStringList;
begin
  Result := False;
  if not LayoutPruefen(Layout, Fehler) then
    Exit;
  Inhalt := TStringList.Create;
  try
    try
      Inhalt.Text := LayoutAlsJson(Layout);
      Inhalt.SaveToFile(Datei);
      Result := True;
    except
      on E: Exception do
        Fehler := E.Message;
    end;
  finally
    Inhalt.Free;
  end;
end;

procedure LayoutMitFallback(const Text: string; out Layout: TDruckLayout;
  out Hinweis: string);
begin
  Hinweis := '';
  if Trim(Text) = '' then
  begin
    Layout := LayoutStandard;
    Exit;
  end;
  if not LayoutAusJson(Text, Layout, Hinweis) then
    Layout := LayoutStandard;
end;

end.
