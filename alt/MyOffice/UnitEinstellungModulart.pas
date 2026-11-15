unit UnitEinstellungModulart;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, Mask, DBTables, ExtCtrls, ComCtrls, Dialogs,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGrids;

type
  TFormEinstellungModulart = class(TForm)
    PanelTastatur: TPanel;
    DataSource1: TDataSource;
    LabelEsc_p: TLabel;
    PageControl1: TPageControl;
    TabSheetFunktion: TTabSheet;
    TabSheetAussehen: TTabSheet;
    TabSheetDatenbank: TTabSheet;
    GroupBoxFelder: TGroupBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox12: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    DBCheckBox14: TDBCheckBox;
    DBCheckBox15: TDBCheckBox;
    DBCheckBox16: TDBCheckBox;
    DBCheckBox19: TDBCheckBox;
    DBEditKopfIhrZeichen: TDBEdit;
    DBCheckBox18: TDBCheckBox;
    Label6: TLabel;
    EditFensterTop: TDBEdit;
    Label10: TLabel;
    Label7: TLabel;
    EditFensterHoehe: TDBEdit;
    Label12: TLabel;
    Label8: TLabel;
    EditFensterLeft: TDBEdit;
    Label11: TLabel;
    Label9: TLabel;
    EditFensterwidth: TDBEdit;
    DBCheckBoxInternAn: TDBCheckBox;
    DBCheckBoxKopfAn: TDBCheckBox;
    DBCheckBoxSummeAn: TDBCheckBox;
    DBCheckBoxFussAn: TDBCheckBox;
    DBCheckBoxButtonAn: TDBCheckBox;
    Label25: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBComboBox1: TDBComboBox;
    Label33: TLabel;
    Label37: TLabel;
    DBCheckBoxFensterBewegenAn: TDBCheckBox;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    TabSheetArtikelAussuchen: TTabSheet;
    DBText1: TDBText;
    PageControl2: TPageControl;
    TabSheetAAAussehen: TTabSheet;
    TabSheetAADatenbank: TTabSheet;
    LabelAAWidth: TLabel;
    DBEditAAWidth: TDBEdit;
    LabelAAWidthVorgabe: TLabel;
    Label20: TLabel;
    DBEdit16: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label29: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    Label45: TLabel;
    DBEdit25: TDBEdit;
    Label46: TLabel;
    Label47: TLabel;
    DBEdit26: TDBEdit;
    Label48: TLabel;
    TabSheetAAFunktion: TTabSheet;
    DBCheckBox24: TDBCheckBox;
    DBCheckBox25: TDBCheckBox;
    DBCheckBox27: TDBCheckBox;
    DBCheckBox28: TDBCheckBox;
    DBCheckBox29: TDBCheckBox;
    DBCheckBox30: TDBCheckBox;
    DBCheckBox31: TDBCheckBox;
    DBCheckBox32: TDBCheckBox;
    DBCheckBox33: TDBCheckBox;
    DBCheckBox34: TDBCheckBox;
    DBCheckBox35: TDBCheckBox;
    DBCheckBox36: TDBCheckBox;
    DBCheckBox37: TDBCheckBox;
    DBCheckBox38: TDBCheckBox;
    DBCheckBox39: TDBCheckBox;
    Label49: TLabel;
    DBEdit27: TDBEdit;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    DBEdit28: TDBEdit;
    Label53: TLabel;
    DBCheckBox40: TDBCheckBox;
    DBCheckBox41: TDBCheckBox;
    Label54: TLabel;
    DBEdit29: TDBEdit;
    Label55: TLabel;
    Label56: TLabel;
    DBEdit30: TDBEdit;
    Label57: TLabel;
    Label58: TLabel;
    DBEdit31: TDBEdit;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    DBEdit33: TDBEdit;
    DBEdit34: TDBEdit;
    DBEdit35: TDBEdit;
    DBEdit36: TDBEdit;
    DBEdit37: TDBEdit;
    DBEdit38: TDBEdit;
    DBEdit39: TDBEdit;
    DBEdit40: TDBEdit;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    DBCheckBox23: TDBCheckBox;
    TabSheetdrucken: TTabSheet;
    DBCheckBoxFarbenwechsel: TDBCheckBox;
    ButtonFarbwechsel1: TButton;
    ColorDialog1: TColorDialog;
    PanelFarbenwechselFarbe1: TPanel;
    FontDialogSchriftart: TFontDialog;
    Label28: TLabel;
    Label98: TLabel;
    DBEdit133: TDBEdit;
    DBEdit134: TDBEdit;
    Label99: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label138: TLabel;
    ButtonStandardwertFunktion: TButton;
    ButtonStandardwertAussehen: TButton;
    ButtonStandardwert: TButton;
    DBCheckBox22: TDBCheckBox;
    DBCheckBox63: TDBCheckBox;
    DBCheckBox64: TDBCheckBox;
    DBCheckBox65: TDBCheckBox;
    DBCheckBox66: TDBCheckBox;
    DBCheckBox67: TDBCheckBox;
    Label27: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    Label139: TLabel;
    DBEdit135: TDBEdit;
    Label140: TLabel;
    DBEdit136: TDBEdit;
    ButtonStandardwertArtikelAussuchen: TButton;
    DataSource2: TDataSource;
    DBCheckBox20: TDBCheckBox;
    PanelFarbenwechselFarbe2: TPanel;
    ButtonFarbwechsel2: TButton;
    PanelFarbenwechselFarbeSelect: TPanel;
    ButtonFarbwechselSelect: TButton;
    DBEditFarbenwechsel1: TDBEdit;
    DBEditFarbenwechsel2: TDBEdit;
    DBEditFarbenwechselSelect: TDBEdit;
    Label13: TLabel;
    Buttondruckermaske1: TButton;
    Buttondruckermaske2: TButton;
    Buttondruckermaske4: TButton;
    Buttondruckermaske3: TButton;
    Buttondruckermaske6: TButton;
    Buttondruckermaske5: TButton;
    DBRadioGroupLaberverwaltung: TDBRadioGroup;
    DBCheckBoxneu: TDBCheckBox;
    DBCheckBoxaender: TDBCheckBox;
    DBCheckBoxloeschen: TDBCheckBox;
    DBCheckBoxkopieren: TDBCheckBox;
    LabelF10_p: TLabel;
    ButtonEsc: TButton;
    ButtonF10: TButton;
    LabelEsc: TLabel;
    LabelF10: TLabel;
    ImageTastatur: TImage;
    DBEditMwst: TDBEdit;
    Label1: TLabel;
    Label14: TLabel;
    TabSheetArtikelliste: TTabSheet;
    Label35: TLabel;
    ButtonStandardwertArtikelListe: TButton;
    QueryEinstellungModulart: TZQuery;
    QueryModulart: TZQuery;
    PanelBerechnenZu2: TPanel;
    Label36: TLabel;
    Label41: TLabel;
    DBRadioGroupErledigt: TDBRadioGroup;
    Label65: TLabel;
    DBLookupComboBox2: TDBLookupComboBox;
    Label26: TLabel;
    DBEdit1: TDBEdit;
    DBCheckBox17: TDBCheckBox;
    Label66: TLabel;
    PanelAL: TPanel;
    PanelAL1: TPanel;
    PanelAL2: TPanel;
    PanelAL3: TPanel;
    PanelAL4: TPanel;
    PanelAL5: TPanel;
    PanelAL6: TPanel;
    PanelAL7: TPanel;
    PanelAL8: TPanel;
    PanelAL9: TPanel;
    PanelAL10: TPanel;
    PanelAL11: TPanel;
    PanelAL12: TPanel;
    PanelAL13: TPanel;
    PanelAL14: TPanel;
    PanelAL15: TPanel;
    PanelAL16: TPanel;
    PanelAL17: TPanel;
    PanelAL18: TPanel;
    PanelAL19: TPanel;
    PanelAL20: TPanel;
    Panel1: TPanel;
    TabSheetAussuchlisten: TTabSheet;
    Label15: TLabel;
    Label34: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Button1zurueck: TButton;
    Label75: TLabel;
    Buttonoben: TButton;
    Buttonunten: TButton;
    ButtonListeBearbeiten: TButton;
    Label76: TLabel;
    QueryEinstellungArtikelaussuchen: TZQuery;
    DataSource3: TDataSource;
    DBGridArtikelAussuchen: TDBGrid;
    DBEditArtikelAussuchen1: TDBEdit;
    DBEditArtikelAussuchen2: TDBEdit;
    DBEditArtikelAussuchen3: TDBEdit;
    DBEditArtikelAussuchen4: TDBEdit;
    DBEditArtikelAussuchen5: TDBEdit;
    DBEditArtikelAussuchen6: TDBEdit;
    DBEditArtikelAussuchen7: TDBEdit;
    DBEditArtikelAussuchen8: TDBEdit;
    ButtonArtikelaussuchenloeschen: TButton;
    procedure ButtonF10Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonEscClick(Sender: TObject);
    procedure DBLookupComboBoxBezieungs_NrExit(Sender: TObject);
    procedure ButtonFarbwechsel1Click(Sender: TObject);
    procedure ButtonStandardwertFunktionClick(Sender: TObject);
    procedure ButtonStandardwertAussehenClick(Sender: TObject);
    procedure ButtonStandardwertClick(Sender: TObject);
    procedure ButtonStandardwertArtikelAussuchenClick(Sender: TObject);
    procedure ButtonFarbwechsel2Click(Sender: TObject);
    procedure ButtonFarbwechselSelectClick(Sender: TObject);
    procedure Buttondruckermaske1Click(Sender: TObject);
    procedure Buttondruckermaske2Click(Sender: TObject);
    procedure Buttondruckermaske3Click(Sender: TObject);
    procedure Buttondruckermaske4Click(Sender: TObject);
    procedure Buttondruckermaske5Click(Sender: TObject);
    procedure Buttondruckermaske6Click(Sender: TObject);
    procedure ButtonStandardwertArtikelListeClick(Sender: TObject);
    Function PanelToString(P:TPanel):String;
    procedure StringToPanel(P:TPanel;s,Feld,FText:String);
    procedure PanelAL1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL11MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL12MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL13MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL14MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL15MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL16MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL17MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL18MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL19MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAL20MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelALDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ButtonListeBearbeitenClick(Sender: TObject);
    procedure Button1zurueckClick(Sender: TObject);
    procedure ButtonArtikelaussuchenloeschenClick(Sender: TObject);
    procedure DBEditArtikelAussuchen1Enter(Sender: TObject);
    procedure DBEditArtikelAussuchen2Enter(Sender: TObject);
    procedure DBEditArtikelAussuchen3Enter(Sender: TObject);
    procedure DBEditArtikelAussuchen4Enter(Sender: TObject);
    procedure DBEditArtikelAussuchen5Enter(Sender: TObject);
    procedure DBEditArtikelAussuchen6Enter(Sender: TObject);
    procedure DBEditArtikelAussuchen7Enter(Sender: TObject);
    procedure DBEditArtikelAussuchen8Enter(Sender: TObject);
    procedure ButtonobenClick(Sender: TObject);
    procedure ButtonuntenClick(Sender: TObject);


  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormEinstellungModulart: TFormEinstellungModulart;
  UZeiger:longint;UZeigerNeu:Boolean;
  UFocus:String;

implementation

uses  TempForm,UnitModule, UnitMeldefenster, UnitDB,UnitDataModul,
  UnitEinstellungenDrucken, UnitBerechnungsart, UnitFormatierung,
  UnitDammiForm, UnitEinstellungenArtikelAussuchen;

{$R *.DFM}


procedure TFormEinstellungModulart.ButtonF10Click(Sender: TObject);
begin
  //QueryEinstellungModulart.FieldByName('Beziehungs_Nr').AsInteger:=QueryModulart.FieldByName('Nr').AsInteger;
  if DBLookupComboBox1.Text<>'' THEN  QueryEinstellungModulart.FieldByName('Beziehungs_Nr').AsInteger:=QueryModulart.FieldByName('Nr').AsInteger;
  //ELSE QueryEinstellungModulart.FieldByName('Beziehungs_Nr').AsInteger:=0;
  QueryEinstellungModulart.Post;
  FormPlanlos.Gzeiger:=QueryEinstellungModulart.Fields[0].Value;
  QueryEinstellungModulart.close;
  if UZeigerNeu Then Showmessage('um das neue Modul sichbar zu machen, muß das Programm neu gestartet werden!');
  close;
end;


procedure TFormEinstellungModulart.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then  ButtonEscClick(Self);
  if Key = VK_F10 then ButtonF10Click(Self);
end;

procedure TFormEinstellungModulart.FormActivate(Sender: TObject);
begin
  //QueryModulart.Active:=True;
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  if QueryEinstellungModulart.Active then QueryEinstellungModulart.close;
  QueryEinstellungModulart.sql.Clear;
  QueryEinstellungModulart.sql.add('Select * From EinstellungModulart Where nr = '+ inttostr(Uzeiger));
  try
    QueryEinstellungModulart.open;//Self.Query1.Edit;
  finally
  end;
  QueryEinstellungModulart.edit;
  if QueryModulart.Active then QueryModulart.close;
  QueryModulart.sql.Clear;
  QueryModulart.sql.add('Select * From EinstellungModulart');
  try
    QueryModulart.open;//Self.Query1.Edit;
  finally
  end;

  if QueryEinstellungArtikelaussuchen.Active then QueryEinstellungArtikelaussuchen.close;
  QueryEinstellungArtikelaussuchen.sql.Clear;
  QueryEinstellungArtikelaussuchen.sql.add('Select * From artikelaussuchen');
  try
    QueryEinstellungArtikelaussuchen.open;//Self.Query1.Edit;
  finally
  end;

  if QueryEinstellungModulart.FieldByName('FarbenwechselFarbe1').AsString = ''then
    PanelFarbenwechselFarbe1.color:=stringtocolor('$00DEDFDE')
  else
    PanelFarbenwechselFarbe1.color:=stringtocolor(QueryEinstellungModulart.FieldByName('FarbenwechselFarbe1').AsString);

  if QueryEinstellungModulart.FieldByName('FarbenwechselFarbe2').AsString = ''then
    PanelFarbenwechselFarbe2.color:=stringtocolor('$00EFEFEF')
  else
    PanelFarbenwechselFarbe2.color:=stringtocolor(QueryEinstellungModulart.FieldByName('FarbenwechselFarbe2').AsString);

  if QueryEinstellungModulart.FieldByName('FarbenwechselFarbeSelect').AsString = ''then
    PanelFarbenwechselFarbeSelect.color:=stringtocolor('$0084F5FF')
  else
    PanelFarbenwechselFarbeSelect.color:=stringtocolor(QueryEinstellungModulart.FieldByName('FarbenwechselFarbeSelect').AsString);
  if UZeigerNeu and (QueryEinstellungModulart.FieldByName('Modulart').AsString='')Then begin
    ButtonStandardwertFunktionClick(Self);
    ButtonStandardwertAussehenClick(Self);
    ButtonStandardwertClick(Self);
    ButtonStandardwertArtikelAussuchenClick(Self);
    ButtonStandardwertArtikelListeClick(Self);
  end
  Else begin
    if QueryEinstellungModulart.FieldByName('druckermaske1').AsString <> '' then
      if QueryEinstellungModulart.FieldByName('druckermaske1').AsString <> 'leer' then
        Buttondruckermaske1.caption:=QueryEinstellungModulart.FieldByName('druckermaske1').AsString;
    if QueryEinstellungModulart.FieldByName('druckermaske2').AsString <> '' then
      if QueryEinstellungModulart.FieldByName('druckermaske2').AsString <> 'leer' then
        Buttondruckermaske2.caption:=QueryEinstellungModulart.FieldByName('druckermaske2').AsString;
    if QueryEinstellungModulart.FieldByName('druckermaske3').AsString <> '' then
      if QueryEinstellungModulart.FieldByName('druckermaske3').AsString <> 'leer' then
        Buttondruckermaske3.caption:=QueryEinstellungModulart.FieldByName('druckermaske3').AsString;
    if QueryEinstellungModulart.FieldByName('druckermaske4').AsString <> '' then
      if QueryEinstellungModulart.FieldByName('druckermaske4').AsString <> 'leer' then
        Buttondruckermaske4.caption:=QueryEinstellungModulart.FieldByName('druckermaske4').AsString;
    if QueryEinstellungModulart.FieldByName('druckermaske5').AsString <> '' then
      if QueryEinstellungModulart.FieldByName('druckermaske5').AsString <> 'leer' then
        Buttondruckermaske5.caption:=QueryEinstellungModulart.FieldByName('druckermaske5').AsString;
    if QueryEinstellungModulart.FieldByName('druckermaske6').AsString <> '' then
      if QueryEinstellungModulart.FieldByName('druckermaske6').AsString <> 'leer' then
        Buttondruckermaske6.caption:=QueryEinstellungModulart.FieldByName('druckermaske6').AsString;
    StringToPanel(PanelAL1,QueryEinstellungModulart.FieldByName('monitormaske1').AsString,'','');
    StringToPanel(PanelAL2,QueryEinstellungModulart.FieldByName('monitormaske2').AsString,'','');
    StringToPanel(PanelAL3,QueryEinstellungModulart.FieldByName('monitormaske3').AsString,'','');
    StringToPanel(PanelAL4,QueryEinstellungModulart.FieldByName('monitormaske4').AsString,'','');
    StringToPanel(PanelAL5,QueryEinstellungModulart.FieldByName('monitormaske5').AsString,'','');
    StringToPanel(PanelAL6,QueryEinstellungModulart.FieldByName('monitormaske6').AsString,'','');
    StringToPanel(PanelAL7,QueryEinstellungModulart.FieldByName('monitormaske7').AsString,'','');
    StringToPanel(PanelAL8,QueryEinstellungModulart.FieldByName('monitormaske8').AsString,'','');
    StringToPanel(PanelAL9,QueryEinstellungModulart.FieldByName('monitormaske9').AsString,'','');
    StringToPanel(PanelAL10,QueryEinstellungModulart.FieldByName('monitormaske10').AsString,'','');
    StringToPanel(PanelAL11,QueryEinstellungModulart.FieldByName('monitormaske11').AsString,'','');
    StringToPanel(PanelAL12,QueryEinstellungModulart.FieldByName('monitormaske12').AsString,'','');
    StringToPanel(PanelAL13,QueryEinstellungModulart.FieldByName('monitormaske13').AsString,'','');
    StringToPanel(PanelAL14,QueryEinstellungModulart.FieldByName('monitormaske14').AsString,'','');
    StringToPanel(PanelAL15,QueryEinstellungModulart.FieldByName('monitormaske15').AsString,'','');
    StringToPanel(PanelAL16,QueryEinstellungModulart.FieldByName('monitormaske16').AsString,'','');
    StringToPanel(PanelAL17,QueryEinstellungModulart.FieldByName('monitormaske17').AsString,'','');
    StringToPanel(PanelAL18,QueryEinstellungModulart.FieldByName('monitormaske18').AsString,'','');
    StringToPanel(PanelAL19,QueryEinstellungModulart.FieldByName('monitormaske19').AsString,'','');
    StringToPanel(PanelAL20,QueryEinstellungModulart.FieldByName('monitormaske20').AsString,'','');
  end;
end;

procedure TFormEinstellungModulart.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QueryEinstellungArtikelaussuchen.Active:=False;
  QueryModulart.Active:=False;
  GOffeneFenster:=GOffeneFenster-1;
end;

procedure TFormEinstellungModulart.ButtonEscClick(Sender: TObject);
var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then
    ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  PanelTastatur.Color:=clGray;
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  PanelTastatur.Color:=clYellow;
  if FAbbrechen then
  begin
    if UZeigerNeu then
      begin
        QueryEinstellungModulart.close;
        if (DataModuleDB.DatensatzLoeschen('Module',Uzeiger) = False) Then
        begin
          PanelTastatur.Color:=clGray;
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
          PanelTastatur.Color:=clYellow;
        end;
      end
    else // änderung
    begin
      QueryEinstellungModulart.Cancel;QueryEinstellungModulart.close;
    end;
    Close;
  end;
end;

procedure TFormEinstellungModulart.DBLookupComboBoxBezieungs_NrExit(
  Sender: TObject);
begin
   if DBLookupComboBox1.Text<>'' THEN  QueryEinstellungModulart.FieldByName('Beziehungs_Nr').AsInteger:=QueryModulart.FieldByName('Nr').AsInteger
   ELSE QueryEinstellungModulart.FieldByName('Beziehungs_Nr').AsInteger:=0;
end;

procedure TFormEinstellungModulart.ButtonFarbwechsel1Click(Sender: TObject);
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  if ColorDialog1.Execute then DBEditFarbenwechsel1.Text := ColorToString(ColorDialog1.Color);
  PanelFarbenwechselFarbe1.color:=ColorDialog1.Color;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormEinstellungModulart.ButtonStandardwertFunktionClick(
  Sender: TObject);
begin
  DBEdit6.text:='Standard';
  DBRadioGroupLaberverwaltung.ItemIndex:=0;
  QueryEinstellungModulart.FieldByName('DatensatzNeu').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('DatensatzAusgabe').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('Datensatzsuchen').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('DatensatzKopieren').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('Datensatzaendern').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('Datensatzloeschen').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('Datensatzspeichern').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('Beziehungs_Name').AsString:='';
  QueryEinstellungModulart.FieldByName('Beziehungs_Nr').AsInteger:=0;
  QueryEinstellungModulart.FieldByName('Modulneu').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('Modulaendern').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('Modulloeschen').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('Modulkopieren').AsInteger:=1;
  DBEdit135.text:='';
  DBEdit136.text:='';
  QueryEinstellungModulart.FieldByName('MwSt').asFloat:=FormPlanlos.GVoreinstellungMwst;
end;

procedure TFormEinstellungModulart.ButtonStandardwertAussehenClick(
  Sender: TObject);
begin
  QueryEinstellungModulart.FieldByName('FensterTop').asInteger:=0;
  //EditFensterTop.text:='0';
  EditFensterHoehe.text:='660';
  EditFensterLeft.Text:='0';
  EditFensterwidth.Text:='793';
  QueryEinstellungModulart.FieldByName('PosTextZeilen').asInteger:=3;
  QueryEinstellungModulart.FieldByName('FensterInternAn').AsInteger:=0;
  QueryEinstellungModulart.FieldByName('FensterKopfAn').AsInteger:=0;
  QueryEinstellungModulart.FieldByName('FensterSummeAn').AsInteger:=0;
  QueryEinstellungModulart.FieldByName('FensterFussAn').AsInteger:=0;
  QueryEinstellungModulart.FieldByName('FensterButtonAn').AsInteger:=1;
  DBEdit2.text:='360';
  DBEdit3.text:='515';
  DBEdit4.text:='793';
  QueryEinstellungModulart.FieldByName('FensterBreiteBewegenAn').AsInteger:=1;

  QueryEinstellungModulart.FieldByName('Farbenwechsel').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('FarbenwechselFarbe1').AsString:='$00DEDFDE';
  PanelFarbenwechselFarbe1.color:=stringtocolor('$00DEDFDE');

  QueryEinstellungModulart.FieldByName('FarbenwechselFarbe2').AsString:='$00EFEFEF';
  PanelFarbenwechselFarbe2.color:=stringtocolor('$00EFEFEF');

  QueryEinstellungModulart.FieldByName('FarbenwechselFarbeSelect').AsString:='$0084F5FF';
  PanelFarbenwechselFarbeSelect.color:=stringtocolor('$0084F5FF')

end;

procedure TFormEinstellungModulart.ButtonStandardwertClick(
  Sender: TObject);
begin
  QueryEinstellungModulart.FieldByName('InternEn').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('InternProjekt').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('InternAdresse').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('InternBezeichnung').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('InternGruppierung').AsInteger:=0;
  QueryEinstellungModulart.FieldByName('InternNotiz').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('KopfEn').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('KopfAdressfeld').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('KopfModulNr').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('Kopfbearbeiter').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('KopfDatum').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('KopfTranzaktionsNr').AsInteger:=0;
  QueryEinstellungModulart.FieldByName('Kopftext').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('KopfModultext').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('KopfIhrZeichen').AsInteger:=1;
  DBEditKopfIhrZeichen.Text:='Ihr Zeichen:';
  QueryEinstellungModulart.FieldByName('ArtikelueberschriftEn').AsInteger:=1;
  DBEdit1.text:='Pos Artikelgruppe                   Artikel                              Menge Einheit            EK_Preis/Pro             Aufs.% Rabatt%     VK_Preis';
  QueryEinstellungModulart.FieldByName('FussEn').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('Fusstext').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('SummeEn').AsInteger:=1;
end;

procedure TFormEinstellungModulart.ButtonStandardwertArtikelAussuchenClick(
  Sender: TObject);
begin
  DBEdit133.text:='0';
  DBEdit134.text:='0';
  DBEditAAWidth.text:='540';
  DBEdit25.text:='2';
  DBEdit16.text:='2';
  DBEdit26.text:='0';
  DBEdit27.text:='130';
  DBEdit28.text:='187';
  DBEdit29.text:='2';
  DBEdit30.text:='2';
  DBEdit8.text:='';
  DBEdit9.text:='';
  DBEdit10.text:='';
  DBEdit11.text:='';
  DBEdit12.text:='';
  DBEdit13.text:='';
  DBEdit14.text:='';
  DBEdit15.text:='';
  DBEdit17.text:='';
  DBEdit18.text:='';
  DBEdit19.text:='';
  DBEdit20.text:='';
  DBEdit21.text:='';
  DBEdit22.text:='';
  DBEdit23.text:='';
  DBEdit24.text:='';
  QueryEinstellungModulart.FieldByName('AAEnaF2').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('AAEnaF4').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('AAEnaF5').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('AAEnaF6').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('AAEnaF7').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('AAEnaF8').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('AAEnaF9').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('AAErledigtArtikelAusSchal').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('AAMarkiernZeigenAn').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('AAErledigtArtikelAn').AsInteger:=1;
  //Welche Button in Artikel aussuchen angezeigt werden
  QueryEinstellungModulart.FieldByName('AAEnaButton1').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('AAEnaButton2').AsInteger:=0;
  QueryEinstellungModulart.FieldByName('AAEnaButton3').AsInteger:=1;
  QueryEinstellungModulart.FieldByName('AAEnaButton4').AsInteger:=0;
  QueryEinstellungModulart.FieldByName('AAEnaButton5').AsInteger:=0;
  QueryEinstellungModulart.FieldByName('AAEnaButton6').AsInteger:=0;
  QueryEinstellungModulart.FieldByName('AAEnaButton7').AsInteger:=0;
  QueryEinstellungModulart.FieldByName('AAEnaButton8').AsInteger:=0;
  DBEdit33.Text:='';
  DBEdit34.Text:='';
  DBEdit35.Text:='';
  DBEdit36.Text:='';
  DBEdit37.Text:='';
  DBEdit38.Text:='';
  DBEdit39.Text:='';
  DBEdit40.Text:='';
  DBEdit31.text:='1';
end;

procedure TFormEinstellungModulart.ButtonFarbwechsel2Click(
  Sender: TObject);
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  if ColorDialog1.Execute then DBEditFarbenwechsel2.Text := ColorToString(ColorDialog1.Color);
  PanelFarbenwechselFarbe2.color:=ColorDialog1.Color;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormEinstellungModulart.ButtonFarbwechselSelectClick(
  Sender: TObject);
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  if ColorDialog1.Execute then DBEditFarbenwechselSelect.Text := ColorToString(ColorDialog1.Color);
  PanelFarbenwechselFarbeSelect.color:=ColorDialog1.Color;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormEinstellungModulart.Buttondruckermaske1Click(
  Sender: TObject);
 var Fnr:integer;Par:TStringList;
     Fname:String;
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  Par:=TStringList.Create;
  Par:=TForm1.an(FormEinstellungenDrucken,Buttondruckermaske1.Caption,GModulart,GBenutzer,181);
  Fnr:=strtoint(Par[0]);Fname:=Par[1];
  If Fname<>'' Then begin
    Buttondruckermaske1.Caption:=Fname;
  end
  Else begin
    Buttondruckermaske1.Caption:='leer';
  end;
  QueryEinstellungModulart.FieldByName('druckermaske1').AsString:=Fname;
  QueryEinstellungModulart.FieldByName('druckermaskeNr1').AsString:=inttostr(Fnr);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormEinstellungModulart.Buttondruckermaske2Click(
  Sender: TObject);
var Fnr:integer;Par:TStringList;
   Fname:String;
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  Par:=TStringList.Create;
  Par:=TForm1.an(FormEinstellungenDrucken,Buttondruckermaske2.Caption,GModulart,GBenutzer,181);
  Fnr:=strtoint(Par[0]);Fname:=Par[1];
  If Fname<>'' Then begin
    Buttondruckermaske2.Caption:=Fname;
  end
  Else begin
    Buttondruckermaske2.Caption:='leer';
  end;
  QueryEinstellungModulart.FieldByName('druckermaske2').AsString:=Fname;
  QueryEinstellungModulart.FieldByName('druckermaskeNr2').AsString:=inttostr(Fnr);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormEinstellungModulart.Buttondruckermaske3Click(
  Sender: TObject);
var Fnr:integer;Par:TStringList;
     Fname:String;
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  Par:=TStringList.Create;
  Par:=TForm1.an(FormEinstellungenDrucken,Buttondruckermaske3.Caption,GModulart,GBenutzer,181);
  Fnr:=strtoint(Par[0]);Fname:=Par[1];
  If Fname<>'' Then begin
    Buttondruckermaske3.Caption:=Fname;
  end
  Else begin
    Buttondruckermaske3.Caption:='leer';
  end;
  QueryEinstellungModulart.FieldByName('druckermaske3').AsString:=Fname;
  QueryEinstellungModulart.FieldByName('druckermaskeNr3').AsString:=inttostr(Fnr);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormEinstellungModulart.Buttondruckermaske4Click(
  Sender: TObject);
var Fnr:integer;Par:TStringList;
    Fname:String;
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  Par:=TStringList.Create;
  Par:=TForm1.an(FormEinstellungenDrucken,Buttondruckermaske4.Caption,GModulart,GBenutzer,181);
  Fnr:=strtoint(Par[0]);Fname:=Par[1];
  If Fname<>'' Then begin
    Buttondruckermaske4.Caption:=Fname;
  end
  Else begin
    Buttondruckermaske4.Caption:='leer';
  end;
  QueryEinstellungModulart.FieldByName('druckermaske4').AsString:=Fname;
  QueryEinstellungModulart.FieldByName('druckermaskeNr4').AsString:=inttostr(Fnr);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormEinstellungModulart.Buttondruckermaske5Click(
  Sender: TObject);
var Fnr:integer;Par:TStringList;
    Fname:String;
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  Par:=TStringList.Create;
  Par:=TForm1.an(FormEinstellungenDrucken,Buttondruckermaske5.Caption,GModulart,GBenutzer,181);
  Fnr:=strtoint(Par[0]);Fname:=Par[1];
  If Fname<>'' Then begin
    Buttondruckermaske5.Caption:=Fname;
  end
  Else begin
    Buttondruckermaske5.Caption:='leer';
  end;
  QueryEinstellungModulart.FieldByName('druckermaske5').AsString:=Fname;
  QueryEinstellungModulart.FieldByName('druckermaskeNr5').AsString:=inttostr(Fnr);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormEinstellungModulart.Buttondruckermaske6Click(
  Sender: TObject);
var Fnr:integer;Par:TStringList;
    Fname:String;
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  Par:=TStringList.Create;
  Par:=TForm1.an(FormEinstellungenDrucken,Buttondruckermaske6.Caption,GModulart,GBenutzer,181);
  Fnr:=strtoint(Par[0]);Fname:=Par[1];
  If Fname<>'' Then begin
    Buttondruckermaske6.Caption:=Fname;
  end
  Else begin
    Buttondruckermaske6.Caption:='leer';
  end;
  QueryEinstellungModulart.FieldByName('druckermaske6').AsString:=Fname;
  QueryEinstellungModulart.FieldByName('druckermaskeNr6').AsString:=inttostr(Fnr);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormEinstellungModulart.ButtonStandardwertArtikelListeClick(
  Sender: TObject);
begin                                                             //'0;EinheitMenge;3;8;57;2;Small Fonts;$000080FF;8;1;0;0;25;
  QueryEinstellungModulart.FieldByName('monitormaske1').AsString:='1;Pos_Nr;3;3;29;1;MS Sans Serif;clNavy;8;0;0;0;0;;';
  QueryEinstellungModulart.FieldByName('monitormaske2').AsString:='1;Artikelgruppe;33;3;152;0;MS Sans Serif;clNavy;8;0;0;0;1;;';
  QueryEinstellungModulart.FieldByName('monitormaske3').AsString:='1;Artikel;186;3;149;0;MS Sans Serif;clNavy;8;0;0;0;2;;';
  QueryEinstellungModulart.FieldByName('monitormaske4').AsString:='1;Menge;336;0;45;1;MS Sans Serif;clNavy;8;0;1;1;3;;';
  QueryEinstellungModulart.FieldByName('monitormaske5').AsString:='1;EinheitMenge;382;3;67;0;MS Sans Serif;clNavy;8;0;0;0;4;;';
  QueryEinstellungModulart.FieldByName('monitormaske6').AsString:='1;EK_Preis;450;0;74;1;MS Sans Serif;clNavy;8;0;1;1;5;;';
  QueryEinstellungModulart.FieldByName('monitormaske7').AsString:='1;Einheit_EK;525;3;67;0;MS Sans Serif;clNavy;8;0;0;0;6;;';
  QueryEinstellungModulart.FieldByName('monitormaske8').AsString:='1;Aufschlag;593;0;39;1;MS Sans Serif;clNavy;8;0;1;1;7;;';
  QueryEinstellungModulart.FieldByName('monitormaske9').AsString:='1;Rabatt;636;0;39;1;MS Sans Serif;clNavy;8;0;1;1;8;;';
  QueryEinstellungModulart.FieldByName('monitormaske10').AsString:='1;VK_Preis;683;1;81;1;MS Sans Serif;clNavy;8;0;0;0;9;;';
  QueryEinstellungModulart.FieldByName('monitormaske11').AsString:='1;Pos_Text;33;23;370;0;Verdana;clGreen;8;2;0;1;10;;';
  QueryEinstellungModulart.FieldByName('monitormaske12').AsString:='1;Berechnen1;450;23;74;0;MS Sans Serif;clNavy;8;0;0;0;11;Berechneter_EK;';
  QueryEinstellungModulart.FieldByName('monitormaske13').AsString:='0;DBEditPos_Nr;144;408;57;0;MS Sans Serif;clNavy;8;0;0;0;12;;';
  QueryEinstellungModulart.FieldByName('monitormaske14').AsString:='0;DBEditPos_Nr;208;408;57;0;MS Sans Serif;clNavy;8;0;0;0;13;;';
  QueryEinstellungModulart.FieldByName('monitormaske15').AsString:='0;DBEditPos_Nr;272;408;57;0;MS Sans Serif;clNavy;8;0;0;0;14;;';
  QueryEinstellungModulart.FieldByName('monitormaske16').AsString:='0;DBEditPos_Nr;336;408;57;0;MS Sans Serif;clNavy;8;0;0;0;15;;';
  QueryEinstellungModulart.FieldByName('monitormaske17').AsString:='0;DBEditPos_Nr;400;408;57;0;MS Sans Serif;clNavy;8;0;0;0;16;;';
  QueryEinstellungModulart.FieldByName('monitormaske18').AsString:='0;DBEditPos_Nr;464;408;57;0;MS Sans Serif;clNavy;8;0;0;0;17;;';
  QueryEinstellungModulart.FieldByName('monitormaske19').AsString:='0;DBEditPos_Nr;528;408;57;0;MS Sans Serif;clNavy;8;0;0;0;18;;';
  QueryEinstellungModulart.FieldByName('monitormaske20').AsString:='0;DBEditPos_Nr;592;408;57;0;MS Sans Serif;clNavy;8;0;0;0;19;;';
  StringToPanel(PanelAL1,QueryEinstellungModulart.FieldByName('monitormaske1').AsString,'','');
  StringToPanel(PanelAL2,QueryEinstellungModulart.FieldByName('monitormaske2').AsString,'','');
  StringToPanel(PanelAL3,QueryEinstellungModulart.FieldByName('monitormaske3').AsString,'','');
  StringToPanel(PanelAL4,QueryEinstellungModulart.FieldByName('monitormaske4').AsString,'','');
  StringToPanel(PanelAL5,QueryEinstellungModulart.FieldByName('monitormaske5').AsString,'','');
  StringToPanel(PanelAL6,QueryEinstellungModulart.FieldByName('monitormaske6').AsString,'','');
  StringToPanel(PanelAL7,QueryEinstellungModulart.FieldByName('monitormaske7').AsString,'','');
  StringToPanel(PanelAL8,QueryEinstellungModulart.FieldByName('monitormaske8').AsString,'','');
  StringToPanel(PanelAL9,QueryEinstellungModulart.FieldByName('monitormaske9').AsString,'','');
  StringToPanel(PanelAL10,QueryEinstellungModulart.FieldByName('monitormaske10').AsString,'','');
  StringToPanel(PanelAL11,QueryEinstellungModulart.FieldByName('monitormaske11').AsString,'','');
  StringToPanel(PanelAL12,QueryEinstellungModulart.FieldByName('monitormaske12').AsString,'','');
  StringToPanel(PanelAL13,QueryEinstellungModulart.FieldByName('monitormaske13').AsString,'','');
  StringToPanel(PanelAL14,QueryEinstellungModulart.FieldByName('monitormaske14').AsString,'','');
  StringToPanel(PanelAL15,QueryEinstellungModulart.FieldByName('monitormaske15').AsString,'','');
  StringToPanel(PanelAL16,QueryEinstellungModulart.FieldByName('monitormaske16').AsString,'','');
  StringToPanel(PanelAL17,QueryEinstellungModulart.FieldByName('monitormaske17').AsString,'','');
  StringToPanel(PanelAL18,QueryEinstellungModulart.FieldByName('monitormaske18').AsString,'','');
  StringToPanel(PanelAL19,QueryEinstellungModulart.FieldByName('monitormaske19').AsString,'','');
  StringToPanel(PanelAL20,QueryEinstellungModulart.FieldByName('monitormaske20').AsString,'','');
end;

Function TFormEinstellungModulart.PanelToString(P:TPanel):String;
begin
  DataModuleMyOffice.FFormatNil(0);
  if P.Color =StringtoColor('clBtnFace') then  FFormat.Sichtbar:=0 Else  FFormat.Sichtbar:=1;
    FFormat.Name:=P.Caption;
    FFormat.Schrift:=P.Font.Name;
    FFormat.Farbe:=ColorToString(P.Font.Color);
    FFormat.Groesse:=P.Font.Size;
    FFormat.Style:=DataModuleMyOffice.StyleToInt(P.Font.Style);
    if P.Alignment=taLeftJustify Then FFormat.j:= 0;
    if P.Alignment=taRightJustify  Then FFormat.j:= 1;
    if P.Alignment=taCenter Then FFormat.j:= 2;
    FFormat.x:=P.Left;
    FFormat.y:=P.Top;
    FFormat.l:=P.Width;
    FFormat.Rahmen:=p.Tag;
    FFormat.Ena:=0;
    FFormat.h:=p.height;
    Result:=DataModuleMyOffice.FdSetString(
      FFormat.Sichtbar,
      FFormat.Name,
      FFormat.x,
      FFormat.y,
      FFormat.l,
      FFormat.j,
      FFormat.Schrift,
      FFormat.Farbe,
      FFormat.Groesse,
      FFormat.Style,
      FFormat.Rahmen,
      0,
      FFormat.h);
  end;

procedure TFormEinstellungModulart.StringToPanel(P:TPanel;s,Feld,FText:String);
begin
  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,s);
  QueryEinstellungModulart.Edit;
  if Feld<>'' Then begin
    QueryEinstellungModulart.FieldByName(Feld).AsString:=s;
    QueryEinstellungModulart.post;
    QueryEinstellungModulart.edit;
  end;
  //if FFormat.Name <>'' Then P.Caption:=FText Else P.Caption:=FFormat.Name;
  P.Caption:=FFormat.Name;
  P.Font.Name:=FFormat.Schrift;
  P.Font.Color:=StringtoColor(FFormat.Farbe);
  P.Font.Size:=FFormat.Groesse;
  P.Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
  P.Width:=FFormat.l;
  //if FFormat.h > 0 then P.Height.FFormat.h;
  if FFormat.Sichtbar=0 Then P.Color:=StringtoColor('clBtnFace') Else  P.Color:=StringtoColor('clWhite');
  if FFormat.j = 0 Then P.Alignment:=taLeftJustify;
  if FFormat.j = 1 Then P.Alignment:=taRightJustify;
  if FFormat.j = 2 Then P.Alignment:=taCenter;
  if FText <>'' Then  P.Caption:=FText;
  {if FFormat.x <>0 Then} P.Left:=FFormat.x;
  {if FFormat.y <>0 Then} P.Top:=FFormat.y;
  {if FFormat.l <>0 Then} P.Width:=FFormat.l;
  P.Tag:=FFormat.Rahmen;
  if P.Caption='Pos_Text' then P.Height:=80 Else P.Height:=19; 
  //if (FFormat.h<> 0) Then P.Height:=FFormat.h;
end;

procedure TFormEinstellungModulart.PanelAL1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske1').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske1');
    if s<>'' then StringToPanel(PanelAL1,s,'monitormaske1','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske2').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske2');
    if s<>'' then StringToPanel(PanelAL2,s,'monitormaske2','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske3').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske3');
    if s<>'' then StringToPanel(PanelAL3,s,'monitormaske3','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL4MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske4').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske4');
    if s<>'' then StringToPanel(PanelAL4,s,'monitormaske4','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL5MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske5').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske5');
    if s<>'' then StringToPanel(PanelAL5,s,'monitormaske5','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL6MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske6').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske6');
    if s<>'' then StringToPanel(PanelAL6,s,'monitormaske6','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL7MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske7').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske7');
    if s<>'' then StringToPanel(PanelAL7,s,'monitormaske7','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL8MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske8').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske8');
    if s<>'' then StringToPanel(PanelAL8,s,'monitormaske8','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL9MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske9').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske9');
    if s<>'' then StringToPanel(PanelAL9,s,'monitormaske9','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL10MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske10').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske10');
    if s<>'' then StringToPanel(PanelAL10,s,'monitormaske10','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL11MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske11').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske11');
    if s<>'' then StringToPanel(PanelAL11,s,'monitormaske11','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL12MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske12').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske12');
    if s<>'' then StringToPanel(PanelAL12,s,'monitormaske12','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL13MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske13').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske13');
    if s<>'' then StringToPanel(PanelAL13,s,'monitormaske13','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL14MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske14').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske14');
    if s<>'' then StringToPanel(PanelAL14,s,'monitormaske14','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL15MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske15').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske15');
    if s<>'' then StringToPanel(PanelAL15,s,'monitormaske15','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL16MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske16').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske16');
    if s<>'' then StringToPanel(PanelAL16,s,'monitormaske16','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL17MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske17').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske17');
    if s<>'' then StringToPanel(PanelAL17,s,'monitormaske17','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL18MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske18').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske18');
    if s<>'' then StringToPanel(PanelAL18,s,'monitormaske18','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL19MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske19').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske19');
    if s<>'' then StringToPanel(PanelAL19,s,'monitormaske19','');
  end;
end;

procedure TFormEinstellungModulart.PanelAL20MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=QueryEinstellungModulart.FieldByName('monitormaske20').AsString;
    s:=FormFormatierung.an(s,9,'','','','Monitormaske20');
    if s<>'' then StringToPanel(PanelAL20,s,'monitormaske20','');
  end;

end;

procedure TFormEinstellungModulart.PanelALDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
if (y < 446) and  (Source is TPanel) then begin
    Accept:=True;
    with Source as TPanel do begin
      Top:=y; Left:=x;
      QueryEinstellungModulart.edit;
      if Name='PanelAL1' Then QueryEinstellungModulart.FieldByName('monitormaske1').AsString:=PanelToString(PanelAL1);
      if Name='PanelAL2' Then QueryEinstellungModulart.FieldByName('monitormaske2').AsString:=PanelToString(PanelAL2);
      if Name='PanelAL3' Then QueryEinstellungModulart.FieldByName('monitormaske3').AsString:=PanelToString(PanelAL3);
      if Name='PanelAL4' Then QueryEinstellungModulart.FieldByName('monitormaske4').AsString:=PanelToString(PanelAL4);
      if Name='PanelAL5' Then QueryEinstellungModulart.FieldByName('monitormaske5').AsString:=PanelToString(PanelAL5);
      if Name='PanelAL6' Then QueryEinstellungModulart.FieldByName('monitormaske6').AsString:=PanelToString(PanelAL6);
      if Name='PanelAL7' Then QueryEinstellungModulart.FieldByName('monitormaske7').AsString:=PanelToString(PanelAL7);
      if Name='PanelAL8' Then QueryEinstellungModulart.FieldByName('monitormaske8').AsString:=PanelToString(PanelAL8);
      if Name='PanelAL9' Then QueryEinstellungModulart.FieldByName('monitormaske9').AsString:=PanelToString(PanelAL9);
      if Name='PanelAL10' Then QueryEinstellungModulart.FieldByName('monitormaske10').AsString:=PanelToString(PanelAL10);
      if Name='PanelAL11' Then QueryEinstellungModulart.FieldByName('monitormaske11').AsString:=PanelToString(PanelAL11);
      if Name='PanelAL12' Then QueryEinstellungModulart.FieldByName('monitormaske12').AsString:=PanelToString(PanelAL12);
      if Name='PanelAL13' Then QueryEinstellungModulart.FieldByName('monitormaske13').AsString:=PanelToString(PanelAL13);
      if Name='PanelAL14' Then QueryEinstellungModulart.FieldByName('monitormaske14').AsString:=PanelToString(PanelAL14);
      if Name='PanelAL15' Then QueryEinstellungModulart.FieldByName('monitormaske15').AsString:=PanelToString(PanelAL15);
      if Name='PanelAL16' Then QueryEinstellungModulart.FieldByName('monitormaske16').AsString:=PanelToString(PanelAL16);
      if Name='PanelAL17' Then QueryEinstellungModulart.FieldByName('monitormaske17').AsString:=PanelToString(PanelAL17);
      if Name='PanelAL18' Then QueryEinstellungModulart.FieldByName('monitormaske18').AsString:=PanelToString(PanelAL18);
      if Name='PanelAL19' Then QueryEinstellungModulart.FieldByName('monitormaske19').AsString:=PanelToString(PanelAL19);
      if Name='PanelAL20' Then QueryEinstellungModulart.FieldByName('monitormaske20').AsString:=PanelToString(PanelAL20);
      if (y > 346) then begin                                                                                          
        if Name='PanelAL1' Then StringToPanel(PanelAL1,'0;DBEditPos_Nr;16;368;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske1','');
        if Name='PanelAL2' Then StringToPanel(PanelAL2,'0;DBEditPos_Nr;80;368;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske2','');
        if Name='PanelAL3' Then StringToPanel(PanelAL3,'0;DBEditPos_Nr;144;368;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske3','');
        if Name='PanelAL4' Then StringToPanel(PanelAL4,'0;DBEditPos_Nr;208;368;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske4','');
        if Name='PanelAL5' Then StringToPanel(PanelAL5,'0;DBEditPos_Nr;272;368;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske5','');
        if Name='PanelAL6' Then StringToPanel(PanelAL6,'0;DBEditPos_Nr;336;368;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske6','');
        if Name='PanelAL7' Then StringToPanel(PanelAL7,'0;DBEditPos_Nr;400;368;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske7','');
        if Name='PanelAL8' Then StringToPanel(PanelAL8,'0;DBEditPos_Nr;464;368;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske8','');
        if Name='PanelAL9' Then StringToPanel(PanelAL9,'0;DBEditPos_Nr;528;368;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske9','');
        if Name='PanelAL10' Then StringToPanel(PanelAL10,'0;DBEditPos_Nr;592;368;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske10','');
        if Name='PanelAL11' Then StringToPanel(PanelAL11,'0;DBEditPos_Nr;16;408;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske11','');
        if Name='PanelAL12' Then StringToPanel(PanelAL12,'0;DBEditPos_Nr;80;408;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske12','');
        if Name='PanelAL13' Then StringToPanel(PanelAL13,'0;DBEditPos_Nr;144;408;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske13','');
        if Name='PanelAL14' Then StringToPanel(PanelAL14,'0;DBEditPos_Nr;208;408;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske14','');
        if Name='PanelAL15' Then StringToPanel(PanelAL15,'0;DBEditPos_Nr;270;408;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske15','');
        if Name='PanelAL16' Then StringToPanel(PanelAL16,'0;DBEditPos_Nr;336;408;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske16','');
        if Name='PanelAL17' Then StringToPanel(PanelAL17,'0;DBEditPos_Nr;400;408;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske17','');
        if Name='PanelAL18' Then StringToPanel(PanelAL18,'0;DBEditPos_Nr;464;408;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske18','');
        if Name='PanelAL19' Then StringToPanel(PanelAL19,'0;DBEditPos_Nr;528;408;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske19','');
        if Name='PanelAL20' Then StringToPanel(PanelAL20,'0;DBEditPos_Nr;592;408;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','monitormaske20','');
      end;
      QueryEinstellungModulart.Post;
      QueryEinstellungModulart.edit;
    end;
  end;
end;

procedure TFormEinstellungModulart.ButtonListeBearbeitenClick(
  Sender: TObject);
  var Fnr:integer;Par:TStringList{;SQLSelect,SQLFrom,SQLWhere,SQLOrder:string};
       Fname:string;
begin //Fenster183
  Par:=TStringList.Create;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  Par:=TForm1.an(FormEinstellungenArtikelAussuchen,'',GModulart,GBenutzer,183);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  Fnr:=strtoint(Par[0]);Fname:=Par[1];
  if Fname <> '' then begin

  end;
  Par.Free;
  if QueryEinstellungArtikelaussuchen.Active then QueryEinstellungArtikelaussuchen.close;
  QueryEinstellungArtikelaussuchen.sql.Clear;
  QueryEinstellungArtikelaussuchen.sql.add('Select * From artikelaussuchen');
  try
    QueryEinstellungArtikelaussuchen.open;//Self.Query1.Edit;
  finally
  end;
end;

procedure TFormEinstellungModulart.Button1zurueckClick(Sender: TObject);
var Eingetragen_Ja:Boolean;
begin
  Eingetragen_Ja:=False;
  if (Eingetragen_Ja = False) and (DBEditArtikelAussuchen1.text='') then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen1').AsString:= QueryEinstellungArtikelaussuchen.FieldByName('Bezeichnung').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr1').AsString:=QueryEinstellungArtikelaussuchen.FieldByName('Nr').AsString;
    Eingetragen_Ja:=True;
  end;
  if (Eingetragen_Ja = False) and (DBEditArtikelAussuchen2.text='') then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen2').AsString:= QueryEinstellungArtikelaussuchen.FieldByName('Bezeichnung').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr2').AsString:=QueryEinstellungArtikelaussuchen.FieldByName('Nr').AsString;
    Eingetragen_Ja:=True;
  end;
  if (Eingetragen_Ja = False) and (DBEditArtikelAussuchen3.text='') then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen3').AsString:= QueryEinstellungArtikelaussuchen.FieldByName('Bezeichnung').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr3').AsString:=QueryEinstellungArtikelaussuchen.FieldByName('Nr').AsString;
    Eingetragen_Ja:=True;
  end;
  if (Eingetragen_Ja = False) and (DBEditArtikelAussuchen4.text='') then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen4').AsString:= QueryEinstellungArtikelaussuchen.FieldByName('Bezeichnung').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr4').AsString:=QueryEinstellungArtikelaussuchen.FieldByName('Nr').AsString;
    Eingetragen_Ja:=True;
  end;
  if (Eingetragen_Ja = False) and (DBEditArtikelAussuchen5.text='') then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen5').AsString:= QueryEinstellungArtikelaussuchen.FieldByName('Bezeichnung').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr5').AsString:=QueryEinstellungArtikelaussuchen.FieldByName('Nr').AsString;
    Eingetragen_Ja:=True;
  end;
  if (Eingetragen_Ja = False) and (DBEditArtikelAussuchen6.text='') then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen6').AsString:= QueryEinstellungArtikelaussuchen.FieldByName('Bezeichnung').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr6').AsString:=QueryEinstellungArtikelaussuchen.FieldByName('Nr').AsString;
    Eingetragen_Ja:=True;
  end;
  if (Eingetragen_Ja = False) and (DBEditArtikelAussuchen7.text='') then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen7').AsString:= QueryEinstellungArtikelaussuchen.FieldByName('Bezeichnung').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr7').AsString:=QueryEinstellungArtikelaussuchen.FieldByName('Nr').AsString;
    Eingetragen_Ja:=True;
  end;
  if (Eingetragen_Ja = False) and (DBEditArtikelAussuchen8.text='') then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen8').AsString:= QueryEinstellungArtikelaussuchen.FieldByName('Bezeichnung').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr8').AsString:=QueryEinstellungArtikelaussuchen.FieldByName('Nr').AsString;
    Eingetragen_Ja:=True;
  end;
end;

procedure TFormEinstellungModulart.ButtonArtikelaussuchenloeschenClick(
  Sender: TObject);
begin
  if  UFocus='DBEditArtikelAussuchen1' Then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen1').AsString:='';
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr1').AsString:='';
  end;
  if  UFocus='DBEditArtikelAussuchen2' Then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen2').AsString:='';
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr2').AsString:='';
  end;
  if  UFocus='DBEditArtikelAussuchen3' Then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen3').AsString:='';
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr3').AsString:='';
  end;
  if  UFocus='DBEditArtikelAussuchen4' Then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen4').AsString:='';
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr4').AsString:='';
  end;
  if  UFocus='DBEditArtikelAussuchen5' Then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen5').AsString:='';
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr5').AsString:='';
  end;
  if  UFocus='DBEditArtikelAussuchen6' Then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen6').AsString:='';
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr6').AsString:='';
  end;
  if  UFocus='DBEditArtikelAussuchen7' Then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen7').AsString:='';
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr7').AsString:='';
  end;
  if  UFocus='DBEditArtikelAussuchen8' Then begin
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen8').AsString:='';
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr8').AsString:='';
  end;

end;

procedure TFormEinstellungModulart.DBEditArtikelAussuchen1Enter(
  Sender: TObject);
begin
  UFocus:='DBEditArtikelAussuchen1';
end;

procedure TFormEinstellungModulart.DBEditArtikelAussuchen2Enter(
  Sender: TObject);
begin
  UFocus:='DBEditArtikelAussuchen2';
end;

procedure TFormEinstellungModulart.DBEditArtikelAussuchen3Enter(
  Sender: TObject);
begin
  UFocus:='DBEditArtikelAussuchen3';
end;

procedure TFormEinstellungModulart.DBEditArtikelAussuchen4Enter(
  Sender: TObject);
begin
  UFocus:='DBEditArtikelAussuchen4';
end;

procedure TFormEinstellungModulart.DBEditArtikelAussuchen5Enter(
  Sender: TObject);
begin
  UFocus:='DBEditArtikelAussuchen5';
end;

procedure TFormEinstellungModulart.DBEditArtikelAussuchen6Enter(
  Sender: TObject);
begin
  UFocus:='DBEditArtikelAussuchen6';
end;

procedure TFormEinstellungModulart.DBEditArtikelAussuchen7Enter(
  Sender: TObject);
begin
  UFocus:='DBEditArtikelAussuchen7';
end;

procedure TFormEinstellungModulart.DBEditArtikelAussuchen8Enter(
  Sender: TObject);
begin
  UFocus:='DBEditArtikelAussuchen8';
end;

procedure TFormEinstellungModulart.ButtonobenClick(Sender: TObject);
var Eingetragen_Verschoben:Boolean;
    ArtikelAussuchen,ArtikelAussuchenNr:String;
begin
  Eingetragen_Verschoben:=False;
  if  (Eingetragen_Verschoben = false) and (UFocus='DBEditArtikelAussuchen1') Then begin
    Eingetragen_Verschoben:=True
  end;
  if  (Eingetragen_Verschoben = false) and (UFocus='DBEditArtikelAussuchen2') Then begin
    ArtikelAussuchen:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen1').AsString;
    ArtikelAussuchenNr:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr1').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen1').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen2').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr1').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr2').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen2').AsString:=ArtikelAussuchen;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr2').AsString:=ArtikelAussuchenNr;
  end;
  if  (Eingetragen_Verschoben = false) and (UFocus='DBEditArtikelAussuchen3') Then begin
    ArtikelAussuchen:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen2').AsString;
    ArtikelAussuchenNr:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr2').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen2').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen3').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr2').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr3').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen3').AsString:=ArtikelAussuchen;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr3').AsString:=ArtikelAussuchenNr;
  end;
  if  (Eingetragen_Verschoben = false) and (UFocus='DBEditArtikelAussuchen4') Then begin
    ArtikelAussuchen:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen3').AsString;
    ArtikelAussuchenNr:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr3').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen3').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen4').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr3').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr4').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen4').AsString:=ArtikelAussuchen;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr4').AsString:=ArtikelAussuchenNr;
  end;
  if  (Eingetragen_Verschoben = false) and (UFocus='DBEditArtikelAussuchen5') Then begin
    ArtikelAussuchen:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen4').AsString;
    ArtikelAussuchenNr:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr4').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen4').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen5').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr4').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr5').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen5').AsString:=ArtikelAussuchen;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr5').AsString:=ArtikelAussuchenNr;
  end;
  if  (Eingetragen_Verschoben = false) and (UFocus='DBEditArtikelAussuchen6') Then begin
    ArtikelAussuchen:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen5').AsString;
    ArtikelAussuchenNr:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr5').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen5').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen6').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr5').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr6').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen6').AsString:=ArtikelAussuchen;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr6').AsString:=ArtikelAussuchenNr;
  end;
  if  (Eingetragen_Verschoben = false) and (UFocus='DBEditArtikelAussuchen7') Then begin
    ArtikelAussuchen:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen6').AsString;
    ArtikelAussuchenNr:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr6').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen6').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen7').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr6').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr7').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen7').AsString:=ArtikelAussuchen;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr7').AsString:=ArtikelAussuchenNr;
  end;
  if  (Eingetragen_Verschoben = false) and (UFocus='DBEditArtikelAussuchen8') Then begin
    ArtikelAussuchen:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen7').AsString;
    ArtikelAussuchenNr:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr7').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen7').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen8').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr7').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr8').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen8').AsString:=ArtikelAussuchen;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr8').AsString:=ArtikelAussuchenNr;
  end;
end;

procedure TFormEinstellungModulart.ButtonuntenClick(Sender: TObject);
var Eingetragen_Verschoben:Boolean;
    ArtikelAussuchen,ArtikelAussuchenNr:String;
begin
  Eingetragen_Verschoben:=False;
  if  (Eingetragen_Verschoben = false) and (UFocus='DBEditArtikelAussuchen8') Then begin
    Eingetragen_Verschoben:=True
  end;
  if  (Eingetragen_Verschoben = false) and (UFocus='DBEditArtikelAussuchen7') Then begin
    ArtikelAussuchen:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen8').AsString;
    ArtikelAussuchenNr:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr8').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen8').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchen7').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr8').AsString:=QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr7').AsString;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchen7').AsString:=ArtikelAussuchen;
    QueryEinstellungModulart.FieldByName('ArtikelAussuchenNr7').AsString:=ArtikelAussuchenNr;
  end;
  
end;

end.
