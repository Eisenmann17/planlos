unit ubeleg;

{ Belege rechnen und speichern. Beträge in Cent, Mengen in Tausendsteln.
  Rundung kaufmännisch, halb aufrunden, ohne Gleitkomma.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils;

type
  TBelegart = record
    Id: Integer;
    Kuerzel: string;
    Bezeichnung: string;
    Nummernkreis: string;
    EmpfaengerMaske: string;
    BeschriftungEmpfaenger: string;
    Kopf: Boolean;
    Positionen: Boolean;
    Summe: Boolean;
    Fuss: Boolean;
    Mwst: Boolean;
    Links: Integer;
    Oben: Integer;
    Breite: Integer;
    Hoehe: Integer;
  end;

  TBelegPosition = record
    Id: Int64;
    PositionNr: Integer;
    ArtikelId: Int64;
    Text: string;
    MengeMilli: Int64;
    Einheit: string;
    EinzelpreisCent: Int64;
    MwstSatz: Integer;
  end;

  TBelegKopf = record
    Id: Int64;
    Modulart: string;
    Nummer: string;
    AdresseId: Int64;
    Bezeichnung: string;
    Kopftext: string;
    Fusstext: string;
    Notiz: string;
    BezugId: Int64;
    BezugNummer: string;
    MwstRechnen: Boolean;
  end;

  TMwstGruppe = record
    Satz: Integer;
    NettoCent: Int64;
    SteuerCent: Int64;
  end;

  TBelegSumme = record
    NettoCent: Int64;
    SteuerCent: Int64;
    BruttoCent: Int64;
    Gruppen: array of TMwstGruppe;
  end;

  TPosListe = array of TBelegPosition;

  TBelegTaste = record
    Ebene: Integer;
    Taste: Integer;
    Beschriftung: string;
    Aktion: string;
    Erlaubt: Boolean;
  end;

  TBelegTasten = array of TBelegTaste;

function Kaufmaennisch(Zaehler, Nenner: Int64): Int64;
function CentAusText(const Text: string; out Cent: Int64): Boolean;
function MilliAusText(const Text: string; out Milli: Int64): Boolean;
function CentAlsText(Cent: Int64): string;
function MilliAlsText(Milli: Int64): string;
function PositionNetto(const Position: TBelegPosition): Int64;
function SummeRechnen(const Positionen: array of TBelegPosition;
  MwstRechnen: Boolean): TBelegSumme;

function BelegartLaden(const Kuerzel: string; out Art: TBelegart): Boolean;
function BelegTasten(const Kuerzel, Kontext: string): TBelegTasten;
function AdressKurzname(Id: Int64): string;
function BelegSpeichern(var Kopf: TBelegKopf; const Positionen: array of TBelegPosition;
  out Fehler: string): Int64;
function BelegLaden(Id: Int64; out Kopf: TBelegKopf; out Positionen: TPosListe): Boolean;
function FolgebelegErzeugen(QuellId: Int64; const ZielKuerzel: string;
  out Fehler: string): Int64;
function BelegNummer(Id: Int64): string;
function BelegArtKuerzel(Id: Int64): string;
function BelegAnzahl(const Kuerzel, Suchtext: string): Integer;
procedure BelegeLesen(const Kuerzel, Suchtext: string; Spalten, Zeilen: TStrings);

type
  TZeitraum = (zrAlle, zrJahr, zrMonat, zrTag);
  TModulFilter = (mfAlle, mfBezeichnung, mfAdressname, mfNummer, mfProjekt);
  TSonstiges = (soAlle, soBearbeiter, soGruppe);

  TExplorerFilter = record
    Modulart: string;
    ModulFilter: TModulFilter;
    Suchtext: string;
    AdresseId: Int64;
    ProjektId: Int64;
    Zeitraum: TZeitraum;
    Jahr: Integer;
    Monat: Integer;
    Tag: string;
    Sonstiges: TSonstiges;
    BearbeiterId: Int64;
    Gruppe: string;
  end;

{ Zeilen: id, kuerzel, Modulart, Bezeichnung, Adressname, Nr, Projektname,
  Erfassungsdatum, Bearbeiter, Gruppierung, LetzteBearbeitung. }
procedure ExplorerLesen(const Filter: TExplorerFilter; Spalten, Zeilen: TStrings);
procedure ExplorerWerte(const Was, Modulart: string; Ziel: TStrings);

implementation

uses
  udatenbank, ubenutzer;

function Kaufmaennisch(Zaehler, Nenner: Int64): Int64;
var
  Negativ: Boolean;
begin
  if Nenner <= 0 then
    raise Exception.Create('Teilen durch null ist beim Runden nicht erlaubt.');
  Negativ := Zaehler < 0;
  if Negativ then
    Zaehler := -Zaehler;
  Result := (Zaehler + (Nenner div 2)) div Nenner;
  if Negativ then
    Result := -Result;
end;

function NurZiffern(const Text: string): Boolean;
var
  i: Integer;
begin
  Result := Text <> '';
  for i := 1 to Length(Text) do
    if (Text[i] < '0') or (Text[i] > '9') then
      Exit(False);
end;

function CentAusText(const Text: string; out Cent: Int64): Boolean;
var
  Normal, Ganz, Bruch: string;
  Trenner: Integer;
begin
  Cent := 0;
  Normal := Trim(Text);
  if Normal = '' then
    Exit(False);
  Normal := StringReplace(Normal, '.', ',', [rfReplaceAll]);
  Trenner := Pos(',', Normal);
  if Trenner = 0 then
  begin
    Ganz := Normal;
    Bruch := '00';
  end
  else
  begin
    Ganz := Copy(Normal, 1, Trenner - 1);
    Bruch := Copy(Normal, Trenner + 1, 8);
  end;
  if Ganz = '' then
    Ganz := '0';
  if not NurZiffern(Ganz) then
    Exit(False);
  if Length(Bruch) > 2 then
    Exit(False);
  while Length(Bruch) < 2 do
    Bruch := Bruch + '0';
  if not NurZiffern(Bruch) then
    Exit(False);
  Cent := StrToInt64(Ganz) * 100 + StrToInt64(Bruch);
  Result := True;
end;

function MilliAusText(const Text: string; out Milli: Int64): Boolean;
var
  Normal, Ganz, Bruch: string;
  Trenner: Integer;
begin
  Milli := 0;
  Normal := Trim(Text);
  if Normal = '' then
    Exit(False);
  Normal := StringReplace(Normal, '.', ',', [rfReplaceAll]);
  Trenner := Pos(',', Normal);
  if Trenner = 0 then
  begin
    Ganz := Normal;
    Bruch := '000';
  end
  else
  begin
    Ganz := Copy(Normal, 1, Trenner - 1);
    Bruch := Copy(Normal, Trenner + 1, 8);
  end;
  if Ganz = '' then
    Ganz := '0';
  if not NurZiffern(Ganz) then
    Exit(False);
  if Length(Bruch) > 3 then
    Exit(False);
  while Length(Bruch) < 3 do
    Bruch := Bruch + '0';
  if not NurZiffern(Bruch) then
    Exit(False);
  Milli := StrToInt64(Ganz) * 1000 + StrToInt64(Bruch);
  Result := True;
end;

function CentAlsText(Cent: Int64): string;
var
  Negativ: Boolean;
  Ganz, Rest: Int64;
begin
  Negativ := Cent < 0;
  if Negativ then
    Cent := -Cent;
  Ganz := Cent div 100;
  Rest := Cent mod 100;
  Result := IntToStr(Ganz) + ',' + IntToStr(Rest div 10) + IntToStr(Rest mod 10);
  if Negativ then
    Result := '-' + Result;
end;

function MilliAlsText(Milli: Int64): string;
var
  Ganz, Rest: Int64;
  Bruch: string;
begin
  Ganz := Milli div 1000;
  Rest := Milli mod 1000;
  Result := IntToStr(Ganz);
  if Rest = 0 then
    Exit;
  Bruch := Copy(IntToStr(1000 + Rest), 2, 3);
  while (Bruch <> '') and (Bruch[Length(Bruch)] = '0') do
    Delete(Bruch, Length(Bruch), 1);
  Result := Result + ',' + Bruch;
end;

function PositionNetto(const Position: TBelegPosition): Int64;
begin
  Result := Kaufmaennisch(Position.MengeMilli * Position.EinzelpreisCent, 1000);
end;

function SummeRechnen(const Positionen: array of TBelegPosition;
  MwstRechnen: Boolean): TBelegSumme;
var
  i, g, Satz: Integer;
  Netto: Int64;
  Gefunden: Boolean;
begin
  Result.NettoCent := 0;
  Result.SteuerCent := 0;
  Result.BruttoCent := 0;
  SetLength(Result.Gruppen, 0);
  for i := 0 to High(Positionen) do
  begin
    Netto := PositionNetto(Positionen[i]);
    Result.NettoCent := Result.NettoCent + Netto;
    if MwstRechnen then
      Satz := Positionen[i].MwstSatz
    else
      Satz := 0;
    Gefunden := False;
    for g := 0 to High(Result.Gruppen) do
      if Result.Gruppen[g].Satz = Satz then
      begin
        Result.Gruppen[g].NettoCent := Result.Gruppen[g].NettoCent + Netto;
        Gefunden := True;
        Break;
      end;
    if not Gefunden then
    begin
      SetLength(Result.Gruppen, Length(Result.Gruppen) + 1);
      Result.Gruppen[High(Result.Gruppen)].Satz := Satz;
      Result.Gruppen[High(Result.Gruppen)].NettoCent := Netto;
      Result.Gruppen[High(Result.Gruppen)].SteuerCent := 0;
    end;
  end;
  for g := 0 to High(Result.Gruppen) do
  begin
    if MwstRechnen then
      Result.Gruppen[g].SteuerCent :=
        Kaufmaennisch(Result.Gruppen[g].NettoCent * Result.Gruppen[g].Satz, 100)
    else
      Result.Gruppen[g].SteuerCent := 0;
    Result.SteuerCent := Result.SteuerCent + Result.Gruppen[g].SteuerCent;
  end;
  Result.BruttoCent := Result.NettoCent + Result.SteuerCent;
end;

function Bereit: Boolean;
begin
  Result := (PlanlosDB <> nil) and PlanlosDB.Verbunden;
end;

function Wahr(const Wert: string): Boolean;
begin
  Result := Wert = '1';
end;

function BelegartLaden(const Kuerzel: string; out Art: TBelegart): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  Art.Id := 0;
  Art.Kuerzel := Kuerzel;
  Art.Bezeichnung := '';
  Art.Nummernkreis := '';
  Art.EmpfaengerMaske := '';
  Art.BeschriftungEmpfaenger := '';
  Art.Kopf := True;
  Art.Positionen := True;
  Art.Summe := True;
  Art.Fuss := True;
  Art.Mwst := True;
  Art.Links := 40;
  Art.Oben := 30;
  Art.Breite := 900;
  Art.Hoehe := 640;
  if not Bereit then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['kuerzel'] := Kuerzel;
    PlanlosDB.ErsteZeile(
      'SELECT id, kuerzel, bezeichnung, nummernkreis, empfaenger_maske, ' +
      'beschriftung_empfaenger, bereich_kopf, bereich_positionen, bereich_summe, ' +
      'bereich_fuss, mwst, fenster_links, fenster_oben, fenster_breite, fenster_hoehe ' +
      'FROM modulart WHERE kuerzel = :kuerzel', Parameter, Zeile);
    if Zeile.Values['id'] = '' then
      Exit;
    Art.Id := StrToIntDef(Zeile.Values['id'], 0);
    Art.Kuerzel := Zeile.Values['kuerzel'];
    Art.Bezeichnung := Zeile.Values['bezeichnung'];
    Art.Nummernkreis := Zeile.Values['nummernkreis'];
    Art.EmpfaengerMaske := Zeile.Values['empfaenger_maske'];
    Art.BeschriftungEmpfaenger := Zeile.Values['beschriftung_empfaenger'];
    Art.Kopf := Wahr(Zeile.Values['bereich_kopf']);
    Art.Positionen := Wahr(Zeile.Values['bereich_positionen']);
    Art.Summe := Wahr(Zeile.Values['bereich_summe']);
    Art.Fuss := Wahr(Zeile.Values['bereich_fuss']);
    Art.Mwst := Wahr(Zeile.Values['mwst']);
    Art.Links := StrToIntDef(Zeile.Values['fenster_links'], 40);
    Art.Oben := StrToIntDef(Zeile.Values['fenster_oben'], 30);
    Art.Breite := StrToIntDef(Zeile.Values['fenster_breite'], 900);
    Art.Hoehe := StrToIntDef(Zeile.Values['fenster_hoehe'], 640);
    Result := Art.Id > 0;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function BelegTasten(const Kuerzel, Kontext: string): TBelegTasten;
var
  Parameter, Spalten, Zeilen, Teile: TStringList;
  i, PosTab: Integer;
  Rest, Stueck: string;

  procedure Zerlegen(const Zeile: string);
  begin
    Teile.Clear;
    Rest := Zeile;
    repeat
      PosTab := Pos(#9, Rest);
      if PosTab = 0 then
      begin
        Teile.Add(Rest);
        Break;
      end;
      Stueck := Copy(Rest, 1, PosTab - 1);
      Teile.Add(Stueck);
      Delete(Rest, 1, PosTab);
    until False;
  end;

begin
  SetLength(Result, 0);
  if not Bereit then
    Exit;
  Parameter := TStringList.Create;
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  Teile := TStringList.Create;
  try
    Parameter.Values['kuerzel'] := Kuerzel;
    Parameter.Values['kontext'] := Kontext;
    PlanlosDB.AlleZeilen(
      'SELECT t.ebene, t.taste, t.beschriftung, t.aktion, t.erlaubt ' +
      'FROM belegtaste t JOIN modulart m ON m.id = t.modulart_id ' +
      'WHERE m.kuerzel = :kuerzel AND t.kontext = :kontext ' +
      'ORDER BY t.ebene, t.taste', Parameter, Spalten, Zeilen);
    SetLength(Result, Zeilen.Count);
    for i := 0 to Zeilen.Count - 1 do
    begin
      Zerlegen(Zeilen[i]);
      if Teile.Count < 5 then
        Continue;
      Result[i].Ebene := StrToIntDef(Teile[0], 1);
      Result[i].Taste := StrToIntDef(Teile[1], 0);
      Result[i].Beschriftung := Teile[2];
      Result[i].Aktion := Teile[3];
      Result[i].Erlaubt := Teile[4] = '1';
    end;
  finally
    Teile.Free;
    Zeilen.Free;
    Spalten.Free;
    Parameter.Free;
  end;
end;

function AdressKurzname(Id: Int64): string;
var
  Parameter, Zeile: TStringList;
begin
  Result := '';
  if (Id = 0) or not Bereit then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT firma, vorname, nachname FROM adresse WHERE id = :id',
      Parameter, Zeile);
    Result := Trim(Zeile.Values['firma']);
    if Trim(Zeile.Values['nachname']) <> '' then
    begin
      if Result <> '' then
        Result := Result + ', ';
      Result := Result + Trim(Trim(Zeile.Values['vorname']) + ' ' +
        Trim(Zeile.Values['nachname']));
    end;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function NaechsteNummer(Art: TBelegart): string;
var
  Parameter: TStringList;
  N: Int64;
  Versuch: Integer;
begin
  Result := '';
  for Versuch := 1 to 5 do
  begin
    Parameter := TStringList.Create;
    try
      Parameter.Values['id'] := IntToStr(Art.Id);
      N := StrToInt64Def(Trim(PlanlosDB.SkalarMit(
        'SELECT nummer_naechste FROM modulart WHERE id = :id', Parameter)), 0);
      Parameter.Values['n'] := IntToStr(N);
      if PlanlosDB.Ausfuehren(
        'UPDATE modulart SET nummer_naechste = nummer_naechste + 1 ' +
        'WHERE id = :id AND nummer_naechste = :n', Parameter) = 1 then
      begin
        if Art.Nummernkreis = '' then
          Result := IntToStr(N)
        else
          Result := Art.Nummernkreis + '-' + IntToStr(N);
        Exit;
      end;
    finally
      Parameter.Free;
    end;
  end;
  raise Exception.Create('Der Nummernkreis konnte nicht fortgeschrieben werden.');
end;

function SatzErlaubt(Satz: Integer): Boolean;
begin
  Result := (Satz = 0) or (Satz = 7) or (Satz = 19);
end;

function BelegSpeichern(var Kopf: TBelegKopf; const Positionen: array of TBelegPosition;
  out Fehler: string): Int64;
var
  Art: TBelegart;
  Parameter: TStringList;
  i: Integer;
  Jetzt, ArtikelSql: string;
begin
  Result := 0;
  Fehler := '';
  if not BelegartLaden(Kopf.Modulart, Art) then
  begin
    Fehler := 'Die Belegart ' + Kopf.Modulart + ' gibt es nicht.';
    Exit;
  end;
  if (Art.EmpfaengerMaske <> '') and (Kopf.AdresseId = 0) then
  begin
    Fehler := 'Bitte einen ' + Art.BeschriftungEmpfaenger + ' auswählen.';
    Exit;
  end;
  for i := 0 to High(Positionen) do
  begin
    if Trim(Positionen[i].Text) = '' then
    begin
      Fehler := 'Position ' + IntToStr(i + 1) + ' braucht einen Text.';
      Exit;
    end;
    if not SatzErlaubt(Positionen[i].MwstSatz) then
    begin
      Fehler := 'MwSt-Satz muss 19, 7 oder 0 sein.';
      Exit;
    end;
    if Positionen[i].MengeMilli < 0 then
    begin
      Fehler := 'Die Menge darf nicht negativ sein.';
      Exit;
    end;
  end;

  Jetzt := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', Now);
  Parameter := TStringList.Create;
  try
    Parameter.Values['art'] := IntToStr(Art.Id);
    Parameter.Values['adresse'] := IntToStr(Kopf.AdresseId);
    Parameter.Values['bezeichnung'] := Kopf.Bezeichnung;
    Parameter.Values['kopf'] := Kopf.Kopftext;
    Parameter.Values['fuss'] := Kopf.Fusstext;
    Parameter.Values['notiz'] := Kopf.Notiz;
    Parameter.Values['jetzt'] := Jetzt;
    if Kopf.Id = 0 then
    begin
      Kopf.Nummer := NaechsteNummer(Art);
      Kopf.MwstRechnen := Art.Mwst;
      Parameter.Values['nummer'] := Kopf.Nummer;
      Parameter.Values['mwst'] := IntToStr(Ord(Kopf.MwstRechnen));
      if Kopf.BezugId = 0 then
        Parameter.Values['bezug'] := ''
      else
        Parameter.Values['bezug'] := IntToStr(Kopf.BezugId);
      if AngemeldeterMitarbeiter > 0 then
        Parameter.Values['bearbeiter'] := IntToStr(AngemeldeterMitarbeiter)
      else
        Parameter.Values['bearbeiter'] := '';
      PlanlosDB.Ausfuehren(
        'INSERT INTO beleg (modulart_id, nummer, adresse_id, bezeichnung, kopftext, ' +
        'fusstext, notiz, bezug_beleg_id, mwst_rechnen, bearbeiter_id, angelegt, geaendert) ' +
        'VALUES (:art, :nummer, NULLIF(:adresse, ''0''), :bezeichnung, :kopf, :fuss, :notiz, ' +
        'NULLIF(:bezug, ''''), :mwst, NULLIF(:bearbeiter, ''''), :jetzt, :jetzt)', Parameter);
      Kopf.Id := StrToInt64Def(Trim(PlanlosDB.Skalar('SELECT last_insert_rowid()')), 0);
    end
    else
    begin
      Parameter.Values['id'] := IntToStr(Kopf.Id);
      if PlanlosDB.Ausfuehren(
        'UPDATE beleg SET adresse_id = NULLIF(:adresse, ''0''), bezeichnung = :bezeichnung, ' +
        'kopftext = :kopf, fusstext = :fuss, notiz = :notiz, geaendert = :jetzt ' +
        'WHERE id = :id AND modulart_id = :art', Parameter) < 1 then
      begin
        Fehler := 'Der Beleg gehört nicht zu dieser Belegart.';
        Exit;
      end;
    end;

    Parameter.Clear;
    Parameter.Values['beleg'] := IntToStr(Kopf.Id);
    PlanlosDB.Ausfuehren('DELETE FROM belegposition WHERE beleg_id = :beleg', Parameter);
    for i := 0 to High(Positionen) do
    begin
      Parameter.Clear;
      Parameter.Values['beleg'] := IntToStr(Kopf.Id);
      Parameter.Values['nr'] := IntToStr(i + 1);
      Parameter.Values['text'] := Positionen[i].Text;
      Parameter.Values['menge'] := IntToStr(Positionen[i].MengeMilli);
      Parameter.Values['einheit'] := Positionen[i].Einheit;
      Parameter.Values['preis'] := IntToStr(Positionen[i].EinzelpreisCent);
      Parameter.Values['satz'] := IntToStr(Positionen[i].MwstSatz);
      if Positionen[i].ArtikelId > 0 then
        ArtikelSql := IntToStr(Positionen[i].ArtikelId)
      else
        ArtikelSql := 'NULL';
      PlanlosDB.Ausfuehren(
        'INSERT INTO belegposition (beleg_id, position_nr, artikel_id, positionstext, ' +
        'menge_milli, einheit, einzelpreis_cent, mwst_satz) VALUES (:beleg, :nr, ' +
        ArtikelSql + ', :text, :menge, :einheit, :preis, :satz)', Parameter);
    end;
    Result := Kopf.Id;
  finally
    Parameter.Free;
  end;
end;

function BelegLaden(Id: Int64; out Kopf: TBelegKopf; out Positionen: TPosListe): Boolean;
var
  Parameter, Zeile, Spalten, Zeilen, Teile: TStringList;
  i, PosTab: Integer;
  Rest, Stueck: string;

  procedure Zerlegen(const Wert: string);
  begin
    Teile.Clear;
    Rest := Wert;
    repeat
      PosTab := Pos(#9, Rest);
      if PosTab = 0 then
      begin
        Teile.Add(Rest);
        Break;
      end;
      Stueck := Copy(Rest, 1, PosTab - 1);
      Teile.Add(Stueck);
      Delete(Rest, 1, PosTab);
    until False;
  end;

begin
  Result := False;
  Kopf.Id := 0;
  Kopf.Modulart := '';
  Kopf.Nummer := '';
  Kopf.AdresseId := 0;
  Kopf.Bezeichnung := '';
  Kopf.Kopftext := '';
  Kopf.Fusstext := '';
  Kopf.Notiz := '';
  Kopf.BezugId := 0;
  Kopf.BezugNummer := '';
  Kopf.MwstRechnen := True;
  SetLength(Positionen, 0);
  if not Bereit then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  Teile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT b.id, m.kuerzel AS kuerzel, b.nummer AS belegnummer, b.adresse_id, ' +
      'b.bezeichnung, b.kopftext, b.fusstext, b.notiz, b.bezug_beleg_id, ' +
      'b.mwst_rechnen, v.nummer AS bezugnummer ' +
      'FROM beleg b JOIN modulart m ON m.id = b.modulart_id ' +
      'LEFT JOIN beleg v ON v.id = b.bezug_beleg_id WHERE b.id = :id',
      Parameter, Zeile);
    if Zeile.Values['id'] = '' then
      Exit;
    Kopf.Id := Id;
    Kopf.Modulart := Zeile.Values['kuerzel'];
    Kopf.Nummer := Zeile.Values['belegnummer'];
    Kopf.AdresseId := StrToInt64Def(Zeile.Values['adresse_id'], 0);
    Kopf.Bezeichnung := Zeile.Values['bezeichnung'];
    Kopf.Kopftext := Zeile.Values['kopftext'];
    Kopf.Fusstext := Zeile.Values['fusstext'];
    Kopf.Notiz := Zeile.Values['notiz'];
    Kopf.BezugId := StrToInt64Def(Zeile.Values['bezug_beleg_id'], 0);
    Kopf.BezugNummer := Zeile.Values['bezugnummer'];
    Kopf.MwstRechnen := Wahr(Zeile.Values['mwst_rechnen']);
    PlanlosDB.AlleZeilen(
      'SELECT id, position_nr, artikel_id, positionstext, menge_milli, einheit, ' +
      'einzelpreis_cent, mwst_satz FROM belegposition WHERE beleg_id = :id ' +
      'ORDER BY position_nr, id', Parameter, Spalten, Zeilen);
    SetLength(Positionen, Zeilen.Count);
    for i := 0 to Zeilen.Count - 1 do
    begin
      Zerlegen(Zeilen[i]);
      if Teile.Count < 8 then
        Continue;
      Positionen[i].Id := StrToInt64Def(Teile[0], 0);
      Positionen[i].PositionNr := StrToIntDef(Teile[1], i + 1);
      Positionen[i].ArtikelId := StrToInt64Def(Teile[2], 0);
      Positionen[i].Text := Teile[3];
      Positionen[i].MengeMilli := StrToInt64Def(Teile[4], 0);
      Positionen[i].Einheit := Teile[5];
      Positionen[i].EinzelpreisCent := StrToInt64Def(Teile[6], 0);
      Positionen[i].MwstSatz := StrToIntDef(Teile[7], 0);
    end;
    Result := True;
  finally
    Teile.Free;
    Zeilen.Free;
    Spalten.Free;
    Zeile.Free;
    Parameter.Free;
  end;
end;

function BelegNummer(Id: Int64): string;
var
  Parameter: TStringList;
begin
  Result := '';
  if not Bereit then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    Result := PlanlosDB.SkalarMit('SELECT nummer FROM beleg WHERE id = :id', Parameter);
  finally
    Parameter.Free;
  end;
end;

function BelegArtKuerzel(Id: Int64): string;
var
  Parameter: TStringList;
begin
  Result := '';
  if not Bereit then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    Result := PlanlosDB.SkalarMit(
      'SELECT m.kuerzel FROM beleg b JOIN modulart m ON m.id = b.modulart_id ' +
      'WHERE b.id = :id', Parameter);
  finally
    Parameter.Free;
  end;
end;

function FolgebelegErzeugen(QuellId: Int64; const ZielKuerzel: string;
  out Fehler: string): Int64;
var
  Kopf: TBelegKopf;
  Positionen: TPosListe;
  Parameter: TStringList;
  Erlaubt: Integer;
begin
  Result := 0;
  Fehler := '';
  if not BelegLaden(QuellId, Kopf, Positionen) then
  begin
    Fehler := 'Der Ausgangsbeleg wurde nicht gefunden.';
    Exit;
  end;
  Parameter := TStringList.Create;
  try
    Parameter.Values['von'] := Kopf.Modulart;
    Parameter.Values['nach'] := ZielKuerzel;
    Erlaubt := StrToIntDef(Trim(PlanlosDB.SkalarMit(
      'SELECT COUNT(*) FROM folgebeleg f ' +
      'JOIN modulart v ON v.id = f.von_modulart_id ' +
      'JOIN modulart n ON n.id = f.nach_modulart_id ' +
      'WHERE v.kuerzel = :von AND n.kuerzel = :nach', Parameter)), 0);
  finally
    Parameter.Free;
  end;
  if Erlaubt = 0 then
  begin
    Fehler := 'Aus ' + Kopf.Modulart + ' darf kein Beleg der Art ' +
      ZielKuerzel + ' entstehen.';
    Exit;
  end;
  Kopf.Id := 0;
  Kopf.Nummer := '';
  Kopf.Modulart := ZielKuerzel;
  Kopf.BezugId := QuellId;
  Result := BelegSpeichern(Kopf, Positionen, Fehler);
end;

function BelegAnzahl(const Kuerzel, Suchtext: string): Integer;
var
  Art: TBelegart;
  Parameter: TStringList;
  Muster: string;
begin
  Result := 0;
  if not BelegartLaden(Kuerzel, Art) then
    Exit;
  Parameter := TStringList.Create;
  try
    Muster := '%' + Trim(StringReplace(StringReplace(Suchtext, '%', '',
      [rfReplaceAll]), '_', '', [rfReplaceAll])) + '%';
    Parameter.Values['art'] := IntToStr(Art.Id);
    if Trim(Suchtext) = '' then
      Parameter.Values['leer'] := '1'
    else
      Parameter.Values['leer'] := '0';
    Parameter.Values['muster'] := Muster;
    Result := StrToIntDef(Trim(PlanlosDB.SkalarMit(
      'SELECT COUNT(*) FROM beleg b LEFT JOIN adresse a ON a.id = b.adresse_id ' +
      'WHERE b.modulart_id = :art AND (:leer = ''1'' OR b.nummer LIKE :muster OR ' +
      'b.bezeichnung LIKE :muster OR a.firma LIKE :muster OR a.nachname LIKE :muster)',
      Parameter)), 0);
  finally
    Parameter.Free;
  end;
end;

procedure BelegeLesen(const Kuerzel, Suchtext: string; Spalten, Zeilen: TStrings);
var
  Art: TBelegart;
  Parameter, Ids, IdSpalten: TStringList;
  i: Integer;
  Kopf: TBelegKopf;
  Positionen: TPosListe;
  Summe: TBelegSumme;
  Muster, Zeile: string;
begin
  Spalten.Clear;
  Zeilen.Clear;
  Spalten.Add('id');
  Spalten.Add('Nummer');
  Spalten.Add('Empfänger');
  Spalten.Add('Bezeichnung');
  Spalten.Add('Brutto');
  if not BelegartLaden(Kuerzel, Art) then
    Exit;
  Parameter := TStringList.Create;
  Ids := TStringList.Create;
  IdSpalten := TStringList.Create;
  try
    Muster := '%' + Trim(StringReplace(StringReplace(Suchtext, '%', '',
      [rfReplaceAll]), '_', '', [rfReplaceAll])) + '%';
    Parameter.Values['art'] := IntToStr(Art.Id);
    if Trim(Suchtext) = '' then
      Parameter.Values['leer'] := '1'
    else
      Parameter.Values['leer'] := '0';
    Parameter.Values['muster'] := Muster;
    PlanlosDB.AlleZeilen(
      'SELECT b.id FROM beleg b LEFT JOIN adresse a ON a.id = b.adresse_id ' +
      'WHERE b.modulart_id = :art AND (:leer = ''1'' OR b.nummer LIKE :muster OR ' +
      'b.bezeichnung LIKE :muster OR a.firma LIKE :muster OR a.nachname LIKE :muster) ' +
      'ORDER BY b.id DESC', Parameter, IdSpalten, Ids);
    for i := 0 to Ids.Count - 1 do
    begin
      if not BelegLaden(StrToInt64Def(Ids[i], 0), Kopf, Positionen) then
        Continue;
      Summe := SummeRechnen(Positionen, Kopf.MwstRechnen);
      Zeile := IntToStr(Kopf.Id) + #9 + Kopf.Nummer + #9 +
        AdressKurzname(Kopf.AdresseId) + #9 + Kopf.Bezeichnung + #9 +
        CentAlsText(Summe.BruttoCent);
      Zeilen.Add(Zeile);
    end;
  finally
    IdSpalten.Free;
    Ids.Free;
    Parameter.Free;
  end;
end;

function MusterAus(const Suchtext: string): string;
begin
  Result := '%' + Trim(StringReplace(StringReplace(Suchtext, '%', '',
    [rfReplaceAll]), '_', '', [rfReplaceAll])) + '%';
end;

procedure ExplorerLesen(const Filter: TExplorerFilter; Spalten, Zeilen: TStrings);
var
  Parameter, Roh: TStringList;
  SQL, Monat: string;
  i: Integer;
begin
  Spalten.Clear;
  Zeilen.Clear;
  Spalten.Add('id');
  Spalten.Add('kuerzel');
  Spalten.Add('Modulart');
  Spalten.Add('Bezeichnung');
  Spalten.Add('Adressname');
  Spalten.Add('Nr');
  Spalten.Add('Projektname');
  Spalten.Add('Erfassungsdatum');
  Spalten.Add('Bearbeiter');
  Spalten.Add('Gruppierung');
  Spalten.Add('LetzteBearbeitung');
  if not Bereit then
    Exit;
  SQL :=
    'SELECT b.id, m.kuerzel, m.bezeichnung, COALESCE(b.bezeichnung, ''''), ' +
    'TRIM(COALESCE(a.firma, '''') || '' '' || COALESCE(a.nachname, '''')), ' +
    'b.nummer, COALESCE(p.bezeichnung, ''''), b.angelegt, ' +
    'TRIM(COALESCE(ba.vorname, '''') || '' '' || COALESCE(ba.nachname, '''')), ' +
    'COALESCE(b.gruppierung, ''''), b.geaendert ' +
    'FROM beleg b JOIN modulart m ON m.id = b.modulart_id ' +
    'LEFT JOIN adresse a ON a.id = b.adresse_id ' +
    'LEFT JOIN beleg p ON p.id = b.projekt_id ' +
    'LEFT JOIN adresse ba ON ba.id = b.bearbeiter_id WHERE 1 = 1';
  Parameter := TStringList.Create;
  Roh := TStringList.Create;
  try
    if Filter.Modulart <> '' then
    begin
      SQL := SQL + ' AND m.kuerzel = :art';
      Parameter.Values['art'] := Filter.Modulart;
    end;
    case Filter.ModulFilter of
      mfBezeichnung:
        begin
          SQL := SQL + ' AND b.bezeichnung LIKE :muster';
          Parameter.Values['muster'] := MusterAus(Filter.Suchtext);
        end;
      mfAdressname:
        begin
          SQL := SQL + ' AND b.adresse_id = :adresse';
          Parameter.Values['adresse'] := IntToStr(Filter.AdresseId);
        end;
      mfNummer:
        begin
          SQL := SQL + ' AND b.nummer LIKE :muster';
          Parameter.Values['muster'] := MusterAus(Filter.Suchtext);
        end;
      mfProjekt:
        begin
          SQL := SQL + ' AND b.projekt_id = :projekt';
          Parameter.Values['projekt'] := IntToStr(Filter.ProjektId);
        end;
    end;
    case Filter.Zeitraum of
      zrJahr:
        begin
          SQL := SQL + ' AND substr(b.angelegt, 1, 4) = :jahr';
          Parameter.Values['jahr'] := IntToStr(Filter.Jahr);
        end;
      zrMonat:
        begin
          Monat := IntToStr(Filter.Jahr) + '-';
          if Filter.Monat < 10 then
            Monat := Monat + '0';
          Monat := Monat + IntToStr(Filter.Monat);
          SQL := SQL + ' AND substr(b.angelegt, 1, 7) = :monat';
          Parameter.Values['monat'] := Monat;
        end;
      zrTag:
        begin
          SQL := SQL + ' AND substr(b.angelegt, 1, 10) = :tag';
          Parameter.Values['tag'] := Filter.Tag;
        end;
    end;
    case Filter.Sonstiges of
      soBearbeiter:
        begin
          SQL := SQL + ' AND b.bearbeiter_id = :bearbeiter';
          Parameter.Values['bearbeiter'] := IntToStr(Filter.BearbeiterId);
        end;
      soGruppe:
        begin
          SQL := SQL + ' AND b.gruppierung = :gruppe';
          Parameter.Values['gruppe'] := Filter.Gruppe;
        end;
    end;
    SQL := SQL + ' ORDER BY b.angelegt DESC, b.id DESC';
    PlanlosDB.AlleZeilen(SQL, Parameter, Spalten, Roh);
    Zeilen.Clear;
    Spalten.Clear;
    Spalten.Add('id');
    Spalten.Add('kuerzel');
    Spalten.Add('Modulart');
    Spalten.Add('Bezeichnung');
    Spalten.Add('Adressname');
    Spalten.Add('Nr');
    Spalten.Add('Projektname');
    Spalten.Add('Erfassungsdatum');
    Spalten.Add('Bearbeiter');
    Spalten.Add('Gruppierung');
    Spalten.Add('LetzteBearbeitung');
    for i := 0 to Roh.Count - 1 do
    begin
      Zeilen.Add(Roh[i]);
    end;
  finally
    Roh.Free;
    Parameter.Free;
  end;
end;

procedure ExplorerWerte(const Was, Modulart: string; Ziel: TStrings);
var
  Parameter, Spalten, Zeilen: TStringList;
  SQL: string;
begin
  Ziel.Clear;
  if not Bereit then
    Exit;
  if Was = 'bezeichnung' then
    SQL := 'SELECT DISTINCT b.bezeichnung FROM beleg b ' +
      'JOIN modulart m ON m.id = b.modulart_id ' +
      'WHERE b.bezeichnung IS NOT NULL AND b.bezeichnung <> '''' ' +
      'AND (:alle = ''1'' OR m.kuerzel = :art) ORDER BY b.bezeichnung'
  else if Was = 'gruppierung' then
    SQL := 'SELECT DISTINCT b.gruppierung FROM beleg b ' +
      'JOIN modulart m ON m.id = b.modulart_id ' +
      'WHERE b.gruppierung IS NOT NULL AND b.gruppierung <> '''' ' +
      'AND (:alle = ''1'' OR m.kuerzel = :art) ORDER BY b.gruppierung'
  else if Was = 'projekt' then
    SQL := 'SELECT b.id, b.bezeichnung FROM beleg b ' +
      'JOIN modulart m ON m.id = b.modulart_id ' +
      'WHERE m.kuerzel = ''projekt'' ORDER BY b.bezeichnung, b.id'
  else if Was = 'jahr' then
    SQL := 'SELECT DISTINCT substr(angelegt, 1, 4) FROM beleg ORDER BY 1'
  else
    Exit;
  Parameter := TStringList.Create;
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  try
    if Was = 'jahr' then
      PlanlosDB.AlleZeilen(SQL, nil, Spalten, Zeilen)
    else
    begin
      if Modulart = '' then
        Parameter.Values['alle'] := '1'
      else
        Parameter.Values['alle'] := '0';
      Parameter.Values['art'] := Modulart;
      PlanlosDB.AlleZeilen(SQL, Parameter, Spalten, Zeilen);
    end;
    Ziel.Assign(Zeilen);
  finally
    Zeilen.Free;
    Spalten.Free;
    Parameter.Free;
  end;
end;

end.
