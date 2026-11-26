unit usuche;

{ Das eine Suchfenster. Die Maske entscheidet, welche Adressart
  und welche Spalten es zeigt.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Grids,
  Graphics, LCLType, utastenleiste, umaske, ueingabe;

type
  TSuchfenster = class(TForm)
  private
    FFilter: TEdit;
    FHinweis: TLabel;
    FListe: TStringGrid;
    FStatus: TLabel;
    FKuerzel: string;
    FBezeichnung: string;
    FTastenInfo: TTastenListe;
    FIds: array of Int64;
    FAuswahl: Integer;
    FModal: Boolean;
    FFuss: TPanel;
    FLeiste: TPanel;
    FNeu: TButton;
    FKopieren: TButton;
    FAendern: TButton;
    FSortieren: TButton;
    FLoeschen: TButton;
    FEnde: TButton;
    FLabelNeu: TLabel;
    FLabelKopieren: TLabel;
    FLabelAendern: TLabel;
    FLabelSortieren: TLabel;
    FLabelLoeschen: TLabel;
    FLabelEnde: TLabel;
    FSortierung: Integer;
    FNeuAn: Boolean;
    FKopierenAn: Boolean;
    FAendernAn: Boolean;
    FLoeschenAn: Boolean;
    FVorgabe: Boolean;
    FEinschraenkung: string;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KnopfKlick(Sender: TObject);
    procedure ListeKlick(Sender: TObject);
    procedure ListeDoppel(Sender: TObject);
    procedure LeisteRichten(Sender: TObject);
    procedure ZeilenSortieren;
    function SortierText: string;
    procedure KnoepfeStellen;
    function VorgabeErlaubt(const Aktionsname: string): Boolean;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FilterTaste(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
    procedure TastenAusDaten;
    procedure AktionAusfuehren(const Aktionsname: string);
    function StammAktion(const Aktionsname: string): Boolean;
    procedure ListeLaden;
  public
    constructor Create(TheOwner: TComponent); override;
    function Oeffne(const Kuerzel: string): Boolean;
    function EnthaeltText(const GesuchterText: string): Boolean;
    procedure WaehleId(Id: Int64);
    function GewaehlteId: Int64;
    procedure UebernehmenNeueId(Id: Int64);
    procedure SetzeFilter(const Suchtext: string);
    procedure SetzeFunktionen(Neu, Kopieren, Aendern, Loeschen: Boolean);
    procedure SetzeEinschraenkung(const Wert: string);
  end;

procedure AdressSucheZeigen(const Kuerzel: string);
function AdressSucheWaehlen(const Kuerzel: string): Int64;
function ListenWahl(const Kuerzel: string; Bearbeiten: Boolean; out Id: Int64): Boolean;
function ListenWahlMit(const Kuerzel, Einschraenkung: string; Bearbeiten: Boolean;
  out Id: Int64): Boolean;

implementation

uses
  ubenutzer, uartikel, uartikelfenster, uartikelgruppe, unachschlage,
  unachschlagefenster, uprojekt, uprojektfenster, utextbaustein,
  utextbausteinfenster;

procedure AdressSucheZeigen(const Kuerzel: string);
var
  Fenster: TSuchfenster;
  Meldung: string;
begin
  if not AktionZulaessig('maske', Kuerzel, 'sehen', Meldung) then
  begin
    ShowMessage(Meldung);
    Exit;
  end;
  Fenster := TSuchfenster.Create(Application);
  if not Fenster.Oeffne(Kuerzel) then
  begin
    Fenster.Free;
    ShowMessage('Die Maske ' + Kuerzel + ' ist nicht angelegt.');
    Exit;
  end;
  Fenster.Show;
end;

function AdressSucheWaehlen(const Kuerzel: string): Int64;
var
  Fenster: TSuchfenster;
  Meldung: string;
begin
  Result := 0;
  if not AktionZulaessig('maske', Kuerzel, 'sehen', Meldung) then
  begin
    ShowMessage(Meldung);
    Exit;
  end;
  Fenster := TSuchfenster.Create(Application);
  try
    Fenster.FModal := True;
    if not Fenster.Oeffne(Kuerzel) then
      Exit;
    if Fenster.ShowModal = mrOk then
      Result := Fenster.GewaehlteId;
  finally
    Fenster.Free;
  end;
end;

function ListenWahlMit(const Kuerzel, Einschraenkung: string; Bearbeiten: Boolean;
  out Id: Int64): Boolean;
var
  Fenster: TSuchfenster;
  Meldung: string;
begin
  Result := False;
  Id := 0;
  if not AktionZulaessig('maske', Kuerzel, 'sehen', Meldung) then
  begin
    ShowMessage(Meldung);
    Exit;
  end;
  Fenster := TSuchfenster.Create(Application);
  try
    Fenster.FModal := True;
    Fenster.FEinschraenkung := Einschraenkung;
    if not Fenster.Oeffne(Kuerzel) then
      Exit;
    if not Bearbeiten then
      Fenster.SetzeFunktionen(False, False, False, False);
    if Fenster.ShowModal = mrOk then
    begin
      Id := Fenster.GewaehlteId;
      Result := Id > 0;
    end;
  finally
    Fenster.Free;
  end;
end;

function ListenWahl(const Kuerzel: string; Bearbeiten: Boolean; out Id: Int64): Boolean;
begin
  Result := ListenWahlMit(Kuerzel, '', Bearbeiten, Id);
end;

procedure TSuchfenster.SetzeEinschraenkung(const Wert: string);
begin
  FEinschraenkung := Wert;
end;

constructor TSuchfenster.Create(TheOwner: TComponent);

  function Schild(const Taste: string): TLabel;
  begin
    Result := TLabel.Create(Self);
    Result.Parent := FLeiste;
    Result.Top := 0;
    Result.Height := 14;
    Result.Caption := Taste;
    Result.Alignment := taCenter;
    Result.AutoSize := False;
    Result.Font.Color := clTeal;
    Result.Font.Height := -11;
    Result.Font.Name := 'MS Sans Serif';
    Result.ParentFont := False;
  end;

  function Knopf(const Text, Aktion: string): TButton;
  begin
    Result := TButton.Create(Self);
    Result.Parent := FLeiste;
    Result.Top := 16;
    Result.Width := 77;
    Result.Height := 22;
    Result.Caption := Text;
    Result.Hint := Aktion;
    Result.OnClick := @KnopfKlick;
  end;

begin
  inherited CreateNew(TheOwner, 1);
  Position := poDesigned;
  KeyPreview := True;
  Caption := 'Planlos';
  OnKeyDown := @FormKeyDown;
  OnClose := @FormClose;

  FFuss := TPanel.Create(Self);
  FFuss.Parent := Self;
  FFuss.Align := alBottom;
  FFuss.Height := 60;
  FFuss.BevelOuter := bvNone;
  FFuss.Caption := '';

  FLeiste := TPanel.Create(Self);
  FLeiste.Parent := FFuss;
  FLeiste.Align := alClient;
  FLeiste.Height := 40;
  FLeiste.BevelOuter := bvNone;
  FLeiste.Caption := '';
  FLeiste.OnResize := @LeisteRichten;
  FLabelNeu := Schild('F2');
  FNeu := Knopf('neu', 'neu');
  FLabelKopieren := Schild('F5');
  FKopieren := Knopf('kopieren', 'kopieren');
  FLabelAendern := Schild('F6');
  FAendern := Knopf('ändern', 'aendern');
  FLabelSortieren := Schild('F7');
  FSortieren := Knopf('sortieren', 'sortieren');
  FLabelLoeschen := Schild('F8');
  FLoeschen := Knopf('löschen', 'loeschen');
  FLabelEnde := Schild('F10');
  FEnde := Knopf('Ende', 'schliessen');
  FEnde.Width := 92;

  FStatus := TLabel.Create(Self);
  FStatus.Parent := FFuss;
  FStatus.Align := alBottom;
  FStatus.Height := 20;
  FStatus.AutoSize := False;
  FStatus.Layout := tlCenter;
  FStatus.BorderSpacing.Left := 8;
  FStatus.Caption := '';

  FHinweis := TLabel.Create(Self);
  FHinweis.Parent := Self;
  FHinweis.Align := alTop;
  FHinweis.Height := 22;
  FHinweis.AutoSize := False;
  FHinweis.Layout := tlCenter;
  FHinweis.BorderSpacing.Left := 8;

  FFilter := TEdit.Create(Self);
  FFilter.Parent := Self;
  FFilter.Align := alTop;
  FFilter.Hint := 'Name, Firma oder Ort';
  FFilter.ShowHint := True;
  FFilter.TextHint := 'Name, Firma oder Ort';
  FFilter.OnKeyDown := @FilterTaste;

  FListe := TStringGrid.Create(Self);
  FListe.Parent := Self;
  FListe.Align := alClient;
  FListe.FixedCols := 0;
  FListe.FixedRows := 1;
  FListe.RowCount := 1;
  FListe.ColCount := 1;
  FListe.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
    goRowSelect, goColSizing, goThumbTracking];
  FListe.OnClick := @ListeKlick;
  FListe.OnDblClick := @ListeDoppel;
  LeisteRichten(nil);
end;

procedure TSuchfenster.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FModal then
  begin
    if ModalResult = mrNone then
      ModalResult := mrCancel;
    CloseAction := caHide;
  end
  else
    CloseAction := caFree;
end;

function TSuchfenster.Oeffne(const Kuerzel: string): Boolean;
var
  Info: TMaskenInfo;
begin
  FKuerzel := Kuerzel;
  Result := MaskeLaden(Kuerzel, Info);
  if not Result then
    Exit;
  FBezeichnung := Info.Bezeichnung;
  Caption := 'Planlos - ' + Info.Bezeichnung;
  Position := poDesigned;
  if Info.Links > 0 then
    Left := Info.Links
  else
    Left := 40;
  if Info.Oben > 0 then
    Top := Info.Oben
  else
    Top := 30;
  Width := Info.Breite;
  Height := Info.Hoehe;
  FHinweis.Caption := 'Maske ' + Info.Bezeichnung +
    '. Felder und Tasten kommen aus der Datenbank.';
  TastenAusDaten;
  ListeLaden;
  KnoepfeStellen;
  LeisteRichten(nil);
end;

procedure TSuchfenster.TastenAusDaten;
begin
  FTastenInfo := TastenLaden(FKuerzel, 'suche');
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

procedure TSuchfenster.ListeLaden;
var
  Spalten, Zeilen, TeileZeile: TStringList;
  Spalte, Zeile: Integer;
begin
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  TeileZeile := TStringList.Create;
  try
    if FKuerzel = 'projekt' then
      ProjektLesen(FFilter.Text, Spalten, Zeilen)
    else if FKuerzel = 'textbaustein' then
      TextbausteinLesen(FFilter.Text, FEinschraenkung, Spalten, Zeilen)
    else if FKuerzel = 'modulart' then
      ModulartLesen(FFilter.Text, Spalten, Zeilen)
    else if FKuerzel = 'benutzer' then
      BenutzerLesen(FFilter.Text, Spalten, Zeilen)
    else if Stammliste(FKuerzel) then
      StammLesen(FKuerzel, FFilter.Text, Spalten, Zeilen)
    else
      TrefferLesen(FKuerzel, FFilter.Text, Spalten, Zeilen);
    if Spalten.Count < 1 then
      Spalten.Add('id');
    FListe.ColCount := Spalten.Count;
    FListe.RowCount := Zeilen.Count + 1;
    for Spalte := 0 to Spalten.Count - 1 do
    begin
      FListe.Cells[Spalte, 0] := Spalten[Spalte];
      if Spalte = 0 then
        FListe.ColWidths[Spalte] := 50
      else
        FListe.ColWidths[Spalte] := 140;
    end;
    SetLength(FIds, Zeilen.Count);
    for Zeile := 0 to Zeilen.Count - 1 do
    begin
      Teile(Zeilen[Zeile], TeileZeile);
      if TeileZeile.Count > 0 then
        FIds[Zeile] := StrToInt64Def(TeileZeile[0], 0)
      else
        FIds[Zeile] := 0;
      for Spalte := 0 to Spalten.Count - 1 do
        if Spalte < TeileZeile.Count then
          FListe.Cells[Spalte, Zeile + 1] := TeileZeile[Spalte]
        else
          FListe.Cells[Spalte, Zeile + 1] := '';
    end;
    if Zeilen.Count = 0 then
    begin
      FListe.RowCount := 2;
      FAuswahl := 0;
    end
    else
    begin
      FListe.Row := 1;
      FAuswahl := 1;
    end;
    ZeilenSortieren;
    FStatus.Caption := IntToStr(Length(FIds)) + ' Einträge · Sortierung: ' +
      SortierText;
    KnoepfeStellen;
  finally
    TeileZeile.Free;
    Zeilen.Free;
    Spalten.Free;
  end;
end;

function TSuchfenster.GewaehlteId: Int64;
var
  Zeile: Integer;
begin
  Result := 0;
  Zeile := FListe.Row;
  if (Zeile < 1) or (Zeile > Length(FIds)) then
    Zeile := FAuswahl;
  if (Zeile < 1) or (Zeile > Length(FIds)) then
    Exit;
  Result := FIds[Zeile - 1];
end;

procedure TSuchfenster.WaehleId(Id: Int64);
var
  i: Integer;
begin
  for i := 0 to High(FIds) do
    if FIds[i] = Id then
    begin
      FListe.Row := i + 1;
      FAuswahl := i + 1;
      Exit;
    end;
end;

procedure TSuchfenster.UebernehmenNeueId(Id: Int64);
begin
  ListeLaden;
  WaehleId(Id);
end;

procedure TSuchfenster.SetzeFilter(const Suchtext: string);
begin
  FFilter.Text := Suchtext;
  ListeLaden;
end;

function TSuchfenster.EnthaeltText(const GesuchterText: string): Boolean;
var
  Spalte, Zeile: Integer;
begin
  Result := False;
  for Zeile := 1 to FListe.RowCount - 1 do
    for Spalte := 0 to FListe.ColCount - 1 do
      if Pos(GesuchterText, FListe.Cells[Spalte, Zeile]) > 0 then
        Exit(True);
end;

procedure TSuchfenster.KnopfKlick(Sender: TObject);
begin
  AktionAusfuehren(TButton(Sender).Hint);
end;

procedure TSuchfenster.ListeKlick(Sender: TObject);
begin
  if (FListe.Row >= 1) and (FListe.Row <= Length(FIds)) then
    FAuswahl := FListe.Row;
  KnoepfeStellen;
end;

procedure TSuchfenster.ListeDoppel(Sender: TObject);
begin
  if FModal then
    AktionAusfuehren('uebernehmen')
  else
    AktionAusfuehren('aendern');
end;

procedure TSuchfenster.LeisteRichten(Sender: TObject);
var
  Knoepfe: array[0..4] of TButton;
  Schilder: array[0..4] of TLabel;
  i, Rest, Slot, Links, Breite: Integer;
begin
  if (FLeiste = nil) or (FEnde = nil) then
    Exit;
  FEnde.Left := FLeiste.ClientWidth - FEnde.Width - 4;
  FLabelEnde.Left := FEnde.Left;
  FLabelEnde.Width := FEnde.Width;
  Knoepfe[0] := FNeu;
  Knoepfe[1] := FKopieren;
  Knoepfe[2] := FAendern;
  Knoepfe[3] := FSortieren;
  Knoepfe[4] := FLoeschen;
  Schilder[0] := FLabelNeu;
  Schilder[1] := FLabelKopieren;
  Schilder[2] := FLabelAendern;
  Schilder[3] := FLabelSortieren;
  Schilder[4] := FLabelLoeschen;
  Rest := FEnde.Left - 8;
  if Rest < 40 then
    Exit;
  Slot := Rest div 5;
  Breite := 77;
  if Slot < Breite then
    Breite := Slot;
  for i := 0 to 4 do
  begin
    Links := i * Slot + (Slot - Breite) div 2;
    if Links < i * Slot then
      Links := i * Slot;
    Knoepfe[i].Width := Breite;
    Knoepfe[i].Left := Links;
    Schilder[i].Left := Links;
    Schilder[i].Width := Breite;
  end;
end;

procedure TSuchfenster.ZeilenSortieren;
var
  i, j, Spalte, Richtung, c: Integer;
  Zelle: string;
  Id: Int64;

  function Kleiner(a, b: Integer): Boolean;
  begin
    if FSortierung = 3 then
      Result := FIds[a - 1] < FIds[b - 1]
    else if Richtung < 0 then
      Result := FListe.Cells[Spalte, a] > FListe.Cells[Spalte, b]
    else
      Result := FListe.Cells[Spalte, a] < FListe.Cells[Spalte, b];
  end;

begin
  if Length(FIds) < 2 then
    Exit;
  Richtung := 1;
  case FSortierung of
    1: begin
         Spalte := 1;
         Richtung := -1;
       end;
    2: Spalte := 2;
    3: Spalte := 0;
  else
    Spalte := 1;
  end;
  if Spalte >= FListe.ColCount then
    Spalte := 1;
  for i := 1 to Length(FIds) - 1 do
    for j := i + 1 to Length(FIds) do
      if Kleiner(j, i) then
      begin
        for c := 0 to FListe.ColCount - 1 do
        begin
          Zelle := FListe.Cells[c, i];
          FListe.Cells[c, i] := FListe.Cells[c, j];
          FListe.Cells[c, j] := Zelle;
        end;
        Id := FIds[i - 1];
        FIds[i - 1] := FIds[j - 1];
        FIds[j - 1] := Id;
      end;
end;

function TSuchfenster.SortierText: string;
var
  Spalte: Integer;
begin
  case FSortierung of
    1: Spalte := 1;
    2: Spalte := 2;
    3: Spalte := 0;
  else
    Spalte := 1;
  end;
  if (FListe = nil) or (Spalte >= FListe.ColCount) then
    Spalte := 0;
  if FListe <> nil then
    Result := FListe.Cells[Spalte, 0]
  else
    Result := '';
  if Result = '' then
    Result := 'Liste';
  if FSortierung = 1 then
    Result := Result + ', absteigend';
end;

procedure TSuchfenster.SetzeFunktionen(Neu, Kopieren, Aendern, Loeschen: Boolean);
begin
  FVorgabe := True;
  FNeuAn := Neu;
  FKopierenAn := Kopieren;
  FAendernAn := Aendern;
  FLoeschenAn := Loeschen;
  KnoepfeStellen;
end;

function TSuchfenster.VorgabeErlaubt(const Aktionsname: string): Boolean;
begin
  Result := True;
  if not FVorgabe then
    Exit;
  if Aktionsname = 'neu' then
    Result := FNeuAn
  else if Aktionsname = 'kopieren' then
    Result := FKopierenAn
  else if Aktionsname = 'aendern' then
    Result := FAendernAn
  else if Aktionsname = 'loeschen' then
    Result := FLoeschenAn;
end;

procedure TSuchfenster.KnoepfeStellen;
var
  Meldung: string;
  ZeileDa: Boolean;
begin
  if FNeu = nil then
    Exit;
  ZeileDa := GewaehlteId > 0;
  FNeu.Enabled := VorgabeErlaubt('neu') and
    AktionZulaessig('maske', FKuerzel, 'neu', Meldung);
  FKopieren.Enabled := ZeileDa and VorgabeErlaubt('kopieren') and
    AktionZulaessig('maske', FKuerzel, 'kopieren', Meldung);
  FAendern.Enabled := ZeileDa and VorgabeErlaubt('aendern') and
    AktionZulaessig('maske', FKuerzel, 'aendern', Meldung);
  FLoeschen.Enabled := ZeileDa and VorgabeErlaubt('loeschen') and
    AktionZulaessig('maske', FKuerzel, 'loeschen', Meldung);
end;

function TSuchfenster.StammAktion(const Aktionsname: string): Boolean;
var
  Id: Int64;
  Meldung, Fehler: string;
begin
  Result := (Aktionsname = 'neu') or (Aktionsname = 'aendern') or
    (Aktionsname = 'kopieren') or (Aktionsname = 'loeschen');
  if not Result then
    Exit;
  if (FKuerzel = 'berechnungsart') or (FKuerzel = 'modulart') or
     (FKuerzel = 'benutzer') then
  begin
    ShowMessage('Diese Liste wird nur zum Aussuchen benutzt.');
    Exit;
  end;
  if (FKuerzel = 'projekt') or (FKuerzel = 'textbaustein') then
  begin
    if not AktionZulaessig('maske', FKuerzel, Aktionsname, Meldung) then
    begin
      ShowMessage(Meldung);
      Exit;
    end;
    if Aktionsname = 'neu' then
    begin
      if FKuerzel = 'projekt' then
        Id := ProjektBearbeiten(0)
      else
        Id := TextbausteinBearbeiten(0);
    end
    else if Aktionsname = 'aendern' then
    begin
      Id := GewaehlteId;
      if Id = 0 then
      begin
        ShowMessage('Bitte zuerst eine Zeile auswählen.');
        Exit;
      end;
      if FKuerzel = 'projekt' then
        Id := ProjektBearbeiten(Id)
      else
        Id := TextbausteinBearbeiten(Id);
      if Id = 0 then
        Exit;
    end
    else if Aktionsname = 'kopieren' then
    begin
      Id := GewaehlteId;
      if Id = 0 then
      begin
        ShowMessage('Bitte zuerst eine Zeile auswählen.');
        Exit;
      end;
      if FKuerzel = 'projekt' then
        Id := ProjektKopieren(Id, Fehler)
      else
        Id := TextbausteinKopieren(Id, Fehler);
      if Id = 0 then
      begin
        ShowMessage(Fehler);
        Exit;
      end;
    end
    else
    begin
      Id := GewaehlteId;
      if Id = 0 then
        Exit;
      if MessageDlg('Datensatz Nr. ' + IntToStr(Id) + ' löschen?',
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;
      if FKuerzel = 'projekt' then
      begin
        if ProjektLoeschen(Id, Fehler) then
          ListeLaden
        else
          ShowMessage(Fehler);
      end
      else if TextbausteinLoeschen(Id, Fehler) then
        ListeLaden
      else
        ShowMessage(Fehler);
      Exit;
    end;
    if Id > 0 then
      UebernehmenNeueId(Id);
    Exit;
  end;
  if NachschlageArt(FKuerzel) then
  begin
    if not AktionZulaessig('maske', FKuerzel, Aktionsname, Meldung) then
    begin
      ShowMessage(Meldung);
      Exit;
    end;
    if Aktionsname = 'neu' then
      Id := NachschlageBearbeiten(FKuerzel, 0)
    else if Aktionsname = 'aendern' then
    begin
      Id := GewaehlteId;
      if Id = 0 then
      begin
        ShowMessage('Bitte zuerst eine Zeile auswählen.');
        Exit;
      end;
      if NachschlageBearbeiten(FKuerzel, Id) = 0 then
        Exit;
    end
    else if Aktionsname = 'kopieren' then
    begin
      Id := GewaehlteId;
      if Id = 0 then
      begin
        ShowMessage('Bitte zuerst eine Zeile auswählen.');
        Exit;
      end;
      Id := NachschlageKopieren(Id, Fehler);
      if Id = 0 then
      begin
        ShowMessage(Fehler);
        Exit;
      end;
    end
    else
    begin
      Id := GewaehlteId;
      if Id = 0 then
        Exit;
      if MessageDlg('Datensatz Nr. ' + IntToStr(Id) + ' löschen?',
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;
      if not NachschlageLoeschen(Id, Fehler) then
        ShowMessage(Fehler)
      else
        ListeLaden;
      Exit;
    end;
    if Id > 0 then
      UebernehmenNeueId(Id);
    Exit;
  end;
  if not AktionZulaessig('maske', FKuerzel, Aktionsname, Meldung) then
  begin
    ShowMessage(Meldung);
    Exit;
  end;
  if Aktionsname = 'neu' then
  begin
    if FKuerzel = 'artikel' then
      Id := ArtikelBearbeiten(0)
    else
      Id := GruppeBearbeiten(0);
    if Id > 0 then
      UebernehmenNeueId(Id);
  end
  else if Aktionsname = 'aendern' then
  begin
    Id := GewaehlteId;
    if Id = 0 then
      ShowMessage('Bitte zuerst eine Zeile auswählen.')
    else if FKuerzel = 'artikel' then
    begin
      if ArtikelBearbeiten(Id) > 0 then
        UebernehmenNeueId(Id);
    end
    else if GruppeBearbeiten(Id) > 0 then
      UebernehmenNeueId(Id);
  end
  else if Aktionsname = 'kopieren' then
  begin
    Id := GewaehlteId;
    if Id = 0 then
    begin
      ShowMessage('Bitte zuerst eine Zeile auswählen.');
      Exit;
    end;
    if FKuerzel = 'artikel' then
      Id := ArtikelKopieren(Id, Fehler)
    else
      Id := GruppeKopieren(Id, Fehler);
    if Id = 0 then
      ShowMessage(Fehler)
    else
      UebernehmenNeueId(Id);
  end
  else
  begin
    Id := GewaehlteId;
    if Id = 0 then
      Exit;
    if MessageDlg('Datensatz Nr. ' + IntToStr(Id) + ' löschen?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      Exit;
    if FKuerzel = 'artikel' then
    begin
      if ArtikelLoeschen(Id, Fehler) then
        ListeLaden
      else
        ShowMessage(Fehler);
    end
    else if GruppeLoeschen(Id, Fehler) then
      ListeLaden
    else
      ShowMessage(Fehler);
  end;
end;

procedure TSuchfenster.AktionAusfuehren(const Aktionsname: string);
var
  Id: Int64;
  Meldung: string;
begin
  if not VorgabeErlaubt(Aktionsname) then
  begin
    ShowMessage('Diese Funktion ist in diesem Fenster ausgeschaltet.');
    Exit;
  end;
  if Stammliste(FKuerzel) and StammAktion(Aktionsname) then
    Exit;
  if Aktionsname = 'hilfe' then
    ShowMessage(
      'Suche in der Maske ' + FBezeichnung + '.' + LineEnding +
      'Dies ist dasselbe Fenster für Kunde, Lieferant, Kontakt und Mitarbeiter.' +
      LineEnding + 'Die Maske filtert die Adressart und blendet die Spalten.' +
      LineEnding + 'F2 legt einen neuen Satz an. F7 schaltet die Sortierung um.' +
      LineEnding + 'Ein Doppelklick übernimmt die Zeile, F10 schließt.')
  else if Aktionsname = 'neu' then
  begin
    if not AktionZulaessig('maske', FKuerzel, 'neu', Meldung) then
    begin
      ShowMessage(Meldung);
      Exit;
    end;
    Id := AdresseEingeben(FKuerzel, 0);
    if Id > 0 then
      UebernehmenNeueId(Id);
  end
  else if Aktionsname = 'kopieren' then
  begin
    if not AktionZulaessig('maske', FKuerzel, 'kopieren', Meldung) then
    begin
      ShowMessage(Meldung);
      Exit;
    end;
    Id := GewaehlteId;
    if Id = 0 then
    begin
      ShowMessage('Bitte zuerst eine Zeile auswählen.');
      Exit;
    end;
    Id := AdresseKopieren(FKuerzel, Id, Meldung);
    if Id = 0 then
      ShowMessage(Meldung)
    else
      UebernehmenNeueId(Id);
  end
  else if Aktionsname = 'aendern' then
  begin
    if not AktionZulaessig('maske', FKuerzel, 'aendern', Meldung) then
    begin
      ShowMessage(Meldung);
      Exit;
    end;
    Id := GewaehlteId;
    if Id = 0 then
      ShowMessage('Bitte zuerst eine Zeile auswählen.')
    else
    begin
      Id := AdresseEingeben(FKuerzel, Id);
      if Id > 0 then
        UebernehmenNeueId(Id);
    end;
  end
  else if Aktionsname = 'sortieren' then
  begin
    FSortierung := (FSortierung + 1) mod 4;
    ListeLaden;
  end
  else if Aktionsname = 'loeschen' then
  begin
    if not AktionZulaessig('maske', FKuerzel, 'loeschen', Meldung) then
    begin
      ShowMessage(Meldung);
      Exit;
    end;
    Id := GewaehlteId;
    if Id = 0 then
      Exit;
    if Id = AngemeldeterMitarbeiter then
    begin
      ShowMessage('Der angemeldete Mitarbeiter kann nicht gelöscht werden.');
      Exit;
    end;
    if MessageDlg('Datensatz Nr. ' + IntToStr(Id) + ' löschen?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      Exit;
    if AdresseLoeschen(FKuerzel, Id) then
      ListeLaden
    else
      ShowMessage('Der Datensatz konnte nicht gelöscht werden.');
  end
  else if Aktionsname = 'uebernehmen' then
  begin
    Id := GewaehlteId;
    if Id = 0 then
    begin
      ShowMessage('Bitte zuerst eine Zeile auswählen.');
      Exit;
    end;
    FStatus.Caption := 'Ausgewählt: Nr. ' + IntToStr(Id);
    if FModal then
      ModalResult := mrOk;
  end
  else if Aktionsname = 'schliessen' then
  begin
    if FModal then
      ModalResult := mrCancel
    else
      Close;
  end;
end;

procedure TSuchfenster.TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
var
  Aktionsname: string;
  Erlaubt: Boolean;
begin
  if not TasteFinden(FTastenInfo, Ebene, Taste, Aktionsname, Erlaubt) then
    Exit;
  if Erlaubt then
    AktionAusfuehren(Aktionsname);
end;

procedure TSuchfenster.FilterTaste(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    ListeLaden;
    Key := 0;
  end;
end;

procedure TSuchfenster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (FFilter <> nil) and FFilter.Focused and (Key = VK_RETURN) then
    Exit;
  if Key = VK_ESCAPE then
  begin
    AktionAusfuehren('schliessen');
    Key := 0;
    Exit;
  end;
  if (Key = VK_RETURN) and FModal then
  begin
    AktionAusfuehren('uebernehmen');
    Key := 0;
    Exit;
  end;
  if Key = VK_F7 then
  begin
    AktionAusfuehren('sortieren');
    Key := 0;
    Exit;
  end;
  if Key = VK_F10 then
  begin
    AktionAusfuehren('schliessen');
    Key := 0;
    Exit;
  end;
  if Key = VK_F12 then
  begin
    Key := 0;
    Exit;
  end;
  if (Key >= VK_F1) and (Key <= VK_F12) then
  begin
    AlleLeistenNachziehen;
    TasteGedrueckt(Self, AktuelleEbene, Key - VK_F1 + 1);
    Key := 0;
  end;
end;

end.
