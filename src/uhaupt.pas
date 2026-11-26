unit uhaupt;

{ Hauptfenster von Planlos, angelehnt an UnitModule.dfm.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE.

  Oben die Reiter Explorer, Stammdaten, Einstellungen und Wartung/Hilfe.
  Unten liegt nur die Statuszeile. Die Belegarten und Kontaktarten kommen aus
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
    PageControl1: TPageControl;
    TabExplorer: TTabSheet;
    TabStammdaten: TTabSheet;
    TabEinstellungen: TTabSheet;
    TabHilfe: TTabSheet;
    LabelNeu: TLabel;
    ComboBoxModule: TComboBox;
    GroupBoxModulF: TGroupBox;
    RadioModulAlle: TRadioButton;
    RadioBezeichnung: TRadioButton;
    RadioAdressname: TRadioButton;
    RadioNummer: TRadioButton;
    RadioProjekt: TRadioButton;
    EditNummer: TEdit;
    ButtonFilterWahl: TButton;
    GroupBoxZeit: TGroupBox;
    RadioZeitAlle: TRadioButton;
    RadioZeitJahr: TRadioButton;
    RadioZeitMonat: TRadioButton;
    RadioZeitTag: TRadioButton;
    ComboJahr: TComboBox;
    ComboMonat: TComboBox;
    KalenderTag: TCalendar;
    GroupBoxSonst: TGroupBox;
    RadioSonstAlle: TRadioButton;
    RadioBearbeiter: TRadioButton;
    RadioGruppe: TRadioButton;
    GridModule: TStringGrid;
    ScrollBoxNeu: TScrollBox;
    PanelFunktion: TPanel;
    LabelF5: TLabel;
    ButtonKopieren: TButton;
    LabelF6: TLabel;
    ButtonAendern: TButton;
    LabelF7: TLabel;
    ButtonSortieren: TButton;
    LabelF8: TLabel;
    ButtonLoeschen: TButton;
    PanelEnde: TPanel;
    LabelF10: TLabel;
    ButtonEnde: TButton;
    LabelKontakte: TLabel;
    ButtonKunden: TButton;
    ButtonLieferant: TButton;
    ButtonMitarbeiter: TButton;
    ButtonKontakt: TButton;
    ButtonArtikel: TButton;
    ButtonArtikelgruppe: TButton;
    ButtonEinheit: TButton;
    ButtonKategorie: TButton;
    ButtonGruppierung: TButton;
    ButtonStueckliste: TButton;
    ButtonProjekt: TButton;
    ButtonTextbaustein: TButton;
    ButtonBelegart: TButton;
    PanelTestdaten: TPanel;
    ButtonTestdaten: TButton;
    LabelEinstellung: TLabel;
    MemoHilfe: TMemo;
    PanelTasten: TPanel;
    LabelStatus: TLabel;
    Hauptmenue: TMainMenu;
    MenuDatei: TMenuItem;
    MenuBeenden: TMenuItem;
    MenuFenster: TMenuItem;
    MenuNeuesFenster: TMenuItem;
    MenuKaskade: TMenuItem;
    MenuAlleZu: TMenuItem;
    MenuAdressen: TMenuItem;
    MenuKunden: TMenuItem;
    MenuLieferanten: TMenuItem;
    MenuKontakte: TMenuItem;
    MenuMitarbeiter: TMenuItem;
    MenuStammdaten: TMenuItem;
    MenuArtikel: TMenuItem;
    MenuArtikelgruppe: TMenuItem;
    MenuEinheit: TMenuItem;
    MenuKategorie: TMenuItem;
    MenuGruppierung: TMenuItem;
    MenuStueckliste: TMenuItem;
    MenuProjektStamm: TMenuItem;
    MenuTextbaustein: TMenuItem;
    MenuBelege: TMenuItem;
    MenuAngebot: TMenuItem;
    MenuAuftrag: TMenuItem;
    MenuBestellung: TMenuItem;
    MenuRechnung: TMenuItem;
    MenuProjekt: TMenuItem;
    MenuEinstellungen: TMenuItem;
    MenuBelegart: TMenuItem;
    MenuHilfe: TMenuItem;
    MenuHilfeText: TMenuItem;
    MenuDatenbank: TMenuItem;
    MenuTestdaten: TMenuItem;
    MenuUeber: TMenuItem;
    TimerTakt: TTimer;
    procedure MenueBeenden(Sender: TObject);
    procedure MenueFenster(Sender: TObject);
    procedure MenueKaskade(Sender: TObject);
    procedure MenueAlleZu(Sender: TObject);
    procedure MenueHilfe(Sender: TObject);
    procedure MenueDatenbank(Sender: TObject);
    procedure MenueTestdaten(Sender: TObject);
    procedure MenueUeber(Sender: TObject);
    procedure MenueKunde(Sender: TObject);
    procedure MenueLieferant(Sender: TObject);
    procedure MenueKontakt(Sender: TObject);
    procedure MenueMitarbeiter(Sender: TObject);
    procedure MenueArtikel(Sender: TObject);
    procedure MenueArtikelgruppe(Sender: TObject);
    procedure MenueEinheit(Sender: TObject);
    procedure MenueKategorie(Sender: TObject);
    procedure MenueGruppierung(Sender: TObject);
    procedure MenueStueckliste(Sender: TObject);
    procedure MenueProjektStamm(Sender: TObject);
    procedure MenueTextbaustein(Sender: TObject);
    procedure MenueBelegart(Sender: TObject);
    procedure BelegartenSchluss(Sender: TObject);
    procedure MenueAngebot(Sender: TObject);
    procedure MenueAuftrag(Sender: TObject);
    procedure MenueBestellung(Sender: TObject);
    procedure MenueRechnung(Sender: TObject);
    procedure MenueProjekt(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure TaktTimer(Sender: TObject);
    procedure FilterModul(Sender: TObject);
    procedure FilterZeit(Sender: TObject);
    procedure FilterSonst(Sender: TObject);
    procedure FilterWahl(Sender: TObject);
    procedure NrGeaendert(Sender: TObject);
    procedure ZeitGeaendert(Sender: TObject);
    procedure ModulGewaehlt(Sender: TObject);
    procedure NeuBeleg(Sender: TObject);
    procedure ZeileOeffnen(Sender: TObject);
    procedure KopierenKlick(Sender: TObject);
    procedure SortierenKlick(Sender: TObject);
    procedure LoeschenKlick(Sender: TObject);
    procedure FunktionVerteilen(Sender: TObject);
    procedure KontaktOeffnen(Sender: TObject);
    procedure KopfFarbe(Sender: TObject; ACol, ARow: Integer; AState: TGridDrawState);
    procedure ZelleGewaehlt(Sender: TObject; aCol, aRow: Integer; var CanSelect: Boolean);
  private
    DbFehler: string;
    SelbsttestAn: Boolean;
    SelbsttestGelaufen: Boolean;
    Bereit: Boolean;
    ModulKuerzel: TStringList;
    ZeilenIds: array of Int64;
    ZeilenArt: array of string;
    ModulFilter: Integer;
    ZeitraumWahl: Integer;
    SonstigesWahl: Integer;
    Suchtext: string;
    AdresseId: Int64;
    ProjektId: Int64;
    BearbeiterId: Int64;
    GruppenText: string;
    SortierArt: Integer;
    procedure TasteAusfuehren(Sender: TObject; Ebene, Taste: Integer);
    procedure KnoepfeStellen;
    procedure KnoepfeFuer(Zeile: Integer);
    function GewaehlteZeilenArt: string;
    function GewaehlteZeilenId: Int64;
    procedure AnsichtNachziehen(Sender: TObject);
    procedure DatenbankOeffnen;
    procedure ModulListe;
    procedure NeuKnoepfe;
    procedure ExplorerLaden;
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

{$R *.lfm}

uses
  ubeleg, ubelegfenster, ubenutzer, utestdaten;

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
const
  SpaltenTitel: array[0..8] of string = (
    'Modulart', 'Bezeichnung', 'Adressname', 'Nr', 'Projektname',
    'Erfassungsdatum', 'Bearbeiter', 'Gruppierung', 'LetzteBearbeitung');
var
  i: Integer;
begin
  inherited Create(TheOwner);
  ModulKuerzel := TStringList.Create;
  for i := 0 to 8 do
    GridModule.Cells[i, 0] := SpaltenTitel[i];
  DatenbankOeffnen;
  WennAnsichtVeraltet := @AnsichtNachziehen;
  ModulListe;
  NeuKnoepfe;
  JahreFuellen;
  Bereit := True;
  GridModule.OnSelectCell := @ZelleGewaehlt;
  ExplorerLaden;
  AnsichtAktualisieren;
  SelbsttestAn := GetEnvironmentVariable('PLANLOS_SELBSTTEST') = '1';
end;

destructor THauptfenster.Destroy;
begin
  ModulKuerzel.Free;
  inherited Destroy;
end;

function THauptfenster.DatenbankOffen: Boolean;
begin
  Result := DbFehler = '';
end;

procedure THauptfenster.DatenbankOeffnen;
begin
  DbFehler := '';
  try
    PlanlosDB := TPlanlosDatenbank.Create;
    PlanlosDB.VerbindenSQLite(PlanlosDatenDatei);
    PlanlosDB.SchemaSicherstellen;
  except
    on E: Exception do
      DbFehler := E.Message;
  end;
end;

procedure THauptfenster.ModulListe;
var
  Spalten, Zeilen, Stueck: TStringList;
  i: Integer;
begin
  ComboBoxModule.Items.Clear;
  ModulKuerzel.Clear;
  ComboBoxModule.Items.Add('Alle');
  ModulKuerzel.Add('');
  if DbFehler <> '' then
  begin
    ComboBoxModule.ItemIndex := 0;
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
      ModulKuerzel.Add(Stueck[0]);
      ComboBoxModule.Items.Add(Stueck[1]);
    end;
  finally
    Stueck.Free;
    Zeilen.Free;
    Spalten.Free;
  end;
  ComboBoxModule.ItemIndex := 0;
end;

procedure THauptfenster.NeuKnoepfe;
var
  i: Integer;
  Knopf: TButton;
begin
  while ScrollBoxNeu.ControlCount > 0 do
    ScrollBoxNeu.Controls[0].Free;
  for i := 1 to ComboBoxModule.Items.Count - 1 do
  begin
    Knopf := TButton.Create(Self);
    Knopf.Parent := ScrollBoxNeu;
    Knopf.Left := 4;
    Knopf.Top := 7 + (i - 1) * 26;
    Knopf.Width := 150;
    Knopf.Height := 22;
    Knopf.Caption := ComboBoxModule.Items[i];
    Knopf.Hint := ModulKuerzel[i];
    Knopf.OnClick := @NeuBeleg;
  end;
end;

procedure THauptfenster.JahreFuellen;
var
  Jahre: TStringList;
  Laufend: string;
begin
  ComboJahr.Items.Clear;
  Laufend := FormatDateTime('yyyy', Date);
  if DbFehler = '' then
  begin
    Jahre := TStringList.Create;
    try
      ExplorerWerte('jahr', '', Jahre);
      ComboJahr.Items.Assign(Jahre);
    finally
      Jahre.Free;
    end;
  end;
  if ComboJahr.Items.IndexOf(Laufend) < 0 then
    ComboJahr.Items.Add(Laufend);
  ComboJahr.ItemIndex := ComboJahr.Items.IndexOf(Laufend);
  if ComboJahr.ItemIndex < 0 then
    ComboJahr.ItemIndex := 0;
  ComboMonat.ItemIndex := StrToIntDef(FormatDateTime('m', Date), 1) - 1;
end;

function THauptfenster.GewaehlteArt: string;
begin
  Result := '';
  if (ComboBoxModule <> nil) and (ComboBoxModule.ItemIndex >= 0) and
     (ComboBoxModule.ItemIndex < ModulKuerzel.Count) then
    Result := ModulKuerzel[ComboBoxModule.ItemIndex];
end;

procedure THauptfenster.ExplorerLaden;
var
  Filter: TExplorerFilter;
  Spalten, Zeilen, Stueck: TStringList;
  Zeile, Spalte: Integer;
begin
  if not Bereit then
    Exit;
  GridModule.RowCount := 2;
  for Spalte := 0 to GridModule.ColCount - 1 do
    GridModule.Cells[Spalte, 1] := '';
  SetLength(ZeilenIds, 0);
  SetLength(ZeilenArt, 0);
  if DbFehler <> '' then
    Exit;
  Filter := Default(TExplorerFilter);
  Filter.Modulart := GewaehlteArt;
  Filter.ModulFilter := TModulFilter(ModulFilter);
  Filter.Suchtext := Suchtext;
  Filter.AdresseId := AdresseId;
  Filter.ProjektId := ProjektId;
  Filter.Zeitraum := TZeitraum(ZeitraumWahl);
  if ComboJahr.ItemIndex >= 0 then
    Filter.Jahr := StrToIntDef(ComboJahr.Items[ComboJahr.ItemIndex], 0);
  Filter.Monat := ComboMonat.ItemIndex + 1;
  Filter.Tag := FormatDateTime('yyyy-mm-dd', KalenderTag.DateTime);
  Filter.Sonstiges := TSonstiges(SonstigesWahl);
  Filter.BearbeiterId := BearbeiterId;
  Filter.Gruppe := GruppenText;
  Filter.Sortierung := SortierArt;

  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  Stueck := TStringList.Create;
  try
    ExplorerLesen(Filter, Spalten, Zeilen);
    SetLength(ZeilenIds, Zeilen.Count);
    SetLength(ZeilenArt, Zeilen.Count);
    if Zeilen.Count = 0 then
      GridModule.RowCount := 2
    else
      GridModule.RowCount := Zeilen.Count + 1;
    for Zeile := 0 to Zeilen.Count - 1 do
    begin
      Teile(Zeilen[Zeile], Stueck);
      if Stueck.Count > 0 then
        ZeilenIds[Zeile] := StrToInt64Def(Stueck[0], 0);
      if Stueck.Count > 1 then
        ZeilenArt[Zeile] := Stueck[1];
      for Spalte := 0 to 8 do
        if Spalte + 2 < Stueck.Count then
          GridModule.Cells[Spalte, Zeile + 1] := StringReplace(Stueck[Spalte + 2],
            'T', ' ', [])
        else
          GridModule.Cells[Spalte, Zeile + 1] := '';
    end;
    if Zeilen.Count > 0 then
      GridModule.Row := 1;
  finally
    Stueck.Free;
    Zeilen.Free;
    Spalten.Free;
  end;
  KnoepfeStellen;
end;

procedure THauptfenster.FilterModul(Sender: TObject);
begin
  if not Bereit or not TRadioButton(Sender).Checked then
    Exit;
  ModulFilter := TRadioButton(Sender).Tag;
  Suchtext := '';
  AdresseId := 0;
  ProjektId := 0;
  EditNummer.Text := '';
  EditNummer.Visible := ModulFilter = 3;
  ButtonFilterWahl.Visible := ModulFilter in [1, 2, 4];
  ButtonFilterWahl.Caption := 'wählen';
  case ModulFilter of
    1: ButtonFilterWahl.Top := 34;
    2: ButtonFilterWahl.Top := 58;
    4: ButtonFilterWahl.Top := 106;
  end;
  ExplorerLaden;
end;

procedure THauptfenster.FilterZeit(Sender: TObject);
begin
  if not Bereit or not TRadioButton(Sender).Checked then
    Exit;
  ZeitraumWahl := TRadioButton(Sender).Tag;
  ComboJahr.Visible := ZeitraumWahl in [1, 2];
  ComboMonat.Visible := ZeitraumWahl = 2;
  KalenderTag.Visible := ZeitraumWahl = 3;
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
  if not Bereit or not TRadioButton(Sender).Checked then
    Exit;
  SonstigesWahl := TRadioButton(Sender).Tag;
  if SonstigesWahl = 0 then
  begin
    BearbeiterId := 0;
    GruppenText := '';
    ExplorerLaden;
    Exit;
  end;
  if SonstigesWahl = 1 then
  begin
    Id := AdressSucheWaehlen('mitarbeiter');
    if Id = 0 then
    begin
      AlleWieder;
      Exit;
    end;
    BearbeiterId := Id;
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
    GruppenText := Werte[Index];
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
  if ModulFilter = 2 then
  begin
    Maske := 'kunde';
    if BelegartLaden(GewaehlteArt, Art) and (Art.EmpfaengerMaske <> '') then
      Maske := Art.EmpfaengerMaske;
    Id := AdressSucheWaehlen(Maske);
    if Id > 0 then
    begin
      AdresseId := Id;
      ButtonFilterWahl.Caption := AdressKurzname(Id);
      ExplorerLaden;
    end;
    Exit;
  end;

  Werte := TStringList.Create;
  Anzeige := TStringList.Create;
  Stueck := TStringList.Create;
  try
    if ModulFilter = 1 then
      ExplorerWerte('bezeichnung', GewaehlteArt, Werte)
    else
      ExplorerWerte('projekt', '', Werte);
    if Werte.Count = 0 then
    begin
      if ModulFilter = 4 then
        ShowMessage('Es gibt noch kein Projekt.')
      else
        ShowMessage('Dazu gibt es noch keinen Eintrag.');
      Exit;
    end;
    for i := 0 to Werte.Count - 1 do
    begin
      if ModulFilter = 4 then
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
    if ModulFilter = 1 then
    begin
      Suchtext := Werte[Index];
      ButtonFilterWahl.Caption := Suchtext;
    end
    else
    begin
      Zeile := Werte[Index];
      TabPos := Pos(#9, Zeile);
      if TabPos > 0 then
        ProjektId := StrToInt64Def(Copy(Zeile, 1, TabPos - 1), 0)
      else
        ProjektId := 0;
      ButtonFilterWahl.Caption := Anzeige[Index];
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
  if not Bereit or (ModulFilter <> 3) then
    Exit;
  Suchtext := EditNummer.Text;
  ExplorerLaden;
end;

procedure THauptfenster.ZeitGeaendert(Sender: TObject);
begin
  if Bereit then
    ExplorerLaden;
end;

procedure THauptfenster.ModulGewaehlt(Sender: TObject);
begin
  if Bereit then
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

function THauptfenster.GewaehlteZeilenArt: string;
var
  Zeile: Integer;
begin
  Result := '';
  Zeile := GridModule.Row;
  if (Zeile < 1) or (Zeile > Length(ZeilenArt)) then
    Exit;
  Result := ZeilenArt[Zeile - 1];
end;

function THauptfenster.GewaehlteZeilenId: Int64;
var
  Zeile: Integer;
begin
  Result := 0;
  Zeile := GridModule.Row;
  if (Zeile < 1) or (Zeile > Length(ZeilenIds)) then
    Exit;
  Result := ZeilenIds[Zeile - 1];
end;

procedure THauptfenster.FunktionVerteilen(Sender: TObject);
var
  Knoepfe: array[0..3] of TButton;
  Schilder: array[0..3] of TLabel;
  i, Slot, Links: Integer;
begin
  if (PanelFunktion = nil) or (ButtonKopieren = nil) then
    Exit;
  Knoepfe[0] := ButtonKopieren;
  Knoepfe[1] := ButtonAendern;
  Knoepfe[2] := ButtonSortieren;
  Knoepfe[3] := ButtonLoeschen;
  Schilder[0] := LabelF5;
  Schilder[1] := LabelF6;
  Schilder[2] := LabelF7;
  Schilder[3] := LabelF8;
  if PanelFunktion.ClientWidth < 8 then
    Exit;
  Slot := PanelFunktion.ClientWidth div 4;
  for i := 0 to 3 do
  begin
    Links := i * Slot + (Slot - Knoepfe[i].Width) div 2;
    if Links < i * Slot then
      Links := i * Slot;
    Knoepfe[i].Left := Links;
    Schilder[i].Left := Links;
    Schilder[i].Width := Knoepfe[i].Width;
  end;
end;

procedure THauptfenster.KnoepfeStellen;
begin
  KnoepfeFuer(GridModule.Row);
end;

procedure THauptfenster.ZelleGewaehlt(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
  if CanSelect then
    KnoepfeFuer(aRow);
end;

procedure THauptfenster.KnoepfeFuer(Zeile: Integer);
var
  Art, Meldung: string;
begin
  Art := '';
  if (Zeile >= 1) and (Zeile <= Length(ZeilenArt)) then
    Art := ZeilenArt[Zeile - 1];
  ButtonKopieren.Enabled := (Art <> '') and
    AktionZulaessig('beleg', Art, 'kopieren', Meldung);
  ButtonAendern.Enabled := (Art <> '') and
    AktionZulaessig('beleg', Art, 'aendern', Meldung);
  ButtonLoeschen.Enabled := (Art <> '') and
    AktionZulaessig('beleg', Art, 'loeschen', Meldung);
  ButtonSortieren.Hint := 'Sortierung: Datum absteigend';
  if SortierArt = 1 then
    ButtonSortieren.Hint := 'Sortierung: Datum aufsteigend'
  else if SortierArt = 2 then
    ButtonSortieren.Hint := 'Sortierung: Nummer'
  else if SortierArt = 3 then
    ButtonSortieren.Hint := 'Sortierung: Bezeichnung';
  ButtonSortieren.ShowHint := True;
end;

procedure THauptfenster.KopierenKlick(Sender: TObject);
var
  Art, Meldung, Fehler: string;
  Id, Neu: Int64;
begin
  Art := GewaehlteZeilenArt;
  Id := GewaehlteZeilenId;
  if (Art = '') or (Id = 0) then
  begin
    ShowMessage('Bitte zuerst einen Beleg auswählen.');
    Exit;
  end;
  if not AktionZulaessig('beleg', Art, 'kopieren', Meldung) then
  begin
    ShowMessage(Meldung);
    Exit;
  end;
  Neu := BelegKopieren(Id, Fehler);
  if Neu = 0 then
    ShowMessage(Fehler)
  else
    ExplorerLaden;
end;

procedure THauptfenster.SortierenKlick(Sender: TObject);
begin
  SortierArt := (SortierArt + 1) mod 4;
  ExplorerLaden;
end;

procedure THauptfenster.LoeschenKlick(Sender: TObject);
var
  Art, Meldung, Fehler, Nummer: string;
  Id: Int64;
begin
  Art := GewaehlteZeilenArt;
  Id := GewaehlteZeilenId;
  if (Art = '') or (Id = 0) then
  begin
    ShowMessage('Bitte zuerst einen Beleg auswählen.');
    Exit;
  end;
  if not AktionZulaessig('beleg', Art, 'loeschen', Meldung) then
  begin
    ShowMessage(Meldung);
    Exit;
  end;
  Nummer := BelegNummer(Id);
  if MessageDlg('Beleg ' + Nummer + ' löschen?', mtConfirmation,
    [mbYes, mbNo], 0) <> mrYes then
    Exit;
  if not BelegLoeschen(Id, Fehler) then
    ShowMessage(Fehler)
  else
    ExplorerLaden;
end;

procedure THauptfenster.ZeileOeffnen(Sender: TObject);
var
  Zeile: Integer;
  Meldung: string;
begin
  Zeile := GridModule.Row;
  if (Zeile < 1) or (Zeile > Length(ZeilenIds)) or (ZeilenIds[Zeile - 1] = 0) then
  begin
    ShowMessage('Bitte zuerst einen Beleg auswählen.');
    Exit;
  end;
  if not AktionZulaessig('beleg', ZeilenArt[Zeile - 1], 'aendern', Meldung) then
  begin
    ShowMessage(Meldung);
    Exit;
  end;
  BelegBearbeiten(ZeilenArt[Zeile - 1], ZeilenIds[Zeile - 1]);
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
    clAqua, clLime, clTeal, clOlive, clGreen, clGray, clBtnFace, clBtnFace, clBtnFace);
begin
  if (ARow = 0) and (ACol >= 0) and (ACol <= 8) then
  begin
    GridModule.Canvas.Brush.Color := Farben[ACol];
    GridModule.Canvas.Font.Color := clBlack;
  end;
end;

procedure THauptfenster.AnsichtAktualisieren;
var
  Kaskade, Wer: string;
  Person: TSitzung;
begin
  if MemoHilfe = nil then
    Exit;
  Person := Sitzung;
  if Person.Aktiv then
    Wer := Person.Name + ' (' + Person.Rolle + ')'
  else
    Wer := 'nicht angemeldet';

  if DbFehler <> '' then
  begin
    MemoHilfe.Lines.Text :=
      'Die Datenbank konnte nicht geöffnet werden.' + LineEnding +
      LineEnding + DbFehler;
    LabelStatus.Caption := 'Datenbank nicht geöffnet';
    Exit;
  end;

  if KaskadeAktiv then
    Kaskade := 'ein'
  else
    Kaskade := 'aus';
  MemoHilfe.Lines.Text :=
    'Planlos' + LineEnding +
    'Angemeldet: ' + Wer + LineEnding +
    LineEnding +
    'Explorer: Belegart wählen, filtern, mit Neu anlegen oder mit Doppelklick öffnen.' +
    LineEnding +
    'Stammdaten: Kunde, Lieferant, Mitarbeiter, Kontakt.' + LineEnding +
    'In der Adresse öffnet ein Feld mit > eine Auswahlliste (Klick oder F4).' +
    LineEnding + LineEnding +
    PlanlosDB.Bericht;
  LabelStatus.Caption := Wer + '   ·   ' +
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
      5: KopierenKlick(Self);
      6: ZeileOeffnen(Self);
      7: SortierenKlick(Self);
      8: LoeschenKlick(Self);
      10: MenueBeenden(Self);
      11:
        begin
          PageControl1.ActivePageIndex := 3;
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
  PageControl1.ActivePageIndex := 3;
  AnsichtAktualisieren;
end;

procedure THauptfenster.MenueTestdaten(Sender: TObject);
var
  Meldung: string;
begin
  if TestdatenVorhanden then
  begin
    ShowMessage('Die Testdaten sind schon eingespielt.');
    Exit;
  end;
  if MessageDlg(
    'Testdaten in diese Datenbank einfügen?' + LineEnding +
    'Sinnvoll ist das in einer noch leeren Datei. Vorhandene Daten bleiben.',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  if TestdatenEinfuegen(Meldung) then
  begin
    ShowMessage(Meldung);
    if Bereit then
      ExplorerLaden;
  end
  else
    ShowMessage(Meldung);
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

procedure THauptfenster.MenueArtikel(Sender: TObject);
begin
  AdressSucheZeigen('artikel');
end;

procedure THauptfenster.MenueArtikelgruppe(Sender: TObject);
begin
  AdressSucheZeigen('artikelgruppe');
end;

procedure THauptfenster.MenueEinheit(Sender: TObject);
begin
  AdressSucheZeigen('einheit');
end;

procedure THauptfenster.MenueKategorie(Sender: TObject);
begin
  AdressSucheZeigen('kategorie');
end;

procedure THauptfenster.MenueGruppierung(Sender: TObject);
begin
  AdressSucheZeigen('gruppierung');
end;

procedure THauptfenster.MenueStueckliste(Sender: TObject);
begin
  AdressSucheZeigen('stuecklistengruppe');
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

procedure THauptfenster.MenueProjektStamm(Sender: TObject);
begin
  AdressSucheZeigen('projekt');
end;

procedure THauptfenster.MenueTextbaustein(Sender: TObject);
begin
  AdressSucheZeigen('textbaustein');
end;

procedure THauptfenster.BelegartenSchluss(Sender: TObject);
begin
  ModulListe;
  NeuKnoepfe;
  ExplorerLaden;
end;

procedure THauptfenster.MenueBelegart(Sender: TObject);
begin
  AdressSucheZeigen('modulart', @BelegartenSchluss);
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
    { Im Formular steht 79/50. Manche Oberflächen melden einen Punkt daneben. }
    if (Abs(Eingabe.EditNachname.Left - 79) > 1) or
       (Abs(Eingabe.EditNachname.Top - 50) > 1) then
      Exit('Nachname steht nicht an der Stelle der alten Maske.');
    if not Eingabe.HatFeld('kategorie') then
      Exit('Die Maske zeigt die Kategorie nicht.');
    Kunde.Vorbereiten('kunde', 0);
    if not Kunde.HatFeld('firma') then
      Exit('Die Kundenmaske zeigt die Firma nicht.');
    if not Kunde.HatFeld('rabatt_prozent') then
      Exit('Die Kundenmaske zeigt den Rabatt nicht.');
    if (Abs(Kunde.EditFirma.Left - 79) > 1) or
       (Abs(Kunde.EditFirma.Top - 116) > 1) then
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
  ExplorerLaden;
  AnsichtAktualisieren;
  if SelbsttestAn and not SelbsttestGelaufen then
  begin
    SelbsttestGelaufen := True;
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
      Liste.Add(MemoHilfe.Lines.Text);
      if Caption <> 'Mein kleines Büro' then
        Grund := 'Das Hauptfenster heißt nicht Mein kleines Büro.';
      if (Grund = '') and ((PageControl1 = nil) or (PageControl1.PageCount <> 4)) then
        Grund := 'Es sollen vier Reiter sein.';
      if (Grund = '') and (PageControl1.Pages[0].Caption <> 'Explorer') then
        Grund := 'Der erste Reiter ist nicht der Explorer.';
      if (Grund = '') and (PageControl1.Pages[1].Caption <> 'Stammdaten') then
        Grund := 'Der zweite Reiter ist nicht Stammdaten.';
      if DbFehler <> '' then
        Grund := 'Datenbank: ' + DbFehler
      else
      begin
        if (Grund = '') and (Pos('Auftragsbestätigung', MemoHilfe.Lines.Text) = 0) then
          Grund := 'Die Belegart Auftragsbestätigung fehlt im Fenstertext.';
        if (Grund = '') and (ScrollBoxNeu.ControlCount < 5) then
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
