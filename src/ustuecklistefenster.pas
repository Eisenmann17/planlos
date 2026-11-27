unit ustuecklistefenster;

{ Stücklisten pflegen und an einer Belegposition nachrechnen.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Grids,
  Graphics, LCLType, ustueckliste;

type
  TStuecklisteFenster = class(TForm)
    ListNamen: TListBox;
    LabelName: TLabel;
    EditName: TEdit;
    LabelGruppe: TLabel;
    ComboGruppe: TComboBox;
    LabelEinheit: TLabel;
    EditEinheit: TEdit;
    LabelSumme: TLabel;
    GridZeilen: TStringGrid;
    ButtonZeile: TButton;
    ButtonZeileWeg: TButton;
    ButtonLoeschen: TButton;
    PanelKnopf: TPanel;
    LabelEsc: TLabel;
    ButtonAbbrechen: TButton;
    LabelF10: TLabel;
    ButtonSpeichern: TButton;
    procedure FormErzeugen(Sender: TObject);
    procedure FormZeigen(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AuswahlKlick(Sender: TObject);
    procedure ZeileKlick(Sender: TObject);
    procedure ZeileWegKlick(Sender: TObject);
    procedure LoeschenKlick(Sender: TObject);
    procedure SpeichernKlick(Sender: TObject);
    procedure AbbrechenKlick(Sender: TObject);
    procedure ZelleFertig(Sender: TObject);
  private
    FIds: array of Int64;
    FId: Int64;
    FZeilen: TStueckZeilen;
    FNurZeilen: Boolean;
    FFuellen: Boolean;
    procedure Gruppen;
    procedure ListeLaden;
    procedure Gitter;
    procedure SummeZeigen;
    procedure AusMaske;
    procedure InMaske(const Liste: TStueckliste);
    procedure Leeren;
  public
    procedure FuerZeilen(const Bezeichnung, Einheit: string;
      const Zeilen: TStueckZeilen);
    function ZeilenErgebnis(out Bezeichnung, Einheit: string;
      out Zeilen: TStueckZeilen): Boolean;
  end;

procedure StuecklisteStammZeigen;
function StuecklisteWaehlen(out Id: Int64): Boolean;
function StuecklisteZeilenBearbeiten(var Bezeichnung, Einheit: string;
  var Zeilen: TStueckZeilen): Boolean;

implementation

{$R *.lfm}

uses
  uartikel, ubeleg;

procedure StuecklisteStammZeigen;
var
  Fenster: TStuecklisteFenster;
begin
  Fenster := TStuecklisteFenster.Create(Application);
  try
    Fenster.ShowModal;
  finally
    Fenster.Free;
  end;
end;

function StuecklisteWaehlen(out Id: Int64): Boolean;
var
  Formular: TForm;
  Liste: TListBox;
  Knopf, Abbruch: TButton;
  Namen, Nummern: TStringList;
begin
  Result := False;
  Id := 0;
  Namen := TStringList.Create;
  Nummern := TStringList.Create;
  Formular := TForm.CreateNew(nil);
  try
    StuecklistenHolen(Namen, Nummern);
    Formular.Caption := 'Stückliste aussuchen';
    Formular.Position := poDesigned;
    Formular.Width := 360;
    Formular.Height := 320;
    Formular.KeyPreview := True;
    Liste := TListBox.Create(Formular);
    Liste.Parent := Formular;
    Liste.Align := alClient;
    Liste.Items.Assign(Namen);
    Abbruch := TButton.Create(Formular);
    Abbruch.Parent := Formular;
    Abbruch.Caption := 'abbrechen';
    Abbruch.Cancel := True;
    Abbruch.Left := 8;
    Abbruch.Top := 250;
    Abbruch.ModalResult := mrCancel;
    Knopf := TButton.Create(Formular);
    Knopf.Parent := Formular;
    Knopf.Caption := 'übernehmen';
    Knopf.Left := 240;
    Knopf.Top := 250;
    Knopf.Width := 100;
    Knopf.ModalResult := mrOk;
    Liste.Align := alNone;
    Liste.SetBounds(8, 8, 340, 230);
    if (Formular.ShowModal = mrOk) and (Liste.ItemIndex >= 0) and
       (Liste.ItemIndex < Nummern.Count) then
    begin
      Id := StrToInt64Def(Nummern[Liste.ItemIndex], 0);
      Result := Id > 0;
    end;
  finally
    Formular.Free;
    Nummern.Free;
    Namen.Free;
  end;
end;

function StuecklisteZeilenBearbeiten(var Bezeichnung, Einheit: string;
  var Zeilen: TStueckZeilen): Boolean;
var
  Fenster: TStuecklisteFenster;
begin
  Fenster := TStuecklisteFenster.Create(Application);
  try
    Fenster.FuerZeilen(Bezeichnung, Einheit, Zeilen);
    Result := Fenster.ShowModal = mrOk;
    if Result then
      Fenster.ZeilenErgebnis(Bezeichnung, Einheit, Zeilen);
  finally
    Fenster.Free;
  end;
end;

procedure TStuecklisteFenster.FormErzeugen(Sender: TObject);
begin
  GridZeilen.Cells[0, 0] := 'Bezeichnung';
  GridZeilen.Cells[1, 0] := 'Menge';
  GridZeilen.Cells[2, 0] := 'Einheit';
  GridZeilen.Cells[3, 0] := 'EK';
  GridZeilen.Cells[4, 0] := 'Aufschlag';
  GridZeilen.Cells[5, 0] := 'VK';
  GridZeilen.ColWidths[0] := 180;
  GridZeilen.ColWidths[1] := 70;
  GridZeilen.ColWidths[2] := 70;
  GridZeilen.ColWidths[3] := 70;
  GridZeilen.ColWidths[4] := 70;
  GridZeilen.ColWidths[5] := 70;
end;

procedure TStuecklisteFenster.Gruppen;
var
  Namen: TStringList;
begin
  Namen := TStringList.Create;
  try
    StueckGruppenHolen(Namen);
    ComboGruppe.Items.Assign(Namen);
    ComboGruppe.Items.Insert(0, '');
  finally
    Namen.Free;
  end;
end;

procedure TStuecklisteFenster.ListeLaden;
var
  Namen, Nummern: TStringList;
  i: Integer;
begin
  Namen := TStringList.Create;
  Nummern := TStringList.Create;
  try
    StuecklistenHolen(Namen, Nummern);
    ListNamen.Items.Assign(Namen);
    SetLength(FIds, Nummern.Count);
    for i := 0 to Nummern.Count - 1 do
      FIds[i] := StrToInt64Def(Nummern[i], 0);
  finally
    Nummern.Free;
    Namen.Free;
  end;
end;

procedure TStuecklisteFenster.Gitter;
var
  i: Integer;
begin
  FFuellen := True;
  try
    if Length(FZeilen) = 0 then
    begin
      GridZeilen.RowCount := 2;
      for i := 0 to 5 do
        GridZeilen.Cells[i, 1] := '';
    end
    else
    begin
      GridZeilen.RowCount := Length(FZeilen) + 1;
      for i := 0 to High(FZeilen) do
      begin
        GridZeilen.Cells[0, i + 1] := FZeilen[i].Bezeichnung;
        GridZeilen.Cells[1, i + 1] := MilliAlsText(FZeilen[i].MengeMilli);
        GridZeilen.Cells[2, i + 1] := FZeilen[i].Einheit;
        GridZeilen.Cells[3, i + 1] := CentAlsText(FZeilen[i].EkCent);
        GridZeilen.Cells[4, i + 1] := TextAusAufschlag(FZeilen[i].AufschlagBp);
        GridZeilen.Cells[5, i + 1] := CentAlsText(ZeilenVkCent(FZeilen[i].MengeMilli,
          FZeilen[i].EkCent, FZeilen[i].AufschlagBp));
      end;
    end;
  finally
    FFuellen := False;
  end;
  SummeZeigen;
end;

procedure TStuecklisteFenster.SummeZeigen;
begin
  LabelSumme.Caption := 'Verkaufspreis je Einheit: ' +
    CentAlsText(SummeVkCent(FZeilen)) + ' €';
end;

procedure TStuecklisteFenster.AusMaske;
var
  i: Integer;
  Cent, Milli: Int64;
  Bp: Integer;
begin
  SetLength(FZeilen, 0);
  for i := 1 to GridZeilen.RowCount - 1 do
  begin
    if Trim(GridZeilen.Cells[0, i]) = '' then
      Continue;
    SetLength(FZeilen, Length(FZeilen) + 1);
    FZeilen[High(FZeilen)].Bezeichnung := Trim(GridZeilen.Cells[0, i]);
    if MilliAusText(GridZeilen.Cells[1, i], Milli) then
      FZeilen[High(FZeilen)].MengeMilli := Milli
    else
      FZeilen[High(FZeilen)].MengeMilli := 0;
    FZeilen[High(FZeilen)].Einheit := Trim(GridZeilen.Cells[2, i]);
    if CentAusText(GridZeilen.Cells[3, i], Cent) then
      FZeilen[High(FZeilen)].EkCent := Cent
    else
      FZeilen[High(FZeilen)].EkCent := 0;
    if AufschlagAusText(GridZeilen.Cells[4, i], Bp) then
      FZeilen[High(FZeilen)].AufschlagBp := Bp
    else
      FZeilen[High(FZeilen)].AufschlagBp := 0;
  end;
end;

procedure TStuecklisteFenster.InMaske(const Liste: TStueckliste);
var
  i: Integer;
begin
  FId := Liste.Id;
  EditName.Text := Liste.Bezeichnung;
  EditEinheit.Text := Liste.Einheit;
  ComboGruppe.ItemIndex := 0;
  for i := 0 to ComboGruppe.Items.Count - 1 do
    if ComboGruppe.Items[i] = Liste.Gruppe then
      ComboGruppe.ItemIndex := i;
  FZeilen := Liste.Zeilen;
  Gitter;
end;

procedure TStuecklisteFenster.Leeren;
begin
  FId := 0;
  EditName.Text := '';
  EditEinheit.Text := '';
  ComboGruppe.ItemIndex := 0;
  SetLength(FZeilen, 0);
  ListNamen.ItemIndex := -1;
  Gitter;
end;

procedure TStuecklisteFenster.FuerZeilen(const Bezeichnung, Einheit: string;
  const Zeilen: TStueckZeilen);
begin
  FNurZeilen := True;
  FId := 0;
  EditName.Text := Bezeichnung;
  EditEinheit.Text := Einheit;
  FZeilen := Zeilen;
end;

function TStuecklisteFenster.ZeilenErgebnis(out Bezeichnung, Einheit: string;
  out Zeilen: TStueckZeilen): Boolean;
begin
  AusMaske;
  Bezeichnung := Trim(EditName.Text);
  Einheit := Trim(EditEinheit.Text);
  Zeilen := FZeilen;
  Result := True;
end;

procedure TStuecklisteFenster.FormZeigen(Sender: TObject);
begin
  Gruppen;
  if FNurZeilen then
  begin
    Caption := 'Stückliste der Position';
    ListNamen.Visible := False;
    ButtonLoeschen.Visible := False;
    LabelGruppe.Visible := False;
    ComboGruppe.Visible := False;
    ButtonSpeichern.Caption := 'übernehmen';
    ButtonAbbrechen.Caption := 'abbrechen';
    Gitter;
  end
  else
  begin
    ListeLaden;
    Leeren;
  end;
end;

procedure TStuecklisteFenster.AuswahlKlick(Sender: TObject);
var
  Liste: TStueckliste;
begin
  if FNurZeilen or (ListNamen.ItemIndex < 0) or
     (ListNamen.ItemIndex > High(FIds)) then
    Exit;
  if StuecklisteLaden(FIds[ListNamen.ItemIndex], Liste) then
    InMaske(Liste);
end;

procedure TStuecklisteFenster.ZeileKlick(Sender: TObject);
begin
  AusMaske;
  SetLength(FZeilen, Length(FZeilen) + 1);
  FZeilen[High(FZeilen)].MengeMilli := 1000;
  Gitter;
  GridZeilen.Row := GridZeilen.RowCount - 1;
  GridZeilen.Col := 0;
  GridZeilen.SetFocus;
end;

procedure TStuecklisteFenster.ZeileWegKlick(Sender: TObject);
var
  Index, i: Integer;
begin
  AusMaske;
  Index := GridZeilen.Row - 1;
  if (Index < 0) or (Index > High(FZeilen)) then
    Exit;
  for i := Index to High(FZeilen) - 1 do
    FZeilen[i] := FZeilen[i + 1];
  SetLength(FZeilen, Length(FZeilen) - 1);
  Gitter;
end;

procedure TStuecklisteFenster.LoeschenKlick(Sender: TObject);
var
  Fehler: string;
begin
  if FId = 0 then
  begin
    Leeren;
    Exit;
  end;
  if MessageDlg('Stückliste löschen?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  if not StuecklisteLoeschen(FId, Fehler) then
    ShowMessage(Fehler)
  else
  begin
    Leeren;
    ListeLaden;
  end;
end;

procedure TStuecklisteFenster.SpeichernKlick(Sender: TObject);
var
  Liste: TStueckliste;
  Fehler: string;
begin
  AusMaske;
  if FNurZeilen then
  begin
    if Trim(EditName.Text) = '' then
    begin
      ShowMessage('Die Stückliste braucht einen Namen.');
      Exit;
    end;
    ModalResult := mrOk;
    Exit;
  end;
  Liste.Id := FId;
  Liste.Bezeichnung := Trim(EditName.Text);
  if ComboGruppe.ItemIndex > 0 then
    Liste.Gruppe := ComboGruppe.Items[ComboGruppe.ItemIndex]
  else
    Liste.Gruppe := '';
  Liste.Einheit := Trim(EditEinheit.Text);
  Liste.Zeilen := FZeilen;
  if not StuecklisteSpeichern(Liste, Fehler) then
  begin
    ShowMessage(Fehler);
    Exit;
  end;
  FId := Liste.Id;
  ListeLaden;
  Gitter;
end;

procedure TStuecklisteFenster.AbbrechenKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TStuecklisteFenster.ZelleFertig(Sender: TObject);
begin
  if FFuellen then
    Exit;
  AusMaske;
  Gitter;
end;

procedure TStuecklisteFenster.FormKeyDown(Sender: TObject; var Key: Word;
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
