unit uhaupt;

{ Hauptfenster von Planlos.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE.

  Das Fenster erklärt den Stand, zeigt die Datenbank und trägt die
  Tastenleiste. F3 öffnet leere Zusatzfenster in der Kaskade.
  Fertige Masken gibt es noch nicht. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Menus,
  Graphics, LCLType, utastenleiste, ukindfenster, udatenbank, umaske,
  usuche, ueingabe, ubelegsuche;

type
  THauptfenster = class(TForm)
  private
    FText: TMemo;
    FStatus: TLabel;
    FFuss: TPanel;
    FTasten: TTastenleiste;
    FTakt: TTimer;
    FDbFehler: string;
    FSelbsttest: Boolean;
    FSelbsttestGelaufen: Boolean;
    procedure BaueMenue;
    procedure MenueBeenden(Sender: TObject);
    procedure MenueFenster(Sender: TObject);
    procedure MenueKaskade(Sender: TObject);
    procedure MenueAlleZu(Sender: TObject);
    procedure MenueHilfe(Sender: TObject);
    procedure MenueDatenbank(Sender: TObject);
    procedure MenueUeber(Sender: TObject);
    procedure MenueKunde(Sender: TObject);
    procedure MenueLieferant(Sender: TObject);
    procedure MenueKontakt(Sender: TObject);
    procedure MenueMitarbeiter(Sender: TObject);
    procedure MenueAngebot(Sender: TObject);
    procedure MenueAuftrag(Sender: TObject);
    procedure MenueBestellung(Sender: TObject);
    procedure MenueRechnung(Sender: TObject);
    procedure MenueProjekt(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure TaktTimer(Sender: TObject);
    procedure TasteAusfuehren(Sender: TObject; Ebene, Taste: Integer);
    procedure AnsichtNachziehen(Sender: TObject);
    procedure DatenbankOeffnen;
    procedure Selbsttest;
  public
    constructor Create(TheOwner: TComponent); override;
    procedure AnsichtAktualisieren;
  end;

var
  Hauptfenster: THauptfenster;

implementation

constructor THauptfenster.Create(TheOwner: TComponent);
begin
  inherited CreateNew(TheOwner, 1);
  Caption := 'Planlos';
  Position := poScreenCenter;
  Width := 980;
  Height := 640;
  KeyPreview := True;
  Constraints.MinWidth := 780;
  Constraints.MinHeight := 460;
  OnKeyDown := @FormKeyDown;
  OnShow := @FormShow;

  FFuss := TPanel.Create(Self);
  FFuss.Parent := Self;
  FFuss.Align := alBottom;
  FFuss.Height := 118;
  FFuss.BevelOuter := bvNone;
  FFuss.Caption := '';

  FStatus := TLabel.Create(Self);
  FStatus.Parent := FFuss;
  FStatus.Align := alBottom;
  FStatus.Height := 20;
  FStatus.AutoSize := False;
  FStatus.Layout := tlCenter;
  FStatus.Caption := 'Datenbank wird geöffnet …';
  FStatus.BorderSpacing.Left := 8;

  FTasten := TTastenleiste.Create(Self);
  FTasten.Parent := FFuss;
  FTasten.Align := alClient;
  FTasten.OnTaste := @TasteAusfuehren;
  StandardBelegung(FTasten);
  FTasten.SetzeText(1, 4, 'Kunden');

  FText := TMemo.Create(Self);
  FText.Parent := Self;
  FText.Align := alClient;
  FText.ReadOnly := True;
  FText.WordWrap := True;
  FText.ScrollBars := ssVertical;
  FText.TabStop := False;
  FText.BorderSpacing.Around := 10;

  BaueMenue;
  DatenbankOeffnen;
  WennAnsichtVeraltet := @AnsichtNachziehen;
  AnsichtAktualisieren;

  FTakt := TTimer.Create(Self);
  FTakt.Interval := 100;
  FTakt.OnTimer := @TaktTimer;
  FTakt.Enabled := True;

  FSelbsttest := GetEnvironmentVariable('PLANLOS_SELBSTTEST') = '1';
end;

procedure THauptfenster.BaueMenue;
var
  Menue: TMainMenu;
  Datei, Fenster, Hilfe: TMenuItem;

  function Eintrag(Eltern: TMenuItem; const Titel: string;
    Reaktion: TNotifyEvent): TMenuItem;
  begin
    Result := TMenuItem.Create(Self);
    Result.Caption := Titel;
    Result.OnClick := Reaktion;
    Eltern.Add(Result);
  end;

begin
  Menue := TMainMenu.Create(Self);
  Menu := Menue;

  Datei := TMenuItem.Create(Self);
  Datei.Caption := '&Datei';
  Menue.Items.Add(Datei);
  Eintrag(Datei, '&Beenden', @MenueBeenden);

  Fenster := TMenuItem.Create(Self);
  Fenster.Caption := '&Fenster';
  Menue.Items.Add(Fenster);
  Eintrag(Fenster, '&Neues Fenster', @MenueFenster);
  Eintrag(Fenster, '&Kaskade umschalten', @MenueKaskade);
  Eintrag(Fenster, '&Alle Zusatzfenster schließen', @MenueAlleZu);

  Fenster := TMenuItem.Create(Self);
  Fenster.Caption := '&Adressen';
  Menue.Items.Add(Fenster);
  Eintrag(Fenster, '&Kunden', @MenueKunde);
  Eintrag(Fenster, '&Lieferanten', @MenueLieferant);
  Eintrag(Fenster, '&Kontakte', @MenueKontakt);
  Eintrag(Fenster, '&Mitarbeiter', @MenueMitarbeiter);

  Fenster := TMenuItem.Create(Self);
  Fenster.Caption := '&Belege';
  Menue.Items.Add(Fenster);
  Eintrag(Fenster, '&Angebot', @MenueAngebot);
  Eintrag(Fenster, 'Auftrags&bestätigung', @MenueAuftrag);
  Eintrag(Fenster, '&Bestellung', @MenueBestellung);
  Eintrag(Fenster, '&Rechnung', @MenueRechnung);
  Eintrag(Fenster, '&Projekt', @MenueProjekt);

  Hilfe := TMenuItem.Create(Self);
  Hilfe.Caption := '&Hilfe';
  Menue.Items.Add(Hilfe);
  Eintrag(Hilfe, '&Hilfe', @MenueHilfe);
  Eintrag(Hilfe, '&Datenbank', @MenueDatenbank);
  Eintrag(Hilfe, 'Über &Planlos', @MenueUeber);
end;

procedure THauptfenster.DatenbankOeffnen;
begin
  FDbFehler := '';
  try
    PlanlosDB := TPlanlosDatenbank.Create;
    PlanlosDB.VerbindenSQLite(PlanlosDatenDatei);
    PlanlosDB.SchemaSicherstellen;
  except
    on E: Exception do
      FDbFehler := E.Message;
  end;
end;

procedure THauptfenster.AnsichtAktualisieren;
var
  Kaskade, Einleitung: string;
begin
  if FText = nil then
    Exit;
  Einleitung :=
    'Planlos' + LineEnding +
    LineEnding +
    'Adressen und Belege sind je ein Fenster. Die Art steht in der Datenbank.' + LineEnding +
    'Menü Adressen: Kunde, Lieferant, Kontakt, Mitarbeiter. F4 öffnet Kunden.' + LineEnding +
    'Menü Belege: Angebot, Auftragsbestätigung, Bestellung, Rechnung, Projekt.' + LineEnding +
    'In der Liste legt F2 neu an. Im Beleg wählt F3 den Empfänger.' + LineEnding +
    LineEnding +
    'Unten liegt die Tastenleiste. F1 bis F12 sind anklickbar.' + LineEnding +
    'Umschalt und Alt wechseln die Beschriftung.' + LineEnding +
    'F3 öffnet ein leeres Fenster in der Kaskade, F12 beendet das Programm.' +
    LineEnding + LineEnding;

  if FDbFehler <> '' then
  begin
    FText.Lines.Text := Einleitung +
      'Die Datenbank konnte nicht geöffnet werden.' + LineEnding +
      LineEnding + FDbFehler + LineEnding +
      LineEnding +
      'Die Tastenleiste bleibt benutzbar. Neue Fenster nehmen dann den' + LineEnding +
      'eingebauten Versatz, 26 nach unten und 9 nach rechts.';
    FStatus.Caption := 'Datenbank nicht geöffnet';
    Exit;
  end;

  if KaskadeAktiv then
    Kaskade := 'ein'
  else
    Kaskade := 'aus';
  FText.Lines.Text := Einleitung + PlanlosDB.Bericht;
  FStatus.Caption := PlanlosDB.ArtName + '   ·   ' +
    IntToStr(PlanlosDB.Ganzzahl('SELECT COUNT(*) FROM modulart')) + ' Belegarten   ·   ' +
    IntToStr(PlanlosDB.Ganzzahl('SELECT COUNT(*) FROM adresse')) + ' Adressen   ·   ' +
    'Kaskade ' + Kaskade;
end;

procedure THauptfenster.AnsichtNachziehen(Sender: TObject);
var
  i: Integer;
begin
  AnsichtAktualisieren;
  for i := 0 to Screen.FormCount - 1 do
    if Screen.Forms[i] is TKindfenster then
      TKindfenster(Screen.Forms[i]).TextAktualisieren;
end;

procedure THauptfenster.TaktTimer(Sender: TObject);
begin
  AlleLeistenNachziehen;
end;

procedure THauptfenster.TasteAusfuehren(Sender: TObject; Ebene, Taste: Integer);
begin
  if Ebene = 1 then
    case Taste of
      1: ZeigeHilfe(True);
      2: HinweisNochOffen('Neu');
      3: KindfensterOeffnen;
      4: AdressSucheZeigen('kunde');
      5: HinweisNochOffen('Ändern');
      6: HinweisNochOffen('Drucken');
      7: HinweisNochOffen('Sortieren');
      8: HinweisNochOffen('Löschen');
      9: HinweisNochOffen('Filter');
      10: HinweisNochOffen('Speichern');
      11: AnsichtAktualisieren;
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

procedure THauptfenster.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key >= VK_F1) and (Key <= VK_F12) then
  begin
    AlleLeistenNachziehen;
    TasteAusfuehren(Self, AktuelleEbene, Key - VK_F1 + 1);
    Key := 0;
  end;
end;

procedure THauptfenster.MenueBeenden(Sender: TObject);
begin
  Close;
end;

procedure THauptfenster.MenueFenster(Sender: TObject);
begin
  KindfensterOeffnen;
end;

procedure THauptfenster.MenueKaskade(Sender: TObject);
begin
  KaskadeUmschaltenUndSagen;
end;

procedure THauptfenster.MenueAlleZu(Sender: TObject);
begin
  AlleKindfensterSchliessen;
end;

procedure THauptfenster.MenueHilfe(Sender: TObject);
begin
  ZeigeHilfe(True);
end;

procedure THauptfenster.MenueDatenbank(Sender: TObject);
begin
  AnsichtAktualisieren;
end;

procedure THauptfenster.MenueUeber(Sender: TObject);
begin
  ZeigeUeberPlanlos;
end;

procedure THauptfenster.MenueKunde(Sender: TObject);
begin
  AdressSucheZeigen('kunde');
end;

procedure THauptfenster.MenueLieferant(Sender: TObject);
begin
  AdressSucheZeigen('lieferant');
end;

procedure THauptfenster.MenueKontakt(Sender: TObject);
begin
  AdressSucheZeigen('kontakt');
end;

procedure THauptfenster.MenueMitarbeiter(Sender: TObject);
begin
  AdressSucheZeigen('mitarbeiter');
end;

procedure THauptfenster.MenueAngebot(Sender: TObject);
begin
  BelegsucheZeigen('angebot');
end;

procedure THauptfenster.MenueAuftrag(Sender: TObject);
begin
  BelegsucheZeigen('auftragsbestaetigung');
end;

procedure THauptfenster.MenueBestellung(Sender: TObject);
begin
  BelegsucheZeigen('bestellung');
end;

procedure THauptfenster.MenueRechnung(Sender: TObject);
begin
  BelegsucheZeigen('rechnung');
end;

procedure THauptfenster.MenueProjekt(Sender: TObject);
begin
  BelegsucheZeigen('projekt');
end;

function KontaktPruefen(Protokoll: TStrings): string;
var
  Werte: TStringList;
  Fehler: string;
  Id, Neu: Int64;
  Kunden, Mitarbeiter: TSuchfenster;
  Eingabe, Kunde: TEingabefenster;
begin
  Result := '';
  Werte := TStringList.Create;
  Kunden := TSuchfenster.Create(Application);
  Mitarbeiter := TSuchfenster.Create(Application);
  Eingabe := TEingabefenster.Create(Application);
  Kunde := TEingabefenster.Create(Application);
  try
    Werte.Values['nachname'] := 'Meier';
    Werte.Values['vorname'] := 'Eva';
    Id := AdresseSpeichern('mitarbeiter', 0, Werte, Fehler);
    if Id = 0 then
      Exit('Mitarbeiter anlegen: ' + Fehler);
    if not Kunden.Oeffne('kunde') then
      Exit('Die Kundenmaske fehlt.');
    if Kunden.Left <> 40 then
      Exit('Das Kundenfenster steht nicht an der Position aus der Maske.');
    if Kunden.EnthaeltText('Meier') then
      Exit('Der Mitarbeiter erscheint in der Kundensuche.');
    if not Mitarbeiter.Oeffne('mitarbeiter') then
      Exit('Die Mitarbeitermaske fehlt.');
    if not Mitarbeiter.EnthaeltText('Meier') then
      Exit('Der Mitarbeiter ist in der Mitarbeitersuche nicht zu finden.');
    if Mitarbeiter.GewaehlteId <> Id then
      Exit('Der Mitarbeiter ist nicht als Treffer ausgewählt.');
    Eingabe.Vorbereiten('mitarbeiter', 0);
    if Eingabe.HatFeld('firma') then
      Exit('Die Mitarbeitermaske zeigt das Feld Firma.');
    if not Eingabe.HatFeld('nachname') then
      Exit('Die Mitarbeitermaske hat kein Feld Nachname.');
    Kunde.Vorbereiten('kunde', 0);
    if not Kunde.HatFeld('firma') then
      Exit('Die Kundenmaske zeigt die Firma nicht.');
    if not Kunde.HatFeld('rabatt_prozent') then
      Exit('Die Kundenmaske zeigt den Rabatt nicht.');
    Eingabe.SetzeWert('nachname', 'Schulz');
    Eingabe.SetzeWert('vorname', 'Tim');
    Neu := Eingabe.SpeichernStill(Fehler);
    if Neu = 0 then
      Exit('Speichern aus der Maske: ' + Fehler);
    Mitarbeiter.UebernehmenNeueId(Neu);
    if Mitarbeiter.GewaehlteId <> Neu then
      Exit('Der neue Mitarbeiter ist nach dem Speichern nicht ausgewählt.');
    Kunden.UebernehmenNeueId(0);
    if Kunden.EnthaeltText('Schulz') then
      Exit('Der neue Mitarbeiter erscheint in der Kundensuche.');
    Protokoll.Add('KONTAKT=OK');
    Protokoll.Add('MITARBEITER=' + IntToStr(Id));
    Protokoll.Add('NEU=' + IntToStr(Neu));
  finally
    Kunde.Free;
    Eingabe.Free;
    Mitarbeiter.Free;
    Kunden.Free;
    Werte.Free;
  end;
end;

procedure THauptfenster.FormShow(Sender: TObject);
begin
  if FSelbsttest and not FSelbsttestGelaufen then
  begin
    FSelbsttestGelaufen := True;
    Selbsttest;
  end;
end;

procedure THauptfenster.Selbsttest;
var
  Datei, Grund: string;
  K1, K2, K3: TKindfenster;
  Liste: TStringList;
  SchrittL, SchrittO: Integer;
begin
  Grund := '';
  Liste := TStringList.Create;
  try
    try
      Liste.Add(FText.Lines.Text);
      if FDbFehler <> '' then
        Grund := 'Datenbank: ' + FDbFehler
      else
      begin
        if Pos('Auftragsbestätigung', FText.Lines.Text) = 0 then
          Grund := 'Die Belegart Auftragsbestätigung fehlt im Fenstertext.';
        K1 := KindfensterOeffnen;
        K2 := KindfensterOeffnen;
        SchrittL := KaskadenSchritt('schritt_links', 9);
        SchrittO := KaskadenSchritt('schritt_oben', 26);
        Liste.Add('K1=' + IntToStr(K1.Left) + ',' + IntToStr(K1.Top));
        Liste.Add('K2=' + IntToStr(K2.Left) + ',' + IntToStr(K2.Top));
        if K2.Left - K1.Left <> SchrittL then
          Grund := 'Der Versatz nach rechts stimmt nicht.';
        if (Grund = '') and (K2.Top - K1.Top <> SchrittO) then
          Grund := 'Der Versatz nach unten stimmt nicht.';
        KaskadeUmschalten;
        try
          K3 := KindfensterOeffnen;
          Liste.Add('K3=' + IntToStr(K3.Left) + ',' + IntToStr(K3.Top));
          if (Grund = '') and ((K3.Left <> KaskadenAnfangLinks) or
             (K3.Top <> KaskadenAnfangOben)) then
            Grund := 'Ohne Kaskade soll das Fenster an der Grundposition stehen.';
        finally
          KaskadeUmschalten;
        end;
        if Grund = '' then
          Grund := KontaktPruefen(Liste);
      end;
    except
      on E: Exception do
        Grund := E.Message;
    end;
    if Grund = '' then
      Liste.Add('RESULT=OK')
    else
      Liste.Add('RESULT=FEHLER ' + Grund);
    Datei := GetEnvironmentVariable('PLANLOS_SELBSTTEST_DATEI');
    if Datei = '' then
      Datei := IncludeTrailingPathDelimiter(GetTempDir) + 'planlos-selbsttest.txt';
    Liste.SaveToFile(Datei, TEncoding.UTF8);
  finally
    Liste.Free;
  end;
  if Grund <> '' then
    ExitCode := 1
  else
    ExitCode := 0;
  Application.Terminate;
end;

end.
