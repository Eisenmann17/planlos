unit ugrafikfenster;

{ Kleine Stammdatenmaske für Briefkopf-Grafiken.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Dialogs, Graphics,
  LCLType, ugrafik;

type
  TGrafikFenster = class(TForm)
    ListNamen: TListBox;
    LabelName: TLabel;
    EditName: TEdit;
    ImageVorschau: TImage;
    ButtonBild: TButton;
    ButtonLoeschen: TButton;
    PanelKnopf: TPanel;
    LabelEsc: TLabel;
    ButtonAbbrechen: TButton;
    LabelF10: TLabel;
    ButtonSpeichern: TButton;
    procedure FormZeigen(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AuswahlKlick(Sender: TObject);
    procedure BildKlick(Sender: TObject);
    procedure LoeschenKlick(Sender: TObject);
    procedure SpeichernKlick(Sender: TObject);
    procedure AbbrechenKlick(Sender: TObject);
  private
    FIds: array of Int64;
    FId: Int64;
    FArt: string;
    FDaten: RawByteString;
    procedure ListeLaden;
    procedure Vorschau;
    procedure Leeren;
  end;

procedure GrafikFensterZeigen;

implementation

{$R *.lfm}

procedure GrafikFensterZeigen;
var
  Fenster: TGrafikFenster;
begin
  Fenster := TGrafikFenster.Create(Application);
  try
    Fenster.ShowModal;
  finally
    Fenster.Free;
  end;
end;

procedure TGrafikFenster.ListeLaden;
var
  Namen, Nummern: TStringList;
  i, Bisher: Integer;
begin
  Bisher := ListNamen.ItemIndex;
  Namen := TStringList.Create;
  Nummern := TStringList.Create;
  try
    GrafikenHolen(Namen, Nummern);
    ListNamen.Items.Assign(Namen);
    SetLength(FIds, Nummern.Count);
    for i := 0 to Nummern.Count - 1 do
      FIds[i] := StrToInt64Def(Nummern[i], 0);
  finally
    Nummern.Free;
    Namen.Free;
  end;
  if (Bisher >= 0) and (Bisher < ListNamen.Items.Count) then
    ListNamen.ItemIndex := Bisher;
end;

procedure TGrafikFenster.Vorschau;
var
  Strom: TStringStream;
  Bild: TGraphic;
begin
  ImageVorschau.Picture.Clear;
  if FDaten = '' then
    Exit;
  Strom := TStringStream.Create(FDaten);
  if FArt = 'jpg' then
    Bild := TJPEGImage.Create
  else
    Bild := TPortableNetworkGraphic.Create;
  try
    try
      Bild.LoadFromStream(Strom);
      ImageVorschau.Picture.Assign(Bild);
    except
      ImageVorschau.Picture.Clear;
    end;
  finally
    Bild.Free;
    Strom.Free;
  end;
end;

procedure TGrafikFenster.Leeren;
begin
  FId := 0;
  FArt := '';
  FDaten := '';
  EditName.Text := '';
  ListNamen.ItemIndex := -1;
  ImageVorschau.Picture.Clear;
end;

procedure TGrafikFenster.FormZeigen(Sender: TObject);
begin
  ListeLaden;
  Leeren;
end;

procedure TGrafikFenster.AuswahlKlick(Sender: TObject);
begin
  if (ListNamen.ItemIndex < 0) or (ListNamen.ItemIndex > High(FIds)) then
    Exit;
  FId := FIds[ListNamen.ItemIndex];
  EditName.Text := ListNamen.Items[ListNamen.ItemIndex];
  if not GrafikInhalt(FId, FArt, FDaten) then
  begin
    FArt := '';
    FDaten := '';
  end;
  Vorschau;
end;

procedure TGrafikFenster.BildKlick(Sender: TObject);
var
  Dialog: TOpenDialog;
  Strom: TFileStream;
  Inhalt: RawByteString;
  Art, Dateiname: string;
begin
  Dialog := TOpenDialog.Create(Self);
  try
    Dialog.Title := 'Grafik wählen';
    Dialog.Filter := 'PNG und JPG|*.png;*.jpg;*.jpeg';
    if not Dialog.Execute then
      Exit;
    Dateiname := Dialog.FileName;
    Strom := TFileStream.Create(Dateiname, fmOpenRead or fmShareDenyNone);
    try
      SetLength(Inhalt, Strom.Size);
      if Strom.Size > 0 then
        Strom.ReadBuffer(Inhalt[1], Strom.Size);
    finally
      Strom.Free;
    end;
  finally
    Dialog.Free;
  end;
  Art := GrafikArtErkennen(Inhalt);
  if Art = '' then
  begin
    ShowMessage('Erlaubt sind PNG und JPG.');
    Exit;
  end;
  FArt := Art;
  FDaten := Inhalt;
  if Trim(EditName.Text) = '' then
    EditName.Text := ChangeFileExt(ExtractFileName(Dateiname), '');
  Vorschau;
end;

procedure TGrafikFenster.LoeschenKlick(Sender: TObject);
var
  Fehler: string;
begin
  if FId = 0 then
  begin
    Leeren;
    Exit;
  end;
  if MessageDlg('Grafik löschen?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  if not GrafikLoeschen(FId, Fehler) then
    ShowMessage(Fehler)
  else
  begin
    Leeren;
    ListeLaden;
  end;
end;

procedure TGrafikFenster.SpeichernKlick(Sender: TObject);
var
  Fehler: string;
begin
  if not GrafikSpeichern(FId, EditName.Text, FArt, FDaten, Fehler) then
  begin
    ShowMessage(Fehler);
    Exit;
  end;
  ListeLaden;
end;

procedure TGrafikFenster.AbbrechenKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TGrafikFenster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end
  else if Key = VK_F10 then
  begin
    SpeichernKlick(nil);
    Key := 0;
  end
  else if Key = VK_F12 then
    Key := 0;
end;

end.
