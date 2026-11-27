unit ubriefkopffenster;

{ Briefköpfe pflegen und eine Grafik zuordnen.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Graphics,
  LCLType, ufensterdaten, ugrafik;

type
  TBriefkopfFenster = class(TForm)
    ListNamen: TListBox;
    LabelName: TLabel;
    EditName: TEdit;
    LabelAbsender: TLabel;
    MemoAbsender: TMemo;
    LabelFuss: TLabel;
    MemoFuss: TMemo;
    LabelGrafik: TLabel;
    ComboGrafik: TComboBox;
    CheckStandard: TCheckBox;
    ButtonNeu: TButton;
    ButtonLoeschen: TButton;
    PanelKnopf: TPanel;
    LabelEsc: TLabel;
    ButtonAbbrechen: TButton;
    LabelF10: TLabel;
    ButtonSpeichern: TButton;
    procedure FormZeigen(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AuswahlKlick(Sender: TObject);
    procedure NeuKlick(Sender: TObject);
    procedure LoeschenKlick(Sender: TObject);
    procedure SpeichernKlick(Sender: TObject);
    procedure AbbrechenKlick(Sender: TObject);
  private
    FIds: array of Int64;
    FGrafikIds: array of Int64;
    FId: Int64;
    procedure GrafikListe;
    procedure ListeLaden;
    procedure Leeren;
  end;

procedure BriefkopfFensterZeigen;

implementation

{$R *.lfm}

procedure BriefkopfFensterZeigen;
var
  Fenster: TBriefkopfFenster;
begin
  Fenster := TBriefkopfFenster.Create(Application);
  try
    Fenster.ShowModal;
  finally
    Fenster.Free;
  end;
end;

procedure TBriefkopfFenster.GrafikListe;
var
  Namen, Nummern: TStringList;
  i, Gewaehlt: Integer;
begin
  Gewaehlt := 0;
  Namen := TStringList.Create;
  Nummern := TStringList.Create;
  try
    GrafikenHolen(Namen, Nummern);
    ComboGrafik.Items.BeginUpdate;
    try
      ComboGrafik.Items.Clear;
      ComboGrafik.Items.Add('(keine)');
      SetLength(FGrafikIds, Nummern.Count + 1);
      FGrafikIds[0] := 0;
      for i := 0 to Nummern.Count - 1 do
      begin
        FGrafikIds[i + 1] := StrToInt64Def(Nummern[i], 0);
        ComboGrafik.Items.Add(Namen[i]);
        if FGrafikIds[i + 1] = Gewaehlt then
          ComboGrafik.ItemIndex := i + 1;
      end;
    finally
      ComboGrafik.Items.EndUpdate;
    end;
  finally
    Nummern.Free;
    Namen.Free;
  end;
  if ComboGrafik.ItemIndex < 0 then
    ComboGrafik.ItemIndex := 0;
end;

procedure TBriefkopfFenster.ListeLaden;
var
  Namen, Nummern: TStringList;
  i: Integer;
begin
  Namen := TStringList.Create;
  Nummern := TStringList.Create;
  try
    BriefkoepfeHolen(Namen, Nummern);
    ListNamen.Items.Assign(Namen);
    SetLength(FIds, Nummern.Count);
    for i := 0 to Nummern.Count - 1 do
      FIds[i] := StrToInt64Def(Nummern[i], 0);
  finally
    Nummern.Free;
    Namen.Free;
  end;
end;

procedure TBriefkopfFenster.Leeren;
begin
  FId := 0;
  EditName.Text := '';
  MemoAbsender.Text := '';
  MemoFuss.Text := '';
  CheckStandard.Checked := False;
  ComboGrafik.ItemIndex := 0;
  ListNamen.ItemIndex := -1;
end;

procedure TBriefkopfFenster.FormZeigen(Sender: TObject);
begin
  GrafikListe;
  ListeLaden;
  Leeren;
end;

procedure TBriefkopfFenster.AuswahlKlick(Sender: TObject);
var
  Bezeichnung, Absender, Fuss: string;
  GrafikId: Int64;
  Standard: Boolean;
  i: Integer;
begin
  if (ListNamen.ItemIndex < 0) or (ListNamen.ItemIndex > High(FIds)) then
    Exit;
  FId := FIds[ListNamen.ItemIndex];
  if not BriefkopfDaten(FId, Bezeichnung, Absender, Fuss, GrafikId, Standard) then
  begin
    ShowMessage('Der Briefkopf wurde nicht gefunden.');
    ListeLaden;
    Leeren;
    Exit;
  end;
  EditName.Text := Bezeichnung;
  MemoAbsender.Text := Absender;
  MemoFuss.Text := Fuss;
  CheckStandard.Checked := Standard;
  ComboGrafik.ItemIndex := 0;
  for i := 0 to High(FGrafikIds) do
    if FGrafikIds[i] = GrafikId then
      ComboGrafik.ItemIndex := i;
end;

procedure TBriefkopfFenster.NeuKlick(Sender: TObject);
begin
  Leeren;
  EditName.SetFocus;
end;

procedure TBriefkopfFenster.LoeschenKlick(Sender: TObject);
var
  Fehler: string;
begin
  if FId = 0 then
  begin
    Leeren;
    Exit;
  end;
  if MessageDlg('Briefkopf löschen?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  if not BriefkopfLoeschen(FId, Fehler) then
    ShowMessage(Fehler)
  else
  begin
    Leeren;
    ListeLaden;
  end;
end;

procedure TBriefkopfFenster.SpeichernKlick(Sender: TObject);
var
  Fehler: string;
  GrafikId: Int64;
begin
  GrafikId := 0;
  if (ComboGrafik.ItemIndex >= 0) and (ComboGrafik.ItemIndex <= High(FGrafikIds)) then
    GrafikId := FGrafikIds[ComboGrafik.ItemIndex];
  if not BriefkopfSpeichern(FId, EditName.Text, MemoAbsender.Text, MemoFuss.Text,
    GrafikId, CheckStandard.Checked, Fehler) then
  begin
    ShowMessage(Fehler);
    Exit;
  end;
  ListeLaden;
end;

procedure TBriefkopfFenster.AbbrechenKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TBriefkopfFenster.FormKeyDown(Sender: TObject; var Key: Word;
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
