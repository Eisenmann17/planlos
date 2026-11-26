unit umodulart;

{ Belegart laden und speichern. Dieselbe Zeile steuert das Belegfenster
  und die Liste im Hauptfenster.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils;

type
  TBelegartEinstellung = record
    Id: Int64;
    Kuerzel: string;
    Bezeichnung: string;
    Beschreibung: string;
    Nummernkreis: string;
    EmpfaengerMaske: string;
    BeschriftungEmpfaenger: string;
    Aktiv: Boolean;
    Sortierung: Integer;
    Links: Integer;
    Oben: Integer;
    Breite: Integer;
    Hoehe: Integer;
    Kopf: Boolean;
    Intern: Boolean;
    Positionen: Boolean;
    Summe: Boolean;
    Fuss: Boolean;
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
    ZeigeKopftext: Boolean;
    ZeigeFusstext: Boolean;
    ZeichenText: string;
    ArtikelUeberschrift: string;
    Neu: Boolean;
    Kopieren: Boolean;
    Aendern: Boolean;
    Loeschen: Boolean;
    Suchen: Boolean;
    Speichern: Boolean;
    Ausgabe: Boolean;
    Mwst: Boolean;
    MwstSatz: Integer;
    DruckvorlageId: Int64;
  end;

function BelegartEinstellungLaden(Id: Int64; out Art: TBelegartEinstellung): Boolean;
function BelegartEinstellungSpeichern(var Art: TBelegartEinstellung;
  out Fehler: string): Int64;
function BelegartEinstellungLoeschen(Id: Int64; out Fehler: string): Boolean;
function BelegartEinstellungKopieren(Id: Int64; out Fehler: string): Int64;

implementation

uses
  udatenbank;

function Bereit: Boolean;
begin
  Result := (PlanlosDB <> nil) and PlanlosDB.Verbunden;
end;

function Wahr(const Wert: string): Boolean;
begin
  Result := Wert = '1';
end;

function Bit(An: Boolean): string;
begin
  if An then
    Result := '1'
  else
    Result := '0';
end;

function KuerzelGueltig(const Wert: string): Boolean;
var
  i: Integer;
begin
  Result := Wert <> '';
  for i := 1 to Length(Wert) do
    if Pos(Wert[i], 'abcdefghijklmnopqrstuvwxyz0123456789_-') = 0 then
      Exit(False);
end;

procedure WerteSetzen(Art: TBelegartEinstellung; Parameter: TStrings);
begin
  Parameter.Values['kuerzel'] := Art.Kuerzel;
  Parameter.Values['name'] := Art.Bezeichnung;
  Parameter.Values['beschreibung'] := Art.Beschreibung;
  Parameter.Values['kreis'] := Art.Nummernkreis;
  Parameter.Values['maske'] := Art.EmpfaengerMaske;
  Parameter.Values['beschriftung'] := Art.BeschriftungEmpfaenger;
  Parameter.Values['aktiv'] := Bit(Art.Aktiv);
  Parameter.Values['sortierung'] := IntToStr(Art.Sortierung);
  Parameter.Values['links'] := IntToStr(Art.Links);
  Parameter.Values['oben'] := IntToStr(Art.Oben);
  Parameter.Values['breite'] := IntToStr(Art.Breite);
  Parameter.Values['hoehe'] := IntToStr(Art.Hoehe);
  Parameter.Values['kopf'] := Bit(Art.Kopf);
  Parameter.Values['intern'] := Bit(Art.Intern);
  Parameter.Values['positionen'] := Bit(Art.Positionen);
  Parameter.Values['summe'] := Bit(Art.Summe);
  Parameter.Values['fuss'] := Bit(Art.Fuss);
  Parameter.Values['kopf_an'] := Bit(Art.KopfAn);
  Parameter.Values['intern_an'] := Bit(Art.InternAn);
  Parameter.Values['summe_an'] := Bit(Art.SummeAn);
  Parameter.Values['fuss_an'] := Bit(Art.FussAn);
  Parameter.Values['z_projekt'] := Bit(Art.ZeigeProjekt);
  Parameter.Values['z_adresse'] := Bit(Art.ZeigeInternAdresse);
  Parameter.Values['z_bez'] := Bit(Art.ZeigeBezeichnung);
  Parameter.Values['z_gruppe'] := Bit(Art.ZeigeGruppierung);
  Parameter.Values['z_notiz'] := Bit(Art.ZeigeNotiz);
  Parameter.Values['z_kopfadr'] := Bit(Art.ZeigeKopfAdresse);
  Parameter.Values['z_nr'] := Bit(Art.ZeigeNr);
  Parameter.Values['z_datum'] := Bit(Art.ZeigeDatum);
  Parameter.Values['z_bearbeiter'] := Bit(Art.ZeigeBearbeiter);
  Parameter.Values['z_zeichen'] := Bit(Art.ZeigeZeichen);
  Parameter.Values['z_kopftext'] := Bit(Art.ZeigeKopftext);
  Parameter.Values['z_fusstext'] := Bit(Art.ZeigeFusstext);
  Parameter.Values['zeichen'] := Art.ZeichenText;
  Parameter.Values['ueberschrift'] := Art.ArtikelUeberschrift;
  Parameter.Values['neu'] := Bit(Art.Neu);
  Parameter.Values['kopieren'] := Bit(Art.Kopieren);
  Parameter.Values['aendern'] := Bit(Art.Aendern);
  Parameter.Values['loeschen'] := Bit(Art.Loeschen);
  Parameter.Values['suchen'] := Bit(Art.Suchen);
  Parameter.Values['speichern'] := Bit(Art.Speichern);
  Parameter.Values['ausgabe'] := Bit(Art.Ausgabe);
  Parameter.Values['mwst'] := Bit(Art.Mwst);
  Parameter.Values['satz'] := IntToStr(Art.MwstSatz);
  Parameter.Values['vorlage'] := IntToStr(Art.DruckvorlageId);
end;

function BelegartEinstellungLaden(Id: Int64; out Art: TBelegartEinstellung): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  Art := Default(TBelegartEinstellung);
  if not Bereit then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT id, kuerzel, bezeichnung, beschreibung, nummernkreis, empfaenger_maske, ' +
      'beschriftung_empfaenger, aktiv, sortierung, fenster_links, fenster_oben, ' +
      'fenster_breite, fenster_hoehe, bereich_kopf, intern_en, bereich_positionen, ' +
      'bereich_summe, bereich_fuss, fenster_kopf_an, fenster_intern_an, fenster_summe_an, ' +
      'fenster_fuss_an, intern_projekt, intern_adresse, intern_bezeichnung, ' +
      'intern_gruppierung, intern_notiz, kopf_adressfeld, kopf_nr, kopf_datum, ' +
      'kopf_bearbeiter, kopf_zeichen, kopftext_an, fusstext_an, kopf_zeichen_text, ' +
      'artikel_ueberschrift, datensatz_neu, datensatz_kopieren, datensatz_aendern, ' +
      'datensatz_loeschen, datensatz_suchen, datensatz_speichern, datensatz_ausgabe, ' +
      'mwst, mwst_satz, druckvorlage_id FROM modulart WHERE id = :id',
      Parameter, Zeile);
    if Zeile.Values['id'] = '' then
      Exit;
    Art.Id := Id;
    Art.Kuerzel := Zeile.Values['kuerzel'];
    Art.Bezeichnung := Zeile.Values['bezeichnung'];
    Art.Beschreibung := Zeile.Values['beschreibung'];
    Art.Nummernkreis := Zeile.Values['nummernkreis'];
    Art.EmpfaengerMaske := Zeile.Values['empfaenger_maske'];
    Art.BeschriftungEmpfaenger := Zeile.Values['beschriftung_empfaenger'];
    Art.Aktiv := Wahr(Zeile.Values['aktiv']);
    Art.Sortierung := StrToIntDef(Zeile.Values['sortierung'], 0);
    Art.Links := StrToIntDef(Zeile.Values['fenster_links'], 50);
    Art.Oben := StrToIntDef(Zeile.Values['fenster_oben'], 50);
    Art.Breite := StrToIntDef(Zeile.Values['fenster_breite'], 793);
    Art.Hoehe := StrToIntDef(Zeile.Values['fenster_hoehe'], 660);
    Art.Kopf := Wahr(Zeile.Values['bereich_kopf']);
    Art.Intern := Wahr(Zeile.Values['intern_en']);
    Art.Positionen := Wahr(Zeile.Values['bereich_positionen']);
    Art.Summe := Wahr(Zeile.Values['bereich_summe']);
    Art.Fuss := Wahr(Zeile.Values['bereich_fuss']);
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
    Art.ZeigeKopftext := Wahr(Zeile.Values['kopftext_an']);
    Art.ZeigeFusstext := Wahr(Zeile.Values['fusstext_an']);
    Art.ZeichenText := Zeile.Values['kopf_zeichen_text'];
    Art.ArtikelUeberschrift := Zeile.Values['artikel_ueberschrift'];
    Art.Neu := Wahr(Zeile.Values['datensatz_neu']);
    Art.Kopieren := Wahr(Zeile.Values['datensatz_kopieren']);
    Art.Aendern := Wahr(Zeile.Values['datensatz_aendern']);
    Art.Loeschen := Wahr(Zeile.Values['datensatz_loeschen']);
    Art.Suchen := Wahr(Zeile.Values['datensatz_suchen']);
    Art.Speichern := Wahr(Zeile.Values['datensatz_speichern']);
    Art.Ausgabe := Wahr(Zeile.Values['datensatz_ausgabe']);
    Art.Mwst := Wahr(Zeile.Values['mwst']);
    Art.MwstSatz := StrToIntDef(Zeile.Values['mwst_satz'], 19);
    Art.DruckvorlageId := StrToInt64Def(Zeile.Values['druckvorlage_id'], 0);
    Result := True;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function BelegartEinstellungSpeichern(var Art: TBelegartEinstellung;
  out Fehler: string): Int64;
var
  Parameter: TStringList;
  Doppelt: Integer;
begin
  Result := 0;
  Fehler := '';
  Art.Kuerzel := LowerCase(Trim(Art.Kuerzel));
  Art.Bezeichnung := Trim(Art.Bezeichnung);
  Art.Nummernkreis := Trim(Art.Nummernkreis);
  if not KuerzelGueltig(Art.Kuerzel) then
  begin
    Fehler := 'Das Kürzel darf nur Kleinbuchstaben, Ziffern, Minus und Unterstrich enthalten.';
    Exit;
  end;
  if Art.Bezeichnung = '' then
  begin
    Fehler := 'Die Belegart braucht eine Bezeichnung.';
    Exit;
  end;
  if Art.Nummernkreis = '' then
  begin
    Fehler := 'Die Belegart braucht einen Nummernkreis.';
    Exit;
  end;
  if not Bereit then
  begin
    Fehler := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  Parameter := TStringList.Create;
  try
    Parameter.Values['kuerzel'] := Art.Kuerzel;
    Parameter.Values['id'] := IntToStr(Art.Id);
    Doppelt := StrToIntDef(PlanlosDB.SkalarMit(
      'SELECT COUNT(*) FROM modulart WHERE kuerzel = :kuerzel AND id <> :id',
      Parameter), 0);
    Parameter.Clear;
    WerteSetzen(Art, Parameter);
    if Doppelt > 0 then
    begin
      Fehler := 'Dieses Kürzel gibt es schon.';
      Exit;
    end;
    if Art.Id = 0 then
    begin
      PlanlosDB.Ausfuehren(
        'INSERT INTO modulart (kuerzel, bezeichnung, beschreibung, nummernkreis, ' +
        'empfaenger_maske, beschriftung_empfaenger, aktiv, sortierung, fenster_links, ' +
        'fenster_oben, fenster_breite, fenster_hoehe, bereich_kopf, intern_en, ' +
        'bereich_positionen, bereich_summe, bereich_fuss, fenster_kopf_an, ' +
        'fenster_intern_an, fenster_summe_an, fenster_fuss_an, intern_projekt, ' +
        'intern_adresse, intern_bezeichnung, intern_gruppierung, intern_notiz, ' +
        'kopf_adressfeld, kopf_nr, kopf_datum, kopf_bearbeiter, kopf_zeichen, ' +
        'kopftext_an, fusstext_an, kopf_zeichen_text, artikel_ueberschrift, ' +
        'datensatz_neu, datensatz_kopieren, datensatz_aendern, datensatz_loeschen, ' +
        'datensatz_suchen, datensatz_speichern, datensatz_ausgabe, mwst, mwst_satz, ' +
        'druckvorlage_id, nummer_naechste) VALUES (:kuerzel, :name, :beschreibung, ' +
        ':kreis, :maske, :beschriftung, :aktiv, :sortierung, :links, :oben, :breite, ' +
        ':hoehe, :kopf, :intern, :positionen, :summe, :fuss, :kopf_an, :intern_an, ' +
        ':summe_an, :fuss_an, :z_projekt, :z_adresse, :z_bez, :z_gruppe, :z_notiz, ' +
        ':z_kopfadr, :z_nr, :z_datum, :z_bearbeiter, :z_zeichen, :z_kopftext, ' +
        ':z_fusstext, :zeichen, :ueberschrift, :neu, :kopieren, :aendern, :loeschen, ' +
        ':suchen, :speichern, :ausgabe, :mwst, :satz, NULLIF(:vorlage, ''0''), 1)',
        Parameter);
      Art.Id := StrToInt64Def(Trim(PlanlosDB.Skalar('SELECT last_insert_rowid()')), 0);
    end
    else
    begin
      Parameter.Values['id'] := IntToStr(Art.Id);
      if PlanlosDB.Ausfuehren(
      'UPDATE modulart SET kuerzel = :kuerzel, bezeichnung = :name, ' +
      'beschreibung = :beschreibung, nummernkreis = :kreis, empfaenger_maske = :maske, ' +
      'beschriftung_empfaenger = :beschriftung, aktiv = :aktiv, sortierung = :sortierung, ' +
      'fenster_links = :links, fenster_oben = :oben, fenster_breite = :breite, ' +
      'fenster_hoehe = :hoehe, bereich_kopf = :kopf, intern_en = :intern, ' +
      'bereich_positionen = :positionen, bereich_summe = :summe, bereich_fuss = :fuss, ' +
      'fenster_kopf_an = :kopf_an, fenster_intern_an = :intern_an, ' +
      'fenster_summe_an = :summe_an, fenster_fuss_an = :fuss_an, ' +
      'intern_projekt = :z_projekt, intern_adresse = :z_adresse, ' +
      'intern_bezeichnung = :z_bez, intern_gruppierung = :z_gruppe, ' +
      'intern_notiz = :z_notiz, kopf_adressfeld = :z_kopfadr, kopf_nr = :z_nr, ' +
      'kopf_datum = :z_datum, kopf_bearbeiter = :z_bearbeiter, kopf_zeichen = :z_zeichen, ' +
      'kopftext_an = :z_kopftext, fusstext_an = :z_fusstext, kopf_zeichen_text = :zeichen, ' +
      'artikel_ueberschrift = :ueberschrift, datensatz_neu = :neu, ' +
      'datensatz_kopieren = :kopieren, datensatz_aendern = :aendern, ' +
      'datensatz_loeschen = :loeschen, datensatz_suchen = :suchen, ' +
      'datensatz_speichern = :speichern, datensatz_ausgabe = :ausgabe, mwst = :mwst, ' +
      'mwst_satz = :satz, druckvorlage_id = NULLIF(:vorlage, ''0'') WHERE id = :id',
      Parameter) < 1 then
    begin
      Fehler := 'Die Belegart wurde nicht gespeichert.';
      Exit;
    end;
    end;
    Result := Art.Id;
    if Result = 0 then
      Fehler := 'Die Belegart wurde nicht gespeichert.';
  finally
    Parameter.Free;
  end;
end;

function BelegartEinstellungLoeschen(Id: Int64; out Fehler: string): Boolean;
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
    if StrToIntDef(PlanlosDB.SkalarMit(
      'SELECT COUNT(*) FROM beleg WHERE modulart_id = :id', Parameter), 0) > 0 then
    begin
      Fehler := 'Die Belegart wird noch von Belegen verwendet.';
      Exit;
    end;
    PlanlosDB.Ausfuehren(
      'DELETE FROM folgebeleg WHERE von_modulart_id = :id OR nach_modulart_id = :id',
      Parameter);
    PlanlosDB.Ausfuehren('DELETE FROM belegtaste WHERE modulart_id = :id', Parameter);
    PlanlosDB.Ausfuehren('DELETE FROM recht WHERE modulart_id = :id', Parameter);
    if PlanlosDB.Ausfuehren('DELETE FROM modulart WHERE id = :id', Parameter) < 1 then
      Fehler := 'Die Belegart konnte nicht gelöscht werden.'
    else
      Result := True;
  finally
    Parameter.Free;
  end;
end;

function BelegartEinstellungKopieren(Id: Int64; out Fehler: string): Int64;
var
  Art: TBelegartEinstellung;
begin
  Result := 0;
  if not BelegartEinstellungLaden(Id, Art) then
  begin
    Fehler := 'Die Belegart wurde nicht gefunden.';
    Exit;
  end;
  Art.Id := 0;
  Art.Kuerzel := Art.Kuerzel + '-kopie';
  Art.Bezeichnung := Art.Bezeichnung + ' Kopie';
  Result := BelegartEinstellungSpeichern(Art, Fehler);
end;

end.
