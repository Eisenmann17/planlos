unit uartikelfenster;

{ Artikelerfassung nach der alten Maske UnitArtikel.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Graphics,
  LCLType, uartikel;

type
  TArtikelFenster = class(TForm)
    LabelGruppe: TLabel;
    EditGruppe: TEdit;
    LabelArtikel: TLabel;
    EditArtikel: TEdit;
    LabelEinheitMenge: TLabel;
    EditEinheitMenge: TEdit;
    LabelEk: TLabel;
    EditEk: TEdit;
    LabelEinheitEk: TLabel;
    EditEinheitEk: TEdit;
    LabelAufschlag: TLabel;
    EditAufschlag: TEdit;
    LabelProzent: TLabel;
    LabelMwst: TLabel;
    EditMwst: TEdit;
    MemoPos: TMemo;
    LabelGewicht: TLabel;
    EditGewicht: TEdit;
    LabelZahl1: TLabel;
    EditZahl1: TEdit;
    LabelZahl2: TLabel;
    EditZahl2: TEdit;
    LabelZahl3: TLabel;
    EditZahl3: TEdit;
    LabelLieferant: TLabel;
    EditLieferant: TEdit;
    LabelLieferantNr: TLabel;
    EditLieferantNr: TEdit;
    LabelBestand: TLabel;
    EditBestand: TEdit;
    LabelMinBestand: TLabel;
    EditMinBestand: TEdit;
    LabelName1: TLabel;
    EditName1: TEdit;
    LabelName2: TLabel;
    EditName2: TEdit;
    LabelName3: TLabel;
    EditName3: TEdit;
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
  private
    FId: Int64;
    FGruppeId: Int64;
    FNeu: Boolean;
    procedure GruppeAnwenden(const Gruppe: TArtikelGruppe; Vorgaben: Boolean);
    procedure SichtSetzen(const Gruppe: TArtikelGruppe; Alle: Boolean);
    procedure Suchen(Sender: TObject);
  end;

function ArtikelBearbeiten(Id: Int64): Int64;

implementation

{$R *.lfm}

uses
  usuche, udatenbank;

function ArtikelBearbeiten(Id: Int64): Int64;
var
  Fenster: TArtikelFenster;
begin
  Result := 0;
  Fenster := TArtikelFenster.Create(Application);
  try
    Fenster.FId := Id;
    Fenster.FNeu := Id = 0;
    if Fenster.ShowModal = mrOk then
      Result := Fenster.FId;
  finally
    Fenster.Free;
  end;
end;

procedure TArtikelFenster.FormZeigen(Sender: TObject);
var
  Artikel: TArtikel;
  Gruppe: TArtikelGruppe;
begin
  if FNeu then
  begin
    Caption := 'Artikel neu';
    if (PlanlosDB <> nil) and PlanlosDB.Verbunden then
      EditMwst.Text := PlanlosDB.ParameterLesen('mwst_satz', '19')
    else
      EditMwst.Text := '19';
    SichtSetzen(Default(TArtikelGruppe), True);
    Exit;
  end;
  if not ArtikelLaden(FId, Artikel) then
  begin
    ShowMessage('Der Artikel wurde nicht gefunden.');
    ModalResult := mrCancel;
    Exit;
  end;
  Caption := 'Artikel';
  FGruppeId := Artikel.GruppeId;
  EditGruppe.Text := Artikel.Gruppe;
  EditArtikel.Text := Artikel.Bezeichnung;
  EditEinheitMenge.Text := Artikel.EinheitMenge;
  EditEk.Text := TextAusCent(Artikel.EkCent);
  EditEinheitEk.Text := Artikel.EinheitEk;
  EditAufschlag.Text := TextAusAufschlag(Artikel.AufschlagBp);
  EditMwst.Text := IntToStr(Artikel.MwstSatz);
  EditGewicht.Text := TextAusMilli(Artikel.GewichtMilli);
  EditZahl1.Text := TextAusMilli(Artikel.Zahl1Milli);
  EditZahl2.Text := TextAusMilli(Artikel.Zahl2Milli);
  EditZahl3.Text := TextAusMilli(Artikel.Zahl3Milli);
  EditLieferant.Text := Artikel.Lieferant;
  EditLieferantNr.Text := Artikel.LieferantNr;
  MemoPos.Text := Artikel.PosText;
  EditBestand.Text := TextAusMilli(Artikel.BestandMilli);
  EditMinBestand.Text := TextAusMilli(Artikel.MinBestandMilli);
  EditName1.Text := Artikel.Name1;
  EditName2.Text := Artikel.Name2;
  EditName3.Text := Artikel.Name3;
  if GruppeLaden(FGruppeId, Gruppe) then
    SichtSetzen(Gruppe, False)
  else
    SichtSetzen(Default(TArtikelGruppe), True);
end;

procedure TArtikelFenster.SichtSetzen(const Gruppe: TArtikelGruppe; Alle: Boolean);
  procedure Paar(An: Boolean; ALabel: TLabel; AEdit: TControl);
  begin
    ALabel.Visible := Alle or An;
    AEdit.Visible := Alle or An;
  end;
begin
  Paar(Gruppe.SichtbarGewicht, LabelGewicht, EditGewicht);
  Paar(Gruppe.SichtbarZahl1, LabelZahl1, EditZahl1);
  Paar(Gruppe.SichtbarZahl2, LabelZahl2, EditZahl2);
  Paar(Gruppe.SichtbarZahl3, LabelZahl3, EditZahl3);
  Paar(Gruppe.SichtbarLieferant, LabelLieferant, EditLieferant);
  Paar(Gruppe.SichtbarLieferantNr, LabelLieferantNr, EditLieferantNr);
  Paar(Gruppe.SichtbarBestand, LabelBestand, EditBestand);
  Paar(Gruppe.SichtbarMinBestand, LabelMinBestand, EditMinBestand);
  Paar(Gruppe.SichtbarName1, LabelName1, EditName1);
  Paar(Gruppe.SichtbarName2, LabelName2, EditName2);
  Paar(Gruppe.SichtbarName3, LabelName3, EditName3);
  MemoPos.Visible := Alle or Gruppe.SichtbarPostext;
  LabelEinheitMenge.Visible := Alle or not Gruppe.EinheitMengeWieEk;
  EditEinheitMenge.Visible := LabelEinheitMenge.Visible;
end;

procedure TArtikelFenster.GruppeAnwenden(const Gruppe: TArtikelGruppe;
  Vorgaben: Boolean);
begin
  FGruppeId := Gruppe.Id;
  EditGruppe.Text := Gruppe.Bezeichnung;
  SichtSetzen(Gruppe, False);
  if Vorgaben and (Trim(EditArtikel.Text) = '') then
  begin
    EditArtikel.Text := Gruppe.VorgabeArtikel;
    EditEinheitMenge.Text := Gruppe.VorgabeEinheitMenge;
    EditEk.Text := TextAusCent(Gruppe.VorgabeEkCent);
    EditEinheitEk.Text := Gruppe.VorgabeEinheitEk;
    EditAufschlag.Text := TextAusAufschlag(Gruppe.VorgabeAufschlagBp);
    EditLieferant.Text := Gruppe.VorgabeLieferant;
  end;
end;

procedure TArtikelFenster.FeldBetreten(Sender: TObject);
begin
  ButtonSuchen.Enabled := True;
end;

procedure TArtikelFenster.Suchen(Sender: TObject);
var
  Id: Int64;
  Gruppe: TArtikelGruppe;
  Ziel: TWinControl;
begin
  Ziel := ActiveControl;
  if Sender is TLabel then
  begin
    if Sender = LabelGruppe then
      Ziel := EditGruppe
    else if Sender = LabelEinheitMenge then
      Ziel := EditEinheitMenge
    else if Sender = LabelEinheitEk then
      Ziel := EditEinheitEk
    else if Sender = LabelLieferant then
      Ziel := EditLieferant;
    if Ziel <> nil then
      Ziel.SetFocus;
  end;
  if Ziel = EditGruppe then
  begin
    if ListenWahl('artikelgruppe', False, Id) and GruppeLaden(Id, Gruppe) then
      GruppeAnwenden(Gruppe, FNeu);
  end
  else if (Ziel = EditEinheitMenge) or (Ziel = EditEinheitEk) then
  begin
    if ListenWahl('einheit', False, Id) then
      TEdit(Ziel).Text := StammBezeichnung('einheit', Id);
  end
  else if Ziel = EditLieferant then
  begin
    if ListenWahl('lieferant', False, Id) then
      EditLieferant.Text := StammBezeichnung('lieferant', Id);
  end;
end;

procedure TArtikelFenster.SucheKlick(Sender: TObject);
begin
  Suchen(Sender);
end;

procedure TArtikelFenster.AbbrechenKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TArtikelFenster.SpeichernKlick(Sender: TObject);
var
  Artikel: TArtikel;
  Gruppe: TArtikelGruppe;
  Fehler: string;
  Cent, Milli: Int64;
  Bp, Satz: Integer;
begin
  Artikel := Default(TArtikel);
  Artikel.Id := FId;
  Artikel.Bezeichnung := Trim(EditArtikel.Text);
  if (FGruppeId = 0) and (Trim(EditGruppe.Text) <> '') and
     GruppeNachName(EditGruppe.Text, Gruppe) then
    FGruppeId := Gruppe.Id;
  Artikel.GruppeId := FGruppeId;
  if not CentAusText(EditEk.Text, Cent) then
  begin
    ShowMessage('Der EK-Preis muss eine Zahl sein.');
    Exit;
  end;
  Artikel.EkCent := Cent;
  if not AufschlagAusText(EditAufschlag.Text, Bp) then
  begin
    ShowMessage('Der Aufschlag muss eine Zahl sein.');
    Exit;
  end;
  Artikel.AufschlagBp := Bp;
  Satz := StrToIntDef(Trim(EditMwst.Text), -1);
  if Satz < 0 then
  begin
    ShowMessage('Der MwSt-Satz muss eine ganze Zahl sein.');
    Exit;
  end;
  Artikel.MwstSatz := Satz;
  if not MilliAusText(EditGewicht.Text, Milli) then
  begin
    ShowMessage('Das Gewicht muss eine Zahl sein.');
    Exit;
  end;
  Artikel.GewichtMilli := Milli;
  if not MilliAusText(EditZahl1.Text, Milli) then Exit;
  Artikel.Zahl1Milli := Milli;
  if not MilliAusText(EditZahl2.Text, Milli) then Exit;
  Artikel.Zahl2Milli := Milli;
  if not MilliAusText(EditZahl3.Text, Milli) then Exit;
  Artikel.Zahl3Milli := Milli;
  if not MilliAusText(EditBestand.Text, Milli) then Exit;
  Artikel.BestandMilli := Milli;
  if not MilliAusText(EditMinBestand.Text, Milli) then Exit;
  Artikel.MinBestandMilli := Milli;
  Artikel.EinheitEk := Trim(EditEinheitEk.Text);
  if EditEinheitMenge.Visible then
    Artikel.EinheitMenge := Trim(EditEinheitMenge.Text)
  else
    Artikel.EinheitMenge := Artikel.EinheitEk;
  Artikel.Lieferant := Trim(EditLieferant.Text);
  Artikel.LieferantNr := Trim(EditLieferantNr.Text);
  Artikel.PosText := MemoPos.Text;
  Artikel.Name1 := Trim(EditName1.Text);
  Artikel.Name2 := Trim(EditName2.Text);
  Artikel.Name3 := Trim(EditName3.Text);
  if FGruppeId > 0 then
  begin
    if GruppeLaden(FGruppeId, Gruppe) then
    begin
      Artikel.Berechnungsart := Gruppe.Berechnungsart;
      Artikel.Kostenart := Gruppe.Kostenart;
    end;
  end;
  FId := ArtikelSpeichern(Artikel, Fehler);
  if FId = 0 then
    ShowMessage(Fehler)
  else
    ModalResult := mrOk;
end;

procedure TArtikelFenster.FormKeyDown(Sender: TObject; var Key: Word;
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
