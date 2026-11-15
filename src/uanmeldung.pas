unit uanmeldung;

{ Anmeldefenster nach Eingang.dfm.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE.

  Anwender und Passwort liegen an denselben Stellen wie früher.
  Unten liegt die Tastenleiste: F10 meldet an, Esc bricht ab. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Graphics,
  LCLType, utastenleiste;

function AnmeldungZeigen: Boolean;

implementation

uses
  ubenutzer;

type
  TAnmeldeFenster = class(TForm)
  private
    FName: TEdit;
    FPasswort: TEdit;
    FTasten: TTastenleiste;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OkKlick(Sender: TObject);
    procedure AbbruchKlick(Sender: TObject);
    procedure TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
    procedure Pruefen;
  public
    constructor Create(TheOwner: TComponent); override;
  end;

function AnmeldungZeigen: Boolean;
var
  Fenster: TAnmeldeFenster;
begin
  Fenster := TAnmeldeFenster.Create(Application);
  try
    Result := Fenster.ShowModal = mrOk;
  finally
    Fenster.Free;
  end;
end;

constructor TAnmeldeFenster.Create(TheOwner: TComponent);
var
  Beschriftung: TLabel;
  Knopf: TButton;

  procedure Fett(Ziel: TLabel);
  begin
    Ziel.Font.Name := 'Arial';
    Ziel.Font.Height := -16;
    Ziel.Font.Color := clBlack;
    Ziel.Font.Style := [fsBold];
  end;

begin
  inherited CreateNew(TheOwner, 1);
  Caption := 'Planlos';
  Position := poScreenCenter;
  BorderStyle := bsDialog;
  Width := 640;
  Height := 320;
  Color := clBtnFace;
  KeyPreview := True;
  OnKeyDown := @FormKeyDown;

  FTasten := TTastenleiste.Create(Self);
  FTasten.Parent := Self;
  FTasten.Align := alBottom;
  FTasten.Height := 96;
  FTasten.OnTaste := @TasteGedrueckt;
  FTasten.AlleBeschriftungenLoeschen;
  FTasten.SetzeTaste(1, 10, 'Ok', True);
  FTasten.SetzeTaste(1, 12, 'Zurück', True);

  Beschriftung := TLabel.Create(Self);
  Beschriftung.Parent := Self;
  Beschriftung.Left := 19;
  Beschriftung.Top := 24;
  Beschriftung.Caption := 'Anwender:';
  Fett(Beschriftung);

  Beschriftung := TLabel.Create(Self);
  Beschriftung.Parent := Self;
  Beschriftung.Left := 24;
  Beschriftung.Top := 64;
  Beschriftung.Caption := 'Passwort:';
  Fett(Beschriftung);

  FName := TEdit.Create(Self);
  FName.Parent := Self;
  FName.Left := 120;
  FName.Top := 16;
  FName.Width := 185;
  FName.Height := 28;
  FName.Font.Height := -16;
  FName.Text := 'Admin';
  FName.TabOrder := 0;

  FPasswort := TEdit.Create(Self);
  FPasswort.Parent := Self;
  FPasswort.Left := 120;
  FPasswort.Top := 56;
  FPasswort.Width := 185;
  FPasswort.Height := 28;
  FPasswort.Font.Height := -16;
  FPasswort.PasswordChar := '*';
  FPasswort.TabOrder := 1;

  Knopf := TButton.Create(Self);
  Knopf.Parent := Self;
  Knopf.Left := 24;
  Knopf.Top := 112;
  Knopf.Width := 110;
  Knopf.Height := 26;
  Knopf.Caption := 'Abbrechen';
  Knopf.OnClick := @AbbruchKlick;

  Knopf := TButton.Create(Self);
  Knopf.Parent := Self;
  Knopf.Left := 232;
  Knopf.Top := 115;
  Knopf.Width := 75;
  Knopf.Height := 22;
  Knopf.Caption := 'Ok';
  Knopf.Default := True;
  Knopf.OnClick := @OkKlick;

  ActiveControl := FPasswort;
end;

procedure TAnmeldeFenster.Pruefen;
var
  Meldung: string;
begin
  if Anmelden(Trim(FName.Text), FPasswort.Text, Meldung) then
    ModalResult := mrOk
  else
  begin
    ShowMessage(Meldung);
    FPasswort.SetFocus;
    FPasswort.SelectAll;
  end;
end;

procedure TAnmeldeFenster.OkKlick(Sender: TObject);
begin
  Pruefen;
end;

procedure TAnmeldeFenster.AbbruchKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TAnmeldeFenster.TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
begin
  if Ebene <> 1 then
    Exit;
  if Taste = 10 then
    Pruefen
  else if Taste = 12 then
    ModalResult := mrCancel;
end;

procedure TAnmeldeFenster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end
  else if Key = VK_RETURN then
  begin
    Pruefen;
    Key := 0;
  end
  else if Key = VK_F10 then
  begin
    Pruefen;
    Key := 0;
  end
  else if (Key >= VK_F1) and (Key <= VK_F12) then
  begin
    AlleLeistenNachziehen;
    TasteGedrueckt(Self, AktuelleEbene, Key - VK_F1 + 1);
    Key := 0;
  end;
end;

end.
