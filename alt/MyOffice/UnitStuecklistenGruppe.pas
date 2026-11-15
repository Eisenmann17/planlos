unit UnitStuecklistenGruppe;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, Mask, DBTables, ExtCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFormStuecklistengruppe = class(TForm)
    DataSource1: TDataSource;
    Label2: TLabel;
    EditStuecklistenGruppe: TDBEdit;
    LabelEsc: TLabel;
    Buttonabbrechen: TButton;
    Buttonspeichern: TButton;
    LabelF10: TLabel;
    ImageTastatur: TImage;
    QueryStuecklistengruppe: TZQuery;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonspeichernClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormStuecklistengruppe: TFormStuecklistengruppe;
  UZeiger:longint;UZeigerNeu:Boolean;

implementation

uses UnitMeldefenster, UnitDB, UnitModule,UnitDataModul;

{$R *.DFM}


procedure TFormStuecklistengruppe.ButtonabbrechenClick(Sender: TObject);
  var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  //PanelTastatur.Color:=clGray;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  //PanelTastatur.Color:=clYellow;
  if FAbbrechen then
  begin
    if UZeigerNeu then
      begin
        QueryStuecklistengruppe.close;
        if (DataModuleDB.DatensatzLoeschen('Stuecklistengruppe',Uzeiger) = False) Then
        begin
          //PanelTastatur.Color:=clGray;
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
          //PanelTastatur.Color:=clYellow;
        end;
      end
    else // änderung
    begin
      QueryStuecklistengruppe.Cancel;QueryStuecklistengruppe.close;
    end;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormStuecklistengruppe.ButtonspeichernClick(Sender: TObject);
begin
  QueryStuecklistengruppe.Post;
  FormPlanlos.Gzeiger:=QueryStuecklistengruppe.Fields[0].Value;
  QueryStuecklistengruppe.close;
  close;
end;

procedure TFormStuecklistengruppe.FormActivate(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  if QueryStuecklistengruppe.Active then QueryStuecklistengruppe.close;
  QueryStuecklistengruppe.sql.Clear;
  QueryStuecklistengruppe.sql.add('Select * From Stuecklistengruppe Where nr = '+ inttostr(Uzeiger));
  try
    QueryStuecklistengruppe.open;//Self.Query1.Edit;
  finally
  end;
  QueryStuecklistengruppe.edit;
  //if UZeigerNeu = False Then
end;

procedure TFormStuecklistengruppe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

procedure TFormStuecklistengruppe.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F10 then ButtonSpeichernClick(Self);
end;

end.