unit ubelegfenster;

{ Das eine Belegfenster. Kopf, Positionen, Summe und Fuß richten sich
  nach der Belegart. Beträge werden in Cent gerechnet.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Grids,
  Graphics, LCLType, utastenleiste, umaske, usuche, ubeleg;

type
  TBelegfenster = class(TForm)
  private
    FKopf: TPanel;
    FEmpfaengerTitel: TLabel;
    FEmpfaengerName: TLabel;
    FBezug: TLabel;
    FBezeichnung: TEdit;
    FKopftext: TMemo;
    FListe: TStringGrid;
    FSumme: TMemo;
    FFusstext: TMemo;
    FTasten: TTastenleiste;
    FArt: TBelegart;
    FKopfDaten: TBelegKopf;
    FTastenInfo: TBelegTasten;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
    procedure ListeGeaendert(Sender: TObject);
    procedure TastenAusDaten;
    procedure Aktion(const Aktionsname: string);
    procedure BereicheSetzen;
    procedure EmpfaengerZeigen;
    procedure PositionHinzufuegen;
    procedure PositionEntfernen;
    function PositionenLesen(out Positionen: TPosListe; out Fehler: string): Boolean;
    procedure SummenZeigen;
    function SpeichernStill(out Fehler: string): Int64;
    procedure Folge(const ZielKuerzel: string);
  public
    constructor Create(TheOwner: TComponent); override;
    function OeffneNeu(const Kuerzel: string): Boolean;
    function OeffneId(Id: Int64): Boolean;
  end;

function BelegBearbeiten(const Kuerzel: string; Id: Int64): Int64;

implementation

function BelegBearbeiten(const Kuerzel: string; Id: Int64): Int64;
var
  Fenster: TBelegfenster;
begin
  Result := 0;
  Fenster := TBelegfenster.Create(Application);
  try
    if Id = 0 then
    begin
      if not Fenster.OeffneNeu(Kuerzel) then
        Exit;
    end
    else if not Fenster.OeffneId(Id) then
      Exit;
    if Fenster.ShowModal = mrOk then
      Result := Fenster.FKopfDaten.Id;
  finally
    Fenster.Free;
  end;
end;

constructor TBelegfenster.Create(TheOwner: TComponent);
begin
  inherited CreateNew(TheOwner, 1);
  Position := poDesigned;
  KeyPreview := True;
  OnKeyDown := @FormKeyDown;
  Caption := 'Planlos';

  FTasten := TTastenleiste.Create(Self);
  FTasten.Parent := Self;
  FTasten.Align := alBottom;
  FTasten.Height := 96;
  FTasten.OnTaste := @TasteGedrueckt;

  FFusstext := TMemo.Create(Self);
  FFusstext.Parent := Self;
  FFusstext.Align := alBottom;
  FFusstext.Height := 52;
  FFusstext.ScrollBars := ssVertical;

  FSumme := TMemo.Create(Self);
  FSumme.Parent := Self;
  FSumme.Align := alBottom;
  FSumme.Height := 78;
  FSumme.ReadOnly := True;
  FSumme.ScrollBars := ssVertical;
  FSumme.Color := clBtnFace;

  FKopf := TPanel.Create(Self);
  FKopf.Parent := Self;
  FKopf.Align := alTop;
  FKopf.Height := 148;
  FKopf.BevelOuter := bvNone;

  FEmpfaengerTitel := TLabel.Create(Self);
  FEmpfaengerTitel.Parent := FKopf;
  FEmpfaengerTitel.Left := 8;
  FEmpfaengerTitel.Top := 8;

  FEmpfaengerName := TLabel.Create(Self);
  FEmpfaengerName.Parent := FKopf;
  FEmpfaengerName.Left := 120;
  FEmpfaengerName.Top := 8;
  FEmpfaengerName.AutoSize := False;
  FEmpfaengerName.Width := 460;

  FBezug := TLabel.Create(Self);
  FBezug.Parent := FKopf;
  FBezug.Left := 600;
  FBezug.Top := 8;
  FBezug.AutoSize := False;
  FBezug.Width := 280;

  FBezeichnung := TEdit.Create(Self);
  FBezeichnung.Parent := FKopf;
  FBezeichnung.Left := 8;
  FBezeichnung.Top := 32;
  FBezeichnung.Width := 500;
  FBezeichnung.TextHint := 'Bezeichnung';

  FKopftext := TMemo.Create(Self);
  FKopftext.Parent := FKopf;
  FKopftext.Left := 8;
  FKopftext.Top := 64;
  FKopftext.Width := 860;
  FKopftext.Height := 76;
  FKopftext.ScrollBars := ssVertical;

  FListe := TStringGrid.Create(Self);
  FListe.Parent := Self;
  FListe.Align := alClient;
  FListe.FixedCols := 0;
  FListe.FixedRows := 1;
  FListe.ColCount := 6;
  FListe.RowCount := 2;
  FListe.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
    goRowSelect, goColSizing, goEditing, goThumbTracking];
  FListe.OnEditingDone := @ListeGeaendert;
  FListe.Cells[0, 0] := 'Pos';
  FListe.Cells[1, 0] := 'Text';
  FListe.Cells[2, 0] := 'Menge';
  FListe.Cells[3, 0] := 'Einheit';
  FListe.Cells[4, 0] := 'Einzelpreis';
  FListe.Cells[5, 0] := 'MwSt %';
  FListe.ColWidths[0] := 40;
  FListe.ColWidths[1] := 360;
  FListe.ColWidths[2] := 80;
  FListe.ColWidths[3] := 80;
  FListe.ColWidths[4] := 110;
  FListe.ColWidths[5] := 70;
end;

procedure TBelegfenster.BereicheSetzen;
begin
  FKopf.Visible := FArt.Kopf;
  FListe.Visible := FArt.Positionen;
  FSumme.Visible := FArt.Summe;
  FFusstext.Visible := FArt.Fuss;
  FEmpfaengerTitel.Visible := FArt.EmpfaengerMaske <> '';
  FEmpfaengerName.Visible := FArt.EmpfaengerMaske <> '';
  if FArt.Mwst then
    FListe.ColWidths[5] := 70
  else
    FListe.ColWidths[5] := 0;
  if FArt.BeschriftungEmpfaenger <> '' then
    FEmpfaengerTitel.Caption := FArt.BeschriftungEmpfaenger
  else
    FEmpfaengerTitel.Caption := 'Empfänger';
end;

procedure TBelegfenster.TastenAusDaten;
var
  i: Integer;
begin
  FTastenInfo := BelegTasten(FArt.Kuerzel, 'beleg');
  FTasten.AlleBeschriftungenLoeschen;
  for i := 0 to High(FTastenInfo) do
    FTasten.SetzeTaste(FTastenInfo[i].Ebene, FTastenInfo[i].Taste,
      FTastenInfo[i].Beschriftung, FTastenInfo[i].Erlaubt);
end;

procedure TBelegfenster.EmpfaengerZeigen;
begin
  if FKopfDaten.AdresseId = 0 then
    FEmpfaengerName.Caption := 'noch keiner gewählt'
  else
    FEmpfaengerName.Caption := AdressKurzname(FKopfDaten.AdresseId);
  if FKopfDaten.BezugNummer <> '' then
    FBezug.Caption := 'aus ' + FKopfDaten.BezugNummer
  else
    FBezug.Caption := '';
end;

function TBelegfenster.OeffneNeu(const Kuerzel: string): Boolean;
begin
  Result := BelegartLaden(Kuerzel, FArt);
  if not Result then
    Exit;
  FKopfDaten.Id := 0;
  FKopfDaten.Modulart := FArt.Kuerzel;
  FKopfDaten.Nummer := '';
  FKopfDaten.AdresseId := 0;
  FKopfDaten.Bezeichnung := '';
  FKopfDaten.Kopftext := '';
  FKopfDaten.Fusstext := '';
  FKopfDaten.Notiz := '';
  FKopfDaten.BezugId := 0;
  FKopfDaten.BezugNummer := '';
  FKopfDaten.MwstRechnen := FArt.Mwst;
  Caption := 'Planlos - ' + FArt.Bezeichnung + ' neu';
  Position := poDesigned;
  Left := FArt.Links;
  Top := FArt.Oben;
  Width := FArt.Breite;
  Height := FArt.Hoehe;
  BereicheSetzen;
  TastenAusDaten;
  EmpfaengerZeigen;
  SummenZeigen;
end;

function TBelegfenster.OeffneId(Id: Int64): Boolean;
var
  Positionen: TPosListe;
  i: Integer;
begin
  Result := BelegLaden(Id, FKopfDaten, Positionen);
  if not Result then
    Exit;
  if not BelegartLaden(FKopfDaten.Modulart, FArt) then
    Exit(False);
  Caption := 'Planlos - ' + FArt.Bezeichnung + ' ' + FKopfDaten.Nummer;
  Position := poDesigned;
  Left := FArt.Links;
  Top := FArt.Oben;
  Width := FArt.Breite;
  Height := FArt.Hoehe;
  FBezeichnung.Text := FKopfDaten.Bezeichnung;
  FKopftext.Text := FKopfDaten.Kopftext;
  FFusstext.Text := FKopfDaten.Fusstext;
  if Length(Positionen) = 0 then
    FListe.RowCount := 2
  else
    FListe.RowCount := Length(Positionen) + 1;
  for i := 0 to High(Positionen) do
  begin
    FListe.Cells[0, i + 1] := IntToStr(i + 1);
    FListe.Cells[1, i + 1] := Positionen[i].Text;
    FListe.Cells[2, i + 1] := MilliAlsText(Positionen[i].MengeMilli);
    FListe.Cells[3, i + 1] := Positionen[i].Einheit;
    FListe.Cells[4, i + 1] := CentAlsText(Positionen[i].EinzelpreisCent);
    FListe.Cells[5, i + 1] := IntToStr(Positionen[i].MwstSatz);
  end;
  BereicheSetzen;
  TastenAusDaten;
  EmpfaengerZeigen;
  SummenZeigen;
end;

procedure TBelegfenster.PositionHinzufuegen;
var
  Zeile, Satz: Integer;
begin
  if not FArt.Positionen then
    Exit;
  if (FListe.RowCount = 2) and (Trim(FListe.Cells[1, 1]) = '') and
     (Trim(FListe.Cells[4, 1]) = '') then
    Zeile := 1
  else
  begin
    FListe.RowCount := FListe.RowCount + 1;
    Zeile := FListe.RowCount - 1;
  end;
  if FArt.Mwst then
    Satz := 19
  else
    Satz := 0;
  FListe.Cells[0, Zeile] := IntToStr(Zeile);
  FListe.Cells[2, Zeile] := '1';
  FListe.Cells[3, Zeile] := 'Stück';
  FListe.Cells[4, Zeile] := '0,00';
  FListe.Cells[5, Zeile] := IntToStr(Satz);
  FListe.Row := Zeile;
  FListe.Col := 1;
end;

procedure TBelegfenster.PositionEntfernen;
var
  Zeile, Spalte: Integer;
begin
  if not FArt.Positionen then
    Exit;
  Zeile := FListe.Row;
  if Zeile < 1 then
    Exit;
  if FListe.RowCount <= 2 then
  begin
    for Spalte := 0 to FListe.ColCount - 1 do
      FListe.Cells[Spalte, 1] := '';
  end
  else
    FListe.DeleteRow(Zeile);
  SummenZeigen;
end;

function TBelegfenster.PositionenLesen(out Positionen: TPosListe;
  out Fehler: string): Boolean;
var
  Zeile, Anzahl, Satz: Integer;
  Zeilentext, MengeText, PreisText: string;
  Milli, Cent: Int64;
begin
  Result := False;
  Fehler := '';
  SetLength(Positionen, 0);
  if not FArt.Positionen then
    Exit(True);
  Anzahl := 0;
  for Zeile := 1 to FListe.RowCount - 1 do
  begin
    Zeilentext := Trim(FListe.Cells[1, Zeile]);
    MengeText := Trim(FListe.Cells[2, Zeile]);
    PreisText := Trim(FListe.Cells[4, Zeile]);
    if (Zeilentext = '') and (MengeText = '') and (PreisText = '') then
      Continue;
    if Zeilentext = '' then
    begin
      Fehler := 'Zeile ' + IntToStr(Zeile) + ' braucht einen Text.';
      Exit;
    end;
    if not MilliAusText(MengeText, Milli) then
    begin
      Fehler := 'Menge in Zeile ' + IntToStr(Zeile) + ' ist keine Zahl.';
      Exit;
    end;
    if not CentAusText(PreisText, Cent) then
    begin
      Fehler := 'Einzelpreis in Zeile ' + IntToStr(Zeile) + ' ist kein Betrag.';
      Exit;
    end;
    if FArt.Mwst then
      Satz := StrToIntDef(Trim(FListe.Cells[5, Zeile]), -1)
    else
      Satz := 0;
    if (Satz <> 0) and (Satz <> 7) and (Satz <> 19) then
    begin
      Fehler := 'MwSt in Zeile ' + IntToStr(Zeile) + ' muss 19, 7 oder 0 sein.';
      Exit;
    end;
    SetLength(Positionen, Anzahl + 1);
    Positionen[Anzahl].Text := Zeilentext;
    Positionen[Anzahl].MengeMilli := Milli;
    Positionen[Anzahl].Einheit := Trim(FListe.Cells[3, Zeile]);
    Positionen[Anzahl].EinzelpreisCent := Cent;
    Positionen[Anzahl].MwstSatz := Satz;
    Positionen[Anzahl].ArtikelId := 0;
    Inc(Anzahl);
  end;
  Result := True;
end;

procedure TBelegfenster.SummenZeigen;
var
  Positionen: TPosListe;
  Fehler, Anzeige: string;
  Summe: TBelegSumme;
  i: Integer;
begin
  if not PositionenLesen(Positionen, Fehler) then
  begin
    FSumme.Text := Fehler;
    Exit;
  end;
  Summe := SummeRechnen(Positionen, FArt.Mwst and FKopfDaten.MwstRechnen);
  Anzeige := 'Netto: ' + CentAlsText(Summe.NettoCent) + ' €';
  if FArt.Mwst then
    for i := 0 to High(Summe.Gruppen) do
      if Summe.Gruppen[i].Satz <> 0 then
        Anzeige := Anzeige + LineEnding + 'MwSt ' + IntToStr(Summe.Gruppen[i].Satz) +
          ' %: ' + CentAlsText(Summe.Gruppen[i].SteuerCent) + ' €';
  Anzeige := Anzeige + LineEnding + 'Brutto: ' + CentAlsText(Summe.BruttoCent) + ' €';
  FSumme.Text := Anzeige;
end;

procedure TBelegfenster.ListeGeaendert(Sender: TObject);
begin
  SummenZeigen;
end;

function TBelegfenster.SpeichernStill(out Fehler: string): Int64;
var
  Positionen: TPosListe;
begin
  Result := 0;
  if not PositionenLesen(Positionen, Fehler) then
    Exit;
  FKopfDaten.Modulart := FArt.Kuerzel;
  FKopfDaten.Bezeichnung := FBezeichnung.Text;
  FKopfDaten.Kopftext := FKopftext.Text;
  FKopfDaten.Fusstext := FFusstext.Text;
  Result := BelegSpeichern(FKopfDaten, Positionen, Fehler);
  if Result > 0 then
    Caption := 'Planlos - ' + FArt.Bezeichnung + ' ' + FKopfDaten.Nummer;
end;

procedure TBelegfenster.Folge(const ZielKuerzel: string);
var
  Fehler: string;
  Neu, Bisher: Int64;
begin
  Bisher := SpeichernStill(Fehler);
  if Bisher = 0 then
  begin
    ShowMessage(Fehler);
    Exit;
  end;
  Neu := FolgebelegErzeugen(Bisher, ZielKuerzel, Fehler);
  if Neu = 0 then
    ShowMessage(Fehler)
  else
    BelegBearbeiten('', Neu);
end;

procedure TBelegfenster.Aktion(const Aktionsname: string);
var
  Fehler: string;
  Gewaehlt: Int64;
begin
  if Aktionsname = 'hilfe' then
    ShowMessage(
      FArt.Bezeichnung + ' ist eine Belegart aus der Datenbank.' + LineEnding +
      'F3 wählt den ' + FArt.BeschriftungEmpfaenger + '.' + LineEnding +
      'F5 fügt eine Position an, F8 entfernt sie.' + LineEnding +
      'F10 speichert. Folgebelege stehen als eigene Tasten da, wenn die ' +
      'Belegart das erlaubt.')
  else if Aktionsname = 'empfaenger' then
  begin
    if FArt.EmpfaengerMaske = '' then
      Exit;
    Gewaehlt := AdressSucheWaehlen(FArt.EmpfaengerMaske);
    if Gewaehlt > 0 then
    begin
      FKopfDaten.AdresseId := Gewaehlt;
      EmpfaengerZeigen;
    end;
  end
  else if Aktionsname = 'position' then
    PositionHinzufuegen
  else if Aktionsname = 'position_weg' then
    PositionEntfernen
  else if Aktionsname = 'speichern' then
  begin
    if SpeichernStill(Fehler) = 0 then
      ShowMessage(Fehler)
    else
      ModalResult := mrOk;
  end
  else if Aktionsname = 'schliessen' then
    ModalResult := mrCancel
  else if Copy(Aktionsname, 1, 6) = 'folge:' then
    Folge(Copy(Aktionsname, 7, 80));
end;

procedure TBelegfenster.TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
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

procedure TBelegfenster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
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
