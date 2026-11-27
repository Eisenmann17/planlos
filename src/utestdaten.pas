unit utestdaten;

{ Liest daten/testdaten.txt und legt die Beispielsätze an.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

function TestdatenVorhanden: Boolean;
function TestdatenEinfuegen(out Meldung: string): Boolean;
function TestdatenMaskenPruefen(out Fehler: string): Boolean;

implementation

uses
  Classes, SysUtils, udatenbank, umaske, uartikel, unachschlage, uprojekt,
  utextbaustein, ubeleg, ustueckliste;

type
  TSatz = record
    Art: string;
    Werte: TStringList;
    Positionen: TStringList;
  end;

function TestdatenVorhanden: Boolean;
begin
  Result := (PlanlosDB <> nil) and PlanlosDB.Verbunden and
    (PlanlosDB.ParameterLesen('testdaten', '') = '1');
end;

function TestdatenPfad: string;
var
  Neben, Darueber, Hier: string;
begin
  Neben := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
    'daten' + DirectorySeparator + 'testdaten.txt';
  Darueber := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
    '..' + DirectorySeparator + 'daten' + DirectorySeparator + 'testdaten.txt';
  Hier := 'daten' + DirectorySeparator + 'testdaten.txt';
  if FileExists(Neben) then
    Result := Neben
  else if FileExists(Darueber) then
    Result := Darueber
  else
    Result := Hier;
end;

function Feld(const Werte: TStrings; const Schluessel: string): string;
begin
  if Werte.IndexOfName(Schluessel) < 0 then
    Result := ''
  else
    Result := Trim(Werte.Values[Schluessel]);
end;

function Ganz(const Werte: TStrings; const Schluessel: string): Int64;
begin
  if Feld(Werte, Schluessel) = '' then
    Result := 0
  else if not TryStrToInt64(Feld(Werte, Schluessel), Result) then
    Result := 0;
end;

function CentFeld(const Text: string; out Cent: Int64): Boolean;
begin
  if Trim(Text) = '' then
  begin
    Cent := 0;
    Result := True;
  end
  else
    Result := CentAusText(Text, Cent);
end;

function MilliFeld(const Text: string; out Milli: Int64): Boolean;
begin
  if Trim(Text) = '' then
  begin
    Milli := 0;
    Result := True;
  end
  else
    Result := MilliAusText(Text, Milli);
end;

function IdNach(const SQL, Name: string): Int64;
var
  Parameter: TStringList;
begin
  Parameter := TStringList.Create;
  try
    Parameter.Values['name'] := Name;
    if Pos(':name2', SQL) > 0 then
      Parameter.Values['name2'] := Name;
    Result := StrToInt64Def(PlanlosDB.SkalarMit(SQL, Parameter), 0);
  finally
    Parameter.Free;
  end;
end;

function AdresseFinden(const Name: string): Int64;
begin
  Result := IdNach(
    'SELECT id FROM adresse WHERE firma = :name OR nachname = :name2 ' +
    'ORDER BY id LIMIT 1', Name);
end;

function GruppeFinden(const Name: string): Int64;
begin
  Result := IdNach(
    'SELECT id FROM artikelgruppe WHERE bezeichnung = :name', Name);
end;

function ArtikelFinden(const Name: string): Int64;
begin
  Result := IdNach(
    'SELECT id FROM artikel WHERE bezeichnung = :name', Name);
end;

function ProjektFinden(const Name: string): Int64;
begin
  Result := IdNach(
    'SELECT id FROM projekt WHERE bezeichnung = :name', Name);
end;

function BausteinFinden(const Name: string): Int64;
begin
  Result := IdNach(
    'SELECT id FROM textbaustein WHERE beschreibung = :name', Name);
end;

function Adressblock(Id: Int64): string;
var
  Parameter, Zeile: TStringList;
  Name: string;
begin
  Result := '';
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT firma, vorname, nachname, strasse, plz, ort FROM adresse WHERE id = :id',
      Parameter, Zeile);
    if Zeile.Values['firma'] <> '' then
      Result := Zeile.Values['firma'];
    Name := Trim(Zeile.Values['vorname'] + ' ' + Zeile.Values['nachname']);
    if (Name <> '') and (Name <> Zeile.Values['firma']) then
    begin
      if Result <> '' then
        Result := Result + LineEnding;
      Result := Result + Name;
    end;
    if Zeile.Values['strasse'] <> '' then
    begin
      if Result <> '' then
        Result := Result + LineEnding;
      Result := Result + Zeile.Values['strasse'];
    end;
    if (Zeile.Values['plz'] <> '') or (Zeile.Values['ort'] <> '') then
    begin
      if Result <> '' then
        Result := Result + LineEnding;
      Result := Result + Trim(Zeile.Values['plz'] + ' ' + Zeile.Values['ort']);
    end;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

procedure ZahlenAufNull;
begin
  PlanlosDB.Ausfuehren(
    'UPDATE adresse SET rabatt_prozent = 0 WHERE rabatt_prozent IS NULL', nil);
  PlanlosDB.Ausfuehren(
    'UPDATE artikelgruppe SET aufschlag_bp = COALESCE(aufschlag_bp, 0), ' +
    'sichtbar_gewicht = COALESCE(sichtbar_gewicht, 0), ' +
    'sichtbar_zahl1 = COALESCE(sichtbar_zahl1, 0), ' +
    'sichtbar_zahl2 = COALESCE(sichtbar_zahl2, 0), ' +
    'sichtbar_zahl3 = COALESCE(sichtbar_zahl3, 0), ' +
    'sichtbar_postext = COALESCE(sichtbar_postext, 0), ' +
    'sichtbar_name1 = COALESCE(sichtbar_name1, 0), ' +
    'sichtbar_name2 = COALESCE(sichtbar_name2, 0), ' +
    'sichtbar_name3 = COALESCE(sichtbar_name3, 0), ' +
    'sichtbar_lieferant = COALESCE(sichtbar_lieferant, 0), ' +
    'sichtbar_bestand = COALESCE(sichtbar_bestand, 0), ' +
    'sichtbar_min_bestand = COALESCE(sichtbar_min_bestand, 0), ' +
    'sichtbar_lieferant_nr = COALESCE(sichtbar_lieferant_nr, 0), ' +
    'einheit_menge_wie_ek = COALESCE(einheit_menge_wie_ek, 0), ' +
    'vorgabe_ek_cent = COALESCE(vorgabe_ek_cent, 0), ' +
    'vorgabe_aufschlag_bp = COALESCE(vorgabe_aufschlag_bp, 0)', nil);
  PlanlosDB.Ausfuehren(
    'UPDATE artikel SET ek_cent = COALESCE(ek_cent, 0), ' +
    'aufschlag_bp = COALESCE(aufschlag_bp, 0), mwst_satz = COALESCE(mwst_satz, 0), ' +
    'gewicht_milli = COALESCE(gewicht_milli, 0), ' +
    'zahl1_milli = COALESCE(zahl1_milli, 0), zahl2_milli = COALESCE(zahl2_milli, 0), ' +
    'zahl3_milli = COALESCE(zahl3_milli, 0), ' +
    'bestand_milli = COALESCE(bestand_milli, 0), ' +
    'min_bestand_milli = COALESCE(min_bestand_milli, 0)', nil);
  PlanlosDB.Ausfuehren(
    'UPDATE beleg SET mwst_rechnen = COALESCE(mwst_rechnen, 0)', nil);
  PlanlosDB.Ausfuehren(
    'UPDATE belegposition SET menge_milli = COALESCE(menge_milli, 0), ' +
    'einzelpreis_cent = COALESCE(einzelpreis_cent, 0), ' +
    'mwst_satz = COALESCE(mwst_satz, 0), ek_cent = COALESCE(ek_cent, 0), ' +
    'aufschlag_bp = COALESCE(aufschlag_bp, 0), rabatt_bp = COALESCE(rabatt_bp, 0)', nil);
  PlanlosDB.Ausfuehren(
    'UPDATE nachschlage SET nur_lesen = COALESCE(nur_lesen, 0)', nil);
end;

function ZahlenDicht: Boolean;
begin
  Result := PlanlosDB.Ganzzahl(
    'SELECT (' +
    '(SELECT COUNT(*) FROM artikel WHERE ek_cent IS NULL OR aufschlag_bp IS NULL ' +
    'OR mwst_satz IS NULL OR gewicht_milli IS NULL OR zahl1_milli IS NULL ' +
    'OR zahl2_milli IS NULL OR zahl3_milli IS NULL OR bestand_milli IS NULL ' +
    'OR min_bestand_milli IS NULL) + ' +
    '(SELECT COUNT(*) FROM artikelgruppe WHERE aufschlag_bp IS NULL ' +
    'OR vorgabe_ek_cent IS NULL OR vorgabe_aufschlag_bp IS NULL) + ' +
    '(SELECT COUNT(*) FROM adresse WHERE rabatt_prozent IS NULL) + ' +
    '(SELECT COUNT(*) FROM belegposition WHERE menge_milli IS NULL ' +
    'OR einzelpreis_cent IS NULL OR mwst_satz IS NULL OR ek_cent IS NULL ' +
    'OR aufschlag_bp IS NULL OR rabatt_bp IS NULL)' +
    ')') = 0;
end;

function SatzLesen(const Datei: string; out Saetze: array of TSatz;
  out Anzahl: Integer; out Fehler: string): Boolean;
var
  Zeilen: TStringList;
  i: Integer;
  Zeile, Art: string;

  procedure Neu(const NeueArt: string);
  begin
    if Anzahl > High(Saetze) then
    begin
      Fehler := 'Die Testdatei hat zu viele Sätze.';
      Exit;
    end;
    Saetze[Anzahl].Art := NeueArt;
    Saetze[Anzahl].Werte := TStringList.Create;
    Saetze[Anzahl].Positionen := TStringList.Create;
    Inc(Anzahl);
  end;

begin
  Result := False;
  Fehler := '';
  Anzahl := 0;
  Art := '';
  if not FileExists(Datei) then
  begin
    Fehler := 'Die Testdatei fehlt: ' + Datei;
    Exit;
  end;
  Zeilen := TStringList.Create;
  try
    Zeilen.LoadFromFile(Datei);
    for i := 0 to Zeilen.Count - 1 do
    begin
      Zeile := Trim(Zeilen[i]);
      if (Zeile = '') or (Zeile[1] = '#') then
        Continue;
      if (Zeile[1] = '[') and (Zeile[Length(Zeile)] = ']') then
      begin
        Art := Copy(Zeile, 2, Length(Zeile) - 2);
        Neu(Art);
        if Fehler <> '' then
          Exit;
        Continue;
      end;
      if Zeile = '---' then
      begin
        Neu(Art);
        if Fehler <> '' then
          Exit;
        Continue;
      end;
      if Anzahl = 0 then
      begin
        Fehler := 'Vor dem ersten Abschnitt steht eine Zeile: ' + Zeile;
        Exit;
      end;
      if Copy(Zeile, 1, 9) = 'position=' then
        Saetze[Anzahl - 1].Positionen.Add(Copy(Zeile, 10, MaxInt))
      else if Copy(Zeile, 1, 6) = 'zeile=' then
        Saetze[Anzahl - 1].Positionen.Add(Copy(Zeile, 7, MaxInt))
      else if Pos('=', Zeile) > 0 then
        Saetze[Anzahl - 1].Werte.Add(Zeile)
      else
      begin
        Fehler := 'Die Zeile ist kein Schlüssel: ' + Zeile;
        Exit;
      end;
    end;
    Result := True;
  finally
    Zeilen.Free;
    if not Result then
      for i := 0 to Anzahl - 1 do
      begin
        Saetze[i].Werte.Free;
        Saetze[i].Positionen.Free;
      end;
  end;
end;

function NachschlageAn(const Art, Name: string; out Fehler: string): Boolean;
begin
  Result := NachschlageSpeichern(Art, 0, Name, Fehler) > 0;
  if Result and (Art = 'einheit') then
    PlanlosDB.Ausfuehren(
      'INSERT INTO einheit (bezeichnung) SELECT ' + QuotedStr(Name) +
      ' WHERE NOT EXISTS (SELECT 1 FROM einheit WHERE bezeichnung = ' +
      QuotedStr(Name) + ')', nil);
end;

function AdresseAn(const Kuerzel: string; Werte: TStrings; out Fehler: string): Int64;
begin
  if Werte.IndexOfName('rabatt_prozent') < 0 then
    Werte.Values['rabatt_prozent'] := '0';
  Result := AdresseSpeichern(Kuerzel, 0, Werte, Fehler);
end;

function GruppeAn(Werte: TStrings; out Fehler: string): Int64;
var
  Gruppe: TArtikelGruppe;
begin
  Gruppe := Default(TArtikelGruppe);
  Gruppe.Bezeichnung := Feld(Werte, 'bezeichnung');
  Gruppe.Berechnungsart := Feld(Werte, 'berechnungsart');
  Gruppe.AufschlagBp := Ganz(Werte, 'aufschlag_bp');
  Gruppe.Kostenart := Feld(Werte, 'kostenart');
  Gruppe.EinheitMengeWieEk := Ganz(Werte, 'einheit_wie_ek') <> 0;
  Gruppe.VorgabeEkCent := Ganz(Werte, 'vorgabe_ek_cent');
  Gruppe.VorgabeAufschlagBp := Ganz(Werte, 'vorgabe_aufschlag_bp');
  Result := GruppeSpeichern(Gruppe, Fehler);
end;

function ArtikelAn(Werte: TStrings; out Fehler: string): Int64;
var
  Artikel: TArtikel;
begin
  Artikel := Default(TArtikel);
  Artikel.GruppeId := GruppeFinden(Feld(Werte, 'gruppe'));
  Artikel.Bezeichnung := Feld(Werte, 'bezeichnung');
  Artikel.EkCent := Ganz(Werte, 'ek_cent');
  Artikel.EinheitEk := Feld(Werte, 'einheit_ek');
  Artikel.EinheitMenge := Feld(Werte, 'einheit_menge');
  Artikel.AufschlagBp := Ganz(Werte, 'aufschlag_bp');
  Artikel.MwstSatz := Ganz(Werte, 'mwst_satz');
  Artikel.GewichtMilli := Ganz(Werte, 'gewicht_milli');
  Artikel.Zahl1Milli := Ganz(Werte, 'zahl1_milli');
  Artikel.Zahl2Milli := Ganz(Werte, 'zahl2_milli');
  Artikel.Zahl3Milli := Ganz(Werte, 'zahl3_milli');
  Artikel.BestandMilli := Ganz(Werte, 'bestand_milli');
  Artikel.MinBestandMilli := Ganz(Werte, 'min_bestand_milli');
  Artikel.Berechnungsart := 'Menge*EK_Preis';
  Artikel.Kostenart := 'M';
  Result := ArtikelSpeichern(Artikel, Fehler);
end;

function ProjektAn(Werte: TStrings; out Fehler: string): Int64;
var
  Projekt: TProjekt;
begin
  Projekt := Default(TProjekt);
  Projekt.Bezeichnung := Feld(Werte, 'bezeichnung');
  Projekt.KundeId := AdresseFinden(Feld(Werte, 'kunde'));
  Projekt.Gruppierung := Feld(Werte, 'gruppierung');
  Projekt.Notiz := Feld(Werte, 'notiz');
  Result := ProjektSpeichern(Projekt, Fehler);
end;

function TextAn(Werte: TStrings; out Fehler: string): Int64;
var
  Baustein: TTextbaustein;
begin
  Baustein := Default(TTextbaustein);
  Baustein.Textart := Feld(Werte, 'textart');
  Baustein.Beschreibung := Feld(Werte, 'beschreibung');
  Baustein.Text := Feld(Werte, 'inhalt');
  Baustein.Modulart := 'Standard';
  Result := TextbausteinSpeichern(Baustein, Fehler);
end;

function PositionAus(const Zeile: string; out Position: TBelegPosition;
  out Fehler: string): Boolean;
var
  Teile: TStringList;
  Preis: Int64;
  Menge: Int64;
  Artikel: TArtikel;
begin
  Result := False;
  Position := Default(TBelegPosition);
  Teile := TStringList.Create;
  try
    Teile.StrictDelimiter := True;
    Teile.Delimiter := '|';
    Teile.DelimitedText := Zeile;
    if Teile.Count < 4 then
    begin
      Fehler := 'Eine Position braucht Name, Menge, Einheit und Preis: ' + Zeile;
      Exit;
    end;
    if not MilliFeld(Teile[1], Menge) or not CentFeld(Teile[2 + 1], Preis) then
    begin
      Fehler := 'Menge oder Preis ist keine Zahl: ' + Zeile;
      Exit;
    end;
    Position.Text := Trim(Teile[0]);
    Position.MengeMilli := Menge;
    Position.Einheit := Trim(Teile[2]);
    Position.EinzelpreisCent := Preis;
    if Teile.Count > 4 then
      Position.MwstSatz := StrToIntDef(Trim(Teile[4]), 0)
    else
      Position.MwstSatz := 0;
    Position.ArtikelId := ArtikelFinden(Position.Text);
    if (Position.ArtikelId > 0) and ArtikelLaden(Position.ArtikelId, Artikel) then
    begin
      Position.ArtikelName := Artikel.Bezeichnung;
      Position.Gruppe := Artikel.Gruppe;
      Position.EkCent := Artikel.EkCent;
      Position.EinheitEk := Artikel.EinheitEk;
      Position.AufschlagBp := 0;
      Position.RabattBp := 0;
    end;
    Result := True;
  finally
    Teile.Free;
  end;
end;

function StueckAn(const Satz: TSatz; out Fehler: string): Int64;
var
  Liste: TStueckliste;
  Teile: TStringList;
  i: Integer;
  Zeile: TStueckZeile;
  Cent, Milli: Int64;
  Bp: Integer;
begin
  Result := 0;
  Liste := Default(TStueckliste);
  Liste.Bezeichnung := Feld(Satz.Werte, 'bezeichnung');
  Liste.Gruppe := Feld(Satz.Werte, 'gruppe');
  Liste.Einheit := Feld(Satz.Werte, 'einheit');
  Teile := TStringList.Create;
  try
    Teile.StrictDelimiter := True;
    Teile.Delimiter := '|';
    for i := 0 to Satz.Positionen.Count - 1 do
    begin
      Teile.DelimitedText := Satz.Positionen[i];
      Zeile := Default(TStueckZeile);
      if Teile.Count > 0 then
        Zeile.Bezeichnung := Teile[0];
      if (Teile.Count > 1) and MilliAusText(Teile[1], Milli) then
        Zeile.MengeMilli := Milli;
      if Teile.Count > 2 then
        Zeile.Einheit := Teile[2];
      if (Teile.Count > 3) and CentAusText(Teile[3], Cent) then
        Zeile.EkCent := Cent;
      if (Teile.Count > 4) and AufschlagAusText(Teile[4], Bp) then
        Zeile.AufschlagBp := Bp;
      SetLength(Liste.Zeilen, Length(Liste.Zeilen) + 1);
      Liste.Zeilen[High(Liste.Zeilen)] := Zeile;
    end;
  finally
    Teile.Free;
  end;
  if StuecklisteSpeichern(Liste, Fehler) then
    Result := Liste.Id;
end;

function BelegAn(const Satz: TSatz; out Fehler: string): Int64;
var
  Kopf: TBelegKopf;
  Liste: TPosListe;
  i: Integer;
  Position: TBelegPosition;
  Baustein: TTextbaustein;
begin
  Result := 0;
  Kopf := Default(TBelegKopf);
  Kopf.Modulart := Feld(Satz.Werte, 'art');
  Kopf.Bezeichnung := Feld(Satz.Werte, 'bezeichnung');
  Kopf.Gruppierung := Feld(Satz.Werte, 'gruppierung');
  Kopf.AdresseId := AdresseFinden(Feld(Satz.Werte, 'empfaenger'));
  if Kopf.AdresseId > 0 then
    Kopf.AdresseText := Adressblock(Kopf.AdresseId);
  Kopf.ProjektStammId := ProjektFinden(Feld(Satz.Werte, 'projekt'));
  Kopf.KopfBausteinId := BausteinFinden(Feld(Satz.Werte, 'kopf'));
  Kopf.FussBausteinId := BausteinFinden(Feld(Satz.Werte, 'fuss'));
  if (Kopf.KopfBausteinId > 0) and TextbausteinLaden(Kopf.KopfBausteinId, Baustein) then
    Kopf.Kopftext := Baustein.Text;
  if (Kopf.FussBausteinId > 0) and TextbausteinLaden(Kopf.FussBausteinId, Baustein) then
    Kopf.Fusstext := Baustein.Text;
  SetLength(Liste, Satz.Positionen.Count);
  for i := 0 to Satz.Positionen.Count - 1 do
  begin
    if not PositionAus(Satz.Positionen[i], Position, Fehler) then
      Exit;
    Liste[i] := Position;
  end;
  Result := BelegSpeichern(Kopf, Liste, Fehler);
end;

function TestdatenEinfuegen(out Meldung: string): Boolean;
var
  Saetze: array[0..199] of TSatz;
  Anzahl, i, Adressen, ArtikelZahl, Belege: Integer;
  Datei, Fehler: string;
begin
  Result := False;
  Meldung := '';
  if (PlanlosDB = nil) or not PlanlosDB.Verbunden then
  begin
    Meldung := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  if TestdatenVorhanden then
  begin
    Meldung := 'Die Testdaten sind schon eingespielt.';
    Exit;
  end;
  Datei := TestdatenPfad;
  if not SatzLesen(Datei, Saetze, Anzahl, Fehler) then
  begin
    Meldung := Fehler;
    Exit;
  end;
  Adressen := 0;
  ArtikelZahl := 0;
  Belege := 0;
  try
    for i := 0 to Anzahl - 1 do
    begin
      Fehler := '';
      if (Saetze[i].Art = 'gruppierung') or (Saetze[i].Art = 'einheit') or
         (Saetze[i].Art = 'kategorie') or (Saetze[i].Art = 'stuecklistengruppe') then
      begin
        if not NachschlageAn(Saetze[i].Art, Feld(Saetze[i].Werte, 'bezeichnung'),
          Fehler) then
          Exit;
      end
      else if (Saetze[i].Art = 'kunde') or (Saetze[i].Art = 'lieferant') or
         (Saetze[i].Art = 'kontakt') or (Saetze[i].Art = 'mitarbeiter') then
      begin
        if AdresseAn(Saetze[i].Art, Saetze[i].Werte, Fehler) = 0 then
          Exit;
        Inc(Adressen);
      end
      else if Saetze[i].Art = 'artikelgruppe' then
      begin
        if GruppeAn(Saetze[i].Werte, Fehler) = 0 then
          Exit;
      end
      else if Saetze[i].Art = 'artikel' then
      begin
        if ArtikelAn(Saetze[i].Werte, Fehler) = 0 then
          Exit;
        Inc(ArtikelZahl);
      end
      else if Saetze[i].Art = 'projekt' then
      begin
        if ProjektAn(Saetze[i].Werte, Fehler) = 0 then
          Exit;
      end
      else if Saetze[i].Art = 'textbaustein' then
      begin
        if TextAn(Saetze[i].Werte, Fehler) = 0 then
          Exit;
      end
      else if Saetze[i].Art = 'stueckliste' then
      begin
        if StueckAn(Saetze[i], Fehler) = 0 then
          Exit;
      end
      else if Saetze[i].Art = 'beleg' then
      begin
        if BelegAn(Saetze[i], Fehler) = 0 then
          Exit;
        Inc(Belege);
      end
      else
      begin
        Fehler := 'Unbekannter Abschnitt: ' + Saetze[i].Art;
        Exit;
      end;
    end;
    ZahlenAufNull;
    if not ZahlenDicht then
    begin
      Fehler := 'In den Testdaten ist eine Zahl leer geblieben.';
      Exit;
    end;
    PlanlosDB.ParameterSetzen('testdaten', '1');
    Meldung := 'Testdaten eingespielt: ' + IntToStr(Adressen) + ' Adressen, ' +
      IntToStr(ArtikelZahl) + ' Artikel, ' + IntToStr(Belege) + ' Belege.';
    Result := True;
  finally
    if not Result and (Fehler <> '') and (Meldung = '') then
      Meldung := Fehler;
    for i := 0 to Anzahl - 1 do
    begin
      Saetze[i].Werte.Free;
      Saetze[i].Positionen.Free;
    end;
  end;
end;

procedure ListeHolen(const Kuerzel: string; Spalten, Zeilen: TStrings);
begin
  if Kuerzel = 'projekt' then
    ProjektLesen('', Spalten, Zeilen)
  else if Kuerzel = 'textbaustein' then
    TextbausteinLesen('', '', Spalten, Zeilen)
  else if Kuerzel = 'modulart' then
    ModulartLesen('', Spalten, Zeilen)
  else if Kuerzel = 'benutzer' then
    BenutzerLesen('', Spalten, Zeilen)
  else if Stammliste(Kuerzel) then
    StammLesen(Kuerzel, '', Spalten, Zeilen)
  else
    TrefferLesen(Kuerzel, '', Spalten, Zeilen);
end;

function TestdatenMaskenPruefen(out Fehler: string): Boolean;
const
  Masken: array[0..14] of string = (
    'kunde', 'lieferant', 'kontakt', 'mitarbeiter', 'artikel', 'artikelgruppe',
    'einheit', 'kategorie', 'gruppierung', 'stuecklistengruppe',
    'berechnungsart', 'projekt', 'textbaustein', 'modulart', 'benutzer'
  );
  Nadeln: array[0..14] of string = (
    'Meier', 'Schmidt', 'Kurz', 'Berger', 'Eiche', 'Holz',
    'Pauschale', 'Kunde', 'Fensterbau', 'Beschlag',
    'Menge', 'Umbau', 'Begrüßung', 'Angebot', 'Admin'
  );
var
  i: Integer;
  Spalten, Zeilen: TStringList;
  Text: string;
begin
  Result := False;
  Fehler := '';
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  try
    for i := 0 to High(Masken) do
    begin
      ListeHolen(Masken[i], Spalten, Zeilen);
      if Spalten.Count < 1 then
      begin
        Fehler := 'Die Maske ' + Masken[i] + ' liefert keine Spalten.';
        Exit;
      end;
      Text := Zeilen.Text;
      if (Nadeln[i] <> '') and (Pos(Nadeln[i], Text) = 0) then
      begin
        Fehler := 'Die Maske ' + Masken[i] + ' zeigt ' + Nadeln[i] + ' nicht.';
        Exit;
      end;
    end;
    Result := True;
  finally
    Zeilen.Free;
    Spalten.Free;
  end;
end;

end.
