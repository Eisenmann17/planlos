unit UnitEinstellungenArtikelAussuchen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ZAbstractRODataset, ZAbstractDataset, ZDataset, ExtCtrls, StdCtrls,
  DBCtrls, Mask;

type
  TFormEinstellungenArtikelAussuchen = class(TForm)
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    Buttonabbrechen: TButton;
    ButtonOk: TButton;
    ImageTastatur: TImage;
    QueryEinstellungArtikelAussuchen: TZQuery;
    DataSource1: TDataSource;
    DBTextNr: TDBText;
    Label1: TLabel;
    DBEditBezeichnung: TDBEdit;
    DBComboBoxArtikelArt: TDBComboBox;
    DBEditUeberschrift: TDBEdit;
    DBEditSQLArtikel: TDBEdit;
    DBEditSQLGruppe: TDBEdit;
    DBCheckBoxErledigtAn_Aus: TDBCheckBox;
    DBCheckBoxMarkierenZeigen: TDBCheckBox;
    DBCheckBoxErledigtArtikelAn: TDBCheckBox;
    DBCheckBoxF2: TDBCheckBox;
    DBCheckBoxF3: TDBCheckBox;
    DBCheckBoxF5: TDBCheckBox;
    DBCheckBoxF6: TDBCheckBox;
    DBCheckBoxF8: TDBCheckBox;
    DBCheckBoxF9: TDBCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    LabelF10: TLabel;
    LabelEsc: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormEinstellungenArtikelAussuchen: TFormEinstellungenArtikelAussuchen;
  UZeiger:longint;UZeigerNeu:Boolean;
  UFocus:String;

implementation

{$R *.DFM}
uses TempForm, UnitDammiForm, UnitModule,
  UnitDB, UnitMeldefenster,UnitDataModul;
procedure TFormEinstellungenArtikelAussuchen.FormActivate(Sender: TObject);
begin
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  if QueryEinstellungArtikelAussuchen.Active then QueryEinstellungArtikelAussuchen.close;
  QueryEinstellungArtikelAussuchen.close;
  QueryEinstellungArtikelAussuchen.sql.Clear;
  QueryEinstellungArtikelAussuchen.sql.add('Select * From artikelaussuchen Where nr = '+ inttostr(UZeiger));
  //QueryKategorie.active:=True;
  try
    QueryEinstellungArtikelAussuchen.open;//Self.Query1.Edit;
  finally end;
  if UZeigerNeu=False then begin
     DBEditBezeichnung.Text:='';
  end Else begin
    DBCheckBoxErledigtAn_Aus.ValueChecked:='0';
    DBCheckBoxMarkierenZeigen.ValueChecked:='0';
    DBCheckBoxErledigtArtikelAn.ValueChecked:='0';
    DBCheckBoxF2.ValueChecked:='1';
    DBCheckBoxF3.ValueChecked:='0';
    DBCheckBoxF5.ValueChecked:='1';
    DBCheckBoxF6.ValueChecked:='1';
    DBCheckBoxF8.ValueChecked:='1';
    DBCheckBoxF9.ValueChecked:='0';
  end;
  QueryEinstellungArtikelAussuchen.Edit;
end;

procedure TFormEinstellungenArtikelAussuchen.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F10 then ButtonOKClick(Self);
end;

procedure TFormEinstellungenArtikelAussuchen.ButtonOkClick(
  Sender: TObject);
begin
  QueryEinstellungArtikelAussuchen.Post;
  FormPlanlos.Gzeiger:=QueryEinstellungArtikelAussuchen.Fields[0].Value;
  QueryEinstellungArtikelAussuchen.close;
  close;
end;

procedure TFormEinstellungenArtikelAussuchen.ButtonabbrechenClick(
  Sender: TObject);
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
        QueryEinstellungArtikelAussuchen.close;
        if (DataModuleDB.DatensatzLoeschen('artikelaussuchen',Uzeiger) = False) Then
        begin
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
        end;
      end
    else // änderung
    begin
      QueryEinstellungArtikelAussuchen.Cancel;QueryEinstellungArtikelAussuchen.close;
    end;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormEinstellungenArtikelAussuchen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

end.
