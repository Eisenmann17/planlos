unit ubelegfenster;

{ Belegfenster nach der alten Artikelsammlung: Kopf, Intern, Positionen,
  Fuß und Summen. Beträge in Cent.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Grids,
  Graphics, LCLType, LCLIntf, Menus, ubeleg, ustueckliste;

type
  TBelegfenster = class(TForm)
    PanelKopf: TPanel;
    LabelKopf: TLabel;
    LabelBriefkopf: TLabel;
    ComboBriefkopf: TComboBox;
    CheckBriefkopf: TCheckBox;
    MemoAdresse: TMemo;
    LabelKopftext: TLabel;
    MemoKopf: TMemo;
    LabelNrTitel: TLabel;
    LabelNr: TLabel;
    LabelDatum: TLabel;
    EditDatum: TEdit;
    LabelBearbeiter: TLabel;
    EditBearbeiter: TEdit;
    LabelZeichen: TLabel;
    EditZeichen: TEdit;
    PanelIntern: TPanel;
    LabelIntern: TLabel;
    LabelProjekt: TLabel;
    EditProjekt: TEdit;
    LabelAdresse: TLabel;
    EditAdresse: TEdit;
    LabelBezeichnungTitel: TLabel;
    EditBezeichnung: TEdit;
    LabelGruppe: TLabel;
    EditGruppe: TEdit;
    LabelNotiz: TLabel;
    MemoNotiz: TMemo;
    PanelUnten: TPanel;
    PanelSumme: TPanel;
    LabelSumme: TLabel;
    CheckSofort: TCheckBox;
    ButtonJetzt: TButton;
    LabelExtern: TLabel;
    MemoExtern: TMemo;
    LabelInternSumme: TLabel;
    MemoIntern: TMemo;
    PanelFuss: TPanel;
    LabelFuss: TLabel;
    LabelFusstext: TLabel;
    MemoFuss: TMemo;
    PanelLeiste: TPanel;
    LabelEsc: TLabel;
    ButtonAbbrechen: TButton;
    LabelF2: TLabel;
    ButtonNeu: TButton;
    LabelF3: TLabel;
    ButtonAusgabe: TButton;
    LabelF4: TLabel;
    ButtonSuchen: TButton;
    LabelF5: TLabel;
    ButtonKopieren: TButton;
    LabelF6: TLabel;
    ButtonAendern: TButton;
    LabelF8: TLabel;
    ButtonLoeschen: TButton;
    LabelF10: TLabel;
    ButtonSpeichern: TButton;
    PanelMitte: TPanel;
    MemoPos: TMemo;
    GridPos: TStringGrid;
    procedure FormErzeugen(Sender: TObject);
    procedure FormZeigen(Sender: TObject);
    procedure FormGeaendert(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KopfKlappen(Sender: TObject);
    procedure InternKlappen(Sender: TObject);
    procedure SummeKlappen(Sender: TObject);
    procedure FussKlappen(Sender: TObject);
    procedure KopftextSuchen(Sender: TObject);
    procedure FusstextSuchen(Sender: TObject);
    procedure DatumHeute(Sender: TObject);
    procedure BearbeiterSuchen(Sender: TObject);
    procedure ProjektSuchen(Sender: TObject);
    procedure AdresseSuchen(Sender: TObject);
    procedure GruppeSuchen(Sender: TObject);
    procedure SofortKlick(Sender: TObject);
    procedure JetztKlick(Sender: TObject);
    procedure NeuKlick(Sender: TObject);
    procedure AusgabeKlick(Sender: TObject);
    procedure KopfAusMaske;
    procedure BriefkoepfeFuellen;
    procedure MenuArtikel(Sender: TObject);
    procedure MenuStueckliste(Sender: TObject);
    procedure MenuNeueStueckliste(Sender: TObject);
    procedure MenuOhneVorgabe(Sender: TObject);
    procedure StueckUebernehmen(Index: Integer; const Bezeichnung, Einheit: string;
      const Zeilen: TStueckZeilen);
    procedure StueckAendern(Sender: TObject);
    procedure SuchenKlick(Sender: TObject);
    procedure KopierenKlick(Sender: TObject);
    procedure AendernKlick(Sender: TObject);
    procedure LoeschenKlick(Sender: TObject);
    procedure AbbrechenKlick(Sender: TObject);
    procedure SpeichernKlick(Sender: TObject);
    procedure ZelleFertig(Sender: TObject);
    procedure ZelleWahl(Sender: TObject; aCol, aRow: Integer; var CanSelect: Boolean);
    procedure PosTextVerlassen(Sender: TObject);
  private
    FArt: TBelegart;
    FKopf: TBelegKopf;
    FZeilen: TPosListe;
    FZeile: Integer;
    FUeberschrift: TLabel;
    FKopfOffen: Boolean;
    FInternOffen: Boolean;
    FSummeOffen: Boolean;
    FFussOffen: Boolean;
    FFuellen: Boolean;
    FRand: TPanel;
    FMenuF2: TPopupMenu;
    FBriefIds: array of Int64;
    FFolge: array of TButton;
    FFolgeAngelegt: Boolean;
    function BenutzerName: string;
    function Darf(const Aktion: string): Boolean;
    function ZeileNeu: Boolean;
    function ZeileLoeschen: Boolean;
    function Gewaehlt: Integer;
    procedure KlappenLesen;
    procedure Klappe(const Bereich: string);
    procedure Anordnen;
    procedure LeisteOrdnen(Sender: TObject);
    procedure FolgeKnopfe;
    procedure FolgeKlick(Sender: TObject);
    procedure FelderFuellen;
    procedure FeldSichten;
    procedure Gitter;
    procedure ZeileSchreiben(Index: Integer);
    procedure ZelleLesen;
    procedure PosTextSichern;
    procedure SummenZeigen;
    procedure Knoepfe;
    procedure Suchen;
    procedure ArtikelHolen;
    procedure ZeileAnlegen;
    function SpeichernStill(out Fehler: string): Int64;
    procedure Folge(const ZielKuerzel: string);
  public
    function OeffneNeu(const Kuerzel: string): Boolean;
    function OeffneId(Id: Int64): Boolean;
  end;

function BelegBearbeiten(const Kuerzel: string; Id: Int64): Int64;

implementation

{$R *.lfm}

uses
  ubenutzer, uartikel, usuche, utextbaustein, utextbausteinfenster, uprojekt,
  uartikelwahl, udruck, ufenster, ufensterdaten, ugrafik, ustuecklistefenster;

const
  CPos = 0;
  CGruppe = 1;
  CArtikel = 2;
  CMenge = 3;
  CEinheit = 4;
  CEk = 5;
  CAuf = 6;
  CRab = 7;
  CVk = 8;
  CSatz = 9;

function BelegBearbeiten(const Kuerzel: string; Id: Int64): Int64;
var
  Fenster: TBelegfenster;
  Meldung, Art: string;
begin
  Result := 0;
  if Id = 0 then
    Art := Kuerzel
  else
    Art := BelegArtKuerzel(Id);
  if Id = 0 then
  begin
    if not AktionZulaessig('beleg', Art, 'neu', Meldung) then
    begin
      ShowMessage(Meldung);
      Exit;
    end;
  end
  else if not AktionZulaessig('beleg', Art, 'sehen', Meldung) then
  begin
    ShowMessage(Meldung);
    Exit;
  end;
  Fenster := TBelegfenster.Create(Application);
  try
    if Id = 0 then
    begin
      if not Fenster.OeffneNeu(Kuerzel) then
        Exit;
    end
    else if not Fenster.OeffneId(Id) then
      Exit;
    if Fenster.ShowModal = mrOk then
      Result := Fenster.FKopf.Id;
  finally
    Fenster.Free;
  end;
end;

function Pfeil(Offen: Boolean): string;
begin
  if Offen then
    Result := '▾ '
  else
    Result := '▸ ';
end;

function TBelegfenster.BenutzerName: string;
begin
  Result := Sitzung.Name;
  if Result = '' then
    Result := 'Standard';
end;

function TBelegfenster.Darf(const Aktion: string): Boolean;
var
  Meldung: string;
begin
  Result := AktionZulaessig('beleg', FArt.Kuerzel, Aktion, Meldung);
end;

function TBelegfenster.ZeileNeu: Boolean;
begin
  if FKopf.Id = 0 then
    Result := Darf('neu')
  else
    Result := Darf('aendern');
end;

function TBelegfenster.ZeileLoeschen: Boolean;
begin
  if FKopf.Id = 0 then
    Result := Darf('neu')
  else
    Result := Darf('loeschen');
end;

function TBelegfenster.Gewaehlt: Integer;
begin
  Result := GridPos.Row - 1;
  if (Result < 0) or (Result > High(FZeilen)) then
    Result := -1;
end;

procedure TBelegfenster.FormErzeugen(Sender: TObject);
var
  Eintrag: TMenuItem;
begin
  FRand := TPanel.Create(Self);
  FRand.Parent := Self;
  FRand.Align := alBottom;
  FRand.BevelOuter := bvNone;
  FRand.Caption := '';
  FRand.Height := PanelUnten.Height + PanelLeiste.Height;
  PanelLeiste.Parent := FRand;
  PanelLeiste.Align := alBottom;
  PanelLeiste.OnResize := @LeisteOrdnen;
  FUeberschrift := TLabel.Create(Self);
  FUeberschrift.Parent := PanelMitte;
  FUeberschrift.Align := alTop;
  FUeberschrift.Height := 18;
  FUeberschrift.Layout := tlCenter;
  FUeberschrift.BorderSpacing.Left := 8;
  FUeberschrift.Font.Color := clNavy;
  PanelUnten.Parent := FRand;
  PanelUnten.Align := alClient;
  FZeile := -1;
  GridPos.Cells[CPos, 0] := 'Pos';
  GridPos.Cells[CGruppe, 0] := 'Gruppe';
  GridPos.Cells[CArtikel, 0] := 'Artikel';
  GridPos.Cells[CMenge, 0] := 'Menge';
  GridPos.Cells[CEinheit, 0] := 'Einheit';
  GridPos.Cells[CEk, 0] := 'EK';
  GridPos.Cells[CAuf, 0] := 'Aufschlag';
  GridPos.Cells[CRab, 0] := 'Rabatt';
  GridPos.Cells[CVk, 0] := 'VK';
  GridPos.Cells[CSatz, 0] := 'MwSt';
  GridPos.OnDblClick := @StueckAendern;
  GridPos.ColWidths[CPos] := 36;
  GridPos.ColWidths[CGruppe] := 90;
  GridPos.ColWidths[CArtikel] := 150;
  GridPos.ColWidths[CMenge] := 60;
  GridPos.ColWidths[CEinheit] := 60;
  GridPos.ColWidths[CEk] := 70;
  GridPos.ColWidths[CAuf] := 70;
  GridPos.ColWidths[CRab] := 60;
  GridPos.ColWidths[CVk] := 70;
  GridPos.ColWidths[CSatz] := 45;
  FMenuF2 := TPopupMenu.Create(Self);
  Eintrag := TMenuItem.Create(FMenuF2);
  Eintrag.Caption := 'Artikel aus Stammdaten';
  Eintrag.OnClick := @MenuArtikel;
  FMenuF2.Items.Add(Eintrag);
  Eintrag := TMenuItem.Create(FMenuF2);
  Eintrag.Caption := 'Stückliste aus Stammdaten';
  Eintrag.OnClick := @MenuStueckliste;
  FMenuF2.Items.Add(Eintrag);
  Eintrag := TMenuItem.Create(FMenuF2);
  Eintrag.Caption := 'Neue Stückliste';
  Eintrag.OnClick := @MenuNeueStueckliste;
  FMenuF2.Items.Add(Eintrag);
  Eintrag := TMenuItem.Create(FMenuF2);
  Eintrag.Caption := 'Artikel ohne Vorgabe';
  Eintrag.OnClick := @MenuOhneVorgabe;
  FMenuF2.Items.Add(Eintrag);
end;

procedure TBelegfenster.MenuArtikel(Sender: TObject);
begin
  ArtikelHolen;
end;

procedure TBelegfenster.StueckUebernehmen(Index: Integer; const Bezeichnung,
  Einheit: string; const Zeilen: TStueckZeilen);
begin
  if (Index < 0) or (Index > High(FZeilen)) then
    Exit;
  FZeilen[Index].Text := Bezeichnung;
  FZeilen[Index].ArtikelName := Bezeichnung;
  if Einheit <> '' then
    FZeilen[Index].Einheit := Einheit;
  if FZeilen[Index].MengeMilli = 0 then
    FZeilen[Index].MengeMilli := 1000;
  FZeilen[Index].Unterzeilen := Zeilen;
  FZeilen[Index].EkCent := SummeEkCent(Zeilen);
  FZeilen[Index].AufschlagBp := 0;
  FZeilen[Index].RabattBp := 0;
  FZeilen[Index].EinzelpreisCent := SummeVkCent(Zeilen);
  FZeile := Index;
  Gitter;
  SummenZeigen;
end;

procedure TBelegfenster.MenuStueckliste(Sender: TObject);
var
  Id: Int64;
  Index: Integer;
  Liste: TStueckliste;
begin
  if not ZeileNeu then
  begin
    ShowMessage('Dafür fehlt das Recht.');
    Exit;
  end;
  if not StuecklisteWaehlen(Id) then
    Exit;
  if not StuecklisteLaden(Id, Liste) then
  begin
    ShowMessage('Die Stückliste wurde nicht gefunden.');
    Exit;
  end;
  ZeileAnlegen;
  Index := FZeile;
  StueckUebernehmen(Index, Liste.Bezeichnung, Liste.Einheit, Liste.Zeilen);
end;

procedure TBelegfenster.MenuNeueStueckliste(Sender: TObject);
var
  Bezeichnung, Einheit: string;
  Zeilen: TStueckZeilen;
  Index: Integer;
begin
  if not ZeileNeu then
  begin
    ShowMessage('Dafür fehlt das Recht.');
    Exit;
  end;
  ZeileAnlegen;
  Index := FZeile;
  Bezeichnung := '';
  Einheit := 'Stück';
  SetLength(Zeilen, 0);
  if not StuecklisteZeilenBearbeiten(Bezeichnung, Einheit, Zeilen) then
    Exit;
  StueckUebernehmen(Index, Bezeichnung, Einheit, Zeilen);
end;

procedure TBelegfenster.StueckAendern(Sender: TObject);
var
  Index: Integer;
  Bezeichnung, Einheit: string;
  Zeilen: TStueckZeilen;
begin
  Index := Gewaehlt;
  if (Index < 0) or (Length(FZeilen[Index].Unterzeilen) = 0) then
    Exit;
  if not ZeileNeu then
    Exit;
  Bezeichnung := FZeilen[Index].Text;
  Einheit := FZeilen[Index].Einheit;
  Zeilen := FZeilen[Index].Unterzeilen;
  if StuecklisteZeilenBearbeiten(Bezeichnung, Einheit, Zeilen) then
    StueckUebernehmen(Index, Bezeichnung, Einheit, Zeilen);
end;

procedure TBelegfenster.MenuOhneVorgabe(Sender: TObject);
begin
  ZeileAnlegen;
end;

procedure TBelegfenster.BriefkoepfeFuellen;
var
  Namen, Nummern: TStringList;
  i, Index: Integer;
begin
  Namen := TStringList.Create;
  Nummern := TStringList.Create;
  try
    BriefkoepfeHolen(Namen, Nummern);
    ComboBriefkopf.Items.Assign(Namen);
    SetLength(FBriefIds, Nummern.Count);
    Index := 0;
    for i := 0 to Nummern.Count - 1 do
    begin
      FBriefIds[i] := StrToInt64Def(Nummern[i], 0);
      if FBriefIds[i] = FKopf.BriefkopfId then
        Index := i;
    end;
    if ComboBriefkopf.Items.Count > 0 then
      ComboBriefkopf.ItemIndex := Index;
  finally
    Namen.Free;
    Nummern.Free;
  end;
end;

function TBelegfenster.OeffneNeu(const Kuerzel: string): Boolean;
begin
  Result := BelegartLaden(Kuerzel, FArt);
  if not Result then
    Exit;
  FKopf := Default(TBelegKopf);
  FKopf.Modulart := Kuerzel;
  FKopf.MwstRechnen := FArt.Mwst;
  FKopf.BearbeiterId := AngemeldeterMitarbeiter;
  FKopf.Erfasst := FormatDateTime('yyyy-mm-dd', Now);
  FKopf.BriefkopfAn := True;
  FKopf.BriefkopfId := BriefkopfStandard;
  SetLength(FZeilen, 0);
end;

function TBelegfenster.OeffneId(Id: Int64): Boolean;
begin
  Result := BelegLaden(Id, FKopf, FZeilen);
  if not Result then
    Exit;
  Result := BelegartLaden(FKopf.Modulart, FArt);
end;

procedure TBelegfenster.KlappenLesen;
begin
  FKopfOffen := KlappOffen(BenutzerName, FArt.Id, 'kopf', FArt.KopfAn);
  FInternOffen := KlappOffen(BenutzerName, FArt.Id, 'intern', FArt.InternAn);
  FSummeOffen := KlappOffen(BenutzerName, FArt.Id, 'summe', FArt.SummeAn);
  FFussOffen := KlappOffen(BenutzerName, FArt.Id, 'fuss', FArt.FussAn);
end;

procedure TBelegfenster.Klappe(const Bereich: string);
var
  Offen: Boolean;
begin
  if Bereich = 'kopf' then
  begin
    if not FArt.Kopf then
      Exit;
    FKopfOffen := not FKopfOffen;
    Offen := FKopfOffen;
  end
  else if Bereich = 'intern' then
  begin
    if not FArt.Intern then
      Exit;
    FInternOffen := not FInternOffen;
    Offen := FInternOffen;
  end
  else if Bereich = 'summe' then
  begin
    if not FArt.Summe then
      Exit;
    FSummeOffen := not FSummeOffen;
    Offen := FSummeOffen;
  end
  else
  begin
    if not FArt.Fuss then
      Exit;
    FFussOffen := not FFussOffen;
    Offen := FFussOffen;
  end;
  KlappMerken(BenutzerName, FArt.Id, Bereich, Offen);
  Anordnen;
end;

procedure TBelegfenster.KopfKlappen(Sender: TObject);
begin
  Klappe('kopf');
end;

procedure TBelegfenster.InternKlappen(Sender: TObject);
begin
  Klappe('intern');
end;

procedure TBelegfenster.SummeKlappen(Sender: TObject);
begin
  Klappe('summe');
end;

procedure TBelegfenster.FussKlappen(Sender: TObject);
begin
  Klappe('fuss');
end;

procedure TBelegfenster.Anordnen;
var
  Unten, SummeH, FussH: Integer;
begin
  PanelKopf.Visible := FArt.Kopf;
  if FArt.Kopf then
    PanelKopf.Height := BereichHoehe('kopf', FKopfOffen);
  LabelKopf.Caption := Pfeil(FKopfOffen) + 'Kopf';
  PanelIntern.Visible := FArt.Intern;
  if FArt.Intern then
    PanelIntern.Height := BereichHoehe('intern', FInternOffen);
  LabelIntern.Caption := Pfeil(FInternOffen) + 'Intern';
  SummeH := 0;
  FussH := 0;
  PanelSumme.Visible := FArt.Summe;
  if FArt.Summe then
  begin
    SummeH := BereichHoehe('summe', FSummeOffen);
    PanelSumme.Height := SummeH;
  end;
  LabelSumme.Caption := Pfeil(FSummeOffen) + 'Summen';
  PanelFuss.Visible := FArt.Fuss;
  if FArt.Fuss then
    FussH := BereichHoehe('fuss', FFussOffen);
  LabelFuss.Caption := Pfeil(FFussOffen) + 'Fuß';
  Unten := SummeH + FussH;
  PanelUnten.Visible := Unten > 0;
  if FRand <> nil then
    FRand.Height := Unten + PanelLeiste.Height;
  FeldSichten;
  PanelMitte.Visible := FArt.Positionen;
  if FUeberschrift <> nil then
  begin
    FUeberschrift.Caption := FArt.ArtikelUeberschrift;
    FUeberschrift.Visible := (FArt.ArtikelUeberschrift <> '') and FArt.Positionen;
  end;
end;

procedure TBelegfenster.FeldSichten;
var
  KopfAuf, InternAuf, FussAuf, SummeAuf: Boolean;
begin
  KopfAuf := FArt.Kopf and FKopfOffen;
  InternAuf := FArt.Intern and FInternOffen;
  FussAuf := FArt.Fuss and FFussOffen;
  SummeAuf := FArt.Summe and FSummeOffen;
  MemoAdresse.Visible := KopfAuf and FArt.ZeigeKopfAdresse;
  LabelKopftext.Visible := KopfAuf and FArt.ZeigeKopftext;
  MemoKopf.Visible := KopfAuf and FArt.ZeigeKopftext;
  LabelNrTitel.Visible := KopfAuf and FArt.ZeigeNr;
  LabelNr.Visible := KopfAuf and FArt.ZeigeNr;
  LabelDatum.Visible := KopfAuf and FArt.ZeigeDatum;
  EditDatum.Visible := KopfAuf and FArt.ZeigeDatum;
  LabelBearbeiter.Visible := KopfAuf and FArt.ZeigeBearbeiter;
  EditBearbeiter.Visible := KopfAuf and FArt.ZeigeBearbeiter;
  LabelZeichen.Visible := KopfAuf and FArt.ZeigeZeichen;
  EditZeichen.Visible := KopfAuf and FArt.ZeigeZeichen;
  LabelBriefkopf.Visible := KopfAuf;
  ComboBriefkopf.Visible := KopfAuf;
  CheckBriefkopf.Visible := KopfAuf;
  if FArt.ZeichenText <> '' then
    LabelZeichen.Caption := FArt.ZeichenText;
  LabelProjekt.Visible := InternAuf and FArt.ZeigeProjekt;
  EditProjekt.Visible := InternAuf and FArt.ZeigeProjekt;
  LabelAdresse.Visible := InternAuf and FArt.ZeigeInternAdresse;
  EditAdresse.Visible := InternAuf and FArt.ZeigeInternAdresse;
  LabelBezeichnungTitel.Visible := InternAuf and FArt.ZeigeBezeichnung;
  EditBezeichnung.Visible := InternAuf and FArt.ZeigeBezeichnung;
  LabelGruppe.Visible := InternAuf and FArt.ZeigeGruppierung;
  EditGruppe.Visible := InternAuf and FArt.ZeigeGruppierung;
  LabelNotiz.Visible := InternAuf and FArt.ZeigeNotiz;
  MemoNotiz.Visible := InternAuf and FArt.ZeigeNotiz;
  LabelFusstext.Visible := FussAuf and FArt.ZeigeFusstext;
  MemoFuss.Visible := FussAuf and FArt.ZeigeFusstext;
  CheckSofort.Visible := SummeAuf;
  ButtonJetzt.Visible := SummeAuf;
  LabelExtern.Visible := SummeAuf;
  MemoExtern.Visible := SummeAuf;
  LabelInternSumme.Visible := SummeAuf;
  MemoIntern.Visible := SummeAuf;
end;

procedure TBelegfenster.FelderFuellen;
var
  Projekt: TProjekt;
begin
  FFuellen := True;
  try
    MemoAdresse.Text := FKopf.AdresseText;
    MemoKopf.Text := FKopf.Kopftext;
    if FKopf.Nummer = '' then
      LabelNr.Caption := 'neu'
    else
      LabelNr.Caption := FKopf.Nummer;
    EditDatum.Text := FKopf.Erfasst;
    if FKopf.BearbeiterId > 0 then
      EditBearbeiter.Text := StammBezeichnung('lieferant', FKopf.BearbeiterId)
    else
      EditBearbeiter.Text := '';
    EditZeichen.Text := FKopf.IhrZeichen;
    if FKopf.BriefkopfId = 0 then
      FKopf.BriefkopfId := BriefkopfStandard;
    BriefkoepfeFuellen;
    CheckBriefkopf.Checked := FKopf.BriefkopfAn;
    if FKopf.ProjektStammId > 0 then
    begin
      if ProjektLaden(FKopf.ProjektStammId, Projekt) then
        EditProjekt.Text := Projekt.Bezeichnung;
    end
    else
      EditProjekt.Text := '';
    if FKopf.AdresseId > 0 then
      EditAdresse.Text := StammBezeichnung('lieferant', FKopf.AdresseId)
    else
      EditAdresse.Text := '';
    EditBezeichnung.Text := FKopf.Bezeichnung;
    EditGruppe.Text := FKopf.Gruppierung;
    MemoNotiz.Text := FKopf.Notiz;
    MemoFuss.Text := FKopf.Fusstext;
    if FKopf.Nummer = '' then
      Caption := FArt.Bezeichnung + ' neu'
    else
      Caption := FArt.Bezeichnung + ' ' + FKopf.Nummer;
  finally
    FFuellen := False;
  end;
end;

procedure TBelegfenster.ZeileSchreiben(Index: Integer);
var
  Zeile: Integer;
begin
  Zeile := Index + 1;
  GridPos.Cells[CPos, Zeile] := IntToStr(Index + 1);
  GridPos.Cells[CGruppe, Zeile] := FZeilen[Index].Gruppe;
  GridPos.Cells[CArtikel, Zeile] := FZeilen[Index].ArtikelName;
  GridPos.Cells[CMenge, Zeile] := MilliAlsText(FZeilen[Index].MengeMilli);
  GridPos.Cells[CEinheit, Zeile] := FZeilen[Index].Einheit;
  GridPos.Cells[CEk, Zeile] := CentAlsText(FZeilen[Index].EkCent);
  GridPos.Cells[CAuf, Zeile] := TextAusAufschlag(FZeilen[Index].AufschlagBp);
  GridPos.Cells[CRab, Zeile] := TextAusAufschlag(FZeilen[Index].RabattBp);
  GridPos.Cells[CVk, Zeile] := CentAlsText(FZeilen[Index].EinzelpreisCent);
  GridPos.Cells[CSatz, Zeile] := IntToStr(FZeilen[Index].MwstSatz);
end;

procedure TBelegfenster.Gitter;
var
  i: Integer;
begin
  FFuellen := True;
  try
    if Length(FZeilen) = 0 then
    begin
      GridPos.RowCount := 2;
      for i := 0 to GridPos.ColCount - 1 do
        GridPos.Cells[i, 1] := '';
      MemoPos.Text := '';
      FZeile := -1;
    end
    else
    begin
      GridPos.RowCount := Length(FZeilen) + 1;
      for i := 0 to High(FZeilen) do
        ZeileSchreiben(i);
      if (FZeile < 0) or (FZeile > High(FZeilen)) then
        FZeile := 0;
      GridPos.Row := FZeile + 1;
      MemoPos.Text := FZeilen[FZeile].Text;
    end;
  finally
    FFuellen := False;
  end;
end;

procedure TBelegfenster.PosTextSichern;
begin
  if (FZeile >= 0) and (FZeile <= High(FZeilen)) then
    FZeilen[FZeile].Text := MemoPos.Text;
end;

procedure TBelegfenster.ZelleLesen;
var
  Index, Spalte: Integer;
  Cent: Int64;
  Milli: Int64;
  Bp, Satz: Integer;
  Zahl: string;
begin
  if FFuellen then
    Exit;
  Index := GridPos.Row - 1;
  if (Index < 0) or (Index > High(FZeilen)) then
    Exit;
  Spalte := GridPos.Col;
  Zahl := Trim(GridPos.Cells[Spalte, Index + 1]);
  case Spalte of
    CGruppe: FZeilen[Index].Gruppe := Zahl;
    CArtikel: FZeilen[Index].ArtikelName := Zahl;
    CMenge:
      if MilliAusText(Zahl, Milli) then
        FZeilen[Index].MengeMilli := Milli;
    CEinheit: FZeilen[Index].Einheit := Zahl;
    CEk:
      if CentAusText(Zahl, Cent) then
        FZeilen[Index].EkCent := Cent;
    CAuf:
      if AufschlagAusText(Zahl, Bp) then
        FZeilen[Index].AufschlagBp := Bp;
    CRab:
      if AufschlagAusText(Zahl, Bp) then
        FZeilen[Index].RabattBp := Bp;
    CVk:
      if CentAusText(Zahl, Cent) then
        FZeilen[Index].EinzelpreisCent := Cent;
    CSatz:
      begin
        Satz := StrToIntDef(Zahl, -1);
        if (Satz = 0) or (Satz = 7) or (Satz = 19) then
          FZeilen[Index].MwstSatz := Satz;
      end;
  end;
  if (Spalte = CEk) or (Spalte = CAuf) or (Spalte = CRab) then
    FZeilen[Index].EinzelpreisCent := VkCent(FZeilen[Index].EkCent,
      FZeilen[Index].AufschlagBp, FZeilen[Index].RabattBp);
  FFuellen := True;
  try
    ZeileSchreiben(Index);
  finally
    FFuellen := False;
  end;
  if CheckSofort.Checked then
    SummenZeigen;
end;

procedure TBelegfenster.ZelleFertig(Sender: TObject);
begin
  ZelleLesen;
end;

procedure TBelegfenster.ZelleWahl(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
  CanSelect := True;
  if FFuellen then
    Exit;
  PosTextSichern;
  FZeile := aRow - 1;
  if (FZeile >= 0) and (FZeile <= High(FZeilen)) then
  begin
    FFuellen := True;
    try
      MemoPos.Text := FZeilen[FZeile].Text;
    finally
      FFuellen := False;
    end;
  end;
end;

procedure TBelegfenster.PosTextVerlassen(Sender: TObject);
begin
  PosTextSichern;
  if CheckSofort.Checked then
    SummenZeigen;
end;

procedure TBelegfenster.SummenZeigen;
var
  Summe: TBelegSumme;
  Intern: TInternSumme;
  Anzeige: string;
  i: Integer;
begin
  PosTextSichern;
  Summe := SummeRechnen(FZeilen, FKopf.MwstRechnen and FArt.Mwst);
  Anzeige := 'Netto: ' + CentAlsText(Summe.NettoCent) + ' €';
  if FArt.Mwst and FKopf.MwstRechnen then
    for i := 0 to High(Summe.Gruppen) do
      if Summe.Gruppen[i].Satz <> 0 then
        Anzeige := Anzeige + LineEnding + 'MwSt ' + IntToStr(Summe.Gruppen[i].Satz) +
          ' %: ' + CentAlsText(Summe.Gruppen[i].SteuerCent) + ' €';
  Anzeige := Anzeige + LineEnding + 'Brutto: ' + CentAlsText(Summe.BruttoCent) + ' €';
  MemoExtern.Text := Anzeige;
  Intern := InternRechnen(FZeilen);
  MemoIntern.Text := 'EK: ' + CentAlsText(Intern.EkCent) + ' €' + LineEnding +
    'VK: ' + CentAlsText(Intern.VkCent) + ' €' + LineEnding +
    'Gewinn: ' + CentAlsText(Intern.GewinnCent) + ' €';
end;

procedure TBelegfenster.SofortKlick(Sender: TObject);
begin
  if FFuellen then
    Exit;
  if CheckSofort.Checked then
    SummenZeigen;
end;

procedure TBelegfenster.JetztKlick(Sender: TObject);
begin
  SummenZeigen;
end;

procedure TBelegfenster.Knoepfe;
var
  Aendern: Boolean;
begin
  Aendern := ZeileNeu;
  ButtonNeu.Enabled := Aendern and FArt.Positionen;
  ButtonKopieren.Enabled := Aendern and Darf('kopieren') and (Gewaehlt >= 0);
  ButtonAendern.Enabled := Aendern and (Gewaehlt >= 0);
  ButtonLoeschen.Enabled := ZeileLoeschen and (Gewaehlt >= 0);
  ButtonSuchen.Enabled := Aendern and FArt.Suchen;
  MemoKopf.ReadOnly := not Aendern;
  MemoFuss.ReadOnly := not Aendern;
  MemoNotiz.ReadOnly := not Aendern;
  MemoPos.ReadOnly := not Aendern;
  EditBezeichnung.ReadOnly := not Aendern;
  EditZeichen.ReadOnly := not Aendern;
  EditDatum.ReadOnly := not Aendern;
  if Aendern then
    GridPos.Options := GridPos.Options + [goEditing]
  else
    GridPos.Options := GridPos.Options - [goEditing];
  if FKopf.Id = 0 then
    ButtonSpeichern.Enabled := Darf('neu') and FArt.Speichern
  else
    ButtonSpeichern.Enabled := Darf('aendern') and FArt.Speichern;
  ButtonAusgabe.Enabled := Darf('drucken') and FArt.Ausgabe;
end;

procedure TBelegfenster.FolgeKnopfe;
var
  Tasten: TBelegTasten;
  i, n: Integer;
  Knopf: TButton;
begin
  if FFolgeAngelegt then
    Exit;
  FFolgeAngelegt := True;
  Tasten := BelegTasten(FArt.Kuerzel, 'beleg');
  n := 0;
  for i := 0 to High(Tasten) do
    if Copy(Tasten[i].Aktion, 1, 6) = 'folge:' then
    begin
      Knopf := TButton.Create(Self);
      Knopf.Parent := PanelLeiste;
      Knopf.Height := 22;
      Knopf.Top := 16;
      Knopf.Width := 78;
      Knopf.Caption := Tasten[i].Beschriftung;
      Knopf.Hint := Copy(Tasten[i].Aktion, 7, 80);
      Knopf.OnClick := @FolgeKlick;
      Knopf.Enabled := Tasten[i].Erlaubt;
      SetLength(FFolge, n + 1);
      FFolge[n] := Knopf;
      Inc(n);
    end;
end;

procedure TBelegfenster.FolgeKlick(Sender: TObject);
begin
  Folge(TButton(Sender).Hint);
end;

procedure TBelegfenster.LeisteOrdnen(Sender: TObject);
var
  Knopfe: array[0..16] of TButton;
  Schilder: array[0..16] of TLabel;
  Anzahl, i, Rest, Slot, Breite, Links: Integer;

  procedure Dazu(Knopf: TButton; Schild: TLabel);
  begin
    if (Knopf = nil) or (Anzahl > High(Knopfe)) then
      Exit;
    Knopfe[Anzahl] := Knopf;
    Schilder[Anzahl] := Schild;
    Inc(Anzahl);
  end;

begin
  if (PanelLeiste = nil) or (ButtonSpeichern = nil) then
    Exit;
  ButtonSpeichern.Anchors := [akTop];
  LabelF10.Anchors := [akTop];
  ButtonSpeichern.Width := 92;
  ButtonSpeichern.Left := PanelLeiste.ClientWidth - ButtonSpeichern.Width - 4;
  ButtonSpeichern.Top := 16;
  LabelF10.Left := ButtonSpeichern.Left;
  LabelF10.Width := ButtonSpeichern.Width;
  Anzahl := 0;
  Dazu(ButtonAbbrechen, LabelEsc);
  Dazu(ButtonNeu, LabelF2);
  Dazu(ButtonAusgabe, LabelF3);
  Dazu(ButtonSuchen, LabelF4);
  Dazu(ButtonKopieren, LabelF5);
  Dazu(ButtonAendern, LabelF6);
  Dazu(ButtonLoeschen, LabelF8);
  for i := 0 to High(FFolge) do
    Dazu(FFolge[i], nil);
  if Anzahl = 0 then
    Exit;
  Rest := ButtonSpeichern.Left - 4;
  if Rest < Anzahl * 36 then
    Rest := Anzahl * 36;
  Slot := Rest div Anzahl;
  Breite := 70;
  if Slot - 4 < Breite then
    Breite := Slot - 4;
  if Breite < 36 then
    Breite := 36;
  for i := 0 to Anzahl - 1 do
  begin
    Links := i * Slot + (Slot - Breite) div 2;
    if Links < 0 then
      Links := 0;
    Knopfe[i].Anchors := [akTop];
    Knopfe[i].Width := Breite;
    Knopfe[i].Left := Links;
    Knopfe[i].Top := 16;
    if Schilder[i] <> nil then
    begin
      Schilder[i].Anchors := [akTop];
      Schilder[i].Left := Links;
      Schilder[i].Width := Breite;
    end;
  end;
end;

procedure TBelegfenster.FormZeigen(Sender: TObject);
var
  Satz: TFensterSatz;
begin
  FensterMerken(Self, 'beleg', FArt.Kuerzel);
  if not (FensterWirksam('beleg', FArt.Kuerzel, Satz) and (Satz.Breite > 40) and
     (Satz.Hoehe > 40)) then
  begin
    if FArt.Breite >= 515 then
      Width := FArt.Breite;
    if FArt.Hoehe >= 360 then
      Height := FArt.Hoehe;
  end;
  FensterAnwenden(Self);
  KlappenLesen;
  FelderFuellen;
  Gitter;
  Anordnen;
  SummenZeigen;
  FolgeKnopfe;
  Knoepfe;
  LeisteOrdnen(nil);
end;

procedure TBelegfenster.FormGeaendert(Sender: TObject);
begin
  if FRand <> nil then
    LeisteOrdnen(nil);
end;

procedure TBelegfenster.ZeileAnlegen;
var
  Index: Integer;
begin
  if not ZeileNeu then
  begin
    ShowMessage('Dafür fehlt das Recht.');
    Exit;
  end;
  PosTextSichern;
  Index := Length(FZeilen);
  SetLength(FZeilen, Index + 1);
  FZeilen[Index] := Default(TBelegPosition);
  FZeilen[Index].MengeMilli := 1000;
  FZeilen[Index].Einheit := 'Stück';
  if FArt.Mwst then
    FZeilen[Index].MwstSatz := FArt.MwstSatz
  else
    FZeilen[Index].MwstSatz := 0;
  FZeile := Index;
  Gitter;
  Knoepfe;
  MemoPos.SetFocus;
end;

procedure TBelegfenster.NeuKlick(Sender: TObject);
begin
  FMenuF2.PopUp(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TBelegfenster.KopierenKlick(Sender: TObject);
var
  Quelle, Index: Integer;
begin
  Quelle := Gewaehlt;
  if Quelle < 0 then
  begin
    ShowMessage('Bitte zuerst eine Position auswählen.');
    Exit;
  end;
  if not (ZeileNeu and Darf('kopieren')) then
  begin
    ShowMessage('Dafür fehlt das Recht.');
    Exit;
  end;
  PosTextSichern;
  Index := Length(FZeilen);
  SetLength(FZeilen, Index + 1);
  FZeilen[Index] := FZeilen[Quelle];
  FZeilen[Index].Id := 0;
  FZeile := Index;
  Gitter;
  Knoepfe;
  if CheckSofort.Checked then
    SummenZeigen;
end;

procedure TBelegfenster.AendernKlick(Sender: TObject);
begin
  if not ZeileNeu then
  begin
    ShowMessage('Dafür fehlt das Recht.');
    Exit;
  end;
  if Gewaehlt < 0 then
  begin
    ShowMessage('Bitte zuerst eine Position auswählen.');
    Exit;
  end;
  MemoPos.SetFocus;
end;

procedure TBelegfenster.LoeschenKlick(Sender: TObject);
var
  Index, i: Integer;
begin
  Index := Gewaehlt;
  if Index < 0 then
    Exit;
  if not ZeileLoeschen then
  begin
    ShowMessage('Dafür fehlt das Recht.');
    Exit;
  end;
  if MessageDlg('Position ' + IntToStr(Index + 1) + ' löschen?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  for i := Index to High(FZeilen) - 1 do
    FZeilen[i] := FZeilen[i + 1];
  SetLength(FZeilen, Length(FZeilen) - 1);
  if Index > High(FZeilen) then
    FZeile := High(FZeilen)
  else
    FZeile := Index;
  Gitter;
  Knoepfe;
  SummenZeigen;
end;

procedure TBelegfenster.KopfAusMaske;
begin
  FKopf.Modulart := FArt.Kuerzel;
  FKopf.Bezeichnung := Trim(EditBezeichnung.Text);
  FKopf.Kopftext := MemoKopf.Text;
  FKopf.Fusstext := MemoFuss.Text;
  FKopf.Notiz := MemoNotiz.Text;
  FKopf.IhrZeichen := Trim(EditZeichen.Text);
  FKopf.Erfasst := Trim(EditDatum.Text);
  FKopf.BriefkopfAn := CheckBriefkopf.Checked;
  if (ComboBriefkopf.ItemIndex >= 0) and
     (ComboBriefkopf.ItemIndex <= High(FBriefIds)) then
    FKopf.BriefkopfId := FBriefIds[ComboBriefkopf.ItemIndex];
  if FKopf.Gruppierung = '' then
    FKopf.Gruppierung := Trim(EditGruppe.Text);
end;

procedure TBelegfenster.AusgabeKlick(Sender: TObject);
var
  Vorlage: TDruckvorlage;
  Datei, Fehler, Meldung, Absender, Fusszeile: string;
  Seiten: Integer;
begin
  if not AktionZulaessig('beleg', FArt.Kuerzel, 'drucken', Meldung) then
  begin
    ShowMessage(Meldung);
    Exit;
  end;
  if not DruckvorlageFuer(FArt.Kuerzel, Vorlage) then
  begin
    ShowMessage('Für diese Belegart gibt es keine Druckvorlage.');
    Exit;
  end;
  PosTextSichern;
  KopfAusMaske;
  if FKopf.Nummer = '' then
    Datei := GetTempDir + 'planlos-neu.pdf'
  else
    Datei := GetTempDir + 'planlos-' + FKopf.Nummer + '.pdf';
  if FKopf.BriefkopfAn and BriefkopfLesen(FKopf.BriefkopfId, Absender, Fusszeile) then
  begin
    if Absender <> '' then
      Vorlage.Absender := Absender;
    if Fusszeile <> '' then
      Vorlage.Fusszeile := Fusszeile;
    GrafikVonBriefkopf(FKopf.BriefkopfId, Vorlage.GrafikArt, Vorlage.GrafikDaten);
  end
  else if not FKopf.BriefkopfAn then
  begin
    Vorlage.Absender := '';
    Vorlage.GrafikArt := '';
    Vorlage.GrafikDaten := '';
  end;
  if not BelegPdfSchreiben(FKopf, FZeilen, Vorlage, FArt.Bezeichnung,
    EditBearbeiter.Text, Datei, Seiten, Fehler) then
    ShowMessage(Fehler)
  else
  begin
    if Layouthinweis <> '' then
      ShowMessage('Das Drucklayout ist ungültig. Es gilt die bisherige Anordnung.' +
        LineEnding + Layouthinweis);
    if not OpenDocument(Datei) then
      ShowMessage('Die PDF-Datei liegt unter ' + Datei + ' (' + IntToStr(Seiten) +
        ' Seiten).');
  end;
end;

procedure TBelegfenster.ArtikelHolen;
var
  Id: Int64;
  Index: Integer;
  Artikel: TArtikel;
begin
  if not ZeileNeu then
  begin
    ShowMessage('Dafür fehlt das Recht.');
    Exit;
  end;
  if not ArtikelWaehlen(Id, FArt.Kuerzel) then
    Exit;
  if not uartikel.ArtikelLaden(Id, Artikel) then
    Exit;
  if Gewaehlt < 0 then
    ZeileAnlegen;
  Index := Gewaehlt;
  if Index < 0 then
    Exit;
  FZeilen[Index].ArtikelId := Artikel.Id;
  FZeilen[Index].Gruppe := Artikel.Gruppe;
  FZeilen[Index].ArtikelName := Artikel.Bezeichnung;
  if Trim(Artikel.PosText) <> '' then
    FZeilen[Index].Text := Artikel.PosText
  else
    FZeilen[Index].Text := Artikel.Bezeichnung;
  FZeilen[Index].EkCent := Artikel.EkCent;
  FZeilen[Index].EinheitEk := Artikel.EinheitEk;
  FZeilen[Index].AufschlagBp := Artikel.AufschlagBp;
  FZeilen[Index].RabattBp := 0;
  FZeilen[Index].EinzelpreisCent := VkCent(Artikel.EkCent, Artikel.AufschlagBp, 0);
  if Artikel.EinheitMenge <> '' then
    FZeilen[Index].Einheit := Artikel.EinheitMenge;
  if FArt.Mwst then
    FZeilen[Index].MwstSatz := Artikel.MwstSatz;
  if FZeilen[Index].MengeMilli = 0 then
    FZeilen[Index].MengeMilli := 1000;
  FZeile := Index;
  Gitter;
  SummenZeigen;
end;

procedure TBelegfenster.ProjektSuchen(Sender: TObject);
var
  Id: Int64;
  Projekt: TProjekt;
begin
  if not ZeileNeu then
    Exit;
  if not ListenWahl('projekt', False, Id) then
    Exit;
  FKopf.ProjektStammId := Id;
  if ProjektLaden(Id, Projekt) then
    EditProjekt.Text := Projekt.Bezeichnung;
end;

procedure TBelegfenster.AdresseSuchen(Sender: TObject);
var
  Id: Int64;
  Maske: string;
begin
  if not ZeileNeu then
    Exit;
  Maske := FArt.EmpfaengerMaske;
  if Maske = '' then
    Maske := 'kunde';
  if not ListenWahl(Maske, False, Id) then
    Exit;
  FKopf.AdresseId := Id;
  FKopf.AdresseText := AdressBlock(Id);
  EditAdresse.Text := StammBezeichnung('lieferant', Id);
  MemoAdresse.Text := FKopf.AdresseText;
end;

procedure TBelegfenster.GruppeSuchen(Sender: TObject);
var
  Id: Int64;
begin
  if not ZeileNeu then
    Exit;
  if not ListenWahl('gruppierung', False, Id) then
    Exit;
  FKopf.Gruppierung := StammBezeichnung('gruppierung', Id);
  EditGruppe.Text := FKopf.Gruppierung;
end;

procedure TBelegfenster.BearbeiterSuchen(Sender: TObject);
var
  Id: Int64;
begin
  if not ZeileNeu then
    Exit;
  if not ListenWahl('mitarbeiter', False, Id) then
    Exit;
  FKopf.BearbeiterId := Id;
  EditBearbeiter.Text := StammBezeichnung('lieferant', Id);
end;

procedure TBelegfenster.KopftextSuchen(Sender: TObject);
var
  Id: Int64;
begin
  if not ZeileNeu then
    Exit;
  if not TextbausteinWaehlen('Kopftext', Id) then
    Exit;
  FKopf.KopfBausteinId := Id;
  MemoKopf.Text := TextbausteinInhalt(Id);
end;

procedure TBelegfenster.FusstextSuchen(Sender: TObject);
var
  Id: Int64;
begin
  if not ZeileNeu then
    Exit;
  if not TextbausteinWaehlen('Fusstext', Id) then
    Exit;
  FKopf.FussBausteinId := Id;
  MemoFuss.Text := TextbausteinInhalt(Id);
end;

procedure TBelegfenster.DatumHeute(Sender: TObject);
begin
  if not ZeileNeu then
    Exit;
  FKopf.Erfasst := FormatDateTime('yyyy-mm-dd', Now);
  EditDatum.Text := FKopf.Erfasst;
end;

procedure TBelegfenster.Suchen;
var
  Ziel: TWinControl;
begin
  Ziel := ActiveControl;
  if Ziel = EditProjekt then
    ProjektSuchen(nil)
  else if (Ziel = EditAdresse) or (Ziel = MemoAdresse) then
    AdresseSuchen(nil)
  else if Ziel = EditGruppe then
    GruppeSuchen(nil)
  else if Ziel = EditBearbeiter then
    BearbeiterSuchen(nil)
  else if Ziel = EditDatum then
    DatumHeute(nil)
  else if Ziel = MemoKopf then
    KopftextSuchen(nil)
  else if Ziel = MemoFuss then
    FusstextSuchen(nil)
  else if FArt.Positionen then
    ArtikelHolen
  else
    AdresseSuchen(nil);
end;

procedure TBelegfenster.SuchenKlick(Sender: TObject);
begin
  Suchen;
end;

function TBelegfenster.SpeichernStill(out Fehler: string): Int64;
begin
  Result := 0;
  if GridPos.EditorMode then
    GridPos.EditorMode := False;
  PosTextSichern;
  PositionenAufraeumen(FZeilen);
  if (FZeile < 0) or (FZeile > High(FZeilen)) then
    FZeile := High(FZeilen);
  Gitter;
  KopfAusMaske;
  Result := BelegSpeichern(FKopf, FZeilen, Fehler);
  if Result > 0 then
    Caption := FArt.Bezeichnung + ' ' + FKopf.Nummer;
end;

procedure TBelegfenster.SpeichernKlick(Sender: TObject);
var
  Fehler: string;
begin
  if FKopf.Id = 0 then
  begin
    if not Darf('neu') then
    begin
      ShowMessage('Dafür fehlt das Recht.');
      Exit;
    end;
  end
  else if not Darf('aendern') then
  begin
    ShowMessage('Dafür fehlt das Recht.');
    Exit;
  end;
  if SpeichernStill(Fehler) = 0 then
    ShowMessage(Fehler)
  else
    ModalResult := mrOk;
end;

procedure TBelegfenster.AbbrechenKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TBelegfenster.Folge(const ZielKuerzel: string);
var
  Fehler: string;
  Neu, Bisher: Int64;
begin
  Bisher := SpeichernStill(Fehler);
  if Bisher = 0 then
  begin
    ShowMessage(Fehler);
    Exit;
  end;
  if not AktionZulaessig('beleg', ZielKuerzel, 'neu', Fehler) then
  begin
    ShowMessage(Fehler);
    Exit;
  end;
  Neu := FolgebelegErzeugen(Bisher, ZielKuerzel, Fehler);
  if Neu = 0 then
    ShowMessage(Fehler)
  else
    BelegBearbeiten('', Neu);
end;

procedure TBelegfenster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Memo: Boolean;
begin
  Memo := (ActiveControl = MemoKopf) or (ActiveControl = MemoFuss) or
    (ActiveControl = MemoNotiz) or (ActiveControl = MemoPos) or
    (ActiveControl = MemoAdresse) or (ActiveControl = MemoExtern) or
    (ActiveControl = MemoIntern);
  if (Key = VK_ESCAPE) or ((ssShift in Shift) and (Key = VK_ESCAPE)) then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end
  else if Key = VK_F12 then
    Key := 0
  else if (ssShift in Shift) and (Key = VK_F6) then
  begin
    ShowMessage('Die Einstellung der Belegart folgt später.');
    Key := 0;
  end
  else if Key = VK_F2 then
  begin
    FMenuF2.PopUp(Mouse.CursorPos.X, Mouse.CursorPos.Y);
    Key := 0;
  end
  else if Key = VK_F3 then
  begin
    AusgabeKlick(nil);
    Key := 0;
  end
  else if Key = VK_F4 then
  begin
    Suchen;
    Key := 0;
  end
  else if Key = VK_F5 then
  begin
    KopierenKlick(nil);
    Key := 0;
  end
  else if Key = VK_F6 then
  begin
    AendernKlick(nil);
    Key := 0;
  end
  else if Key = VK_F8 then
  begin
    LoeschenKlick(nil);
    Key := 0;
  end
  else if Key = VK_F10 then
  begin
    SpeichernKlick(nil);
    Key := 0;
  end
  else if (Key = VK_RETURN) and (Shift = []) and not Memo and
          (ActiveControl <> GridPos) and (ActiveControl <> nil) then
  begin
    SelectNext(ActiveControl, True, True);
    Key := 0;
  end;
end;

end.
