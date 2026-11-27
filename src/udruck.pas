unit udruck;

{ PDF eines Belegs mit fpPDF aus der FPC-Bibliothek. Die Vorlage liegt
  in der Datenbank, damit später jede Belegart eine eigene wählen kann.
  Maße in Millimetern, angelehnt an DIN 5008 Form A.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, ubeleg;

type
  TDruckvorlage = record
    Id: Integer;
    Kuerzel: string;
    Bezeichnung: string;
    Absender: string;
    Fusszeile: string;
    RandLinksMm: Integer;
    RandRechtsMm: Integer;
    AnschriftObenMm: Integer;
    TextObenMm: Integer;
    RandUntenMm: Integer;
    LayoutText: string;
    GrafikArt: string;
    GrafikDaten: RawByteString;
  end;

function DruckvorlageFuer(const ModulKuerzel: string; out Vorlage: TDruckvorlage): Boolean;
function VorlageNachId(Id: Int64; out Vorlage: TDruckvorlage): Boolean;
function VorlageLayoutSchreiben(Id: Int64; const Text: string;
  out Fehler: string): Boolean;
function VorlageKopieren(Id: Int64; const NeuerKuerzel, NeueBezeichnung,
  NeuerText: string; out NeuId: Int64; out Fehler: string): Boolean;
function VorlageAnlegen(const Kuerzel, Bezeichnung, Text: string;
  out NeuId: Int64; out Fehler: string): Boolean;
function Layouthinweis: string;

{ Schreibt die Datei und gibt die Seitenzahl zurück. }
function BelegPdfSchreiben(const Kopf: TBelegKopf;
  const Positionen: array of TBelegPosition; const Vorlage: TDruckvorlage;
  const ArtName, BearbeiterName, Datei: string; out Seiten: Integer;
  out Fehler: string): Boolean;

implementation

uses
  Math, fppdf, FPImage, FPReadJPEG, FPReadPNG, udatenbank, udrucklayout;

procedure GrafikAufSeite(Doc: TPDFDocument; Seite: TPDFPage;
  const Vorlage: TDruckvorlage; Links: Single);
var
  Strom: TStringStream;
  Leser: TFPCustomImageReaderClass;
  Bild: TFPMemoryImage;
  LeserObjekt: TFPCustomImageReader;
  Nr: Integer;
  Breite, Hoehe: Single;
begin
  if (Seite = nil) or (Vorlage.GrafikDaten = '') then
    Exit;
  if Vorlage.GrafikArt = 'jpg' then
    Leser := TFPReaderJPEG
  else if Vorlage.GrafikArt = 'png' then
    Leser := TFPReaderPNG
  else
    Exit;
  Strom := TStringStream.Create(Vorlage.GrafikDaten);
  Bild := TFPMemoryImage.Create(0, 0);
  LeserObjekt := Leser.Create;
  try
    try
      Strom.Position := 0;
      Bild.LoadFromStream(Strom, LeserObjekt);
      Hoehe := 18;
      if Bild.Height > 0 then
        Breite := Hoehe * Bild.Width / Bild.Height
      else
        Breite := Hoehe;
      if Breite > 70 then
      begin
        Hoehe := Hoehe * 70 / Breite;
        Breite := 70;
      end;
      Strom.Position := 0;
      Nr := Doc.Images.AddFromStream(Strom, Leser, False);
      Seite.DrawImage(Links, 297 - 8 - Hoehe, Breite, Hoehe, Nr);
    except
      { Eine defekte Grafik lässt den übrigen Beleg trotzdem entstehen. }
    end;
  finally
    LeserObjekt.Free;
    Bild.Free;
    Strom.Free;
  end;
end;

var
  HinweisZuletzt: string;

const
  SeiteHoch = 297;
  ZeileMm = 5;

function Bereit: Boolean;
begin
  Result := (PlanlosDB <> nil) and PlanlosDB.Verbunden;
end;

procedure ZeileInVorlage(Zeile: TStrings; out Vorlage: TDruckvorlage);
begin
  Vorlage := Default(TDruckvorlage);
  Vorlage.RandLinksMm := 25;
  Vorlage.RandRechtsMm := 20;
  Vorlage.AnschriftObenMm := 45;
  Vorlage.TextObenMm := 105;
  Vorlage.RandUntenMm := 20;
  Vorlage.Id := StrToIntDef(Zeile.Values['id'], 0);
  Vorlage.Kuerzel := Zeile.Values['kuerzel'];
  Vorlage.Bezeichnung := Zeile.Values['bezeichnung'];
  Vorlage.Absender := Zeile.Values['absender'];
  Vorlage.Fusszeile := Zeile.Values['fusszeile'];
  Vorlage.RandLinksMm := StrToIntDef(Zeile.Values['rand_links_mm'], 25);
  Vorlage.RandRechtsMm := StrToIntDef(Zeile.Values['rand_rechts_mm'], 20);
  Vorlage.AnschriftObenMm := StrToIntDef(Zeile.Values['anschrift_oben_mm'], 45);
  Vorlage.TextObenMm := StrToIntDef(Zeile.Values['text_oben_mm'], 105);
  Vorlage.RandUntenMm := StrToIntDef(Zeile.Values['rand_unten_mm'], 20);
  Vorlage.LayoutText := Zeile.Values['layout'];
end;

function DruckvorlageFuer(const ModulKuerzel: string; out Vorlage: TDruckvorlage): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  Vorlage := Default(TDruckvorlage);
  if not Bereit then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['kuerzel'] := ModulKuerzel;
    PlanlosDB.ErsteZeile(
      'SELECT d.id, d.kuerzel, d.bezeichnung, d.absender, d.fusszeile, ' +
      'd.rand_links_mm, d.rand_rechts_mm, d.anschrift_oben_mm, d.text_oben_mm, ' +
      'd.rand_unten_mm, d.layout FROM druckvorlage d ' +
      'JOIN modulart m ON m.druckvorlage_id = d.id WHERE m.kuerzel = :kuerzel',
      Parameter, Zeile);
    if Zeile.Values['id'] = '' then
      PlanlosDB.ErsteZeile(
        'SELECT id, kuerzel, bezeichnung, absender, fusszeile, rand_links_mm, ' +
        'rand_rechts_mm, anschrift_oben_mm, text_oben_mm, rand_unten_mm, layout ' +
        'FROM druckvorlage WHERE kuerzel = ''standard''', nil, Zeile);
    if Zeile.Values['id'] = '' then
      Exit;
    ZeileInVorlage(Zeile, Vorlage);
    Result := Vorlage.Id > 0;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function VorlageNachId(Id: Int64; out Vorlage: TDruckvorlage): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  Vorlage := Default(TDruckvorlage);
  if not Bereit or (Id <= 0) then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT id, kuerzel, bezeichnung, absender, fusszeile, rand_links_mm, ' +
      'rand_rechts_mm, anschrift_oben_mm, text_oben_mm, rand_unten_mm, layout ' +
      'FROM druckvorlage WHERE id = :id', Parameter, Zeile);
    if Zeile.Values['id'] = '' then
      Exit;
    ZeileInVorlage(Zeile, Vorlage);
    Result := True;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function VorlageLayoutSchreiben(Id: Int64; const Text: string;
  out Fehler: string): Boolean;
var
  Parameter: TStringList;
  Layout: TDruckLayout;
begin
  Result := False;
  Fehler := '';
  if not LayoutAusJson(Text, Layout, Fehler) then
    Exit;
  if not Bereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    Parameter.Values['layout'] := Text;
    PlanlosDB.Ausfuehren(
      'UPDATE druckvorlage SET layout = :layout WHERE id = :id', Parameter);
    Result := True;
  finally
    Parameter.Free;
  end;
end;

function KuerzelBelegt(const Kuerzel: string): Boolean;
var
  Parameter: TStringList;
begin
  Parameter := TStringList.Create;
  try
    Parameter.Values['kuerzel'] := Kuerzel;
    Result := PlanlosDB.SkalarMit(
      'SELECT kuerzel FROM druckvorlage WHERE kuerzel = :kuerzel',
      Parameter) <> '';
  finally
    Parameter.Free;
  end;
end;

function KuerzelFrei(const Basis: string): string;
var
  Nummer: Integer;
begin
  if not KuerzelBelegt(Basis) then
    Exit(Basis);
  Nummer := 2;
  while KuerzelBelegt(Basis + '-' + IntToStr(Nummer)) do
    Inc(Nummer);
  Result := Basis + '-' + IntToStr(Nummer);
end;

function VorlageKopieren(Id: Int64; const NeuerKuerzel, NeueBezeichnung,
  NeuerText: string; out NeuId: Int64; out Fehler: string): Boolean;
var
  Parameter: TStringList;
  Layout: TDruckLayout;
  Kuerzel: string;
begin
  Result := False;
  NeuId := 0;
  Fehler := '';
  if not LayoutAusJson(NeuerText, Layout, Fehler) then
    Exit;
  if not Bereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  Kuerzel := KuerzelFrei(NeuerKuerzel);
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    Parameter.Values['kuerzel'] := Kuerzel;
    Parameter.Values['bez'] := NeueBezeichnung;
    Parameter.Values['layout'] := NeuerText;
    PlanlosDB.Ausfuehren(
      'INSERT INTO druckvorlage (kuerzel, bezeichnung, absender, fusszeile, ' +
      'rand_links_mm, rand_rechts_mm, anschrift_oben_mm, text_oben_mm, ' +
      'rand_unten_mm, layout) SELECT :kuerzel, :bez, absender, fusszeile, ' +
      'rand_links_mm, rand_rechts_mm, anschrift_oben_mm, text_oben_mm, ' +
      'rand_unten_mm, :layout FROM druckvorlage WHERE id = :id', Parameter);
    Parameter.Clear;
    Parameter.Values['kuerzel'] := Kuerzel;
    NeuId := StrToInt64Def(PlanlosDB.SkalarMit(
      'SELECT id FROM druckvorlage WHERE kuerzel = :kuerzel', Parameter), 0);
    Result := NeuId > 0;
    if not Result then
      Fehler := 'Die Kopie der Vorlage wurde nicht angelegt.';
  finally
    Parameter.Free;
  end;
end;

function VorlageAnlegen(const Kuerzel, Bezeichnung, Text: string;
  out NeuId: Int64; out Fehler: string): Boolean;
var
  Parameter: TStringList;
  Layout: TDruckLayout;
  Frei: string;
begin
  Result := False;
  NeuId := 0;
  Fehler := '';
  if not LayoutAusJson(Text, Layout, Fehler) then
    Exit;
  if not Bereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  Frei := KuerzelFrei(Kuerzel);
  Parameter := TStringList.Create;
  try
    Parameter.Values['kuerzel'] := Frei;
    Parameter.Values['bez'] := Bezeichnung;
    Parameter.Values['layout'] := Text;
    Parameter.Values['absender'] := 'Planlos · Musterweg 1 · 12345 Musterstadt';
    PlanlosDB.Ausfuehren(
      'INSERT INTO druckvorlage (kuerzel, bezeichnung, absender, fusszeile, ' +
      'rand_links_mm, rand_rechts_mm, anschrift_oben_mm, text_oben_mm, ' +
      'rand_unten_mm, layout) VALUES (:kuerzel, :bez, :absender, '''', ' +
      '25, 20, 45, 105, 20, :layout)', Parameter);
    Parameter.Clear;
    Parameter.Values['kuerzel'] := Frei;
    NeuId := StrToInt64Def(PlanlosDB.SkalarMit(
      'SELECT id FROM druckvorlage WHERE kuerzel = :kuerzel', Parameter), 0);
    Result := NeuId > 0;
    if not Result then
      Fehler := 'Die Vorlage wurde nicht angelegt.';
  finally
    Parameter.Free;
  end;
end;

function Layouthinweis: string;
begin
  Result := HinweisZuletzt;
end;

function DatumDeutsch(const Iso: string): string;
begin
  if (Length(Iso) >= 10) and (Iso[5] = '-') and (Iso[8] = '-') then
    Result := Copy(Iso, 9, 2) + '.' + Copy(Iso, 6, 2) + '.' + Copy(Iso, 1, 4)
  else
    Result := Iso;
end;

function NaechsteZeile(var Rest: string; MaxZeichen: Integer): string;
var
  Bruch, i, Schnitt: Integer;
begin
  Bruch := Pos(LineEnding, Rest);
  if (Bruch > 0) and (Bruch <= MaxZeichen + 1) then
  begin
    Result := Copy(Rest, 1, Bruch - 1);
    Delete(Rest, 1, Bruch + Length(LineEnding) - 1);
    Exit;
  end;
  if Length(Rest) <= MaxZeichen then
  begin
    Result := Rest;
    Rest := '';
    Exit;
  end;
  Schnitt := MaxZeichen;
  for i := MaxZeichen downto 1 do
    if Rest[i] = ' ' then
    begin
      Schnitt := i - 1;
      Break;
    end;
  if Schnitt < 1 then
    Schnitt := MaxZeichen;
  Result := Copy(Rest, 1, Schnitt);
  Delete(Rest, 1, Schnitt);
  while (Rest <> '') and (Rest[1] = ' ') do
    Delete(Rest, 1, 1);
end;

function PdfAusLayout(const Kopf: TBelegKopf;
  const Positionen: array of TBelegPosition; const Vorlage: TDruckvorlage;
  const Layout: TDruckLayout; const ArtName, BearbeiterName, Datei: string;
  out Seiten: Integer; out Fehler: string): Boolean;
var
  Doc: TPDFDocument;
  Abschnitt: TPDFSection;
  Blatt: array of TPDFPage;
  Normal, Fett: Integer;
  Oben, Grenze, Links, Rechts, Laufend, SpalteX: Single;
  LaufendCent: Int64;
  Index, g, s, b: Integer;
  RestText, Stueck: string;
  Summe: TBelegSumme;
  SpaltenX: array of Single;

  function VonUnten(VonOben: Single): Single;
  begin
    Result := SeiteHoch - VonOben;
  end;

  procedure Schrift(Groesse: Integer; Dick: Boolean);
  begin
    if Dick then
      Blatt[High(Blatt)].SetFont(Fett, Groesse)
    else
      Blatt[High(Blatt)].SetFont(Normal, Groesse);
  end;

  procedure Text(X, VonOben: Single; Groesse: Integer; const Wert: string;
    Dick: Boolean);
  begin
    if Wert = '' then
      Exit;
    Schrift(Groesse, Dick);
    Blatt[High(Blatt)].WriteText(X, VonUnten(VonOben), Wert);
  end;

  procedure RechtsText(Rand, VonOben: Single; Groesse: Integer; const Wert: string;
    Dick: Boolean);
  begin
    Text(Rand - Length(Wert) * 1.6, VonOben, Groesse, Wert, Dick);
  end;

  procedure Strich(X1, O1, X2, O2: Single);
  begin
    Blatt[High(Blatt)].SetColor($000000, True);
    Blatt[High(Blatt)].DrawLine(X1, VonUnten(O1), X2, VonUnten(O2), 0.2, True);
  end;

  procedure NeueSeite;
  var
    Seite: TPDFPage;
  begin
    Seite := Doc.Pages.AddPage;
    Seite.PaperType := ptA4;
    Seite.UnitOfMeasure := uomMillimeters;
    Abschnitt.AddPage(Seite);
    SetLength(Blatt, Length(Blatt) + 1);
    Blatt[High(Blatt)] := Seite;
  end;

  function PosText(const Position: TBelegPosition): string;
  begin
    if Position.ArtikelName <> '' then
      Result := Position.ArtikelName
    else
      Result := Position.Text;
  end;

  function BereichBei(const Id: string): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := 0 to High(Layout.Bereiche) do
      if Layout.Bereiche[i].Id = Id then
        Exit(i);
  end;

  function FeldBei(Bereich: Integer; const Id: string): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    if Bereich < 0 then
      Exit;
    for i := 0 to High(Layout.Bereiche[Bereich].Felder) do
      if Layout.Bereiche[Bereich].Felder[i].Id = Id then
        Exit(i);
  end;

  procedure TextAn(const Feld: TLayoutFeld; const Wert: string);
  var
    ZeileText: string;
    X: Single;
  begin
    if not Feld.Sichtbar then
      Exit;
    if (Wert = '') and (Feld.Quelle <> 'text') then
      Exit;
    ZeileText := Feld.Beschriftung + Wert;
    if ZeileText = '' then
      Exit;
    if Feld.Ausrichtung = 'rechts' then
      RechtsText(Feld.XMm + Feld.BreiteMm, Feld.YMm, Feld.Groesse, ZeileText, Feld.Fett)
    else if Feld.Ausrichtung = 'mitte' then
    begin
      X := Feld.XMm + (Feld.BreiteMm - Length(ZeileText) * 1.6) / 2;
      if X < Feld.XMm then
        X := Feld.XMm;
      Text(X, Feld.YMm, Feld.Groesse, ZeileText, Feld.Fett);
    end
    else
      Text(Feld.XMm, Feld.YMm, Feld.Groesse, ZeileText, Feld.Fett);
  end;

  procedure Block(const Feld: TLayoutFeld; const Wert: string; MaxZeichen: Integer);
  var
    Offen, Teil: string;
    Y: Single;
  begin
    if not Feld.Sichtbar or (Wert = '') then
      Exit;
    Offen := Wert;
    Y := Feld.YMm;
    while Offen <> '' do
    begin
      Teil := NaechsteZeile(Offen, MaxZeichen);
      Text(Feld.XMm, Y, Feld.Groesse, Teil, Feld.Fett);
      Y := Y + ZeileMm;
    end;
  end;

  procedure Fluss(const Feld: TLayoutFeld; const Wert: string; MaxZeichen: Integer);
  var
    Offen, Teil: string;
  begin
    if not Feld.Sichtbar or (Wert = '') then
      Exit;
    if MaxZeichen <= 0 then
    begin
      Text(Feld.XMm, Oben, Feld.Groesse, Feld.Beschriftung + Wert, Feld.Fett);
      if Feld.HoeheMm > 0 then
        Oben := Oben + Feld.HoeheMm
      else
        Oben := Oben + ZeileMm;
      Exit;
    end;
    Offen := Wert;
    while Offen <> '' do
    begin
      if Oben + ZeileMm > Grenze then
      begin
        NeueSeite;
        Oben := 18;
      end;
      Teil := NaechsteZeile(Offen, MaxZeichen);
      Text(Feld.XMm, Oben, Feld.Groesse, Teil, Feld.Fett);
      Oben := Oben + ZeileMm;
    end;
  end;

  procedure Tabellenkopf;
  var
    i: Integer;
  begin
    for i := 0 to High(Layout.Spalten) do
    begin
      if not Layout.Spalten[i].Sichtbar then
        Continue;
      Text(SpaltenX[i], Oben, 8, Layout.Spalten[i].Beschriftung, True);
    end;
    Oben := Oben + 4;
    Strich(Links, Oben, Rechts, Oben);
    Oben := Oben + 4;
  end;

  procedure Zelle(i: Integer; const Wert: string; Groesse: Integer);
  begin
    if (i < 0) or (i > High(Layout.Spalten)) or not Layout.Spalten[i].Sichtbar or
       (Wert = '') then
      Exit;
    if Layout.Spalten[i].Ausrichtung = 'rechts' then
      RechtsText(SpaltenX[i] + Layout.Spalten[i].BreiteMm - 2, Oben, Groesse, Wert, False)
    else
      Text(SpaltenX[i], Oben, Groesse, Wert, False);
  end;

  function SpalteVon(const Quelle: string): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := 0 to High(Layout.Spalten) do
      if Layout.Spalten[i].Quelle = Quelle then
        Exit(i);
  end;

  procedure FussJederSeite;
  var
    i, f, Bereich: Integer;
    Feld: TLayoutFeld;
    Wert: string;
  begin
    Bereich := BereichBei('fusszeile');
    if (Bereich < 0) or not Layout.Bereiche[Bereich].Sichtbar then
      Exit;
    for i := 0 to High(Blatt) do
      for f := 0 to High(Layout.Bereiche[Bereich].Felder) do
      begin
        Feld := Layout.Bereiche[Bereich].Felder[f];
        if not Feld.Sichtbar then
          Continue;
        if Feld.Quelle = 'beleg.seite' then
          Wert := IntToStr(i + 1) + ' von ' + IntToStr(Length(Blatt))
        else if Feld.Quelle = 'firma.fusszeile' then
          Wert := Vorlage.Fusszeile
        else
          Wert := '';
        if Feld.Beschriftung + Wert = '' then
          Continue;
        Blatt[i].SetFont(Normal, Feld.Groesse);
        Blatt[i].WriteText(Feld.XMm, VonUnten(Feld.YMm), Feld.Beschriftung + Wert);
      end;
  end;

begin
  Seiten := 0;
  Fehler := '';
  Result := False;
  Doc := TPDFDocument.Create(nil);
  try
    try
      Doc.StartDocument;
      Doc.DefaultPaperType := ptA4;
      Abschnitt := Doc.Sections.AddSection;
      Normal := Doc.AddFont('Helvetica');
      Fett := Doc.AddFont('Helvetica-Bold');
      Links := Layout.RandLinks;
      Rechts := SeiteBreite - Layout.RandRechts;
      Grenze := SeiteHoch - Layout.RandUnten - 8;
      SetLength(SpaltenX, Length(Layout.Spalten));
      SpalteX := Links;
      for s := 0 to High(Layout.Spalten) do
      begin
        SpaltenX[s] := SpalteX;
        if Layout.Spalten[s].Sichtbar then
          SpalteX := SpalteX + Layout.Spalten[s].BreiteMm;
      end;
      NeueSeite;
      GrafikAufSeite(Doc, Blatt[High(Blatt)], Vorlage, Links);
      b := BereichBei('firmenkopf');
      s := FeldBei(b, 'absender');
      if s >= 0 then
      begin
        TextAn(Layout.Bereiche[b].Felder[s], Vorlage.Absender);
        if Layout.Bereiche[b].Felder[s].Sichtbar and (Vorlage.Absender <> '') then
          Strich(Layout.Bereiche[b].Felder[s].XMm,
            Layout.Bereiche[b].Felder[s].YMm + 2,
            Layout.Bereiche[b].Felder[s].XMm + Layout.Bereiche[b].Felder[s].BreiteMm,
            Layout.Bereiche[b].Felder[s].YMm + 2);
      end;
      b := BereichBei('anschrift');
      s := FeldBei(b, 'adresse');
      if s >= 0 then
        Block(Layout.Bereiche[b].Felder[s], Kopf.AdresseText,
          Max(8, Layout.Bereiche[b].Felder[s].BreiteMm div 2));
      b := BereichBei('belegkopf');
      s := FeldBei(b, 'art');
      if s >= 0 then
        TextAn(Layout.Bereiche[b].Felder[s], ArtName);
      s := FeldBei(b, 'nummer');
      if s >= 0 then
      begin
        if Kopf.Nummer = '' then
          TextAn(Layout.Bereiche[b].Felder[s], 'neu')
        else
          TextAn(Layout.Bereiche[b].Felder[s], Kopf.Nummer);
      end;
      s := FeldBei(b, 'datum');
      if s >= 0 then
        TextAn(Layout.Bereiche[b].Felder[s], DatumDeutsch(Kopf.Erfasst));
      s := FeldBei(b, 'bearbeiter');
      if s >= 0 then
        TextAn(Layout.Bereiche[b].Felder[s], BearbeiterName);
      s := FeldBei(b, 'ihr_zeichen');
      if s >= 0 then
        TextAn(Layout.Bereiche[b].Felder[s], Kopf.IhrZeichen);
      b := BereichBei('kopftext');
      if (b >= 0) and Layout.Bereiche[b].Sichtbar then
        Oben := Layout.Bereiche[b].YMm
      else
        Oben := Layout.TextOben;
      if b >= 0 then
      begin
        s := FeldBei(b, 'titel');
        if s >= 0 then
          Fluss(Layout.Bereiche[b].Felder[s], Trim(ArtName + ' ' + Kopf.Nummer), 0);
        s := FeldBei(b, 'bezeichnung');
        if s >= 0 then
          Fluss(Layout.Bereiche[b].Felder[s], Kopf.Bezeichnung, 0);
        s := FeldBei(b, 'kopftext');
        if s >= 0 then
        begin
          Fluss(Layout.Bereiche[b].Felder[s], Kopf.Kopftext,
            Max(8, Layout.Bereiche[b].Felder[s].BreiteMm div 2));
          if Kopf.Kopftext <> '' then
            Oben := Oben + 2;
        end;
      end;
      b := BereichBei('positionen');
      if (b >= 0) and (Oben < Layout.Bereiche[b].YMm) then
        Oben := Layout.Bereiche[b].YMm
      else if (b < 0) and (Oben < Layout.TextOben) then
        Oben := Layout.TextOben;
      if (b < 0) or Layout.Bereiche[b].Sichtbar then
        Tabellenkopf;
      LaufendCent := 0;
      for Index := 0 to High(Positionen) do
      begin
        if PosText(Positionen[Index]) = '' then
          Continue;
        if Oben + ZeileMm > Grenze then
        begin
          Text(Links, Oben, 9, 'Übertrag ' + CentAlsText(LaufendCent) + ' EUR', True);
          Oben := Oben + ZeileMm;
          NeueSeite;
          Oben := 18;
          Text(Links, Oben, 11, Trim(ArtName + ' ' + Kopf.Nummer), True);
          Oben := Oben + 6;
          Text(Links, Oben, 9, 'Übertrag ' + CentAlsText(LaufendCent) + ' EUR', True);
          Oben := Oben + ZeileMm;
          Tabellenkopf;
        end;
        Zelle(SpalteVon('position.pos'), IntToStr(Index + 1), 9);
        s := SpalteVon('position.text');
        if s >= 0 then
          Zelle(s, Copy(PosText(Positionen[Index]), 1,
            Max(4, Round(Layout.Spalten[s].BreiteMm / 1.62))), 9);
        Zelle(SpalteVon('position.menge'), MilliAlsText(Positionen[Index].MengeMilli), 9);
        Zelle(SpalteVon('position.einheit'), Positionen[Index].Einheit, 9);
        Zelle(SpalteVon('position.einzel'), CentAlsText(Positionen[Index].EinzelpreisCent), 9);
        Zelle(SpalteVon('position.mwst'), IntToStr(Positionen[Index].MwstSatz) + ' %', 9);
        Zelle(SpalteVon('position.gesamt'), CentAlsText(PositionNetto(Positionen[Index])), 9);
        Oben := Oben + ZeileMm;
        LaufendCent := LaufendCent + PositionNetto(Positionen[Index]);
        if (s >= 0) and (Positionen[Index].Text <> '') and
           (Positionen[Index].Text <> Positionen[Index].ArtikelName) and
           (Positionen[Index].ArtikelName <> '') then
        begin
          Text(SpaltenX[s], Oben, 8, Copy(Positionen[Index].Text, 1, 70), False);
          Oben := Oben + 4;
        end;
      end;
      Summe := SummeRechnen(Positionen, Kopf.MwstRechnen);
      if Oben + 30 > Grenze then
      begin
        NeueSeite;
        Oben := 18;
        Text(Links, Oben, 11, Trim(ArtName + ' ' + Kopf.Nummer), True);
        Oben := Oben + 8;
      end;
      b := BereichBei('summen');
      if (b < 0) or Layout.Bereiche[b].Sichtbar then
      begin
        Oben := Oben + 2;
        Strich(Links + 110, Oben, Rechts, Oben);
        Oben := Oben + 5;
        if b >= 0 then
          for s := 0 to High(Layout.Bereiche[b].Felder) do
          begin
            if not Layout.Bereiche[b].Felder[s].Sichtbar then
              Continue;
            if Layout.Bereiche[b].Felder[s].Quelle = 'summe.netto' then
            begin
              RechtsText(Rechts, Oben, Layout.Bereiche[b].Felder[s].Groesse,
                Layout.Bereiche[b].Felder[s].Beschriftung +
                CentAlsText(Summe.NettoCent) + ' EUR',
                Layout.Bereiche[b].Felder[s].Fett);
              Oben := Oben + ZeileMm;
            end
            else if Layout.Bereiche[b].Felder[s].Quelle = 'summe.mwst' then
            begin
              for g := 0 to High(Summe.Gruppen) do
                if Summe.Gruppen[g].Satz <> 0 then
                begin
                  RechtsText(Rechts, Oben, Layout.Bereiche[b].Felder[s].Groesse,
                    Layout.Bereiche[b].Felder[s].Beschriftung +
                    IntToStr(Summe.Gruppen[g].Satz) + ' % ' +
                    CentAlsText(Summe.Gruppen[g].SteuerCent) + ' EUR',
                    Layout.Bereiche[b].Felder[s].Fett);
                  Oben := Oben + ZeileMm;
                end;
            end
            else if Layout.Bereiche[b].Felder[s].Quelle = 'summe.brutto' then
            begin
              RechtsText(Rechts, Oben, Layout.Bereiche[b].Felder[s].Groesse,
                Layout.Bereiche[b].Felder[s].Beschriftung +
                CentAlsText(Summe.BruttoCent) + ' EUR',
                Layout.Bereiche[b].Felder[s].Fett);
              Oben := Oben + 8;
            end;
          end;
      end;
      b := BereichBei('fusstext');
      s := FeldBei(b, 'fusstext');
      if s >= 0 then
        Fluss(Layout.Bereiche[b].Felder[s], Kopf.Fusstext,
          Max(8, Layout.Bereiche[b].Felder[s].BreiteMm div 2));
      FussJederSeite;
      Doc.SaveToFile(Datei);
      Seiten := Length(Blatt);
      Result := (Seiten > 0) and FileExists(Datei);
      if not Result then
        Fehler := 'Die PDF-Datei wurde nicht geschrieben.';
    except
      on E: Exception do
        Fehler := E.Message;
    end;
  finally
    Doc.Free;
  end;
end;


function BelegPdfSchreiben(const Kopf: TBelegKopf;
  const Positionen: array of TBelegPosition; const Vorlage: TDruckvorlage;
  const ArtName, BearbeiterName, Datei: string; out Seiten: Integer;
  out Fehler: string): Boolean;
var
  Doc: TPDFDocument;
  Abschnitt: TPDFSection;
  Blatt: array of TPDFPage;
  Normal, Fett: Integer;
  Oben, Grenze, Links, Rechts, Laufend: Single;
  LaufendCent: Int64;
  Index, g: Integer;
  Rest, Zeile, Hinweis: string;
  Summe: TBelegSumme;
  Layout: TDruckLayout;

  function VonUnten(VonOben: Single): Single;
  begin
    Result := SeiteHoch - VonOben;
  end;

  procedure Schrift(Groesse: Integer; Dick: Boolean);
  begin
    if Dick then
      Blatt[High(Blatt)].SetFont(Fett, Groesse)
    else
      Blatt[High(Blatt)].SetFont(Normal, Groesse);
  end;

  procedure Text(X, VonOben: Single; Groesse: Integer; const Inhalt: string;
    Dick: Boolean);
  begin
    if Inhalt = '' then
      Exit;
    Schrift(Groesse, Dick);
    Blatt[High(Blatt)].WriteText(X, VonUnten(VonOben), Inhalt);
  end;

  procedure RechtsText(Rand, VonOben: Single; Groesse: Integer; const Inhalt: string;
    Dick: Boolean);
  begin
    Text(Rand - Length(Inhalt) * 1.6, VonOben, Groesse, Inhalt, Dick);
  end;

  procedure Strich(X1, O1, X2, O2: Single);
  begin
    Blatt[High(Blatt)].SetColor($000000, True);
    Blatt[High(Blatt)].DrawLine(X1, VonUnten(O1), X2, VonUnten(O2), 0.2, True);
  end;

  procedure FussJederSeite;
  var
    i: Integer;
  begin
    for i := 0 to High(Blatt) do
    begin
      Blatt[i].SetFont(Normal, 8);
      Blatt[i].WriteText(Links, Vorlage.RandUntenMm - 6,
        'Seite ' + IntToStr(i + 1) + ' von ' + IntToStr(Length(Blatt)));
      if Vorlage.Fusszeile <> '' then
        Blatt[i].WriteText(Links + 40, Vorlage.RandUntenMm - 6, Vorlage.Fusszeile);
    end;
  end;

  procedure NeueSeite;
  var
    Seite: TPDFPage;
  begin
    Seite := Doc.Pages.AddPage;
    Seite.PaperType := ptA4;
    Seite.UnitOfMeasure := uomMillimeters;
    Abschnitt.AddPage(Seite);
    SetLength(Blatt, Length(Blatt) + 1);
    Blatt[High(Blatt)] := Seite;
  end;

  procedure Tabellenkopf;
  begin
    Text(Links, Oben, 8, 'Pos', True);
    Text(Links + 12, Oben, 8, 'Beschreibung', True);
    RechtsText(Links + 96, Oben, 8, 'Menge', True);
    Text(Links + 100, Oben, 8, 'Einh.', True);
    RechtsText(Links + 132, Oben, 8, 'Einzel', True);
    Text(Links + 140, Oben, 8, 'MwSt', True);
    Text(Links + 168, Oben, 8, 'Gesamt', True);
    Oben := Oben + 4;
    Strich(Links, Oben, Rechts, Oben);
    Oben := Oben + 4;
  end;

  procedure UebertragZeile(const Vorspann: string);
  begin
    Text(Links, Oben, 9, Vorspann + CentAlsText(LaufendCent) + ' EUR', True);
    Oben := Oben + ZeileMm;
  end;

  function PosText(const Position: TBelegPosition): string;
  begin
    if Position.ArtikelName <> '' then
      Result := Position.ArtikelName
    else
      Result := Position.Text;
  end;

begin
  Seiten := 0;
  Fehler := '';
  Result := False;
  HinweisZuletzt := '';
  if Datei = '' then
  begin
    Fehler := 'Die PDF-Datei hat keinen Namen.';
    Exit;
  end;
  if LayoutAusJson(Vorlage.LayoutText, Layout, Hinweis) then
  begin
    Result := PdfAusLayout(Kopf, Positionen, Vorlage, Layout, ArtName,
      BearbeiterName, Datei, Seiten, Fehler);
    Exit;
  end;
  if Trim(Vorlage.LayoutText) <> '' then
    HinweisZuletzt := Hinweis;
  Doc := TPDFDocument.Create(nil);
  try
    try
      Doc.StartDocument;
      Doc.DefaultPaperType := ptA4;
      Abschnitt := Doc.Sections.AddSection;
      Normal := Doc.AddFont('Helvetica');
      Fett := Doc.AddFont('Helvetica-Bold');
      Links := Vorlage.RandLinksMm;
      Rechts := 210 - Vorlage.RandRechtsMm;
      Grenze := SeiteHoch - Vorlage.RandUntenMm - 8;
      NeueSeite;
      GrafikAufSeite(Doc, Blatt[High(Blatt)], Vorlage, Links);
      Text(Links, Vorlage.AnschriftObenMm, 7, Vorlage.Absender, False);
      Strich(Links, Vorlage.AnschriftObenMm + 2, Links + 80,
        Vorlage.AnschriftObenMm + 2);
      Oben := Vorlage.AnschriftObenMm + 6;
      Rest := Kopf.AdresseText;
      while Rest <> '' do
      begin
        Zeile := NaechsteZeile(Rest, 40);
        Text(Links, Oben, 11, Zeile, False);
        Oben := Oben + 5;
      end;
      Oben := Vorlage.AnschriftObenMm;
      Text(125, Oben, 11, ArtName, True);
      Oben := Oben + 6;
      if Kopf.Nummer = '' then
        Text(125, Oben, 10, 'Nr. neu', False)
      else
        Text(125, Oben, 10, 'Nr. ' + Kopf.Nummer, False);
      Oben := Oben + 5;
      Text(125, Oben, 10, 'Datum ' + DatumDeutsch(Kopf.Erfasst), False);
      if BearbeiterName <> '' then
      begin
        Oben := Oben + 5;
        Text(125, Oben, 10, 'Bearbeiter ' + BearbeiterName, False);
      end;
      if Kopf.IhrZeichen <> '' then
      begin
        Oben := Oben + 5;
        Text(125, Oben, 10, 'Ihr Zeichen ' + Kopf.IhrZeichen, False);
      end;
      Oben := Vorlage.TextObenMm - 8;
      Text(Links, Oben, 14, Trim(ArtName + ' ' + Kopf.Nummer), True);
      Oben := Oben + 8;
      if Kopf.Bezeichnung <> '' then
      begin
        Text(Links, Oben, 11, Kopf.Bezeichnung, False);
        Oben := Oben + ZeileMm;
      end;
      if Kopf.Kopftext <> '' then
      begin
        Rest := Kopf.Kopftext;
        while Rest <> '' do
        begin
          Zeile := NaechsteZeile(Rest, 85);
          Text(Links, Oben, 10, Zeile, False);
          Oben := Oben + ZeileMm;
        end;
        Oben := Oben + 2;
      end;
      if Oben < Vorlage.TextObenMm then
        Oben := Vorlage.TextObenMm;
      Tabellenkopf;
      LaufendCent := 0;
      for Index := 0 to High(Positionen) do
      begin
        if PosText(Positionen[Index]) = '' then
          Continue;
        if Oben + ZeileMm > Grenze then
        begin
          UebertragZeile('Übertrag ');
          NeueSeite;
          Oben := 18;
          Text(Links, Oben, 11, Trim(ArtName + ' ' + Kopf.Nummer), True);
          Oben := Oben + 6;
          UebertragZeile('Übertrag ');
          Tabellenkopf;
        end;
        Text(Links, Oben, 9, IntToStr(Index + 1), False);
        Text(Links + 12, Oben, 9, Copy(PosText(Positionen[Index]), 1, 42), False);
        RechtsText(Links + 96, Oben, 9, MilliAlsText(Positionen[Index].MengeMilli), False);
        Text(Links + 100, Oben, 9, Positionen[Index].Einheit, False);
        RechtsText(Links + 132, Oben, 9, CentAlsText(Positionen[Index].EinzelpreisCent), False);
        RechtsText(Links + 156, Oben, 9, IntToStr(Positionen[Index].MwstSatz) + ' %', False);
        RechtsText(Rechts, Oben, 9, CentAlsText(PositionNetto(Positionen[Index])), False);
        Oben := Oben + ZeileMm;
        LaufendCent := LaufendCent + PositionNetto(Positionen[Index]);
        if (Positionen[Index].Text <> '') and
           (Positionen[Index].Text <> Positionen[Index].ArtikelName) and
           (Positionen[Index].ArtikelName <> '') then
        begin
          Text(Links + 12, Oben, 8, Copy(Positionen[Index].Text, 1, 70), False);
          Oben := Oben + 4;
        end;
      end;
      Summe := SummeRechnen(Positionen, Kopf.MwstRechnen);
        if Oben + 30 > Grenze then
        begin
          NeueSeite;
          Oben := 18;
          Text(Links, Oben, 11, Trim(ArtName + ' ' + Kopf.Nummer), True);
          Oben := Oben + 8;
        end;
        Oben := Oben + 2;
        Strich(Links + 110, Oben, Rechts, Oben);
        Oben := Oben + 5;
        RechtsText(Rechts, Oben, 10, 'Netto ' + CentAlsText(Summe.NettoCent) + ' EUR', False);
        Oben := Oben + ZeileMm;
        for g := 0 to High(Summe.Gruppen) do
          if Summe.Gruppen[g].Satz <> 0 then
          begin
            RechtsText(Rechts, Oben, 10, 'MwSt ' + IntToStr(Summe.Gruppen[g].Satz) +
              ' % ' + CentAlsText(Summe.Gruppen[g].SteuerCent) + ' EUR', False);
            Oben := Oben + ZeileMm;
          end;
        RechtsText(Rechts, Oben, 11, 'Brutto ' + CentAlsText(Summe.BruttoCent) + ' EUR', True);
        Oben := Oben + 8;
      Rest := Kopf.Fusstext;
      while Rest <> '' do
      begin
        if Oben + ZeileMm > Grenze then
        begin
          NeueSeite;
          Oben := 18;
        end;
        Zeile := NaechsteZeile(Rest, 85);
        Text(Links, Oben, 10, Zeile, False);
        Oben := Oben + ZeileMm;
      end;
      FussJederSeite;
      Doc.SaveToFile(Datei);
      Seiten := Length(Blatt);
      Result := (Seiten > 0) and FileExists(Datei);
      if not Result then
        Fehler := 'Die PDF-Datei wurde nicht geschrieben.';
    except
      on E: Exception do
        Fehler := E.Message;
    end;
  finally
    Doc.Free;
  end;
end;

end.
