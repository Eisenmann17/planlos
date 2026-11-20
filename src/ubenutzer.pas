unit ubenutzer;

{ Anwender, Passwort und die angemeldete Rolle.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE.

  Das Passwort liegt nur als SHA-256 über Salz und Passwort.
  Die Rolle der Sitzung entscheidet, welche Taste etwas tun darf. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils;

type
  TSitzung = record
    Aktiv: Boolean;
    Id: Int64;
    Name: string;
    RolleId: Integer;
    Rolle: string;
    AdresseId: Int64;
  end;

function Sha256Hex(const Daten: RawByteString): string;
function Sitzung: TSitzung;
procedure SitzungSetzen(const Neu: TSitzung);
function Anmelden(const Name, Passwort: string; out Meldung: string): Boolean;
function AngemeldeterMitarbeiter: Int64;
{ Art ist 'maske' oder 'beleg'. Aktion: sehen, neu, aendern, loeschen, drucken, kopieren. }
function AktionZulaessig(const Art, Kuerzel, Aktion: string; out Meldung: string): Boolean;
procedure BenutzerSicherstellen;

implementation

uses
  udatenbank, umaske;

function ArtSchalter(const Art, Kuerzel, Aktion: string): Boolean; forward;

type
  TBlock = array[0..63] of Byte;
  THash = array[0..7] of Cardinal;

const
  K: array[0..63] of Cardinal = (
    $428a2f98, $71374491, $b5c0fbcf, $e9b5dba5, $3956c25b, $59f111f1, $923f82a4, $ab1c5ed5,
    $d807aa98, $12835b01, $243185be, $550c7dc3, $72be5d74, $80deb1fe, $9bdc06a7, $c19bf174,
    $e49b69c1, $efbe4786, $0fc19dc6, $240ca1cc, $2de92c6f, $4a7484aa, $5cb0a9dc, $76f988da,
    $983e5152, $a831c66d, $b00327c8, $bf597fc7, $c6e00bf3, $d5a79147, $06ca6351, $14292967,
    $27b70a85, $2e1b2138, $4d2c6dfc, $53380d13, $650a7354, $766a0abb, $81c2c92e, $92722c85,
    $a2bfe8a1, $a81a664b, $c24b8b70, $c76c51a3, $d192e819, $d6990624, $f40e3585, $106aa070,
    $19a4c116, $1e376c08, $2748774c, $34b0bcb5, $391c0cb3, $4ed8aa4a, $5b9cca4f, $682e6ff3,
    $748f82ee, $78a5636f, $84c87814, $8cc70208, $90befffa, $a4506ceb, $bef9a3f7, $c67178f2
  );

var
  GSitzung: TSitzung;

function Rot(X: Cardinal; N: Integer): Cardinal;
begin
  Result := (X shr N) or (X shl (32 - N));
end;

procedure BlockRechnen(const Block: TBlock; var H: THash);
var
  W: array[0..63] of Cardinal;
  i: Integer;
  A, B, C, D, E, F, G, T, T1, T2, S0, S1, Ch, Maj: Cardinal;
begin
  for i := 0 to 15 do
    W[i] := (Cardinal(Block[i * 4]) shl 24) or (Cardinal(Block[i * 4 + 1]) shl 16) or
      (Cardinal(Block[i * 4 + 2]) shl 8) or Cardinal(Block[i * 4 + 3]);
  for i := 16 to 63 do
  begin
    S0 := Rot(W[i - 15], 7) xor Rot(W[i - 15], 18) xor (W[i - 15] shr 3);
    S1 := Rot(W[i - 2], 17) xor Rot(W[i - 2], 19) xor (W[i - 2] shr 10);
    W[i] := W[i - 16] + S0 + W[i - 7] + S1;
  end;
  A := H[0];
  B := H[1];
  C := H[2];
  D := H[3];
  E := H[4];
  F := H[5];
  G := H[6];
  T := H[7];
  for i := 0 to 63 do
  begin
    S1 := Rot(E, 6) xor Rot(E, 11) xor Rot(E, 25);
    Ch := (E and F) xor ((not E) and G);
    T1 := T + S1 + Ch + K[i] + W[i];
    S0 := Rot(A, 2) xor Rot(A, 13) xor Rot(A, 22);
    Maj := (A and B) xor (A and C) xor (B and C);
    T2 := S0 + Maj;
    T := G;
    G := F;
    F := E;
    E := D + T1;
    D := C;
    C := B;
    B := A;
    A := T1 + T2;
  end;
  H[0] := H[0] + A;
  H[1] := H[1] + B;
  H[2] := H[2] + C;
  H[3] := H[3] + D;
  H[4] := H[4] + E;
  H[5] := H[5] + F;
  H[6] := H[6] + G;
  H[7] := H[7] + T;
end;

function Sha256Hex(const Daten: RawByteString): string;
var
  H: THash;
  Block: TBlock;
  i, Rest, Posi: Integer;
  Bits: QWord;
  Ziffern: string;
begin
  H[0] := $6a09e667;
  H[1] := $bb67ae85;
  H[2] := $3c6ef372;
  H[3] := $a54ff53a;
  H[4] := $510e527f;
  H[5] := $9b05688c;
  H[6] := $1f83d9ab;
  H[7] := $5be0cd19;
  Posi := 1;
  while Posi + 63 <= Length(Daten) do
  begin
    for i := 0 to 63 do
      Block[i] := Ord(Daten[Posi + i]);
    BlockRechnen(Block, H);
    Inc(Posi, 64);
  end;
  FillChar(Block, SizeOf(Block), 0);
  Rest := Length(Daten) - Posi + 1;
  for i := 0 to Rest - 1 do
    Block[i] := Ord(Daten[Posi + i]);
  Block[Rest] := $80;
  if Rest >= 56 then
  begin
    BlockRechnen(Block, H);
    FillChar(Block, SizeOf(Block), 0);
  end;
  Bits := QWord(Length(Daten)) * 8;
  for i := 0 to 7 do
    Block[63 - i] := Byte((Bits shr (8 * i)) and $FF);
  BlockRechnen(Block, H);
  Ziffern := '0123456789abcdef';
  Result := '';
  for i := 0 to 7 do
  begin
    Result := Result +
      Ziffern[((H[i] shr 28) and $F) + 1] + Ziffern[((H[i] shr 24) and $F) + 1] +
      Ziffern[((H[i] shr 20) and $F) + 1] + Ziffern[((H[i] shr 16) and $F) + 1] +
      Ziffern[((H[i] shr 12) and $F) + 1] + Ziffern[((H[i] shr 8) and $F) + 1] +
      Ziffern[((H[i] shr 4) and $F) + 1] + Ziffern[(H[i] and $F) + 1];
  end;
end;

function HexZiffer(C: Char): Integer;
begin
  case C of
    '0'..'9': Result := Ord(C) - Ord('0');
    'a'..'f': Result := Ord(C) - Ord('a') + 10;
    'A'..'F': Result := Ord(C) - Ord('A') + 10;
  else
    Result := -1;
  end;
end;

function HexNachRoh(const Hex: string): RawByteString;
var
  i, A, B: Integer;
begin
  Result := '';
  if Odd(Length(Hex)) then
    Exit;
  SetLength(Result, Length(Hex) div 2);
  for i := 1 to Length(Result) do
  begin
    A := HexZiffer(Hex[i * 2 - 1]);
    B := HexZiffer(Hex[i * 2]);
    if (A < 0) or (B < 0) then
      Exit('');
    Result[i] := Chr((A shl 4) or B);
  end;
end;

function PasswortHash(const SalzHex, Passwort: string): string;
var
  Roh: RawByteString;
begin
  Roh := HexNachRoh(SalzHex);
  Roh := Roh + UTF8Encode(Passwort);
  Result := Sha256Hex(Roh);
end;

function GleichLangsam(const A, B: string): Boolean;
var
  i: Integer;
  Unterschied: Byte;
begin
  Unterschied := Byte(Length(A) xor Length(B));
  for i := 1 to Length(A) do
    if i <= Length(B) then
      Unterschied := Unterschied or (Ord(A[i]) xor Ord(B[i]))
    else
      Unterschied := Unterschied or Ord(A[i]);
  Result := Unterschied = 0;
end;

function NeuesSalz: string;
var
  Kennung: TGUID;
  Roh: RawByteString;
  i: Integer;
begin
  if CreateGUID(Kennung) <> 0 then
    Kennung.D1 := Cardinal(Random(MaxInt));
  SetLength(Roh, 16);
  Move(Kennung, Roh[1], 16);
  Result := '';
  for i := 1 to 16 do
    Result := Result + LowerCase(IntToHex(Ord(Roh[i]), 2));
end;

function Sitzung: TSitzung;
begin
  Result := GSitzung;
end;

procedure SitzungSetzen(const Neu: TSitzung);
begin
  GSitzung := Neu;
end;

function DatenbankBereit: Boolean;
begin
  Result := (PlanlosDB <> nil) and PlanlosDB.Verbunden;
end;

function Anmelden(const Name, Passwort: string; out Meldung: string): Boolean;
var
  Parameter, Zeile: TStringList;
  Neu: TSitzung;
begin
  Result := False;
  Meldung := '';
  SitzungSetzen(Neu);
  if Trim(Name) = '' then
  begin
    Meldung := 'Bitte den Anwender eintragen.';
    Exit;
  end;
  if Passwort = '' then
  begin
    Meldung := 'Bitte das Passwort eintragen.';
    Exit;
  end;
  if not DatenbankBereit then
  begin
    Meldung := 'Die Datenbank ist nicht geöffnet.';
    Exit;
  end;
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['name'] := Trim(Name);
    PlanlosDB.ErsteZeile(
      'SELECT b.id, b.name, b.passwort_salz, b.passwort_hash, b.rolle_id, ' +
      'b.adresse_id, b.aktiv, r.bezeichnung AS rolle FROM benutzer b ' +
      'JOIN rolle r ON r.id = b.rolle_id WHERE b.name = :name',
      Parameter, Zeile);
    if Zeile.Values['id'] = '' then
    begin
      Meldung := 'Diesen Anwender gibt es nicht.';
      Exit;
    end;
    if Zeile.Values['aktiv'] = '0' then
    begin
      Meldung := 'Dieser Anwender ist abgeschaltet.';
      Exit;
    end;
    if not GleichLangsam(Zeile.Values['passwort_hash'],
      PasswortHash(Zeile.Values['passwort_salz'], Passwort)) then
    begin
      Meldung := 'Das Passwort stimmt nicht.';
      Exit;
    end;
    Neu.Aktiv := True;
    Neu.Id := StrToInt64Def(Zeile.Values['id'], 0);
    Neu.Name := Zeile.Values['name'];
    Neu.RolleId := StrToIntDef(Zeile.Values['rolle_id'], 0);
    Neu.Rolle := Zeile.Values['rolle'];
    Neu.AdresseId := StrToInt64Def(Zeile.Values['adresse_id'], 0);
    SitzungSetzen(Neu);
    Result := True;
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function AngemeldeterMitarbeiter: Int64;
begin
  if GSitzung.Aktiv then
    Result := GSitzung.AdresseId
  else
    Result := 0;
end;

function BelegRecht(const Rolle, Kuerzel, Aktion: string): Boolean;
var
  Parameter, Zeile: TStringList;

  function Wahr(const Wert: string): Boolean;
  begin
    Result := Wert = '1';
  end;

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
      'SELECT t.sehen, t.neu, t.aendern, t.loeschen, t.drucken, t.kopieren FROM recht t ' +
      'JOIN rolle r ON r.id = t.rolle_id JOIN modulart m ON m.id = t.modulart_id ' +
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
    else if Aktion = 'drucken' then
      Result := Wahr(Zeile.Values['drucken'])
    else if Aktion = 'kopieren' then
      Result := Wahr(Zeile.Values['kopieren']);
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

function AktionZulaessig(const Art, Kuerzel, Aktion: string; out Meldung: string): Boolean;
var
  Erlaubt: Boolean;
begin
  Meldung := '';
  if not GSitzung.Aktiv then
  begin
    Meldung := 'Bitte zuerst anmelden.';
    Exit(False);
  end;
  if Art = 'maske' then
    Erlaubt := MaskenRecht(GSitzung.Rolle, Kuerzel, Aktion)
  else if Art = 'beleg' then
    Erlaubt := BelegRecht(GSitzung.Rolle, Kuerzel, Aktion)
  else
    Erlaubt := False;
  if not Erlaubt then
  begin
    Meldung := 'Die Rolle ' + GSitzung.Rolle + ' darf das hier nicht.';
    Exit(False);
  end;
  if not ArtSchalter(Art, Kuerzel, Aktion) then
  begin
    Meldung := 'Diese Funktion ist für diese Art ausgeschaltet.';
    Exit(False);
  end;
  Result := True;
end;

function ArtSchalter(const Art, Kuerzel, Aktion: string): Boolean;
var
  Parameter, Zeile: TStringList;
  Spalte, Tabelle: string;
begin
  Result := True;
  if (Aktion <> 'neu') and (Aktion <> 'kopieren') and
     (Aktion <> 'aendern') and (Aktion <> 'loeschen') then
    Exit;
  if Art = 'beleg' then
  begin
    Tabelle := 'modulart';
    if Aktion = 'neu' then
      Spalte := 'datensatz_neu'
    else if Aktion = 'kopieren' then
      Spalte := 'datensatz_kopieren'
    else if Aktion = 'aendern' then
      Spalte := 'datensatz_aendern'
    else
      Spalte := 'datensatz_loeschen';
  end
  else if Art = 'maske' then
  begin
    Tabelle := 'maske';
    if Aktion = 'neu' then
      Spalte := 'neu_an'
    else if Aktion = 'kopieren' then
      Spalte := 'kopieren_an'
    else if Aktion = 'aendern' then
      Spalte := 'aendern_an'
    else
      Spalte := 'loeschen_an';
  end
  else
    Exit(False);
  if not DatenbankBereit then
    Exit(False);
  Parameter := TStringList.Create;
  Zeile := TStringList.Create;
  try
    Parameter.Values['kuerzel'] := Kuerzel;
    PlanlosDB.ErsteZeile(
      'SELECT ' + Spalte + ' AS schalter FROM ' + Tabelle + ' WHERE kuerzel = :kuerzel',
      Parameter, Zeile);
    Result := Zeile.Values['schalter'] = '1';
  finally
    Zeile.Free;
    Parameter.Free;
  end;
end;

procedure BenutzerSicherstellen;
var
  Parameter: TStringList;
  Jetzt, Salz, Hash, Adresse: string;
begin
  if not DatenbankBereit then
    Exit;
  if PlanlosDB.Ganzzahl('SELECT COUNT(*) FROM benutzer WHERE name = ''Admin''') > 0 then
    Exit;
  Jetzt := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', Now);
  Parameter := TStringList.Create;
  try
    Parameter.Values['jetzt'] := Jetzt;
    PlanlosDB.Ausfuehren(
      'INSERT INTO adresse (kategorie_id, nachname, vorname, angelegt, geaendert) ' +
      'VALUES (4, ''Admin'', '''', :jetzt, :jetzt)', Parameter);
    Adresse := Trim(PlanlosDB.Skalar('SELECT last_insert_rowid()'));
    Salz := NeuesSalz;
    Hash := PasswortHash(Salz, '0000');
    Parameter.Clear;
    Parameter.Values['salz'] := Salz;
    Parameter.Values['hash'] := Hash;
    Parameter.Values['adresse'] := Adresse;
    PlanlosDB.Ausfuehren(
      'INSERT INTO benutzer (name, passwort_salz, passwort_hash, rolle_id, adresse_id, aktiv) ' +
      'VALUES (''Admin'', :salz, :hash, 1, :adresse, 1)', Parameter);
  finally
    Parameter.Free;
  end;
end;

end.
