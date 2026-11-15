unit UnitMaskeProjekt;
{Fenster 11 bis 20}
interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,Dialogs,
  StdCtrls, Forms, DBCtrls, DB, DBTables, Mask, ExtCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFormProjekte = class(TForm)
    DataSource1: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    DBTextNr: TDBText;
    DBEditBezeichnung: TDBEdit;
    DBEditKunde: TDBEdit;
    DBEditErfassungsdatum: TDBEdit;
    DBEditLeiter: TDBEdit;
    DBEditBeartbeiter: TDBEdit;
    DBMemoNotiz: TDBMemo;
    DBEditLetzteBearbeitung: TDBEdit;
    LabelEsc: TLabel;
    Buttonabbrechen: TButton;
    Buttonsuchen: TButton;
    ButtonOK: TButton;
    LabelF4: TLabel;
    LabelF10: TLabel;
    ImageTastatur: TImage;
    QueryModulProjekt: TZQuery;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF4_p: TLabel;
    LabelF10_p: TLabel;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonsuchenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Focus;
    procedure DBEditBezeichnungEnter(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormProjekte: TFormProjekte;
  UZeiger:longint;UZeigerNeu:Boolean;
  UFocus:String;

implementation

uses UnitDammiForm, UnitDatum,TempForm, UnitModule, UnitAdresse,
  UnitMeldefenster, UnitDB, UnitDataModul;

//uses UnitModule, UnitDammiForm,TempForm, UnitDatum;

{$R *.DFM}



procedure TFormProjekte.ButtonOKClick(Sender: TObject);
begin
  QueryModulProjekt.Post;
  FormPlanlos.Gzeiger:=QueryModulProjekt.Fields[0].Value;
  QueryModulProjekt.close;
  close;
end;

procedure TFormProjekte.ButtonabbrechenClick(Sender: TObject);
var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  //DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  //DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
  if FAbbrechen then
  begin
    if UZeigerNeu then
      begin
        QueryModulProjekt.close;
        if (DataModuleDB.DatensatzLoeschen('Module',Uzeiger) = False) Then
        begin
          //DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
          //DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
        end;
      end
    else // änderung
    begin
      QueryModulProjekt.Cancel;QueryModulProjekt.close;
    end;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
end;

procedure TFormProjekte.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F4 then ButtonsuchenClick(Self);
  if Key = VK_F10 then ButtonOKClick(Self);
end;

procedure TFormProjekte.ButtonsuchenClick(Sender: TObject);
var Fnr:integer;Fname,FDatum:string;Par:TStringList;
begin
  If UFocus <> '' then
  begin
    DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
    //DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
    Par:=TStringList.Create;
    if UFocus = 'DBEditBeartbeiter'then begin
      Par:=TForm1.an(FormAdresse,DBEditBeartbeiter.text,GModulart,GBenutzer,13);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then DBEditBeartbeiter.text:=Fname;
      //ActiveControl:=DBMemoNotiz;
    end;
    if UFocus = 'DBEditLeiter'then begin
      Par:=TForm1.an(FormAdresse,DBEditLeiter.text,GModulart,GBenutzer,12);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then DBEditLeiter.text:=Fname;
      //ActiveControl:=DBEditBeartbeiter;
    end;
    if UFocus = 'DBEditKunde'then begin
      Par:=TForm1.an(FormAdresse,DBEditKunde.text,GModulart,GBenutzer,11);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then DBEditKunde.text:=Fname;
      //ActiveControl:=DBEditLeiter;
    end;
    if UFocus = 'DBEditErfassungsdatum' then begin
      FDatum:=FormDatum.an(DBEditErfassungsdatum.Text,Left + 80,Top);
      if FDatum <> '' then DBEditErfassungsdatum.text:=FDatum;
      //ActiveControl:=DBEditBezeichnung;
    end;
    if UFocus = 'DBEditLetzteBearbeitung' then begin
      FDatum:=FormDatum.an(DBEditLetzteBearbeitung.Text,Left + 80,Top);
      if FDatum <> '' then DBEditLetzteBearbeitung.text:=FDatum;
      //ActiveControl:=DBEditBezeichnung;
    end;
    //DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
    DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  end;
end;


procedure TFormProjekte.FormActivate(Sender: TObject);
begin
  //DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  if QueryModulProjekt.Active then QueryModulProjekt.close;
  QueryModulProjekt.sql.Clear;
  QueryModulProjekt.sql.add('Select * From Module Where nr = '+ inttostr(Uzeiger));
  try
    QueryModulProjekt.open;//Self.Query1.Edit;
  finally
  end;
  QueryModulProjekt.edit;
  if UZeigerNeu = False Then QueryModulProjekt.FieldByName('LetzteBearbeitung').AsString := Datetostr(Now);
  if UZeigerNeu = True Then
  begin
    QueryModulProjekt.FieldByName('LetzteBearbeitung').AsString := Datetostr(Now);
    QueryModulProjekt.FieldByName('Erfassungsdatum').AsString := Datetostr(Now);
  end;
end;


procedure TFormProjekte.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
GOffeneFenster:=GOffeneFenster-1;
end;

procedure TFormProjekte.Focus;
begin
  If (ActiveControl.Name = DBEditKunde.Name) or
     (ActiveControl.Name = DBEditLeiter.Name) or
     (ActiveControl.Name = DBEditBeartbeiter.Name) or
     (ActiveControl.Name = DBEditLetzteBearbeitung.Name) or
     (ActiveControl.Name = DBEditErfassungsdatum.Name) Then
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

procedure TFormProjekte.DBEditBezeichnungEnter(Sender: TObject);
begin
  Focus;//wird von allen Felder belegt
end;

end.
