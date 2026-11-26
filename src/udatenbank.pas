unit udatenbank;

{ Datenzugriff für Planlos.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE.

  Gewählt ist SQLdb, die Datenbankschnittstelle aus Free Pascal,
  nicht die früher verwendete Zeos-Bibliothek. Die Begründung steht
  in docs/KONZEPT.md. Fenster sprechen nur mit dieser Unit.

  SQLite ist angeschlossen. PostgreSQL benutzt später dieselbe Klasse;
  die Tabellen sind so geschrieben, dass beide sie verstehen. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, SQLDB;

type
  TDatenbankArt = (daSQLite, daPostgreSQL);

  TPlanlosDatenbank = class
  private
    FArt: TDatenbankArt;
    FConn: TObject;
    FTrans: TObject;
    FPfad: string;
    procedure Direkt(const SQL: string);
    procedure VerbindungAufbauen(const Dateipfad: string);
    function QueryNeu(const SQL: string; Parameter: TStrings): TSQLQuery;
    procedure TransaktionSchliessen;
    procedure MaskenAnlegen;
    procedure BelegSchema;
    procedure ArtikelSchema;
    procedure NachschlageSchema;
    procedure ProjektTextSchema;
  public
    constructor Create;
    destructor Destroy; override;
    procedure VerbindenSQLite(const Dateipfad: string);
    procedure VerbindenPostgreSQL(const Host, Datenbankname, Benutzer, Passwort: string;
      Port: Integer);
    procedure SchemaSicherstellen;
    function Verbunden: Boolean;
    function ArtName: string;
    function Pfad: string;
    function Skalar(const SQL: string): string;
    function SkalarMit(const SQL: string; Parameter: TStrings): string;
    function Ganzzahl(const SQL: string): Int64;
    function ParameterLesen(const Schluessel, Vorgabe: string): string;
    procedure ParameterSetzen(const Schluessel, Wert: string);
    { Parameter sind Name=Wert. Leere Liste oder nil heißt: keine Platzhalter.
      Ausfuehren liefert die Zahl geänderter Zeilen. }
    function Ausfuehren(const SQL: string; Parameter: TStrings): Int64;
    procedure ErsteZeile(const SQL: string; Parameter: TStrings; Ziel: TStrings);
    procedure AlleZeilen(const SQL: string; Parameter: TStrings;
      Spalten, Zeilen: TStrings);
    function FremdschluesselAktiv: Boolean;
    function Bericht: string;
    property Art: TDatenbankArt read FArt;
  end;

function PlanlosDatenDatei: string;
function KaskadeAktiv: Boolean;
procedure KaskadeUmschalten;
function KaskadenSchritt(const Schluessel: string; Vorgabe: Integer): Integer;

var
  PlanlosDB: TPlanlosDatenbank;
  { Das Hauptfenster setzt das, damit es nach einer Parameteränderung
    seinen Text neu zeichnet, ohne dass diese Unit die Fenster kennt. }
  WennAnsichtVeraltet: TNotifyEvent;

implementation

uses
  DB, SQLite3Conn, sqlite3dyn, ubenutzer;

type
  TConn = TSQLite3Connection;

{ SQLite liefert UTF-8. Unter Windows hängt an dem Text sonst die
  ANSI-Codepage, und „Auftragsbestätigung“ wird falsch verglichen. }
function Utf8Text(const Quelle: string): string;
var
  Roh: RawByteString;
begin
  Roh := Quelle;
  SetCodePage(Roh, CP_UTF8, False);
  Result := Roh;
end;

function PlanlosAnwendungsname: string;
begin
  Result := 'planlos';
end;

function OrdnerIstBeschreibbar(const Ordner: string): Boolean;
var
  Probe: string;
  Griff: THandle;
begin
  Result := False;
  if not ForceDirectories(Ordner) then
    Exit;
  Probe := IncludeTrailingPathDelimiter(Ordner) + '.planlos-schreibprobe';
  Griff := FileCreate(Probe);
  if Griff = THandle(feInvalidHandle) then
    Exit;
  FileClose(Griff);
  Result := DeleteFile(Probe);
end;

function PlanlosDatenDatei: string;
var
  Env, NebenProgramm, ImProfil: string;
begin
  Env := Trim(GetEnvironmentVariable('PLANLOS_DATEN'));
  if Env <> '' then
  begin
    if (ExtractFilePath(Env) <> '') and not DirectoryExists(ExtractFilePath(Env)) then
      if not ForceDirectories(ExtractFilePath(Env)) then
        raise Exception.Create(
          'Der Ordner für die Datenbank konnte nicht angelegt werden: ' +
          ExtractFilePath(Env));
    Exit(Env);
  end;
  { Neben der Programmdatei, wenn Windows das Schreiben erlaubt.
    Sonst im eigenen Bereich des Benutzers, zum Beispiel unter AppData. }
  NebenProgramm := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'data';
  if OrdnerIstBeschreibbar(NebenProgramm) then
    Exit(IncludeTrailingPathDelimiter(NebenProgramm) + 'planlos.sqlite');
  OnGetApplicationName := @PlanlosAnwendungsname;
  ImProfil := IncludeTrailingPathDelimiter(GetAppConfigDir(False)) + 'data';
  if not OrdnerIstBeschreibbar(ImProfil) then
    raise Exception.Create(
      'Die Datenbank konnte weder neben dem Programm noch im Benutzerordner angelegt werden.' +
      LineEnding + NebenProgramm + LineEnding + ImProfil);
  Result := IncludeTrailingPathDelimiter(ImProfil) + 'planlos.sqlite';
end;

function KaskadeAktiv: Boolean;
begin
  if (PlanlosDB = nil) or not PlanlosDB.Verbunden then
    Exit(True);
  Result := PlanlosDB.ParameterLesen('kaskade', '1') = '1';
end;

procedure AnsichtVeraltetMelden;
begin
  if Assigned(WennAnsichtVeraltet) then
    WennAnsichtVeraltet(nil);
end;

procedure KaskadeUmschalten;
begin
  if (PlanlosDB = nil) or not PlanlosDB.Verbunden then
    Exit;
  if KaskadeAktiv then
    PlanlosDB.ParameterSetzen('kaskade', '0')
  else
    PlanlosDB.ParameterSetzen('kaskade', '1');
  AnsichtVeraltetMelden;
end;

function KaskadenSchritt(const Schluessel: string; Vorgabe: Integer): Integer;
begin
  Result := Vorgabe;
  if (PlanlosDB <> nil) and PlanlosDB.Verbunden then
    Result := StrToIntDef(PlanlosDB.ParameterLesen(Schluessel, IntToStr(Vorgabe)), Vorgabe);
  if (Result < 1) or (Result > 200) then
    Result := Vorgabe;
end;

constructor TPlanlosDatenbank.Create;
begin
  inherited Create;
  FArt := daSQLite;
end;

destructor TPlanlosDatenbank.Destroy;
var
  Conn: TConn;
  Trans: TSQLTransaction;
begin
  Trans := TSQLTransaction(FTrans);
  Conn := TConn(FConn);
  if Trans <> nil then
  begin
    if Trans.Active then
      Trans.Rollback;
    Trans.Free;
    FTrans := nil;
  end;
  if Conn <> nil then
  begin
    if Conn.Connected then
      Conn.Close;
    Conn.Free;
    FConn := nil;
  end;
  inherited Destroy;
end;

function TPlanlosDatenbank.Verbunden: Boolean;
begin
  Result := (FConn <> nil) and TConn(FConn).Connected;
end;

function TPlanlosDatenbank.ArtName: string;
begin
  if FArt = daPostgreSQL then
    Result := 'PostgreSQL'
  else
    Result := 'SQLite';
end;

function TPlanlosDatenbank.Pfad: string;
begin
  Result := FPfad;
end;

procedure TPlanlosDatenbank.Direkt(const SQL: string);
var
  Conn: TConn;
  Trans: TSQLTransaction;
begin
  Conn := TConn(FConn);
  Trans := TSQLTransaction(FTrans);
  try
    Conn.ExecuteDirect(SQL);
    if Trans.Active then
      Trans.Commit;
  except
    on E: Exception do
    begin
      if (Trans <> nil) and Trans.Active then
        Trans.Rollback;
      raise Exception.Create(
        'Die Datenbank hat eine Anweisung abgelehnt.' + LineEnding +
        E.Message + LineEnding + Copy(Trim(SQL), 1, 500));
    end;
  end;
end;

function TPlanlosDatenbank.Skalar(const SQL: string): string;
var
  Q: TSQLQuery;
  Trans: TSQLTransaction;
begin
  Result := '';
  Trans := TSQLTransaction(FTrans);
  Q := TSQLQuery.Create(nil);
  try
    Q.Database := TConn(FConn);
    Q.Transaction := Trans;
    Q.SQL.Text := SQL;
    Q.Open;
    try
      if not Q.EOF then
      begin
        Result := Utf8Text(Q.Fields[0].AsString);
      end;
    finally
      Q.Close;
    end;
    if Trans.Active then
      Trans.Commit;
  finally
    Q.Free;
  end;
end;

function TPlanlosDatenbank.Ganzzahl(const SQL: string): Int64;
begin
  Result := StrToInt64Def(Trim(Skalar(SQL)), 0);
end;

function TPlanlosDatenbank.QueryNeu(const SQL: string; Parameter: TStrings): TSQLQuery;
var
  i: Integer;
  Name: string;
begin
  Result := TSQLQuery.Create(nil);
  Result.Database := TConn(FConn);
  Result.Transaction := TSQLTransaction(FTrans);
  Result.SQL.Text := SQL;
  if Parameter = nil then
    Exit;
  for i := 0 to Parameter.Count - 1 do
  begin
    Name := Parameter.Names[i];
    if Name <> '' then
      Result.ParamByName(Name).AsString := Parameter.ValueFromIndex[i];
  end;
end;

procedure TPlanlosDatenbank.TransaktionSchliessen;
var
  Trans: TSQLTransaction;
begin
  Trans := TSQLTransaction(FTrans);
  if (Trans <> nil) and Trans.Active then
    Trans.Commit;
end;

function TPlanlosDatenbank.SkalarMit(const SQL: string; Parameter: TStrings): string;
var
  Q: TSQLQuery;
begin
  Result := '';
  Q := QueryNeu(SQL, Parameter);
  try
    Q.Open;
    try
      if not Q.EOF then
      begin
        Result := Utf8Text(Q.Fields[0].AsString);
      end;
    finally
      Q.Close;
    end;
    TransaktionSchliessen;
  finally
    Q.Free;
  end;
end;

function TPlanlosDatenbank.Ausfuehren(const SQL: string; Parameter: TStrings): Int64;
var
  Q: TSQLQuery;
begin
  Q := QueryNeu(SQL, Parameter);
  try
    Q.ExecSQL;
    Result := Q.RowsAffected;
    TransaktionSchliessen;
  finally
    Q.Free;
  end;
end;

procedure TPlanlosDatenbank.ErsteZeile(const SQL: string; Parameter: TStrings;
  Ziel: TStrings);
var
  Q: TSQLQuery;
  i: Integer;
begin
  Ziel.Clear;
  Q := QueryNeu(SQL, Parameter);
  try
    Q.Open;
    try
      if not Q.EOF then
        for i := 0 to Q.Fields.Count - 1 do
        begin
          Ziel.Values[Q.Fields[i].FieldName] := Utf8Text(Q.Fields[i].AsString);
        end;
    finally
      Q.Close;
    end;
    TransaktionSchliessen;
  finally
    Q.Free;
  end;
end;

procedure TPlanlosDatenbank.AlleZeilen(const SQL: string; Parameter: TStrings;
  Spalten, Zeilen: TStrings);
var
  Q: TSQLQuery;
  i: Integer;
  Zeile, Wert: string;
begin
  Spalten.Clear;
  Zeilen.Clear;
  Q := QueryNeu(SQL, Parameter);
  try
    Q.Open;
    try
      for i := 0 to Q.Fields.Count - 1 do
        Spalten.Add(Q.Fields[i].FieldName);
      while not Q.EOF do
      begin
        Zeile := '';
        for i := 0 to Q.Fields.Count - 1 do
        begin
          Wert := StringReplace(Utf8Text(Q.Fields[i].AsString), #9, ' ', [rfReplaceAll]);
          if i > 0 then
            Zeile := Zeile + #9;
          Zeile := Zeile + Wert;
        end;
        Zeilen.Add(Zeile);
        Q.Next;
      end;
    finally
      Q.Close;
    end;
    TransaktionSchliessen;
  finally
    Q.Free;
  end;
end;

function TPlanlosDatenbank.ParameterLesen(const Schluessel, Vorgabe: string): string;
var
  Q: TSQLQuery;
  Trans: TSQLTransaction;
begin
  Result := Vorgabe;
  Trans := TSQLTransaction(FTrans);
  Q := TSQLQuery.Create(nil);
  try
    Q.Database := TConn(FConn);
    Q.Transaction := Trans;
    Q.SQL.Text := 'SELECT wert FROM parameter WHERE schluessel = :schluessel';
    Q.ParamByName('schluessel').AsString := Schluessel;
    Q.Open;
    try
      if not Q.EOF then
      begin
        Result := Utf8Text(Q.Fields[0].AsString);
      end;
    finally
      Q.Close;
    end;
    if Trans.Active then
      Trans.Commit;
  finally
    Q.Free;
  end;
end;

procedure TPlanlosDatenbank.ParameterSetzen(const Schluessel, Wert: string);
var
  Q: TSQLQuery;
  Trans: TSQLTransaction;
begin
  Trans := TSQLTransaction(FTrans);
  Q := TSQLQuery.Create(nil);
  try
    Q.Database := TConn(FConn);
    Q.Transaction := Trans;
    Q.SQL.Text := 'UPDATE parameter SET wert = :wert WHERE schluessel = :schluessel';
    Q.ParamByName('wert').AsString := Wert;
    Q.ParamByName('schluessel').AsString := Schluessel;
    Q.ExecSQL;
    if Q.RowsAffected = 0 then
    begin
      Q.SQL.Text :=
        'INSERT INTO parameter (schluessel, wert) VALUES (:schluessel, :wert)';
      Q.ParamByName('schluessel').AsString := Schluessel;
      Q.ParamByName('wert').AsString := Wert;
      Q.ExecSQL;
    end;
    if Trans.Active then
      Trans.Commit;
  finally
    Q.Free;
  end;
end;

function TPlanlosDatenbank.FremdschluesselAktiv: Boolean;
begin
  Result := Trim(Skalar('PRAGMA foreign_keys')) = '1';
end;

procedure TPlanlosDatenbank.VerbindungAufbauen(const Dateipfad: string);
var
  Ordner: string;
  Conn: TConn;
  Trans: TSQLTransaction;
begin
  if Dateipfad = '' then
    raise Exception.Create('Es ist kein Pfad für die Datenbankdatei angegeben.');
  Ordner := ExtractFilePath(Dateipfad);
  if (Ordner <> '') and not DirectoryExists(Ordner) then
    if not ForceDirectories(Ordner) then
      raise Exception.Create(
        'Der Ordner für die Datenbank konnte nicht angelegt werden: ' + Ordner);

  {$IFDEF UNIX}
  { Ubuntu liefert die Bibliothek als libsqlite3.so.0.
    Der Name libsqlite3.so steht nur im Entwicklungspaket. }
  SQLiteDefaultLibrary := 'libsqlite3.so.0';
  {$ENDIF}

  Conn := TSQLite3Connection.Create(nil);
  Trans := TSQLTransaction.Create(nil);
  FConn := Conn;
  FTrans := Trans;
  try
    Conn.Transaction := Trans;
    { Von SQLdb gelesen und beim Öffnen als PRAGMA gesetzt. }
    Conn.Params.Add('foreign_keys=ON');
    Conn.DatabaseName := Dateipfad;
    Conn.Open;
    FPfad := Dateipfad;
    FArt := daSQLite;
  except
    on E: Exception do
    begin
      Trans.Free;
      FTrans := nil;
      Conn.Free;
      FConn := nil;
      raise Exception.Create(
        'Die SQLite-Datei konnte nicht geöffnet werden.' + LineEnding +
        Dateipfad + LineEnding + E.Message);
    end;
  end;
end;

procedure TPlanlosDatenbank.VerbindenSQLite(const Dateipfad: string);
begin
  VerbindungAufbauen(Dateipfad);
end;

procedure TPlanlosDatenbank.VerbindenPostgreSQL(const Host, Datenbankname,
  Benutzer, Passwort: string; Port: Integer);
var
  PasswortHinweis: string;
begin
  if Passwort = '' then
    PasswortHinweis := 'Es wurde kein Passwort übergeben.'
  else
    PasswortHinweis := 'Ein Passwort wurde übergeben und wird hier nicht angezeigt.';
  raise Exception.Create(
    'PostgreSQL ist in dieser Ausbaustufe noch nicht angeschlossen.' + LineEnding +
    'Vorgesehen ist dieselbe Klasse, mit der Verbindung TPQConnection aus ' +
    'Free Pascal (Unit pqconnection), Host ' + Host + ', Datenbank ' +
    Datenbankname + ', Benutzer ' + Benutzer + ', Port ' + IntToStr(Port) + '.' +
    LineEnding + PasswortHinweis);
end;

procedure TPlanlosDatenbank.SchemaSicherstellen;

  procedure Merkmal(const Schluessel, Wert: string);
  begin
    Direkt(
      'INSERT INTO parameter (schluessel, wert) SELECT ' +
      QuotedStr(Schluessel) + ', ' + QuotedStr(Wert) +
      ' WHERE NOT EXISTS (SELECT 1 FROM parameter WHERE schluessel = ' +
      QuotedStr(Schluessel) + ')');
  end;

  procedure Modulart(Id: Integer; const Kuerzel, Bezeichnung, Beschreibung,
    Kreis: string; HauptId, Sortierung, Kopf, Summe, Fuss: Integer);
  var
    HauptSQL: string;
  begin
    if HauptId = 0 then
      HauptSQL := 'NULL'
    else
      HauptSQL := IntToStr(HauptId);
    Direkt(
      'INSERT INTO modulart (id, kuerzel, bezeichnung, beschreibung, nummernkreis, ' +
      'hauptmodul_id, sortierung, bereich_kopf, bereich_summe, bereich_fuss) SELECT ' +
      IntToStr(Id) + ', ' + QuotedStr(Kuerzel) + ', ' + QuotedStr(Bezeichnung) + ', ' +
      QuotedStr(Beschreibung) + ', ' + QuotedStr(Kreis) + ', ' + HauptSQL + ', ' +
      IntToStr(Sortierung) + ', ' + IntToStr(Kopf) + ', ' + IntToStr(Summe) + ', ' +
      IntToStr(Fuss) +
      ' WHERE NOT EXISTS (SELECT 1 FROM modulart WHERE id = ' + IntToStr(Id) + ')');
  end;

  procedure Kategorie(Id: Integer; const Bezeichnung: string);
  begin
    Direkt(
      'INSERT INTO adresskategorie (id, bezeichnung) SELECT ' +
      IntToStr(Id) + ', ' + QuotedStr(Bezeichnung) +
      ' WHERE NOT EXISTS (SELECT 1 FROM adresskategorie WHERE id = ' + IntToStr(Id) + ')');
  end;

  procedure Rolle(Id: Integer; const Bezeichnung, Beschreibung: string);
  begin
    Direkt(
      'INSERT INTO rolle (id, bezeichnung, beschreibung) SELECT ' +
      IntToStr(Id) + ', ' + QuotedStr(Bezeichnung) + ', ' + QuotedStr(Beschreibung) +
      ' WHERE NOT EXISTS (SELECT 1 FROM rolle WHERE id = ' + IntToStr(Id) + ')');
  end;

  procedure Spalte(const Tabelle, Name, Definition: string);
  begin
    if Ganzzahl(
      'SELECT COUNT(*) FROM pragma_table_info(' + QuotedStr(Tabelle) +
      ') WHERE name = ' + QuotedStr(Name)) = 0 then
      Direkt('ALTER TABLE ' + Tabelle + ' ADD COLUMN ' + Name + ' ' + Definition);
  end;

var
  RolleId, ModulId, RechtId: Integer;
  Sehen, Neu, Aendern, Loeschen, Drucken: Integer;
  Kennung: string;
  G: TGUID;
begin
  { Schema-Version 5. Vorhandene Zeilen werden nicht überschrieben,
    damit eine spätere Umbenennung beim nächsten Start erhalten bleibt. }

  Direkt(
    'CREATE TABLE IF NOT EXISTS schema_info (' +
    'id INTEGER PRIMARY KEY, ' +
    'version INTEGER NOT NULL, ' +
    'angelegt TEXT NOT NULL)');

  Direkt(
    'CREATE TABLE IF NOT EXISTS parameter (' +
    'schluessel TEXT PRIMARY KEY, ' +
    'wert TEXT NOT NULL)');

  Direkt(
    'CREATE TABLE IF NOT EXISTS modulart (' +
    'id INTEGER PRIMARY KEY, ' +
    'kuerzel TEXT NOT NULL UNIQUE, ' +
    'bezeichnung TEXT NOT NULL, ' +
    'beschreibung TEXT, ' +
    'fenster_oben INTEGER NOT NULL DEFAULT 0, ' +
    'fenster_links INTEGER NOT NULL DEFAULT 0, ' +
    'fenster_breite INTEGER NOT NULL DEFAULT 800, ' +
    'fenster_hoehe INTEGER NOT NULL DEFAULT 600, ' +
    'bereich_kopf INTEGER NOT NULL DEFAULT 1, ' +
    'bereich_summe INTEGER NOT NULL DEFAULT 1, ' +
    'bereich_fuss INTEGER NOT NULL DEFAULT 1, ' +
    'hauptmodul_id INTEGER REFERENCES modulart(id), ' +
    'nummernkreis TEXT, ' +
    'sortierung INTEGER NOT NULL DEFAULT 0, ' +
    'aktiv INTEGER NOT NULL DEFAULT 1)');
  Spalte('modulart', 'datensatz_neu', 'INTEGER NOT NULL DEFAULT 1');
  Spalte('modulart', 'datensatz_kopieren', 'INTEGER NOT NULL DEFAULT 1');
  Spalte('modulart', 'datensatz_aendern', 'INTEGER NOT NULL DEFAULT 1');
  Spalte('modulart', 'datensatz_loeschen', 'INTEGER NOT NULL DEFAULT 1');

  Direkt(
    'CREATE TABLE IF NOT EXISTS adresskategorie (' +
    'id INTEGER PRIMARY KEY, ' +
    'bezeichnung TEXT NOT NULL UNIQUE)');

  Direkt(
    'CREATE TABLE IF NOT EXISTS adresse (' +
    'id INTEGER PRIMARY KEY, ' +
    'kategorie_id INTEGER REFERENCES adresskategorie(id), ' +
    'firma TEXT, ' +
    'anrede TEXT, ' +
    'titel TEXT, ' +
    'vorname TEXT, ' +
    'nachname TEXT, ' +
    'strasse TEXT, ' +
    'plz TEXT, ' +
    'ort TEXT, ' +
    'land TEXT, ' +
    'telefon TEXT, ' +
    'telefax TEXT, ' +
    'email TEXT, ' +
    'notiz TEXT, ' +
    'telefon_privat TEXT, ' +
    'telefon_andere TEXT, ' +
    'adressblock TEXT, ' +
    'frei1 TEXT, ' +
    'frei2 TEXT, ' +
    'frei3 TEXT, ' +
    'frei4 TEXT, ' +
    'rabatt_prozent REAL NOT NULL DEFAULT 0, ' +
    'angelegt TEXT NOT NULL, ' +
    'geaendert TEXT NOT NULL)');

  Direkt(
    'CREATE TABLE IF NOT EXISTS rolle (' +
    'id INTEGER PRIMARY KEY, ' +
    'bezeichnung TEXT NOT NULL UNIQUE, ' +
    'beschreibung TEXT)');

  Direkt(
    'CREATE TABLE IF NOT EXISTS benutzer (' +
    'id INTEGER PRIMARY KEY, ' +
    'name TEXT NOT NULL UNIQUE, ' +
    'passwort_salz TEXT NOT NULL, ' +
    'passwort_hash TEXT NOT NULL, ' +
    'rolle_id INTEGER NOT NULL REFERENCES rolle(id), ' +
    'adresse_id INTEGER REFERENCES adresse(id), ' +
    'aktiv INTEGER NOT NULL DEFAULT 1)');

  Direkt(
    'CREATE TABLE IF NOT EXISTS recht (' +
    'id INTEGER PRIMARY KEY, ' +
    'rolle_id INTEGER NOT NULL REFERENCES rolle(id), ' +
    'modulart_id INTEGER NOT NULL REFERENCES modulart(id), ' +
    'sehen INTEGER NOT NULL DEFAULT 0, ' +
    'neu INTEGER NOT NULL DEFAULT 0, ' +
    'aendern INTEGER NOT NULL DEFAULT 0, ' +
    'loeschen INTEGER NOT NULL DEFAULT 0, ' +
    'drucken INTEGER NOT NULL DEFAULT 0, ' +
    'kopieren INTEGER NOT NULL DEFAULT 1, ' +
    'UNIQUE (rolle_id, modulart_id))');
  Spalte('recht', 'kopieren', 'INTEGER NOT NULL DEFAULT 1');

  Spalte('adresse', 'telefon_privat', 'TEXT');
  Spalte('adresse', 'telefon_andere', 'TEXT');
  Spalte('adresse', 'adressblock', 'TEXT');
  Spalte('adresse', 'frei1', 'TEXT');
  Spalte('adresse', 'frei2', 'TEXT');
  Spalte('adresse', 'frei3', 'TEXT');
  Spalte('adresse', 'frei4', 'TEXT');

  Direkt('CREATE INDEX IF NOT EXISTS idx_adresse_kategorie ON adresse(kategorie_id)');
  Direkt('CREATE INDEX IF NOT EXISTS idx_adresse_nachname ON adresse(nachname)');
  Direkt('CREATE INDEX IF NOT EXISTS idx_adresse_firma ON adresse(firma)');
  Direkt('CREATE INDEX IF NOT EXISTS idx_recht_rolle ON recht(rolle_id)');

  Modulart(1, 'angebot', 'Angebot',
    'Preisvorschlag an einen Kunden, noch ohne Pflicht.',
    'ANG', 0, 10, 1, 1, 1);
  Modulart(2, 'auftragsbestaetigung', 'Auftragsbestätigung',
    'Zusage, dass der Auftrag so ausgeführt wird.',
    'AB', 1, 20, 1, 1, 1);
  Modulart(3, 'bestellung', 'Bestellung',
    'Bestellung bei einem Lieferanten.',
    'BES', 0, 30, 1, 1, 1);
  Modulart(4, 'rechnung', 'Rechnung',
    'Forderung an den Kunden. Später festschreibbar.',
    'RE', 2, 40, 1, 1, 1);
  Modulart(5, 'projekt', 'Projekt',
    'Sammelmappe für Belege, ohne Summen- und Fußblock.',
    'PRJ', 0, 50, 1, 0, 0);

  Kategorie(1, 'Kunde');
  Kategorie(2, 'Lieferant');
  Kategorie(3, 'Kontakt');
  Kategorie(4, 'Mitarbeiter');

  Rolle(1, 'Administrator',
    'Darf Belege sehen, anlegen, ändern, löschen und drucken.');
  Rolle(2, 'Abteilungsleiter',
    'Darf Belege sehen, anlegen, ändern und drucken, aber nicht löschen.');
  Rolle(3, 'Gruppenleiter',
    'Darf Belege sehen und anlegen.');

  RechtId := 0;
  for RolleId := 1 to 3 do
    for ModulId := 1 to 5 do
    begin
      Inc(RechtId);
      case RolleId of
        1: begin
             Sehen := 1; Neu := 1; Aendern := 1; Loeschen := 1; Drucken := 1;
           end;
        2: begin
             Sehen := 1; Neu := 1; Aendern := 1; Loeschen := 0; Drucken := 1;
           end;
      else
        begin
          Sehen := 1; Neu := 1; Aendern := 0; Loeschen := 0; Drucken := 0;
        end;
      end;
      Direkt(
        'INSERT INTO recht (id, rolle_id, modulart_id, sehen, neu, aendern, ' +
        'loeschen, drucken, kopieren) SELECT ' +
        IntToStr(RechtId) + ', ' + IntToStr(RolleId) + ', ' + IntToStr(ModulId) + ', ' +
        IntToStr(Sehen) + ', ' + IntToStr(Neu) + ', ' + IntToStr(Aendern) + ', ' +
        IntToStr(Loeschen) + ', ' + IntToStr(Drucken) + ', ' + IntToStr(Neu) +
        ' WHERE NOT EXISTS (SELECT 1 FROM recht WHERE id = ' + IntToStr(RechtId) + ')');
    end;
  if ParameterLesen('recht_kopieren_v5', '') = '' then
  begin
    Direkt('UPDATE recht SET kopieren = neu');
    ParameterSetzen('recht_kopieren_v5', '1');
  end;

  Merkmal('kaskade', '1');
  Merkmal('schritt_oben', '26');
  Merkmal('schritt_links', '9');
  Merkmal('datenbank_art', 'sqlite');
  { Regelsteuersatz nach § 12 Abs. 1 UStG. Kein Steuerprogramm,
    nur der Startwert für spätere Belege. }
  Merkmal('mwst_satz', '19');

  Kennung := Trim(Skalar(
    'SELECT wert FROM parameter WHERE schluessel = ''installation_id'''));
  if Kennung = '' then
  begin
    if CreateGUID(G) <> 0 then
      Kennung := 'ohne-kennung'
    else
    begin
      Kennung := GUIDToString(G);
      if (Length(Kennung) >= 2) and (Kennung[1] = '{') then
        Kennung := Copy(Kennung, 2, Length(Kennung) - 2);
    end;
    Merkmal('installation_id', Kennung);
  end;

  MaskenAnlegen;
  BelegSchema;
  ArtikelSchema;
  NachschlageSchema;
  ProjektTextSchema;
  { PlanlosDB zeigt während des Anlegens auf diese Datei, auch wenn der
    Aufrufer die Variable erst danach setzt. }
  if PlanlosDB = nil then
    PlanlosDB := Self;
  BenutzerSicherstellen;

  if Ganzzahl('SELECT COUNT(*) FROM schema_info') = 0 then
    Direkt(
      'INSERT INTO schema_info (id, version, angelegt) VALUES (1, 8, ' +
      QuotedStr(FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', Now)) + ')')
  else if Ganzzahl('SELECT version FROM schema_info WHERE id = 1') < 8 then
    Direkt('UPDATE schema_info SET version = 8 WHERE id = 1');
end;

procedure TPlanlosDatenbank.ArtikelSchema;
var
  RolleId, MaskeId, Sehen, Neu, Aendern, Loeschen: Integer;
begin
  Direkt(
    'CREATE TABLE IF NOT EXISTS einheit (' +
    'id INTEGER PRIMARY KEY, ' +
    'bezeichnung TEXT NOT NULL UNIQUE)');
  Direkt(
    'CREATE TABLE IF NOT EXISTS berechnungsart (' +
    'id INTEGER PRIMARY KEY, ' +
    'bezeichnung TEXT NOT NULL UNIQUE)');
  Direkt(
    'CREATE TABLE IF NOT EXISTS artikelgruppe (' +
    'id INTEGER PRIMARY KEY, ' +
    'bezeichnung TEXT NOT NULL UNIQUE, ' +
    'berechnungsart TEXT, ' +
    'aufschlag_bp INTEGER NOT NULL DEFAULT 0, ' +
    'kostenart TEXT NOT NULL DEFAULT ''M'', ' +
    'sichtbar_gewicht INTEGER NOT NULL DEFAULT 0, ' +
    'sichtbar_zahl1 INTEGER NOT NULL DEFAULT 0, ' +
    'sichtbar_zahl2 INTEGER NOT NULL DEFAULT 0, ' +
    'sichtbar_zahl3 INTEGER NOT NULL DEFAULT 0, ' +
    'sichtbar_postext INTEGER NOT NULL DEFAULT 0, ' +
    'sichtbar_name1 INTEGER NOT NULL DEFAULT 0, ' +
    'sichtbar_name2 INTEGER NOT NULL DEFAULT 0, ' +
    'sichtbar_name3 INTEGER NOT NULL DEFAULT 0, ' +
    'sichtbar_lieferant INTEGER NOT NULL DEFAULT 0, ' +
    'sichtbar_bestand INTEGER NOT NULL DEFAULT 0, ' +
    'sichtbar_min_bestand INTEGER NOT NULL DEFAULT 0, ' +
    'sichtbar_lieferant_nr INTEGER NOT NULL DEFAULT 0, ' +
    'einheit_menge_wie_ek INTEGER NOT NULL DEFAULT 1, ' +
    'vorgabe_artikel TEXT, ' +
    'vorgabe_ek_cent INTEGER NOT NULL DEFAULT 0, ' +
    'vorgabe_aufschlag_bp INTEGER NOT NULL DEFAULT 0, ' +
    'vorgabe_einheit_menge TEXT, ' +
    'vorgabe_einheit_ek TEXT, ' +
    'vorgabe_lieferant TEXT)');
  Direkt(
    'CREATE TABLE IF NOT EXISTS artikel (' +
    'id INTEGER PRIMARY KEY, ' +
    'gruppe_id INTEGER REFERENCES artikelgruppe(id), ' +
    'bezeichnung TEXT, ' +
    'ek_cent INTEGER NOT NULL DEFAULT 0, ' +
    'einheit_ek TEXT, ' +
    'aufschlag_bp INTEGER NOT NULL DEFAULT 0, ' +
    'mwst_satz INTEGER NOT NULL DEFAULT 19, ' +
    'gewicht_milli INTEGER NOT NULL DEFAULT 0, ' +
    'zahl1_milli INTEGER NOT NULL DEFAULT 0, ' +
    'zahl2_milli INTEGER NOT NULL DEFAULT 0, ' +
    'zahl3_milli INTEGER NOT NULL DEFAULT 0, ' +
    'name1 TEXT, name2 TEXT, name3 TEXT, ' +
    'lieferant TEXT, lieferant_nr TEXT, pos_text TEXT, ' +
    'einheit_menge TEXT, berechnungsart TEXT, kostenart TEXT, ' +
    'bestand_milli INTEGER NOT NULL DEFAULT 0, ' +
    'min_bestand_milli INTEGER NOT NULL DEFAULT 0)');

  Direkt('INSERT INTO einheit (id, bezeichnung) SELECT 1, ''Meter'' ' +
    'WHERE NOT EXISTS (SELECT 1 FROM einheit WHERE id = 1)');
  Direkt('INSERT INTO einheit (id, bezeichnung) SELECT 2, ''Stunden'' ' +
    'WHERE NOT EXISTS (SELECT 1 FROM einheit WHERE id = 2)');
  Direkt('INSERT INTO einheit (id, bezeichnung) SELECT 3, ''Stück'' ' +
    'WHERE NOT EXISTS (SELECT 1 FROM einheit WHERE id = 3)');
  Direkt('INSERT INTO einheit (id, bezeichnung) SELECT 4, ''Sortiment'' ' +
    'WHERE NOT EXISTS (SELECT 1 FROM einheit WHERE id = 4)');
  Direkt('INSERT INTO berechnungsart (id, bezeichnung) SELECT 1, ''Menge*EK_Preis'' ' +
    'WHERE NOT EXISTS (SELECT 1 FROM berechnungsart WHERE id = 1)');

  Direkt(
    'INSERT INTO maske (id, kuerzel, bezeichnung, tabelle, kategorie_id, ' +
    'fenster_links, fenster_oben, fenster_breite, fenster_hoehe, sortierung) SELECT ' +
    '5, ''artikel'', ''Artikel'', ''artikel'', NULL, 45, 13, 700, 480, 50 ' +
    'WHERE NOT EXISTS (SELECT 1 FROM maske WHERE id = 5)');
  Direkt(
    'INSERT INTO maske (id, kuerzel, bezeichnung, tabelle, kategorie_id, ' +
    'fenster_links, fenster_oben, fenster_breite, fenster_hoehe, sortierung) SELECT ' +
    '6, ''artikelgruppe'', ''Artikelgruppe'', ''artikelgruppe'', NULL, 33, 15, 560, 500, 60 ' +
    'WHERE NOT EXISTS (SELECT 1 FROM maske WHERE id = 6)');
  Direkt(
    'INSERT INTO maske (id, kuerzel, bezeichnung, tabelle, kategorie_id, ' +
    'fenster_links, fenster_oben, fenster_breite, fenster_hoehe, sortierung) SELECT ' +
    '7, ''einheit'', ''Einheit'', ''einheit'', NULL, 80, 40, 420, 360, 70 ' +
    'WHERE NOT EXISTS (SELECT 1 FROM maske WHERE id = 7)');
  Direkt(
    'INSERT INTO maske (id, kuerzel, bezeichnung, tabelle, kategorie_id, ' +
    'fenster_links, fenster_oben, fenster_breite, fenster_hoehe, sortierung) SELECT ' +
    '8, ''berechnungsart'', ''Berechnungsart'', ''berechnungsart'', NULL, 80, 40, 420, 360, 80 ' +
    'WHERE NOT EXISTS (SELECT 1 FROM maske WHERE id = 8)');

  for RolleId := 1 to 3 do
    for MaskeId := 5 to 8 do
    begin
      if MaskeId >= 7 then
      begin
        Sehen := 1; Neu := 0; Aendern := 0; Loeschen := 0;
      end
      else
        case RolleId of
          1: begin
               Sehen := 1; Neu := 1; Aendern := 1; Loeschen := 1;
             end;
          2: begin
               Sehen := 1; Neu := 1; Aendern := 1; Loeschen := 0;
             end;
        else
          begin
            Sehen := 1; Neu := 1; Aendern := 0; Loeschen := 0;
          end;
        end;
      Direkt(
        'INSERT INTO maskenrecht (rolle_id, maske_id, sehen, neu, aendern, loeschen, kopieren) ' +
        'SELECT ' + IntToStr(RolleId) + ', ' + IntToStr(MaskeId) + ', ' +
        IntToStr(Sehen) + ', ' + IntToStr(Neu) + ', ' + IntToStr(Aendern) + ', ' +
        IntToStr(Loeschen) + ', ' + IntToStr(Neu) +
        ' WHERE NOT EXISTS (SELECT 1 FROM maskenrecht WHERE rolle_id = ' +
        IntToStr(RolleId) + ' AND maske_id = ' + IntToStr(MaskeId) + ')');
    end;

  for MaskeId := 5 to 6 do
  begin
    Direkt(
      'INSERT INTO tastenbelegung (maske_id, kontext, ebene, taste, beschriftung, aktion, erlaubt) ' +
      'SELECT ' + IntToStr(MaskeId) + ', ''suche'', 1, 2, ''Neu'', ''neu'', 1 ' +
      'WHERE NOT EXISTS (SELECT 1 FROM tastenbelegung WHERE maske_id = ' +
      IntToStr(MaskeId) + ' AND kontext = ''suche'' AND ebene = 1 AND taste = 2)');
    Direkt(
      'INSERT INTO tastenbelegung (maske_id, kontext, ebene, taste, beschriftung, aktion, erlaubt) ' +
      'SELECT ' + IntToStr(MaskeId) + ', ''suche'', 1, 5, ''Kopieren'', ''kopieren'', 1 ' +
      'WHERE NOT EXISTS (SELECT 1 FROM tastenbelegung WHERE maske_id = ' +
      IntToStr(MaskeId) + ' AND kontext = ''suche'' AND ebene = 1 AND taste = 5)');
    Direkt(
      'INSERT INTO tastenbelegung (maske_id, kontext, ebene, taste, beschriftung, aktion, erlaubt) ' +
      'SELECT ' + IntToStr(MaskeId) + ', ''suche'', 1, 6, ''Ändern'', ''aendern'', 1 ' +
      'WHERE NOT EXISTS (SELECT 1 FROM tastenbelegung WHERE maske_id = ' +
      IntToStr(MaskeId) + ' AND kontext = ''suche'' AND ebene = 1 AND taste = 6)');
    Direkt(
      'INSERT INTO tastenbelegung (maske_id, kontext, ebene, taste, beschriftung, aktion, erlaubt) ' +
      'SELECT ' + IntToStr(MaskeId) + ', ''suche'', 1, 8, ''Löschen'', ''loeschen'', 1 ' +
      'WHERE NOT EXISTS (SELECT 1 FROM tastenbelegung WHERE maske_id = ' +
      IntToStr(MaskeId) + ' AND kontext = ''suche'' AND ebene = 1 AND taste = 8)');
  end;
end;

procedure TPlanlosDatenbank.NachschlageSchema;
var
  RolleId, MaskeId, Sehen, Neu, Aendern, Loeschen: Integer;

  procedure Maske(Id, Links, Oben, Breite, Hoehe, Sortierung: Integer;
    const Kuerzel, Bezeichnung, Tabelle: string);
  begin
    Direkt(
      'INSERT INTO maske (id, kuerzel, bezeichnung, tabelle, kategorie_id, ' +
      'fenster_links, fenster_oben, fenster_breite, fenster_hoehe, sortierung) SELECT ' +
      IntToStr(Id) + ', ' + QuotedStr(Kuerzel) + ', ' + QuotedStr(Bezeichnung) + ', ' +
      QuotedStr(Tabelle) + ', NULL, ' + IntToStr(Links) + ', ' + IntToStr(Oben) + ', ' +
      IntToStr(Breite) + ', ' + IntToStr(Hoehe) + ', ' + IntToStr(Sortierung) +
      ' WHERE NOT EXISTS (SELECT 1 FROM maske WHERE id = ' + IntToStr(Id) + ')');
  end;

  procedure Taste(MaskeId, TasteNr: Integer; const Beschriftung, Aktion: string);
  begin
    Direkt(
      'INSERT INTO tastenbelegung (maske_id, kontext, ebene, taste, beschriftung, ' +
      'aktion, erlaubt) SELECT ' + IntToStr(MaskeId) + ', ''suche'', 1, ' +
      IntToStr(TasteNr) + ', ' + QuotedStr(Beschriftung) + ', ' + QuotedStr(Aktion) +
      ', 1 WHERE NOT EXISTS (SELECT 1 FROM tastenbelegung WHERE maske_id = ' +
      IntToStr(MaskeId) + ' AND kontext = ''suche'' AND ebene = 1 AND taste = ' +
      IntToStr(TasteNr) + ')');
  end;

begin
  Direkt(
    'CREATE TABLE IF NOT EXISTS nachschlage (' +
    'id INTEGER PRIMARY KEY, ' +
    'art TEXT NOT NULL, ' +
    'bezeichnung TEXT NOT NULL, ' +
    'nur_lesen INTEGER NOT NULL DEFAULT 0, ' +
    'UNIQUE (art, bezeichnung))');
  Direkt(
    'INSERT INTO nachschlage (art, bezeichnung, nur_lesen) ' +
    'SELECT ''einheit'', bezeichnung, 0 FROM einheit e ' +
    'WHERE NOT EXISTS (SELECT 1 FROM nachschlage n WHERE n.art = ''einheit'' ' +
    'AND n.bezeichnung = e.bezeichnung)');
  Direkt('INSERT INTO nachschlage (art, bezeichnung, nur_lesen) SELECT ''kategorie'', ''Kunde'', 1 ' +
    'WHERE NOT EXISTS (SELECT 1 FROM nachschlage WHERE art = ''kategorie'' AND bezeichnung = ''Kunde'')');
  Direkt('INSERT INTO nachschlage (art, bezeichnung, nur_lesen) SELECT ''kategorie'', ''Lieferant'', 1 ' +
    'WHERE NOT EXISTS (SELECT 1 FROM nachschlage WHERE art = ''kategorie'' AND bezeichnung = ''Lieferant'')');
  Direkt('INSERT INTO nachschlage (art, bezeichnung, nur_lesen) SELECT ''kategorie'', ''Mitarbeiter'', 1 ' +
    'WHERE NOT EXISTS (SELECT 1 FROM nachschlage WHERE art = ''kategorie'' AND bezeichnung = ''Mitarbeiter'')');
  Direkt('INSERT INTO nachschlage (art, bezeichnung, nur_lesen) SELECT ''kategorie'', ''Kontakt'', 1 ' +
    'WHERE NOT EXISTS (SELECT 1 FROM nachschlage WHERE art = ''kategorie'' AND bezeichnung = ''Kontakt'')');
  Direkt('INSERT INTO nachschlage (art, bezeichnung, nur_lesen) SELECT ''kategorie'', ''Privat'', 0 ' +
    'WHERE NOT EXISTS (SELECT 1 FROM nachschlage WHERE art = ''kategorie'' AND bezeichnung = ''Privat'')');

  Maske(9, 26, 9, 560, 420, 90, 'kategorie', 'Kategorie', 'nachschlage');
  Maske(10, 26, 9, 560, 420, 100, 'gruppierung', 'Gruppierung', 'nachschlage');
  Maske(11, 26, 9, 560, 420, 110, 'stuecklistengruppe', 'Stücklistengruppe', 'nachschlage');
  Direkt(
    'UPDATE maske SET fenster_breite = 560, fenster_hoehe = 420, tabelle = ''nachschlage'' ' +
    'WHERE id = 7 AND kuerzel = ''einheit''');

  if ParameterLesen('nachschlage_rechte_v7', '') = '' then
  begin
    for RolleId := 1 to 3 do
    begin
      case RolleId of
        1: begin
             Sehen := 1; Neu := 1; Aendern := 1; Loeschen := 1;
           end;
        2: begin
             Sehen := 1; Neu := 1; Aendern := 1; Loeschen := 0;
           end;
      else
        begin
          Sehen := 1; Neu := 1; Aendern := 0; Loeschen := 0;
        end;
      end;
      Direkt(
        'UPDATE maskenrecht SET sehen = ' + IntToStr(Sehen) + ', neu = ' + IntToStr(Neu) +
        ', aendern = ' + IntToStr(Aendern) + ', loeschen = ' + IntToStr(Loeschen) +
        ', kopieren = ' + IntToStr(Neu) + ' WHERE maske_id = 7 AND rolle_id = ' +
        IntToStr(RolleId));
    end;
    ParameterSetzen('nachschlage_rechte_v7', '1');
  end;

  for RolleId := 1 to 3 do
    for MaskeId := 9 to 11 do
    begin
      case RolleId of
        1: begin
             Sehen := 1; Neu := 1; Aendern := 1; Loeschen := 1;
           end;
        2: begin
             Sehen := 1; Neu := 1; Aendern := 1; Loeschen := 0;
           end;
      else
        begin
          Sehen := 1; Neu := 1; Aendern := 0; Loeschen := 0;
        end;
      end;
      Direkt(
        'INSERT INTO maskenrecht (rolle_id, maske_id, sehen, neu, aendern, loeschen, kopieren) ' +
        'SELECT ' + IntToStr(RolleId) + ', ' + IntToStr(MaskeId) + ', ' +
        IntToStr(Sehen) + ', ' + IntToStr(Neu) + ', ' + IntToStr(Aendern) + ', ' +
        IntToStr(Loeschen) + ', ' + IntToStr(Neu) +
        ' WHERE NOT EXISTS (SELECT 1 FROM maskenrecht WHERE rolle_id = ' +
        IntToStr(RolleId) + ' AND maske_id = ' + IntToStr(MaskeId) + ')');
    end;

  for MaskeId := 7 to 7 do
  begin
    Taste(MaskeId, 2, 'Neu', 'neu');
    Taste(MaskeId, 5, 'Kopieren', 'kopieren');
    Taste(MaskeId, 6, 'Ändern', 'aendern');
    Taste(MaskeId, 8, 'Löschen', 'loeschen');
  end;
  for MaskeId := 9 to 11 do
  begin
    Taste(MaskeId, 2, 'Neu', 'neu');
    Taste(MaskeId, 5, 'Kopieren', 'kopieren');
    Taste(MaskeId, 6, 'Ändern', 'aendern');
    Taste(MaskeId, 8, 'Löschen', 'loeschen');
  end;
end;

procedure TPlanlosDatenbank.ProjektTextSchema;
var
  RolleId, MaskeId, Sehen, Neu, Aendern, Loeschen: Integer;

  procedure Spalte(const Tabelle, Name, Definition: string);
  begin
    if Ganzzahl(
      'SELECT COUNT(*) FROM pragma_table_info(' + QuotedStr(Tabelle) +
      ') WHERE name = ' + QuotedStr(Name)) = 0 then
      Direkt('ALTER TABLE ' + Tabelle + ' ADD COLUMN ' + Name + ' ' + Definition);
  end;

  procedure Maske(Id, Links, Oben, Breite, Hoehe, Sortierung: Integer;
    const Kuerzel, Bezeichnung, Tabelle: string);
  begin
    Direkt(
      'INSERT INTO maske (id, kuerzel, bezeichnung, tabelle, kategorie_id, ' +
      'fenster_links, fenster_oben, fenster_breite, fenster_hoehe, sortierung) SELECT ' +
      IntToStr(Id) + ', ' + QuotedStr(Kuerzel) + ', ' + QuotedStr(Bezeichnung) + ', ' +
      QuotedStr(Tabelle) + ', NULL, ' + IntToStr(Links) + ', ' + IntToStr(Oben) + ', ' +
      IntToStr(Breite) + ', ' + IntToStr(Hoehe) + ', ' + IntToStr(Sortierung) +
      ' WHERE NOT EXISTS (SELECT 1 FROM maske WHERE id = ' + IntToStr(Id) + ')');
  end;

  procedure Taste(MaskeId, TasteNr, Erlaubt: Integer; const Beschriftung, Aktion: string);
  begin
    Direkt(
      'INSERT INTO tastenbelegung (maske_id, kontext, ebene, taste, beschriftung, ' +
      'aktion, erlaubt) SELECT ' + IntToStr(MaskeId) + ', ''suche'', 1, ' +
      IntToStr(TasteNr) + ', ' + QuotedStr(Beschriftung) + ', ' + QuotedStr(Aktion) +
      ', ' + IntToStr(Erlaubt) + ' WHERE NOT EXISTS (SELECT 1 FROM tastenbelegung ' +
      'WHERE maske_id = ' + IntToStr(MaskeId) +
      ' AND kontext = ''suche'' AND ebene = 1 AND taste = ' + IntToStr(TasteNr) + ')');
  end;

begin
  Direkt(
    'CREATE TABLE IF NOT EXISTS projekt (' +
    'id INTEGER PRIMARY KEY, ' +
    'bezeichnung TEXT NOT NULL, ' +
    'kunde_id INTEGER REFERENCES adresse(id), ' +
    'gruppierung TEXT, ' +
    'bearbeiter_id INTEGER REFERENCES adresse(id), ' +
    'notiz TEXT, ' +
    'erfasst TEXT, ' +
    'geaendert TEXT)');
  Direkt(
    'CREATE TABLE IF NOT EXISTS textbaustein (' +
    'id INTEGER PRIMARY KEY, ' +
    'modulart TEXT NOT NULL DEFAULT ''Standard'', ' +
    'benutzer TEXT, ' +
    'textart TEXT NOT NULL, ' +
    'beschreibung TEXT, ' +
    'inhalt TEXT NOT NULL)');
  Spalte('beleg', 'projekt_stamm_id', 'INTEGER');
  Spalte('beleg', 'kopf_baustein_id', 'INTEGER');
  Spalte('beleg', 'fuss_baustein_id', 'INTEGER');

  Maske(12, 26, 9, 620, 480, 120, 'projekt', 'Projekt', 'projekt');
  Maske(13, 52, 18, 700, 480, 130, 'textbaustein', 'Textbaustein', 'textbaustein');
  Maske(14, 80, 40, 420, 360, 140, 'modulart', 'Modulart', 'modulart');
  Maske(15, 80, 40, 420, 360, 150, 'benutzer', 'Benutzer', 'benutzer');

  for RolleId := 1 to 3 do
    for MaskeId := 12 to 15 do
    begin
      if MaskeId >= 14 then
      begin
        Sehen := 1; Neu := 0; Aendern := 0; Loeschen := 0;
      end
      else
        case RolleId of
          1: begin
               Sehen := 1; Neu := 1; Aendern := 1; Loeschen := 1;
             end;
          2: begin
               Sehen := 1; Neu := 1; Aendern := 1; Loeschen := 0;
             end;
        else
          begin
            Sehen := 1; Neu := 1; Aendern := 0; Loeschen := 0;
          end;
        end;
      Direkt(
        'INSERT INTO maskenrecht (rolle_id, maske_id, sehen, neu, aendern, loeschen, kopieren) ' +
        'SELECT ' + IntToStr(RolleId) + ', ' + IntToStr(MaskeId) + ', ' +
        IntToStr(Sehen) + ', ' + IntToStr(Neu) + ', ' + IntToStr(Aendern) + ', ' +
        IntToStr(Loeschen) + ', ' + IntToStr(Neu) +
        ' WHERE NOT EXISTS (SELECT 1 FROM maskenrecht WHERE rolle_id = ' +
        IntToStr(RolleId) + ' AND maske_id = ' + IntToStr(MaskeId) + ')');
    end;

  for MaskeId := 12 to 13 do
  begin
    Taste(MaskeId, 2, 1, 'Neu', 'neu');
    Taste(MaskeId, 5, 1, 'Kopieren', 'kopieren');
    Taste(MaskeId, 6, 1, 'Ändern', 'aendern');
    Taste(MaskeId, 8, 1, 'Löschen', 'loeschen');
  end;
end;

procedure TPlanlosDatenbank.MaskenAnlegen;

  procedure Spalte(const Tabelle, Name, Definition: string);
  begin
    if Ganzzahl(
      'SELECT COUNT(*) FROM pragma_table_info(' + QuotedStr(Tabelle) +
      ') WHERE name = ' + QuotedStr(Name)) = 0 then
      Direkt('ALTER TABLE ' + Tabelle + ' ADD COLUMN ' + Name + ' ' + Definition);
  end;

  procedure Maske(Id, Kategorie, Links, Oben, Breite, Hoehe, Sortierung: Integer;
    const Kuerzel, Bezeichnung: string);
  begin
    Direkt(
      'INSERT INTO maske (id, kuerzel, bezeichnung, tabelle, kategorie_id, ' +
      'fenster_links, fenster_oben, fenster_breite, fenster_hoehe, sortierung) SELECT ' +
      IntToStr(Id) + ', ' + QuotedStr(Kuerzel) + ', ' + QuotedStr(Bezeichnung) +
      ', ''adresse'', ' + IntToStr(Kategorie) + ', ' + IntToStr(Links) + ', ' +
      IntToStr(Oben) + ', ' + IntToStr(Breite) + ', ' + IntToStr(Hoehe) + ', ' +
      IntToStr(Sortierung) +
      ' WHERE NOT EXISTS (SELECT 1 FROM maske WHERE id = ' + IntToStr(Id) + ')');
  end;

  procedure Feld(MaskeId, Reihenfolge: Integer; const Spalte, Beschriftung: string;
    Sichtbar, Pflicht, InListe, Breite: Integer);
  begin
    Direkt(
      'INSERT INTO maskenfeld (maske_id, spalte, beschriftung, reihenfolge, ' +
      'sichtbar, pflicht, in_liste, breite) SELECT ' +
      IntToStr(MaskeId) + ', ' + QuotedStr(Spalte) + ', ' + QuotedStr(Beschriftung) +
      ', ' + IntToStr(Reihenfolge) + ', ' + IntToStr(Sichtbar) + ', ' +
      IntToStr(Pflicht) + ', ' + IntToStr(InListe) + ', ' + IntToStr(Breite) +
      ' WHERE NOT EXISTS (SELECT 1 FROM maskenfeld WHERE maske_id = ' +
      IntToStr(MaskeId) + ' AND spalte = ' + QuotedStr(Spalte) + ')');
  end;

  procedure Felder(MaskeId: Integer; const Liste: string);
  var
    Zeilen, Teile: TStringList;
    i, Nr: Integer;
  begin
    Zeilen := TStringList.Create;
    Teile := TStringList.Create;
    try
      Zeilen.Text := Liste;
      Teile.StrictDelimiter := True;
      Teile.Delimiter := '|';
      Nr := 0;
      for i := 0 to Zeilen.Count - 1 do
      begin
        if Trim(Zeilen[i]) = '' then
          Continue;
        Teile.DelimitedText := Zeilen[i];
        if Teile.Count < 6 then
          raise Exception.Create('Maskenfeld unvollständig: ' + Zeilen[i]);
        Inc(Nr);
        Feld(MaskeId, Nr * 10, Teile[0], Teile[1], StrToInt(Teile[2]),
          StrToInt(Teile[3]), StrToInt(Teile[4]), StrToInt(Teile[5]));
      end;
    finally
      Teile.Free;
      Zeilen.Free;
    end;
  end;

  procedure Taste(MaskeId, Ebene, TasteNr, Erlaubt: Integer;
    const Kontext, Beschriftung, Aktion: string);
  begin
    Direkt(
      'INSERT INTO tastenbelegung (maske_id, kontext, ebene, taste, beschriftung, ' +
      'aktion, erlaubt) SELECT ' + IntToStr(MaskeId) + ', ' + QuotedStr(Kontext) +
      ', ' + IntToStr(Ebene) + ', ' + IntToStr(TasteNr) + ', ' +
      QuotedStr(Beschriftung) + ', ' + QuotedStr(Aktion) + ', ' + IntToStr(Erlaubt) +
      ' WHERE NOT EXISTS (SELECT 1 FROM tastenbelegung WHERE maske_id = ' +
      IntToStr(MaskeId) + ' AND kontext = ' + QuotedStr(Kontext) +
      ' AND ebene = ' + IntToStr(Ebene) + ' AND taste = ' + IntToStr(TasteNr) + ')');
  end;

  procedure TastenFuer(MaskeId, LoeschenFrei: Integer);
  begin
    Taste(MaskeId, 1, 1, 1, 'suche', 'Hilfe', 'hilfe');
    Taste(MaskeId, 1, 2, 1, 'suche', 'Neu', 'neu');
    Taste(MaskeId, 1, 5, 1, 'suche', 'Kopieren', 'kopieren');
    Taste(MaskeId, 1, 6, 1, 'suche', 'Ändern', 'aendern');
    Taste(MaskeId, 1, 8, LoeschenFrei, 'suche', 'Löschen', 'loeschen');
    Taste(MaskeId, 1, 10, 1, 'suche', 'Übernehmen', 'uebernehmen');
    Taste(MaskeId, 1, 12, 1, 'suche', 'Schließen', 'schliessen');
    Taste(MaskeId, 1, 1, 1, 'eingabe', 'Hilfe', 'hilfe');
    Taste(MaskeId, 1, 4, 1, 'eingabe', 'Suchen', 'auswahl');
    Taste(MaskeId, 1, 10, 1, 'eingabe', 'Speichern', 'speichern');
    Taste(MaskeId, 1, 12, 1, 'eingabe', 'Abbrechen', 'abbrechen');
  end;

const
  { Beschriftungen und die spätere Anordnung kommen aus UnitAdresse.dfm.
    Sichtbar und Pflicht bleiben je Maske verschieden. }
  FelderKunde =
    'kategorie|Kategorie>|1|0|0|80'#10 +
    'nachname|Nachname|1|1|1|140'#10 +
    'vorname|Vorname:|1|0|1|120'#10 +
    'titel|Titel:|1|0|0|80'#10 +
    'firma|Firma:|1|0|1|180'#10 +
    'telefon|Tel_Firma:|1|0|1|120'#10 +
    'telefon_privat|Tel_Privat:|1|0|0|120'#10 +
    'telefax|Tel_Fax:|1|0|0|120'#10 +
    'telefon_andere|Tel_Andere:|1|0|0|120'#10 +
    'email|E_Mail:|1|0|1|180'#10 +
    'strasse|Strasse_Nr.:|1|0|0|200'#10 +
    'plz|PLZ:|1|0|1|70'#10 +
    'ort|Ort:|1|0|1|140'#10 +
    'land|Land:|1|0|0|120'#10 +
    'notiz|Notiz:|1|0|0|200'#10 +
    'adressblock|Adresse:|1|0|0|200'#10 +
    'frei1|Frei1:|1|0|0|80'#10 +
    'frei2|Frei2:|1|0|0|80'#10 +
    'frei3|Frei3:|1|0|0|80'#10 +
    'frei4|Frei4:|1|0|0|80'#10 +
    'rabatt_prozent|Rabatt %|1|0|0|80';
  FelderLieferant =
    'kategorie|Kategorie>|1|0|0|80'#10 +
    'nachname|Nachname|1|0|1|140'#10 +
    'vorname|Vorname:|1|0|1|120'#10 +
    'titel|Titel:|0|0|0|80'#10 +
    'firma|Firma:|1|1|1|180'#10 +
    'telefon|Tel_Firma:|1|0|1|120'#10 +
    'telefon_privat|Tel_Privat:|1|0|0|120'#10 +
    'telefax|Tel_Fax:|1|0|1|120'#10 +
    'telefon_andere|Tel_Andere:|1|0|0|120'#10 +
    'email|E_Mail:|1|0|1|180'#10 +
    'strasse|Strasse_Nr.:|1|0|0|200'#10 +
    'plz|PLZ:|1|0|1|70'#10 +
    'ort|Ort:|1|0|1|140'#10 +
    'land|Land:|1|0|0|120'#10 +
    'notiz|Notiz:|1|0|0|200'#10 +
    'adressblock|Adresse:|1|0|0|200'#10 +
    'frei1|Frei1:|1|0|0|80'#10 +
    'frei2|Frei2:|1|0|0|80'#10 +
    'frei3|Frei3:|1|0|0|80'#10 +
    'frei4|Frei4:|1|0|0|80'#10 +
    'rabatt_prozent|Rabatt %|0|0|0|80';
  FelderKontakt =
    'kategorie|Kategorie>|1|0|0|80'#10 +
    'nachname|Nachname|1|1|1|140'#10 +
    'vorname|Vorname:|1|1|1|120'#10 +
    'titel|Titel:|1|0|0|80'#10 +
    'firma|Firma:|1|0|1|160'#10 +
    'telefon|Tel_Firma:|1|0|1|120'#10 +
    'telefon_privat|Tel_Privat:|1|0|0|120'#10 +
    'telefax|Tel_Fax:|0|0|0|120'#10 +
    'telefon_andere|Tel_Andere:|1|0|0|120'#10 +
    'email|E_Mail:|1|0|1|180'#10 +
    'strasse|Strasse_Nr.:|1|0|0|200'#10 +
    'plz|PLZ:|1|0|0|70'#10 +
    'ort|Ort:|1|0|1|140'#10 +
    'land|Land:|0|0|0|120'#10 +
    'notiz|Notiz:|1|0|0|200'#10 +
    'adressblock|Adresse:|1|0|0|200'#10 +
    'frei1|Frei1:|1|0|0|80'#10 +
    'frei2|Frei2:|1|0|0|80'#10 +
    'frei3|Frei3:|1|0|0|80'#10 +
    'frei4|Frei4:|1|0|0|80'#10 +
    'rabatt_prozent|Rabatt %|0|0|0|80';
  FelderMitarbeiter =
    'kategorie|Kategorie>|1|0|0|80'#10 +
    'nachname|Nachname|1|1|1|140'#10 +
    'vorname|Vorname:|1|1|1|120'#10 +
    'titel|Titel:|1|0|0|80'#10 +
    'firma|Firma:|0|0|0|160'#10 +
    'telefon|Tel_Firma:|1|0|1|120'#10 +
    'telefon_privat|Tel_Privat:|1|0|0|120'#10 +
    'telefax|Tel_Fax:|0|0|0|120'#10 +
    'telefon_andere|Tel_Andere:|1|0|0|120'#10 +
    'email|E_Mail:|1|0|1|180'#10 +
    'strasse|Strasse_Nr.:|1|0|0|200'#10 +
    'plz|PLZ:|1|0|1|70'#10 +
    'ort|Ort:|1|0|1|140'#10 +
    'land|Land:|1|0|0|120'#10 +
    'notiz|Notiz:|1|0|0|200'#10 +
    'adressblock|Adresse:|1|0|0|200'#10 +
    'frei1|Frei1:|1|0|0|80'#10 +
    'frei2|Frei2:|1|0|0|80'#10 +
    'frei3|Frei3:|1|0|0|80'#10 +
    'frei4|Frei4:|1|0|0|80'#10 +
    'rabatt_prozent|Rabatt %|0|0|0|80';
  { spalte|beschriftung|links|oben|breite|hoehe|art|hintergrund
    Maße der Eingabefelder aus UnitAdresse.dfm. }
  LayoutAdresse =
    'kategorie|Kategorie>|79|28|140|21|auswahl|'#10 +
    'nachname|Nachname|79|50|265|21|zeile|'#10 +
    'vorname|Vorname:|79|72|265|21|zeile|'#10 +
    'titel|Titel:|79|94|265|21|zeile|'#10 +
    'firma|Firma:|79|116|265|21|zeile|lime'#10 +
    'telefon|Tel_Firma:|79|138|140|21|zeile|'#10 +
    'telefon_privat|Tel_Privat:|79|160|140|21|zeile|'#10 +
    'telefax|Tel_Fax:|79|182|140|21|zeile|'#10 +
    'telefon_andere|Tel_Andere:|79|204|140|21|zeile|'#10 +
    'email|E_Mail:|79|226|265|21|zeile|'#10 +
    'strasse|Strasse_Nr.:|79|248|265|21|zeile|'#10 +
    'plz|PLZ:|79|270|140|21|zeile|'#10 +
    'ort|Ort:|79|292|265|21|zeile|'#10 +
    'land|Land:|79|314|265|21|zeile|'#10 +
    'notiz|Notiz:|455|58|185|89|memo|'#10 +
    'adressblock|Adresse:|455|148|185|89|memo|'#10 +
    'frei1|Frei1:|455|242|265|21|zeile|'#10 +
    'frei2|Frei2:|455|264|265|21|zeile|'#10 +
    'frei3|Frei3:|455|286|265|21|zeile|'#10 +
    'frei4|Frei4:|455|308|265|21|zeile|'#10 +
    'rabatt_prozent|Rabatt %|455|332|120|21|zeile|';

var
  RolleId, MaskeId, Sehen, Neu, Aendern, Loeschen, i: Integer;
  Zeilen, Teile: TStringList;
  Hintergrund: string;
begin
  Direkt(
    'CREATE TABLE IF NOT EXISTS maske (' +
    'id INTEGER PRIMARY KEY, ' +
    'kuerzel TEXT NOT NULL UNIQUE, ' +
    'bezeichnung TEXT NOT NULL, ' +
    'tabelle TEXT NOT NULL, ' +
    'kategorie_id INTEGER REFERENCES adresskategorie(id), ' +
    'fenster_links INTEGER NOT NULL DEFAULT 0, ' +
    'fenster_oben INTEGER NOT NULL DEFAULT 0, ' +
    'fenster_breite INTEGER NOT NULL DEFAULT 720, ' +
    'fenster_hoehe INTEGER NOT NULL DEFAULT 480, ' +
    'sortierung INTEGER NOT NULL DEFAULT 0, ' +
    'aktiv INTEGER NOT NULL DEFAULT 1)');
  Spalte('maske', 'neu_an', 'INTEGER NOT NULL DEFAULT 1');
  Spalte('maske', 'kopieren_an', 'INTEGER NOT NULL DEFAULT 1');
  Spalte('maske', 'aendern_an', 'INTEGER NOT NULL DEFAULT 1');
  Spalte('maske', 'loeschen_an', 'INTEGER NOT NULL DEFAULT 1');

  Direkt(
    'CREATE TABLE IF NOT EXISTS maskenfeld (' +
    'id INTEGER PRIMARY KEY, ' +
    'maske_id INTEGER NOT NULL REFERENCES maske(id), ' +
    'spalte TEXT NOT NULL, ' +
    'beschriftung TEXT NOT NULL, ' +
    'reihenfolge INTEGER NOT NULL DEFAULT 0, ' +
    'sichtbar INTEGER NOT NULL DEFAULT 1, ' +
    'pflicht INTEGER NOT NULL DEFAULT 0, ' +
    'in_liste INTEGER NOT NULL DEFAULT 1, ' +
    'breite INTEGER NOT NULL DEFAULT 120, ' +
    'links INTEGER NOT NULL DEFAULT 0, ' +
    'oben INTEGER NOT NULL DEFAULT 0, ' +
    'feldbreite INTEGER NOT NULL DEFAULT 0, ' +
    'feldhoehe INTEGER NOT NULL DEFAULT 0, ' +
    'feldart TEXT NOT NULL DEFAULT ''zeile'', ' +
    'hintergrund TEXT NOT NULL DEFAULT '''', ' +
    'UNIQUE (maske_id, spalte))');

  Direkt(
    'CREATE TABLE IF NOT EXISTS tastenbelegung (' +
    'id INTEGER PRIMARY KEY, ' +
    'maske_id INTEGER NOT NULL REFERENCES maske(id), ' +
    'kontext TEXT NOT NULL, ' +
    'ebene INTEGER NOT NULL, ' +
    'taste INTEGER NOT NULL, ' +
    'beschriftung TEXT NOT NULL, ' +
    'aktion TEXT NOT NULL, ' +
    'erlaubt INTEGER NOT NULL DEFAULT 1, ' +
    'UNIQUE (maske_id, kontext, ebene, taste))');

  Direkt(
    'CREATE TABLE IF NOT EXISTS maskenrecht (' +
    'id INTEGER PRIMARY KEY, ' +
    'rolle_id INTEGER NOT NULL REFERENCES rolle(id), ' +
    'maske_id INTEGER NOT NULL REFERENCES maske(id), ' +
    'sehen INTEGER NOT NULL DEFAULT 0, ' +
    'neu INTEGER NOT NULL DEFAULT 0, ' +
    'aendern INTEGER NOT NULL DEFAULT 0, ' +
    'loeschen INTEGER NOT NULL DEFAULT 0, ' +
    'kopieren INTEGER NOT NULL DEFAULT 1, ' +
    'UNIQUE (rolle_id, maske_id))');
  Spalte('maskenrecht', 'kopieren', 'INTEGER NOT NULL DEFAULT 1');

  if Ganzzahl(
    'SELECT COUNT(*) FROM pragma_table_info(''maskenfeld'') WHERE name = ''links''') = 0 then
  begin
    Direkt('ALTER TABLE maskenfeld ADD COLUMN links INTEGER NOT NULL DEFAULT 0');
    Direkt('ALTER TABLE maskenfeld ADD COLUMN oben INTEGER NOT NULL DEFAULT 0');
    Direkt('ALTER TABLE maskenfeld ADD COLUMN feldbreite INTEGER NOT NULL DEFAULT 0');
    Direkt('ALTER TABLE maskenfeld ADD COLUMN feldhoehe INTEGER NOT NULL DEFAULT 0');
    Direkt('ALTER TABLE maskenfeld ADD COLUMN feldart TEXT NOT NULL DEFAULT ''zeile''');
    Direkt('ALTER TABLE maskenfeld ADD COLUMN hintergrund TEXT NOT NULL DEFAULT ''''');
  end;

  Direkt('CREATE INDEX IF NOT EXISTS idx_maskenfeld_maske ON maskenfeld(maske_id)');
  Direkt('CREATE INDEX IF NOT EXISTS idx_taste_maske ON tastenbelegung(maske_id)');

  Maske(1, 1, 40, 30, 860, 560, 10, 'kunde', 'Kunde');
  Maske(2, 2, 70, 50, 840, 540, 20, 'lieferant', 'Lieferant');
  Maske(3, 3, 100, 70, 720, 500, 30, 'kontakt', 'Kontakt');
  Maske(4, 4, 130, 90, 700, 520, 40, 'mitarbeiter', 'Mitarbeiter');

  Felder(1, FelderKunde);
  Felder(2, FelderLieferant);
  Felder(3, FelderKontakt);
  Felder(4, FelderMitarbeiter);

  TastenFuer(1, 1);
  TastenFuer(2, 1);
  { Kontakte: Löschen ist in der Tastenbelegung aus. Zusätzlich
    entscheidet maskenrecht nach der Anmeldung. }
  TastenFuer(3, 0);
  TastenFuer(4, 1);

  for RolleId := 1 to 3 do
    for MaskeId := 1 to 4 do
    begin
      case RolleId of
        1: begin
             Sehen := 1; Neu := 1; Aendern := 1; Loeschen := 1;
           end;
        2: begin
             Sehen := 1; Neu := 1; Aendern := 1; Loeschen := 0;
           end;
      else
        begin
          Sehen := 1; Neu := 1; Aendern := 0; Loeschen := 0;
        end;
      end;
      Direkt(
        'INSERT INTO maskenrecht (rolle_id, maske_id, sehen, neu, aendern, loeschen, kopieren) ' +
        'SELECT ' + IntToStr(RolleId) + ', ' + IntToStr(MaskeId) + ', ' +
        IntToStr(Sehen) + ', ' + IntToStr(Neu) + ', ' + IntToStr(Aendern) + ', ' +
        IntToStr(Loeschen) + ', ' + IntToStr(Neu) +
        ' WHERE NOT EXISTS (SELECT 1 FROM maskenrecht WHERE rolle_id = ' +
        IntToStr(RolleId) + ' AND maske_id = ' + IntToStr(MaskeId) + ')');
    end;
  if ParameterLesen('maskenrecht_kopieren_v5', '') = '' then
  begin
    Direkt('UPDATE maskenrecht SET kopieren = neu');
    ParameterSetzen('maskenrecht_kopieren_v5', '1');
  end;

  if ParameterLesen('masken_layout_v4', '') = '' then
  begin
    Zeilen := TStringList.Create;
    Teile := TStringList.Create;
    try
      Zeilen.Text := LayoutAdresse;
      Teile.StrictDelimiter := True;
      Teile.Delimiter := '|';
      for i := 0 to Zeilen.Count - 1 do
      begin
        if Trim(Zeilen[i]) = '' then
          Continue;
        Teile.DelimitedText := Zeilen[i];
        if Teile.Count < 7 then
          raise Exception.Create('Maskenlayout unvollständig: ' + Zeilen[i]);
        if Teile.Count > 7 then
          Hintergrund := Teile[7]
        else
          Hintergrund := '';
        Direkt(
          'UPDATE maskenfeld SET beschriftung = ' + QuotedStr(Teile[1]) +
          ', links = ' + Teile[2] + ', oben = ' + Teile[3] +
          ', feldbreite = ' + Teile[4] + ', feldhoehe = ' + Teile[5] +
          ', feldart = ' + QuotedStr(Teile[6]) +
          ', hintergrund = ' + QuotedStr(Hintergrund) +
          ' WHERE spalte = ' + QuotedStr(Teile[0]));
      end;
    finally
      Teile.Free;
      Zeilen.Free;
    end;
    ParameterSetzen('masken_layout_v4', '1');
  end;
end;

procedure TPlanlosDatenbank.BelegSchema;

  procedure Spalte(const Tabelle, Name, Definition: string);
  begin
    if Ganzzahl(
      'SELECT COUNT(*) FROM pragma_table_info(' + QuotedStr(Tabelle) +
      ') WHERE name = ' + QuotedStr(Name)) = 0 then
      Direkt('ALTER TABLE ' + Tabelle + ' ADD COLUMN ' + Name + ' ' + Definition);
  end;

  procedure Folge(VonId, NachId: Integer);
  begin
    Direkt(
      'INSERT INTO folgebeleg (von_modulart_id, nach_modulart_id) SELECT ' +
      IntToStr(VonId) + ', ' + IntToStr(NachId) +
      ' WHERE NOT EXISTS (SELECT 1 FROM folgebeleg WHERE von_modulart_id = ' +
      IntToStr(VonId) + ' AND nach_modulart_id = ' + IntToStr(NachId) + ')');
  end;

  procedure Taste(ModulartId, Ebene, TasteNr, Erlaubt: Integer;
    const Kontext, Beschriftung, Aktion: string);
  begin
    Direkt(
      'INSERT INTO belegtaste (modulart_id, kontext, ebene, taste, beschriftung, ' +
      'aktion, erlaubt) SELECT ' + IntToStr(ModulartId) + ', ' + QuotedStr(Kontext) +
      ', ' + IntToStr(Ebene) + ', ' + IntToStr(TasteNr) + ', ' +
      QuotedStr(Beschriftung) + ', ' + QuotedStr(Aktion) + ', ' + IntToStr(Erlaubt) +
      ' WHERE NOT EXISTS (SELECT 1 FROM belegtaste WHERE modulart_id = ' +
      IntToStr(ModulartId) + ' AND kontext = ' + QuotedStr(Kontext) +
      ' AND ebene = ' + IntToStr(Ebene) + ' AND taste = ' + IntToStr(TasteNr) + ')');
  end;

  procedure TastenSuche(ModulartId: Integer);
  begin
    Taste(ModulartId, 1, 1, 1, 'suche', 'Hilfe', 'hilfe');
    Taste(ModulartId, 1, 2, 1, 'suche', 'Neu', 'neu');
    Taste(ModulartId, 1, 4, 1, 'suche', 'Suchen', 'filtern');
    Taste(ModulartId, 1, 5, 1, 'suche', 'Kopieren', 'kopieren');
    Taste(ModulartId, 1, 6, 1, 'suche', 'Öffnen', 'oeffnen');
    Taste(ModulartId, 1, 8, 1, 'suche', 'Löschen', 'loeschen');
    Taste(ModulartId, 1, 10, 1, 'suche', 'Übernehmen', 'uebernehmen');
    Taste(ModulartId, 1, 12, 1, 'suche', 'Schließen', 'schliessen');
  end;

  procedure TastenBeleg(ModulartId, Empfaenger, Positionen: Integer);
  begin
    Taste(ModulartId, 1, 1, 1, 'beleg', 'Hilfe', 'hilfe');
    Taste(ModulartId, 1, 3, Empfaenger, 'beleg', 'Empfänger', 'empfaenger');
    Taste(ModulartId, 1, 5, Positionen, 'beleg', 'Position', 'position');
    Taste(ModulartId, 1, 8, Positionen, 'beleg', 'Entfernen', 'position_weg');
    Taste(ModulartId, 1, 10, 1, 'beleg', 'Speichern', 'speichern');
    Taste(ModulartId, 1, 12, 1, 'beleg', 'Schließen', 'schliessen');
  end;

begin
  Spalte('modulart', 'bereich_positionen', 'INTEGER NOT NULL DEFAULT 1');
  Spalte('modulart', 'mwst', 'INTEGER NOT NULL DEFAULT 1');
  Spalte('modulart', 'empfaenger_maske', 'TEXT NOT NULL DEFAULT ''''');
  Spalte('modulart', 'beschriftung_empfaenger', 'TEXT NOT NULL DEFAULT ''''');
  Spalte('modulart', 'nummer_naechste', 'INTEGER NOT NULL DEFAULT 1');

  Direkt(
    'CREATE TABLE IF NOT EXISTS beleg (' +
    'id INTEGER PRIMARY KEY, ' +
    'modulart_id INTEGER NOT NULL REFERENCES modulart(id), ' +
    'nummer TEXT NOT NULL, ' +
    'adresse_id INTEGER REFERENCES adresse(id), ' +
    'bezeichnung TEXT, ' +
    'kopftext TEXT, ' +
    'fusstext TEXT, ' +
    'notiz TEXT, ' +
    'bezug_beleg_id INTEGER REFERENCES beleg(id), ' +
    'waehrung TEXT NOT NULL DEFAULT ''EUR'', ' +
    'mwst_rechnen INTEGER NOT NULL DEFAULT 1, ' +
    'bearbeiter_id INTEGER REFERENCES adresse(id), ' +
    'gruppierung TEXT, ' +
    'projekt_id INTEGER REFERENCES beleg(id), ' +
    'angelegt TEXT NOT NULL, ' +
    'geaendert TEXT NOT NULL)');
  Spalte('beleg', 'bearbeiter_id', 'INTEGER');
  Spalte('beleg', 'gruppierung', 'TEXT');
  Spalte('beleg', 'projekt_id', 'INTEGER');
  Direkt(
    'CREATE UNIQUE INDEX IF NOT EXISTS idx_beleg_nummer ON beleg(modulart_id, nummer)');
  Direkt(
    'CREATE TABLE IF NOT EXISTS belegposition (' +
    'id INTEGER PRIMARY KEY, ' +
    'beleg_id INTEGER NOT NULL REFERENCES beleg(id), ' +
    'position_nr INTEGER NOT NULL, ' +
    'artikel_id INTEGER, ' +
    'positionstext TEXT NOT NULL, ' +
    'menge_milli INTEGER NOT NULL, ' +
    'einheit TEXT, ' +
    'einzelpreis_cent INTEGER NOT NULL, ' +
    'mwst_satz INTEGER NOT NULL DEFAULT 0)');
  Direkt(
    'CREATE INDEX IF NOT EXISTS idx_belegposition_beleg ON belegposition(beleg_id)');
  Direkt(
    'CREATE TABLE IF NOT EXISTS folgebeleg (' +
    'id INTEGER PRIMARY KEY, ' +
    'von_modulart_id INTEGER NOT NULL REFERENCES modulart(id), ' +
    'nach_modulart_id INTEGER NOT NULL REFERENCES modulart(id), ' +
    'UNIQUE (von_modulart_id, nach_modulart_id))');
  Direkt(
    'CREATE TABLE IF NOT EXISTS belegtaste (' +
    'id INTEGER PRIMARY KEY, ' +
    'modulart_id INTEGER NOT NULL REFERENCES modulart(id), ' +
    'kontext TEXT NOT NULL, ' +
    'ebene INTEGER NOT NULL, ' +
    'taste INTEGER NOT NULL, ' +
    'beschriftung TEXT NOT NULL, ' +
    'aktion TEXT NOT NULL, ' +
    'erlaubt INTEGER NOT NULL DEFAULT 1, ' +
    'UNIQUE (modulart_id, kontext, ebene, taste))');

  if ParameterLesen('modulart_beleg_v3', '') = '' then
  begin
    Direkt(
      'UPDATE modulart SET empfaenger_maske = ''kunde'', ' +
      'beschriftung_empfaenger = ''Kunde'', mwst = 1, bereich_positionen = 1, ' +
      'fenster_links = 40, fenster_oben = 30, fenster_breite = 920, fenster_hoehe = 680 ' +
      'WHERE kuerzel = ''angebot''');
    Direkt(
      'UPDATE modulart SET empfaenger_maske = ''kunde'', ' +
      'beschriftung_empfaenger = ''Kunde'', mwst = 1, bereich_positionen = 1, ' +
      'fenster_links = 70, fenster_oben = 50, fenster_breite = 920, fenster_hoehe = 680 ' +
      'WHERE kuerzel = ''auftragsbestaetigung''');
    Direkt(
      'UPDATE modulart SET empfaenger_maske = ''lieferant'', ' +
      'beschriftung_empfaenger = ''Lieferant'', mwst = 1, bereich_positionen = 1, ' +
      'fenster_links = 100, fenster_oben = 70, fenster_breite = 900, fenster_hoehe = 660 ' +
      'WHERE kuerzel = ''bestellung''');
    Direkt(
      'UPDATE modulart SET empfaenger_maske = ''kunde'', ' +
      'beschriftung_empfaenger = ''Kunde'', mwst = 1, bereich_positionen = 1, ' +
      'fenster_links = 50, fenster_oben = 40, fenster_breite = 920, fenster_hoehe = 700 ' +
      'WHERE kuerzel = ''rechnung''');
    Direkt(
      'UPDATE modulart SET empfaenger_maske = '''', beschriftung_empfaenger = '''', ' +
      'mwst = 0, bereich_positionen = 0, bereich_summe = 0, bereich_fuss = 0, ' +
      'fenster_links = 130, fenster_oben = 80, fenster_breite = 720, fenster_hoehe = 460 ' +
      'WHERE kuerzel = ''projekt''');
    ParameterSetzen('modulart_beleg_v3', '1');
  end;

  Folge(1, 2);
  Folge(1, 4);
  Folge(2, 4);

  TastenSuche(1);
  TastenSuche(2);
  TastenSuche(3);
  TastenSuche(4);
  TastenSuche(5);
  TastenBeleg(1, 1, 1);
  TastenBeleg(2, 1, 1);
  TastenBeleg(3, 1, 1);
  TastenBeleg(4, 1, 1);
  TastenBeleg(5, 0, 0);
  Taste(1, 1, 6, 1, 'beleg', 'Auftrag', 'folge:auftragsbestaetigung');
  Taste(1, 1, 7, 1, 'beleg', 'Rechnung', 'folge:rechnung');
  Taste(2, 1, 6, 1, 'beleg', 'Rechnung', 'folge:rechnung');
end;

function TPlanlosDatenbank.Bericht: string;

  function Sichtbar(Kopf, Summe, Fuss: Integer): string;
  var
    Teile: string;
  begin
    Teile := '';
    if Kopf = 1 then
      Teile := 'Kopf';
    if Summe = 1 then
    begin
      if Teile <> '' then
        Teile := Teile + ', ';
      Teile := Teile + 'Summe';
    end;
    if Fuss = 1 then
    begin
      if Teile <> '' then
        Teile := Teile + ', ';
      Teile := Teile + 'Fuß';
    end;
    if Teile = '' then
      Result := 'ohne die drei Blöcke'
    else
      Result := 'sichtbar: ' + Teile;
  end;

  function RechtNamen(Sehen, Neu, Aendern, Loeschen, Drucken, Anzahl: Int64): string;
  var
    Ziel: string;
    procedure Dazu(const Name: string; Summe: Int64);
    begin
      if Summe <= 0 then
        Exit;
      if Ziel <> '' then
        Ziel := Ziel + ', ';
      if Summe = Anzahl then
        Ziel := Ziel + Name
      else
        Ziel := Ziel + Name + ' (teilweise)';
    end;
  begin
    Ziel := '';
    Dazu('sehen', Sehen);
    Dazu('neu', Neu);
    Dazu('ändern', Aendern);
    Dazu('löschen', Loeschen);
    Dazu('drucken', Drucken);
    if Ziel = '' then
      Ziel := 'keine Rechte';
    Result := Ziel;
  end;

var
  Zeilen: TStringList;
  Q: TSQLQuery;
  Trans: TSQLTransaction;
  Arten, Zeile, Vorgaenger: string;
begin
  Zeilen := TStringList.Create;
  try
    Zeilen.Add('Art: ' + ArtName + ', eine Datei auf diesem Rechner.');
    Zeilen.Add('Datei: ' + FPfad);
    Zeilen.Add('Schema: Version ' +
      Skalar('SELECT version FROM schema_info WHERE id = 1'));
    if ParameterLesen('kaskade', '1') = '1' then
      Zeile := 'ein'
    else
      Zeile := 'aus';
    Zeilen.Add('Kaskade: ' + Zeile + ' (Schritt ' +
      ParameterLesen('schritt_oben', '26') + ' nach unten, ' +
      ParameterLesen('schritt_links', '9') + ' nach rechts).');
    Zeilen.Add('Mehrwertsteuer, Startwert: ' +
      ParameterLesen('mwst_satz', '19') + ' Prozent. Noch ohne Berechnung.');
    Zeilen.Add('Installationskennung: ' + ParameterLesen('installation_id', ''));
    Zeilen.Add('Diese Kennung bleibt. Später erkennt daran eine andere ' +
      'Installation, ob sie einen Beleg schon übernommen hat.');
    Zeilen.Add('');
    Zeilen.Add('Belegarten:');

    Trans := TSQLTransaction(FTrans);
    Q := TSQLQuery.Create(nil);
    try
      Q.Database := TConn(FConn);
      Q.Transaction := Trans;
      Q.SQL.Text :=
        'SELECT m.bezeichnung, m.nummernkreis, m.bereich_kopf, m.bereich_summe, ' +
        'm.bereich_fuss, h.bezeichnung ' +
        'FROM modulart m LEFT JOIN modulart h ON h.id = m.hauptmodul_id ' +
        'ORDER BY m.sortierung, m.id';
      Q.Open;
      try
        while not Q.EOF do
        begin
          Zeile := '- ' + Q.Fields[0].AsString + ' (' + Q.Fields[1].AsString + ')';
          if not Q.Fields[5].IsNull then
            Zeile := Zeile + ', folgt auf ' + Q.Fields[5].AsString;
          Zeile := Zeile + ', ' + Sichtbar(Q.Fields[2].AsInteger,
            Q.Fields[3].AsInteger, Q.Fields[4].AsInteger);
          Zeilen.Add(Zeile);
          Q.Next;
        end;
      finally
        Q.Close;
      end;
      if Trans.Active then
        Trans.Commit;

      Q.SQL.Text := 'SELECT bezeichnung FROM adresskategorie ORDER BY id';
      Q.Open;
      try
        Arten := '';
        while not Q.EOF do
        begin
          if Arten <> '' then
            Arten := Arten + ', ';
          Arten := Arten + Q.Fields[0].AsString;
          Q.Next;
        end;
      finally
        Q.Close;
      end;
      if Trans.Active then
        Trans.Commit;
      Zeilen.Add('');
      Zeilen.Add('Adressarten: ' + Arten);
      Zeilen.Add('Adressen: ' + IntToStr(Ganzzahl('SELECT COUNT(*) FROM adresse')));
      Zeilen.Add('Kontaktmasken: ' +
        IntToStr(Ganzzahl('SELECT COUNT(*) FROM maske')) +
        ' (ein Fenster, je Maske andere Felder)');
      Zeilen.Add('');
      Zeilen.Add('Rollen:');

      Q.SQL.Text :=
        'SELECT r.bezeichnung, ' +
        'COALESCE(SUM(t.sehen), 0), COALESCE(SUM(t.neu), 0), ' +
        'COALESCE(SUM(t.aendern), 0), COALESCE(SUM(t.loeschen), 0), ' +
        'COALESCE(SUM(t.drucken), 0), COUNT(t.id) ' +
        'FROM rolle r LEFT JOIN recht t ON t.rolle_id = r.id ' +
        'GROUP BY r.id, r.bezeichnung ORDER BY r.id';
      Q.Open;
      try
        while not Q.EOF do
        begin
          Vorgaenger := RechtNamen(
            Q.Fields[1].AsLargeInt, Q.Fields[2].AsLargeInt, Q.Fields[3].AsLargeInt,
            Q.Fields[4].AsLargeInt, Q.Fields[5].AsLargeInt, Q.Fields[6].AsLargeInt);
          Zeilen.Add('- ' + Q.Fields[0].AsString + ': ' + Vorgaenger);
          Q.Next;
        end;
      finally
        Q.Close;
      end;
      if Trans.Active then
        Trans.Commit;
    finally
      Q.Free;
    end;

    Result := Zeilen.Text;
  finally
    Zeilen.Free;
  end;
end;

initialization
  { Auf Windows ist die normale Zeichentabelle nicht UTF-8.
    SQLite und die Quelltexte sind UTF-8. Diese Zuordnung sorgt dafür,
    dass Umlaute auf dem Weg in die Datenbank nicht verändert werden. }
  {$IFDEF MSWINDOWS}
  DefaultSystemCodePage := CP_UTF8;
  {$ENDIF}

end.
