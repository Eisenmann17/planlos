unit UnitAdresse;
{Fenster 21 bis 30}
interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, ExtCtrls, Mask, Dialogs,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFormAdresse = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    EditKategorie: TDBEdit;
    EditNachname: TDBEdit;
    EditVorname: TDBEdit;
    EditTitel: TDBEdit;
    EditFirma: TDBEdit;
    EditTel_Firma: TDBEdit;
    EditTel_Privat: TDBEdit;
    EditTel_Fax: TDBEdit;
    EditTel_Andere: TDBEdit;
    EditE_Mail: TDBEdit;
    EditStrasse_Nr: TDBEdit;
    EditPLZ: TDBEdit;
    EditOrt: TDBEdit;
    EditLand: TDBEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    MemoNotiz: TDBMemo;
    MemoAdresse: TDBMemo;
    EditFrei: TDBEdit;
    EditFrei2: TDBEdit;
    EditFrei3: TDBEdit;
    EditFrei4: TDBEdit;
    DBTextNr: TDBText;
    Buttonabbrechen: TButton;
    LabelESC: TLabel;
    ButtonSuchen: TButton;
    ButtonOk: TButton;
    LabelF4: TLabel;
    LabelF10: TLabel;
    ImageTastatur: TImage;
    QueryAdresse: TZQuery;
    DataSource1: TDataSource;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF4_p: TLabel;
    LabelF10_p: TLabel;
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonSuchenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditKategorieEnter(Sender: TObject);
    procedure Focus;
  private
    { Private-Deklarationen }
  public
  end;

var
  FormAdresse: TFormAdresse;
  UZeiger:longint;UZeigerNeu:Boolean;
  UFocus:String;
implementation

{$R *.DFM}

uses TempForm, UnitDammiForm, UnitModule, UnitKategorie,
  UnitDB, UnitMeldefenster,UnitDataModul;


procedure TFormAdresse.ButtonOkClick(Sender: TObject);
begin
  QueryAdresse.Post;
  FormPlanlos.Gzeiger:=QueryAdresse.Fields[0].Value;
  QueryAdresse.close;
  close;
end;

procedure TFormAdresse.ButtonabbrechenClick(Sender: TObject);
var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then //neu abbrechen
    ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  //PanelTastatur.Color:=clGray;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  //PanelTastatur.Color:=clYellow;
  //DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
  //DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  if FAbbrechen then
    begin
      if UZeigerNeu then
       begin
        QueryAdresse.close;
        if (DataModuleDB.DatensatzLoeschen('ADRESSEN',Uzeiger) = False) Then
          begin
          //ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
          //PanelTastatur.Color:=clGray;
          //DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
          //DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
          //DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
          //PanelTastatur.Color:=clYellow;
          //ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
          end;
        //Showmessage('Datensatz konnte nicht gelöscht werden');
        end
      else // änderung  abbrechen
      begin
        QueryAdresse.Cancel;QueryAdresse.close;
      end;
    //PanelTastatur.Color:=clYellow;
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
end;


procedure TFormAdresse.ButtonSuchenClick(Sender: TObject);
 var Fnr:integer;Par:TStringList;SQLSelect,SQLFrom,SQLWhere,SQLOrder:string;
      Fname,FDatum:string;
begin
  If UFocus <> '' then
  begin
    //    PanelTastatur.Color:=clGray;
    DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
    //DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
    Par:=TStringList.Create;
    if UFocus = 'EditKategorie'then
    begin
      Par:=TForm1.an(FormKategorie,EditKategorie.text,GModulart,GBenutzer,21);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then begin
        EditKategorie.text:=Fname;
      end;
      ActiveControl:=EditNachname;
      //    PanelTastatur.Color:=clYellow;
      //ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
    end;
    //    PanelTastatur.Color:=clYellow;
    DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
    //DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  end;
end;


procedure TFormAdresse.FormActivate(Sender: TObject);
begin
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  //DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  if QueryAdresse.Active then QueryAdresse.close;
  QueryAdresse.sql.Clear;
  QueryAdresse.sql.add('Select * From Adressen Where nr = '+ inttostr(Uzeiger));
  try
    QueryAdresse.open;//Self.Query1.Edit;
  finally
  end;
  QueryAdresse.edit;
end;

procedure TFormAdresse.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F4 then ButtonsuchenClick(Self);
  if Key = VK_F10 then ButtonOKClick(Self);
end;

procedure TFormAdresse.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

procedure TFormAdresse.Focus;
begin
  If (ActiveControl.Name = EditKategorie.Name)Then
  begin
    UFocus:=ActiveControl.Name;
    Buttonsuchen.Enabled:=True;
  end
  else
  begin
    UFocus:='';
    Buttonsuchen.Enabled:=False;
  end;
end;

procedure TFormAdresse.EditKategorieEnter(Sender: TObject);
begin
  Focus;//in allen Felder aktiv
end;

end.
