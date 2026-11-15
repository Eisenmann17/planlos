unit UnitDataModul;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZConnection,
  StdCtrls, Mask, ExtCtrls;

type
  TDataModuleMyOffice = class(TDataModule)
    ZConnectionMyOffice: TZConnection;
    ZQueryAdressen: TZQuery;
    ZQueryArtikel: TZQuery;
    ZQueryArtikelgruppe: TZQuery;
    ZQueryArtikelListe: TZQuery;
    ZQueryArtikellisteS: TZQuery;
    ZQueryBenutzer: TZQuery;
    ZQueryBerechnungsart: TZQuery;
    ZQueryEinheit: TZQuery;
    ZQueryEinstellungForm1: TZQuery;
    ZQueryEinstellungModulart: TZQuery;
    ZQueryGruppierung: TZQuery;
    ZQueryKategorie: TZQuery;
    ZQueryModule: TZQuery;
    ZQueryStueckliste: TZQuery;
    ZQueryStuecklistenArtikel: TZQuery;
    ZQueryStuecklistenGruppe: TZQuery;
    ZQueryTextbaustein: TZQuery;
    DataSourceArtikel: TDataSource;
    DataSourceAdressen: TDataSource;
    DataSourceArtikelgruppe: TDataSource;
    DataSourceArtikelListe: TDataSource;
    DataSourceArtikellisteS: TDataSource;
    DataSourceBenutzer: TDataSource;
    DataSourceBerechnungsart: TDataSource;
    DataSourceEinheit: TDataSource;
    DataSourceEinstellungForm1: TDataSource;
    DataSourceEinstellungModulart: TDataSource;
    DataSourceGruppierung: TDataSource;
    DataSourceKategorie: TDataSource;
    DataSourceModule: TDataSource;
    DataSourceStueckliste: TDataSource;
    DataSourceStuecklistenArtikel: TDataSource;
    DataSourceStuecklistenGruppe: TDataSource;
    DataSourceTextbaustein: TDataSource;
    FQuery1: TZQuery;
    FDataSource1: TDataSource;
    FQuery2: TZQuery;
    FDataSource2: TDataSource;
    FQueryVon: TZQuery;
    FQueryZu: TZQuery;
    GQuery1: TZQuery;
    GQuery2: TZQuery;
    DataSourceG1: TDataSource;
    DataSourceG2: TDataSource;
    procedure DSSet(FArtikelStr:String;FQuery:TZQuery);
    function  DSGet(FArtikelStr:String;FTabelle:String;FNr:integer):integer;
    procedure DSNil(FArtikelStr:String);
    procedure DSLoeschen(FTabelle,FFeld:String;FNr:longint);
    procedure DSArtikelListeKopieren(FVonTabelle,FVonFeld:String;FVonWert:integer;FZuTabelle,FZuFeld:String;FZuWert:integer);
    //procedure FddSet(z:integer;s:String);
    procedure FddNil(z:integer);
    procedure FdmNil(z:integer);
    procedure FmoNil(z:integer);
    function  FdSetString(sichtbar:integer;Name:String;x,y,l,j:integer;Schrift,Farbe:String;Groesse,Style,Rahmen,Ena,h:integer):String;
    procedure FddGet(z:integer;s:String);
    procedure FdmGet(z:integer;s:String);
    procedure FmoGet(z:integer;s:String);
    procedure FddSetQuery(FQ:TZQuery);
    procedure FdmSetQuery(FQ:TZQuery);
    procedure FmoSetQuery(FQ:TZQuery);
    Function  IntToBol(i:integer):Boolean;
    Function  BolToInt(b:Boolean):integer;
    Function  StyleToInt(sy:TFontStyles):integer;
    Function  IntToStyle(i:integer):TFontStyles;
    Function  XStrToint(s:String):integer;
    procedure FFormatNil(z:integer);
    procedure FFormatGet(z:integer;s:String);
    procedure LagerverwaltungListe(FModulart:String;FZeiger:Integer;loeschen:Boolean);
    procedure LagerverwaltungArtikel(FLagerverwaltung,FArtikelNr:Integer;FLagerverwaltungMenge:Real;FArtikelart:String;FArtikelListenNr:integer;loeschen:Boolean);
    procedure FensteraktivLaden(FPanelTastatur:TPanel;FImageTastatur:TImage;L1,L2,L3,L4,L5,L6,L7,L8,L9,L10,L11,L12,L13,L1_p,L2_p,L3_p,L4_p,L5_p,L6_p,L7_p,L8_p,L9_p,L10_p,L11_p,L12_p,L13_P:TLabel;CB:TCheckBox);
    procedure FensterdeaktivLaden(FPanelTastatur:TPanel;FImageTastatur:TImage;L1,L2,L3,L4,L5,L6,L7,L8,L9,L10,L11,L12,L13,L1_p,L2_p,L3_p,L4_p,L5_p,L6_p,L7_p,L8_p,L9_p,L10_p,L11_p,L12_p,L13_p:TLabel;CB:TCheckBox);
    function  FdmoSetString(sichtbar:integer;Name:String;x,y,l,j:integer;Schrift,Farbe:String;Groesse,Style,Rahmen,Ena,h:integer;Berechnung:String):String;
    procedure CreateArtikelMemo();
    procedure DSArtikelListeKopieren2(FVonTabelle,FVonFeld:String;FVonWert:integer;FZuTabelle,FZuFeld,FZuFeld2:String;FZuWert,FZuWert2:integer);
    procedure FreeArtikelMemo();

  private
    { Private-Deklarationen }
  public
  end;
type
    TArtikel = record
    Nr:integer;
    Artikelgruppe,Artikel:String[25];
    EK_Preis,VK_Preis:Real;
    Einheit_EK,EinheitMenge:String[13];
    Aufschlag,Rabatt:Real;
    Gewicht,Zahl1,Zahl2,Zahl3:Real;
    Name1,Name2:string[25];
    Name3:String[100];
    Lieferant:String[50];
    LieferantArtikelNr:String[25];
    Pos_Text:TMemo;
    BerechnungsArt:String[50];
    Kostenart:String[1];
    Bestand:Real;
    Min_Bestand:Real;
    Pos_Nr,Pos:integer;
    Gruppierung:String[25];
    Modul_Nr,ModulNr:integer;
    Artikel_Nr:integer;
    Menge,Menge2:Real;
    Materialleistung,Dienstleistung,Fremdleistung,Sonstigeleistung:Real;
    MatAufschlag,DieAufschlag,FreAufschlag,SonAufschlag:Real;
    Erledigt1,Erledigt2,Erledigt3,Erledigt4,Erledigt5,Geaendert:Integer;
    ArtikelArt:String[25];
    Bearbeiter:String[25];
    Stuecklisten_Nr:Integer;
end;
type TFD = Record
     Sichtbar:integer;
     Name:String[250];
     x:integer;
     y:integer;
     l:integer;
     j:integer;
     Schrift:String[50];
     Farbe:String[25];
     Groesse:integer;
     Style:integer;
     Rahmen:integer;
     Ena:integer;
     h:integer;
     Berechnung:String;
end;
var
  DataModuleMyOffice: TDataModuleMyOffice;
  Artikel1,Artikel2:TArtikel;
  Fdd1,Fdd2,Fdd3,Fdd4,Fdd5,Fdd6,Fdd7,Fdd8,Fdd9,Fdd10,Fdd11,Fdd12,Fdd13,Fdd14,Fdd15,Fdd16,Fdd17,Fdd18,Fdd19,Fdd20:TFD;
  Fdm1,Fdm2,Fdm3,Fdm4,Fdm5,Fdm6,Fdm7,Fdm8,Fdm9,Fdm10,Fdm11,Fdm12,Fdm13,Fdm14,Fdm15,Fdm16,Fdm17,Fdm18,Fdm19,Fdm20:TFD;
  Fmo1,Fmo2,Fmo3,Fmo4,Fmo5,Fmo6,Fmo7,Fmo8,Fmo9,Fmo10,Fmo11,Fmo12,Fmo13,Fmo14,Fmo15,Fmo16,Fmo17,Fmo18,Fmo19,Fmo20:TFD;
  FFormat:TFD;
implementation

uses UnitModule, UnitDB;

{$R *.DFM}


procedure TDataModuleMyOffice.CreateArtikelMemo();
begin
   Artikel1.Pos_Text:=TMemo.Create(DataModuleDB);
   Artikel2.Pos_Text:=TMemo.Create(DataModuleDB);
end;

procedure TDataModuleMyOffice.FreeArtikelMemo();
begin
   Artikel1.Pos_Text.Free;
   Artikel2.Pos_Text.Free;
end;
procedure TDataModuleMyOffice.FensteraktivLaden(FPanelTastatur:TPanel;FImageTastatur:TImage;L1,L2,L3,L4,L5,L6,L7,L8,L9,L10,L11,L12,L13,L1_p,L2_p,L3_p,L4_p,L5_p,L6_p,L7_p,L8_p,L9_p,L10_p,L11_p,L12_p,L13_p:TLabel;CB:TCheckBox);
begin
  if FormPlanlos.GButtonFeldActiv = 0 then begin
   FPanelTastatur.Visible:=False;
   FImageTastatur.Visible:=False;
   L1.color:=stringtoColor('clBtnFace');
   L2.color:=stringtoColor('clBtnFace');
   L3.color:=stringtoColor('clBtnFace');
   L4.color:=stringtoColor('clBtnFace');
   L5.color:=stringtoColor('clBtnFace');
   L6.color:=stringtoColor('clBtnFace');
   L7.color:=stringtoColor('clBtnFace');
   L8.color:=stringtoColor('clBtnFace');
   L9.color:=stringtoColor('clBtnFace');
   L10.color:=stringtoColor('clBtnFace');
   L11.color:=stringtoColor('clBtnFace');
   L12.color:=stringtoColor('clBtnFace');
   L13.color:=stringtoColor('clBtnFace');
   CB.Color:=stringtoColor('clBtnFace');
 end;
 if FormPlanlos.GButtonFeldActiv = 1 then begin
   FPanelTastatur.Visible:=False;
   FImageTastatur.Visible:=True;
   if FormPlanlos.GButtonDateinameActiv <> '' then FImageTastatur.Picture.LoadFromFile(FormPlanlos.GButtonDateinameActiv);
   L1.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L2.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L3.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L4.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L5.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L6.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L7.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L8.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L9.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L10.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L11.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L12.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L13.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   CB.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L1.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L2.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L3.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L4.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L5.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L6.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L7.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L8.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L9.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L10.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L11.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L12.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L13.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   CB.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
 end;
 if FormPlanlos.GButtonFeldActiv = 2 then begin
   FPanelTastatur.Visible:=True;
   FImageTastatur.Visible:=False;
   FPanelTastatur.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L1_p.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L2_p.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L3_p.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L4_p.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L5_p.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L6_p.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L7_p.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L8_p.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L9_p.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L10_p.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L11_p.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L12_p.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L13_p.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   CB.color:=stringtoColor(FormPlanlos.GButtonFarbeActive);
   L1_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L2_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L3_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L4_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L5_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L6_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L7_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L8_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L9_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L10_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L11_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L12_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   L13_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
   CB.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorActiv);
 end;
end;

procedure TDataModuleMyOffice.FensterdeaktivLaden(FPanelTastatur:TPanel;FImageTastatur:TImage;L1,L2,L3,L4,L5,L6,L7,L8,L9,L10,L11,L12,L13,L1_p,L2_p,L3_p,L4_p,L5_p,L6_p,L7_p,L8_p,L9_p,L10_p,L11_p,L12_p,L13_p:TLabel;CB:TCheckBox);
begin
  if FormPlanlos.GButtonFeldNichtActiv = 0 then begin
   FPanelTastatur.Visible:=False;
   FImageTastatur.Visible:=False;
   L1.color:=stringtoColor('clBtnFace');
   L2.color:=stringtoColor('clBtnFace');
   L3.color:=stringtoColor('clBtnFace');
   L4.color:=stringtoColor('clBtnFace');
   L5.color:=stringtoColor('clBtnFace');
   L6.color:=stringtoColor('clBtnFace');
   L7.color:=stringtoColor('clBtnFace');
   L8.color:=stringtoColor('clBtnFace');
   L9.color:=stringtoColor('clBtnFace');
   L10.color:=stringtoColor('clBtnFace');
   L11.color:=stringtoColor('clBtnFace');
   L12.color:=stringtoColor('clBtnFace');
   L13.color:=stringtoColor('clBtnFace');
   CB.color:=stringtoColor('clBtnFace');
 end;
 if FormPlanlos.GButtonFeldNichtActiv = 1 then begin
   FPanelTastatur.Visible:=False;
   FImageTastatur.Visible:=True;
   if FormPlanlos.GButtonDateinameNichtActiv <> '' then FImageTastatur.Picture.LoadFromFile(FormPlanlos.GButtonDateinameNichtActiv);
   L1.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L2.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L3.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L4.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L5.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L6.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L7.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L8.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L9.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L10.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L11.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L12.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L13.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   CB.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L1.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L2.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L3.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L4.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L5.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L6.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L7.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L8.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L9.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L10.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L11.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L12.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L13.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   CB.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
 end;
 if FormPlanlos.GButtonFeldNichtActiv = 2 then begin
   FPanelTastatur.Visible:=True;
   FImageTastatur.Visible:=False;
   FPanelTastatur.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L1_p.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L2_p.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L3_p.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L4_p.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L5_p.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L6_p.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L7_p.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L8_p.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L9_p.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L10_p.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L11_p.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L12_p.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L13_p.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   CB.color:=stringtoColor(FormPlanlos.GButtonFarbeNichtActive);
   L1_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L2_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L3_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L4_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L5_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L6_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L7_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L8_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L9_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L10_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L11_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L12_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   L13_p.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
   CB.Font.color:=stringtoColor(FormPlanlos.GButtonFontColorNichtActiv);
 end;
end;

procedure TDataModuleMyOffice.LagerverwaltungArtikel(FLagerverwaltung,FArtikelNr:Integer;FLagerverwaltungMenge:Real;FArtikelart:String;FArtikelListenNr:integer;loeschen:Boolean);
Var i:integer;
begin
  if loeschen Then begin
    if FLagerverwaltung = 1 then FLagerverwaltung:=2
    Else  if FLagerverwaltung = 2 then FLagerverwaltung:=1;
  end;
  if (FArtikelNr <> 0) and (FLagerverwaltung <> 0) Then begin
    if ZQueryArtikel.Active Then ZQueryArtikel.Close;
    ZQueryArtikel.SQL.Clear;
    ZQueryArtikel.sql.add('Select * From Artikel Where Nr = '+ inttostr(FArtikelNr));
    try
      ZQueryArtikel.open;//Self.Query1.Edit;
    finally
    end;
    if ZQueryArtikel.RecordCount = 1 then begin
      ZQueryArtikel.edit;
      if FLagerverwaltung  = 1 then ZQueryArtikel.FieldByName('Bestand').AsFloat:=ZQueryArtikel.FieldByName('Bestand').AsFloat - FLagerverwaltungMenge;
      if FLagerverwaltung  = 2 then ZQueryArtikel.FieldByName('Bestand').AsFloat:=ZQueryArtikel.FieldByName('Bestand').AsFloat + FLagerverwaltungMenge;
      ZQueryArtikel.post;
    end;
    //if QueryLagerverwaltung.RecordCount > 1 then  Showmessage('es sind mehrere Artikel mit dieser Artikel_Nr in den Stammdaten vorhanden, für die Lagerverwaltung');
    //if QueryLagerverwaltung.RecordCount = 0 then  Showmessage('es wurde kein Artikel in den Stammdaten gefunden, für die Lagerverwaltung');
    ZQueryArtikel.close;
  end;
  if (FArtikelart = 'Stueckliste') and (FLagerverwaltung <> 0) Then begin
    if ZQueryArtikellisteS.Active Then ZQueryArtikellisteS.Close;
    ZQueryArtikellisteS.SQL.Clear;
    ZQueryArtikellisteS.sql.add('Select * From Artikellistes Where Stuecklisten_Nr = '+ inttostr(FArtikelNr));
    try ZQueryArtikellisteS.open; finally end;
    for i := 0 to ZQueryArtikellisteS.RecordCount - 1 do begin
      if ZQueryArtikel.Active Then ZQueryArtikel.Close;
      ZQueryArtikel.SQL.Clear;
      ZQueryArtikel.sql.add('Select * From Artikel Where Nr = '+ inttostr(ZQueryArtikelListeS.FieldByName('Artikel_Nr').Asinteger));
      try ZQueryArtikel.open; finally end;
      if ZQueryArtikel.RecordCount = 1 then begin
        ZQueryArtikel.edit;
        if FLagerverwaltung  = 1 then ZQueryArtikel.FieldByName('Bestand').AsFloat:=ZQueryArtikel.FieldByName('Bestand').AsFloat - (FLagerverwaltungMenge*ZQueryArtikellisteS.FieldByName('Menge').AsFloat);
        if FLagerverwaltung  = 2 then ZQueryArtikel.FieldByName('Bestand').AsFloat:=ZQueryArtikel.FieldByName('Bestand').AsFloat + (FLagerverwaltungMenge*ZQueryArtikellisteS.FieldByName('Menge').AsFloat);
        ZQueryArtikel.post;
      end;
      //if ZQueryArtikel.RecordCount > 1 then  Showmessage('es sind mehrere Artikel mit dieser Artikel_Nr in den Stammdaten vorhanden');
      //if ZQueryArtikel.RecordCount = 0 then  Showmessage('es wurde kein Artikel mit der Nr '+ZQueryArtikellisteS.FieldByName('Artikel_Nr').AsString+' in den Stammdaten gefunden, für die Lagerverwaltung');
      ZQueryArtikel.close;
      ZQueryArtikellisteS.next;
    end;
  end;
  ZQueryArtikellisteS.close;
end;

procedure TDataModuleMyOffice.LagerverwaltungListe(FModulart:String;FZeiger:Integer;loeschen:Boolean);
var FLagerverwaltung:integer;
    FLagerverwaltungMenge:Real;
    i,i2:integer;
begin
  if ZQueryEinstellungModulart.Active then ZQueryEinstellungModulart.close;
  ZQueryEinstellungModulart.SQL.Clear;
  ZQueryEinstellungModulart.SQL.Add('Select * FROM EinstellungModulart WHERE Modulart = ' +'"'+ FModulart+'"');
  try
    ZQueryEinstellungModulart.Open
  except
  end;
  FLagerverwaltung:=ZQueryEinstellungModulart.FieldByName('Lagerverwaltung').ASInteger;
  if loeschen Then begin
    if FLagerverwaltung = 1 then FLagerverwaltung:=2
    Else  if FLagerverwaltung = 2 then FLagerverwaltung:=1;
  end;
  ZQueryEinstellungModulart.close;
  if ZQueryArtikelListe.Active then ZQueryArtikelListe.close;
  ZQueryArtikelListe.SQL.Clear;
  ZQueryArtikelListe.SQL.Add('Select * From ArtikelListe Where Modul_Nr = '+ inttostr(Fzeiger)+' Order by Pos_Nr');
  try
    ZQueryArtikelListe.Open
  except
  end;
  for i := 0 to ZQueryArtikelListe.RecordCount - 1 do begin
    FLagerverwaltungMenge:=ZQueryArtikelListe.FieldByName('Menge').AsFloat;
    if (ZQueryArtikelListe.FieldByName('Artikel_Nr').AsString <> '') and (FLagerverwaltung <> 0) Then begin
      if ZQueryArtikel.Active Then ZQueryArtikel.Close;
      ZQueryArtikel.SQL.Clear;
      ZQueryArtikel.sql.add('Select * From Artikel Where Nr = '+ inttostr(ZQueryArtikelListe.FieldByName('Artikel_Nr').Asinteger));
      try
        ZQueryArtikel.open;//Self.Query1.Edit;
      finally
      end;
      if ZQueryArtikel.RecordCount = 1 then begin
        ZQueryArtikel.edit;
        if FLagerverwaltung  = 1 then ZQueryArtikel.FieldByName('Bestand').AsFloat:=ZQueryArtikel.FieldByName('Bestand').AsFloat - FLagerverwaltungMenge;
        if FLagerverwaltung  = 2 then ZQueryArtikel.FieldByName('Bestand').AsFloat:=ZQueryArtikel.FieldByName('Bestand').AsFloat + FLagerverwaltungMenge;
        ZQueryArtikel.post;
      end;
      //if QueryLagerverwaltung.RecordCount > 1 then  Showmessage('es sind mehrere Artikel mit dieser Artikel_Nr in den Stammdaten vorhanden, für die Lagerverwaltung');
      //if QueryLagerverwaltung.RecordCount = 0 then  Showmessage('es wurde kein Artikel in den Stammdaten gefunden, für die Lagerverwaltung');
      ZQueryArtikel.close;
    end;
    if(ZQueryArtikelListe.FieldByName('ArtikelArt').AsString = 'Stueckliste') and (FLagerverwaltung <> 0) Then begin
      if ZQueryArtikellisteS.Active Then ZQueryArtikellisteS.Close;
      ZQueryArtikellisteS.SQL.Clear;
      ZQueryArtikellisteS.sql.add('Select * From Artikellistes Where Stuecklisten_Nr = '+ inttostr(ZQueryArtikelListe.FieldByName('Nr').Asinteger));
      try
        ZQueryArtikellisteS.open;//Self.Query1.Edit;
      finally
      end;
      for i2 := 0 to ZQueryArtikellisteS.RecordCount - 1 do begin
        if ZQueryArtikel.Active Then ZQueryArtikel.Close;
        ZQueryArtikel.SQL.Clear;
        ZQueryArtikel.sql.add('Select * From Artikel Where Nr = '+ inttostr(ZQueryArtikellisteS.FieldByName('Artikel_Nr').Asinteger));
        try
          ZQueryArtikel.open;//Self.Query1.Edit;
        finally
        end;
        if ZQueryArtikel.RecordCount = 1 then begin
          ZQueryArtikel.edit;
          if FLagerverwaltung  = 1 then ZQueryArtikel.FieldByName('Bestand').AsFloat:=ZQueryArtikel.FieldByName('Bestand').AsFloat - (FLagerverwaltungMenge*ZQueryArtikellisteS.FieldByName('Menge').AsFloat);
          if FLagerverwaltung  = 2 then ZQueryArtikel.FieldByName('Bestand').AsFloat:=ZQueryArtikel.FieldByName('Bestand').AsFloat + (FLagerverwaltungMenge*ZQueryArtikellisteS.FieldByName('Menge').AsFloat);
          ZQueryArtikel.post;
        end;
        //if ZQueryArtikel.RecordCount > 1 then  Showmessage('es sind mehrere Artikel mit dieser Artikel_Nr in den Stammdaten vorhanden');
        //if ZQueryArtikel.RecordCount = 0 then  Showmessage('es wurde kein Artikel mit der Nr '+ZQueryArtikellisteS.FieldByName('Artikel_Nr').AsString+' in den Stammdaten gefunden, für die Lagerverwaltung');
        ZQueryArtikel.close;
        ZQueryArtikellisteS.next;
      end;
    end;
    ZQueryArtikellisteS.close;
    ZQueryArtikelListe.next;
  end;
  ZQueryArtikelListe.close;
end;

Function TDataModuleMyOffice.XStrToint(s:String):integer;
var zahl,i:integer;
    Fs,FsZiel:String;
    Z:String;
begin
  Fs:=s;
  for i:=1 to length(Fs)do begin
    z:=copy(Fs,i,1);
    if (z = '0') or (z= '1') or (z= '2') or (z= '3') or (z= '4') or (z= '5') or (z= '6') or (z= '7') or (z= '8') or (z= '9')  then
      FsZiel:=FsZiel+z;
  end;
  if FsZiel='' then FsZiel:='0';
  Zahl:=Strtoint(FsZiel);
  Result:=Zahl;
end;

procedure TDataModuleMyOffice.FFormatNil(z:integer);
begin
  FFormat.Sichtbar:=0;
  FFormat.Name:='';
  FFormat.x:=0;
  FFormat.y:=0;
  FFormat.l:=0;
  FFormat.j:=0;
  FFormat.Schrift:='Arial';
  FFormat.Farbe:='clblack';
  FFormat.Groesse:=0;
  FFormat.Style:=0;
  FFormat.Rahmen:=0;
  FFormat.Ena:=0;
  FFormat.h:=0;
end;



Function TDataModuleMyOffice.IntToBol(i:integer):Boolean;
begin
   if i=1 then Result:=True Else Result:=False;
   //if i=Nil then Result:=False;
end;

Function TDataModuleMyOffice.BolToInt(b:Boolean):integer;
begin
   if b=True then Result:=1 Else Result:=0;
   //if i=Nil then Result:=False;
end;

Function TDataModuleMyOffice.StyleToInt(sy:TFontStyles):integer;
var ergebniss:integer;
begin
  ergebniss:=0;
  if sy= [] then ergebniss:=0;
  if sy= [fsBold] then ergebniss:=1;
  if sy= [fsItalic]  then ergebniss:=2;
  if sy= [fsBold, fsItalic]  then ergebniss:=3;
  //fsUnderline, fsStrikeOut
  Result:=ergebniss;
end;

Function TDataModuleMyOffice.IntToStyle(i:integer):TFontStyles;
var sy:TFontStyles;
begin
   if i=0 Then sy:=[];
   if i=1 Then sy:=[fsBold];
   if i=2 Then sy:=[fsItalic];
   if i=3 Then sy:=[fsBold, fsItalic];
   Result:=sy;
end;


procedure TDataModuleMyOffice.FddSetQuery(FQ:TZQuery);
begin
  FQ.edit;
  FQ.FieldByName('Feld1').AsString:=DataModuleMyOffice.FdSetString(Fdd1.sichtbar,Fdd1.Name,Fdd1.x,Fdd1.y,Fdd1.l,Fdd1.j,Fdd1.Schrift,Fdd1.Farbe,Fdd1.Groesse,Fdd1.Style,Fdd1.Rahmen,Fdd1.Ena,Fdd1.h);
  FQ.FieldByName('Feld2').AsString:=DataModuleMyOffice.FdSetString(Fdd2.sichtbar,Fdd2.Name,Fdd2.x,Fdd2.y,Fdd2.l,Fdd2.j,Fdd2.Schrift,Fdd2.Farbe,Fdd2.Groesse,Fdd2.Style,Fdd2.Rahmen,Fdd2.Ena,Fdd2.h);
  FQ.FieldByName('Feld3').AsString:=DataModuleMyOffice.FdSetString(Fdd3.sichtbar,Fdd3.Name,Fdd3.x,Fdd3.y,Fdd3.l,Fdd3.j,Fdd3.Schrift,Fdd3.Farbe,Fdd3.Groesse,Fdd3.Style,Fdd3.Rahmen,Fdd3.Ena,Fdd3.h);
  FQ.FieldByName('Feld4').AsString:=DataModuleMyOffice.FdSetString(Fdd4.sichtbar,Fdd4.Name,Fdd4.x,Fdd4.y,Fdd1.l,Fdd4.j,Fdd4.Schrift,Fdd4.Farbe,Fdd4.Groesse,Fdd4.Style,Fdd4.Rahmen,Fdd4.Ena,Fdd4.h);
  FQ.FieldByName('Feld5').AsString:=DataModuleMyOffice.FdSetString(Fdd5.sichtbar,Fdd5.Name,Fdd5.x,Fdd5.y,Fdd5.l,Fdd5.j,Fdd5.Schrift,Fdd5.Farbe,Fdd5.Groesse,Fdd5.Style,Fdd5.Rahmen,Fdd5.Ena,Fdd5.h);
  FQ.FieldByName('Feld6').AsString:=DataModuleMyOffice.FdSetString(Fdd6.sichtbar,Fdd6.Name,Fdd6.x,Fdd6.y,Fdd6.l,Fdd6.j,Fdd6.Schrift,Fdd6.Farbe,Fdd6.Groesse,Fdd6.Style,Fdd6.Rahmen,Fdd6.Ena,Fdd6.h);
  FQ.FieldByName('Feld7').AsString:=DataModuleMyOffice.FdSetString(Fdd7.sichtbar,Fdd7.Name,Fdd7.x,Fdd7.y,Fdd7.l,Fdd7.j,Fdd7.Schrift,Fdd7.Farbe,Fdd7.Groesse,Fdd7.Style,Fdd7.Rahmen,Fdd7.Ena,Fdd7.h);
  FQ.FieldByName('Feld8').AsString:=DataModuleMyOffice.FdSetString(Fdd8.sichtbar,Fdd8.Name,Fdd8.x,Fdd8.y,Fdd8.l,Fdd8.j,Fdd8.Schrift,Fdd8.Farbe,Fdd8.Groesse,Fdd8.Style,Fdd8.Rahmen,Fdd8.Ena,Fdd8.h);
  FQ.FieldByName('Feld9').AsString:=DataModuleMyOffice.FdSetString(Fdd9.sichtbar,Fdd9.Name,Fdd9.x,Fdd9.y,Fdd9.l,Fdd9.j,Fdd9.Schrift,Fdd9.Farbe,Fdd9.Groesse,Fdd9.Style,Fdd9.Rahmen,Fdd9.Ena,Fdd9.h);
  FQ.FieldByName('Feld10').AsString:=DataModuleMyOffice.FdSetString(Fdd10.sichtbar,Fdd10.Name,Fdd10.x,Fdd10.y,Fdd10.l,Fdd10.j,Fdd10.Schrift,Fdd10.Farbe,Fdd10.Groesse,Fdd10.Style,Fdd10.Rahmen,Fdd10.Ena,Fdd10.h);
  FQ.FieldByName('Feld11').AsString:=DataModuleMyOffice.FdSetString(Fdd11.sichtbar,Fdd11.Name,Fdd11.x,Fdd11.y,Fdd11.l,Fdd11.j,Fdd11.Schrift,Fdd11.Farbe,Fdd11.Groesse,Fdd11.Style,Fdd11.Rahmen,Fdd11.Ena,Fdd11.h);
  FQ.FieldByName('Feld12').AsString:=DataModuleMyOffice.FdSetString(Fdd12.sichtbar,Fdd12.Name,Fdd12.x,Fdd12.y,Fdd12.l,Fdd12.j,Fdd12.Schrift,Fdd12.Farbe,Fdd12.Groesse,Fdd12.Style,Fdd12.Rahmen,Fdd12.Ena,Fdd12.h);
  FQ.FieldByName('Feld13').AsString:=DataModuleMyOffice.FdSetString(Fdd13.sichtbar,Fdd13.Name,Fdd13.x,Fdd13.y,Fdd13.l,Fdd13.j,Fdd13.Schrift,Fdd13.Farbe,Fdd13.Groesse,Fdd13.Style,Fdd13.Rahmen,Fdd13.Ena,Fdd13.h);
  FQ.FieldByName('Feld14').AsString:=DataModuleMyOffice.FdSetString(Fdd14.sichtbar,Fdd14.Name,Fdd14.x,Fdd14.y,Fdd14.l,Fdd14.j,Fdd14.Schrift,Fdd14.Farbe,Fdd14.Groesse,Fdd14.Style,Fdd14.Rahmen,Fdd14.Ena,Fdd14.h);
  FQ.FieldByName('Feld15').AsString:=DataModuleMyOffice.FdSetString(Fdd15.sichtbar,Fdd15.Name,Fdd15.x,Fdd15.y,Fdd15.l,Fdd15.j,Fdd15.Schrift,Fdd15.Farbe,Fdd15.Groesse,Fdd15.Style,Fdd15.Rahmen,Fdd15.Ena,Fdd15.h);
  FQ.FieldByName('Feld16').AsString:=DataModuleMyOffice.FdSetString(Fdd16.sichtbar,Fdd16.Name,Fdd16.x,Fdd16.y,Fdd16.l,Fdd16.j,Fdd16.Schrift,Fdd16.Farbe,Fdd16.Groesse,Fdd16.Style,Fdd16.Rahmen,Fdd16.Ena,Fdd16.h);
  FQ.FieldByName('Feld17').AsString:=DataModuleMyOffice.FdSetString(Fdd17.sichtbar,Fdd17.Name,Fdd17.x,Fdd17.y,Fdd17.l,Fdd17.j,Fdd17.Schrift,Fdd17.Farbe,Fdd17.Groesse,Fdd17.Style,Fdd17.Rahmen,Fdd17.Ena,Fdd17.h);
  FQ.FieldByName('Feld18').AsString:=DataModuleMyOffice.FdSetString(Fdd18.sichtbar,Fdd18.Name,Fdd18.x,Fdd18.y,Fdd18.l,Fdd18.j,Fdd18.Schrift,Fdd18.Farbe,Fdd18.Groesse,Fdd18.Style,Fdd18.Rahmen,Fdd18.Ena,Fdd18.h);
  FQ.FieldByName('Feld19').AsString:=DataModuleMyOffice.FdSetString(Fdd19.sichtbar,Fdd19.Name,Fdd19.x,Fdd19.y,Fdd19.l,Fdd19.j,Fdd19.Schrift,Fdd19.Farbe,Fdd19.Groesse,Fdd19.Style,Fdd19.Rahmen,Fdd19.Ena,Fdd19.h);
  FQ.FieldByName('Feld20').AsString:=DataModuleMyOffice.FdSetString(Fdd20.sichtbar,Fdd20.Name,Fdd20.x,Fdd20.y,Fdd20.l,Fdd20.j,Fdd20.Schrift,Fdd20.Farbe,Fdd20.Groesse,Fdd20.Style,Fdd20.Rahmen,Fdd20.Ena,Fdd20.h);
  FQ.Post
end;

procedure TDataModuleMyOffice.FdmSetQuery(FQ:TZQuery);
begin
  FQ.Edit;
  FQ.FieldByName('Feld1').AsString:=DataModuleMyOffice.FdSetString(Fdm1.sichtbar,Fdm1.Name,Fdm1.x,Fdm1.y,Fdm1.l,Fdm1.j,Fdm1.Schrift,Fdm1.Farbe,Fdm1.Groesse,Fdm1.Style,Fdm1.Rahmen,Fdm1.Ena,Fdm1.h);
  FQ.FieldByName('Feld2').AsString:=DataModuleMyOffice.FdSetString(Fdm2.sichtbar,Fdm2.Name,Fdm2.x,Fdm2.y,Fdm2.l,Fdm2.j,Fdm2.Schrift,Fdm2.Farbe,Fdm2.Groesse,Fdm2.Style,Fdm2.Rahmen,Fdm2.Ena,Fdm2.h);
  FQ.FieldByName('Feld3').AsString:=DataModuleMyOffice.FdSetString(Fdm3.sichtbar,Fdm3.Name,Fdm3.x,Fdm3.y,Fdm3.l,Fdm3.j,Fdm3.Schrift,Fdm3.Farbe,Fdm3.Groesse,Fdm3.Style,Fdm3.Rahmen,Fdm3.Ena,Fdm3.h);
  FQ.FieldByName('Feld4').AsString:=DataModuleMyOffice.FdSetString(Fdm4.sichtbar,Fdm4.Name,Fdm4.x,Fdm4.y,Fdm1.l,Fdm4.j,Fdm4.Schrift,Fdm4.Farbe,Fdm4.Groesse,Fdm4.Style,Fdm4.Rahmen,Fdm4.Ena,Fdm4.h);
  FQ.FieldByName('Feld5').AsString:=DataModuleMyOffice.FdSetString(Fdm5.sichtbar,Fdm5.Name,Fdm5.x,Fdm5.y,Fdm5.l,Fdm5.j,Fdm5.Schrift,Fdm5.Farbe,Fdm5.Groesse,Fdm5.Style,Fdm5.Rahmen,Fdm5.Ena,Fdm5.h);
  FQ.FieldByName('Feld6').AsString:=DataModuleMyOffice.FdSetString(Fdm6.sichtbar,Fdm6.Name,Fdm6.x,Fdm6.y,Fdm6.l,Fdm6.j,Fdm6.Schrift,Fdm6.Farbe,Fdm6.Groesse,Fdm6.Style,Fdm6.Rahmen,Fdm6.Ena,Fdm6.h);
  FQ.FieldByName('Feld7').AsString:=DataModuleMyOffice.FdSetString(Fdm7.sichtbar,Fdm7.Name,Fdm7.x,Fdm7.y,Fdm7.l,Fdm7.j,Fdm7.Schrift,Fdm7.Farbe,Fdm7.Groesse,Fdm7.Style,Fdm7.Rahmen,Fdm7.Ena,Fdm7.h);
  FQ.FieldByName('Feld8').AsString:=DataModuleMyOffice.FdSetString(Fdm8.sichtbar,Fdm8.Name,Fdm8.x,Fdm8.y,Fdm8.l,Fdm8.j,Fdm8.Schrift,Fdm8.Farbe,Fdm8.Groesse,Fdm8.Style,Fdm8.Rahmen,Fdm8.Ena,Fdm8.h);
  FQ.FieldByName('Feld9').AsString:=DataModuleMyOffice.FdSetString(Fdm9.sichtbar,Fdm9.Name,Fdm9.x,Fdm9.y,Fdm9.l,Fdm9.j,Fdm9.Schrift,Fdm9.Farbe,Fdm9.Groesse,Fdm9.Style,Fdm9.Rahmen,Fdm9.Ena,Fdm9.h);
  FQ.FieldByName('Feld10').AsString:=DataModuleMyOffice.FdSetString(Fdm10.sichtbar,Fdm10.Name,Fdm10.x,Fdm10.y,Fdm10.l,Fdm10.j,Fdm10.Schrift,Fdm10.Farbe,Fdm10.Groesse,Fdm10.Style,Fdm10.Rahmen,Fdm10.Ena,Fdm10.h);
  FQ.FieldByName('Feld11').AsString:=DataModuleMyOffice.FdSetString(Fdm11.sichtbar,Fdm11.Name,Fdm11.x,Fdm11.y,Fdm11.l,Fdm11.j,Fdm11.Schrift,Fdm11.Farbe,Fdm11.Groesse,Fdm11.Style,Fdm11.Rahmen,Fdm11.Ena,Fdm11.h);
  FQ.FieldByName('Feld12').AsString:=DataModuleMyOffice.FdSetString(Fdm12.sichtbar,Fdm12.Name,Fdm12.x,Fdm12.y,Fdm12.l,Fdm12.j,Fdm12.Schrift,Fdm12.Farbe,Fdm12.Groesse,Fdm12.Style,Fdm12.Rahmen,Fdm12.Ena,Fdm12.h);
  FQ.FieldByName('Feld13').AsString:=DataModuleMyOffice.FdSetString(Fdm13.sichtbar,Fdm13.Name,Fdm13.x,Fdm13.y,Fdm13.l,Fdm13.j,Fdm13.Schrift,Fdm13.Farbe,Fdm13.Groesse,Fdm13.Style,Fdm13.Rahmen,Fdm13.Ena,Fdm13.h);
  FQ.FieldByName('Feld14').AsString:=DataModuleMyOffice.FdSetString(Fdm14.sichtbar,Fdm14.Name,Fdm14.x,Fdm14.y,Fdm14.l,Fdm14.j,Fdm14.Schrift,Fdm14.Farbe,Fdm14.Groesse,Fdm14.Style,Fdm14.Rahmen,Fdm14.Ena,Fdm14.h);
  FQ.FieldByName('Feld15').AsString:=DataModuleMyOffice.FdSetString(Fdm15.sichtbar,Fdm15.Name,Fdm15.x,Fdm15.y,Fdm15.l,Fdm15.j,Fdm15.Schrift,Fdm15.Farbe,Fdm15.Groesse,Fdm15.Style,Fdm15.Rahmen,Fdm15.Ena,Fdm15.h);
  FQ.FieldByName('Feld16').AsString:=DataModuleMyOffice.FdSetString(Fdm16.sichtbar,Fdm16.Name,Fdm16.x,Fdm16.y,Fdm16.l,Fdm16.j,Fdm16.Schrift,Fdm16.Farbe,Fdm16.Groesse,Fdm16.Style,Fdm16.Rahmen,Fdm16.Ena,Fdm16.h);
  FQ.FieldByName('Feld17').AsString:=DataModuleMyOffice.FdSetString(Fdm17.sichtbar,Fdm17.Name,Fdm17.x,Fdm17.y,Fdm17.l,Fdm17.j,Fdm17.Schrift,Fdm17.Farbe,Fdm17.Groesse,Fdm17.Style,Fdm17.Rahmen,Fdm17.Ena,Fdm17.h);
  FQ.FieldByName('Feld18').AsString:=DataModuleMyOffice.FdSetString(Fdm18.sichtbar,Fdm18.Name,Fdm18.x,Fdm18.y,Fdm18.l,Fdm18.j,Fdm18.Schrift,Fdm18.Farbe,Fdm18.Groesse,Fdm18.Style,Fdm18.Rahmen,Fdm18.Ena,Fdm18.h);
  FQ.FieldByName('Feld19').AsString:=DataModuleMyOffice.FdSetString(Fdm19.sichtbar,Fdm19.Name,Fdm19.x,Fdm19.y,Fdm19.l,Fdm19.j,Fdm19.Schrift,Fdm19.Farbe,Fdm19.Groesse,Fdm19.Style,Fdm19.Rahmen,Fdm19.Ena,Fdm19.h);
  FQ.FieldByName('Feld20').AsString:=DataModuleMyOffice.FdSetString(Fdm20.sichtbar,Fdm20.Name,Fdm20.x,Fdm20.y,Fdm20.l,Fdm20.j,Fdm20.Schrift,Fdm20.Farbe,Fdm20.Groesse,Fdm20.Style,Fdm20.Rahmen,Fdm20.Ena,Fdm20.h);
  FQ.Post;
end;

procedure TDataModuleMyOffice.FmoSetQuery(FQ:TZQuery);
begin
  FQ.Edit;
  FQ.FieldByName('monitormaske1').AsString:=DataModuleMyOffice.FdSetString(Fmo1.sichtbar,Fmo1.Name,Fmo1.x,Fmo1.y,Fmo1.l,Fmo1.j,Fmo1.Schrift,Fmo1.Farbe,Fmo1.Groesse,Fmo1.Style,Fmo1.Rahmen,Fmo1.Ena,Fmo1.h);
  FQ.FieldByName('monitormaske2').AsString:=DataModuleMyOffice.FdSetString(Fmo2.sichtbar,Fmo2.Name,Fmo2.x,Fmo2.y,Fmo2.l,Fmo2.j,Fmo2.Schrift,Fmo2.Farbe,Fmo2.Groesse,Fmo2.Style,Fmo2.Rahmen,Fmo2.Ena,Fmo2.h);
  FQ.FieldByName('monitormaske3').AsString:=DataModuleMyOffice.FdSetString(Fmo3.sichtbar,Fmo3.Name,Fmo3.x,Fmo3.y,Fmo3.l,Fmo3.j,Fmo3.Schrift,Fmo3.Farbe,Fmo3.Groesse,Fmo3.Style,Fmo3.Rahmen,Fmo3.Ena,Fmo3.h);
  FQ.FieldByName('monitormaske4').AsString:=DataModuleMyOffice.FdSetString(Fmo4.sichtbar,Fmo4.Name,Fmo4.x,Fmo4.y,Fmo1.l,Fmo4.j,Fmo4.Schrift,Fmo4.Farbe,Fmo4.Groesse,Fmo4.Style,Fmo4.Rahmen,Fmo4.Ena,Fmo4.h);
  FQ.FieldByName('monitormaske5').AsString:=DataModuleMyOffice.FdSetString(Fmo5.sichtbar,Fmo5.Name,Fmo5.x,Fmo5.y,Fmo5.l,Fmo5.j,Fmo5.Schrift,Fmo5.Farbe,Fmo5.Groesse,Fmo5.Style,Fmo5.Rahmen,Fmo5.Ena,Fmo5.h);
  FQ.FieldByName('monitormaske6').AsString:=DataModuleMyOffice.FdSetString(Fmo6.sichtbar,Fmo6.Name,Fmo6.x,Fmo6.y,Fmo6.l,Fmo6.j,Fmo6.Schrift,Fmo6.Farbe,Fmo6.Groesse,Fmo6.Style,Fmo6.Rahmen,Fmo6.Ena,Fmo6.h);
  FQ.FieldByName('monitormaske7').AsString:=DataModuleMyOffice.FdSetString(Fmo7.sichtbar,Fmo7.Name,Fmo7.x,Fmo7.y,Fmo7.l,Fmo7.j,Fmo7.Schrift,Fmo7.Farbe,Fmo7.Groesse,Fmo7.Style,Fmo7.Rahmen,Fmo7.Ena,Fmo7.h);
  FQ.FieldByName('monitormaske8').AsString:=DataModuleMyOffice.FdSetString(Fmo8.sichtbar,Fmo8.Name,Fmo8.x,Fmo8.y,Fmo8.l,Fmo8.j,Fmo8.Schrift,Fmo8.Farbe,Fmo8.Groesse,Fmo8.Style,Fmo8.Rahmen,Fmo8.Ena,Fmo8.h);
  FQ.FieldByName('monitormaske9').AsString:=DataModuleMyOffice.FdSetString(Fmo9.sichtbar,Fmo9.Name,Fmo9.x,Fmo9.y,Fmo9.l,Fmo9.j,Fmo9.Schrift,Fmo9.Farbe,Fmo9.Groesse,Fmo9.Style,Fmo9.Rahmen,Fmo9.Ena,Fmo9.h);
  FQ.FieldByName('monitormaske10').AsString:=DataModuleMyOffice.FdSetString(Fmo10.sichtbar,Fmo10.Name,Fmo10.x,Fmo10.y,Fmo10.l,Fmo10.j,Fmo10.Schrift,Fmo10.Farbe,Fmo10.Groesse,Fmo10.Style,Fmo10.Rahmen,Fmo10.Ena,Fmo10.h);
  FQ.FieldByName('monitormaske11').AsString:=DataModuleMyOffice.FdSetString(Fmo11.sichtbar,Fmo11.Name,Fmo11.x,Fmo11.y,Fmo11.l,Fmo11.j,Fmo11.Schrift,Fmo11.Farbe,Fmo11.Groesse,Fmo11.Style,Fmo11.Rahmen,Fmo11.Ena,Fmo11.h);
  FQ.FieldByName('monitormaske12').AsString:=DataModuleMyOffice.FdSetString(Fmo12.sichtbar,Fmo12.Name,Fmo12.x,Fmo12.y,Fmo12.l,Fmo12.j,Fmo12.Schrift,Fmo12.Farbe,Fmo12.Groesse,Fmo12.Style,Fmo12.Rahmen,Fmo12.Ena,Fmo12.h);
  FQ.FieldByName('monitormaske13').AsString:=DataModuleMyOffice.FdSetString(Fmo13.sichtbar,Fmo13.Name,Fmo13.x,Fmo13.y,Fmo13.l,Fmo13.j,Fmo13.Schrift,Fmo13.Farbe,Fmo13.Groesse,Fmo13.Style,Fmo13.Rahmen,Fmo13.Ena,Fmo13.h);
  FQ.FieldByName('monitormaske14').AsString:=DataModuleMyOffice.FdSetString(Fmo14.sichtbar,Fmo14.Name,Fmo14.x,Fmo14.y,Fmo14.l,Fmo14.j,Fmo14.Schrift,Fmo14.Farbe,Fmo14.Groesse,Fmo14.Style,Fmo14.Rahmen,Fmo14.Ena,Fmo14.h);
  FQ.FieldByName('monitormaske15').AsString:=DataModuleMyOffice.FdSetString(Fmo15.sichtbar,Fmo15.Name,Fmo15.x,Fmo15.y,Fmo15.l,Fmo15.j,Fmo15.Schrift,Fmo15.Farbe,Fmo15.Groesse,Fmo15.Style,Fmo15.Rahmen,Fmo15.Ena,Fmo15.h);
  FQ.FieldByName('monitormaske16').AsString:=DataModuleMyOffice.FdSetString(Fmo16.sichtbar,Fmo16.Name,Fmo16.x,Fmo16.y,Fmo16.l,Fmo16.j,Fmo16.Schrift,Fmo16.Farbe,Fmo16.Groesse,Fmo16.Style,Fmo16.Rahmen,Fmo16.Ena,Fmo16.h);
  FQ.FieldByName('monitormaske17').AsString:=DataModuleMyOffice.FdSetString(Fmo17.sichtbar,Fmo17.Name,Fmo17.x,Fmo17.y,Fmo17.l,Fmo17.j,Fmo17.Schrift,Fmo17.Farbe,Fmo17.Groesse,Fmo17.Style,Fmo17.Rahmen,Fmo17.Ena,Fmo17.h);
  FQ.FieldByName('monitormaske18').AsString:=DataModuleMyOffice.FdSetString(Fmo18.sichtbar,Fmo18.Name,Fmo18.x,Fmo18.y,Fmo18.l,Fmo18.j,Fmo18.Schrift,Fmo18.Farbe,Fmo18.Groesse,Fmo18.Style,Fmo18.Rahmen,Fmo18.Ena,Fmo18.h);
  FQ.FieldByName('monitormaske19').AsString:=DataModuleMyOffice.FdSetString(Fmo19.sichtbar,Fmo19.Name,Fmo19.x,Fmo19.y,Fmo19.l,Fmo19.j,Fmo19.Schrift,Fmo19.Farbe,Fmo19.Groesse,Fmo19.Style,Fmo19.Rahmen,Fmo19.Ena,Fmo19.h);
  FQ.FieldByName('monitormaske20').AsString:=DataModuleMyOffice.FdSetString(Fmo20.sichtbar,Fmo20.Name,Fmo20.x,Fmo20.y,Fmo20.l,Fmo20.j,Fmo20.Schrift,Fmo20.Farbe,Fmo20.Groesse,Fmo20.Style,Fmo20.Rahmen,Fmo20.Ena,Fmo20.h);
  FQ.Post;
end;

function TDataModuleMyOffice.FdSetString(sichtbar:integer;Name:String;x,y,l,j:integer;Schrift,Farbe:String;Groesse,Style,Rahmen,Ena,h:integer):String;
var sReturn:String;
    z:String;
begin
  z:=';';
  sReturn:=inttostr(sichtbar);
  sReturn:=sReturn+z+Name;
  sReturn:=sReturn+z+inttostr(x);
  sReturn:=sReturn+z+inttostr(y);
  sReturn:=sReturn+z+inttostr(l);
  sReturn:=sReturn+z+inttostr(j);
  sReturn:=sReturn+z+Schrift;
  sReturn:=sReturn+z+Farbe;
  sReturn:=sReturn+z+inttostr(Groesse);
  sReturn:=sReturn+z+inttostr(Style);
  sReturn:=sReturn+z+inttostr(Rahmen);
  sReturn:=sReturn+z+inttostr(Ena);
  sReturn:=sReturn+z+inttostr(h);
  sReturn:=sReturn+z;
  {sTemp:=inttostr(sichtbar); solllaenge:=1;
  istlaenge:=length(sTemp);if istlaenge>solllaenge then sTemp:=copy(stemp,1,solllaenge);
  istlaenge:=length(sTemp);
  for i:=1 to solllaenge do if i <= istlaenge then  sReturn:=sReturn+copy(sTemp,i,1) Else sReturn:=sReturn+' ';

  sTemp:=Name; solllaenge:=25;
  istlaenge:=length(sTemp);if istlaenge>solllaenge then sTemp:=copy(stemp,1,solllaenge);
  istlaenge:=length(sTemp);
  for i:=1 to solllaenge do if i <= istlaenge then  sReturn:=sReturn+copy(sTemp,i,1) Else sReturn:=sReturn+' ';

  sTemp:=inttostr(x); solllaenge:=4;
  istlaenge:=length(sTemp);if istlaenge>solllaenge then sTemp:=copy(stemp,1,solllaenge);
  istlaenge:=length(sTemp);
  for i:=1 to solllaenge do if i <= istlaenge then  sReturn:=sReturn+copy(sTemp,i,1) Else sReturn:=sReturn+' ';

  sTemp:=inttostr(y); solllaenge:=4;
  istlaenge:=length(sTemp);if istlaenge>solllaenge then sTemp:=copy(stemp,1,solllaenge);
  istlaenge:=length(sTemp);
  for i:=1 to solllaenge do if i <= istlaenge then  sReturn:=sReturn+copy(sTemp,i,1) Else sReturn:=sReturn+' ';

  sTemp:=inttostr(l); solllaenge:=4;
  istlaenge:=length(sTemp);if istlaenge>solllaenge then sTemp:=copy(stemp,1,solllaenge);
  istlaenge:=length(sTemp);
  for i:=1 to solllaenge do if i <= istlaenge then  sReturn:=sReturn+copy(sTemp,i,1) Else sReturn:=sReturn+' ';

  sTemp:=inttostr(j); solllaenge:=4;
  istlaenge:=length(sTemp);if istlaenge>solllaenge then sTemp:=copy(stemp,1,solllaenge);
  istlaenge:=length(sTemp);
  for i:=1 to solllaenge do if i <= istlaenge then  sReturn:=sReturn+copy(sTemp,i,1) Else sReturn:=sReturn+' ';

  sTemp:=Schrift; solllaenge:=25;
  istlaenge:=length(sTemp);if istlaenge>solllaenge then sTemp:=copy(stemp,1,solllaenge);
  istlaenge:=length(sTemp);
  for i:=1 to solllaenge do if i <= istlaenge then  sReturn:=sReturn+copy(sTemp,i,1) Else sReturn:=sReturn+' ';
  for i:=0 to 149 do s[i]:=' ';
  sTemp:=inttostr(sichtbar); sLaenge:=length(sTemp);zaehler:=1;
                             for i:=1 to 1  do begin
                               if zaehler<=sLaenge then s[i]:=copy(sTemp,zaehler,1)[1] Else  s[i]:=' ';
                               zaehler:=zaehler+1;
                             end;
  sTemp:=Name;               sLaenge:=length(sTemp);zaehler:=1;
                             for i:=2 to 26  do begin
                               if zaehler<=sLaenge then s[i]:=copy(sTemp,zaehler,1)[1] Else  s[i]:=' ';
                               zaehler:=zaehler+1;
                             end;
  Showmessage('sichbar+Name= '+s);
  sTemp:=inttostr(x);        sLaenge:=length(sTemp);zaehler:=1;
                             for i:=27 to 30  do begin
                               if zaehler<=sLaenge then s[i]:=copy(sTemp,zaehler,1)[1] Else  s[i]:=' ';
                               zaehler:=zaehler+1;
                             end;
  sTemp:=inttostr(y);        sLaenge:=length(sTemp);zaehler:=1;
                             for i:=31 to 34  do begin
                               if zaehler<=sLaenge then s[i]:=copy(sTemp,zaehler,1)[1] Else  s[i]:=' ';
                               zaehler:=zaehler+1;
                             end;
  sTemp:=inttostr(l);        sLaenge:=length(sTemp);zaehler:=1;
                             for i:=35 to 38  do begin
                               if zaehler<=sLaenge then s[i]:=copy(sTemp,zaehler,1)[1] Else  s[i]:=' ';
                               zaehler:=zaehler+1;
                             end;
  sTemp:=inttostr(j);        sLaenge:=length(sTemp);zaehler:=1;
                             for i:=39 to 42  do begin
                               if zaehler<=sLaenge then s[i]:=copy(sTemp,zaehler,1)[1] Else  s[i]:=' ';
                               zaehler:=zaehler+1;
                             end;
  sTemp:=Schrift;            sLaenge:=length(sTemp);zaehler:=1;
                             for i:=43 to 67  do begin
                               if zaehler<=sLaenge then s[i]:=copy(sTemp,zaehler,1)[1] Else  s[i]:=' ';
                               zaehler:=zaehler+1;
                             end;
  sTemp:=Farbe;              sLaenge:=length(sTemp);zaehler:=1;
                             for i:=68 to 76  do begin
                               if zaehler<=sLaenge then s[i]:=copy(sTemp,zaehler,1)[1] Else  s[i]:=' ';
                               zaehler:=zaehler+1;
                             end;
  sTemp:=inttostr(Groesse);  sLaenge:=length(sTemp);zaehler:=1;
                             for i:=77 to 78  do begin
                               if zaehler<=sLaenge then s[i]:=copy(sTemp,zaehler,1)[1] Else  s[i]:=' ';
                               zaehler:=zaehler+1;
                             end;
  sTemp:=inttostr(Style);    sLaenge:=length(sTemp);zaehler:=1;
                             for i:=79 to 80  do begin
                               if zaehler<=sLaenge then s[i]:=copy(sTemp,zaehler,1)[1] Else  s[i]:=' ';
                               zaehler:=zaehler+1;
                             end;
 sTemp:=inttostr(Rahmen);    sLaenge:=length(sTemp);zaehler:=1;
                             for i:=81 to 82  do begin
                               if zaehler<=sLaenge then s[i]:=copy(sTemp,zaehler,1)[1] Else  s[i]:=' ';
                               zaehler:=zaehler+1;
                             end;
 sTemp:=inttostr(Ena);       sLaenge:=length(sTemp);zaehler:=1;
                             for i:=83 to 83  do begin
                               if zaehler<=sLaenge then s[i]:=copy(sTemp,zaehler,1)[1] Else  s[i]:=' ';
                               zaehler:=zaehler+1;
                             end;
 //for i:=84 to 148  do s[i]:=' ';
 //s[149]:=' ';}
 //Showmessage(sReturn);
 result:=sReturn;
end;

function TDataModuleMyOffice.FdmoSetString(sichtbar:integer;Name:String;x,y,l,j:integer;Schrift,Farbe:String;Groesse,Style,Rahmen,Ena,h:integer;Berechnung:String):String;
var sReturn:String;
    z:String;
begin
  z:=';';
  sReturn:=inttostr(sichtbar);
  sReturn:=sReturn+z+Name;
  sReturn:=sReturn+z+inttostr(x);
  sReturn:=sReturn+z+inttostr(y);
  sReturn:=sReturn+z+inttostr(l);
  sReturn:=sReturn+z+inttostr(j);
  sReturn:=sReturn+z+Schrift;
  sReturn:=sReturn+z+Farbe;
  sReturn:=sReturn+z+inttostr(Groesse);
  sReturn:=sReturn+z+inttostr(Style);
  sReturn:=sReturn+z+inttostr(Rahmen);
  sReturn:=sReturn+z+inttostr(Ena);
  sReturn:=sReturn+z+inttostr(h);
  sReturn:=sReturn+z+Berechnung;
  sReturn:=sReturn+z;
  result:=sReturn;
end;

procedure TDataModuleMyOffice.FddNil(z:integer);
begin
  if (z=1) or (z>20) Then begin
    Fdd1.Sichtbar:=0;Fdd1.Name:='';Fdd1.x:=0;Fdd1.y:=0;Fdd1.l:=0;Fdd1.j:=0;Fdd1.Schrift:='Arial';Fdd1.Farbe:='clWhite';
    Fdd1.Groesse:=0;Fdd1.Style:=0;Fdd1.Rahmen:=0;Fdd1.Ena:=0;Fdd1.h:=0;
  end;
  if (z=2) or (z>20) Then begin
    Fdd2.Sichtbar:=0;Fdd2.Name:='';Fdd2.x:=0;Fdd2.y:=0;Fdd2.l:=0;Fdd2.j:=0;Fdd2.Schrift:='Arial';Fdd2.Farbe:='clWhite';
    Fdd2.Groesse:=0;Fdd2.Style:=0;Fdd2.Rahmen:=0;Fdd2.Ena:=0;Fdd2.h:=0;
  end;
  if (z=3) or (z>20) Then begin
    Fdd3.Sichtbar:=0;Fdd3.Name:='';Fdd3.x:=0;Fdd3.y:=0;Fdd3.l:=0;Fdd3.j:=0;Fdd3.Schrift:='Arial';Fdd3.Farbe:='clWhite';
    Fdd3.Groesse:=0;Fdd3.Style:=0;Fdd3.Rahmen:=0;Fdd3.Ena:=0;Fdd3.h:=0;
  end;
  if (z=4) or (z>20) Then begin
    Fdd4.Sichtbar:=0;Fdd4.Name:='';Fdd4.x:=0;Fdd4.y:=0;Fdd4.l:=0;Fdd4.j:=0;Fdd4.Schrift:='Arial';Fdd4.Farbe:='clWhite';
    Fdd4.Groesse:=0;Fdd4.Style:=0;Fdd4.Rahmen:=0;Fdd4.Ena:=0;Fdd4.h:=0;
  end;
  if (z=5) or (z>20) Then begin
    Fdd5.Sichtbar:=0;Fdd5.Name:='';Fdd5.x:=0;Fdd5.y:=0;Fdd5.l:=0;Fdd5.j:=0;Fdd5.Schrift:='Arial';Fdd5.Farbe:='clWhite';
    Fdd5.Groesse:=0;Fdd5.Style:=0;Fdd5.Rahmen:=0;Fdd5.Ena:=0;Fdd5.h:=0;
  end;
  if (z=6) or (z>20) Then begin
    Fdd6.Sichtbar:=0;Fdd6.Name:='';Fdd6.x:=0;Fdd6.y:=0;Fdd6.l:=0;Fdd6.j:=0;Fdd6.Schrift:='Arial';Fdd6.Farbe:='clWhite';
    Fdd6.Groesse:=0;Fdd6.Style:=0;Fdd6.Rahmen:=0;Fdd6.Ena:=0;Fdd6.h:=0;
  end;
  if (z=7) or (z>20) Then begin
    Fdd7.Sichtbar:=0;Fdd7.Name:='';Fdd7.x:=0;Fdd7.y:=0;Fdd7.l:=0;Fdd7.j:=0;Fdd7.Schrift:='Arial';Fdd7.Farbe:='clWhite';
    Fdd7.Groesse:=0;Fdd7.Style:=0;Fdd7.Rahmen:=0;Fdd7.Ena:=0;Fdd7.h:=0;
  end;
  if (z=8) or (z>20) Then begin
    Fdd8.Sichtbar:=0;Fdd8.Name:='';Fdd8.x:=0;Fdd8.y:=0;Fdd8.l:=0;Fdd8.j:=0;Fdd8.Schrift:='Arial';Fdd8.Farbe:='clWhite';
    Fdd8.Groesse:=0;Fdd8.Style:=0;Fdd8.Rahmen:=0;Fdd8.Ena:=0;Fdd8.h:=0;
  end;
  if (z=9) or (z>20) Then begin
    Fdd9.Sichtbar:=0;Fdd9.Name:='';Fdd9.x:=0;Fdd9.y:=0;Fdd9.l:=0;Fdd9.j:=0;Fdd9.Schrift:='Arial';Fdd9.Farbe:='clWhite';
    Fdd9.Groesse:=0;Fdd9.Style:=0;Fdd9.Rahmen:=0;Fdd9.Ena:=0;Fdd9.h:=0;
  end;
  if (z=10) or (z>20) Then begin
    Fdd10.Sichtbar:=0;Fdd10.Name:='';Fdd10.x:=0;Fdd10.y:=0;Fdd10.l:=0;Fdd10.j:=0;Fdd10.Schrift:='Arial';Fdd10.Farbe:='clWhite';
    Fdd10.Groesse:=0;Fdd10.Style:=0;Fdd10.Rahmen:=0;Fdd10.Ena:=0;Fdd10.h:=0;
  end;
  if (z=11) or (z>20) Then begin
    Fdd11.Sichtbar:=0;Fdd11.Name:='';Fdd11.x:=0;Fdd11.y:=0;Fdd11.l:=0;Fdd11.j:=0;Fdd11.Schrift:='Arial';Fdd11.Farbe:='clWhite';
    Fdd11.Groesse:=0;Fdd11.Style:=0;Fdd11.Rahmen:=0;Fdd11.Ena:=0;Fdd11.h:=0;
  end;
  if (z=12) or (z>20) Then begin
    Fdd12.Sichtbar:=0;Fdd12.Name:='';Fdd12.x:=0;Fdd12.y:=0;Fdd12.l:=0;Fdd12.j:=0;Fdd12.Schrift:='Arial';Fdd12.Farbe:='clWhite';
    Fdd1.Groesse:=0;Fdd1.Style:=0;Fdd1.Rahmen:=0;Fdd1.Ena:=0;Fdd12.h:=0;
  end;
  if (z=13) or (z>20) Then begin
    Fdd13.Sichtbar:=0;Fdd13.Name:='';Fdd13.x:=0;Fdd13.y:=0;Fdd13.l:=0;Fdd13.j:=0;Fdd13.Schrift:='Arial';Fdd13.Farbe:='clWhite';
    Fdd13.Groesse:=0;Fdd13.Style:=0;Fdd13.Rahmen:=0;Fdd13.Ena:=0;Fdd13.h:=0;
  end;
  if (z=14) or (z>20) Then begin
    Fdd14.Sichtbar:=0;Fdd14.Name:='';Fdd14.x:=0;Fdd14.y:=0;Fdd14.l:=0;Fdd14.j:=0;Fdd14.Schrift:='Arial';Fdd14.Farbe:='clWhite';
    Fdd14.Groesse:=0;Fdd14.Style:=0;Fdd14.Rahmen:=0;Fdd14.Ena:=0;Fdd14.h:=0;
  end;
  if (z=15) or (z>20) Then begin
    Fdd15.Sichtbar:=0;Fdd15.Name:='';Fdd15.x:=0;Fdd15.y:=0;Fdd15.l:=0;Fdd15.j:=0;Fdd15.Schrift:='Arial';Fdd15.Farbe:='clWhite';
    Fdd15.Groesse:=0;Fdd15.Style:=0;Fdd15.Rahmen:=0;Fdd15.Ena:=0;Fdd15.h:=0;
  end;
  if (z=16) or (z>20) Then begin
    Fdd16.Sichtbar:=0;Fdd16.Name:='';Fdd16.x:=0;Fdd16.y:=0;Fdd16.l:=0;Fdd16.j:=0;Fdd16.Schrift:='Arial';Fdd16.Farbe:='clWhite';
    Fdd16.Groesse:=0;Fdd16.Style:=0;Fdd16.Rahmen:=0;Fdd16.Ena:=0;Fdd16.h:=0;
  end;
  if (z=17) or (z>20) Then begin
    Fdd17.Sichtbar:=0;Fdd17.Name:='';Fdd17.x:=0;Fdd17.y:=0;Fdd17.l:=0;Fdd17.j:=0;Fdd17.Schrift:='Arial';Fdd17.Farbe:='clWhite';
    Fdd17.Groesse:=0;Fdd17.Style:=0;Fdd17.Rahmen:=0;Fdd17.Ena:=0;Fdd17.h:=0;
  end;
  if (z=18) or (z>20) Then begin
    Fdd18.Sichtbar:=0;Fdd18.Name:='';Fdd18.x:=0;Fdd18.y:=0;Fdd18.l:=0;Fdd18.j:=0;Fdd18.Schrift:='Arial';Fdd18.Farbe:='clWhite';
    Fdd18.Groesse:=0;Fdd18.Style:=0;Fdd18.Rahmen:=0;Fdd18.Ena:=0;Fdd18.h:=0;
  end;
  if (z=19) or (z>20) Then begin
    Fdd19.Sichtbar:=0;Fdd19.Name:='';Fdd19.x:=0;Fdd19.y:=0;Fdd19.l:=0;Fdd19.j:=0;Fdd19.Schrift:='Arial';Fdd19.Farbe:='clWhite';
    Fdd19.Groesse:=0;Fdd19.Style:=0;Fdd19.Rahmen:=0;Fdd19.Ena:=0;Fdd19.h:=0;
  end;
  if (z=20) or (z>20) Then begin
    Fdd20.Sichtbar:=0;Fdd20.Name:='';Fdd20.x:=0;Fdd20.y:=0;Fdd20.l:=0;Fdd20.j:=0;Fdd20.Schrift:='Arial';Fdd20.Farbe:='clWhite';
    Fdd20.Groesse:=0;Fdd20.Style:=0;Fdd20.Rahmen:=0;Fdd20.Ena:=0;Fdd20.h:=0;
  end;

end;

procedure TDataModuleMyOffice.FdmNil(z:integer);
begin
  if (z=1) or (z>20) Then begin
    Fdm1.Sichtbar:=0;Fdm1.Name:='';Fdm1.x:=0;Fdm1.y:=0;Fdm1.l:=0;Fdm1.j:=0;Fdm1.Schrift:='Arial';Fdm1.Farbe:='clWhite';
    Fdm1.Groesse:=0;Fdm1.Style:=0;Fdm1.Rahmen:=0;Fdm1.Ena:=0;Fdm1.h:=0;
  end;
  if (z=2) or (z>20) Then begin
    Fdm2.Sichtbar:=0;Fdm2.Name:='';Fdm2.x:=0;Fdm2.y:=0;Fdm2.l:=0;Fdm2.j:=0;Fdm2.Schrift:='Arial';Fdm2.Farbe:='clWhite';
    Fdm2.Groesse:=0;Fdm2.Style:=0;Fdm2.Rahmen:=0;Fdm2.Ena:=0;Fdm2.h:=0;
  end;
  if (z=3) or (z>20) Then begin
    Fdm3.Sichtbar:=0;Fdm3.Name:='';Fdm3.x:=0;Fdm3.y:=0;Fdm3.l:=0;Fdm3.j:=0;Fdm3.Schrift:='Arial';Fdm3.Farbe:='clWhite';
    Fdm3.Groesse:=0;Fdm3.Style:=0;Fdm3.Rahmen:=0;Fdm3.Ena:=0;Fdm3.h:=0;
  end;
  if (z=4) or (z>20) Then begin
    Fdm4.Sichtbar:=0;Fdm4.Name:='';Fdm4.x:=0;Fdm4.y:=0;Fdm4.l:=0;Fdm4.j:=0;Fdm4.Schrift:='Arial';Fdm4.Farbe:='clWhite';
    Fdm4.Groesse:=0;Fdm4.Style:=0;Fdm4.Rahmen:=0;Fdm4.Ena:=0;Fdm4.h:=0;
  end;
  if (z=5) or (z>20) Then begin
    Fdm5.Sichtbar:=0;Fdm5.Name:='';Fdm5.x:=0;Fdm5.y:=0;Fdm5.l:=0;Fdm5.j:=0;Fdm5.Schrift:='Arial';Fdm5.Farbe:='clWhite';
    Fdm5.Groesse:=0;Fdm5.Style:=0;Fdm5.Rahmen:=0;Fdm5.Ena:=0;Fdm5.h:=0;
  end;
  if (z=6) or (z>20) Then begin
    Fdm6.Sichtbar:=0;Fdm6.Name:='';Fdm6.x:=0;Fdm6.y:=0;Fdm6.l:=0;Fdm6.j:=0;Fdm6.Schrift:='Arial';Fdm6.Farbe:='clWhite';
    Fdm6.Groesse:=0;Fdm6.Style:=0;Fdm6.Rahmen:=0;Fdm6.Ena:=0;Fdm6.h:=0;
  end;
  if (z=7) or (z>20) Then begin
    Fdm7.Sichtbar:=0;Fdm7.Name:='';Fdm7.x:=0;Fdm7.y:=0;Fdm7.l:=0;Fdm7.j:=0;Fdm7.Schrift:='Arial';Fdm7.Farbe:='clWhite';
    Fdm7.Groesse:=0;Fdm7.Style:=0;Fdm7.Rahmen:=0;Fdm7.Ena:=0;Fdm7.h:=0;
  end;
  if (z=8) or (z>20) Then begin
    Fdm8.Sichtbar:=0;Fdm8.Name:='';Fdm8.x:=0;Fdm8.y:=0;Fdm8.l:=0;Fdm8.j:=0;Fdm8.Schrift:='Arial';Fdm8.Farbe:='clWhite';
    Fdm8.Groesse:=0;Fdm8.Style:=0;Fdm8.Rahmen:=0;Fdm8.Ena:=0;Fdm8.h:=0;
  end;
  if (z=9) or (z>20) Then begin
    Fdm9.Sichtbar:=0;Fdm9.Name:='';Fdm9.x:=0;Fdm9.y:=0;Fdm9.l:=0;Fdm9.j:=0;Fdm9.Schrift:='Arial';Fdm9.Farbe:='clWhite';
    Fdm9.Groesse:=0;Fdm9.Style:=0;Fdm9.Rahmen:=0;Fdm9.Ena:=0;Fdm9.h:=0;
  end;
  if (z=10) or (z>20) Then begin
    Fdm10.Sichtbar:=0;Fdm10.Name:='';Fdm10.x:=0;Fdm10.y:=0;Fdm10.l:=0;Fdm10.j:=0;Fdm10.Schrift:='Arial';Fdm10.Farbe:='clWhite';
    Fdm10.Groesse:=0;Fdm10.Style:=0;Fdm10.Rahmen:=0;Fdm10.Ena:=0;Fdm10.h:=0;
  end;
  if (z=11) or (z>20) Then begin
    Fdm11.Sichtbar:=0;Fdm11.Name:='';Fdm11.x:=0;Fdm11.y:=0;Fdm11.l:=0;Fdm11.j:=0;Fdm11.Schrift:='Arial';Fdm11.Farbe:='clWhite';
    Fdm11.Groesse:=0;Fdm11.Style:=0;Fdm11.Rahmen:=0;Fdm11.Ena:=0;Fdm11.h:=0;
  end;
  if (z=12) or (z>20) Then begin
    Fdm12.Sichtbar:=0;Fdm12.Name:='';Fdm12.x:=0;Fdm12.y:=0;Fdm12.l:=0;Fdm12.j:=0;Fdm12.Schrift:='Arial';Fdm12.Farbe:='clWhite';
    Fdm1.Groesse:=0;Fdm1.Style:=0;Fdm1.Rahmen:=0;Fdm1.Ena:=0;Fdm12.h:=0;
  end;
  if (z=13) or (z>20) Then begin
    Fdm13.Sichtbar:=0;Fdm13.Name:='';Fdm13.x:=0;Fdm13.y:=0;Fdm13.l:=0;Fdm13.j:=0;Fdm13.Schrift:='Arial';Fdm13.Farbe:='clWhite';
    Fdm13.Groesse:=0;Fdm13.Style:=0;Fdm13.Rahmen:=0;Fdm13.Ena:=0;Fdm13.h:=0;
  end;
  if (z=14) or (z>20) Then begin
    Fdm14.Sichtbar:=0;Fdm14.Name:='';Fdm14.x:=0;Fdm14.y:=0;Fdm14.l:=0;Fdm14.j:=0;Fdm14.Schrift:='Arial';Fdm14.Farbe:='clWhite';
    Fdm14.Groesse:=0;Fdm14.Style:=0;Fdm14.Rahmen:=0;Fdm14.Ena:=0;Fdm14.h:=0;
  end;
  if (z=15) or (z>20) Then begin
    Fdm15.Sichtbar:=0;Fdm15.Name:='';Fdm15.x:=0;Fdm15.y:=0;Fdm15.l:=0;Fdm15.j:=0;Fdm15.Schrift:='Arial';Fdm15.Farbe:='clWhite';
    Fdm15.Groesse:=0;Fdm15.Style:=0;Fdm15.Rahmen:=0;Fdm15.Ena:=0;Fdm15.h:=0;
  end;
  if (z=16) or (z>20) Then begin
    Fdm16.Sichtbar:=0;Fdm16.Name:='';Fdm16.x:=0;Fdm16.y:=0;Fdm16.l:=0;Fdm16.j:=0;Fdm16.Schrift:='Arial';Fdm16.Farbe:='clWhite';
    Fdm16.Groesse:=0;Fdm16.Style:=0;Fdm16.Rahmen:=0;Fdm16.Ena:=0;Fdm16.h:=0;
  end;
  if (z=17) or (z>20) Then begin
    Fdm17.Sichtbar:=0;Fdm17.Name:='';Fdm17.x:=0;Fdm17.y:=0;Fdm17.l:=0;Fdm17.j:=0;Fdm17.Schrift:='Arial';Fdm17.Farbe:='clWhite';
    Fdm17.Groesse:=0;Fdm17.Style:=0;Fdm17.Rahmen:=0;Fdm17.Ena:=0;Fdm17.h:=0;
  end;
  if (z=18) or (z>20) Then begin
    Fdm18.Sichtbar:=0;Fdm18.Name:='';Fdm18.x:=0;Fdm18.y:=0;Fdm18.l:=0;Fdm18.j:=0;Fdm18.Schrift:='Arial';Fdm18.Farbe:='clWhite';
    Fdm18.Groesse:=0;Fdm18.Style:=0;Fdm18.Rahmen:=0;Fdm18.Ena:=0;Fdm18.h:=0;
  end;
  if (z=19) or (z>20) Then begin
    Fdm19.Sichtbar:=0;Fdm19.Name:='';Fdm19.x:=0;Fdm19.y:=0;Fdm19.l:=0;Fdm19.j:=0;Fdm19.Schrift:='Arial';Fdm19.Farbe:='clWhite';
    Fdm19.Groesse:=0;Fdm19.Style:=0;Fdm19.Rahmen:=0;Fdm19.Ena:=0;Fdm19.h:=0;
  end;
  if (z=20) or (z>20) Then begin
    Fdm20.Sichtbar:=0;Fdm20.Name:='';Fdm20.x:=0;Fdm20.y:=0;Fdm20.l:=0;Fdm20.j:=0;Fdm20.Schrift:='Arial';Fdm20.Farbe:='clWhite';
    Fdm20.Groesse:=0;Fdm20.Style:=0;Fdm20.Rahmen:=0;Fdm20.Ena:=0;Fdm20.h:=0;
  end;
end;

procedure TDataModuleMyOffice.FmoNil(z:integer);
begin
  if (z=1) or (z>20) Then begin
    Fmo1.Sichtbar:=0;Fmo1.Name:='';Fmo1.x:=0;Fmo1.y:=0;Fmo1.l:=0;Fmo1.j:=0;Fmo1.Schrift:='MS Sans Serif';Fmo1.Farbe:='clBlue';
    Fmo1.Groesse:=8;Fmo1.Style:=0;Fmo1.Rahmen:=0;Fmo1.Ena:=0;Fmo1.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=2) or (z>20) Then begin
    Fmo2.Sichtbar:=0;Fmo2.Name:='';Fmo2.x:=0;Fmo2.y:=0;Fmo2.l:=0;Fmo2.j:=0;Fmo2.Schrift:='MS Sans Serif';Fmo2.Farbe:='clBlue';
    Fmo2.Groesse:=8;Fmo2.Style:=0;Fmo2.Rahmen:=0;Fmo2.Ena:=0;Fmo2.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=3) or (z>20) Then begin
    Fmo3.Sichtbar:=0;Fmo3.Name:='';Fmo3.x:=0;Fmo3.y:=0;Fmo3.l:=0;Fmo3.j:=0;Fmo3.Schrift:='MS Sans Serif';Fmo3.Farbe:='clBlue';
    Fmo3.Groesse:=8;Fmo3.Style:=0;Fmo3.Rahmen:=0;Fmo3.Ena:=0;Fmo3.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=4) or (z>20) Then begin
    Fmo4.Sichtbar:=0;Fmo4.Name:='';Fmo4.x:=0;Fmo4.y:=0;Fmo4.l:=0;Fmo4.j:=0;Fmo4.Schrift:='MS Sans Serif';Fmo4.Farbe:='clBlue';
    Fmo4.Groesse:=8;Fmo4.Style:=0;Fmo4.Rahmen:=0;Fmo4.Ena:=0;Fmo4.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=5) or (z>20) Then begin
    Fmo5.Sichtbar:=0;Fmo5.Name:='';Fmo5.x:=0;Fmo5.y:=0;Fmo5.l:=0;Fmo5.j:=0;Fmo5.Schrift:='MS Sans Serif';Fmo5.Farbe:='clBlue';
    Fmo5.Groesse:=8;Fmo5.Style:=0;Fmo5.Rahmen:=0;Fmo5.Ena:=0;Fmo5.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=6) or (z>20) Then begin
    Fmo6.Sichtbar:=0;Fmo6.Name:='';Fmo6.x:=0;Fmo6.y:=0;Fmo6.l:=0;Fmo6.j:=0;Fmo6.Schrift:='MS Sans Serif';Fmo6.Farbe:='clBlue';
    Fmo6.Groesse:=8;Fmo6.Style:=0;Fmo6.Rahmen:=0;Fmo6.Ena:=0;Fmo6.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=7) or (z>20) Then begin
    Fmo7.Sichtbar:=0;Fmo7.Name:='';Fmo7.x:=0;Fmo7.y:=0;Fmo7.l:=0;Fmo7.j:=0;Fmo7.Schrift:='MS Sans Serif';Fmo7.Farbe:='clBlue';
    Fmo7.Groesse:=8;Fmo7.Style:=0;Fmo7.Rahmen:=0;Fmo7.Ena:=0;Fmo7.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=8) or (z>20) Then begin
    Fmo8.Sichtbar:=0;Fmo8.Name:='';Fmo8.x:=0;Fmo8.y:=0;Fmo8.l:=0;Fmo8.j:=0;Fmo8.Schrift:='MS Sans Serif';Fmo8.Farbe:='clBlue';
    Fmo8.Groesse:=0;Fmo8.Style:=0;Fmo8.Rahmen:=0;Fmo8.Ena:=0;Fmo8.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=9) or (z>20) Then begin
    Fmo9.Sichtbar:=0;Fmo9.Name:='';Fmo9.x:=0;Fmo9.y:=0;Fmo9.l:=0;Fmo9.j:=0;Fmo9.Schrift:='MS Sans Serif';Fmo9.Farbe:='clBlue';
    Fmo9.Groesse:=8;Fmo9.Style:=0;Fmo9.Rahmen:=0;Fmo9.Ena:=0;Fmo9.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=10) or (z>20) Then begin
    Fmo10.Sichtbar:=0;Fmo10.Name:='';Fmo10.x:=0;Fmo10.y:=0;Fmo10.l:=0;Fmo10.j:=0;Fmo10.Schrift:='MS Sans Serif';Fmo10.Farbe:='clBlue';
    Fmo10.Groesse:=8;Fmo10.Style:=0;Fmo10.Rahmen:=0;Fmo10.Ena:=0;Fmo10.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=11) or (z>20) Then begin
    Fmo11.Sichtbar:=0;Fmo11.Name:='';Fmo11.x:=0;Fmo11.y:=0;Fmo11.l:=0;Fmo11.j:=0;Fmo11.Schrift:='MS Sans Serif';Fmo11.Farbe:='clBlue';
    Fmo11.Groesse:=8;Fmo11.Style:=0;Fmo11.Rahmen:=0;Fmo11.Ena:=0;Fmo11.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=12) or (z>20) Then begin
    Fmo12.Sichtbar:=0;Fmo12.Name:='';Fmo12.x:=0;Fmo12.y:=0;Fmo12.l:=0;Fmo12.j:=0;Fmo12.Schrift:='MS Sans Serif';Fmo12.Farbe:='clBlue';
    Fmo1.Groesse:=8;Fmo1.Style:=0;Fmo1.Rahmen:=0;Fmo1.Ena:=0;Fmo12.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=13) or (z>20) Then begin
    Fmo13.Sichtbar:=0;Fmo13.Name:='';Fmo13.x:=0;Fmo13.y:=0;Fmo13.l:=0;Fmo13.j:=0;Fmo13.Schrift:='MS Sans Serif';Fmo13.Farbe:='clBlue';
    Fmo13.Groesse:=8;Fmo13.Style:=0;Fmo13.Rahmen:=0;Fmo13.Ena:=0;Fmo13.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=14) or (z>20) Then begin
    Fmo14.Sichtbar:=0;Fmo14.Name:='';Fmo14.x:=0;Fmo14.y:=0;Fmo14.l:=0;Fmo14.j:=0;Fmo14.Schrift:='MS Sans Serif';Fmo14.Farbe:='clBlue';
    Fmo14.Groesse:=8;Fmo14.Style:=0;Fmo14.Rahmen:=0;Fmo14.Ena:=0;Fmo14.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=15) or (z>20) Then begin
    Fmo15.Sichtbar:=0;Fmo15.Name:='';Fmo15.x:=0;Fmo15.y:=0;Fmo15.l:=0;Fmo15.j:=0;Fmo15.Schrift:='MS Sans Serif';Fmo15.Farbe:='clBlue';
    Fmo15.Groesse:=8;Fmo15.Style:=0;Fmo15.Rahmen:=0;Fmo15.Ena:=0;Fmo15.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=16) or (z>20) Then begin
    Fmo16.Sichtbar:=0;Fmo16.Name:='';Fmo16.x:=0;Fmo16.y:=0;Fmo16.l:=0;Fmo16.j:=0;Fmo16.Schrift:='MS Sans Serif';Fmo16.Farbe:='clBlue';
    Fmo16.Groesse:=8;Fmo16.Style:=0;Fmo16.Rahmen:=0;Fmo16.Ena:=0;Fmo16.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=17) or (z>20) Then begin
    Fmo17.Sichtbar:=0;Fmo17.Name:='';Fmo17.x:=0;Fmo17.y:=0;Fmo17.l:=0;Fmo17.j:=0;Fmo17.Schrift:='MS Sans Serif';Fmo17.Farbe:='clBlue';
    Fmo17.Groesse:=8;Fmo17.Style:=0;Fmo17.Rahmen:=0;Fmo17.Ena:=0;Fmo17.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=18) or (z>20) Then begin
    Fmo18.Sichtbar:=0;Fmo18.Name:='';Fmo18.x:=0;Fmo18.y:=0;Fmo18.l:=0;Fmo18.j:=0;Fmo18.Schrift:='MS Sans Serif';Fmo18.Farbe:='clBlue';
    Fmo18.Groesse:=8;Fmo18.Style:=0;Fmo18.Rahmen:=0;Fmo18.Ena:=0;Fmo18.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=19) or (z>20) Then begin
    Fmo19.Sichtbar:=0;Fmo19.Name:='';Fmo19.x:=0;Fmo19.y:=0;Fmo19.l:=0;Fmo19.j:=0;Fmo19.Schrift:='MS Sans Serif';Fmo19.Farbe:='clBlue';
    Fmo19.Groesse:=8;Fmo19.Style:=0;Fmo19.Rahmen:=0;Fmo19.Ena:=0;Fmo19.h:=0;Fmo1.Berechnung:='';
  end;
  if (z=20) or (z>20) Then begin
    Fmo20.Sichtbar:=0;Fmo20.Name:='';Fmo20.x:=0;Fmo20.y:=0;Fmo20.l:=0;Fmo20.j:=0;Fmo20.Schrift:='MS Sans Serif';Fmo20.Farbe:='clBlue';
    Fmo20.Groesse:=8;Fmo20.Style:=0;Fmo20.Rahmen:=0;Fmo20.Ena:=0;Fmo20.h:=0;Fmo1.Berechnung:='';
  end;
end;

procedure TDataModuleMyOffice.FFormatGet(z:integer;s:String);
var y:String;
    sTemp:String;
    i:integer;
Begin
  y:=';';
  sTemp:=s;
  i:=Pos(y,sTemp);  FFormat.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
  i:=Pos(y,sTemp);  FFormat.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
  i:=Pos(y,sTemp);  FFormat.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
  i:=Pos(y,sTemp);  FFormat.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
  i:=Pos(y,sTemp);  FFormat.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
  i:=Pos(y,sTemp);  FFormat.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
  i:=Pos(y,sTemp);  FFormat.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
  i:=Pos(y,sTemp);  FFormat.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
  i:=Pos(y,sTemp);  FFormat.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
  i:=Pos(y,sTemp);  FFormat.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
  i:=Pos(y,sTemp);  FFormat.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
  i:=Pos(y,sTemp);  FFormat.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  i:=Pos(y,sTemp);  FFormat.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
End;


procedure TDataModuleMyOffice.FddGet(z:integer;s:String);
var y:String;
    sTemp:String;
    i:integer;
begin
  y:=';';
  sTemp:=s;
  if z=1 then begin
    i:=Pos(y,sTemp);  Fdd1.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd1.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd1.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd1.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd1.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd1.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd1.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd1.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd1.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd1.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd1.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd1.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=2 then begin
    i:=Pos(y,sTemp);  Fdd2.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd2.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd2.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd2.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd2.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd2.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd2.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd2.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd2.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd2.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd2.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd2.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=3 then begin
    i:=Pos(y,sTemp);  Fdd3.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd3.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd3.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd3.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd3.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd3.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd3.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd3.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd3.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd3.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd3.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd3.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=4 then begin
    i:=Pos(y,sTemp);  Fdd4.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd4.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd4.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd4.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd4.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd4.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd4.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd4.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd4.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd4.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd4.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd4.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=5 then begin
    i:=Pos(y,sTemp);  Fdd5.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd5.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd5.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd5.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd5.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd5.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd5.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd5.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd5.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd5.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd5.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd5.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=6 then begin
    i:=Pos(y,sTemp);  Fdd6.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd6.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd6.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd6.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd6.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd6.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd6.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd6.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd6.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd6.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd6.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd6.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=7 then begin
    i:=Pos(y,sTemp);  Fdd7.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd7.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd7.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd7.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd7.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd7.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd7.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd7.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd7.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd7.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd7.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd7.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=8 then begin
    i:=Pos(y,sTemp);  Fdd8.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd8.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd8.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd8.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd8.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd8.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd8.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd8.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd8.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd8.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd8.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd8.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=9 then begin
    i:=Pos(y,sTemp);  Fdd9.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd9.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd9.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd9.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd9.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd9.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd9.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd9.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd9.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd9.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd9.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd9.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=10 then begin
    i:=Pos(y,sTemp);  Fdd10.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd10.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd10.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd10.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd10.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd10.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd10.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd10.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd10.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd10.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd10.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd10.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=11 then begin
    i:=Pos(y,sTemp);  Fdd11.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd11.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd11.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd11.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd11.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd11.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd11.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd11.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd11.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd11.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd11.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd11.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=12 then begin
    i:=Pos(y,sTemp);  Fdd12.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd12.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd12.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd12.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd12.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd12.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd12.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd12.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd12.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd12.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd12.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd12.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=13 then begin
    i:=Pos(y,sTemp);  Fdd13.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd13.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd13.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd13.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd13.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd13.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd13.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd13.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd13.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd13.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd13.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd13.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=14 then begin
    i:=Pos(y,sTemp);  Fdd14.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd14.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd14.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd14.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd14.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd14.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd14.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd14.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd14.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd14.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd14.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd14.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=15 then begin
    i:=Pos(y,sTemp);  Fdd15.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd15.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd15.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd15.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd15.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd15.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd15.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd15.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd15.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd15.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd15.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd15.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=16 then begin
    i:=Pos(y,sTemp);  Fdd16.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd16.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd16.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd16.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd16.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd16.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd16.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd16.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd16.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd16.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd16.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd16.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=17 then begin
    i:=Pos(y,sTemp);  Fdd17.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd17.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd17.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd17.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd17.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd17.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd17.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd17.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd17.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd17.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd17.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd17.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=18 then begin
    i:=Pos(y,sTemp);  Fdd18.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd18.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd18.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd18.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd18.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd18.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd18.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd18.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd18.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd18.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd18.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd18.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=19 then begin
    i:=Pos(y,sTemp);  Fdd19.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd19.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd19.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd19.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd19.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd19.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd19.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd19.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd19.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd19.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd19.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd19.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=20 then begin
    i:=Pos(y,sTemp);  Fdd20.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd20.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd20.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd20.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd20.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd20.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd20.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd20.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd20.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd20.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd20.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdd20.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;


    {Fdd1.Name:=copy(s,2,25);
    Fdd1.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));
    Fdd1.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd1.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));
    Fdd1.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));
    Fdd1.Schrift:=copy(s,43,25);
    Fdd1.Farbe:=copy(s,68,9);
    Fdd1.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));
    Fdd1.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));
    Fdd1.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));
    Fdd1.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));}
    {Fdd1.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));
    Fdd1.Name:=copy(s,2,25);
    Fdd1.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));
    Fdd1.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd1.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));
    Fdd1.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));
    Fdd1.Schrift:=copy(s,43,25);
    Fdd1.Farbe:=copy(s,68,9);
    Fdd1.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));
    Fdd1.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));
    Fdd1.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));
    Fdd1.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));}
  //end;
  {if z=2 then begin
    Fdd2.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd2.Name:=copy(s,2,25);Fdd2.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd2.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd2.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd2.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd2.Schrift:=copy(s,43,25);Fdd2.Farbe:=copy(s,68,9);
    Fdd2.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd2.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd2.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd2.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=3 then begin
    Fdd3.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd3.Name:=copy(s,2,25);Fdd3.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd3.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd3.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd3.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd3.Schrift:=copy(s,43,25);Fdd3.Farbe:=copy(s,68,9);
    Fdd3.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd3.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd3.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd3.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=4 then begin
    Fdd4.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd4.Name:=copy(s,2,25);Fdd4.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd4.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd4.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd4.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd4.Schrift:=copy(s,43,25);Fdd4.Farbe:=copy(s,68,9);
    Fdd4.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd4.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd4.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd4.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=5 then begin
    Fdd5.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd5.Name:=copy(s,2,25);Fdd5.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd5.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd5.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd5.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd5.Schrift:=copy(s,43,25);Fdd5.Farbe:=copy(s,68,9);
    Fdd5.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd5.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd5.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd5.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=6 then begin
    Fdd6.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd6.Name:=copy(s,2,25);Fdd6.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd6.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd6.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd6.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd6.Schrift:=copy(s,43,25);Fdd6.Farbe:=copy(s,68,9);
    Fdd6.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd6.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd6.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd6.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=7 then begin
    Fdd7.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd7.Name:=copy(s,2,25);Fdd7.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd7.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd7.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd7.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd7.Schrift:=copy(s,43,25);Fdd7.Farbe:=copy(s,68,9);
    Fdd7.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd7.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd7.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd7.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=8 then begin
    Fdd8.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd8.Name:=copy(s,2,25);Fdd8.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd8.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd1.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd1.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd1.Schrift:=copy(s,43,25);Fdd1.Farbe:=copy(s,68,9);
    Fdd1.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd1.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd1.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd1.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=9 then begin
    Fdd9.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd9.Name:=copy(s,2,25);Fdd9.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd9.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd9.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd9.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd9.Schrift:=copy(s,43,25);Fdd9.Farbe:=copy(s,68,9);
    Fdd9.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd9.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd9.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd9.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=10 then begin
    Fdd10.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd10.Name:=copy(s,2,25);Fdd10.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd10.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd10.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd10.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd10.Schrift:=copy(s,43,25);Fdd10.Farbe:=copy(s,68,9);
    Fdd10.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd10.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd10.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd10.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=11 then begin
    Fdd11.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd11.Name:=copy(s,2,25);Fdd11.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd11.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd11.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd11.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd11.Schrift:=copy(s,43,25);Fdd11.Farbe:=copy(s,68,9);
    Fdd11.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd11.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd11.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd11.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=12 then begin
    Fdd12.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd12.Name:=copy(s,2,25);Fdd12.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd12.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd12.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd12.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd12.Schrift:=copy(s,43,25);Fdd12.Farbe:=copy(s,68,9);
    Fdd12.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd12.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd12.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd12.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=13 then begin
    Fdd13.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd13.Name:=copy(s,2,25);Fdd13.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd13.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd13.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd13.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd13.Schrift:=copy(s,43,25);Fdd13.Farbe:=copy(s,68,9);
    Fdd13.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd13.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd13.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd13.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=14 then begin
    Fdd14.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd14.Name:=copy(s,2,25);Fdd14.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd14.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd14.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd14.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd14.Schrift:=copy(s,43,25);Fdd14.Farbe:=copy(s,68,9);
    Fdd14.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd14.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd14.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd14.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=15 then begin
    Fdd15.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd15.Name:=copy(s,2,25);Fdd15.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd15.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd15.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd15.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd15.Schrift:=copy(s,43,25);Fdd15.Farbe:=copy(s,68,9);
    Fdd15.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd15.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd15.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd15.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=16 then begin
    Fdd16.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd16.Name:=copy(s,2,25);Fdd16.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd16.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd16.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd16.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd16.Schrift:=copy(s,43,25);Fdd16.Farbe:=copy(s,68,9);
    Fdd16.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd16.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd16.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd16.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=17 then begin
    Fdd17.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd17.Name:=copy(s,2,25);Fdd17.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd17.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd17.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd17.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd17.Schrift:=copy(s,43,25);Fdd17.Farbe:=copy(s,68,9);
    Fdd17.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd17.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd17.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd17.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=18 then begin
    Fdd18.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd18.Name:=copy(s,2,25);Fdd18.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd18.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd18.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd18.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd18.Schrift:=copy(s,43,25);Fdd18.Farbe:=copy(s,68,9);
    Fdd18.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd18.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd18.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd18.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=19 then begin
    Fdd19.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd19.Name:=copy(s,2,25);Fdd19.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd19.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd19.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd19.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd19.Schrift:=copy(s,43,25);Fdd19.Farbe:=copy(s,68,9);
    Fdd19.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd19.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd19.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd19.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=20 then begin
    Fdd20.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdd20.Name:=copy(s,2,25);Fdd20.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdd20.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdd20.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdd20.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdd20.Schrift:=copy(s,43,25);Fdd20.Farbe:=copy(s,68,9);
    Fdd20.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdd20.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdd20.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdd20.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;}
end;

procedure TDataModuleMyOffice.FmoGet(z:integer;s:String);
var y:String;
    sTemp:String;
    i:integer;
begin
  y:=';';
  sTemp:=s;
  if z=1 then begin
    i:=Pos(y,sTemp);  Fmo1.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo1.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo1.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo1.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo1.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo1.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo1.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo1.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo1.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo1.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo1.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo1.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo1.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=2 then begin
    i:=Pos(y,sTemp);  Fmo2.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo2.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo2.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo2.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo2.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo2.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo2.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo2.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo2.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo2.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo2.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo2.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo2.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo2.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=3 then begin
    i:=Pos(y,sTemp);  Fmo3.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo3.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo3.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo3.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo3.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo3.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo3.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo3.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo3.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo3.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo3.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo3.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo3.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo3.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=4 then begin
    i:=Pos(y,sTemp);  Fmo4.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo4.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo4.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo4.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo4.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo4.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo4.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo4.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo4.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo4.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo4.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo4.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo4.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo4.Berechnung:= copy(sTemp,1,i-1);                            sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=5 then begin
    i:=Pos(y,sTemp);  Fmo5.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo5.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo5.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo5.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo5.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo5.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo5.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo5.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo5.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo5.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo5.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo5.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo5.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo5.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=6 then begin
    i:=Pos(y,sTemp);  Fmo6.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo6.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo6.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo6.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo6.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo6.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo6.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo6.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo6.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo6.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo6.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo6.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo6.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo6.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=7 then begin
    i:=Pos(y,sTemp);  Fmo7.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo7.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo7.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo7.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo7.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo7.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo7.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo7.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo7.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo7.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo7.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo7.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo7.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo7.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=8 then begin
    i:=Pos(y,sTemp);  Fmo8.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo8.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo8.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo8.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo8.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo8.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo8.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo8.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo8.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo8.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo8.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo8.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo8.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo8.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=9 then begin
    i:=Pos(y,sTemp);  Fmo9.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo9.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo9.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo9.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo9.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo9.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo9.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo9.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo9.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo9.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo9.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo9.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo9.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo9.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=10 then begin
    i:=Pos(y,sTemp);  Fmo10.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo10.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo10.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo10.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo10.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo10.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo10.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo10.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo10.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo10.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo10.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo10.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo10.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo10.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=11 then begin
    i:=Pos(y,sTemp);  Fmo11.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo11.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo11.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo11.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo11.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo11.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo11.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo11.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo11.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo11.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo11.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo11.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo11.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo11.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=12 then begin
    i:=Pos(y,sTemp);  Fmo12.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo12.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo12.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo12.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo12.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo12.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo12.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo12.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo12.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo12.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo12.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo12.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo12.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo12.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=13 then begin
    i:=Pos(y,sTemp);  Fmo13.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo13.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo13.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo13.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo13.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo13.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo13.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo13.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo13.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo13.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo13.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo13.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo13.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo13.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=14 then begin
    i:=Pos(y,sTemp);  Fmo14.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo14.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo14.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo14.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo14.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo14.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo14.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo14.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo14.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo14.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo14.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo14.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo14.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo14.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=15 then begin
    i:=Pos(y,sTemp);  Fmo15.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo15.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo15.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo15.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo15.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo15.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo15.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo15.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo15.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo15.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo15.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo15.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo15.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo15.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=16 then begin
    i:=Pos(y,sTemp);  Fmo16.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo16.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo16.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo16.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo16.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo16.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo16.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo16.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo16.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo16.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo16.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo16.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo16.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo16.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=17 then begin
    i:=Pos(y,sTemp);  Fmo17.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo17.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo17.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo17.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo17.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo17.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo17.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo17.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo17.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo17.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo17.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo17.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo17.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo17.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=18 then begin
    i:=Pos(y,sTemp);  Fmo18.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo18.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo18.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo18.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo18.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo18.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo18.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo18.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo18.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo18.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo18.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo18.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo18.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo18.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=19 then begin
    i:=Pos(y,sTemp);  Fmo19.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo19.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo19.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo19.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo19.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo19.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo19.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo19.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo19.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo19.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo19.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo19.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo19.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));         sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo19.Berechnung:=copy(sTemp,1,i-1);                              sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=20 then begin
    i:=Pos(y,sTemp);  Fmo20.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo20.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo20.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo20.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo20.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo20.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo20.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo20.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo20.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo20.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo20.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo20.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo20.h:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fmo20.Berechnung:=copy(sTemp,1,i-1);                             sTemp:=copy(sTemp,i+1,length(sTemp));

  end;
end;

procedure TDataModuleMyOffice.FdmGet(z:integer;s:String);
var y:String;
    sTemp:String;
    i:integer;
begin
  y:=';';
  sTemp:=s;
  if z=1 then begin
    i:=Pos(y,sTemp);  Fdm1.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm1.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm1.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm1.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm1.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm1.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm1.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm1.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm1.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm1.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm1.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm1.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=2 then begin
    i:=Pos(y,sTemp);  Fdm2.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm2.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm2.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm2.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm2.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm2.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm2.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm2.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm2.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm2.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm2.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm2.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=3 then begin
    i:=Pos(y,sTemp);  Fdm3.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm3.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm3.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm3.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm3.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm3.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm3.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm3.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm3.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm3.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm3.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm3.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=4 then begin
    i:=Pos(y,sTemp);  Fdm4.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm4.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm4.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm4.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm4.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm4.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm4.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm4.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm4.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm4.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm4.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm4.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=5 then begin
    i:=Pos(y,sTemp);  Fdm5.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm5.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm5.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm5.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm5.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm5.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm5.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm5.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm5.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm5.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm5.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm5.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=6 then begin
    i:=Pos(y,sTemp);  Fdm6.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm6.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm6.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm6.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm6.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm6.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm6.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm6.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm6.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm6.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm6.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm6.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=7 then begin
    i:=Pos(y,sTemp);  Fdm7.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm7.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm7.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm7.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm7.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm7.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm7.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm7.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm7.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm7.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm7.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm7.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=8 then begin
    i:=Pos(y,sTemp);  Fdm8.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm8.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm8.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm8.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm8.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm8.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm8.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm8.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm8.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm8.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm8.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm8.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=9 then begin
    i:=Pos(y,sTemp);  Fdm9.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm9.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm9.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm9.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm9.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm9.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm9.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm9.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm9.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm9.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm9.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm9.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=10 then begin
    i:=Pos(y,sTemp);  Fdm10.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm10.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm10.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm10.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm10.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm10.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm10.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm10.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm10.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm10.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm10.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm10.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=11 then begin
    i:=Pos(y,sTemp);  Fdm11.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm11.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm11.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm11.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm11.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm11.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm11.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm11.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm11.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm11.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm11.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm11.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=12 then begin
    i:=Pos(y,sTemp);  Fdm12.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm12.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm12.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm12.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm12.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm12.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm12.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm12.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm12.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm12.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm12.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm12.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=13 then begin
    i:=Pos(y,sTemp);  Fdm13.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm13.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm13.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm13.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm13.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm13.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm13.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm13.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm13.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm13.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm13.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm13.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=14 then begin
    i:=Pos(y,sTemp);  Fdm14.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm14.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm14.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm14.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm14.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm14.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm14.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm14.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm14.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm14.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm14.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm14.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=15 then begin
    i:=Pos(y,sTemp);  Fdm15.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm15.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm15.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm15.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm15.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm15.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm15.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm15.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm15.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm15.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm15.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm15.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=16 then begin
    i:=Pos(y,sTemp);  Fdm16.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm16.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm16.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm16.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm16.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm16.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm16.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm16.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm16.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm16.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm16.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm16.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=17 then begin
    i:=Pos(y,sTemp);  Fdm17.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm17.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm17.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm17.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm17.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm17.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm17.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm17.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm17.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm17.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm17.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm17.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=18 then begin
    i:=Pos(y,sTemp);  Fdm18.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm18.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm18.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm18.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm18.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm18.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm18.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm18.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm18.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm18.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm18.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm18.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=19 then begin
    i:=Pos(y,sTemp);  Fdm19.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm19.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm19.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm19.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm19.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm19.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm19.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm19.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm19.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm19.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm19.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm19.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;
  if z=20 then begin
    i:=Pos(y,sTemp);  Fdm20.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm20.Name:=copy(sTemp,1,i-1);                                   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm20.x:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm20.y:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm20.l:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm20.j:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));        sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm20.Schrift:=copy(sTemp,1,i-1);                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm20.Farbe:=copy(sTemp,1,i-1);                                  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm20.Groesse:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm20.Style:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm20.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));   sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Fdm20.Ena:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));      sTemp:=copy(sTemp,i+1,length(sTemp));
  end;


{begin
  if z=1 then begin
    Fdm1.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));
    Fdm1.Name:=copy(s,2,25);
    Fdm1.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));
    Fdm1.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm1.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));
    Fdm1.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));
    Fdm1.Schrift:=copy(s,43,25);
    Fdm1.Farbe:=copy(s,68,9);
    Fdm1.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));
    Fdm1.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));
    Fdm1.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));
    Fdm1.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=2 then begin
    Fdm2.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm2.Name:=copy(s,2,25);Fdm2.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm2.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm2.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm2.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm2.Schrift:=copy(s,43,25);Fdm2.Farbe:=copy(s,68,9);
    Fdm2.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm2.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm2.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm2.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=3 then begin
    Fdm3.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm3.Name:=copy(s,2,25);Fdm3.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm3.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm3.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm3.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm3.Schrift:=copy(s,43,25);Fdm3.Farbe:=copy(s,68,9);
    Fdm3.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm3.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm3.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm3.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=4 then begin
    Fdm4.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm4.Name:=copy(s,2,25);Fdm4.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm4.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm4.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm4.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm4.Schrift:=copy(s,43,25);Fdm4.Farbe:=copy(s,68,9);
    Fdm4.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm4.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm4.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm4.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=5 then begin
    Fdm5.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm5.Name:=copy(s,2,25);Fdm5.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm5.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm5.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm5.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm5.Schrift:=copy(s,43,25);Fdm5.Farbe:=copy(s,68,9);
    Fdm5.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm5.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm5.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm5.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=6 then begin
    Fdm6.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm6.Name:=copy(s,2,25);Fdm6.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm6.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm6.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm6.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm6.Schrift:=copy(s,43,25);Fdm6.Farbe:=copy(s,68,9);
    Fdm6.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm6.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm6.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm6.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=7 then begin
    Fdm7.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm7.Name:=copy(s,2,25);Fdm7.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm7.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm7.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm7.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm7.Schrift:=copy(s,43,25);Fdm7.Farbe:=copy(s,68,9);
    Fdm7.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm7.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm7.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm7.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=8 then begin
    Fdm8.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm8.Name:=copy(s,2,25);Fdm8.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm8.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm1.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm1.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm1.Schrift:=copy(s,43,25);Fdm1.Farbe:=copy(s,68,9);
    Fdm1.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm1.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm1.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm1.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=9 then begin
    Fdm9.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm9.Name:=copy(s,2,25);Fdm9.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm9.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm9.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm9.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm9.Schrift:=copy(s,43,25);Fdm9.Farbe:=copy(s,68,9);
    Fdm9.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm9.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm9.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm9.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=10 then begin
    Fdm10.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm10.Name:=copy(s,2,25);Fdm10.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm10.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm10.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm10.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm10.Schrift:=copy(s,43,25);Fdm10.Farbe:=copy(s,68,9);
    Fdm10.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm10.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm10.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm10.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=11 then begin
    Fdm11.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm11.Name:=copy(s,2,25);Fdm11.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm11.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm11.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm11.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm11.Schrift:=copy(s,43,25);Fdm11.Farbe:=copy(s,68,9);
    Fdm11.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm11.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm11.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm11.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=12 then begin
    Fdm12.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm12.Name:=copy(s,2,25);Fdm12.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm12.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm12.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm12.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm12.Schrift:=copy(s,43,25);Fdm12.Farbe:=copy(s,68,9);
    Fdm12.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm12.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm12.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm12.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=13 then begin
    Fdm13.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm13.Name:=copy(s,2,25);Fdm13.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm13.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm13.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm13.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm13.Schrift:=copy(s,43,25);Fdm13.Farbe:=copy(s,68,9);
    Fdm13.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm13.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm13.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm13.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=14 then begin
    Fdm14.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm14.Name:=copy(s,2,25);Fdm14.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm14.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm14.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm14.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm14.Schrift:=copy(s,43,25);Fdm14.Farbe:=copy(s,68,9);
    Fdm14.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm14.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm14.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm14.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=15 then begin
    Fdm15.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm15.Name:=copy(s,2,25);Fdm15.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm15.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm15.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm15.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm15.Schrift:=copy(s,43,25);Fdm15.Farbe:=copy(s,68,9);
    Fdm15.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm15.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm15.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm15.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=16 then begin
    Fdm16.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm16.Name:=copy(s,2,25);Fdm16.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm16.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm16.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm16.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm16.Schrift:=copy(s,43,25);Fdm16.Farbe:=copy(s,68,9);
    Fdm16.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm16.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm16.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm16.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=17 then begin
    Fdm17.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm17.Name:=copy(s,2,25);Fdm17.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm17.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm17.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm17.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm17.Schrift:=copy(s,43,25);Fdm17.Farbe:=copy(s,68,9);
    Fdm17.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm17.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm17.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm17.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=18 then begin
    Fdm18.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm18.Name:=copy(s,2,25);Fdm18.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm18.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm18.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm18.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm18.Schrift:=copy(s,43,25);Fdm18.Farbe:=copy(s,68,9);
    Fdm18.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm18.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm18.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm18.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=19 then begin
    Fdm19.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm19.Name:=copy(s,2,25);Fdm19.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm19.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm19.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm19.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm19.Schrift:=copy(s,43,25);Fdm19.Farbe:=copy(s,68,9);
    Fdm19.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm19.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm19.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm19.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;
  if z=20 then begin
    Fdm20.Sichtbar:=DataModuleMyOffice.XStrtoInt(copy(s,1,1));Fdm20.Name:=copy(s,2,25);Fdm20.x:=DataModuleMyOffice.XStrtoInt(copy(s,27,4));Fdm20.y:=DataModuleMyOffice.XStrtoInt(copy(s,31,4));
    Fdm20.l:=DataModuleMyOffice.XStrtoInt(copy(s,35,4));Fdm20.j:=DataModuleMyOffice.XStrtoInt(copy(s,39,4));Fdm20.Schrift:=copy(s,43,25);Fdm20.Farbe:=copy(s,68,9);
    Fdm20.Groesse:=DataModuleMyOffice.XStrtoInt(copy(s,77,2));Fdm20.Style:=DataModuleMyOffice.XStrtoInt(copy(s,79,2));Fdm20.Rahmen:=DataModuleMyOffice.XStrtoInt(copy(s,81,2));Fdm20.Ena:=DataModuleMyOffice.XStrtoInt(copy(s,83,1));
  end;}
end;


procedure TDataModuleMyOffice.DSSet(FArtikelStr:String;FQuery:TZQuery);
Var i:integer;
begin
  if FArtikelStr='Artikel1' then begin
    for i:=0 to FQuery.Fieldcount-1 do begin
      if FQuery.Fields[i].Fieldname =  'Nr' then                 Artikel1.Nr:=                  FQuery.FieldByName('Nr').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Pos_Nr' then             Artikel1.Pos_Nr:=              FQuery.FieldByName('Pos_Nr').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Pos' then                Artikel1.Pos:=                 FQuery.FieldByName('Pos').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Modul_Nr' then           Artikel1.Modul_Nr:=            FQuery.FieldByName('Modul_Nr').AsInteger;
      if FQuery.Fields[i].Fieldname =  'ModulNr' then            Artikel1.ModulNr:=             FQuery.FieldByName('ModulNr').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Artikel_Nr' then         Artikel1.Artikel_Nr:=          FQuery.FieldByName('Artikel_Nr').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Stuecklisten_Nr' then    Artikel1.Stuecklisten_Nr:=     FQuery.FieldByName('Stuecklisten_Nr').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Artikelgruppe' then      Artikel1.Artikelgruppe:=       FQuery.FieldByName('Artikelgruppe').AsString;
      if FQuery.Fields[i].Fieldname =  'Artikel' then            Artikel1.Artikel:=             FQuery.FieldByName('Artikel').AsString;
      if FQuery.Fields[i].Fieldname =  'Einheit_EK' then         Artikel1.Einheit_EK:=          FQuery.FieldByName('Einheit_EK').AsString;
      if FQuery.Fields[i].Fieldname =  'EinheitMenge' then       Artikel1.EinheitMenge:=        FQuery.FieldByName('EinheitMenge').AsString;
      if FQuery.Fields[i].Fieldname =  'Name1' then              Artikel1.Name1:=               FQuery.FieldByName('Name1').AsString;
      if FQuery.Fields[i].Fieldname =  'Name2' then              Artikel1.Name2:=               FQuery.FieldByName('Name2').AsString;
      if FQuery.Fields[i].Fieldname =  'Name3' then              Artikel1.Name3:=               FQuery.FieldByName('Name3').AsString;
      if FQuery.Fields[i].Fieldname =  'Lieferant' then          Artikel1.Lieferant:=           FQuery.FieldByName('Lieferant').AsString;
      if FQuery.Fields[i].Fieldname =  'LieferantArtikelNr' then Artikel1.LieferantArtikelNr:=  FQuery.FieldByName('LieferantArtikelNr').AsString;
      if FQuery.Fields[i].Fieldname =  'BerechnungsArt' then     Artikel1.BerechnungsArt:=      FQuery.FieldByName('BerechnungsArt').AsString;
      if FQuery.Fields[i].Fieldname =  'Kostenart' then          Artikel1.Kostenart:=           FQuery.FieldByName('Kostenart').AsString;
      if FQuery.Fields[i].Fieldname =  'Gruppierung' then        Artikel1.Gruppierung:=         FQuery.FieldByName('Gruppierung').AsString;
      if FQuery.Fields[i].Fieldname =  'ArtikelArt' then         Artikel1.ArtikelArt:=          FQuery.FieldByName('ArtikelArt').AsString;
      if FQuery.Fields[i].Fieldname =  'Bearbeiter' then         Artikel1.Bearbeiter:=          FQuery.FieldByName('Bearbeiter').AsString;
      if FQuery.Fields[i].Fieldname =  'Erledigt1' then          Artikel1.Erledigt1:=           FQuery.FieldByName('Erledigt1').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Erledigt2' then          Artikel1.Erledigt2:=           FQuery.FieldByName('Erledigt2').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Erledigt3' then          Artikel1.Erledigt3:=           FQuery.FieldByName('Erledigt3').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Erledigt4' then          Artikel1.Erledigt4:=           FQuery.FieldByName('Erledigt4').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Erledigt5' then          Artikel1.Erledigt5:=           FQuery.FieldByName('Erledigt5').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Geaendert' then          Artikel1.Geaendert:=           FQuery.FieldByName('Geaendert').AsInteger;
      if FQuery.Fields[i].Fieldname =  'EK_Preis' then           Artikel1.EK_Preis:=            FQuery.FieldByName('EK_Preis').AsFloat;
      if FQuery.Fields[i].Fieldname =  'VK_Preis' then           Artikel1.VK_Preis:=            FQuery.FieldByName('VK_Preis').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Aufschlag' then          Artikel1.Aufschlag:=           FQuery.FieldByName('Aufschlag').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Rabatt' then             Artikel1.Rabatt:=              FQuery.FieldByName('Rabatt').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Gewicht' then            Artikel1.Gewicht:=             FQuery.FieldByName('Gewicht').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Zahl1' then              Artikel1.Zahl1:=               FQuery.FieldByName('Zahl1').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Zahl2' then              Artikel1.Zahl2:=               FQuery.FieldByName('Zahl2').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Zahl3' then              Artikel1.Zahl3:=               FQuery.FieldByName('Zahl3').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Bestand' then            Artikel1.Bestand:=             FQuery.FieldByName('Bestand').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Min_Bestand' then        Artikel1.Min_Bestand:=         FQuery.FieldByName('Min_Bestand').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Menge' then              Artikel1.Menge:=               FQuery.FieldByName('Menge').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Menge2' then             Artikel1.Menge2:=              FQuery.FieldByName('Menge2').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Materialleistung' then   Artikel1.Materialleistung:=    FQuery.FieldByName('Materialleistung').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Dienstleistung' then     Artikel1.Dienstleistung:=      FQuery.FieldByName('Dienstleistung').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Fremdleistung' then      Artikel1.Fremdleistung:=       FQuery.FieldByName('Fremdleistung').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Sonstigeleistung' then   Artikel1.Sonstigeleistung:=    FQuery.FieldByName('Sonstigeleistung').AsFloat;
      if FQuery.Fields[i].Fieldname =  'MatAufschlag' then       Artikel1.MatAufschlag:=        FQuery.FieldByName('MatAufschlag').AsFloat;
      if FQuery.Fields[i].Fieldname =  'DieAufschlag' then       Artikel1.DieAufschlag:=        FQuery.FieldByName('DieAufschlag').AsFloat;
      if FQuery.Fields[i].Fieldname =  'FreAufschlag' then       Artikel1.FreAufschlag:=        FQuery.FieldByName('FreAufschlag').AsFloat;
      if FQuery.Fields[i].Fieldname =  'SonAufschlag' then       Artikel1.SonAufschlag:=        FQuery.FieldByName('SonAufschlag').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Pos_Text' then           Artikel1.Pos_Text.text:=       FQuery.FieldByName('Pos_Text').AsString;
    end;
  end;
  if FArtikelStr='Artikel2' then begin
    for i:=0 to FQuery.Fieldcount-1 do begin
      if FQuery.Fields[i].Fieldname =  'Nr' then                 Artikel2.Nr:=                  FQuery.FieldByName('Nr').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Pos_Nr' then             Artikel2.Pos_Nr:=              FQuery.FieldByName('Pos_Nr').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Pos' then                Artikel2.Pos:=                 FQuery.FieldByName('Pos').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Modul_Nr' then           Artikel2.Modul_Nr:=            FQuery.FieldByName('Modul_Nr').AsInteger;
      if FQuery.Fields[i].Fieldname =  'ModulNr' then            Artikel2.ModulNr:=             FQuery.FieldByName('ModulNr').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Artikel_Nr' then         Artikel2.Artikel_Nr:=          FQuery.FieldByName('Artikel_Nr').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Stuecklisten_Nr' then    Artikel2.Stuecklisten_Nr:=     FQuery.FieldByName('Stuecklisten_Nr').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Artikelgruppe' then      Artikel2.Artikelgruppe:=       FQuery.FieldByName('Artikelgruppe').AsString;
      if FQuery.Fields[i].Fieldname =  'Artikel' then            Artikel2.Artikel:=             FQuery.FieldByName('Artikel').AsString;
      if FQuery.Fields[i].Fieldname =  'Einheit_EK' then         Artikel2.Einheit_EK:=          FQuery.FieldByName('Einheit_EK').AsString;
      if FQuery.Fields[i].Fieldname =  'EinheitMenge' then       Artikel2.EinheitMenge:=        FQuery.FieldByName('EinheitMenge').AsString;
      if FQuery.Fields[i].Fieldname =  'Name1' then              Artikel2.Name1:=               FQuery.FieldByName('Name1').AsString;
      if FQuery.Fields[i].Fieldname =  'Name2' then              Artikel2.Name2:=               FQuery.FieldByName('Name2').AsString;
      if FQuery.Fields[i].Fieldname =  'Name3' then              Artikel2.Name3:=               FQuery.FieldByName('Name3').AsString;
      if FQuery.Fields[i].Fieldname =  'Lieferant' then          Artikel2.Lieferant:=           FQuery.FieldByName('Lieferant').AsString;
      if FQuery.Fields[i].Fieldname =  'LieferantArtikelNr' then Artikel2.LieferantArtikelNr:=  FQuery.FieldByName('LieferantArtikelNr').AsString;
      if FQuery.Fields[i].Fieldname =  'BerechnungsArt' then     Artikel2.BerechnungsArt:=      FQuery.FieldByName('BerechnungsArt').AsString;
      if FQuery.Fields[i].Fieldname =  'Kostenart' then          Artikel2.Kostenart:=           FQuery.FieldByName('Kostenart').AsString;
      if FQuery.Fields[i].Fieldname =  'Gruppierung' then        Artikel2.Gruppierung:=         FQuery.FieldByName('Gruppierung').AsString;
      if FQuery.Fields[i].Fieldname =  'ArtikelArt' then         Artikel2.ArtikelArt:=          FQuery.FieldByName('ArtikelArt').AsString;
      if FQuery.Fields[i].Fieldname =  'Bearbeiter' then         Artikel2.Bearbeiter:=          FQuery.FieldByName('Bearbeiter').AsString;
      if FQuery.Fields[i].Fieldname =  'Erledigt1' then          Artikel2.Erledigt1:=           FQuery.FieldByName('Erledigt1').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Erledigt2' then          Artikel2.Erledigt2:=           FQuery.FieldByName('Erledigt2').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Erledigt3' then          Artikel2.Erledigt3:=           FQuery.FieldByName('Erledigt3').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Erledigt4' then          Artikel2.Erledigt4:=           FQuery.FieldByName('Erledigt4').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Erledigt5' then          Artikel2.Erledigt5:=           FQuery.FieldByName('Erledigt5').AsInteger;
      if FQuery.Fields[i].Fieldname =  'Geaendert' then          Artikel2.Geaendert:=           FQuery.FieldByName('Geaendert').AsInteger;
      if FQuery.Fields[i].Fieldname =  'EK_Preis' then           Artikel2.EK_Preis:=            FQuery.FieldByName('EK_Preis').AsFloat;
      if FQuery.Fields[i].Fieldname =  'VK_Preis' then           Artikel2.VK_Preis:=            FQuery.FieldByName('VK_Preis').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Aufschlag' then          Artikel2.Aufschlag:=           FQuery.FieldByName('Aufschlag').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Rabatt' then             Artikel2.Rabatt:=              FQuery.FieldByName('Rabatt').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Gewicht' then            Artikel2.Gewicht:=             FQuery.FieldByName('Gewicht').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Zahl1' then              Artikel2.Zahl1:=               FQuery.FieldByName('Zahl1').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Zahl2' then              Artikel2.Zahl2:=               FQuery.FieldByName('Zahl2').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Zahl3' then              Artikel2.Zahl3:=               FQuery.FieldByName('Zahl3').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Bestand' then            Artikel2.Bestand:=             FQuery.FieldByName('Bestand').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Min_Bestand' then        Artikel2.Min_Bestand:=         FQuery.FieldByName('Min_Bestand').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Menge' then              Artikel2.Menge:=               FQuery.FieldByName('Menge').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Menge2' then             Artikel2.Menge2:=              FQuery.FieldByName('Menge2').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Materialleistung' then   Artikel2.Materialleistung:=    FQuery.FieldByName('Materialleistung').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Dienstleistung' then     Artikel2.Dienstleistung:=      FQuery.FieldByName('Dienstleistung').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Fremdleistung' then      Artikel2.Fremdleistung:=       FQuery.FieldByName('Fremdleistung').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Sonstigeleistung' then   Artikel2.Sonstigeleistung:=    FQuery.FieldByName('Sonstigeleistung').AsFloat;
      if FQuery.Fields[i].Fieldname =  'MatAufschlag' then       Artikel2.MatAufschlag:=        FQuery.FieldByName('MatAufschlag').AsFloat;
      if FQuery.Fields[i].Fieldname =  'DieAufschlag' then       Artikel2.DieAufschlag:=        FQuery.FieldByName('DieAufschlag').AsFloat;
      if FQuery.Fields[i].Fieldname =  'FreAufschlag' then       Artikel2.FreAufschlag:=        FQuery.FieldByName('FreAufschlag').AsFloat;
      if FQuery.Fields[i].Fieldname =  'SonAufschlag' then       Artikel2.SonAufschlag:=        FQuery.FieldByName('SonAufschlag').AsFloat;
      if FQuery.Fields[i].Fieldname =  'Pos_Text' then           Artikel2.Pos_Text.text:=       FQuery.FieldByName('Pos_Text').AsString;
    end;
  end;
  //Showmessage(Artikel1.Pos_Text.Lines.CommaText);
end;




function TDataModuleMyOffice.DSGet(FArtikelStr:String;FTabelle:String;FNr:integer):integer;
Var i,FZurueck:integer;
begin
  if FQuery1.Active then FQuery1.close;
  if Fnr>0 Then begin
    FQuery1.sql.Clear;
    FQuery1.sql.add('Select * From '+FTabelle+' Where nr = '+ inttostr(FNr));
    try
      FQuery1.open;
    finally
    end;
  end
  Else begin
    FQuery1.sql.Clear;
    FQuery1.sql.add('Select * From '+FTabelle);
    try
      FQuery1.open;
    finally
    end;
    FQuery1.Append;
  end;
  FQuery1.Edit;
  if FArtikelStr='Artikel1' then begin
    for i:=0 to FQuery1.Fieldcount-1 do begin
      //if FQuery1.Fields[i].Fieldname =  'Nr' then                 FQuery1.FieldByName('Nr').AsInteger:=               Artikel1.Nr;
      if FQuery1.Fields[i].Fieldname =  'Pos_Nr' then             FQuery1.FieldByName('Pos_Nr').AsInteger:=           Artikel1.Pos_Nr;
      if FQuery1.Fields[i].Fieldname =  'Pos' then                FQuery1.FieldByName('Pos').AsInteger:=              Artikel1.Pos;
      if FQuery1.Fields[i].Fieldname =  'Modul_Nr' then           FQuery1.FieldByName('Modul_Nr').AsInteger:=         Artikel1.Modul_Nr;
      if FQuery1.Fields[i].Fieldname =  'ModulNr' then            FQuery1.FieldByName('ModulNr').AsInteger:=          Artikel1.ModulNr;
      if FQuery1.Fields[i].Fieldname =  'Artikel_Nr' then         FQuery1.FieldByName('Artikel_Nr').AsInteger:=       Artikel1.Artikel_Nr;
      if FQuery1.Fields[i].Fieldname =  'Stuecklisten_Nr' then    FQuery1.FieldByName('Stuecklisten_Nr').AsInteger:=  Artikel1.Stuecklisten_Nr;
      if FQuery1.Fields[i].Fieldname =  'Artikelgruppe' then      FQuery1.FieldByName('Artikelgruppe').AsString:=     Artikel1.Artikelgruppe;
      if FQuery1.Fields[i].Fieldname =  'Artikel' then            FQuery1.FieldByName('Artikel').AsString:=           Artikel1.Artikel;
      if FQuery1.Fields[i].Fieldname =  'Einheit_EK' then         FQuery1.FieldByName('Einheit_EK').AsString:=        Artikel1.Einheit_EK;
      if FQuery1.Fields[i].Fieldname =  'EinheitMenge' then       FQuery1.FieldByName('EinheitMenge').AsString:=      Artikel1.EinheitMenge;
      if FQuery1.Fields[i].Fieldname =  'Name1' then              FQuery1.FieldByName('Name1').AsString:=             Artikel1.Name1;
      if FQuery1.Fields[i].Fieldname =  'Name2' then              FQuery1.FieldByName('Name2').AsString:=             Artikel1.Name2;
      if FQuery1.Fields[i].Fieldname =  'Name3' then              FQuery1.FieldByName('Name3').AsString:=             Artikel1.Name3;
      if FQuery1.Fields[i].Fieldname =  'Lieferant' then          FQuery1.FieldByName('Lieferant').AsString:=         Artikel1.Lieferant;
      if FQuery1.Fields[i].Fieldname =  'LieferantArtikelNr' then FQuery1.FieldByName('LieferantArtikelNr').AsString:=Artikel1.LieferantArtikelNr;
      if FQuery1.Fields[i].Fieldname =  'BerechnungsArt' then     FQuery1.FieldByName('BerechnungsArt').AsString:=    Artikel1.BerechnungsArt;
      if FQuery1.Fields[i].Fieldname =  'Kostenart' then          FQuery1.FieldByName('Kostenart').AsString:=         Artikel1.Kostenart;
      if FQuery1.Fields[i].Fieldname =  'ArtikelArt'then          FQuery1.FieldByName('ArtikelArt').AsString:=        Artikel1.ArtikelArt;
      if FQuery1.Fields[i].Fieldname =  'Bearbeiter' then         FQuery1.FieldByName('Bearbeiter').AsString:=        Artikel1.Bearbeiter;
      if FQuery1.Fields[i].Fieldname =  'Erledigt1' then          FQuery1.FieldByName('Erledigt1').AsInteger:=        Artikel1.Erledigt1;
      if FQuery1.Fields[i].Fieldname =  'Erledigt2' then          FQuery1.FieldByName('Erledigt2').AsInteger:=        Artikel1.Erledigt2;
      if FQuery1.Fields[i].Fieldname =  'Erledigt3' then          FQuery1.FieldByName('Erledigt3').AsInteger:=        Artikel1.Erledigt3;
      if FQuery1.Fields[i].Fieldname =  'Erledigt4' then          FQuery1.FieldByName('Erledigt4').AsInteger:=        Artikel1.Erledigt4;
      if FQuery1.Fields[i].Fieldname =  'Erledigt5' then          FQuery1.FieldByName('Erledigt5').AsInteger:=        Artikel1.Erledigt5;
      if FQuery1.Fields[i].Fieldname =  'Geaendert' then          FQuery1.FieldByName('Geaendert').AsInteger:=        Artikel1.Geaendert;
      if FQuery1.Fields[i].Fieldname =  'EK_Preis' then           FQuery1.FieldByName('EK_Preis').AsFloat:=           Artikel1.EK_Preis;
      if FQuery1.Fields[i].Fieldname =  'VK_Preis' then           FQuery1.FieldByName('VK_Preis').AsFloat:=           Artikel1.VK_Preis;
      if FQuery1.Fields[i].Fieldname =  'Aufschlag' then          FQuery1.FieldByName('Aufschlag').AsFloat:=          Artikel1.Aufschlag;
      if FQuery1.Fields[i].Fieldname =  'Rabatt' then             FQuery1.FieldByName('Rabatt').AsFloat:=             Artikel1.Rabatt;
      if FQuery1.Fields[i].Fieldname =  'Gewicht' then            FQuery1.FieldByName('Gewicht').AsFloat:=            Artikel1.Gewicht;
      if FQuery1.Fields[i].Fieldname =  'Zahl1' then              FQuery1.FieldByName('Zahl1').AsFloat:=              Artikel1.Zahl1;
      if FQuery1.Fields[i].Fieldname =  'Zahl2' then              FQuery1.FieldByName('Zahl2').AsFloat:=              Artikel1.Zahl2;
      if FQuery1.Fields[i].Fieldname =  'Zahl3' then              FQuery1.FieldByName('Zahl3').AsFloat:=              Artikel1.Zahl3;
      if FQuery1.Fields[i].Fieldname =  'Bestand' then            FQuery1.FieldByName('Bestand').AsFloat:=            Artikel1.Bestand;
      if FQuery1.Fields[i].Fieldname =  'Min_Bestand' then        FQuery1.FieldByName('Min_Bestand').AsFloat:=        Artikel1.Min_Bestand;
      if FQuery1.Fields[i].Fieldname =  'Menge' then              FQuery1.FieldByName('Menge').AsFloat:=              Artikel1.Menge;
      if FQuery1.Fields[i].Fieldname =  'Menge2' then             FQuery1.FieldByName('Menge2').AsFloat:=             Artikel1.Menge2;
      if FQuery1.Fields[i].Fieldname =  'Materialleistung' then   FQuery1.FieldByName('Materialleistung').AsFloat:=   Artikel1.Materialleistung;
      if FQuery1.Fields[i].Fieldname =  'Dienstleistung' then     FQuery1.FieldByName('Dienstleistung').AsFloat:=     Artikel1.Dienstleistung;
      if FQuery1.Fields[i].Fieldname =  'Fremdleistung' then      FQuery1.FieldByName('Fremdleistung').AsFloat:=      Artikel1.Fremdleistung;
      if FQuery1.Fields[i].Fieldname =  'Sonstigeleistung' then   FQuery1.FieldByName('Sonstigeleistung').AsFloat:=   Artikel1.Sonstigeleistung;
      if FQuery1.Fields[i].Fieldname =  'MatAufschlag'     then   FQuery1.FieldByName('MatAufschlag').AsFloat:=       Artikel1.MatAufschlag;
      if FQuery1.Fields[i].Fieldname =  'DieAufschlag' then       FQuery1.FieldByName('DieAufschlag').AsFloat:=       Artikel1.DieAufschlag;
      if FQuery1.Fields[i].Fieldname =  'FreAufschlag' then       FQuery1.FieldByName('FreAufschlag').AsFloat:=       Artikel1.FreAufschlag;
      if FQuery1.Fields[i].Fieldname =  'SonAufschlag' then       FQuery1.FieldByName('SonAufschlag').AsFloat:=       Artikel1.SonAufschlag;
      if FQuery1.Fields[i].Fieldname =  'Pos_Text' then           FQuery1.FieldByName('Pos_Text').AsString:=          Artikel1.Pos_Text.text;
      //Showmessage(FloatTostr(Artikel1.DieAufschlag));
      //Showmessage(FQuery1.FieldByName('DieAufschlag').AsString);



    end;
  end;
  if FArtikelStr='Artikel2' then begin
    for i:=0 to FQuery1.Fieldcount-1 do begin
      //if FQuery1.Fields[i].Fieldname =  'Nr' then                 FQuery1.FieldByName('Nr').AsInteger:=               Artikel2.Nr;
      if FQuery1.Fields[i].Fieldname =  'Pos_Nr' then             FQuery1.FieldByName('Pos_Nr').AsInteger:=           Artikel2.Pos_Nr;
      if FQuery1.Fields[i].Fieldname =  'Pos' then                FQuery1.FieldByName('Pos').AsInteger:=              Artikel2.Pos;
      if FQuery1.Fields[i].Fieldname =  'Modul_Nr' then           FQuery1.FieldByName('Modul_Nr').AsInteger:=         Artikel2.Modul_Nr;
      if FQuery1.Fields[i].Fieldname =  'ModulNr' then            FQuery1.FieldByName('ModulNr').AsInteger:=          Artikel2.ModulNr;
      if FQuery1.Fields[i].Fieldname =  'Artikel_Nr' then         FQuery1.FieldByName('Artikel_Nr').AsInteger:=       Artikel2.Artikel_Nr;
      if FQuery1.Fields[i].Fieldname =  'Stuecklisten_Nr' then    FQuery1.FieldByName('Stuecklisten_Nr').AsInteger:=  Artikel2.Stuecklisten_Nr;
      if FQuery1.Fields[i].Fieldname =  'Artikelgruppe' then      FQuery1.FieldByName('Artikelgruppe').AsString:=     Artikel2.Artikelgruppe;
      if FQuery1.Fields[i].Fieldname =  'Artikel' then            FQuery1.FieldByName('Artikel').AsString:=           Artikel2.Artikel;
      if FQuery1.Fields[i].Fieldname =  'Einheit_EK' then         FQuery1.FieldByName('Einheit_EK').AsString:=        Artikel2.Einheit_EK;
      if FQuery1.Fields[i].Fieldname =  'EinheitMenge' then       FQuery1.FieldByName('EinheitMenge').AsString:=      Artikel2.EinheitMenge;
      if FQuery1.Fields[i].Fieldname =  'Name1' then              FQuery1.FieldByName('Name1').AsString:=             Artikel2.Name1;
      if FQuery1.Fields[i].Fieldname =  'Name2' then              FQuery1.FieldByName('Name2').AsString:=             Artikel2.Name2;
      if FQuery1.Fields[i].Fieldname =  'Name3' then              FQuery1.FieldByName('Name3').AsString:=             Artikel2.Name3;
      if FQuery1.Fields[i].Fieldname =  'Lieferant' then          FQuery1.FieldByName('Lieferant').AsString:=         Artikel2.Lieferant;
      if FQuery1.Fields[i].Fieldname =  'LieferantArtikelNr' then FQuery1.FieldByName('LieferantArtikelNr').AsString:=Artikel2.LieferantArtikelNr;
      if FQuery1.Fields[i].Fieldname =  'BerechnungsArt' then     FQuery1.FieldByName('BerechnungsArt').AsString:=    Artikel2.BerechnungsArt;
      if FQuery1.Fields[i].Fieldname =  'Kostenart' then          FQuery1.FieldByName('Kostenart').AsString:=         Artikel2.Kostenart;
      if FQuery1.Fields[i].Fieldname =  'ArtikelArt' then         FQuery1.FieldByName('ArtikelArt').AsString:=        Artikel2.ArtikelArt;
      if FQuery1.Fields[i].Fieldname =  'Bearbeiter' then         FQuery1.FieldByName('Bearbeiter').AsString:=        Artikel2.Bearbeiter;
      if FQuery1.Fields[i].Fieldname =  'Erledigt1' then          FQuery1.FieldByName('Erledigt1').AsInteger:=        Artikel2.Erledigt1;
      if FQuery1.Fields[i].Fieldname =  'Erledigt2' then          FQuery1.FieldByName('Erledigt2').AsInteger:=        Artikel2.Erledigt2;
      if FQuery1.Fields[i].Fieldname =  'Erledigt3' then          FQuery1.FieldByName('Erledigt3').AsInteger:=        Artikel2.Erledigt3;
      if FQuery1.Fields[i].Fieldname =  'Erledigt4' then          FQuery1.FieldByName('Erledigt4').AsInteger:=        Artikel2.Erledigt4;
      if FQuery1.Fields[i].Fieldname =  'Erledigt5' then          FQuery1.FieldByName('Erledigt5').AsInteger:=        Artikel2.Erledigt5;
      if FQuery1.Fields[i].Fieldname =  'Geaendert' then          FQuery1.FieldByName('Geaendert').AsInteger:=        Artikel2.Geaendert;
      if FQuery1.Fields[i].Fieldname =  'EK_Preis' then           FQuery1.FieldByName('EK_Preis').AsFloat:=           Artikel2.EK_Preis;
      if FQuery1.Fields[i].Fieldname =  'VK_Preis' then           FQuery1.FieldByName('VK_Preis').AsFloat:=           Artikel2.VK_Preis;
      if FQuery1.Fields[i].Fieldname =  'Aufschlag' then          FQuery1.FieldByName('Aufschlag').AsFloat:=          Artikel2.Aufschlag;
      if FQuery1.Fields[i].Fieldname =  'Rabatt' then             FQuery1.FieldByName('Rabatt').AsFloat:=             Artikel2.Rabatt;
      if FQuery1.Fields[i].Fieldname =  'Gewicht' then            FQuery1.FieldByName('Gewicht').AsFloat:=            Artikel2.Gewicht;
      if FQuery1.Fields[i].Fieldname =  'Zahl1' then              FQuery1.FieldByName('Zahl1').AsFloat:=              Artikel2.Zahl1;
      if FQuery1.Fields[i].Fieldname =  'Zahl2' then              FQuery1.FieldByName('Zahl2').AsFloat:=              Artikel2.Zahl2;
      if FQuery1.Fields[i].Fieldname =  'Zahl3' then              FQuery1.FieldByName('Zahl3').AsFloat:=              Artikel2.Zahl3;
      if FQuery1.Fields[i].Fieldname =  'Bestand' then            FQuery1.FieldByName('Bestand').AsFloat:=            Artikel2.Bestand;
      if FQuery1.Fields[i].Fieldname =  'Min_Bestand' then        FQuery1.FieldByName('Min_Bestand').AsFloat:=        Artikel2.Min_Bestand;
      if FQuery1.Fields[i].Fieldname =  'Menge' then              FQuery1.FieldByName('Menge').AsFloat:=              Artikel2.Menge;
      if FQuery1.Fields[i].Fieldname =  'Menge2' then             FQuery1.FieldByName('Menge2').AsFloat:=             Artikel2.Menge2;
      if FQuery1.Fields[i].Fieldname =  'Materialleistung' then   FQuery1.FieldByName('Materialleistung').AsFloat:=   Artikel2.Materialleistung;
      if FQuery1.Fields[i].Fieldname =  'Dienstleistung' then     FQuery1.FieldByName('Dienstleistung').AsFloat:=     Artikel2.Dienstleistung;
      if FQuery1.Fields[i].Fieldname =  'Fremdleistung' then      FQuery1.FieldByName('Fremdleistung').AsFloat:=      Artikel2.Fremdleistung;
      if FQuery1.Fields[i].Fieldname =  'Sonstigeleistung' then   FQuery1.FieldByName('Sonstigeleistung').AsFloat:=   Artikel2.Sonstigeleistung;
      if FQuery1.Fields[i].Fieldname =  'MatAufschlag' then       FQuery1.FieldByName('MatAufschlag').AsFloat:=       Artikel2.MatAufschlag;
      if FQuery1.Fields[i].Fieldname =  'DieAufschlag' then       FQuery1.FieldByName('DieAufschlag').AsFloat:=       Artikel2.DieAufschlag;
      if FQuery1.Fields[i].Fieldname =  'FreAufschlag' then       FQuery1.FieldByName('FreAufschlag').AsFloat:=       Artikel2.FreAufschlag;
      if FQuery1.Fields[i].Fieldname =  'SonAufschlag' then       FQuery1.FieldByName('SonAufschlag').AsFloat:=       Artikel2.SonAufschlag;
      if FQuery1.Fields[i].Fieldname =  'Pos_Text' then           FQuery1.FieldByName('Pos_Text').AsString:=          Artikel2.Pos_Text.text;
    end;
  end;
  FQuery1.Post;
  Fzurueck:=FQuery1.FieldByName('Nr').AsInteger;
  Result:=FZurueck;
  FQuery1.Close;
end;

procedure TDataModuleMyOffice.DSNil(FArtikelStr:String);
Var i:integer;
begin
  if FArtikelStr='Artikel1' then begin
    Artikel1.Nr:=0;
    Artikel1.Pos_Nr:=0;
    Artikel1.Pos:=0;
    Artikel1.Modul_Nr:=0;
    Artikel1.ModulNr:=0;
    Artikel1.Artikel_Nr:=0;
    Artikel1.Stuecklisten_Nr:=0;
    Artikel1.Artikelgruppe:='';
    Artikel1.Artikel:='';
    Artikel1.Einheit_EK:='';
    Artikel1.EinheitMenge:='';
    Artikel1.Name1:='';
    Artikel1.Name2:='';
    Artikel1.Name3:='';
    Artikel1.Lieferant:='';
    Artikel1.LieferantArtikelNr:='';
    Artikel1.BerechnungsArt:='';
    Artikel1.Kostenart:='';
    Artikel1.Gruppierung:='';
    Artikel1.ArtikelArt:='';
    Artikel1.Bearbeiter:='';
    Artikel1.Erledigt1:=0;
    Artikel1.Erledigt2:=0;
    Artikel1.Erledigt3:=0;
    Artikel1.Erledigt4:=0;
    Artikel1.Erledigt5:=0;
    Artikel1.Geaendert:=0;
    Artikel1.EK_Preis:=0;
    Artikel1.VK_Preis:=0;
    Artikel1.Aufschlag:=0;
    Artikel1.Rabatt:=0;
    Artikel1.Gewicht:=0;
    Artikel1.Zahl1:= 0;
    Artikel1.Zahl2:=0;
    Artikel1.Zahl3:=0;
    Artikel1.Bestand:=0;
    Artikel1.Min_Bestand:=0;
    Artikel1.Menge:=0;
    Artikel1.Menge2:=0;
    Artikel1.Materialleistung:=0;
    Artikel1.Dienstleistung:=0;
    Artikel1.Fremdleistung:=0;
    Artikel1.Sonstigeleistung:=0;
    Artikel1.MatAufschlag:=0;
    Artikel1.DieAufschlag:=0;
    Artikel1.FreAufschlag:=0;
    Artikel1.SonAufschlag:=0;
    Artikel1.Pos_Text.text:='';
  end;
  if FArtikelStr='Artikel2' then begin
    Artikel2.Nr:=0;
    Artikel2.Pos_Nr:=0;
    Artikel2.Pos:=0;
    Artikel2.Modul_Nr:=0;
    Artikel2.ModulNr:=0;
    Artikel2.Artikel_Nr:=0;
    Artikel2.Stuecklisten_Nr:=0;
    Artikel2.Artikelgruppe:='';
    Artikel2.Artikel:='';
    Artikel2.Einheit_EK:='';
    Artikel2.EinheitMenge:='';
    Artikel2.Name1:='';
    Artikel2.Name2:='';
    Artikel2.Name3:='';
    Artikel2.Lieferant:='';
    Artikel2.LieferantArtikelNr:='';
    Artikel2.BerechnungsArt:='';
    Artikel2.Kostenart:='';
    Artikel2.Gruppierung:='';
    Artikel2.ArtikelArt:='';
    Artikel2.Bearbeiter:='';
    Artikel2.Erledigt1:=0;
    Artikel2.Erledigt2:=0;
    Artikel2.Erledigt3:=0;
    Artikel2.Erledigt4:=0;
    Artikel2.Erledigt5:=0;
    Artikel2.Geaendert:=0;
    Artikel2.EK_Preis:=0;
    Artikel2.VK_Preis:=0;
    Artikel2.Aufschlag:=0;
    Artikel2.Rabatt:=0;
    Artikel2.Gewicht:=0;
    Artikel2.Zahl1:= 0;
    Artikel2.Zahl2:=0;
    Artikel2.Zahl3:=0;
    Artikel2.Bestand:=0;
    Artikel2.Min_Bestand:=0;
    Artikel2.Menge:=0;
    Artikel2.Menge2:=0;
    Artikel2.Materialleistung:=0;
    Artikel2.Dienstleistung:=0;
    Artikel2.Fremdleistung:=0;
    Artikel2.Sonstigeleistung:=0;
    Artikel2.MatAufschlag:=0;
    Artikel2.DieAufschlag:=0;
    Artikel2.FreAufschlag:=0;
    Artikel2.SonAufschlag:=0;
    Artikel2.Pos_Text.text:='';
  end;
end;

procedure TDataModuleMyOffice.DSLoeschen(FTabelle,FFeld:String;FNr:longint);//Sondereinstellung
begin
  if  FQuery1.Active then FQuery1.Close;
  FQuery1.SQL.Clear;
  FQuery1.SQL.Add('Delete From ' + FTabelle + ' WHERE '+FFeld+' = ' + inttostr(Fnr));
  try
    FQuery1.ExecSQL;
  finally
  end;
  FQuery1.Close;
end;

procedure  TDataModuleMyOffice.DSArtikelListeKopieren(FVonTabelle,FVonFeld:String;FVonWert:integer;FZuTabelle,FZuFeld:String;FZuWert:integer);
var i:integer;
begin
  if  FQueryVon.Active then FQueryVon.Close;
  FQueryVon.SQL.Clear;
  FQueryVon.SQL.Add('Select * From ' + FVonTabelle + ' WHERE '+FVonFeld+' = ' + inttostr(FVonWert));
  try
    FQueryVon.open;
  finally
  end;
  FQueryVon.first;
  for i := 0 to FQueryVon.RecordCount - 1 do begin
    DSSet('Artikel1',FQueryVon);
    if FZuFeld='Stuecklisten_Nr' then Artikel1.Stuecklisten_Nr:=FZuWert;
    if FZuFeld='Nr'              then Artikel1.Nr:=FZuWert;
    if FZuFeld='Pos_Nr'          then Artikel1.Pos_Nr:=FZuWert;
    if FZuFeld='Pos'             then Artikel1.Pos:=FZuWert;
    if FZuFeld='Modul_Nr'        then Artikel1.Modul_Nr:=FZuWert;
    if FZuFeld='Artikel_Nr'      then Artikel1.Artikel_Nr:=FZuWert;
    if FZuFeld='ModulNr'         then Artikel1.ModulNr:=FZuWert;
    DSGet('Artikel1',FZuTabelle,0);
    FQueryVon.next
  end;
  FQueryVon.close;
end;

procedure  TDataModuleMyOffice.DSArtikelListeKopieren2(FVonTabelle,FVonFeld:String;FVonWert:integer;FZuTabelle,FZuFeld,FZuFeld2:String;FZuWert,FZuWert2:integer);
var i:integer;
begin
  if  FQueryVon.Active then FQueryVon.Close;
  FQueryVon.SQL.Clear;
  FQueryVon.SQL.Add('Select * From ' + FVonTabelle + ' WHERE '+FVonFeld+' = ' + inttostr(FVonWert));
  try
    FQueryVon.open;
  finally
  end;
  FQueryVon.first;
  for i := 0 to FQueryVon.RecordCount - 1 do begin
    DSSet('Artikel1',FQueryVon);
    if FZuFeld='Stuecklisten_Nr' then Artikel1.Stuecklisten_Nr:=FZuWert;
    if FZuFeld='Nr'              then Artikel1.Nr:=FZuWert;
    if FZuFeld='Pos_Nr'          then Artikel1.Pos_Nr:=FZuWert;
    if FZuFeld='Pos'             then Artikel1.Pos:=FZuWert;
    if FZuFeld='Modul_Nr'        then Artikel1.Modul_Nr:=FZuWert;
    if FZuFeld='Artikel_Nr'      then Artikel1.Artikel_Nr:=FZuWert;
    if FZuFeld='ModulNr'         then Artikel1.ModulNr:=FZuWert;
    if FZuFeld2='Stuecklisten_Nr' then Artikel1.Stuecklisten_Nr:=FZuWert2;
    if FZuFeld2='Nr'              then Artikel1.Nr:=FZuWert2;
    if FZuFeld2='Pos_Nr'          then Artikel1.Pos_Nr:=FZuWert2;
    if FZuFeld2='Pos'             then Artikel1.Pos:=FZuWert2;
    if FZuFeld2='Modul_Nr'        then Artikel1.Modul_Nr:=FZuWert2;
    if FZuFeld2='Artikel_Nr'      then Artikel1.Artikel_Nr:=FZuWert2;
    if FZuFeld2='ModulNr'         then Artikel1.ModulNr:=FZuWert2;
    DSGet('Artikel1',FZuTabelle,0);
    FQueryVon.next
  end;
  FQueryVon.close;
end;
end.
