unit uanmeldung;

{ Anmeldefenster. Das Aussehen steht in uanmeldung.lfm,
  nach der alten Eingang.dfm.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Graphics,
  LCLType, utastenleiste;

type
  TAnmeldeFenster = class(TForm)
    LabelAnwender: TLabel;
    LabelPasswort: TLabel;
    EditAnwender: TEdit;
    EditPasswort: TEdit;
    ButtonAbbrechen: TButton;
    ButtonOk: TButton;
    PanelTasten: TPanel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AbbruchKlick(Sender: TObject);
    procedure OkKlick(Sender: TObject);
    procedure FormZeigen(Sender: TObject);
  private
    FTasten: TTastenleiste;
    procedure TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
    procedure Pruefen;
  public
    constructor Create(TheOwner: TComponent); override;
  end;

function AnmeldungZeigen: Boolean;

implementation

{$R *.lfm}

uses
  ubenutzer;

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
begin
  inherited Create(TheOwner);
  FTasten := TTastenleiste.Create(Self);
  FTasten.Parent := PanelTasten;
  FTasten.Align := alBottom;
  FTasten.Height := 96;
  FTasten.OnTaste := @TasteGedrueckt;
  FTasten.AlleBeschriftungenLoeschen;
  FTasten.SetzeTaste(1, 10, 'Ok', True);
  FTasten.SetzeTaste(1, 12, 'Zurück', True);
end;

procedure TAnmeldeFenster.FormZeigen(Sender: TObject);
begin
  if EditPasswort <> nil then
    EditPasswort.SetFocus;
end;

procedure TAnmeldeFenster.Pruefen;
var
  Meldung: string;
begin
  if Anmelden(Trim(EditAnwender.Text), EditPasswort.Text, Meldung) then
    ModalResult := mrOk
  else
  begin
    ShowMessage(Meldung);
    EditPasswort.SetFocus;
    EditPasswort.SelectAll;
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
  else if (Key = VK_RETURN) or (Key = VK_F10) then
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
