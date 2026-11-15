unit UnitModule;
{Fenster Planlos Module          1 bis 10
                 Stammdaten      31 bis 40 und 81 bis 90
                 Einstellungen   41 bis 50
         Projekte                11 bis 20
         Adressen                21 bis 30
         Artikel                 71 bis 80
         Artikelgruppe           61 bis 70
         Artikelsammlung         100 bis 120
         Textbausteine           121 bis 130
         Stueckliste             131 bis 140
         Artikelaussuchen        141 bis 180
         EinstellungenModulart   181 bis 190
         Stammdaten Besonderes   191 bis 210
         Stammdaten Selbsdev.    211 bis 230
         Einstellung benutzer    231 bis 240
         }
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBGrids, DB, DBTables, Grids, Calendar, ComCtrls, Outline,
  DirOutln, ExtCtrls, Menus, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  DBCtrls, Mask, ExtDlgs;

type
  TFormPlanlos = class(TForm)
    PageControl1: TPageControl;
    TabSheetModule: TTabSheet;
    TabSheetStammdaten: TTabSheet;
    TabSheetEinstellungen: TTabSheet;
    s1GroupZeitbereich: TGroupBox;
    s1RadioZeitbereichAlle: TRadioButton;
    s1RadioZeitbereichJahr: TRadioButton;
    s1RadioZeitbereichMonat: TRadioButton;
    s1ComboZeitbereichMonat: TComboBox;
    s1ComboZeitbereichJahr: TComboBox;
    s1RadioZeitbereichTag: TRadioButton;
    s1CalenderZeitbreichTag: TCalendar;
    DataSourceModule: TDataSource;
    DBGridModule: TDBGrid;
    ComboBoxModule: TComboBox;
    ButtonAdressen: TButton;
    ButtonArtikel: TButton;
    ButtonEinheiten: TButton;
    GroupBoxModulF: TGroupBox;
    RadioButtonFilterNr: TRadioButton;
    EditFVN: TEdit;
    RadioButtonFPNR: TRadioButton;
    RadioButtonFAN: TRadioButton;
    ButtonFilterProjekte: TButton;
    ButtonFilterAdressen: TButton;
    RadioButtonFA: TRadioButton;
    RadioButtonName: TRadioButton;
    ButtonFN: TButton;
    GroupBoxPerson: TGroupBox;
    RadioButtonPAlle: TRadioButton;
    RadioButtonPB: TRadioButton;
    RadioButtonPL: TRadioButton;
    ButtonFPB: TButton;
    ButtonFPL: TButton;
    DataSource1: TDataSource;
    ButtonArtikelGruppe: TButton;
    PageControl2: TPageControl;
    TabSheetDB: TTabSheet;
    GroupBoxEModule: TGroupBox;
    LabelEMProjekte: TLabel;
    CheckBoxEMAngebote: TCheckBox;
    CheckBoxEMAuftrag: TCheckBox;
    CheckBoxEMBestellungen: TCheckBox;
    ButtonEMUebernehmen: TButton;
    ButtonEMabbrechen: TButton;
    TabSheetFenster: TTabSheet;
    ButtonForm1: TButton;
    ButtonKunden: TButton;
    ButtonLieferant: TButton;
    ButtonMitarbeiter: TButton;
    LabelNeu: TLabel;
    ButtonProjekt: TButton;
    ButtonKategorie: TButton;
    ButtonEinstellungModulart: TButton;
    ScrollBoxButtom: TScrollBox;
    ButtonListe1: TButton;
    ButtonListe2: TButton;
    ButtonListe3: TButton;
    ButtonListe4: TButton;
    ButtonListe5: TButton;
    ButtonListe6: TButton;
    ButtonListe7: TButton;
    ButtonListe8: TButton;
    ButtonListe9: TButton;
    ButtonListe10: TButton;
    ButtonListe11: TButton;
    ButtonListe12: TButton;
    ButtonListe13: TButton;
    ButtonListe14: TButton;
    ButtonListe15: TButton;
    ButtonListe16: TButton;
    ButtonListe17: TButton;
    ButtonListe18: TButton;
    ButtonListe19: TButton;
    ButtonListe20: TButton;
    ButtonListe21: TButton;
    ButtonListe23: TButton;
    ButtonListe24: TButton;
    ButtonListe25: TButton;
    ButtonListe26: TButton;
    ButtonListe27: TButton;
    ButtonListe28: TButton;
    ButtonListe29: TButton;
    ButtonListe30: TButton;
    ButtonListe31: TButton;
    ButtonListe32: TButton;
    ButtonListe33: TButton;
    ButtonListe22: TButton;
    DataSource2: TDataSource;
    ButtonListe50: TButton;
    ButtonListe49: TButton;
    ButtonListe48: TButton;
    ButtonListe47: TButton;
    ButtonListe46: TButton;
    ButtonListe45: TButton;
    ButtonListe44: TButton;
    ButtonListe43: TButton;
    ButtonListe42: TButton;
    ButtonListe41: TButton;
    ButtonListe40: TButton;
    ButtonListe39: TButton;
    ButtonListe38: TButton;
    ButtonListe37: TButton;
    ButtonListe36: TButton;
    ButtonListe35: TButton;
    ButtonListe34: TButton;
    PopupMenuSortieren: TPopupMenu;
    ButtonTextbaustein: TButton;
    ButtonStuecklistenGruppe: TButton;
    ButtonStuecklistenArtikel: TButton;
    ButtonStuecklistenListe: TButton;
    ImageTastatur: TImage;
    Buttonloeschen: TButton;
    ButtonAendern: TButton;
    sortieren: TButton;
    ButtonModuleEnde: TButton;
    LabelF8: TLabel;
    LabelF6: TLabel;
    LabelF7: TLabel;
    LabelF10: TLabel;
    ButtonArtikelaussuchfenster: TButton;
    QueryEinstellungForm1L: TZQuery;
    QueryModule: TZQuery;
    QueryEinstellungModulart1: TZQuery;
    TabSheetHilfe: TTabSheet;
    LabelVersionshinweiss: TLabel;
    Label1: TLabel;
    MemoSQLBefehl: TMemo;
    ButtonSQLAusfuehren: TButton;
    ButtonMyOfficeAnlegen: TButton;
    Buttontest: TButton;
    ButtonEinstellungDrucken: TButton;
    Allgemeine_Einstellungen: TTabSheet;
    QueryAllgemeineEinstellungen: TZQuery;
    DataSourceQueryAllgemeineEinstellungen: TDataSource;
    DBEditMwSt: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    DBEditFirmenNr: TDBEdit;
    Label4: TLabel;
    DBEditLandNr: TDBEdit;
    Label5: TLabel;
    DBEditEinheitGewicht: TDBEdit;
    DBEditNameZahl1: TDBEdit;
    DBEditEinheitZahl1: TDBEdit;
    DBEditNameZahl2: TDBEdit;
    DBEditEinheitZahl2: TDBEdit;
    DBEditNameZahl3: TDBEdit;
    DBEditEinheitZahl3: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    DBEditName1: TDBEdit;
    DBEditName2: TDBEdit;
    DBEditName3: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    ButtonDatenAendern: TButton;
    LabelF5: TLabel;
    Buttonkopieren: TButton;
    TabSheetUser: TTabSheet;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    ButtonBenutzereinstellungen: TButton;
    ButtonBenutzer: TButton;
    Label17: TLabel;
    Label18: TLabel;
    QueryEinstelungenBenutzer: TZQuery;
    DataSourceEinstelungenBenutzer: TDataSource;
    PanelTastatur: TPanel;
    LabelF5_p: TLabel;
    LabelF6_p: TLabel;
    LabelF7_p: TLabel;
    Label22: TLabel;
    LabelF10_p: TLabel;
    LabelF8_p: TLabel;
    GCB: TCheckBox;
    ButtonNummern: TButton;
    ButtonModule: TButton;
    ButtonProjekte: TButton;
    ButtonArtikelSammlungen: TButton;
    ButtonModulStuecklistenartikel: TButton;
    Panel3: TPanel;
    ButtonStGuppierung: TButton;
    ButtonWaArtikelTemp: TButton;
    ButtonSonderfunktion1: TButton;
    ButtonSonderfunktion2: TButton;
    ButtonSonderfunktion3: TButton;
    ButtonSonderfunktion4: TButton;
    ButtonSonderfunktion5: TButton;
    ButtonSonderfunktion6: TButton;
    ButtonSonderfunktion7: TButton;
    ButtonSonderfunktion8: TButton;
    ButtonSonderfunktion9: TButton;
    ButtonSonderfunktion10: TButton;
    ButtonSonderfunktion11: TButton;
    ButtonSonderfunktion12: TButton;
    ButtonSonderfunktion13: TButton;
    ButtonSonderfunktion14: TButton;
    ButtonSonderfunktion15: TButton;
    ButtonSonderfunktion16: TButton;
    ButtonSonderfunktion17: TButton;
    ButtonSonderfunktion18: TButton;
    Panel4: TPanel;
    ButtonSelbst1: TButton;
    ButtonSelbst2: TButton;
    ButtonSelbst3: TButton;
    ButtonSelbst4: TButton;
    ButtonSelbst5: TButton;
    ButtonSelbst6: TButton;
    ButtonSelbst7: TButton;
    ButtonSelbst8: TButton;
    ButtonSelbst9: TButton;
    ButtonSelbst10: TButton;
    ButtonSelbst11: TButton;
    ButtonSelbst12: TButton;
    ButtonSelbst13: TButton;
    ButtonSelbst14: TButton;
    ButtonSelbst15: TButton;
    ButtonSelbst16: TButton;
    ButtonSelbst17: TButton;
    ButtonSelbst18: TButton;
    ButtonRegistrierung: TButton;
    ButtonBenutzereinstellungFenster: TButton;
    LabelINIDatabase: TLabel;
    ButtonINIDatabase: TButton;
    Panel2: TPanel;
    Label11: TLabel;
    ButtonINIHostname: TButton;
    ButtonINIPassswort: TButton;
    ButtonINIProtocol: TButton;
    Label12: TLabel;
    Label13: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    ButtonINIUser: TButton;
    ButtonINIDBLogin: TButton;
    ButtonINIDBErstellen: TButton;
    ButtonINIProgrammsta: TButton;
    Label24: TLabel;
    ButtonImport: TButton;
    ButtonExportieren: TButton;
    Label25: TLabel;
    Label26: TLabel;
    procedure ButtonModuleEndeClick(Sender: TObject);
    procedure ModulDBZeigen;
    procedure ModulDBZeigenMitZeiger(Zeiger:longint);
    procedure s1RadioZeitbereichAlleClick(Sender: TObject);
    procedure s1RadioZeitbereichJahrClick(Sender: TObject);
    procedure s1RadioZeitbereichMonatClick(Sender: TObject);
    procedure s1RadioZeitbereichTagClick(Sender: TObject);
    procedure s1ComboZeitbereichJahrChange(Sender: TObject);
    procedure s1ComboZeitbereichMonatChange(Sender: TObject);
    function bereichDatum(bereich:string;datum:TDateTime):string;
    function iniZeile(zeile:String):String;
    function datumAusKalender:TDateTime;
    function Zeitbereich:String;
    procedure s1CalenderZeitbreichTagChange(Sender: TObject);
    procedure initial(Sender: TObject);
    procedure ButtonFNClick(Sender: TObject);
    procedure ComboBoxModuleChange(Sender: TObject);
    procedure RadioButtonNameClick(Sender: TObject);
    procedure RadioButtonFANClick(Sender: TObject);
    procedure ButtonFilterAdressenClick(Sender: TObject);
    procedure RadioButtonFAClick(Sender: TObject);
    procedure RadioButtonFilterNrClick(Sender: TObject);
    procedure EditFVNKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RadioButtonFPNRClick(Sender: TObject);
    procedure ButtonFilterProjekteClick(Sender: TObject);
    procedure RadioButtonPAlleClick(Sender: TObject);
    procedure RadioButtonPBClick(Sender: TObject);
    procedure ButtonFPBClick(Sender: TObject);
    procedure RadioButtonPLClick(Sender: TObject);
    procedure ButtonFPLClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridModuleDblClick(Sender: TObject);
    procedure ButtonAendernClick(Sender: TObject);
    procedure ButtonEinheitenClick(Sender: TObject);
    procedure ButtonForm1Click(Sender: TObject);
    procedure ButtonArtikelClick(Sender: TObject);
    procedure ButtonArtikelGruppeClick(Sender: TObject);
    procedure ButtonModuleClick(Sender: TObject);
    procedure ButtonProjekteClick(Sender: TObject);
    procedure ButtonKundenClick(Sender: TObject);
    procedure ButtonAdressenClick(Sender: TObject);
    procedure ButtonLieferantClick(Sender: TObject);
    procedure ButtonMitarbeiterClick(Sender: TObject);
    procedure ButtonKategorieClick(Sender: TObject);
    procedure ButtonEinstellungModulartClick(Sender: TObject);
    procedure ButtonListe1Click(Sender: TObject);
    procedure ButtonProjektClick(Sender: TObject);
    procedure sortierenClick(Sender: TObject);
    procedure PopupMenuSortierenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EditFVNKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonTextbausteinClick(Sender: TObject);
    procedure ButtonBenutzerClick(Sender: TObject);
    procedure ButtonLoeschenClick(Sender: TObject);
    procedure ButtonStuecklistenListeClick(Sender: TObject);
    procedure ButtonStuecklistenGruppeClick(Sender: TObject);
    procedure ButtonStuecklistenArtikelClick(Sender: TObject);
    procedure ButtonArtikelaussuchfensterClick(Sender: TObject);
    procedure ButtonArtikelSammlungenClick(Sender: TObject);
    procedure ButtonSQLAusfuehrenClick(Sender: TObject);
    procedure ButtonMyOfficeAnlegenClick(Sender: TObject);
    procedure ButtontestClick(Sender: TObject);
    procedure ButtonEinstellungDruckenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonDatenAendernClick(Sender: TObject);
    procedure Allgemeine_EinstellungenExit(Sender: TObject);
    procedure ButtonkopierenClick(Sender: TObject);
    procedure QueryModuleAfterScroll(DataSet: TDataSet);
    procedure Modulbuttonszeigen();
    procedure ButtonBenutzereinstellungenClick(Sender: TObject);
//    procedure PanelButtonDateiActivClick(Sender: TObject);
//    procedure PanelButtonFarbeactivClick(Sender: TObject);
//    procedure PanelButtonFarbenichtactivClick(Sender: TObject);
//    procedure PanelButtonDateinichtActivClick(Sender: TObject);
//    procedure DBRadioGroupTastaturActicChange(Sender: TObject);
//    procedure DBRadioGroupButtonNichtactivChange(Sender: TObject);
//    procedure PanelButtonFontColorActivClick(Sender: TObject);
//    procedure PanelButtonFontColorNichtActivClick(Sender: TObject);
    procedure ButtonModulStuecklistenartikelClick(Sender: TObject);
    procedure ButtonNummernClick(Sender: TObject);
    procedure ButtonStGuppierungClick(Sender: TObject);
    procedure ButtonWaArtikelTempClick(Sender: TObject);
    procedure ButtonSonderfunktion1Click(Sender: TObject);
    procedure ButtonSonderfunktion2Click(Sender: TObject);
    procedure ButtonSonderfunktion3Click(Sender: TObject);
    procedure ButtonSonderfunktion4Click(Sender: TObject);
    procedure ButtonSonderfunktion5Click(Sender: TObject);
    procedure ButtonSonderfunktion6Click(Sender: TObject);
    procedure ButtonSonderfunktion7Click(Sender: TObject);
    procedure ButtonSonderfunktion8Click(Sender: TObject);
    procedure ButtonSonderfunktion9Click(Sender: TObject);
    procedure ButtonSonderfunktion10Click(Sender: TObject);
    procedure ButtonSonderfunktion11Click(Sender: TObject);
    procedure ButtonSonderfunktion12Click(Sender: TObject);
    procedure ButtonSonderfunktion13Click(Sender: TObject);
    procedure ButtonSonderfunktion14Click(Sender: TObject);
    procedure ButtonSonderfunktion15Click(Sender: TObject);
    procedure ButtonSonderfunktion16Click(Sender: TObject);
    procedure ButtonSonderfunktion17Click(Sender: TObject);
    procedure ButtonSonderfunktion18Click(Sender: TObject);
    procedure ButtonSelbst1Click(Sender: TObject);
    procedure ButtonSelbst2Click(Sender: TObject);
    procedure ButtonSelbst3Click(Sender: TObject);
    procedure ButtonSelbst4Click(Sender: TObject);
    procedure ButtonSelbst5Click(Sender: TObject);
    procedure ButtonSelbst6Click(Sender: TObject);
    procedure ButtonSelbst7Click(Sender: TObject);
    procedure ButtonSelbst8Click(Sender: TObject);
    procedure ButtonSelbst9Click(Sender: TObject);
    procedure ButtonSelbst10Click(Sender: TObject);
    procedure ButtonSelbst11Click(Sender: TObject);
    procedure ButtonSelbst12Click(Sender: TObject);
    procedure ButtonSelbst13Click(Sender: TObject);
    procedure ButtonSelbst14Click(Sender: TObject);
    procedure ButtonSelbst15Click(Sender: TObject);
    procedure ButtonSelbst16Click(Sender: TObject);
    procedure ButtonSelbst17Click(Sender: TObject);
    procedure ButtonSelbst18Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonRegistrierungClick(Sender: TObject);
    procedure ButtonBenutzereinstellungFensterClick(Sender: TObject);
    procedure ButtonINIDatabaseClick(Sender: TObject);
    procedure ButtonINIHostnameClick(Sender: TObject);
    procedure ButtonINIPassswortClick(Sender: TObject);
    procedure ButtonINIProtocolClick(Sender: TObject);
    procedure ButtonINIUserClick(Sender: TObject);
    procedure ButtonINIDBLoginClick(Sender: TObject);
    procedure ButtonINIDBErstellenClick(Sender: TObject);
    procedure ButtonINIProgrammstaClick(Sender: TObject);
    procedure ButtonImportClick(Sender: TObject);
    procedure ButtonExportierenClick(Sender: TObject);

  private
    { Private-Deklarationen }
  public
  GZeiger:longint;GzeigerNeu:Boolean;{GMwst,GVKPlusMwst,}GVoreinstellungMwst:Double ;{GModulart:String;}
  GButtonDateinameNichtActiv,GButtonDateinameActiv,GButtonFarbeActive,GButtonFarbeNichtActive:String;GButtonFeldActiv,GButtonFeldNichtActiv:Integer;
  GButtonFontColorActiv,GButtonFontColorNichtActiv:String;
  //GCB:TCheckBox;
  Gtest,GArtikelaussuchenneu:Boolean;
  GModulNrFuerStuckliste:integer;
  UPar:TStringList;
  GVersion:String;GLandNr,GFirmaNr:longint;
  end;
type
    TModulV = record
    //Nr:integer;
    Modulname:String[25];
    neu,aendern,loeschen,kopieren:Boolean;
end;
var
  FormPlanlos: TFormPlanlos;
  modulart,modulname,modulAdressName,modulVerbindungsNr,modulprojektnr,
  modulErfassungsdatum,modulBearbeiter,modulLeiter,modulOrder:string;
 // UNr,UVerNr:longint;
  modulArtListe:TStringList;
  FormCounter:integer;
  //UDBPaht,
  //UEnaF8:Boolean;
  GBenutzer,GModulart:String;
  GOffeneFenster,GCascade,GTopSchritte,GLeftSchritte,GAnimationsgeschwindigkeit:integer;
  ItemSortieren: TMenuItem;UZeiger,GProjekt_Nr,GBeziehungs_Nr,GModulart_Nr:longint;
  //GLandNr,GFirmaNr:longint;
  GKopfFusstext,GArtikelgruppe,G_Artikelgruppe,G_Benutzereinstellung:string;
  GIniDatabase,GIniHostname,GIniPasswort,GIniProtocol,GIniUser,GMeldefenster:string;
  GIniDBerstellen,GIniLoginPrompt,GIniProgrammsta:Boolean;
  GEinheitGewicht,GEinheitZahl1,GEinheitZahl2,GEinheitZahl3,GZahl1,GZahl2,GZahl3,GName1,GName2,GName3:String;
  GSonstigeSQLGruppe,GSonstigeSQLArtikel1,GSonstigeSQLArtikel2,GModulart_Name,GBeziehungs_Name,GButtonCaption,GUeberschrift:String;
  GBmpLaden:Boolean;
  GZeigerFuerSonstiges,GPosFuerSonstiges:longint;
  GDatumLauffaehig:TDateTime;GLogo:TBitmap;
  M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12,M13,M14,M15,M16,M17,M18,M19,M20:TModulV;
  M21,M22,M23,M24,M25,M26,M27,M28,M29,M30,M31,M32,M33,M34,M35,M36,M37,M38,M39,M40:TModulV;
  M41,M42,M43,M44,M45,M46,M47,M48,M49,M50:TModulV;
  UMloeschen,UMkopieren,UMaendern:Boolean;
  UProjektkopieren,UProjektaendern,UProjektloeschen,UmodulsrollAn,UProjektneu:Boolean;
  //GButtonDateinameNichtActiv,GButtonDateinameActiv,GButtonFarbeActive,GButtonFarbeNichtActive:String;GButtonFeldActiv,GButtonFeldNichtActiv:Integer;
  //GButtonFontColorActiv,GButtonFontColorNichtActiv:String;
  //GFensteranimation:Integer;
implementation


uses UnitDammiForm,TempForm, UnitMaskeProjekt,UnitAdresse,UnitArtikelSammlung,
  UnitEinstellungForm1, UnitMeldefenster, UnitDB, UnitMaskeEinheit,
  UnitArtikel, UnitArtikelgruppe, UnitKategorie, UnitEinstellungModulart,
  UnitGuppierung, UnitTextbaustein, UnitBenutzer, UnitArtikelAussuchen,
  UnitStueckListe, UnitStuecklistenGruppe,UnitDataModul,
  UnitEinstellungenDrucken, UnitEinstellungenBenutzer, registrierung,
  UnitEinstellungenFenster, UnitImport, UnitExport;

{$R *.DFM}

//zeige Zeitbereich------------------------------------------------------------
procedure TFormPlanlos.PopupMenuSortierenClick(Sender: TObject);
begin
 with Sender as TMenuItem do modulOrder:=(Caption);
 ModulDBZeigenMitZeiger(UZeiger);
end;

procedure TFormPlanlos.s1CalenderZeitbreichTagChange(Sender: TObject);
begin
  modulErfassungsdatum:=bereichDatum('Tag',datumAusKalender);
  ModulDBZeigenMitZeiger(UZeiger);
end;

function TFormPlanlos.Zeitbereich:String;
begin
  if s1RadioZeitbereichAlle.Checked then Result:='Alle';
  if s1RadioZeitbereichTag.Checked  then Result:='Tag';
  if s1RadioZeitbereichMonat.Checked then Result:='Monat';
  if s1RadioZeitbereichJahr.Checked then Result:='Jahr';
end;

procedure TFormPlanlos.s1RadioZeitbereichAlleClick(Sender: TObject);
begin
  s1ComboZeitbereichJahr.Visible := False;
  s1ComboZeitbereichMonat.Visible := False;
  s1CalenderZeitbreichTag.Visible := False;
  modulErfassungsdatum:=bereichDatum('Alle',now);
  ModulDBZeigenMitZeiger(UZeiger);
end;

procedure TFormPlanlos.s1RadioZeitbereichJahrClick(Sender: TObject);
begin
  s1ComboZeitbereichJahr.Visible := True;
  s1ComboZeitbereichMonat.Visible := False;
  s1CalenderZeitbreichTag.Visible := False;
  modulErfassungsdatum:=bereichDatum('Jahr',datumAusKalender);
  s1ComboZeitbereichJahr.Focused;
  ModulDBZeigenMitZeiger(UZeiger);
end;

procedure TFormPlanlos.s1RadioZeitbereichMonatClick(Sender: TObject);
begin
  s1ComboZeitbereichJahr.Visible := True;
  s1ComboZeitbereichMonat.Visible := True;
  s1CalenderZeitbreichTag.Visible := False;
  s1ComboZeitbereichMonat.Focused;
  modulErfassungsdatum:=bereichDatum('Monat',datumAusKalender);
  ModulDBZeigenMitZeiger(UZeiger);
end;

procedure TFormPlanlos.s1RadioZeitbereichTagClick(Sender: TObject);
begin
  s1ComboZeitbereichJahr.Visible := True;
  s1ComboZeitbereichMonat.Visible := True;
  s1CalenderZeitbreichTag.Visible := True;
  modulErfassungsdatum:=bereichDatum('Tag',datumAusKalender);
  ModulDBZeigenMitZeiger(UZeiger);
end;

procedure TFormPlanlos.s1ComboZeitbereichJahrChange(Sender: TObject);
var jahr:integer;
    bereich:string;
begin
  s1CalenderZeitbreichTag.Year:=strtoint(s1ComboZeitbereichJahr.text);
  modulErfassungsdatum:=bereichDatum(Zeitbereich,datumAusKalender);
  ModulDBZeigenMitZeiger(UZeiger);
end;

procedure TFormPlanlos.s1ComboZeitbereichMonatChange(Sender: TObject);
begin
  s1CalenderZeitbreichTag.Month:=(s1ComboZeitbereichMonat.ItemIndex  + 1);
  modulErfassungsdatum:=bereichDatum(Zeitbereich,datumAusKalender);
  ModulDBZeigenMitZeiger(UZeiger);
end;

function TFormPlanlos.datumAusKalender:TDateTime;
var Year, Month, Day: Word;
begin
  Year:=s1CalenderZeitbreichTag.Year;
  Month:=s1CalenderZeitbreichTag.Month;
  Day:=s1CalenderZeitbreichTag.Day;
  Result:=EncodeDate(Year, Month, Day);
end;

function TFormPlanlos.bereichDatum(bereich:string; datum:TDateTime):string;
var Year, Month, Day: Word;
    datumVon,datumBis:string;
begin
  if bereich='Alle' then
    Result:='and erfassungsdatum >= "1900-01-01"';
  if bereich='Jahr' then
    begin
      DecodeDate(datum, Year, Month, Day);
      datumVon:=IntToStr(Year)+'-01-01';
      datumBis:=IntToStr(Year)+'-12-31';
      Result:=' AND (erfassungsdatum BETWEEN  "'+datumVon+'" AND "'+datumBis+'") ';
    end;
  if bereich='Monat' then
    begin
      DecodeDate(datum, Year, Month, Day);
      DatumVon:=IntToStr(Year)+'-'+IntToStr(Month)+'-01';
      if Month < 12 then
        Month:=Month+1
      else
        Begin
          Month:=1;Year:=Year+1;
        end;
      DatumBis:=IntToStr(Year)+'-'+IntToStr(Month)+'-01';
      Result:='and erfassungsdatum >= "'+DatumVon+'" and erfassungsdatum < "'+datumBis+'"';
    end;
  if bereich='Tag' then
    begin
      DecodeDate(datum, Year, Month, Day);
      DatumVon:=IntToStr(Year)+'-'+IntToStr(Month)+'-'+IntToStr(Day);
      Result:='and erfassungsdatum = "'+DatumVon+'"';
    end;
end;
// eingang----------------------------------------------------------------------
procedure TFormPlanlos.initial(Sender: TObject);
   var Year, Month, Day: Word;
       i:integer;
       FFensterdesignNr:integer;
begin
  //----------------------Versionskontrolle----------------

  {GModulNrFuerStuckliste:=0;
  UMloeschen:=False;UMkopieren:=False;UMaendern:=False;
  UmodulsrollAn:=True;
  UProjektneu:=False;UProjektkopieren:=False;UProjektaendern:=False;UProjektloeschen:=False;
  GBenutzer:='Standard';GModulart:='Standard';}
  DataModuleMyOffice.ZConnectionMyOffice.Disconnect;
  DataModuleMyOffice.ZConnectionMyOffice.Database:=GIniDatabase;
  //Showmessage(DataModuleMyOffice.ZConnectionMyOffice.Database);
  //DataModuleMyOffice.ZConnectionMyOffice.Database:=GIniHostname;
  DataModuleMyOffice.ZConnectionMyOffice.Password:=GIniPasswort;
  DataModuleMyOffice.ZConnectionMyOffice.Protocol:=GIniProtocol;
  DataModuleMyOffice.ZConnectionMyOffice.User:=GIniUser;
  DataModuleMyOffice.ZConnectionMyOffice.LoginPrompt:=GIniLoginPrompt;
  DataModuleMyOffice.ZConnectionMyOffice.connect;
  GBenutzer:=GIniUser;
  GOffeneFenster:=0;
  GTopSchritte:=26;GLeftSchritte:=9;
  //---------------------Benutzer Eistellungen laden end--------
  QueryEinstelungenBenutzer.close;
  QueryEinstelungenBenutzer.SQL.Clear;
  QueryEinstelungenBenutzer.SQL.Add('Select * FROM Benutzer where Benutzer ="'+GBenutzer+'"'); //noch ist Benutzer Standard
  try
    QueryEinstelungenBenutzer.Open
  except
  end;
  if QueryEinstelungenBenutzer.FieldByName('Projektneu').Asinteger = 1 then UProjektneu:=True Else UProjektneu:=False;
  UProjektkopieren:=False;
  if QueryEinstelungenBenutzer.FieldByName('Projektaendern').Asinteger = 1 then UProjektaendern:=True  Else  UProjektaendern:=False;
  if QueryEinstelungenBenutzer.FieldByName('Projektloeschen').Asinteger = 1 then UProjektloeschen:=True Else UProjektloeschen:=False;
  FFensterdesignNr:=QueryEinstelungenBenutzer.FieldByName('FensterdesignNr').Asinteger;
  QueryEinstelungenBenutzer.Close;
  //----------------------- FFensterdesign laden --------------
  QueryEinstelungenBenutzer.SQL.Clear;
  QueryEinstelungenBenutzer.SQL.Add('Select * FROM fensterdesign where Nr = '+inttostr(FFensterdesignNr));
  try QueryEinstelungenBenutzer.Open except end;

  GButtonDateinameNichtActiv:=QueryEinstelungenBenutzer.FieldByName('ButtonDateiNichtActive').AsString;
  GButtonDateinameActiv:=QueryEinstelungenBenutzer.FieldByName('ButtonDateiActive').AsString;
  GButtonFarbeActive:=QueryEinstelungenBenutzer.FieldByName('ButtonFarbeActive').AsString;
  GButtonFarbeNichtActive:=QueryEinstelungenBenutzer.FieldByName('ButtonFarbeNichtActive').AsString;
  GButtonFeldActiv:=QueryEinstelungenBenutzer.FieldByName('ButtonFeldActive').Asinteger;
  GButtonFeldNichtActiv:=QueryEinstelungenBenutzer.FieldByName('ButtonFeldNichtActive').Asinteger;
  GButtonFontColorActiv :=QueryEinstelungenBenutzer.FieldByName('ButtonFontColorActive').AsString;
  GButtonFontColorNichtActiv:=QueryEinstelungenBenutzer.FieldByName('ButtonFontColorNichtActive').AsString;

  GCascade:=QueryEinstelungenBenutzer.FieldByName('Cascad').Asinteger;
  GAnimationsgeschwindigkeit:=QueryEinstelungenBenutzer.FieldByName('Animationsgeschwindigkeit').Asinteger;
  QueryEinstelungenBenutzer.Close;
  //---------------------Allgemeine Eistellungen laden end--------
  QueryAllgemeineEinstellungen.close;
  QueryAllgemeineEinstellungen.SQL.Clear;
  QueryAllgemeineEinstellungen.SQL.Add('Select * FROM EinstellungenAllgemein');
  try
    QueryAllgemeineEinstellungen.Open
  except
  end;
  GVoreinstellungMwst:=QueryAllgemeineEinstellungen.FieldByName('MwSt').AsFloat;//GMwst:=16;

  //änderung kommt in benutzereinstelung  wobei die einstellung benutzt wird, die in DB festgestellt(abgespeichert wurde)
  GBmpLaden:=False;
  {GButtonDateinameNichtActiv:=QueryAllgemeineEinstellungen.FieldByName('ButtonDateiNichtActive').AsString;
  GButtonDateinameActiv:=QueryAllgemeineEinstellungen.FieldByName('ButtonDateiActive').AsString;
  GButtonFarbeActive:=QueryAllgemeineEinstellungen.FieldByName('ButtonFarbeActive').AsString;
  GButtonFarbeNichtActive:=QueryAllgemeineEinstellungen.FieldByName('ButtonFarbeNichtActive').AsString;
  GButtonFeldActiv:=QueryAllgemeineEinstellungen.FieldByName('ButtonFeldActive').Asinteger;
  GButtonFeldNichtActiv:=QueryAllgemeineEinstellungen.FieldByName('ButtonFeldNichtActive').Asinteger;
  GButtonFontColorActiv :=QueryAllgemeineEinstellungen.FieldByName('ButtonFontColorActive').AsString;
  GButtonFontColorNichtActiv:=QueryAllgemeineEinstellungen.FieldByName('ButtonFontColorNichtActive').AsString;}
  //änderung kommt in benutzereinstelung ENDE

  GEinheitGewicht:=QueryAllgemeineEinstellungen.FieldByName('Einheitgewicht').AsString;
  GEinheitZahl1:=QueryAllgemeineEinstellungen.FieldByName('EinheitZahl1').AsString;
  GEinheitZahl2:=QueryAllgemeineEinstellungen.FieldByName('EinheitZahl2').AsString;
  GEinheitZahl3:=QueryAllgemeineEinstellungen.FieldByName('EinheitZahl3').AsString;
  GZahl1:=QueryAllgemeineEinstellungen.FieldByName('NameZahl1').AsString;
  GZahl2:=QueryAllgemeineEinstellungen.FieldByName('NameZahl2').AsString;
  GZahl3:=QueryAllgemeineEinstellungen.FieldByName('NameZahl3').AsString;
  GName1:=QueryAllgemeineEinstellungen.FieldByName('Name1').AsString;
  GName2:=QueryAllgemeineEinstellungen.FieldByName('Name2').AsString;
  GName3:=QueryAllgemeineEinstellungen.FieldByName('Name3').AsString;
  GLandNr:=QueryAllgemeineEinstellungen.FieldByName('LandNr').Asinteger;
  {GOffeneFenster:=0;
  GCascade:=1;
  GTopSchritte:=26;GLeftSchritte:=9;}
  QueryAllgemeineEinstellungen.close;
  //---------------------Allgemeine Eistellungen laden end--------



 //UDBPaht:='C:\DB'
  {UZeiger:=0;
  GKopfFusstext:='';G_Artikelgruppe:='';
  GProjekt_Nr:=0;GBeziehungs_Nr:=0;GModulart_Nr:=0;
  modulart:='(modulart <> "") ';
  ButtonProjekt.Enabled:=UProjektneu;}
  QueryEinstellungModulart1.close;
  QueryEinstellungModulart1.SQL.Clear;
  QueryEinstellungModulart1.SQL.Add('Select * FROM EinstellungModulart WHERE Benutzer = "Standard" or Benutzer = "'+GBenutzer+'"'+' Order by Nr');
  //Benutzer: in den Benutzereinstelungen ist angegeben, ob standart und Benutzer oder nur benuter; prüfen, das keine doppelten Modulart geladen wird.
  try
    QueryEinstellungModulart1.Open
  except
  end;
  modulArtListe:=TStringList.Create;
  modulArtListe.add('Alle');
  modulArtListe.add('Projekt');
  for i:=1 to QueryEinstellungModulart1.RecordCount do
  begin
   case I of
    1: begin ButtonListe1.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe1.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe1.Enabled:=False;
         M1.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M1.aendern:=False Else M1.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M1.loeschen:=False Else M1.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M1.kopieren:=False Else M1.kopieren:=True;
       end;
    2: begin ButtonListe2.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe2.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe2.Enabled:=False;
         M2.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M2.aendern:=False Else M2.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M2.loeschen:=False Else M2.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M2.kopieren:=False Else M2.kopieren:=True;
       end;
    3: begin ButtonListe3.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe3.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe3.Enabled:=False;
         M3.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M3.aendern:=False Else M3.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M3.loeschen:=False Else M3.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M3.kopieren:=False Else M3.kopieren:=True;
       end;
    4: begin ButtonListe4.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe4.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe4.Enabled:=False;
         M4.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M4.aendern:=False Else M4.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M4.loeschen:=False Else M4.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M4.kopieren:=False Else M4.kopieren:=True;
       end;
    5: begin ButtonListe5.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe5.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe5.Enabled:=False;
         M5.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M5.aendern:=False Else M5.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M5.loeschen:=False Else M5.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M5.kopieren:=False Else M5.kopieren:=True;
       end;
    6: begin ButtonListe6.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe6.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe6.Enabled:=False;
         M6.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M6.aendern:=False Else M6.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M6.loeschen:=False Else M6.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M6.kopieren:=False Else M6.kopieren:=True;
       end;
    7: begin ButtonListe7.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe7.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe7.Enabled:=False;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M7.aendern:=False Else M7.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M7.loeschen:=False Else M7.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M7.kopieren:=False Else M7.kopieren:=True;
       end;
    8: begin ButtonListe8.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe8.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe8.Enabled:=False;
         M8.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M8.aendern:=False Else M8.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M8.loeschen:=False Else M8.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M8.kopieren:=False Else M8.kopieren:=True;
       end;
    9: begin ButtonListe9.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe9.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe9.Enabled:=False;
         M9.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M9.aendern:=False Else M9.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M9.loeschen:=False Else M9.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M9.kopieren:=False Else M9.kopieren:=True;
       end;
    10: begin ButtonListe10.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe10.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe10.Enabled:=False;
         M10.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M10.aendern:=False Else M10.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M10.loeschen:=False Else M10.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M10.kopieren:=False Else M10.kopieren:=True;
       end;
    11: begin ButtonListe11.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe11.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe11.Enabled:=False;
         M11.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M11.aendern:=False Else M11.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M11.loeschen:=False Else M11.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M11.kopieren:=False Else M11.kopieren:=True;
       end;
    12: begin ButtonListe12.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe12.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe12.Enabled:=False;
         M12.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M12.aendern:=False Else M12.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M12.loeschen:=False Else M12.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M12.kopieren:=False Else M12.kopieren:=True;
       end;
    13: begin ButtonListe13.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe13.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe13.Enabled:=False;
         M13.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M13.aendern:=False Else M13.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M13.loeschen:=False Else M13.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M13.kopieren:=False Else M13.kopieren:=True;
       end;
    14: begin ButtonListe14.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe14.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe14.Enabled:=False;
         M14.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M14.aendern:=False Else M14.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M14.loeschen:=False Else M14.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M14.kopieren:=False Else M14.kopieren:=True;
       end;
    15: begin ButtonListe15.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe15.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe15.Enabled:=False;
         M15.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M15.aendern:=False Else M15.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M15.loeschen:=False Else M15.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M15.kopieren:=False Else M15.kopieren:=True;
       end;
    16: begin ButtonListe16.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe16.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe16.Enabled:=False;
         M16.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M16.aendern:=False Else M16.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M16.loeschen:=False Else M16.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M16.kopieren:=False Else M16.kopieren:=True;
       end;
    17: begin ButtonListe17.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe17.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe17.Enabled:=False;
         M17.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M17.aendern:=False Else M17.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M17.loeschen:=False Else M17.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M17.kopieren:=False Else M17.kopieren:=True;
       end;
    18: begin ButtonListe18.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe18.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe18.Enabled:=False;
         M18.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M18.aendern:=False Else M18.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M18.loeschen:=False Else M18.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M18.kopieren:=False Else M18.kopieren:=True;
       end;
    19: begin ButtonListe19.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe19.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe19.Enabled:=False;
         M19.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M19.aendern:=False Else M19.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M19.loeschen:=False Else M19.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M19.kopieren:=False Else M19.kopieren:=True;
       end;
    20: begin ButtonListe20.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe20.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe20.Enabled:=False;
         M2.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M2.aendern:=False Else M2.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M2.loeschen:=False Else M2.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M2.kopieren:=False Else M2.kopieren:=True;
       end;
    21: begin ButtonListe21.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe21.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe21.Enabled:=False;
         M21.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M21.aendern:=False Else M21.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M21.loeschen:=False Else M21.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M21.kopieren:=False Else M21.kopieren:=True;
       end;
    22: begin ButtonListe22.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe22.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe22.Enabled:=False;
         M22.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M22.aendern:=False Else M22.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M22.loeschen:=False Else M22.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M22.kopieren:=False Else M22.kopieren:=True;
       end;
    23: begin ButtonListe23.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe23.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe23.Enabled:=False;
         M23.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M23.aendern:=False Else M23.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M23.loeschen:=False Else M23.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M23.kopieren:=False Else M23.kopieren:=True;
       end;
    24: begin ButtonListe24.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe24.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe24.Enabled:=False;
         M24.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M24.aendern:=False Else M24.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M24.loeschen:=False Else M24.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M24.kopieren:=False Else M24.kopieren:=True;
       end;
    25: begin ButtonListe25.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe25.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe25.Enabled:=False;
         M25.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M25.aendern:=False Else M25.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M25.loeschen:=False Else M25.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M25.kopieren:=False Else M25.kopieren:=True;
       end;
    26: begin ButtonListe26.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe26.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe26.Enabled:=False;
         M26.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M26.aendern:=False Else M26.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M26.loeschen:=False Else M26.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M26.kopieren:=False Else M26.kopieren:=True;
       end;
    27: begin ButtonListe27.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe27.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe27.Enabled:=False;
         M27.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M27.aendern:=False Else M27.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M27.loeschen:=False Else M27.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M27.kopieren:=False Else M27.kopieren:=True;
       end;
    28: begin ButtonListe28.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe28.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe28.Enabled:=False;
         M28.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M28.aendern:=False Else M28.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M28.loeschen:=False Else M28.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M28.kopieren:=False Else M28.kopieren:=True;
       end;
    29: begin ButtonListe29.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe29.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe29.Enabled:=False;
         M29.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M29.aendern:=False Else M29.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M29.loeschen:=False Else M29.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M29.kopieren:=False Else M29.kopieren:=True;
       end;
    30: begin ButtonListe30.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe30.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe30.Enabled:=False;
         M30.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M30.aendern:=False Else M30.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M30.loeschen:=False Else M30.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M30.kopieren:=False Else M30.kopieren:=True;
       end;
    31: begin ButtonListe31.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe31.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe31.Enabled:=False;
         M31.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M31.aendern:=False Else M31.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M31.loeschen:=False Else M31.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M31.kopieren:=False Else M31.kopieren:=True;
       end;
    32: begin ButtonListe32.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe32.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe32.Enabled:=False;
         M32.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M32.aendern:=False Else M32.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M32.loeschen:=False Else M32.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M32.kopieren:=False Else M32.kopieren:=True;
       end;
    33: begin ButtonListe33.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe33.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe33.Enabled:=False;
         M33.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M33.aendern:=False Else M33.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M33.loeschen:=False Else M33.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M33.kopieren:=False Else M33.kopieren:=True;
       end;
    34: begin ButtonListe34.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe34.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe34.Enabled:=False;
         M34.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M34.aendern:=False Else M34.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M34.loeschen:=False Else M34.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M34.kopieren:=False Else M34.kopieren:=True;
       end;
    35: begin ButtonListe35.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe35.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe35.Enabled:=False;
         M35.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M35.aendern:=False Else M35.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M35.loeschen:=False Else M35.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M35.kopieren:=False Else M35.kopieren:=True;
       end;
    36: begin ButtonListe36.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe36.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe36.Enabled:=False;
         M36.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M36.aendern:=False Else M36.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M36.loeschen:=False Else M36.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M36.kopieren:=False Else M36.kopieren:=True;
       end;
    37: begin ButtonListe37.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe37.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe37.Enabled:=False;
         M37.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M37.aendern:=False Else M37.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M37.loeschen:=False Else M37.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M37.kopieren:=False Else M37.kopieren:=True;
       end;
    38: begin ButtonListe38.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe38.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe38.Enabled:=False;
         M38.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M38.aendern:=False Else M38.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M38.loeschen:=False Else M38.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M38.kopieren:=False Else M38.kopieren:=True;
       end;
    39: begin ButtonListe39.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe39.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe39.Enabled:=False;
         M39.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M39.aendern:=False Else M39.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M39.loeschen:=False Else M39.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M39.kopieren:=False Else M39.kopieren:=True;
       end;
    40: begin ButtonListe40.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe40.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe40.Enabled:=False;
         M4.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M4.aendern:=False Else M4.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M4.loeschen:=False Else M4.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M4.kopieren:=False Else M4.kopieren:=True;
       end;
    41: begin ButtonListe41.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe41.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe41.Enabled:=False;
         M41.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M41.aendern:=False Else M41.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M41.loeschen:=False Else M41.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M41.kopieren:=False Else M41.kopieren:=True;
       end;
    42: begin ButtonListe42.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe42.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe42.Enabled:=False;
         M42.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M42.aendern:=False Else M42.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M42.loeschen:=False Else M42.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M42.kopieren:=False Else M42.kopieren:=True;
       end;
    43: begin ButtonListe43.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe43.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe43.Enabled:=False;
         M43.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M43.aendern:=False Else M43.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M43.loeschen:=False Else M43.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M43.kopieren:=False Else M43.kopieren:=True;
       end;
    44: begin ButtonListe45.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe44.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe44.Enabled:=False;
         M44.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M44.aendern:=False Else M44.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M44.loeschen:=False Else M44.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M44.kopieren:=False Else M44.kopieren:=True;
       end;
    45: begin ButtonListe46.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe45.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe45.Enabled:=False;
         M45.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M45.aendern:=False Else M45.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M45.loeschen:=False Else M45.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M45.kopieren:=False Else M45.kopieren:=True;
       end;
    46: begin ButtonListe46.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe46.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe46.Enabled:=False;
         M46.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M46.aendern:=False Else M46.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M46.loeschen:=False Else M46.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M46.kopieren:=False Else M46.kopieren:=True;
       end;
    47: begin ButtonListe47.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe47.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe47.Enabled:=False;
         M47.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M47.aendern:=False Else M47.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M47.loeschen:=False Else M47.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M47.kopieren:=False Else M47.kopieren:=True;
       end;
    48: begin ButtonListe48.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe48.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe48.Enabled:=False;
         M48.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M48.aendern:=False Else M48.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M48.loeschen:=False Else M48.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M48.kopieren:=False Else M48.kopieren:=True;
       end;
    49: begin ButtonListe49.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe49.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe49.Enabled:=False;
         M49.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M49.aendern:=False Else M49.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M49.loeschen:=False Else M49.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M49.kopieren:=False Else M49.kopieren:=True;
       end;
    50: begin ButtonListe50.Caption := QueryEinstellungModulart1.FieldByName('Modulart').AsString; ButtonListe50.Visible:=True; if QueryEinstellungModulart1.FieldByName('Modulneu').AsInteger <> 1 then ButtonListe50.Enabled:=False;
         M50.Modulname:=QueryEinstellungModulart1.FieldByName('Modulart').AsString;
         if QueryEinstellungModulart1.FieldByName('Modulaendern').Asinteger <> 1 then M50.aendern:=False Else M50.aendern:=True;
         if QueryEinstellungModulart1.FieldByName('Modulloeschen').Asinteger <> 1 then M50.loeschen:=False Else M50.loeschen:=True;
         if QueryEinstellungModulart1.FieldByName('Modulkopieren').Asinteger <> 1 then M50.kopieren:=False Else M50.kopieren:=True;
       end;
    end;
    modulArtListe.add(QueryEinstellungModulart1.FieldByName('Modulart').AsString);
    QueryEinstellungModulart1.next;
 end;
 QueryEinstellungModulart1.close;


 DecodeDate(now,Year, Month, Day);
 s1ComboZeitbereichJahr.itemindex:=Year - 2000;
 //s1ComboZeitbereichJahr.text:=s1ComboZeitbereichJahr.items[Year - 2000];
 s1ComboZeitbereichMonat.itemindex:=Month - 1;
{
 for i := 0 to QueryModule.FieldCount - 1 do
 begin
   with QueryModule.Fields[i] do
     if FieldName <> '' then
     begin
       showmessage(QueryModule.Fields[i].FieldName);
       ItemSortieren := TMenuItem.Create(Self);
       ItemSortieren.Caption :=(QueryModule.Fields[i].FieldName);
       PopupMenuSortieren.Items.Add(ItemSortieren);
       PopupMenuSortieren.Items[i].OnClick:=PopupMenuSortierenClick;
     end;
   end;
 }
 ComboBoxModule.Items:=modulArtListe;ComboBoxModule.text:=ComboBoxModule.items[0];
 modulname:='';modulAdressName:='';modulVerbindungsNr:='';modulprojektnr:='';
 modulBearbeiter:='';modulLeiter:='';modulOrder:='Nr';
 GZeiger:=0;GZeigerNeu:=False;
 Top:=0;Left:=0;
 FormCounter:=0;
 ModulDBZeigen;
 ActiveControl:=DBGridModule;
end;
// Liste zeigen-----------------------------------------------------------------

procedure TFormPlanlos.ModulDBZeigen;
  var sqltext:string;
begin
 modulErfassungsdatum:=bereichDatum(Zeitbereich,datumAusKalender);
 sqltext:=('SELECT * FROM  Module WHERE '+
  modulart + modulname + modulAdressName + modulVerbindungsNr + modulprojektnr +
  modulErfassungsdatum + modulBearbeiter + modulLeiter + ' Order By '+modulOrder);
 //MessageDlg(sqltext, mtInformation,[mbOk], 0);
 QueryModule.close;
 QueryModule.sql.Clear;
 QueryModule.sql.add(sqltext);
 try
   QueryModule.open;
 finally
 end;
end;

procedure TFormPlanlos.ModulDBZeigenMitZeiger(Zeiger:longint);
var weiter:Boolean;
begin
  weiter:=True;
  ModulDBZeigen;
  UmodulsrollAn:=False;
  if zeiger > 0  then
  begin
    QueryModule.DisableControls;
    try
    QueryModule.First; { Cursor zum ersten Datensatz, wodurch EOF auf False gesetzt wird }
    while not QueryModule.EOF  and weiter do { wiederholen, bis EOF True ist }
    begin
      if Zeiger<>QueryModule.FieldByName('Nr').AsInteger then QueryModule.Next
      else  weiter:=False;
    end;
    finally
        QueryModule.EnableControls;
    end;
  end;
  UmodulsrollAn:=True;
  Modulbuttonszeigen;
  DBGridModule.setFocus;
end;

procedure TFormPlanlos.ButtonModuleEndeClick(Sender: TObject);
begin
  close;
end;
//Filter Module----------------------------------------------------------------

procedure TFormPlanlos.ComboBoxModuleChange(Sender: TObject);
begin
  modulArt:='(modulart = "' + ComboBoxModule.text +'") ';
  if ComboBoxModule.Itemindex = 0 then modulart:='(modulart <> "") ';
  ModulDBZeigenMitZeiger(UZeiger);
end;

procedure TFormPlanlos.RadioButtonFAClick(Sender: TObject);
begin
  ButtonFN.Visible:=False;
  ButtonFilterAdressen.Visible:=False;
  EditFVN.Visible:=False;
  ButtonFilterProjekte.Visible:=False;
  modulname:='';modulAdressName:='';modulVerbindungsNr:='';modulprojektnr:='';
  ModulDBZeigenMitZeiger(UZeiger);
end;
//Filter Modul Name
procedure TFormPlanlos.RadioButtonNameClick(Sender: TObject);
begin
   ButtonFN.Visible:=True;
   ButtonFilterAdressen.Visible:=False;
   EditFVN.Visible:=False;
   ButtonFilterProjekte.Visible:=False;
   modulname:='';modulAdressName:='';modulVerbindungsNr:='';modulprojektnr:='';
   if ButtonFN.Caption= '' Then ButtonFNClick(Self)
   else begin
    modulname:='and (Bezeichnung = "'+ ButtonFN.Caption +'") ';
    ModulDBZeigenMitZeiger(UZeiger);
   end;
end;

procedure TFormPlanlos.ButtonFNClick(Sender: TObject);
   var Fnr:integer;Par:TStringList{;SQLSelect,SQLFrom,SQLWhere,SQLOrder:string};
       Fname:string;
begin //Fenster1
  Par:=TStringList.Create;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  Par:=TForm1.an(DammiForm,ButtonFN.Caption,GModulart,GBenutzer,1);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  Fnr:=strtoint(Par[0]);Fname:=Par[1];
  if Fname <> '' then begin
    ButtonFN.Caption:=Fname;
    modulname:='';modulAdressName:='';modulVerbindungsNr:='';modulprojektnr:='';
    modulname:='and (Bezeichnung = "'+ Fname +'") ';
    ModulDBZeigenMitZeiger(UZeiger);
  end;
  Par.Free;
  DBGridModule.setFocus;
end;

//Filter Module Firma
procedure TFormPlanlos.RadioButtonFANClick(Sender: TObject);
begin
  ButtonFN.Visible:=False;
  ButtonFilterAdressen.Visible:=True;
  EditFVN.Visible:=False;
  ButtonFilterProjekte.Visible:=False;
  modulname:='';modulAdressName:='';modulVerbindungsNr:='';modulprojektnr:='';
  if ButtonFilterAdressen.Caption= '' Then ButtonFilterAdressenClick(Self)
  else begin modulname:='';modulAdressName:='';modulVerbindungsNr:='';modulprojektnr:='';
    modulAdressName:='and (AdressName = "'+ ButtonFN.Caption +'") ';
    ModulDBZeigenMitZeiger(UZeiger);
  end;
end;

procedure TFormPlanlos.ButtonFilterAdressenClick(Sender: TObject);
  var Fnr:integer;Par:TStringList{;SQLSelect,SQLFrom,SQLWhere,SQLOrder:string};
      Fname:string;
begin //Fenster2
  Par:=TStringList.Create;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  Par:=TForm1.an(FormAdresse,ButtonFilterAdressen.Caption,GModulart,GBenutzer,2);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  Fnr:=strtoint(Par[0]);Fname:=Par[1];
  if Fname <> '' then begin
    ButtonFilterAdressen.Caption:=Fname;
    modulname:='';modulAdressName:='';modulVerbindungsNr:='';modulprojektnr:='';
    modulAdressName:='and (AdressName = "'+ Fname +'") ';
    ModulDBZeigenMitZeiger(UZeiger);
  end;
  Par.Free;
  DBGridModule.setFocus;
end;

//Filter Nr------
procedure TFormPlanlos.RadioButtonFilterNrClick(Sender: TObject);
begin
  ButtonFN.Visible:=False;
  ButtonFilterAdressen.Visible:=False;
  EditFVN.Visible:=True;
  ButtonFilterProjekte.Visible:=False;
  modulname:='';modulAdressName:='';modulVerbindungsNr:='';modulprojektnr:='';
  if EditFVN.text= '' Then EditFVN.setFocus
  else begin
    modulAdressName:='and (Nr = "'+ EditFVN.text +'") ';
    ModulDBZeigenMitZeiger(UZeiger);
  end;
end;

procedure TFormPlanlos.EditFVNKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //if Key = VK_RETURN then begin
   { modulname:='';modulAdressName:='';modulVerbindungsNr:='';modulprojektnr:='';
    modulAdressName:='and Nr = "'+ EditFVN.text +'" ';
    ModulDBZeigen; }
  //end;
end;
//Filter Projekt-----
procedure TFormPlanlos.RadioButtonFPNRClick(Sender: TObject);
begin
  ButtonFN.Visible:=False;
  ButtonFilterAdressen.Visible:=False;
  EditFVN.Visible:=False;
  ButtonFilterProjekte.Visible:=True;
  modulname:='';modulAdressName:='';modulVerbindungsNr:='';modulprojektnr:='';
  if ButtonFilterProjekte.Caption= '' Then ButtonFilterProjekteClick(Self)
  else begin
    modulprojektnr:='and (ProjektName = "'+ ButtonFilterProjekte.Caption +'") ';
    ModulDBZeigenMitZeiger(UZeiger);
  end;
end;

procedure TFormPlanlos.ButtonFilterProjekteClick(Sender: TObject);
  var Fnr:integer;Par:TStringList{;SQLSelect,SQLFrom,SQLWhere,SQLOrder:string};
      Fname:string;
begin //Fenster3
  Par:=TStringList.Create;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  Par:=TForm1.an(FormProjekte,ButtonFilterProjekte.Caption,GModulart,GBenutzer,3);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  Fnr:=strtoint(Par[0]);Fname:=Par[1];
  if Fname <> '' then begin
    ButtonFilterProjekte.Caption:=Fname;
    modulname:='';modulAdressName:='';modulVerbindungsNr:='';modulprojektnr:='';
    modulAdressName:='and (ProjektName = "'+ Fname +'") ';
    ModulDBZeigenMitZeiger(UZeiger);
  end;
  Par.Free;
  DBGridModule.setFocus;
end;
// Filter Personen---------------------------------------------------------------
procedure TFormPlanlos.RadioButtonPAlleClick(Sender: TObject);
begin
  ButtonFPB.Visible:=False;ButtonFPL.Visible:=False;
  modulBearbeiter:='';modulLeiter:='';
  ModulDBZeigenMitZeiger(UZeiger);
end;

// Filter Bearbeiter---
procedure TFormPlanlos.RadioButtonPBClick(Sender: TObject);
begin
  ButtonFPB.Visible:=True;ButtonFPL.Visible:=False;
  modulBearbeiter:='';modulLeiter:='';
  if ButtonFPB.Caption= '' Then ButtonFPBClick(Self)
  else begin
    modulBearbeiter:='and (Bearbeiter = "'+ ButtonFPB.Caption +'") ';
    ModulDBZeigenMitZeiger(UZeiger);
  end;
end;

procedure TFormPlanlos.ButtonFPBClick(Sender: TObject);
  var Fnr:integer;Par:TStringList{;SQLSelect,SQLFrom,SQLWhere,SQLOrder:string};
      Fname:string;
begin  //Fenster 4
  Par:=TStringList.Create;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  Par:=TForm1.an(FormAdresse,ButtonFPB.Caption,GModulart,GBenutzer,4);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  Fnr:=strtoint(Par[0]);Fname:=Par[1];
  if Fname <> '' then begin
    ButtonFPB.Caption:=Fname;
    modulBearbeiter:='';modulLeiter:='';
    modulBearbeiter:='and (Bearbeiter = "'+ Fname +'") ';
    ModulDBZeigenMitZeiger(UZeiger);
  end;
  Par.Free;
  DBGridModule.setFocus;
end;
// Filter Leiter---
procedure TFormPlanlos.RadioButtonPLClick(Sender: TObject);
begin
  ButtonFPB.Visible:=False;ButtonFPL.Visible:=True;
  modulBearbeiter:='';modulLeiter:='';
  if ButtonFPL.Caption= '' Then ButtonFPLClick(Self)
  else begin
    modulLeiter:='and (Gruppierung = "'+ ButtonFPL.Caption +'") ';
    ModulDBZeigenMitZeiger(UZeiger);
  end;
end;

procedure TFormPlanlos.ButtonFPLClick(Sender: TObject);
 var Fnr:integer;Par:TStringList{;SQLSelect,SQLFrom,SQLWhere,SQLOrder:string};
     Fname:string;
begin //Fenster5
  Par:=TStringList.Create;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  Par:=TForm1.an(FormGruppierung,ButtonFPB.Caption,GModulart,GBenutzer,5);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  Fnr:=strtoint(Par[0]);Fname:=Par[1];
  if Fname <> '' then begin
    ButtonFPL.Caption:=Fname;
    modulBearbeiter:='';modulLeiter:='';
    modulLeiter:='and (Gruppierung = "'+ Fname +'") ';
    ModulDBZeigenMitZeiger(UZeiger);
  end;
  Par.Free;
  DBGridModule.setFocus;

end;
//aus der Liste ändern------------------------------------------------------------------
procedure TFormPlanlos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [ssShift] then begin
    if Key = 27 then ButtonModuleEndeClick(Self);
    if Key = VK_F3 then  Showmessage(QueryModule.SQL.Strings[0]);
  end Else begin
    if Key = VK_F5 then if UMkopieren then ButtonkopierenClick(Self);
    if Key = VK_F8 then if UMloeschen then ButtonLoeschenClick(Self);
    if Key = VK_F6 then if UMaendern then DBGridModuleDblClick(Self);
    if Key = VK_F7 then sortierenClick(Self);
    if Key = VK_F10 then ButtonModuleEndeClick(Self);
    if Key = VK_Return then if ActiveControl.Name=DBGridModule.Name then DBGridModuleDblClick(Self);
  end;
end;

procedure TFormPlanlos.DBGridModuleDblClick(Sender: TObject);
begin
  //PanelTastatur.Color:=clGray;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  GModulart:=QueryModule.FieldByName('Modulart').AsString;
  GZeiger:= QueryModule.Fields[0].Value;
  QueryModule.close;
  FormPlanlos.GzeigerNeu:=False;
  if GModulArt = 'Projekt' then FormProjekte.Showmodal
  Else begin FormPlanlos.Visible:=False;FormArtikelSammlung.Showmodal;FormPlanlos.Visible:=True; end;
  UZeiger:=GZeiger;GZeiger:=0;
  ModulDBZeigenMitZeiger(UZeiger);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  //PanelTastatur.Color:=clYellow;
end;

procedure TFormPlanlos.ButtonAendernClick(Sender: TObject);
begin
  DBGridModuleDblClick(Self);
end;
//Buttons Neu ------------------------------------------------------------------

{procedure TFormPlanlos.Button1Click(Sender: TObject);
var FelderWennNeu,SQLFrom,FelderWennNeuValue:String;
begin
  FelderWennNeu:='Modulart,Erfassungsdatum,LetzteBearbeitung';SQLFrom:='Module';
  FelderWennNeuValue:= '"Projekt",'+'"'+Datetostr(Now)+'","'+Datetostr(Now)+'"';
  PanelTastatur.Color:=clGray;
  QueryModule.close;
  //showmessage(inttostr(IEinstellungsNr)+FelderWennNeu);
  if FelderWennNeu =''then FormPlanlos.Gzeiger:=DataModuleDB.DatensatzNeu(SQLFrom)
  else FormPlanlos.Gzeiger:=DataModuleDB.DatensatzNeuMit(SQLFrom,FelderWennNeu,FelderWennNeuValue);
  FormPlanlos.GzeigerNeu:=True;
  //FormMaske.Showmodal;
  FormProjekte.Showmodal;
  if GZeiger<> 0 then ModulDBZeigenMitZeiger(GZeiger);
  PanelTastatur.Color:=clYellow;
end;

procedure TFormPlanlos.Button2Click(Sender: TObject);
begin
  PanelTastatur.Color:=clGray;
  GZeiger:=0;
  FormArtikelSammlung.ShowModal;
  if GZeiger<> 0 then ModulDBZeigenMitZeiger(GZeiger);
  PanelTastatur.Color:=clYellow;
end;}
//Stammdaten ------------------------------------------------------------------

procedure TFormPlanlos.ButtonEinheitenClick(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(FormEinheit,'',GModulart,GBenutzer,31);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonArtikelClick(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(FormArtikel,'',GModulart,GBenutzer,32);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonArtikelGruppeClick(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(FormArtikelgruppe,'',GModulart,GBenutzer,33);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonModuleClick(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(Dammiform,'',GModulart,GBenutzer,34);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonProjekteClick(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(FormProjekte,'',GModulart,GBenutzer,35);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonKundenClick(Sender: TObject);
begin
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(FormAdresse,'',GModulart,GBenutzer,36);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonAdressenClick(Sender: TObject);
begin
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(FormAdresse,'',GModulart,GBenutzer,37);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonLieferantClick(Sender: TObject);
begin
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(FormAdresse,'',GModulart,GBenutzer,38);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonMitarbeiterClick(Sender: TObject);
begin
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(FormAdresse,'',GModulart,GBenutzer,39);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonKategorieClick(Sender: TObject);
begin
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(FormKategorie,'',GModulart,GBenutzer,40);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonTextbausteinClick(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(FormTextbaustein,'',GModulart,GBenutzer,81);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;
procedure TFormPlanlos.ButtonBenutzerClick(Sender: TObject);
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  TForm1.an(FormBenutzer,'',GModulart,GBenutzer,82);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonStuecklistenListeClick(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(FormStueckliste,'',GModulart,GBenutzer,83);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;
procedure TFormPlanlos.ButtonStuecklistenGruppeClick(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(FormStuecklistengruppe,'',GModulart,GBenutzer,84);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;
procedure TFormPlanlos.ButtonStuecklistenArtikelClick(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(Dammiform,'',GModulart,GBenutzer,85);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonModulStuecklistenartikelClick(
  Sender: TObject);
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(Dammiform,'',GModulart,GBenutzer,87);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;


//Einstellungen ------------------------------------------------------------------

procedure TFormPlanlos.ButtonForm1Click(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(FormEinstellungForm1,'',GModulart,GBenutzer,41);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonEinstellungModulartClick(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(FormEinstellungModulart,'',GModulart,GBenutzer,42);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;
// Module ButtonListe -------------------------------------------------------------
procedure TFormPlanlos.ButtonListe1Click(Sender: TObject);
  var FFelderWennNeu,FFelderWennNeuValue:String;
begin
  if ButtonListe1.Focused then GModulart:=ButtonListe1.Caption;
  if ButtonListe2.Focused then GModulart:=ButtonListe2.Caption;
  if ButtonListe3.Focused then GModulart:=ButtonListe3.Caption;
  if ButtonListe4.Focused then GModulart:=ButtonListe4.Caption;
  if ButtonListe5.Focused then GModulart:=ButtonListe5.Caption;
  if ButtonListe6.Focused then GModulart:=ButtonListe6.Caption;
  if ButtonListe7.Focused then GModulart:=ButtonListe7.Caption;
  if ButtonListe8.Focused then GModulart:=ButtonListe8.Caption;
  if ButtonListe9.Focused then GModulart:=ButtonListe9.Caption;
  if ButtonListe10.Focused then GModulart:=ButtonListe10.Caption;
  if ButtonListe11.Focused then GModulart:=ButtonListe11.Caption;
  if ButtonListe12.Focused then GModulart:=ButtonListe12.Caption;
  if ButtonListe13.Focused then GModulart:=ButtonListe13.Caption;
  if ButtonListe14.Focused then GModulart:=ButtonListe14.Caption;
  if ButtonListe15.Focused then GModulart:=ButtonListe15.Caption;
  if ButtonListe16.Focused then GModulart:=ButtonListe16.Caption;
  if ButtonListe17.Focused then GModulart:=ButtonListe17.Caption;
  if ButtonListe18.Focused then GModulart:=ButtonListe18.Caption;
  if ButtonListe19.Focused then GModulart:=ButtonListe19.Caption;
  if ButtonListe20.Focused then GModulart:=ButtonListe20.Caption;
  if ButtonListe21.Focused then GModulart:=ButtonListe21.Caption;
  if ButtonListe22.Focused then GModulart:=ButtonListe22.Caption;
  if ButtonListe23.Focused then GModulart:=ButtonListe23.Caption;
  if ButtonListe24.Focused then GModulart:=ButtonListe24.Caption;
  if ButtonListe25.Focused then GModulart:=ButtonListe25.Caption;
  if ButtonListe26.Focused then GModulart:=ButtonListe26.Caption;
  if ButtonListe27.Focused then GModulart:=ButtonListe27.Caption;
  if ButtonListe28.Focused then GModulart:=ButtonListe28.Caption;
  if ButtonListe29.Focused then GModulart:=ButtonListe29.Caption;
  if ButtonListe30.Focused then GModulart:=ButtonListe30.Caption;
  if ButtonListe31.Focused then GModulart:=ButtonListe31.Caption;
  if ButtonListe32.Focused then GModulart:=ButtonListe32.Caption;
  if ButtonListe33.Focused then GModulart:=ButtonListe33.Caption;
  if ButtonListe34.Focused then GModulart:=ButtonListe34.Caption;
  if ButtonListe35.Focused then GModulart:=ButtonListe35.Caption;
  if ButtonListe36.Focused then GModulart:=ButtonListe36.Caption;
  if ButtonListe37.Focused then GModulart:=ButtonListe37.Caption;
  if ButtonListe38.Focused then GModulart:=ButtonListe38.Caption;
  if ButtonListe39.Focused then GModulart:=ButtonListe39.Caption;
  if ButtonListe40.Focused then GModulart:=ButtonListe40.Caption;
  if ButtonListe41.Focused then GModulart:=ButtonListe41.Caption;
  if ButtonListe42.Focused then GModulart:=ButtonListe42.Caption;
  if ButtonListe43.Focused then GModulart:=ButtonListe43.Caption;
  if ButtonListe44.Focused then GModulart:=ButtonListe44.Caption;
  if ButtonListe45.Focused then GModulart:=ButtonListe45.Caption;
  if ButtonListe46.Focused then GModulart:=ButtonListe46.Caption;
  if ButtonListe47.Focused then GModulart:=ButtonListe47.Caption;
  if ButtonListe48.Focused then GModulart:=ButtonListe48.Caption;
  if ButtonListe49.Focused then GModulart:=ButtonListe49.Caption;
  if ButtonListe50.Focused then GModulart:=ButtonListe50.Caption;
  //PanelTastatur.Color:=clGray;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  QueryModule.close;
  FormPlanlos.GzeigerNeu:=True;GZeiger:= 0;
  FormPlanlos.Visible:=False;
  FormArtikelSammlung.Showmodal;
  FormPlanlos.Visible:=True;
  UZeiger:=GZeiger;GZeiger:=0;
  ModulDBZeigenMitZeiger(UZeiger);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  //PanelTastatur.Color:=clYellow;
end;

procedure TFormPlanlos.ButtonProjektClick(Sender: TObject);
 var FelderWennNeu,SQLFrom,FelderWennNeuValue:String;
begin
  FelderWennNeu:='Modulart,Erfassungsdatum,LetzteBearbeitung';SQLFrom:='Module';
  FelderWennNeuValue:= '"Projekt",'+'"'+Datetostr(Now)+'","'+Datetostr(Now)+'"';
  //PanelTastatur.Color:=clGray;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  QueryModule.close;
  //showmessage(inttostr(IEinstellungsNr)+FelderWennNeu);
  if FelderWennNeu =''then FormPlanlos.Gzeiger:=DataModuleDB.DatensatzNeu(SQLFrom)
  else FormPlanlos.Gzeiger:=DataModuleDB.DatensatzNeuMit(SQLFrom,FelderWennNeu,FelderWennNeuValue);
  FormPlanlos.GzeigerNeu:=True;
  //FormMaske.Showmodal;
  FormProjekte.Showmodal;UZeiger:=GZeiger;GZeiger:=0;
  ModulDBZeigenMitZeiger(UZeiger);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  //PanelTastatur.Color:=clYellow;
end;

procedure TFormPlanlos.sortierenClick(Sender: TObject);
begin
  PopupMenuSortieren .Popup(Self.left+(Round(ClientWidth*0.55)+102),Self.Top+ClientHeight-(6 + (PopupMenuSortieren.Items.Count*17)));
  ModulDBZeigenMitZeiger(UZeiger);
end;

procedure TFormPlanlos.FormActivate(Sender: TObject);
var i,z:integer;
    FFensterNrtemp:integer;
begin
  GTest:=False;
  initial(Self);
  DataModuleMyOffice.CreateArtikelMemo;
  UPar:=TStringList.Create;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  //GButtonDateinameNichtActiv,GButtonDateinameActiv,GButtonFarbeActive,GButtonFarbeNichtActive:String;GButtonFeldActiv,GButtonFeldNichtActiv:Integer;
  //GButtonFontColorActiv,GButtonFontColorNichtActiv
  //PanelTastatur,ImageTastatur,LabelF5_p
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
{
 if GButtonFeldActiv = 0 then begin
   PanelTastatur.Visible:=False;
   ImageTastatur.Visible:=False;
   LabelF5.color:=stringtoColor('clBtnFace');
   LabelF6.color:=stringtoColor('clBtnFace');
   LabelF7.color:=stringtoColor('clBtnFace');
   LabelF8.color:=stringtoColor('clBtnFace');
   LabelF10.color:=stringtoColor('clBtnFace');
   LabelF5.Font.color:=stringtoColor('clBlack');
   LabelF6.Font.color:=stringtoColor('clBlack');
   LabelF7.Font.color:=stringtoColor('clBlack');
   LabelF8.Font.color:=stringtoColor('clBlack');
   LabelF10.Font.color:=stringtoColor('clBlack');
 end;
 if GButtonFeldActiv = 1 then begin
   PanelTastatur.Visible:=False;
   ImageTastatur.Visible:=True;
   ImageTastatur.Picture.LoadFromFile(GButtonDateinameActiv);
   LabelF5.color:=stringtoColor(GButtonFarbeActive);
   LabelF6.color:=stringtoColor(GButtonFarbeActive);
   LabelF7.color:=stringtoColor(GButtonFarbeActive);
   LabelF8.color:=stringtoColor(GButtonFarbeActive);
   LabelF10.color:=stringtoColor(GButtonFarbeActive);
   LabelF5.Font.color:=stringtoColor(GButtonFontColorActiv);
   LabelF6.Font.color:=stringtoColor(GButtonFontColorActiv);
   LabelF7.Font.color:=stringtoColor(GButtonFontColorActiv);
   LabelF8.Font.color:=stringtoColor(GButtonFontColorActiv);
   LabelF10.Font.color:=stringtoColor(GButtonFontColorActiv);
 end;
 if GButtonFeldActiv = 2 then begin
   PanelTastatur.Visible:=True;
   ImageTastatur.Visible:=False;
   PanelTastatur.color:=stringtoColor(GButtonFarbeActive);
   LabelF5_p.color:=stringtoColor(GButtonFarbeActive);
   LabelF6_p.color:=stringtoColor(GButtonFarbeActive);
   LabelF7_p.color:=stringtoColor(GButtonFarbeActive);
   LabelF8_p.color:=stringtoColor(GButtonFarbeActive);
   LabelF10_p.color:=stringtoColor(GButtonFarbeActive);
   LabelF5_p.Font.color:=stringtoColor(GButtonFontColorActiv);
   LabelF6_p.Font.color:=stringtoColor(GButtonFontColorActiv);
   LabelF7_p.Font.color:=stringtoColor(GButtonFontColorActiv);
   LabelF8_p.Font.color:=stringtoColor(GButtonFontColorActiv);
   LabelF10_p.Font.color:=stringtoColor(GButtonFontColorActiv);
 end;}
 z:=0;
 for i := 0 to QueryModule.FieldCount - 1 do
 begin
   with QueryModule.Fields[i] do
     if FieldName <> '' then
     begin
       //showmessage(QueryModule.Fields[i].FieldName);
       if QueryModule.Fields[i].IsBlob = False then
       begin
         ItemSortieren := TMenuItem.Create(Self);
         ItemSortieren.Caption :=(QueryModule.Fields[i].FieldName);
         PopupMenuSortieren.Items.Add(ItemSortieren);
         PopupMenuSortieren.Items[z].OnClick:=PopupMenuSortierenClick;
         z:=z+1;
       end;
     end;
   end;
  FFensterNrtemp:=211;
  While FFensterNrtemp < 231 do begin
    FormPlanlos.QueryEinstellungForm1L.close;
    FormPlanlos.QueryEinstellungForm1L.SQL.Clear;
    FormPlanlos.QueryEinstellungForm1L.SQL.Add('Select * FROM EinstellungForm1 WHERE FensterNr = ' + inttostr(FFensterNrtemp)+' AND Modulart = "'+GModulart+ '" AND Benutzer = "'+GBenutzer+'"');
    try  FormPlanlos.QueryEinstellungForm1L.Open except end;
    if FormPlanlos.QueryEinstellungForm1L.RecordCount < 1 Then
    begin
      FormPlanlos.QueryEinstellungForm1L.close;
      FormPlanlos.QueryEinstellungForm1L.SQL.Clear;
      FormPlanlos.QueryEinstellungForm1L.SQL.Add('Select * FROM EinstellungForm1 WHERE FensterNr = ' + inttostr(FFensterNrtemp)+' AND Modulart = "Standard" AND Benutzer = "'+GBenutzer+'"');
      try FormPlanlos.QueryEinstellungForm1L.Open except end;
      if FormPlanlos.QueryEinstellungForm1L.RecordCount < 1 Then
      begin
        FormPlanlos.QueryEinstellungForm1L.close;
        FormPlanlos.QueryEinstellungForm1L.SQL.Clear;
        FormPlanlos.QueryEinstellungForm1L.SQL.Add('Select * FROM EinstellungForm1 WHERE FensterNr = ' + inttostr(FFensterNrtemp)+' AND Modulart = "Standard" AND Benutzer = "Standard"');
        try FormPlanlos.QueryEinstellungForm1L.Open  except   end;
      end;
    end;
    if (FormPlanlos.QueryEinstellungForm1L.RecordCount = 1) and  (QueryEinstellungForm1L.FieldByName('Caption').AsString <>'') then
      begin
      if FFensterNrtemp=211 Then ButtonSelbst1.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=212 Then ButtonSelbst2.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=213 Then ButtonSelbst3.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=214 Then ButtonSelbst4.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=215 Then ButtonSelbst5.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=216 Then ButtonSelbst6.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=217 Then ButtonSelbst7.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=218 Then ButtonSelbst8.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=219 Then ButtonSelbst9.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=220 Then ButtonSelbst10.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=221 Then ButtonSelbst11.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=222 Then ButtonSelbst12.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=223 Then ButtonSelbst13.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=224 Then ButtonSelbst14.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=225 Then ButtonSelbst15.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=226 Then ButtonSelbst16.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=227 Then ButtonSelbst17.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
      if FFensterNrtemp=228 Then ButtonSelbst18.Caption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
    end;
    FormPlanlos.QueryEinstellungForm1L.close;
    FFensterNrtemp:=FFensterNrtemp+1;
  end;
end;

procedure TFormPlanlos.EditFVNKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   modulname:='';modulAdressName:='';modulVerbindungsNr:='';modulprojektnr:='';
   modulAdressName:='and (Nr = "'+ EditFVN.text +'") ';
   ModulDBZeigen;
end;


procedure TFormPlanlos.ButtonLoeschenClick(Sender: TObject);
var LoeschenJa:Boolean;
    s,FModulart:string;
    Fnr,FFNr:integer;
    i,i2:integer;
begin
  //PanelTastatur.Color:=clGray;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  //QueryModule.close;
  //showmessage(inttostr(IEinstellungsNr)+FelderWennNeu);
  //FormPlanlos.GzeigerNeu:=True;
  //FormMaske.Showmodal;
  //FormArtikelAussuchen.Showmodal;UZeiger:=GZeiger;GZeiger:=0;
  //ModulDBZeigenMitZeiger(UZeiger);
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  s:=QueryModule.FieldByName('Modulart').AsString;
  Fnr:=QueryModule.FieldByName('Nr').AsInteger;
  LoeschenJa:=Meldefenster.an(3,'Wollen sie wirklich das/die "'+s+'" löschen?','geben sie "Ja" ein zum Bestätigen:',s);
  //if r then Showmessage('mit Ja beantwortet') Else  Showmessage('abbruch');
  if LoeschenJa then begin
    FModulart:=QueryModule.FieldByName('Modulart').AsString;
    QueryModule.Close;
    if FModulart = 'Projekt' then begin
      if DataModuleMyOffice.GQuery2.active = True Then DataModuleMyOffice.FQuery2.active:=False;
      DataModuleMyOffice.GQuery2.SQL.Clear;
      DataModuleMyOffice.GQuery2.SQL.add('Select * From Module Where Projekt_Nr = '+inttostr(Fnr));
      DataModuleMyOffice.GQuery2.open;
      DataModuleMyOffice.GQuery2.first;
      for i := 0 to DataModuleMyOffice.GQuery2.RecordCount - 1 do begin
        if DataModuleMyOffice.GQuery1.active = True Then DataModuleMyOffice.GQuery1.active:=False;
        DataModuleMyOffice.GQuery1.SQL.Clear;
        DataModuleMyOffice.GQuery1.SQL.add('Select * From ArtikelListe Where Modul_Nr = '+inttostr(DataModuleMyOffice.GQuery2.FieldByName('Nr').AsInteger));
        //Showmessage('  1  '+'Select * From ArtikelListe Where Modul_Nr = '+inttostr(DataModuleMyOffice.FQuery2.FieldByName('Nr').AsInteger));
        DataModuleMyOffice.GQuery1.open;
        DataModuleMyOffice.GQuery1.first;
        for i2 := 0 to DataModuleMyOffice.GQuery1.RecordCount - 1 do begin
          if DataModuleMyOffice.GQuery1.FieldByName('ArtikelArt').AsString = 'Stueckliste' then
            DataModuleMyOffice.DSLoeschen('ArtikelListeS','StueckListen_Nr',DataModuleMyOffice.GQuery1.FieldByName('Nr').AsInteger);
          //Showmessage('  2  '+'ArtikelListeS'+'StueckListen_Nr'+inttostr(DataModuleMyOffice.FQuery1.FieldByName('Nr').AsInteger));
          DataModuleMyOffice.GQuery1.next;
        end;
        DataModuleMyOffice.DSLoeschen('ArtikelListe','Modul_Nr',DataModuleMyOffice.GQuery1.FieldByName('Nr').AsInteger);
        DataModuleMyOffice.GQuery2.next;
      end;
      DataModuleMyOffice.GQuery1.close;
      DataModuleMyOffice.GQuery2.close;
      DataModuleMyOffice.DSLoeschen('Module','Projekt_Nr',Fnr);
    end
    Else begin
      DataModuleMyOffice.LagerverwaltungListe(FModulart,Fnr,True);
      if DataModuleMyOffice.GQuery1.active = True Then DataModuleMyOffice.GQuery1.active:=False;
      DataModuleMyOffice.GQuery1.SQL.Clear;
      DataModuleMyOffice.GQuery1.SQL.add('Select * From ArtikelListe Where Modul_Nr = '+inttostr(Fnr));
      DataModuleMyOffice.GQuery1.open;
      DataModuleMyOffice.GQuery1.first;
      for i := 0 to DataModuleMyOffice.GQuery1.RecordCount - 1 do begin
        if DataModuleMyOffice.GQuery1.FieldByName('ArtikelArt').AsString = 'Stueckliste' then
          DataModuleMyOffice.DSLoeschen('ArtikelListeS','StueckListen_Nr',DataModuleMyOffice.GQuery1.FieldByName('Nr').AsInteger);
        DataModuleMyOffice.GQuery1.next;
      end;
      DataModuleMyOffice.GQuery1.close;
      DataModuleMyOffice.DSLoeschen('ArtikelListe','Modul_Nr',Fnr);
      DataModuleMyOffice.DSLoeschen('Module','Nr',Fnr);
    end;
    QueryModule.Open;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  //PanelTastatur.Color:=clYellow;
end;

procedure TFormPlanlos.ButtonArtikelaussuchfensterClick(Sender: TObject);
Var FEinstelllisteArtikelAussuchen:TStringList;
    i:integer;
begin
  FEinstelllisteArtikelAussuchen:=TStringList.Create;
  for i:=0 to 100 do FEinstelllisteArtikelAussuchen.add('');
  FEinstelllisteArtikelAussuchen[37]:='1';
  FEinstelllisteArtikelAussuchen[24]:='1';
  FEinstelllisteArtikelAussuchen[27]:='1';
  FEinstelllisteArtikelAussuchen[28]:='1';
  FEinstelllisteArtikelAussuchen[29]:='1';
  FEinstelllisteArtikelAussuchen[30]:='1';
  FormArtikelAussuchen1.an('','',1,'Artikel',FEinstelllisteArtikelAussuchen);
end;

procedure TFormPlanlos.ButtonArtikelSammlungenClick(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(DammiForm,'',GModulart,GBenutzer,86);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonSQLAusfuehrenClick(Sender: TObject);
begin
  if DataModuleMyOffice.FQuery1.active then DataModuleMyOffice.FQuery1.Close;
  DataModuleMyOffice.FQuery1.SQL.Clear;
  DataModuleMyOffice.FQuery1.SQL:=MemoSQLBefehl.Lines;
  //showmessage(QueryDB.SQL.text);
  try
    DataModuleMyOffice.FQuery1.ExecSQL;
  finally
  end;
  DataModuleMyOffice.FQuery1.Close;
end;

procedure TFormPlanlos.ButtonMyOfficeAnlegenClick(Sender: TObject);
begin
  MemoSQLBefehl.text:='CREATE DATABASE `myoffice`';
end;

procedure TFormPlanlos.ButtontestClick(Sender: TObject);
var s:string;
begin
  S:=DataModuleMyOffice.FdSetString(1,'123456name12345678901234xx',12309,12309,12309,12309,'123456Schrift45678901234xx','12farbe8x',109,109,109,09999,0);
  Showmessage(s);
  DataModuleMyOffice.FddGet(1,s);
  Showmessage(Fdd1.Name);
end;

procedure TFormPlanlos.ButtonEinstellungDruckenClick(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(FormEinstellungenDrucken,'',GModulart,GBenutzer,43);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //GLogo.Free;
  modulArtListe.Free;
  UPar.Free;
  DataModuleMyOffice.FreeArtikelMemo();
end;

procedure TFormPlanlos.ButtonDatenAendernClick(Sender: TObject);
begin
  If ButtonDatenAendern.Caption ='Daten ändern:' then begin
    Showmessage('die Änderungen werden erst nach dem Neustart des Programms akiviert');
    ButtonDatenAendern.Caption:='geänderte daten Speichern';
    if QueryAllgemeineEinstellungen.active then QueryAllgemeineEinstellungen.close;
    QueryAllgemeineEinstellungen.SQL.Clear;
    QueryAllgemeineEinstellungen.SQL.Add('Select * FROM EinstellungenAllgemein');
    try
      QueryAllgemeineEinstellungen.Open
    except end;
    QueryAllgemeineEinstellungen.edit;
    {PanelButtonDateiActiv.Caption:=QueryAllgemeineEinstellungen.FieldByName('ButtonDateiActive').AsString;
    PanelButtonDateiNichtActiv.Caption:=QueryAllgemeineEinstellungen.FieldByName('ButtonDateiNichtActive').AsString;
    PanelButtonFarbeactiv.Color:=stringtocolor(QueryAllgemeineEinstellungen.FieldByName('ButtonFarbeActive').AsString);
    PanelButtonFarbeNichtactiv.Color:=stringtocolor(QueryAllgemeineEinstellungen.FieldByName('ButtonFarbeNichtActive').AsString);
    PanelButtonFontColorActiv.Font.Color:=stringtocolor(QueryAllgemeineEinstellungen.FieldByName('ButtonFontColorActive').AsString);
    PanelButtonFontColorNichtActiv.Font.Color:=stringtocolor(QueryAllgemeineEinstellungen.FieldByName('ButtonFontColorNichtActive').AsString);

    if QueryAllgemeineEinstellungen.FieldByName('ButtonFeldActive').Asinteger = 0 then begin
      PanelButtonDateiActiv.Visible:=False;
      PanelButtonFarbeactiv.Visible:=False;
    end;
    if QueryAllgemeineEinstellungen.FieldByName('ButtonFeldActive').Asinteger = 1 then begin
      PanelButtonDateiActiv.Visible:=True;
      PanelButtonFarbeactiv.Visible:=True;
      //PanelButtonDateiActiv.Caption:=QueryAllgemeineEinstellungen.FieldByName('ButtonDateiActive').AsString;
    end;
    if QueryAllgemeineEinstellungen.FieldByName('ButtonFeldActive').Asinteger = 2 then begin
      PanelButtonDateiActiv.Visible:=False;
      PanelButtonFarbeactiv.Visible:=True;
      //PanelButtonFarbeactiv.Color:=stringtocolor(QueryAllgemeineEinstellungen.FieldByName('ButtonFarbeActive').AsString);
    end;
    if QueryAllgemeineEinstellungen.FieldByName('ButtonFeldNichtActive').Asinteger = 0 then begin
      PanelButtonDateiNichtActiv.Visible:=False;
      PanelButtonFarbeNichtactiv.Visible:=False;
    end;
    if QueryAllgemeineEinstellungen.FieldByName('ButtonFeldNichtActive').Asinteger = 1 then begin
      PanelButtonDateiNichtActiv.Visible:=True;
      PanelButtonFarbeNichtactiv.Visible:=True;
      //PanelButtonDateiNichtActiv.Caption:=QueryAllgemeineEinstellungen.FieldByName('ButtonDateiNichtActive').AsString;
    end;
    if QueryAllgemeineEinstellungen.FieldByName('ButtonFeldNichtActive').Asinteger = 2 then begin
      PanelButtonDateiNichtActiv.Visible:=False;
      PanelButtonFarbeNichtactiv.Visible:=True;
      //PanelButtonFarbeNichtactiv.Color:=stringtocolor(QueryAllgemeineEinstellungen.FieldByName('ButtonFarbeNichtActive').AsString);
    end;}
  end
  else begin
    ButtonDatenAendern.Caption:='Daten ändern:';
    {QueryAllgemeineEinstellungen.FieldByName('ButtonDateiActive').AsString:=PanelButtonDateiActiv.Caption;
    QueryAllgemeineEinstellungen.FieldByName('ButtonDateiNichtActive').AsString:=PanelButtonDateiNichtActiv.Caption;
    QueryAllgemeineEinstellungen.FieldByName('ButtonFarbeActive').AsString:=ColorToString(PanelButtonFarbeactiv.Color);
    QueryAllgemeineEinstellungen.FieldByName('ButtonFarbeNichtActive').AsString:=ColorToString(PanelButtonFarbeNichtactiv.Color);
    QueryAllgemeineEinstellungen.FieldByName('ButtonFontColorActive').AsString:=ColorToString(PanelButtonFontColorActiv.Font.Color);
    QueryAllgemeineEinstellungen.FieldByName('ButtonFontColorNichtActive').AsString:=ColorToString(PanelButtonFontColorNichtActiv.Font.Color);}
    QueryAllgemeineEinstellungen.post;
    if QueryAllgemeineEinstellungen.active then QueryAllgemeineEinstellungen.close;
  end;
end;

procedure TFormPlanlos.Allgemeine_EinstellungenExit(Sender: TObject);
begin
    if QueryAllgemeineEinstellungen.active then QueryAllgemeineEinstellungen.close;
end;

procedure TFormPlanlos.ButtonkopierenClick(Sender: TObject);
Var Fnr:integer;
    FModulart:String;
begin
  //FModulart:=QueryModule.FieldByName('Modulart').AsString;
  //Fnr:=QueryModule.FieldByName('Nr').AsInteger;
  //DataModuleMyOffice.LagerverwaltungListe(FModulart,Fnr,False);
  //Showmessage('modul kopieren noch gemacht werden');
  //wenn kopieren gleich abbrechen dann muss vor dem löschen in Artikelsammlung noch
  //die Lagerverwaltungänderungen wieder gelöscht werden.
end;

procedure TFormPlanlos.QueryModuleAfterScroll(DataSet: TDataSet);
begin
  if UmodulsrollAn Then begin
    Modulbuttonszeigen();
  end;
end;

procedure TFormPlanlos.Modulbuttonszeigen();
begin
  if 'Projekt'    = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=UProjektkopieren;UMaendern:=UProjektaendern;UMloeschen:=UProjektloeschen; end;
  if M1.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M1.kopieren;UMaendern:=M1.aendern;UMloeschen:=M1.loeschen; end;
  if M2.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M2.kopieren;UMaendern:=M2.aendern;UMloeschen:=M2.loeschen; end;
  if M3.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M3.kopieren;UMaendern:=M3.aendern;UMloeschen:=M3.loeschen; end;
  if M4.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M4.kopieren;UMaendern:=M4.aendern;UMloeschen:=M4.loeschen; end;
  if M5.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M5.kopieren;UMaendern:=M5.aendern;UMloeschen:=M5.loeschen; end;
  if M6.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M6.kopieren;UMaendern:=M6.aendern;UMloeschen:=M6.loeschen; end;
  if M7.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M7.kopieren;UMaendern:=M7.aendern;UMloeschen:=M7.loeschen; end;
  if M8.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M8.kopieren;UMaendern:=M8.aendern;UMloeschen:=M8.loeschen; end;
  if M9.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M9.kopieren;UMaendern:=M9.aendern;UMloeschen:=M9.loeschen; end;
  if M10.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M10.kopieren;UMaendern:=M10.aendern;UMloeschen:=M10.loeschen; end;
  if M11.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M11.kopieren;UMaendern:=M11.aendern;UMloeschen:=M11.loeschen; end;
  if M12.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M12.kopieren;UMaendern:=M12.aendern;UMloeschen:=M12.loeschen; end;
  if M13.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M13.kopieren;UMaendern:=M13.aendern;UMloeschen:=M13.loeschen; end;
  if M14.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M14.kopieren;UMaendern:=M14.aendern;UMloeschen:=M14.loeschen; end;
  if M15.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M15.kopieren;UMaendern:=M15.aendern;UMloeschen:=M15.loeschen; end;
  if M16.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M16.kopieren;UMaendern:=M16.aendern;UMloeschen:=M16.loeschen; end;
  if M17.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M17.kopieren;UMaendern:=M17.aendern;UMloeschen:=M17.loeschen; end;
  if M18.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M18.kopieren;UMaendern:=M18.aendern;UMloeschen:=M18.loeschen; end;
  if M19.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M19.kopieren;UMaendern:=M19.aendern;UMloeschen:=M19.loeschen; end;
  if M20.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M20.kopieren;UMaendern:=M20.aendern;UMloeschen:=M20.loeschen; end;
  if M21.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M21.kopieren;UMaendern:=M21.aendern;UMloeschen:=M21.loeschen; end;
  if M22.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M22.kopieren;UMaendern:=M22.aendern;UMloeschen:=M22.loeschen; end;
  if M23.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M23.kopieren;UMaendern:=M23.aendern;UMloeschen:=M23.loeschen; end;
  if M24.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M24.kopieren;UMaendern:=M24.aendern;UMloeschen:=M24.loeschen; end;
  if M25.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M25.kopieren;UMaendern:=M25.aendern;UMloeschen:=M25.loeschen; end;
  if M26.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M26.kopieren;UMaendern:=M26.aendern;UMloeschen:=M26.loeschen; end;
  if M27.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M27.kopieren;UMaendern:=M27.aendern;UMloeschen:=M27.loeschen; end;
  if M28.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M28.kopieren;UMaendern:=M28.aendern;UMloeschen:=M28.loeschen; end;
  if M29.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M29.kopieren;UMaendern:=M29.aendern;UMloeschen:=M29.loeschen; end;
  if M30.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M30.kopieren;UMaendern:=M30.aendern;UMloeschen:=M30.loeschen; end;
  if M31.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M31.kopieren;UMaendern:=M31.aendern;UMloeschen:=M31.loeschen; end;
  if M32.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M32.kopieren;UMaendern:=M32.aendern;UMloeschen:=M32.loeschen; end;
  if M33.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M33.kopieren;UMaendern:=M33.aendern;UMloeschen:=M33.loeschen; end;
  if M34.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M34.kopieren;UMaendern:=M34.aendern;UMloeschen:=M34.loeschen; end;
  if M35.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M35.kopieren;UMaendern:=M35.aendern;UMloeschen:=M35.loeschen; end;
  if M36.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M36.kopieren;UMaendern:=M36.aendern;UMloeschen:=M36.loeschen; end;
  if M37.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M37.kopieren;UMaendern:=M37.aendern;UMloeschen:=M37.loeschen; end;
  if M38.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M38.kopieren;UMaendern:=M38.aendern;UMloeschen:=M38.loeschen; end;
  if M39.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M39.kopieren;UMaendern:=M39.aendern;UMloeschen:=M39.loeschen; end;
  if M40.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M40.kopieren;UMaendern:=M40.aendern;UMloeschen:=M40.loeschen; end;
  if M41.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M41.kopieren;UMaendern:=M41.aendern;UMloeschen:=M41.loeschen; end;
  if M42.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M42.kopieren;UMaendern:=M42.aendern;UMloeschen:=M42.loeschen; end;
  if M43.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M43.kopieren;UMaendern:=M43.aendern;UMloeschen:=M43.loeschen; end;
  if M44.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M44.kopieren;UMaendern:=M44.aendern;UMloeschen:=M44.loeschen; end;
  if M45.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M45.kopieren;UMaendern:=M45.aendern;UMloeschen:=M45.loeschen; end;
  if M46.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M46.kopieren;UMaendern:=M46.aendern;UMloeschen:=M46.loeschen; end;
  if M47.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M47.kopieren;UMaendern:=M47.aendern;UMloeschen:=M47.loeschen; end;
  if M48.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M48.kopieren;UMaendern:=M48.aendern;UMloeschen:=M48.loeschen; end;
  if M49.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M49.kopieren;UMaendern:=M49.aendern;UMloeschen:=M49.loeschen; end;
  if M50.Modulname = QueryModule.FieldByName('Modulart').AsString then begin UMkopieren:=M50.kopieren;UMaendern:=M50.aendern;UMloeschen:=M50.loeschen; end;
  Buttonkopieren.Enabled:=UMkopieren;
  ButtonAendern.Enabled:=UMaendern;
  Buttonloeschen.Enabled:=UMloeschen;
  //Showmessage(QueryModule.FieldByName('Modulart').AsString);
end;

procedure TFormPlanlos.ButtonBenutzereinstellungenClick(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(FormEinstellungenBenutzer,'',GModulart,GBenutzer,44);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormPlanlos.ButtonNummernClick(Sender: TObject);
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(DammiForm,'',GModulart,GBenutzer,88);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonStGuppierungClick(Sender: TObject);
begin
//if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(FormAdresse,'',GModulart,GBenutzer,89);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonWaArtikelTempClick(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(FormAdresse,'',GModulart,GBenutzer,90);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion1Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,191);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion2Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,192);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion3Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,193);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion4Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,194);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion5Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,195);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion6Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,196);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion7Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,197);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion8Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,198);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion9Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,199);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion10Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,200);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion11Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,201);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion12Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,202);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion13Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,203);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion14Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,204);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion15Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,205);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion16Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,206);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion17Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,207);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSonderfunktion18Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   TForm1.an(DammiForm,'',GModulart,GBenutzer,208);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonSelbst1Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,211);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst1.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst2Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,212);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst2.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst3Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,213);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst3.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst4Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,214);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst4.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst5Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,215);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst5.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst6Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,216);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst6.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst7Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,217);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst7.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst8Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,218);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst8.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst9Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,219);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst9.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst10Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,220);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst10.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst11Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,221);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst11.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst12Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,222);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst12.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst13Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,223);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst13.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst14Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,224);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst14.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst15Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,225);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst15.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst16Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,226);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst16.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst17Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,227);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst17.Caption:=UPar[1];
end;

procedure TFormPlanlos.ButtonSelbst18Click(Sender: TObject);
begin
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   UPar:=TForm1.an(DammiForm,'',GModulart,GBenutzer,228);
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
   if UPar[1] <>'' then ButtonSelbst18.Caption:=UPar[1];
end;

function TFormPlanlos.iniZeile(zeile:String):String;
var z:String;
    i:integer;
    zuruck:String;
    beenden:Boolean;
begin
  beenden:=False;
  for i:=1 to length(zeile)do begin
    z:=copy(zeile,i,1);
    if z = ';' then beenden:=True;
    if beenden=False then zuruck:=zuruck+z;
  end;
  Result:=zuruck;
end;

procedure TFormPlanlos.FormCreate(Sender: TObject);
var datendatei:System.text;
    rename:Array[1..50] of String;
begin
  //------------------  Standardeinstellung---------------------------
  GVersion:='01.00';
  GModulNrFuerStuckliste:=0;
  UMloeschen:=False;UMkopieren:=False;UMaendern:=False;
  UmodulsrollAn:=True;
  UProjektneu:=False;UProjektkopieren:=False;UProjektaendern:=False;UProjektloeschen:=False;
  GBenutzer:='Standard';GModulart:='Standard';
  UZeiger:=0;
  GKopfFusstext:='';G_Artikelgruppe:='';
  GProjekt_Nr:=0;GBeziehungs_Nr:=0;GModulart_Nr:=0;
  modulart:='(modulart <> "") ';
  ButtonProjekt.Enabled:=UProjektneu;
  //G_Benutzereinstellung:='Standard';

  //------------------  Registrierung---------------------------

  if FileExists('Key.ini') then begin
    Reset(datendatei,'Key.ini');
    readln(datendatei,rename[1]);
    readln(datendatei,rename[2]);
    readln(datendatei,rename[3]);
    CloseFile(datendatei);
    if Formregistrierung.test(rename[1],rename[2],rename[3]) Then begin
      FormPlanlos.Caption:='Mein kleines Büro '+GVersion+'  '+ rename[1]+' Firmen Nr='+rename[3];
      FormPlanlos.GFirmaNr:=strtoint(rename[3]);
    end
    Else begin
      FormPlanlos.Caption:='Mein kleines Büro '+GVersion+'  --------unregistriert--------';
      Showmessage('Registrierung fehlgeschlagen');Close;
    end;
  end
  Else FormPlanlos.Caption:='Mein kleines Büro '+GVersion+'  --------unregistriert--------';

  //------------------ DBEinstellung ---------------------------
  //GIniDatabase:='MyOffice';
  GIniDatabase:='MyOffice';
  GIniHostname:='localhost';
  GIniPasswort:='';
  GIniProtocol:='mysql-4.0';
  GIniUser:='Standard';
  GIniDBerstellen:=False;
  GIniLoginPrompt:=False;
  if FileExists('DB.ini') then begin
    Reset(datendatei,'DB.ini');
    readln(datendatei,rename[1]);
    readln(datendatei,rename[2]);
    readln(datendatei,rename[3]);
    readln(datendatei,rename[4]);
    readln(datendatei,rename[5]);
    readln(datendatei,rename[6]);
    readln(datendatei,rename[7]);
    readln(datendatei,rename[8]);
    GIniDatabase:=iniZeile(rename[1]);
    GIniHostname:=iniZeile(rename[2]);
    GIniPasswort:=iniZeile(rename[3]);
    GIniProtocol:=iniZeile(rename[4]);
    GIniUser:=iniZeile(rename[5]);
    if iniZeile(rename[6])= 'Ja' then GIniLoginPrompt:=True Else GIniLoginPrompt:=False;
    if iniZeile(rename[7])= 'Ja' then GIniDBerstellen:=True Else GIniDBerstellen:=False;
    if iniZeile(rename[8])= 'Ja' then GIniProgrammsta:=True Else GIniProgrammsta:=False;

    ButtonINIDatabase.Caption:=GIniDatabase;
    ButtonINIHostname.Caption:=GIniHostname;
    ButtonINIPassswort.Caption:=GIniPasswort;
    ButtonINIProtocol.Caption:=GIniProtocol;
    ButtonINIUser.Caption:=GIniUser;
    if GIniLoginPrompt then ButtonINIDBLogin.Caption:='Ja' else ButtonINIDBLogin.Caption:='Nein';
    if GIniDBerstellen then ButtonINIDBErstellen.Caption:='Ja' else ButtonINIDBErstellen.Caption:='Nein';
    if GIniProgrammsta then ButtonINIProgrammsta.Caption:='Ja' else ButtonINIProgrammsta.Caption:='Nein';

    if GIniDBerstellen then begin
      {GIniDBerstellen:=Meldefenster.an(3,'soll eine neue Datenbank mit dem ','Protokoll '+GIniProtocol+' erstellt werden','eine neue DB erstellen');
      if GIniDBerstellen then begin

        //DB erstellen

      end;}
      Showmessage('Datenbank erstellen wurde in DB.ini ausgewählt. Starten Sie das Programm DBErstellen um die neu Datenbank zu erstellen');
    end;
  End Else begin
    Showmessage('DB.ini kann nicht gefunden werden');Close;
  End;
  CloseFile(datendatei);
end;

procedure TFormPlanlos.ButtonRegistrierungClick(Sender: TObject);
  var rename:String;
begin
  rename:=Formregistrierung.anfang;
  if rename <> ''then FormPlanlos.Caption:='Mein kleines Büro '+GVersion+'  '+ rename+' Firmen Nr='+rename[3];
end;

procedure TFormPlanlos.ButtonBenutzereinstellungFensterClick(
  Sender: TObject);
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  TForm1.an(FormEinstellungenFenster,'',GModulart,GBenutzer,46);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);

end;

procedure TFormPlanlos.ButtonINIDatabaseClick(Sender: TObject);
Var  datendatei:System.text;
     rename:Array[1..20] of String;
begin
  if (Meldefenster.an(4,'MyOffice,etc.',ButtonINIDatabase.Caption,'Geben Sie den DB-Name ein, der verwendet werden soll!')) then begin
    if FileExists('DB.ini') then begin
      Reset(datendatei,'DB.ini');
      readln(datendatei,rename[1]);
      readln(datendatei,rename[2]);
      readln(datendatei,rename[3]);
      readln(datendatei,rename[4]);
      readln(datendatei,rename[5]);
      readln(datendatei,rename[6]);
      readln(datendatei,rename[7]);
      readln(datendatei,rename[8]);
      CloseFile(datendatei);

      rename[1]:=GMeldefenster+';'+'          Database';

      Rewrite(datendatei,'DB.ini');
      Writeln(datendatei,rename[1]);
      Writeln(datendatei,rename[2]);
      Writeln(datendatei,rename[3]);
      Writeln(datendatei,rename[4]);
      Writeln(datendatei,rename[5]);
      Writeln(datendatei,rename[6]);
      Writeln(datendatei,rename[7]);
      Writeln(datendatei,rename[8]);
      CloseFile(datendatei);
      Showmessage('die Änderung wird beim Neustart des Programms wirksam!');
      ButtonINIDatabase.Caption:=GMeldefenster;
    end;
  end;
end;

procedure TFormPlanlos.ButtonINIHostnameClick(Sender: TObject);
Var  datendatei:System.text;
     rename:Array[1..20] of String;
begin
  if (Meldefenster.an(4,'localhost,etc.',ButtonINIHostname.Caption,'Geben Sie den HostName ein, der verwendet werden soll!')) then begin
    if FileExists('DB.ini') then begin
      Reset(datendatei,'DB.ini');
      readln(datendatei,rename[1]);
      readln(datendatei,rename[2]);
      readln(datendatei,rename[3]);
      readln(datendatei,rename[4]);
      readln(datendatei,rename[5]);
      readln(datendatei,rename[6]);
      readln(datendatei,rename[7]);
      readln(datendatei,rename[8]);
      CloseFile(datendatei);

      rename[2]:=GMeldefenster+';'+'          Hostname';

      Rewrite(datendatei,'DB.ini');
      Writeln(datendatei,rename[1]);
      Writeln(datendatei,rename[2]);
      Writeln(datendatei,rename[3]);
      Writeln(datendatei,rename[4]);
      Writeln(datendatei,rename[5]);
      Writeln(datendatei,rename[6]);
      Writeln(datendatei,rename[7]);
      Writeln(datendatei,rename[8]);
      CloseFile(datendatei);
      Showmessage('die Änderung wird beim Neustart des Programms wirksam!');
      ButtonINIHostname.Caption:=GMeldefenster;
    end;
  end;
end;

procedure TFormPlanlos.ButtonINIPassswortClick(Sender: TObject);
Var  datendatei:System.text;
     rename:Array[1..20] of String;
begin
  if (Meldefenster.an(4,'',ButtonINIPassswort.Caption,'Geben Sie das DB-Passwort ein, das verwendet werden soll!')) then begin
    if FileExists('DB.ini') then begin
      Reset(datendatei,'DB.ini');
      readln(datendatei,rename[1]);
      readln(datendatei,rename[2]);
      readln(datendatei,rename[3]);
      readln(datendatei,rename[4]);
      readln(datendatei,rename[5]);
      readln(datendatei,rename[6]);
      readln(datendatei,rename[7]);
      readln(datendatei,rename[8]);
      CloseFile(datendatei);

      rename[3]:=GMeldefenster+';'+'          Passwort';

      Rewrite(datendatei,'DB.ini');
      Writeln(datendatei,rename[1]);
      Writeln(datendatei,rename[2]);
      Writeln(datendatei,rename[3]);
      Writeln(datendatei,rename[4]);
      Writeln(datendatei,rename[5]);
      Writeln(datendatei,rename[6]);
      Writeln(datendatei,rename[7]);
      Writeln(datendatei,rename[8]);
      CloseFile(datendatei);
      Showmessage('die Änderung wird beim Neustart des Programms wirksam!');
      ButtonINIPassswort.Caption:=GMeldefenster;
    end;
  end;
end;

procedure TFormPlanlos.ButtonINIProtocolClick(Sender: TObject);
Var  datendatei:System.text;
     rename:Array[1..20] of String;
begin
  if (Meldefenster.an(4,'mysql-4.0, ado,firebird-1.5, interbase-6, postgresql-7.3, sybase,',ButtonINIProtocol.Caption,'Geben Sie das DB-Protokoll ein, das verwendet werden soll!')) then begin
    if FileExists('DB.ini') then begin
      Reset(datendatei,'DB.ini');
      readln(datendatei,rename[1]);
      readln(datendatei,rename[2]);
      readln(datendatei,rename[3]);
      readln(datendatei,rename[4]);
      readln(datendatei,rename[5]);
      readln(datendatei,rename[6]);
      readln(datendatei,rename[7]);
      readln(datendatei,rename[8]);
      CloseFile(datendatei);

      rename[4]:=GMeldefenster+';'+'          Protocol';

      Rewrite(datendatei,'DB.ini');
      Writeln(datendatei,rename[1]);
      Writeln(datendatei,rename[2]);
      Writeln(datendatei,rename[3]);
      Writeln(datendatei,rename[4]);
      Writeln(datendatei,rename[5]);
      Writeln(datendatei,rename[6]);
      Writeln(datendatei,rename[7]);
      Writeln(datendatei,rename[8]);
      CloseFile(datendatei);
      Showmessage('die Änderung wird beim Neustart des Programms wirksam!');
      ButtonINIProtocol.Caption:=GMeldefenster;
    end;
  end;
end;
procedure TFormPlanlos.ButtonINIUserClick(Sender: TObject);
Var  datendatei:System.text;
     rename:Array[1..20] of String;
begin
  if (Meldefenster.an(4,'Standard',ButtonINIUser.Caption,'Geben Sie ein DB-Username/Benutzername ein, der verwendet werden soll!')) then begin
    if FileExists('DB.ini') then begin
      Reset(datendatei,'DB.ini');
      readln(datendatei,rename[1]);
      readln(datendatei,rename[2]);
      readln(datendatei,rename[3]);
      readln(datendatei,rename[4]);
      readln(datendatei,rename[5]);
      readln(datendatei,rename[6]);
      readln(datendatei,rename[7]);
      readln(datendatei,rename[8]);
      CloseFile(datendatei);

      rename[5]:=GMeldefenster+';'+'          Username/Benutzernam';

      Rewrite(datendatei,'DB.ini');
      Writeln(datendatei,rename[1]);
      Writeln(datendatei,rename[2]);
      Writeln(datendatei,rename[3]);
      Writeln(datendatei,rename[4]);
      Writeln(datendatei,rename[5]);
      Writeln(datendatei,rename[6]);
      Writeln(datendatei,rename[7]);
      Writeln(datendatei,rename[8]);
      CloseFile(datendatei);
      Showmessage('die Änderung wird beim Neustart des Programms wirksam!');
      ButtonINIUser.Caption:=GMeldefenster;
    end;
  end;
end;

procedure TFormPlanlos.ButtonINIDBLoginClick(Sender: TObject);
Var  datendatei:System.text;
     rename:Array[1..20] of String;
begin
  if (Meldefenster.an(4,'Ja, Nein',ButtonINIDBLogin.Caption,'Geben Sie "Ja" oder "Nein" ein, um ein DBLogin zu nutzen')) then begin
    if FileExists('DB.ini') then begin
      Reset(datendatei,'DB.ini');
      readln(datendatei,rename[1]);
      readln(datendatei,rename[2]);
      readln(datendatei,rename[3]);
      readln(datendatei,rename[4]);
      readln(datendatei,rename[5]);
      readln(datendatei,rename[6]);
      readln(datendatei,rename[7]);
      readln(datendatei,rename[8]);
      CloseFile(datendatei);

      rename[6]:=GMeldefenster+';'+'          DB login';

      Rewrite(datendatei,'DB.ini');
      Writeln(datendatei,rename[1]);
      Writeln(datendatei,rename[2]);
      Writeln(datendatei,rename[3]);
      Writeln(datendatei,rename[4]);
      Writeln(datendatei,rename[5]);
      Writeln(datendatei,rename[6]);
      Writeln(datendatei,rename[7]);
      Writeln(datendatei,rename[8]);
      CloseFile(datendatei);
      Showmessage('die Änderung wird beim Neustart des Programms wirksam!');
      ButtonINIDBLogin.Caption:=GMeldefenster;
    end;
  end;
end;

procedure TFormPlanlos.ButtonINIDBErstellenClick(Sender: TObject);
Var  datendatei:System.text;
     rename:Array[1..20] of String;
begin
  if (Meldefenster.an(4,'Ja, Nein',ButtonINIDBErstellen.Caption,'Geben Sie "Ja" oder "Nein" ein, um eine neue DB zu erstellen')) then begin
    if FileExists('DB.ini') then begin
      Reset(datendatei,'DB.ini');
      readln(datendatei,rename[1]);
      readln(datendatei,rename[2]);
      readln(datendatei,rename[3]);
      readln(datendatei,rename[4]);
      readln(datendatei,rename[5]);
      readln(datendatei,rename[6]);
      readln(datendatei,rename[7]);
      readln(datendatei,rename[8]);
      CloseFile(datendatei);

      rename[7]:=GMeldefenster+';'+'          DB erstellen';

      Rewrite(datendatei,'DB.ini');
      Writeln(datendatei,rename[1]);
      Writeln(datendatei,rename[2]);
      Writeln(datendatei,rename[3]);
      Writeln(datendatei,rename[4]);
      Writeln(datendatei,rename[5]);
      Writeln(datendatei,rename[6]);
      Writeln(datendatei,rename[7]);
      Writeln(datendatei,rename[8]);
      CloseFile(datendatei);
      Showmessage('die Änderung wird beim Neustart des Programms wirksam!');
      ButtonINIDBErstellen.Caption:=GMeldefenster;
      Showmessage('Datenbank erstellen wurde in DB.ini ausgewählt. Starten Sie das Programm DBErstellen um die neu Datenbank zu erstellen'); 
    end;
  end;
end;

procedure TFormPlanlos.ButtonINIProgrammstaClick(Sender: TObject);
Var  datendatei:System.text;
     rename:Array[1..20] of String;
begin
  if (Meldefenster.an(4,'Ja, Nein',ButtonINIProgrammsta.Caption,'Geben Sie "Ja" oder "Nein" ein, um ein Benutzer-Login zu nutzen!')) then begin
    if FileExists('DB.ini') then begin
      Reset(datendatei,'DB.ini');
      readln(datendatei,rename[1]);
      readln(datendatei,rename[2]);
      readln(datendatei,rename[3]);
      readln(datendatei,rename[4]);
      readln(datendatei,rename[5]);
      readln(datendatei,rename[6]);
      readln(datendatei,rename[7]);
      readln(datendatei,rename[8]);
      CloseFile(datendatei);

      rename[8]:=GMeldefenster+';'+'          Programmstart Login';

      Rewrite(datendatei,'DB.ini');
      Writeln(datendatei,rename[1]);
      Writeln(datendatei,rename[2]);
      Writeln(datendatei,rename[3]);
      Writeln(datendatei,rename[4]);
      Writeln(datendatei,rename[5]);
      Writeln(datendatei,rename[6]);
      Writeln(datendatei,rename[7]);
      Writeln(datendatei,rename[8]);
      CloseFile(datendatei);
      Showmessage('die Änderung wird beim Neustart des Programms wirksam!');
      ButtonINIProgrammsta.Caption:=GMeldefenster;
    end;
  end;
end;

procedure TFormPlanlos.ButtonImportClick(Sender: TObject);
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  FormImport.Showmodal;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

procedure TFormPlanlos.ButtonExportierenClick(Sender: TObject);
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
  FormExport.Showmodal;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelF5,LabelF6,LabelF7,LabelF8,LabelF10,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF10_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_p,LabelF5_P,LabelF5_p,GCB);
end;

end.
