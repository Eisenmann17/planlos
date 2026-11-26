unit umodulartfenster;

{ Einstellung einer Belegart. Die Reiter folgen der alten Maske,
  ohne die vielen Einzelfelder der Druck- und Spaltenmaske.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, ComCtrls, Dialogs,
  Graphics, LCLType, umodulart;

type
  TModulartFenster = class(TForm)
    Seiten: TPageControl;
    TabFunktion: TTabSheet;
    TabAussehen: TTabSheet;
    TabArtikel: TTabSheet;
    TabDruck: TTabSheet;
    LabelKuerzel: TLabel;
    EditKuerzel: TEdit;
    LabelName: TLabel;
    EditName: TEdit;
    LabelKreis: TLabel;
    EditKreis: TEdit;
    LabelBeschreibung: TLabel;
    EditBeschreibung: TEdit;
    LabelSortierung: TLabel;
    EditSortierung: TEdit;
    CheckAktiv: TCheckBox;
    LabelEmpfaenger: TLabel;
    ComboEmpfaenger: TComboBox;
    LabelBeschriftung: TLabel;
    EditBeschriftung: TEdit;
    CheckNeu: TCheckBox;
    CheckKopieren: TCheckBox;
    CheckAendern: TCheckBox;
    CheckLoeschen: TCheckBox;
    CheckSuchen: TCheckBox;
    CheckSpeichern: TCheckBox;
    CheckAusgabe: TCheckBox;
    LabelLinks: TLabel;
    EditLinks: TEdit;
    LabelOben: TLabel;
    EditOben: TEdit;
    LabelBreite: TLabel;
    EditBreite: TEdit;
    LabelHoehe: TLabel;
    EditHoehe: TEdit;
    CheckKopf: TCheckBox;
    CheckIntern: TCheckBox;
    CheckPositionen: TCheckBox;
    CheckSumme: TCheckBox;
    CheckFuss: TCheckBox;
    CheckKopfAn: TCheckBox;
    CheckInternAn: TCheckBox;
    CheckSummeAn: TCheckBox;
    CheckFussAn: TCheckBox;
    CheckProjekt: TCheckBox;
    CheckInternAdresse: TCheckBox;
    CheckBezeichnung: TCheckBox;
    CheckGruppierung: TCheckBox;
    CheckNotiz: TCheckBox;
    CheckKopfAdresse: TCheckBox;
    CheckNr: TCheckBox;
    CheckDatum: TCheckBox;
    CheckBearbeiter: TCheckBox;
    CheckZeichen: TCheckBox;
    CheckKopftext: TCheckBox;
    CheckFusstext: TCheckBox;
    LabelZeichen: TLabel;
    EditZeichen: TEdit;
    LabelUeberschrift: TLabel;
    EditUeberschrift: TEdit;
    CheckMwst: TCheckBox;
    LabelSatz: TLabel;
    EditSatz: TEdit;
    LabelArtikelHinweis: TLabel;
    LabelVorlage: TLabel;
    ComboVorlage: TComboBox;
    ButtonLayout: TButton;
    PanelKnopf: TPanel;
    LabelEsc: TLabel;
    ButtonAbbrechen: TButton;
    LabelF10: TLabel;
    ButtonSpeichern: TButton;
    procedure FormZeigen(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AbbrechenKlick(Sender: TObject);
    procedure SpeichernKlick(Sender: TObject);
    procedure LayoutKlick(Sender: TObject);
  private
    FId: Int64;
    FVorlagen: array of Int64;
    procedure FelderAusArt(const Art: TBelegartEinstellung);
    procedure ArtAusFeldern(out Art: TBelegartEinstellung);
    procedure VorlagenLaden;
    procedure VorlageWaehlen(Id: Int64);
  end;

function BelegartBearbeiten(Id: Int64): Int64;

implementation

{$R *.lfm}

uses
  udatenbank, udrucklayoutfenster;

function BelegartBearbeiten(Id: Int64): Int64;
var
  Fenster: TModulartFenster;
begin
  Result := 0;
  Fenster := TModulartFenster.Create(Application);
  try
    Fenster.FId := Id;
    if Fenster.ShowModal = mrOk then
      Result := Fenster.FId;
  finally
    Fenster.Free;
  end;
end;

function Ganz(const Text: string; Vorgabe: Integer): Integer;
begin
  Result := StrToIntDef(Trim(Text), Vorgabe);
end;

procedure TModulartFenster.VorlagenLaden;
var
  Spalten, Zeilen: TStringList;
  i, Tab: Integer;
  Zeile, Titel: string;
  Id: Int64;
begin
  ComboVorlage.Items.Clear;
  ComboVorlage.Items.Add('(keine)');
  SetLength(FVorlagen, 1);
  FVorlagen[0] := 0;
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  try
    PlanlosDB.AlleZeilen(
      'SELECT id, bezeichnung FROM druckvorlage ORDER BY bezeichnung, id',
      nil, Spalten, Zeilen);
    for i := 0 to Zeilen.Count - 1 do
    begin
      Zeile := Zeilen[i];
      Tab := Pos(#9, Zeile);
      Id := StrToInt64Def(Copy(Zeile, 1, Tab - 1), 0);
      Titel := Copy(Zeile, Tab + 1, MaxInt);
      ComboVorlage.Items.Add(Titel);
      SetLength(FVorlagen, Length(FVorlagen) + 1);
      FVorlagen[High(FVorlagen)] := Id;
    end;
  finally
    Zeilen.Free;
    Spalten.Free;
  end;
end;

procedure TModulartFenster.VorlageWaehlen(Id: Int64);
var
  i: Integer;
begin
  ComboVorlage.ItemIndex := 0;
  for i := 0 to High(FVorlagen) do
    if FVorlagen[i] = Id then
    begin
      ComboVorlage.ItemIndex := i;
      Exit;
    end;
end;

procedure TModulartFenster.LayoutKlick(Sender: TObject);
var
  Bisher, Neu: Int64;
begin
  if (ComboVorlage.ItemIndex < 0) or
     (ComboVorlage.ItemIndex > High(FVorlagen)) then
    Exit;
  Bisher := FVorlagen[ComboVorlage.ItemIndex];
  if Bisher = 0 then
  begin
    ShowMessage('Bitte zuerst eine Druckvorlage auswählen.');
    Exit;
  end;
  if DrucklayoutBearbeiten(FId, Bisher, Neu) then
  begin
    VorlagenLaden;
    VorlageWaehlen(Neu);
  end;
end;

procedure TModulartFenster.FelderAusArt(const Art: TBelegartEinstellung);
var
  i: Integer;
begin
  EditKuerzel.Text := Art.Kuerzel;
  EditName.Text := Art.Bezeichnung;
  EditKreis.Text := Art.Nummernkreis;
  EditBeschreibung.Text := Art.Beschreibung;
  EditSortierung.Text := IntToStr(Art.Sortierung);
  CheckAktiv.Checked := Art.Aktiv;
  ComboEmpfaenger.ItemIndex := ComboEmpfaenger.Items.IndexOf(Art.EmpfaengerMaske);
  if ComboEmpfaenger.ItemIndex < 0 then
    ComboEmpfaenger.ItemIndex := 0;
  EditBeschriftung.Text := Art.BeschriftungEmpfaenger;
  CheckNeu.Checked := Art.Neu;
  CheckKopieren.Checked := Art.Kopieren;
  CheckAendern.Checked := Art.Aendern;
  CheckLoeschen.Checked := Art.Loeschen;
  CheckSuchen.Checked := Art.Suchen;
  CheckSpeichern.Checked := Art.Speichern;
  CheckAusgabe.Checked := Art.Ausgabe;
  EditLinks.Text := IntToStr(Art.Links);
  EditOben.Text := IntToStr(Art.Oben);
  EditBreite.Text := IntToStr(Art.Breite);
  EditHoehe.Text := IntToStr(Art.Hoehe);
  CheckKopf.Checked := Art.Kopf;
  CheckIntern.Checked := Art.Intern;
  CheckPositionen.Checked := Art.Positionen;
  CheckSumme.Checked := Art.Summe;
  CheckFuss.Checked := Art.Fuss;
  CheckKopfAn.Checked := Art.KopfAn;
  CheckInternAn.Checked := Art.InternAn;
  CheckSummeAn.Checked := Art.SummeAn;
  CheckFussAn.Checked := Art.FussAn;
  CheckProjekt.Checked := Art.ZeigeProjekt;
  CheckInternAdresse.Checked := Art.ZeigeInternAdresse;
  CheckBezeichnung.Checked := Art.ZeigeBezeichnung;
  CheckGruppierung.Checked := Art.ZeigeGruppierung;
  CheckNotiz.Checked := Art.ZeigeNotiz;
  CheckKopfAdresse.Checked := Art.ZeigeKopfAdresse;
  CheckNr.Checked := Art.ZeigeNr;
  CheckDatum.Checked := Art.ZeigeDatum;
  CheckBearbeiter.Checked := Art.ZeigeBearbeiter;
  CheckZeichen.Checked := Art.ZeigeZeichen;
  CheckKopftext.Checked := Art.ZeigeKopftext;
  CheckFusstext.Checked := Art.ZeigeFusstext;
  EditZeichen.Text := Art.ZeichenText;
  EditUeberschrift.Text := Art.ArtikelUeberschrift;
  CheckMwst.Checked := Art.Mwst;
  EditSatz.Text := IntToStr(Art.MwstSatz);
  ComboVorlage.ItemIndex := 0;
  for i := 0 to High(FVorlagen) do
    if FVorlagen[i] = Art.DruckvorlageId then
      ComboVorlage.ItemIndex := i;
end;

procedure TModulartFenster.ArtAusFeldern(out Art: TBelegartEinstellung);
begin
  Art := Default(TBelegartEinstellung);
  Art.Id := FId;
  Art.Kuerzel := Trim(EditKuerzel.Text);
  Art.Bezeichnung := Trim(EditName.Text);
  Art.Nummernkreis := Trim(EditKreis.Text);
  Art.Beschreibung := Trim(EditBeschreibung.Text);
  Art.Sortierung := Ganz(EditSortierung.Text, 0);
  Art.Aktiv := CheckAktiv.Checked;
  if ComboEmpfaenger.ItemIndex <= 0 then
    Art.EmpfaengerMaske := ''
  else
    Art.EmpfaengerMaske := ComboEmpfaenger.Text;
  Art.BeschriftungEmpfaenger := Trim(EditBeschriftung.Text);
  Art.Neu := CheckNeu.Checked;
  Art.Kopieren := CheckKopieren.Checked;
  Art.Aendern := CheckAendern.Checked;
  Art.Loeschen := CheckLoeschen.Checked;
  Art.Suchen := CheckSuchen.Checked;
  Art.Speichern := CheckSpeichern.Checked;
  Art.Ausgabe := CheckAusgabe.Checked;
  Art.Links := Ganz(EditLinks.Text, 50);
  Art.Oben := Ganz(EditOben.Text, 50);
  Art.Breite := Ganz(EditBreite.Text, 793);
  Art.Hoehe := Ganz(EditHoehe.Text, 660);
  Art.Kopf := CheckKopf.Checked;
  Art.Intern := CheckIntern.Checked;
  Art.Positionen := CheckPositionen.Checked;
  Art.Summe := CheckSumme.Checked;
  Art.Fuss := CheckFuss.Checked;
  Art.KopfAn := CheckKopfAn.Checked;
  Art.InternAn := CheckInternAn.Checked;
  Art.SummeAn := CheckSummeAn.Checked;
  Art.FussAn := CheckFussAn.Checked;
  Art.ZeigeProjekt := CheckProjekt.Checked;
  Art.ZeigeInternAdresse := CheckInternAdresse.Checked;
  Art.ZeigeBezeichnung := CheckBezeichnung.Checked;
  Art.ZeigeGruppierung := CheckGruppierung.Checked;
  Art.ZeigeNotiz := CheckNotiz.Checked;
  Art.ZeigeKopfAdresse := CheckKopfAdresse.Checked;
  Art.ZeigeNr := CheckNr.Checked;
  Art.ZeigeDatum := CheckDatum.Checked;
  Art.ZeigeBearbeiter := CheckBearbeiter.Checked;
  Art.ZeigeZeichen := CheckZeichen.Checked;
  Art.ZeigeKopftext := CheckKopftext.Checked;
  Art.ZeigeFusstext := CheckFusstext.Checked;
  Art.ZeichenText := Trim(EditZeichen.Text);
  Art.ArtikelUeberschrift := Trim(EditUeberschrift.Text);
  Art.Mwst := CheckMwst.Checked;
  Art.MwstSatz := Ganz(EditSatz.Text, 19);
  if (ComboVorlage.ItemIndex >= 0) and
     (ComboVorlage.ItemIndex <= High(FVorlagen)) then
    Art.DruckvorlageId := FVorlagen[ComboVorlage.ItemIndex];
end;

procedure TModulartFenster.FormZeigen(Sender: TObject);
var
  Art: TBelegartEinstellung;
begin
  VorlagenLaden;
  if FId = 0 then
  begin
    Caption := 'Belegart neu';
    Art := Default(TBelegartEinstellung);
    Art.Aktiv := True;
    Art.Links := 50;
    Art.Oben := 50;
    Art.Breite := 793;
    Art.Hoehe := 660;
    Art.Kopf := True;
    Art.Intern := True;
    Art.Positionen := True;
    Art.Summe := True;
    Art.Fuss := True;
    Art.KopfAn := True;
    Art.InternAn := True;
    Art.SummeAn := True;
    Art.FussAn := True;
    Art.ZeigeProjekt := True;
    Art.ZeigeInternAdresse := True;
    Art.ZeigeBezeichnung := True;
    Art.ZeigeGruppierung := True;
    Art.ZeigeNotiz := True;
    Art.ZeigeKopfAdresse := True;
    Art.ZeigeNr := True;
    Art.ZeigeDatum := True;
    Art.ZeigeBearbeiter := True;
    Art.ZeigeZeichen := True;
    Art.ZeigeKopftext := True;
    Art.ZeigeFusstext := True;
    Art.ZeichenText := 'Ihr Zeichen:';
    Art.Neu := True;
    Art.Kopieren := True;
    Art.Aendern := True;
    Art.Loeschen := True;
    Art.Suchen := True;
    Art.Speichern := True;
    Art.Ausgabe := True;
    Art.Mwst := True;
    Art.MwstSatz := 19;
    if Length(FVorlagen) > 1 then
      Art.DruckvorlageId := FVorlagen[1];
    FelderAusArt(Art);
    EditKuerzel.SetFocus;
    Exit;
  end;
  if not BelegartEinstellungLaden(FId, Art) then
  begin
    ShowMessage('Die Belegart wurde nicht gefunden.');
    ModalResult := mrCancel;
    Exit;
  end;
  Caption := 'Belegart ' + Art.Bezeichnung;
  FelderAusArt(Art);
end;

procedure TModulartFenster.SpeichernKlick(Sender: TObject);
var
  Art: TBelegartEinstellung;
  Fehler: string;
begin
  ArtAusFeldern(Art);
  FId := BelegartEinstellungSpeichern(Art, Fehler);
  if FId = 0 then
    ShowMessage(Fehler)
  else
    ModalResult := mrOk;
end;

procedure TModulartFenster.AbbrechenKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TModulartFenster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) or (Key = VK_F12) then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end
  else if (Key = VK_F10) or (Key = VK_RETURN) then
  begin
    SpeichernKlick(nil);
    Key := 0;
  end;
end;

end.
