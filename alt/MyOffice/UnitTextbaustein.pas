unit UnitTextbaustein;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,  Dialogs,
  StdCtrls, Forms, DBCtrls, DB, Mask, DBTables, ExtCtrls, ComCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFormTextbaustein = class(TForm)
    DataSource1: TDataSource;
    Label1: TLabel;
    EditNr: TDBEdit;
    Label2: TLabel;
    EditModulart: TDBEdit;
    Label3: TLabel;
    EditBenutzer: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBEditBeschreibung: TDBEdit;
    Label6: TLabel;
    DBComboBoxTextart: TDBComboBox;
    DBRiImageTextbaustein: TDBMemo;
    Buttonabbrechen: TButton;
    Buttonsuchen: TButton;
    LabelEsc: TLabel;
    Buttonspeichern: TButton;
    LabelF4: TLabel;
    LabelF10: TLabel;
    ImageTastatur: TImage;
    QueryTextbaustein: TZQuery;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF4_p: TLabel;
    LabelF10_p: TLabel;
    procedure ButtonspeichernClick(Sender: TObject);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Focus;
    procedure EditModulartEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonsuchenClick(Sender: TObject);
    procedure DBRiImageTextbausteinExit(Sender: TObject);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormTextbaustein: TFormTextbaustein;
  UZeiger:longint;UZeigerNeu:Boolean;
  UFocus:String;
implementation

uses UnitDammiForm,UnitModule, UnitMeldefenster, UnitDB,TempForm,UnitDataModul;

{$R *.DFM}


procedure TFormTextbaustein.ButtonspeichernClick(Sender: TObject);
begin
   If DBEditBeschreibung.EditText = '' then   QueryTextbaustein.FieldByName('Beschreibung').AsString:=DBRiImageTextbaustein.lines[0];
   QueryTextbaustein.Post;
   FormPlanlos.Gzeiger:=QueryTextbaustein.Fields[0].Value;
   QueryTextbaustein.close;
   close;
end;

procedure TFormTextbaustein.ButtonabbrechenClick(Sender: TObject);
var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then  ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  //PanelTastatur.Color:=clGray;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  //PanelTastatur.Color:=clYellow;
  if FAbbrechen then
  begin
    if UZeigerNeu then
      begin
        QueryTextbaustein.close;
        if (DataModuleDB.DatensatzLoeschen('Textbaustein',Uzeiger) = False) Then
        begin
          //PanelTastatur.Color:=clGray;
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
          //PanelTastatur.Color:=clYellow;
        end;
      end
    else // änderung
    begin
      QueryTextbaustein.Cancel;QueryTextbaustein.close;
    end;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormTextbaustein.FormActivate(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  If GKopfFusstext <> '' Then DBComboBoxTextart.Enabled := False Else DBComboBoxTextart.Enabled:=True;
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  if QueryTextbaustein.Active then QueryTextbaustein.close;
  QueryTextbaustein.sql.Clear;
  QueryTextbaustein.sql.add('Select * From Textbaustein Where nr = '+ inttostr(Uzeiger));
  try
    QueryTextbaustein.open;//Self.Query1.Edit;
  finally
  end;
  QueryTextbaustein.edit;
  if UZeigerNeu = True Then
  begin
    if GModulart ='' then
      QueryTextbaustein.FieldByName('Modulart').AsString :='Standard'
    else
      QueryTextbaustein.FieldByName('Modulart').AsString := GModulart;
    QueryTextbaustein.FieldByName('Benutzer').AsString := GBenutzer;
    QueryTextbaustein.FieldByName('Textart').AsString := GKopfFusstext;
  end;
end;

procedure TFormTextbaustein.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GKopfFusstext:='';
  if QueryTextbaustein.Active = False then QueryTextbaustein.close;
  GOffeneFenster:=GOffeneFenster-1;
end;

procedure TFormTextbaustein.Focus;
begin
  If (ActiveControl.Name = EditModulart.Name) or
     (ActiveControl.Name = EditBenutzer.Name) Then
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

procedure TFormTextbaustein.EditModulartEnter(Sender: TObject);
begin
  Focus;
end;

procedure TFormTextbaustein.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F4 then ButtonsuchenClick(Self);
  if Key = VK_F10 then ButtonspeichernClick(Self);
end;

procedure TFormTextbaustein.ButtonsuchenClick(Sender: TObject);
var Fnr:integer;Fname,FDatum:string;Par:TStringList;
begin
  If UFocus <> '' then
  begin
    //PanelTastatur.Color:=clGray;
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
    DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
    Par:=TStringList.Create;
    if UFocus = 'EditModulart'then begin
      Par:=TForm1.an(DammiForm,EditModulart.text,GModulart,GBenutzer,121);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then EditModulart.text:=Fname;
      //ActiveControl:=DBMemoNotiz;
    end;
    if UFocus = 'EditBenutzer'then begin
      Par:=TForm1.an(DammiForm,EditBenutzer.text,GModulart,GBenutzer,122);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then EditBenutzer.text:=Fname;
      //ActiveControl:=DBEditBeartbeiter;
    end;
    //PanelTastatur.Color:=clYellow;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormTextbaustein.DBRiImageTextbausteinExit(Sender: TObject);
begin

  If DBEditBeschreibung.EditText = '' then   QueryTextbaustein.FieldByName('Beschreibung').AsString:=DBRiImageTextbaustein.lines[0];

end;

end.