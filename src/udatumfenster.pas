unit udatumfenster;

{ Kleines Datumsfenster für alle Datumsfelder. Ein Feld mit > öffnet es
  per Klick oder F4. ESC bricht ab, Return übernimmt den Tag.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Graphics,
  LCLType, Calendar;

function DatumZeigen(const Start: string; out Ergebnis: string): Boolean;

implementation

{$R *.lfm}

uses
  udatum;

type
  TDatumFenster = class(TForm)
    ComboMonat: TComboBox;
    ComboJahr: TComboBox;
    Kalender: TCalendar;
    PanelKnopf: TPanel;
    LabelEsc: TLabel;
    ButtonAbbrechen: TButton;
    LabelF6: TLabel;
    ButtonHeute: TButton;
    LabelReturn: TLabel;
    ButtonUebernehmen: TButton;
    procedure FormZeigen(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MonatGeaendert(Sender: TObject);
    procedure JahrGeaendert(Sender: TObject);
    procedure KalenderGeaendert(Sender: TObject);
    procedure HeuteKlick(Sender: TObject);
    procedure AbbrechenKlick(Sender: TObject);
    procedure UebernehmenKlick(Sender: TObject);
    procedure TagNrDoppel(Sender: TObject);
  private
    FStart: string;
    FErgebnis: string;
    FSync: Boolean;
    procedure JahreFuellen(Auswahl: Word);
    procedure SetzeDatum(Jahr, Monat, TagNr: Word);
    procedure AusKalender;
  end;

  TDatumHaken = class
    procedure Taste(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Klick(Sender: TObject);
    procedure Sichtbar(Sender: TObject; Formular: TCustomForm);
  end;

var
  DatumOffen: Boolean;
  DatumHaken: TDatumHaken;

function DatumZeigen(const Start: string; out Ergebnis: string): Boolean;
var
  Fenster: TDatumFenster;
begin
  Ergebnis := '';
  Fenster := TDatumFenster.Create(Application);
  try
    Fenster.FStart := Start;
    Result := Fenster.ShowModal = mrOk;
    if Result then
      Ergebnis := Fenster.FErgebnis;
  finally
    Fenster.Free;
  end;
end;

function Kern(const Beschriftung: string): string;
var
  S: string;
  i: Integer;
begin
  S := Trim(Beschriftung);
  if (S <> '') and (S[Length(S)] = '>') then
    Delete(S, Length(S), 1);
  S := LowerCase(Trim(S));
  Result := '';
  for i := 1 to Length(S) do
    if S[i] <> ' ' then
      Result := Result + S[i];
end;

function IstDatumsKern(const Text: string): Boolean;
begin
  Result := (Text = 'letztebearbeitung') or (Text = 'erfasst') or
    (Text = 'geaendert') or (Text = 'geändert');
  if Result then
    Exit;
  Result := (Length(Text) >= 5) and
    (Copy(Text, Length(Text) - 4, 5) = 'datum');
end;

function NameIstDatum(const Name: string): Boolean;
var
  N: string;
begin
  N := LowerCase(Name);
  Result := (N = 'editdatum') or (N = 'editerfasst') or (N = 'editgeaendert');
end;

function EditNeben(Beschriftung: TLabel): TCustomEdit;
var
  i, Abstand, Bester: Integer;
  Kind: TControl;
  Edit: TCustomEdit;
  Eltern: TWinControl;
begin
  Result := nil;
  Eltern := Beschriftung.Parent;
  if Eltern = nil then
    Exit;
  Bester := MaxInt;
  for i := 0 to Eltern.ControlCount - 1 do
  begin
    Kind := Eltern.Controls[i];
    if not (Kind is TCustomEdit) or (Kind is TCustomMemo) then
      Continue;
    Edit := TCustomEdit(Kind);
    if Abs(Edit.Top - Beschriftung.Top) > 12 then
      Continue;
    if Edit.Left + Edit.Width <= Beschriftung.Left then
      Continue;
    Abstand := Edit.Left - (Beschriftung.Left + Beschriftung.Width);
    if Abstand < 0 then
      Abstand := 0;
    if Abstand < Bester then
    begin
      Bester := Abstand;
      Result := Edit;
    end;
  end;
end;

function BeschriftungZu(Edit: TCustomEdit): Boolean;
var
  i: Integer;
  Kind: TControl;
  Beschriftung: TLabel;
begin
  Result := False;
  if (Edit = nil) or (Edit.Parent = nil) then
    Exit;
  for i := 0 to Edit.Parent.ControlCount - 1 do
  begin
    Kind := Edit.Parent.Controls[i];
    if not (Kind is TLabel) then
      Continue;
    Beschriftung := TLabel(Kind);
    if not IstDatumsKern(Kern(Beschriftung.Caption)) then
      Continue;
    if EditNeben(Beschriftung) = Edit then
      Exit(True);
  end;
end;

function ZielEdit(Control: TControl; out Edit: TCustomEdit): Boolean;
begin
  Result := False;
  if not (Control is TCustomEdit) or (Control is TCustomMemo) then
    Exit;
  Edit := TCustomEdit(Control);
  if Edit.ReadOnly or not Edit.Visible then
    Exit;
  Result := NameIstDatum(Edit.Name) or BeschriftungZu(Edit);
end;

procedure Oeffnen(Edit: TCustomEdit);
var
  Ergebnis: string;
begin
  if DatumOffen or (Edit = nil) or Edit.ReadOnly or not Edit.Visible then
    Exit;
  DatumOffen := True;
  try
    if DatumZeigen(Edit.Text, Ergebnis) then
      Edit.Text := Ergebnis;
  finally
    DatumOffen := False;
  end;
end;

procedure Verbinde(Wurzel: TWinControl);
var
  i: Integer;
  Kind: TControl;
  Beschriftung: TLabel;
begin
  for i := 0 to Wurzel.ControlCount - 1 do
  begin
    Kind := Wurzel.Controls[i];
    if Kind is TWinControl then
      Verbinde(TWinControl(Kind));
    if not (Kind is TLabel) then
      Continue;
    Beschriftung := TLabel(Kind);
    if not IstDatumsKern(Kern(Beschriftung.Caption)) then
      Continue;
    if EditNeben(Beschriftung) = nil then
      Continue;
    Beschriftung.OnClick := @DatumHaken.Klick;
  end;
end;

procedure TDatumFenster.JahreFuellen(Auswahl: Word);
var
  Heute, Von, Bis, Jahr: Word;
  Monat, TagNr: Word;
begin
  DecodeDate(Date, Heute, Monat, TagNr);
  Von := Heute - 40;
  Bis := Heute + 10;
  if Auswahl < Von then
    Von := Auswahl;
  if Auswahl > Bis then
    Bis := Auswahl;
  ComboJahr.Items.BeginUpdate;
  try
    ComboJahr.Items.Clear;
    for Jahr := Von to Bis do
      ComboJahr.Items.Add(IntToStr(Jahr));
  finally
    ComboJahr.Items.EndUpdate;
  end;
  ComboJahr.ItemIndex := ComboJahr.Items.IndexOf(IntToStr(Auswahl));
end;

procedure TDatumFenster.SetzeDatum(Jahr, Monat, TagNr: Word);
var
  Grenze: Word;
begin
  if Monat < 1 then
    Monat := 1;
  if Monat > 12 then
    Monat := 12;
  Grenze := TageImMonat(Jahr, Monat);
  if TagNr < 1 then
    TagNr := 1;
  if TagNr > Grenze then
    TagNr := Grenze;
  FSync := True;
  try
    Kalender.DateTime := EncodeDate(Jahr, Monat, TagNr);
    ComboMonat.ItemIndex := Monat - 1;
    if ComboJahr.Items.IndexOf(IntToStr(Jahr)) < 0 then
      JahreFuellen(Jahr)
    else
      ComboJahr.ItemIndex := ComboJahr.Items.IndexOf(IntToStr(Jahr));
  finally
    FSync := False;
  end;
end;

procedure TDatumFenster.AusKalender;
var
  Jahr, Monat, TagNr: Word;
begin
  if FSync then
    Exit;
  DecodeDate(Kalender.DateTime, Jahr, Monat, TagNr);
  FSync := True;
  try
    ComboMonat.ItemIndex := Monat - 1;
    if ComboJahr.Items.IndexOf(IntToStr(Jahr)) < 0 then
      JahreFuellen(Jahr)
    else
      ComboJahr.ItemIndex := ComboJahr.Items.IndexOf(IntToStr(Jahr));
  finally
    FSync := False;
  end;
end;

procedure TDatumFenster.FormZeigen(Sender: TObject);
var
  Jahr, Monat, TagNr: Word;
begin
  Kalender.FirstDayOfWeek := dowMonday;
  if not DatumLesen(FStart, Jahr, Monat, TagNr) then
    DecodeDate(Date, Jahr, Monat, TagNr);
  FSync := True;
  try
    JahreFuellen(Jahr);
  finally
    FSync := False;
  end;
  SetzeDatum(Jahr, Monat, TagNr);
  Kalender.SetFocus;
end;

procedure TDatumFenster.MonatGeaendert(Sender: TObject);
var
  Jahr, Monat, TagNr: Word;
begin
  if FSync or (ComboMonat.ItemIndex < 0) then
    Exit;
  DecodeDate(Kalender.DateTime, Jahr, Monat, TagNr);
  Jahr := StrToIntDef(ComboJahr.Text, Jahr);
  SetzeDatum(Jahr, ComboMonat.ItemIndex + 1, TagNr);
end;

procedure TDatumFenster.JahrGeaendert(Sender: TObject);
var
  Jahr, Monat, TagNr: Word;
begin
  if FSync then
    Exit;
  DecodeDate(Kalender.DateTime, Jahr, Monat, TagNr);
  Jahr := StrToIntDef(ComboJahr.Text, Jahr);
  if ComboMonat.ItemIndex >= 0 then
    Monat := ComboMonat.ItemIndex + 1;
  SetzeDatum(Jahr, Monat, TagNr);
end;

procedure TDatumFenster.KalenderGeaendert(Sender: TObject);
begin
  AusKalender;
end;

procedure TDatumFenster.HeuteKlick(Sender: TObject);
var
  Jahr, Monat, TagNr: Word;
begin
  DecodeDate(Date, Jahr, Monat, TagNr);
  SetzeDatum(Jahr, Monat, TagNr);
  Kalender.SetFocus;
end;

procedure TDatumFenster.AbbrechenKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TDatumFenster.UebernehmenKlick(Sender: TObject);
var
  Jahr, Monat, TagNr: Word;
begin
  DecodeDate(Kalender.DateTime, Jahr, Monat, TagNr);
  FErgebnis := DatumIso(Jahr, Monat, TagNr);
  ModalResult := mrOk;
end;

procedure TDatumFenster.TagNrDoppel(Sender: TObject);
begin
  UebernehmenKlick(Sender);
end;

procedure TDatumFenster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) or (Key = VK_F12) then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end
  else if Key = VK_F6 then
  begin
    HeuteKlick(nil);
    Key := 0;
  end
  else if Key = VK_RETURN then
  begin
    UebernehmenKlick(nil);
    Key := 0;
  end;
end;

procedure TDatumHaken.Taste(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Edit: TCustomEdit;
begin
  if DatumOffen or (Key <> VK_F4) or (Shift <> []) then
    Exit;
  if not (Sender is TControl) then
    Exit;
  if not ZielEdit(TControl(Sender), Edit) then
    Exit;
  Oeffnen(Edit);
  Key := 0;
end;

procedure TDatumHaken.Klick(Sender: TObject);
var
  Beschriftung: TLabel;
  Edit: TCustomEdit;
begin
  if DatumOffen or not (Sender is TLabel) then
    Exit;
  Beschriftung := TLabel(Sender);
  Edit := EditNeben(Beschriftung);
  if Edit = nil then
    Exit;
  if Edit.CanFocus then
    Edit.SetFocus;
  Oeffnen(Edit);
end;

procedure TDatumHaken.Sichtbar(Sender: TObject; Formular: TCustomForm);
begin
  if (Formular = nil) or not Formular.Visible then
    Exit;
  Verbinde(Formular);
end;

initialization
  DatumOffen := False;
  DatumHaken := TDatumHaken.Create;
  Application.AddOnKeyDownBeforeHandler(@DatumHaken.Taste);
  Screen.AddHandlerFormVisibleChanged(@DatumHaken.Sichtbar);

finalization
  if Application <> nil then
    Application.RemoveOnKeyDownBeforeHandler(@DatumHaken.Taste);
  if Screen <> nil then
    Screen.RemoveHandlerFormVisibleChanged(@DatumHaken.Sichtbar);
  DatumHaken.Free;

end.
