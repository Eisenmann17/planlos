unit UnitArtikelSammlung;

interface
        
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, DBCGrids, DB, DBTables, Mask, DBCtrls, ExtCtrls,
  Buttons, Menus, FR_DBOp, FR_DSet, FR_DBSet, FR_Class, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, FR_Desgn, FR_E_HTM, FR_E_CSV, FR_E_RTF,
  FR_E_TXT;

type
  TFormArtikelSammlung = class(TForm)
    GroupBoxKopf: TGroupBox;
    GroupBoxFuss: TGroupBox;
    GroupBoxButton: TGroupBox;
    DataSource1: TDataSource;
    DBCtrlGridArtikel: TDBCtrlGrid;
    ButtonSpeichern: TButton;
    GroupBoxSummen: TGroupBox;
    DBEditPos_Nr: TDBEdit;
    DBEditArtikel: TDBEdit;
    DBEditArtikelGruppe: TDBEdit;
    DBEditEinheitMenge: TDBEdit;
    DBEditMenge: TDBEdit;
    DBEditVK_Preis: TDBEdit;
    DBEditEK_Preis: TDBEdit;
    DBEditEinheit_EK: TDBEdit;
    DBEditAufschlag: TDBEdit;
    Buttonabbrechen: TButton;
    Labelpos_text: TLabel;
    ComboBoxPostext: TComboBox;
    DataSource2: TDataSource;
    DBMemoKopf: TDBMemo;
    DBTextModul: TDBText;
    LabelBearbeiter: TLabel;
    DBEditBearbeiter: TDBEdit;
    LabelErfassungsdatum: TLabel;
    DBMemoAdresse: TDBMemo;
    LabellModulKleinNr: TLabel;
    DBEditLetzteBearbeitung: TDBEdit;
    DBTextModulartKlein: TDBText;
    ButtonSuchen: TButton;
    DBMemoFuss: TDBMemo;
    ButtonNeu: TButton;
    ButtonLoeschen: TButton;
    PageControlSumme: TPageControl;
    TabSheetExtern: TTabSheet;
    TabSheetSummen: TTabSheet;
    LabelSEK_Preis: TLabel;
    LabelSVK_Preis: TLabel;
    LabelSAufschlag: TLabel;
    LabelEVK_Preis: TLabel;
    LabelEMwSt: TLabel;
    LabelEPreis: TLabel;
    LabelKopftext: TLabel;
    GroupBoxIntern: TGroupBox;
    DBMemoNotiz: TDBMemo;
    LabelNotiz: TLabel;
    LabelBezeichnung: TLabel;
    DBEditBezeichnung: TDBEdit;
    LabelAdresse: TLabel;
    LabelTransaktionsNr: TLabel;
    Buttonaendern: TButton;
    Buttonkopieren: TButton;
    DBEditProjekt: TDBEdit;
    DBEditAdresse: TDBEdit;
    LabelProjektName: TLabel;
    ButtonAusgabe: TButton;
    LabelGruppe: TLabel;
    DBEditGruppierung: TDBEdit;
    DataSource3: TDataSource;
    DBMemoPosText: TDBMemo;
    LabelTransaktionsNrNr: TLabel;
    DataSource4: TDataSource;
    DBMemoVonAdresse: TDBMemo;
    DataSource5: TDataSource;
    DBMemoTextbaustein: TDBMemo;
    ButtonKopftext: TButton;
    ButtonFusstext: TButton;
    DBTextModul_Nr: TDBText;
    DataSource6: TDataSource;
    DataSource7: TDataSource;
    DBMemoArtikelPos_Text: TDBMemo;
    DBEditBerechnungsArt: TDBEdit;
    DBEditGewicht: TDBEdit;
    DBEditKopfIhrZeichen: TDBEdit;
    LabelKopfihrZeichen: TLabel;
    ImageTastatur: TImage;
    LabelESC: TLabel;
    LabelF2: TLabel;
    LabelF3: TLabel;
    LabelF4: TLabel;
    LabelF5: TLabel;
    LabelF6: TLabel;
    LabelF8: TLabel;
    LabelF10: TLabel;
    DBTextArtikel: TDBText;
    DBCheckBoxGeaendert: TDBCheckBox;
    TabSheetAllgemein: TTabSheet;
    Label18: TLabel;
    LabelZ_1: TLabel;
    LabelZ_2: TLabel;
    LabelZ_3: TLabel;
    LabelGEinheit: TLabel;
    LabelZ_1Einheit: TLabel;
    LabelZ_2Einheit: TLabel;
    LabelZ_3Einheit: TLabel;
    LabelG: TLabel;
    LabelZ1: TLabel;
    LabelZ2: TLabel;
    LabelZ3: TLabel;
    TabSheetLeistungen: TTabSheet;
    LabelEK: TLabel;
    LabelVK: TLabel;
    LabelAuschlag: TLabel;
    LabelM: TLabel;
    LabelMVK: TLabel;
    LabelMAufschlag: TLabel;
    LabelD: TLabel;
    LabelDVK: TLabel;
    LabelDAufschlag: TLabel;
    LabelF: TLabel;
    LabelFVK: TLabel;
    LabelFAufschlag: TLabel;
    LabelS: TLabel;
    LabelSVK: TLabel;
    LabelSSAufschlag: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    SpeedButtonBewegenNachOben: TSpeedButton;
    SpeedButtonBewegenNachUnten: TSpeedButton;
    PopupMenuAusgabe: TPopupMenu;
    PrintDialog1: TPrintDialog;
    frReport1: TfrReport;
    frDBDataSetModule: TfrDBDataSet;
    frDBDataSetArtikel: TfrDBDataSet;
    DataSource8: TDataSource;
    frDBDataSetStueckliste: TfrDBDataSet;
    CheckBoxSummenSofort: TCheckBox;
    ButtonSummieren: TButton;
    DataSource9: TDataSource;
    DBEditZahl1: TDBEdit;
    DBEditZahl2: TDBEdit;
    DBEditZahl3: TDBEdit;
    DBEditRabatt: TDBEdit;
    DBEditArtikelNr: TDBEdit;
    DBCheckBoxArtikelErledigt1: TDBCheckBox;
    QueryEinstellungModulart: TZQuery;
    QueryArtikelListe: TZQuery;
    QueryTextbaustein: TZQuery;
    QueryZListe: TZQuery;
    QueryModul: TZQuery;
    QueryAdresse: TZQuery;
    QueryArtikel: TZQuery;
    QueryArtikelListe_d: TZQuery;
    QuerySumme: TZQuery;
    frDesigner1: TfrDesigner;
    frTextExport1: TfrTextExport;
    frRTFExport1: TfrRTFExport;
    frCSVExport1: TfrCSVExport;
    frHTMExport1: TfrHTMExport;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    QueryLagerverwaltung: TZQuery;
    DataSourceLagerverwaltung: TDataSource;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF2_p: TLabel;
    LabelF3_p: TLabel;
    LabelF4_p: TLabel;
    LabelF5_p: TLabel;
    LabelF6_p: TLabel;
    LabelF8_p: TLabel;
    LabelF10_p: TLabel;
    Labelpos_text_p: TLabel;
    DBEditBerechnen1: TDBEdit;
    DBEditBerechnen2: TDBEdit;
    DBEditBerechnen3: TDBEdit;
    DBEditName1: TDBEdit;
    DBEditName2: TDBEdit;
    DBEditName3: TDBEdit;
    LabelS_Berechnung1: TLabel;
    LabelS_Berechnung2: TLabel;
    LabelS_Berechnung3: TLabel;
    LabelS_Aufschlag: TLabel;
    LabelS_Rabatt: TLabel;
    LabelS_EK_Preis: TLabel;
    LabelS_Vkpreis: TLabel;
    LabelS_Gewinn: TLabel;
    LabelSBerechnung3: TLabel;
    LabelSBerechnung2: TLabel;
    LabelSBerechnung1: TLabel;
    LabelSGewinn: TLabel;
    LabelSRabatt: TLabel;
    LabelSPBerechnung1: TLabel;
    LabelSPBerechnung2: TLabel;
    LabelSPBerechnung3: TLabel;
    LabelSPEK_Preis: TLabel;
    LabelSPAufschlag: TLabel;
    LabelSPRabatt: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    LabelSPGewinn: TLabel;
    DBCheckBoxArtikelErledigt2: TDBCheckBox;
    DBCheckBoxArtikelErledigt3: TDBCheckBox;
    DBCheckBoxArtikelErledigt4: TDBCheckBox;
    procedure GroupBoxKopfDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GroupBoxFussDblClick(Sender: TObject);
    procedure GroupBoxButtonDblClick(Sender: TObject);
    procedure ButtonSpeichernClick(Sender: TObject);
    procedure ini;
    procedure AnzeigeNeu;
    procedure GroupBoxSummenDblClick(Sender: TObject);
    procedure PosTextZeilen;
    procedure ComboBoxPostextChange(Sender: TObject);
    procedure ButtonNeuClick(Sender: TObject);
    procedure ButtonLoeschenClick(Sender: TObject);
    procedure summierung(FEinstellung:integer);
    procedure ButtonSuchenClick(Sender: TObject);
    procedure GroupBoxInternDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ButtonaendernClick(Sender: TObject);
    procedure ButtonkopierenClick(Sender: TObject);
    procedure DBEditBezeichnungEnter(Sender: TObject);
    procedure Focus;
    procedure FenstergroesseAbspeichern;
    procedure ButtonAusgabeClick(Sender: TObject);
    procedure DBCtrlGridArtikelPaintPanel(DBCtrlGrid: TDBCtrlGrid;
      Index: Integer);
    procedure ButtonFusstextClick(Sender: TObject);
    procedure ButtonKopftextClick(Sender: TObject);
    procedure LabelProjektNameClick(Sender: TObject);
    procedure LabelAdresseClick(Sender: TObject);
    procedure LabelGruppeClick(Sender: TObject);
    procedure LabelBearbeiterClick(Sender: TObject);
    procedure LabelErfassungsdatumClick(Sender: TObject);
    procedure DBCtrlGridArtikelEnter(Sender: TObject);
    procedure DBCtrlGridArtikelExit(Sender: TObject);
    function  berechnung(Berechnungstext:String;Kennung:integer;FBerechneter_EK:Real):Real;
    procedure geheZu(Pos:integer);
    procedure QueryEinstellungModulartAfterInsert(DataSet: TDataSet);
    //procedure Popdrucken1Click(Sender: TObject);
    //procedure Popdrucken2Click(Sender: TObject);
    procedure frReport1BeginBand(Band: TfrBand);
    procedure frReport1EnterRect(Memo: TStringList; View: TfrView);
    //procedure ohneKopfdaten1Click(Sender: TObject);//Eingang/Ausgang
    procedure drucken(Fdruckart:integer);
    //procedure Popdrucken4ClickClick(Sender: TObject);
    procedure DBCtrlGridArtikelDblClick(Sender: TObject);
    procedure DBEditProjektDblClick(Sender: TObject);
    procedure QueryArtikelListeBeforePost(DataSet: TDataSet);
    procedure QueryArtikelListeAfterPost(DataSet: TDataSet);
    procedure ButtonSummierenClick(Sender: TObject);
    procedure CheckBoxSummenSofortClick(Sender: TObject);
    procedure DBEditMengeExit(Sender: TObject);
    procedure SpeedButtonBewegenNachObenClick(Sender: TObject);
    procedure SpeedButtonBewegenNachUntenClick(Sender: TObject);
    procedure MengeActiv(FEinstellung:integer);
    procedure PopupMenuAusgabeClick(Sender: TObject);
    procedure frReport1EndBand(Band: TfrBand);
    procedure ListeVerlassen(FActivControl: TWinControl);
    procedure ListeZurueck();
    function  FeldEineZahl(Zahl:String):Boolean;
    procedure DBEditEK_PreisExit(Sender: TObject);
    procedure DBEditAufschlagExit(Sender: TObject);
    procedure DBEditZahl1Exit(Sender: TObject);
    procedure DBEditGewichtExit(Sender: TObject);
    procedure DBEditRabattExit(Sender: TObject);
    procedure DBEditZahl3Exit(Sender: TObject);
    procedure DBEditZahl2Exit(Sender: TObject);
    procedure DBEditBerechnen1Exit(Sender: TObject);
    procedure DBEditBerechnen2Exit(Sender: TObject);
    procedure DBEditBerechnen3Exit(Sender: TObject);
    procedure DBEditBerechnungsArtExit(Sender: TObject);
    procedure DBEditArtikelGruppeExit(Sender: TObject);
    procedure QueryArtikelListeAfterScroll(DataSet: TDataSet);
    procedure DBEditArtikelExit(Sender: TObject);
    procedure DBEditName1Exit(Sender: TObject);
    procedure DBEditName2Exit(Sender: TObject);
    procedure DBEditName3Exit(Sender: TObject);
    procedure DBEditEinheitMengeExit(Sender: TObject);
    procedure DBEditEinheit_EKExit(Sender: TObject);
    procedure DBEditArtikelNrExit(Sender: TObject);
    procedure DBMemoPosTextExit(Sender: TObject);
    procedure FelderExit;
    procedure loeschenVonNullPos(FPos_Nr:integer);
    procedure DBCtrlGridArtikelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    //function IntToBol(Zahl:integer):Boolean;
    //procedure DSSet(FArtikel:TArtikel;FQuery:TZQuery);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormArtikelSammlung: TFormArtikelSammlung;
  UInternJN,UKopfJN,UFussJN,USummeJN,UButtonJN:Boolean;
  UInternHoeheAus,UKopfHoeheAus,UFussHoeheAus,USummeHoeheAus,UButtonHoeheAn:Integer;
  UInternHoeheAn,UKopfHoeheAn,UFussHoeheAn,USummeHoeheAn,UButtonHoeheAus:Integer;
  UPanelHeight,UGridHeight,URowCount,UZ,UFensterHeoheMin,
  UFensterBreiteMin,UFensterBreiteMax:Integer;
  UEnaF2,UEnaF4,UEnaF3,UEnaF5,UEnaF6,UEnaF8,UEnaF10:Boolean;
  UIhrZeichenJN:Boolean;UIhrZeichen:String;
  UDBZeiger:longint;
  UMwSt,UVKPreis:Double;
  UZeiger:longint;UZeigerNeu,UFensterBewegenAn:Boolean;
  UFocus,UModulart:string;
  UKopfrecht,UPosTextZeilen:integer;
  UFensterwidth:integer;
  UEinstellungNr,UModul_Nr:longint;
  UinternProjekt{,UArtikelAusSuchen}:Boolean;
  UEinstelllisteSammlung,UArtikelZurueck,Udruckerliste,UdruckerlisteNr:TStringList;
  UInterndruck,UFocusGrid:Boolean;
  UFarbenwechselFarbe1,UFarbenwechselFarbe2,UFarbenwechselFarbeSelect:String;UFarbenwechsel:Boolean;
  UFocusListe,UAltcurser,UHintAn:Boolean;
  UPoszeile_S1,UPoszeile_S2,UPoszeile_S3,UPoszeile_S4,UPoszeile_S5,UPoszeile_S6,UPoszeile_S7,UPoszeile_S8,UPoszeile_S9,UPoszeile_S10:Boolean;
  UPoszeile_N1,UPoszeile_N2,UPoszeile_N3,UPoszeile_N4,UPoszeile_N5,UPoszeile_N6,UPoszeile_N7,UPoszeile_N8,UPoszeile_N9,UPoszeile_N10:String;
  UPoszeile_AL1,UPoszeile_AL2,UPoszeile_AL3,UPoszeile_AL4,UPoszeile_AL5,UPoszeile_AL6,UPoszeile_AL7,UPoszeile_AL8,UPoszeile_AL9,UPoszeile_AL10:integer;
  UPoszeile_AO1,UPoszeile_AO2,UPoszeile_AO3,UPoszeile_AO4,UPoszeile_AO5,UPoszeile_AO6,UPoszeile_AO7,UPoszeile_AO8,UPoszeile_AO9,UPoszeile_AO10:integer;
  UPoszeile_L1,UPoszeile_L2,UPoszeile_L3,UPoszeile_L4,UPoszeile_L5,UPoszeile_L6,UPoszeile_L7,UPoszeile_L8,UPoszeile_L9,UPoszeile_L10:integer;
  UPoszeile_J1,UPoszeile_J2,UPoszeile_J3,UPoszeile_J4,UPoszeile_J5,UPoszeile_J6,UPoszeile_J7,UPoszeile_J8,UPoszeile_J9,UPoszeile_J10:integer;
  ULagerverwaltung:integer;ULagerverwaltungMenge:Real;
  UFdd20y,UDruckeSeite,USo:Integer;
  ULogo2x,ULogo2y,ULogo2dx,ULogo2dy:integer;
  UKopfzeileName:String;
  UStuecklisteJa,UPos_TextJa,UArtikelNeu:Boolean;
  UStuecklistenHoehe:Integer;
  UActivNameZurueck: TWinControl;
  UBerechnung1,UBerechnung2,UBerechnung3:String;
  UAGArtikel, UAGArtikelgruppe, UAGName1, UAGName2, UAGName3, UAGEinheit_EK, UAGEinheitMenge, UAGArtikelNr,  UAGBerechnungsArt:String;
  {UAGEK_Preis, UAGAufschlag,} UAGZahl1, UAGZahl2, UAGZahl3, UAGgewicht{, UAGRabatt}:Real;
  //UFrVK,UFrMwSt,UFrMwStBetrag,UFrVKPlusMwSt:String;
  //Fzeiger:longint;
  UErledigtNr:integer;
  UFarbenmenge,UFarbenArtikelgruppe,UFarbenPos_Nr:String;
implementation

uses UnitAdresse, UnitDatum,TempForm, UnitDammiForm, UnitModule, UnitDB,
  UnitMeldefenster, UnitMaskeProjekt, UnitEinstellungModulart,
  UnitGuppierung, UnitTextbaustein, UnitArtikelgruppe, UnitArtikel,
  UnitMaskeEinheit, UnitArtikelAussuchen, UnitStueckliste,UnitDataModul;

{$R *.DFM}

procedure TFormArtikelSammlung.ListeVerlassen(FActivControl: TWinControl);
Begin
  UActivNameZurueck:=FActivControl;
  ActiveControl:=DBEditBezeichnung;
  if QueryArtikelListe.Active then QueryArtikelListe.close;
End;

procedure TFormArtikelSammlung.ListeZurueck();
Begin
  //If FActivControl = nil then UActivNameZurueck
  //Showmessage(UActivNameZurueck.Name);
  //if UActivNameZurueck <> nil then ActiveControl:=UActivNameZurueck Else ActiveControl:=DBEditArtikelGruppe;
  if QueryArtikelListe.Active = False then QueryArtikelListe.open;
  if UActivNameZurueck <> nil then ActiveControl:=UActivNameZurueck Else ActiveControl:=DBEditArtikelGruppe;
End;



procedure TFormArtikelSammlung.ini;//Eingang/Ausgang
var FFelderWennNeu,FFelderWennNeuValue:String;
    i:integer;
    F_Sichtbar:Boolean;F_Name:String;F_AbstandLinks,F_AbstandOben,F_Laenge,F_justierung,F_Groesse,F_Style,F_Rahmen,F_Ena,F_h:integer;
    F_Schrift,F_Farbe,F_Berechnung:String;
    Year, Month, Day: Word;
    Fdatum:string;
    NewItem1: TMenuItem;
    FHauptModulNr:Integer;FHauptModulName:String;
    FNummer:integer;
begin
  UEinstelllisteSammlung:=TStringList.Create;
  Udruckerliste:=TStringList.Create;
  UdruckerlisteNr:=TStringList.Create;
  UArtikelZurueck:=TStringList.Create;
  //UActivNameZurueck:='DBEditProjekt'
  for i:=0 to 300 do UEinstelllisteSammlung.add('');
  for i:=0 to 5 do Udruckerliste.add('');
  // Einstellung suchen
  if QueryEinstellungModulart.Active then QueryEinstellungModulart.close;
  QueryEinstellungModulart.SQL.Clear;
  QueryEinstellungModulart.SQL.Add('Select * FROM EinstellungModulart WHERE Modulart = ' +'"'+ UModulart+'"');
  try
    QueryEinstellungModulart.Open
  except
  end;
  //Einstelung nicht gefunden
  if QueryEinstellungModulart.RecordCount < 1 Then
  begin
    QueryEinstellungModulart.close;
    FormPlanlos.Gzeiger:=DataModuleDB.DatensatzNeuMit('EinstellungModulart','Modulart','"'+ UModulart+'"');
    FormPlanlos.GzeigerNeu:=True;
    FormEinstellungModulart.ShowModal;
    if QueryEinstellungModulart.active then QueryEinstellungModulart.close;
    QueryEinstellungModulart.SQL.Clear;
    QueryEinstellungModulart.SQL.Add('Select * FROM EinstellungModulart WHERE Nr = ' + inttostr(FormPlanlos.Gzeiger));
    try
      QueryEinstellungModulart.Open
    except
    end;
  end;
  DBEditProjekt.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('internProjekt').ASInteger);
  LabelProjektName.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('internProjekt').ASInteger);
  DBEditAdresse.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('internadresse').ASInteger);
  LabelAdresse.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('internadresse').ASInteger);
  LabelBezeichnung.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('internBezeichnung').ASInteger);
  DBEditBezeichnung.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('internBezeichnung').ASInteger);
  LabelGruppe.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('internGruppierung').ASInteger);
  DBEditGruppierung.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('internGruppierung').ASInteger);
  DBMemoNotiz.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('internNotiz').ASInteger);
  LabelNotiz.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('internNotiz').ASInteger);
  DBMemoAdresse.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('KopfadressFeld').ASInteger);
  DBTextModulartKlein.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('KopfModulnr').ASInteger);
  LabellModulKleinNr.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('KopfModulnr').ASInteger);
  DBTextModul_Nr.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('KopfModulnr').ASInteger);
  LabelBearbeiter.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('KopfBearbeiter').ASInteger);
  DBEditBearbeiter.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('KopfBearbeiter').ASInteger);
  LabelErfassungsdatum.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('Kopfdatum').ASInteger);
  DBEditLetzteBearbeitung.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('Kopfdatum').ASInteger);
  LabelTransaktionsNr.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('Kopftranzaktionsnr').ASInteger);
  LabelTransaktionsNrNr.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('Kopftranzaktionsnr').ASInteger);
  DBMemoKopf.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('Kopftext').ASInteger);
  ButtonKopftext.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('Kopftext').ASInteger);
  DBEditKopfIhrZeichen.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('KopfIhrZeichen').ASInteger);
  LabelKopfihrZeichen.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('KopfIhrZeichen').ASInteger);
  DBMemoFuss.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('Fusstext').ASInteger);
  ButtonFusstext.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('Fusstext').ASInteger);
  DBTextModul.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('KopfModultext').ASInteger);
  LabelKopftext.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('ArtikelueberschriftEn').ASInteger);
  //DBCheckBoxGeaendert.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FSArtikelgeaendertEn').ASInteger);
  //DBMemoPosText.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FSPost_textEn').ASInteger);
  //DBTextArtikel.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FSArtikelartEn').ASInteger);
  //DBCheckBoxArtikelErledigt.Visible:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FSArtikelErledigtEn').ASInteger);
  If QueryEinstellungModulart.FieldByName('KopfIhrZeichenText').AsString <>'' then
    LabelKopfihrZeichen.caption:=QueryEinstellungModulart.FieldByName('KopfIhrZeichenText').AsString;
  If QueryEinstellungModulart.FieldByName('Artikelueberschrift').AsString <>'' then
     LabelKopftext.Caption:= QueryEinstellungModulart.FieldByName('Artikelueberschrift').AsString;

  UInternJN:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FensterInternAn').ASInteger);
  if DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('InternEn').ASInteger) = False then
  begin
    UInternJN:=False;GroupBoxIntern.Visible:=False;
  end
  Else
  begin
    UInternJN:=True;GroupBoxIntern.Visible:=True;
  end;
  UKopfJN:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FensterKopfAn').ASInteger);
  if DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('KopfEn').ASInteger) = False then
  begin
    UKopfJN:=False;GroupBoxKopf.Visible:=False;
  end
  Else
  begin
    UKopfJN:=True;GroupBoxKopf.Visible:=True;
  end;
  UFussJN:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FensterFussAn').ASInteger);
  if DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FussEn').ASInteger) = False then
  begin
    UFussJN:=False;GroupBoxFuss.Visible:=False;
  end
  Else
  begin
    UFussJN:=True;GroupBoxFuss.Visible:=True;
  end;
  USummeJN:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FensterSummeAn').ASInteger);
  if DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('SummeEn').ASInteger) = False then
  begin
    USummeJN:=False;GroupBoxSummen.Visible:=False;
  end
  Else
  begin
    USummeJN:=True;GroupBoxSummen.Visible:=True;
  end;
  UEinstellungNr:=QueryEinstellungModulart.Fields[0].Value;
  if QueryModul.Active then QueryModul.close;
  // Modul_Nr suchen -------------------------------------------------------------------------
  FHauptModulNr:=QueryEinstellungModulart.FieldByName('HauptModulNr').AsInteger;
  FHauptModulName:=QueryEinstellungModulart.FieldByName('HauptModulName').AsString;
  if FHauptModulNr=0 then begin FHauptModulNr:=QueryEinstellungModulart.FieldByName('Nr').AsInteger;FHauptModulName:=UModulart; End;
  if UZeigerNeu then //wenn neu
  begin
    {if QueryModul.active then QueryModul.close;
    QueryModul.sql.Clear;
    QueryModul.sql.add('Select * From Nummer Where HauptModulNr = '+ inttostr(FHauptModulNr)+' Order by ModulartNr');
    try
      QueryModul.open;//Self.Query1.Edit;
    finally
    end;
    QueryModul.FindLast;
    UModul_Nr:= QueryModul.FieldByName('ModulartNr').AsInteger + 1;
    QueryModul.close;}
    if QueryZListe.active then QueryZListe.close;
    QueryZListe.sql.Clear;
    QueryZListe.sql.add('Select * From Nummer Where HauptModulNr = '+ inttostr(FHauptModulNr)+' Order by ModulartNr');
    try
      QueryZListe.open;//Self.Query1.Edit;
    finally
    end;
    QueryZListe.FindLast;
    UModul_Nr:= QueryZListe.FieldByName('ModulartNr').AsInteger + 1;
    QueryZListe.close;
    //inttostr(Uzeiger)
    FNummer:=DataModuleDB.DatensatzNeuMit('Nummer','HauptModulNr,HauptModulName,NebenModulNr,NebenModulName,ModulartNr,ReadOnly','"'+inttostr(FHauptModulNr)+'","'+FHauptModulName+'","'+inttostr(FormPlanlos.Gzeiger)+'","'+UModulart+'","'+inttostr(UModul_Nr)+'","1"');
    //Test, ob Modulnr schon vorhanden. nocherledigen
    {if UModul_Nr <  QueryModul.RecordCount then Showmessage('gefundene '+UModulart+'  Nr ='+inttostr(UModul_Nr)+' nicht OK');}
  end;
  // Modul suchen -------------------------------------------------------------------------
  if UZeigerNeu then //wenn neu
  begin
    DecodeDate(Now, Year, Month, Day);
    FDatum:=IntToStr(Year)+'-'+IntToStr(Month)+'-'+IntToStr(Day);
    FFelderWennNeu:=QueryEinstellungModulart.FieldByName('FelderWennNeu').AsString;
    FFelderWennNeuValue:=QueryEinstellungModulart.FieldByName('FelderWennNeuValue').AsString;
    //Datetostr(FDatum)
    if FFelderWennNeu =''then Uzeiger:=DataModuleDB.DatensatzNeuMit('Module','Modulart,Erfassungsdatum,LetzteBearbeitung,Modul_Nr,Modulart_Nr','"'+Umodulart+'","'+FDatum+'","'+FDatum+'","'+inttostr(UModul_Nr)+'","'+inttostr(UEinstellungNr)+'"')
    else Uzeiger:=DataModuleDB.DatensatzNeuMit('Module',Modulart+',Erfassungsdatum,LetzteBearbeitung,'+FFelderWennNeu+'Modulart_Nr','"'+Umodulart+'","'+FDatum+'","'+FDatum+'",'+FFelderWennNeuValue+',"'+inttostr(UEinstellungNr)+'"');
    if QueryZListe.active then QueryZListe.close;
    QueryZListe.sql.Clear;
    QueryZListe.sql.add('Select * From Nummer Where Nr = '+ inttostr(FNummer));
    try
      QueryZListe.open;//Self.Query1.Edit;
    finally
    end;
    QueryZListe.edit;
    QueryZListe.FieldByName('NebenModulNr').AsInteger:=FNummer;
    QueryZListe.post;QueryZListe.close;
  end;
  QueryModul.sql.Clear;
  QueryModul.sql.add('Select * From Module Where nr = '+inttostr(Uzeiger));
  try
    QueryModul.open;//Self.Query1.Edit;
  finally
  end;
  //Showmessage('1');
  QueryModul.Edit;
  //GOffeneFenster:=GOffeneFenster+1;
  //if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte end
  //else begin
    top:=QueryEinstellungModulart.FieldByName('FensterTop').AsInteger;
    left:=QueryEinstellungModulart.FieldByName('FensterLeft').AsInteger;
  //end;
  //Artikelliste suchen
  if QueryArtikelListe.Active then QueryArtikelListe.close;
  QueryArtikelListe.sql.Clear;
  QueryArtikelListe.sql.add('Select * From ArtikelListe Where Modul_Nr = '+ inttostr(Uzeiger)+' Order by Pos_Nr');
  try
    QueryArtikelListe.open;//Self.Query1.Edit;
  finally
  end;
  QueryArtikelListe.edit;
  //Showmessage('1');
  //if UZeigerNeu=False then  UModul_Nr:=QueryEinstellungModulart.FieldByName('HauptModulNr').AsInteger;
  //Showmessage('2');
  FormArtikelSammlung.width:=QueryEinstellungModulart.FieldByName('Fensterwidth').AsInteger;
  FormArtikelSammlung.Height:=QueryEinstellungModulart.FieldByName('Fensterhoehe').AsInteger;
  UDBZeiger:=QueryEinstellungModulart.Fields[0].Value;
  UInternJN:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FensterInternAn').ASInteger);
  UKopfJN:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FensterKopfAn').ASInteger);
  UFussJN:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FensterFussAn').ASInteger);
  USummeJN:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FensterSummeAn').ASInteger);
  UButtonJN:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FensterButtonAn').ASInteger);
  UFensterHeoheMin:=QueryEinstellungModulart.FieldByName('FensterHoeheMin').AsInteger;//360;
  UFensterBreiteMin:=QueryEinstellungModulart.FieldByName('FensterBreiteMin').AsInteger;//517;
  UFensterBreiteMax:=QueryEinstellungModulart.FieldByName('FensterBreiteMax').AsInteger;//783;
  UMwSt:= QueryEinstellungModulart.FieldByName('MwSt').AsFloat;//16;
  UEnaF2:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('DatensatzNeu').ASInteger);
  UEnaF3:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('DatensatzAusgabe').ASInteger);
  UEnaF4:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('Datensatzsuchen').ASInteger);
  UEnaF5:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('DatensatzKopieren').ASInteger);
  UEnaF6:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('DatensatzAendern').ASInteger);
  UEnaF8:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('DatensatzLoeschen').ASInteger);
  UENaF10:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('DatensatzSpeichern').ASInteger);
  UFensterBewegenAn:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('FensterBreiteBewegenAn').ASInteger);
  UFensterwidth:=QueryEinstellungModulart.FieldByName('Fensterwidth').AsInteger;
  UFarbenwechselFarbe1:=QueryEinstellungModulart.FieldByName('FarbenwechselFarbe1').AsString;
  UFarbenwechselFarbe2:=QueryEinstellungModulart.FieldByName('FarbenwechselFarbe2').AsString;
  UFarbenwechselFarbeSelect:=QueryEinstellungModulart.FieldByName('FarbenwechselFarbeSelect').AsString;
  UFarbenwechsel:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('Farbenwechsel').ASInteger);
  ULagerverwaltung:=QueryEinstellungModulart.FieldByName('Lagerverwaltung').ASInteger;
  UErledigtNr:=QueryEinstellungModulart.FieldByName('ErledigtNr').ASInteger;
  //GMwst:=QueryEinstellungModulart.FieldByName('MwSt').ASInteger;
 { UPoszeile_S1:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('B_Sichtbar1').ASInteger);
  UPoszeile_S2:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('B_Sichtbar2').ASInteger);
  UPoszeile_S3:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('B_Sichtbar3').ASInteger);
  UPoszeile_S4:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('B_Sichtbar4').ASInteger);
  UPoszeile_S5:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('B_Sichtbar5').ASInteger);
  UPoszeile_S6:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('B_Sichtbar6').ASInteger);
  UPoszeile_S7:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('B_Sichtbar7').ASInteger);
  UPoszeile_S8:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('B_Sichtbar8').ASInteger);
  UPoszeile_S9:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('B_Sichtbar9').ASInteger);
  UPoszeile_S10:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('B_Sichtbar10').ASInteger);
  UPoszeile_N1:=QueryEinstellungModulart.FieldByName('B_Name1').AsString;
  UPoszeile_N2:=QueryEinstellungModulart.FieldByName('B_Name2').AsString;
  UPoszeile_N3:=QueryEinstellungModulart.FieldByName('B_Name3').AsString;
  UPoszeile_N4:=QueryEinstellungModulart.FieldByName('B_Name4').AsString;
  UPoszeile_N5:=QueryEinstellungModulart.FieldByName('B_Name5').AsString;
  UPoszeile_N6:=QueryEinstellungModulart.FieldByName('B_Name6').AsString;
  UPoszeile_N7:=QueryEinstellungModulart.FieldByName('B_Name7').AsString;
  UPoszeile_N8:=QueryEinstellungModulart.FieldByName('B_Name8').AsString;
  UPoszeile_N9:=QueryEinstellungModulart.FieldByName('B_Name9').AsString;
  UPoszeile_N10:=QueryEinstellungModulart.FieldByName('B_Name10').AsString;
  UPoszeile_AL1:=QueryEinstellungModulart.FieldByName('B_AbstandLinks1').AsInteger;
  UPoszeile_AL2:=QueryEinstellungModulart.FieldByName('B_AbstandLinks2').AsInteger;
  UPoszeile_AL3:=QueryEinstellungModulart.FieldByName('B_AbstandLinks3').AsInteger;
  UPoszeile_AL4:=QueryEinstellungModulart.FieldByName('B_AbstandLinks4').AsInteger;
  UPoszeile_AL5:=QueryEinstellungModulart.FieldByName('B_AbstandLinks5').AsInteger;
  UPoszeile_AL6:=QueryEinstellungModulart.FieldByName('B_AbstandLinks6').AsInteger;
  UPoszeile_AL7:=QueryEinstellungModulart.FieldByName('B_AbstandLinks7').AsInteger;
  UPoszeile_AL8:=QueryEinstellungModulart.FieldByName('B_AbstandLinks8').AsInteger;
  UPoszeile_AL9:=QueryEinstellungModulart.FieldByName('B_AbstandLinks9').AsInteger;
  UPoszeile_AL10:=QueryEinstellungModulart.FieldByName('B_AbstandLinks10').AsInteger;
  UPoszeile_AO1:=QueryEinstellungModulart.FieldByName('B_AbstandOben1').AsInteger;
  UPoszeile_AO2:=QueryEinstellungModulart.FieldByName('B_AbstandOben2').AsInteger;
  UPoszeile_AO3:=QueryEinstellungModulart.FieldByName('B_AbstandOben3').AsInteger;
  UPoszeile_AO4:=QueryEinstellungModulart.FieldByName('B_AbstandOben4').AsInteger;
  UPoszeile_AO5:=QueryEinstellungModulart.FieldByName('B_AbstandOben5').AsInteger;
  UPoszeile_AO6:=QueryEinstellungModulart.FieldByName('B_AbstandOben6').AsInteger;
  UPoszeile_AO7:=QueryEinstellungModulart.FieldByName('B_AbstandOben7').AsInteger;
  UPoszeile_AO8:=QueryEinstellungModulart.FieldByName('B_AbstandOben8').AsInteger;
  UPoszeile_AO9:=QueryEinstellungModulart.FieldByName('B_AbstandOben9').AsInteger;
  UPoszeile_AO10:=QueryEinstellungModulart.FieldByName('B_AbstandOben10').AsInteger;
  UPoszeile_L1:=QueryEinstellungModulart.FieldByName('B_Laenge1').AsInteger;
  UPoszeile_L2:=QueryEinstellungModulart.FieldByName('B_Laenge2').AsInteger;
  UPoszeile_L3:=QueryEinstellungModulart.FieldByName('B_Laenge3').AsInteger;
  UPoszeile_L4:=QueryEinstellungModulart.FieldByName('B_Laenge4').AsInteger;
  UPoszeile_L5:=QueryEinstellungModulart.FieldByName('B_Laenge5').AsInteger;
  UPoszeile_L6:=QueryEinstellungModulart.FieldByName('B_Laenge6').AsInteger;
  UPoszeile_L7:=QueryEinstellungModulart.FieldByName('B_Laenge7').AsInteger;
  UPoszeile_L8:=QueryEinstellungModulart.FieldByName('B_Laenge8').AsInteger;
  UPoszeile_L9:=QueryEinstellungModulart.FieldByName('B_Laenge9').AsInteger;
  UPoszeile_L10:=QueryEinstellungModulart.FieldByName('B_Laenge10').AsInteger;
  UPoszeile_J1:=QueryEinstellungModulart.FieldByName('B_Justierung1').AsInteger;
  UPoszeile_J2:=QueryEinstellungModulart.FieldByName('B_Justierung2').AsInteger;
  UPoszeile_J3:=QueryEinstellungModulart.FieldByName('B_Justierung3').AsInteger;
  UPoszeile_J4:=QueryEinstellungModulart.FieldByName('B_Justierung4').AsInteger;
  UPoszeile_J5:=QueryEinstellungModulart.FieldByName('B_Justierung5').AsInteger;
  UPoszeile_J6:=QueryEinstellungModulart.FieldByName('B_Justierung6').AsInteger;
  UPoszeile_J7:=QueryEinstellungModulart.FieldByName('B_Justierung7').AsInteger;
  UPoszeile_J8:=QueryEinstellungModulart.FieldByName('B_Justierung8').AsInteger;
  UPoszeile_J9:=QueryEinstellungModulart.FieldByName('B_Justierung9').AsInteger;
  UPoszeile_J10:=QueryEinstellungModulart.FieldByName('B_Justierung10').AsInteger;}
   DataModuleMyOffice.FmoNil(1);
  DataModuleMyOffice.FmoNil(2);
  DataModuleMyOffice.FmoNil(3);
  DataModuleMyOffice.FmoNil(4);
  DataModuleMyOffice.FmoNil(5);
  DataModuleMyOffice.FmoNil(6);
  DataModuleMyOffice.FmoNil(7);
  DataModuleMyOffice.FmoNil(8);
  DataModuleMyOffice.FmoNil(9);
  DataModuleMyOffice.FmoNil(10);
  DataModuleMyOffice.FmoNil(11);
  DataModuleMyOffice.FmoNil(12);
  DataModuleMyOffice.FmoNil(13);
  DataModuleMyOffice.FmoNil(14);
  DataModuleMyOffice.FmoNil(15);
  DataModuleMyOffice.FmoNil(16);
  DataModuleMyOffice.FmoNil(17);
  DataModuleMyOffice.FmoNil(18);
  DataModuleMyOffice.FmoNil(19);
  DataModuleMyOffice.FmoNil(20);
  DataModuleMyOffice.FmoGet(1,QueryEinstellungModulart.FieldByName('monitormaske1').AsString);
  DataModuleMyOffice.FmoGet(2,QueryEinstellungModulart.FieldByName('monitormaske2').AsString);
  DataModuleMyOffice.FmoGet(3,QueryEinstellungModulart.FieldByName('monitormaske3').AsString);
  DataModuleMyOffice.FmoGet(4,QueryEinstellungModulart.FieldByName('monitormaske4').AsString);
  DataModuleMyOffice.FmoGet(5,QueryEinstellungModulart.FieldByName('monitormaske5').AsString);
  DataModuleMyOffice.FmoGet(6,QueryEinstellungModulart.FieldByName('monitormaske6').AsString);
  DataModuleMyOffice.FmoGet(7,QueryEinstellungModulart.FieldByName('monitormaske7').AsString);
  DataModuleMyOffice.FmoGet(8,QueryEinstellungModulart.FieldByName('monitormaske8').AsString);
  DataModuleMyOffice.FmoGet(9,QueryEinstellungModulart.FieldByName('monitormaske9').AsString);
  DataModuleMyOffice.FmoGet(10,QueryEinstellungModulart.FieldByName('monitormaske10').AsString);
  DataModuleMyOffice.FmoGet(11,QueryEinstellungModulart.FieldByName('monitormaske11').AsString);
  DataModuleMyOffice.FmoGet(12,QueryEinstellungModulart.FieldByName('monitormaske12').AsString);
  DataModuleMyOffice.FmoGet(13,QueryEinstellungModulart.FieldByName('monitormaske13').AsString);
  DataModuleMyOffice.FmoGet(14,QueryEinstellungModulart.FieldByName('monitormaske14').AsString);
  DataModuleMyOffice.FmoGet(15,QueryEinstellungModulart.FieldByName('monitormaske15').AsString);
  DataModuleMyOffice.FmoGet(16,QueryEinstellungModulart.FieldByName('monitormaske16').AsString);
  DataModuleMyOffice.FmoGet(17,QueryEinstellungModulart.FieldByName('monitormaske17').AsString);
  DataModuleMyOffice.FmoGet(18,QueryEinstellungModulart.FieldByName('monitormaske18').AsString);
  DataModuleMyOffice.FmoGet(19,QueryEinstellungModulart.FieldByName('monitormaske19').AsString);
  DataModuleMyOffice.FmoGet(20,QueryEinstellungModulart.FieldByName('monitormaske20').AsString);
  DBEditPos_Nr.Visible:=False;
  DBEditArtikelGruppe.Visible:=False;
  DBEditArtikel.Visible:=False;
  DBEditMenge.Visible:=False;
  DBEditEinheitMenge.Visible:=False;
  DBEditEK_Preis.Visible:=False;
  DBEditEinheit_EK.Visible:=False;
  DBEditAufschlag.Visible:=False;
  DBEditVK_Preis.Visible:=False;
  DBEditBerechnungsArt.Visible:=False;
  DBEditGewicht.Visible:=False;
  DBEditZahl1.Visible:=False;
  DBEditZahl2.Visible:=False;
  DBEditZahl3.Visible:=False;
  DBEditRabatt.Visible:=False;
  DBEditArtikelNr.Visible:=False;
  DBEditBerechnen1.Visible:=False;
  DBEditBerechnen2.Visible:=False;
  DBEditBerechnen3.Visible:=False;
  F_h:=-1;
  for i:=1 to 20 do begin
    if i=1 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo1.Sichtbar);
                      F_Name:=Fmo1.Name;
                      F_AbstandLinks:=Fmo1.x;
                      F_AbstandOben:=Fmo1.y;
                      F_Laenge:=Fmo1.l;
                      F_justierung:=Fmo1.j;
                      F_Schrift:=Fmo1.Schrift;
                      F_Farbe:=Fmo1.Farbe;
                      F_Groesse:=Fmo1.Groesse;
                      F_Style:=Fmo1.Style;
                      F_Rahmen:=Fmo1.Rahmen;
                      F_Ena:=Fmo1.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo1.Berechnung;
    end;
    if i=2 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo2.Sichtbar);
                      F_Name:=Fmo2.Name;
                      F_AbstandLinks:=Fmo2.x;
                      F_AbstandOben:=Fmo2.y;
                      F_Laenge:=Fmo2.l;
                      F_justierung:=Fmo2.j;
                      F_Schrift:=Fmo2.Schrift;
                      F_Farbe:=Fmo2.Farbe;
                      F_Groesse:=Fmo2.Groesse;
                      F_Style:=Fmo2.Style;
                      F_Rahmen:=Fmo2.Rahmen;
                      F_Ena:=Fmo2.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo2.Berechnung;
    end;
    if i=3 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo3.Sichtbar);
                      F_Name:=Fmo3.Name;
                      F_AbstandLinks:=Fmo3.x;
                      F_AbstandOben:=Fmo3.y;
                      F_Laenge:=Fmo3.l;
                      F_justierung:=Fmo3.j;
                      F_Schrift:=Fmo3.Schrift;
                      F_Farbe:=Fmo3.Farbe;
                      F_Groesse:=Fmo3.Groesse;
                      F_Style:=Fmo3.Style;
                      F_Rahmen:=Fmo3.Rahmen;
                      F_Ena:=Fmo3.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo3.Berechnung;
    end;
    if i=4 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo4.Sichtbar);
                      F_Name:=Fmo4.Name;
                      F_AbstandLinks:=Fmo4.x;
                      F_AbstandOben:=Fmo4.y;
                      F_Laenge:=Fmo4.l;
                      F_justierung:=Fmo4.j;
                      F_Schrift:=Fmo4.Schrift;
                      F_Farbe:=Fmo4.Farbe;
                      F_Groesse:=Fmo4.Groesse;
                      F_Style:=Fmo4.Style;
                      F_Rahmen:=Fmo4.Rahmen;
                      F_Ena:=Fmo4.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo4.Berechnung;
    end;
    if i=5 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo5.Sichtbar);
                      F_Name:=Fmo5.Name;
                      F_AbstandLinks:=Fmo5.x;
                      F_AbstandOben:=Fmo5.y;
                      F_Laenge:=Fmo5.l;
                      F_justierung:=Fmo5.j;
                      F_Schrift:=Fmo5.Schrift;
                      F_Farbe:=Fmo5.Farbe;
                      F_Groesse:=Fmo5.Groesse;
                      F_Style:=Fmo5.Style;
                      F_Rahmen:=Fmo5.Rahmen;
                      F_Ena:=Fmo5.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo5.Berechnung;
    end;
    if i=6 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo6.Sichtbar);
                      F_Name:=Fmo6.Name;
                      F_AbstandLinks:=Fmo6.x;
                      F_AbstandOben:=Fmo6.y;
                      F_Laenge:=Fmo6.l;
                      F_justierung:=Fmo6.j;
                      F_Schrift:=Fmo6.Schrift;
                      F_Farbe:=Fmo6.Farbe;
                      F_Groesse:=Fmo6.Groesse;
                      F_Style:=Fmo6.Style;
                      F_Rahmen:=Fmo6.Rahmen;
                      F_Ena:=Fmo6.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo6.Berechnung;
    end;
    if i=7 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo7.Sichtbar);
                      F_Name:=Fmo7.Name;
                      F_AbstandLinks:=Fmo7.x;
                      F_AbstandOben:=Fmo7.y;
                      F_Laenge:=Fmo7.l;
                      F_justierung:=Fmo7.j;
                      F_Schrift:=Fmo7.Schrift;
                      F_Farbe:=Fmo7.Farbe;
                      F_Groesse:=Fmo7.Groesse;
                      F_Style:=Fmo7.Style;
                      F_Rahmen:=Fmo7.Rahmen;
                      F_Ena:=Fmo7.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo7.Berechnung;
    end;
    if i=8 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo8.Sichtbar);
                      F_Name:=Fmo8.Name;
                      F_AbstandLinks:=Fmo8.x;
                      F_AbstandOben:=Fmo8.y;
                      F_Laenge:=Fmo8.l;
                      F_justierung:=Fmo8.j;
                      F_Schrift:=Fmo8.Schrift;
                      F_Farbe:=Fmo8.Farbe;
                      F_Groesse:=Fmo8.Groesse;
                      F_Style:=Fmo8.Style;
                      F_Rahmen:=Fmo8.Rahmen;
                      F_Ena:=Fmo8.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo8.Berechnung;
    end;
    if i=9 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo9.Sichtbar);
                      F_Name:=Fmo9.Name;
                      F_AbstandLinks:=Fmo9.x;
                      F_AbstandOben:=Fmo9.y;
                      F_Laenge:=Fmo9.l;
                      F_justierung:=Fmo9.j;
                      F_Schrift:=Fmo9.Schrift;
                      F_Farbe:=Fmo9.Farbe;
                      F_Groesse:=Fmo9.Groesse;
                      F_Style:=Fmo9.Style;
                      F_Rahmen:=Fmo9.Rahmen;
                      F_Ena:=Fmo9.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo9.Berechnung;
    end;
    if i=10 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo10.Sichtbar);
                      F_Name:=Fmo10.Name;
                      F_AbstandLinks:=Fmo10.x;
                      F_AbstandOben:=Fmo10.y;
                      F_Laenge:=Fmo10.l;
                      F_justierung:=Fmo10.j;
                      F_Schrift:=Fmo10.Schrift;
                      F_Farbe:=Fmo10.Farbe;
                      F_Groesse:=Fmo10.Groesse;
                      F_Style:=Fmo10.Style;
                      F_Rahmen:=Fmo10.Rahmen;
                      F_Ena:=Fmo10.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo10.Berechnung;
    end;
    if i=11 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo11.Sichtbar);
                      F_Name:=Fmo11.Name;
                      F_AbstandLinks:=Fmo11.x;
                      F_AbstandOben:=Fmo11.y;
                      F_Laenge:=Fmo11.l;
                      F_justierung:=Fmo11.j;
                      F_Schrift:=Fmo11.Schrift;
                      F_Farbe:=Fmo11.Farbe;
                      F_Groesse:=Fmo11.Groesse;
                      F_Style:=Fmo11.Style;
                      F_Rahmen:=Fmo11.Rahmen;
                      F_Ena:=Fmo11.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo11.Berechnung;
    end;
    if i=12 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo12.Sichtbar);
                      F_Name:=Fmo12.Name;
                      F_AbstandLinks:=Fmo12.x;
                      F_AbstandOben:=Fmo12.y;
                      F_Laenge:=Fmo12.l;
                      F_justierung:=Fmo12.j;
                      F_Schrift:=Fmo12.Schrift;
                      F_Farbe:=Fmo12.Farbe;
                      F_Groesse:=Fmo12.Groesse;
                      F_Style:=Fmo12.Style;
                      F_Rahmen:=Fmo12.Rahmen;
                      F_Ena:=Fmo12.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo12.Berechnung;
    end;
    if i=13 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo13.Sichtbar);
                      F_Name:=Fmo13.Name;
                      F_AbstandLinks:=Fmo13.x;
                      F_AbstandOben:=Fmo13.y;
                      F_Laenge:=Fmo13.l;
                      F_justierung:=Fmo13.j;
                      F_Schrift:=Fmo13.Schrift;
                      F_Farbe:=Fmo13.Farbe;
                      F_Groesse:=Fmo13.Groesse;
                      F_Style:=Fmo13.Style;
                      F_Rahmen:=Fmo13.Rahmen;
                      F_Ena:=Fmo13.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo13.Berechnung;
    end;
    if i=14 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo14.Sichtbar);
                      F_Name:=Fmo14.Name;
                      F_AbstandLinks:=Fmo14.x;
                      F_AbstandOben:=Fmo14.y;
                      F_Laenge:=Fmo14.l;
                      F_justierung:=Fmo14.j;
                      F_Schrift:=Fmo14.Schrift;
                      F_Farbe:=Fmo14.Farbe;
                      F_Groesse:=Fmo14.Groesse;
                      F_Style:=Fmo14.Style;
                      F_Rahmen:=Fmo14.Rahmen;
                      F_Ena:=Fmo14.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo14.Berechnung;
    end;
    if i=15 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo15.Sichtbar);
                      F_Name:=Fmo15.Name;
                      F_AbstandLinks:=Fmo15.x;
                      F_AbstandOben:=Fmo15.y;
                      F_Laenge:=Fmo15.l;
                      F_justierung:=Fmo15.j;
                      F_Schrift:=Fmo15.Schrift;
                      F_Farbe:=Fmo15.Farbe;
                      F_Groesse:=Fmo15.Groesse;
                      F_Style:=Fmo15.Style;
                      F_Rahmen:=Fmo15.Rahmen;
                      F_Ena:=Fmo15.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo15.Berechnung;
    end;
    if i=16 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo16.Sichtbar);
                      F_Name:=Fmo16.Name;
                      F_AbstandLinks:=Fmo16.x;
                      F_AbstandOben:=Fmo16.y;
                      F_Laenge:=Fmo16.l;
                      F_justierung:=Fmo16.j;
                      F_Schrift:=Fmo16.Schrift;
                      F_Farbe:=Fmo16.Farbe;
                      F_Groesse:=Fmo16.Groesse;
                      F_Style:=Fmo16.Style;
                      F_Rahmen:=Fmo16.Rahmen;
                      F_Ena:=Fmo16.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo16.Berechnung;
    end;
    if i=17 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo17.Sichtbar);
                      F_Name:=Fmo17.Name;
                      F_AbstandLinks:=Fmo17.x;
                      F_AbstandOben:=Fmo17.y;
                      F_Laenge:=Fmo17.l;
                      F_justierung:=Fmo17.j;
                      F_Schrift:=Fmo17.Schrift;
                      F_Farbe:=Fmo17.Farbe;
                      F_Groesse:=Fmo17.Groesse;
                      F_Style:=Fmo17.Style;
                      F_Rahmen:=Fmo17.Rahmen;
                      F_Ena:=Fmo17.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo17.Berechnung;
    end;
    if i=18 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo18.Sichtbar);
                      F_Name:=Fmo18.Name;
                      F_AbstandLinks:=Fmo18.x;
                      F_AbstandOben:=Fmo18.y;
                      F_Laenge:=Fmo18.l;
                      F_justierung:=Fmo18.j;
                      F_Schrift:=Fmo18.Schrift;
                      F_Farbe:=Fmo18.Farbe;
                      F_Groesse:=Fmo18.Groesse;
                      F_Style:=Fmo18.Style;
                      F_Rahmen:=Fmo18.Rahmen;
                      F_Ena:=Fmo18.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo19.Berechnung;
    end;
    if i=19 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo19.Sichtbar);
                      F_Name:=Fmo19.Name;
                      F_AbstandLinks:=Fmo19.x;
                      F_AbstandOben:=Fmo19.y;
                      F_Laenge:=Fmo19.l;
                      F_justierung:=Fmo19.j;
                      F_Schrift:=Fmo19.Schrift;
                      F_Farbe:=Fmo19.Farbe;
                      F_Groesse:=Fmo19.Groesse;
                      F_Style:=Fmo19.Style;
                      F_Rahmen:=Fmo19.Rahmen;
                      F_Ena:=Fmo19.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo19.Berechnung;
    end;
    if i=20 then begin F_Sichtbar:=DataModuleMyOffice.IntToBol(Fmo20.Sichtbar);
                      F_Name:=Fmo20.Name;
                      F_AbstandLinks:=Fmo20.x;
                      F_AbstandOben:=Fmo20.y;
                      F_Laenge:=Fmo20.l;
                      F_justierung:=Fmo20.j;
                      F_Schrift:=Fmo20.Schrift;
                      F_Farbe:=Fmo20.Farbe;
                      F_Groesse:=Fmo20.Groesse;
                      F_Style:=Fmo20.Style;
                      F_Rahmen:=Fmo20.Rahmen;
                      F_Ena:=Fmo20.Ena;
                      If F_Sichtbar then F_h:=F_h+1;
                      F_Berechnung:=Fmo20.Berechnung;
    end;
    {f i=2 then begin F_Sichtbar:=UPoszeile_S2;F_Name:=UPoszeile_N2;F_AbstandLinks:=UPoszeile_AL2;F_AbstandOben:=UPoszeile_AO2;F_Laenge:=UPoszeile_L2;F_justierung:=UPoszeile_J2;end;
    if i=3 then begin F_Sichtbar:=UPoszeile_S3;F_Name:=UPoszeile_N3;F_AbstandLinks:=UPoszeile_AL3;F_AbstandOben:=UPoszeile_AO3;F_Laenge:=UPoszeile_L3;F_justierung:=UPoszeile_J3;end;
    if i=4 then begin F_Sichtbar:=UPoszeile_S4;F_Name:=UPoszeile_N4;F_AbstandLinks:=UPoszeile_AL4;F_AbstandOben:=UPoszeile_AO4;F_Laenge:=UPoszeile_L4;F_justierung:=UPoszeile_J4;end;
    if i=5 then begin F_Sichtbar:=UPoszeile_S5;F_Name:=UPoszeile_N5;F_AbstandLinks:=UPoszeile_AL5;F_AbstandOben:=UPoszeile_AO5;F_Laenge:=UPoszeile_L5;F_justierung:=UPoszeile_J5;end;
    if i=6 then begin F_Sichtbar:=UPoszeile_S6;F_Name:=UPoszeile_N6;F_AbstandLinks:=UPoszeile_AL6;F_AbstandOben:=UPoszeile_AO6;F_Laenge:=UPoszeile_L6;F_justierung:=UPoszeile_J6;end;
    if i=7 then begin F_Sichtbar:=UPoszeile_S7;F_Name:=UPoszeile_N7;F_AbstandLinks:=UPoszeile_AL7;F_AbstandOben:=UPoszeile_AO7;F_Laenge:=UPoszeile_L7;F_justierung:=UPoszeile_J7;end;
    if i=8 then begin F_Sichtbar:=UPoszeile_S8;F_Name:=UPoszeile_N8;F_AbstandLinks:=UPoszeile_AL8;F_AbstandOben:=UPoszeile_AO8;F_Laenge:=UPoszeile_L8;F_justierung:=UPoszeile_J8;end;
    if i=9 then begin F_Sichtbar:=UPoszeile_S9;F_Name:=UPoszeile_N9;F_AbstandLinks:=UPoszeile_AL9;F_AbstandOben:=UPoszeile_AO9;F_Laenge:=UPoszeile_L9;F_justierung:=UPoszeile_J9;end;
    if i=10 then begin F_Sichtbar:=UPoszeile_S10;F_Name:=UPoszeile_N10;F_AbstandLinks:=UPoszeile_AL10;F_AbstandOben:=UPoszeile_AO10;F_Laenge:=UPoszeile_L10;F_justierung:=UPoszeile_J10;end;
    if i=11 then begin F_Sichtbar:=UPoszeile_S10;F_Name:=UPoszeile_N10;F_AbstandLinks:=UPoszeile_AL10;F_AbstandOben:=UPoszeile_AO10;F_Laenge:=UPoszeile_L10;F_justierung:=UPoszeile_J10;end;
    if i=12 then begin F_Sichtbar:=UPoszeile_S10;F_Name:=UPoszeile_N10;F_AbstandLinks:=UPoszeile_AL10;F_AbstandOben:=UPoszeile_AO10;F_Laenge:=UPoszeile_L10;F_justierung:=UPoszeile_J10;end;
    if i=13 then begin F_Sichtbar:=UPoszeile_S10;F_Name:=UPoszeile_N10;F_AbstandLinks:=UPoszeile_AL10;F_AbstandOben:=UPoszeile_AO10;F_Laenge:=UPoszeile_L10;F_justierung:=UPoszeile_J10;end;
    if i=14 then begin F_Sichtbar:=UPoszeile_S10;F_Name:=UPoszeile_N10;F_AbstandLinks:=UPoszeile_AL10;F_AbstandOben:=UPoszeile_AO10;F_Laenge:=UPoszeile_L10;F_justierung:=UPoszeile_J10;end;
    if i=15 then begin F_Sichtbar:=UPoszeile_S10;F_Name:=UPoszeile_N10;F_AbstandLinks:=UPoszeile_AL10;F_AbstandOben:=UPoszeile_AO10;F_Laenge:=UPoszeile_L10;F_justierung:=UPoszeile_J10;end;
    if i=16 then begin F_Sichtbar:=UPoszeile_S10;F_Name:=UPoszeile_N10;F_AbstandLinks:=UPoszeile_AL10;F_AbstandOben:=UPoszeile_AO10;F_Laenge:=UPoszeile_L10;F_justierung:=UPoszeile_J10;end;
    if i=17 then begin F_Sichtbar:=UPoszeile_S10;F_Name:=UPoszeile_N10;F_AbstandLinks:=UPoszeile_AL10;F_AbstandOben:=UPoszeile_AO10;F_Laenge:=UPoszeile_L10;F_justierung:=UPoszeile_J10;end;
    if i=18 then begin F_Sichtbar:=UPoszeile_S10;F_Name:=UPoszeile_N10;F_AbstandLinks:=UPoszeile_AL10;F_AbstandOben:=UPoszeile_AO10;F_Laenge:=UPoszeile_L10;F_justierung:=UPoszeile_J10;end;
    if i=19 then begin F_Sichtbar:=UPoszeile_S10;F_Name:=UPoszeile_N10;F_AbstandLinks:=UPoszeile_AL10;F_AbstandOben:=UPoszeile_AO10;F_Laenge:=UPoszeile_L10;F_justierung:=UPoszeile_J10;end;
    if i=20 then begin F_Sichtbar:=UPoszeile_S10;F_Name:=UPoszeile_N10;F_AbstandLinks:=UPoszeile_AL10;F_AbstandOben:=UPoszeile_AO10;F_Laenge:=UPoszeile_L10;F_justierung:=UPoszeile_J10;end;}
    //UFarbenmenge:='clBlack';UFarbenArtikelgruppe:='clBlack';UFarbenPos_Nr:='clBlack';
    if F_Sichtbar then begin
      //Showmessage(F_Name+' '+DBEditArtikelGruppe.Field.FieldName);
      If F_Name = DBEditPos_Nr.Field.FieldName Then begin
        with DBEditPos_Nr do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
          UFarbenPos_Nr:=F_Farbe;
        end;
      end;
      If F_Name = DBEditArtikelGruppe.Field.FieldName Then begin
        with DBEditArtikelGruppe do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
          UFarbenArtikelgruppe:=F_Farbe;
        end;
      end;
      If F_Name = DBEditArtikel.Field.FieldName Then begin
        with DBEditArtikel do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditMenge.Field.FieldName Then begin
        with DBEditMenge do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
          UFarbenmenge:=F_Farbe;
        end;
      end;
      If F_Name = DBEditEinheitMenge.Field.FieldName Then begin
        with DBEditEinheitMenge do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditEK_Preis.Field.FieldName Then begin
        with DBEditEK_Preis do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditEinheit_EK.Field.FieldName Then begin
        with DBEditEinheit_EK do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditAufschlag.Field.FieldName Then begin
        with DBEditAufschlag do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditVK_Preis.Field.FieldName Then begin
        with DBEditVK_Preis do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          //if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditBerechnungsArt.Field.FieldName Then begin
        with DBEditBerechnungsArt do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditGewicht.Field.FieldName Then begin
        with DBEditGewicht do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditZahl1.Field.FieldName Then begin
        with DBEditZahl1 do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditZahl2.Field.FieldName Then begin
        with DBEditZahl2 do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditZahl3.Field.FieldName Then begin
        with DBEditZahl3 do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditRabatt.Field.FieldName Then begin
        with DBEditRabatt do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditArtikelNr.Field.FieldName Then begin
        with DBEditArtikelNr do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditBerechnen1.Field.FieldName Then begin
        with DBEditBerechnen1 do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          //if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
          UBerechnung1:=F_Berechnung;
        end;
      end;
      If F_Name = DBEditBerechnen2.Field.FieldName Then begin
        with DBEditBerechnen2 do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
          UBerechnung2:=F_Berechnung;
        end;
      end;
      If F_Name = DBEditBerechnen3.Field.FieldName Then begin
        with DBEditBerechnen3 do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
          UBerechnung3:=F_Berechnung;
        end;
      end;
      If F_Name = DBMemoPosText.Field.FieldName Then begin
        with DBMemoPosText do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Alignment:=taLeftJustify;
          if F_justierung=1 then Alignment:=taRightJustify;
          if F_justierung=2 then Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBTextArtikel.Field.FieldName Then begin
        with DBTextArtikel do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          //if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          //if F_Ena = 0 Then //ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBCheckBoxArtikelErledigt1.Field.FieldName Then begin
        with DBCheckBoxArtikelErledigt1 do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          //if F_justierung=0 then Field.Alignment:=taLeftJustify;
          //if F_justierung=1 then Field.Alignment:=taRightJustify;
          //if F_justierung=2 then Field.Alignment:=taCenter;
          //Font.Name:=F_Schrift; Font.Color:=F_Farbe; Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          //if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBCheckBoxArtikelErledigt2.Field.FieldName Then begin
        with DBCheckBoxArtikelErledigt2 do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          //if F_justierung=0 then Field.Alignment:=taLeftJustify;
          //if F_justierung=1 then Field.Alignment:=taRightJustify;
          //if F_justierung=2 then Field.Alignment:=taCenter;
          //Font.Name:=F_Schrift; Font.Color:=F_Farbe; Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          //if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBCheckBoxArtikelErledigt3.Field.FieldName Then begin
        with DBCheckBoxArtikelErledigt3 do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          //if F_justierung=0 then Field.Alignment:=taLeftJustify;
          //if F_justierung=1 then Field.Alignment:=taRightJustify;
          //if F_justierung=2 then Field.Alignment:=taCenter;
          //Font.Name:=F_Schrift; Font.Color:=F_Farbe; Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          //if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBCheckBoxArtikelErledigt4.Field.FieldName Then begin
        with DBCheckBoxArtikelErledigt4 do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          //if F_justierung=0 then Field.Alignment:=taLeftJustify;
          //if F_justierung=1 then Field.Alignment:=taRightJustify;
          //if F_justierung=2 then Field.Alignment:=taCenter;
          //Font.Name:=F_Schrift; Font.Color:=F_Farbe; Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          //if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      if F_Name = DBCheckBoxGeaendert.Field.FieldName Then begin
        with DBCheckBoxGeaendert do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          //{if F_justierung=0 then Field.Alignment:=taLeftJustify;
          //if F_justierung=1 then Field.Alignment:=taRightJustify;
          //if F_justierung=2 then Field.Alignment:=taCenter;
          //Font.Name:=F_Schrift; Font.Color:=F_Farbe; Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          //if F_Rahmen > 0 Then  DBCheckBoxGeaendert.BorderStyle:=bsSingle Else DBCheckBoxGeaendert.BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditName1.Field.FieldName Then begin
        with DBEditName1 do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      If F_Name = DBEditName2.Field.FieldName Then begin
        with DBEditName2 do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
      if F_Name = DBEditName3.Field.FieldName Then begin
        with DBEditName2 do begin
          Visible:=True;Left:=F_AbstandLinks;Top:=F_AbstandOben;Width:=F_Laenge;
          if F_justierung=0 then Field.Alignment:=taLeftJustify;
          if F_justierung=1 then Field.Alignment:=taRightJustify;
          if F_justierung=2 then Field.Alignment:=taCenter;
          Font.Name:=F_Schrift; Font.Color:=stringtoColor(F_Farbe); Font.Size:=F_Groesse; Font.Style:=DataModuleMyOffice.IntToStyle(F_Style);
          if F_Rahmen > 0 Then  BorderStyle:=bsSingle Else BorderStyle:=bsNone;
          if F_Ena = 0 Then ReadOnly:=True Else ReadOnly:=False;
          TabOrder:=F_h;
        end;
      end;
    end;
  end;
  UPosTextZeilen:=QueryEinstellungModulart.FieldByName('PosTextZeilen').AsInteger;
  ComboBoxPostext.text:=inttostr(UPosTextZeilen);
  UInternHoeheAus:=17; UInternHoeheAn:=108;
  UKopfHoeheAus:=17;  UKopfHoeheAn:=182;
  UFussHoeheAus:=17;  UFussHoeheAn:=89;
  USummeHoeheAus:=23; USummeHoeheAn:=94;
  UButtonHoeheAus:=17;UButtonHoeheAn:=56;
  UGridHeight:=88;
  UPanelHeight:=45;
  URowCount:=3;
  UZ:=3;
  UKopfrecht:=304;
  DBCtrlGridArtikel.AllowInsert:=False;
  DBCtrlGridArtikel.AllowDelete:=False;

  GProjekt_Nr:=QueryModul.FieldByName('Projekt_Nr').AsInteger;
  GModulart_Nr:=QueryEinstellungModulart.FieldByName('Nr').AsInteger;
  GBeziehungs_Nr:=QueryEinstellungModulart.FieldByName('Beziehungs_Nr').AsInteger;
  GSonstigeSQLGruppe:='';GSonstigeSQLArtikel1:='';GSonstigeSQLArtikel2:='';
  GBeziehungs_Name:=QueryEinstellungModulart.FieldByName('Beziehungs_Name').AsString;
  GModulart_Name:=QueryEinstellungModulart.FieldByName('Modulart').AsString;
  UHintAn:=False;
  //UArtikelAusSuchen:=True;ASInteger);
  UEinstelllisteSammlung[0]:=QueryEinstellungModulart.FieldByName('AAWidth').AsString;
  UEinstelllisteSammlung[1]:=QueryEinstellungModulart.FieldByName('AARahmenbeite').AsString;
  UEinstelllisteSammlung[2]:=QueryEinstellungModulart.FieldByName('AAGruppeSpaltenbreite1').AsString;
  UEinstelllisteSammlung[3]:=QueryEinstellungModulart.FieldByName('AAGruppeSpaltenbreite2').AsString;
  UEinstelllisteSammlung[4]:=QueryEinstellungModulart.FieldByName('AADBGridGruppeLeft').AsString;
  UEinstelllisteSammlung[5]:=QueryEinstellungModulart.FieldByName('AADBGridGruppeBreite').AsString;
  UEinstelllisteSammlung[6]:=QueryEinstellungModulart.FieldByName('AAArtikelSpaltenbreite1').AsString;
  UEinstelllisteSammlung[7]:=QueryEinstellungModulart.FieldByName('AAArtikelSpaltenbreite2').AsString;

  UEinstelllisteSammlung[8]:=QueryEinstellungModulart.FieldByName('AASQLFilterGruppe1').AsString;
  UEinstelllisteSammlung[9]:=QueryEinstellungModulart.FieldByName('AASQLFilterGruppe2').AsString;
  UEinstelllisteSammlung[10]:=QueryEinstellungModulart.FieldByName('AASQLFilterGruppe3').AsString;
  UEinstelllisteSammlung[11]:=QueryEinstellungModulart.FieldByName('AASQLFilterGruppe4').AsString;
  UEinstelllisteSammlung[12]:=QueryEinstellungModulart.FieldByName('AASQLFilterGruppe5').AsString;
  UEinstelllisteSammlung[13]:=QueryEinstellungModulart.FieldByName('AASQLFilterGruppe6').AsString;
  UEinstelllisteSammlung[14]:=QueryEinstellungModulart.FieldByName('AASQLFilterGruppe7').AsString;
  UEinstelllisteSammlung[15]:=QueryEinstellungModulart.FieldByName('AASQLFilterGruppe8').AsString;
  UEinstelllisteSammlung[16]:=QueryEinstellungModulart.FieldByName('AASQLFilterArtikel1').AsString;
  UEinstelllisteSammlung[17]:=QueryEinstellungModulart.FieldByName('AASQLFilterArtikel2').AsString;
  UEinstelllisteSammlung[18]:=QueryEinstellungModulart.FieldByName('AASQLFilterArtikel3').AsString;
  UEinstelllisteSammlung[19]:=QueryEinstellungModulart.FieldByName('AASQLFilterArtikel4').AsString;
  UEinstelllisteSammlung[20]:=QueryEinstellungModulart.FieldByName('AASQLFilterArtikel5').AsString;
  UEinstelllisteSammlung[21]:=QueryEinstellungModulart.FieldByName('AASQLFilterArtikel6').AsString;
  UEinstelllisteSammlung[22]:=QueryEinstellungModulart.FieldByName('AASQLFilterArtikel7').AsString;
  UEinstelllisteSammlung[23]:=QueryEinstellungModulart.FieldByName('AASQLFilterArtikel8').AsString;
  UEinstelllisteSammlung[24]:=QueryEinstellungModulart.FieldByName('AAEnaF2').AsString;
  UEinstelllisteSammlung[25]:=QueryEinstellungModulart.FieldByName('AAEnaF3').AsString;
  UEinstelllisteSammlung[26]:=QueryEinstellungModulart.FieldByName('AAEnaF4').AsString;
  UEinstelllisteSammlung[27]:=QueryEinstellungModulart.FieldByName('AAEnaF5').AsString;
  UEinstelllisteSammlung[28]:=QueryEinstellungModulart.FieldByName('AAEnaF6').AsString;
  UEinstelllisteSammlung[29]:=QueryEinstellungModulart.FieldByName('AAEnaF7').AsString;
  UEinstelllisteSammlung[30]:=QueryEinstellungModulart.FieldByName('AAEnaF8').AsString;
  UEinstelllisteSammlung[31]:=QueryEinstellungModulart.FieldByName('AAEnaF9').AsString;
  UEinstelllisteSammlung[32]:=QueryEinstellungModulart.FieldByName('AAErledigtArtikelAusSchal').AsString;
  UEinstelllisteSammlung[33]:=QueryEinstellungModulart.FieldByName('AAMarkiernZeigenAn').AsString;
  UEinstelllisteSammlung[34]:=QueryEinstellungModulart.FieldByName('AAErledigtArtikelAn').AsString;
  UEinstelllisteSammlung[35]:=QueryEinstellungModulart.FieldByName('AAEnaButton1').AsString;
  UEinstelllisteSammlung[36]:=QueryEinstellungModulart.FieldByName('AAEnaButton2').AsString;
  UEinstelllisteSammlung[37]:=QueryEinstellungModulart.FieldByName('AAEnaButton3').AsString;
  UEinstelllisteSammlung[38]:=QueryEinstellungModulart.FieldByName('AAEnaButton4').AsString;
  UEinstelllisteSammlung[39]:=QueryEinstellungModulart.FieldByName('AAEnaButton5').AsString;
  UEinstelllisteSammlung[40]:=QueryEinstellungModulart.FieldByName('AAEnaButton6').AsString;
  UEinstelllisteSammlung[41]:=QueryEinstellungModulart.FieldByName('AAEnaButton7').AsString;
  UEinstelllisteSammlung[42]:=QueryEinstellungModulart.FieldByName('AAEnaButton8').AsString;
  UEinstelllisteSammlung[43]:=QueryEinstellungModulart.FieldByName('AACaption1').AsString;
  UEinstelllisteSammlung[44]:=QueryEinstellungModulart.FieldByName('AACaption2').AsString;
  UEinstelllisteSammlung[45]:=QueryEinstellungModulart.FieldByName('AACaption3').AsString;
  UEinstelllisteSammlung[46]:=QueryEinstellungModulart.FieldByName('AACaption4').AsString;
  UEinstelllisteSammlung[47]:=QueryEinstellungModulart.FieldByName('AACaption5').AsString;
  UEinstelllisteSammlung[48]:=QueryEinstellungModulart.FieldByName('AACaption6').AsString;
  UEinstelllisteSammlung[49]:=QueryEinstellungModulart.FieldByName('AACaption7').AsString;
  UEinstelllisteSammlung[50]:=QueryEinstellungModulart.FieldByName('AACaption8').AsString;



  UEinstelllisteSammlung[51]:=QueryEinstellungModulart.FieldByName('AATop').AsString;
  UEinstelllisteSammlung[52]:=QueryEinstellungModulart.FieldByName('AALeft').AsString;
  UEinstelllisteSammlung[53]:=QueryEinstellungModulart.FieldByName('AAButtonNr').AsString;
  UEinstelllisteSammlung[54]:=QueryEinstellungModulart.FieldByName('ErledigtNr').AsString;




  //von 0 bis 60 für die allgemeinen einstellungen in artikel aussuchen
  //von 61 bis 300 für die Buttons in Artikel aussuchen
  // von 300 bis 310 ist von Artikel Sammlung für Artikel aussuchen bestimmt(Kunde Lieeferand also aus DB oder Variablen)


  //Drukermasken laden;
  Udruckerliste.clear;
  UdruckerlisteNr.clear;
  if (QueryEinstellungModulart.FieldByName('druckermaske1').AsString <> 'leer') then if (QueryEinstellungModulart.FieldByName('druckermaske1').AsString <> '') Then begin Udruckerliste.add(QueryEinstellungModulart.FieldByName('druckermaske1').AsString);UdruckerlisteNr.add(QueryEinstellungModulart.FieldByName('druckermaskeNr1').AsString);end;
  if (QueryEinstellungModulart.FieldByName('druckermaske2').AsString <> 'leer') then if (QueryEinstellungModulart.FieldByName('druckermaske2').AsString <> '') Then begin Udruckerliste.add(QueryEinstellungModulart.FieldByName('druckermaske2').AsString);UdruckerlisteNr.add(QueryEinstellungModulart.FieldByName('druckermaskeNr2').AsString);end;
  if (QueryEinstellungModulart.FieldByName('druckermaske3').AsString <> 'leer') then if (QueryEinstellungModulart.FieldByName('druckermaske3').AsString <> '') Then begin Udruckerliste.add(QueryEinstellungModulart.FieldByName('druckermaske3').AsString);UdruckerlisteNr.add(QueryEinstellungModulart.FieldByName('druckermaskeNr3').AsString);end;
  if (QueryEinstellungModulart.FieldByName('druckermaske4').AsString <> 'leer') then if (QueryEinstellungModulart.FieldByName('druckermaske4').AsString <> '') Then begin Udruckerliste.add(QueryEinstellungModulart.FieldByName('druckermaske4').AsString);UdruckerlisteNr.add(QueryEinstellungModulart.FieldByName('druckermaskeNr4').AsString);end;
  if (QueryEinstellungModulart.FieldByName('druckermaske5').AsString <> 'leer') then if (QueryEinstellungModulart.FieldByName('druckermaske5').AsString <> '') Then begin Udruckerliste.add(QueryEinstellungModulart.FieldByName('druckermaske5').AsString);UdruckerlisteNr.add(QueryEinstellungModulart.FieldByName('druckermaskeNr5').AsString);end;
  if (QueryEinstellungModulart.FieldByName('druckermaske6').AsString <> 'leer') then if (QueryEinstellungModulart.FieldByName('druckermaske6').AsString <> '') Then begin Udruckerliste.add(QueryEinstellungModulart.FieldByName('druckermaske6').AsString);UdruckerlisteNr.add(QueryEinstellungModulart.FieldByName('druckermaskeNr6').AsString);end;
  GZeigerFuerSonstiges:=Uzeiger;
  //Showmessage(Udruckerliste[0]);
  //Showmessage(inttostr(Udruckerliste.Count));
  //PopupMenuAusgabe.Items.

  for i:=0 to PopupMenuAusgabe.Items.Count-1 do PopupMenuAusgabe.Items.Delete(0);
  {if PopupMenuAusgabe.Items.Count>0 then  begin
    PopupMenuAusgabe.Items.Delete(0);
    PopupMenuAusgabe.Items.Delete(1);
  end;}
  for i:=0 to Udruckerliste.Count-1 do begin
    NewItem1 := TMenuItem.Create(Self);
    NewItem1.Caption :=Udruckerliste[i];
    PopupMenuAusgabe.Items.Add(NewItem1);
    PopupMenuAusgabe.Items[i].OnClick:=PopupMenuAusgabeClick;
  end;
  //Drukermasken laden;
  QueryEinstellungModulart.close;
   if UEnaF2 = False then  ButtonNeu.Enabled:=False  else ButtonNeu.Enabled:=true;
   if UEnaF3 = False then  ButtonAusgabe.Enabled:=False  else ButtonAusgabe.Enabled:=True;
   if UEnaF4 = False then  ButtonSuchen.Enabled:=False  else ButtonSuchen.Enabled:=True;
   if UEnaF5 = False then  ButtonKopieren.Enabled:=False  else ButtonKopieren.Enabled:=True;
   if UEnaF6 = False then  ButtonAendern.Enabled:=False  else ButtonAendern.Enabled:=True;
   if UEnaF8 = False then  ButtonLoeschen.Enabled:=False  else ButtonLoeschen.Enabled:=True;
   if UEnaF10 = False then ButtonSpeichern.Enabled:=False  else ButtonSpeichern.Enabled:=True;
   PosTextZeilen;
   LabelTransaktionsNrNr.Caption:=inttostr(FormPlanlos.GLandNr)+' # '+ inttostr(FormPlanlos.GFirmaNr)+' # '+ inttostr(Uzeiger);
  DBCtrlGridArtikelExit(Self);
  anzeigeneu;
  if UZeigerNeu then begin
    if (GroupBoxIntern.Visible) and (DBEditBezeichnung.Visible) then begin
      UInternJN:=True;anzeigeNeu;ActiveControl:=DBEditBezeichnung;
    end;
  end
  Else begin
    if DBEditArtikelGruppe.Visible then ActiveControl:=DBEditArtikelGruppe Else ActiveControl:=DBEditArtikel;
    DBCtrlGridArtikelEnter(Self);
    Focus;//Einstzelungen für Artikel aussuchen;
    //ButtonNeuClick(self);
  end;
  FormArtikelSammlung.width:=UFensterWidth;
  UFocusGrid:=True;
end;

procedure TFormArtikelSammlung.PosTextZeilen;//Bedienung
Var zeilen:integer;
begin
zeilen:=strtoint(ComboBoxPostext.text);
  case zeilen of
       0:  begin UPanelHeight:=20;DBMemoPosText.Height:=0;  end;
       1:  begin UPanelHeight:=40;DBMemoPosText.Height:=14;  end;
       2:  begin UPanelHeight:=51;DBMemoPosText.Height:=27;  end;
       3:  begin UPanelHeight:=63;DBMemoPosText.Height:=40;  end;
       5:  begin UPanelHeight:=90;DBMemoPosText.Height:=66;  end;
       8:  begin UPanelHeight:=129;DBMemoPosText.Height:=104;  end;
      12:  begin UPanelHeight:=182;DBMemoPosText.Height:=157;  end;
  else
    UPanelHeight:=45;
  end;
anzeigeNeu;
end;

procedure TFormArtikelSammlung.summierung(FEinstellung:integer);//Bedienung
var i:integer;
    SEK_Preis,SEKPreis,SVKPreis,SVK_Preis,M_preis,D_preis,F_preis,S_preis,M_preisVK,D_preisVK,F_preisVK,S_preisVK,G,Z1,Z2,Z3:Double;
    //SEKPreis und SAufschlag sind Zwischenwerte
    SBerechnung1,SBerechnung2,SBerechnung3:Double;
    SRabatt,SAufschlag,S_Rabatt,S_Aufschlag:Double;
    Kostenart:char;
    FAufschlag:Double;
    FTempPos: integer;
    FMenge,FTemp:Double;
begin
    //FAufschlag:=QueryStueckliste.FieldByName('Aufschlag').AsFloat;
    if (CheckBoxSummenSofort.Checked) or (USummenButtonAn) then
    begin
      if QuerySumme.Active then QuerySumme.close;
      QuerySumme.sql.Clear;
      QuerySumme.sql.add(QueryArtikelListe.SQL.Strings[0]);
      try
        QuerySumme.open;//Self.Query1.Edit;
      finally
      end;
      SEK_Preis:=0;//Summierung von EK
      SVK_Preis:=0;//Summierung von VK
      S_Aufschlag:=0;//Tatsächlicher aufschlag in der ganzen Stückliste
      S_Rabatt:=0;
      M_preis:=0;D_preis:=0;F_preis:=0;S_preis:=0;
      M_preisVK:=0;D_preisVK:=0;F_preisVK:=0;S_preisVK:=0;
      G:=0;Z1:=0;Z2:=0;Z3:=0;
      SBerechnung1:=0;SBerechnung2:=0;SBerechnung3:=0;
      if (QuerySumme.RecordCount > 0) Then
      begin
        QuerySumme.First;
        for i := 1 to QuerySumme.RecordCount do
        begin
          SAufschlag:=0;//Temporär für den Datensatz
          SEKPreis:=0;//Temporär für den Datensatz
          SVKPreis:=0;//Temporär für den Datensatz
          SRabatt:=0;//Temporär für den Datensatz
          if QuerySumme.FieldByName('VK_Preis').AsFloat <> 0.0 then
          begin
            SVKPreis:=QuerySumme.FieldByName('VK_Preis').AsFloat;
            SVK_Preis:=SVK_Preis+SVKPreis;

            SRabatt:=SVKPreis/(100-QuerySumme.FieldByName('Rabatt').AsFloat)*QuerySumme.FieldByName('Rabatt').AsFloat;
            S_Rabatt:=S_Rabatt+SRabatt;

            SAufschlag:=((SVKPreis+SRabatt)/(100+QuerySumme.FieldByName('Aufschlag').AsFloat))*QuerySumme.FieldByName('Aufschlag').AsFloat;
            S_Aufschlag:=S_Aufschlag+SAufschlag;

            SEKPreis:=SVKPreis+SRabatt-SAufschlag;
            SEK_Preis:=SEK_Preis+SEKPreis;

            FMenge:=QuerySumme.FieldByName('Menge').AsFloat;

            SBerechnung1:=SBerechnung1+QuerySumme.FieldByName('Berechnen1').AsFloat;
            SBerechnung2:=SBerechnung2+QuerySumme.FieldByName('Berechnen2').AsFloat;
            SBerechnung2:=SBerechnung2+QuerySumme.FieldByName('Berechnen3').AsFloat;

            if QuerySumme.FieldByName('KostenArt').AsString = 'M' then Kostenart:='M';
            if QuerySumme.FieldByName('KostenArt').AsString = 'D' then Kostenart:='D';
            if QuerySumme.FieldByName('KostenArt').AsString = 'F' then Kostenart:='F';
            if QuerySumme.FieldByName('KostenArt').AsString = 'S' then Kostenart:='S';
            if QuerySumme.FieldByName('KostenArt').AsString = 'G' then Kostenart:='G';//Stückliste
            case KostenArt of
             'D' : D_preis:=D_preis+SEKPreis;
             'F' : F_preis:=F_preis+SEKPreis;//SEKPreis*FMenge);//SEKPreis;
             'S' : S_preis:=S_preis+SEKPreis;
             'G' : begin
                     D_preis:=D_preis+(QuerySumme.FieldByName('Dienstleistung').AsFloat*FMenge);
                     F_preis:=F_preis+(QuerySumme.FieldByName('Fremdleistung').AsFloat*FMenge);
                     S_preis:=S_preis+(QuerySumme.FieldByName('Sonstigeleistung').AsFloat*FMenge);
                     M_preis:=M_preis+(QuerySumme.FieldByName('Materialleistung').AsFloat*FMenge);
                   end;
             else  M_preis:=M_preis+SEKPreis;
            end;
            case KostenArt of
             'D' : D_preisVK:=D_preisVK+SVKPreis;
             'F' : F_preisVK:=F_preisVK+SVKPreis;
             'S' : S_preisVK:=S_preisVK+SVKPreis;
             'G' : begin
                     FTemp:=(QuerySumme.FieldByName('Dienstleistung').AsFloat*FMenge)+(QuerySumme.FieldByName('DieAufschlag').AsFloat*FMenge);
                     D_preisVK:=D_preisVK+(FTemp/100*(100-QuerySumme.FieldByName('Rabatt').AsFloat));

                     FTemp:=(QuerySumme.FieldByName('Fremdleistung').AsFloat*FMenge)+(QuerySumme.FieldByName('FreAufschlag').AsFloat*FMenge);
                     F_preisVK:=F_preisVK+(FTemp/100*(100-QuerySumme.FieldByName('Rabatt').AsFloat));

                     FTemp:=(QuerySumme.FieldByName('Sonstigeleistung').AsFloat*FMenge)+(QuerySumme.FieldByName('SonAufschlag').AsFloat*FMenge);
                     S_preisVK:=S_preisVK+(FTemp/100*(100-QuerySumme.FieldByName('Rabatt').AsFloat));

                     FTemp:=(QuerySumme.FieldByName('Materialleistung').AsFloat*FMenge)+(QuerySumme.FieldByName('MatAufschlag').AsFloat*FMenge);
                     M_preisVK:=M_preisVK+(FTemp/100*(100-QuerySumme.FieldByName('Rabatt').AsFloat));
                   end;
             else  M_preisVK:=M_preisVK+SVKPreis;
            end;
            G:=G+QuerySumme.FieldByName('Gewicht').AsFloat*QuerySumme.FieldByName('Menge').AsFloat;
            Z1:=Z1+QuerySumme.FieldByName('Zahl1').AsFloat*QuerySumme.FieldByName('Menge').AsFloat;
            Z2:=Z2+QuerySumme.FieldByName('Zahl2').AsFloat*QuerySumme.FieldByName('Menge').AsFloat;
            Z3:=Z3+QuerySumme.FieldByName('Zahl3').AsFloat*QuerySumme.FieldByName('Menge').AsFloat;
            QuerySumme.Next;
          end;
        end;
        UVKPreis:=Strtofloat(FormatFloat('0.00' ,SVK_Preis));
        LabelEVK_Preis.Caption:=FloattoStrF(SVK_Preis,ffNumber,10,2);
        LabelEMwSt.Caption:='+ '+Floattostr(UMwSt)+'% MwSt   '+FloattoStrF(SVK_Preis/100*UMwSt,ffNumber,10,2);
        LabelEPreis.Caption:=FloattoStrF((SVK_Preis/100*UMwSt)+SVK_Preis,ffNumber,10,2);
        //Leistungen
        LabelM.Caption:=FloattoStrF(M_Preis,ffNumber,10,2);
        LabelD.Caption:=FloattoStrF(D_Preis,ffNumber,10,2);
        LabelF.Caption:=FloattoStrF(F_Preis,ffNumber,10,2);
        LabelS.Caption:=FloattoStrF(S_Preis,ffNumber,10,2);
        LabelG.Caption:=FloattoStrF(g,ffNumber,10,2);
        LabelMVK.Caption:=FloattoStrF(M_PreisVK,ffNumber,10,2);
        LabelDVK.Caption:=FloattoStrF(D_PreisVK,ffNumber,10,2);
        LabelFVK.Caption:=FloattoStrF(F_PreisVK,ffNumber,10,2);
        LabelSVK.Caption:=FloattoStrF(S_PreisVK,ffNumber,10,2);
        LabelMAufschlag.Caption:=FloattoStrF(M_PreisVK-M_Preis,ffNumber,10,2);
        LabelDAufschlag.Caption:=FloattoStrF(D_PreisVK-D_Preis,ffNumber,10,2);
        LabelFAufschlag.Caption:=FloattoStrF(F_PreisVK-F_Preis,ffNumber,10,2);
        LabelSSAufschlag.Caption:=FloattoStrF(S_PreisVK-S_Preis,ffNumber,10,2);
        //Allgemein
        LabelZ1.Caption:=FloattoStrF(Z1,ffNumber,10,2);
        LabelZ2.Caption:=FloattoStrF(Z2,ffNumber,10,2);
        LabelZ3.Caption:=FloattoStrF(Z3,ffNumber,10,2);
        LabelZ_1Einheit.Caption:=GEinheitZahl1;
        LabelZ_2Einheit.Caption:=GEinheitZahl2;
        LabelZ_3Einheit.Caption:=GEinheitZahl3;
        LabelZ_1.Caption:=GName1;
        LabelZ_2.Caption:=GName2;
        LabelZ_3.Caption:=GName3;
        //Intern
        LabelSBerechnung1.Caption:=FloattoStrF(SBerechnung1,ffNumber,10,2);
        LabelSBerechnung2.Caption:=FloattoStrF(SBerechnung2,ffNumber,10,2);
        LabelSBerechnung3.Caption:=FloattoStrF(SBerechnung3,ffNumber,10,2);
        if SVK_Preis <> 0.0 Then begin
          LabelSPBerechnung1.Caption:=FloattoStrF(100/SVK_Preis*SBerechnung1,ffNumber,10,2);
          LabelSPBerechnung2.Caption:=FloattoStrF(100/SVK_Preis*SBerechnung2,ffNumber,10,2);
          LabelSPBerechnung3.Caption:=FloattoStrF(100/SVK_Preis*SBerechnung3,ffNumber,10,2);
          LabelSEK_Preis.Caption:=FloattoStrF(SEK_Preis,ffNumber,10,2);
          LabelSPEK_Preis.Caption:=FloattoStrF(100/SVK_Preis*SEK_Preis,ffNumber,10,2);
          LabelSAufschlag.Caption:=FloattoStrF(S_Aufschlag,ffNumber,10,2);
          LabelSPAufschlag.Caption:=FloattoStrF(100/(SVK_Preis+S_Rabatt-S_Aufschlag)*S_Aufschlag,ffNumber,10,2);
          LabelSRabatt.Caption:=FloattoStrF(S_Rabatt,ffNumber,10,2);
          LabelSPRabatt.Caption:=FloattoStrF(100/(SVK_Preis+S_Rabatt)*S_Rabatt,ffNumber,10,2);
          LabelSVK_Preis.Caption:=FloattoStrF(SVK_Preis,ffNumber,10,2);
          LabelSGewinn.Caption:=FloattoStrF(SVK_Preis-SEK_Preis,ffNumber,10,2);
          LabelSPGewinn.Caption:=FloattoStrF(100/SVK_Preis*(SVK_Preis-SEK_Preis),ffNumber,10,2);
        end
        Else begin
          LabelSPBerechnung1.Caption:=FloattoStrF(0.0,ffNumber,10,2);
          LabelSPBerechnung2.Caption:=FloattoStrF(0.0,ffNumber,10,2);
          LabelSPBerechnung3.Caption:=FloattoStrF(0.0,ffNumber,10,2);
          LabelSEK_Preis.Caption:=FloattoStrF(0.0,ffNumber,10,2);
          LabelSPEK_Preis.Caption:=FloattoStrF(0.0,ffNumber,10,2);
          LabelSAufschlag.Caption:=FloattoStrF(0.0,ffNumber,10,2);
          LabelSPAufschlag.Caption:=FloattoStrF(0.0,ffNumber,10,2);
          LabelSRabatt.Caption:=FloattoStrF(0.0,ffNumber,10,2);
          LabelSPRabatt.Caption:=FloattoStrF(0.0,ffNumber,10,2);
          LabelSVK_Preis.Caption:=FloattoStrF(0.0,ffNumber,10,2);
          LabelSGewinn.Caption:=FloattoStrF(0.0,ffNumber,10,2);
          LabelSPGewinn.Caption:=FloattoStrF(0.0,ffNumber,10,2);
        end;
        //DBEditAufschlag.Text:=  FormatFloat('0.00',S_Aufschlag);
        //end;
        //end;
      end;
      QuerySumme.close;
    end;
  //end;
  {if FEinstellung  = 1 then //Summierung in der DB abspeichern
  begin
    QueryModul.edit;
    QueryModul.FieldByName('Materialleistung').AsFloat:=M_Preis;
    QueryModul.FieldByName('Dienstleistung').AsFloat:=D_Preis;
    QueryModul.FieldByName('Fremdleistung').AsFloat:=F_Preis;
    QueryModul.FieldByName('Sonstigeleistung').AsFloat:=S_Preis;
    QueryModul.FieldByName('VK_Preis').AsFloat:=0;//StrtoFloat(FormatFloat('0.00',SVK_Preis));
    QueryModul.FieldByName('Aufschlag').AsFloat:=StrtoFloat(FormatFloat('0.00',S_Aufschlag));
    QueryModul.FieldByName('Gewicht').AsFloat:=g;
    QueryModul.FieldByName('Zahl1').AsFloat:=Z1;
    QueryModul.FieldByName('Zahl2').AsFloat:=Z2;
    QueryModul.FieldByName('Zahl3').AsFloat:=Z3;
    QueryModul.FieldByName('EK_Preis').AsFloat:=StrtoFloat(FormatFloat('0.00',SEK_Preis));
    QueryModul.post;
  end;}
end;

procedure TFormArtikelSammlung.GroupBoxKopfDblClick(Sender: TObject);//Bedienung
begin
  if UKopfJN then UKopfJN:=False Else UKopfJN:=True;
  anzeigeNeu;
end;

procedure TFormArtikelSammlung.AnzeigeNeu;//Bedienung
 var //FRow:Real;
     //Kopfrecht:integer;}
     I:integer;
    Buchstabenbreite:Real;
    CaptionLeerstelle:String;
begin
  if UInternJN then GroupBoxIntern.Height:=UInternHoeheAn Else GroupBoxIntern.Height:=UInternHoeheAus;
  if UKopfJN then GroupBoxKopf.Height:=UKopfHoeheAn Else GroupBoxKopf.Height:=UKopfHoeheAus;
  if UFussJN then GroupBoxFuss.Height:=UFussHoeheAn Else GroupBoxFuss.Height:=UFussHoeheAus;
  if USummeJN then GroupBoxSummen.Height:=USummeHoeheAn Else GroupBoxSummen.Height:=UFussHoeheAus;
  if UButtonJN then GroupBoxButton.Height:=UButtonHoeheAn Else GroupBoxButton.Height:=UButtonHoeheAus;
  if UHintAn then begin
    if UInternJN then GroupBoxIntern.Hint:='Doppelklick schliesst den internen Teil' Else GroupBoxIntern.Hint:='Doppelklick öffnet den internen Teil';
    if UKopfJN then GroupBoxKopf.Hint:='Doppelklick schliesst den Kopfteil' Else GroupBoxKopf.Hint:='Doppelklick öffnet den Kopfteil';
    if UFussJN then GroupBoxFuss.Hint:='Doppelklick schliesst den Fussteil' Else GroupBoxFuss.Hint:='Doppelklick öffnet den Fussteil';
    if USummeJN then GroupBoxSummen.Hint:='Doppelklick schliesst den Summenteil' Else GroupBoxSummen.Hint:='Doppelklick öffnet den Summenteil';
    if UButtonJN then GroupBoxButton.Hint:='Doppelklick schliesst den Buttonteil' Else GroupBoxButton.Hint:='Doppelklick öffnet den Buttonteil';
  end
  Else
  begin
    GroupBoxIntern.Hint:='';
    GroupBoxKopf.Hint:='';
    GroupBoxFuss.Hint:='';
    GroupBoxSummen.Hint:='';
    GroupBoxButton.Hint:='';
  end;
  GroupBoxIntern.top:=UZ;
  GroupBoxKopf.top:=UZ+GroupBoxIntern.Height;
  LabelKopftext.top:=UZ+GroupBoxIntern.Height+GroupBoxKopf.Height;
  GroupBoxSummen.top:=ClientHeight-GroupBoxSummen.Height-UZ-GroupBoxFuss.Height-UZ-GroupBoxButton.Height-UZ;
  GroupBoxFuss.top:=ClientHeight-GroupBoxFuss.Height-UZ-GroupBoxButton.Height-UZ;
  GroupBoxButton.top:=ClientHeight-GroupBoxButton.Height-UZ+3;
  DBCtrlGridArtikel.top:=GroupBoxKopf.top+GroupBoxKopf.Height+UZ+12;
  UGridHeight:=ClientHeight-GroupBoxKopf.Height-GroupBoxFuss.Height - GroupBoxSummen.Height - GroupBoxButton.Height - (6*UZ)-GroupBoxIntern.Height;
  if UPanelHeight> 0 then URowCount:=Trunc(UGridHeight/UPanelHeight);
  with DBCtrlGridArtikel do begin
      Height:=UGridHeight;
      if UGridHeight > 300 then Height := UGridHeight else Height := 300;
      RowCount:=URowCount;
      PanelHeight:=UPanelHeight;end;
  GroupBoxIntern.Width:=Width-8;
  GroupBoxKopf.Width:=Width-8;
  DBCtrlGridArtikel.Width:=Width-8;
  GroupBoxFuss.Width:=Width-8;
  GroupBoxSummen.Width:=Width-8;
  GroupBoxButton.Width:=Width-8;
  PageControlSumme.Width:=Width-12;
  if Height < UFensterHeoheMin then Height :=UFensterHeoheMin;
  if Width < UFensterBreiteMin then Width :=UFensterBreiteMin;
  if Width > UFensterBreiteMax then Width :=UFensterBreiteMax;
  PageControlSumme.Height:=USummeHoeheAn-19;
  DBMemoNotiz.Width:=Width-DBMemoNotiz.Left-(3*UZ);
  DBTextModulartKlein.Left:=Width-UKopfrecht;
  LabellModulKleinNr.Left:=Width-(UKopfrecht-155);
  LabelTransaktionsNrNr.Left:=Width-(UKopfrecht-95);
  LabelBearbeiter.Left:=Width-UKopfrecht;
  DBEditBearbeiter.Left:=Width-(UKopfrecht-155);
  LabelErfassungsdatum.Left:=Width-UKopfrecht;
  DBEditLetzteBearbeitung.Left:=Width-(UKopfrecht-155);
  LabelTransaktionsNr.Left:=Width-UKopfrecht;
  DBTextModul_Nr.left:=Width-(UKopfrecht-190);
  //LabelFirmaNr.Left:=Width-(UKopfrecht-160);
  //LabelLandNr.Left:=Width-(UKopfrecht-100);
  //Labelsymbol1.Left:=Width-(UKopfrecht-130);
  //LabelSymbol2.Left:=Width-(UKopfrecht-205);
  LabelKopfihrZeichen.Left:=Width-UKopfrecht;
  DBEditKopfIhrZeichen.Left:=Width-(UKopfrecht-155);
  DBTextModul.Left:=strtoint(Floattostr(Int((Width / 2) - DBTextModul.Width/2)));
  DBMemoKopf.Width:=Width-(7*UZ);
  DBMemoFuss.Width:=Width-(7*UZ);
  Buchstabenbreite:=4.01;//4.01
  //showmessage(inttostr((Round((ClientWidth-110)/Buchstabenbreite))-Round(Length(Umodulart)*{1.5}1.9)));
  for I := 1 to (Round((ClientWidth-110)/Buchstabenbreite))-Round(Length(Umodulart)*1.9{1.9}) do //1.5
    begin
    CaptionLeerstelle:=CaptionLeerstelle+' ';
    end;
  FormArtikelSammlung.Caption:=Umodulart+CaptionLeerstelle+inttostr(UEinstellungNr);
  ImageTastatur.Width:=GroupBoxButton.Width-4;
  PanelTastatur.Width:=GroupBoxButton.Width-4;
  LabelEVK_Preis.Left:=ClientWidth-20-Round(Length(LabelEVK_Preis.Caption)*6.2) ;
  LabelEMwSt.Left:=ClientWidth-20-Round(Length(LabelEMwSt.Caption)*6.2);
  LabelEPreis.Left:=ClientWidth-20-Round(Length(LabelEPreis.Caption)*6.2);
end;

procedure TFormArtikelSammlung.FormResize(Sender: TObject);//Bedienung
begin
  if UFensterBewegenAn = False then width:=UFensterWidth;
  AnzeigeNeu;
end;

procedure TFormArtikelSammlung.GroupBoxFussDblClick(Sender: TObject); //Bedienung
begin
  if UFussJN then UFussJN:=False Else UFussJN:=True;
  AnzeigeNeu;
end;

procedure TFormArtikelSammlung.GroupBoxButtonDblClick(Sender: TObject);//Bedienung
begin
  if UButtonJN then UButtonJN:=False Else UButtonJN:=True;
  AnzeigeNeu;
end;

procedure TFormArtikelSammlung.ButtonSpeichernClick(Sender: TObject);//Eingang/Ausgang
begin
  QueryModul.post;
  FormPlanlos.Gzeiger:=QueryModul.Fields[0].Value;
  QueryArtikelListe.edit;
  QueryArtikelListe.Post;
  if QueryModul.Active then QueryModul.close;
  //QueryArtikelListe.
  ListeVerlassen(DBEditProjekt);
  //if QueryArtikelListe.Active then QueryArtikelListe.close;
  close;
end;

procedure TFormArtikelSammlung.GroupBoxSummenDblClick(Sender: TObject);//Bedienung
begin
   if USummeJN then USummeJN:=False Else USummeJN:=True;
  AnzeigeNeu;
end;

procedure TFormArtikelSammlung.ComboBoxPostextChange(Sender: TObject);//Bedienung
begin
  PosTextZeilen;
  self.ActiveControl:=DBCtrlGridArtikel;
end;

procedure TFormArtikelSammlung.ButtonNeuClick(Sender: TObject);//DB
begin
  //with QueryArtikelListe do
  //begin
    //Showmessage('ButtonNeuClick');
    if DBEditArtikelGruppe.Visible then ActiveControl:=DBEditArtikelGruppe Else ActiveControl:=DBEditArtikel;
    UArtikelNeu:=True;
    ButtonSuchenClick(Self);
    UArtikelNeu:=False;
    //MengeActiv(0);
  //end;
end;

procedure TFormArtikelSammlung.ButtonLoeschenClick(Sender: TObject);//DB
var Pos,i:integer;
    //,FNr,FVon:integer;
begin
   Pos:=strtoint(QueryArtikelListe.FieldByName('Pos_Nr').Asstring);
   QueryArtikelListe.DisableControls;
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
   if Meldefenster.an(1,'soll die Position-Nr: '+inttostr(Pos),'gelöscht werden','') Then
   begin
    DataModuleMyOffice.LagerverwaltungArtikel(ULagerverwaltung,QueryArtikelListe.FieldByName('Artikel_Nr').Asinteger,QueryArtikelListe.FieldByName('Menge').AsFloat,QueryArtikelListe.FieldByName('Artikelart').Asstring,QueryArtikelListe.FieldByName('Artikel_Nr').AsInteger,True);
    DataModuleMyOffice.DSLoeschen('Artikellistes','Stuecklisten_Nr',QueryArtikelListe.FieldByName('Nr').Asinteger);
    QueryArtikelListe.Delete;
    for I:=Pos to QueryArtikelListe.RecordCount do
    begin
      QueryArtikelListe.edit;
      QueryArtikelListe.FieldByName('Pos_Nr').Asstring:=inttostr(I);
      QueryArtikelListe.post;
      QueryArtikelListe.Next;
    end;
    geheZu(Pos);
   end;
   QueryArtikelListe.EnableControls;
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
   //DataModuleMyOffice.LagerverwaltungArtikel(ULagerverwaltung,FArtikelNr:Integer;FLagerverwaltungMenge:Real;FArtikelart:String;FArtikelListenNr:integer;loeschen:Boolean);
   //Showmessage('Artikel muss noch von der Lagerverwaltung abgezogen werden.');
    summierung(0);
end;

procedure TFormArtikelSammlung.ButtonSuchenClick(Sender: TObject);//Eingang/Ausgang
var i,FVon,FZu,Fnr,FArtikelNr,FPos_Nr:integer;Par:TStringList;Fname,FDatum,FArtikelArt:string;
begin
  If UFocus <> '' then
  begin
    DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
    Par:=TStringList.Create;
    if UFocus = 'DBEditProjekt'then begin
      Par:=TForm1.an(FormProjekte,DBEditProjekt.text,GModulart,GBenutzer,100);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then
      begin
       DBEditProjekt.text:=Fname;
       QueryModul.FieldByName('Projekt_Nr').AsInteger :=Fnr;
       GProjekt_Nr:=Fnr;
      end;
      //ActiveControl:=DBEditAdresse;
    end;
    if UFocus = 'DBEditAdresse'then begin
      Par:=TForm1.an(FormAdresse,DBEditAdresse.text,GModulart,GBenutzer,101);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then
      begin
        DBEditAdresse.text:=Fname;
        QueryModul.FieldByName('Adress_Nr').AsInteger:=Fnr;
        if QueryAdresse.Active then QueryAdresse.close;
        QueryAdresse.sql.Clear;
        QueryAdresse.sql.add('Select * From Adressen Where Nr = '+ inttostr(Fnr));
        try
          QueryAdresse.open;//Self.Query1.Edit;
        finally
        end;
        DBMemoAdresse.Lines:= DBMemoVonAdresse.Lines;
        QueryAdresse.close;
      end;
      //ActiveControl:=DBEditGruppierung;
    end;
    if UFocus = 'DBEditGruppierung'then begin
      Par:=TForm1.an(FormGruppierung,DBEditGruppierung.text,GModulart,GBenutzer,102);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then DBEditGruppierung.text:=Fname;
      //ActiveControl:=DBEditBearbeiter;
    end;
    if UFocus = 'DBEditBearbeiter'then begin
      Par:=TForm1.an(FormAdresse,DBEditBearbeiter.text,GModulart,GBenutzer,103);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then DBEditBearbeiter.text:=Fname;
      //ActiveControl:=DBMemoNotiz;
    end;
    if UFocus = 'DBEditLetzteBearbeitung' then begin
      FDatum:=FormDatum.an(DBEditLetzteBearbeitung.Text,Left + 80,Top);
      if FDatum <> '' then DBEditLetzteBearbeitung.text:=FDatum;
      //ActiveControl:=DBMemoKopf;
    end;
    // Memos
    if UFocus = 'DBMemoKopf'then begin
      GKopfFusstext:='Kopftext';
      Par:=TForm1.an(FormTextbaustein,DBMemoKopf.Lines[0],GModulart,GBenutzer,104);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then
        begin
        QueryTextbaustein.sql.Clear;
        QueryTextbaustein.sql.add('Select * From Textbaustein Where Nr = '+ inttostr(Fnr));
        try
          QueryTextbaustein.open;//Self.Query1.Edit;
        finally
        end;
        DBMemoKopf.Lines:= DBMemoTextbaustein.Lines;
        QueryTextbaustein.close;
      end;
    end;
    if UFocus = 'DBMemoFuss'then begin
      GKopfFusstext:='Fusstext';
      Par:=TForm1.an(FormTextbaustein,DBMemoFuss.Lines[0],GModulart,GBenutzer,105);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then
        begin
        QueryTextbaustein.sql.Clear;
        QueryTextbaustein.sql.add('Select * From Textbaustein Where Nr = '+ inttostr(Fnr));
        try
          QueryTextbaustein.open;//Self.Query1.Edit;
        finally
        end;
        DBMemoFuss.Lines:= DBMemoTextbaustein.Lines;
        QueryTextbaustein.close;
      end;
    end;
    if UFocusGrid Then //;(UFocus = 'DBCtrlGridArtikel') then//DBEditArtikel') or (UFocus = 'DBEditArtikelGruppe') then
    begin
      if UArtikelNeu Then FormPlanlos.GArtikelaussuchenneu:=True Else FormPlanlos.GArtikelaussuchenneu:=False;
      FArtikelNr:=QueryArtikelliste.FieldByName('Nr').AsInteger;
      FPos_Nr:=QueryArtikelliste.FieldByName('Pos_Nr').AsInteger;
      loeschenVonNullPos(FPos_Nr);
      UArtikelZurueck.clear;
      if QueryArtikelliste.State = dsEdit then Else QueryArtikelliste.edit;GPosFuerSonstiges:=QueryArtikelListe.RecordCount+1;
      UArtikelZurueck:=FormArtikelAussuchen.an(QueryArtikelliste.FieldByName('Artikelgruppe').AsString,QueryArtikelliste.FieldByName('Artikel').AsString,3{GModulart_Nr},QueryArtikelliste.FieldByName('ArtikelArt').asString,UEinstelllisteSammlung);
      if Artikel1.Nr<>0 then begin
        If Artikel1.Artikelart='Artikel' then begin
          Artikel1.Modul_Nr:=UZeiger;
          if UArtikelNeu Then Artikel1.Pos_Nr:=QueryArtikelListe.RecordCount+1 Else
             Artikel1.Pos_Nr:=FPos_Nr;
          Artikel1.Geaendert:=0;
          Artikel1.Erledigt1:=0; Artikel1.Erledigt2:=0; Artikel1.Erledigt3:=0; Artikel1.Erledigt4:=0; Artikel1.Erledigt5:=0;
          Artikel1.Artikel_Nr:=Artikel1.Nr;
          ListeVerlassen(ActiveControl);
          if UArtikelNeu Then DataModuleMyOffice.DSGet('Artikel1','ArtikelListe',0)Else
             DataModuleMyOffice.DSGet('Artikel1','ArtikelListe',FArtikelNr);
          ListeZurueck();
          if UArtikelNeu Then geheZu(QueryArtikelliste.RecordCount) Else geheZu(FPos_Nr);
          //ActiveControl:=DBEditMenge;DBEditMenge.Text:='';
          QueryArtikelliste.edit;
        end;

        If Artikel1.Artikelart='Freie Eingabe' then begin
          Artikel1.Modul_Nr:=UZeiger;
          Artikel1.Pos_Nr:=QueryArtikelListe.RecordCount+1;
          Artikel1.Artikelart:='Artikel';
          Artikel1.Geaendert:=0;
          Artikel1.Erledigt1:=0; Artikel1.Erledigt2:=0; Artikel1.Erledigt3:=0; Artikel1.Erledigt4:=0; Artikel1.Erledigt5:=0;
          DataModuleMyOffice.DSGet('Artikel1','ArtikelListe',0);
          ListeZurueck();
          geheZu(QueryArtikelListe.RecordCount+1);
          ButtonaendernClick(Self);
          //ListeZurueck();
          //geheZu(QueryArtikelliste.RecordCount);
          //QueryArtikelliste.edit;
        end;

        If Artikel1.Artikelart='Freie Stueckliste' then begin
        end;

        If Artikel1.Artikelart='Stueckliste' then begin
          Artikel1.Modul_Nr:=UZeiger;
          if UArtikelNeu Then Artikel1.Pos_Nr:=QueryArtikelListe.RecordCount+1 Else
             Artikel1.Pos_Nr:=FPos_Nr;
          Artikel1.Geaendert:=0;
          Artikel1.Erledigt1:=0;Artikel1.Erledigt2:=0;Artikel1.Erledigt3:=0;Artikel1.Erledigt4:=0;Artikel1.Erledigt5:=0;
          Artikel1.Kostenart:='G';
          Artikel1.ModulNr:=FormPlanlos.GModulNrFuerStuckliste;
          FVon:=Artikel1.Nr;
          ListeVerlassen(ActiveControl);
          //FZu:=DataModuleMyOffice.DSGet('Artikel1','ArtikelListe',0);
          if UArtikelNeu Then FZu:=DataModuleMyOffice.DSGet('Artikel1','ArtikelListe',0)Else
             FZu:=DataModuleMyOffice.DSGet('Artikel1','ArtikelListe',FArtikelNr);
          ListeZurueck();
          if UArtikelNeu Then geheZu(QueryArtikelliste.RecordCount) Else geheZu(FPos_Nr);
          DataModuleMyOffice.DSLoeschen('ArtikellisteS','Stuecklisten_Nr',FZu{QueryArtikelliste.FieldByName('Nr').AsInteger});
          DataModuleMyOffice.DSArtikelListeKopieren('stuecklistenartikel','Stuecklisten_Nr',FVon,'ArtikellisteS','Stuecklisten_Nr',FZu);
        end;
        if  (Artikel1.Artikelart= 'Beziehungs Nr') or (Artikel1.Artikelart= 'Projekt Nr') or (Artikel1.Artikelart= 'Modul Nr') or (Artikel1.Artikelart= 'Alle Nr') then begin
        //If Artikel1.Artikelart='Liste' then begin
          FArtikelArt:=Artikel1.Artikelart;
          i:=0;
          while i < UArtikelZurueck.count do begin
            if (UArtikelZurueck[i] = 'Artikel') or (UArtikelZurueck[i] = 'Freie Eingabe') then  begin
              DataModuleMyOffice.DSNil('Artikel1');DataModuleMyOffice.DSNil('Artikel2');
              if QueryArtikel.Active then QueryArtikel.close;
              QueryArtikel.sql.Clear;
              QueryArtikel.sql.add('Select * From ArtikelListe Where Nr = '+(UArtikelZurueck[i+1]));
              QueryArtikel.open;
              if (FArtikelArt='Beziehungs Nr') and (UErledigtNr <>0) Then begin
                QueryArtikel.edit;
                if UErledigtNr = 1 then QueryArtikel.FieldByName('Erledigt1').AsInteger:=1;
                if UErledigtNr = 2 then QueryArtikel.FieldByName('Erledigt2').AsInteger:=1;
                if UErledigtNr = 3 then QueryArtikel.FieldByName('Erledigt3').AsInteger:=1;
                if UErledigtNr = 4 then QueryArtikel.FieldByName('Erledigt4').AsInteger:=1;
                QueryArtikel.Post;
              end;
              DataModuleMyOffice.DSSet('Artikel2',QueryArtikel);
              Artikel2.Modul_Nr:=UZeiger;
              Artikel2.Pos_Nr:=QueryArtikelListe.RecordCount+1;
              Artikel2.Geaendert:=0;
              Artikel2.Erledigt1:=0;Artikel2.Erledigt2:=0;Artikel2.Erledigt3:=0;Artikel2.Erledigt4:=0;Artikel2.Erledigt5:=0;
              ListeVerlassen(ActiveControl);
              if FArtikelArt='Beziehungs Nr' Then
              DataModuleMyOffice.DSGet('Artikel2','ArtikelListe',0);
              ListeZurueck();
              QueryArtikel.close;
            end;
            if UArtikelZurueck[i] = 'Stueckliste' then  begin
              FVon:=strtoint(UArtikelZurueck[i+1]);
              DataModuleMyOffice.DSNil('Artikel1');DataModuleMyOffice.DSNil('Artikel2');
              if QueryArtikel.Active then QueryArtikel.close;
              QueryArtikel.sql.Clear;
              QueryArtikel.sql.add('Select * From ArtikelListe Where Nr = '+(UArtikelZurueck[i+1]));
              QueryArtikel.open;
              if (FArtikelArt='Beziehungs Nr') and (UErledigtNr <>0) Then begin
                QueryArtikel.edit;
                if UErledigtNr = 1 then QueryArtikel.FieldByName('Erledigt1').AsInteger:=1;
                if UErledigtNr = 2 then QueryArtikel.FieldByName('Erledigt2').AsInteger:=1;
                if UErledigtNr = 3 then QueryArtikel.FieldByName('Erledigt3').AsInteger:=1;
                if UErledigtNr = 4 then QueryArtikel.FieldByName('Erledigt4').AsInteger:=1;
                QueryArtikel.Post;
              end;
              DataModuleMyOffice.DSSet('Artikel2',QueryArtikel);
              Artikel2.Modul_Nr:=UZeiger;
              Artikel2.Pos_Nr:=QueryArtikelListe.RecordCount+1;
              Artikel2.Geaendert:=0;
              Artikel2.Erledigt1:=0;Artikel2.Erledigt2:=0;Artikel2.Erledigt3:=0;Artikel2.Erledigt4:=0;Artikel2.Erledigt5:=0;
              ListeVerlassen(ActiveControl);
              FZu:=DataModuleMyOffice.DSGet('Artikel2','ArtikelListe',0);
              ListeZurueck();
              DataModuleMyOffice.DSLoeschen('ArtikellisteS','Stuecklisten_Nr',FZu);
              DataModuleMyOffice.DSArtikelListeKopieren('ArtikellisteS','Stuecklisten_Nr',FVon,'ArtikellisteS','Stuecklisten_Nr',FZu);
              QueryArtikel.close;
            end;
    	    i:=I+2;
  	  end;
        end;
        If Artikel1.Artikelart='ZListe' then begin
        //wird in artikel aussuchen übertragen
          i:=0;
          ListeVerlassen(ActiveControl);
          if (UErledigtNr <>0) Then begin
            while i < UArtikelZurueck.count do begin //hier wird nur noch die ausgesuchten artikel auf Erledigt gesetzt
              if QueryArtikel.Active then QueryArtikel.close;
              QueryArtikel.sql.Clear;
              QueryArtikel.sql.add('Select * From ArtikelListe Where Modul_Nr = '+inttostr(GZeigerFuerSonstiges));//+' and  ArtikelNr = '+(UArtikelZurueck[i+1]));
              QueryArtikel.open;
              while not QueryArtikel.eof do begin  //if QueryZListe.Active Then QueryZListe.Close;
                if QueryArtikel.FieldByName('Artikel_Nr').asString = UArtikelZurueck[i+1] then begin
                  QueryArtikel.edit;
                  if UErledigtNr = 1 then QueryArtikel.FieldByName('Erledigt1').AsInteger:=1;
                  if UErledigtNr = 2 then QueryArtikel.FieldByName('Erledigt2').AsInteger:=1;
                  if UErledigtNr = 3 then QueryArtikel.FieldByName('Erledigt3').AsInteger:=1;
                  if UErledigtNr = 4 then QueryArtikel.FieldByName('Erledigt4').AsInteger:=1;
                  QueryArtikel.Post;
                end;
                if QueryArtikel.FieldByName('ArtikelArt').asString = 'Stueckliste' then begin
                  //Showmessage('Stueckliste gefunden');
                  if QueryZListe.Active Then QueryZListe.Close;
                  QueryZListe.sql.Clear;
                  QueryZListe.sql.add('Select * From ArtikelListeS Where Stuecklisten_Nr = '+QueryArtikel.FieldByName('Nr').asString);//+' and  ArtikelNr = '+(UArtikelZurueck[i+1]));
                  QueryZListe.open;
                  while not QueryZListe.eof do begin
                    if QueryZListe.FieldByName('Artikel_Nr').asString = UArtikelZurueck[i+1] then begin
                      //Showmessage('Artikel_Nr gefunden');
                      QueryZListe.edit;
                      if UErledigtNr = 1 then QueryZListe.FieldByName('Erledigt1').AsInteger:=1;
                      if UErledigtNr = 2 then QueryZListe.FieldByName('Erledigt2').AsInteger:=1;
                      if UErledigtNr = 3 then QueryZListe.FieldByName('Erledigt3').AsInteger:=1;
                      if UErledigtNr = 4 then QueryZListe.FieldByName('Erledigt4').AsInteger:=1;
                      QueryZListe.Post;
                    end;
                    QueryZListe.Next;
                  end;
                  if QueryZListe.Active Then QueryZListe.Close;
                end;
                QueryArtikel.Next;
              end;
              if QueryArtikel.Active then QueryArtikel.close;
              i:=i+2;
            end;
          end;
          ListeZurueck();
        end;
      end;
      UAGArtikel:=QueryArtikelListe.FieldByName('Artikel').Asstring;
      UAGArtikelgruppe:=QueryArtikelListe.FieldByName('ArtikelGruppe').Asstring;
      UAGName1:=QueryArtikelListe.FieldByName('Name1').Asstring;
      UAGName2:=QueryArtikelListe.FieldByName('Name2').Asstring;
      UAGName3:=QueryArtikelListe.FieldByName('Name3').Asstring;
      UAGEinheitMenge:=QueryArtikelListe.FieldByName('EinheitMenge').Asstring;
      UAGEinheit_EK:=QueryArtikelListe.FieldByName('Einheit_EK').Asstring;
      UAGZahl1:=QueryArtikelListe.FieldByName('Zahl1').AsFloat;
      UAGZahl2:=QueryArtikelListe.FieldByName('Zahl1').AsFloat;
      UAGZahl3:=QueryArtikelListe.FieldByName('Zahl1').AsFloat;
      UAGgewicht:=QueryArtikelListe.FieldByName('Gewicht').AsFloat;
      UAGArtikelNr:=QueryArtikelListe.FieldByName('Artikel_Nr').Asstring;
      UAGBerechnungsArt:=QueryArtikelListe.FieldByName('Berechnungsart').Asstring;
      MengeActiv(0);
      FormPlanlos.GArtikelaussuchenneu:=False;
    end;
    {if UFocus = 'DBEditEinheitMenge'then begin
      Par:=TForm1.an(FormEinheit,DBEditEinheitMenge.text,GModulart,GBenutzer,108);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then DBEditEinheitMenge.text:=Fname;
    end;
    if UFocus = 'DBEditEinheit_EK'then
    begin
      Par:=TForm1.an(FormEinheit,DBEditEinheit_EK.text,GModulart,GBenutzer,109);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then DBEditEinheit_EK.text:=Fname;
    end;}
    Par.Free;
    DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
    //GroupBoxButton.Color:=clYellow;
  end;
end;


procedure TFormArtikelSammlung.loeschenVonNullPos(FPos_Nr:integer);
Var i:integer;
begin
  QueryArtikelListe.disableControls;
  QueryArtikelliste.first;
  for i:=0 to QueryArtikelListe.RecordCount-1 do begin
    if  QueryArtikelListe.FieldByName('Pos_Nr').Asinteger=0 Then begin
      QueryArtikelListe.Delete;
    end;
    QueryArtikelListe.Next;
  end;
  QueryArtikelListe.EnableControls;
  geheZu(FPos_Nr);
end;

procedure TFormArtikelSammlung.MengeActiv(FEinstellung:integer);
begin
  //ActiveControl:=DBEditBezeichnung;
  QueryArtikelliste.edit;
  //QueryArtikelListe.disableControls;
  //DBCtrlGridArtikel.EditMode:=True;
  //ActiveControl:=DBCtrlGridArtikel;
  //Showmessage('Mengeactiv');
  //geheZu(2);
  DBCtrlGridArtikel.setFocus;
  ActiveControl:=DBEditMenge;
  //DBCtrlGridArtikel.EditMode:=True;
  //QueryArtikelListe.EnableControls;
  //if FEinstellung = 0  then DBEditMenge.Text:='';
end;

procedure TFormArtikelSammlung.GroupBoxInternDblClick(Sender: TObject);//Bedienung
begin
 if UInternJN then UInternJN:=False Else UInternJN:=True;
  anzeigeNeu;
end;

procedure TFormArtikelSammlung.FormKeyDown(Sender: TObject; var Key: Word;//Bedienung
  Shift: TShiftState);
begin
  //if UFocusListe then Showmessage('UFocusListe=True')Else Showmessage('UFocusListe=False');
  if (Shift = [ssShift]) or (Shift = [ssAlt]) then begin
    if Shift = [ssShift] then
    begin
      if Key = VK_F6 then
      begin
        DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
        //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
        //GroupBoxButton.Color:=clGray;
        FormPlanlos.GZeiger:=UDBZeiger;
        FormEinstellungModulart.ShowModal;
        Meldefenster.an(2,'Die Änderung wird erst beim erneutem','aufruf der Liste wirksam !','');
        //GroupBoxButton.Color:=clYellow;
        DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
        //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
      end;
      if Key = VK_F9 then FenstergroesseAbspeichern;
      if Key = 27 then  ButtonabbrechenClick(Self);
      if Key = VK_F3 then begin Showmessage(QueryArtikelListe.SQL.text);self.ActiveControl:=DBCtrlGridArtikel;end;
      if Key = Vk_F4 then begin Showmessage(QueryArtikelliste.FieldByName('Nr').AsString);self.ActiveControl:=DBCtrlGridArtikel;end;
      if Key = VK_F7 then  Showmessage(UFocus);
      if Key = VK_F8 then  if  UFocusGrid then Showmessage('UFocusGrid=True')Else Showmessage('UFocusGrid=False');
    end
    Else begin
      if Key = VK_DOWN then begin UAltcurser:=True;SpeedButtonBewegenNachUntenClick(Self);end;
      if Key = VK_UP then begin UAltcurser:=True;SpeedButtonBewegenNachObenClick(Self);end;
    end
  end
  else
  begin
    //if Key = 27 then  ButtonabbrechenClick(Self);
    if Key = VK_F2 then  if UEnaF2 and ButtonNeu.Enabled then ButtonNeuClick(Self);
    if Key = VK_F3 then  if UEnaF3 and ButtonAusgabe.Enabled then ButtonAusgabeClick(Self);
    if Key = VK_F4 then  if UEnaF4 and ButtonSuchen.Enabled then ButtonSuchenClick(Self);
    if Key = VK_F5 then  if UEnaF5 and ButtonKopieren.Enabled then ButtonKopierenClick(Self);
    if Key = VK_F6 then  if UEnaF6 and ButtonAendern.Enabled then ButtonAendernClick(Self);
    if Key = VK_F8 then  if UEnaF8 and ButtonLoeschen.Enabled then ButtonLoeschenClick(Self);
    if Key = VK_F10 then if UEnaF10 and ButtonSpeichern.Enabled then ButtonSpeichernClick(Self);
    if (Key = VK_DOWN) or (Key = VK_UP) then self.ActiveControl:=DBCtrlGridArtikel;
  end;
end;

procedure TFormArtikelSammlung.ButtonAbbrechenClick(Sender: TObject);//Eingang/Ausgang
  var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  //GroupBoxButton.Color:=clGray;
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  //GroupBoxButton.Color:=clYellow;
  if FAbbrechen then
  begin
    if UZeigerNeu then
      begin
        DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
        //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
        QueryArtikelListe.close;
        QueryModul.close;
        if (DataModuleDB.DatensatzLoeschen('Module',Uzeiger) = False) Then
        begin
          //GroupBoxButton.Color:=clGray;
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
          //GroupBoxButton.Color:=clYellow;
        end;
        if (DataModuleDB.DatensatzLoeschen('ArtikelListe',Uzeiger) = False) Then
        begin
          //GroupBoxButton.Color:=clGray;
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
          //GroupBoxButton.Color:=clYellow;
        end;
        DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
        //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
        FormPlanlos.Gzeiger:=0;
      end
    else // änderung
    begin
      QueryModul.Cancel;QueryModul.close;
      QueryArtikelListe.Cancel;QueryArtikelListe.close;
      FormPlanlos.Gzeiger:=Uzeiger;
    end;
    Close;
  end;
end;

procedure TFormArtikelSammlung.FormClose(Sender: TObject;//Eingang/Ausgang
  var Action: TCloseAction);
begin
  FormPlanlos.GModulNrFuerStuckliste:=0;
  UEinstelllisteSammlung.Free;
  Udruckerliste.Free;
  UdruckerlisteNr.Free;
  UArtikelZurueck.Free;
  //NewItem1.Free;
  //ButtonAbbrechenClick(Self);
  //GOffeneFenster:=GOffeneFenster-1;
end;

procedure TFormArtikelSammlung.FormActivate(Sender: TObject);//Eingang/Ausgang
begin
  UAltcurser:=False;
  UBerechnung1:='';UBerechnung2:='';UBerechnung3:='';
  UArtikelNeu:=True;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  UModulart:=GModulart;//GModulart:='';
  FormPlanlos.GModulNrFuerStuckliste:=UZeiger;
  ini;
  summierung(0);
end;

procedure TFormArtikelSammlung.ButtonaendernClick(Sender: TObject);//Eingang/Ausgang
Var FArtikelArt:String;
    FZeiger:longint;
    FPos:integer;
begin
  If UFocus <> '' then
  begin
    QueryArtikelliste.edit;
    QueryArtikelliste.post;
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
    DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
    FArtikelArt:=QueryArtikelliste.FieldByName('ArtikelArt').AsString;
    FormPlanlos.GzeigerNeu:=False;
    FormPlanlos.Gzeiger:=QueryArtikelliste.FieldByName('Nr').AsInteger;
    FZeiger:=QueryArtikelliste.FieldByName('Nr').AsInteger;
    FPos:=QueryArtikelliste.FieldByName('Pos_Nr').AsInteger;

    //QueryArtikelliste.Active:=False;
    if FArtikelArt='Stueckliste' Then TFormStueckliste.an(1);
    if FArtikelArt='Artikel' Then TFormArtikel.an(1);
    ListeVerlassen(ActiveControl);
    ListeZurueck();
    //QueryArtikelliste.close;----------------> ????
    //QueryArtikelliste.open;----------------> ????
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
    DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
    gehezu(FPos);
    MengeActiv(1);
    //QueryArtikelliste.edit;
    //QueryArtikelliste.post;
  end;
  //showmessage('eingang Artikel ändern');
end;

procedure TFormArtikelSammlung.ButtonkopierenClick(Sender: TObject); //DB
Var NrAlt,NrNeu,PosNeu:integer;
    ArtikelArt:String;
begin
   NrAlt:=QueryArtikelListe.FieldByName('Nr').Asinteger;
   PosNeu:=QueryArtikelListe.RecordCount+1;
   ArtikelArt:=QueryArtikelListe.FieldByName('ArtikelArt').AsString;
   ActiveControl:=DBEditBezeichnung;
   QueryArtikelListe.close;
   NrNeu:=DataModuleDB.DatensatzkopierenMit('Artikelliste',NrAlt,'Modul_Nr,Pos_Nr','"'+inttostr(UZeiger)+'","'+inttostr(PosNeu)+'"');
   if ArtikelArt='Stueckliste' Then DataModuleDB.DatensatzkopierenListeMitFeld('ArtikellisteS','Stuecklisten_Nr',NrAlt,'ArtikellisteS','Stuecklisten_Nr',NrNeu);
   QueryArtikelListe.Open;
   QueryArtikelListe.edit;
   geheZu(PosNeu);
   MengeActiv(0);
end;

procedure TFormArtikelSammlung.DBEditBezeichnungEnter(Sender: TObject);//Bedienung
begin
   //QueryArtikelliste.Edit;
   ULagerverwaltungMenge:=DataModuleMyOffice.Xstrtoint(DBEditMenge.Text);
   Focus;//wird von allen felder belegt
end;

procedure TFormArtikelSammlung.Focus;//Bedienung
begin
  //UFocusListe:=False;
  If (ActiveControl.Name = DBEditProjekt.Name) or
     (ActiveControl.Name = DBEditAdresse.Name) or
     //(ActiveControl.Name = DBEditBezeichnung.Name) or
     (ActiveControl.Name = DBEditGruppierung.Name) or
     (ActiveControl.Name = DBEditBearbeiter.Name) or
     (ActiveControl.Name = DBEditLetzteBearbeitung.Name) or
     (ActiveControl.Name = DBMemoKopf.Name) or
     (ActiveControl.Name = DBMemoFuss.Name) or
     (ActiveControl.Name = DBEditPos_Nr.Name) or
     (ActiveControl.Name = DBEditArtikelGruppe.Name) or
     (ActiveControl.Name = DBEditArtikel.Name) or
     (ActiveControl.Name = DBEditMenge.Name) or
     (ActiveControl.Name = DBEditEinheitMenge.Name) or
     (ActiveControl.Name = DBEditEK_Preis.Name) or
     (ActiveControl.Name = DBEditEinheit_EK.Name) or
     (ActiveControl.Name = DBEditAufschlag.Name) or
     (ActiveControl.Name = DBEditVK_Preis.Name) or
     (ActiveControl.Name = DBEditZahl3.Name) or
     (ActiveControl.Name = DBEditRabatt.Name) or
     (ActiveControl.Name = DBEditArtikelNr.Name) or
     (ActiveControl.Name = DBEditBerechnungsArt.Name) or
     (ActiveControl.Name = DBEditGewicht.Name) or
     (ActiveControl.Name = DBEditZahl2.Name) or
     (ActiveControl.Name = DBEditZahl1.Name) or
     (ActiveControl.Name = DBEditBerechnen1.Name) or
     (ActiveControl.Name = DBEditBerechnen2.Name) or
     (ActiveControl.Name = DBEditBerechnen3.Name) or
     (ActiveControl.Name = DBMemoPosText.Name) Then
  begin
    UFocus:=ActiveControl.Name;
    If (UFocus = DBEditPos_Nr.Name) or
     (UFocus = DBEditArtikelGruppe.Name) or
     (UFocus = DBEditArtikel.Name) or
     (UFocus = DBEditMenge.Name) or
     (UFocus = DBEditEinheitMenge.Name) or
     (UFocus = DBEditEK_Preis.Name) or
     (UFocus = DBEditEinheit_EK.Name) or
     (UFocus = DBEditAufschlag.Name) or
     (UFocus = DBEditVK_Preis.Name) or
     (UFocus = DBEditZahl3.Name) or
     (UFocus = DBEditRabatt.Name) or
     (UFocus = DBEditArtikelNr.Name) or
     (UFocus = DBEditBerechnungsArt.Name) or
     (UFocus = DBEditBerechnen1.Name) or
     (UFocus = DBEditBerechnen2.Name) or
     (UFocus = DBEditBerechnen3.Name) or
     (UFocus = DBEditGewicht.Name) or
     (UFocus = DBEditZahl2.Name) or
     (UFocus = DBEditZahl1.Name) or
     (UFocus = DBMemoPosText.Name) Then UFocusGrid:=True Else UFocusGrid:=False;
     Buttonsuchen.Enabled:=True;
  end
  else //kein Suchfeld
  begin
    UFocus:='';
    UFocusGrid:=False;
    Buttonsuchen.Enabled:=False;
  end;
end;

procedure TFormArtikelSammlung.FenstergroesseAbspeichern;//Bedienung
begin
  QueryEinstellungModulart.close;
  QueryEinstellungModulart.SQL.Clear;
  QueryEinstellungModulart.SQL.Add('Select * FROM EinstellungModulart WHERE Nr = ' + inttostr(UEinstellungNr));
  try
    QueryEinstellungModulart.Open
  except
  end;
  QueryEinstellungModulart.edit;
  QueryEinstellungModulart.FieldByName('FensterTop').AsInteger:=top;
  QueryEinstellungModulart.FieldByName('FensterLeft').AsInteger:=left;
  QueryEinstellungModulart.FieldByName('Fensterwidth').AsInteger:=width;
  QueryEinstellungModulart.FieldByName('Fensterhoehe').AsInteger:=height;
  QueryEinstellungModulart.post;
  QueryEinstellungModulart.close;
end;

procedure TFormArtikelSammlung.ButtonAusgabeClick(Sender: TObject);//Bedienung
var test:String;
begin
  PopupMenuAusgabe.Popup(Self.left+133,Self.Top+ClientHeight-(9 + (PopupMenuAusgabe.Items.Count*17)));
  //DBEditMenge.Font.Color:=stringtoColor(UFarbenPos_Nr);
end;

procedure TFormArtikelSammlung.DBCtrlGridArtikelPaintPanel(//Bedienung
  DBCtrlGrid: TDBCtrlGrid; Index: Integer);
  var Farbe1,Farbe2,Farbe3:TColor;
begin
  //Farbe2:=stringtoColor('$00D5FDFC');//DBCtrlGridArtikel.Color;
  //Farbe3:=clWhite;//stringtoColor('$00D5FDFC');//DBCtrlGridArtikel.SelectedColor;
  // Farbe1:=stringtoColor('$00FAF7D3');
  if UFarbenwechselFarbe1<>''then Farbe1:=StringToColor(UFarbenwechselFarbe1) Else  Farbe1:=stringtoColor('$00FDFEDA');
  if UFarbenwechselFarbe2<>''then Farbe2:=StringToColor(UFarbenwechselFarbe2) Else  Farbe2:=stringtoColor('$00E8E8E8');
  if UFarbenwechselFarbeSelect<>''then Farbe3:=StringToColor(UFarbenwechselFarbeSelect) Else  Farbe3:=stringtoColor('$0084F5FF');
  //DBEditMenge.Font.Color:=stringtoColor(UFarbenPos_Nr);
  //Farbe4:=stringtoColor(UFarbenArtikelgruppe);
  if (DBCtrlGridArtikel.DataSource.DataSet.FieldByName('ArtikelArt').asstring) = 'Artikel' Then
    DBEditArtikelGruppe.Font.Color:=stringtocolor('clBlack'{UFarbenArtikelgruppe})
  Else DBEditArtikelGruppe.Font.Color:=stringtocolor('clPurple');

  if (DBCtrlGridArtikel.DataSource.DataSet.FieldByName('Geaendert').asinteger) = 0 Then
    DBEditPos_Nr.Font.Color:=stringtocolor('clBlack'{UFarbenPos_Nr})
  Else DBEditPos_Nr.Font.Color:=stringtocolor('clGreen');

  if ((DBCtrlGridArtikel.DataSource.DataSet.FieldByName('Artikel_Nr').asinteger) = 0) and ((DBCtrlGridArtikel.DataSource.DataSet.FieldByName('Geaendert').asinteger) = 0) and ((DBCtrlGridArtikel.DataSource.DataSet.FieldByName('ArtikelArt').asString) = 'Artikel') then
    DBEditMenge.Font.Color:=stringtocolor('clRed')
  Else DBEditMenge.Font.Color:=stringtocolor('clBlack'{UFarbenmenge});

  if UFarbenwechsel Then begin
    if Odd(DBCtrlGridArtikel.DataSource.DataSet.RecNo) then begin
        DBCtrlGridArtikel.Canvas.Brush.Color := Farbe2;
        DBEditPos_Nr.Color:=Farbe2;
        DBEditArtikelGruppe.Color:=Farbe2;
        DBEditArtikel.Color:=Farbe2;
        DBEditMenge.Color:=Farbe2;
        DBEditEinheitMenge.Color:=Farbe2;
        DBEditEK_Preis.Color:=Farbe2;
        DBEditEinheit_EK.Color:=Farbe2;
        DBEditAufschlag.Color:=Farbe2;
        DBEditVK_Preis.Color:=Farbe2;
        DBMemoPosText.Color:=Farbe2;
        DBCheckBoxGeaendert.Color:=Farbe2;
        DBTextArtikel.Color:=Farbe2;
        DBCheckBoxArtikelErledigt1.Color:=Farbe2;
        DBCheckBoxArtikelErledigt2.Color:=Farbe2;
        DBCheckBoxArtikelErledigt3.Color:=Farbe2;
        DBCheckBoxArtikelErledigt4.Color:=Farbe2;
        DBEditBerechnungsArt.Color:=Farbe2;
        DBEditGewicht.Color:=Farbe2;
        DBEditZahl1.Color:=Farbe2;
        DBEditZahl2.Color:=Farbe2;
        DBEditZahl3.Color:=Farbe2;
        DBEditRabatt.Color:=Farbe2;
        DBEditArtikelNr.Color:=Farbe2;
        DBEditBerechnen1.Color:=Farbe2;
        DBEditBerechnen2.Color:=Farbe2;
        DBEditBerechnen3.Color:=Farbe2;
   End
    else begin
        DBCtrlGridArtikel.Canvas.Brush.Color := Farbe1;
        DBEditPos_Nr.Color:=Farbe1;
        DBEditArtikelGruppe.Color:=Farbe1;
        DBEditArtikel.Color:=Farbe1;
        DBEditMenge.Color:=Farbe1;
        DBEditEinheitMenge.Color:=Farbe1;
        DBEditEK_Preis.Color:=Farbe1;
        DBEditEinheit_EK.Color:=Farbe1;
        DBEditAufschlag.Color:=Farbe1;
        DBEditVK_Preis.Color:=Farbe1;
        DBMemoPosText.Color:=Farbe1;
        DBCheckBoxGeaendert.Color:=Farbe1;
        DBTextArtikel.Color:=Farbe1;
        DBCheckBoxArtikelErledigt1.Color:=Farbe1;
        DBCheckBoxArtikelErledigt2.Color:=Farbe1;
        DBCheckBoxArtikelErledigt3.Color:=Farbe1;
        DBCheckBoxArtikelErledigt4.Color:=Farbe1;
        DBEditBerechnungsArt.Color:=Farbe1;
        DBEditGewicht.Color:=Farbe1;
        DBEditZahl1.Color:=Farbe1;
        DBEditZahl2.Color:=Farbe1;
        DBEditZahl3.Color:=Farbe1;
        DBEditRabatt.Color:=Farbe1;
        DBEditArtikelNr.Color:=Farbe1;
        DBEditBerechnen1.Color:=Farbe1;
        DBEditBerechnen2.Color:=Farbe1;
        DBEditBerechnen3.Color:=Farbe1;
    End;
    if DBCtrlGridArtikel.PanelIndex=Index then begin
      DBCtrlGridArtikel.Canvas.Brush.Color := Farbe3;
        DBEditPos_Nr.Color:=Farbe3;
        DBEditArtikelGruppe.Color:=Farbe3;
        DBEditArtikel.Color:=Farbe3;
        DBEditMenge.Color:=Farbe3;
        DBEditEinheitMenge.Color:=Farbe3;
        DBEditEK_Preis.Color:=Farbe3;
        DBEditEinheit_EK.Color:=Farbe3;
        DBEditAufschlag.Color:=Farbe3;
        DBEditVK_Preis.Color:=Farbe3;
        DBMemoPosText.Color:=Farbe3;
        DBCheckBoxGeaendert.Color:=Farbe3;
        DBTextArtikel.Color:=Farbe3;
        DBCheckBoxArtikelErledigt1.Color:=Farbe3;
        DBCheckBoxArtikelErledigt2.Color:=Farbe3;
        DBCheckBoxArtikelErledigt3.Color:=Farbe3;
        DBCheckBoxArtikelErledigt4.Color:=Farbe3;
        DBEditBerechnungsArt.Color:=Farbe3;
        DBEditGewicht.Color:=Farbe3;
        DBEditZahl1.Color:=Farbe3;
        DBEditZahl2.Color:=Farbe3;
        DBEditZahl3.Color:=Farbe3;
        DBEditRabatt.Color:=Farbe3;
        DBEditArtikelNr.Color:=Farbe3;
        DBEditBerechnen1.Color:=Farbe3;
        DBEditBerechnen2.Color:=Farbe3;
        DBEditBerechnen3.Color:=Farbe3;
    end;
    DBCtrlGridArtikel.Canvas.Rectangle(0, 0, DBCtrlGridArtikel.PanelWidth,DBCtrlGridArtikel.PanelHeight);
  end;
end;

procedure TFormArtikelSammlung.ButtonFusstextClick(Sender: TObject);//Bedienung
begin
  UFocus:='DBMemoFuss';
  ButtonSuchenClick(Self);
  ActiveControl:=DBMemoFuss;
end;

procedure TFormArtikelSammlung.ButtonKopftextClick(Sender: TObject);//Bedienung
begin
   UFocus:='DBMemoKopf';
   ButtonSuchenClick(Self);
   ActiveControl:=DBMemoKopf;
end;

procedure TFormArtikelSammlung.LabelProjektNameClick(Sender: TObject);//Bedienung
begin
   UFocus:='DBEditProjekt';
   ButtonSuchenClick(Self);
   ActiveControl:=DBEditProjekt;
end;

procedure TFormArtikelSammlung.LabelAdresseClick(Sender: TObject);//Bedienung
begin
   UFocus:='DBEditAdresse';
   ButtonSuchenClick(Self);
   ActiveControl:=DBEditAdresse;
end;

procedure TFormArtikelSammlung.LabelGruppeClick(Sender: TObject);//Bedienung
begin
   UFocus:='DBEditGruppierung';
   ButtonSuchenClick(Self);
   ActiveControl:=DBEditGruppierung;
end;

procedure TFormArtikelSammlung.LabelBearbeiterClick(Sender: TObject);//Bedienung
begin
   UFocus:='DBEditBearbeiter';
   ButtonSuchenClick(Self);
   ActiveControl:=DBEditBearbeiter;
end;

procedure TFormArtikelSammlung.LabelErfassungsdatumClick(Sender: TObject);//Bedienung
begin
   UFocus:='DBEditLetzteBearbeitung';
   ButtonSuchenClick(Self);
   ActiveControl:=DBEditLetzteBearbeitung;
end;

procedure TFormArtikelSammlung.DBCtrlGridArtikelEnter(Sender: TObject);//Bedienung
begin
  //U Focus:='';
  //Focus;
  //Showmessage('DBCtrlGridArtikelEnter');
  if QueryArtikelListe.Active then begin
    //Showmessage('DBCtrlGridArtikelEnter.Active');
    UAGArtikel:=QueryArtikelListe.FieldByName('Artikel').Asstring;
    UAGArtikelgruppe:=QueryArtikelListe.FieldByName('ArtikelGruppe').Asstring;
    UAGName1:=QueryArtikelListe.FieldByName('Name1').Asstring;
    UAGName2:=QueryArtikelListe.FieldByName('Name2').Asstring;
    UAGName3:=QueryArtikelListe.FieldByName('Name3').Asstring;
    UAGEinheitMenge:=QueryArtikelListe.FieldByName('EinheitMenge').Asstring;
    //UAGEK_Preis:=QueryArtikelListe.FieldByName('EK_Preis').AsFloat;
    UAGEinheit_EK:=QueryArtikelListe.FieldByName('Einheit_EK').Asstring;
    //UAGAufschlag:=QueryArtikelListe.FieldByName('Aufschlag').AsFloat;
    UAGZahl1:=QueryArtikelListe.FieldByName('Zahl1').AsFloat;
    UAGZahl2:=QueryArtikelListe.FieldByName('Zahl1').AsFloat;
    UAGZahl3:=QueryArtikelListe.FieldByName('Zahl1').AsFloat;
    UAGgewicht:=QueryArtikelListe.FieldByName('Gewicht').AsFloat;
    UAGArtikelNr:=QueryArtikelListe.FieldByName('Artikel_Nr').Asstring;
    UAGBerechnungsArt:=QueryArtikelListe.FieldByName('Berechnungsart').Asstring;
    //UAGRabatt:=QueryArtikelListe.FieldByName('Rabatt').AsFloat;
  end;
  if UEnaF5 then Buttonkopieren.Enabled:=True;
  if UEnaF6 then Buttonaendern.Enabled:=True;
  if UEnaF8 then ButtonLoeschen.Enabled:=True;
  //Buttonsuchen.Enabled:=True;
  Focus;
end;

procedure TFormArtikelSammlung.DBCtrlGridArtikelExit(Sender: TObject);//Bedienung
begin
  //UFocus:='';
  //Showmessage('DBCtrlGridArtikelExit');
  If (ActiveControl.Name = Buttonkopieren.Name) or
  (ActiveControl.Name = Buttonaendern.Name) or
  (ActiveControl.Name = ButtonLoeschen.Name) Then
  Else begin
    Buttonkopieren.Enabled:=False;
    Buttonaendern.Enabled:=False;
    ButtonLoeschen.Enabled:=False;
  end;
  //Buttonsuchen.Enabled:=False;
  //Focus;
end;

function TFormArtikelSammlung.berechnung(Berechnungstext:String;Kennung:integer;FBerechneter_EK:Real):Real;//Bedienung
var N1,N2,E,Aufschlag,Rabatt:Real;
   i:integer;
   ErsteZahl:Boolean;
   Feld,O,O2,s,z:String;
begin
  s:=Berechnungstext;
  if s='' then s:='Menge*EK_Preis';
  N1:=0.0;N2:=0.0;E:=0.0;
  ErsteZahl:=True;
  for i:=1 to length(s) do
  begin
    z:=copy(s,i,1);
    if (z='+')or(z='-')or(z='*')or(z='/') then begin
      if ErsteZahl Then O2:=Z  Else begin O:=O2;O2:=Z; end;
      //if (FeldEineZahl(Feld) = False) and (QueryArtikelliste.FieldByName(Feld).AsString ='') then N1:=0.0;
      if ErsteZahl then  begin
        if FeldEineZahl(Feld) then N1:=strtoFloat(Feld)
        Else begin
          if (Kennung=3) and (Feld='Berechneter_EK') then N1:=FBerechneter_EK
          Else begin               
            if QueryArtikelliste.FieldByName(Feld).AsString ='' then N1:=0.0
            Else N1:=strtoFloat(QueryArtikelliste.FieldByName(Feld).AsString);
          end;
        end;
        ErsteZahl:=False;
      end else  begin
        if FeldEineZahl(Feld) then N2:=strtoFloat(Feld)
        Else begin
          if (Kennung=3) and (Feld='Berechneter_EK') then N2:=FBerechneter_EK
          Else begin
            if QueryArtikelliste.FieldByName(Feld).AsString ='' then N2:=0.0
            Else N2:=strtoFloat(QueryArtikelliste.FieldByName(Feld).AsString);
          end;
        end;
        if O='+' then E:=N1 + N2;
        if O='-' then E:=N1 - N2;
        if O='*' then E:=N1 * N2;
        if O='/' then if N2=0.0 then E:=0.0 Else E:=N1 / N2;
        N1:=E;
      end;
      Feld:='';
    end
    else Feld:=Feld+z;
  end;  //ende for
  if (ErsteZahl=False) and (N1<>0.0) then  begin
    if (Feld<>'Berechneter_EK') and (FeldEineZahl(Feld) = False) and (QueryArtikelliste.FieldByName(Feld).AsString ='') then
      N1:=0.0
    else
    begin
      if FeldEineZahl(Feld) then N2:=strtoFloat(Feld)
      Else  begin
        if (Kennung=3) and (Feld='Berechneter_EK') then N2:=FBerechneter_EK
        Else begin
          if QueryArtikelliste.FieldByName(Feld).AsString ='' then N2:=0.0
          Else N2:=strtoFloat(QueryArtikelliste.FieldByName(Feld).AsString);
        end;
      end;
      O:=O2;
      if O='+' then E:=N1 + N2;
      if O='-' then E:=N1 - N2;
      if O='*' then E:=N1 * N2;
      if O='/' then if N2=0.0 then E:=0.0 Else E:=N1 / N2;
      N1:=E;
    end;
    if Kennung = 0 Then begin
      if QueryArtikelliste.FieldByName('Aufschlag').AsString <>'' then
        N1:=N1+(N1/100*(strtoFloat(QueryArtikelliste.FieldByName('Aufschlag').AsString)));
      if QueryArtikelliste.FieldByName('Rabatt').AsString <>'' then
        N1:=N1/100*(100-strtoFloat(QueryArtikelliste.FieldByName('Rabatt').AsString));
    end;
  end;
  Result:=N1;
end;

function TFormArtikelSammlung.FeldEineZahl(Zahl:String):Boolean;
Var Komma,ZahlJa:Boolean;
    I:Integer;
    z:String;
begin
  Komma:=False;
  ZahlJa:=True;
  z:='';
  if Zahl='' Then  ZahlJa:=False;
  for i:=1 to length(Zahl) do begin
    z:=copy(Zahl,i,1);
    if (z='0') or (z='1') or (z='2') or (z='3') or (z='4') or (z='5') or (z='6') or (z='7') or (z='8') or (z='9') or (z=',') then begin
       If (z=',') Then begin
         If Komma then  ZahlJa:=False;
         Komma:=True;
       end;
    end
    Else  ZahlJa:=False;
  end;
  Result:=ZahlJa;
end;

procedure TFormArtikelSammlung.geheZu(Pos:integer);//Bedienung
var i:integer;
begin
  QueryArtikelListe.disableControls;
  QueryArtikelListe.First;
  for I:=1 to QueryArtikelListe.RecordCount do
  begin
    if QueryArtikelListe.FieldByName('Pos_Nr').Asstring = inttostr(Pos) then break;
    QueryArtikelListe.Next;
  end;
  QueryArtikelListe.EnableControls;
end;

procedure TFormArtikelSammlung.QueryEinstellungModulartAfterInsert(
  DataSet: TDataSet);
begin
  //  if QueryArtikelliste.FieldByName('ArtikelArt').AsString = 'Stueckliste' Then
  //  DataModuleDB.DatensatzkopierenListeMitFeld('StuecklistenArtikel','Stuecklisten_Nr',QueryArtikelliste.FieldByName('Artikel_Nr').Asinteger,'StuecklistenArtikel','Artikelliste_Nr',strtoint(QueryArtikelliste.FieldByName('Nr').AsString));
end;

procedure TFormArtikelSammlung.drucken(Fdruckart:integer);
var
  FModul_Name:String;
  BandIntern,BandMaster,BandDetail,BandSeitenanfang,BandSeitenEnde,BandSumme:TfrBandView;
  LProjekt,LAdresse,LBezeichnung,LGruppe,LNotiz,LText1,LText2,LText3:TfrView;
  DBTProjekt,DBTAdresse,DBTBezeichnung,DBTGruppe,DBTNotiz:TfrView;
  DBTAdressMemo,LAbs,LModulartKlein,DBTModul_Nr,LNr,LBearbeiter,LDatum,LTranzaktionsNr,LIhrZeichen,LRahmen1,LRahmen2:TfrView;
  DBTBearbeiter,DBTDatum,DBTTranzaktionsNr,DBTIhrZeichen,DBTModulartGross,DBTMemoKopf,LKopfSeite1:TfrView;
  DBTPos_Nr,DBTArtikelgruppe,DBTArtikel,DBTPos_Text:TfrView;
  DBTA1,DBTA2,DBTA3,DBTA4,DBTA5,DBTA6,DBTA7,DBTA8,DBTA9,DBTA10:TfrView;
  DBTA11,DBTA12,DBTA13,DBTA14,DBTA15,DBTA16,DBTA17,DBTA18,DBTA19,DBTA20:TfrView;
  LSeitenanfang,LSeitenEnde,DBTSumme1,DBTSumme2,DBTSumme3,DBTSumme4,DBTMemoFuss:TfrView;
  DBTB1,DBTB2,DBTB3:TfrView;
  Page,Page1: TfrPage;
  Logo,Logo2:TfrView;
  StreamLogo:TStream;
  //Logo:TfrPictureView;
  SO,SL,AnfangPositionen,SummenZeilenOhneMemo,FModul_Nr:integer;
  //BandInternV,BandKopfV,Farbe:Boolean;
  BandInterHoehe,BandKopfHoehe,BandSeite1KopfAnfang,BandSummenhoehe:integer;
  //F1,F2,F3,Kopfzeile,Abs:String;RahmenKopfzeile,Rahmenfusszeile,RahmenAdresse,RahmenABS,RahmenRechtsOben,RahmenA,RahmenSummenZeile1:integer;Fusszeile,Titeltext:String;
  A1_Feldname, A2_Feldname,A3_Feldname,A4_Feldname,A5_Feldname,A6_Feldname,A7_Feldname,A8_Feldname,A9_Feldname,A10_Feldname:String;
  A1_Sichtbar,A2_Sichtbar,A3_Sichtbar,A4_Sichtbar,A5_Sichtbar,A6_Sichtbar,A7_Sichtbar,A8_Sichtbar,A9_Sichtbar,A10_Sichtbar,Titelzeigen:Boolean;
  A1_x,A2_x,A3_x,A4_x,A5_x,A6_x,A7_x,A8_x,A9_x,A10_x:integer;
  A1_laenge,A2_laenge,A3_laenge,A4_laenge,A5_laenge,A6_laenge,A7_laenge,A8_laenge,A9_laenge,A10_laenge:integer;
  A1_Justierung,A2_Justierung,A3_Justierung,A4_Justierung,A5_Justierung,A6_Justierung,A7_Justierung,A8_Justierung,A9_Justierung,A10_Justierung,Titeljustierung:integer;
  SummenZeile1,SummenZeile2,SummenZeile3,SummenZeile4:String;
  //C1,C2,C3:TColor;
//  Notizhoehe,KopftextHoehe,FusstextHoehe,R1,SchriftgroesseA1_A10,Titelgroesse,H1:Integer;
  Seitengroesse:TRect;
  Kopfende,Notizhoehe,KopftextHoehe,FusstextHoehe,PosAnfang,Masterhoehe,H1,SeitenKopfhoehe:integer;
  HoeheBisNotizAnfang,HoeheBisTitelAnfang,HoeheBisMemoKopfAnfang,HoeheBisSeitenkopfAnfang:integer;
  Done:Boolean;
  FDrucker,FDruckermaske:String;
begin
  summierung(0);
  FModul_Nr:=QueryModul.FieldByName('Modul_Nr').AsInteger;
  FModul_Name:=QueryModul.FieldByName('Modulart').AsString;
  frReport1.Pages.Clear;
  frReport1.Pages.Add;                // create page
  //frReport1.prev
  Page := frReport1.Pages[0];
  Page.UseMargins:=true;
  UStuecklisteJa:=False;
  UStuecklistenHoehe:=0;
  UPos_TextJa:=False;
//  Seitengroesse.Left:=5;
//  Seitengroesse.Right:=5;
//  Seitengroesse.Bottom:=40;
  //Page.pgMargins :=Seitengroesse;
  // --------Einstelungen laden und Datenbanken ---------------
  if QueryEinstellungModulart.Active then QueryEinstellungModulart.close;
  QueryEinstellungModulart.SQL.Clear;
  QueryEinstellungModulart.SQL.Add('Select * FROM EinstellungDrucken WHERE Nr = ' +'"'+ inttoStr(Fdruckart)+'"');
  try
    QueryEinstellungModulart.Open
  except
  end;
  //(QueryEinstellungModulart.FieldByName('BmpLogo') as TBlobField).SaveToStream(StreamLogo);
 // (Logo as TfrPictureView).BlobType:=btBMP;
  QueryModul.Edit;
  QueryModul.FieldByName('BMPLogo').ASVariant:=QueryEinstellungModulart.FieldByName('BMPLogo').ASVariant;
  QueryModul.Post;
  Seitengroesse.Top:=0;//QueryEinstellungModulart.FieldByName('Abstand_Oben').ASInteger;
  Seitengroesse.Left:=5;//QueryEinstellungModulart.FieldByName('Abstand_Links').ASInteger;
  Seitengroesse.Right:=QueryEinstellungModulart.FieldByName('Abstand_Rechts').ASInteger;
  Seitengroesse.Bottom:=QueryEinstellungModulart.FieldByName('Abstand_Unten').ASInteger;
  SL:=QueryEinstellungModulart.FieldByName('Abstand_Links').ASInteger;
  So:=QueryEinstellungModulart.FieldByName('PanelLogoEnde').ASInteger;
  USo:=So; UDruckeSeite:=0; //zum drucken vom logo
  Page.pgMargins :=Seitengroesse;
  ULogo2x:=0; ULogo2y:=0; ULogo2dx:=0; ULogo2dy:=0;
  {if UStuecklisteJa then begin
    if QueryArtikelListe_d.Active then QueryArtikelListe_d.close;
    QueryArtikelListe_d.sql.Clear;
    QueryArtikelListe_d.sql.add('Select * From ArtikelListeS Where Stuecklisten_Nr = 0 Order by Pos');
    try
      QueryArtikelListe_d.open;
    finally
    end;
    //Showmessage(QueryArtikelListe_d.sql[0]);  Showmessage(inttostr(QueryArtikelListe_d.RecordCount ));
  end;}
//------------ variable von Report-------------------------
   frReport1.Variables.Add('VK');
   frReport1.Variables.Add('MwSt');
   frReport1.Variables.Add('MwStBetrag');
   frReport1.Variables.Add('VKPlusMwSt');
   frVariables['VK']:=Floattostr(UVKPreis);
   frVariables['MwSt']:=Floattostr(UMwSt);
   frVariables['MwStBetrag']:=Floattostr(UVKPreis/100*UMwSt);
   frVariables['VKPlusMwSt']:=Floattostr(UVKPreis+(UVKPreis/100*UMwSt));
//------------ variable von Report ende-------------------------
  //BandInternV:=True;
  //BandKopfV:=True;//ohne adressmemo etc. ohne Memo Kopf und ohne MemoFuss

//  SL:=QueryEinstellungModulart.FieldByName('Abstand_Links').ASInteger;
  //Kopfzeile:=QueryEinstellungModulart.FieldByName('Kopfzeile').ASString;
  //Fusszeile:=QueryEinstellungModulart.FieldByName('Fusszeile').ASString;
  //Abs:=QueryEinstellungModulart.FieldByName('Absender').ASString;
  //Seitengroesse.Top:=QueryEinstellungModulart.FieldByName('Abstand_Oben').ASInteger;
//  So:=Seitengroesse.Top;
  SummenZeilenOhneMemo:=0;
  Kopfende:=0;
  Notizhoehe:=(DBMemoNotiz.Lines.Count)*15;
  FusstextHoehe:=(DBMemoFuss.Lines.Count)*15;
  KopftextHoehe:=(DBMemoKopf.Lines.Count)*15;
  //      ermittlung summenhöhe
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Summenzeile1').ASString);
  if DataModuleMyOffice.intToBol(FFormat.sichtbar) then SummenZeilenOhneMemo:=SummenZeilenOhneMemo+1;
  //SummenZeile1:=FFormat.Name;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Summenzeile2').ASString);
  if DataModuleMyOffice.intToBol(FFormat.sichtbar) then SummenZeilenOhneMemo:=SummenZeilenOhneMemo+1;
  //  SummenZeile2:=FFormat.Name;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Summenzeile3').ASString);
  if DataModuleMyOffice.intToBol(FFormat.sichtbar) then SummenZeilenOhneMemo:=SummenZeilenOhneMemo+1;
  //SummenZeile3:=FFormat.Name;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Summenzeile4').ASString);
  if DataModuleMyOffice.intToBol(FFormat.sichtbar) then SummenZeilenOhneMemo:=SummenZeilenOhneMemo+1;
  //SummenZeile4:=FFormat.Name;
//  if SummenZeile1 <> '' Then SummenZeilenOhneMemo:=SummenZeilenOhneMemo+1;
//  if SummenZeile2 <> '' Then SummenZeilenOhneMemo:=SummenZeilenOhneMemo+1;
//  if SummenZeile3 <> '' Then SummenZeilenOhneMemo:=SummenZeilenOhneMemo+1;
//  if SummenZeile4 <> '' Then SummenZeilenOhneMemo:=SummenZeilenOhneMemo+1;
  FDrucker:=QueryEinstellungModulart.FieldByName('FDrucker').ASString;
  FDruckermaske:=QueryEinstellungModulart.FieldByName('Druckermaske').ASString;
  BandSummenhoehe:=20*SummenZeilenOhneMemo;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('MemoFuss').ASString);
  if DataModuleMyOffice.intToBol(FFormat.sichtbar) then BandSummenhoehe:=BandSummenhoehe+FusstextHoehe;

  DataModuleMyOffice.FddNil(21);//alle 20 Felder auf nil setzen
  DataModuleMyOffice.FddGet(1,QueryEinstellungModulart.FieldByName('Feld1').ASString);
  DataModuleMyOffice.FddGet(2,QueryEinstellungModulart.FieldByName('Feld2').ASString);
  DataModuleMyOffice.FddGet(3,QueryEinstellungModulart.FieldByName('Feld3').ASString);
  DataModuleMyOffice.FddGet(4,QueryEinstellungModulart.FieldByName('Feld4').ASString);
  DataModuleMyOffice.FddGet(5,QueryEinstellungModulart.FieldByName('Feld5').ASString);
  DataModuleMyOffice.FddGet(6,QueryEinstellungModulart.FieldByName('Feld6').ASString);
  DataModuleMyOffice.FddGet(7,QueryEinstellungModulart.FieldByName('Feld7').ASString);
  DataModuleMyOffice.FddGet(8,QueryEinstellungModulart.FieldByName('Feld8').ASString);
  DataModuleMyOffice.FddGet(9,QueryEinstellungModulart.FieldByName('Feld9').ASString);
  DataModuleMyOffice.FddGet(10,QueryEinstellungModulart.FieldByName('Feld10').ASString);
  DataModuleMyOffice.FddGet(11,QueryEinstellungModulart.FieldByName('Feld11').ASString);
  DataModuleMyOffice.FddGet(12,QueryEinstellungModulart.FieldByName('Feld12').ASString);
  DataModuleMyOffice.FddGet(13,QueryEinstellungModulart.FieldByName('Feld13').ASString);
  DataModuleMyOffice.FddGet(14,QueryEinstellungModulart.FieldByName('Feld14').ASString);
  DataModuleMyOffice.FddGet(15,QueryEinstellungModulart.FieldByName('Feld15').ASString);
  DataModuleMyOffice.FddGet(16,QueryEinstellungModulart.FieldByName('Feld16').ASString);
  DataModuleMyOffice.FddGet(17,QueryEinstellungModulart.FieldByName('Feld17').ASString);
  DataModuleMyOffice.FddGet(18,QueryEinstellungModulart.FieldByName('Feld18').ASString);
  DataModuleMyOffice.FddGet(19,QueryEinstellungModulart.FieldByName('Feld19').ASString);
  DataModuleMyOffice.FddGet(20,QueryEinstellungModulart.FieldByName('Feld20').ASString);
  Masterhoehe:=20;
  if (Masterhoehe<Fdd1.y) and (Fdd1.Sichtbar=1 )Then  Masterhoehe:=Fdd1.y+20;
  if (Masterhoehe<Fdd2.y) and (Fdd2.Sichtbar=1 )Then  Masterhoehe:=Fdd2.y+20;
  if (Masterhoehe<Fdd3.y) and (Fdd3.Sichtbar=1 )Then  Masterhoehe:=Fdd3.y+20;
  if (Masterhoehe<Fdd4.y) and (Fdd4.Sichtbar=1 )Then  Masterhoehe:=Fdd4.y+20;
  if (Masterhoehe<Fdd5.y) and (Fdd5.Sichtbar=1 )Then  Masterhoehe:=Fdd5.y+20;
  if (Masterhoehe<Fdd6.y) and (Fdd6.Sichtbar=1 )Then  Masterhoehe:=Fdd6.y+20;
  if (Masterhoehe<Fdd7.y) and (Fdd7.Sichtbar=1 )Then  Masterhoehe:=Fdd7.y+20;
  if (Masterhoehe<Fdd8.y) and (Fdd8.Sichtbar=1 )Then  Masterhoehe:=Fdd8.y+20;
  if (Masterhoehe<Fdd9.y) and (Fdd9.Sichtbar=1 )Then  Masterhoehe:=Fdd9.y+20;
  if (Masterhoehe<Fdd10.y) and (Fdd10.Sichtbar=1 )Then  Masterhoehe:=Fdd10.y+20;
  if (Masterhoehe<Fdd11.y) and (Fdd11.Sichtbar=1 )Then  Masterhoehe:=Fdd11.y+20;
  if (Masterhoehe<Fdd12.y) and (Fdd12.Sichtbar=1 )Then  Masterhoehe:=Fdd12.y+20;
  if (Masterhoehe<Fdd13.y) and (Fdd13.Sichtbar=1 )Then  Masterhoehe:=Fdd13.y+20;
  if (Masterhoehe<Fdd14.y) and (Fdd14.Sichtbar=1 )Then  Masterhoehe:=Fdd14.y+20;
  if (Masterhoehe<Fdd15.y) and (Fdd15.Sichtbar=1 )Then  Masterhoehe:=Fdd15.y+20;
  if (Masterhoehe<Fdd16.y) and (Fdd16.Sichtbar=1 )Then  Masterhoehe:=Fdd16.y+20;
  if (Masterhoehe<Fdd17.y) and (Fdd17.Sichtbar=1 )Then  Masterhoehe:=Fdd17.y+20;
  if (Masterhoehe<Fdd18.y) and (Fdd18.Sichtbar=1 )Then  Masterhoehe:=Fdd18.y+20;
  if (Masterhoehe<Fdd19.y) and (Fdd19.Sichtbar=1 )Then  Masterhoehe:=Fdd19.y+20;
  if (Masterhoehe<Fdd20.y) and (Fdd20.Sichtbar=1 )Then  Masterhoehe:=Fdd20.y+20;
  UFdd20y:=Masterhoehe;//Fdd20.y;
  //Masterhoehe:=Masterhoehe+50;
  if DataModuleMyOffice.IntToBol(Fdd19.Sichtbar) Then  UStuecklisteJa:=True Else UStuecklisteJa:=False;

  //--if UStuecklisteJa then begin
  //--  QueryArtikelListe.post;
  //--  if QueryArtikelListe.Active then QueryArtikelListe.close;
  //--  QueryArtikelListe.sql.Clear;
   // QueryArtikelListe.sql.add('Select * From Artikelliste,Artikellistes Where Artikelliste.Modul_Nr =' + inttostr(Uzeiger)+ ' Order by Pos_Nr');
   //Select Artikelliste.nr, Artikelliste.Pos_Nr, Artikelliste.Modul_Nr, Artikellistes.Nr, Artikellistes.Pos, Artikellistes.Stuecklisten_Nr
   //From Artikelliste,Artikellistes
   //Where Artikelliste.Modul_Nr = 25
   //and (Stuecklisten_Nr = Artikelliste.Nr or Stuecklisten_Nr=0)
   //Order By Artikelliste.Pos_Nr
   //-- QueryArtikelListe.sql.add('Select * From Artikelliste,Artikellistes Where Artikelliste.Modul_Nr = ' + inttostr(Uzeiger)+ ' and (Artikellistes.Stuecklisten_Nr = Artikelliste.Nr or Artikellistes.Stuecklisten_Nr = 0 ) Order By Artikelliste.Pos_Nr,Artikellistes.Pos');
   //-- try
   //--   QueryArtikelListe.open;
   //-- finally
   //-- end;
  //--end;
  //  Showmessage(Fdd1.Name);
//  Showmessage(QueryEinstellungModulart.FieldByName('Feld1').ASString);


  //RahmenKopfzeile:=QueryEinstellungModulart.FieldByName('D_RahmenKopfzeile').ASInteger;
  //RahmenFusszeile:=QueryEinstellungModulart.FieldByName('D_RahmenFusszeile').ASInteger;
  //RahmenAdresse:=QueryEinstellungModulart.FieldByName('D_RahmenAdresse').ASInteger;
  //RahmenAbs:=QueryEinstellungModulart.FieldByName('D_RahmenABS').ASInteger;
  //RahmenRechtsOben:=QueryEinstellungModulart.FieldByName('D_RahmenRechtsOben').ASInteger;
  //RahmenA:=QueryEinstellungModulart.FieldByName('D_RahmenA').ASInteger;
  //RahmenSummenZeile1:=QueryEinstellungModulart.FieldByName('D_RahmenSumme1').ASInteger;
  //Titelzeigen:=DataModuleMyOffice.InttoBol(QueryEinstellungModulart.FieldByName('D_Titelzeigen').ASInteger);
  //Titelgroesse:=QueryEinstellungModulart.FieldByName('D_Titelgroesse').ASInteger;
  {Kopfende:=0;
  Notizhoehe:=(DBMemoNotiz.Lines.Count)*14;
  FusstextHoehe:=(DBMemoFuss.Lines.Count)*14;
  KopftextHoehe:=(DBMemoKopf.Lines.Count)*14;}

  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelProjekt').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Projekt').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Projekt').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelGruppe').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Gruppe').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelBezeichnung').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Bezeichnung').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelAdresseKurzname').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('AdresseKurzname').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Absender').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelModulartklein').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Modulartklein').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Adresse').ASString);
  if (Kopfende < FFormat.y+100) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y+100;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelBearbeiter').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Bearbeiter').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelDatum').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Datum').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelTransaktionsNr').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('TransaktionsNr').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelIhrZeichen').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('IhrZeichen').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Text1').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Text2').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Text3').ASString);
  if (Kopfende < FFormat.y) and  (DataModuleMyOffice.intToBol(FFormat.sichtbar)) Then Kopfende:=FFormat.y;
  //Kopfende:=kopfende+So;
  //DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Notiz').ASString);
  //if Kopfende < FFormat.y+Notizhoehe Then Kopfende:=FFormat.y+Notizhoehe;
  //  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('ImageLogo').ASString);
  //  HoeheBisNotizAnfang,HoeheBisTitelAnfang,HoeheBisMemoKopfAnfang,HoeheBisSeitenkopfAnfang:integer;
  //Posanfang:=Kopfende;//+20;
  HoeheBisNotizAnfang:=Kopfende+20;
  HoeheBisTitelAnfang:=HoeheBisNotizAnfang+20;
  DataModuleMyOffice.FFormatNil(0); DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Notiz').ASString);
  if DataModuleMyOffice.intToBol(FFormat.sichtbar) Then  HoeheBisTitelAnfang:=HoeheBisNotizAnfang+Notizhoehe+10;
  HoeheBisMemoKopfAnfang:=HoeheBisTitelAnfang;
  DataModuleMyOffice.FFormatNil(0); DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Titel').ASString);
  Titelzeigen:=DataModuleMyOffice.intToBol(FFormat.sichtbar);
  if Titelzeigen Then begin
    FModul_Name:='';
    if FFormat.Name = '#' then FModul_Name:=QueryModul.FieldByName('Modulart').ASString;
    HoeheBisMemoKopfAnfang:=HoeheBisTitelAnfang+(FFormat.Groesse*2);
  end;
  HoeheBisSeitenkopfAnfang:=HoeheBisMemoKopfAnfang;
  DataModuleMyOffice.FFormatNil(0); DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('MemoKopf').ASString);
  if DataModuleMyOffice.intToBol(FFormat.sichtbar) Then HoeheBisSeitenkopfAnfang:=HoeheBisSeitenkopfAnfang+KopftextHoehe+10;
  Posanfang:=HoeheBisSeitenkopfAnfang;
  DataModuleMyOffice.FFormatNil(0); DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Kopfzeile').ASString);
  if DataModuleMyOffice.intToBol(FFormat.sichtbar) Then SeitenKopfhoehe:=20 Else SeitenKopfhoehe:=0;
  Posanfang:=Posanfang+SeitenKopfhoehe;
//Definnition der Bänder
  BandIntern:=TfrBandView(frCreateObject(gtBand, ''));  // create MasterData band
  BandIntern.SetBounds(0,0,700,So+HoeheBisSeitenkopfAnfang-2);
  BandIntern.BandType := btReporttitle;
  BandIntern.Dataset := 'frDBDataSetModule';
  Page.Objects.Add(BandIntern);

  DataModuleMyOffice.FFormatNil(0); DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Kopfzeile').ASString);
  if DataModuleMyOffice.intToBol(FFormat.sichtbar) Then begin
    BandSeitenanfang:=TfrBandView(frCreateObject(gtBand, ''));  // create MasterData band
    BandSeitenanfang.SetBounds(0,So+HoeheBisSeitenkopfAnfang,700,18);
    BandSeitenanfang.BandType := btPageHeader;
    BandSeitenanfang.Dataset := 'frDBDataSetArtikel';
    Page.Objects.Add(BandSeitenanfang);
  end;

  BandMaster:=TfrBandView(frCreateObject(gtBand, ''));  // create MasterData band
  BandMaster.SetBounds(0,So+PosAnfang-1,700,Masterhoehe);
  if not UStuecklisteJa then begin
    BandMaster.BandType := btMasterData;
  end Else begin
    BandMaster.BandType := btGroupHeader;
    BandMaster.GroupCondition:='[QueryArtikelListe."Pos_Nr"]';
  end;

  //if Fdruckart <> 2 then BandMaster.Dataset := 'frDBDataSetArtikel' Else BandMaster.Dataset := 'frDBDataSetStueckliste';
  BandMaster.Dataset := 'frDBDataSetArtikel';
  //BandMaster.FrameTyp:=1;
  Page.Objects.Add(BandMaster);

  if UStuecklisteJa then begin
    BandDetail:=TfrBandView(frCreateObject(gtBand, ''));  // create MasterData band
    BandDetail.SetBounds(0,So+PosAnfang+Fdd19.y,700,20);
    BandDetail.BandType := btMasterData;
    //Showmessage('wenn UStuecklisteJa dann Band y='+inttostr(So+PosAnfang+Fdd19.y));
    BandDetail.Dataset := 'frDBDataSetArtikel';
    Page.Objects.Add(BandDetail);
  end;

  BandSumme:=TfrBandView(frCreateObject(gtBand, ''));  // create MasterData band
  BandSumme.SetBounds(0,So+PosAnfang+MasterHoehe,700,BandSummenhoehe{+FusstextHoehe});
  BandSumme.BandType := btReportSummary;
  BandSumme.Dataset := 'frDBDataSetArtikel';
  Page.Objects.Add(BandSumme);
  //btPageHeader, btPageFooter,btReportSummary,

  BandSeitenEnde:=TfrBandView(frCreateObject(gtBand, ''));  // create MasterData band
  BandSeitenEnde.SetBounds(0,So+PosAnfang+MasterHoehe+BandSummenhoehe{+FusstextHoehe}+10,700,20);
  BandSeitenEnde.BandType := btPageFooter;
  BandSeitenEnde.Dataset := 'frDBDataSetArtikel';
  Page.Objects.Add(BandSeitenEnde);

  //////////////////////Daten---Kopf
  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('FormatLogo').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    Logo:= frCreateObject(gtPicture, '');  // create data field
    Logo.SetBounds(SL+FFormat.x,FFormat.y,FFormat.l,FFormat.h);
    Logo.Memo.Add('[QueryModul."BMPLogo"]');
    (Logo as TfrPictureView).Typ:=1;
    (Logo as TfrPictureView).Name:='Logo1';
    Page.Objects.Add(Logo);
  end;
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    Logo2:= frCreateObject(gtPicture, '');  // create data field
    //Logo2.SetBounds(SL+FFormat.x,FFormat.y,FFormat.l,FFormat.h);
    Logo2.SetBounds(SL+FFormat.x,So+HoeheBisSeitenkopfAnfang,0,0);
    Logo2.Memo.Add('[QueryModul."BMPLogo"]');
    (Logo2 as TfrPictureView).Typ:=1;
    (Logo2 as TfrPictureView).Name:='Logo2';
    Page.Objects.Add(Logo2);
    ULogo2x:=SL+FFormat.x;ULogo2y:=FFormat.y;ULogo2dx:=FFormat.l;ULogo2dy:=FFormat.h;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelProjekt').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LProjekt:= frCreateObject(gtMemo, '');  // create data field
    LProjekt.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    LProjekt.Memo.Add(FFormat.Name);
    (LProjekt as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LProjekt as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LProjekt as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LProjekt as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LProjekt as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LProjekt as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LProjekt); // if BandInternV then LProjekt.Visible:=DBEditProjekt.Visible Else LProjekt.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Projekt').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTProjekt:= frCreateObject(gtMemo, '');  // create data field
    DBTProjekt.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    DBTProjekt.Memo.Add('[QueryModul."Projektname"]');
    (DBTProjekt as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTProjekt as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTProjekt as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTProjekt as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTProjekt as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTProjekt as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTProjekt); //if BandInternV then DBTProjekt.Visible:=DBEditProjekt.Visible Else DBTProjekt.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelGruppe').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LGruppe:= frCreateObject(gtMemo, '');  // create data field
    LGruppe.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    LGruppe.Memo.Add(FFormat.Name);
    (LGruppe as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LGruppe as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LGruppe as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LGruppe as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LGruppe as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LGruppe as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LGruppe); // if BandInternV then LGruppe.Visible:=DBEditGruppierung.Visible Else LGruppe.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Gruppe').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTGruppe:= frCreateObject(gtMemo, '');  // create data field
    DBTGruppe.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    DBTGruppe.Memo.Add('[QueryModul."Gruppierung"]');
    (DBTGruppe as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTGruppe as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTGruppe as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTGruppe as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTGruppe as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTGruppe as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTGruppe); //if BandInternV then DBTGruppe.Visible:=DBEditGruppierung.Visible Else DBTGruppe.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelBezeichnung').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LBezeichnung:= frCreateObject(gtMemo, '');  // create data field
    LBezeichnung.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    LBezeichnung.Memo.Add(FFormat.Name);
    (LBezeichnung as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LBezeichnung as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LBezeichnung as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LBezeichnung as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LBezeichnung as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LBezeichnung as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LBezeichnung); // if BandInternV then LBezeichnung.Visible:=DBEditBezeichnung.Visible Else LBezeichnung.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Bezeichnung').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTBezeichnung:= frCreateObject(gtMemo, '');  // create data field
    DBTBezeichnung.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    DBTBezeichnung.Memo.Add('[QueryModul."Bezeichnung"]');
    (DBTBezeichnung as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTBezeichnung as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTBezeichnung as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTBezeichnung as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTBezeichnung as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTBezeichnung as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTBezeichnung);// if BandInternV then DBTBezeichnung.Visible:=DBEditBezeichnung.Visible Else DBTBezeichnung.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelAdresseKurzname').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LAdresse:= frCreateObject(gtMemo, '');  // create data field
    LAdresse.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    LAdresse.Memo.Add(FFormat.Name);
    (LAdresse as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LAdresse as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LAdresse as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LAdresse as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LAdresse as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LAdresse as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LAdresse); // if BandInternV then LAdresse.Visible:=DBEditAdresse.Visible Else LAdresse.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('AdresseKurzname').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTAdresse:= frCreateObject(gtMemo, '');  // create data field
    DBTAdresse.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    DBTAdresse.Memo.Add('[QueryModul."Adressname"]');
    (DBTAdresse as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTAdresse as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTAdresse as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTAdresse as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTAdresse as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTAdresse as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTAdresse);  // BandInternV then DBTAdresse.Visible:=DBEditAdresse.Visible Else DBTAdresse.Visible:=False;
  end;

  {DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelNotiz').ASString);
  LNotiz:= frCreateObject(gtMemo, '');  // create data field
  LNotiz.SetBounds(SL+320,20, 120, 18);
  LNotiz.Memo.Add('Notiz :');
  (LNotiz as TfrMemoView).Font.Style:=[fsBold];
  (LNotiz as TfrMemoView).Font.Size:=10;
  (LNotiz as TfrMemoView).Font.Name:=F1;
  (LNotiz as TfrMemoView).Font.Color:=C1;
  (LNotiz as TfrMemoView).FrameTyp:=R1;
  (LNotiz as TfrMemoView).Adjust:=0;
  Page.Objects.Add(LNotiz);  if BandInternV then LNotiz.Visible:=DBMemoNotiz.Visible Else LNotiz.Visible:=False;}

//Kopf============================================================================

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Rahmen1').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LRahmen1:= frCreateObject(gtMemo, '');  // create data field
    LRahmen1.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l,FFormat.h);
    LRahmen1.Memo.Add('');
    //(LRahmen1 as TfrMemoView).Font.Style:=[];
    //(LRahmen1 as TfrMemoView).Font.Size:=6;
    //(LRahmen1 as TfrMemoView).Font.Name:=F2;
    //(LRahmen1 as TfrMemoView).Font.Color:=C1;
    (LRahmen1 as TfrMemoView).FrameTyp:=15;
    //(LRahmen1 as TfrMemoView).Adjust:=0;
    Page.Objects.Add(LRahmen1);  // BandKopfV then LRahmen1.Visible:=True Else LRahmen1.Visible:=False;}
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Rahmen2').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LRahmen2:= frCreateObject(gtMemo, '');  // create data field
    LRahmen2.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l,FFormat.h);
    LRahmen2.Memo.Add('');
    //(LRahmen2 as TfrMemoView).Font.Style:=[];
    //(LRahmen2 as TfrMemoView).Font.Size:=6;
    //(LRahmen2 as TfrMemoView).Font.Name:=F2;
    //(LRahmen2 as TfrMemoView).Font.Color:=C1;
    (LRahmen2 as TfrMemoView).FrameTyp:=15;
    //(LRahmen2 as TfrMemoView).Adjust:=0;
    Page.Objects.Add(LRahmen2);  // BandKopfV then LRahmen1.Visible:=True Else LRahmen1.Visible:=False;}
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Absender').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LAbs:= frCreateObject(gtMemo, '');  // create data field
    LAbs.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    LAbs.Memo.Add(FFormat.Name);
    (LAbs as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LAbs as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LAbs as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LAbs as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LAbs as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LAbs as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LAbs); // if BandKopfV then LAbs.Visible:=True Else LAbs.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Adresse').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTAdressMemo:= frCreateObject(gtMemo, '');  // create data field
    DBTAdressMemo.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 100);
    DBTAdressMemo.Memo.Add('[QueryModul."Adresse"]');
    (DBTAdressMemo as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTAdressMemo as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTAdressMemo as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTAdressMemo as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTAdressMemo as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTAdressMemo as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTAdressMemo); // if BandKopfV then DBTAdressMemo.Visible:=DBMemoAdresse.Visible Else DBTAdressMemo.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelModulartklein').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LModulartKlein:= frCreateObject(gtMemo, '');  // create data field
    LModulartKlein.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    LModulartKlein.Memo.Add(FModul_Name);
    (LModulartKlein as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LModulartKlein as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LModulartKlein as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LModulartKlein as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LModulartKlein as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LModulartKlein as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LModulartKlein); // if BandKopfV then LModulartKlein.Visible:=DBTextModulartKlein.Visible Else LModulartKlein.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Modulartklein').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTModul_Nr:= frCreateObject(gtMemo, '');  // create data field
    DBTModul_Nr.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    //DBTModul_Nr.Memo.Add('[QueryModul."Modul_Nr"]');
    DBTModul_Nr.Memo.Add(inttoStr(FModul_Nr));
//    DBTModul_Nr.Memo.Add(inttostr(FModul_Nr));
    (DBTModul_Nr as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTModul_Nr as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTModul_Nr as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTModul_Nr as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTModul_Nr as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTModul_Nr as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTModul_Nr); // if BandKopfV then DBTModul_Nr.Visible:=DBTextModulartKlein.Visible Else DBTModul_Nr.Visible:=False;
  end;

  {DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelModulartklein').ASString);
  if FFormat.Sichtbar Then begin
    LNr:= frCreateObject(gtMemo, '');  // create data field
    LNr.SetBounds(SL+FFormat.x+150,BandInterHoehe+20,30, 18);
    LNr.Memo.Add('Nr.');
    (LNr as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LNr as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LNr as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LNr as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LNr as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LNr as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LNr); // if BandKopfV then LNr.Visible:=DBTextModulartKlein.Visible Else LNr.Visible:=False;
  end;}

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelBearbeiter').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LBearbeiter:= frCreateObject(gtMemo, '');  // create data field
    LBearbeiter.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    LBearbeiter.Memo.Add(FFormat.Name);
    (LBearbeiter as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LBearbeiter as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LBearbeiter as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LBearbeiter as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LBearbeiter as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LBearbeiter as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LBearbeiter);//  if BandKopfV then LBearbeiter.Visible:=DBEditBearbeiter.Visible Else LBearbeiter.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Bearbeiter').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTBearbeiter:= frCreateObject(gtMemo, '');  // create data field
    DBTBearbeiter.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    DBTBearbeiter.Memo.Add('[QueryModul."Bearbeiter"]');
    (DBTBearbeiter as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTBearbeiter as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTBearbeiter as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTBearbeiter as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTBearbeiter as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTBearbeiter as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTBearbeiter);//  if BandKopfV then DBTBearbeiter.Visible:=DBEditBearbeiter.Visible Else DBTBearbeiter.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelDatum').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LDatum:= frCreateObject(gtMemo, '');  // create data field
    LDatum.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    LDatum.Memo.Add(FFormat.Name);
    (LDatum as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LDatum as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LDatum as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LDatum as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LDatum as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LDatum as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LDatum); // if BandKopfV then LDatum.Visible:=DBEditLetzteBearbeitung.Visible Else LDatum.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Datum').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTDatum:= frCreateObject(gtMemo, '');  // create data field
    DBTDatum.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    DBTDatum.Memo.Add('[QueryModul."LetzteBearbeitung"]');
    (DBTDatum as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTDatum as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTDatum as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTDatum as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTDatum as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTDatum as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTDatum); // if BandKopfV then DBTDatum.Visible:=DBEditLetzteBearbeitung.Visible Else DBTDatum.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelTransaktionsNr').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LTranzaktionsNr:= frCreateObject(gtMemo, '');  // create data field
    LTranzaktionsNr.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    LTranzaktionsNr.Memo.Add(FFormat.Name);
    (LTranzaktionsNr as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LTranzaktionsNr as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LTranzaktionsNr as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LTranzaktionsNr as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LTranzaktionsNr as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LTranzaktionsNr as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LTranzaktionsNr);//  if BandKopfV then LTranzaktionsNr.Visible:=LabelTransaktionsNr.Visible Else LTranzaktionsNr.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('TransaktionsNr').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTTranzaktionsNr:= frCreateObject(gtMemo, '');  // create data field
    DBTTranzaktionsNr.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    DBTTranzaktionsNr.Memo.Add(LabelTransaktionsNrNr.Caption);
    (DBTTranzaktionsNr as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTTranzaktionsNr as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTTranzaktionsNr as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTTranzaktionsNr as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTTranzaktionsNr as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTTranzaktionsNr as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTTranzaktionsNr);//  if BandKopfV then DBTTranzaktionsNr.Visible:=LabelTransaktionsNr.Visible Else DBTTranzaktionsNr.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('LabelIhrZeichen').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LIhrZeichen:= frCreateObject(gtMemo, '');  // create data field
    LIhrZeichen.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    LIhrZeichen.Memo.Add(FFormat.Name);
    (LIhrZeichen as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LIhrZeichen as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LIhrZeichen as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LIhrZeichen as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LIhrZeichen as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LIhrZeichen as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LIhrZeichen);//  if BandKopfV then LIhrZeichen.Visible:=DBEditKopfIhrZeichen.Visible Else LIhrZeichen.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('IhrZeichen').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTIhrZeichen:= frCreateObject(gtMemo, '');  // create data field
    DBTIhrZeichen.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    DBTIhrZeichen.Memo.Add('[QueryModul."IhrZeichen"]');
    (DBTIhrZeichen as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTIhrZeichen as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTIhrZeichen as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTIhrZeichen as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTIhrZeichen as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTIhrZeichen as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTIhrZeichen);//  if BandKopfV then DBTIhrZeichen.Visible:=DBEditKopfIhrZeichen.Visible Else DBTIhrZeichen.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Text1').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LText1:= frCreateObject(gtMemo, '');  // create data field
    LText1.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    LText1.Memo.Add(FFormat.Name);
    (LText1 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LText1 as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LText1 as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LText1 as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LText1 as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LText1 as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LText1);//  if BandKopfV then LIhrZeichen.Visible:=DBEditKopfIhrZeichen.Visible Else LIhrZeichen.Visible:=False;
  end;

    DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Text2').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LText2:= frCreateObject(gtMemo, '');  // create data field
    LText2.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    LText2.Memo.Add(FFormat.Name);
    (LText2 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LText2 as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LText2 as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LText2 as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LText2 as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LText2 as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LText2);//  if BandKopfV then LIhrZeichen.Visible:=DBEditKopfIhrZeichen.Visible Else LIhrZeichen.Visible:=False;
  end;

    DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Text3').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LText3:= frCreateObject(gtMemo, '');  // create data field
    LText3.SetBounds(SL+FFormat.x,So+FFormat.y,FFormat.l, 18);
    LText3.Memo.Add(FFormat.Name);
    (LText3 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LText3 as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LText3 as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LText3 as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LText3 as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LText3 as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LText3);//  if BandKopfV then LIhrZeichen.Visible:=DBEditKopfIhrZeichen.Visible Else LIhrZeichen.Visible:=False;
  end;





  //============================ Ende Variaber Kopf====================================
  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Notiz').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTNotiz:= frCreateObject(gtMemo, '');  // create data field
    DBTNotiz.SetBounds(SL+FFormat.x,So+HoeheBisNotizAnfang,FFormat.l,Notizhoehe);
    DBTNotiz.Memo.Add('[QueryModul."Notiz"]');
    (DBTNotiz as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTNotiz as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTNotiz as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTNotiz as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTNotiz as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTNotiz as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTNotiz); // if BandInternV then DBTNotiz.Visible:=DBMemoNotiz.Visible Else DBTNotiz.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Titel').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTModulartGross:= frCreateObject(gtMemo, '');  // create data field
    DBTModulartGross.SetBounds(SL+FFormat.x,So+HoeheBisTitelAnfang,FFormat.l,FFormat.Groesse*2);
    DBTModulartGross.Memo.Add(FModul_Name);
    (DBTModulartGross as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTModulartGross as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTModulartGross as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTModulartGross as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTModulartGross as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTModulartGross as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTModulartGross);//  if BandKopfV then DBTModulartGross.Visible:=DBTextModul.Visible Else DBTModulartGross.Visible:=False;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('MemoKopf').ASString);// if Fdruckart <> 2 then begin
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTMemoKopf:= frCreateObject(gtMemo, '');  // create data field
    DBTMemoKopf.SetBounds(SL+FFormat.x,So+HoeheBisMemoKopfAnfang,FFormat.l, KopftextHoehe);
    DBTMemoKopf.Memo.Add('[QueryModul."Kopftext"]');
    (DBTMemoKopf as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTMemoKopf as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTMemoKopf as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTMemoKopf as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTMemoKopf as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTMemoKopf as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTMemoKopf);//  if BandKopfV then DBTMemoKopf.Visible:=DBMemoKopf.Visible Else DBTMemoKopf.Visible:=False;
  end;
  //Showmessage('Kopfzeile ='+inttostr(So+HoeheBisSeitenkopfAnfang)+'  + 18 Bandseitenanfang ='+inttostr(So+HoeheBisSeitenkopfAnfang)+' + 20');
  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Kopfzeile').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LSeitenanfang:= frCreateObject(gtMemo, '');  // create data field
    LSeitenanfang.SetBounds(SL+FFormat.x,So+HoeheBisSeitenkopfAnfang,FFormat.l,18);
    LSeitenanfang.Memo.Add(FFormat.Name);
    (LSeitenanfang as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LSeitenanfang as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LSeitenanfang as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LSeitenanfang as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LSeitenanfang as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LSeitenanfang as TfrMemoView).Adjust:=FFormat.j;
    (LSeitenanfang as TfrMemoView).Name:='LSeitenanfang';
    Page.Objects.Add(LSeitenanfang);//  LSeitenanfang.Visible:=LabelKopftext.Visible;
    //UKopfzeileY1:=So+HoeheBisSeitenkopfAnfang;UKopfzeileY2:=FFormat.l;
    //UKopfzeileName:=FFormat.Name;
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('FussZeile').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    LSeitenEnde:= frCreateObject(gtMemo, '');  // create data field
    LSeitenEnde.SetBounds(SL+FFormat.x,So+PosAnfang+MasterHoehe+BandSummenhoehe{+FusstextHoehe}+11,FFormat.l,18);
    LSeitenEnde.Memo.Add(FFormat.Name);
    (LSeitenEnde as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (LSeitenEnde as TfrMemoView).Font.Size:=FFormat.Groesse;
    (LSeitenEnde as TfrMemoView).Font.Name:=FFormat.Schrift;
    (LSeitenEnde as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (LSeitenEnde as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (LSeitenEnde as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(LSeitenEnde);  //LSeitenanfang.Visible:=LabelKopftext.Visible;
  end;
  //Artikellisten Variablen--------------------------------------------------------
  //Showmessage('Pos ='+inttostr(So+PosAnfang+Fdd1.y)+'  + 18 Bandmaster ='+inttostr(So+PosAnfang-1)+' + '+inttostr(Masterhoehe));
  if DataModuleMyOffice.IntToBol(Fdd1.Sichtbar) then begin
    DBTA1:= frCreateObject(gtMemo, '');  // create data field
    DBTA1.SetBounds(SL+Fdd1.x,So+PosAnfang+Fdd1.y,Fdd1.l, 18);
    DBTA1.Memo.Add('[QueryArtikelListe."'+Fdd1.Name+'"]');
    (DBTA1 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd1.Style);
    (DBTA1 as TfrMemoView).Font.Size:=Fdd1.Groesse;
    (DBTA1 as TfrMemoView).Font.Name:=Fdd1.Schrift;
    (DBTA1 as TfrMemoView).Font.Color:=Stringtocolor(Fdd1.Farbe);
    (DBTA1 as TfrMemoView).FrameTyp:=Fdd1.Rahmen;
    (DBTA1 as TfrMemoView).Adjust:=Fdd1.j;
    Page.Objects.Add(DBTA1);
  End;

  if DataModuleMyOffice.IntToBol(Fdd2.Sichtbar) then begin
    DBTA2:= frCreateObject(gtMemo, '');  // create data field
    DBTA2.SetBounds(SL+Fdd2.x,So+PosAnfang+Fdd2.y,Fdd2.l, 18);
    DBTA2.Memo.Add('[QueryArtikelListe."'+Fdd2.Name+'"]');
    (DBTA2 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd2.Style);
    (DBTA2 as TfrMemoView).Font.Size:=Fdd2.Groesse;
    (DBTA2 as TfrMemoView).Font.Name:=Fdd2.Schrift;
    (DBTA2 as TfrMemoView).Font.Color:=Stringtocolor(Fdd2.Farbe);
    (DBTA2 as TfrMemoView).FrameTyp:=Fdd2.Rahmen;
    (DBTA2 as TfrMemoView).Adjust:=Fdd2.j;
    Page.Objects.Add(DBTA2);
  End;
  if DataModuleMyOffice.IntToBol(Fdd3.Sichtbar) then begin
    DBTA3:= frCreateObject(gtMemo, '');  // create data field
    DBTA3.SetBounds(SL+Fdd3.x,So+PosAnfang+Fdd3.y,Fdd3.l, 18);
    DBTA3.Memo.Add('[QueryArtikelListe."'+Fdd3.Name+'"]');
    (DBTA3 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd3.Style);
    (DBTA3 as TfrMemoView).Font.Size:=Fdd3.Groesse;
    (DBTA3 as TfrMemoView).Font.Name:=Fdd3.Schrift;
    (DBTA3 as TfrMemoView).Font.Color:=Stringtocolor(Fdd3.Farbe);
    (DBTA3 as TfrMemoView).FrameTyp:=Fdd3.Rahmen;
    (DBTA3 as TfrMemoView).Adjust:=Fdd3.j;
    Page.Objects.Add(DBTA3);
  End;
  if DataModuleMyOffice.IntToBol(Fdd4.Sichtbar) then begin
    DBTA4:= frCreateObject(gtMemo, '');  // create data field
    DBTA4.SetBounds(SL+Fdd4.x,So+PosAnfang+Fdd4.y,Fdd4.l, 18);
    DBTA4.Memo.Add('[QueryArtikelListe."'+Fdd4.Name+'"]');
    (DBTA4 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd4.Style);
    (DBTA4 as TfrMemoView).Font.Size:=Fdd4.Groesse;
    (DBTA4 as TfrMemoView).Font.Name:=Fdd4.Schrift;
    (DBTA4 as TfrMemoView).Font.Color:=Stringtocolor(Fdd4.Farbe);
    (DBTA4 as TfrMemoView).FrameTyp:=Fdd4.Rahmen;
    (DBTA4 as TfrMemoView).Adjust:=Fdd4.j;
    Page.Objects.Add(DBTA4);
  End;
  if DataModuleMyOffice.IntToBol(Fdd5.Sichtbar) then begin
    DBTA5:= frCreateObject(gtMemo, '');  // create data field
    DBTA5.SetBounds(SL+Fdd5.x,So+PosAnfang+Fdd5.y,Fdd5.l, 18);
    DBTA5.Memo.Add('[QueryArtikelListe."'+Fdd5.Name+'"]');
    (DBTA5 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd5.Style);
    (DBTA5 as TfrMemoView).Font.Size:=Fdd5.Groesse;
    (DBTA5 as TfrMemoView).Font.Name:=Fdd5.Schrift;
    (DBTA5 as TfrMemoView).Font.Color:=Stringtocolor(Fdd5.Farbe);
    (DBTA5 as TfrMemoView).FrameTyp:=Fdd5.Rahmen;
    (DBTA5 as TfrMemoView).Adjust:=Fdd5.j;
    Page.Objects.Add(DBTA5);
  End;
  if DataModuleMyOffice.IntToBol(Fdd6.Sichtbar) then begin
    DBTA6:= frCreateObject(gtMemo, '');  // create data field
    DBTA6.SetBounds(SL+Fdd6.x,So+PosAnfang+Fdd6.y,Fdd6.l, 18);
    DBTA6.Memo.Add('[QueryArtikelListe."'+Fdd6.Name+'"]');
    (DBTA6 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd6.Style);
    (DBTA6 as TfrMemoView).Font.Size:=Fdd6.Groesse;
    (DBTA6 as TfrMemoView).Font.Name:=Fdd6.Schrift;
    (DBTA6 as TfrMemoView).Font.Color:=Stringtocolor(Fdd6.Farbe);
    (DBTA6 as TfrMemoView).FrameTyp:=Fdd6.Rahmen;
    (DBTA6 as TfrMemoView).Adjust:=Fdd6.j;
    Page.Objects.Add(DBTA6);
  End;
  if DataModuleMyOffice.IntToBol(Fdd7.Sichtbar) then begin
    DBTA7:= frCreateObject(gtMemo, '');  // create data field
    DBTA7.SetBounds(SL+Fdd7.x,So+PosAnfang+Fdd7.y,Fdd7.l, 18);
    DBTA7.Memo.Add('[QueryArtikelListe."'+Fdd7.Name+'"]');
    (DBTA7 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd7.Style);
    (DBTA7 as TfrMemoView).Font.Size:=Fdd7.Groesse;
    (DBTA7 as TfrMemoView).Font.Name:=Fdd7.Schrift;
    (DBTA7 as TfrMemoView).Font.Color:=Stringtocolor(Fdd7.Farbe);
    (DBTA7 as TfrMemoView).FrameTyp:=Fdd7.Rahmen;
    (DBTA7 as TfrMemoView).Adjust:=Fdd7.j;
    Page.Objects.Add(DBTA7);
  End;
  if DataModuleMyOffice.IntToBol(Fdd8.Sichtbar) then begin
    DBTA8:= frCreateObject(gtMemo, '');  // create data field
    DBTA8.SetBounds(SL+Fdd8.x,So+PosAnfang+Fdd8.y,Fdd8.l, 18);
    DBTA8.Memo.Add('[QueryArtikelListe."'+Fdd8.Name+'"]');
    (DBTA8 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd8.Style);
    (DBTA8 as TfrMemoView).Font.Size:=Fdd8.Groesse;
    (DBTA8 as TfrMemoView).Font.Name:=Fdd8.Schrift;
    (DBTA8 as TfrMemoView).Font.Color:=Stringtocolor(Fdd8.Farbe);
    (DBTA8 as TfrMemoView).FrameTyp:=Fdd8.Rahmen;
    (DBTA8 as TfrMemoView).Adjust:=Fdd8.j;
    Page.Objects.Add(DBTA8);
  End;
  if DataModuleMyOffice.IntToBol(Fdd9.Sichtbar) then begin
    DBTA9:= frCreateObject(gtMemo, '');  // create data field
    DBTA9.SetBounds(SL+Fdd9.x,So+PosAnfang+Fdd9.y,Fdd9.l, 18);
    DBTA9.Memo.Add('[QueryArtikelListe."'+Fdd9.Name+'"]');
    (DBTA9 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd9.Style);
    (DBTA9 as TfrMemoView).Font.Size:=Fdd9.Groesse;
    (DBTA9 as TfrMemoView).Font.Name:=Fdd9.Schrift;
    (DBTA9 as TfrMemoView).Font.Color:=Stringtocolor(Fdd9.Farbe);
    (DBTA9 as TfrMemoView).FrameTyp:=Fdd9.Rahmen;
    (DBTA9 as TfrMemoView).Adjust:=Fdd9.j;
    Page.Objects.Add(DBTA9);
  End;

  if DataModuleMyOffice.IntToBol(Fdd10.Sichtbar) then begin
    DBTA10:= frCreateObject(gtMemo, '');  // create data field
    DBTA10.SetBounds(SL+Fdd10.x,So+PosAnfang+Fdd10.y,Fdd10.l, 18);
    DBTA10.Memo.Add('[QueryArtikelListe."'+Fdd10.Name+'"]');
    (DBTA10 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd10.Style);
    (DBTA10 as TfrMemoView).Font.Size:=Fdd10.Groesse;
    (DBTA10 as TfrMemoView).Font.Name:=Fdd10.Schrift;
    (DBTA10 as TfrMemoView).Font.Color:=Stringtocolor(Fdd10.Farbe);
    (DBTA10 as TfrMemoView).FrameTyp:=Fdd10.Rahmen;
    (DBTA10 as TfrMemoView).Adjust:=Fdd10.j;
    Page.Objects.Add(DBTA10);
  End;


  if DataModuleMyOffice.IntToBol(Fdd11.Sichtbar) then begin
    DBTA11:= frCreateObject(gtMemo, '');  // create data field
    DBTA11.SetBounds(SL+Fdd11.x,So+PosAnfang+Fdd11.y,Fdd11.l, 18);
    DBTA11.Memo.Add('[QueryArtikelListe."'+Fdd11.Name+'"]');
    (DBTA11 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd11.Style);
    (DBTA11 as TfrMemoView).Font.Size:=Fdd11.Groesse;
    (DBTA11 as TfrMemoView).Font.Name:=Fdd11.Schrift;
    (DBTA11 as TfrMemoView).Font.Color:=Stringtocolor(Fdd11.Farbe);
    (DBTA11 as TfrMemoView).FrameTyp:=Fdd11.Rahmen;
    (DBTA11 as TfrMemoView).Adjust:=Fdd11.j;
    Page.Objects.Add(DBTA11);
  End;

  if DataModuleMyOffice.IntToBol(Fdd12.Sichtbar) then begin
    DBTA12:= frCreateObject(gtMemo, '');  // create data field
    DBTA12.SetBounds(SL+Fdd12.x,So+PosAnfang+Fdd12.y,Fdd12.l, 18);
    DBTA12.Memo.Add('[QueryArtikelListe."'+Fdd12.Name+'"]');
    (DBTA12 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd12.Style);
    (DBTA12 as TfrMemoView).Font.Size:=Fdd12.Groesse;
    (DBTA12 as TfrMemoView).Font.Name:=Fdd12.Schrift;
    (DBTA12 as TfrMemoView).Font.Color:=Stringtocolor(Fdd12.Farbe);
    (DBTA12 as TfrMemoView).FrameTyp:=Fdd12.Rahmen;
    (DBTA12 as TfrMemoView).Adjust:=Fdd12.j;
    Page.Objects.Add(DBTA12);
  End;

  if DataModuleMyOffice.IntToBol(Fdd13.Sichtbar) then begin
    DBTA13:= frCreateObject(gtMemo, '');  // create data field
    DBTA13.SetBounds(SL+Fdd13.x,So+PosAnfang+Fdd13.y,Fdd13.l, 18);
    DBTA13.Memo.Add('[QueryArtikelListe."'+Fdd13.Name+'"]');
    (DBTA13 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd13.Style);
    (DBTA13 as TfrMemoView).Font.Size:=Fdd13.Groesse;
    (DBTA13 as TfrMemoView).Font.Name:=Fdd13.Schrift;
    (DBTA13 as TfrMemoView).Font.Color:=Stringtocolor(Fdd13.Farbe);
    (DBTA13 as TfrMemoView).FrameTyp:=Fdd13.Rahmen;
    (DBTA13 as TfrMemoView).Adjust:=Fdd13.j;
    Page.Objects.Add(DBTA13);
  End;

  if DataModuleMyOffice.IntToBol(Fdd14.Sichtbar) then begin
    DBTA14:= frCreateObject(gtMemo, '');  // create data field
    DBTA14.SetBounds(SL+Fdd14.x,So+PosAnfang+Fdd14.y,Fdd14.l, 18);
    DBTA14.Memo.Add('[QueryArtikelListe."'+Fdd14.Name+'"]');
    (DBTA14 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd14.Style);
    (DBTA14 as TfrMemoView).Font.Size:=Fdd14.Groesse;
    (DBTA14 as TfrMemoView).Font.Name:=Fdd14.Schrift;
    (DBTA14 as TfrMemoView).Font.Color:=Stringtocolor(Fdd14.Farbe);
    (DBTA14 as TfrMemoView).FrameTyp:=Fdd14.Rahmen;
    (DBTA14 as TfrMemoView).Adjust:=Fdd14.j;
    Page.Objects.Add(DBTA14);
  End;

  if DataModuleMyOffice.IntToBol(Fdd15.Sichtbar) then begin
    DBTA15:= frCreateObject(gtMemo, '');  // create data field
    DBTA15.SetBounds(SL+Fdd15.x,So+PosAnfang+Fdd15.y,Fdd15.l, 18);
    DBTA15.Memo.Add('[QueryArtikelListe."'+Fdd15.Name+'"]');
    (DBTA15 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd15.Style);
    (DBTA15 as TfrMemoView).Font.Size:=Fdd15.Groesse;
    (DBTA15 as TfrMemoView).Font.Name:=Fdd15.Schrift;
    (DBTA15 as TfrMemoView).Font.Color:=Stringtocolor(Fdd15.Farbe);
    (DBTA15 as TfrMemoView).FrameTyp:=Fdd15.Rahmen;
    (DBTA15 as TfrMemoView).Adjust:=Fdd15.j;
    Page.Objects.Add(DBTA15);
  End;

  if DataModuleMyOffice.IntToBol(Fdd16.Sichtbar) then begin
    DBTA16:= frCreateObject(gtMemo, '');  // create data field
    DBTA16.SetBounds(SL+Fdd16.x,So+PosAnfang+Fdd16.y,Fdd16.l, 18);
    DBTA16.Memo.Add('[QueryArtikelListe."'+Fdd16.Name+'"]');
    (DBTA16 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd16.Style);
    (DBTA16 as TfrMemoView).Font.Size:=Fdd16.Groesse;
    (DBTA16 as TfrMemoView).Font.Name:=Fdd16.Schrift;
    (DBTA16 as TfrMemoView).Font.Color:=Stringtocolor(Fdd16.Farbe);
    (DBTA16 as TfrMemoView).FrameTyp:=Fdd16.Rahmen;
    (DBTA16 as TfrMemoView).Adjust:=Fdd16.j;
    Page.Objects.Add(DBTA16);
  End;

  if DataModuleMyOffice.IntToBol(Fdd17.Sichtbar) then begin
    DBTA17:= frCreateObject(gtMemo, '');  // create data field
    DBTA17.SetBounds(SL+Fdd17.x,So+PosAnfang+Fdd17.y,Fdd17.l, 18);
    DBTA17.Memo.Add('[QueryArtikelListe."'+Fdd17.Name+'"]');
    (DBTA17 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd17.Style);
    (DBTA17 as TfrMemoView).Font.Size:=Fdd17.Groesse;
    (DBTA17 as TfrMemoView).Font.Name:=Fdd17.Schrift;
    (DBTA17 as TfrMemoView).Font.Color:=Stringtocolor(Fdd17.Farbe);
    (DBTA17 as TfrMemoView).FrameTyp:=Fdd17.Rahmen;
    (DBTA17 as TfrMemoView).Adjust:=Fdd17.j;
    Page.Objects.Add(DBTA17);
  End;

  if DataModuleMyOffice.IntToBol(Fdd18.Sichtbar) then begin
    DBTA18:= frCreateObject(gtMemo, '');  // create data field
    DBTA18.SetBounds(SL+Fdd18.x,So+PosAnfang+Fdd18.y,Fdd18.l, 18);
    DBTA18.Memo.Add('[QueryArtikelListe."'+Fdd18.Name+'"]');
    (DBTA18 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd18.Style);
    (DBTA18 as TfrMemoView).Font.Size:=Fdd18.Groesse;
    (DBTA18 as TfrMemoView).Font.Name:=Fdd18.Schrift;
    (DBTA18 as TfrMemoView).Font.Color:=Stringtocolor(Fdd18.Farbe);
    (DBTA18 as TfrMemoView).FrameTyp:=Fdd18.Rahmen;
    (DBTA18 as TfrMemoView).Adjust:=Fdd18.j;
    Page.Objects.Add(DBTA18);
  End;

  if UStuecklisteJa then begin
    if DataModuleMyOffice.IntToBol(Fdd19.Sichtbar) then begin
      {DBTA19:= frCreateObject(gtMemo, '');  // create data field
      DBTA19.SetBounds(SL+Fdd19.x,So+PosAnfang+Fdd19.y,Fdd19.l, 18);
      DBTA19.Memo.Add('[QueryArtikelListe."'+Fdd19.Name+'"]');
      (DBTA19 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd19.Style);
      (DBTA19 as TfrMemoView).Font.Size:=Fdd19.Groesse;
      (DBTA19 as TfrMemoView).Font.Name:=Fdd19.Schrift;
      (DBTA19 as TfrMemoView).Font.Color:=Stringtocolor(Fdd19.Farbe);
      (DBTA19 as TfrMemoView).FrameTyp:=Fdd19.Rahmen;
      (DBTA19 as TfrMemoView).Adjust:=Fdd19.j;
      Page.Objects.Add(DBTA19);}

      DBTB1:= frCreateObject(gtMemo, '');  // create data field
      DBTB1.SetBounds(SL+Fdd19.x,So+PosAnfang+Fdd19.y,30, 18);
      DBTB1.Memo.Add('[QueryArtikelListe."'+'Pos'+'"]');
      (DBTB1 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd19.Style);
      (DBTB1 as TfrMemoView).Font.Size:=Fdd19.Groesse;
      (DBTB1 as TfrMemoView).Font.Name:=Fdd19.Schrift;
      (DBTB1 as TfrMemoView).Font.Color:=Stringtocolor(Fdd19.Farbe);
      (DBTB1 as TfrMemoView).FrameTyp:=Fdd19.Rahmen;
      (DBTB1 as TfrMemoView).Adjust:=Fdd19.j;
      (DBTB1 as TfrMemoView).Name:='Stückliste';
      Page.Objects.Add(DBTB1);

      DBTB2:= frCreateObject(gtMemo, '');  // create data field
      DBTB2.SetBounds(SL+Fdd19.x+35,So+PosAnfang+Fdd19.y,50, 18);
      DBTB2.Memo.Add('[QueryArtikelListe."'+'ArtikelGruppe_1'+'"]');
      (DBTB2 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd19.Style);
      (DBTB2 as TfrMemoView).Font.Size:=Fdd19.Groesse;
      (DBTB2 as TfrMemoView).Font.Name:=Fdd19.Schrift;
      (DBTB2 as TfrMemoView).Font.Color:=Stringtocolor(Fdd19.Farbe);
      (DBTB2 as TfrMemoView).FrameTyp:=Fdd19.Rahmen;
      (DBTB2 as TfrMemoView).Adjust:=Fdd19.j;
      Page.Objects.Add(DBTB2);

      DBTB3:= frCreateObject(gtMemo, '');  // create data field
      DBTB3.SetBounds(SL+Fdd19.x+85,So+PosAnfang+Fdd19.y,50, 18);
      DBTB3.Memo.Add('[QueryArtikelListe."'+'Menge_1'+'"]');
      (DBTB3 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd19.Style);
      (DBTB3 as TfrMemoView).Font.Size:=Fdd19.Groesse;
      (DBTB3 as TfrMemoView).Font.Name:=Fdd19.Schrift;
      (DBTB3 as TfrMemoView).Font.Color:=Stringtocolor(Fdd19.Farbe);
      (DBTB3 as TfrMemoView).FrameTyp:=Fdd19.Rahmen;
      (DBTB3 as TfrMemoView).Adjust:=Fdd19.j;
      Page.Objects.Add(DBTB3);
    end;
  end
  Else begin
    if DataModuleMyOffice.IntToBol(Fdd20.Sichtbar) then begin
      UPos_TextJa:=True;
      DBTPos_Text:= frCreateObject(gtMemo, '');  // create data field
      DBTPos_Text.SetBounds(SL+Fdd20.x,So+PosAnfang+Fdd20.y, 479{wichtig zum erkennen vom PostText für die dynamische höhe},18);
      DBTPos_Text.Memo.Add('[QueryArtikelListe."Pos_Text"]');
      (DBTPos_Text as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(Fdd20.Style);
      (DBTPos_Text as TfrMemoView).Font.Size:=Fdd20.Groesse;
      (DBTPos_Text as TfrMemoView).Font.Name:=Fdd20.Schrift;
      (DBTPos_Text as TfrMemoView).Font.Color:=Stringtocolor(Fdd20.Farbe);
      (DBTPos_Text as TfrMemoView).FrameTyp:=Fdd20.Rahmen;
      (DBTPos_Text as TfrMemoView).Adjust:=Fdd20.j;
      (DBTPos_Text as TfrMemoView).Name:='Pos_Text';
      Page.Objects.Add(DBTPos_Text);
    end;
  end;

  {if Fdruckart = 2 then begin
    DBTB1:= frCreateObject(gtMemo, '');  // create data field
    DBTB1.SetBounds(SL+A1_x,AnfangPositionen+22,A1_laenge, 18);
    DBTB1.Memo.Add('[QueryArtikelListe_d."'+'Pos'+'"]');
    //(DBTB1 as TfrMemoView).Font.Style:=[fsBold];
    (DBTB1 as TfrMemoView).Font.Size:=SchriftgroesseA1_A10;
    (DBTB1 as TfrMemoView).Font.Name:=F3;
    (DBTB1 as TfrMemoView).Font.Color:=C2;
    (DBTB1 as TfrMemoView).FrameTyp:=RahmenA;
    (DBTB1 as TfrMemoView).Adjust:=A1_Justierung;
    Page.Objects.Add(DBTB1);

    DBTB2:= frCreateObject(gtMemo, '');  // create data field
    DBTB2.SetBounds(SL+A2_x,AnfangPositionen+22,A2_laenge, 18);
    DBTB2.Memo.Add('[QueryArtikelListe_d."'+'ArtikelGruppe'+'"]');
    //(DBTB2 as TfrMemoView).Font.Style:=[fsBold];
    (DBTB2 as TfrMemoView).Font.Size:=SchriftgroesseA1_A10;
    (DBTB2 as TfrMemoView).Font.Name:=F3;
    (DBTB2 as TfrMemoView).Font.Color:=C2;
    (DBTB2 as TfrMemoView).FrameTyp:=RahmenA;
    (DBTB2 as TfrMemoView).Adjust:=A2_Justierung;
    Page.Objects.Add(DBTB2);

    DBTB3:= frCreateObject(gtMemo, '');  // create data field
    DBTB3.SetBounds(SL+A3_x,AnfangPositionen+22,A3_laenge, 18);
    DBTB3.Memo.Add('[QueryArtikelListe_d."'+'Menge'+'"]');
    //(DBTB3 as TfrMemoView).Font.Style:=[fsBold];
    (DBTB3 as TfrMemoView).Font.Size:=SchriftgroesseA1_A10;
    (DBTB3 as TfrMemoView).Font.Name:=F3;
    (DBTB3 as TfrMemoView).Font.Color:=C2;
    (DBTB3 as TfrMemoView).FrameTyp:=RahmenA;
    (DBTB3 as TfrMemoView).Adjust:=A3_Justierung;
    Page.Objects.Add(DBTB3);
  end;}
  H1:=0;
  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Summenzeile1').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTSumme1:= frCreateObject(gtMemo, '');  // create data field
    DBTSumme1.SetBounds(SL+FFormat.x,So+PosAnfang+Masterhoehe+1+H1,FFormat.l,18);
    H1:=H1+20;
    DBTSumme1.Memo.Add(FFormat.Name);
    (DBTSumme1 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTSumme1 as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTSumme1 as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTSumme1 as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTSumme1 as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTSumme1 as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTSumme1);
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Summenzeile2').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTSumme2:= frCreateObject(gtMemo, '');  // create data field
    DBTSumme2.SetBounds(SL+FFormat.x,So+PosAnfang+Masterhoehe+1+H1,FFormat.l,18);
    H1:=H1+20;
    DBTSumme2.Memo.Add(FFormat.Name);
    (DBTSumme2 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTSumme2 as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTSumme2 as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTSumme2 as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTSumme2 as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTSumme2 as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTSumme2);
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Summenzeile3').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTSumme3:= frCreateObject(gtMemo, '');  // create data field
    DBTSumme3.SetBounds(SL+FFormat.x,So+PosAnfang+Masterhoehe+1+H1,FFormat.l,18);
    H1:=H1+20;
    DBTSumme3.Memo.Add(FFormat.Name);
    (DBTSumme3 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTSumme3 as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTSumme3 as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTSumme3 as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTSumme3 as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTSumme3 as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTSumme3);
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('Summenzeile4').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
    DBTSumme4:= frCreateObject(gtMemo, '');  // create data field
    DBTSumme4.SetBounds(SL+FFormat.x,So+PosAnfang+Masterhoehe+1+H1,FFormat.l,18);
    H1:=H1+20;
    DBTSumme4.Memo.Add(FFormat.Name);
    (DBTSumme4 as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTSumme4 as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTSumme4 as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTSumme4 as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTSumme4 as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTSumme4 as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTSumme4);
  end;

  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,QueryEinstellungModulart.FieldByName('MemoFuss').ASString);
  if DataModuleMyOffice.IntToBol(FFormat.Sichtbar) Then begin
  //if Fdruckart <> 2 then begin
    DBTMemoFuss:= frCreateObject(gtMemo, '');  // create data field
    DBTMemoFuss.SetBounds(SL+FFormat.x,So+PosAnfang+Masterhoehe+1+H1,FFormat.l,FusstextHoehe);
    DBTMemoFuss.Memo.Add('[QueryModul."Fusstext"]');
    (DBTMemoFuss as TfrMemoView).Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    (DBTMemoFuss as TfrMemoView).Font.Size:=FFormat.Groesse;
    (DBTMemoFuss as TfrMemoView).Font.Name:=FFormat.Schrift;
    (DBTMemoFuss as TfrMemoView).Font.Color:=StringToColor(FFormat.Farbe);
    (DBTMemoFuss as TfrMemoView).FrameTyp:=FFormat.Rahmen;
    (DBTMemoFuss as TfrMemoView).Adjust:=FFormat.j;
    Page.Objects.Add(DBTMemoFuss); //DBTMemoFuss.Visible:=DBMemoFuss.Visible Else DBTMemoFuss.Visible:=False;
  end;
  //end;
  QueryEinstellungModulart.close;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
  if (FDrucker = 'ExportTxt') or (FDrucker = 'ExportDoc') or (FDrucker = 'ExportWWW') or (FDrucker = 'ExportXls') then begin
    if (FDrucker = 'ExportTxt') Then SaveDialog1.DefaultExt:='txt';
    if (FDrucker = 'ExportDoc') Then SaveDialog1.DefaultExt:='doc';
    if (FDrucker = 'ExportXls') Then SaveDialog1.DefaultExt:='xls';
    if (FDrucker = 'ExportWWW') Then SaveDialog1.DefaultExt:='html';
    SaveDialog1.Execute;
    if (FDrucker = 'ExportTxt') Then frReport1.ExportTo(TfrTextExport,SaveDialog1.FileName);
    if (FDrucker = 'ExportDoc') Then frReport1.ExportTo(TfrRTFExport,SaveDialog1.FileName);
    if (FDrucker = 'ExportXls') Then frReport1.ExportTo(TfrCSVExport,SaveDialog1.FileName);
    if (FDrucker = 'ExportWWW') Then frReport1.ExportTo(TfrHTMExport,SaveDialog1.FileName);
  end;
  if (FDrucker = 'Designer') Then begin frReport1.ModalPreview:= True; frReport1.DesignReport; end;
  if (FDrucker = 'Preview') Then begin frReport1.ModalPreview:=True; frReport1.ShowReport; end;
  if (FDrucker = 'Druck') Then begin {frReport1.ModalPreview:=False;} frReport1.ShowReport; end;
  if (FDrucker = 'Laden') Then begin frReport1.ModalPreview:=True; frReport1.LoadFromFile(FDruckermaske); end;
  //frReport1.ModalPreview:= True;frReport1.ShowReport;
  //frReport1.Free;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
  QueryModul.Edit;
  QueryModul.FieldByName('BMPLogo').ASString:='';//QueryEinstellungModulart.FieldByName('BMPLogo').ASVariant;
  QueryModul.Post;
  QueryModul.Edit;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  //  OpenDialog1.Execute;
  //SaveDialog1.Execute;
  //frReport1.ExportTo(TfrRTFExport,'test3.doc'{SaveDialog1.FileName});

  //frReport1.ShowReport;
  //Done:=False;
  ////OpenPictureDialog1.DefaultExt := GraphicExtension(TBitmap);
  //OpenPictureDialog1.FileName := GraphicFileMask(TBitmap);
  //OpenPictureDialog1.Filter := GraphicFilter(TBitmap);
  //OpenPictureDialog1.Options := [ofFileMustExist{, ofHideReadOnly}, ofNoChangeDir ];
  //while not Done do  begin
    //if OpenDialog1.Execute then begin
      //if not (ofExtensionDifferent in OpenPictureDialog1.Options) then  begin
      //Application.Icon.LoadFromFile(OpenPictureDialog1.FileName);
      //Showmessage(OpenPictureDialog1.FileName);
      //frReport1.ExportTo(TfrRTFExport,OpenDialog1.FileName);

      //Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      //USchriftOderDateiname:=OpenPictureDialog1.FileName;
      //Showmessage(USchriftOderDateiname);
      //Done := True;
    //end
    //else
    //  OpenPictureDialog1.Options := [ofExtensionDifferent];
    //end
    //else { Abbruch durch Benutzer }
    //  Done := True;
  //end;



  //frReport1.ExportTo(frRTFExport1,
  //DesignReport;
  //QueryArtikelListe_d.close;
  //QueryArtikelListe.open;
  //--if UStuecklisteJa then begin
    {Showmessage('1');
    if QueryArtikelListe.Active then QueryArtikelListe.close;
    QueryArtikelListe.sql.Clear;
    Showmessage('2');
    QueryArtikelListe.sql.add('Select * From ArtikelListe Where Modul_Nr = '+ inttostr(Uzeiger)+' Order by Pos_Nr');
    try  QueryArtikelListe.open; finally end;
    QueryArtikelListe.edit;
    Showmessage('3');}
  //end;--}
end;

procedure TFormArtikelSammlung.PopupMenuAusgabeClick(Sender: TObject);
var i:integer;
    s:String;
begin
 with Sender as TMenuItem do s:=(Caption);
 with Sender as TMenuItem do i:=(MenuIndex);
 drucken(DataModuleMyOffice.XStrtoInt(UdruckerlisteNr[i]));
end;

procedure TFormArtikelSammlung.frReport1EnterRect(Memo: TStringList;
  View: TfrView);
begin
    if (View.Name = 'Pos_Text') then begin
      //Showmessage('Posttexthöhe pro Datensatz');
      View.dy :=(UFdd20y)+((DBMemoPosText.Lines.Count)*15);
    end;


    {if (View.Name = 'Stückliste') then begin
      if QueryArtikelListe_d.Active then QueryArtikelListe_d.close;
      QueryArtikelListe_d.sql.Clear;
      QueryArtikelListe_d.sql.add('Select * From ArtikelListeS Where Stuecklisten_Nr = '+QueryArtikelListe.FieldByName('Nr').ASString+' Order by Pos');
      try
        QueryArtikelListe_d.open;
      finally
      end;
      View.dy :=QueryArtikelListe_d.RecordCount*15;
      UStuecklistenHoehe:=QueryArtikelListe_d.RecordCount*15;
    end;}



    if (View.Name = 'LSeitenanfang') and (UDruckeSeite > 1) Then Begin
      View.y:=USo;
    end;
    if (View.Name = 'Logo2') and (UDruckeSeite > 1) and (ULogo2dy>0) Then Begin
      View.x:=ULogo2x; View.y:=ULogo2y+17; View.dx:=ULogo2dx;  View.dy:=ULogo2dy;
    end;
end;

procedure TFormArtikelSammlung.frReport1BeginBand(Band: TfrBand);
begin
  if Band.Typ = btMasterData then begin
    if UStuecklisteJa then  begin
      //Band.dy:=UFdd20y;
      //Showmessage('Masterband höhe='+inttostr(UFdd20y)+' y='+inttoStr(Band.y));

    end
    Else begin
      if UPos_TextJa Then begin
        Band.dy:=UFdd20y+((DBMemoPosText.Lines.Count)*15);

        //Showmessage('Posthöhe pro Bandbegin='+inttostr(UFdd20y));
      end;
    end;
  end;

  if Band.Typ = btPageHeader then   UDruckeSeite:=UDruckeSeite+1;

  {if Band.Typ = btDetailData then begin
    if UStuecklisteJa then  begin
      //Band.dy:=UStuecklistenHoehe;
      //Showmessage('Detail höhe='+inttostr(UStuecklistenHoehe)+'  y='+inttostr(Band.y));
    end
    Else begin
      ///Band.dy:=0;
    end;
  end;}

end;

procedure TFormArtikelSammlung.frReport1EndBand(Band: TfrBand);
begin
  if Band.Typ = btPageHeader then begin //BandSeitenanfang
    If UDruckeSeite = 1 Then  begin
      Band.y:=0;
      Band.dy:=USo;
    end;
  end;
end;

procedure TFormArtikelSammlung.DBCtrlGridArtikelDblClick(Sender: TObject);
begin
   if UEnaF6 and ButtonAendern.Enabled then ButtonAendernClick(Self);
end;

procedure TFormArtikelSammlung.DBEditProjektDblClick(Sender: TObject);
begin
   if UEnaF4 and ButtonSuchen.Enabled then ButtonSuchenClick(Self);
end;

procedure TFormArtikelSammlung.QueryArtikelListeBeforePost(
  DataSet: TDataSet);
Var FBerechneter_EK{,FMenge}:Real;

begin
  QueryArtikelListe.edit;
  //Showmessage('berechnung Berechnungsart='+QueryArtikelListe.FieldByName('Berechnungsart').AsString);
  QueryArtikelListe.FieldByName('VK_Preis').AsString:=Formatcurr('0.00',berechnung(QueryArtikelListe.FieldByName('Berechnungsart').AsString,0,0.0));
  //Showmessage('in befor Post am anfang 2');
  //FMenge:= QueryArtikelListe.FieldByName('Menge').AsFloat;
  if (QueryArtikelListe.FieldByName('Menge').AsFloat<>0.0) and (QueryArtikelListe.FieldByName('VK_Preis').AsFloat<>0.0) Then begin
    FBerechneter_EK:=berechnung(QueryArtikelListe.FieldByName('Berechnungsart').AsString,1,0.0)/QueryArtikelListe.FieldByName('Menge').AsFloat;
    //Showmessage('in befor Post wenn Fmenge<>0.0    UBerechnung1='+UBerechnung1);
    if (DBEditBerechnen1.Visible) and (UBerechnung1 <>'') then begin
      if UBerechnung1='Berechneter_EK' then QueryArtikelListe.FieldByName('Berechnen1').AsString:=Floattostr(FBerechneter_EK)
      Else QueryArtikelListe.FieldByName('Berechnen1').AsString:=Formatcurr('0.00',berechnung(UBerechnung1,3,FBerechneter_EK));
    end;
    if (DBEditBerechnen2.Visible) and (UBerechnung2 <>'') then begin
      if UBerechnung2='Berechneter_EK' then QueryArtikelListe.FieldByName('Berechnen2').AsString:=Floattostr(FBerechneter_EK)
      Else QueryArtikelListe.FieldByName('Berechnen2').AsString:=Formatcurr('0.00',berechnung(UBerechnung2,3,FBerechneter_EK));
    end;
    if (DBEditBerechnen3.Visible) and (UBerechnung3 <>'') then begin
      if UBerechnung3='Berechneter_EK' then QueryArtikelListe.FieldByName('Berechnen3').AsString:=Floattostr(FBerechneter_EK)
      Else QueryArtikelListe.FieldByName('Berechnen3').AsString:=Formatcurr('0.00',berechnung(UBerechnung3,3,FBerechneter_EK));
    end;
  end;
  //Showmessage('in befor Post am schluß');
end;

procedure TFormArtikelSammlung.QueryArtikelListeAfterPost(
  DataSet: TDataSet);
begin
  summierung(0);
end;

procedure TFormArtikelSammlung.ButtonSummierenClick(Sender: TObject);
begin
  USummenButtonAn:=True;
  summierung(0);
  ActiveControl:=DBCtrlGridArtikel;
  //DataModuleMyOffice.DSSet('Artikel1',QueryArtikelliste);
end;

procedure TFormArtikelSammlung.CheckBoxSummenSofortClick(Sender: TObject);
begin
  if CheckBoxSummenSofort.Checked then ButtonSummieren.Visible:=False else ButtonSummieren.Visible:=true;
  summierung(0);
  ActiveControl:=DBCtrlGridArtikel;
end;

procedure TFormArtikelSammlung.DBEditMengeExit(Sender: TObject);
var FLagerverwaltungMenge:Real;
    i:integer;
begin
  QueryArtikelListe.edit;QueryArtikelListe.post;
  FLagerverwaltungMenge:=QueryArtikelListe.FieldByName('Menge').AsFloat;
  if (QueryArtikelListe.FieldByName('Artikel_Nr').AsString <> '') and (ULagerverwaltung <> 0) and (FLagerverwaltungMenge <> ULagerverwaltungMenge) Then begin
    if QueryLagerverwaltung.Active Then QueryLagerverwaltung.Close;
    QueryLagerverwaltung.SQL.Clear;
    QueryLagerverwaltung.sql.add('Select * From Artikel Where Nr = '+ inttostr(QueryArtikelListe.FieldByName('Artikel_Nr').Asinteger));
    try
      QueryLagerverwaltung.open;//Self.Query1.Edit;
    finally
    end;
    if QueryLagerverwaltung.RecordCount = 1 then begin
      QueryLagerverwaltung.edit;
      if ULagerverwaltung  = 1 then QueryLagerverwaltung.FieldByName('Bestand').AsFloat:=QueryLagerverwaltung.FieldByName('Bestand').AsFloat - (FLagerverwaltungMenge-ULagerverwaltungMenge);
      if ULagerverwaltung  = 2 then QueryLagerverwaltung.FieldByName('Bestand').AsFloat:=QueryLagerverwaltung.FieldByName('Bestand').AsFloat + (FLagerverwaltungMenge-ULagerverwaltungMenge);
      QueryLagerverwaltung.post;
    end;
    //if QueryLagerverwaltung.RecordCount > 1 then  Showmessage('es sind mehrere Artikel mit dieser Artikel_Nr in den Stammdaten vorhanden, für die Lagerverwaltung');
    //if QueryLagerverwaltung.RecordCount = 0 then  Showmessage('es wurde kein Artikel in den Stammdaten gefunden, für die Lagerverwaltung');
    QueryLagerverwaltung.close;
  end;

  if(QueryArtikelListe.FieldByName('ArtikelArt').AsString = 'Stueckliste') and (ULagerverwaltung <> 0) and (FLagerverwaltungMenge <> ULagerverwaltungMenge) Then begin
    FLagerverwaltungMenge:=FLagerverwaltungMenge-ULagerverwaltungMenge;
    if QueryZListe.Active Then QueryZListe.Close;
    QueryZListe.SQL.Clear;
    QueryZListe.sql.add('Select * From Artikellistes Where Stuecklisten_Nr = '+ inttostr(QueryArtikelListe.FieldByName('Nr').Asinteger));
    try
      QueryZListe.open;//Self.Query1.Edit;
    finally
    end;
    for i := 0 to QueryZListe.RecordCount - 1 do begin
      if QueryLagerverwaltung.Active Then QueryLagerverwaltung.Close;
      QueryLagerverwaltung.SQL.Clear;
      QueryLagerverwaltung.sql.add('Select * From Artikel Where Nr = '+ inttostr(QueryZListe.FieldByName('Artikel_Nr').Asinteger));
      try
        QueryLagerverwaltung.open;//Self.Query1.Edit;
      finally
      end;
      if QueryLagerverwaltung.RecordCount = 1 then begin
         QueryLagerverwaltung.edit;
         if ULagerverwaltung  = 1 then QueryLagerverwaltung.FieldByName('Bestand').AsFloat:=QueryLagerverwaltung.FieldByName('Bestand').AsFloat - (FLagerverwaltungMenge*QueryZListe.FieldByName('Menge').AsFloat);
         if ULagerverwaltung  = 2 then QueryLagerverwaltung.FieldByName('Bestand').AsFloat:=QueryLagerverwaltung.FieldByName('Bestand').AsFloat + (FLagerverwaltungMenge*QueryZListe.FieldByName('Menge').AsFloat);
        QueryLagerverwaltung.post;
      end;
      //if QueryLagerverwaltung.RecordCount > 1 then  Showmessage('es sind mehrere Artikel mit dieser Artikel_Nr in den Stammdaten vorhanden');
      //if QueryLagerverwaltung.RecordCount = 0 then  Showmessage('es wurde kein Artikel mit der Nr '+QueryZListe.FieldByName('Artikel_Nr').AsString+' in den Stammdaten gefunden, für die Lagerverwaltung');
      QueryLagerverwaltung.close;
      QueryZListe.next;
    end;
    if QueryZListe.Active Then QueryZListe.Close;
  end;
  QueryArtikelListe.edit;
end;

procedure TFormArtikelSammlung.SpeedButtonBewegenNachObenClick(
  Sender: TObject);
var Pos:integer;
begin
  Pos:=strtoint(QueryArtikelListe.FieldByName('Pos_Nr').Asstring);
  if Pos > 1 then begin
    //ListeVerlassen(ActiveControl);
    //QueryArtikelListe.DisableControls;
    //QueryArtikelListe.EnableControls;
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Pos_Nr').Asstring:=inttostr(Pos-1);
    QueryArtikelListe.post;
    QueryArtikelListe.Prior;
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Pos_Nr').Asstring:=inttostr(Pos);
    QueryArtikelListe.post;
    //DBCtrlGridArtikel.
    ListeVerlassen(ActiveControl);
    QueryArtikelListe.close;
    QueryArtikelListe.open;
    //QueryArtikelListe.EnableControls;
    ListeZurueck();
    QueryArtikelListe.edit;
    geheZu(Pos);
    if UAltcurser = False then QueryArtikelListe.Prior ;
  end
  Else  begin
    DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
    Meldefenster.an(2,'Die Position '+inttostr(Pos)+' kann nicht weiter','nach oben verschoben werden!','');
    DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  end;
  UAltcurser:=False;
end;

procedure TFormArtikelSammlung.SpeedButtonBewegenNachUntenClick(
  Sender: TObject);
var Pos:integer;

begin
  Pos:=strtoint(QueryArtikelListe.FieldByName('Pos_Nr').Asstring);
  if (Pos < QueryArtikelListe.RecordCount) then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Pos_Nr').Asstring:=inttostr(Pos+1);
    QueryArtikelListe.post;
    QueryArtikelListe.next;
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Pos_Nr').Asstring:=inttostr(Pos);
    QueryArtikelListe.post;
    ListeVerlassen(ActiveControl);
    QueryArtikelListe.close;
    QueryArtikelListe.open;
    ListeZurueck();
    geheZu(Pos);
    if UAltcurser = False then QueryArtikelListe.next ;
  end
  Else  begin
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
   Meldefenster.an(2,'Die Position '+inttostr(Pos)+' kann nicht weiter','nach unten verschoben werden!','');
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,Labelpos_text,LabelF2,LabelF2,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,Labelpos_text_p,LabelF2_p,LabelF2_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  end;
  UAltcurser:=False;
end;


procedure TFormArtikelSammlung.DBEditEK_PreisExit(Sender: TObject);
begin
  FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
  {if UAGEK_Preis<>QueryArtikelListe.FieldByName('EK_Preis').Asstring then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Geaendert').AsInteger:=1;
    QueryArtikelListe.post;QueryArtikelListe.edit;
  end;}
end;

procedure TFormArtikelSammlung.DBEditAufschlagExit(Sender: TObject);
begin
  IF QueryArtikelListe.FieldByName('ArtikelArt').AsString='Stueckliste' Then Showmessage('Vorsicht, der Aufschlag, der von der Stückliste automatisch ermittel wird, dient zur genauen Ermittlung der Leistungen. der richtige  Aufschlag wird beim erneuten Aufruf der Stückliste wieder eingesetzt');
  FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
end;

procedure TFormArtikelSammlung.DBEditZahl1Exit(Sender: TObject);
begin
  FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
  if UAGZahl1<>QueryArtikelListe.FieldByName('Zahl1').AsFloat then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Geaendert').AsInteger:=1;
    QueryArtikelListe.FieldByName('Artikel_Nr').AsInteger:=0;
    QueryArtikelListe.post;QueryArtikelListe.edit;
  end;
end;

procedure TFormArtikelSammlung.DBEditGewichtExit(Sender: TObject);
begin
  FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
  if UAGgewicht<>QueryArtikelListe.FieldByName('Gewicht').AsFloat then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Geaendert').AsInteger:=1;
    QueryArtikelListe.FieldByName('Artikel_Nr').AsInteger:=0;
    QueryArtikelListe.post;QueryArtikelListe.edit;
  end;
end;

procedure TFormArtikelSammlung.DBEditRabattExit(Sender: TObject);
begin
  FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
end;

procedure TFormArtikelSammlung.DBEditZahl3Exit(Sender: TObject);
begin
  FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
  if UAGZahl3<>QueryArtikelListe.FieldByName('Zahl3').AsFloat then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Geaendert').AsInteger:=1;
    QueryArtikelListe.FieldByName('Artikel_Nr').AsInteger:=0;
    QueryArtikelListe.post;QueryArtikelListe.edit;
  end;
end;

procedure TFormArtikelSammlung.DBEditZahl2Exit(Sender: TObject);
begin
  FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
  if UAGZahl2<>QueryArtikelListe.FieldByName('Zahl2').AsFloat then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Geaendert').AsInteger:=1;
    QueryArtikelListe.FieldByName('Artikel_Nr').AsInteger:=0;
    QueryArtikelListe.post;QueryArtikelListe.edit;
  end;
end;

procedure TFormArtikelSammlung.DBEditBerechnen1Exit(Sender: TObject);
begin
  //FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
end;

procedure TFormArtikelSammlung.DBEditBerechnen2Exit(Sender: TObject);
begin
  //FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
end;

procedure TFormArtikelSammlung.DBEditBerechnen3Exit(Sender: TObject);
begin
  //FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
end;

procedure TFormArtikelSammlung.DBEditBerechnungsArtExit(Sender: TObject);
begin
  //FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
  if UAGBerechnungsArt<>QueryArtikelListe.FieldByName('ArtikelGruppe').Asstring then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Geaendert').AsInteger:=1;
    QueryArtikelListe.FieldByName('Artikel_Nr').AsInteger:=0;
    QueryArtikelListe.post;QueryArtikelListe.edit;
  end;
end;

procedure TFormArtikelSammlung.DBEditArtikelGruppeExit(Sender: TObject);
begin
  //FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
  if UAGArtikelGruppe<>QueryArtikelListe.FieldByName('ArtikelGruppe').Asstring then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Geaendert').AsInteger:=1;
    QueryArtikelListe.FieldByName('Artikel_Nr').AsInteger:=0;
    QueryArtikelListe.post;QueryArtikelListe.edit;
  end;
end;

procedure TFormArtikelSammlung.QueryArtikelListeAfterScroll(
  DataSet: TDataSet);
begin
  //Showmessage('AferScroll');
  UAGArtikel:=QueryArtikelListe.FieldByName('Artikel').Asstring;
  UAGArtikelgruppe:=QueryArtikelListe.FieldByName('ArtikelGruppe').Asstring;
  UAGName1:=QueryArtikelListe.FieldByName('Name1').Asstring;
  UAGName2:=QueryArtikelListe.FieldByName('Name2').Asstring;
  UAGName3:=QueryArtikelListe.FieldByName('Name3').Asstring;
  UAGEinheitMenge:=QueryArtikelListe.FieldByName('EinheitMenge').Asstring;
  //UAGEK_Preis:=QueryArtikelListe.FieldByName('EK_Preis').AsFloat;
  UAGEinheit_EK:=QueryArtikelListe.FieldByName('Einheit_EK').Asstring;
  //UAGAufschlag:=QueryArtikelListe.FieldByName('Aufschlag').AsFloat;
  UAGZahl1:=QueryArtikelListe.FieldByName('Zahl1').AsFloat;
  UAGZahl2:=QueryArtikelListe.FieldByName('Zahl1').AsFloat;
  UAGZahl3:=QueryArtikelListe.FieldByName('Zahl1').AsFloat;
  UAGgewicht:=QueryArtikelListe.FieldByName('Gewicht').AsFloat;
  UAGArtikelNr:=QueryArtikelListe.FieldByName('Artikel_Nr').Asstring;
  UAGBerechnungsArt:=QueryArtikelListe.FieldByName('Berechnungsart').Asstring;
  //UAGRabatt:=QueryArtikelListe.FieldByName('Rabatt').AsFloat;
end;

procedure TFormArtikelSammlung.DBEditArtikelExit(Sender: TObject);
begin
  //FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
  if UAGArtikel<>QueryArtikelListe.FieldByName('Artikel').Asstring then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Geaendert').AsInteger:=1;
    QueryArtikelListe.FieldByName('Artikel_Nr').AsInteger:=0;
    QueryArtikelListe.post;QueryArtikelListe.edit;
  end;
end;

procedure TFormArtikelSammlung.DBEditName1Exit(Sender: TObject);
begin
  //FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
  if UAGName1<>QueryArtikelListe.FieldByName('Name1').Asstring then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Geaendert').AsInteger:=1;
    QueryArtikelListe.FieldByName('Artikel_Nr').AsInteger:=0;
    QueryArtikelListe.post;QueryArtikelListe.edit;
  end;
end;

procedure TFormArtikelSammlung.DBEditName2Exit(Sender: TObject);
begin
  //FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
  if UAGName2<>QueryArtikelListe.FieldByName('Name2').Asstring then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Geaendert').AsInteger:=1;
    QueryArtikelListe.FieldByName('Artikel_Nr').AsInteger:=0;
    QueryArtikelListe.post;QueryArtikelListe.edit;
  end;
end;

procedure TFormArtikelSammlung.DBEditName3Exit(Sender: TObject);
begin
  //FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
  if UAGName3<>QueryArtikelListe.FieldByName('Name3').Asstring then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Geaendert').AsInteger:=1;
    QueryArtikelListe.FieldByName('Artikel_Nr').AsInteger:=0;
    QueryArtikelListe.post;QueryArtikelListe.edit;
  end;
end;

procedure TFormArtikelSammlung.DBEditEinheitMengeExit(Sender: TObject);
begin
  //FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
  if UAGEinheitMenge<>QueryArtikelListe.FieldByName('Artikel_Nr').Asstring then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Geaendert').AsInteger:=1;
    QueryArtikelListe.FieldByName('Artikel_Nr').AsInteger:=0;
    QueryArtikelListe.post;QueryArtikelListe.edit;
  end;
end;

procedure TFormArtikelSammlung.DBEditEinheit_EKExit(Sender: TObject);
begin
  //FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
  if UAGEinheit_EK<>QueryArtikelListe.FieldByName('Einheit_EK').Asstring then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Geaendert').AsInteger:=1;
    QueryArtikelListe.FieldByName('Artikel_Nr').AsInteger:=0;
    QueryArtikelListe.post;QueryArtikelListe.edit;
  end;
end;

procedure TFormArtikelSammlung.DBEditArtikelNrExit(Sender: TObject);
begin
  //FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
  if UAGArtikelNr<>QueryArtikelListe.FieldByName('Artikel_Nr').Asstring then begin
    QueryArtikelListe.edit;
    QueryArtikelListe.FieldByName('Geaendert').AsInteger:=1;
    //QueryArtikelListe.FieldByName('Artikel_Nr').AsInteger:=0;
    QueryArtikelListe.post;QueryArtikelListe.edit;
  end;
end;

procedure TFormArtikelSammlung.DBMemoPosTextExit(Sender: TObject);
begin
  //FelderExit;
  //QueryArtikelListe.post;QueryArtikelListe.edit;
end;

procedure TFormArtikelSammlung.FelderExit;
begin
  QueryArtikelListeBeforePost(QueryArtikelListe);
  QueryArtikelListe.post;QueryArtikelListe.edit;
end;

procedure TFormArtikelSammlung.DBCtrlGridArtikelKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  {if (Shift = [ssShift]) or (Shift = [ssAlt]) then
  Else
  if Key = VK_F2 then begin
    ButtonNeuClick(self);
    //MengeActiv(0);
  end;}
  //Showmessage('ButtonNeuClickDBCtrl');end;
end;

end.
