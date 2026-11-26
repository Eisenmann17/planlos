unit uprojektfenster;

{ Projektmaske nach UnitMaskeProjekt, ohne die alte Tastenleiste.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Graphics,
  LCLType, uprojekt;

type
  TProjektFenster = class(TForm)
    LabelNrTitel: TLabel;
    LabelNr: TLabel;
    LabelBezeichnung: TLabel;
    EditBezeichnung: TEdit;
    LabelKunde: TLabel;
    EditKunde: TEdit;
    LabelGruppe: TLabel;
    EditGruppe: TEdit;
    LabelBearbeiter: TLabel;
    EditBearbeiter: TEdit;
    LabelNotiz: TLabel;
    MemoNotiz: TMemo;
    LabelErfasst: TLabel;
    EditErfasst: TEdit;
    LabelGeaendert: TLabel;
    EditGeaendert: TEdit;
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
    FKundeId: Int64;
    FBearbeiterId: Int64;
    procedure Suchen(Sender: TObject);
  end;

function ProjektBearbeiten(Id: Int64): Int64;

implementation

{$R *.lfm}

uses
  usuche, uartikel;

function ProjektBearbeiten(Id: Int64): Int64;
var
  Fenster: TProjektFenster;
begin
  Result := 0;
  Fenster := TProjektFenster.Create(Application);
  try
    Fenster.FId := Id;
    if Fenster.ShowModal = mrOk then
      Result := Fenster.FId;
  finally
    Fenster.Free;
  end;
end;

procedure TProjektFenster.FormZeigen(Sender: TObject);
var
  Projekt: TProjekt;
begin
  if FId = 0 then
  begin
    Caption := 'Projekte neu';
    EditErfasst.Text := Heute;
    EditGeaendert.Text := Heute;
    Exit;
  end;
  if not ProjektLaden(FId, Projekt) then
  begin
    ShowMessage('Das Projekt wurde nicht gefunden.');
    ModalResult := mrCancel;
    Exit;
  end;
  LabelNr.Caption := IntToStr(Projekt.Id);
  EditBezeichnung.Text := Projekt.Bezeichnung;
  FKundeId := Projekt.KundeId;
  EditKunde.Text := Projekt.Kunde;
  EditGruppe.Text := Projekt.Gruppierung;
  FBearbeiterId := Projekt.BearbeiterId;
  EditBearbeiter.Text := Projekt.Bearbeiter;
  MemoNotiz.Text := Projekt.Notiz;
  EditErfasst.Text := Projekt.Erfasst;
  EditGeaendert.Text := Heute;
end;

procedure TProjektFenster.FeldBetreten(Sender: TObject);
begin
  ButtonSuchen.Enabled := True;
end;

procedure TProjektFenster.Suchen(Sender: TObject);
var
  Id: Int64;
  Ziel: TWinControl;
begin
  Ziel := ActiveControl;
  if Sender = LabelKunde then
    Ziel := EditKunde
  else if Sender = LabelGruppe then
    Ziel := EditGruppe
  else if Sender = LabelBearbeiter then
    Ziel := EditBearbeiter
  else if Sender = LabelErfasst then
    Ziel := EditErfasst
  else if Sender = LabelGeaendert then
    Ziel := EditGeaendert;
  if (Ziel <> nil) and (Sender is TLabel) then
    Ziel.SetFocus;
  if Ziel = EditKunde then
  begin
    if ListenWahl('kunde', False, Id) then
    begin
      FKundeId := Id;
      EditKunde.Text := StammBezeichnung('lieferant', Id);
    end;
  end
  else if Ziel = EditGruppe then
  begin
    if ListenWahl('gruppierung', True, Id) then
      EditGruppe.Text := StammBezeichnung('gruppierung', Id);
  end
  else if Ziel = EditBearbeiter then
  begin
    if ListenWahl('mitarbeiter', False, Id) then
    begin
      FBearbeiterId := Id;
      EditBearbeiter.Text := StammBezeichnung('lieferant', Id);
    end;
  end
  else if Ziel = EditErfasst then
    EditErfasst.Text := Heute
  else if Ziel = EditGeaendert then
    EditGeaendert.Text := Heute;
end;

procedure TProjektFenster.SucheKlick(Sender: TObject);
begin
  Suchen(Sender);
end;

procedure TProjektFenster.AbbrechenKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TProjektFenster.SpeichernKlick(Sender: TObject);
var
  Projekt: TProjekt;
  Fehler: string;
begin
  Projekt := Default(TProjekt);
  Projekt.Id := FId;
  Projekt.Bezeichnung := Trim(EditBezeichnung.Text);
  Projekt.KundeId := FKundeId;
  if Trim(EditKunde.Text) = '' then
    Projekt.KundeId := 0;
  Projekt.Gruppierung := Trim(EditGruppe.Text);
  Projekt.BearbeiterId := FBearbeiterId;
  if Trim(EditBearbeiter.Text) = '' then
    Projekt.BearbeiterId := 0;
  Projekt.Notiz := MemoNotiz.Text;
  Projekt.Erfasst := Trim(EditErfasst.Text);
  Projekt.Geaendert := Trim(EditGeaendert.Text);
  FId := ProjektSpeichern(Projekt, Fehler);
  if FId = 0 then
    ShowMessage(Fehler)
  else
    ModalResult := mrOk;
end;

procedure TProjektFenster.FormKeyDown(Sender: TObject; var Key: Word;
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
    if not MemoNotiz.Focused then
    begin
      SpeichernKlick(nil);
      Key := 0;
    end;
  end
  else if Key = VK_F12 then
    Key := 0;
end;

end.
