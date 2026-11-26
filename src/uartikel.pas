unit uartikel;

{ Artikel und Artikelgruppen. Preise in ganzen Cent, Aufschlag in
  Hundertsteln eines Prozents (1500 = 15,00 %). Der MwSt-Satz ist ein
  ganzer Prozentwert am Artikel.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils;

type
  TArtikelGruppe = record
    Id: Int64;
    Bezeichnung: string;
    Berechnungsart: string;
    AufschlagBp: Integer;
    Kostenart: string;
    SichtbarGewicht: Boolean;
    SichtbarZahl1: Boolean;
    SichtbarZahl2: Boolean;
    SichtbarZahl3: Boolean;
    SichtbarPostext: Boolean;
    SichtbarName1: Boolean;
    SichtbarName2: Boolean;
    SichtbarName3: Boolean;
    SichtbarLieferant: Boolean;
    SichtbarBestand: Boolean;
    SichtbarMinBestand: Boolean;
    SichtbarLieferantNr: Boolean;
    EinheitMengeWieEk: Boolean;
    VorgabeArtikel: string;
    VorgabeEkCent: Int64;
    VorgabeAufschlagBp: Integer;
    VorgabeEinheitMenge: string;
    VorgabeEinheitEk: string;
    VorgabeLieferant: string;
  end;

  TArtikel = record
    Id: Int64;
    GruppeId: Int64;
    Gruppe: string;
    Bezeichnung: string;
    EkCent: Int64;
    EinheitEk: string;
    AufschlagBp: Integer;
    MwstSatz: Integer;
    GewichtMilli: Int64;
    Zahl1Milli: Int64;
    Zahl2Milli: Int64;
    Zahl3Milli: Int64;
    Name1: string;
    Name2: string;
    Name3: string;
    Lieferant: string;
    LieferantNr: string;
    PosText: string;
    EinheitMenge: string;
    Berechnungsart: string;
    Kostenart: string;
    BestandMilli: Int64;
    MinBestandMilli: Int64;
  end;

function Stammliste(const Kuerzel: string): Boolean;
function VerkaufspreisCent(EkCent: Int64; AufschlagBp: Integer): Int64;
function BruttoCent(NettoCent: Int64; MwstSatz: Integer): Int64;
function CentAusText(const Text: string; out Cent: Int64): Boolean;
function TextAusCent(Cent: Int64): string;
function MilliAusText(const Text: string; out Milli: Int64): Boolean;
function TextAusMilli(Milli: Int64): string;
function TextAusAufschlag(Bp: Integer): string;
function AufschlagAusText(const Text: string; out Bp: Integer): Boolean;

function GruppeLaden(Id: Int64; out Gruppe: TArtikelGruppe): Boolean;
function GruppeNachName(const Name: string; out Gruppe: TArtikelGruppe): Boolean;
function GruppeSpeichern(var Gruppe: TArtikelGruppe; out Fehler: string): Int64;
function GruppeLoeschen(Id: Int64; out Fehler: string): Boolean;
function GruppeKopieren(Id: Int64; out Fehler: string): Int64;

function ArtikelLaden(Id: Int64; out Artikel: TArtikel): Boolean;
function ArtikelSpeichern(var Artikel: TArtikel; out Fehler: string): Int64;
function ArtikelLoeschen(Id: Int64; out Fehler: string): Boolean;
function ArtikelKopieren(Id: Int64; out Fehler: string): Int64;

procedure StammLesen(const Kuerzel, Suchtext: string; Spalten, Zeilen: TStrings);
function StammBezeichnung(const Kuerzel: string; Id: Int64): string;

implementation

uses
  udatenbank, unachschlage;

function DatenbankBereit: Boolean;
begin
  Result := (PlanlosDB <> nil) and PlanlosDB.Verbunden;
end;

function Stammliste(const Kuerzel: string): Boolean;
begin
  Result := (Kuerzel = 'artikel') or (Kuerzel = 'artikelgruppe') or
    (Kuerzel = 'berechnungsart') or (Kuerzel = 'projekt') or
    (Kuerzel = 'textbaustein') or (Kuerzel = 'modulart') or
    (Kuerzel = 'benutzer') or NachschlageArt(Kuerzel);
end;

function VerkaufspreisCent(EkCent: Int64; AufschlagBp: Integer): Int64;
var
  Produkt: Int64;
begin
  Produkt := EkCent * (10000 + AufschlagBp);
  if Produkt >= 0 then
    Result := (Produkt + 5000) div 10000
  else
    Result := (Produkt - 5000) div 10000;
end;

function BruttoCent(NettoCent: Int64; MwstSatz: Integer): Int64;
var
  Produkt: Int64;
begin
  Produkt := NettoCent * (100 + MwstSatz);
  if Produkt >= 0 then
    Result := (Produkt + 50) div 100
  else
    Result := (Produkt - 50) div 100;
end;

function ZahlLesen(const Text: string; Stellen: Integer; out Wert: Int64): Boolean;
var
  S: string;
  Komma, i, Nach: Integer;
  Negativ: Boolean;
  Ganz: Int64;
begin
  Result := False;
  Wert := 0;
  S := Trim(Text);
  if S = '' then
  begin
    Result := True;
    Exit;
  end;
  S := StringReplace(S, ' ', '', [rfReplaceAll]);
  Negativ := False;
  if S[1] = '-' then
  begin
    Negativ := True;
    Delete(S, 1, 1);
  end;
  S := StringReplace(S, '.', '', [rfReplaceAll]);
  Komma := Pos(',', S);
  if Komma = 0 then
  begin
    Ganz := StrToInt64Def(S, -1);
    if (S <> '0') and (Ganz < 0) then
      Exit;
    Wert := Ganz;
    for i := 1 to Stellen do
      Wert := Wert * 10;
  end
  else
  begin
    Ganz := StrToInt64Def(Copy(S, 1, Komma - 1), 0);
    if (Komma > 1) and (Copy(S, 1, Komma - 1) <> '0') and
       (StrToInt64Def(Copy(S, 1, Komma - 1), -1) < 0) then
      Exit;
    Nach := 0;
    for i := 1 to Stellen do
    begin
      Nach := Nach * 10;
      if Komma + i <= Length(S) then
      begin
        if not (S[Komma + i] in ['0'..'9']) then
          Exit;
        Nach := Nach + Ord(S[Komma + i]) - Ord('0');
      end;
    end;
    if Komma + Stellen < Length(S) then
      Exit;
    Wert := Ganz;
    for i := 1 to Stellen do
      Wert := Wert * 10;
    Wert := Wert + Nach;
  end;
  if Negativ then
    Wert := -Wert;
  Result := True;
end;

function CentAusText(const Text: string; out Cent: Int64): Boolean;
begin
  Result := ZahlLesen(Text, 2, Cent);
end;

function MilliAusText(const Text: string; out Milli: Int64): Boolean;
begin
  Result := ZahlLesen(Text, 3, Milli);
end;

function AufschlagAusText(const Text: string; out Bp: Integer): Boolean;
var
  Wert: Int64;
begin
  Result := ZahlLesen(Text, 2, Wert);
  Bp := Integer(Wert);
end;

function TextMitStellen(Wert: Int64; Stellen: Integer): string;
var
  Negativ: Boolean;
  Ganz, Rest, Teiler, i: Int64;
  Nach: string;
begin
  Negativ := Wert < 0;
  if Negativ then
    Wert := -Wert;
  Teiler := 1;
  for i := 1 to Stellen do
    Teiler := Teiler * 10;
  Ganz := Wert div Teiler;
  Rest := Wert mod Teiler;
  Nach := IntToStr(Rest);
  while Length(Nach) < Stellen do
    Nach := '0' + Nach;
  Result := IntToStr(Ganz) + ',' + Nach;
  if Negativ then
    Result := '-' + Result;
end;

function TextAusCent(Cent: Int64): string;
begin
  Result := TextMitStellen(Cent, 2);
end;

function TextAusMilli(Milli: Int64): string;
begin
  Result := TextMitStellen(Milli, 3);
end;

function TextAusAufschlag(Bp: Integer): string;
begin
  Result := TextMitStellen(Bp, 2);
end;

function Wahr(const Wert: string): Boolean;
begin
  Result := Wert = '1';
end;

procedure GruppeAusZeile(const Zeile: TStrings; out Gruppe: TArtikelGruppe);
begin
  Gruppe := Default(TArtikelGruppe);
  Gruppe.Id := StrToInt64Def(Zeile.Values['id'], 0);
  Gruppe.Bezeichnung := Zeile.Values['bezeichnung'];
  Gruppe.Berechnungsart := Zeile.Values['berechnungsart'];
  Gruppe.AufschlagBp := StrToIntDef(Zeile.Values['aufschlag_bp'], 0);
  Gruppe.Kostenart := Zeile.Values['kostenart'];
  Gruppe.SichtbarGewicht := Wahr(Zeile.Values['sichtbar_gewicht']);
  Gruppe.SichtbarZahl1 := Wahr(Zeile.Values['sichtbar_zahl1']);
  Gruppe.SichtbarZahl2 := Wahr(Zeile.Values['sichtbar_zahl2']);
  Gruppe.SichtbarZahl3 := Wahr(Zeile.Values['sichtbar_zahl3']);
  Gruppe.SichtbarPostext := Wahr(Zeile.Values['sichtbar_postext']);
  Gruppe.SichtbarName1 := Wahr(Zeile.Values['sichtbar_name1']);
  Gruppe.SichtbarName2 := Wahr(Zeile.Values['sichtbar_name2']);
  Gruppe.SichtbarName3 := Wahr(Zeile.Values['sichtbar_name3']);
  Gruppe.SichtbarLieferant := Wahr(Zeile.Values['sichtbar_lieferant']);
  Gruppe.SichtbarBestand := Wahr(Zeile.Values['sichtbar_bestand']);
  Gruppe.SichtbarMinBestand := Wahr(Zeile.Values['sichtbar_min_bestand']);
  Gruppe.SichtbarLieferantNr := Wahr(Zeile.Values['sichtbar_lieferant_nr']);
  Gruppe.EinheitMengeWieEk := Wahr(Zeile.Values['einheit_menge_wie_ek']);
  Gruppe.VorgabeArtikel := Zeile.Values['vorgabe_artikel'];
  Gruppe.VorgabeEkCent := StrToInt64Def(Zeile.Values['vorgabe_ek_cent'], 0);
  Gruppe.VorgabeAufschlagBp := StrToIntDef(Zeile.Values['vorgabe_aufschlag_bp'], 0);
  Gruppe.VorgabeEinheitMenge := Zeile.Values['vorgabe_einheit_menge'];
  Gruppe.VorgabeEinheitEk := Zeile.Values['vorgabe_einheit_ek'];
  Gruppe.VorgabeLieferant := Zeile.Values['vorgabe_lieferant'];
end;

function GruppeLesen(const Where: string; Parameter: TStrings;
  out Gruppe: TArtikelGruppe): Boolean;
var
  Zeile: TStringList;
begin
  Result := False;
  Gruppe := Default(TArtikelGruppe);
  if not DatenbankBereit then
    Exit;
  Zeile := TStringList.Create;
  try
    PlanlosDB.ErsteZeile(
      'SELECT id, bezeichnung, berechnungsart, aufschlag_bp, kostenart, ' +
      'sichtbar_gewicht, sichtbar_zahl1, sichtbar_zahl2, sichtbar_zahl3, ' +
      'sichtbar_postext, sichtbar_name1, sichtbar_name2, sichtbar_name3, ' +
      'sichtbar_lieferant, sichtbar_bestand, sichtbar_min_bestand, ' +
      'sichtbar_lieferant_nr, einheit_menge_wie_ek, vorgabe_artikel, ' +
      'vorgabe_ek_cent, vorgabe_aufschlag_bp, vorgabe_einheit_menge, ' +
      'vorgabe_einheit_ek, vorgabe_lieferant FROM artikelgruppe WHERE ' + Where,
      Parameter, Zeile);
    if Zeile.Count = 0 then
      Exit;
    GruppeAusZeile(Zeile, Gruppe);
    Result := True;
  finally
    Zeile.Free;
  end;
end;

function GruppeLaden(Id: Int64; out Gruppe: TArtikelGruppe): Boolean;
var
  Parameter: TStringList;
begin
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    Result := GruppeLesen('id = :id', Parameter, Gruppe);
  finally
    Parameter.Free;
  end;
end;

function GruppeNachName(const Name: string; out Gruppe: TArtikelGruppe): Boolean;
var
  Parameter: TStringList;
begin
  Parameter := TStringList.Create;
  try
    Parameter.Values['name'] := Trim(Name);
    Result := GruppeLesen('bezeichnung = :name', Parameter, Gruppe);
  finally
    Parameter.Free;
  end;
end;

function GruppeSpeichern(var Gruppe: TArtikelGruppe; out Fehler: string): Int64;
var
  Parameter: TStringList;

  procedure Flag(const Name: string; An: Boolean);
  begin
    if An then
      Parameter.Values[Name] := '1'
    else
      Parameter.Values[Name] := '0';
  end;

begin
  Result := 0;
  Fehler := '';
  if Trim(Gruppe.Bezeichnung) = '' then
  begin
    Fehler := 'Die Artikelgruppe braucht einen Namen.';
    Exit;
  end;
  if not DatenbankBereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  if Gruppe.Kostenart = '' then
    Gruppe.Kostenart := 'M';
  Parameter := TStringList.Create;
  try
    Parameter.Values['name'] := Trim(Gruppe.Bezeichnung);
    Parameter.Values['art'] := Gruppe.Berechnungsart;
    Parameter.Values['aufschlag'] := IntToStr(Gruppe.AufschlagBp);
    Parameter.Values['kosten'] := Gruppe.Kostenart;
    Flag('sg', Gruppe.SichtbarGewicht);
    Flag('sz1', Gruppe.SichtbarZahl1);
    Flag('sz2', Gruppe.SichtbarZahl2);
    Flag('sz3', Gruppe.SichtbarZahl3);
    Flag('sp', Gruppe.SichtbarPostext);
    Flag('sn1', Gruppe.SichtbarName1);
    Flag('sn2', Gruppe.SichtbarName2);
    Flag('sn3', Gruppe.SichtbarName3);
    Flag('sl', Gruppe.SichtbarLieferant);
    Flag('sb', Gruppe.SichtbarBestand);
    Flag('sm', Gruppe.SichtbarMinBestand);
    Flag('snr', Gruppe.SichtbarLieferantNr);
    Flag('wie', Gruppe.EinheitMengeWieEk);
    Parameter.Values['vartikel'] := Gruppe.VorgabeArtikel;
    Parameter.Values['vek'] := IntToStr(Gruppe.VorgabeEkCent);
    Parameter.Values['vauf'] := IntToStr(Gruppe.VorgabeAufschlagBp);
    Parameter.Values['vem'] := Gruppe.VorgabeEinheitMenge;
    Parameter.Values['veek'] := Gruppe.VorgabeEinheitEk;
    Parameter.Values['vlief'] := Gruppe.VorgabeLieferant;
    if Gruppe.Id = 0 then
    begin
      PlanlosDB.Ausfuehren(
        'INSERT INTO artikelgruppe (bezeichnung, berechnungsart, aufschlag_bp, ' +
        'kostenart, sichtbar_gewicht, sichtbar_zahl1, sichtbar_zahl2, sichtbar_zahl3, ' +
        'sichtbar_postext, sichtbar_name1, sichtbar_name2, sichtbar_name3, ' +
        'sichtbar_lieferant, sichtbar_bestand, sichtbar_min_bestand, ' +
        'sichtbar_lieferant_nr, einheit_menge_wie_ek, vorgabe_artikel, ' +
        'vorgabe_ek_cent, vorgabe_aufschlag_bp, vorgabe_einheit_menge, ' +
        'vorgabe_einheit_ek, vorgabe_lieferant) VALUES (' +
        ':name, :art, :aufschlag, :kosten, :sg, :sz1, :sz2, :sz3, :sp, :sn1, ' +
        ':sn2, :sn3, :sl, :sb, :sm, :snr, :wie, :vartikel, :vek, :vauf, :vem, ' +
        ':veek, :vlief)', Parameter);
      Result := StrToInt64Def(Trim(PlanlosDB.Skalar('SELECT last_insert_rowid()')), 0);
    end
    else
    begin
      Parameter.Values['id'] := IntToStr(Gruppe.Id);
      if PlanlosDB.Ausfuehren(
        'UPDATE artikelgruppe SET bezeichnung = :name, berechnungsart = :art, ' +
        'aufschlag_bp = :aufschlag, kostenart = :kosten, sichtbar_gewicht = :sg, ' +
        'sichtbar_zahl1 = :sz1, sichtbar_zahl2 = :sz2, sichtbar_zahl3 = :sz3, ' +
        'sichtbar_postext = :sp, sichtbar_name1 = :sn1, sichtbar_name2 = :sn2, ' +
        'sichtbar_name3 = :sn3, sichtbar_lieferant = :sl, sichtbar_bestand = :sb, ' +
        'sichtbar_min_bestand = :sm, sichtbar_lieferant_nr = :snr, ' +
        'einheit_menge_wie_ek = :wie, vorgabe_artikel = :vartikel, ' +
        'vorgabe_ek_cent = :vek, vorgabe_aufschlag_bp = :vauf, ' +
        'vorgabe_einheit_menge = :vem, vorgabe_einheit_ek = :veek, ' +
        'vorgabe_lieferant = :vlief WHERE id = :id', Parameter) < 1 then
      begin
        Fehler := 'Die Artikelgruppe wurde nicht gefunden.';
        Exit;
      end;
      Result := Gruppe.Id;
    end;
    if Result = 0 then
      Fehler := 'Die Artikelgruppe wurde nicht gespeichert.'
    else
      Gruppe.Id := Result;
  finally
    Parameter.Free;
  end;
end;

function GruppeLoeschen(Id: Int64; out Fehler: string): Boolean;
var
  Parameter: TStringList;
begin
  Fehler := '';
  Result := False;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    if StrToIntDef(PlanlosDB.SkalarMit(
      'SELECT COUNT(*) FROM artikel WHERE gruppe_id = :id', Parameter), 0) > 0 then
    begin
      Fehler := 'In dieser Gruppe liegen noch Artikel.';
      Exit;
    end;
    Result := PlanlosDB.Ausfuehren(
      'DELETE FROM artikelgruppe WHERE id = :id', Parameter) > 0;
    if not Result then
      Fehler := 'Die Artikelgruppe konnte nicht gelöscht werden.';
  finally
    Parameter.Free;
  end;
end;

function GruppeKopieren(Id: Int64; out Fehler: string): Int64;
var
  Gruppe: TArtikelGruppe;
begin
  Result := 0;
  if not GruppeLaden(Id, Gruppe) then
  begin
    Fehler := 'Die Artikelgruppe wurde nicht gefunden.';
    Exit;
  end;
  Gruppe.Id := 0;
  Gruppe.Bezeichnung := Gruppe.Bezeichnung + ' Kopie';
  Result := GruppeSpeichern(Gruppe, Fehler);
end;

function ArtikelLaden(Id: Int64; out Artikel: TArtikel): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  Artikel := Default(TArtikel);
  Artikel.MwstSatz := 19;
  if not DatenbankBereit then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT a.id, a.gruppe_id, g.bezeichnung AS gruppe, a.bezeichnung, a.ek_cent, ' +
      'a.einheit_ek, a.aufschlag_bp, a.mwst_satz, a.gewicht_milli, a.zahl1_milli, ' +
      'a.zahl2_milli, a.zahl3_milli, a.name1, a.name2, a.name3, a.lieferant, ' +
      'a.lieferant_nr, a.pos_text, a.einheit_menge, a.berechnungsart, a.kostenart, ' +
      'a.bestand_milli, a.min_bestand_milli FROM artikel a ' +
      'LEFT JOIN artikelgruppe g ON g.id = a.gruppe_id WHERE a.id = :id',
      Parameter, Zeile);
    if Zeile.Count = 0 then
      Exit;
    Artikel.Id := StrToInt64Def(Zeile.Values['id'], 0);
    Artikel.GruppeId := StrToInt64Def(Zeile.Values['gruppe_id'], 0);
    Artikel.Gruppe := Zeile.Values['gruppe'];
    Artikel.Bezeichnung := Zeile.Values['bezeichnung'];
    Artikel.EkCent := StrToInt64Def(Zeile.Values['ek_cent'], 0);
    Artikel.EinheitEk := Zeile.Values['einheit_ek'];
    Artikel.AufschlagBp := StrToIntDef(Zeile.Values['aufschlag_bp'], 0);
    Artikel.MwstSatz := StrToIntDef(Zeile.Values['mwst_satz'], 19);
    Artikel.GewichtMilli := StrToInt64Def(Zeile.Values['gewicht_milli'], 0);
    Artikel.Zahl1Milli := StrToInt64Def(Zeile.Values['zahl1_milli'], 0);
    Artikel.Zahl2Milli := StrToInt64Def(Zeile.Values['zahl2_milli'], 0);
    Artikel.Zahl3Milli := StrToInt64Def(Zeile.Values['zahl3_milli'], 0);
    Artikel.Name1 := Zeile.Values['name1'];
    Artikel.Name2 := Zeile.Values['name2'];
    Artikel.Name3 := Zeile.Values['name3'];
    Artikel.Lieferant := Zeile.Values['lieferant'];
    Artikel.LieferantNr := Zeile.Values['lieferant_nr'];
    Artikel.PosText := Zeile.Values['pos_text'];
    Artikel.EinheitMenge := Zeile.Values['einheit_menge'];
    Artikel.Berechnungsart := Zeile.Values['berechnungsart'];
    Artikel.Kostenart := Zeile.Values['kostenart'];
    Artikel.BestandMilli := StrToInt64Def(Zeile.Values['bestand_milli'], 0);
    Artikel.MinBestandMilli := StrToInt64Def(Zeile.Values['min_bestand_milli'], 0);
    Result := True;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function ArtikelSpeichern(var Artikel: TArtikel; out Fehler: string): Int64;
var
  Parameter: TStringList;
begin
  Result := 0;
  Fehler := '';
  if Trim(Artikel.Bezeichnung) = '' then
  begin
    Fehler := 'Der Artikel braucht einen Namen.';
    Exit;
  end;
  if not DatenbankBereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  Parameter := TStringList.Create;
  try
    if Artikel.GruppeId = 0 then
      Parameter.Values['gruppe'] := ''
    else
      Parameter.Values['gruppe'] := IntToStr(Artikel.GruppeId);
    Parameter.Values['name'] := Trim(Artikel.Bezeichnung);
    Parameter.Values['ek'] := IntToStr(Artikel.EkCent);
    Parameter.Values['eek'] := Artikel.EinheitEk;
    Parameter.Values['auf'] := IntToStr(Artikel.AufschlagBp);
    Parameter.Values['mwst'] := IntToStr(Artikel.MwstSatz);
    Parameter.Values['gew'] := IntToStr(Artikel.GewichtMilli);
    Parameter.Values['z1'] := IntToStr(Artikel.Zahl1Milli);
    Parameter.Values['z2'] := IntToStr(Artikel.Zahl2Milli);
    Parameter.Values['z3'] := IntToStr(Artikel.Zahl3Milli);
    Parameter.Values['n1'] := Artikel.Name1;
    Parameter.Values['n2'] := Artikel.Name2;
    Parameter.Values['n3'] := Artikel.Name3;
    Parameter.Values['lief'] := Artikel.Lieferant;
    Parameter.Values['lnr'] := Artikel.LieferantNr;
    Parameter.Values['pos'] := Artikel.PosText;
    Parameter.Values['em'] := Artikel.EinheitMenge;
    Parameter.Values['bart'] := Artikel.Berechnungsart;
    Parameter.Values['kosten'] := Artikel.Kostenart;
    Parameter.Values['best'] := IntToStr(Artikel.BestandMilli);
    Parameter.Values['minb'] := IntToStr(Artikel.MinBestandMilli);
    if Artikel.Id = 0 then
    begin
      PlanlosDB.Ausfuehren(
        'INSERT INTO artikel (gruppe_id, bezeichnung, ek_cent, einheit_ek, ' +
        'aufschlag_bp, mwst_satz, gewicht_milli, zahl1_milli, zahl2_milli, ' +
        'zahl3_milli, name1, name2, name3, lieferant, lieferant_nr, pos_text, ' +
        'einheit_menge, berechnungsart, kostenart, bestand_milli, min_bestand_milli) ' +
        'VALUES (NULLIF(:gruppe, ''''), :name, :ek, :eek, :auf, :mwst, :gew, :z1, ' +
        ':z2, :z3, :n1, :n2, :n3, :lief, :lnr, :pos, :em, :bart, :kosten, :best, :minb)',
        Parameter);
      Result := StrToInt64Def(Trim(PlanlosDB.Skalar('SELECT last_insert_rowid()')), 0);
    end
    else
    begin
      Parameter.Values['id'] := IntToStr(Artikel.Id);
      if PlanlosDB.Ausfuehren(
        'UPDATE artikel SET gruppe_id = NULLIF(:gruppe, ''''), bezeichnung = :name, ' +
        'ek_cent = :ek, einheit_ek = :eek, aufschlag_bp = :auf, mwst_satz = :mwst, ' +
        'gewicht_milli = :gew, zahl1_milli = :z1, zahl2_milli = :z2, zahl3_milli = :z3, ' +
        'name1 = :n1, name2 = :n2, name3 = :n3, lieferant = :lief, lieferant_nr = :lnr, ' +
        'pos_text = :pos, einheit_menge = :em, berechnungsart = :bart, ' +
        'kostenart = :kosten, bestand_milli = :best, min_bestand_milli = :minb ' +
        'WHERE id = :id', Parameter) < 1 then
      begin
        Fehler := 'Der Artikel wurde nicht gefunden.';
        Exit;
      end;
      Result := Artikel.Id;
    end;
    if Result = 0 then
      Fehler := 'Der Artikel wurde nicht gespeichert.'
    else
      Artikel.Id := Result;
  finally
    Parameter.Free;
  end;
end;

function ArtikelLoeschen(Id: Int64; out Fehler: string): Boolean;
var
  Parameter: TStringList;
begin
  Fehler := '';
  Result := False;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    Result := PlanlosDB.Ausfuehren('DELETE FROM artikel WHERE id = :id', Parameter) > 0;
    if not Result then
      Fehler := 'Der Artikel konnte nicht gelöscht werden.';
  finally
    Parameter.Free;
  end;
end;

function ArtikelKopieren(Id: Int64; out Fehler: string): Int64;
var
  Artikel: TArtikel;
begin
  Result := 0;
  if not ArtikelLaden(Id, Artikel) then
  begin
    Fehler := 'Der Artikel wurde nicht gefunden.';
    Exit;
  end;
  Artikel.Id := 0;
  Artikel.Bezeichnung := Artikel.Bezeichnung + ' Kopie';
  Result := ArtikelSpeichern(Artikel, Fehler);
end;

procedure StammLesen(const Kuerzel, Suchtext: string; Spalten, Zeilen: TStrings);
var
  Parameter, Teile: TStringList;
  SQL, Muster: string;
  i, n: Integer;
begin
  Spalten.Clear;
  Zeilen.Clear;
  if NachschlageArt(Kuerzel) then
  begin
    NachschlageLesen(Kuerzel, Suchtext, Spalten, Zeilen);
    Exit;
  end;
  if not DatenbankBereit then
    Exit;
  Muster := '%' + Trim(StringReplace(StringReplace(Suchtext, '%', '',
    [rfReplaceAll]), '_', '', [rfReplaceAll])) + '%';
  Parameter := TStringList.Create;
  try
    Parameter.Values['muster'] := Muster;
    if Trim(Suchtext) = '' then
      Parameter.Values['leer'] := '1'
    else
      Parameter.Values['leer'] := '0';
    if Kuerzel = 'artikel' then
    begin
      Spalten.Add('id');
      Spalten.Add('Artikelgruppe');
      Spalten.Add('Artikel');
      Spalten.Add('EK');
      SQL :=
        'SELECT a.id, COALESCE(g.bezeichnung, ''''), a.bezeichnung, a.ek_cent ' +
        'FROM artikel a LEFT JOIN artikelgruppe g ON g.id = a.gruppe_id ' +
        'WHERE :leer = ''1'' OR a.bezeichnung LIKE :muster OR g.bezeichnung LIKE :muster ' +
        'ORDER BY g.bezeichnung, a.bezeichnung, a.id';
    end
    else if Kuerzel = 'artikelgruppe' then
    begin
      Spalten.Add('id');
      Spalten.Add('Artikelgruppe');
      Spalten.Add('Kostenart');
      Spalten.Add('Aufschlag');
      SQL :=
        'SELECT id, bezeichnung, kostenart, aufschlag_bp FROM artikelgruppe ' +
        'WHERE :leer = ''1'' OR bezeichnung LIKE :muster ORDER BY bezeichnung, id';
    end
    else
    begin
      Spalten.Add('id');
      Spalten.Add('Berechnungsart');
      SQL :=
        'SELECT id, bezeichnung FROM berechnungsart ' +
        'WHERE :leer = ''1'' OR bezeichnung LIKE :muster ORDER BY bezeichnung, id';
    end;
    PlanlosDB.AlleZeilen(SQL, Parameter, Spalten, Zeilen);
  finally
    Parameter.Free;
  end;
  if (Kuerzel = 'artikel') or (Kuerzel = 'artikelgruppe') then
    for i := 0 to Zeilen.Count - 1 do
    begin
      Teile := TStringList.Create;
      try
        Teile.StrictDelimiter := True;
        Teile.Delimiter := #9;
        Teile.DelimitedText := Zeilen[i];
        if Teile.Count >= 4 then
        begin
          if Kuerzel = 'artikel' then
            Teile[3] := TextAusCent(StrToInt64Def(Teile[3], 0))
          else
            Teile[3] := TextAusAufschlag(StrToIntDef(Teile[3], 0));
          Zeilen[i] := Teile[0];
          for n := 1 to Teile.Count - 1 do
            Zeilen[i] := Zeilen[i] + #9 + Teile[n];
        end;
      finally
        Teile.Free;
      end;
    end;
  if Kuerzel = 'artikel' then
  begin
    Spalten.Clear;
    Spalten.Add('id');
    Spalten.Add('Artikelgruppe');
    Spalten.Add('Artikel');
    Spalten.Add('EK');
  end
  else if Kuerzel = 'artikelgruppe' then
  begin
    Spalten.Clear;
    Spalten.Add('id');
    Spalten.Add('Artikelgruppe');
    Spalten.Add('Kostenart');
    Spalten.Add('Aufschlag');
  end;
end;

function StammBezeichnung(const Kuerzel: string; Id: Int64): string;
var
  Parameter: TStringList;
  SQL: string;
begin
  Result := '';
  if not DatenbankBereit then
    Exit;
  if NachschlageArt(Kuerzel) then
  begin
    Result := NachschlageName(Id);
    Exit;
  end;
  if Kuerzel = 'artikelgruppe' then
    SQL := 'SELECT bezeichnung FROM artikelgruppe WHERE id = :id'
  else if Kuerzel = 'berechnungsart' then
    SQL := 'SELECT bezeichnung FROM berechnungsart WHERE id = :id'
  else if Kuerzel = 'lieferant' then
    SQL := 'SELECT COALESCE(NULLIF(firma, ''''), nachname) FROM adresse WHERE id = :id'
  else
    SQL := 'SELECT bezeichnung FROM artikel WHERE id = :id';
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    Result := PlanlosDB.SkalarMit(SQL, Parameter);
  finally
    Parameter.Free;
  end;
end;

end.
