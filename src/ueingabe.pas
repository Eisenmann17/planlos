unit ueingabe;

{ Das eine Eingabefenster. Welche Felder es zeigt, steht in der Maske.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, LCLType,
  utastenleiste, umaske;

type
  TEingabefenster = class(TForm)
  private
    FScroll: TScrollBox;
    FTasten: TTastenleiste;
    FKuerzel: string;
    FBezeichnung: string;
    FId: Int64;
    FGespeichert: Int64;
    FTastenInfo: TTastenListe;
    FSpalten: array of string;
    FPflicht: array of Boolean;
    FEingaben: array of TControl;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
    procedure TastenAusDaten;
    procedure AktionAusfuehren(const Aktionsname: string);
    function TextVon(Feld: TControl): string;
    procedure TextNach(Feld: TControl; const Wert: string);
    function WerteSammeln: TStringList;
  public
    constructor Create(TheOwner: TComponent); override;
    procedure Vorbereiten(const Kuerzel: string; Id: Int64);
    function HatFeld(const Spalte: string): Boolean;
    procedure SetzeWert(const Spalte, Wert: string);
    function SpeichernStill(out Fehler: string): Int64;
    property GespeicherteId: Int64 read FGespeichert;
  end;

function AdresseEingeben(const Kuerzel: string; Id: Int64): Int64;

implementation

function AdresseEingeben(const Kuerzel: string; Id: Int64): Int64;
var
  Fenster: TEingabefenster;
begin
  Fenster := TEingabefenster.Create(Application);
  try
    Fenster.Vorbereiten(Kuerzel, Id);
    if Fenster.ShowModal = mrOk then
      Result := Fenster.GespeicherteId
    else
      Result := 0;
  finally
    Fenster.Free;
  end;
end;

constructor TEingabefenster.Create(TheOwner: TComponent);
begin
  inherited CreateNew(TheOwner, 1);
  Position := poDesigned;
  KeyPreview := True;
  OnKeyDown := @FormKeyDown;

  FTasten := TTastenleiste.Create(Self);
  FTasten.Parent := Self;
  FTasten.Align := alBottom;
  FTasten.Height := 96;
  FTasten.OnTaste := @TasteGedrueckt;

  FScroll := TScrollBox.Create(Self);
  FScroll.Parent := Self;
  FScroll.Align := alClient;
  FScroll.BorderStyle := bsNone;
end;

function TEingabefenster.TextVon(Feld: TControl): string;
begin
  if Feld is TMemo then
    Result := TMemo(Feld).Text
  else if Feld is TEdit then
    Result := TEdit(Feld).Text
  else
    Result := '';
end;

procedure TEingabefenster.TextNach(Feld: TControl; const Wert: string);
begin
  if Feld is TMemo then
    TMemo(Feld).Text := Wert
  else if Feld is TEdit then
    TEdit(Feld).Text := Wert;
end;

procedure TEingabefenster.Vorbereiten(const Kuerzel: string; Id: Int64);
var
  Info: TMaskenInfo;
  Felder: TFeldListe;
  Alt: TStringList;
  i, Sichtbar, Y, Breite: Integer;
  Beschriftung: TLabel;
  Eingabe: TControl;
begin
  FKuerzel := Kuerzel;
  FId := Id;
  FGespeichert := 0;
  if not MaskeLaden(Kuerzel, Info) then
  begin
    Caption := 'Planlos';
    Exit;
  end;
  FBezeichnung := Info.Bezeichnung;
  if Id = 0 then
    Caption := 'Planlos - ' + Info.Bezeichnung + ' neu'
  else
    Caption := 'Planlos - ' + Info.Bezeichnung + ' ändern';
  Position := poDesigned;
  if Info.Links > 0 then
    Left := Info.Links + 24;
  if Info.Oben > 0 then
    Top := Info.Oben + 24;
  Width := Info.Breite;
  Height := Info.Hoehe;
  if Width < 420 then
    Width := 420;
  if Height < 320 then
    Height := 320;

  while FScroll.ControlCount > 0 do
    FScroll.Controls[0].Free;
  SetLength(FSpalten, 0);
  SetLength(FPflicht, 0);
  SetLength(FEingaben, 0);

  Felder := FelderLaden(Kuerzel);
  Sichtbar := 0;
  for i := 0 to High(Felder) do
    if Felder[i].Sichtbar then
      Inc(Sichtbar);
  SetLength(FSpalten, Sichtbar);
  SetLength(FPflicht, Sichtbar);
  SetLength(FEingaben, Sichtbar);

  Y := 12;
  Sichtbar := 0;
  Breite := Width - 48;
  if Breite < 200 then
    Breite := 200;
  for i := 0 to High(Felder) do
  begin
    if not Felder[i].Sichtbar then
      Continue;
    Beschriftung := TLabel.Create(Self);
    Beschriftung.Parent := FScroll;
    Beschriftung.Left := 12;
    Beschriftung.Top := Y;
    Beschriftung.Caption := Felder[i].Beschriftung;
    if Felder[i].Pflicht then
      Beschriftung.Caption := Beschriftung.Caption + ' *';
    Y := Y + 18;
    if Felder[i].Spalte = 'notiz' then
    begin
      Eingabe := TMemo.Create(Self);
      Eingabe.Parent := FScroll;
      TMemo(Eingabe).Left := 12;
      TMemo(Eingabe).Top := Y;
      TMemo(Eingabe).Width := Breite;
      TMemo(Eingabe).Height := 72;
      Y := Y + 80;
    end
    else
    begin
      Eingabe := TEdit.Create(Self);
      Eingabe.Parent := FScroll;
      TEdit(Eingabe).Left := 12;
      TEdit(Eingabe).Top := Y;
      TEdit(Eingabe).Width := Breite;
      Y := Y + 30;
    end;
    FSpalten[Sichtbar] := Felder[i].Spalte;
    FPflicht[Sichtbar] := Felder[i].Pflicht;
    FEingaben[Sichtbar] := Eingabe;
    Inc(Sichtbar);
  end;

  if Id > 0 then
  begin
    Alt := TStringList.Create;
    try
      AdresseLesen(Id, Alt);
      for i := 0 to High(FSpalten) do
        SetzeWert(FSpalten[i], Alt.Values[FSpalten[i]]);
    finally
      Alt.Free;
    end;
  end;
  TastenAusDaten;
end;

procedure TEingabefenster.TastenAusDaten;
var
  i: Integer;
begin
  FTastenInfo := TastenLaden(FKuerzel, 'eingabe');
  FTasten.AlleBeschriftungenLoeschen;
  for i := 0 to High(FTastenInfo) do
    FTasten.SetzeTaste(FTastenInfo[i].Ebene, FTastenInfo[i].Taste,
      FTastenInfo[i].Beschriftung, FTastenInfo[i].Erlaubt);
end;

function TEingabefenster.HatFeld(const Spalte: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to High(FSpalten) do
    if FSpalten[i] = Spalte then
      Exit(True);
end;

procedure TEingabefenster.SetzeWert(const Spalte, Wert: string);
var
  i: Integer;
begin
  for i := 0 to High(FSpalten) do
    if FSpalten[i] = Spalte then
    begin
      TextNach(FEingaben[i], Wert);
      Exit;
    end;
end;

function TEingabefenster.WerteSammeln: TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 0 to High(FSpalten) do
    Result.Values[FSpalten[i]] := TextVon(FEingaben[i]);
end;

function TEingabefenster.SpeichernStill(out Fehler: string): Int64;
var
  Werte: TStringList;
begin
  Werte := WerteSammeln;
  try
    Result := AdresseSpeichern(FKuerzel, FId, Werte, Fehler);
    if Result > 0 then
    begin
      FGespeichert := Result;
      FId := Result;
    end;
  finally
    Werte.Free;
  end;
end;

procedure TEingabefenster.AktionAusfuehren(const Aktionsname: string);
var
  Fehler: string;
  Neu: Int64;
begin
  if Aktionsname = 'hilfe' then
    ShowMessage(
      'Maske ' + FBezeichnung + '.' + LineEnding +
      'Die sichtbaren Felder und die Tasten stehen in der Datenbank.' + LineEnding +
      'Felder mit einem Stern sind Pflicht.' + LineEnding +
      'F10 speichert, F12 bricht ab.')
  else if Aktionsname = 'speichern' then
  begin
    Neu := SpeichernStill(Fehler);
    if Neu = 0 then
      ShowMessage(Fehler)
    else
      ModalResult := mrOk;
  end
  else if Aktionsname = 'abbrechen' then
    ModalResult := mrCancel;
end;

procedure TEingabefenster.TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
var
  Aktionsname: string;
  Erlaubt: Boolean;
begin
  if not TasteFinden(FTastenInfo, Ebene, Taste, Aktionsname, Erlaubt) then
    Exit;
  if Erlaubt then
    AktionAusfuehren(Aktionsname);
end;

procedure TEingabefenster.FormKeyDown(Sender: TObject; var Key: Word;
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
