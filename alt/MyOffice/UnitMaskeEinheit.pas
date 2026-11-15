unit UnitMaskeEinheit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Db, DBTables, ExtCtrls, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TFormEinheit = class(TForm)
    Label1Einheit: TLabel;
    DataSource1: TDataSource;
    DBEditEinheit: TDBEdit;
    DBTextNr: TDBText;
    LabelEsc: TLabel;
    Buttonabbrechen: TButton;
    ButtonSpeichern: TButton;
    LabelF10: TLabel;
    ImageTastatur: TImage;
    QueryEinheit: TZQuery;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonSpeichernClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormEinheit: TFormEinheit;
  UZeiger:longint;UZeigerNeu:Boolean;

implementation

uses UnitModule, UnitMeldefenster, UnitDB,UnitDataModul;

{$R *.DFM}
procedure TFormEinheit.FormActivate(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  if QueryEinheit.Active then QueryEinheit.close;
  QueryEinheit.close;
  QueryEinheit.sql.Clear;
  QueryEinheit.sql.add('Select * From Einheit Where nr = '+ inttostr(UZeiger));
  //QueryKategorie.active:=True;
  try
    QueryEinheit.open;//Self.Query1.Edit;
  finally end;
  QueryEinheit.Edit;
end;

procedure TFormEinheit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F10 then ButtonSpeichernClick(Self);
end;

procedure TFormEinheit.ButtonabbrechenClick(Sender: TObject);
var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  //PanelTastatur.Color:=clGray;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  //PanelTastatur.Color:=clYellow;
  if FAbbrechen then
  begin
    if UZeigerNeu then
      begin
        QueryEinheit.close;
        if (DataModuleDB.DatensatzLoeschen('Einheit',Uzeiger) = False) Then
        begin
         // PanelTastatur.Color:=clGray;
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
         // PanelTastatur.Color:=clYellow;
        end;
      end
    else // änderung
    begin
      QueryEinheit.Cancel;QueryEinheit.close;
    end;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormEinheit.ButtonSpeichernClick(Sender: TObject);
begin
  QueryEinheit.Post;
  FormPlanlos.Gzeiger:=QueryEinheit.Fields[0].Value;
  QueryEinheit.close;
  close;
end;

procedure TFormEinheit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

end.
