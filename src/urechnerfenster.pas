unit urechnerfenster;

{ Kleines Rechnerfenster für Zahlenfelder. F4 öffnet es, wenn das
  aktive Feld eine Menge, ein Preis, ein Rabatt oder ein Aufschlag ist.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Grids,
  Graphics, LCLType;

function RechnerZeigen(const Start: string; out Ergebnis: string): Boolean;

implementation

{$R *.lfm}

uses
  urechner;

type
  TRechnerFenster = class(TForm)
    EditAusdruck: TEdit;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    ButtonTeil: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    ButtonMal: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ButtonMinus: TButton;
    Button0: TButton;
    ButtonKomma: TButton;
    ButtonProzent: TButton;
    ButtonPlus: TButton;
    ButtonLeeren: TButton;
    PanelKnopf: TPanel;
    LabelEsc: TLabel;
    ButtonAbbrechen: TButton;
    LabelReturn: TLabel;
    ButtonUebernehmen: TButton;
    procedure FormZeigen(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ZifferKlick(Sender: TObject);
    procedure LeerenKlick(Sender: TObject);
    procedure AbbrechenKlick(Sender: TObject);
    procedure UebernehmenKlick(Sender: TObject);
  private
    FStart: string;
    FErgebnis: string;
    procedure Anhaengen(const Zeichen: string);
  end;

const
  RechenFelder: array[0..13] of string = (
    'EditEk', 'EditAufschlag', 'EditMwst', 'EditGewicht',
    'EditZahl1', 'EditZahl2', 'EditZahl3',
    'EditBestand', 'EditMinBestand',
    'EditVEk', 'EditVAufschlag', 'EditVMenge', 'EditRabatt', 'EditSatz'
  );
  RechenSpalten: array[0..10] of string = (
    'menge', 'ek', 'aufschlag', 'rabatt', 'vk', 'mwst',
    'einzel', 'gewicht', 'zahl1', 'zahl2', 'zahl3'
  );

type
  TRechnerHaken = class
    procedure Taste(Sender: TObject; var Key: Word; Shift: TShiftState);
  end;

var
  RechnerOffen: Boolean;
  RechnerHaken: TRechnerHaken;

function Gleich(const A, B: string): Boolean;
begin
  Result := LowerCase(A) = LowerCase(B);
end;

function FeldNamePasst(const Name: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to High(RechenFelder) do
    if Gleich(RechenFelder[i], Name) then
      Exit(True);
end;

function SpaltePasst(const Kopf: string): Boolean;
var
  i: Integer;
  Normal: string;
begin
  Normal := LowerCase(Trim(Kopf));
  Result := False;
  for i := 0 to High(RechenSpalten) do
    if RechenSpalten[i] = Normal then
      Exit(True);
end;

function RechnerZeigen(const Start: string; out Ergebnis: string): Boolean;
var
  Fenster: TRechnerFenster;
begin
  Ergebnis := '';
  Fenster := TRechnerFenster.Create(Application);
  try
    Fenster.FStart := Start;
    Result := Fenster.ShowModal = mrOk;
    if Result then
      Ergebnis := Fenster.FErgebnis;
  finally
    Fenster.Free;
  end;
end;

procedure TRechnerFenster.Anhaengen(const Zeichen: string);
begin
  EditAusdruck.Text := EditAusdruck.Text + Zeichen;
  EditAusdruck.SelStart := Length(EditAusdruck.Text);
end;

procedure TRechnerFenster.ZifferKlick(Sender: TObject);
begin
  Anhaengen(TButton(Sender).Caption);
end;

procedure TRechnerFenster.LeerenKlick(Sender: TObject);
begin
  EditAusdruck.Text := '';
  EditAusdruck.SetFocus;
end;

procedure TRechnerFenster.FormZeigen(Sender: TObject);
begin
  EditAusdruck.Text := FStart;
  EditAusdruck.SetFocus;
  EditAusdruck.SelStart := Length(EditAusdruck.Text);
end;

procedure TRechnerFenster.UebernehmenKlick(Sender: TObject);
var
  Wert: Double;
  Fehler: string;
begin
  if not RechnerAuswerten(EditAusdruck.Text, Wert, Fehler) then
  begin
    ShowMessage(Fehler);
    EditAusdruck.SetFocus;
    Exit;
  end;
  FErgebnis := RechnerText(Wert);
  ModalResult := mrOk;
end;

procedure TRechnerFenster.AbbrechenKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TRechnerFenster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) or (Key = VK_F12) then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end
  else if Key = VK_RETURN then
  begin
    UebernehmenKlick(nil);
    Key := 0;
  end;
end;

function ZielEdit(Control: TControl; out Edit: TCustomEdit): Boolean;
begin
  Result := False;
  if (Control is TCustomEdit) and not (Control is TCustomMemo) and
     FeldNamePasst(Control.Name) and not TCustomEdit(Control).ReadOnly then
  begin
    Edit := TCustomEdit(Control);
    Result := True;
  end;
end;

function ZielZelle(Control: TControl; out Gitter: TStringGrid;
  out Spalte, Zeile: Integer): Boolean;
var
  Lauf: TControl;
begin
  Result := False;
  Lauf := Control;
  while (Lauf <> nil) and not (Lauf is TStringGrid) do
    Lauf := Lauf.Parent;
  if not (Lauf is TStringGrid) then
    Exit;
  Gitter := TStringGrid(Lauf);
  if not (goEditing in Gitter.Options) then
    Exit;
  Spalte := Gitter.Col;
  Zeile := Gitter.Row;
  if (Zeile < Gitter.FixedRows) or (Spalte < 0) or (Spalte >= Gitter.ColCount) then
    Exit;
  Result := SpaltePasst(Gitter.Cells[Spalte, 0]);
end;

procedure ZurueckSchreiben(Control: TControl; const Ergebnis: string);
var
  Edit: TCustomEdit;
  Gitter: TStringGrid;
  Spalte, Zeile: Integer;
begin
  if ZielEdit(Control, Edit) then
    Edit.Text := Ergebnis
  else if ZielZelle(Control, Gitter, Spalte, Zeile) then
  begin
    Gitter.Cells[Spalte, Zeile] := Ergebnis;
    if (Gitter.Editor <> nil) and (Gitter.Editor is TCustomEdit) then
      TCustomEdit(Gitter.Editor).Text := Ergebnis;
    if Assigned(Gitter.OnEditingDone) then
      Gitter.OnEditingDone(Gitter);
  end;
end;

procedure TRechnerHaken.Taste(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Edit: TCustomEdit;
  Gitter: TStringGrid;
  Spalte, Zeile: Integer;
  Start, Ergebnis: string;
begin
  if RechnerOffen or (Key <> VK_F4) or (Shift <> []) then
    Exit;
  if not (Sender is TControl) then
    Exit;
  Start := '';
  if ZielEdit(TControl(Sender), Edit) then
    Start := Edit.Text
  else if ZielZelle(TControl(Sender), Gitter, Spalte, Zeile) then
    Start := Gitter.Cells[Spalte, Zeile]
  else
    Exit;
  RechnerOffen := True;
  try
    if RechnerZeigen(Start, Ergebnis) then
      ZurueckSchreiben(TControl(Sender), Ergebnis);
  finally
    RechnerOffen := False;
  end;
  Key := 0;
end;

initialization
  RechnerOffen := False;
  RechnerHaken := TRechnerHaken.Create;
  Application.AddOnKeyDownBeforeHandler(@RechnerHaken.Taste);

finalization
  Application.RemoveOnKeyDownBeforeHandler(@RechnerHaken.Taste);
  RechnerHaken.Free;

end.
