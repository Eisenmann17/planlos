unit UnitEinstellungenDrucken;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls, DBCtrls,
  Mask, ComCtrls, ExtCtrls;

type
  TFormEinstellungenDrucken = class(TForm)
    ZQueryEinstellungenDrucken: TZQuery;
    DataSource1: TDataSource;
    FontDialog1: TFontDialog;
    ColorDialog1: TColorDialog;
    PanelTastatur: TPanel;
    LabelInfo_p: TLabel;
    PageControlDrucken: TPageControl;
    TabSheet2: TTabSheet;
    TabSheetVerwaltung: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DBText1: TDBText;
    DBEditModulart: TDBEdit;
    DBEditBenutzer: TDBEdit;
    DBEditBeschreibung: TDBEdit;
    TabSheet3: TTabSheet;
    Label19: TLabel;
    Label21: TLabel;
    PanelD_FussZeile: TPanel;
    PanelD_Summenzeile1: TPanel;
    Label23: TLabel;
    PanelD_Summenzeile2: TPanel;
    PanelD_Summenzeile3: TPanel;
    PanelD_Summenzeile4: TPanel;
    PanelD_MemoFuss: TPanel;
    Label24: TLabel;
    TabSheetKopf: TTabSheet;
    Label12: TLabel;
    DBEditAbstand_Links: TDBEdit;
    Label13: TLabel;
    DBEditAbstand_Oben: TDBEdit;
    Label14: TLabel;
    Label15: TLabel;
    PanelMemokopf: TPanel;
    PanelD_Adresse: TPanel;
    PanelModular: TPanel;
    Label20: TLabel;
    Label25: TLabel;
    PanelAbs: TPanel;
    PanelNotiz: TPanel;
    Panel4: TPanel;
    PanelModulartklein: TPanel;
    PanelIhrZeichen: TPanel;
    PanelTransaktionsNr: TPanel;
    PanelDatum: TPanel;
    PanelBearbeiter: TPanel;
    PanelAdresseKurzname: TPanel;
    PanelGruppe: TPanel;
    PanelBezeichnung: TPanel;
    PanelProjekt: TPanel;
    PanelLabelIhrZeichen: TPanel;
    PanelLabelProjekt: TPanel;
    PanelLabelBezeichnung: TPanel;
    PanelLabelGruppe: TPanel;
    PanelLabelAdresseKurzname: TPanel;
    PanelLabelModulartKlein: TPanel;
    PanelLabelBearbeiter: TPanel;
    PanelLabelDatum: TPanel;
    PanelLabelTransaktionsNr: TPanel;
    Splitter1: TSplitter;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    PanelRahmen1: TPanel;
    PanelRahmen2: TPanel;
    TabSheetlogo: TTabSheet;
    DBImageLogo: TDBImage;
    PanelLogoEnde: TPanel;
    PanelText1: TPanel;
    PanelText2: TPanel;
    PanelText3: TPanel;
    DBRadioGroupFdruck: TDBRadioGroup;
    OpenDialog1: TOpenDialog;
    ButtonDateiname: TButton;
    Label10: TLabel;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    LabelF10: TLabel;
    LabelEsc: TLabel;
    LabelInfo: TLabel;
    ButtonEsc: TButton;
    ButtonStandard: TButton;
    ButtonalsStandardSetzen: TButton;
    Buttonspeichern: TButton;
    ImageTastatur: TImage;
    Memo1: TMemo;
    Label16: TLabel;
    PanelD_KopfZeile: TPanel;
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
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure StringToPanel(P:TPanel;s,Feld,FText:String);
    procedure StringToImage(P:TDBImage;s,Feld,Dateiname:String);
    Function PanelToString(P:TPanel):String;
    Function ImageToString(P:TDBImage;Dateiname:String):String;
    procedure TabSheetKopfDragOver(Sender, Source: TObject; X, Y: Integer;State: TDragState; var Accept: Boolean);
    procedure ButtonStandardClick(Sender: TObject);
    procedure StringToPanels();
    procedure PanelLabelProjektMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelProjektMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelLabelBezeichnungMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelBezeichnungMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelLabelGruppeMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelGruppeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelLabelAdresseKurznameMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelAdresseKurznameMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelNotizMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelAbsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelD_AdresseMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelLabelModulartKleinMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelModulartkleinMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelLabelBearbeiterMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelBearbeiterMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelLabelDatumMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelDatumMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelLabelTransaktionsNrMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelTransaktionsNrMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelLabelIhrZeichenMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelIhrZeichenMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelModularMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelMemokopfMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelD_KopfZeileMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelD_Summenzeile1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelD_Summenzeile2MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelD_Summenzeile3MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelD_Summenzeile4MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelD_MemoFussMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelD_FussZeileMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelRahmen2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelRahmen1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBImageLogoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TabSheetlogoDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PanelLogoEndeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelText1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelText2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelText3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonDateinameClick(Sender: TObject);
    procedure PanelALDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
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

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormEinstellungenDrucken: TFormEinstellungenDrucken;
  UZeiger:longint;UZeigerNeu:Boolean;

implementation

uses UnitDataModul, UnitModule, UnitMeldefenster, UnitDB,UnitFormatierung;
{$R *.DFM}

procedure TFormEinstellungenDrucken.ButtonOkClick(Sender: TObject);
begin
  ZQueryEinstellungenDrucken.Post;
  FormPlanlos.Gzeiger:=ZQueryEinstellungenDrucken.Fields[0].Value;
  ZQueryEinstellungenDrucken.close;
  close;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelInfo,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelInfo_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormEinstellungenDrucken.ButtonabbrechenClick(Sender: TObject);
var ABtext:String;FAbbrechen:Boolean;
begin
 if UZeigerNeu then ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelInfo,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelInfo_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  if FAbbrechen then
    begin
      if UZeigerNeu then
       begin
        ZQueryEinstellungenDrucken.close;
        if (DataModuleDB.DatensatzLoeschen('einstellungdrucken',Uzeiger) = False) Then
          begin
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
          end;
        end
      else // änderung  abbrechen
      begin
        ZQueryEinstellungenDrucken.Cancel;ZQueryEinstellungenDrucken.close;
      end;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelInfo,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelInfo_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormEinstellungenDrucken.FormActivate(Sender: TObject);
var s:String;
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelInfo,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelInfo_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  if ZQueryEinstellungenDrucken.Active then ZQueryEinstellungenDrucken.close;
  ZQueryEinstellungenDrucken.sql.Clear;
  ZQueryEinstellungenDrucken.sql.add('Select * From  Einstellungdrucken Where nr = '+ inttostr(Uzeiger));
  try
    ZQueryEinstellungenDrucken.open;//Self.Query1.Edit;
  finally
  end;
  if (UZeigerNeu=True) and (ZQueryEinstellungenDrucken.FieldByName('Modulart').AsString='')Then begin
    ButtonStandardClick(Self);
    FontDialog1.Options := [];
  end;
  ZQueryEinstellungenDrucken.edit;
  StringToPanels;
  ButtonDateiname.Caption:=ZQueryEinstellungenDrucken.FieldByName('Druckermaske').AsString;
end;

procedure TFormEinstellungenDrucken.StringToPanels();
begin
  StringToPanel(PanelLabelProjekt,ZQueryEinstellungenDrucken.FieldByName('LabelProjekt').AsString,'LabelProjekt','');
  StringToPanel(PanelProjekt,ZQueryEinstellungenDrucken.FieldByName('Projekt').AsString,'Projekt','');
  StringToPanel(PanelLabelBezeichnung,ZQueryEinstellungenDrucken.FieldByName('LabelBezeichnung').AsString,'LabelBezeichnung','');
  StringToPanel(PanelBezeichnung,ZQueryEinstellungenDrucken.FieldByName('Bezeichnung').AsString,'Bezeichnung','');
  StringToPanel(PanelLabelGruppe,ZQueryEinstellungenDrucken.FieldByName('LabelGruppe').AsString,'LabelGruppe','');
  StringToPanel(PanelGruppe,ZQueryEinstellungenDrucken.FieldByName('Gruppe').AsString,'Gruppe','');
  StringToPanel(PanelLabelAdresseKurzname,ZQueryEinstellungenDrucken.FieldByName('LabelAdresseKurzname').AsString,'LabelAdresseKurzname','');
  StringToPanel(PanelAdresseKurzname,ZQueryEinstellungenDrucken.FieldByName('AdresseKurzname').AsString,'AdresseKurzname','');
  StringToPanel(PanelNotiz,ZQueryEinstellungenDrucken.FieldByName('Notiz').AsString,'Notiz','');
  StringToPanel(PanelAbs,ZQueryEinstellungenDrucken.FieldByName('Absender').AsString,'Absender','');
  StringToPanel(PanelD_Adresse,ZQueryEinstellungenDrucken.FieldByName('Adresse').AsString,'Adresse','');
  StringToPanel(PanelLabelModulartKlein,ZQueryEinstellungenDrucken.FieldByName('LabelModulartKlein').AsString,'LabelModulartKlein','');
  StringToPanel(PanelModulartklein,ZQueryEinstellungenDrucken.FieldByName('ModulartKlein').AsString,'ModulartKlein','');
  StringToPanel(PanelLabelBearbeiter,ZQueryEinstellungenDrucken.FieldByName('LabelBearbeiter').AsString,'LabelBearbeiter','');
  StringToPanel(PanelBearbeiter,ZQueryEinstellungenDrucken.FieldByName('Bearbeiter').AsString,'Bearbeiter','');
  StringToPanel(PanelLabelDatum,ZQueryEinstellungenDrucken.FieldByName('LabelDatum').AsString,'LabelDatum','');
  StringToPanel(PanelDatum,ZQueryEinstellungenDrucken.FieldByName('Datum').AsString,'Datum','');
  StringToPanel(PanelLabelTransaktionsNr,ZQueryEinstellungenDrucken.FieldByName('LabelTransaktionsNr').AsString,'LabelTransaktionsNr','');
  StringToPanel(PanelTransaktionsNr,ZQueryEinstellungenDrucken.FieldByName('TransaktionsNr').AsString,'TransaktionsNr','');
  StringToPanel(PanelLabelIhrZeichen,ZQueryEinstellungenDrucken.FieldByName('LabelIhrZeichen').AsString,'LabelIhrZeichen','');
  StringToPanel(PanelIhrZeichen,ZQueryEinstellungenDrucken.FieldByName('IhrZeichen').AsString,'IhrZeichen','');
  StringToPanel(PanelModular,ZQueryEinstellungenDrucken.FieldByName('Titel').AsString,'Titel','');
  StringToPanel(PanelMemokopf,ZQueryEinstellungenDrucken.FieldByName('Memokopf').AsString,'Memokopf','');
  StringToPanel(PanelD_KopfZeile,ZQueryEinstellungenDrucken.FieldByName('KopfZeile').AsString,'KopfZeile','');
  StringToPanel(PanelD_Summenzeile1,ZQueryEinstellungenDrucken.FieldByName('Summenzeile1').AsString,'Summenzeile1','');
  StringToPanel(PanelD_Summenzeile2,ZQueryEinstellungenDrucken.FieldByName('Summenzeile2').AsString,'Summenzeile2','');
  StringToPanel(PanelD_Summenzeile3,ZQueryEinstellungenDrucken.FieldByName('Summenzeile3').AsString,'Summenzeile3','');
  StringToPanel(PanelD_Summenzeile4,ZQueryEinstellungenDrucken.FieldByName('Summenzeile4').AsString,'Summenzeile4','');
  StringToPanel(PanelD_MemoFuss,ZQueryEinstellungenDrucken.FieldByName('MemoFuss').AsString,'MemoFuss','');
  StringToPanel(PanelD_FussZeile,ZQueryEinstellungenDrucken.FieldByName('FussZeile').AsString,'FussZeile','');
  StringToPanel(PanelRahmen1,ZQueryEinstellungenDrucken.FieldByName('Rahmen1').AsString,'Rahmen1','');
  StringToPanel(PanelRahmen2,ZQueryEinstellungenDrucken.FieldByName('Rahmen2').AsString,'Rahmen2','');
  StringToImage(DBImageLogo,ZQueryEinstellungenDrucken.FieldByName('FormatLogo').AsString,'FormatLogo',''{Dateiname});
  StringToPanel(PanelText1,ZQueryEinstellungenDrucken.FieldByName('Text1').AsString,'Text1','');
  StringToPanel(PanelText2,ZQueryEinstellungenDrucken.FieldByName('Text2').AsString,'Text2','');
  StringToPanel(PanelText3,ZQueryEinstellungenDrucken.FieldByName('Text3').AsString,'Text3','');
  PanelLogoEnde.top:=ZQueryEinstellungenDrucken.FieldByName('PanelLogoEnde').AsInteger;
  StringToPanel(PanelAL1,ZQueryEinstellungenDrucken.FieldByName('Feld1').AsString,'Feld1','');
  StringToPanel(PanelAL2,ZQueryEinstellungenDrucken.FieldByName('Feld2').AsString,'Feld2','');
  StringToPanel(PanelAL3,ZQueryEinstellungenDrucken.FieldByName('Feld3').AsString,'Feld3','');
  StringToPanel(PanelAL4,ZQueryEinstellungenDrucken.FieldByName('Feld4').AsString,'Feld4','');
  StringToPanel(PanelAL5,ZQueryEinstellungenDrucken.FieldByName('Feld5').AsString,'Feld5','');
  StringToPanel(PanelAL6,ZQueryEinstellungenDrucken.FieldByName('Feld6').AsString,'Feld6','');
  StringToPanel(PanelAL7,ZQueryEinstellungenDrucken.FieldByName('Feld7').AsString,'Feld7','');
  StringToPanel(PanelAL8,ZQueryEinstellungenDrucken.FieldByName('Feld8').AsString,'Feld8','');
  StringToPanel(PanelAL9,ZQueryEinstellungenDrucken.FieldByName('Feld9').AsString,'Feld9','');
  StringToPanel(PanelAL10,ZQueryEinstellungenDrucken.FieldByName('Feld10').AsString,'Feld10','');
  StringToPanel(PanelAL11,ZQueryEinstellungenDrucken.FieldByName('Feld11').AsString,'Feld11','');
  StringToPanel(PanelAL12,ZQueryEinstellungenDrucken.FieldByName('Feld12').AsString,'Feld12','');
  StringToPanel(PanelAL13,ZQueryEinstellungenDrucken.FieldByName('Feld13').AsString,'Feld13','');
  StringToPanel(PanelAL14,ZQueryEinstellungenDrucken.FieldByName('Feld14').AsString,'Feld14','');
  StringToPanel(PanelAL15,ZQueryEinstellungenDrucken.FieldByName('Feld15').AsString,'Feld15','');
  StringToPanel(PanelAL16,ZQueryEinstellungenDrucken.FieldByName('Feld16').AsString,'Feld16','');
  StringToPanel(PanelAL17,ZQueryEinstellungenDrucken.FieldByName('Feld17').AsString,'Feld17','');
  StringToPanel(PanelAL18,ZQueryEinstellungenDrucken.FieldByName('Feld18').AsString,'Feld18','');
  StringToPanel(PanelAL19,ZQueryEinstellungenDrucken.FieldByName('Feld19').AsString,'Feld19','');
  StringToPanel(PanelAL20,ZQueryEinstellungenDrucken.FieldByName('Feld20').AsString,'Feld20','');
end;


procedure TFormEinstellungenDrucken.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

procedure TFormEinstellungenDrucken.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  //if Key = VK_F4 then ButtonsuchenClick(Self);
  if Key = VK_F10 then ButtonOKClick(Self);
end;

procedure TFormEinstellungenDrucken.ButtonStandardClick(Sender: TObject);
Var Schrift,Farbe:String;Schriftgroesse:integer;
  i:integer;
begin
  Schrift:='Arial';
  Farbe:='clblack';
  Schriftgroesse:=8;
  ZQueryEinstellungenDrucken.FieldByName('Abstand_Links').AsString:='70';
  ZQueryEinstellungenDrucken.FieldByName('Abstand_Oben').AsString:='20';
  ZQueryEinstellungenDrucken.FieldByName('Abstand_Rechts').AsString:='5';
  ZQueryEinstellungenDrucken.FieldByName('Abstand_Unten').AsString:='50';
  ZQueryEinstellungenDrucken.FieldByName('Modulart').AsString:=GModulart;
  ZQueryEinstellungenDrucken.FieldByName('Benutzer').AsString:=GBenutzer;
  ZQueryEinstellungenDrucken.FieldByName('Beschreibung').AsString:='Standard Maske '+GModulart;
  ZQueryEinstellungenDrucken.FieldByName('FDrucker').AsString:='Preview';
  DBRadioGroupFdruck.ItemIndex:=0;

  ZQueryEinstellungenDrucken.FieldByName('LabelProjekt').AsString:='0;Projekt:;354;243;100;0;Arial;clNavy;8;1;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('Projekt').AsString:='0;Beispieltext;457;243;200;0;Times New Roman;clWindowText;8;0;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('LabelBezeichnung').AsString:='1;Bezeichnung:;354;43;100;0;Arial;clNavy;8;1;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('Bezeichnung').AsString:='1;Beispieltext;461;44;200;0;Times New Roman;clWindowText;8;0;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('LabelGruppe').AsString:='0;Gruppe:;354;292;100;0;Arial;clNavy;8;1;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('Gruppe').AsString:='0;Beispieltext;457;291;200;0;Times New Roman;clWindowText;8;0;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('LabelAdresseKurzname').AsString:='0;Adr.-Kurzname:;354;315;100;0;Arial;clNavy;8;1;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('AdresseKurzname').AsString:='0;Beispieltext;456;315;200;0;Times New Roman;clWindowText;8;0;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('Notiz').AsString:='0;Notiz;2;357;660;0;Times New Roman;clWindowText;8;2;0;0;20;';
  ZQueryEinstellungenDrucken.FieldByName('Absender').AsString:='1;Abs.........;2;11;250;0;Arial;clWindowText;8;0;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('Adresse').AsString:='1;Beispieltext;2;30;250;0;Arial;clWindowText;10;1;0;0;100;';
  ZQueryEinstellungenDrucken.FieldByName('LabelModulartKlein').AsString:='1;ModulartKlein;354;18;100;0;Arial;clNavy;8;1;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('ModulartKlein').AsString:='1;Beispieltext;519;18;142;0;Times New Roman;clWindowText;8;0;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('LabelBearbeiter').AsString:='1;Bearbeiter:;353;69;100;0;Arial;clNavy;8;1;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('Bearbeiter').AsString:='1;Beispieltext;461;69;200;0;Times New Roman;clWindowText;8;0;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('LabelDatum').AsString:='1;Datum:;352;94;100;0;Arial;clNavy;8;1;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('Datum').AsString:='1;Beispieltext;461;95;200;0;Times New Roman;clWindowText;8;0;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('LabelTransaktionsNr').AsString:='0;TransaktionsNr:;353;267;100;0;Arial;clNavy;8;1;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('TransaktionsNr').AsString:='0;Beispieltext;456;267;200;0;Times New Roman;clWindowText;8;0;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('LabelIhrZeichen').AsString:='1;IhrZeichen;353;119;100;0;Arial;clNavy;8;1;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('IhrZeichen').AsString:='1;Beispieltext;461;120;200;0;Times New Roman;clWindowText;8;0;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('Titel').AsString:='1;#;2;394;660;2;Arial;clWindowText;16;1;0;0;39;';
  ZQueryEinstellungenDrucken.FieldByName('Memokopf').AsString:='1;Beispieltext;2;447;660;0;Times New Roman;clWindowText;10;0;0;0;40;';//                             100                                                                                                 200                              233
  ZQueryEinstellungenDrucken.FieldByName('KopfZeile').AsString:='1;Pos   Artikelgruppe                         Artikel                                        Menge Einheit           Rabatt                                        VK_Preis;2;18;660;0;Arial;clWindowText;8;1;0;0;20;';
  ZQueryEinstellungenDrucken.FieldByName('Summenzeile1').AsString:='1;Gesamt: [VK] €;2;313;660;1;Arial;clWindowText;8;0;0;0;20;';
  ZQueryEinstellungenDrucken.FieldByName('Summenzeile2').AsString:='1;+ [MwSt] % Mwst [MwStBetrag] €;2;339;660;1;Arial;clWindowText;8;0;0;0;20;';
  ZQueryEinstellungenDrucken.FieldByName('Summenzeile3').AsString:='1;Gesamtbetrag = [VKPlusMwSt] €;2;365;660;1;Arial;clWindowText;8;0;0;0;20;';
  ZQueryEinstellungenDrucken.FieldByName('Summenzeile4').AsString:='1;;2;391;660;1;Arial;clWindowText;8;0;0;0;20;';
  ZQueryEinstellungenDrucken.FieldByName('MemoFuss').AsString:='1;Beispieltext;2;439;660;0;Times New Roman;clWindowText;10;0;0;0;40;';
  ZQueryEinstellungenDrucken.FieldByName('FussZeile').AsString:='1;Seite  - [Page#] -;2;504;660;2;Arial;clWindowText;9;2;0;0;20;';
  ZQueryEinstellungenDrucken.FieldByName('Rahmen1').AsString:='1;Rahmen1;348;8;317;2;MS Sans Serif;clWindowText;8;0;0;0;165;';
  ZQueryEinstellungenDrucken.FieldByName('Rahmen2').AsString:='0;Rahmen2;584;200;73;2;MS Sans Serif;clWindowText;8;0;0;0;33;';
  ZQueryEinstellungenDrucken.FieldByName('FormatLogo').AsString:='0;Logo;444;7;220;0;;clWindowText;8;0;0;0;130;';
  ZQueryEinstellungenDrucken.FieldByName('PanelLogoEnde').AsString:='144';
  ZQueryEinstellungenDrucken.FieldByName('Text1').AsString:='1;Nr.:;461;18;33;0;Arial;clNavy;8;1;0;0;17;';
  ZQueryEinstellungenDrucken.FieldByName('Text2').AsString:='1;USt-Id Nr.:;353;143;308;0;Arial;clNavy;8;1;0;0;18;';
  ZQueryEinstellungenDrucken.FieldByName('Text3').AsString:='0;Text3;354;216;73;0;Arial;clNavy;8;1;0;0;17;';
  ZQueryEinstellungenDrucken.FieldByName('Feld1').AsString:='1;Pos_Nr;0;0;29;1;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld2').AsString:='1;Artikelgruppe;33;0;152;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld3').AsString:='1;Artikel;186;0;149;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld4').AsString:='1;Menge;336;0;45;1;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld5').AsString:='1;EinheitMenge;382;0;67;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld6').AsString:='1;Rabatt;450;0;39;1;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld7').AsString:='1;VK_Preis;570;0;90;1;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld8').AsString:='0;Pos_Nr;464;368;51;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld9').AsString:='0;Pos_Nr;528;368;51;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld10').AsString:='0;Pos_Nr;592;368;51;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld11').AsString:='0;Pos_Nr;16;408;51;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld12').AsString:='0;Pos_Nr;80;408;51;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld13').AsString:='0;Pos_Nr;144;408;51;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld14').AsString:='0;Pos_Nr;208;408;51;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld15').AsString:='0;Pos_Nr;272;408;51;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld16').AsString:='0;Pos_Nr;336;408;51;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld17').AsString:='0;Pos_Nr;400;408;51;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld18').AsString:='0;Pos_Nr;464;408;51;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld19').AsString:='0;Pos_Nr;528;408;51;0;Arial;clBlack;8;0;0;0;0;';
  ZQueryEinstellungenDrucken.FieldByName('Feld20').AsString:='1;Pos_Text;33;21;370;0;Arial;clBlack;8;0;0;0;0;';
  StringToPanels();
  //Memo.Free;
end;

Function TFormEinstellungenDrucken.ImageToString(P:TDBImage;Dateiname:String):String;
begin
  DataModuleMyOffice.FFormatNil(0);
  if P.Color =StringtoColor('clBtnFace') then  FFormat.Sichtbar:=0 Else  FFormat.Sichtbar:=1;
    FFormat.Name:='Logo';//P.Caption;
    FFormat.Schrift:='';//P.Font.Name;
    FFormat.Farbe:=ColorToString(P.Font.Color);
    FFormat.Groesse:=8;//P.Font.Size;
    FFormat.Style:=0;//DataModuleMyOffice.StyleToInt(P.Font.Style);
    FFormat.j:= 0;
    //if P.Alignment=taRightJustify  Then FFormat.j:= 1;
    //if P.Alignment=taCenter Then FFormat.j:= 2;
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

Function TFormEinstellungenDrucken.PanelToString(P:TPanel):String;
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

procedure TFormEinstellungenDrucken.StringToPanel(P:TPanel;s,Feld,FText:String);
begin
  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,s);
  ZQueryEinstellungenDrucken.Edit;
  if Feld<>'' Then begin
    ZQueryEinstellungenDrucken.FieldByName(Feld).AsString:=s;
    ZQueryEinstellungenDrucken.post;
    ZQueryEinstellungenDrucken.edit;
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
  if (FFormat.h<> 0) Then P.Height:=FFormat.h;
end;

procedure TFormEinstellungenDrucken.StringToImage(P:TDBImage;s,Feld,Dateiname:String);
begin
  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,s);
  //Showmessage(s);
  ZQueryEinstellungenDrucken.Edit;
  if Feld<>'' Then ZQueryEinstellungenDrucken.FieldByName(Feld).AsString:=s;
  ZQueryEinstellungenDrucken.post;
  ZQueryEinstellungenDrucken.edit;
  //if FFormat.Name <>'' Then P.Caption:=FText Else P.Caption:=FFormat.Name;
  //P.Caption:=FFormat.Name;
  //if FFormat.Schrift <>'' then ImageLogo.
  //Showmessage('FFormat.Schrift in StringToImage'+FFormat.Schrift);
  if FFormat.Schrift <>'' then P.Picture.LoadFromFile(FFormat.Schrift);
  //P.Font.Color:=StringtoColor(FFormat.Farbe);
  //P.Font.Size:=FFormat.Groesse;
  //P.Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
  P.Width:=FFormat.l;
  //if FFormat.h > 0 then P.Height.FFormat.h;
  if FFormat.Sichtbar=0 Then P.Color:=StringtoColor('clBtnFace') Else  P.Color:=StringtoColor('clWhite');
  //if FFormat.j = 0 Then P.Alignment:=taLeftJustify;
  //if FFormat.j = 1 Then P.Alignment:=taRightJustify;
  //if FFormat.j = 2 Then P.Alignment:=taCenter;
  //if FText <>'' Then  P.Caption:=FText;
  if FFormat.x <>0 Then P.Left:=FFormat.x;
  if FFormat.y <>0 Then P.Top:=FFormat.y;
  if FFormat.l <>0 Then P.Width:=FFormat.l;
  //P.Tag:=FFormat.Rahmen;
  if (FFormat.h<> 0) Then P.Height:=FFormat.h;
end;

//procedure TFormEinstellungenDrucken.SchriftToPanelLaden(P:TPanel;s,Feld,FText:String);
//begin
  {s:=ZQueryEinstellungenDrucken.FieldByName(Feld).AsString;
  if s<>'' Then begin
    DataModuleMyOffice.FFormatNil(0);
    DataModuleMyOffice.FFormatGet(0,s);
    //if FFormat.Name <>'' Then P.Caption:=FText Else P.Caption:=FFormat.Name;
    P.Caption:=FFormat.Name;
    P.Font.Name:=FFormat.Schrift;
    P.Font.Color:=StringtoColor(FFormat.Farbe);
    P.Font.Size:=FFormat.Groesse;
    P.Font.Style:=DataModuleMyOffice.IntToStyle(FFormat.Style);
    if FFormat.Sichtbar=0 Then P.Color:=StringtoColor('clSilver') Else  P.Color:=StringtoColor('clWhite');
    if FFormat.j = 0 Then P.Alignment:=taLeftJustify;
    if FFormat.j = 1 Then P.Alignment:=taRightJustify;
    if FFormat.j = 2 Then P.Alignment:=taCenter;
    if FText <>'' Then  P.Caption:=FText;
    if FFormat.x <>0 Then P.Left:=FFormat.x;
    if FFormat.y <>0 Then P.Top:=FFormat.y;
    if FFormat.l <>0 Then P.Width:=FFormat.l;
    P.Tag:=FFormat.Rahmen;
    P.Height:=FFormat.h;
  end;}
//end;

procedure TFormEinstellungenDrucken.TabSheetKopfDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if (y < 347) and  (Source is TPanel) then begin
    Accept:=True;
    with Source as TPanel do begin
      Top:=y; Left:=x;
      ZQueryEinstellungenDrucken.edit;
      if Name='PanelLabelProjekt' Then ZQueryEinstellungenDrucken.FieldByName('LabelProjekt').AsString:=PanelToString(PanelLabelProjekt);
      if Name='PanelProjekt' Then ZQueryEinstellungenDrucken.FieldByName('Projekt').AsString:=PanelToString(PanelProjekt);
      if Name='PanelLabelBezeichnung' Then ZQueryEinstellungenDrucken.FieldByName('LabelBezeichnung').AsString:=PanelToString(PanelLabelBezeichnung);
      if Name='PanelBezeichnung' Then ZQueryEinstellungenDrucken.FieldByName('Bezeichnung').AsString:=PanelToString(PanelBezeichnung);
      if Name='PanelLabelGruppe' Then ZQueryEinstellungenDrucken.FieldByName('LabelGruppe').AsString:=PanelToString(PanelLabelGruppe);
      if Name='PanelGruppe' Then ZQueryEinstellungenDrucken.FieldByName('Gruppe').AsString:=PanelToString(PanelGruppe);
      if Name='PanelLabelAdresseKurzname' Then ZQueryEinstellungenDrucken.FieldByName('LabelAdresseKurzname').AsString:=PanelToString(PanelLabelAdresseKurzname);
      if Name='PanelAdresseKurzname' Then ZQueryEinstellungenDrucken.FieldByName('AdresseKurzname').AsString:=PanelToString(PanelAdresseKurzname);
      if Name='PanelNotiz' Then ZQueryEinstellungenDrucken.FieldByName('Notiz').AsString:=PanelToString(PanelNotiz);
      if Name='PanelAbs' Then ZQueryEinstellungenDrucken.FieldByName('Absender').AsString:=PanelToString(PanelAbs);
      if Name='PanelD_Adresse' Then ZQueryEinstellungenDrucken.FieldByName('Adresse').AsString:=PanelToString(PanelD_Adresse);
      if Name='PanelLabelModulartKlein' Then ZQueryEinstellungenDrucken.FieldByName('LabelModulartKlein').AsString:=PanelToString(PanelLabelModulartKlein);
      if Name='PanelModulartklein' Then ZQueryEinstellungenDrucken.FieldByName('Modulartklein').AsString:=PanelToString(PanelModulartklein);
      if Name='PanelLabelBearbeiter' Then ZQueryEinstellungenDrucken.FieldByName('LabelBearbeiter').AsString:=PanelToString(PanelLabelBearbeiter);
      if Name='PanelBearbeiter' Then ZQueryEinstellungenDrucken.FieldByName('Bearbeiter').AsString:=PanelToString(PanelBearbeiter);
      if Name='PanelLabelDatum' Then ZQueryEinstellungenDrucken.FieldByName('LabelDatum').AsString:=PanelToString(PanelLabelDatum);
      if Name='PanelDatum' Then ZQueryEinstellungenDrucken.FieldByName('Datum').AsString:=PanelToString(PanelDatum);
      if Name='PanelLabelTransaktionsNr' Then ZQueryEinstellungenDrucken.FieldByName('LabelTransaktionsNr').AsString:=PanelToString(PanelLabelTransaktionsNr);
      if Name='PanelTransaktionsNr' Then ZQueryEinstellungenDrucken.FieldByName('TransaktionsNr').AsString:=PanelToString(PanelTransaktionsNr);
      if Name='PanelLabelIhrZeichen' Then ZQueryEinstellungenDrucken.FieldByName('LabelIhrZeichen').AsString:=PanelToString(PanelLabelIhrZeichen);
      if Name='PanelLabelIhrZeichen' Then ZQueryEinstellungenDrucken.FieldByName('IhrZeichen').AsString:=PanelToString(PanelIhrZeichen);
      if Name='PanelModular' Then ZQueryEinstellungenDrucken.FieldByName('Titel').AsString:=PanelToString(PanelModular);
      if Name='PanelMemokopf' Then ZQueryEinstellungenDrucken.FieldByName('Memokopf').AsString:=PanelToString(PanelMemokopf);
      if Name='PanelD_KopfZeile' Then ZQueryEinstellungenDrucken.FieldByName('KopfZeile').AsString:=PanelToString(PanelD_KopfZeile);
      if Name='PanelD_Summenzeile1' Then ZQueryEinstellungenDrucken.FieldByName('Summenzeile1').AsString:=PanelToString(PanelD_Summenzeile1);
      if Name='PanelD_Summenzeile2' Then ZQueryEinstellungenDrucken.FieldByName('Summenzeile2').AsString:=PanelToString(PanelD_Summenzeile2);
      if Name='PanelD_Summenzeile3' Then ZQueryEinstellungenDrucken.FieldByName('Summenzeile3').AsString:=PanelToString(PanelD_Summenzeile3);
      if Name='PanelD_Summenzeile4' Then ZQueryEinstellungenDrucken.FieldByName('Summenzeile4').AsString:=PanelToString(PanelD_Summenzeile4);
      if Name='PanelD_MemoFuss' Then ZQueryEinstellungenDrucken.FieldByName('MemoFuss').AsString:=PanelToString(PanelD_MemoFuss);
      if Name='PanelD_FussZeile' Then ZQueryEinstellungenDrucken.FieldByName('FussZeile').AsString:=PanelToString(PanelD_FussZeile);
      if Name='PanelLabelProjekt' Then ZQueryEinstellungenDrucken.FieldByName('LabelProjekt').AsString:=PanelToString(PanelLabelProjekt);
      if Name='PanelRahmen1' Then ZQueryEinstellungenDrucken.FieldByName('Rahmen1').AsString:=PanelToString(PanelRahmen1);
      if Name='PanelRahmen2' Then ZQueryEinstellungenDrucken.FieldByName('Rahmen2').AsString:=PanelToString(PanelRahmen2);
      if Name='PanelText1' Then ZQueryEinstellungenDrucken.FieldByName('Text1').AsString:=PanelToString(PanelText1);
      if Name='PanelText2' Then ZQueryEinstellungenDrucken.FieldByName('Text2').AsString:=PanelToString(PanelText2);
      if Name='PanelText3' Then ZQueryEinstellungenDrucken.FieldByName('Text3').AsString:=PanelToString(PanelText3);
      {1 Memo.add(PanelToString(PanelLabelProjekt));
  2 Memo.add(PanelToString(PanelProjekt));
  3 Memo.add(PanelToString(PanelLabelBezeichnung));
  4 Memo.add(PanelToString(PanelBezeichnung));
  5 Memo.add(PanelToString(PanelLabelGruppe));
  6 Memo.add(PanelToString(PanelGruppe));
  7 Memo.add(PanelToString(PanelLabelAdresseKurzname));
  8 Memo.add(PanelToString(PanelAdresseKurzname));
  9 Memo.add(PanelToString(PanelNotiz));
  10 Memo.add(PanelToString(PanelAbs));
  11 Memo.add(PanelToString(PanelD_Adresse));
  12 Memo.add(PanelToString(PanelLabelModulartKlein));
  13 Memo.add(PanelToString(PanelModularNr));
  14 Memo.add(PanelToString(PanelLabelBearbeiter));
  15 Memo.add(PanelToString(PanelBearbeiter));
  16 Memo.add(PanelToString(PanelLabelDatum));
  17 Memo.add(PanelToString(PanelDatum));
  18 Memo.add(PanelToString(PanelLabelTransaktionsNr));
  19 Memo.add(PanelToString(PanelTransaktionsNr));
  20 Memo.add(PanelToString(PanelLabelIhrZeichen));
  21 Memo.add(PanelToString(PanelIhrZeichen));
  22 Memo.add(PanelToString(PanelModular));
  23 Memo.add(PanelToString(PanelMemokopf));
  24 Memo.add(PanelToString(PanelD_KopfZeile));
  25 Memo.add(PanelToString(PanelD_Summenzeile1));
  26 Memo.add(PanelToString(PanelD_Summenzeile2));
  27 Memo.add(PanelToString(PanelD_Summenzeile3));
  28 Memo.add(PanelToString(PanelD_Summenzeile4));
  29 Memo.add(PanelToString(PanelD_MemoFuss));
  30 Memo.add(PanelToString(PanelD_FussZeile));}
      ZQueryEinstellungenDrucken.Post;
      ZQueryEinstellungenDrucken.edit;
    end;
  end;
 {if (y < 347) and  (Source is TDBImage) then begin
    with Source as TDBImage do begin
      Top:=y; Left:=x;
      ZQueryEinstellungenDrucken.edit;
      if Name='DBImage1' Then ZQueryEinstellungenDrucken.FieldByName('FormatLogo').AsString:=ImageToString(DBImage1,'Dateiname');
      ZQueryEinstellungenDrucken.Post;
      ZQueryEinstellungenDrucken.edit;
    end;
  end;}
end;

procedure TFormEinstellungenDrucken.PanelLabelProjektMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('LabelProjekt').AsString;
    s:=FormFormatierung.an(s,0,'','','','LabelProjekt');
    if s<>'' then StringToPanel(PanelLabelProjekt,s,'LabelProjekt','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelProjektMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Projekt').AsString;
    s:=FormFormatierung.an(s,1,'','','','Projekt');
    if s<>'' then StringToPanel(PanelProjekt,s,'Projekt','Beispieltext');
  end;
end;

procedure TFormEinstellungenDrucken.PanelLabelBezeichnungMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('LabelBezeichnung').AsString;
    s:=FormFormatierung.an(s,0,'','','','LabelBezeichnung');
    if s<>'' then StringToPanel(PanelLabelBezeichnung,s,'LabelBezeichnung','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelBezeichnungMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Bezeichnung').AsString;
    s:=FormFormatierung.an(s,1,'','','','Bezeichnung');
    if s<>'' then StringToPanel(PanelBezeichnung,s,'Bezeichnung','Beispieltext');
  end;
end;

procedure TFormEinstellungenDrucken.PanelLabelGruppeMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('LabelGruppe').AsString;
    s:=FormFormatierung.an(s,0,'','','','LabelGruppe');
    if s<>'' then StringToPanel(PanelLabelGruppe,s,'LabelGruppe','');
  End;
end;

procedure TFormEinstellungenDrucken.PanelGruppeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Gruppe').AsString;
    s:=FormFormatierung.an(s,1,'','','','Gruppe');
    if s<>'' then StringToPanel(PanelGruppe,s,'Gruppe','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelLabelAdresseKurznameMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('LabelAdresseKurzname').AsString;
    s:=FormFormatierung.an(s,0,'','','','LabelAdresseKurzname');
    if s<>'' then StringToPanel(PanelLabelAdresseKurzname,s,'LabelAdresseKurzname','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAdresseKurznameMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('AdresseKurzname').AsString;
    s:=FormFormatierung.an(s,1,'','','','AdresseKurzname');
    if s<>'' then StringToPanel(PanelAdresseKurzname,s,'AdresseKurzname','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelNotizMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Notiz').AsString;
    s:=FormFormatierung.an(s,1,'','','','Notiz');
   if s<>'' then StringToPanel(PanelNotiz,s,'Notiz','');
 end;
end;

procedure TFormEinstellungenDrucken.PanelAbsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Absender').AsString;
    s:=FormFormatierung.an(s,0,'','','','Absender');
    if s<>'' then StringToPanel(PanelAbs,s,'Absender','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelD_AdresseMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Adresse').AsString;
    s:=FormFormatierung.an(s,1,'','','','Adresse');
    if s<>'' then StringToPanel(PanelD_Adresse,s,'Adresse','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelLabelModulartKleinMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('LabelModulartklein').AsString;
    s:=FormFormatierung.an(s,0,'','','','LabelModulartklein');
    if s<>'' then StringToPanel(PanelLabelModulartKlein,s,'LabelModulartklein','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelModulartkleinMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Modulartklein').AsString;
    s:=FormFormatierung.an(s,1,'','','','Modulartklein');
    if s<>'' then StringToPanel(PanelModulartklein,s,'Modulartklein','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelLabelBearbeiterMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('LabelBearbeiter').AsString;
    s:=FormFormatierung.an(s,0,'','','','LabelBearbeiter');
    if s<>'' then StringToPanel(PanelLabelBearbeiter,s,'LabelBearbeiter','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelBearbeiterMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Bearbeiter').AsString;
    s:=FormFormatierung.an(s,1,'','','','Bearbeiter');
    if s<>'' then StringToPanel(PanelBearbeiter,s,'Bearbeiter','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelLabelDatumMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('LabelDatum').AsString;
    s:=FormFormatierung.an(s,0,'','','','LabelDatum');
    if s<>'' then StringToPanel(PanelLabelDatum,s,'LabelDatum','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelDatumMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Datum').AsString;
    s:=FormFormatierung.an(s,1,'','','','Datum');
    if s<>'' then StringToPanel(PanelDatum,s,'Datum','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelLabelTransaktionsNrMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('LabelTransaktionsNr').AsString;
    s:=FormFormatierung.an(s,0,'','','','LabelTransaktionsNr');
    if s<>'' then StringToPanel(PanelLabelTransaktionsNr,s,'LabelTransaktionsNr','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelTransaktionsNrMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('TransaktionsNr').AsString;
    s:=FormFormatierung.an(s,1,'','','','TransaktionsNr');
    if s<>'' then StringToPanel(PanelTransaktionsNr,s,'TransaktionsNr','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelLabelIhrZeichenMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('LabelIhrZeichen').AsString;
    s:=FormFormatierung.an(s,0,'','','','LabelIhrZeichen');
    if s<>'' then StringToPanel(PanelLabelIhrZeichen,s,'LabelIhrZeichen','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelIhrZeichenMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('IhrZeichen').AsString;
    s:=FormFormatierung.an(s,1,'','','','IhrZeichen');
    if s<>'' then StringToPanel(PanelIhrZeichen,s,'IhrZeichen','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelModularMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s:String;
begin
  if Button <> mbRight then //with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Titel').AsString;
    s:=FormFormatierung.an(s,5,'"#" ist ein Platzhalter für den Modulname','oder geben Sie einen anderen Text ein','','Titel');
    if s<>'' then StringToPanel(PanelModular,s,'Titel','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelMemokopfMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s:String;
begin
  if Button <> mbRight then //with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('MemoKopf').AsString;
    s:=FormFormatierung.an(s,6,'','','','MemoKopf');
    if s<>'' then StringToPanel(PanelMemokopf,s,'MemoKopf','#');
  end;
end;

procedure TFormEinstellungenDrucken.PanelD_KopfZeileMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then //with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Kopfzeile').AsString;
    s:=FormFormatierung.an(s,5,'','','','Kopfzeile');
    if s<>'' then StringToPanel(PanelD_KopfZeile,s,'Kopfzeile','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelD_Summenzeile1MouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then //with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Summenzeile1').AsString;
    s:=FormFormatierung.an(s,5,'Summe: [Sum([QueryArtikelListe."VK_Preis"],BandMaster)] €','mögliche Variablen z.B. "VK_Preis" ist der Feldname:','oder MwSt; VK; MwStBetrag;VK_PreisPlusMwSt','Summenzeile1');
    if s<>'' then StringToPanel(PanelD_Summenzeile1,s,'Summenzeile1','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelD_Summenzeile2MouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then //with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Summenzeile2').AsString;
    s:=FormFormatierung.an(s,5,'Summe: [Sum([QueryArtikelListe."VK_Preis"],BandMaster)] €','mögliche Variablen z.B. "VK_Preis" ist der Feldname:','','Summenzeile2');
    if s<>'' then StringToPanel(PanelD_Summenzeile2,s,'Summenzeile2','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelD_Summenzeile3MouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then //with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Summenzeile3').AsString;
    s:=FormFormatierung.an(s,5,'Summe: [Sum([QueryArtikelListe."VK_Preis"],BandMaster)] €','mögliche Variablen z.B. "VK_Preis" ist der Feldname:','','Summenzeile3');
    if s<>'' then StringToPanel(PanelD_Summenzeile3,s,'Summenzeile3','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelD_Summenzeile4MouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then //with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Summenzeile4').AsString;
    s:=FormFormatierung.an(s,5,'Summe: [Sum([QueryArtikelListe."VK_Preis"],BandMaster)] €','mögliche Variablen z.B. "VK_Preis" ist der Feldname:','','Summenzeile4');
    if s<>'' then StringToPanel(PanelD_Summenzeile4,s,'Summenzeile4','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelD_MemoFussMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then //with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('MemoFuss').AsString;
    s:=FormFormatierung.an(s,5,'','','','MemoFuss');
    if s<>'' then StringToPanel(PanelD_MemoFuss,s,'MemoFuss','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelD_FussZeileMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var s:String;
begin
  if Button <> mbRight then //with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('FussZeile').AsString;
    s:=FormFormatierung.an(s,5,'mögliche Variable = [Page]','','','FussZeile');
    if s<>'' then StringToPanel(PanelD_FussZeile,s,'FussZeile','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelRahmen2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Rahmen2').AsString;
    s:=FormFormatierung.an(s,7,'','','','Rahmen2');
    if s<>'' then StringToPanel(PanelRahmen2,s,'Rahmen2','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelRahmen1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Rahmen1').AsString;
    s:=FormFormatierung.an(s,7,'','','','Rahmen1');
    if s<>'' then StringToPanel(PanelRahmen1,s,'Rahmen1','');
  end;
end;

procedure TFormEinstellungenDrucken.DBImageLogoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s:String;
begin
  //FormatLogo BmpLogo
  if Button <> mbRight then with Sender as TDBImage do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('FormatLogo').AsString;
    Glogo:=DBImageLogo.Picture.Bitmap;
    //DBImage1.Picture.Bitmap.SavetoStream(GLogo);
    s:=FormFormatierung.an(s,8,'','','','FormatLogo');
    if s<>'' then StringToImage(DBImageLogo,s,'FormatLogo','');
  end;
end;

procedure TFormEinstellungenDrucken.TabSheetlogoDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if (y < 535) and  (Source is TDBImage) then begin
    with Source as TDBImage do begin
      Top:=y; Left:=x;
      ZQueryEinstellungenDrucken.edit;
      if Name='DBImageLogo' Then ZQueryEinstellungenDrucken.FieldByName('FormatLogo').AsString:=ImageToString(DBImageLogo,'Dateiname');
      ZQueryEinstellungenDrucken.Post;
      ZQueryEinstellungenDrucken.edit;
    end;
  end;
  if (y < 535) and  (Source is TPanel) then begin
    with Source as TPanel do begin
      Top:=y;
      ZQueryEinstellungenDrucken.edit;
      if Name='PanelLogoEnde' Then ZQueryEinstellungenDrucken.FieldByName('PanelLogoEnde').Asinteger:=PanelLogoEnde.Top;
      ZQueryEinstellungenDrucken.Post;
      ZQueryEinstellungenDrucken.edit;
    End;
  end;  
end;

procedure TFormEinstellungenDrucken.PanelLogoEndeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (y < 535) and  (Sender is TPanel) then begin
    with Sender as TPanel do Begindrag(False,-1);
  end;
end;

procedure TFormEinstellungenDrucken.PanelText1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Text1').AsString;
    s:=FormFormatierung.an(s,0,'','','','Text1');
    if s<>'' then StringToPanel(PanelLabelProjekt,s,'Text1','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelText2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Text2').AsString;
    s:=FormFormatierung.an(s,0,'','','','Text2');
    if s<>'' then StringToPanel(PanelLabelProjekt,s,'Text2','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelText3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Text3').AsString;
    s:=FormFormatierung.an(s,0,'','','','Text3');
    if s<>'' then StringToPanel(PanelLabelProjekt,s,'Text3','');
  end;
end;

procedure TFormEinstellungenDrucken.ButtonDateinameClick(Sender: TObject);
begin
  OpenDialog1.Execute;
  ButtonDateiname.Caption:=OpenDialog1.FileName;
  ZQueryEinstellungenDrucken.FieldByName('Druckermaske').AsString:=OpenDialog1.FileName;
end;

procedure TFormEinstellungenDrucken.PanelALDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
if (y < 446) and  (Source is TPanel) then begin
    Accept:=True;
    with Source as TPanel do begin
      Top:=y; Left:=x;
      ZQueryEinstellungenDrucken.edit;
      if Name='PanelAL1' Then ZQueryEinstellungenDrucken.FieldByName('Feld1').AsString:=PanelToString(PanelAL1);
      if Name='PanelAL2' Then ZQueryEinstellungenDrucken.FieldByName('Feld2').AsString:=PanelToString(PanelAL2);
      if Name='PanelAL3' Then ZQueryEinstellungenDrucken.FieldByName('Feld3').AsString:=PanelToString(PanelAL3);
      if Name='PanelAL4' Then ZQueryEinstellungenDrucken.FieldByName('Feld4').AsString:=PanelToString(PanelAL4);
      if Name='PanelAL5' Then ZQueryEinstellungenDrucken.FieldByName('Feld5').AsString:=PanelToString(PanelAL5);
      if Name='PanelAL6' Then ZQueryEinstellungenDrucken.FieldByName('Feld6').AsString:=PanelToString(PanelAL6);
      if Name='PanelAL7' Then ZQueryEinstellungenDrucken.FieldByName('Feld7').AsString:=PanelToString(PanelAL7);
      if Name='PanelAL8' Then ZQueryEinstellungenDrucken.FieldByName('Feld8').AsString:=PanelToString(PanelAL8);
      if Name='PanelAL9' Then ZQueryEinstellungenDrucken.FieldByName('Feld9').AsString:=PanelToString(PanelAL9);
      if Name='PanelAL10' Then ZQueryEinstellungenDrucken.FieldByName('Feld10').AsString:=PanelToString(PanelAL10);
      if Name='PanelAL11' Then ZQueryEinstellungenDrucken.FieldByName('Feld11').AsString:=PanelToString(PanelAL11);
      if Name='PanelAL12' Then ZQueryEinstellungenDrucken.FieldByName('Feld12').AsString:=PanelToString(PanelAL12);
      if Name='PanelAL13' Then ZQueryEinstellungenDrucken.FieldByName('Feld13').AsString:=PanelToString(PanelAL13);
      if Name='PanelAL14' Then ZQueryEinstellungenDrucken.FieldByName('Feld14').AsString:=PanelToString(PanelAL14);
      if Name='PanelAL15' Then ZQueryEinstellungenDrucken.FieldByName('Feld15').AsString:=PanelToString(PanelAL15);
      if Name='PanelAL16' Then ZQueryEinstellungenDrucken.FieldByName('Feld16').AsString:=PanelToString(PanelAL16);
      if Name='PanelAL17' Then ZQueryEinstellungenDrucken.FieldByName('Feld17').AsString:=PanelToString(PanelAL17);
      if Name='PanelAL18' Then ZQueryEinstellungenDrucken.FieldByName('Feld18').AsString:=PanelToString(PanelAL18);
      if Name='PanelAL19' Then ZQueryEinstellungenDrucken.FieldByName('Feld19').AsString:=PanelToString(PanelAL19);
      if Name='PanelAL20' Then ZQueryEinstellungenDrucken.FieldByName('Feld20').AsString:=PanelToString(PanelAL20);
      if (y > 346) then begin
        if Name='PanelAL1' Then StringToPanel(PanelAL1,'0;Pos_Nr;16;368;51;0;Arial;clBlack;8;0;0;0;0;','Feld1','');
        if Name='PanelAL2' Then StringToPanel(PanelAL2,'0;Pos_Nr;80;368;51;0;Arial;clBlack;8;0;0;0;0;','Feld2','');
        if Name='PanelAL3' Then StringToPanel(PanelAL3,'0;Pos_Nr;144;368;51;0;Arial;clBlack;8;0;0;0;0;','Feld3','');
        if Name='PanelAL4' Then StringToPanel(PanelAL4,'0;Pos_Nr;208;368;51;0;Arial;clBlack;8;0;0;0;0;','Feld4','');
        if Name='PanelAL5' Then StringToPanel(PanelAL5,'0;Pos_Nr;272;368;51;0;Arial;clBlack;8;0;0;0;0;','Feld5','');
        if Name='PanelAL6' Then StringToPanel(PanelAL6,'0;Pos_Nr;336;368;51;0;Arial;clBlack;8;0;0;0;0;','Feld6','');
        if Name='PanelAL7' Then StringToPanel(PanelAL7,'0;Pos_Nr;400;368;51;0;Arial;clBlack;8;0;0;0;0;','Feld7','');
        if Name='PanelAL8' Then StringToPanel(PanelAL8,'0;Pos_Nr;464;368;51;0;Arial;clBlack;8;0;0;0;0;','Feld8','');
        if Name='PanelAL9' Then StringToPanel(PanelAL9,'0;Pos_Nr;528;368;51;0;Arial;clBlack;8;0;0;0;0;','Feld9','');
        if Name='PanelAL10' Then StringToPanel(PanelAL10,'0;Pos_Nr;592;368;51;0;Arial;clBlack;8;0;0;0;0;','Feld10','');
        if Name='PanelAL11' Then StringToPanel(PanelAL11,'0;Pos_Nr;16;408;51;0;Arial;clBlack;8;0;0;0;0;','Feld11','');
        if Name='PanelAL12' Then StringToPanel(PanelAL12,'0;Pos_Nr;80;408;51;0;Arial;clBlack;8;0;0;0;0;','Feld12','');
        if Name='PanelAL13' Then StringToPanel(PanelAL13,'0;Pos_Nr;144;408;51;0;Arial;clBlack;8;0;0;0;0;','Feld13','');
        if Name='PanelAL14' Then StringToPanel(PanelAL14,'0;Pos_Nr;208;408;51;0;Arial;clBlack;8;0;0;0;0;','Feld14','');
        if Name='PanelAL15' Then StringToPanel(PanelAL15,'0;Pos_Nr;272;408;51;0;Arial;clBlack;8;0;0;0;0;','Feld15','');
        if Name='PanelAL16' Then StringToPanel(PanelAL16,'0;Pos_Nr;336;408;51;0;Arial;clBlack;8;0;0;0;0;','Feld16','');
        if Name='PanelAL17' Then StringToPanel(PanelAL17,'0;Pos_Nr;400;408;51;0;Arial;clBlack;8;0;0;0;0;','Feld17','');
        if Name='PanelAL18' Then StringToPanel(PanelAL18,'0;Pos_Nr;464;408;51;0;Arial;clBlack;8;0;0;0;0;','Feld18','');
        if Name='PanelAL19' Then StringToPanel(PanelAL19,'0;Pos_Nr;528;408;51;0;Arial;clBlack;8;0;0;0;0;','Feld19','');
        if Name='PanelAL20' Then StringToPanel(PanelAL20,'0;Pos_Text;592;408;51;0;Arial;clBlack;8;0;0;0;0;','Feld20','');
      end;
      ZQueryEinstellungenDrucken.Post;
      ZQueryEinstellungenDrucken.edit;
    end;
  end;
end;

{Function TFormEinstellungenDrucken.PanelToString(P:TPanel):String;
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
end;}

{procedure TFormEinstellungenDrucken.StringToPanel(P:TPanel;s,Feld,FText:String);
begin
  DataModuleMyOffice.FFormatNil(0);
  DataModuleMyOffice.FFormatGet(0,s);
  ZQueryEinstellungenDrucken.Edit;
  if Feld<>'' Then begin
    ZQueryEinstellungenDrucken.FieldByName(Feld).AsString:=s;
    ZQueryEinstellungenDrucken.post;
    ZQueryEinstellungenDrucken.edit;
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
  if FFormat.x <>0 Then P.Left:=FFormat.x;
  if FFormat.y <>0 Then P.Top:=FFormat.y;
  if FFormat.l <>0 Then P.Width:=FFormat.l;
  P.Tag:=FFormat.Rahmen;
  //if P.Caption='Pos_Text' then P.Height:=80 Else P.Height:=19; 
  if (FFormat.h<> 0) Then P.Height:=FFormat.h;
end;}

procedure TFormEinstellungenDrucken.PanelAL1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld1').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld1');
    if s<>'' then StringToPanel(PanelAL1,s,'Feld1','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld2').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld2');
    if s<>'' then StringToPanel(PanelAL2,s,'Feld2','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld3').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld3');
    if s<>'' then StringToPanel(PanelAL3,s,'Feld3','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL4MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld4').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld4');
    if s<>'' then StringToPanel(PanelAL4,s,'Feld4','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL5MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld5').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld5');
    if s<>'' then StringToPanel(PanelAL5,s,'Feld5','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL6MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld6').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld6');
    if s<>'' then StringToPanel(PanelAL6,s,'Feld6','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL7MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld7').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld7');
    if s<>'' then StringToPanel(PanelAL7,s,'Feld7','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL8MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld8').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld8');
    if s<>'' then StringToPanel(PanelAL8,s,'Feld8','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL9MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld9').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld9');
    if s<>'' then StringToPanel(PanelAL9,s,'Feld9','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL10MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld10').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld10');
    if s<>'' then StringToPanel(PanelAL10,s,'Feld10','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL11MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld11').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld11');
    if s<>'' then StringToPanel(PanelAL11,s,'Feld11','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL12MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld12').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld12');
    if s<>'' then StringToPanel(PanelAL12,s,'Feld12','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL13MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld13').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld13');
    if s<>'' then StringToPanel(PanelAL13,s,'Feld13','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL14MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld14').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld14');
    if s<>'' then StringToPanel(PanelAL14,s,'Feld14','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL15MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld15').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld15');
    if s<>'' then StringToPanel(PanelAL15,s,'Feld15','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL16MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld16').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld16');
    if s<>'' then StringToPanel(PanelAL16,s,'Feld16','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL17MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld17').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld17');
    if s<>'' then StringToPanel(PanelAL17,s,'Feld17','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL18MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld18').AsString;
    s:=FormFormatierung.an(s,10,'','','','Feld18');
    if s<>'' then StringToPanel(PanelAL18,s,'Feld18','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL19MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld19').AsString;
    s:=FormFormatierung.an(s,11,'','','','Feld19=Reserviert für Stücklistenzeile');
    if s<>'' then StringToPanel(PanelAL19,s,'Feld19','');
  end;
end;

procedure TFormEinstellungenDrucken.PanelAL20MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var s:String;
begin
  if Button <> mbRight then with Sender as TPanel do Begindrag(False,-1)
  Else begin
    s:=ZQueryEinstellungenDrucken.FieldByName('Feld20').AsString;
    s:=FormFormatierung.an(s,11,'','','','Feld20=Reserviert für Pos_text');
    if s<>'' then StringToPanel(PanelAL20,s,'Feld20','');
  end;
end;

END.
