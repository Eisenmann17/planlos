unit ufenstereinstellung;

{ Fenstereinstellungen. Die Admin-Ansicht zeigt zusätzlich die SQL-Abfrage.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, CheckLst,
  Graphics, LCLType, ufensterdaten;

type
  TFensterEinstellung = class(TForm)
    LabelKontext: TLabel;
    LabelSpalten: TLabel;
    ListSpalten: TCheckListBox;
    LabelSortierung: TLabel;
    EditSortierung: TEdit;
    LabelFilter: TLabel;
    EditFilter: TEdit;
    LabelSql: TLabel;
    MemoSql: TMemo;
    PanelKnopf: TPanel;
    LabelEsc: TLabel;
    ButtonAbbrechen: TButton;
    LabelF10: TLabel;
    ButtonSpeichern: TButton;
    procedure FormZeigen(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AbbrechenKlick(Sender: TObject);
    procedure SpeichernKlick(Sender: TObject);
  private
    FSatz: TFensterSatz;
    FAdmin: Boolean;
    FSpaltenNamen: TStringList;
  public
    procedure Vorbereiten(const Satz: TFensterSatz; Admin: Boolean;
      const SpaltenNamen: TStrings);
  end;

function FensterEinstellungZeigen(var Satz: TFensterSatz; Admin: Boolean;
  const SpaltenNamen: TStrings): Boolean;

implementation

{$R *.lfm}

function FensterEinstellungZeigen(var Satz: TFensterSatz; Admin: Boolean;
  const SpaltenNamen: TStrings): Boolean;
var
  Fenster: TFensterEinstellung;
begin
  Fenster := TFensterEinstellung.Create(Application);
  try
    Fenster.Vorbereiten(Satz, Admin, SpaltenNamen);
    Result := Fenster.ShowModal = mrOk;
    if Result then
      Satz := Fenster.FSatz;
  finally
    Fenster.Free;
  end;
end;

procedure TFensterEinstellung.Vorbereiten(const Satz: TFensterSatz; Admin: Boolean;
  const SpaltenNamen: TStrings);
var
  i: Integer;
  Sichtbar: string;
begin
  FSatz := Satz;
  FAdmin := Admin;
  FSpaltenNamen := TStringList.Create;
  if SpaltenNamen <> nil then
    FSpaltenNamen.Assign(SpaltenNamen);
  if Admin then
    Caption := 'Fenstereinstellungen (Verwaltung)'
  else
    Caption := 'Fenstereinstellungen';
  LabelSql.Visible := Admin;
  MemoSql.Visible := Admin;
  if Admin then
  begin
    Height := 460;
    MemoSql.Text := Satz.SqlText;
  end
  else
    Height := 340;
  if Satz.Kontext = '' then
    LabelKontext.Caption := 'Fenster ' + Satz.Fenster + ', allgemeine Vorgabe.'
  else
    LabelKontext.Caption := 'Fenster ' + Satz.Fenster + ', Kontext ' + Satz.Kontext + '.';
  Sichtbar := ',' + Satz.Spalten + ',';
  ListSpalten.Items.BeginUpdate;
  try
    ListSpalten.Items.Clear;
    for i := 0 to FSpaltenNamen.Count - 1 do
    begin
      ListSpalten.Items.Add(FSpaltenNamen[i]);
      if (Satz.Spalten = '') or (Pos(',' + FSpaltenNamen[i] + ',', Sichtbar) > 0) then
        ListSpalten.Checked[i] := True;
    end;
  finally
    ListSpalten.Items.EndUpdate;
  end;
  EditSortierung.Text := Satz.Sortierung;
  EditFilter.Text := Satz.Filter;
end;

procedure TFensterEinstellung.FormZeigen(Sender: TObject);
begin
end;

procedure TFensterEinstellung.SpeichernKlick(Sender: TObject);
var
  i: Integer;
  Liste, Fehler: string;
begin
  Liste := '';
  for i := 0 to ListSpalten.Items.Count - 1 do
    if ListSpalten.Checked[i] then
    begin
      if Liste <> '' then
        Liste := Liste + ',';
      Liste := Liste + ListSpalten.Items[i];
    end;
  FSatz.Spalten := Liste;
  FSatz.Sortierung := Trim(EditSortierung.Text);
  FSatz.Filter := Trim(EditFilter.Text);
  if FAdmin then
    FSatz.SqlText := Trim(MemoSql.Text);
  if not FensterSpeichern(FSatz, Fehler) then
  begin
    ShowMessage(Fehler);
    Exit;
  end;
  ModalResult := mrOk;
end;

procedure TFensterEinstellung.AbbrechenKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFensterEinstellung.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end
  else if Key = VK_F10 then
  begin
    SpeichernKlick(nil);
    Key := 0;
  end
  else if Key = VK_F12 then
    Key := 0;
end;

end.
