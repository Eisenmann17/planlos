unit ubelegsuche;

{ Eine Suche für alle Belegarten. Die Art filtert die Liste.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Grids,
  Graphics, LCLType, utastenleiste, ubeleg, ubelegfenster;

type
  TBelegsuche = class(TForm)
  private
    FFilter: TEdit;
    FHinweis: TLabel;
    FListe: TStringGrid;
    FStatus: TLabel;
    FTasten: TTastenleiste;
    FArt: TBelegart;
    FTastenInfo: TBelegTasten;
    FIds: array of Int64;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FilterTaste(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
    procedure ListeLaden;
    procedure WaehleId(Id: Int64);
    function GewaehlteId: Int64;
    procedure Aktion(const Aktionsname: string);
  public
    constructor Create(TheOwner: TComponent); override;
    function Oeffne(const Kuerzel: string): Boolean;
  end;

procedure BelegsucheZeigen(const Kuerzel: string);

implementation

uses
  ubenutzer;

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

procedure BelegsucheZeigen(const Kuerzel: string);
var
  Fenster: TBelegsuche;
  Meldung: string;
begin
  if not AktionZulaessig('beleg', Kuerzel, 'sehen', Meldung) then
  begin
    ShowMessage(Meldung);
    Exit;
  end;
  Fenster := TBelegsuche.Create(Application);
  if not Fenster.Oeffne(Kuerzel) then
  begin
    Fenster.Free;
    ShowMessage('Die Belegart ' + Kuerzel + ' ist nicht angelegt.');
    Exit;
  end;
  Fenster.Show;
end;

constructor TBelegsuche.Create(TheOwner: TComponent);
begin
  inherited CreateNew(TheOwner, 1);
  Position := poDesigned;
  KeyPreview := True;
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
  FFilter.TextHint := 'Nummer, Name oder Bezeichnung';
  FFilter.OnKeyDown := @FilterTaste;

  FListe := TStringGrid.Create(Self);
  FListe.Parent := Self;
  FListe.Align := alClient;
  FListe.FixedCols := 0;
  FListe.FixedRows := 1;
  FListe.RowCount := 1;
  FListe.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
    goRowSelect, goColSizing, goThumbTracking];
  FListe.BorderSpacing.Around := 6;
end;

procedure TBelegsuche.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

function TBelegsuche.Oeffne(const Kuerzel: string): Boolean;
var
  i: Integer;
begin
  Result := BelegartLaden(Kuerzel, FArt);
  if not Result then
    Exit;
  Caption := 'Planlos - ' + FArt.Bezeichnung;
  Position := poDesigned;
  Left := FArt.Links;
  Top := FArt.Oben;
  Width := FArt.Breite;
  Height := FArt.Hoehe;
  FHinweis.Caption := 'Belegart ' + FArt.Bezeichnung +
    '. Nummernkreis ' + FArt.Nummernkreis + '. F2 legt einen neuen Beleg an.';
  FTastenInfo := BelegTasten(FArt.Kuerzel, 'suche');
  FTasten.AlleBeschriftungenLoeschen;
  for i := 0 to High(FTastenInfo) do
    FTasten.SetzeTaste(FTastenInfo[i].Ebene, FTastenInfo[i].Taste,
      FTastenInfo[i].Beschriftung, FTastenInfo[i].Erlaubt);
  ListeLaden;
end;

procedure TBelegsuche.ListeLaden;
var
  Spalten, Zeilen, TeileZeile: TStringList;
  Spalte, Zeile: Integer;
begin
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  TeileZeile := TStringList.Create;
  try
    BelegeLesen(FArt.Kuerzel, FFilter.Text, Spalten, Zeilen);
    FListe.ColCount := Spalten.Count;
    if Zeilen.Count = 0 then
      FListe.RowCount := 2
    else
      FListe.RowCount := Zeilen.Count + 1;
    for Spalte := 0 to Spalten.Count - 1 do
    begin
      FListe.Cells[Spalte, 0] := Spalten[Spalte];
      if Spalte = 0 then
        FListe.ColWidths[Spalte] := 50
      else if Spalte = 4 then
        FListe.ColWidths[Spalte] := 100
      else
        FListe.ColWidths[Spalte] := 160;
    end;
    SetLength(FIds, Zeilen.Count);
    for Zeile := 0 to Zeilen.Count - 1 do
    begin
      Teile(Zeilen[Zeile], TeileZeile);
      if TeileZeile.Count > 0 then
        FIds[Zeile] := StrToInt64Def(TeileZeile[0], 0);
      for Spalte := 0 to Spalten.Count - 1 do
        if Spalte < TeileZeile.Count then
          FListe.Cells[Spalte, Zeile + 1] := TeileZeile[Spalte]
        else
          FListe.Cells[Spalte, Zeile + 1] := '';
    end;
    if Zeilen.Count > 0 then
      FListe.Row := 1;
    FStatus.Caption := IntToStr(Zeilen.Count) + ' ' + FArt.Bezeichnung;
  finally
    TeileZeile.Free;
    Zeilen.Free;
    Spalten.Free;
  end;
end;

function TBelegsuche.GewaehlteId: Int64;
begin
  Result := 0;
  if (FListe.Row < 1) or (FListe.Row > Length(FIds)) then
    Exit;
  Result := FIds[FListe.Row - 1];
end;

procedure TBelegsuche.WaehleId(Id: Int64);
var
  i: Integer;
begin
  for i := 0 to High(FIds) do
    if FIds[i] = Id then
    begin
      FListe.Row := i + 1;
      Exit;
    end;
end;

procedure TBelegsuche.Aktion(const Aktionsname: string);
var
  Id: Int64;
  Meldung: string;
begin
  if Aktionsname = 'hilfe' then
    ShowMessage(
      'Suche für ' + FArt.Bezeichnung + '.' + LineEnding +
      'F2 legt einen neuen Beleg an. Im Beleg wählt F3 den Empfänger,' + LineEnding +
      'dort kann mit F2 ein neuer Kontakt angelegt und mit F10 übernommen werden.')
  else if Aktionsname = 'filtern' then
    ListeLaden
  else if Aktionsname = 'neu' then
  begin
    if not AktionZulaessig('beleg', FArt.Kuerzel, 'neu', Meldung) then
    begin
      ShowMessage(Meldung);
      Exit;
    end;
    Id := BelegBearbeiten(FArt.Kuerzel, 0);
    if Id > 0 then
    begin
      ListeLaden;
      WaehleId(Id);
    end;
  end
  else if Aktionsname = 'oeffnen' then
  begin
    Id := GewaehlteId;
    if Id = 0 then
      ShowMessage('Bitte zuerst eine Zeile auswählen.')
    else
    begin
      BelegBearbeiten(FArt.Kuerzel, Id);
      ListeLaden;
      WaehleId(Id);
    end;
  end
  else if Aktionsname = 'uebernehmen' then
    FStatus.Caption := 'Ausgewählt: ' + BelegNummer(GewaehlteId)
  else if Aktionsname = 'schliessen' then
    Close;
end;

procedure TBelegsuche.TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
var
  i: Integer;
begin
  for i := 0 to High(FTastenInfo) do
    if (FTastenInfo[i].Ebene = Ebene) and (FTastenInfo[i].Taste = Taste) and
       FTastenInfo[i].Erlaubt then
    begin
      Aktion(FTastenInfo[i].Aktion);
      Exit;
    end;
end;

procedure TBelegsuche.FilterTaste(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    ListeLaden;
    Key := 0;
  end;
end;

procedure TBelegsuche.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (FFilter <> nil) and FFilter.Focused and (Key = VK_RETURN) then
    Exit;
  if Key = VK_ESCAPE then
  begin
    Close;
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
