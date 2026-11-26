unit unachschlagefenster;

{ Eine Eingabe für Einheit, Kategorie, Gruppierung und Stücklistengruppe.
  Esc bricht ab, Return und F10 speichern, wie die alte kleine Maske.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Graphics,
  LCLType;

type
  TNachschlageFenster = class(TForm)
    LabelNr: TLabel;
    LabelName: TLabel;
    EditName: TEdit;
    PanelKnopf: TPanel;
    LabelEsc: TLabel;
    ButtonAbbrechen: TButton;
    LabelF10: TLabel;
    ButtonSpeichern: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormZeigen(Sender: TObject);
    procedure AbbrechenKlick(Sender: TObject);
    procedure SpeichernKlick(Sender: TObject);
  private
    FArt: string;
    FId: Int64;
  end;

function NachschlageBearbeiten(const Art: string; Id: Int64): Int64;

implementation

{$R *.lfm}

uses
  unachschlage;

function NachschlageBearbeiten(const Art: string; Id: Int64): Int64;
var
  Fenster: TNachschlageFenster;
begin
  Result := 0;
  Fenster := TNachschlageFenster.Create(Application);
  try
    Fenster.FArt := Art;
    Fenster.FId := Id;
    if Fenster.ShowModal = mrOk then
      Result := Fenster.FId;
  finally
    Fenster.Free;
  end;
end;

procedure TNachschlageFenster.FormZeigen(Sender: TObject);
var
  Wert: string;
begin
  Caption := NachschlageBeschriftung(FArt);
  if (Length(Caption) > 1) and (Caption[Length(Caption)] = ':') then
    Caption := Copy(Caption, 1, Length(Caption) - 1);
  LabelName.Caption := NachschlageBeschriftung(FArt);
  if FId = 0 then
  begin
    Caption := Caption + ' neu';
    LabelNr.Caption := '';
    Exit;
  end;
  Wert := NachschlageName(FId);
  EditName.Text := Wert;
  LabelNr.Caption := 'Nr ' + IntToStr(FId);
end;

procedure TNachschlageFenster.AbbrechenKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TNachschlageFenster.SpeichernKlick(Sender: TObject);
var
  Fehler: string;
  Neu: Int64;
begin
  Neu := NachschlageSpeichern(FArt, FId, EditName.Text, Fehler);
  if Neu = 0 then
    ShowMessage(Fehler)
  else
  begin
    FId := Neu;
    ModalResult := mrOk;
  end;
end;

procedure TNachschlageFenster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end
  else if (Key = VK_RETURN) or (Key = VK_F10) then
  begin
    SpeichernKlick(nil);
    Key := 0;
  end
  else if Key = VK_F12 then
    Key := 0;
end;

end.
