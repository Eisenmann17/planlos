unit uartikelwahl;

{ Artikel aussuchen für eine Belegposition. Links die Gruppe, rechts die
  Artikel. Enter übernimmt, Esc geht zurück.
  Copyright (C) 2026 Günther Stadtler
  Lizenz: GNU GPL, Version 3. Text in der Datei LICENSE. }

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Grids, ExtCtrls, Graphics,
  LCLType;

function ArtikelWaehlen(out Id: Int64): Boolean;

implementation

{$R *.lfm}

uses
  udatenbank;

type
  TArtikelWahl = class(TForm)
    EditFilter: TEdit;
    GridGruppe: TStringGrid;
    GridArtikel: TStringGrid;
    PanelKnopf: TPanel;
    LabelEsc: TLabel;
    ButtonZurueck: TButton;
    LabelReturn: TLabel;
    ButtonUebernehmen: TButton;
    procedure FormZeigen(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GruppeKlick(Sender: TObject);
    procedure ArtikelDoppel(Sender: TObject);
    procedure FilterTaste(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ZurueckKlick(Sender: TObject);
    procedure UebernehmenKlick(Sender: TObject);
  private
    FGruppen: array of Int64;
    FArtikel: array of Int64;
    FId: Int64;
    procedure GruppenLaden;
    procedure ArtikelLaden;
    procedure Uebernehmen;
  end;

function ArtikelWaehlen(out Id: Int64): Boolean;
var
  Fenster: TArtikelWahl;
begin
  Id := 0;
  Fenster := TArtikelWahl.Create(Application);
  try
    if Fenster.ShowModal = mrOk then
      Id := Fenster.FId;
    Result := Id > 0;
  finally
    Fenster.Free;
  end;
end;

procedure Teile(const Zeile: string; Ziel: TStrings);
var
  Rest, Stueck: string;
  PosTab: Integer;
begin
  Ziel.Clear;
  Rest := Zeile;
  repeat
    PosTab := Pos(#9, Rest);
    if PosTab = 0 then
    begin
      Ziel.Add(Rest);
      Break;
    end;
    Stueck := Copy(Rest, 1, PosTab - 1);
    Ziel.Add(Stueck);
    Delete(Rest, 1, PosTab);
  until False;
end;

procedure TArtikelWahl.GruppenLaden;
var
  Spalten, Zeilen, Stueck: TStringList;
  i: Integer;
begin
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  Stueck := TStringList.Create;
  try
    PlanlosDB.AlleZeilen(
      'SELECT id, bezeichnung FROM artikelgruppe ORDER BY bezeichnung, id',
      nil, Spalten, Zeilen);
    GridGruppe.ColCount := 1;
    GridGruppe.RowCount := Zeilen.Count + 2;
    GridGruppe.Cells[0, 0] := 'Gruppe';
    GridGruppe.Cells[0, 1] := 'Alle';
    SetLength(FGruppen, Zeilen.Count + 1);
    FGruppen[0] := 0;
    for i := 0 to Zeilen.Count - 1 do
    begin
      Teile(Zeilen[i], Stueck);
      FGruppen[i + 1] := StrToInt64Def(Stueck[0], 0);
      if Stueck.Count > 1 then
        GridGruppe.Cells[0, i + 2] := Stueck[1];
    end;
    GridGruppe.Row := 1;
  finally
    Stueck.Free;
    Zeilen.Free;
    Spalten.Free;
  end;
end;

procedure TArtikelWahl.ArtikelLaden;
var
  Parameter, Spalten, Zeilen, Stueck: TStringList;
  i, GruppeZeile: Integer;
  GruppeId: Int64;
begin
  GruppeZeile := GridGruppe.Row;
  if (GruppeZeile < 1) or (GruppeZeile > Length(FGruppen)) then
    GruppeId := 0
  else
    GruppeId := FGruppen[GruppeZeile - 1];
  Parameter := TStringList.Create;
  Spalten := TStringList.Create;
  Zeilen := TStringList.Create;
  Stueck := TStringList.Create;
  try
    if GruppeId = 0 then
      Parameter.Values['alle'] := '1'
    else
      Parameter.Values['alle'] := '0';
    Parameter.Values['gruppe'] := IntToStr(GruppeId);
    Parameter.Values['muster'] := '%' + Trim(EditFilter.Text) + '%';
    PlanlosDB.AlleZeilen(
      'SELECT a.id, COALESCE(g.bezeichnung, ''''), a.bezeichnung ' +
      'FROM artikel a LEFT JOIN artikelgruppe g ON g.id = a.gruppe_id ' +
      'WHERE (:alle = ''1'' OR a.gruppe_id = :gruppe) AND a.bezeichnung LIKE :muster ' +
      'ORDER BY a.bezeichnung, a.id', Parameter, Spalten, Zeilen);
    GridArtikel.ColCount := 2;
    if Zeilen.Count = 0 then
      GridArtikel.RowCount := 2
    else
      GridArtikel.RowCount := Zeilen.Count + 1;
    GridArtikel.Cells[0, 0] := 'Gruppe';
    GridArtikel.Cells[1, 0] := 'Artikel';
    SetLength(FArtikel, Zeilen.Count);
    for i := 0 to Zeilen.Count - 1 do
    begin
      Teile(Zeilen[i], Stueck);
      FArtikel[i] := StrToInt64Def(Stueck[0], 0);
      if Stueck.Count > 1 then
        GridArtikel.Cells[0, i + 1] := Stueck[1];
      if Stueck.Count > 2 then
        GridArtikel.Cells[1, i + 1] := Stueck[2];
    end;
  finally
    Stueck.Free;
    Zeilen.Free;
    Spalten.Free;
    Parameter.Free;
  end;
end;

procedure TArtikelWahl.Uebernehmen;
var
  Zeile: Integer;
begin
  Zeile := GridArtikel.Row;
  if (Zeile < 1) or (Zeile > Length(FArtikel)) then
    Exit;
  FId := FArtikel[Zeile - 1];
  if FId > 0 then
    ModalResult := mrOk;
end;

procedure TArtikelWahl.FormZeigen(Sender: TObject);
begin
  GruppenLaden;
  ArtikelLaden;
  EditFilter.SetFocus;
end;

procedure TArtikelWahl.GruppeKlick(Sender: TObject);
begin
  ArtikelLaden;
end;

procedure TArtikelWahl.ArtikelDoppel(Sender: TObject);
begin
  Uebernehmen;
end;

procedure TArtikelWahl.FilterTaste(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    ArtikelLaden;
    Key := 0;
  end;
end;

procedure TArtikelWahl.ZurueckKlick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TArtikelWahl.UebernehmenKlick(Sender: TObject);
begin
  Uebernehmen;
end;

procedure TArtikelWahl.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) or (Key = VK_F12) then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end
  else if (Key = VK_RETURN) and not EditFilter.Focused then
  begin
    Uebernehmen;
    Key := 0;
  end;
end;

end.
