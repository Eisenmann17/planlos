unit UnitArtikelgruppe;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, Mask, DBTables, ExtCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFormArtikelgruppe = class(TForm)
    DataSource1: TDataSource;
    Label3: TLabel;
    EditBerechnungsart: TDBEdit;
    EditArtikelgruppe: TDBEdit;
    Label2: TLabel;
    Label1: TLabel;
    DBTextNr: TDBText;
    DBRadioGroup1: TDBRadioGroup;
    GroupBoxVorgaben: TGroupBox;
    Label5: TLabel;
    EditAufschlag: TDBEdit;
    Label6: TLabel;
    GroupBoxzeigen: TGroupBox;
    DBEditV_Artikel: TDBEdit;
    Label4: TLabel;
    LabelV_EinheitMenge: TLabel;
    DBEditV_EinheitMenge: TDBEdit;
    Label8: TLabel;
    DBEditEinheit_EK_Preis: TDBEdit;
    Label9: TLabel;
    DBEditEKPreis: TDBEdit;
    DBCheckBoxGewicht: TDBCheckBox;
    DBCheckBoxPostext: TDBCheckBox;
    DBCheckBoxZahl2: TDBCheckBox;
    DBCheckBoxZahl1: TDBCheckBox;
    DBCheckBoxZahl3: TDBCheckBox;
    DBCheckBoxEinheitMengeSichtbar: TDBCheckBox;
    DBCheckBoxS_Lieferant: TDBCheckBox;
    ImageTastatur: TImage;
    LabelEsc: TLabel;
    Buttonabbrechen: TButton;
    Buttonsuchen: TButton;
    Buttonspeichern: TButton;
    LabelF4: TLabel;
    LabelF10: TLabel;
    LabelEinheitGewicht: TLabel;
    LabelEinheitZ1: TLabel;
    LabelEinheitZ2: TLabel;
    LabelEinheitZ3: TLabel;
    QueryArtikelgruppe: TZQuery;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBoxName1: TDBCheckBox;
    DBCheckBoxName3: TDBCheckBox;
    DBCheckBoxName2: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    Bevel1: TBevel;
    DBEditV_Lieferant: TDBEdit;
    Label7: TLabel;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF4_p: TLabel;
    LabelF10_p: TLabel;
    procedure EditArtikelgruppeEnter(Sender: TObject);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonspeichernClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonsuchenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Focus;
    procedure DBCheckBoxEinheitMengeSichtbarClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormArtikelgruppe: TFormArtikelgruppe;
  UZeiger:longint;UZeigerNeu:Boolean;
  UFocus,UArtikelgruppe:String;

implementation

uses UnitDammiForm,TempForm,UnitMeldefenster, UnitDB, UnitModule,
  UnitMaskeEinheit,UnitDataModul, UnitAdresse, UnitBerechnungsart;

{$R *.DFM}


procedure TFormArtikelgruppe.Focus;
begin
  If (ActiveControl.Name = EditBerechnungsart.Name) or
     (ActiveControl.Name = DBEditV_EinheitMenge.Name) or
     (ActiveControl.Name = DBEditV_Lieferant.Name) or
     (ActiveControl.Name = DBEditEinheit_EK_Preis.Name)  Then
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
procedure TFormArtikelgruppe.EditArtikelgruppeEnter(Sender: TObject);
begin
  Focus;
end;

procedure TFormArtikelgruppe.ButtonabbrechenClick(Sender: TObject);
  var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then  ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  //  PanelTastatur.Color:=clGray;
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  //PanelTastatur.Color:=clYellow;
  if FAbbrechen then
  begin
    if UZeigerNeu then
      begin
        QueryArtikelgruppe.close;
        if (DataModuleDB.DatensatzLoeschen('Artikelgruppe',Uzeiger) = False) Then
        begin
          //PanelTastatur.Color:=clGray;
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
          //PanelTastatur.Color:=clYellow;
        end;
      end
    else // änderung
    begin
      QueryArtikelgruppe.Cancel;QueryArtikelgruppe.close;
    end;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormArtikelgruppe.ButtonspeichernClick(Sender: TObject);
var FUmbenennten:Boolean;
     I:integer;
begin
  QueryArtikelgruppe.Post;
  if (UArtikelgruppe<>EditArtikelgruppe.Text) and (UArtikelgruppe<>'') and (UZeigerNeu <>True)  then begin
    DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
    FUmbenennten:= Meldefenster.an(1,'sollen alle Artikel mit der Arikelgruppe "'+UArtikelgruppe+'"','in die Artikelgruppe "'+EditArtikelgruppe.Text+'"'+ ' umbennant werden?','Achtung' );
    if FUmbenennten Then begin
      If DataModuleMyOffice.ZQueryArtikel.active = True Then DataModuleMyOffice.ZQueryArtikel.Close;
      DataModuleMyOffice.ZQueryArtikel.sql.Clear;
      DataModuleMyOffice.ZQueryArtikel.sql.add('Select * From Artikel Where Artikelgruppe = "'+UArtikelgruppe+'"');
      try DataModuleMyOffice.ZQueryArtikel.open;finally end;
      DataModuleMyOffice.ZQueryArtikel.first;
      for I:=0 to DataModuleMyOffice.ZQueryArtikel.RecordCount-1 do begin
        DataModuleMyOffice.ZQueryArtikel.edit;
        DataModuleMyOffice.ZQueryArtikel.FieldByName('Artikelgruppe').AsString:=EditArtikelgruppe.Text;
        DataModuleMyOffice.ZQueryArtikel.post;
        DataModuleMyOffice.ZQueryArtikel.next;
      end;
      DataModuleMyOffice.ZQueryArtikel.close;
    end;
    DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  end;
  FormPlanlos.Gzeiger:=QueryArtikelgruppe.Fields[0].Value;
  QueryArtikelgruppe.close;
  close;
end;

procedure TFormArtikelgruppe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F4 then ButtonsuchenClick(Self);
  if Key = VK_F10 then ButtonspeichernClick(Self);
end;

procedure TFormArtikelgruppe.ButtonsuchenClick(Sender: TObject);
var Fnr:integer;Fname,FDatum:string;Par:TStringList;
begin
  If UFocus <> '' then
  begin
    //PanelTastatur.Color:=clGray;
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
    DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
    Par:=TStringList.Create;
    if UFocus = 'DBEditV_Lieferant'then begin
      Par:=TForm1.an(FormAdresse,DBEditV_Lieferant.text,GModulart,GBenutzer,64);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then DBEditV_Lieferant.text:=Fname;
      ActiveControl:=DBCheckBoxGewicht;
    end;
    if UFocus = 'DBEditEinheit_EK_Preis'then begin
      Par:=TForm1.an(FormEinheit,DBEditEinheit_EK_Preis.text,GModulart,GBenutzer,63);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then DBEditEinheit_EK_Preis.text:=Fname;
      ActiveControl:=EditAufschlag;
    end;
    if UFocus = 'DBEditV_EinheitMenge'then begin
      Par:=TForm1.an(FormEinheit,DBEditV_EinheitMenge.text,GModulart,GBenutzer,62);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then DBEditV_EinheitMenge.text:=Fname;
      ActiveControl:=DBEditEKPreis;
    end;
    if UFocus = 'EditBerechnungsart' then begin
      Par:=TForm1.an(FormBerechungsart,EditBerechnungsart.text,GModulart,GBenutzer,61);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then EditBerechnungsart.text:=Fname;
      ActiveControl:=DBRadioGroup1;
    end;
    //    PanelTastatur.Color:=clYellow;
    DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  end;
end;

procedure TFormArtikelgruppe.FormActivate(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelESC_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  if QueryArtikelgruppe.Active then QueryArtikelgruppe.close;
  QueryArtikelgruppe.sql.Clear;
  QueryArtikelgruppe.sql.add('Select * From Artikelgruppe Where nr = '+ inttostr(Uzeiger));
  try
    QueryArtikelgruppe.open;//Self.Query1.Edit;
  finally
  end;
  QueryArtikelgruppe.edit;
  //if UZeigerNeu = False Then {QueryArtikel.FieldByName('LetzteBearbeitung').AsString := Datetostr(Now)};
  DBCheckBoxZahl1.Caption:=GZahl1;
  DBCheckBoxZahl2.Caption:=GZahl2;
  DBCheckBoxZahl3.Caption:=GZahl3;
  LabelEinheitGewicht.Caption:=GEinheitGewicht;
  LabelEinheitZ1.Caption:=GEinheitZahl1;
  LabelEinheitZ2.Caption:=GEinheitZahl2;
  LabelEinheitZ3.Caption:=GEinheitZahl3;
  DBCheckBoxName1.Caption:=GName1;
  DBCheckBoxName2.Caption:=GName2;
  DBCheckBoxName3.Caption:=GName3;
  If  UZeigerNeu then
  begin
    DBCheckBoxZahl1.Checked:=False;
    DBCheckBoxZahl2.Checked:=False;
    DBCheckBoxZahl3.Checked:=False;
    DBCheckBoxEinheitMengeSichtbar.Checked:=True;
    DBCheckBoxPostext.Checked:=False;
    DBCheckBoxGewicht.Checked:=False;
    DBCheckBoxS_Lieferant.Checked:=False;
    UArtikelgruppe:='';
  end
  Else UArtikelgruppe:=EditArtikelgruppe.Text;
  if DBCheckBoxEinheitMengeSichtbar.Checked then begin
    DBEditV_EinheitMenge.Visible:=False;
    LabelV_EinheitMenge.Visible:=False;
  end
  Else begin
    DBEditV_EinheitMenge.Visible:=True;
    LabelV_EinheitMenge.Visible:=True;
  End;
end;

procedure TFormArtikelgruppe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

procedure TFormArtikelgruppe.DBCheckBoxEinheitMengeSichtbarClick(
  Sender: TObject);
begin
  if  DBCheckBoxEinheitMengeSichtbar.Checked = True then
  begin
    LabelV_EinheitMenge.Visible:=False;
    DBEditV_EinheitMenge.Visible:=False;
  end else begin
    LabelV_EinheitMenge.Visible:=True;
    DBEditV_EinheitMenge.Visible:=True;
  end;
end;

end.
