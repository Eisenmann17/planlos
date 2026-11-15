unit uhaupt;

{ Hauptfenster von Planlos, angelehnt an UnitModule.dfm.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE.

  Oben die Reiter Explorer, Stammdaten, Einstellungen und Wartung/Hilfe.
  Unten die Tastenleiste. Die Belegarten und Kontaktarten kommen aus
  der Datenbank. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Menus,
  Graphics, Grids, ComCtrls, Calendar, LCLType, utastenleiste, ukindfenster,
  udatenbank, umaske, usuche, ueingabe, ubelegsuche;

type
  THauptfenster = class(TForm)
  private
    FSeiten: TPageControl;
    FText: TMemo;
    FStatus: TLabel;
    FFuss: TPanel;
    FTasten: TTastenleiste;
    FTakt: TTimer;
    FDbFehler: string;
    FSelbsttest: Boolean;
    FSelbsttestGelaufen: Boolean;
    FBereit: Boolean;
    FModul: TComboBox;
    FModulKuerzel: TStringList;
    FListe: TStringGrid;
    FIds: array of Int64;
    FZeilenArt: array of string;
    FNrFeld: TEdit;
    FFilterWahl: TButton;
    FJahr: TComboBox;
    FMonat: TComboBox;
    FKalender: TCalendar;
    FNeuLeiste: TScrollBox;
    FModulFilter: Integer;
    FZeitraum: Integer;
    FSonstiges: Integer;
    FSuchtext: string;
    FAdresseId: Int64;
    FProjektId: Int64;
    FBearbeiterId: Int64;
    FGruppe: string;
    procedure BaueMenue;
    procedure BaueSeiten;
    procedure BaueExplorer;
    procedure BaueStamm;
    procedure BaueEinstellung;
    procedure MenueBeenden(Sender: TObject);
    procedure MenueFenster(Sender: TObject);
    procedure MenueKaskade(Sender: TObject);
    procedure MenueAlleZu(Sender: TObject);
    procedure MenueHilfe(Sender: TObject);
    procedure MenueDatenbank(Sender: TObject);
    procedure MenueUeber(Sender: TObject);
    procedure MenueKunde(Sender: TObject);
    procedure MenueLieferant(Sender: TObject);
    procedure MenueKontakt(Sender: TObject);
    procedure MenueMitarbeiter(Sender: TObject);
    procedure MenueAngebot(Sender: TObject);
    procedure MenueAuftrag(Sender: TObject);
    procedure MenueBestellung(Sender: TObject);
    procedure MenueRechnung(Sender: TObject);
    procedure MenueProjekt(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure TaktTimer(Sender: TObject);
    procedure TasteAusfuehren(Sender: TObject; Ebene, Taste: Integer);
    procedure AnsichtNachziehen(Sender: TObject);
    procedure DatenbankOeffnen;
    procedure ModulListe;
    procedure NeuKnoepfe;
    procedure ExplorerLaden;
    procedure FilterModul(Sender: TObject);
    procedure FilterZeit(Sender: TObject);
    procedure FilterSonst(Sender: TObject);
    procedure FilterWahl(Sender: TObject);
    procedure NrGeaendert(Sender: TObject);
    procedure ZeitGeaendert(Sender: TObject);
    procedure ModulGewaehlt(Sender: TObject);
    procedure NeuBeleg(Sender: TObject);
    procedure ZeileOeffnen(Sender: TObject);
    procedure KontaktOeffnen(Sender: TObject);
    procedure KopfFarbe(Sender: TObject; ACol, ARow: Integer; AState: TGridDrawState);
    procedure JahreFuellen;
    function GewaehlteArt: string;
    procedure Selbsttest;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure AnsichtAktualisieren;
    function DatenbankOffen: Boolean;
  end;

var
  Hauptfenster: THauptfenster;

implementation

uses
  ubeleg, ubelegfenster, ubenutzer;

function Teile(const Zeile: string; Ziel: TStrings): Boolean;
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
  Result := Ziel.Count > 0;
end;

constructor THauptfenster.Create(TheOwner: TComponent);
begin
  inherited CreateNew(TheOwner, 1);
  Caption := 'Mein kleines Büro';
  Position := poScreenCenter;
  Width := 980;
  Height := 760;
  KeyPreview := True;
  Color := clBtnFace;
  Constraints.MinWidth := 860;
  Constraints.MinHeight := 640;
  OnKeyDown := @FormKeyDown;
  OnShow := @FormShow;

  FModulKuerzel := TStringList.Create;

  FFuss := TPanel.Create(Self);
  FFuss.Parent := Self;
  FFuss.Align := alBottom;
  FFuss.Height := 118;
  FFuss.BevelOuter := bvNone;
  FFuss.Caption := '';

  FStatus := TLabel.Create(Self);
  FStatus.Parent := FFuss;
  FStatus.Align := alBottom;
  FStatus.Height := 20;
  FStatus.AutoSize := False;
  FStatus.Layout := tlCenter;
  FStatus.Caption := 'Datenbank wird geöffnet …';
  FStatus.BorderSpacing.Left := 8;

  FTasten := TTastenleiste.Create(Self);
  FTasten.Parent := FFuss;
  FTasten.Align := alClient;
  FTasten.OnTaste := @TasteAusfuehren;
  StandardBelegung(FTasten);
  FTasten.SetzeText(1, 2, 'Neu');
  FTasten.SetzeText(1, 4, 'Kunden');
  FTasten.SetzeText(1, 6, 'Öffnen');

  BaueSeiten;
  BaueMenue;
  DatenbankOeffnen;
  WennAnsichtVeraltet := @AnsichtNachziehen;
  ModulListe;
  NeuKnoepfe;
  JahreFuellen;
  FBereit := True;
  ExplorerLaden;
  AnsichtAktualisieren;

  FTakt := TTimer.Create(Self);
  FTakt.Interval := 100;
  FTakt.OnTimer := @TaktTimer;
  FTakt.Enabled := True;

  FSelbsttest := GetEnvironmentVariable('PLANLOS_SELBSTTEST') = '1';
end;

destructor THauptfenster.Destroy;
begin
  FModulKuerzel.Free;
  inherited Destroy;
end;

function THauptfenster.DatenbankOffen: Boolean;
begin
  Result := FDbFehler = '';
end;

procedure THauptfenster.BaueSeiten;
var
  Reiter: TTabSheet;
begin
  FSeiten := TPageControl.Create(Self);
  FSeiten.Parent := Self;
  FSeiten.Align := alClient;

  Reiter := TTabSheet.Create(Self);
  Reiter.PageControl := FSeiten;
  Reiter.Caption := 'Explorer';
  BaueExplorer;

  Reiter := TTabSheet.Create(Self);
  Reiter.PageControl := FSeiten;
  Reiter.Caption := 'Stammdaten';
  BaueStamm;

  Reiter := TTabSheet.Create(Self);
  Reiter.PageControl := FSeiten;
  Reiter.Caption := 'Einstellungen';
  BaueEinstellung;

  Reiter := TTabSheet.Create(Self);
  Reiter.PageControl := FSeiten;
  Reiter.Caption := 'Wartung/Hilfe';
  FText := TMemo.Create(Self);
  FText.Parent := Reiter;
  FText.Align := alClient;
  FText.ReadOnly := True;
  FText.WordWrap := True;
  FText.ScrollBars := ssVertical;
  FText.TabStop := False;
  FText.BorderSpacing.Around := 8;
end;

procedure THauptfenster.BaueExplorer;

  function Gruppe(const Titel: string; Links, Oben, Breite, Hoehe: Integer): TGroupBox;
  begin
    Result := TGroupBox.Create(Self);
    Result.Parent := FSeiten.Pages[0];
    Result.Caption := Titel;
    Result.Left := Links;
    Result.Top := Oben;
    Result.Width := Breite;
    Result.Height := Hoehe;
  end;

  function Wahl(Eltern: TWinControl; const Titel: string;
    Links, Oben, Breite, Hoehe, Kennung: Integer; Farbe: TColor;
    Reaktion: TNotifyEvent): TRadioButton;
  begin
    Result := TRadioButton.Create(Self);
    Result.Parent := Eltern;
    Result.Caption := Titel;
    Result.Left := Links;
    Result.Top := Oben;
    Result.Width := Breite;
    Result.Height := Hoehe;
    Result.Tag := Kennung;
    Result.OnClick := Reaktion;
    if Farbe <> clNone then
    begin
      Result.Color := Farbe;
      Result.ParentColor := False;
    end;
  end;

var
  Eltern: TWinControl;
  Zeit, Filter, Sonst: TGroupBox;
  Knopf: TButton;
  Hinweis: TLabel;
begin
  Eltern := FSeiten.Pages[0];

  Hinweis := TLabel.Create(Self);
  Hinweis.Parent := Eltern;
  Hinweis.Left := 708;
  Hinweis.Top := 4;
  Hinweis.Caption := 'Neu';

  FModul := TComboBox.Create(Self);
  FModul.Parent := Eltern;
  FModul.Left := 0;
  FModul.Top := 0;
  FModul.Width := 225;
  FModul.Height := 28;
  FModul.Style := csDropDownList;
  FModul.Color := clAqua;
  FModul.Font.Height := -16;
  FModul.Font.Style := [fsBold];
  FModul.Font.Color := clTeal;
  FModul.OnChange := @ModulGewaehlt;

  Filter := Gruppe('Modul-Filter', 0, 36, 225, 158);
  Wahl(Filter, 'Alle', 8, 16, 200, 17, 0, clNone, @FilterModul).Checked := True;
  Wahl(Filter, 'Bezeichnung:', 3, 34, 82, 17, 1, clLime, @FilterModul);
  Wahl(Filter, 'Adressname:', 2, 58, 82, 17, 2, clTeal, @FilterModul);
  Wahl(Filter, 'Nr:', 2, 82, 82, 17, 3, clOlive, @FilterModul);
  Wahl(Filter, 'Projekte:', 2, 106, 82, 17, 4, clGreen, @FilterModul);

  FNrFeld := TEdit.Create(Self);
  FNrFeld.Parent := Filter;
  FNrFeld.Left := 87;
  FNrFeld.Top := 80;
  FNrFeld.Width := 130;
  FNrFeld.Height := 21;
  FNrFeld.Visible := False;
  FNrFeld.OnChange := @NrGeaendert;

  FFilterWahl := TButton.Create(Self);
  FFilterWahl.Parent := Filter;
  FFilterWahl.Left := 87;
  FFilterWahl.Top := 34;
  FFilterWahl.Width := 130;
  FFilterWahl.Height := 18;
  FFilterWahl.Caption := 'wählen';
  FFilterWahl.Visible := False;
  FFilterWahl.OnClick := @FilterWahl;

  Zeit := Gruppe('Modul Filter im Zeitbereich', 0, 198, 225, 210);
  Wahl(Zeit, 'Alle', 8, 16, 65, 22, 0, clNone, @FilterZeit).Checked := True;
  Wahl(Zeit, 'Jahr', 8, 40, 65, 22, 1, clNone, @FilterZeit);
  Wahl(Zeit, 'Monat', 8, 64, 65, 22, 2, clNone, @FilterZeit);
  Wahl(Zeit, 'Tag', 8, 88, 65, 22, 3, clNone, @FilterZeit);
  FJahr := TComboBox.Create(Self);
  FJahr.Parent := Zeit;
  FJahr.Left := 77;
  FJahr.Top := 40;
  FJahr.Width := 140;
  FJahr.Style := csDropDownList;
  FJahr.Visible := False;
  FJahr.OnChange := @ZeitGeaendert;
  FMonat := TComboBox.Create(Self);
  FMonat.Parent := Zeit;
  FMonat.Left := 77;
  FMonat.Top := 64;
  FMonat.Width := 140;
  FMonat.Style := csDropDownList;
  FMonat.Items.Add('Januar');
  FMonat.Items.Add('Februar');
  FMonat.Items.Add('März');
  FMonat.Items.Add('April');
  FMonat.Items.Add('Mai');
  FMonat.Items.Add('Juni');
  FMonat.Items.Add('Juli');
  FMonat.Items.Add('August');
  FMonat.Items.Add('September');
  FMonat.Items.Add('Oktober');
  FMonat.Items.Add('November');
  FMonat.Items.Add('Dezember');
  FMonat.ItemIndex := 0;
  FMonat.Visible := False;
  FMonat.OnChange := @ZeitGeaendert;
  FKalender := TCalendar.Create(Self);
  FKalender.Parent := Zeit;
  FKalender.Left := 77;
  FKalender.Top := 88;
  FKalender.Width := 145;
  FKalender.Height := 121;
  FKalender.Visible := False;
  FKalender.DateTime := Date;
  FKalender.OnChange := @ZeitGeaendert;

  Sonst := Gruppe('Modul-Filter Sonstiges', 0, 412, 225, 96);
  Wahl(Sonst, 'Alle', 8, 16, 210, 17, 0, clNone, @FilterSonst).Checked := True;
  Wahl(Sonst, 'Bearbeiter', 8, 32, 70, 17, 1, clNone, @FilterSonst);
  Wahl(Sonst, 'Gruppe', 8, 48, 70, 17, 2, clNone, @FilterSonst);

  FListe := TStringGrid.Create(Self);
  FListe.Parent := Eltern;
  FListe.Left := 232;
  FListe.Top := 3;
  FListe.Width := 460;
  FListe.Height := 453;
  FListe.FixedCols := 0;
  FListe.FixedRows := 1;
  FListe.ColCount := 9;
  FListe.RowCount := 2;
  FListe.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
    goRowSelect, goColSizing, goThumbTracking];
  FListe.OnDblClick := @ZeileOeffnen;
  FListe.OnPrepareCanvas := @KopfFarbe;
  FListe.Cells[0, 0] := 'Modulart';
  FListe.Cells[1, 0] := 'Bezeichnung';
  FListe.Cells[2, 0] := 'Adressname';
  FListe.Cells[3, 0] := 'Nr';
  FListe.Cells[4, 0] := 'Projektname';
  FListe.Cells[5, 0] := 'Erfassungsdatum';
  FListe.Cells[6, 0] := 'Bearbeiter';
  FListe.Cells[7, 0] := 'Gruppierung';
  FListe.Cells[8, 0] := 'LetzteBearbeitung';
  FListe.ColWidths[0] := 110;
  FListe.ColWidths[1] := 140;
  FListe.ColWidths[2] := 120;
  FListe.ColWidths[3] := 70;
  FListe.ColWidths[4] := 110;
  FListe.ColWidths[5] := 110;
  FListe.ColWidths[6] := 90;
  FListe.ColWidths[7] := 90;
  FListe.ColWidths[8] := 110;

  Knopf := TButton.Create(Self);
  Knopf.Parent := Eltern;
  Knopf.Left := 359;
  Knopf.Top := 464;
  Knopf.Width := 77;
  Knopf.Height := 20;
  Knopf.Caption := 'ändern';
  Knopf.OnClick := @ZeileOeffnen;

  Knopf := TButton.Create(Self);
  Knopf.Parent := Eltern;
  Knopf.Left := 720;
  Knopf.Top := 464;
  Knopf.Width := 140;
  Knopf.Height := 20;
  Knopf.Caption := 'Planlos Ende';
  Knopf.OnClick := @MenueBeenden;

  FNeuLeiste := TScrollBox.Create(Self);
  FNeuLeiste.Parent := Eltern;
  FNeuLeiste.Left := 700;
  FNeuLeiste.Top := 24;
  FNeuLeiste.Width := 168;
  FNeuLeiste.Height := 430;
  FNeuLeiste.HorzScrollBar.Visible := False;
end;

procedure THauptfenster.BaueStamm;

  function Knopf(const Titel, Kuerzel: string; Links, Oben: Integer): TButton;
  begin
    Result := TButton.Create(Self);
    Result.Parent := FSeiten.Pages[1];
    Result.Caption := Titel;
    Result.Hint := Kuerzel;
    Result.Left := Links;
    Result.Top := Oben;
    Result.Width := 120;
    Result.Height := 25;
    Result.OnClick := @KontaktOeffnen;
  end;

var
  Hinweis: TLabel;
begin
  Hinweis := TLabel.Create(Self);
  Hinweis.Parent := FSeiten.Pages[1];
  Hinweis.Left := 16;
  Hinweis.Top := 24;
  Hinweis.Caption := 'Kontakte';
  Hinweis.Font.Color := clNavy;
  Hinweis.Font.Height := -13;

  Knopf('Kunden', 'kunde', 139, 53);
  Knopf('Lieferant', 'lieferant', 139, 85);
  Knopf('Mitarbeiter', 'mitarbeiter', 139, 117);
  Knopf('Kontakt', 'kontakt', 139, 149);
end;

procedure THauptfenster.BaueEinstellung;
var
  Hinweis: TLabel;
begin
  Hinweis := TLabel.Create(Self);
  Hinweis.Parent := FSeiten.Pages[2];
  Hinweis.Left := 16;
  Hinweis.Top := 24;
  Hinweis.AutoSize := True;
  Hinweis.Caption :=
    'Angemeldet wird beim Start. Die Rolle steht in der Datenbank.' + LineEnding +
    'Das Passwort liegt nur als gesalzener Hash, nie im Klartext.' + LineEnding +
    LineEnding +
    'MwSt ist der Startwert für neue Belege. Druck, Fensterfarben und' + LineEnding +
    'die Server-Datenbank folgen später.';
end;

procedure THauptfenster.BaueMenue;
var
  Menue: TMainMenu;
  Datei, Fenster, Hilfe: TMenuItem;

  function Eintrag(Eltern: TMenuItem; const Titel: string;
    Reaktion: TNotifyEvent): TMenuItem;
  begin
    Result := TMenuItem.Create(Self);
    Result.Caption := Titel;
    Result.OnClick := Reaktion;
    Eltern.Add(Result);
  end;

begin
  Menue := TMainMenu.Create(Self);
  Menu := Menue;

  Datei := TMenuItem.Create(Self);
  Datei.Caption := '&Datei';
  Menue.Items.Add(Datei);
  Eintrag(Datei, '&Beenden', @MenueBeenden);

  Fenster := TMenuItem.Create(Self);
  Fenster.Caption := '&Fenster';
  Menue.Items.Add(Fenster);
  Eintrag(Fenster, '&Neues Fenster', @MenueFenster);
  Eintrag(Fenster, '&Kaskade umschalten', @MenueKaskade);
  Eintrag(Fenster, '&Alle Zusatzfenster schließen', @MenueAlleZu);

  Fenster := TMenuItem.Create(Self);
  Fenster.Caption := '&Adressen';
  Menue.Items.Add(Fenster);
  Eintrag(Fenster, '&Kunden', @MenueKunde);
  Eintrag(Fenster, '&Lieferanten', @MenueLieferant);
  Eintrag(Fenster, '&Kontakte', @MenueKontakt);
  Eintrag(Fenster, '&Mitarbeiter', @MenueMitarbeiter);

  Fenster := TMenuItem.Create(Self);
  Fenster.Caption := '&Belege';
  Menue.Items.Add(Fenster);
  Eintrag(Fenster, '&Angebot', @MenueAngebot);
  Eintrag(Fenster, 'Auftrags&bestätigung', @MenueAuftrag);
  Eintrag(Fenster, '&Bestellung', @MenueBestellung);
  Eintrag(Fenster, '&Rechnung', @MenueRechnung);
  Eintrag(Fenster, '&Projekt', @MenueProjekt);

  Hilfe := TMenuItem.Create(Self);
  Hilfe.Caption := '&Hilfe';
  Menue.Items.Add(Hilfe);
  Eintrag(Hilfe, '&Hilfe', @MenueHilfe);
  Eintrag(Hilfe, '&Datenbank', @MenueDatenbank);
  Eintrag(Hilfe, 'Über &Planlos', @MenueUeber);
end;

procedure THauptfenster.DatenbankOeffnen;
begin
  FDbFehler := '';
  try
    PlanlosDB := TPlanlosDatenbank.Create;
    PlanlosDB.VerbindenSQLite(PlanlosDatenDatei);
    PlanlosDB.SchemaSicherstellen;
  except
    on E: Exception do
      FDbFehler := E.Message;
  end;
end;

procedure THauptfenster.ModulListe;
var
  Spalten, Zeilen, Stueck: TStringList;
  i: Integer;
begin
  FModul.Items.Clear;
  FModulKuerzel.Clear;
  FModul.Items.Add('Alle');
  FModulKuerzel.Add('');
  if FDbFehler <> '' then
  begin
    FModul.ItemIndex := 0;
    Exit;
  end;
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  Stueck := TStringList.Create;
  try
    PlanlosDB.AlleZeilen(
      'SELECT kuerzel, bezeichnung FROM modulart WHERE aktiv = 1 ORDER BY sortierung, id',
      nil, Spalten, Zeilen);
    for i := 0 to Zeilen.Count - 1 do
    begin
      Teile(Zeilen[i], Stueck);
      if Stueck.Count < 2 then
        Continue;
      FModulKuerzel.Add(Stueck[0]);
      FModul.Items.Add(Stueck[1]);
    end;
  finally
    Stueck.Free;
    Zeilen.Free;
    Spalten.Free;
  end;
  FModul.ItemIndex := 0;
end;

procedure THauptfenster.NeuKnoepfe;
var
  i: Integer;
  Knopf: TButton;
begin
  while FNeuLeiste.ControlCount > 0 do
    FNeuLeiste.Controls[0].Free;
  for i := 1 to FModul.Items.Count - 1 do
  begin
    Knopf := TButton.Create(Self);
    Knopf.Parent := FNeuLeiste;
    Knopf.Left := 4;
    Knopf.Top := 7 + (i - 1) * 26;
    Knopf.Width := 150;
    Knopf.Height := 22;
    Knopf.Caption := FModul.Items[i];
    Knopf.Hint := FModulKuerzel[i];
    Knopf.OnClick := @NeuBeleg;
  end;
end;

procedure THauptfenster.JahreFuellen;
var
  Jahre: TStringList;
  Laufend: string;
begin
  FJahr.Items.Clear;
  Laufend := FormatDateTime('yyyy', Date);
  if FDbFehler = '' then
  begin
    Jahre := TStringList.Create;
    try
      ExplorerWerte('jahr', '', Jahre);
      FJahr.Items.Assign(Jahre);
    finally
      Jahre.Free;
    end;
  end;
  if FJahr.Items.IndexOf(Laufend) < 0 then
    FJahr.Items.Add(Laufend);
  FJahr.ItemIndex := FJahr.Items.IndexOf(Laufend);
  if FJahr.ItemIndex < 0 then
    FJahr.ItemIndex := 0;
  FMonat.ItemIndex := StrToIntDef(FormatDateTime('m', Date), 1) - 1;
end;

function THauptfenster.GewaehlteArt: string;
begin
  Result := '';
  if (FModul <> nil) and (FModul.ItemIndex >= 0) and
     (FModul.ItemIndex < FModulKuerzel.Count) then
    Result := FModulKuerzel[FModul.ItemIndex];
end;

procedure THauptfenster.ExplorerLaden;
var
  Filter: TExplorerFilter;
  Spalten, Zeilen, Stueck: TStringList;
  Zeile, Spalte: Integer;
begin
  if not FBereit then
    Exit;
  FListe.RowCount := 2;
  for Spalte := 0 to FListe.ColCount - 1 do
    FListe.Cells[Spalte, 1] := '';
  SetLength(FIds, 0);
  SetLength(FZeilenArt, 0);
  if FDbFehler <> '' then
    Exit;
  Filter := Default(TExplorerFilter);
  Filter.Modulart := GewaehlteArt;
  Filter.ModulFilter := TModulFilter(FModulFilter);
  Filter.Suchtext := FSuchtext;
  Filter.AdresseId := FAdresseId;
  Filter.ProjektId := FProjektId;
  Filter.Zeitraum := TZeitraum(FZeitraum);
  if FJahr.ItemIndex >= 0 then
    Filter.Jahr := StrToIntDef(FJahr.Items[FJahr.ItemIndex], 0);
  Filter.Monat := FMonat.ItemIndex + 1;
  Filter.Tag := FormatDateTime('yyyy-mm-dd', FKalender.DateTime);
  Filter.Sonstiges := TSonstiges(FSonstiges);
  Filter.BearbeiterId := FBearbeiterId;
  Filter.Gruppe := FGruppe;

  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  Stueck := TStringList.Create;
  try
    ExplorerLesen(Filter, Spalten, Zeilen);
    SetLength(FIds, Zeilen.Count);
    SetLength(FZeilenArt, Zeilen.Count);
    if Zeilen.Count = 0 then
      FListe.RowCount := 2
    else
      FListe.RowCount := Zeilen.Count + 1;
    for Zeile := 0 to Zeilen.Count - 1 do
    begin
      Teile(Zeilen[Zeile], Stueck);
      if Stueck.Count > 0 then
        FIds[Zeile] := StrToInt64Def(Stueck[0], 0);
      if Stueck.Count > 1 then
        FZeilenArt[Zeile] := Stueck[1];
      for Spalte := 0 to 8 do
        if Spalte + 2 < Stueck.Count then
          FListe.Cells[Spalte, Zeile + 1] := StringReplace(Stueck[Spalte + 2],
            'T', ' ', [])
        else
          FListe.Cells[Spalte, Zeile + 1] := '';
    end;
    if Zeilen.Count > 0 then
      FListe.Row := 1;
  finally
    Stueck.Free;
    Zeilen.Free;
    Spalten.Free;
  end;
end;

procedure THauptfenster.FilterModul(Sender: TObject);
begin
  if not FBereit or not TRadioButton(Sender).Checked then
    Exit;
  FModulFilter := TRadioButton(Sender).Tag;
  FSuchtext := '';
  FAdresseId := 0;
  FProjektId := 0;
  FNrFeld.Text := '';
  FNrFeld.Visible := FModulFilter = 3;
  FFilterWahl.Visible := FModulFilter in [1, 2, 4];
  FFilterWahl.Caption := 'wählen';
  case FModulFilter of
    1: FFilterWahl.Top := 34;
    2: FFilterWahl.Top := 58;
    4: FFilterWahl.Top := 106;
  end;
  ExplorerLaden;
end;

procedure THauptfenster.FilterZeit(Sender: TObject);
begin
  if not FBereit or not TRadioButton(Sender).Checked then
    Exit;
  FZeitraum := TRadioButton(Sender).Tag;
  FJahr.Visible := FZeitraum in [1, 2];
  FMonat.Visible := FZeitraum = 2;
  FKalender.Visible := FZeitraum = 3;
  ExplorerLaden;
end;

procedure THauptfenster.FilterSonst(Sender: TObject);
var
  Werte, Anzeige: TStringList;
  Index, i: Integer;
  Id: Int64;

  procedure AlleWieder;
  var
    n: Integer;
    Eltern: TWinControl;
  begin
    Eltern := TRadioButton(Sender).Parent;
    for n := 0 to Eltern.ControlCount - 1 do
      if (Eltern.Controls[n] is TRadioButton) and (TRadioButton(Eltern.Controls[n]).Tag = 0) then
        TRadioButton(Eltern.Controls[n]).Checked := True;
  end;

begin
  if not FBereit or not TRadioButton(Sender).Checked then
    Exit;
  FSonstiges := TRadioButton(Sender).Tag;
  if FSonstiges = 0 then
  begin
    FBearbeiterId := 0;
    FGruppe := '';
    ExplorerLaden;
    Exit;
  end;
  if FSonstiges = 1 then
  begin
    Id := AdressSucheWaehlen('mitarbeiter');
    if Id = 0 then
    begin
      AlleWieder;
      Exit;
    end;
    FBearbeiterId := Id;
    ExplorerLaden;
    Exit;
  end;
  Werte := TStringList.Create;
  Anzeige := TStringList.Create;
  try
    ExplorerWerte('gruppierung', GewaehlteArt, Werte);
    if Werte.Count = 0 then
    begin
      ShowMessage('Es ist noch keine Gruppe vergeben.');
      AlleWieder;
      Exit;
    end;
    for i := 0 to Werte.Count - 1 do
      Anzeige.Add(Werte[i]);
    if not ListeWaehlen('Gruppe aussuchen', Anzeige, Index) then
    begin
      AlleWieder;
      Exit;
    end;
    FGruppe := Werte[Index];
    ExplorerLaden;
  finally
    Anzeige.Free;
    Werte.Free;
  end;
end;

procedure THauptfenster.FilterWahl(Sender: TObject);
var
  Werte, Anzeige, Stueck: TStringList;
  i, Index, TabPos: Integer;
  Art: TBelegart;
  Maske, Zeile: string;
  Id: Int64;
begin
  if FModulFilter = 2 then
  begin
    Maske := 'kunde';
    if BelegartLaden(GewaehlteArt, Art) and (Art.EmpfaengerMaske <> '') then
      Maske := Art.EmpfaengerMaske;
    Id := AdressSucheWaehlen(Maske);
    if Id > 0 then
    begin
      FAdresseId := Id;
      FFilterWahl.Caption := AdressKurzname(Id);
      ExplorerLaden;
    end;
    Exit;
  end;

  Werte := TStringList.Create;
  Anzeige := TStringList.Create;
  Stueck := TStringList.Create;
  try
    if FModulFilter = 1 then
      ExplorerWerte('bezeichnung', GewaehlteArt, Werte)
    else
      ExplorerWerte('projekt', '', Werte);
    if Werte.Count = 0 then
    begin
      if FModulFilter = 4 then
        ShowMessage('Es gibt noch kein Projekt.')
      else
        ShowMessage('Dazu gibt es noch keinen Eintrag.');
      Exit;
    end;
    for i := 0 to Werte.Count - 1 do
    begin
      if FModulFilter = 4 then
      begin
        Teile(Werte[i], Stueck);
        if Stueck.Count > 1 then
          Anzeige.Add(Stueck[1])
        else
          Anzeige.Add(Werte[i]);
      end
      else
        Anzeige.Add(Werte[i]);
    end;
    if not ListeWaehlen('Aussuchen', Anzeige, Index) then
      Exit;
    if FModulFilter = 1 then
    begin
      FSuchtext := Werte[Index];
      FFilterWahl.Caption := FSuchtext;
    end
    else
    begin
      Zeile := Werte[Index];
      TabPos := Pos(#9, Zeile);
      if TabPos > 0 then
        FProjektId := StrToInt64Def(Copy(Zeile, 1, TabPos - 1), 0)
      else
        FProjektId := 0;
      FFilterWahl.Caption := Anzeige[Index];
    end;
    ExplorerLaden;
  finally
    Stueck.Free;
    Anzeige.Free;
    Werte.Free;
  end;
end;

procedure THauptfenster.NrGeaendert(Sender: TObject);
begin
  if not FBereit or (FModulFilter <> 3) then
    Exit;
  FSuchtext := FNrFeld.Text;
  ExplorerLaden;
end;

procedure THauptfenster.ZeitGeaendert(Sender: TObject);
begin
  if FBereit then
    ExplorerLaden;
end;

procedure THauptfenster.ModulGewaehlt(Sender: TObject);
begin
  if FBereit then
    ExplorerLaden;
end;

procedure THauptfenster.NeuBeleg(Sender: TObject);
var
  Kuerzel, Meldung: string;
begin
  Kuerzel := TButton(Sender).Hint;
  if not AktionZulaessig('beleg', Kuerzel, 'neu', Meldung) then
    ShowMessage(Meldung)
  else
  begin
    BelegBearbeiten(Kuerzel, 0);
    ExplorerLaden;
  end;
end;

procedure THauptfenster.ZeileOeffnen(Sender: TObject);
var
  Zeile: Integer;
  Meldung: string;
begin
  Zeile := FListe.Row;
  if (Zeile < 1) or (Zeile > Length(FIds)) or (FIds[Zeile - 1] = 0) then
  begin
    ShowMessage('Bitte zuerst einen Beleg auswählen.');
    Exit;
  end;
  if not AktionZulaessig('beleg', FZeilenArt[Zeile - 1], 'sehen', Meldung) then
  begin
    ShowMessage(Meldung);
    Exit;
  end;
  BelegBearbeiten(FZeilenArt[Zeile - 1], FIds[Zeile - 1]);
  ExplorerLaden;
end;

procedure THauptfenster.KontaktOeffnen(Sender: TObject);
begin
  AdressSucheZeigen(TButton(Sender).Hint);
end;

procedure THauptfenster.KopfFarbe(Sender: TObject; ACol, ARow: Integer;
  AState: TGridDrawState);
const
  Farben: array[0..8] of TColor = (
    clAqua, clLime, clTeal, clLime, clGreen, clGray, clBtnFace, clBtnFace, clBtnFace);
begin
  if (ARow = 0) and (ACol >= 0) and (ACol <= 8) then
  begin
    FListe.Canvas.Brush.Color := Farben[ACol];
    FListe.Canvas.Font.Color := clBlack;
  end;
end;

procedure THauptfenster.AnsichtAktualisieren;
var
  Kaskade, Wer: string;
  Person: TSitzung;
begin
  if FText = nil then
    Exit;
  Person := Sitzung;
  if Person.Aktiv then
    Wer := Person.Name + ' (' + Person.Rolle + ')'
  else
    Wer := 'nicht angemeldet';

  if FDbFehler <> '' then
  begin
    FText.Lines.Text :=
      'Die Datenbank konnte nicht geöffnet werden.' + LineEnding +
      LineEnding + FDbFehler;
    FStatus.Caption := 'Datenbank nicht geöffnet';
    Exit;
  end;

  if KaskadeAktiv then
    Kaskade := 'ein'
  else
    Kaskade := 'aus';
  FText.Lines.Text :=
    'Planlos' + LineEnding +
    'Angemeldet: ' + Wer + LineEnding +
    LineEnding +
    'Explorer: Belegart wählen, filtern, mit Neu anlegen oder mit Doppelklick öffnen.' +
    LineEnding +
    'Stammdaten: Kunde, Lieferant, Mitarbeiter, Kontakt.' + LineEnding +
    'In der Adresse öffnet ein Feld mit > eine Auswahlliste (Klick oder F4).' +
    LineEnding + LineEnding +
    PlanlosDB.Bericht;
  FStatus.Caption := Wer + '   ·   ' +
    IntToStr(PlanlosDB.Ganzzahl('SELECT COUNT(*) FROM modulart')) + ' Belegarten   ·   ' +
    IntToStr(PlanlosDB.Ganzzahl('SELECT COUNT(*) FROM adresse')) + ' Adressen   ·   ' +
    'Kaskade ' + Kaskade;
end;

procedure THauptfenster.AnsichtNachziehen(Sender: TObject);
var
  i: Integer;
begin
  AnsichtAktualisieren;
  ExplorerLaden;
  for i := 0 to Screen.FormCount - 1 do
    if Screen.Forms[i] is TKindfenster then
      TKindfenster(Screen.Forms[i]).TextAktualisieren;
end;

procedure THauptfenster.TaktTimer(Sender: TObject);
begin
  AlleLeistenNachziehen;
end;

procedure THauptfenster.TasteAusfuehren(Sender: TObject; Ebene, Taste: Integer);
var
  Meldung: string;
begin
  if Ebene = 1 then
    case Taste of
      1: ZeigeHilfe(True);
      2:
        begin
          if GewaehlteArt = '' then
            ShowMessage('Bitte zuerst eine Belegart wählen, nicht Alle.')
          else if not AktionZulaessig('beleg', GewaehlteArt, 'neu', Meldung) then
            ShowMessage(Meldung)
          else
          begin
            BelegBearbeiten(GewaehlteArt, 0);
            ExplorerLaden;
          end;
        end;
      3: KindfensterOeffnen;
      4: AdressSucheZeigen('kunde');
      6: ZeileOeffnen(Self);
      11:
        begin
          FSeiten.ActivePageIndex := 3;
          AnsichtAktualisieren;
        end;
      12: Close;
    else
      HinweisNochOffen('Diese Taste');
    end
  else if Ebene = 2 then
    case Taste of
      1: ZeigeTastenhilfe;
      3: KaskadeUmschaltenUndSagen;
      11: ShowMessage('Datenbankdatei:' + LineEnding + PlanlosDatenDatei);
      12: AlleKindfensterSchliessen;
    else
      HinweisNochOffen('Diese Taste');
    end
  else if Ebene = 3 then
    case Taste of
      1: ZeigeUeberPlanlos;
      4, 12: Close;
    end;
end;

procedure THauptfenster.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key >= VK_F1) and (Key <= VK_F12) then
  begin
    AlleLeistenNachziehen;
    TasteAusfuehren(Self, AktuelleEbene, Key - VK_F1 + 1);
    Key := 0;
  end;
end;

procedure THauptfenster.MenueBeenden(Sender: TObject);
begin
  Close;
end;

procedure THauptfenster.MenueFenster(Sender: TObject);
begin
  KindfensterOeffnen;
end;

procedure THauptfenster.MenueKaskade(Sender: TObject);
begin
  KaskadeUmschaltenUndSagen;
end;

procedure THauptfenster.MenueAlleZu(Sender: TObject);
begin
  AlleKindfensterSchliessen;
end;

procedure THauptfenster.MenueHilfe(Sender: TObject);
begin
  ZeigeHilfe(True);
end;

procedure THauptfenster.MenueDatenbank(Sender: TObject);
begin
  FSeiten.ActivePageIndex := 3;
  AnsichtAktualisieren;
end;

procedure THauptfenster.MenueUeber(Sender: TObject);
begin
  ZeigeUeberPlanlos;
end;

procedure THauptfenster.MenueKunde(Sender: TObject);
begin
  AdressSucheZeigen('kunde');
end;

procedure THauptfenster.MenueLieferant(Sender: TObject);
begin
  AdressSucheZeigen('lieferant');
end;

procedure THauptfenster.MenueKontakt(Sender: TObject);
begin
  AdressSucheZeigen('kontakt');
end;

procedure THauptfenster.MenueMitarbeiter(Sender: TObject);
begin
  AdressSucheZeigen('mitarbeiter');
end;

procedure THauptfenster.MenueAngebot(Sender: TObject);
begin
  BelegsucheZeigen('angebot');
end;

procedure THauptfenster.MenueAuftrag(Sender: TObject);
begin
  BelegsucheZeigen('auftragsbestaetigung');
end;

procedure THauptfenster.MenueBestellung(Sender: TObject);
begin
  BelegsucheZeigen('bestellung');
end;

procedure THauptfenster.MenueRechnung(Sender: TObject);
begin
  BelegsucheZeigen('rechnung');
end;

procedure THauptfenster.MenueProjekt(Sender: TObject);
begin
  BelegsucheZeigen('projekt');
end;

function KontaktPruefen(Protokoll: TStrings): string;
var
  Werte: TStringList;
  Fehler: string;
  Id, Neu: Int64;
  Kunden, Mitarbeiter: TSuchfenster;
  Eingabe, Kunde: TEingabefenster;
begin
  Result := '';
  Werte := TStringList.Create;
  Kunden := TSuchfenster.Create(Application);
  Mitarbeiter := TSuchfenster.Create(Application);
  Eingabe := TEingabefenster.Create(Application);
  Kunde := TEingabefenster.Create(Application);
  try
    Werte.Values['nachname'] := 'Meier';
    Werte.Values['vorname'] := 'Eva';
    Id := AdresseSpeichern('mitarbeiter', 0, Werte, Fehler);
    if Id = 0 then
      Exit('Mitarbeiter anlegen: ' + Fehler);
    if not Kunden.Oeffne('kunde') then
      Exit('Die Kundenmaske fehlt.');
    if Kunden.Left <> 40 then
      Exit('Das Kundenfenster steht nicht an der Position aus der Maske.');
    if Kunden.EnthaeltText('Meier') then
      Exit('Der Mitarbeiter erscheint in der Kundensuche.');
    if not Mitarbeiter.Oeffne('mitarbeiter') then
      Exit('Die Mitarbeitermaske fehlt.');
    Mitarbeiter.SetzeFilter('Meier');
    if not Mitarbeiter.EnthaeltText('Meier') then
      Exit('Der Mitarbeiter ist in der Mitarbeitersuche nicht zu finden.');
    if Mitarbeiter.GewaehlteId <> Id then
      Exit('Der Mitarbeiter ist nicht als Treffer ausgewählt.');
    Eingabe.Vorbereiten('mitarbeiter', 0);
    if Eingabe.HatFeld('firma') then
      Exit('Die Mitarbeitermaske zeigt das Feld Firma.');
    if not Eingabe.HatFeld('nachname') then
      Exit('Die Mitarbeitermaske hat kein Feld Nachname.');
    if not Eingabe.FeldBei('nachname', 79, 50) then
      Exit('Nachname steht nicht an der Stelle der alten Maske.');
    if not Eingabe.HatFeld('kategorie') then
      Exit('Die Maske zeigt die Kategorie nicht.');
    Kunde.Vorbereiten('kunde', 0);
    if not Kunde.HatFeld('firma') then
      Exit('Die Kundenmaske zeigt die Firma nicht.');
    if not Kunde.HatFeld('rabatt_prozent') then
      Exit('Die Kundenmaske zeigt den Rabatt nicht.');
    if not Kunde.FeldBei('firma', 79, 116) then
      Exit('Firma steht nicht an der Stelle der alten Maske.');
    Eingabe.SetzeWert('nachname', 'Schulz');
    Eingabe.SetzeWert('vorname', 'Tim');
    Neu := Eingabe.SpeichernStill(Fehler);
    if Neu = 0 then
      Exit('Speichern aus der Maske: ' + Fehler);
    Mitarbeiter.SetzeFilter('');
    Mitarbeiter.UebernehmenNeueId(Neu);
    if Mitarbeiter.GewaehlteId <> Neu then
      Exit('Der neue Mitarbeiter ist nach dem Speichern nicht ausgewählt.');
    Kunden.UebernehmenNeueId(0);
    if Kunden.EnthaeltText('Schulz') then
      Exit('Der neue Mitarbeiter erscheint in der Kundensuche.');
    Protokoll.Add('KONTAKT=OK');
    Protokoll.Add('MITARBEITER=' + IntToStr(Id));
    Protokoll.Add('NEU=' + IntToStr(Neu));
  finally
    Kunde.Free;
    Eingabe.Free;
    Mitarbeiter.Free;
    Kunden.Free;
    Werte.Free;
  end;
end;

procedure THauptfenster.FormShow(Sender: TObject);
begin
  AnsichtAktualisieren;
  if FSelbsttest and not FSelbsttestGelaufen then
  begin
    FSelbsttestGelaufen := True;
    Selbsttest;
  end;
end;

procedure THauptfenster.Selbsttest;
var
  Datei, Grund: string;
  K1, K2, K3: TKindfenster;
  Liste: TStringList;
  SchrittL, SchrittO: Integer;
begin
  Grund := '';
  Liste := TStringList.Create;
  try
    try
      Liste.Add(FText.Lines.Text);
      if Caption <> 'Mein kleines Büro' then
        Grund := 'Das Hauptfenster heißt nicht Mein kleines Büro.';
      if (Grund = '') and ((FSeiten = nil) or (FSeiten.PageCount <> 4)) then
        Grund := 'Es sollen vier Reiter sein.';
      if (Grund = '') and (FSeiten.Pages[0].Caption <> 'Explorer') then
        Grund := 'Der erste Reiter ist nicht der Explorer.';
      if (Grund = '') and (FSeiten.Pages[1].Caption <> 'Stammdaten') then
        Grund := 'Der zweite Reiter ist nicht Stammdaten.';
      if FDbFehler <> '' then
        Grund := 'Datenbank: ' + FDbFehler
      else
      begin
        if (Grund = '') and (Pos('Auftragsbestätigung', FText.Lines.Text) = 0) then
          Grund := 'Die Belegart Auftragsbestätigung fehlt im Fenstertext.';
        if (Grund = '') and (FNeuLeiste.ControlCount < 5) then
          Grund := 'Die Neu-Knöpfe fehlen.';
        K1 := KindfensterOeffnen;
        K2 := KindfensterOeffnen;
        SchrittL := KaskadenSchritt('schritt_links', 9);
        SchrittO := KaskadenSchritt('schritt_oben', 26);
        Liste.Add('K1=' + IntToStr(K1.Left) + ',' + IntToStr(K1.Top));
        Liste.Add('K2=' + IntToStr(K2.Left) + ',' + IntToStr(K2.Top));
        if (Grund = '') and (K2.Left - K1.Left <> SchrittL) then
          Grund := 'Der Versatz nach rechts stimmt nicht.';
        if (Grund = '') and (K2.Top - K1.Top <> SchrittO) then
          Grund := 'Der Versatz nach unten stimmt nicht.';
        KaskadeUmschalten;
        try
          K3 := KindfensterOeffnen;
          Liste.Add('K3=' + IntToStr(K3.Left) + ',' + IntToStr(K3.Top));
          if (Grund = '') and ((K3.Left <> KaskadenAnfangLinks) or
             (K3.Top <> KaskadenAnfangOben)) then
            Grund := 'Ohne Kaskade soll das Fenster an der Grundposition stehen.';
        finally
          KaskadeUmschalten;
        end;
        if Grund = '' then
          Grund := KontaktPruefen(Liste);
      end;
    except
      on E: Exception do
        Grund := E.Message;
    end;
    if Grund = '' then
      Liste.Add('RESULT=OK')
    else
      Liste.Add('RESULT=FEHLER ' + Grund);
    Datei := GetEnvironmentVariable('PLANLOS_SELBSTTEST_DATEI');
    if Datei = '' then
      Datei := IncludeTrailingPathDelimiter(GetTempDir) + 'planlos-selbsttest.txt';
    Liste.SaveToFile(Datei, TEncoding.UTF8);
  finally
    Liste.Free;
  end;
  if Grund <> '' then
    ExitCode := 1
  else
    ExitCode := 0;
  Application.Terminate;
end;

end.
