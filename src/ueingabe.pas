unit ueingabe;

{ Das eine Eingabefenster für Adressen. Das Aussehen steht in
  ueingabe.lfm, nach der alten UnitAdresse.dfm. Welche Felder
  sichtbar sind, entscheidet weiter die Maske in der Datenbank.
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
    LabelNr: TLabel;
    LabelNrWert: TLabel;
    LabelKategorie: TLabel;
    LabelNachname: TLabel;
    LabelVorname: TLabel;
    LabelTitel: TLabel;
    LabelFirma: TLabel;
    LabelTelFirma: TLabel;
    LabelTelPrivat: TLabel;
    LabelTelFax: TLabel;
    LabelTelAndere: TLabel;
    LabelEMail: TLabel;
    LabelStrasse: TLabel;
    LabelPLZ: TLabel;
    LabelOrt: TLabel;
    LabelLand: TLabel;
    LabelNotiz: TLabel;
    LabelAdresse: TLabel;
    LabelFrei1: TLabel;
    LabelFrei2: TLabel;
    LabelFrei3: TLabel;
    LabelFrei4: TLabel;
    LabelRabatt: TLabel;
    EditKategorie: TEdit;
    EditNachname: TEdit;
    EditVorname: TEdit;
    EditTitel: TEdit;
    EditFirma: TEdit;
    EditTelFirma: TEdit;
    EditTelPrivat: TEdit;
    EditTelFax: TEdit;
    EditTelAndere: TEdit;
    EditEMail: TEdit;
    EditStrasse: TEdit;
    EditPLZ: TEdit;
    EditOrt: TEdit;
    EditLand: TEdit;
    MemoNotiz: TMemo;
    MemoAdresse: TMemo;
    EditFrei1: TEdit;
    EditFrei2: TEdit;
    EditFrei3: TEdit;
    EditFrei4: TEdit;
    EditRabatt: TEdit;
    PanelTasten: TPanel;
    ButtonAbbrechen: TButton;
    ButtonSuchen: TButton;
    ButtonOk: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KategorieKlick(Sender: TObject);
    procedure AbbruchKlick(Sender: TObject);
    procedure SuchenKlick(Sender: TObject);
    procedure OkKlick(Sender: TObject);
  private
    FTasten: TTastenleiste;
    FKuerzel: string;
    FBezeichnung: string;
    FId: Int64;
    FGespeichert: Int64;
    FTastenInfo: TTastenListe;
    FSpalten: array of string;
    FArten: array of string;
    FEingaben: array of TControl;
    FBeschriftungen: array of TLabel;
    FGrundtext: array of string;
    procedure SteuerungBinden;
    procedure Merke(const Spalte, Art: string; Eingabe: TControl; Beschriftung: TLabel);
    procedure TasteGedrueckt(Sender: TObject; Ebene, Taste: Integer);
    procedure TastenAusDaten;
    procedure AktionAusfuehren(const Aktionsname: string);
    procedure AuswahlOeffnen;
    function IndexVon(const Spalte: string): Integer;
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

{$R *.lfm}

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
  inherited Create(TheOwner);
  FTasten := TTastenleiste.Create(Self);
  FTasten.Parent := PanelTasten;
  FTasten.Align := alBottom;
  FTasten.Height := 84;
  FTasten.OnTaste := @TasteGedrueckt;
  SteuerungBinden;
end;

procedure TEingabefenster.Merke(const Spalte, Art: string; Eingabe: TControl;
  Beschriftung: TLabel);
var
  n: Integer;
begin
  n := Length(FSpalten);
  SetLength(FSpalten, n + 1);
  SetLength(FArten, n + 1);
  SetLength(FEingaben, n + 1);
  SetLength(FBeschriftungen, n + 1);
  SetLength(FGrundtext, n + 1);
  FSpalten[n] := Spalte;
  FArten[n] := Art;
  FEingaben[n] := Eingabe;
  FBeschriftungen[n] := Beschriftung;
  if Beschriftung <> nil then
    FGrundtext[n] := Beschriftung.Caption
  else
    FGrundtext[n] := '';
end;

procedure TEingabefenster.SteuerungBinden;
begin
  SetLength(FSpalten, 0);
  Merke('kategorie', 'auswahl', EditKategorie, LabelKategorie);
  Merke('nachname', 'zeile', EditNachname, LabelNachname);
  Merke('vorname', 'zeile', EditVorname, LabelVorname);
  Merke('titel', 'zeile', EditTitel, LabelTitel);
  Merke('firma', 'zeile', EditFirma, LabelFirma);
  Merke('telefon', 'zeile', EditTelFirma, LabelTelFirma);
  Merke('telefon_privat', 'zeile', EditTelPrivat, LabelTelPrivat);
  Merke('telefax', 'zeile', EditTelFax, LabelTelFax);
  Merke('telefon_andere', 'zeile', EditTelAndere, LabelTelAndere);
  Merke('email', 'zeile', EditEMail, LabelEMail);
  Merke('strasse', 'zeile', EditStrasse, LabelStrasse);
  Merke('plz', 'zeile', EditPLZ, LabelPLZ);
  Merke('ort', 'zeile', EditOrt, LabelOrt);
  Merke('land', 'zeile', EditLand, LabelLand);
  Merke('notiz', 'memo', MemoNotiz, LabelNotiz);
  Merke('adressblock', 'memo', MemoAdresse, LabelAdresse);
  Merke('frei1', 'zeile', EditFrei1, LabelFrei1);
  Merke('frei2', 'zeile', EditFrei2, LabelFrei2);
  Merke('frei3', 'zeile', EditFrei3, LabelFrei3);
  Merke('frei4', 'zeile', EditFrei4, LabelFrei4);
  Merke('rabatt_prozent', 'zeile', EditRabatt, LabelRabatt);
end;

function TEingabefenster.IndexVon(const Spalte: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to High(FSpalten) do
    if FSpalten[i] = Spalte then
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
  i, n: Integer;
begin
  FKuerzel := Kuerzel;
  FId := Id;
  FGespeichert := 0;
  for i := 0 to High(FEingaben) do
  begin
    FEingaben[i].Visible := False;
    if FBeschriftungen[i] <> nil then
    begin
      FBeschriftungen[i].Visible := False;
      FBeschriftungen[i].Caption := FGrundtext[i];
    end;
  end;
  if Id = 0 then
    LabelNrWert.Caption := 'neu'
  else
    LabelNrWert.Caption := IntToStr(Id);
  if not MaskeLaden(Kuerzel, Info) then
  begin
    Caption := 'Adresse';
    Exit;
  end;
  FBezeichnung := Info.Bezeichnung;
  Caption := 'Adresse';
  Felder := FelderLaden(Kuerzel);
  for i := 0 to High(Felder) do
  begin
    if not Felder[i].Sichtbar then
      Continue;
    n := IndexVon(Felder[i].Spalte);
    if n < 0 then
      Continue;
    FEingaben[n].Visible := True;
    if FBeschriftungen[n] <> nil then
    begin
      FBeschriftungen[n].Visible := True;
      if Felder[i].Pflicht then
        FBeschriftungen[n].Caption := FGrundtext[n] + ' *';
    end;
  end;
  if Id > 0 then
  begin
    Alt := TStringList.Create;
    try
      AdresseLesen(Id, Alt);
      for i := 0 to High(FSpalten) do
        if FEingaben[i].Visible then
        begin
          if FSpalten[i] = 'kategorie' then
            SetzeWert('kategorie', Alt.Values['kategorie_id'])
          else
            SetzeWert(FSpalten[i], Alt.Values[FSpalten[i]]);
        end;
    finally
      Alt.Free;
    end;
  end
  else if EditKategorie.Visible then
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
  n: Integer;
begin
  n := IndexVon(Spalte);
  Result := (n >= 0) and FEingaben[n].Visible;
end;

function TEingabefenster.FeldBei(const Spalte: string; Links, Oben: Integer): Boolean;
var
  n: Integer;
begin
  n := IndexVon(Spalte);
  Result := (n >= 0) and (FEingaben[n].Left = Links) and (FEingaben[n].Top = Oben);
end;

procedure TEingabefenster.SetzeWert(const Spalte, Wert: string);
var
  n, Kategorie: Integer;
begin
  n := IndexVon(Spalte);
  if n < 0 then
    Exit;
  if FArten[n] = 'auswahl' then
  begin
    FEingaben[n].Hint := Wert;
    Kategorie := StrToIntDef(Wert, 0);
    TextNach(FEingaben[n], KategorieName(Kategorie));
  end
  else
    TextNach(FEingaben[n], Wert);
end;

function TEingabefenster.WerteSammeln: TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 0 to High(FSpalten) do
    if FEingaben[i].Visible then
    begin
      if FArten[i] = 'auswahl' then
        Result.Values[FSpalten[i]] := FEingaben[i].Hint
      else
        Result.Values[FSpalten[i]] := TextVon(FEingaben[i]);
    end;
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
      LabelNrWert.Caption := IntToStr(Result);
    end;
  finally
    Werte.Free;
  end;
end;

procedure TEingabefenster.AuswahlOeffnen;
var
  Roh, Namen: TStringList;
  i, Gewaehlt, Kategorie, TabPos: Integer;
  Zeile, Kuerzel, Bisher: string;
  Werte: TStringList;
begin
  if not EditKategorie.Visible then
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

procedure TEingabefenster.KategorieKlick(Sender: TObject);
begin
  AuswahlOeffnen;
end;

procedure TEingabefenster.SuchenKlick(Sender: TObject);
begin
  AuswahlOeffnen;
end;

procedure TEingabefenster.AbbruchKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TEingabefenster.OkKlick(Sender: TObject);
begin
  AktionAusfuehren('speichern');
end;

procedure TEingabefenster.AktionAusfuehren(const Aktionsname: string);
var
  Fehler: string;
  Neu: Int64;
begin
  if Aktionsname = 'hilfe' then
    ShowMessage(
      'Maske ' + FBezeichnung + '.' + LineEnding +
      'Die Stellen stehen in der Formulardatei und lassen sich im' + LineEnding +
      'Lazarus-Designer ändern.' + LineEnding +
      'Ein Feld mit > öffnet eine Liste, per Klick oder mit F4.' + LineEnding +
      'F10 speichert, F12 bricht ab.')
  else if Aktionsname = 'auswahl' then
    AuswahlOeffnen
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
