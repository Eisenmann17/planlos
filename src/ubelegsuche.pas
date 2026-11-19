unit ubelegsuche;

{ Eine Suche für alle Belegarten. Die Art filtert die Liste.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Grids,
  Graphics, LCLType, utastenleiste, ubeleg, ubelegfenster;

type
  TBelegsuche = class(TForm)
  private
    FFilter: TEdit;
    FHinweis: TLabel;
    FListe: TStringGrid;
    FStatus: TLabel;
    FArt: TBelegart;
    FTastenInfo: TBelegTasten;
    FIds: array of Int64;
    FLeiste: TPanel;
    FNeu: TButton;
    FKopieren: TButton;
    FAendern: TButton;
    FLoeschen: TButton;
    FSchliessen: TButton;
    FLabelSchluss: TLabel;
    FNeuAn: Boolean;
    FKopierenAn: Boolean;
    FAendernAn: Boolean;
    FLoeschenAn: Boolean;
    FVorgabe: Boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KnopfKlick(Sender: TObject);
    procedure ListeKlick(Sender: TObject);
    procedure LeisteRichten(Sender: TObject);
    procedure KnoepfeStellen;
    function VorgabeErlaubt(const Aktionsname: string): Boolean;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FilterTaste(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
    procedure ListeLaden;
    procedure WaehleId(Id: Int64);
    function GewaehlteId: Int64;
    procedure Aktion(const Aktionsname: string);
  public
    constructor Create(TheOwner: TComponent); override;
    function Oeffne(const Kuerzel: string): Boolean;
    procedure SetzeFunktionen(Neu, Kopieren, Aendern, Loeschen: Boolean);
  end;

procedure BelegsucheZeigen(const Kuerzel: string);

implementation

uses
  ubenutzer;

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

procedure BelegsucheZeigen(const Kuerzel: string);
var
  Fenster: TBelegsuche;
  Meldung: string;
begin
  if not AktionZulaessig('beleg', Kuerzel, 'sehen', Meldung) then
  begin
    ShowMessage(Meldung);
    Exit;
  end;
  Fenster := TBelegsuche.Create(Application);
  if not Fenster.Oeffne(Kuerzel) then
  begin
    Fenster.Free;
    ShowMessage('Die Belegart ' + Kuerzel + ' ist nicht angelegt.');
    Exit;
  end;
  Fenster.Show;
end;

constructor TBelegsuche.Create(TheOwner: TComponent);

  function Knopf(const Taste, Text, Aktion: string; Links: Integer): TButton;
  var
    Schild: TLabel;
  begin
    Schild := TLabel.Create(Self);
    Schild.Parent := FLeiste;
    Schild.Left := Links;
    Schild.Top := 2;
    Schild.Caption := Taste;
    Result := TButton.Create(Self);
    Result.Parent := FLeiste;
    Result.Left := Links;
    Result.Top := 18;
    Result.Width := 77;
    Result.Height := 22;
    Result.Caption := Text;
    Result.Hint := Aktion;
    Result.OnClick := @KnopfKlick;
  end;

begin
  inherited CreateNew(TheOwner, 1);
  Position := poDesigned;
  KeyPreview := True;
  OnKeyDown := @FormKeyDown;
  OnClose := @FormClose;

  FLeiste := TPanel.Create(Self);
  FLeiste.Parent := Self;
  FLeiste.Align := alBottom;
  FLeiste.Height := 46;
  FLeiste.BevelOuter := bvNone;
  FLeiste.Caption := '';
  FLeiste.OnResize := @LeisteRichten;
  FNeu := Knopf('F2', 'neu', 'neu', 8);
  FKopieren := Knopf('F5', 'kopieren', 'kopieren', 96);
  FAendern := Knopf('F6', 'ändern', 'oeffnen', 184);
  FLoeschen := Knopf('F8', 'löschen', 'loeschen', 272);
  FLabelSchluss := TLabel.Create(Self);
  FLabelSchluss.Parent := FLeiste;
  FLabelSchluss.Caption := 'F12';
  FLabelSchluss.Top := 2;
  FSchliessen := TButton.Create(Self);
  FSchliessen.Parent := FLeiste;
  FSchliessen.Top := 18;
  FSchliessen.Width := 92;
  FSchliessen.Height := 22;
  FSchliessen.Caption := 'schließen';
  FSchliessen.Hint := 'schliessen';
  FSchliessen.OnClick := @KnopfKlick;
  FSchliessen.Anchors := [akTop, akRight];

  FStatus := TLabel.Create(Self);
  FStatus.Parent := Self;
  FStatus.Align := alBottom;
  FStatus.Height := 20;
  FStatus.AutoSize := False;
  FStatus.Layout := tlCenter;
  FStatus.BorderSpacing.Left := 8;

  FHinweis := TLabel.Create(Self);
  FHinweis.Parent := Self;
  FHinweis.Align := alTop;
  FHinweis.Height := 22;
  FHinweis.AutoSize := False;
  FHinweis.Layout := tlCenter;
  FHinweis.BorderSpacing.Left := 8;

  FFilter := TEdit.Create(Self);
  FFilter.Parent := Self;
  FFilter.Align := alTop;
  FFilter.TextHint := 'Nummer, Name oder Bezeichnung';
  FFilter.OnKeyDown := @FilterTaste;

  FListe := TStringGrid.Create(Self);
  FListe.Parent := Self;
  FListe.Align := alClient;
  FListe.FixedCols := 0;
  FListe.FixedRows := 1;
  FListe.RowCount := 1;
  FListe.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
    goRowSelect, goColSizing, goThumbTracking];
  FListe.BorderSpacing.Around := 6;
  FListe.OnClick := @ListeKlick;
end;

procedure TBelegsuche.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

function TBelegsuche.Oeffne(const Kuerzel: string): Boolean;
begin
  Result := BelegartLaden(Kuerzel, FArt);
  if not Result then
    Exit;
  Caption := 'Planlos - ' + FArt.Bezeichnung;
  Position := poDesigned;
  Left := FArt.Links;
  Top := FArt.Oben;
  Width := FArt.Breite;
  Height := FArt.Hoehe;
  FHinweis.Caption := 'Belegart ' + FArt.Bezeichnung +
    '. Nummernkreis ' + FArt.Nummernkreis + '. F2 legt einen neuen Beleg an.';
  FTastenInfo := BelegTasten(FArt.Kuerzel, 'suche');
  ListeLaden;
  KnoepfeStellen;
  LeisteRichten(nil);
end;

procedure TBelegsuche.ListeLaden;
var
  Spalten, Zeilen, TeileZeile: TStringList;
  Spalte, Zeile: Integer;
begin
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  TeileZeile := TStringList.Create;
  try
    BelegeLesen(FArt.Kuerzel, FFilter.Text, Spalten, Zeilen);
    FListe.ColCount := Spalten.Count;
    if Zeilen.Count = 0 then
      FListe.RowCount := 2
    else
      FListe.RowCount := Zeilen.Count + 1;
    for Spalte := 0 to Spalten.Count - 1 do
    begin
      FListe.Cells[Spalte, 0] := Spalten[Spalte];
      if Spalte = 0 then
        FListe.ColWidths[Spalte] := 50
      else if Spalte = 4 then
        FListe.ColWidths[Spalte] := 100
      else
        FListe.ColWidths[Spalte] := 160;
    end;
    SetLength(FIds, Zeilen.Count);
    for Zeile := 0 to Zeilen.Count - 1 do
    begin
      Teile(Zeilen[Zeile], TeileZeile);
      if TeileZeile.Count > 0 then
        FIds[Zeile] := StrToInt64Def(TeileZeile[0], 0);
      for Spalte := 0 to Spalten.Count - 1 do
        if Spalte < TeileZeile.Count then
          FListe.Cells[Spalte, Zeile + 1] := TeileZeile[Spalte]
        else
          FListe.Cells[Spalte, Zeile + 1] := '';
    end;
    if Zeilen.Count > 0 then
      FListe.Row := 1;
    FStatus.Caption := IntToStr(Zeilen.Count) + ' ' + FArt.Bezeichnung;
    KnoepfeStellen;
  finally
    TeileZeile.Free;
    Zeilen.Free;
    Spalten.Free;
  end;
end;

function TBelegsuche.GewaehlteId: Int64;
begin
  Result := 0;
  if (FListe.Row < 1) or (FListe.Row > Length(FIds)) then
    Exit;
  Result := FIds[FListe.Row - 1];
end;

procedure TBelegsuche.WaehleId(Id: Int64);
var
  i: Integer;
begin
  for i := 0 to High(FIds) do
    if FIds[i] = Id then
    begin
      FListe.Row := i + 1;
      Exit;
    end;
end;

procedure TBelegsuche.KnopfKlick(Sender: TObject);
begin
  Aktion(TButton(Sender).Hint);
end;

procedure TBelegsuche.ListeKlick(Sender: TObject);
begin
  KnoepfeStellen;
end;

procedure TBelegsuche.LeisteRichten(Sender: TObject);
begin
  if (FSchliessen = nil) or (FLeiste = nil) then
    Exit;
  FSchliessen.Left := FLeiste.ClientWidth - FSchliessen.Width - 8;
  FLabelSchluss.Left := FSchliessen.Left;
end;

procedure TBelegsuche.SetzeFunktionen(Neu, Kopieren, Aendern, Loeschen: Boolean);
begin
  FVorgabe := True;
  FNeuAn := Neu;
  FKopierenAn := Kopieren;
  FAendernAn := Aendern;
  FLoeschenAn := Loeschen;
  KnoepfeStellen;
end;

function TBelegsuche.VorgabeErlaubt(const Aktionsname: string): Boolean;
begin
  Result := True;
  if not FVorgabe then
    Exit;
  if (Aktionsname = 'neu') then
    Result := FNeuAn
  else if Aktionsname = 'kopieren' then
    Result := FKopierenAn
  else if (Aktionsname = 'oeffnen') or (Aktionsname = 'aendern') then
    Result := FAendernAn
  else if Aktionsname = 'loeschen' then
    Result := FLoeschenAn;
end;

procedure TBelegsuche.KnoepfeStellen;
var
  Meldung: string;
  ZeileDa: Boolean;
begin
  if FNeu = nil then
    Exit;
  ZeileDa := GewaehlteId > 0;
  FNeu.Enabled := VorgabeErlaubt('neu') and
    AktionZulaessig('beleg', FArt.Kuerzel, 'neu', Meldung);
  FKopieren.Enabled := ZeileDa and VorgabeErlaubt('kopieren') and
    AktionZulaessig('beleg', FArt.Kuerzel, 'kopieren', Meldung);
  FAendern.Enabled := ZeileDa and VorgabeErlaubt('oeffnen') and
    AktionZulaessig('beleg', FArt.Kuerzel, 'aendern', Meldung);
  FLoeschen.Enabled := ZeileDa and VorgabeErlaubt('loeschen') and
    AktionZulaessig('beleg', FArt.Kuerzel, 'loeschen', Meldung);
end;

procedure TBelegsuche.Aktion(const Aktionsname: string);
var
  Id: Int64;
  Meldung: string;
begin
  if not VorgabeErlaubt(Aktionsname) then
  begin
    ShowMessage('Diese Funktion ist in diesem Fenster ausgeschaltet.');
    Exit;
  end;
  if Aktionsname = 'hilfe' then
    ShowMessage(
      'Suche für ' + FArt.Bezeichnung + '.' + LineEnding +
      'F2 legt einen neuen Beleg an. Im Beleg wählt F3 den Empfänger,' + LineEnding +
      'dort kann mit F2 ein neuer Kontakt angelegt und mit F10 übernommen werden.')
  else if Aktionsname = 'filtern' then
    ListeLaden
  else if Aktionsname = 'neu' then
  begin
    if not AktionZulaessig('beleg', FArt.Kuerzel, 'neu', Meldung) then
    begin
      ShowMessage(Meldung);
      Exit;
    end;
    Id := BelegBearbeiten(FArt.Kuerzel, 0);
    if Id > 0 then
    begin
      ListeLaden;
      WaehleId(Id);
    end;
  end
  else if Aktionsname = 'oeffnen' then
  begin
    if not AktionZulaessig('beleg', FArt.Kuerzel, 'aendern', Meldung) then
    begin
      ShowMessage(Meldung);
      Exit;
    end;
    Id := GewaehlteId;
    if Id = 0 then
      ShowMessage('Bitte zuerst eine Zeile auswählen.')
    else
    begin
      BelegBearbeiten(FArt.Kuerzel, Id);
      ListeLaden;
      WaehleId(Id);
    end;
  end
  else if Aktionsname = 'kopieren' then
  begin
    if not AktionZulaessig('beleg', FArt.Kuerzel, 'kopieren', Meldung) then
    begin
      ShowMessage(Meldung);
      Exit;
    end;
    Id := GewaehlteId;
    if Id = 0 then
    begin
      ShowMessage('Bitte zuerst einen Beleg auswählen.');
      Exit;
    end;
    Id := BelegKopieren(Id, Meldung);
    if Id = 0 then
      ShowMessage(Meldung)
    else
    begin
      ListeLaden;
      WaehleId(Id);
    end;
  end
  else if Aktionsname = 'loeschen' then
  begin
    if not AktionZulaessig('beleg', FArt.Kuerzel, 'loeschen', Meldung) then
    begin
      ShowMessage(Meldung);
      Exit;
    end;
    Id := GewaehlteId;
    if Id = 0 then
      Exit;
    if MessageDlg('Beleg ' + BelegNummer(Id) + ' löschen?', mtConfirmation,
      [mbYes, mbNo], 0) <> mrYes then
      Exit;
    if not BelegLoeschen(Id, Meldung) then
      ShowMessage(Meldung)
    else
      ListeLaden;
  end
  else if Aktionsname = 'uebernehmen' then
    FStatus.Caption := 'Ausgewählt: ' + BelegNummer(GewaehlteId)
  else if Aktionsname = 'schliessen' then
    Close;
end;

procedure TBelegsuche.TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
var
  i: Integer;
begin
  for i := 0 to High(FTastenInfo) do
    if (FTastenInfo[i].Ebene = Ebene) and (FTastenInfo[i].Taste = Taste) and
       FTastenInfo[i].Erlaubt then
    begin
      Aktion(FTastenInfo[i].Aktion);
      Exit;
    end;
end;

procedure TBelegsuche.FilterTaste(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    ListeLaden;
    Key := 0;
  end;
end;

procedure TBelegsuche.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (FFilter <> nil) and FFilter.Focused and (Key = VK_RETURN) then
    Exit;
  if Key = VK_ESCAPE then
  begin
    Close;
    Key := 0;
    Exit;
  end;
  if (Key >= VK_F1) and (Key <= VK_F12) then
  begin
    AlleLeistenNachziehen;
    TasteGedrueckt(Self, AktuelleEbene, Key - VK_F1 + 1);
    Key := 0;
  end;
end;

end.
