unit ufensterliste;

{ Liste aller Fenstereinstellungen. Liegt unter Einstellungen, nicht bei der Belegart.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Grids,
  Graphics, LCLType;

type
  TFensterliste = class(TForm)
    LabelHinweis: TLabel;
    GridListe: TStringGrid;
    PanelKnopf: TPanel;
    LabelF6: TLabel;
    ButtonAendern: TButton;
    LabelF8: TLabel;
    ButtonVorgabe: TButton;
    LabelEsc: TLabel;
    ButtonSchliessen: TButton;
    procedure FormZeigen(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AendernKlick(Sender: TObject);
    procedure VorgabeKlick(Sender: TObject);
    procedure SchliessenKlick(Sender: TObject);
  private
    FIds: array of Int64;
    FAdmin: Boolean;
    procedure ListeLaden;
    function Gewaehlt: Integer;
    procedure SpaltenNamen(const Spalten: string; Ziel: TStrings);
  end;

procedure FensterlisteZeigen;

implementation

{$R *.lfm}

uses
  ubenutzer, ufensterdaten, ufenstereinstellung;

procedure Teile(const Zeile: string; Ziel: TStrings);
var
  Rest, Stueck: string;
  PosTab: Integer;
begin
  Ziel.Clear;
  Rest := Zeile;
  repeat
    PosTab := Pos(#9, Rest);
    if PosTab = 0 then
    begin
      Ziel.Add(Rest);
      Break;
    end;
    Stueck := Copy(Rest, 1, PosTab - 1);
    Ziel.Add(Stueck);
    Delete(Rest, 1, PosTab);
  until False;
end;

function EineZeile(const Text: string): string;
begin
  Result := StringReplace(Text, #13, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #10, ' ', [rfReplaceAll]);
end;

procedure FensterlisteZeigen;
var
  Fenster: TFensterliste;
begin
  Fenster := TFensterliste.Create(Application);
  try
    Fenster.ShowModal;
  finally
    Fenster.Free;
  end;
end;

procedure TFensterliste.SpaltenNamen(const Spalten: string; Ziel: TStrings);
var
  Rest, Stueck: string;
  Komma: Integer;
begin
  Ziel.Clear;
  Rest := Spalten;
  while Rest <> '' do
  begin
    Komma := Pos(',', Rest);
    if Komma = 0 then
    begin
      Stueck := Trim(Rest);
      Rest := '';
    end
    else
    begin
      Stueck := Trim(Copy(Rest, 1, Komma - 1));
      Delete(Rest, 1, Komma);
    end;
    if Stueck <> '' then
      Ziel.Add(Stueck);
  end;
end;

procedure TFensterliste.ListeLaden;
var
  Zeilen, TeileZeile: TStringList;
  i, SpaltenZahl: Integer;
  Auswahl: Int64;
begin
  Auswahl := 0;
  if Gewaehlt >= 0 then
    Auswahl := FIds[Gewaehlt];
  FAdmin := Sitzung.Rolle = 'Administrator';
  if FAdmin then
    SpaltenZahl := 3
  else
    SpaltenZahl := 2;
  GridListe.ColCount := SpaltenZahl;
  GridListe.Cells[0, 0] := 'Fenster';
  GridListe.Cells[1, 0] := 'Aufrufkontext';
  GridListe.ColWidths[0] := 180;
  GridListe.ColWidths[1] := 180;
  if FAdmin then
  begin
    GridListe.Cells[2, 0] := 'SQL';
    GridListe.ColWidths[2] := 300;
  end;
  Zeilen := TStringList.Create;
  TeileZeile := TStringList.Create;
  try
    FensterAlle(Zeilen);
    if Zeilen.Count = 0 then
    begin
      SetLength(FIds, 0);
      GridListe.RowCount := 2;
      GridListe.Cells[0, 1] :=
        'Noch keine eigenen Einstellungen. Mit Strg+F6 in einem Fenster speichern.';
      GridListe.ColWidths[0] := 640;
      GridListe.Cells[1, 1] := '';
      if FAdmin then
        GridListe.Cells[2, 1] := '';
      LabelHinweis.Caption := GridListe.Cells[0, 1];
      Exit;
    end;
    LabelHinweis.Caption :=
      'Gespeicherte Stellungen. Vorgabe löscht den Satz, dann gilt wieder die allgemeine Einstellung.';
    GridListe.RowCount := Zeilen.Count + 1;
    SetLength(FIds, Zeilen.Count);
    for i := 0 to Zeilen.Count - 1 do
    begin
      Teile(Zeilen[i], TeileZeile);
      if TeileZeile.Count > 0 then
        FIds[i] := StrToInt64Def(TeileZeile[0], 0)
      else
        FIds[i] := 0;
      if TeileZeile.Count > 1 then
        GridListe.Cells[0, i + 1] := TeileZeile[1]
      else
        GridListe.Cells[0, i + 1] := '';
      if TeileZeile.Count > 2 then
        GridListe.Cells[1, i + 1] := TeileZeile[2]
      else
        GridListe.Cells[1, i + 1] := '';
      if FAdmin then
      begin
        if TeileZeile.Count > 3 then
          GridListe.Cells[2, i + 1] := EineZeile(TeileZeile[3])
        else
          GridListe.Cells[2, i + 1] := '';
      end;
      if FIds[i] = Auswahl then
        GridListe.Row := i + 1;
    end;
  finally
    TeileZeile.Free;
    Zeilen.Free;
  end;
end;

function TFensterliste.Gewaehlt: Integer;
begin
  Result := GridListe.Row - 1;
  if (Result < 0) or (Result > High(FIds)) or (FIds[Result] = 0) then
    Result := -1;
end;

procedure TFensterliste.FormZeigen(Sender: TObject);
begin
  ListeLaden;
end;

procedure TFensterliste.AendernKlick(Sender: TObject);
var
  Index: Integer;
  Satz: TFensterSatz;
  Namen: TStringList;
begin
  Index := Gewaehlt;
  if Index < 0 then
  begin
    ShowMessage('Bitte zuerst eine Zeile wählen.');
    Exit;
  end;
  if not FensterLesen(GridListe.Cells[0, Index + 1], GridListe.Cells[1, Index + 1],
    Satz) then
  begin
    ShowMessage('Die Fenstereinstellung wurde nicht gefunden.');
    ListeLaden;
    Exit;
  end;
  Namen := TStringList.Create;
  try
    SpaltenNamen(Satz.Spalten, Namen);
    FensterEinstellungZeigen(Satz, FAdmin, Namen);
  finally
    Namen.Free;
  end;
  ListeLaden;
end;

procedure TFensterliste.VorgabeKlick(Sender: TObject);
var
  Index: Integer;
  Fehler, Frage: string;
begin
  Index := Gewaehlt;
  if Index < 0 then
  begin
    ShowMessage('Bitte zuerst eine Zeile wählen.');
    Exit;
  end;
  if GridListe.Cells[1, Index + 1] = '' then
    Frage := 'Die allgemeine Vorgabe für ' + GridListe.Cells[0, Index + 1] +
      ' löschen? Danach gilt die eingebaute Stellung.'
  else
    Frage := 'Die Einstellung für ' + GridListe.Cells[0, Index + 1] +
      ', Kontext ' + GridListe.Cells[1, Index + 1] +
      ', löschen? Danach gilt wieder die Vorgabe.';
  if MessageDlg(Frage, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  if not FensterLoeschen(FIds[Index], Fehler) then
    ShowMessage(Fehler);
  ListeLaden;
end;

procedure TFensterliste.SchliessenKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFensterliste.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) or (Key = VK_F10) then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end
  else if Key = VK_F6 then
  begin
    AendernKlick(nil);
    Key := 0;
  end
  else if Key = VK_F8 then
  begin
    VorgabeKlick(nil);
    Key := 0;
  end
  else if Key = VK_F12 then
    Key := 0;
end;

end.
