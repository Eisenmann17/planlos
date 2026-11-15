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
    FTasten: TTastenleiste;
    FKuerzel: string;
    FBezeichnung: string;
    FTastenInfo: TTastenListe;
    FIds: array of Int64;
    FModal: Boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FilterTaste(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
    procedure TastenAusDaten;
    procedure AktionAusfuehren(const Aktionsname: string);
    procedure ListeLaden;
  public
    constructor Create(TheOwner: TComponent); override;
    function Oeffne(const Kuerzel: string): Boolean;
    function EnthaeltText(const GesuchterText: string): Boolean;
    procedure WaehleId(Id: Int64);
    function GewaehlteId: Int64;
    procedure UebernehmenNeueId(Id: Int64);
  end;

procedure AdressSucheZeigen(const Kuerzel: string);
function AdressSucheWaehlen(const Kuerzel: string): Int64;

implementation

procedure AdressSucheZeigen(const Kuerzel: string);
var
  Fenster: TSuchfenster;
begin
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
begin
  Result := 0;
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

constructor TSuchfenster.Create(TheOwner: TComponent);
begin
  inherited CreateNew(TheOwner, 1);
  Position := poDesigned;
  KeyPreview := True;
  Caption := 'Planlos';
  OnKeyDown := @FormKeyDown;
  OnClose := @FormClose;

  FTasten := TTastenleiste.Create(Self);
  FTasten.Parent := Self;
  FTasten.Align := alBottom;
  FTasten.Height := 96;
  FTasten.OnTaste := @TasteGedrueckt;

  FStatus := TLabel.Create(Self);
  FStatus.Parent := Self;
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
  FListe.BorderSpacing.Around := 6;
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
end;

procedure TSuchfenster.TastenAusDaten;
var
  i: Integer;
begin
  FTastenInfo := TastenLaden(FKuerzel, 'suche');
  FTasten.AlleBeschriftungenLoeschen;
  for i := 0 to High(FTastenInfo) do
    FTasten.SetzeTaste(FTastenInfo[i].Ebene, FTastenInfo[i].Taste,
      FTastenInfo[i].Beschriftung, FTastenInfo[i].Erlaubt);
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
      FListe.RowCount := 2;
    if Zeilen.Count > 0 then
      FListe.Row := 1;
    FStatus.Caption := IntToStr(Zeilen.Count) + ' Treffer in ' + FBezeichnung;
  finally
    TeileZeile.Free;
    Zeilen.Free;
    Spalten.Free;
  end;
end;

function TSuchfenster.GewaehlteId: Int64;
begin
  Result := 0;
  if (FListe.Row < 1) or (FListe.Row > Length(FIds)) then
    Exit;
  Result := FIds[FListe.Row - 1];
end;

procedure TSuchfenster.WaehleId(Id: Int64);
var
  i: Integer;
begin
  for i := 0 to High(FIds) do
    if FIds[i] = Id then
    begin
      FListe.Row := i + 1;
      FStatus.Caption := 'Ausgewählt: Nr. ' + IntToStr(Id);
      Exit;
    end;
end;

procedure TSuchfenster.UebernehmenNeueId(Id: Int64);
begin
  ListeLaden;
  WaehleId(Id);
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

procedure TSuchfenster.AktionAusfuehren(const Aktionsname: string);
var
  Id: Int64;
begin
  if Aktionsname = 'hilfe' then
    ShowMessage(
      'Suche in der Maske ' + FBezeichnung + '.' + LineEnding +
      'Dies ist dasselbe Fenster für Kunde, Lieferant, Kontakt und Mitarbeiter.' +
      LineEnding + 'Die Maske filtert die Adressart und blendet die Spalten.' +
      LineEnding + 'F2 legt einen neuen Satz an und wählt ihn hier aus.' +
      LineEnding + 'F10 übernimmt die Zeile, F12 schließt.')
  else if Aktionsname = 'neu' then
  begin
    Id := AdresseEingeben(FKuerzel, 0);
    if Id > 0 then
      UebernehmenNeueId(Id);
  end
  else if Aktionsname = 'aendern' then
  begin
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
  else if Aktionsname = 'loeschen' then
  begin
    Id := GewaehlteId;
    if Id = 0 then
      Exit;
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
  if (Key >= VK_F1) and (Key <= VK_F12) then
  begin
    AlleLeistenNachziehen;
    TasteGedrueckt(Self, AktuelleEbene, Key - VK_F1 + 1);
    Key := 0;
  end;
end;

end.
