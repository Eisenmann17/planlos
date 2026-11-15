unit UnitEinstellungForm1;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, ExtCtrls, Mask, DBTables, Dialogs,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFormEinstellungForm1 = class(TForm)
    DataSource1: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    EditModulart: TDBEdit;
    EditBenutzer: TDBEdit;
    EditFensterNr: TDBEdit;
    EditBeschreibung: TDBEdit;
    EditSQLSelect: TDBEdit;
    EditSQLWhere: TDBEdit;
    EditSQLOrder: TDBEdit;
    EditSQLWhereZusatz: TDBEdit;
    CheckBoxNeuAn: TDBCheckBox;
    CheckBoxKopierenAn: TDBCheckBox;
    CheckBoxAendernA: TDBCheckBox;
    CheckBoxLoeschenAn: TDBCheckBox;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    GroupBox1: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    EditErsteSpalteBreite: TDBEdit;
    EditFensterTop: TDBEdit;
    EditFensterLeft: TDBEdit;
    EditFensterWidth: TDBEdit;
    EditFensterHoehe: TDBEdit;
    Label12: TLabel;
    EditCaption: TDBEdit;
    ButtonFensterSollgroesse: TButton;
    DBTextNr: TDBText;
    Label7: TLabel;
    Label6: TLabel;
    Label24: TLabel;
    LabelWennNeuFelder: TLabel;
    LabelValueWennNeu: TLabel;
    DBEditFelderWennNeu: TDBEdit;
    DBEditValueWennNeu: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBComboBox1: TDBComboBox;
    Label22: TLabel;
    EditRckgabespalte: TDBEdit;
    Label23: TLabel;
    EditRckgabespalte2: TDBEdit;
    QueryEinstellungForm1: TZQuery;
    DBRadioGroup1: TDBRadioGroup;
    LabelF6_p: TLabel;
    LabelF7_p: TLabel;
    LabelF10_p: TLabel;
    LabelEsc: TLabel;
    LabelF6: TLabel;
    LabelF7: TLabel;
    LabelF10: TLabel;
    ButtonEsc: TButton;
    ButtonFensterGroesse: TButton;
    ButtonStandard: TButton;
    ButtonF10: TButton;
    ImageTastatur: TImage;
    procedure ButtonEscClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ButtonF10Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonFensterGroesseClick(Sender: TObject);
    procedure ButtonFensterSollgroesseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonStandardClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormEinstellungForm1: TFormEinstellungForm1;
  UDatensatzNr:longint;UModulart,UBenutzer,UStatus:String;
  UGespeichert:Boolean;
  Utop,Uleft,Uwidth,Uheight:integer;
  UZeiger:longint;UZeigerNeu:Boolean;


implementation

uses UnitMeldefenster, UnitDB, UnitModule,UnitDataModul;

{$R *.DFM}


procedure TFormEinstellungForm1.ButtonEscClick(Sender: TObject);
var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  //PanelTastatur.Color:=clGray;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF6,LabelF7,LabelF10,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelEsc_p,LabelF6_p,LabelF7_p,LabelF10_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,FormPlanlos.GCB);
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  //PanelTastatur.Color:=clYellow;
  if FAbbrechen then
    begin
      if UZeigerNeu then
       begin
        QueryEinstellungForm1.close;
        if (DataModuleDB.DatensatzLoeschen('EinstellungForm1',Uzeiger) = False) Then
          begin
          //PanelTastatur.Color:=clGray;
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
          //PanelTastatur.Color:=clYellow;
          end;
        //Showmessage('Datensatz konnte nicht gelöscht werden');
        end
      else // änderung  abbrechen
      begin
        QueryEinstellungForm1.Cancel;QueryEinstellungForm1.close;
      end;
    //PanelTastatur.Color:=clYellow;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF6,LabelF7,LabelF10,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelEsc_p,LabelF6_p,LabelF7_p,LabelF10_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,FormPlanlos.GCB);
end;


procedure TFormEinstellungForm1.FormActivate(Sender: TObject);
begin
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF6,LabelF7,LabelF10,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelEsc_p,LabelF6_p,LabelF7_p,LabelF10_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,FormPlanlos.GCB);
  if QueryEinstellungForm1.Active then QueryEinstellungForm1.close;
  QueryEinstellungForm1.sql.Clear;
  QueryEinstellungForm1.sql.add('Select * From EinstellungForm1 Where nr = '+ inttostr(Uzeiger));
  try
    QueryEinstellungForm1.open;//Self.Query1.Edit;
  finally
  end;
  //if UZeigerNeu then ButtonStandardClick(Self);
  QueryEinstellungForm1.edit;
  if UZeigerNeu then ButtonStandardClick(Self);
end;


{with QueryEinstellungForm1 do
  begin
    if   UStatus='Ändern' Then //eingang aendern
    begin
      ButtonFensterGroesse.Caption:='Maße vom Listfenster eintragen';
      close;
      SQL.Clear;
      SQL.Add('Select * FROM EinstellungForm1 WHERE Nr = ' + inttostr(UDatensatzNr));
      //ShowMessage(sql.text);
      try
        Open;
      except
      end;
      //edit;
      InDenPufferKopieren(1);
      edit;
    end
    else //eingang über neu
    begin
      ButtonFensterGroesse.Caption:='Maße vom Einstelungsfenster eintragen';
      close;
      SQL.Clear;
      SQL.Add('INSERT INTO "EinstellungForm1" (FensterNr, Modulart, Benutzer) VALUES ( "'+inttostr((UDatensatzNr))+'" , "'+UModulart+'" , "'+ UBenutzer+'")');
      try
        ExecSQL;
      except
      end;
      //post;
      UDatensatzNr:=strtoint(Fields[0].AsString);
      close;
      SQL.Clear;
      SQL.Add('Select * FROM EinstellungForm1 WHERE Nr = ' + inttostr(UDatensatzNr));
      ShowMessage(sql.text);
      try
        Open;
      except
      end;
      edit;
    end;
  end; //end if
end;}

procedure TFormEinstellungForm1.ButtonF10Click(Sender: TObject);
begin
  if EditBeschreibung.Text='' then EditBeschreibung.Text:=EditCaption.Text;
  QueryEinstellungForm1.post;
  FormPlanlos.Gzeiger:=QueryEinstellungForm1.Fields[0].Value;
  QueryEinstellungForm1.close;
  close;
end;

procedure TFormEinstellungForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonEscClick(Self);
  if Key = VK_F10 then ButtonF10Click(Self);
  if Key = VK_F6 then ButtonFensterGroesseClick(Self);
  if Key = VK_F9 then ButtonFensterSollgroesseClick(Self);
  if Key = VK_F7 then ButtonStandardClick(Self);
end;

procedure TFormEinstellungForm1.ButtonFensterGroesseClick(Sender: TObject);
begin
  QueryEinstellungForm1.edit;
  EditFensterHoehe.text:=inttostr(Height);
  EditFensterWidth.text:=inttostr(Width);
  EditFensterLeft.text:=inttostr(Left);
  EditFensterTop.text:=inttostr(Top);
end;

procedure TFormEinstellungForm1.ButtonFensterSollgroesseClick(
  Sender: TObject);
begin
  FormEinstellungForm1.Height:=649;
  FormEinstellungForm1.Width:=443;
  FormEinstellungForm1.Left:=301;
  FormEinstellungForm1.Top:=21;
end;


procedure TFormEinstellungForm1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    GOffeneFenster:=GOffeneFenster-1;
end;

procedure TFormEinstellungForm1.ButtonStandardClick(Sender: TObject);
begin
  EditModulart.Text:='Standard';
  EditBenutzer.Text:='Standard';
  EditSQLSelect.Text:='*';
  EditSQLWhere.Text:='Aus';
  EditSQLOrder.Text:='Nr';
  DBCheckBox1.Checked:=False;
  CheckBoxNeuAn.Checked:=False;
  CheckBoxAendernA.Checked:=False;
  CheckBoxKopierenAn.Checked:=False;
  CheckBoxLoeschenAn.Checked:=False;
  EditFensterHoehe.text:='540';
  EditFensterWidth.text:='691';
  EditFensterLeft.text:='0';
  EditFensterTop.text:='0';
  EditErsteSpalteBreite.text:='2';
  EditRckgabespalte.text:='0';
  EditRckgabespalte2.text:='1';
end;

end.
