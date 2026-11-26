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
  end;

function DruckvorlageFuer(const ModulKuerzel: string; out Vorlage: TDruckvorlage): Boolean;

{ Schreibt die Datei und gibt die Seitenzahl zurück. }
function BelegPdfSchreiben(const Kopf: TBelegKopf;
  const Positionen: array of TBelegPosition; const Vorlage: TDruckvorlage;
  const ArtName, BearbeiterName, Datei: string; out Seiten: Integer;
  out Fehler: string): Boolean;

implementation

uses
  fppdf, udatenbank;

const
  SeiteHoch = 297;
  ZeileMm = 5;

function Bereit: Boolean;
begin
  Result := (PlanlosDB <> nil) and PlanlosDB.Verbunden;
end;

function DruckvorlageFuer(const ModulKuerzel: string; out Vorlage: TDruckvorlage): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  Vorlage := Default(TDruckvorlage);
  Vorlage.RandLinksMm := 25;
  Vorlage.RandRechtsMm := 20;
  Vorlage.AnschriftObenMm := 45;
  Vorlage.TextObenMm := 105;
  Vorlage.RandUntenMm := 20;
  if not Bereit then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['kuerzel'] := ModulKuerzel;
    PlanlosDB.ErsteZeile(
      'SELECT d.id, d.kuerzel, d.bezeichnung, d.absender, d.fusszeile, ' +
      'd.rand_links_mm, d.rand_rechts_mm, d.anschrift_oben_mm, d.text_oben_mm, ' +
      'd.rand_unten_mm FROM druckvorlage d JOIN modulart m ON m.druckvorlage_id = d.id ' +
      'WHERE m.kuerzel = :kuerzel', Parameter, Zeile);
    if Zeile.Values['id'] = '' then
      PlanlosDB.ErsteZeile(
        'SELECT id, kuerzel, bezeichnung, absender, fusszeile, rand_links_mm, ' +
        'rand_rechts_mm, anschrift_oben_mm, text_oben_mm, rand_unten_mm ' +
        'FROM druckvorlage WHERE kuerzel = ''standard''', nil, Zeile);
    if Zeile.Values['id'] = '' then
      Exit;
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
    Result := Vorlage.Id > 0;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
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
  Rest, Zeile: string;
  Summe: TBelegSumme;

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
  if Datei = '' then
  begin
    Fehler := 'Die PDF-Datei hat keinen Namen.';
    Exit;
  end;
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
