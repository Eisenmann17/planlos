unit utastenleiste;

{ Tastenleiste F1 bis F12 mit drei Ebenen.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE.

  Ebene 1 ist die normale Beschriftung.
  Ebene 2 gilt, solange die Umschalttaste gehalten wird.
  Ebene 3 gilt, solange die Alt-Taste gehalten wird.
  Die drei Knöpfe darüber legen eine Ebene fest, damit man sie
  auch anklicken kann, ohne die Taste gedrückt zu halten.
  Eine wirklich gehaltene Umschalt- oder Alt-Taste gewinnt. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Controls, ExtCtrls, StdCtrls, Buttons, Dialogs, Graphics,
  LCLType, LCLIntf;

const
  TastenAnzahl = 12;
  EbenenAnzahl = 3;

type
  TTastenEreignis = procedure(Sender: TObject; Ebene, Taste: Integer) of object;

  TTastenleiste = class(TCustomPanel)
  private
    FKopf: TPanel;
    FHinweis: TLabel;
    FWahl: array[1..EbenenAnzahl] of TSpeedButton;
    FFlaeche: TPanel;
    FButtons: array[1..TastenAnzahl] of TButton;
    FTexte: array[1..EbenenAnzahl, 1..TastenAnzahl] of string;
    FFrei: array[1..EbenenAnzahl, 1..TastenAnzahl] of Boolean;
    FEbene: Integer;
    FFestGesehen: Integer;
    FIntern: Boolean;
    FOnTaste: TTastenEreignis;
    procedure WahlKlick(Sender: TObject);
    procedure Klick(Sender: TObject);
    procedure KopfAnordnen(Sender: TObject);
    procedure TastenAnordnen(Sender: TObject);
    procedure ButtonsNachEbene;
    procedure WahlAnzeigen;
    procedure ZeigeEbene(Ebene: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetzeText(Ebene, Taste: Integer; const Beschriftung: string);
    procedure SetzeTaste(Ebene, Taste: Integer; const Beschriftung: string;
      Frei: Boolean);
    procedure AlleBeschriftungenLoeschen;
    procedure Nachziehen;
    property OnTaste: TTastenEreignis read FOnTaste write FOnTaste;
  end;

function AktuelleEbene: Integer;
procedure AlleLeistenNachziehen;
procedure StandardBelegung(Leiste: TTastenleiste);
procedure HinweisNochOffen(const Aktion: string);
procedure ZeigeHilfe(Hauptfenster: Boolean);
procedure ZeigeTastenhilfe;
procedure ZeigeUeberPlanlos;

implementation

var
  Leisten: TList;
  FestEbeneGlobal: Integer;

function TasteUnten(Code: Integer): Boolean;
begin
  Result := (GetKeyState(Code) and $8000) <> 0;
end;

function AktuelleEbene: Integer;
begin
  if TasteUnten(VK_MENU) then
    Exit(3);
  if TasteUnten(VK_SHIFT) then
    Exit(2);
  if FestEbeneGlobal in [1..EbenenAnzahl] then
    Exit(FestEbeneGlobal);
  Result := 1;
end;

procedure AlleLeistenNachziehen;
var
  i: Integer;
begin
  if Leisten = nil then
    Exit;
  for i := 0 to Leisten.Count - 1 do
    TTastenleiste(Leisten[i]).Nachziehen;
end;

procedure StandardBelegung(Leiste: TTastenleiste);
const
  Normal: array[1..TastenAnzahl] of string = (
    'Hilfe', 'Neu', 'Fenster', 'Suchen', 'Ändern', 'Drucken',
    'Sortieren', 'Löschen', 'Filter', 'Speichern', 'Datenbank', 'Schließen');
  Umschalt: array[1..TastenAnzahl] of string = (
    'Tasten', '', 'Kaskade', '', '', '',
    '', '', '', '', 'Datei', 'Alle zu');
  Alt: array[1..TastenAnzahl] of string = (
    'Über', '', '', 'Beenden', '', '',
    '', '', '', '', '', 'Beenden');
var
  i: Integer;
begin
  for i := 1 to TastenAnzahl do
  begin
    Leiste.SetzeText(1, i, Normal[i]);
    Leiste.SetzeText(2, i, Umschalt[i]);
    Leiste.SetzeText(3, i, Alt[i]);
  end;
end;

procedure HinweisNochOffen(const Aktion: string);
begin
  ShowMessage(Aktion + ' gibt es in dieser Fassung noch nicht.');
end;

procedure ZeigeHilfe(Hauptfenster: Boolean);
var
  Text: string;
begin
  Text :=
    'Planlos, Grundgerüst' + LineEnding +
    LineEnding +
    'Unten liegen die Tasten F1 bis F12. Drücken oder anklicken.' + LineEnding +
    'Umschalt zeigt die zweite Beschriftung, Alt die dritte.' + LineEnding +
    'Wer die Taste nicht halten will, klickt oben auf Normal, Umschalt oder Alt.' + LineEnding +
    LineEnding +
    'F3 öffnet ein weiteres Fenster, versetzt von links oben.' + LineEnding +
    'F11 zeigt, was in der Datenbank steht.' + LineEnding +
    'F12 schließt das Fenster.';
  if Hauptfenster then
    Text := Text + ' Im Hauptfenster beendet das das Programm.'
  else
    Text := Text + LineEnding + 'Esc schließt dieses Zusatzfenster ebenfalls.';
  Text := Text + LineEnding + LineEnding +
    'Kunden, Lieferanten, Kontakte und Mitarbeiter stehen unter Stammdaten.' +
    LineEnding + 'Im Hauptfenster öffnet F4 die Kundensuche.' +
    LineEnding + 'F2 legt einen Beleg der gewählten Art an, F6 öffnet die Zeile.';
  ShowMessage(Text);
end;

procedure ZeigeTastenhilfe;
begin
  ShowMessage(
    'Die Leiste hat drei Ebenen.' + LineEnding +
    LineEnding +
    'Normal: die Beschriftung ohne Zusatztaste.' + LineEnding +
    'Umschalt: die Umschalttaste halten, oder oben auf Umschalt klicken.' + LineEnding +
    'Alt: die Alt-Taste halten, oder oben auf Alt klicken.' + LineEnding +
    LineEnding +
    'Solange Umschalt oder Alt wirklich gehalten werden, gilt diese Ebene,' + LineEnding +
    'auch wenn oben etwas anderes fest gewählt ist.');
end;

procedure ZeigeUeberPlanlos;
begin
  ShowMessage(
    'Planlos' + LineEnding +
    'Freies Programm für Angebote und Rechnungen.' + LineEnding +
    LineEnding +
    'Copyright (C) 2026 Günther Stadtler' + LineEnding +
    'Lizenz: GNU GPL, Version 3' + LineEnding +
    LineEnding +
    'Anmelden, Adressen und Belege. Die Masken richten sich nach der Datenbank.');
end;

constructor TTastenleiste.Create(AOwner: TComponent);
var
  i, e: Integer;
begin
  inherited Create(AOwner);
  BevelOuter := bvNone;
  Caption := '';
  FEbene := 0;
  FFestGesehen := 0;
  if FestEbeneGlobal = 0 then
    FestEbeneGlobal := 1;
  if Leisten = nil then
    Leisten := TList.Create;
  Leisten.Add(Self);

  FKopf := TPanel.Create(Self);
  FKopf.Parent := Self;
  FKopf.Align := alTop;
  FKopf.Height := 30;
  FKopf.BevelOuter := bvNone;
  FKopf.Caption := '';
  FKopf.OnResize := @KopfAnordnen;

  FHinweis := TLabel.Create(Self);
  FHinweis.Parent := FKopf;
  FHinweis.AutoSize := False;
  FHinweis.Layout := tlCenter;
  FHinweis.Font.Style := [fsBold];

  for i := 1 to EbenenAnzahl do
  begin
    FWahl[i] := TSpeedButton.Create(Self);
    FWahl[i].Parent := FKopf;
    FWahl[i].Tag := i;
    FWahl[i].GroupIndex := 7;
    FWahl[i].AllowAllUp := False;
    FWahl[i].OnClick := @WahlKlick;
  end;
  FWahl[1].Caption := 'Normal';
  FWahl[2].Caption := 'Umschalt';
  FWahl[3].Caption := 'Alt';

  FFlaeche := TPanel.Create(Self);
  FFlaeche.Parent := Self;
  FFlaeche.Align := alClient;
  FFlaeche.BevelOuter := bvNone;
  FFlaeche.Caption := '';
  FFlaeche.OnResize := @TastenAnordnen;

  for e := 1 to EbenenAnzahl do
    for i := 1 to TastenAnzahl do
      FTexte[e, i] := '';

  for i := 1 to TastenAnzahl do
  begin
    FButtons[i] := TButton.Create(Self);
    FButtons[i].Parent := FFlaeche;
    FButtons[i].Tag := i;
    FButtons[i].OnClick := @Klick;
    FButtons[i].TabStop := False;
    FButtons[i].ShowHint := True;
  end;

  FIntern := True;
  FWahl[1].Down := True;
  FIntern := False;
  Nachziehen;
end;

destructor TTastenleiste.Destroy;
begin
  if Leisten <> nil then
    Leisten.Remove(Self);
  inherited Destroy;
end;

procedure TTastenleiste.SetzeText(Ebene, Taste: Integer; const Beschriftung: string);
begin
  if (Ebene < 1) or (Ebene > EbenenAnzahl) then
    Exit;
  if (Taste < 1) or (Taste > TastenAnzahl) then
    Exit;
  FTexte[Ebene, Taste] := Beschriftung;
  FFrei[Ebene, Taste] := Trim(Beschriftung) <> '';
  if Ebene = FEbene then
    ButtonsNachEbene;
end;

procedure TTastenleiste.SetzeTaste(Ebene, Taste: Integer;
  const Beschriftung: string; Frei: Boolean);
begin
  if (Ebene < 1) or (Ebene > EbenenAnzahl) then
    Exit;
  if (Taste < 1) or (Taste > TastenAnzahl) then
    Exit;
  FTexte[Ebene, Taste] := Beschriftung;
  FFrei[Ebene, Taste] := Frei and (Trim(Beschriftung) <> '');
  if Ebene = FEbene then
    ButtonsNachEbene;
end;

procedure TTastenleiste.AlleBeschriftungenLoeschen;
var
  Ebene, Taste: Integer;
begin
  for Ebene := 1 to EbenenAnzahl do
    for Taste := 1 to TastenAnzahl do
    begin
      FTexte[Ebene, Taste] := '';
      FFrei[Ebene, Taste] := False;
    end;
  ButtonsNachEbene;
end;

procedure TTastenleiste.Nachziehen;
var
  E: Integer;
begin
  E := AktuelleEbene;
  if (E = FEbene) and (FFestGesehen = FestEbeneGlobal) then
    Exit;
  FFestGesehen := FestEbeneGlobal;
  ZeigeEbene(E);
end;

procedure TTastenleiste.ZeigeEbene(Ebene: Integer);
begin
  if (Ebene < 1) or (Ebene > EbenenAnzahl) then
    Ebene := 1;
  FEbene := Ebene;
  case Ebene of
    2: FHinweis.Caption := 'Ebene: Umschalt';
    3: FHinweis.Caption := 'Ebene: Alt';
  else
    FHinweis.Caption := 'Ebene: Normal';
  end;
  WahlAnzeigen;
  ButtonsNachEbene;
end;

procedure TTastenleiste.WahlAnzeigen;
var
  i: Integer;
  Soll: Boolean;
begin
  FIntern := True;
  try
    for i := 1 to EbenenAnzahl do
    begin
      if i = 1 then
        Soll := FestEbeneGlobal <= 1
      else
        Soll := FestEbeneGlobal = i;
      if FWahl[i].Down <> Soll then
        FWahl[i].Down := Soll;
    end;
  finally
    FIntern := False;
  end;
end;

procedure TTastenleiste.ButtonsNachEbene;
var
  i: Integer;
  Beschriftung, Vorsatz: string;
begin
  case FEbene of
    2: Vorsatz := 'Umschalt+';
    3: Vorsatz := 'Alt+';
  else
    Vorsatz := '';
  end;
  for i := 1 to TastenAnzahl do
  begin
    Beschriftung := Trim(FTexte[FEbene, i]);
    if Beschriftung = '' then
    begin
      FButtons[i].Caption := 'F' + IntToStr(i);
      FButtons[i].Enabled := False;
      FButtons[i].Hint := '';
    end
    else
    begin
      FButtons[i].Caption := 'F' + IntToStr(i) + LineEnding + Beschriftung;
      FButtons[i].Enabled := FFrei[FEbene, i];
      FButtons[i].Hint := Vorsatz + 'F' + IntToStr(i) + '  ' + Beschriftung;
    end;
  end;
end;

procedure TTastenleiste.WahlKlick(Sender: TObject);
begin
  if FIntern then
    Exit;
  FestEbeneGlobal := TComponent(Sender).Tag;
  AlleLeistenNachziehen;
end;

procedure TTastenleiste.Klick(Sender: TObject);
var
  Taste, Ebene: Integer;
begin
  Taste := TButton(Sender).Tag;
  Ebene := AktuelleEbene;
  Nachziehen;
  if (Taste < 1) or (Taste > TastenAnzahl) then
    Exit;
  if not FButtons[Taste].Enabled then
    Exit;
  if Assigned(FOnTaste) then
    FOnTaste(Self, Ebene, Taste);
end;

procedure TTastenleiste.KopfAnordnen(Sender: TObject);
var
  i, Rechts, Breite: Integer;
begin
  Breite := 92;
  Rechts := FKopf.ClientWidth - 4;
  for i := EbenenAnzahl downto 1 do
  begin
    FWahl[i].SetBounds(Rechts - Breite, 3, Breite, FKopf.ClientHeight - 6);
    Rechts := Rechts - Breite - 4;
  end;
  FHinweis.SetBounds(8, 2, Rechts - 12, FKopf.ClientHeight - 4);
end;

procedure TTastenleiste.TastenAnordnen(Sender: TObject);
var
  i, Breite, Rest, Links: Integer;
begin
  if FFlaeche.ClientWidth < TastenAnzahl then
    Exit;
  Breite := FFlaeche.ClientWidth div TastenAnzahl;
  Rest := FFlaeche.ClientWidth - Breite * TastenAnzahl;
  Links := 0;
  for i := 1 to TastenAnzahl do
  begin
    FButtons[i].Top := 0;
    FButtons[i].Height := FFlaeche.ClientHeight;
    if i <= Rest then
      FButtons[i].Width := Breite + 1
    else
      FButtons[i].Width := Breite;
    FButtons[i].Left := Links;
    Links := Links + FButtons[i].Width;
  end;
end;

end.
