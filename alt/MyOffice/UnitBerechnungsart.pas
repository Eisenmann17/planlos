unit UnitBerechnungsart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Mask, DBCtrls;

type
  TFormBerechungsart = class(TForm)
    PanelTastatur: TPanel;
    ImageTastatur: TImage;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    ButtonSpeichern: TButton;
    Buttonabbrechen: TButton;
    LabelEsc: TLabel;
    LabelF10: TLabel;
    QueryBerechnungsart: TZQuery;
    DataSourceBerechnungsart: TDataSource;
    DBEdit1: TDBEdit;
    Memo1: TMemo;
    Label2: TLabel;
    Memo2: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonSpeichernClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormBerechungsart: TFormBerechungsart;
  UZeiger:longint;UZeigerNeu:Boolean;

implementation

uses UnitDataModul, UnitModule, UnitDB, UnitMeldefenster;

{$R *.DFM}

procedure TFormBerechungsart.ButtonabbrechenClick(Sender: TObject);
var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  if FAbbrechen then
  begin
    if UZeigerNeu then
      begin
        QueryBerechnungsart.close;
        if (DataModuleDB.DatensatzLoeschen('Berechnungsart',Uzeiger) = False) Then
        begin
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
        end;
      end
    else // änderung
    begin
      QueryBerechnungsart.Cancel;QueryBerechnungsart.close;
    end;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormBerechungsart.ButtonSpeichernClick(Sender: TObject);
begin
  QueryBerechnungsart.Post;
  FormPlanlos.Gzeiger:=QueryBerechnungsart.Fields[0].Value;
  QueryBerechnungsart.close;
  close;
end;

procedure TFormBerechungsart.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

procedure TFormBerechungsart.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F10 then ButtonSpeichernClick(Self);
end;

procedure TFormBerechungsart.FormActivate(Sender: TObject);
begin
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  if QueryBerechnungsart.Active then QueryBerechnungsart.close;
  QueryBerechnungsart.sql.Clear;
  QueryBerechnungsart.sql.add('Select * From Berechnungsart Where nr = '+ inttostr(UZeiger));
  try
    QueryBerechnungsart.open;//Self.Query1.Edit;
  finally end;
  QueryBerechnungsart.Edit;
end;

end.
