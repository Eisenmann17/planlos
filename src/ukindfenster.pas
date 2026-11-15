unit ukindfenster;

{ Leeres Zusatzfenster. Es zeigt die Kaskade, noch keine Maske.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, LCLType,
  utastenleiste, udatenbank;

const
  KaskadenAnfangLinks = 24;
  KaskadenAnfangOben = 24;

type
  TKindfenster = class(TForm)
  private
    FText: TMemo;
    FTasten: TTastenleiste;
    FNummer: Integer;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure TasteAusfuehren(Sender: TObject; Ebene, Taste: Integer);
  public
    constructor Create(TheOwner: TComponent); override;
    procedure SetzeNummer(Nummer: Integer);
    procedure TextAktualisieren;
  end;

function KindfensterOeffnen: TKindfenster;
procedure AlleKindfensterSchliessen;
procedure KaskadeUmschaltenUndSagen;

implementation

function KindfensterOeffnen: TKindfenster;
var
  i, Vorhanden, Index: Integer;
begin
  Vorhanden := 0;
  for i := 0 to Screen.FormCount - 1 do
    if Screen.Forms[i] is TKindfenster then
      Inc(Vorhanden);
  Result := TKindfenster.Create(Application);
  Result.Position := poDesigned;
  if KaskadeAktiv then
  begin
    Index := Vorhanden mod 15;
    Result.Left := KaskadenAnfangLinks + Index * KaskadenSchritt('schritt_links', 9);
    Result.Top := KaskadenAnfangOben + Index * KaskadenSchritt('schritt_oben', 26);
  end
  else
  begin
    Result.Left := KaskadenAnfangLinks;
    Result.Top := KaskadenAnfangOben;
  end;
  Result.SetzeNummer(Vorhanden + 1);
  Result.Show;
end;

procedure AlleKindfensterSchliessen;
var
  i: Integer;
begin
  for i := Screen.FormCount - 1 downto 0 do
    if Screen.Forms[i] is TKindfenster then
      Screen.Forms[i].Close;
end;

procedure KaskadeUmschaltenUndSagen;
begin
  KaskadeUmschalten;
  if KaskadeAktiv then
    ShowMessage('Neue Fenster öffnen sich versetzt von links oben.')
  else
    ShowMessage('Neue Fenster öffnen sich alle an derselben Stelle.');
end;

constructor TKindfenster.Create(TheOwner: TComponent);
begin
  inherited CreateNew(TheOwner, 1);
  Caption := 'Planlos - Fenster';
  Position := poDesigned;
  Width := 640;
  Height := 420;
  KeyPreview := True;
  OnKeyDown := @FormKeyDown;
  OnClose := @FormClose;

  FTasten := TTastenleiste.Create(Self);
  FTasten.Parent := Self;
  FTasten.Align := alBottom;
  FTasten.Height := 96;
  FTasten.OnTaste := @TasteAusfuehren;
  StandardBelegung(FTasten);

  FText := TMemo.Create(Self);
  FText.Parent := Self;
  FText.Align := alClient;
  FText.ReadOnly := True;
  FText.WordWrap := True;
  FText.ScrollBars := ssVertical;
  FText.TabStop := False;
  FText.BorderSpacing.Around := 8;
end;

procedure TKindfenster.SetzeNummer(Nummer: Integer);
begin
  FNummer := Nummer;
  Caption := 'Planlos - Fenster ' + IntToStr(FNummer);
  TextAktualisieren;
end;

procedure TKindfenster.TextAktualisieren;
var
  Kaskade: string;
begin
  if FText = nil then
    Exit;
  if KaskadeAktiv then
    Kaskade := 'ein'
  else
    Kaskade := 'aus';
  FText.Lines.Text :=
    'Platzhalterfenster ' + IntToStr(FNummer) + LineEnding +
    LineEnding +
    'Hier ist noch keine Maske. Das Fenster zeigt nur, dass Planlos' + LineEnding +
    'weitere Fenster öffnen kann. Steht die Kaskade auf ein, liegt jedes' + LineEnding +
    'neue Fenster ein Stück weiter unten und rechts.' + LineEnding +
    LineEnding +
    'Position: ' + IntToStr(Left) + ' von links, ' + IntToStr(Top) + ' von oben.' + LineEnding +
    'Kaskade: ' + Kaskade + '.' + LineEnding +
    'Schritt: ' + IntToStr(KaskadenSchritt('schritt_oben', 26)) +
    ' nach unten, ' + IntToStr(KaskadenSchritt('schritt_links', 9)) + ' nach rechts.' + LineEnding +
    LineEnding +
    'F3 öffnet ein weiteres Fenster.' + LineEnding +
    'F12 oder Esc schließt dieses Fenster.' + LineEnding +
    'Umschalt+F3 schaltet die Kaskade an oder aus.';
end;

procedure TKindfenster.TasteAusfuehren(Sender: TObject; Ebene, Taste: Integer);
begin
  if Ebene = 1 then
    case Taste of
      1: ZeigeHilfe(False);
      2: HinweisNochOffen('Neu');
      3: KindfensterOeffnen;
      4: HinweisNochOffen('Suchen');
      5: HinweisNochOffen('Ändern');
      6: HinweisNochOffen('Drucken');
      7: HinweisNochOffen('Sortieren');
      8: HinweisNochOffen('Löschen');
      9: HinweisNochOffen('Filter');
      10: HinweisNochOffen('Speichern');
      11: if (PlanlosDB <> nil) and PlanlosDB.Verbunden then
            ShowMessage(PlanlosDB.Bericht)
          else
            ShowMessage('Die Datenbank ist nicht geöffnet.');
      12: Close;
    end
  else if Ebene = 2 then
    case Taste of
      1: ZeigeTastenhilfe;
      3: KaskadeUmschaltenUndSagen;
      11: ShowMessage('Datenbankdatei:' + LineEnding + PlanlosDatenDatei);
      12: AlleKindfensterSchliessen;
    end
  else if Ebene = 3 then
    case Taste of
      1: ZeigeUeberPlanlos;
      4, 12: Close;
    end;
end;

procedure TKindfenster.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Close;
    Key := 0;
    Exit;
  end;
  if (Key >= VK_F1) and (Key <= VK_F12) then
  begin
    AlleLeistenNachziehen;
    TasteAusfuehren(Self, AktuelleEbene, Key - VK_F1 + 1);
    Key := 0;
  end;
end;

procedure TKindfenster.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.
