unit ueingabe;

{ Das eine Eingabefenster. Welche Felder es zeigt, steht in der Maske.
  Die Stellen und Beschriftungen kommen aus der alten Adressmaske.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Graphics,
  LCLType, utastenleiste, umaske;

type
  TEingabefenster = class(TForm)
  private
    FFlaeche: TPanel;
    FTasten: TTastenleiste;
    FNr: TLabel;
    FKuerzel: string;
    FBezeichnung: string;
    FId: Int64;
    FGespeichert: Int64;
    FTastenInfo: TTastenListe;
    FSpalten: array of string;
    FArten: array of string;
    FPflicht: array of Boolean;
    FEingaben: array of TControl;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
    procedure FeldKlick(Sender: TObject);
    procedure TastenAusDaten;
    procedure AktionAusfuehren(const Aktionsname: string);
    procedure AuswahlOeffnen(Index: Integer);
    function IndexVon(Feld: TObject): Integer;
    function TextVon(Feld: TControl): string;
    procedure TextNach(Feld: TControl; const Wert: string);
    function WerteSammeln: TStringList;
  public
    constructor Create(TheOwner: TComponent); override;
    procedure Vorbereiten(const Kuerzel: string; Id: Int64);
    function HatFeld(const Spalte: string): Boolean;
    function FeldBei(const Spalte: string; Links, Oben: Integer): Boolean;
    procedure SetzeWert(const Spalte, Wert: string);
    function SpeichernStill(out Fehler: string): Int64;
    property GespeicherteId: Int64 read FGespeichert;
  end;

function AdresseEingeben(const Kuerzel: string; Id: Int64): Int64;
function ListeWaehlen(const Titel: string; Anzeige: TStrings; out Index: Integer): Boolean;

implementation

uses
  ubenutzer;

function ListeWaehlen(const Titel: string; Anzeige: TStrings; out Index: Integer): Boolean;
var
  Dialog: TForm;
  Liste: TListBox;
  Ok, Abbruch: TButton;
begin
  Index := -1;
  Result := False;
  if (Anzeige = nil) or (Anzeige.Count = 0) then
  begin
    ShowMessage('Die Liste ist leer.');
    Exit;
  end;
  Dialog := TForm.CreateNew(nil);
  try
    Dialog.Caption := Titel;
    Dialog.Position := poScreenCenter;
    Dialog.Width := 360;
    Dialog.Height := 420;
    Dialog.BorderStyle := bsDialog;
    Liste := TListBox.Create(Dialog);
    Liste.Parent := Dialog;
    Liste.Align := alClient;
    Liste.Items.Assign(Anzeige);
    Liste.ItemIndex := 0;
    Ok := TButton.Create(Dialog);
    Ok.Parent := Dialog;
    Ok.Align := alBottom;
    Ok.Caption := 'Ok';
    Ok.ModalResult := mrOk;
    Abbruch := TButton.Create(Dialog);
    Abbruch.Parent := Dialog;
    Abbruch.Align := alBottom;
    Abbruch.Caption := 'Abbrechen';
    Abbruch.ModalResult := mrCancel;
    Dialog.ActiveControl := Liste;
    if Dialog.ShowModal = mrOk then
    begin
      Index := Liste.ItemIndex;
      Result := Index >= 0;
    end;
  finally
    Dialog.Free;
  end;
end;

function AdresseEingeben(const Kuerzel: string; Id: Int64): Int64;
var
  Fenster: TEingabefenster;
begin
  Fenster := TEingabefenster.Create(Application);
  try
    Fenster.Vorbereiten(Kuerzel, Id);
    if Fenster.ShowModal = mrOk then
      Result := Fenster.GespeicherteId
    else
      Result := 0;
  finally
    Fenster.Free;
  end;
end;

constructor TEingabefenster.Create(TheOwner: TComponent);
begin
  inherited CreateNew(TheOwner, 1);
  Position := poDesigned;
  KeyPreview := True;
  OnKeyDown := @FormKeyDown;

  FTasten := TTastenleiste.Create(Self);
  FTasten.Parent := Self;
  FTasten.Align := alBottom;
  FTasten.Height := 96;
  FTasten.OnTaste := @TasteGedrueckt;

  FFlaeche := TPanel.Create(Self);
  FFlaeche.Parent := Self;
  FFlaeche.Align := alClient;
  FFlaeche.BevelOuter := bvNone;
  FFlaeche.Caption := '';
  FFlaeche.Color := clBtnFace;
end;

function TEingabefenster.IndexVon(Feld: TObject): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to High(FEingaben) do
    if FEingaben[i] = Feld then
      Exit(i);
end;

function TEingabefenster.TextVon(Feld: TControl): string;
begin
  if Feld is TMemo then
    Result := TMemo(Feld).Text
  else if Feld is TEdit then
    Result := TEdit(Feld).Text
  else
    Result := '';
end;

procedure TEingabefenster.TextNach(Feld: TControl; const Wert: string);
begin
  if Feld is TMemo then
    TMemo(Feld).Text := Wert
  else if Feld is TEdit then
    TEdit(Feld).Text := Wert;
end;

procedure TEingabefenster.Vorbereiten(const Kuerzel: string; Id: Int64);
var
  Info: TMaskenInfo;
  Felder: TFeldListe;
  Alt: TStringList;
  i, Sichtbar, Y, FeldLinks, FeldOben, FeldBreite, FeldHoehe: Integer;
  Beschriftung: TLabel;
  Eingabe: TControl;
  Stapel: Boolean;
begin
  FKuerzel := Kuerzel;
  FId := Id;
  FGespeichert := 0;
  if not MaskeLaden(Kuerzel, Info) then
  begin
    Caption := 'Planlos';
    Exit;
  end;
  FBezeichnung := Info.Bezeichnung;
  Caption := 'Adresse';
  Position := poDesigned;
  if Info.Links > 0 then
    Left := Info.Links + 24;
  if Info.Oben > 0 then
    Top := Info.Oben + 24;
  Width := Info.Breite;
  Height := Info.Hoehe;
  if Width < 760 then
    Width := 760;
  if Height < 520 then
    Height := 520;
  Color := clBtnFace;

  while FFlaeche.ControlCount > 0 do
    FFlaeche.Controls[0].Free;
  SetLength(FSpalten, 0);
  SetLength(FArten, 0);
  SetLength(FPflicht, 0);
  SetLength(FEingaben, 0);

  Beschriftung := TLabel.Create(Self);
  Beschriftung.Parent := FFlaeche;
  Beschriftung.Left := 6;
  Beschriftung.Top := 9;
  Beschriftung.Width := 67;
  Beschriftung.Height := 13;
  Beschriftung.Alignment := taRightJustify;
  Beschriftung.AutoSize := False;
  Beschriftung.Caption := 'Nr';
  FNr := TLabel.Create(Self);
  FNr.Parent := FFlaeche;
  FNr.Left := 83;
  FNr.Top := 8;
  FNr.Width := 80;
  FNr.Height := 17;
  FNr.AutoSize := False;
  if Id = 0 then
    FNr.Caption := 'neu'
  else
    FNr.Caption := IntToStr(Id);

  Felder := FelderLaden(Kuerzel);
  Sichtbar := 0;
  for i := 0 to High(Felder) do
    if Felder[i].Sichtbar then
      Inc(Sichtbar);
  SetLength(FSpalten, Sichtbar);
  SetLength(FArten, Sichtbar);
  SetLength(FPflicht, Sichtbar);
  SetLength(FEingaben, Sichtbar);

  Y := 40;
  Sichtbar := 0;
  for i := 0 to High(Felder) do
  begin
    if not Felder[i].Sichtbar then
      Continue;
    Stapel := Felder[i].Feldbreite <= 0;
    if Stapel then
    begin
      FeldLinks := 79;
      FeldOben := Y;
      FeldBreite := 265;
      FeldHoehe := 21;
    end
    else
    begin
      FeldLinks := Felder[i].Links;
      FeldOben := Felder[i].Oben;
      FeldBreite := Felder[i].Feldbreite;
      FeldHoehe := Felder[i].Feldhoehe;
      if FeldHoehe <= 0 then
        FeldHoehe := 21;
    end;

    Beschriftung := TLabel.Create(Self);
    Beschriftung.Parent := FFlaeche;
    Beschriftung.AutoSize := False;
    Beschriftung.Alignment := taRightJustify;
    Beschriftung.Width := 67;
    Beschriftung.Height := 16;
    Beschriftung.Left := FeldLinks - 73;
    if Beschriftung.Left < 0 then
      Beschriftung.Left := 4;
    Beschriftung.Top := FeldOben + 3;
    Beschriftung.Caption := Felder[i].Beschriftung;
    if Felder[i].Pflicht then
      Beschriftung.Caption := Beschriftung.Caption + ' *';
    if Felder[i].Feldart = 'auswahl' then
      Beschriftung.OnClick := @FeldKlick;

    if Felder[i].Feldart = 'memo' then
    begin
      Eingabe := TMemo.Create(Self);
      Eingabe.Parent := FFlaeche;
      TMemo(Eingabe).Left := FeldLinks;
      TMemo(Eingabe).Top := FeldOben;
      TMemo(Eingabe).Width := FeldBreite;
      TMemo(Eingabe).Height := FeldHoehe;
      TMemo(Eingabe).ScrollBars := ssVertical;
    end
    else
    begin
      Eingabe := TEdit.Create(Self);
      Eingabe.Parent := FFlaeche;
      TEdit(Eingabe).Left := FeldLinks;
      TEdit(Eingabe).Top := FeldOben;
      TEdit(Eingabe).Width := FeldBreite;
      TEdit(Eingabe).Height := FeldHoehe;
      if Felder[i].Feldart = 'auswahl' then
      begin
        TEdit(Eingabe).ReadOnly := True;
        TEdit(Eingabe).Color := clSilver;
        TEdit(Eingabe).TabStop := False;
        TEdit(Eingabe).OnClick := @FeldKlick;
        TEdit(Eingabe).Cursor := crHandPoint;
      end
      else if Felder[i].Hintergrund = 'lime' then
        TEdit(Eingabe).Color := clLime;
    end;
    Eingabe.Tag := Sichtbar;
    Beschriftung.Tag := Sichtbar;
    FSpalten[Sichtbar] := Felder[i].Spalte;
    FArten[Sichtbar] := Felder[i].Feldart;
    FPflicht[Sichtbar] := Felder[i].Pflicht;
    FEingaben[Sichtbar] := Eingabe;
    Inc(Sichtbar);
    if Stapel then
      Y := FeldOben + FeldHoehe + 8;
  end;

  if Id > 0 then
  begin
    Alt := TStringList.Create;
    try
      AdresseLesen(Id, Alt);
      for i := 0 to High(FSpalten) do
        if FSpalten[i] = 'kategorie' then
          SetzeWert('kategorie', Alt.Values['kategorie_id'])
        else
          SetzeWert(FSpalten[i], Alt.Values[FSpalten[i]]);
    finally
      Alt.Free;
    end;
  end
  else
    SetzeWert('kategorie', IntToStr(Info.KategorieId));
  TastenAusDaten;
end;

procedure TEingabefenster.TastenAusDaten;
var
  i: Integer;
begin
  FTastenInfo := TastenLaden(FKuerzel, 'eingabe');
  FTasten.AlleBeschriftungenLoeschen;
  for i := 0 to High(FTastenInfo) do
    FTasten.SetzeTaste(FTastenInfo[i].Ebene, FTastenInfo[i].Taste,
      FTastenInfo[i].Beschriftung, FTastenInfo[i].Erlaubt);
end;

function TEingabefenster.HatFeld(const Spalte: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to High(FSpalten) do
    if FSpalten[i] = Spalte then
      Exit(True);
end;

function TEingabefenster.FeldBei(const Spalte: string; Links, Oben: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to High(FSpalten) do
    if FSpalten[i] = Spalte then
      Exit((FEingaben[i].Left = Links) and (FEingaben[i].Top = Oben));
end;

procedure TEingabefenster.SetzeWert(const Spalte, Wert: string);
var
  i, Kategorie: Integer;
begin
  for i := 0 to High(FSpalten) do
    if FSpalten[i] = Spalte then
    begin
      if FArten[i] = 'auswahl' then
      begin
        FEingaben[i].Hint := Wert;
        Kategorie := StrToIntDef(Wert, 0);
        TextNach(FEingaben[i], KategorieName(Kategorie));
      end
      else
        TextNach(FEingaben[i], Wert);
      Exit;
    end;
end;

function TEingabefenster.WerteSammeln: TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 0 to High(FSpalten) do
    if FArten[i] = 'auswahl' then
      Result.Values[FSpalten[i]] := FEingaben[i].Hint
    else
      Result.Values[FSpalten[i]] := TextVon(FEingaben[i]);
end;

function TEingabefenster.SpeichernStill(out Fehler: string): Int64;
var
  Werte: TStringList;
  Aktion: string;
begin
  if FId = 0 then
    Aktion := 'neu'
  else
    Aktion := 'aendern';
  if not AktionZulaessig('maske', FKuerzel, Aktion, Fehler) then
    Exit(0);
  Werte := WerteSammeln;
  try
    Result := AdresseSpeichern(FKuerzel, FId, Werte, Fehler);
    if Result > 0 then
    begin
      FGespeichert := Result;
      FId := Result;
      if FNr <> nil then
        FNr.Caption := IntToStr(Result);
    end;
  finally
    Werte.Free;
  end;
end;

procedure TEingabefenster.AuswahlOeffnen(Index: Integer);
var
  Roh, Namen: TStringList;
  i, Gewaehlt, Kategorie, TabPos: Integer;
  Zeile, Kuerzel, Bisher: string;
  Werte: TStringList;
begin
  if (Index < 0) or (Index > High(FArten)) then
    Exit;
  if FArten[Index] <> 'auswahl' then
    Exit;
  if FSpalten[Index] <> 'kategorie' then
    Exit;
  Roh := TStringList.Create;
  Namen := TStringList.Create;
  try
    KategorienAuflisten(Roh);
    for i := 0 to Roh.Count - 1 do
    begin
      Zeile := Roh[i];
      TabPos := Pos(#9, Zeile);
      if TabPos > 0 then
        Namen.Add(Copy(Zeile, TabPos + 1, 80))
      else
        Namen.Add(Zeile);
    end;
    if not ListeWaehlen('Kategorie aussuchen', Namen, Gewaehlt) then
      Exit;
    Zeile := Roh[Gewaehlt];
    TabPos := Pos(#9, Zeile);
    if TabPos > 0 then
      Kategorie := StrToIntDef(Copy(Zeile, 1, TabPos - 1), 0)
    else
      Kategorie := 0;
    Kuerzel := MaskenKuerzelZuKategorie(Kategorie);
    Bisher := FKuerzel;
    if (Kuerzel <> '') and (Kuerzel <> Bisher) then
    begin
      Werte := WerteSammeln;
      try
        Werte.Values['kategorie'] := IntToStr(Kategorie);
        Vorbereiten(Kuerzel, FId);
        for i := 0 to Werte.Count - 1 do
          SetzeWert(Werte.Names[i], Werte.ValueFromIndex[i]);
      finally
        Werte.Free;
      end;
    end
    else
      SetzeWert('kategorie', IntToStr(Kategorie));
  finally
    Namen.Free;
    Roh.Free;
  end;
end;

procedure TEingabefenster.FeldKlick(Sender: TObject);
var
  Index: Integer;
begin
  Index := -1;
  if Sender is TControl then
    Index := TControl(Sender).Tag;
  if Index < 0 then
    Index := IndexVon(Sender);
  AuswahlOeffnen(Index);
end;

procedure TEingabefenster.AktionAusfuehren(const Aktionsname: string);
var
  Fehler: string;
  Neu, i: Int64;
begin
  if Aktionsname = 'hilfe' then
    ShowMessage(
      'Maske ' + FBezeichnung + '.' + LineEnding +
      'Die Stellen stehen so wie in der alten Adressmaske.' + LineEnding +
      'Ein Feld mit > öffnet eine Liste, per Klick oder mit F4.' + LineEnding +
      'F10 speichert, F12 bricht ab.')
  else if Aktionsname = 'auswahl' then
  begin
    i := -1;
    if ActiveControl <> nil then
      i := IndexVon(ActiveControl);
    if (i < 0) or (FArten[i] <> 'auswahl') then
      for Neu := 0 to High(FArten) do
        if FArten[Neu] = 'auswahl' then
        begin
          i := Neu;
          Break;
        end;
    AuswahlOeffnen(i);
  end
  else if Aktionsname = 'speichern' then
  begin
    Neu := SpeichernStill(Fehler);
    if Neu = 0 then
      ShowMessage(Fehler)
    else
      ModalResult := mrOk;
  end
  else if Aktionsname = 'abbrechen' then
    ModalResult := mrCancel;
end;

procedure TEingabefenster.TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
var
  Aktionsname: string;
  Erlaubt: Boolean;
begin
  if not TasteFinden(FTastenInfo, Ebene, Taste, Aktionsname, Erlaubt) then
    Exit;
  if Erlaubt then
    AktionAusfuehren(Aktionsname);
end;

procedure TEingabefenster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
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
