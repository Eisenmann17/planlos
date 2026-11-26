unit utextbausteinfenster;

{ Textbaustein nach der alten Maske. Esc bricht ab, Return und F10 speichern.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Graphics,
  LCLType, utextbaustein;

type
  TTextbausteinFenster = class(TForm)
    LabelNr: TLabel;
    EditNr: TEdit;
    LabelModulart: TLabel;
    EditModulart: TEdit;
    LabelBenutzer: TLabel;
    EditBenutzer: TEdit;
    LabelTextart: TLabel;
    ComboTextart: TComboBox;
    LabelText: TLabel;
    MemoText: TMemo;
    LabelBeschreibung: TLabel;
    EditBeschreibung: TEdit;
    PanelKnopf: TPanel;
    LabelEsc: TLabel;
    ButtonAbbrechen: TButton;
    LabelF4: TLabel;
    ButtonSuchen: TButton;
    LabelF10: TLabel;
    ButtonSpeichern: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormZeigen(Sender: TObject);
    procedure AbbrechenKlick(Sender: TObject);
    procedure SpeichernKlick(Sender: TObject);
    procedure SucheKlick(Sender: TObject);
    procedure FeldBetreten(Sender: TObject);
  private
    FId: Int64;
    FFestArt: string;
    procedure Suchen(Sender: TObject);
  end;

function TextbausteinBearbeiten(Id: Int64): Int64;
function TextbausteinWaehlen(const Textart: string; out Id: Int64): Boolean;

implementation

{$R *.lfm}

uses
  usuche, ubenutzer;

function TextbausteinBearbeiten(Id: Int64): Int64;
var
  Fenster: TTextbausteinFenster;
begin
  Result := 0;
  Fenster := TTextbausteinFenster.Create(Application);
  try
    Fenster.FId := Id;
    if Fenster.ShowModal = mrOk then
      Result := Fenster.FId;
  finally
    Fenster.Free;
  end;
end;

function TextbausteinWaehlen(const Textart: string; out Id: Int64): Boolean;
begin
  Result := ListenWahlMit('textbaustein', Textart, False, Id);
end;

procedure TTextbausteinFenster.FormZeigen(Sender: TObject);
var
  Baustein: TTextbaustein;
begin
  if FId = 0 then
  begin
    Caption := 'Textbaustein neu';
    EditModulart.Text := 'Standard';
    if Sitzung.Aktiv then
      EditBenutzer.Text := Sitzung.Name;
    if FFestArt <> '' then
    begin
      ComboTextart.ItemIndex := ComboTextart.Items.IndexOf(FFestArt);
      ComboTextart.Enabled := False;
    end
    else
      ComboTextart.ItemIndex := 0;
    Exit;
  end;
  if not TextbausteinLaden(FId, Baustein) then
  begin
    ShowMessage('Der Textbaustein wurde nicht gefunden.');
    ModalResult := mrCancel;
    Exit;
  end;
  EditNr.Text := IntToStr(Baustein.Id);
  EditModulart.Text := Baustein.Modulart;
  EditBenutzer.Text := Baustein.Benutzer;
  ComboTextart.ItemIndex := ComboTextart.Items.IndexOf(Baustein.Textart);
  EditBeschreibung.Text := Baustein.Beschreibung;
  MemoText.Text := Baustein.Text;
end;

procedure TTextbausteinFenster.FeldBetreten(Sender: TObject);
begin
  ButtonSuchen.Enabled := True;
end;

procedure TTextbausteinFenster.Suchen(Sender: TObject);
var
  Id: Int64;
  Ziel: TWinControl;
begin
  Ziel := ActiveControl;
  if Sender = LabelModulart then
    Ziel := EditModulart
  else if Sender = LabelBenutzer then
    Ziel := EditBenutzer;
  if (Ziel <> nil) and (Sender is TLabel) then
    Ziel.SetFocus;
  if Ziel = EditModulart then
  begin
    if ListenWahl('modulart', False, Id) then
      EditModulart.Text := ListenName('modulart', Id);
  end
  else if Ziel = EditBenutzer then
  begin
    if ListenWahl('benutzer', False, Id) then
      EditBenutzer.Text := ListenName('benutzer', Id);
  end;
end;

procedure TTextbausteinFenster.SucheKlick(Sender: TObject);
begin
  Suchen(Sender);
end;

procedure TTextbausteinFenster.AbbrechenKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TTextbausteinFenster.SpeichernKlick(Sender: TObject);
var
  Baustein: TTextbaustein;
  Fehler: string;
begin
  Baustein := Default(TTextbaustein);
  Baustein.Id := FId;
  Baustein.Modulart := Trim(EditModulart.Text);
  Baustein.Benutzer := Trim(EditBenutzer.Text);
  if ComboTextart.ItemIndex >= 0 then
    Baustein.Textart := ComboTextart.Items[ComboTextart.ItemIndex];
  Baustein.Beschreibung := Trim(EditBeschreibung.Text);
  Baustein.Text := MemoText.Text;
  FId := TextbausteinSpeichern(Baustein, Fehler);
  if FId = 0 then
    ShowMessage(Fehler)
  else
    ModalResult := mrOk;
end;

procedure TTextbausteinFenster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end
  else if Key = VK_F4 then
  begin
    Suchen(nil);
    Key := 0;
  end
  else if Key = VK_F10 then
  begin
    SpeichernKlick(nil);
    Key := 0;
  end
  else if Key = VK_RETURN then
  begin
    if not MemoText.Focused then
    begin
      SpeichernKlick(nil);
      Key := 0;
    end;
  end
  else if Key = VK_F12 then
    Key := 0;
end;

end.
