unit ubeleg;

{ Belege rechnen und speichern. Beträge in Cent, Mengen in Tausendsteln.
  Rundung kaufmännisch, halb aufrunden, ohne Gleitkomma.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, ustueckliste;

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
    Intern: Boolean;
    KopfAn: Boolean;
    InternAn: Boolean;
    SummeAn: Boolean;
    FussAn: Boolean;
    ZeigeProjekt: Boolean;
    ZeigeInternAdresse: Boolean;
    ZeigeBezeichnung: Boolean;
    ZeigeGruppierung: Boolean;
    ZeigeNotiz: Boolean;
    ZeigeKopfAdresse: Boolean;
    ZeigeNr: Boolean;
    ZeigeDatum: Boolean;
    ZeigeBearbeiter: Boolean;
    ZeigeZeichen: Boolean;
    ZeichenText: string;
    ZeigeKopftext: Boolean;
    ZeigeFusstext: Boolean;
    MwstSatz: Integer;
    Suchen: Boolean;
    Speichern: Boolean;
    Ausgabe: Boolean;
    ArtikelUeberschrift: string;
  end;

  TBelegPosition = record
    Id: Int64;
    PositionNr: Integer;
    ArtikelId: Int64;
    Gruppe: string;
    ArtikelName: string;
    Text: string;
    MengeMilli: Int64;
    Einheit: string;
    EkCent: Int64;
    EinheitEk: string;
    AufschlagBp: Integer;
    RabattBp: Integer;
    EinzelpreisCent: Int64;
    MwstSatz: Integer;
    Unterzeilen: TStueckZeilen;
  end;

  TBelegKopf = record
    Id: Int64;
    Modulart: string;
    Nummer: string;
    AdresseId: Int64;
    AdresseText: string;
    Bezeichnung: string;
    Kopftext: string;
    Fusstext: string;
    Notiz: string;
    BezugId: Int64;
    BezugNummer: string;
    MwstRechnen: Boolean;
    Gruppierung: string;
    ProjektStammId: Int64;
    KopfBausteinId: Int64;
    FussBausteinId: Int64;
    IhrZeichen: string;
    BearbeiterId: Int64;
    Erfasst: string;
    BriefkopfId: Int64;
    BriefkopfAn: Boolean;
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

  TInternSumme = record
    EkCent: Int64;
    VkCent: Int64;
    GewinnCent: Int64;
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

{ 50/50 und leer gelten nicht als gesetzte Fensterlage. }
function FensterlageBewusst(Links, Oben: Integer): Boolean;
function Kaufmaennisch(Zaehler, Nenner: Int64): Int64;
function CentAusText(const Text: string; out Cent: Int64): Boolean;
function MilliAusText(const Text: string; out Milli: Int64): Boolean;
function CentAlsText(Cent: Int64): string;
function MilliAlsText(Milli: Int64): string;
function PositionNetto(const Position: TBelegPosition): Int64;
function PositionEk(const Position: TBelegPosition): Int64;
function VkCent(EkCent: Int64; AufschlagBp, RabattBp: Integer): Int64;
function SummeRechnen(const Positionen: array of TBelegPosition;
  MwstRechnen: Boolean): TBelegSumme;
function InternRechnen(const Positionen: array of TBelegPosition): TInternSumme;
{ Zugeklappte Summen sind 23 hoch, nicht die Fußhöhe 17. }
function BereichHoehe(const Bereich: string; Offen: Boolean): Integer;
function KlappOffen(const Benutzer: string; ModulartId: Integer;
  const Bereich: string; Vorgabe: Boolean): Boolean;
procedure KlappMerken(const Benutzer: string; ModulartId: Integer;
  const Bereich: string; Offen: Boolean);
function AdressBlock(Id: Int64): string;

function BelegartLaden(const Kuerzel: string; out Art: TBelegart): Boolean;
function BelegTasten(const Kuerzel, Kontext: string): TBelegTasten;
function AdressKurzname(Id: Int64): string;
function PositionText(const Position: TBelegPosition): string;
function PositionLeer(const Position: TBelegPosition): Boolean;
procedure PositionenAufraeumen(var Liste: TPosListe);
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
    Sortierung: Integer;
  end;

function BelegKopieren(Id: Int64; out Fehler: string): Int64;
function BelegLoeschen(Id: Int64; out Fehler: string): Boolean;

{ Zeilen: id, kuerzel, Modulart, Bezeichnung, Adressname, Nr, Projektname,
  Erfassungsdatum, Bearbeiter, Gruppierung, LetzteBearbeitung. }
procedure ExplorerLesen(const Filter: TExplorerFilter; Spalten, Zeilen: TStrings);
procedure ExplorerWerte(const Was, Modulart: string; Ziel: TStrings);

implementation

uses
  udatenbank, ubenutzer;

function FensterlageBewusst(Links, Oben: Integer): Boolean;
begin
  Result := (Links > 0) and (Oben > 0) and not ((Links = 50) and (Oben = 50));
end;

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

function Bereit: Boolean; forward;

function PositionEk(const Position: TBelegPosition): Int64;
begin
  Result := Kaufmaennisch(Position.MengeMilli * Position.EkCent, 1000);
end;

function VkCent(EkCent: Int64; AufschlagBp, RabattBp: Integer): Int64;
var
  MitAufschlag: Int64;
begin
  MitAufschlag := Kaufmaennisch(EkCent * (10000 + AufschlagBp), 10000);
  Result := Kaufmaennisch(MitAufschlag * (10000 - RabattBp), 10000);
end;

function InternRechnen(const Positionen: array of TBelegPosition): TInternSumme;
var
  i: Integer;
begin
  Result.EkCent := 0;
  Result.VkCent := 0;
  Result.GewinnCent := 0;
  for i := 0 to High(Positionen) do
  begin
    Result.EkCent := Result.EkCent + PositionEk(Positionen[i]);
    Result.VkCent := Result.VkCent + PositionNetto(Positionen[i]);
  end;
  Result.GewinnCent := Result.VkCent - Result.EkCent;
end;

function BereichHoehe(const Bereich: string; Offen: Boolean): Integer;
begin
  if Bereich = 'kopf' then
  begin
    if Offen then
      Result := 182
    else
      Result := 17;
  end
  else if Bereich = 'intern' then
  begin
    if Offen then
      Result := 108
    else
      Result := 17;
  end
  else if Bereich = 'fuss' then
  begin
    if Offen then
      Result := 89
    else
      Result := 17;
  end
  else if Bereich = 'summe' then
  begin
    if Offen then
      Result := 94
    else
      Result := 23;
  end
  else
    Result := 17;
end;

function KlappOffen(const Benutzer: string; ModulartId: Integer;
  const Bereich: string; Vorgabe: Boolean): Boolean;
var
  Parameter: TStringList;
  Wert: string;
begin
  Result := Vorgabe;
  if not Bereit then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['benutzer'] := Benutzer;
    Parameter.Values['art'] := IntToStr(ModulartId);
    Parameter.Values['bereich'] := Bereich;
    Wert := Trim(PlanlosDB.SkalarMit(
      'SELECT offen FROM klappzustand WHERE benutzer = :benutzer AND ' +
      'modulart_id = :art AND bereich = :bereich', Parameter));
    if Wert <> '' then
      Result := Wert = '1';
  finally
    Parameter.Free;
  end;
end;

procedure KlappMerken(const Benutzer: string; ModulartId: Integer;
  const Bereich: string; Offen: Boolean);
var
  Parameter: TStringList;
  OffenZahl: Integer;
begin
  if not Bereit then
    Exit;
  if Offen then
    OffenZahl := 1
  else
    OffenZahl := 0;
  Parameter := TStringList.Create;
  try
    Parameter.Values['benutzer'] := Benutzer;
    Parameter.Values['art'] := IntToStr(ModulartId);
    Parameter.Values['bereich'] := Bereich;
    PlanlosDB.Ausfuehren(
      'DELETE FROM klappzustand WHERE benutzer = :benutzer AND modulart_id = :art ' +
      'AND bereich = :bereich', Parameter);
    Parameter.Values['offen'] := IntToStr(OffenZahl);
    PlanlosDB.Ausfuehren(
      'INSERT INTO klappzustand (benutzer, modulart_id, bereich, offen) ' +
      'VALUES (:benutzer, :art, :bereich, :offen)', Parameter);
  finally
    Parameter.Free;
  end;
end;

function AdressBlock(Id: Int64): string;
var
  Parameter, Zeile: TStringList;
  Name: string;

  procedure ZeileDazu(const Text: string);
  begin
    if Trim(Text) = '' then
      Exit;
    if Result <> '' then
      Result := Result + LineEnding;
    Result := Result + Trim(Text);
  end;

begin
  Result := '';
  if (Id = 0) or not Bereit then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT firma, anrede, vorname, nachname, strasse, plz, ort FROM adresse ' +
      'WHERE id = :id', Parameter, Zeile);
    ZeileDazu(Zeile.Values['firma']);
    Name := Trim(Zeile.Values['anrede'] + ' ' + Zeile.Values['vorname'] + ' ' +
      Zeile.Values['nachname']);
    ZeileDazu(Name);
    ZeileDazu(Zeile.Values['strasse']);
    ZeileDazu(Trim(Zeile.Values['plz'] + ' ' + Zeile.Values['ort']));
  finally
    Zeile.Free;
    Parameter.Free;
  end;
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
  Art.Links := 50;
  Art.Oben := 50;
  Art.Breite := 793;
  Art.Hoehe := 660;
  Art.Intern := True;
  Art.KopfAn := True;
  Art.InternAn := True;
  Art.SummeAn := True;
  Art.FussAn := True;
  Art.ZeigeProjekt := True;
  Art.ZeigeInternAdresse := True;
  Art.ZeigeBezeichnung := True;
  Art.ZeigeGruppierung := True;
  Art.ZeigeNotiz := True;
  Art.ZeigeKopfAdresse := True;
  Art.ZeigeNr := True;
  Art.ZeigeDatum := True;
  Art.ZeigeBearbeiter := True;
  Art.ZeigeZeichen := True;
  Art.ZeichenText := 'Ihr Zeichen:';
  Art.ZeigeKopftext := True;
  Art.ZeigeFusstext := True;
  Art.MwstSatz := 19;
  Art.Suchen := True;
  Art.Speichern := True;
  Art.Ausgabe := True;
  Art.ArtikelUeberschrift := '';
  if not Bereit then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['kuerzel'] := Kuerzel;
    PlanlosDB.ErsteZeile(
      'SELECT id, kuerzel, bezeichnung, nummernkreis, empfaenger_maske, ' +
      'beschriftung_empfaenger, bereich_kopf, bereich_positionen, bereich_summe, ' +
      'bereich_fuss, mwst, fenster_links, fenster_oben, fenster_breite, fenster_hoehe, ' +
      'intern_en, fenster_kopf_an, fenster_intern_an, fenster_summe_an, fenster_fuss_an, ' +
      'intern_projekt, intern_adresse, intern_bezeichnung, intern_gruppierung, intern_notiz, ' +
      'kopf_adressfeld, kopf_nr, kopf_datum, kopf_bearbeiter, kopf_zeichen, kopf_zeichen_text, ' +
      'kopftext_an, fusstext_an, mwst_satz, datensatz_suchen, datensatz_speichern, ' +
      'datensatz_ausgabe, artikel_ueberschrift ' +
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
    Art.Breite := StrToIntDef(Zeile.Values['fenster_breite'], 793);
    Art.Hoehe := StrToIntDef(Zeile.Values['fenster_hoehe'], 660);
    Art.Intern := Wahr(Zeile.Values['intern_en']);
    Art.KopfAn := Wahr(Zeile.Values['fenster_kopf_an']);
    Art.InternAn := Wahr(Zeile.Values['fenster_intern_an']);
    Art.SummeAn := Wahr(Zeile.Values['fenster_summe_an']);
    Art.FussAn := Wahr(Zeile.Values['fenster_fuss_an']);
    Art.ZeigeProjekt := Wahr(Zeile.Values['intern_projekt']);
    Art.ZeigeInternAdresse := Wahr(Zeile.Values['intern_adresse']);
    Art.ZeigeBezeichnung := Wahr(Zeile.Values['intern_bezeichnung']);
    Art.ZeigeGruppierung := Wahr(Zeile.Values['intern_gruppierung']);
    Art.ZeigeNotiz := Wahr(Zeile.Values['intern_notiz']);
    Art.ZeigeKopfAdresse := Wahr(Zeile.Values['kopf_adressfeld']);
    Art.ZeigeNr := Wahr(Zeile.Values['kopf_nr']);
    Art.ZeigeDatum := Wahr(Zeile.Values['kopf_datum']);
    Art.ZeigeBearbeiter := Wahr(Zeile.Values['kopf_bearbeiter']);
    Art.ZeigeZeichen := Wahr(Zeile.Values['kopf_zeichen']);
    if Zeile.Values['kopf_zeichen_text'] <> '' then
      Art.ZeichenText := Zeile.Values['kopf_zeichen_text'];
    Art.ZeigeKopftext := Wahr(Zeile.Values['kopftext_an']);
    Art.ZeigeFusstext := Wahr(Zeile.Values['fusstext_an']);
    Art.MwstSatz := StrToIntDef(Zeile.Values['mwst_satz'], 19);
    Art.Suchen := Wahr(Zeile.Values['datensatz_suchen']);
    Art.Speichern := Wahr(Zeile.Values['datensatz_speichern']);
    Art.Ausgabe := Wahr(Zeile.Values['datensatz_ausgabe']);
    Art.ArtikelUeberschrift := Zeile.Values['artikel_ueberschrift'];
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

function PositionText(const Position: TBelegPosition): string;
begin
  Result := Trim(Position.Text);
  if Result = '' then
    Result := Trim(Position.ArtikelName);
end;

function PositionLeer(const Position: TBelegPosition): Boolean;
begin
  Result := (PositionText(Position) = '') and (Trim(Position.Gruppe) = '') and
    (Position.ArtikelId = 0) and (Position.EkCent = 0) and
    (Position.EinzelpreisCent = 0);
end;

procedure PositionenAufraeumen(var Liste: TPosListe);
var
  i, Anzahl: Integer;
begin
  Anzahl := 0;
  for i := 0 to High(Liste) do
  begin
    if PositionLeer(Liste[i]) then
      Continue;
    Liste[i].Text := PositionText(Liste[i]);
    if Anzahl <> i then
      Liste[Anzahl] := Liste[i];
    Inc(Anzahl);
  end;
  SetLength(Liste, Anzahl);
end;

function BelegSpeichern(var Kopf: TBelegKopf; const Positionen: array of TBelegPosition;
  out Fehler: string): Int64;
var
  Art: TBelegart;
  Parameter: TStringList;
  i, Nr: Integer;
  Jetzt, ArtikelSql, Text: string;
  PosId: Int64;
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
    if PositionLeer(Positionen[i]) then
      Continue;
    if PositionText(Positionen[i]) = '' then
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
  if Kopf.Erfasst = '' then
    Kopf.Erfasst := Copy(Jetzt, 1, 10);
  Parameter := TStringList.Create;
  try
    Parameter.Values['art'] := IntToStr(Art.Id);
    Parameter.Values['adresse'] := IntToStr(Kopf.AdresseId);
    Parameter.Values['adresse_text'] := Kopf.AdresseText;
    Parameter.Values['bezeichnung'] := Kopf.Bezeichnung;
    Parameter.Values['kopf'] := Kopf.Kopftext;
    Parameter.Values['fuss'] := Kopf.Fusstext;
    Parameter.Values['notiz'] := Kopf.Notiz;
    Parameter.Values['gruppe'] := Kopf.Gruppierung;
    Parameter.Values['zeichen'] := Kopf.IhrZeichen;
    if Kopf.BriefkopfId > 0 then
      Parameter.Values['brief'] := IntToStr(Kopf.BriefkopfId)
    else
      Parameter.Values['brief'] := '0';
    if Kopf.BriefkopfAn then
      Parameter.Values['briefan'] := '1'
    else
      Parameter.Values['briefan'] := '0';
    Parameter.Values['projekt'] := IntToStr(Kopf.ProjektStammId);
    Parameter.Values['kopf_id'] := IntToStr(Kopf.KopfBausteinId);
    Parameter.Values['fuss_id'] := IntToStr(Kopf.FussBausteinId);
    Parameter.Values['jetzt'] := Jetzt;
    if Kopf.BearbeiterId > 0 then
      Parameter.Values['bearbeiter'] := IntToStr(Kopf.BearbeiterId)
    else if AngemeldeterMitarbeiter > 0 then
      Parameter.Values['bearbeiter'] := IntToStr(AngemeldeterMitarbeiter)
    else
      Parameter.Values['bearbeiter'] := '';
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
      Parameter.Values['erfasst'] := Kopf.Erfasst + Copy(Jetzt, 11, 20);
      PlanlosDB.Ausfuehren(
        'INSERT INTO beleg (modulart_id, nummer, adresse_id, bezeichnung, kopftext, ' +
        'fusstext, notiz, bezug_beleg_id, mwst_rechnen, bearbeiter_id, gruppierung, ' +
        'projekt_stamm_id, kopf_baustein_id, fuss_baustein_id, adresse_text, ihr_zeichen, ' +
        'briefkopf_id, briefkopf_an, angelegt, geaendert) VALUES (:art, :nummer, ' +
        'NULLIF(:adresse, ''0''), :bezeichnung, :kopf, :fuss, :notiz, NULLIF(:bezug, ''''), ' +
        ':mwst, NULLIF(:bearbeiter, ''''), :gruppe, NULLIF(:projekt, ''0''), ' +
        'NULLIF(:kopf_id, ''0''), NULLIF(:fuss_id, ''0''), :adresse_text, :zeichen, ' +
        'NULLIF(:brief, ''0''), :briefan, :erfasst, :jetzt)', Parameter);
      Kopf.Id := StrToInt64Def(Trim(PlanlosDB.Skalar('SELECT last_insert_rowid()')), 0);
    end
    else
    begin
      Parameter.Values['id'] := IntToStr(Kopf.Id);
      if PlanlosDB.Ausfuehren(
        'UPDATE beleg SET adresse_id = NULLIF(:adresse, ''0''), bezeichnung = :bezeichnung, ' +
        'kopftext = :kopf, fusstext = :fuss, notiz = :notiz, geaendert = :jetzt, ' +
        'gruppierung = :gruppe, adresse_text = :adresse_text, ihr_zeichen = :zeichen, ' +
        'bearbeiter_id = NULLIF(:bearbeiter, ''''), projekt_stamm_id = NULLIF(:projekt, ''0''), ' +
        'kopf_baustein_id = NULLIF(:kopf_id, ''0''), fuss_baustein_id = NULLIF(:fuss_id, ''0''), ' +
        'briefkopf_id = NULLIF(:brief, ''0''), briefkopf_an = :briefan ' +
        'WHERE id = :id AND modulart_id = :art', Parameter) < 1 then
      begin
        Fehler := 'Der Beleg gehört nicht zu dieser Belegart.';
        Exit;
      end;
    end;

    Parameter.Clear;
    Parameter.Values['beleg'] := IntToStr(Kopf.Id);
    PlanlosDB.Ausfuehren(
      'DELETE FROM belegstueckliste WHERE belegposition_id IN ' +
      '(SELECT id FROM belegposition WHERE beleg_id = :beleg)', Parameter);
    PlanlosDB.Ausfuehren('DELETE FROM belegposition WHERE beleg_id = :beleg', Parameter);
    Nr := 0;
    for i := 0 to High(Positionen) do
    begin
      if PositionLeer(Positionen[i]) then
        Continue;
      Text := PositionText(Positionen[i]);
      Inc(Nr);
      Parameter.Clear;
      Parameter.Values['beleg'] := IntToStr(Kopf.Id);
      Parameter.Values['nr'] := IntToStr(Nr);
      Parameter.Values['text'] := Text;
      Parameter.Values['menge'] := IntToStr(Positionen[i].MengeMilli);
      Parameter.Values['einheit'] := Positionen[i].Einheit;
      Parameter.Values['preis'] := IntToStr(Positionen[i].EinzelpreisCent);
      Parameter.Values['satz'] := IntToStr(Positionen[i].MwstSatz);
      Parameter.Values['gruppe'] := Positionen[i].Gruppe;
      Parameter.Values['artikelname'] := Positionen[i].ArtikelName;
      Parameter.Values['ek'] := IntToStr(Positionen[i].EkCent);
      Parameter.Values['eek'] := Positionen[i].EinheitEk;
      Parameter.Values['auf'] := IntToStr(Positionen[i].AufschlagBp);
      Parameter.Values['rabatt'] := IntToStr(Positionen[i].RabattBp);
      if Positionen[i].ArtikelId > 0 then
        ArtikelSql := IntToStr(Positionen[i].ArtikelId)
      else
        ArtikelSql := 'NULL';
      PlanlosDB.Ausfuehren(
        'INSERT INTO belegposition (beleg_id, position_nr, artikel_id, positionstext, ' +
        'menge_milli, einheit, einzelpreis_cent, mwst_satz, gruppe, artikelname, ' +
        'ek_cent, einheit_ek, aufschlag_bp, rabatt_bp) VALUES (:beleg, :nr, ' +
        ArtikelSql + ', :text, :menge, :einheit, :preis, :satz, :gruppe, :artikelname, ' +
        ':ek, :eek, :auf, :rabatt)', Parameter);
      PosId := StrToInt64Def(PlanlosDB.Skalar('SELECT last_insert_rowid()'), 0);
      if (PosId > 0) and (Length(Positionen[i].Unterzeilen) > 0) then
        UnterzeilenSpeichern(PosId, Positionen[i].Unterzeilen);
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
  Kopf.AdresseText := '';
  Kopf.Gruppierung := '';
  Kopf.ProjektStammId := 0;
  Kopf.KopfBausteinId := 0;
  Kopf.FussBausteinId := 0;
  Kopf.IhrZeichen := '';
  Kopf.BearbeiterId := 0;
  Kopf.Erfasst := '';
  Kopf.BriefkopfId := 0;
  Kopf.BriefkopfAn := True;
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
      'b.mwst_rechnen, v.nummer AS bezugnummer, b.adresse_text, b.gruppierung, ' +
      'b.projekt_stamm_id, b.kopf_baustein_id, b.fuss_baustein_id, b.ihr_zeichen, ' +
      'b.bearbeiter_id, b.angelegt, b.briefkopf_id, b.briefkopf_an ' +
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
    Kopf.AdresseText := Zeile.Values['adresse_text'];
    Kopf.Gruppierung := Zeile.Values['gruppierung'];
    Kopf.ProjektStammId := StrToInt64Def(Zeile.Values['projekt_stamm_id'], 0);
    Kopf.KopfBausteinId := StrToInt64Def(Zeile.Values['kopf_baustein_id'], 0);
    Kopf.FussBausteinId := StrToInt64Def(Zeile.Values['fuss_baustein_id'], 0);
    Kopf.IhrZeichen := Zeile.Values['ihr_zeichen'];
    Kopf.BearbeiterId := StrToInt64Def(Zeile.Values['bearbeiter_id'], 0);
    Kopf.Erfasst := Copy(Zeile.Values['angelegt'], 1, 10);
    Kopf.BriefkopfId := StrToInt64Def(Zeile.Values['briefkopf_id'], 0);
    Kopf.BriefkopfAn := Zeile.Values['briefkopf_an'] <> '0';
    PlanlosDB.AlleZeilen(
      'SELECT id, position_nr, artikel_id, positionstext, menge_milli, einheit, ' +
      'einzelpreis_cent, mwst_satz, gruppe, artikelname, ek_cent, einheit_ek, ' +
      'aufschlag_bp, rabatt_bp FROM belegposition WHERE beleg_id = :id ' +
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
      if Teile.Count > 8 then
        Positionen[i].Gruppe := Teile[8];
      if Teile.Count > 9 then
        Positionen[i].ArtikelName := Teile[9];
      if Teile.Count > 10 then
        Positionen[i].EkCent := StrToInt64Def(Teile[10], 0);
      if Teile.Count > 11 then
        Positionen[i].EinheitEk := Teile[11];
      if Teile.Count > 12 then
        Positionen[i].AufschlagBp := StrToIntDef(Teile[12], 0);
      if Teile.Count > 13 then
        Positionen[i].RabattBp := StrToIntDef(Teile[13], 0);
      if Positionen[i].Id > 0 then
        UnterzeilenLaden(Positionen[i].Id, Positionen[i].Unterzeilen);
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

function BelegKopieren(Id: Int64; out Fehler: string): Int64;
var
  Kopf: TBelegKopf;
  Positionen: TPosListe;
begin
  Fehler := '';
  Result := 0;
  if not BelegLaden(Id, Kopf, Positionen) then
  begin
    Fehler := 'Der Beleg wurde nicht gefunden.';
    Exit;
  end;
  Kopf.Id := 0;
  Kopf.Nummer := '';
  Kopf.BezugId := 0;
  Kopf.BezugNummer := '';
  Result := BelegSpeichern(Kopf, Positionen, Fehler);
end;

function BelegLoeschen(Id: Int64; out Fehler: string): Boolean;
var
  Parameter: TStringList;
begin
  Fehler := '';
  Result := False;
  if not Bereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.Ausfuehren(
      'UPDATE beleg SET bezug_beleg_id = NULL WHERE bezug_beleg_id = :id', Parameter);
    PlanlosDB.Ausfuehren(
      'UPDATE beleg SET projekt_id = NULL WHERE projekt_id = :id', Parameter);
    PlanlosDB.Ausfuehren(
      'DELETE FROM belegstueckliste WHERE belegposition_id IN ' +
      '(SELECT id FROM belegposition WHERE beleg_id = :id)', Parameter);
    PlanlosDB.Ausfuehren('DELETE FROM belegposition WHERE beleg_id = :id', Parameter);
    if PlanlosDB.Ausfuehren('DELETE FROM beleg WHERE id = :id', Parameter) < 1 then
      Fehler := 'Der Beleg konnte nicht gelöscht werden.'
    else
      Result := True;
  finally
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
    case Filter.Sortierung of
      1: SQL := SQL + ' ORDER BY b.angelegt, b.id';
      2: SQL := SQL + ' ORDER BY b.nummer, b.id';
      3: SQL := SQL + ' ORDER BY b.bezeichnung, b.id';
    else
      SQL := SQL + ' ORDER BY b.angelegt DESC, b.id DESC';
    end;
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
