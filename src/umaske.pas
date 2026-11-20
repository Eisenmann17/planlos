unit umaske;

{ Eine Maske macht aus der Adresstabelle Kunde, Lieferant, Kontakt
  oder Mitarbeiter. Suchen und Eingeben benutzen dieselben Zeilen.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils;

type
  TMaskenInfo = record
    Id: Integer;
    Kuerzel: string;
    Bezeichnung: string;
    Tabelle: string;
    KategorieId: Integer;
    Links: Integer;
    Oben: Integer;
    Breite: Integer;
    Hoehe: Integer;
  end;

  TFeldInfo = record
    Spalte: string;
    Beschriftung: string;
    Reihenfolge: Integer;
    Sichtbar: Boolean;
    Pflicht: Boolean;
    InListe: Boolean;
    Breite: Integer;
    Links: Integer;
    Oben: Integer;
    Feldbreite: Integer;
    Feldhoehe: Integer;
    Feldart: string;
    Hintergrund: string;
  end;

  TFeldListe = array of TFeldInfo;

  TTastenInfo = record
    Ebene: Integer;
    Taste: Integer;
    Beschriftung: string;
    Aktion: string;
    Erlaubt: Boolean;
  end;

  TTastenListe = array of TTastenInfo;

function MaskeLaden(const Kuerzel: string; out Info: TMaskenInfo): Boolean;
function FelderLaden(const Kuerzel: string): TFeldListe;
function TastenLaden(const Kuerzel, Kontext: string): TTastenListe;
function FeldSichtbar(const Kuerzel, Spalte: string): Boolean;
function TasteFinden(const Tasten: TTastenListe; Ebene, Taste: Integer;
  out Aktion: string; out Erlaubt: Boolean): Boolean;
function MaskenRecht(const Rolle, Kuerzel, Aktion: string): Boolean;
function AdresseSpeichern(const Kuerzel: string; Id: Int64; Werte: TStrings;
  out Fehler: string): Int64;
procedure AdresseLesen(Id: Int64; Ziel: TStrings);
function AdresseLoeschen(const Kuerzel: string; Id: Int64): Boolean;
function AdresseKopieren(const Kuerzel: string; Id: Int64; out Fehler: string): Int64;
function TrefferZahl(const Kuerzel, Suchtext: string): Integer;
procedure TrefferLesen(const Kuerzel, Suchtext: string; Spalten, Zeilen: TStrings);
function KategorieName(Id: Integer): string;
procedure KategorienAuflisten(Ziel: TStrings);
function MaskenKuerzelZuKategorie(Id: Integer): string;

implementation

uses
  udatenbank;

const
  ErlaubteSpalten =
    ',firma,anrede,titel,vorname,nachname,strasse,plz,ort,land,' +
    'telefon,telefax,telefon_privat,telefon_andere,email,notiz,adressblock,' +
    'frei1,frei2,frei3,frei4,rabatt_prozent,';

function SpalteErlaubt(const Spalte: string): Boolean;
begin
  Result := Pos(',' + Spalte + ',', ErlaubteSpalten) > 0;
end;

function Wahr(const Wert: string): Boolean;
begin
  Result := Wert = '1';
end;

function DatenbankBereit: Boolean;
begin
  Result := (PlanlosDB <> nil) and PlanlosDB.Verbunden;
end;

procedure Teile(const Zeile: string; Ziel: TStrings);
var
  Rest, Stueck: string;
  PosTab: Integer;
begin
  Ziel.Clear;
  Rest := Zeile;
  repeat
    PosTab := Pos(#9, Rest);
    if PosTab = 0 then
    begin
      Ziel.Add(Rest);
      Break;
    end;
    Stueck := Copy(Rest, 1, PosTab - 1);
    Ziel.Add(Stueck);
    Delete(Rest, 1, PosTab);
  until False;
end;

function MaskeLaden(const Kuerzel: string; out Info: TMaskenInfo): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Info.Id := 0;
  Info.Kuerzel := Kuerzel;
  Info.Bezeichnung := '';
  Info.Tabelle := '';
  Info.KategorieId := 0;
  Info.Links := 0;
  Info.Oben := 0;
  Info.Breite := 720;
  Info.Hoehe := 480;
  Result := False;
  if not DatenbankBereit then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['kuerzel'] := Kuerzel;
    PlanlosDB.ErsteZeile(
      'SELECT id, kuerzel, bezeichnung, tabelle, kategorie_id, fenster_links, ' +
      'fenster_oben, fenster_breite, fenster_hoehe FROM maske ' +
      'WHERE kuerzel = :kuerzel', Parameter, Zeile);
    if Zeile.Values['id'] = '' then
      Exit;
    Info.Id := StrToIntDef(Zeile.Values['id'], 0);
    Info.Kuerzel := Zeile.Values['kuerzel'];
    Info.Bezeichnung := Zeile.Values['bezeichnung'];
    Info.Tabelle := Zeile.Values['tabelle'];
    Info.KategorieId := StrToIntDef(Zeile.Values['kategorie_id'], 0);
    Info.Links := StrToIntDef(Zeile.Values['fenster_links'], 0);
    Info.Oben := StrToIntDef(Zeile.Values['fenster_oben'], 0);
    Info.Breite := StrToIntDef(Zeile.Values['fenster_breite'], 720);
    Info.Hoehe := StrToIntDef(Zeile.Values['fenster_hoehe'], 480);
    Result := Info.Id > 0;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function FelderLaden(const Kuerzel: string): TFeldListe;
var
  Parameter, Spalten, Zeilen, TeileZeile: TStringList;
  i: Integer;
begin
  SetLength(Result, 0);
  if not DatenbankBereit then
    Exit;
  Parameter := TStringList.Create;
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  TeileZeile := TStringList.Create;
  try
    Parameter.Values['kuerzel'] := Kuerzel;
    PlanlosDB.AlleZeilen(
      'SELECT f.spalte, f.beschriftung, f.reihenfolge, f.sichtbar, f.pflicht, ' +
      'f.in_liste, f.breite, f.links, f.oben, f.feldbreite, f.feldhoehe, ' +
      'f.feldart, f.hintergrund FROM maskenfeld f ' +
      'JOIN maske m ON m.id = f.maske_id WHERE m.kuerzel = :kuerzel ' +
      'ORDER BY f.reihenfolge, f.id', Parameter, Spalten, Zeilen);
    SetLength(Result, Zeilen.Count);
    for i := 0 to Zeilen.Count - 1 do
    begin
      Teile(Zeilen[i], TeileZeile);
      if TeileZeile.Count < 7 then
        Continue;
      Result[i].Spalte := TeileZeile[0];
      Result[i].Beschriftung := TeileZeile[1];
      Result[i].Reihenfolge := StrToIntDef(TeileZeile[2], 0);
      Result[i].Sichtbar := Wahr(TeileZeile[3]);
      Result[i].Pflicht := Wahr(TeileZeile[4]);
      Result[i].InListe := Wahr(TeileZeile[5]);
      Result[i].Breite := StrToIntDef(TeileZeile[6], 120);
      if TeileZeile.Count > 7 then
        Result[i].Links := StrToIntDef(TeileZeile[7], 0);
      if TeileZeile.Count > 8 then
        Result[i].Oben := StrToIntDef(TeileZeile[8], 0);
      if TeileZeile.Count > 9 then
        Result[i].Feldbreite := StrToIntDef(TeileZeile[9], 0);
      if TeileZeile.Count > 10 then
        Result[i].Feldhoehe := StrToIntDef(TeileZeile[10], 0);
      if TeileZeile.Count > 11 then
        Result[i].Feldart := TeileZeile[11];
      if Result[i].Feldart = '' then
        Result[i].Feldart := 'zeile';
      if TeileZeile.Count > 12 then
        Result[i].Hintergrund := TeileZeile[12];
    end;
  finally
    TeileZeile.Free;
    Zeilen.Free;
    Spalten.Free;
    Parameter.Free;
  end;
end;

function TastenLaden(const Kuerzel, Kontext: string): TTastenListe;
var
  Parameter, Spalten, Zeilen, TeileZeile: TStringList;
  i: Integer;
begin
  SetLength(Result, 0);
  if not DatenbankBereit then
    Exit;
  Parameter := TStringList.Create;
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  TeileZeile := TStringList.Create;
  try
    Parameter.Values['kuerzel'] := Kuerzel;
    Parameter.Values['kontext'] := Kontext;
    PlanlosDB.AlleZeilen(
      'SELECT t.ebene, t.taste, t.beschriftung, t.aktion, t.erlaubt ' +
      'FROM tastenbelegung t JOIN maske m ON m.id = t.maske_id ' +
      'WHERE m.kuerzel = :kuerzel AND t.kontext = :kontext ' +
      'ORDER BY t.ebene, t.taste', Parameter, Spalten, Zeilen);
    SetLength(Result, Zeilen.Count);
    for i := 0 to Zeilen.Count - 1 do
    begin
      Teile(Zeilen[i], TeileZeile);
      if TeileZeile.Count < 5 then
        Continue;
      Result[i].Ebene := StrToIntDef(TeileZeile[0], 1);
      Result[i].Taste := StrToIntDef(TeileZeile[1], 0);
      Result[i].Beschriftung := TeileZeile[2];
      Result[i].Aktion := TeileZeile[3];
      Result[i].Erlaubt := Wahr(TeileZeile[4]);
    end;
  finally
    TeileZeile.Free;
    Zeilen.Free;
    Spalten.Free;
    Parameter.Free;
  end;
end;

function FeldSichtbar(const Kuerzel, Spalte: string): Boolean;
var
  Felder: TFeldListe;
  i: Integer;
begin
  Result := False;
  Felder := FelderLaden(Kuerzel);
  for i := 0 to High(Felder) do
    if (Felder[i].Spalte = Spalte) and Felder[i].Sichtbar then
      Exit(True);
end;

function TasteFinden(const Tasten: TTastenListe; Ebene, Taste: Integer;
  out Aktion: string; out Erlaubt: Boolean): Boolean;
var
  i: Integer;
begin
  Aktion := '';
  Erlaubt := False;
  Result := False;
  for i := 0 to High(Tasten) do
    if (Tasten[i].Ebene = Ebene) and (Tasten[i].Taste = Taste) then
    begin
      Aktion := Tasten[i].Aktion;
      Erlaubt := Tasten[i].Erlaubt;
      Exit(True);
    end;
end;

function MaskenRecht(const Rolle, Kuerzel, Aktion: string): Boolean;
var
  Parameter, Zeile: TStringList;
begin
  Result := False;
  if not DatenbankBereit then
    Exit;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['rolle'] := Rolle;
    Parameter.Values['kuerzel'] := Kuerzel;
    PlanlosDB.ErsteZeile(
      'SELECT mr.sehen, mr.neu, mr.aendern, mr.loeschen, mr.kopieren FROM maskenrecht mr ' +
      'JOIN rolle r ON r.id = mr.rolle_id JOIN maske m ON m.id = mr.maske_id ' +
      'WHERE r.bezeichnung = :rolle AND m.kuerzel = :kuerzel',
      Parameter, Zeile);
    if Zeile.Count = 0 then
      Exit;
    if Aktion = 'sehen' then
      Result := Wahr(Zeile.Values['sehen'])
    else if Aktion = 'neu' then
      Result := Wahr(Zeile.Values['neu'])
    else if Aktion = 'aendern' then
      Result := Wahr(Zeile.Values['aendern'])
    else if Aktion = 'loeschen' then
      Result := Wahr(Zeile.Values['loeschen'])
    else if Aktion = 'kopieren' then
      Result := Wahr(Zeile.Values['kopieren']);
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function ZahlInOrdnung(const Text: string; out Zahl: Double): Boolean;
var
  FS: TFormatSettings;
  Normal: string;
begin
  Normal := Trim(StringReplace(Text, ',', '.', [rfReplaceAll]));
  if Normal = '' then
  begin
    Zahl := 0;
    Exit(True);
  end;
  FS := DefaultFormatSettings;
  FS.DecimalSeparator := '.';
  Result := TryStrToFloat(Normal, Zahl, FS);
end;

function AdresseSpeichern(const Kuerzel: string; Id: Int64; Werte: TStrings;
  out Fehler: string): Int64;
var
  Info: TMaskenInfo;
  Felder: TFeldListe;
  Parameter: TStringList;
  i: Integer;
  Spalte, SQL, Jetzt: string;
  Zahl: Double;
  Erstes: Boolean;
begin
  Result := 0;
  Fehler := '';
  if not MaskeLaden(Kuerzel, Info) then
  begin
    Fehler := 'Die Maske ' + Kuerzel + ' gibt es nicht.';
    Exit;
  end;
  Felder := FelderLaden(Kuerzel);
  for i := 0 to High(Felder) do
    if Felder[i].Sichtbar and Felder[i].Pflicht and
       (Trim(Werte.Values[Felder[i].Spalte]) = '') then
    begin
      Fehler := Felder[i].Beschriftung + ' ist ein Pflichtfeld.';
      Exit;
    end;
  if Werte.IndexOfName('rabatt_prozent') >= 0 then
  begin
    if not ZahlInOrdnung(Werte.Values['rabatt_prozent'], Zahl) then
    begin
      Fehler := 'Der Rabatt muss eine Zahl sein.';
      Exit;
    end;
    Werte.Values['rabatt_prozent'] := StringReplace(
      FormatFloat('0.##', Zahl), ',', '.', [rfReplaceAll]);
  end;

  Jetzt := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', Now);
  Parameter := TStringList.Create;
  try
    if (Werte <> nil) and (Werte.IndexOfName('kategorie') >= 0) and
       (Trim(Werte.Values['kategorie']) <> '') then
      Parameter.Values['kategorie'] := Trim(Werte.Values['kategorie'])
    else
      Parameter.Values['kategorie'] := IntToStr(Info.KategorieId);
    Parameter.Values['jetzt'] := Jetzt;
    if Id > 0 then
      Parameter.Values['id'] := IntToStr(Id);
    for i := 0 to High(Felder) do
    begin
      Spalte := Felder[i].Spalte;
      if not SpalteErlaubt(Spalte) then
        Continue;
      if (Id = 0) or (Werte.IndexOfName(Spalte) >= 0) then
      begin
        if (Spalte = 'rabatt_prozent') and (Trim(Werte.Values[Spalte]) = '') then
          Parameter.Values['p_' + Spalte] := '0'
        else if Werte.IndexOfName(Spalte) >= 0 then
          Parameter.Values['p_' + Spalte] := Werte.Values[Spalte]
        else
          Parameter.Values['p_' + Spalte] := '';
      end;
    end;

    if Id = 0 then
    begin
      SQL := 'INSERT INTO adresse (kategorie_id, angelegt, geaendert';
      for i := 0 to Parameter.Count - 1 do
        if Copy(Parameter.Names[i], 1, 2) = 'p_' then
          SQL := SQL + ', ' + Copy(Parameter.Names[i], 3, 80);
      SQL := SQL + ') VALUES (:kategorie, :jetzt, :jetzt';
      for i := 0 to Parameter.Count - 1 do
        if Copy(Parameter.Names[i], 1, 2) = 'p_' then
          SQL := SQL + ', :' + Parameter.Names[i];
      SQL := SQL + ')';
      PlanlosDB.Ausfuehren(SQL, Parameter);
      Result := StrToInt64Def(Trim(PlanlosDB.Skalar('SELECT last_insert_rowid()')), 0);
      if Result = 0 then
        Fehler := 'Der Datensatz wurde nicht angelegt.';
    end
    else
    begin
      SQL := 'UPDATE adresse SET geaendert = :jetzt';
      Erstes := True;
      for i := 0 to Parameter.Count - 1 do
        if Copy(Parameter.Names[i], 1, 2) = 'p_' then
        begin
          Erstes := False;
          SQL := SQL + ', ' + Copy(Parameter.Names[i], 3, 80) + ' = :' +
            Parameter.Names[i];
        end;
      if Erstes then
        SQL := 'UPDATE adresse SET geaendert = :jetzt';
      if (Werte <> nil) and (Werte.IndexOfName('kategorie') >= 0) then
        SQL := SQL + ' WHERE id = :id'
      else
        SQL := SQL + ' WHERE id = :id AND kategorie_id = :kategorie';
      if PlanlosDB.Ausfuehren(SQL, Parameter) < 1 then
        Fehler := 'Der Datensatz gehört nicht zu dieser Maske.'
      else
        Result := Id;
    end;
  finally
    Parameter.Free;
  end;
end;

procedure AdresseLesen(Id: Int64; Ziel: TStrings);
var
  Parameter: TStringList;
begin
  Ziel.Clear;
  if not DatenbankBereit then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    PlanlosDB.ErsteZeile(
      'SELECT id, kategorie_id, firma, anrede, titel, vorname, nachname, strasse, ' +
      'plz, ort, land, telefon, telefax, telefon_privat, telefon_andere, email, ' +
      'notiz, adressblock, frei1, frei2, frei3, frei4, rabatt_prozent ' +
      'FROM adresse WHERE id = :id', Parameter, Ziel);
  finally
    Parameter.Free;
  end;
end;

function AdresseKopieren(const Kuerzel: string; Id: Int64; out Fehler: string): Int64;
var
  Werte: TStringList;
begin
  Fehler := '';
  Result := 0;
  Werte := TStringList.Create;
  try
    AdresseLesen(Id, Werte);
    if Werte.Count = 0 then
    begin
      Fehler := 'Der Datensatz wurde nicht gefunden.';
      Exit;
    end;
    Werte.Values['kategorie'] := Werte.Values['kategorie_id'];
    Result := AdresseSpeichern(Kuerzel, 0, Werte, Fehler);
  finally
    Werte.Free;
  end;
end;

function AdresseLoeschen(const Kuerzel: string; Id: Int64): Boolean;
var
  Info: TMaskenInfo;
  Parameter: TStringList;
begin
  Result := False;
  if not MaskeLaden(Kuerzel, Info) then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    Parameter.Values['kategorie'] := IntToStr(Info.KategorieId);
    Result := PlanlosDB.Ausfuehren(
      'DELETE FROM adresse WHERE id = :id AND kategorie_id = :kategorie',
      Parameter) > 0;
  finally
    Parameter.Free;
  end;
end;

function Suchmuster(const Suchtext: string): string;
var
  Text: string;
begin
  Text := StringReplace(Suchtext, '%', '', [rfReplaceAll]);
  Text := StringReplace(Text, '_', '', [rfReplaceAll]);
  Result := '%' + Trim(Text) + '%';
end;

procedure SuchParameter(const Info: TMaskenInfo; const Suchtext: string;
  Parameter: TStrings);
begin
  Parameter.Values['kategorie'] := IntToStr(Info.KategorieId);
  if Trim(Suchtext) = '' then
    Parameter.Values['leer'] := '1'
  else
    Parameter.Values['leer'] := '0';
  Parameter.Values['muster'] := Suchmuster(Suchtext);
end;

function TrefferZahl(const Kuerzel, Suchtext: string): Integer;
var
  Info: TMaskenInfo;
  Parameter: TStringList;
begin
  Result := 0;
  if not MaskeLaden(Kuerzel, Info) then
    Exit;
  Parameter := TStringList.Create;
  try
    SuchParameter(Info, Suchtext, Parameter);
    Result := StrToIntDef(Trim(PlanlosDB.SkalarMit(
      'SELECT COUNT(*) FROM adresse WHERE kategorie_id = :kategorie AND (' +
      ':leer = ''1'' OR firma LIKE :muster OR nachname LIKE :muster OR ' +
      'vorname LIKE :muster OR ort LIKE :muster OR email LIKE :muster)',
      Parameter)), 0);
  finally
    Parameter.Free;
  end;
end;

procedure TrefferLesen(const Kuerzel, Suchtext: string; Spalten, Zeilen: TStrings);
var
  Info: TMaskenInfo;
  Felder: TFeldListe;
  Parameter: TStringList;
  SQL, Liste: string;
  i: Integer;
begin
  Spalten.Clear;
  Zeilen.Clear;
  if not MaskeLaden(Kuerzel, Info) then
    Exit;
  Felder := FelderLaden(Kuerzel);
  Liste := '';
  Spalten.Add('id');
  for i := 0 to High(Felder) do
    if Felder[i].InListe and Felder[i].Sichtbar and SpalteErlaubt(Felder[i].Spalte) then
    begin
      Liste := Liste + ', ' + Felder[i].Spalte;
      Spalten.Add(Felder[i].Beschriftung);
    end;
  if Liste = '' then
  begin
    Liste := ', nachname, firma';
    Spalten.Add('Nachname');
    Spalten.Add('Firma');
  end;
  SQL := 'SELECT id' + Liste + ' FROM adresse WHERE kategorie_id = :kategorie AND (' +
    ':leer = ''1'' OR firma LIKE :muster OR nachname LIKE :muster OR ' +
    'vorname LIKE :muster OR ort LIKE :muster OR email LIKE :muster) ' +
    'ORDER BY nachname, vorname, firma, id';
  Parameter := TStringList.Create;
  try
    SuchParameter(Info, Suchtext, Parameter);
    PlanlosDB.AlleZeilen(SQL, Parameter, Spalten, Zeilen);
    { AlleZeilen überschreibt Spalten mit den Feldnamen. Die Beschriftungen
      stehen in der Maske; die Reihenfolge ist id plus Listenspalten. }
  finally
    Parameter.Free;
  end;
  Spalten.Clear;
  Spalten.Add('id');
  for i := 0 to High(Felder) do
    if Felder[i].InListe and Felder[i].Sichtbar and SpalteErlaubt(Felder[i].Spalte) then
      Spalten.Add(Felder[i].Beschriftung);
  if Spalten.Count = 1 then
  begin
    Spalten.Add('Nachname');
    Spalten.Add('Firma');
  end;
end;

function KategorieName(Id: Integer): string;
var
  Parameter: TStringList;
begin
  Result := '';
  if not DatenbankBereit or (Id = 0) then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    Result := PlanlosDB.SkalarMit(
      'SELECT bezeichnung FROM adresskategorie WHERE id = :id', Parameter);
  finally
    Parameter.Free;
  end;
end;

procedure KategorienAuflisten(Ziel: TStrings);
var
  Spalten, Zeilen: TStringList;
begin
  Ziel.Clear;
  if not DatenbankBereit then
    Exit;
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  try
    PlanlosDB.AlleZeilen(
      'SELECT id, bezeichnung FROM adresskategorie ORDER BY id',
      nil, Spalten, Zeilen);
    Ziel.Assign(Zeilen);
  finally
    Zeilen.Free;
    Spalten.Free;
  end;
end;

function MaskenKuerzelZuKategorie(Id: Integer): string;
var
  Parameter: TStringList;
begin
  Result := '';
  if not DatenbankBereit or (Id = 0) then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    Result := PlanlosDB.SkalarMit(
      'SELECT kuerzel FROM maske WHERE kategorie_id = :id ORDER BY id', Parameter);
  finally
    Parameter.Free;
  end;
end;

end.
