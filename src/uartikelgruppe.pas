unit uartikelgruppe;

{ Artikelgruppe nach der alten Maske.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Graphics,
  LCLType, uartikel;

type
  TGruppenFenster = class(TForm)
    LabelName: TLabel;
    EditName: TEdit;
    LabelBerechnung: TLabel;
    EditBerechnung: TEdit;
    GroupKosten: TGroupBox;
    RadioMaterial: TRadioButton;
    RadioDienst: TRadioButton;
    RadioFremd: TRadioButton;
    RadioSonstig: TRadioButton;
    GroupVorgabe: TGroupBox;
    CheckMengeWieEk: TCheckBox;
    LabelVArtikel: TLabel;
    EditVArtikel: TEdit;
    LabelVMenge: TLabel;
    EditVMenge: TEdit;
    LabelVEk: TLabel;
    EditVEk: TEdit;
    LabelVEinheitEk: TLabel;
    EditVEinheitEk: TEdit;
    LabelVAufschlag: TLabel;
    EditVAufschlag: TEdit;
    LabelVProzent: TLabel;
    LabelVLieferant: TLabel;
    EditVLieferant: TEdit;
    GroupZeigen: TGroupBox;
    CheckGewicht: TCheckBox;
    CheckPostext: TCheckBox;
    CheckZahl1: TCheckBox;
    CheckZahl2: TCheckBox;
    CheckZahl3: TCheckBox;
    CheckLieferant: TCheckBox;
    CheckLieferantNr: TCheckBox;
    CheckBestand: TCheckBox;
    CheckMinBestand: TCheckBox;
    CheckName1: TCheckBox;
    CheckName2: TCheckBox;
    CheckName3: TCheckBox;
    PanelKnopf: TPanel;
    LabelEsc: TLabel;
    ButtonAbbrechen: TButton;
    LabelF4: TLabel;
    ButtonSuchen: TButton;
    LabelReturn: TLabel;
    ButtonSpeichern: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormZeigen(Sender: TObject);
    procedure AbbrechenKlick(Sender: TObject);
    procedure SpeichernKlick(Sender: TObject);
    procedure SucheKlick(Sender: TObject);
    procedure FeldBetreten(Sender: TObject);
    procedure MengeWieEkKlick(Sender: TObject);
  private
    FId: Int64;
    procedure MengeZeigen;
    procedure Suchen(Sender: TObject);
    function Kostenart: string;
    procedure KostenartSetzen(const Art: string);
  end;

function GruppeBearbeiten(Id: Int64): Int64;

implementation

{$R *.lfm}

uses
  usuche;

function GruppeBearbeiten(Id: Int64): Int64;
var
  Fenster: TGruppenFenster;
begin
  Result := 0;
  Fenster := TGruppenFenster.Create(Application);
  try
    Fenster.FId := Id;
    if Fenster.ShowModal = mrOk then
      Result := Fenster.FId;
  finally
    Fenster.Free;
  end;
end;

function TGruppenFenster.Kostenart: string;
begin
  if RadioDienst.Checked then
    Result := 'D'
  else if RadioFremd.Checked then
    Result := 'F'
  else if RadioSonstig.Checked then
    Result := 'S'
  else
    Result := 'M';
end;

procedure TGruppenFenster.KostenartSetzen(const Art: string);
begin
  RadioDienst.Checked := Art = 'D';
  RadioFremd.Checked := Art = 'F';
  RadioSonstig.Checked := Art = 'S';
  RadioMaterial.Checked := not (RadioDienst.Checked or RadioFremd.Checked or
    RadioSonstig.Checked);
end;

procedure TGruppenFenster.MengeZeigen;
begin
  LabelVMenge.Visible := not CheckMengeWieEk.Checked;
  EditVMenge.Visible := LabelVMenge.Visible;
end;

procedure TGruppenFenster.MengeWieEkKlick(Sender: TObject);
begin
  MengeZeigen;
end;

procedure TGruppenFenster.FormZeigen(Sender: TObject);
var
  Gruppe: TArtikelGruppe;
begin
  if FId = 0 then
  begin
    Caption := 'Artikelgruppe neu';
    CheckMengeWieEk.Checked := True;
    MengeZeigen;
    Exit;
  end;
  if not GruppeLaden(FId, Gruppe) then
  begin
    ShowMessage('Die Artikelgruppe wurde nicht gefunden.');
    ModalResult := mrCancel;
    Exit;
  end;
  EditName.Text := Gruppe.Bezeichnung;
  EditBerechnung.Text := Gruppe.Berechnungsart;
  KostenartSetzen(Gruppe.Kostenart);
  CheckMengeWieEk.Checked := Gruppe.EinheitMengeWieEk;
  EditVArtikel.Text := Gruppe.VorgabeArtikel;
  EditVMenge.Text := Gruppe.VorgabeEinheitMenge;
  EditVEk.Text := TextAusCent(Gruppe.VorgabeEkCent);
  EditVEinheitEk.Text := Gruppe.VorgabeEinheitEk;
  EditVAufschlag.Text := TextAusAufschlag(Gruppe.VorgabeAufschlagBp);
  EditVLieferant.Text := Gruppe.VorgabeLieferant;
  CheckGewicht.Checked := Gruppe.SichtbarGewicht;
  CheckPostext.Checked := Gruppe.SichtbarPostext;
  CheckZahl1.Checked := Gruppe.SichtbarZahl1;
  CheckZahl2.Checked := Gruppe.SichtbarZahl2;
  CheckZahl3.Checked := Gruppe.SichtbarZahl3;
  CheckLieferant.Checked := Gruppe.SichtbarLieferant;
  CheckLieferantNr.Checked := Gruppe.SichtbarLieferantNr;
  CheckBestand.Checked := Gruppe.SichtbarBestand;
  CheckMinBestand.Checked := Gruppe.SichtbarMinBestand;
  CheckName1.Checked := Gruppe.SichtbarName1;
  CheckName2.Checked := Gruppe.SichtbarName2;
  CheckName3.Checked := Gruppe.SichtbarName3;
  MengeZeigen;
end;

procedure TGruppenFenster.FeldBetreten(Sender: TObject);
begin
  ButtonSuchen.Enabled := True;
end;

procedure TGruppenFenster.Suchen(Sender: TObject);
var
  Id: Int64;
  Ziel: TWinControl;
begin
  Ziel := ActiveControl;
  if Sender = LabelBerechnung then
    Ziel := EditBerechnung
  else if Sender = LabelVMenge then
    Ziel := EditVMenge
  else if Sender = LabelVEinheitEk then
    Ziel := EditVEinheitEk
  else if Sender = LabelVLieferant then
    Ziel := EditVLieferant;
  if (Ziel <> nil) and (Sender is TLabel) then
    Ziel.SetFocus;
  if Ziel = EditBerechnung then
  begin
    if ListenWahl('berechnungsart', False, Id) then
      EditBerechnung.Text := StammBezeichnung('berechnungsart', Id);
  end
  else if (Ziel = EditVMenge) or (Ziel = EditVEinheitEk) then
  begin
    if ListenWahl('einheit', False, Id) then
      TEdit(Ziel).Text := StammBezeichnung('einheit', Id);
  end
  else if Ziel = EditVLieferant then
  begin
    if ListenWahl('lieferant', False, Id) then
      EditVLieferant.Text := StammBezeichnung('lieferant', Id);
  end;
end;

procedure TGruppenFenster.SucheKlick(Sender: TObject);
begin
  Suchen(Sender);
end;

procedure TGruppenFenster.AbbrechenKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TGruppenFenster.SpeichernKlick(Sender: TObject);
var
  Gruppe: TArtikelGruppe;
  Fehler: string;
  Cent: Int64;
  Bp: Integer;
begin
  if FId > 0 then
    GruppeLaden(FId, Gruppe)
  else
    Gruppe := Default(TArtikelGruppe);
  Gruppe.Id := FId;
  Gruppe.Bezeichnung := Trim(EditName.Text);
  Gruppe.Berechnungsart := Trim(EditBerechnung.Text);
  Gruppe.Kostenart := Kostenart;
  Gruppe.EinheitMengeWieEk := CheckMengeWieEk.Checked;
  Gruppe.VorgabeArtikel := Trim(EditVArtikel.Text);
  if not CentAusText(EditVEk.Text, Cent) then
  begin
    ShowMessage('Der EK-Preis muss eine Zahl sein.');
    Exit;
  end;
  Gruppe.VorgabeEkCent := Cent;
  if not AufschlagAusText(EditVAufschlag.Text, Bp) then
  begin
    ShowMessage('Der Aufschlag muss eine Zahl sein.');
    Exit;
  end;
  Gruppe.VorgabeAufschlagBp := Bp;
  Gruppe.AufschlagBp := Bp;
  if CheckMengeWieEk.Checked then
    Gruppe.VorgabeEinheitMenge := Trim(EditVEinheitEk.Text)
  else
    Gruppe.VorgabeEinheitMenge := Trim(EditVMenge.Text);
  Gruppe.VorgabeEinheitEk := Trim(EditVEinheitEk.Text);
  Gruppe.VorgabeLieferant := Trim(EditVLieferant.Text);
  Gruppe.SichtbarGewicht := CheckGewicht.Checked;
  Gruppe.SichtbarPostext := CheckPostext.Checked;
  Gruppe.SichtbarZahl1 := CheckZahl1.Checked;
  Gruppe.SichtbarZahl2 := CheckZahl2.Checked;
  Gruppe.SichtbarZahl3 := CheckZahl3.Checked;
  Gruppe.SichtbarLieferant := CheckLieferant.Checked;
  Gruppe.SichtbarLieferantNr := CheckLieferantNr.Checked;
  Gruppe.SichtbarBestand := CheckBestand.Checked;
  Gruppe.SichtbarMinBestand := CheckMinBestand.Checked;
  Gruppe.SichtbarName1 := CheckName1.Checked;
  Gruppe.SichtbarName2 := CheckName2.Checked;
  Gruppe.SichtbarName3 := CheckName3.Checked;
  FId := GruppeSpeichern(Gruppe, Fehler);
  if FId = 0 then
    ShowMessage(Fehler)
  else
    ModalResult := mrOk;
end;

procedure TGruppenFenster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end
  else if Key = VK_F4 then
  begin
    Suchen(nil);
    Key := 0;
  end
  else if (Key = VK_RETURN) or (Key = VK_F10) then
  begin
    SpeichernKlick(nil);
    Key := 0;
  end
  else if Key = VK_F12 then
    Key := 0;
end;

end.
