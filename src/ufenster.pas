unit ufenster;

{ Kaskade ab dem Hauptfenster, Strg+F6, Alt+F6 und F10.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Grids;

procedure FensterMerken(Formular: TCustomForm; const Fenster, Kontext: string);
procedure FensterAnwenden(Formular: TCustomForm);

implementation

uses
  LCLType, Dialogs, ubenutzer, udatenbank, ufensterdaten, ufenstereinstellung;

type
  TFensterHaken = class
    procedure Taste(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Sichtbar(Sender: TObject; Formular: TCustomForm);
    procedure Weg(Sender: TObject; Formular: TCustomForm);
  end;

  TMerk = class
    Formular: TCustomForm;
    Fenster: string;
    Kontext: string;
  end;

var
  Haken: TFensterHaken;
  Merker: TList;
  Offen: Boolean;

function MerkSuchen(Formular: TCustomForm): TMerk;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Merker.Count - 1 do
    if TMerk(Merker[i]).Formular = Formular then
      Exit(TMerk(Merker[i]));
end;

procedure FensterMerken(Formular: TCustomForm; const Fenster, Kontext: string);
var
  Merk: TMerk;
begin
  if Formular = nil then
    Exit;
  Merk := MerkSuchen(Formular);
  if Merk = nil then
  begin
    Merk := TMerk.Create;
    Merk.Formular := Formular;
    Merker.Add(Merk);
  end;
  Merk.Fenster := Fenster;
  Merk.Kontext := Kontext;
end;

function Hauptform: TForm;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Screen.FormCount - 1 do
    if Screen.Forms[i].ClassName = 'THauptfenster' then
      Exit(Screen.Forms[i]);
end;

function MitteOderAnmeldung(Formular: TCustomForm): Boolean;
begin
  Result := (Formular.ClassName = 'THauptfenster') or
    (Formular.ClassName = 'TAnmeldeFenster');
end;

function StaffelZahl(Neu: TCustomForm): Integer;
var
  i, Zahl: Integer;
  Formular: TForm;
begin
  Zahl := 0;
  for i := 0 to Screen.FormCount - 1 do
  begin
    Formular := Screen.Forms[i];
    if (Formular = Neu) or not Formular.Visible then
      Continue;
    if MitteOderAnmeldung(Formular) then
      Continue;
    Inc(Zahl);
  end;
  Result := Zahl + 1;
end;

procedure SpaltenAnwenden(Formular: TCustomForm; const Sichtbar: string);
var
  i, k: Integer;
  Gitter: TStringGrid;
  Liste: string;
begin
  if Sichtbar = '' then
    Exit;
  Liste := ',' + Sichtbar + ',';
  for i := 0 to Formular.ComponentCount - 1 do
    if Formular.Components[i] is TStringGrid then
    begin
      Gitter := TStringGrid(Formular.Components[i]);
      for k := 0 to Gitter.ColCount - 1 do
        if Pos(',' + Gitter.Cells[k, 0] + ',', Liste) = 0 then
          Gitter.ColWidths[k] := 0
        else if Gitter.ColWidths[k] < 24 then
          Gitter.ColWidths[k] := 80;
      Exit;
    end;
end;

procedure FensterAnwenden(Formular: TCustomForm);
var
  Merk: TMerk;
  Satz: TFensterSatz;
  Haupt: TForm;
  SchrittX, SchrittY, Index: Integer;
begin
  if (Formular = nil) or MitteOderAnmeldung(Formular) then
    Exit;
  Merk := MerkSuchen(Formular);
  if Merk = nil then
    FensterMerken(Formular, Copy(Formular.ClassName, 2, 40), '');
  Merk := MerkSuchen(Formular);
  if FensterWirksam(Merk.Fenster, Merk.Kontext, Satz) and (Satz.Breite > 40) and
     (Satz.Hoehe > 40) then
  begin
    Formular.Position := poDesigned;
    Formular.SetBounds(Satz.Links, Satz.Oben, Satz.Breite, Satz.Hoehe);
    SpaltenAnwenden(Formular, Satz.Spalten);
    Exit;
  end;
  Haupt := Hauptform;
  SchrittX := KaskadenSchritt('schritt_links', 9);
  SchrittY := KaskadenSchritt('schritt_oben', 26);
  if KaskadeAktiv then
    Index := StaffelZahl(Formular)
  else
    Index := 1;
  Formular.Position := poDesigned;
  if Haupt <> nil then
    Formular.SetBounds(Haupt.Left + Index * SchrittX, Haupt.Top + Index * SchrittY,
      Formular.Width, Formular.Height)
  else
    Formular.SetBounds(24 + Index * SchrittX, 24 + Index * SchrittY,
      Formular.Width, Formular.Height);
end;

function SpaltenNamen(Formular: TCustomForm): TStringList;
var
  i, k: Integer;
  Gitter: TStringGrid;
begin
  Result := TStringList.Create;
  if Formular = nil then
    Exit;
  for i := 0 to Formular.ComponentCount - 1 do
    if Formular.Components[i] is TStringGrid then
    begin
      Gitter := TStringGrid(Formular.Components[i]);
      for k := 0 to Gitter.ColCount - 1 do
        if Gitter.Cells[k, 0] <> '' then
          Result.Add(Gitter.Cells[k, 0]);
      Exit;
    end;
end;

function EnterZumNaechsten(Formular: TCustomForm; Steuerung: TControl): Boolean;
begin
  Result := False;
  if (Formular = nil) or (Steuerung = nil) or not (Steuerung is TWinControl) then
    Exit;
  if (Steuerung is TCustomMemo) or (Steuerung is TCustomGrid) or
     (Steuerung is TButton) then
    Exit;
  if not ((Steuerung is TCustomEdit) or (Steuerung is TCustomComboBox) or
          (Steuerung is TCheckBox)) then
    Exit;
  if (Formular.ClassName = 'TAnmeldeFenster') or
     (Formular.ClassName = 'TRechnerFenster') or
     (Formular.ClassName = 'TDatumFenster') or
     (Formular.ClassName = 'TSuchfenster') or
     (Formular.ClassName = 'TBelegsuche') or
     (Formular.ClassName = 'TArtikelWahl') or
     (Formular.ClassName = 'THauptfenster') then
    Exit;
  Result := True;
end;

function MeldungErnst(const Fehler: string): Boolean;
var
  Klein: string;
begin
  Klein := LowerCase(Fehler);
  Result := (Fehler <> '') and (Pos('nicht gefunden', Klein) = 0) and
    (Pos('not found', Klein) = 0);
end;

procedure StellungOeffnen(Formular: TCustomForm; Admin: Boolean);
var
  Merk: TMerk;
  Satz: TFensterSatz;
  Namen: TStringList;
  Fehler: string;
begin
  Merk := MerkSuchen(Formular);
  if Merk = nil then
    FensterMerken(Formular, Copy(Formular.ClassName, 2, 40), '');
  Merk := MerkSuchen(Formular);
  if not FensterMitVorgabe(Merk.Fenster, Merk.Kontext, Formular.Left, Formular.Top,
    Formular.Width, Formular.Height, Satz, Fehler) then
  begin
    Satz.Fenster := Merk.Fenster;
    Satz.Kontext := Merk.Kontext;
    Satz.Links := Formular.Left;
    Satz.Oben := Formular.Top;
    Satz.Breite := Formular.Width;
    Satz.Hoehe := Formular.Height;
    if MeldungErnst(Fehler) then
      ShowMessage(Fehler);
  end;
  Namen := SpaltenNamen(Formular);
  try
    Offen := True;
    if FensterEinstellungZeigen(Satz, Admin, Namen) then
      SpaltenAnwenden(Formular, Satz.Spalten);
  finally
    Offen := False;
    Namen.Free;
  end;
end;

function KnopfFinden(Formular: TCustomForm; const Name: string): TButton;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Formular.ComponentCount - 1 do
    if (Formular.Components[i] is TButton) and
       (CompareText(Formular.Components[i].Name, Name) = 0) then
      Exit(TButton(Formular.Components[i]));
end;

procedure TFensterHaken.Sichtbar(Sender: TObject; Formular: TCustomForm);
begin
  if (Formular = nil) or not Formular.Visible or Offen then
    Exit;
  FensterAnwenden(Formular);
end;

procedure TFensterHaken.Taste(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Formular: TCustomForm;
  Knopf: TButton;
begin
  if Offen or not (Sender is TControl) then
    Exit;
  Formular := GetParentForm(TControl(Sender));
  if Formular = nil then
    Formular := Screen.ActiveCustomForm;
  if Formular = nil then
    Exit;
  if (Key = VK_RETURN) and (Shift = []) and
     EnterZumNaechsten(Formular, TControl(Sender)) then
  begin
    Formular.SelectNext(TWinControl(Sender), True, True);
    Key := 0;
    Exit;
  end;
  if (Key = VK_F6) and (ssCtrl in Shift) then
  begin
    StellungOeffnen(Formular, False);
    Key := 0;
  end
  else if (Key = VK_F6) and (ssAlt in Shift) then
  begin
    if Sitzung.Rolle <> 'Administrator' then
    begin
      ShowMessage('Die Verwaltungsansicht ist dem Administrator vorbehalten.');
      Key := 0;
      Exit;
    end;
    StellungOeffnen(Formular, True);
    Key := 0;
  end
  else if (Key = VK_F10) and (Shift = []) then
  begin
    Knopf := KnopfFinden(Formular, 'ButtonSpeichern');
    if Knopf = nil then
      Knopf := KnopfFinden(Formular, 'ButtonUebernehmen');
    if Knopf = nil then
      Knopf := KnopfFinden(Formular, 'ButtonOK');
    if (Knopf <> nil) and Knopf.Enabled then
    begin
      Knopf.Click;
      Key := 0;
    end;
  end;
end;

procedure MerkWeg(Formular: TCustomForm);
var
  i: Integer;
begin
  for i := Merker.Count - 1 downto 0 do
    if TMerk(Merker[i]).Formular = Formular then
    begin
      TMerk(Merker[i]).Free;
      Merker.Delete(i);
    end;
end;

procedure TFensterHaken.Weg(Sender: TObject; Formular: TCustomForm);
begin
  MerkWeg(Formular);
end;

initialization
  Merker := TList.Create;
  Haken := TFensterHaken.Create;
  Offen := False;
  Screen.AddHandlerFormVisibleChanged(@Haken.Sichtbar);
  Screen.AddHandlerRemoveForm(@Haken.Weg);
  Application.AddOnKeyDownBeforeHandler(@Haken.Taste);

finalization
  Application.RemoveOnKeyDownBeforeHandler(@Haken.Taste);
  Screen.RemoveHandlerFormVisibleChanged(@Haken.Sichtbar);
  Screen.RemoveHandlerRemoveForm(@Haken.Weg);
  Haken.Free;
  Merker.Free;

end.
