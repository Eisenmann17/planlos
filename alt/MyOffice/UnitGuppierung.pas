unit UnitGuppierung;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Db, DBTables, ExtCtrls, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TFormGruppierung = class(TForm)
    DataSource1: TDataSource;
    DBEditGruppe: TDBEdit;
    LabelGruppe: TLabel;
    Buttonabbrechen: TButton;
    Buttonspeichern: TButton;
    LabelEsc: TLabel;
    LabelF10: TLabel;
    ImageTastatur: TImage;
    QueryGruppierung: TZQuery;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonspeichernClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormGruppierung: TFormGruppierung;
  UZeiger:longint;UZeigerNeu:Boolean;

implementation

uses UnitModule, UnitMeldefenster, UnitDB,UnitDataModul;

{$R *.DFM}

procedure TFormGruppierung.FormActivate(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  if QueryGruppierung.Active then QueryGruppierung.close;
  QueryGruppierung.close;
  QueryGruppierung.sql.Clear;
  QueryGruppierung.sql.add('Select * From Gruppierung Where nr = '+ inttostr(UZeiger));
  //QueryKategorie.active:=True;
  try
    QueryGruppierung.open;//Self.Query1.Edit;
  finally end;
  QueryGruppierung.Edit;
end;

procedure TFormGruppierung.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F10 then ButtonSpeichernClick(Self);
end;

procedure TFormGruppierung.ButtonabbrechenClick(Sender: TObject);

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
        QueryGruppierung.close;
        if (DataModuleDB.DatensatzLoeschen('Gruppierung',Uzeiger) = False) Then
        begin
          //PanelTastatur.Color:=clGray;
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
          //PanelTastatur.Color:=clYellow;
        end;
      end
    else // änderung
    begin
      QueryGruppierung.Cancel;QueryGruppierung.close;
    end;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;


procedure TFormGruppierung.ButtonspeichernClick(Sender: TObject);
begin
  QueryGruppierung.Post;
  FormPlanlos.Gzeiger:=QueryGruppierung.Fields[0].Value;
  QueryGruppierung.close;
  close;
end;

procedure TFormGruppierung.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

end.
