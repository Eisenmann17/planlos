unit udrucklayoutfenster;

{ Fenster zum Verschieben und Ein- und Ausblenden eines Drucklayouts.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Graphics,
  LCLType, LCLIntf, udruck, ubeleg, udrucklayout;

type
  TDrucklayoutFenster = class(TForm)
    ListBereich: TListBox;
    ListEintrag: TListBox;
    CheckSichtbar: TCheckBox;
    LabelBeschriftung: TLabel;
    EditBeschriftung: TEdit;
    LabelBreite: TLabel;
    EditBreite: TEdit;
    LabelOrt: TLabel;
    PaintSeite: TPaintBox;
    PanelKnopf: TPanel;
    LabelEsc: TLabel;
    ButtonAbbrechen: TButton;
    ButtonVorschau: TButton;
    ButtonExport: TButton;
    ButtonImport: TButton;
    LabelF10: TLabel;
    ButtonSpeichern: TButton;
    procedure FormZeigen(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BereichGewaehlt(Sender: TObject);
    procedure EintragGewaehlt(Sender: TObject);
    procedure EigenschaftGeaendert(Sender: TObject);
    procedure SeiteMalen(Sender: TObject);
    procedure SeiteMaus(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SeiteZiehen(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SeiteLos(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AbbrechenKlick(Sender: TObject);
    procedure SpeichernKlick(Sender: TObject);
    procedure VorschauKlick(Sender: TObject);
    procedure ExportKlick(Sender: TObject);
    procedure ImportKlick(Sender: TObject);
  private
    FBelegartId: Int64;
    FVorlageId: Int64;
    FGewaehlt: Int64;
    FVorlage: TDruckvorlage;
    FLayout: TDruckLayout;
    FBereich: Integer;
    FEintrag: Integer;
    FSync: Boolean;
    FZiehen: Boolean;
    FZiehBereich: Boolean;
    FGriffX: Integer;
    FGriffY: Integer;
    function BereichName(const Id: string): string;
    function IstPositionen: Boolean;
    function IstFest: Boolean;
    procedure BereicheFuellen;
    procedure EintraegeFuellen;
    procedure MaskeFuellen;
    procedure MaskeLesen;
    procedure OrtZeigen;
    procedure AuswahlSetzen(Bereich, Eintrag: Integer);
    function SeiteNachX(Mm: Integer): Integer;
    function SeiteNachY(Mm: Integer): Integer;
    function XNachSeite(Pixel: Integer): Integer;
    function YNachSeite(Pixel: Integer): Integer;
    procedure FeldBewegen(DX, DY: Integer);
  end;

function DrucklayoutBearbeiten(BelegartId, VorlageId: Int64;
  out GewaehlteVorlage: Int64): Boolean;

implementation

{$R *.lfm}

uses
  Math, udatenbank;

const
  Mass = 1.6;

function DrucklayoutBearbeiten(BelegartId, VorlageId: Int64;
  out GewaehlteVorlage: Int64): Boolean;
var
  Fenster: TDrucklayoutFenster;
begin
  GewaehlteVorlage := VorlageId;
  Fenster := TDrucklayoutFenster.Create(Application);
  try
    Fenster.FBelegartId := BelegartId;
    Fenster.FVorlageId := VorlageId;
    Fenster.FGewaehlt := 0;
    Result := Fenster.ShowModal = mrOk;
    if Result and (Fenster.FGewaehlt > 0) then
      GewaehlteVorlage := Fenster.FGewaehlt;
  finally
    Fenster.Free;
  end;
end;

function TDrucklayoutFenster.BereichName(const Id: string): string;
begin
  if Id = 'firmenkopf' then
    Result := 'Firmenkopf'
  else if Id = 'anschrift' then
    Result := 'Anschrift'
  else if Id = 'belegkopf' then
    Result := 'Belegkopf'
  else if Id = 'kopftext' then
    Result := 'Kopftext'
  else if Id = 'positionen' then
    Result := 'Positionen'
  else if Id = 'summen' then
    Result := 'Summen'
  else if Id = 'fusstext' then
    Result := 'Fußtext'
  else if Id = 'fusszeile' then
    Result := 'Fußzeile'
  else
    Result := Id;
end;

function TDrucklayoutFenster.IstPositionen: Boolean;
begin
  Result := (FBereich >= 0) and (FBereich <= High(FLayout.Bereiche)) and
    (FLayout.Bereiche[FBereich].Id = 'positionen');
end;

function TDrucklayoutFenster.IstFest: Boolean;
begin
  Result := (FBereich >= 0) and (FBereich <= High(FLayout.Bereiche)) and
    (FLayout.Bereiche[FBereich].Anker = 'fest');
end;

function TDrucklayoutFenster.SeiteNachX(Mm: Integer): Integer;
begin
  Result := 16 + Round(Mm * Mass);
end;

function TDrucklayoutFenster.SeiteNachY(Mm: Integer): Integer;
begin
  Result := 8 + Round(Mm * Mass);
end;

function TDrucklayoutFenster.XNachSeite(Pixel: Integer): Integer;
begin
  Result := Round((Pixel - 16) / Mass);
end;

function TDrucklayoutFenster.YNachSeite(Pixel: Integer): Integer;
begin
  Result := Round((Pixel - 8) / Mass);
end;

procedure TDrucklayoutFenster.BereicheFuellen;
var
  i, Bisher: Integer;
begin
  Bisher := ListBereich.ItemIndex;
  ListBereich.Items.BeginUpdate;
  try
    ListBereich.Items.Clear;
    for i := 0 to High(FLayout.Bereiche) do
      ListBereich.Items.Add(BereichName(FLayout.Bereiche[i].Id));
  finally
    ListBereich.Items.EndUpdate;
  end;
  if (Bisher >= 0) and (Bisher < ListBereich.Items.Count) then
    ListBereich.ItemIndex := Bisher
  else if ListBereich.Items.Count > 0 then
    ListBereich.ItemIndex := 0;
  FBereich := ListBereich.ItemIndex;
end;

procedure TDrucklayoutFenster.EintraegeFuellen;
var
  i, Bisher: Integer;
  Zeile: string;
begin
  Bisher := FEintrag;
  ListEintrag.Items.BeginUpdate;
  try
    ListEintrag.Items.Clear;
    if IstPositionen then
      for i := 0 to High(FLayout.Spalten) do
      begin
        Zeile := FLayout.Spalten[i].Beschriftung;
        if Zeile = '' then
          Zeile := FLayout.Spalten[i].Id;
        if not FLayout.Spalten[i].Sichtbar then
          Zeile := '— ' + Zeile;
        ListEintrag.Items.Add(Zeile);
      end
    else if (FBereich >= 0) and (FBereich <= High(FLayout.Bereiche)) then
      for i := 0 to High(FLayout.Bereiche[FBereich].Felder) do
      begin
        Zeile := FLayout.Bereiche[FBereich].Felder[i].Id;
        if not FLayout.Bereiche[FBereich].Felder[i].Sichtbar then
          Zeile := '— ' + Zeile;
        ListEintrag.Items.Add(Zeile);
      end;
  finally
    ListEintrag.Items.EndUpdate;
  end;
  if (Bisher >= 0) and (Bisher < ListEintrag.Items.Count) then
    ListEintrag.ItemIndex := Bisher
  else if ListEintrag.Items.Count > 0 then
    ListEintrag.ItemIndex := 0
  else
    ListEintrag.ItemIndex := -1;
  FEintrag := ListEintrag.ItemIndex;
end;

procedure TDrucklayoutFenster.MaskeFuellen;
begin
  FSync := True;
  try
    EditBreite.Visible := IstPositionen;
    LabelBreite.Visible := IstPositionen;
    if IstPositionen and (FEintrag >= 0) and (FEintrag <= High(FLayout.Spalten)) then
    begin
      CheckSichtbar.Checked := FLayout.Spalten[FEintrag].Sichtbar;
      EditBeschriftung.Text := FLayout.Spalten[FEintrag].Beschriftung;
      EditBreite.Text := IntToStr(FLayout.Spalten[FEintrag].BreiteMm);
    end
    else if (not IstPositionen) and (FBereich >= 0) and (FEintrag >= 0) and
      (FEintrag <= High(FLayout.Bereiche[FBereich].Felder)) then
    begin
      CheckSichtbar.Checked := FLayout.Bereiche[FBereich].Felder[FEintrag].Sichtbar;
      EditBeschriftung.Text := FLayout.Bereiche[FBereich].Felder[FEintrag].Beschriftung;
      EditBreite.Text := '';
    end
    else
    begin
      CheckSichtbar.Checked := False;
      EditBeschriftung.Text := '';
      EditBreite.Text := '';
    end;
  finally
    FSync := False;
  end;
  OrtZeigen;
end;

procedure TDrucklayoutFenster.MaskeLesen;
var
  Breite: Integer;
begin
  if FSync then
    Exit;
  if IstPositionen and (FEintrag >= 0) and (FEintrag <= High(FLayout.Spalten)) then
  begin
    FLayout.Spalten[FEintrag].Sichtbar := CheckSichtbar.Checked;
    FLayout.Spalten[FEintrag].Beschriftung := EditBeschriftung.Text;
    Breite := StrToIntDef(Trim(EditBreite.Text), FLayout.Spalten[FEintrag].BreiteMm);
    if Breite < 0 then
      Breite := 0;
    FLayout.Spalten[FEintrag].BreiteMm := Breite;
  end
  else if (not IstPositionen) and (FBereich >= 0) and (FEintrag >= 0) and
    (FEintrag <= High(FLayout.Bereiche[FBereich].Felder)) then
  begin
    FLayout.Bereiche[FBereich].Felder[FEintrag].Sichtbar := CheckSichtbar.Checked;
    FLayout.Bereiche[FBereich].Felder[FEintrag].Beschriftung := EditBeschriftung.Text;
  end;
end;

procedure TDrucklayoutFenster.OrtZeigen;
var
  Summe, Nutzbar, i: Integer;
begin
  Nutzbar := SeiteBreite - FLayout.RandLinks - FLayout.RandRechts;
  if IstPositionen then
  begin
    Summe := 0;
    for i := 0 to High(FLayout.Spalten) do
      if FLayout.Spalten[i].Sichtbar then
        Summe := Summe + FLayout.Spalten[i].BreiteMm;
    LabelOrt.Caption := IntToStr(Summe) + ' von ' + IntToStr(Nutzbar) + ' mm';
    if Summe > Nutzbar then
      LabelOrt.Font.Color := clRed
    else
      LabelOrt.Font.Color := clWindowText;
  end
  else if (FBereich >= 0) and (FEintrag >= 0) and
    (FEintrag <= High(FLayout.Bereiche[FBereich].Felder)) and IstFest then
  begin
    LabelOrt.Font.Color := clWindowText;
    LabelOrt.Caption := 'x ' + IntToStr(FLayout.Bereiche[FBereich].Felder[FEintrag].XMm) +
      ' mm, y ' + IntToStr(FLayout.Bereiche[FBereich].Felder[FEintrag].YMm) + ' mm';
  end
  else if (FBereich >= 0) and (FLayout.Bereiche[FBereich].Anker = 'fluss') then
  begin
    LabelOrt.Font.Color := clWindowText;
    LabelOrt.Caption := 'Beginn bei ' + IntToStr(FLayout.Bereiche[FBereich].YMm) + ' mm';
  end
  else
  begin
    LabelOrt.Font.Color := clWindowText;
    LabelOrt.Caption := '';
  end;
end;

procedure TDrucklayoutFenster.AuswahlSetzen(Bereich, Eintrag: Integer);
begin
  MaskeLesen;
  if (Bereich >= 0) and (Bereich < ListBereich.Items.Count) then
    ListBereich.ItemIndex := Bereich;
  FBereich := ListBereich.ItemIndex;
  FEintrag := Eintrag;
  EintraegeFuellen;
  if Eintrag < ListEintrag.Items.Count then
    ListEintrag.ItemIndex := Eintrag;
  FEintrag := ListEintrag.ItemIndex;
  MaskeFuellen;
  PaintSeite.Invalidate;
end;

procedure TDrucklayoutFenster.FormZeigen(Sender: TObject);
var
  Fehler: string;
begin
  if not VorlageNachId(FVorlageId, FVorlage) then
  begin
    ShowMessage('Die Druckvorlage wurde nicht gefunden.');
    ModalResult := mrCancel;
    Exit;
  end;
  if not LayoutAusJson(FVorlage.LayoutText, FLayout, Fehler) then
  begin
    FLayout := LayoutStandard;
    if Trim(FVorlage.LayoutText) <> '' then
      ShowMessage('Das gespeicherte Layout ist ungültig. Es wird die Standardvorlage gezeigt.' +
        LineEnding + Fehler);
  end;
  FBereich := 0;
  FEintrag := 0;
  BereicheFuellen;
  EintraegeFuellen;
  MaskeFuellen;
end;

procedure TDrucklayoutFenster.BereichGewaehlt(Sender: TObject);
begin
  MaskeLesen;
  FBereich := ListBereich.ItemIndex;
  FEintrag := 0;
  EintraegeFuellen;
  MaskeFuellen;
  PaintSeite.Invalidate;
end;

procedure TDrucklayoutFenster.EintragGewaehlt(Sender: TObject);
begin
  MaskeLesen;
  FEintrag := ListEintrag.ItemIndex;
  MaskeFuellen;
  PaintSeite.Invalidate;
end;

procedure TDrucklayoutFenster.EigenschaftGeaendert(Sender: TObject);
begin
  MaskeLesen;
  OrtZeigen;
  PaintSeite.Invalidate;
end;

procedure TDrucklayoutFenster.SeiteMalen(Sender: TObject);
var
  i, k, X, Y, B, H: Integer;
  Feld: TLayoutFeld;
begin
  PaintSeite.Canvas.Brush.Color := clWhite;
  PaintSeite.Canvas.Pen.Color := clGray;
  PaintSeite.Canvas.Rectangle(SeiteNachX(0), SeiteNachY(0),
    SeiteNachX(SeiteBreite) + 1, SeiteNachY(SeiteHoehe) + 1);
  PaintSeite.Canvas.Font.Name := 'Helvetica';
  PaintSeite.Canvas.Font.Height := -9;
  for i := 0 to High(FLayout.Bereiche) do
  begin
    if FLayout.Bereiche[i].Anker = 'fluss' then
    begin
      if FLayout.Bereiche[i].YMm <= 0 then
        Continue;
      Y := SeiteNachY(FLayout.Bereiche[i].YMm);
      if (i = FBereich) and (FEintrag < 0) then
        PaintSeite.Canvas.Pen.Color := clTeal
      else
        PaintSeite.Canvas.Pen.Color := clSilver;
      PaintSeite.Canvas.MoveTo(SeiteNachX(FLayout.RandLinks), Y);
      PaintSeite.Canvas.LineTo(SeiteNachX(SeiteBreite - FLayout.RandRechts), Y);
      Continue;
    end;
    for k := 0 to High(FLayout.Bereiche[i].Felder) do
    begin
      Feld := FLayout.Bereiche[i].Felder[k];
      if not Feld.Sichtbar then
        Continue;
      X := SeiteNachX(Feld.XMm);
      Y := SeiteNachY(Feld.YMm);
      B := Round(Feld.BreiteMm * Mass);
      H := Round(Feld.HoeheMm * Mass);
      if H < 8 then
        H := 8;
      if (i = FBereich) and (k = FEintrag) then
        PaintSeite.Canvas.Pen.Color := clTeal
      else
        PaintSeite.Canvas.Pen.Color := clMedGray;
      PaintSeite.Canvas.Brush.Style := bsClear;
      PaintSeite.Canvas.Rectangle(X, Y, X + B, Y + H);
      PaintSeite.Canvas.Font.Color := clBlack;
      PaintSeite.Canvas.TextOut(X + 1, Y, Feld.Id);
    end;
  end;
end;

procedure TDrucklayoutFenster.SeiteMaus(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i, k, Mx, My: Integer;
  Feld: TLayoutFeld;
begin
  if Button <> mbLeft then
    Exit;
  Mx := XNachSeite(X);
  My := YNachSeite(Y);
  for i := High(FLayout.Bereiche) downto 0 do
  begin
    if FLayout.Bereiche[i].Anker <> 'fest' then
      Continue;
    for k := High(FLayout.Bereiche[i].Felder) downto 0 do
    begin
      Feld := FLayout.Bereiche[i].Felder[k];
      if not Feld.Sichtbar then
        Continue;
      if (Mx >= Feld.XMm) and (Mx <= Feld.XMm + Feld.BreiteMm) and
         (My >= Feld.YMm) and (My <= Feld.YMm + Max(Feld.HoeheMm, 4)) then
      begin
        AuswahlSetzen(i, k);
        FZiehen := True;
        FZiehBereich := False;
        FGriffX := Mx - Feld.XMm;
        FGriffY := My - Feld.YMm;
        Exit;
      end;
    end;
  end;
  for i := 0 to High(FLayout.Bereiche) do
    if (FLayout.Bereiche[i].Anker = 'fluss') and (FLayout.Bereiche[i].YMm > 0) and
       (Abs(My - FLayout.Bereiche[i].YMm) <= 3) then
    begin
      AuswahlSetzen(i, -1);
      FZiehen := True;
      FZiehBereich := True;
      FGriffY := My - FLayout.Bereiche[i].YMm;
      Exit;
    end;
end;

procedure TDrucklayoutFenster.SeiteZiehen(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  Nx, Ny: Integer;
begin
  if not FZiehen then
    Exit;
  if FZiehBereich then
  begin
    Ny := YNachSeite(Y) - FGriffY;
    if Ny < 0 then
      Ny := 0;
    if Ny > SeiteHoehe - 10 then
      Ny := SeiteHoehe - 10;
    FLayout.Bereiche[FBereich].YMm := Ny;
  end
  else if IstFest and (FEintrag >= 0) and
    (FEintrag <= High(FLayout.Bereiche[FBereich].Felder)) then
  begin
    Nx := XNachSeite(X) - FGriffX;
    Ny := YNachSeite(Y) - FGriffY;
    if Nx < 0 then
      Nx := 0;
    if Ny < 0 then
      Ny := 0;
    if Nx + FLayout.Bereiche[FBereich].Felder[FEintrag].BreiteMm > SeiteBreite then
      Nx := SeiteBreite - FLayout.Bereiche[FBereich].Felder[FEintrag].BreiteMm;
    if Ny + FLayout.Bereiche[FBereich].Felder[FEintrag].HoeheMm > SeiteHoehe then
      Ny := SeiteHoehe - FLayout.Bereiche[FBereich].Felder[FEintrag].HoeheMm;
    FLayout.Bereiche[FBereich].Felder[FEintrag].XMm := Nx;
    FLayout.Bereiche[FBereich].Felder[FEintrag].YMm := Ny;
  end
  else
    Exit;
  OrtZeigen;
  PaintSeite.Invalidate;
end;

procedure TDrucklayoutFenster.SeiteLos(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FZiehen := False;
end;

procedure TDrucklayoutFenster.FeldBewegen(DX, DY: Integer);
var
  Nx, Ny: Integer;
begin
  if FZiehBereich or not IstFest or (FEintrag < 0) or
     (FEintrag > High(FLayout.Bereiche[FBereich].Felder)) then
  begin
    if (FBereich >= 0) and (FLayout.Bereiche[FBereich].Anker = 'fluss') and
       (DX = 0) then
    begin
      Ny := FLayout.Bereiche[FBereich].YMm + DY;
      if Ny < 0 then
        Ny := 0;
      FLayout.Bereiche[FBereich].YMm := Ny;
      OrtZeigen;
      PaintSeite.Invalidate;
    end;
    Exit;
  end;
  Nx := FLayout.Bereiche[FBereich].Felder[FEintrag].XMm + DX;
  Ny := FLayout.Bereiche[FBereich].Felder[FEintrag].YMm + DY;
  if Nx < 0 then
    Nx := 0;
  if Ny < 0 then
    Ny := 0;
  FLayout.Bereiche[FBereich].Felder[FEintrag].XMm := Nx;
  FLayout.Bereiche[FBereich].Felder[FEintrag].YMm := Ny;
  OrtZeigen;
  PaintSeite.Invalidate;
end;

function NutzendeBelegarten(VorlageId: Int64): Integer;
var
  Parameter: TStringList;
begin
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(VorlageId);
    Result := StrToIntDef(PlanlosDB.SkalarMit(
      'SELECT COUNT(*) FROM modulart WHERE druckvorlage_id = :id', Parameter), 0);
  finally
    Parameter.Free;
  end;
end;

function KuerzelDerBelegart(Id: Int64): string;
var
  Parameter: TStringList;
begin
  Result := 'kopie';
  if Id <= 0 then
    Exit;
  Parameter := TStringList.Create;
  try
    Parameter.Values['id'] := IntToStr(Id);
    Result := PlanlosDB.SkalarMit(
      'SELECT kuerzel FROM modulart WHERE id = :id', Parameter);
    if Result = '' then
      Result := 'kopie';
  finally
    Parameter.Free;
  end;
end;

function DateiStamm(const Datei: string): string;
var
  Roh: string;
  i: Integer;
  C: Char;
begin
  Roh := LowerCase(ChangeFileExt(ExtractFileName(Datei), ''));
  Result := '';
  for i := 1 to Length(Roh) do
  begin
    C := Roh[i];
    if ((C >= 'a') and (C <= 'z')) or ((C >= '0') and (C <= '9')) or
       (C = '-') or (C = '_') then
      Result := Result + C;
  end;
  if Result = '' then
    Result := 'import';
end;

procedure TDrucklayoutFenster.SpeichernKlick(Sender: TObject);
var
  Inhalt, Fehler: string;
  Antwort: Integer;
  Neu: Int64;
begin
  MaskeLesen;
  Inhalt := LayoutAlsJson(FLayout);
  if not LayoutPruefen(FLayout, Fehler) then
  begin
    ShowMessage(Fehler);
    Exit;
  end;
  if (FVorlage.Kuerzel = 'standard') or (NutzendeBelegarten(FVorlageId) > 1) then
  begin
    Antwort := MessageDlg(
      'Diese Vorlage nutzen mehrere Belegarten.' + LineEnding +
      'Ja legt eine Kopie nur für diese Belegart an.' + LineEnding +
      'Nein ändert die gemeinsame Vorlage.',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if Antwort = mrCancel then
      Exit;
    if Antwort = mrYes then
    begin
      if not VorlageKopieren(FVorlageId, KuerzelDerBelegart(FBelegartId),
        'Kopie von ' + FVorlage.Bezeichnung, Inhalt, Neu, Fehler) then
      begin
        ShowMessage(Fehler);
        Exit;
      end;
      FGewaehlt := Neu;
      ModalResult := mrOk;
      Exit;
    end;
  end;
  if not VorlageLayoutSchreiben(FVorlageId, Inhalt, Fehler) then
    ShowMessage(Fehler)
  else
  begin
    FGewaehlt := FVorlageId;
    ModalResult := mrOk;
  end;
end;

procedure TDrucklayoutFenster.VorschauKlick(Sender: TObject);
var
  Kopf: TBelegKopf;
  Zeilen: TPosListe;
  Vorlage: TDruckvorlage;
  Datei, Fehler: string;
  Seiten: Integer;
begin
  MaskeLesen;
  if not LayoutPruefen(FLayout, Fehler) then
  begin
    ShowMessage(Fehler);
    Exit;
  end;
  Vorlage := FVorlage;
  Vorlage.LayoutText := LayoutAlsJson(FLayout);
  Vorlage.RandLinksMm := FLayout.RandLinks;
  Vorlage.RandRechtsMm := FLayout.RandRechts;
  Vorlage.RandUntenMm := FLayout.RandUnten;
  Vorlage.AnschriftObenMm := FLayout.AnschriftOben;
  Vorlage.TextObenMm := FLayout.TextOben;
  Kopf := Default(TBelegKopf);
  Kopf.Nummer := 'ANG-1';
  Kopf.Bezeichnung := 'Beispiel';
  Kopf.AdresseText := 'Meier GmbH' + LineEnding + 'Hauptstraße 1' + LineEnding +
    '12345 Musterstadt';
  Kopf.Erfasst := FormatDateTime('yyyy-mm-dd', Date);
  Kopf.Kopftext := 'Guten Tag';
  Kopf.Fusstext := 'Mit freundlichen Grüßen';
  Kopf.IhrZeichen := 'AZ-1';
  Kopf.MwstRechnen := True;
  SetLength(Zeilen, 2);
  Zeilen[0] := Default(TBelegPosition);
  Zeilen[0].Text := 'Beratung';
  Zeilen[0].MengeMilli := 2000;
  Zeilen[0].Einheit := 'Stunde';
  Zeilen[0].EinzelpreisCent := 9000;
  Zeilen[0].MwstSatz := 19;
  Zeilen[1] := Default(TBelegPosition);
  Zeilen[1].Text := 'Anfahrt';
  Zeilen[1].MengeMilli := 1000;
  Zeilen[1].Einheit := 'Stück';
  Zeilen[1].EinzelpreisCent := 2500;
  Zeilen[1].MwstSatz := 19;
  Datei := GetTempDir + 'planlos-layout-vorschau.pdf';
  if not BelegPdfSchreiben(Kopf, Zeilen, Vorlage, 'Angebot', 'Admin', Datei,
    Seiten, Fehler) then
    ShowMessage(Fehler)
  else if not OpenDocument(Datei) then
    ShowMessage('Die Vorschau liegt unter ' + Datei);
end;

procedure TDrucklayoutFenster.ExportKlick(Sender: TObject);
var
  Dialog: TSaveDialog;
  Fehler: string;
begin
  MaskeLesen;
  Dialog := TSaveDialog.Create(Self);
  try
    Dialog.Title := 'Layout exportieren';
    Dialog.Filter := 'JSON (*.json)|*.json';
    Dialog.FileName := FVorlage.Kuerzel + '.json';
    Dialog.Options := Dialog.Options + [ofOverwritePrompt];
    if not Dialog.Execute then
      Exit;
    if not LayoutSpeichern(Dialog.FileName, FLayout, Fehler) then
      ShowMessage(Fehler);
  finally
    Dialog.Free;
  end;
end;

procedure TDrucklayoutFenster.ImportKlick(Sender: TObject);
var
  Dialog: TOpenDialog;
  Geladen: TDruckLayout;
  Fehler: string;
  Neu: Int64;
  DateiText: TStringList;
begin
  Dialog := TOpenDialog.Create(Self);
  try
    Dialog.Title := 'Layout einlesen';
    Dialog.Filter := 'JSON (*.json)|*.json|Alle Dateien|*.*';
    if not Dialog.Execute then
      Exit;
    if not LayoutLaden(Dialog.FileName, Geladen, Fehler) then
    begin
      ShowMessage(Fehler);
      Exit;
    end;
    DateiText := TStringList.Create;
    try
      DateiText.LoadFromFile(Dialog.FileName);
      if not VorlageAnlegen(DateiStamm(Dialog.FileName),
        'Import ' + ChangeFileExt(ExtractFileName(Dialog.FileName), ''),
        DateiText.Text, Neu, Fehler) then
      begin
        ShowMessage(Fehler);
        Exit;
      end;
    finally
      DateiText.Free;
    end;
    FVorlageId := Neu;
    FGewaehlt := Neu;
    VorlageNachId(Neu, FVorlage);
    FLayout := Geladen;
    FBereich := 0;
    FEintrag := 0;
    BereicheFuellen;
    EintraegeFuellen;
    MaskeFuellen;
    PaintSeite.Invalidate;
    ShowMessage('Die Vorlage ist angelegt. Speichern Sie die Belegart mit F10, ' +
      'damit sie diese Vorlage nutzt.');
  finally
    Dialog.Free;
  end;
end;

procedure TDrucklayoutFenster.AbbrechenKlick(Sender: TObject);
begin
  if FGewaehlt > 0 then
    ModalResult := mrOk
  else
    ModalResult := mrCancel;
end;

procedure TDrucklayoutFenster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  InFeld: Boolean;
begin
  InFeld := (ActiveControl = EditBeschriftung) or (ActiveControl = EditBreite);
  if Key = VK_ESCAPE then
  begin
    AbbrechenKlick(nil);
    Key := 0;
  end
  else if Key = VK_F10 then
  begin
    SpeichernKlick(nil);
    Key := 0;
  end
  else if Key = VK_F12 then
    Key := 0
  else if not InFeld and (Key = VK_LEFT) then
  begin
    FeldBewegen(-1, 0);
    Key := 0;
  end
  else if not InFeld and (Key = VK_RIGHT) then
  begin
    FeldBewegen(1, 0);
    Key := 0;
  end
  else if not InFeld and (Key = VK_UP) then
  begin
    FeldBewegen(0, -1);
    Key := 0;
  end
  else if not InFeld and (Key = VK_DOWN) then
  begin
    FeldBewegen(0, 1);
    Key := 0;
  end;
end;

end.
