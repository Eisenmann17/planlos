unit TempForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, Grids, DBGrids, StdCtrls, ExtCtrls, Menus,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TForm1 = class(TForm)
    ButtonZurueck: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ButtonAendern: TButton;
    ButtonNeu: TButton;
    ButtonAusgabe: TButton;
    ButtonSortieren: TButton;
    ButtonLoeschen: TButton;
    ButtonEnter: TButton;
    LabelEsc: TLabel;
    LabelF2: TLabel;
    LabelF3: TLabel;
    LabelF6: TLabel;
    LabelF7: TLabel;
    LabelF8: TLabel;
    LabelEnter: TLabel;
    ButtonKopieren: TButton;
    LabelF5: TLabel;
    LabelDatensatzinfo: TLabel;
    LabelSortiert: TLabel;
    EditZeiger: TEdit;
    ButtonFilter: TButton;
    LabelF9: TLabel;
    LabelFilter: TLabel;
    BevelDatensatzinfo: TBevel;
    BevelSortieren: TBevel;
    BevelFilter: TBevel;
    PopupMenuSuchen: TPopupMenu;
    PopupMenuSortieren: TPopupMenu;
    PopupMenuFilter: TPopupMenu;
    ImageTastatur: TImage;
    Query1: TZQuery;
    PanelTastatur: TPanel;
    LabelESC_P: TLabel;
    LabelF2_P: TLabel;
    LabelF3_p: TLabel;
    LabelF5_p: TLabel;
    LabelF6_p: TLabel;
    LabelF7_p: TLabel;
    LabelF8_p: TLabel;
    LabelF9_p: TLabel;
    LabelEnter_p: TLabel;
    BevelDatensatzinfo_p: TBevel;
    BevelSortieren_p: TBevel;
    BevelFilter_p: TBevel;
    LabelDatensatzinfo_p: TLabel;
    LabelSortiert_p: TLabel;
    LabelFilter_p: TLabel;
    procedure ButtonZurueckClick(Sender: TObject);
    procedure ButtonAendernClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonNeuClick(Sender: TObject);
    procedure ButtonAusgabeClick(Sender: TObject);
    procedure ButtonSortierenClick(Sender: TObject);
    procedure ButtonFilterClick(Sender: TObject);
    procedure formNeu;
    procedure ButtonEnterClick(Sender: TObject);
    procedure DBGridNeu(SQLSelect,SQLFrom,SQLWhere,SQLOrder:String);
//    procedure PopupMenuSuchenClick(Sender: TObject);
    procedure PopupMenuSortierenClick(Sender: TObject);
    procedure EditZeigerChange(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ButtonLoeschenClick(Sender: TObject);
 //   function  DatensatzNeu:longint;
    procedure ButtonKopierenClick(Sender: TObject);
    procedure FenstergroesseAbspeichern;
    Procedure NrZeigerAn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure EditZeigerEnter(Sender: TObject);
    procedure EditZeigerExit(Sender: TObject);
  //  procedure Einstellungsuchen;
  private
    SQLSelect,SQLFrom,SQLWhere,SQLOrder,ParEditText,ICaption: String;
    EnaF2,EnaF3,EnaF5,EnaF6,EnaF8:Boolean;
    FSpatenbreite1,FensterTop,FensterLeft,FensterWidth,FensterHeight:Integer;
    SqlWhereList,SpaltenListe: TStringlist;
    formAbbrechen:Boolean;
    SQLWhereZusaetzlich:String;
    UspaltenNr1,UspaltenNr2:integer;
    IEinstellungsNr,CNr,GZeigerEinstellung:longint;
    FelderWennNeu,FelderWennNeuValue,IModulart,IBenutzer:String;
    FormMaske:TForm;
    UTop,ULeft:integer; Ui,Ut,Ul,Ua,UReadOnly:integer;//Fensteranimation
    { Private-Deklarationen }
  public
    //class function an(mFormMaske:TForm;mSQLSelect,mSQLFrom,mSQLWhere,mSQLOrder:String;Par:TStringList):TStringlist;
    class function an(mFormMaske:TForm;FEditText,FModulart,FBenutzer:string;FFensterNr:longint):TStringList;

  end;

var
  Form1,Form2,Form3,Form4,Form5,Form6,Form7,Form8,Form9,Form10: TForm1;
 // FormMaske:TForm;


implementation

uses UnitModule,UnitDammiForm,UnitFilter,UnitDatum,UnitArtikelSammlung,
     UnitMaskeProjekt, UnitAdresse, UnitEinstellungForm1, UnitDB,
  UnitMeldefenster,UnitDataModul, UnitSpalteAendern;

{$R *.DFM}
//Eingang-----------------------------------------------------------------------
class function  TForm1.an(mFormMaske:TForm;FEditText,FModulart,FBenutzer:string;FFensterNr:longint):TStringList;
var Fzurueck:TStringList;FDatensatzgefunden:Boolean;
begin
  FDatensatzgefunden:=True;
  Fzurueck:=TStringList.Create;
  FormPlanlos.QueryEinstellungForm1L.close;
  FormPlanlos.QueryEinstellungForm1L.SQL.Clear;
  FormPlanlos.QueryEinstellungForm1L.SQL.Add('Select * FROM EinstellungForm1 WHERE FensterNr = ' + inttostr(FFensterNr)+' AND Modulart = "'+GModulart+ '" AND Benutzer = "'+GBenutzer+'"');
  try  FormPlanlos.QueryEinstellungForm1L.Open except end;
  if FormPlanlos.QueryEinstellungForm1L.RecordCount < 1 Then
  begin
    FormPlanlos.QueryEinstellungForm1L.close;
    FormPlanlos.QueryEinstellungForm1L.SQL.Clear;
    FormPlanlos.QueryEinstellungForm1L.SQL.Add('Select * FROM EinstellungForm1 WHERE FensterNr = ' + inttostr(FFensterNr)+' AND Modulart = "Standard" AND Benutzer = "'+GBenutzer+'"');
    try FormPlanlos.QueryEinstellungForm1L.Open except end;
    if FormPlanlos.QueryEinstellungForm1L.RecordCount < 1 Then
    begin
      FormPlanlos.QueryEinstellungForm1L.close;
      FormPlanlos.QueryEinstellungForm1L.SQL.Clear;
      FormPlanlos.QueryEinstellungForm1L.SQL.Add('Select * FROM EinstellungForm1 WHERE FensterNr = ' + inttostr(FFensterNr)+' AND Modulart = "Standard" AND Benutzer = "Standard"');
      try FormPlanlos.QueryEinstellungForm1L.Open  except   end;
      if FormPlanlos.QueryEinstellungForm1L.RecordCount < 1 Then
      begin
        //Meldefenster.an(2,'Das fehlende Fenster hat die ','Nr, die in der Titelleiste steht',inttostr(FFensterNr));
        FormPlanlos.Gzeiger:=DataModuleDB.DatensatzNeuMit('EinstellungForm1','FensterNr,Modulart,Benutzer','"'+inttostr(FFensterNr)+'"'+',"Standard","Standard"');
        FormPlanlos.GzeigerNeu:=True;
        FormEinstellungForm1.ShowModal;
        //FDatensatzgefunden:=FormEinstellungForm1.neu(FFensterNr,'Standart','Standart');
        FormPlanlos.QueryEinstellungForm1L.close;
        FormPlanlos.QueryEinstellungForm1L.SQL.Clear;
        FormPlanlos.QueryEinstellungForm1L.SQL.Add('Select * FROM EinstellungForm1 WHERE Nr = ' + inttostr(FormPlanlos.Gzeiger) +' AND Modulart = "Standard" AND Benutzer = "Standard"');
        try
          FormPlanlos.QueryEinstellungForm1L.Open
        except
        end;
      end;
    end;
  end;
   // FormMaske:=mFormMaske;
    FormPlanlos.Gzeiger:=FormPlanlos.QueryEinstellungForm1L.Fields[0].Value;
    if FormCounter < 1 then
      FormCounter:=1
    else
      FormCounter:=FormCounter + 1;
    Fzurueck.add('0');Fzurueck.add('');
    if (FormCounter > 9) or (FDatensatzgefunden = False) then
       Result:=Fzurueck
    else begin
      case FormCounter of
         {Nr,Modulart,Benutzer,FensterNr,Beschreibung,Formularname,SQLForm,SQLSelect,SQLWhere,SQLOrder
         SQLWhereZusatz,Caption,NeuAn,KopierenAn,AendernAn,LoeschenAn,
         ErsteSpalteBreite,FensterTop,FensterLeft,Fensterwidth,Fensterhoehe,
         Rückgabespalte1,Rückgabespalte2}




        1: begin Form1:=TForm1.Create(FormPlanlos);Form1.formAbbrechen:=False;
        Form1.IModulart:=FModulart;
        Form1.IBenutzer:=FBenutzer;
        Form1.IEinstellungsNr:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterNR').Asinteger;
        Form1.SQLSelect:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLSelect').AsString;
        Form1.SQLFrom:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLFrom').AsString;
        Form1.SQLWhere:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhere').AsString;
        Form1.SQLOrder:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLOrder').AsString;
        Form1.formneu;
        Form1.ICaption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
        Form1.ParEditText:=FEditText;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('NeuAn').AsInteger = 0 then Form1.EnaF2:=False Else Form1.EnaF2:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AusgabeAn').AsInteger = 0 then Form1.EnaF3:=False Else Form1.EnaF3:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('KopierenAn').AsInteger = 0 then Form1.EnaF5:=False Else Form1.EnaF5:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AendernAn').AsInteger = 0 then Form1.EnaF6:=False Else Form1.EnaF6:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('LoeschenAn').AsInteger = 0 then Form1.EnaF8:=False Else Form1.EnaF8:=True;
        Form1.FSpatenbreite1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('ErsteSpalteBreite').AsInteger;
        Form1.FensterTop:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterTop').AsInteger;
        Form1.FensterLeft:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterLeft').AsInteger;
        Form1.FensterWidth:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterwidth').AsInteger;
        Form1.FensterHeight:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterhoehe').AsInteger;
        Form1.SQLWhereZusaetzlich:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhereZusatz').AsString;
        Form1.UspaltenNr1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte1').AsInteger;
        Form1.UspaltenNr2:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte2').AsInteger;
        Form1.FelderWennNeu:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeu').AsString;
        Form1.FelderWennNeuValue:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeuValue').AsString;
        Form1.UReadOnly:=FormPlanlos.QueryEinstellungForm1L.FieldByName('DBC').Asinteger;
        Form1.FormMaske:=mFormMaske;
        Form1.ShowModal;
        {1: begin Form1:=TForm1.Create(FormPlanlos);Form1.formAbbrechen:=False;
        Form1.SQLSelect:=mSQLSelect;
        Form1.SQLFrom:=mSQLFrom;
        Form1.SQLWhere:=mSQLWhere;
        Form1.SQLOrder:=mSQLOrder;
        Form1.formneu;
        Form1.Caption:=Par.Strings[0];
        Form1.ParEditText:=Par.Strings[1];
        Form1.EnaF2:=Par.Strings[2];
        Form1.EnaF5:=Par.Strings[3];
        Form1.EnaF6:=Par.Strings[4];
        Form1.EnaF8:=Par.Strings[5];
        Form1.FSpatenbreite1:=strtoint(Par.Strings[6]);
        Form1.FensterTop:=strtoint(Par.Strings[7]);
        Form1.FensterLeft:=strtoint(Par.Strings[8]);
        Form1.FensterWidth:=strtoint(Par.Strings[9]);
        Form1.FensterHeight:=strtoint(Par.Strings[10]);
        Form1.SQLWhereZusaetzlich:=Par.Strings[11];
        Form1.ShowModal;
        Form1.UspaltenNr1:=strtoint(Par.Strings[12]);
        Form1.UspaltenNr2:=strtoint(Par.Strings[13]);}
        if (Form1.formAbbrechen=False) and (Form1.Query1.Fields[Form1.UspaltenNr1].AsString <> '') then
          begin
            Fzurueck[0]:=Form1.Query1.Fields[Form1.UspaltenNr1].AsString;
            Fzurueck[1]:=Form1.Query1.Fields[Form1.UspaltenNr2].AsString;
          end
          else
          begin
            Fzurueck[0]:='0';
            Fzurueck[1]:='';
          end;
        if (Form1.IEinstellungsNr > 210) and (Form1.IEinstellungsNr < 231) then  Fzurueck[1]:=Form1.ICaption;
        Result:=Fzurueck;
        end;
      2:begin Form2:=TForm1.Create(FormPlanlos);Form2.formAbbrechen:=False;
        Form2.IModulart:=FModulart;
        Form2.IBenutzer:=FBenutzer;
        Form2.IEinstellungsNr:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterNR').Asinteger;
        Form2.SQLSelect:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLSelect').AsString;
        Form2.SQLFrom:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLFrom').AsString;
        Form2.SQLWhere:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhere').AsString;
        Form2.SQLOrder:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLOrder').AsString;
        Form2.formneu;
        Form2.ICaption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
        Form2.ParEditText:=FEditText;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('NeuAn').AsInteger = 0 then Form2.EnaF2:=False Else Form2.EnaF2:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AusgabeAn').AsInteger = 0 then Form2.EnaF3:=False Else Form2.EnaF3:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('KopierenAn').AsInteger = 0 then Form2.EnaF5:=False Else Form2.EnaF5:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AendernAn').AsInteger = 0 then Form2.EnaF6:=False Else Form2.EnaF6:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('LoeschenAn').AsInteger = 0 then Form2.EnaF8:=False Else Form2.EnaF8:=True;
        Form2.FSpatenbreite1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('ErsteSpalteBreite').AsInteger;
        Form2.FensterTop:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterTop').AsInteger;
        Form2.FensterLeft:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterLeft').AsInteger;
        Form2.FensterWidth:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterwidth').AsInteger;
        Form2.FensterHeight:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterhoehe').AsInteger;
        Form2.SQLWhereZusaetzlich:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhereZusatz').AsString;
        Form2.UspaltenNr1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte1').AsInteger;
        Form2.UspaltenNr2:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte2').AsInteger;
        Form2.FelderWennNeu:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeu').AsString;
        Form2.FelderWennNeuValue:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeuValue').AsString;
        Form2.UReadOnly:=FormPlanlos.QueryEinstellungForm1L.FieldByName('DBC').Asinteger;
        Form2.FormMaske:=mFormMaske;
        Form2.ShowModal;
        if Form2.formAbbrechen=False and (Form2.Query1.Fields[Form2.UspaltenNr1].AsString <> '') then
          begin
            Fzurueck[0]:=Form2.Query1.Fields[Form2.UspaltenNr1].AsString;
            Fzurueck[1]:=Form2.Query1.Fields[Form2.UspaltenNr2].AsString;
          end
        else
          begin
            Fzurueck[0]:='0';
            Fzurueck[1]:='';
          end;
        if (Form2.IEinstellungsNr > 210) and (Form2.IEinstellungsNr < 231) then  Fzurueck[1]:=Form2.ICaption;
        Result:=Fzurueck;
        end;
      3:begin Form3:=TForm1.Create(FormPlanlos);Form3.formAbbrechen:=False;
        Form3.IModulart:=FModulart;
        Form3.IBenutzer:=FBenutzer;
        Form3.IEinstellungsNr:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterNR').Asinteger;
        Form3.SQLSelect:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLSelect').AsString;
        Form3.SQLFrom:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLFrom').AsString;
        Form3.SQLWhere:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhere').AsString;
        Form3.SQLOrder:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLOrder').AsString;
        Form3.formneu;
        Form3.ICaption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
        Form3.ParEditText:=FEditText;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('NeuAn').AsInteger = 0 then Form3.EnaF2:=False Else Form3.EnaF2:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AusgabeAn').AsInteger = 0 then Form3.EnaF3:=False Else Form3.EnaF3:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('KopierenAn').AsInteger = 0 then Form3.EnaF5:=False Else Form3.EnaF5:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AendernAn').AsInteger = 0 then Form3.EnaF6:=False Else Form3.EnaF6:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('LoeschenAn').AsInteger = 0 then Form3.EnaF8:=False Else Form3.EnaF8:=True;
        Form3.FSpatenbreite1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('ErsteSpalteBreite').AsInteger;
        Form3.FensterTop:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterTop').AsInteger;
        Form3.FensterLeft:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterLeft').AsInteger;
        Form3.FensterWidth:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterwidth').AsInteger;
        Form3.FensterHeight:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterhoehe').AsInteger;
        Form3.SQLWhereZusaetzlich:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhereZusatz').AsString;
        Form3.UspaltenNr1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte1').AsInteger;
        Form3.UspaltenNr2:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte2').AsInteger;
        Form3.FelderWennNeu:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeu').AsString;
        Form3.FelderWennNeuValue:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeuValue').AsString;
        Form3.UReadOnly:=FormPlanlos.QueryEinstellungForm1L.FieldByName('DBC').Asinteger;
        Form3.FormMaske:=mFormMaske;
        Form3.ShowModal;
        if Form3.formAbbrechen=False and (Form3.Query1.Fields[Form3.UspaltenNr1].AsString <> '') then
          begin
            Fzurueck[0]:=Form3.Query1.Fields[Form3.UspaltenNr1].AsString;
            Fzurueck[1]:=Form3.Query1.Fields[Form3.UspaltenNr2].AsString;
          end
          else
          begin
            Fzurueck[0]:='0';
            Fzurueck[1]:='';
          end;
        if (Form3.IEinstellungsNr > 210) and (Form3.IEinstellungsNr < 231) then  Fzurueck[1]:=Form3.ICaption;
        Result:=Fzurueck;
        end;
      4:begin Form4:=TForm1.Create(FormPlanlos);Form4.formAbbrechen:=False;
        Form4.IModulart:=FModulart;
        Form4.IBenutzer:=FBenutzer;
        Form4.IEinstellungsNr:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterNR').Asinteger;
        Form4.SQLSelect:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLSelect').AsString;
        Form4.SQLFrom:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLFrom').AsString;
        Form4.SQLWhere:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhere').AsString;
        Form4.SQLOrder:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLOrder').AsString;
        Form4.formneu;
        Form4.ICaption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
        Form4.ParEditText:=FEditText;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('NeuAn').AsInteger = 0 then Form4.EnaF2:=False Else Form4.EnaF2:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AusgabeAn').AsInteger = 0 then Form4.EnaF3:=False Else Form4.EnaF3:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('KopierenAn').AsInteger = 0 then Form4.EnaF5:=False Else Form4.EnaF5:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AendernAn').AsInteger = 0 then Form4.EnaF6:=False Else Form4.EnaF6:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('LoeschenAn').AsInteger = 0 then Form4.EnaF8:=False Else Form4.EnaF8:=True;
        Form4.FSpatenbreite1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('ErsteSpalteBreite').AsInteger;
        Form4.FensterTop:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterTop').AsInteger;
        Form4.FensterLeft:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterLeft').AsInteger;
        Form4.FensterWidth:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterwidth').AsInteger;
        Form4.FensterHeight:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterhoehe').AsInteger;
        Form4.SQLWhereZusaetzlich:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhereZusatz').AsString;
        Form4.UspaltenNr1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte1').AsInteger;
        Form4.UspaltenNr2:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte2').AsInteger;
        Form4.FelderWennNeu:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeu').AsString;
        Form4.FelderWennNeuValue:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeuValue').AsString;
        Form4.UReadOnly:=FormPlanlos.QueryEinstellungForm1L.FieldByName('DBC').Asinteger;
        Form4.FormMaske:=mFormMaske;
        Form4.ShowModal;
        if Form4.formAbbrechen=False and (Form4.Query1.Fields[Form4.UspaltenNr1].AsString <> '')then
          begin
            Fzurueck[0]:=Form4.Query1.Fields[Form4.UspaltenNr1].AsString;
            Fzurueck[1]:=Form4.Query1.Fields[Form4.UspaltenNr2].AsString;
          end
          else
          begin
            Fzurueck[0]:='0';
            Fzurueck[1]:='';
          end;
        if (Form4.IEinstellungsNr > 210) and (Form4.IEinstellungsNr < 231) then  Fzurueck[1]:=Form4.ICaption;
        Result:=Fzurueck;
        end;
      5:begin Form5:=TForm1.Create(FormPlanlos);Form5.formAbbrechen:=False;
        Form5.IModulart:=FModulart;
        Form5.IBenutzer:=FBenutzer;
        Form5.IEinstellungsNr:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterNR').Asinteger;
        Form5.SQLSelect:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLSelect').AsString;
        Form5.SQLFrom:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLFrom').AsString;
        Form5.SQLWhere:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhere').AsString;
        Form5.SQLOrder:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLOrder').AsString;
        Form5.formneu;
        Form5.ICaption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
        Form5.ParEditText:=FEditText;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('NeuAn').AsInteger = 0 then Form5.EnaF2:=False Else Form5.EnaF2:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AusgabeAn').AsInteger = 0 then Form5.EnaF3:=False Else Form5.EnaF3:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('KopierenAn').AsInteger = 0 then Form5.EnaF5:=False Else Form5.EnaF5:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AendernAn').AsInteger = 0 then Form5.EnaF6:=False Else Form5.EnaF6:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('LoeschenAn').AsInteger = 0 then Form5.EnaF8:=False Else Form5.EnaF8:=True;
        Form5.FSpatenbreite1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('ErsteSpalteBreite').AsInteger;
        Form5.FensterTop:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterTop').AsInteger;
        Form5.FensterLeft:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterLeft').AsInteger;
        Form5.FensterWidth:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterwidth').AsInteger;
        Form5.FensterHeight:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterhoehe').AsInteger;
        Form5.SQLWhereZusaetzlich:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhereZusatz').AsString;
        Form5.UspaltenNr1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte1').AsInteger;
        Form5.UspaltenNr2:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte2').AsInteger;
        Form5.FelderWennNeu:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeu').AsString;
        Form5.FelderWennNeuValue:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeuValue').AsString;
        Form5.UReadOnly:=FormPlanlos.QueryEinstellungForm1L.FieldByName('DBC').Asinteger;
        Form5.FormMaske:=mFormMaske;
        Form5.ShowModal;
        if Form5.formAbbrechen=False and (Form5.Query1.Fields[Form5.UspaltenNr1].AsString <> '')then
          begin
            Fzurueck[0]:=Form5.Query1.Fields[Form5.UspaltenNr1].AsString;
            Fzurueck[1]:=Form5.Query1.Fields[Form5.UspaltenNr2].AsString;
          end
          else
          begin
            Fzurueck[0]:='0';
            Fzurueck[1]:='';
          end;
        if (Form5.IEinstellungsNr > 210) and (Form5.IEinstellungsNr < 231) then  Fzurueck[1]:=Form5.ICaption;
        Result:=Fzurueck;
        end;
      6:begin Form6:=TForm1.Create(FormPlanlos);Form6.formAbbrechen:=False;
        Form6.IModulart:=FModulart;
        Form6.IBenutzer:=FBenutzer;
        Form6.IEinstellungsNr:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterNR').Asinteger;
        Form6.SQLSelect:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLSelect').AsString;
        Form6.SQLFrom:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLFrom').AsString;
        Form6.SQLWhere:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhere').AsString;
        Form6.SQLOrder:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLOrder').AsString;
        Form6.formneu;
        Form6.ICaption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
        Form6.ParEditText:=FEditText;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('NeuAn').AsInteger = 0 then Form6.EnaF2:=False Else Form6.EnaF2:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AusgabeAn').AsInteger = 0 then Form6.EnaF3:=False Else Form6.EnaF3:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('KopierenAn').AsInteger = 0 then Form6.EnaF5:=False Else Form6.EnaF5:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AendernAn').AsInteger = 0 then Form6.EnaF6:=False Else Form6.EnaF6:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('LoeschenAn').AsInteger = 0 then Form6.EnaF8:=False Else Form6.EnaF8:=True;
        Form6.FSpatenbreite1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('ErsteSpalteBreite').AsInteger;
        Form6.FensterTop:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterTop').AsInteger;
        Form6.FensterLeft:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterLeft').AsInteger;
        Form6.FensterWidth:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterwidth').AsInteger;
        Form6.FensterHeight:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterhoehe').AsInteger;
        Form6.SQLWhereZusaetzlich:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhereZusatz').AsString;
        Form6.UspaltenNr1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte1').AsInteger;
        Form6.UspaltenNr2:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte2').AsInteger;
        Form6.FelderWennNeu:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeu').AsString;
        Form6.FelderWennNeuValue:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeuValue').AsString;
        Form6.UReadOnly:=FormPlanlos.QueryEinstellungForm1L.FieldByName('DBC').Asinteger;
        Form6.FormMaske:=mFormMaske;
        Form6.ShowModal;
        if Form6.formAbbrechen=False and (Form6.Query1.Fields[Form6.UspaltenNr1].AsString <> '')then
          begin
            Fzurueck[0]:=Form6.Query1.Fields[Form6.UspaltenNr1].AsString;
            Fzurueck[1]:=Form6.Query1.Fields[Form6.UspaltenNr2].AsString;
          end
          else
          begin
            Fzurueck[0]:='0';
            Fzurueck[1]:='';
          end;
        if (Form6.IEinstellungsNr > 210) and (Form6.IEinstellungsNr < 231) then  Fzurueck[1]:=Form6.ICaption;
        Result:=Fzurueck;
        end;
      7:begin Form7:=TForm1.Create(FormPlanlos);Form7.formAbbrechen:=False;
        Form7.IModulart:=FModulart;
        Form7.IBenutzer:=FBenutzer;
        Form7.IEinstellungsNr:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterNR').Asinteger;
        Form7.SQLSelect:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLSelect').AsString;
        Form7.SQLFrom:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLFrom').AsString;
        Form7.SQLWhere:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhere').AsString;
        Form7.SQLOrder:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLOrder').AsString;
        Form7.formneu;
        Form7.ICaption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
        Form7.ParEditText:=FEditText;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('NeuAn').AsInteger = 0 then Form7.EnaF2:=False Else Form7.EnaF2:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AusgabeAn').AsInteger = 0 then Form7.EnaF3:=False Else Form7.EnaF3:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('KopierenAn').AsInteger = 0 then Form7.EnaF5:=False Else Form7.EnaF5:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AendernAn').AsInteger = 0 then Form7.EnaF6:=False Else Form7.EnaF6:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('LoeschenAn').AsInteger = 0 then Form7.EnaF8:=False Else Form7.EnaF8:=True;
        Form7.FSpatenbreite1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('ErsteSpalteBreite').AsInteger;
        Form7.FensterTop:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterTop').AsInteger;
        Form7.FensterLeft:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterLeft').AsInteger;
        Form7.FensterWidth:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterwidth').AsInteger;
        Form7.FensterHeight:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterhoehe').AsInteger;
        Form7.SQLWhereZusaetzlich:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhereZusatz').AsString;
        Form7.UspaltenNr1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte1').AsInteger;
        Form7.UspaltenNr2:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte2').AsInteger;
        Form7.FelderWennNeu:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeu').AsString;
        Form7.FelderWennNeuValue:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeuValue').AsString;
        Form7.UReadOnly:=FormPlanlos.QueryEinstellungForm1L.FieldByName('DBC').Asinteger;
        Form7.FormMaske:=mFormMaske;
        Form7.ShowModal;
        if Form7.formAbbrechen=False and (Form7.Query1.Fields[Form7.UspaltenNr1].AsString <> '')then
          begin
            Fzurueck[0]:=Form7.Query1.Fields[Form7.UspaltenNr1].AsString;
            Fzurueck[1]:=Form7.Query1.Fields[Form7.UspaltenNr2].AsString;
          end
          else
          begin
            Fzurueck[0]:='0';
            Fzurueck[1]:='';
          end;
        if (Form7.IEinstellungsNr > 210) and (Form7.IEinstellungsNr < 231) then  Fzurueck[1]:=Form7.ICaption;
        Result:=Fzurueck;
        end;
      8:begin Form8:=TForm1.Create(FormPlanlos);Form8.formAbbrechen:=False;
        Form8.IModulart:=FModulart;
        Form8.IBenutzer:=FBenutzer;
        Form8.IEinstellungsNr:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterNR').Asinteger;
        Form8.SQLSelect:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLSelect').AsString;
        Form8.SQLFrom:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLFrom').AsString;
        Form8.SQLWhere:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhere').AsString;
        Form8.SQLOrder:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLOrder').AsString;
        Form8.formneu;
        Form8.ICaption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
        Form8.ParEditText:=FEditText;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('NeuAn').AsInteger = 0 then Form8.EnaF2:=False Else Form8.EnaF2:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AusgabeAn').AsInteger = 0 then Form8.EnaF3:=False Else Form8.EnaF3:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('KopierenAn').AsInteger = 0 then Form8.EnaF5:=False Else Form8.EnaF5:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AendernAn').AsInteger = 0 then Form8.EnaF6:=False Else Form8.EnaF6:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('LoeschenAn').AsInteger = 0 then Form8.EnaF8:=False Else Form8.EnaF8:=True;
        Form8.FSpatenbreite1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('ErsteSpalteBreite').AsInteger;
        Form8.FensterTop:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterTop').AsInteger;
        Form8.FensterLeft:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterLeft').AsInteger;
        Form8.FensterWidth:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterwidth').AsInteger;
        Form8.FensterHeight:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterhoehe').AsInteger;
        Form8.SQLWhereZusaetzlich:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhereZusatz').AsString;
        Form8.UspaltenNr1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte1').AsInteger;
        Form8.UspaltenNr2:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte2').AsInteger;
        Form8.FelderWennNeu:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeu').AsString;
        Form8.FelderWennNeuValue:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeuValue').AsString;
        Form8.UReadOnly:=FormPlanlos.QueryEinstellungForm1L.FieldByName('DBC').Asinteger;
        Form8.FormMaske:=mFormMaske;
        Form8.ShowModal;
        if Form8.formAbbrechen=False and (Form8.Query1.Fields[Form8.UspaltenNr1].AsString <> '')then
          begin
            Fzurueck[0]:=Form8.Query1.Fields[Form8.UspaltenNr1].AsString;
            Fzurueck[1]:=Form8.Query1.Fields[Form8.UspaltenNr2].AsString;
          end
          else
          begin
            Fzurueck[0]:='0';
            Fzurueck[1]:='';
          end;
        if (Form8.IEinstellungsNr > 210) and (Form8.IEinstellungsNr < 231) then  Fzurueck[1]:=Form8.ICaption;
        Result:=Fzurueck;
        end;
      9:begin Form9:=TForm1.Create(FormPlanlos);Form9.formAbbrechen:=False;
        Form9.IModulart:=FModulart;
        Form9.IBenutzer:=FBenutzer;
        Form9.IEinstellungsNr:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterNR').Asinteger;
        Form9.SQLSelect:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLSelect').AsString;
        Form9.SQLFrom:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLFrom').AsString;
        Form9.SQLWhere:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhere').AsString;
        Form9.SQLOrder:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLOrder').AsString;
        Form9.formneu;
        Form9.ICaption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
        Form9.ParEditText:=FEditText;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('NeuAn').AsInteger = 0 then Form9.EnaF2:=False Else Form9.EnaF2:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AusgabeAn').AsInteger = 0 then Form9.EnaF3:=False Else Form9.EnaF3:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('KopierenAn').AsInteger = 0 then Form9.EnaF5:=False Else Form9.EnaF5:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AendernAn').AsInteger = 0 then Form9.EnaF6:=False Else Form9.EnaF6:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('LoeschenAn').AsInteger = 0 then Form9.EnaF8:=False Else Form9.EnaF8:=True;
        Form9.FSpatenbreite1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('ErsteSpalteBreite').AsInteger;
        Form9.FensterTop:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterTop').AsInteger;
        Form9.FensterLeft:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterLeft').AsInteger;
        Form9.FensterWidth:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterwidth').AsInteger;
        Form9.FensterHeight:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterhoehe').AsInteger;
        Form9.SQLWhereZusaetzlich:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhereZusatz').AsString;
        Form9.UspaltenNr1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte1').AsInteger;
        Form9.UspaltenNr2:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte2').AsInteger;
        Form9.FelderWennNeu:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeu').AsString;
        Form9.FelderWennNeuValue:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeuValue').AsString;
        Form9.UReadOnly:=FormPlanlos.QueryEinstellungForm1L.FieldByName('DBC').Asinteger;
        Form9.FormMaske:=mFormMaske;
        Form9.ShowModal;
        if Form9.formAbbrechen=False and (Form9.Query1.Fields[Form9.UspaltenNr1].AsString <> '')then
          begin
            Fzurueck[0]:=Form9.Query1.Fields[Form9.UspaltenNr1].AsString;
            Fzurueck[1]:=Form9.Query1.Fields[Form9.UspaltenNr2].AsString;
          end
          else
          begin
            Fzurueck[0]:='0';
            Fzurueck[1]:='';
          end;
        if (Form9.IEinstellungsNr > 210) and (Form9.IEinstellungsNr < 231) then  Fzurueck[1]:=Form9.ICaption;
        Result:=Fzurueck;
        end;
      10:begin Form10:=TForm1.Create(FormPlanlos);Form10.formAbbrechen:=False;
        Form10.IModulart:=FModulart;
        Form10.IBenutzer:=FBenutzer;
        Form10.IEinstellungsNr:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterNR').Asinteger;
        Form10.SQLSelect:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLSelect').AsString;
        Form10.SQLFrom:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLFrom').AsString;
        Form10.SQLWhere:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhere').AsString;
        Form10.SQLOrder:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLOrder').AsString;
        Form10.formneu;
        Form10.ICaption:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Caption').AsString;
        Form10.ParEditText:=FEditText;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('NeuAn').AsInteger = 0 then Form10.EnaF2:=False Else Form10.EnaF2:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AusgabeAn').AsInteger = 0 then Form10.EnaF3:=False Else Form10.EnaF3:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('KopierenAn').AsInteger = 0 then Form10.EnaF5:=False Else Form10.EnaF5:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('AendernAn').AsInteger = 0 then Form10.EnaF6:=False Else Form10.EnaF6:=True;
        if FormPlanlos.QueryEinstellungForm1L.FieldByName('LoeschenAn').AsInteger = 0 then Form10.EnaF8:=False Else Form10.EnaF8:=True;
        Form10.FSpatenbreite1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('ErsteSpalteBreite').AsInteger;
        Form10.FensterTop:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterTop').AsInteger;
        Form10.FensterLeft:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterLeft').AsInteger;
        Form10.FensterWidth:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterwidth').AsInteger;
        Form10.FensterHeight:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterhoehe').AsInteger;
        Form10.SQLWhereZusaetzlich:=FormPlanlos.QueryEinstellungForm1L.FieldByName('SQLWhereZusatz').AsString;
        Form10.UspaltenNr1:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte1').AsInteger;
        Form10.UspaltenNr2:=FormPlanlos.QueryEinstellungForm1L.FieldByName('Rückgabespalte2').AsInteger;
        Form10.FelderWennNeu:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeu').AsString;
        Form10.FelderWennNeuValue:=FormPlanlos.QueryEinstellungForm1L.FieldByName('FelderWennNeuValue').AsString;
        Form10.UReadOnly:=FormPlanlos.QueryEinstellungForm1L.FieldByName('DBC').Asinteger;
        Form10.FormMaske:=mFormMaske;
        Form10.ShowModal;
        if Form10.formAbbrechen=False and (Form10.Query1.Fields[Form10.UspaltenNr1].AsString <> '')then
          begin
            Fzurueck[0]:=Form10.Query1.Fields[Form10.UspaltenNr1].AsString;
            Fzurueck[1]:=Form10.Query1.Fields[Form10.UspaltenNr2].AsString;
          end
          else
          begin
            Fzurueck[0]:='0';
            Fzurueck[1]:='';
          end;
        if (Form10.IEinstellungsNr > 210) and (Form10.IEinstellungsNr < 231) then  Fzurueck[1]:=Form10.ICaption;
        Result:=Fzurueck;
        end;
      end;
      FormCounter:=FormCounter-1;
    end;
    FormPlanlos.QueryEinstellungForm1L.close;
end;

procedure TForm1.formNeu;
var
   i,z: integer;
   NewItem1: TMenuItem;
   NewItem2: TMenuItem;
begin
  z:=0;
  //Query1.DatabaseName:=UDBPaht;Query2.DatabaseName:=UDBPaht;
  SqlWhereList:=TStringList.Create;
  SpaltenListe:=TStringList.Create;
  Self.DBGridNeu(SQLSelect,SQLFrom,SQLWhere,SQLOrder);
  for i := 0 to Query1.FieldCount - 1 do
     with DBGrid1.Fields[i] do
       if FieldName <> '' then
         begin
           if Query1.Fields[i].IsBlob = False then
           begin
             SpaltenListe.add(DBGrid1.Fields[i].FieldName);
             NewItem1 := TMenuItem.Create(Self);
             NewItem1.Caption :=(DBGrid1.Fields[i].FieldName);
             NewItem2 := TMenuItem.Create(Self);
             NewItem2.Caption :=(DBGrid1.Fields[i].FieldName);
             //PopupMenuSuchen.Items.Add(NewItem1);
             //PopupMenuSuchen.Items[z].OnClick:=PopupMenuSuchenClick;
             PopupMenuSortieren.Items.Add(NewItem2);
             PopupMenuSortieren.Items[z].OnClick:=PopupMenuSortierenClick;
             z:=z+1;
           end;
         end;
end;
//Datensatz zeigen -------------------------------------------------------------
procedure TForm1.DBGridNeu(SQLSelect,SQLFrom,SQLWhere,SQLOrder: String);
Var SQLZusatz:String;
begin
   if (IEinstellungsNr = 104) or (IEinstellungsNr = 105) or (IEinstellungsNr = 107) or (IEinstellungsNr = 134)then //Sondereinstellung
   begin                                                                                 //während der laufzeit
     if (IEinstellungsNr = 104) or (IEinstellungsNr = 105)then
       SQLZusatz:=' and Modulart ="'+IModulart+'"'+{  and Benutzer = "'+IBenutzer+'" }'AND Benutzer = "Standard" ';
     if (IEinstellungsNr = 107) or (IEinstellungsNr = 134) Then
     begin
       if GArtikelgruppe <> '' then  SQLZusatz:='and Artikelgruppe ="'+GArtikelgruppe+'" '
       else SQLZusatz:='';
     end;
   end
   else SQLZusatz:='';
   if (Self.Query1.Active) then Self.Query1.close;
   Self.Query1.sql.Clear;
   if SQLWhere = 'Aus'then
        Self.Query1.sql.add('SELECT '+ SQLSelect + ' FROM '+ SQLFrom +
                      ' WHERE ' + SQLWhereZusaetzlich + ' Nr <> 0 ' +SQLZusatz+ ' Order by '+ SQLOrder)
   else Self.Query1.sql.add('SELECT '+ SQLSelect + ' FROM '+ SQLFrom +
                      ' WHERE ' + SQLWhereZusaetzlich +' '+ SQLWhere +SQLZusatz+ ' Order by '+ SQLOrder);
                      //showmessage( Self.Query1.sql.text);
  try
    Self.Query1.open;
  finally
  end;
  LabelSortiert.Caption:=SQLOrder;
  LabelSortiert_P.Caption:=LabelSortiert.Caption;
  LabelFilter.Caption:=SQLWhere;
  LabelFilter_p.Caption:=LabelFilter.Caption;
  LabelDatensatzinfo.Caption:=IntToStr(Query1.RecNo)+'/'+IntToStr(Query1.RecordCount);
  LabelDatensatzinfo_p.Caption:=LabelDatensatzinfo.Caption;
  If FSpatenbreite1 > 0 Then DBGrid1.Columns[0].Width:=FSpatenbreite1;
  BevelSortieren.Hint:='Sortiert nach = '+ SQLOrder;
  BevelFilter.Hint:='Filter = '+ SQLWhere;
  EditZeigerChange(Self);
  if CNr>0 then NrZeigerAn;
  ActiveControl:=DBGrid1;DBGrid1.SelectedField:=DBGrid1.Fields[1];
end;

Procedure TForm1.NrZeigerAn;
begin
  if Cnr > 0 then
  begin
    Query1.disableControls;
    Query1.first;
    while not Query1.eof do
    begin
      if Query1.Fields[0].Value=CNr then break
      else Query1.next;
    end;
    Query1.EnableControls;
    Cnr:=0;
  end;
  //DBGrid1.SetFocus;
  ActiveControl:=DBGrid1;
  //ShowMessage('hat den Focus gesetzt');
end;
//Tastatur ---------------------------------------------------------------------
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var LoeschenJa:Boolean;
      i:integer;
      s:string;
begin
  if (Shift = [ssShift]) or (Shift = [ssAlt]) then
  begin
    if (Shift = [ssAlt]) then begin
      if (Key = VK_DOWN) or (Key = VK_UP) then if DBGrid1.Focused then self.ActiveControl:=EditZeiger Else self.ActiveControl:=DBGrid1;
    end Else begin
      if Key = 27 then  ButtonZurueckClick(Self);
      if Key = VK_F8 then begin
        if EnaF8 then begin
          LoeschenJa:=Meldefenster.an(3,'Wollen sie wirklich alle gezeigten Datensätze löschen?','geben sie "Ja" ein zum Bestätigen:',s);
          if LoeschenJa then begin
            Query1.first;
            for i := 0 to Query1.RecordCount - 1 do begin
              if Query1.FieldByName('ReadOnly').ASInteger <> 1 Then begin
                if (IEinstellungsNr = 83) then DataModuleDB.DatensaetzeLoeschen('Stuecklistenartikel','Stuecklisten_Nr',Query1.Fields[0].Value);//Sondereinstellung
                If (DataModuleDB.DatensatzLoeschen(SQLFrom,Query1.Fields[0].Value) = False) Then  Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
              end
              Else begin
                DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
                Meldefenster.an(2,'Datensatz konnte nicht gelöscht werden,','weil ReadOnly = 1!','');
                DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
              end;
              Query1.next;
            end;
            DBGridNeu(SQLSelect,SQLFrom,SQLWhere,SQLOrder);
          end;
        end;
      end;
      if Key = VK_F6 then
      begin
        //Color:=clGray;
        DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
        FormPlanlos.GZeiger:=GZeigerEinstellung;
        FormEinstellungForm1.ShowModal;
        DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
        //Showmessage('Die Änderung wird erst beim erneuten aufruf der Liste wirksam');
        DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
        //Color:=clGray;
        Meldefenster.an(2,'Die Änderung wird erst beim erneutem','aufruf der Liste wirksam !','');
        DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
        //Color:=clYellow;
      end;
      if Key = VK_F4 then Showmessage('GModulart ='+GModulart+'  GBenutzer ='+GBenutzer);
      if Key = VK_F3 then Showmessage(Query1.SQL.text);
      if Key = VK_F9 then FenstergroesseAbspeichern;
    end;
  end else  begin
    if Key = 27 then  ButtonZurueckClick(Self);
    if Key = VK_F2 then  if EnaF2 then ButtonNeuClick(Self);
    if Key = VK_F3 then  ButtonAusgabeClick(Self);
    if Key = VK_F5 then  if EnaF5 then ButtonKopierenClick(Self);
    if Key = VK_F6 then  if EnaF6 then ButtonAendernClick(Self);
    if Key = VK_F7 then  ButtonSortierenClick(Self);
    if Key = VK_F8 then  if EnaF8 then ButtonLoeschenClick(Self);
    if Key = VK_F9 then  ButtonFilterClick(Self);
    if Key = VK_RETURN then ButtonEnterClick(Self);
    if (Key = VK_DOWN) or (Key = VK_UP) then
    begin
      if EditZeiger.Focused then self.ActiveControl:=DBGrid1;
      //if DBGrid1.Focused then if Query1.RecNo=Query1.RecordCount then ActiveControl:=EditZeiger;
    end;
  end;
end;

procedure TForm1.ButtonEnterClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ButtonZurueckClick(Sender: TObject);
begin
  formAbbrechen:=True;
  Close;
end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
  //if EnaF6 then ButtonAendernClick(Self);
  close;
end;

procedure TForm1.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  LabelDatensatzinfo.Caption:=IntToStr(Self.Query1.RecNo)+'/'+IntToStr(Self.Query1.RecordCount);
  LabelDatensatzinfo_p.Caption:=LabelDatensatzinfo.Caption;
end;


//Formalitäten---------------------------------------------------------------

procedure TForm1.FormResize(Sender: TObject);
var Umschaltbreite1,Umschaltbreite2,I:integer;
    Buchstabenbreite:Real;
    CaptionLeerstelle:String;
begin
Umschaltbreite1:=380;
Umschaltbreite2:=200;
DBGrid1.Left:=0;
DBGrid1.Width:={Round(}ClientWidth{)}-3;
//DBGrid1.Height:=ClientHeight-59;
ImageTastatur.Width:=ClientWidth-3;
PanelTastatur.Width:=ClientWidth-3;
Buchstabenbreite:=4.01;
for I := 1 to (Round((ClientWidth-110)/Buchstabenbreite))-Round(Length(ICaption)*{1.5}1.9) do
    begin
    CaptionLeerstelle:=CaptionLeerstelle+' ';
    end;
Caption:=ICaption+CaptionLeerstelle+inttostr(IEinstellungsNr);
if (self.Width > Umschaltbreite1) then begin   {Buttons}
   //ImageTastatur.Width:=ClientWidth-2;
   //PanelTastatur.Width:=ClientWidth-2;
   ImageTastatur.Top:=ClientHeight-58;
   //ImageTastatur.Top:=ClientHeight-58;
   ImageTastatur.Height:=56;
   PanelTastatur.Top:=ClientHeight-58;
   PanelTastatur.Height:=56;
   DBGrid1.Height:=ClientHeight-59;

   ButtonZurueck.Left:=0;
   ButtonZurueck.Width:=Round(ClientWidth*0.11);
   ButtonZurueck.Top:=ClientHeight-44;
   ButtonNeu.Left:=Round(ClientWidth*0.11);
   ButtonNeu.Width:=Round(ClientWidth*0.11);
   ButtonNeu.Top:=ClientHeight-44;
   ButtonAusgabe.Left:=Round(ClientWidth*0.22);
   ButtonAusgabe.Width:=Round(ClientWidth*0.11);
   ButtonAusgabe.Top:=ClientHeight-44;
   ButtonKopieren.Left:=Round(ClientWidth*0.33);
   ButtonKopieren.Width:=Round(ClientWidth*0.11);
   ButtonKopieren.Top:=ClientHeight-44;
   ButtonAendern.Left:=Round(ClientWidth*0.44);
   ButtonAendern.Width:=Round(ClientWidth*0.11);
   ButtonAendern.Top:=ClientHeight-44;
   ButtonSortieren.Left:=Round(ClientWidth*0.55);
   ButtonSortieren.Width:=Round(ClientWidth*0.11);
   ButtonSortieren.Top:=ClientHeight-44;
   ButtonLoeschen.Left:=Round(ClientWidth*0.66);
   ButtonLoeschen.Width:=Round(ClientWidth*0.11);
   ButtonLoeschen.Top:=ClientHeight-44;
   ButtonFilter.Left:=Round(ClientWidth*0.77);
   ButtonFilter.Width:=Round(ClientWidth*0.11);
   ButtonFilter.Top:=ClientHeight-44;
   ButtonEnter.Left:=Round(ClientWidth*0.88);
   ButtonEnter.Width:=Round(ClientWidth*0.11);
   ButtonEnter.Top:=ClientHeight-44;
   {Labels}
   LabelEsc.Left:=Round(ClientWidth*0.04);
   LabelEsc.Top:=ClientHeight-56;
   LabelEsc.Visible:=True;
   LabelF2.Left:=Round(ClientWidth*0.15);
   LabelF2.Top:=ClientHeight-56;
   LabelF2.Visible:=True;
   LabelF3.Left:=Round(ClientWidth*0.26);
   LabelF3.Top:=ClientHeight-56;
   LabelF3.Visible:=True;
   LabelF5.Left:=Round(ClientWidth*0.37);
   LabelF5.Top:=ClientHeight-56;
   LabelF5.Visible:=True;
   LabelF6.Left:=Round(ClientWidth*0.48);
   LabelF6.Top:=ClientHeight-56;
   LabelF6.Visible:=True;
   LabelF7.Left:=Round(ClientWidth*0.60);
   LabelF7.Top:=ClientHeight-56;
   LabelF7.Visible:=True;
   LabelF8.Left:=Round(ClientWidth*0.7);
   LabelF8.Top:=ClientHeight-56;
   LabelF8.Visible:=True;
   LabelF9.Left:=Round(ClientWidth*0.82);
   LabelF9.Top:=ClientHeight-56;
   LabelF9.Visible:=True;
   LabelEnter.Left:=Round(ClientWidth*0.910);
   LabelEnter.Top:=ClientHeight-56;
   LabelEnter.Visible:=True;

   LabelEsc_p.Left:=Round(ClientWidth*0.04);
   LabelEsc_p.Top:=1;
   LabelEsc_p.Visible:=True;
   LabelF2_p.Left:=Round(ClientWidth*0.15);
   LabelF2_p.Top:=1;
   LabelF2_p.Visible:=True;
   LabelF3_p.Left:=Round(ClientWidth*0.26);
   LabelF3_p.Top:=1;
   LabelF3_p.Visible:=True;
   LabelF5_p.Left:=Round(ClientWidth*0.37);
   LabelF5_p.Top:=1;
   LabelF5_p.Visible:=True;
   LabelF6_p.Left:=Round(ClientWidth*0.48);
   LabelF6_p.Top:=1;
   LabelF6_p.Visible:=True;
   LabelF7_p.Left:=Round(ClientWidth*0.60);
   LabelF7_p.Top:=1;
   LabelF7_p.Visible:=True;
   LabelF8_p.Left:=Round(ClientWidth*0.7);
   LabelF8_p.Top:=1;
   LabelF8_p.Visible:=True;
   LabelF9_p.Left:=Round(ClientWidth*0.82);
   LabelF9_p.Top:=1;
   LabelF9_p.Visible:=True;
   LabelEnter_p.Left:=Round(ClientWidth*0.910);
   LabelEnter_p.Top:=1;
   LabelEnter_p.Visible:=True;

  {sonstiges}
   EditZeiger.Left:=1;{Round(ClientWidth*0.22);}
   EditZeiger.Width:=Round(ClientWidth*0.22);
   EditZeiger.Height:=18;
   EditZeiger.Top:=ClientHeight-22;
   BevelDatensatzinfo.Left:=Round(ClientWidth*0.44);
   BevelDatensatzinfo.Width:=Round(ClientWidth*0.11);
   BevelDatensatzinfo.Top:=ClientHeight-21;
   BevelSortieren.Left:=Round(ClientWidth*0.553);
   BevelSortieren.Width:=Round(ClientWidth*0.2144);
   BevelSortieren.Top:=ClientHeight-21;
   BevelFilter.Left:=Round(ClientWidth*0.77);
   BevelFilter.Width:=Round(ClientWidth*0.22);
   BevelFilter.Top:=ClientHeight-21;
   LabelDatensatzinfo.Left:=Round(ClientWidth*0.45);
   LabelDatensatzinfo.Top:=ClientHeight-20;
   LabelSortiert.Left:=Round(ClientWidth*0.56);
   LabelSortiert.Top:=ClientHeight-20;
   LabelFilter.Left:=Round(ClientWidth*0.78);
   LabelFilter.Top:=ClientHeight-20;

   BevelDatensatzinfo_p.Left:=Round(ClientWidth*0.44);
   BevelDatensatzinfo_p.Width:=Round(ClientWidth*0.11);
   BevelDatensatzinfo_p.Top:=37;
   BevelSortieren_p.Left:=Round(ClientWidth*0.553);
   BevelSortieren_p.Width:=Round(ClientWidth*0.2144);
   BevelSortieren_p.Top:=37;
   BevelFilter_p.Left:=Round(ClientWidth*0.77);
   BevelFilter_p.Width:=Round(ClientWidth*0.22);
   BevelFilter_p.Top:=37;
   LabelDatensatzinfo_p.Left:=Round(ClientWidth*0.45);
   LabelDatensatzinfo_p.Top:=39;
   LabelSortiert_p.Left:=Round(ClientWidth*0.56);
   LabelSortiert_p.Top:=39;
   LabelFilter_p.Left:=Round(ClientWidth*0.78);
   LabelFilter_p.Top:=39;

   end
  Else begin
   ImageTastatur.Top:=ClientHeight-150;
   ImageTastatur.Height:=151;
   PanelTastatur.Top:=ClientHeight-150;
   PanelTastatur.Height:=151;
   DBGrid1.Height:=ClientHeight-95;
   ButtonZurueck.Left:=1;
   ButtonZurueck.Width:=Round(ClientWidth*0.32);
   ButtonZurueck.Top:=ClientHeight-46;
   ButtonNeu.Left:=1;
   ButtonNeu.Width:=Round(ClientWidth*0.32);
   ButtonNeu.Top:=ClientHeight-66;
   ButtonAusgabe.Left:=1;
   ButtonAusgabe.Width:=Round(ClientWidth*0.32);
   ButtonAusgabe.Top:=ClientHeight-86;
   ButtonKopieren.Left:=Round(ClientWidth*0.34);
   ButtonKopieren.Width:=Round(ClientWidth*0.32);
   ButtonKopieren.Top:=ClientHeight-66;
   ButtonAendern.Left:=Round(ClientWidth*0.67);
   ButtonAendern.Width:=Round(ClientWidth*0.31);
   ButtonAendern.Top:=ClientHeight-66;
   ButtonSortieren.Left:=Round(ClientWidth*0.34);
   ButtonSortieren.Width:=Round(ClientWidth*0.32);
   ButtonSortieren.Top:=ClientHeight-86;
   ButtonLoeschen.Left:=Round(ClientWidth*0.34);
   ButtonLoeschen.Width:=Round(ClientWidth*0.32);
   ButtonLoeschen.Top:=ClientHeight-46;
   ButtonFilter.Left:=Round(ClientWidth*0.67);
   ButtonFilter.Width:=Round(ClientWidth*0.31);
   ButtonFilter.Top:=ClientHeight-86;
   ButtonEnter.Left:=Round(ClientWidth*0.67);
   ButtonEnter.Width:=Round(ClientWidth*0.31);
   ButtonEnter.Top:=ClientHeight-46;
   //LabelEsc.Top:=ClientHeight-56;
   LabelEsc.Visible:=False;
   LabelF2.Visible:=False;
   LabelF3.Visible:=False;
   //LabelF5.Top:=ClientHeight-56;
   LabelF5.Visible:=False;
   LabelF6.Visible:=False;
   LabelF7.Visible:=False;
   LabelF8.Visible:=False;
   LabelF9.Visible:=False;
   LabelEnter.Visible:=False;

   //LabelEsc_p.Top:=1;
   LabelEsc_p.Visible:=False;
   LabelF2_p.Visible:=False;
   LabelF3_p.Visible:=False;
   //LabelF5_p.Top:=1;
   LabelF5_p.Visible:=False;
   LabelF6_p.Visible:=False;
   LabelF7_p.Visible:=False;
   LabelF8_p.Visible:=False;
   LabelF9_p.Visible:=False;
   LabelEnter_p.Visible:=False;

  {sonstiges}
   EditZeiger.Left:=1;
   EditZeiger.Width:=Round(ClientWidth*0.375);
   EditZeiger.Height:=18;
   EditZeiger.Top:=ClientHeight-22;
   BevelDatensatzinfo.Left:=Round(ClientWidth*0.375);
   BevelDatensatzinfo.Width:=Round(ClientWidth*0.145);
   BevelDatensatzinfo.Top:=ClientHeight-22;
   BevelSortieren.Left:=Round(ClientWidth*0.514);
   BevelSortieren.Width:=Round(ClientWidth*0.192);
   BevelSortieren.Top:=ClientHeight-22;
   BevelFilter.Left:=Round(ClientWidth*0.702);
   BevelFilter.Width:=Round(ClientWidth*0.280);
   BevelFilter.Top:=ClientHeight-22;
   LabelDatensatzinfo.Left:=Round(ClientWidth*0.39);
   LabelDatensatzinfo.Top:=ClientHeight-20;
   LabelSortiert.Left:=Round(ClientWidth*0.524);
   LabelSortiert.Top:=ClientHeight-20;
   LabelFilter.Left:=Round(ClientWidth*0.712);
   LabelFilter.Top:=ClientHeight-20;

   BevelDatensatzinfo_p.Left:=Round(ClientWidth*0.375);
   BevelDatensatzinfo_p.Width:=Round(ClientWidth*0.145);
   BevelDatensatzinfo_p.Top:=128;
   BevelSortieren_p.Left:=Round(ClientWidth*0.514);
   BevelSortieren_p.Width:=Round(ClientWidth*0.192);
   BevelSortieren_p.Top:=128;
   BevelFilter_p.Left:=Round(ClientWidth*0.702);
   BevelFilter_p.Width:=Round(ClientWidth*0.286);
   BevelFilter_p.Top:=128;
   LabelDatensatzinfo_p.Left:=Round(ClientWidth*0.39);
   LabelDatensatzinfo_p.Top:=130;
   LabelSortiert_p.Left:=Round(ClientWidth*0.524);
   LabelSortiert_p.Top:=130;
   LabelFilter_p.Left:=Round(ClientWidth*0.712);
   LabelFilter_p.Top:=130;

  end;
  if (self.Width > Umschaltbreite2) and (self.Width < Umschaltbreite1)then begin
   ButtonZurueck.Caption:='Zurück/Esc';
   ButtonNeu.Caption:='Neu/F2';
   ButtonAusgabe.Caption:='Ausgabe/F4';
   ButtonKopieren.Caption:='Kopieren/F5';
   ButtonAendern.Caption:='Ändern/F6';
   ButtonSortieren.Caption:='Sortieren/F7';
   ButtonLoeschen.Caption:='Löschen/F8';
   ButtonFilter.Caption:='Filter/F9';
   end
  Else begin
   ButtonZurueck.Caption:='Zurück';
   ButtonNeu.Caption:='Neu';
   ButtonAusgabe.Caption:='Ausgabe';
   ButtonKopieren.Caption:='Kopieren';
   ButtonAendern.Caption:='Ändern';
   ButtonSortieren.Caption:='Sortieren';
   ButtonLoeschen.Caption:='Löschen';
   ButtonFilter.Caption:='Filter';
  end;
  //ImageTastatur.Width:=ClientWidth-2;
  //ImageTastatur.Top:=ClientHeight-58;
end;

procedure TForm1.ButtonAusgabeClick(Sender: TObject);
begin
     Showmessage('für diese Tabelle ist keine Druckermaske definiert');
{
    if self.Width > 380 then
       PopupMenuSuchen.Popup(Self.left+(Round(ClientWidth*0.22)+5),
       Self.Top+ClientHeight-(34 + (SpaltenListe.count*17)))
    else
       PopupMenuSuchen.Popup(Self.left + 1 + 5,
       Self.Top+ClientHeight-(63 + (SpaltenListe.count*17)));}
end;

procedure TForm1.ButtonSortierenClick(Sender: TObject);
begin
    if self.Width > 380 then
      PopupMenuSortieren.Popup(Self.left+(Round(ClientWidth*0.55)+5),
      Self.Top+ClientHeight-(34 + (SpaltenListe.count*17)))
    else
      PopupMenuSortieren.Popup(Self.left+(Round(ClientWidth*0.34)+5),
      Self.Top+ClientHeight-(63 + (SpaltenListe.count*17)));
end;

procedure TForm1.ButtonFilterClick(Sender: TObject);
var i:integer;
    filterString:String;
begin
  SqlWhereList:=FormFilter.an(SqlWhereList,SpaltenListe);
  if SqlWhereList.count > 2 then
    begin
      SQLWhere :='';
      for i:=0 to (SqlWhereList.count -1) do
      SQLWhere:= SQLWhere + ' '+ SqlWhereList.Strings[i];
    end
  else SQLWhere :='Aus';
  DBGridNeu(SQLSelect,SQLFrom,SQLWhere,SQLOrder);
end;


{procedure TForm1.PopupMenuSuchenClick(Sender: TObject);
var suchtext,spalte: String;
    Button: Integer;
begin
  with Sender as TMenuItem do spalte:=Caption;
  suchtext:=InputBox('Suche im Feld:', spalte+' = ', '');
   Query1.first;
  while not Query1.eof do begin
    if Query1.FieldByName(spalte).AsString=suchtext then break
    else Query1.next;
  end;
  EditZeiger.text:=suchtext;
 end;}

procedure TForm1.PopupMenuSortierenClick(Sender: TObject);
begin
with Sender as TMenuItem do SQLOrder:=(Caption);
DBGridNeu(SQLSelect,SQLFrom,SQLWhere,SQLOrder);
end;

procedure TForm1.EditZeigerChange(Sender: TObject);
begin
 Query1.DisableControls;
 Query1.first;
  while not Query1.eof do begin
    if AnsiUpperCase((copy(Query1.FieldByName(LabelSortiert.Caption).AsString,1,Length(EditZeiger.text))))
      =AnsiUpperCase(EditZeiger.text) then break
    else Query1.next;
  end;
 Query1.EnableControls; 
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   DBGridNeu(SQLSelect,SQLFrom,SQLWhere,SQLOrder);
   if ParEditText <>'' then EditZeiger.Text:=ParEditText;
   LabelDatensatzinfo.Caption:=IntToStr(Self.Query1.RecNo)+'/'+IntToStr(Self.Query1.RecordCount);
   LabelDatensatzinfo_p.Caption:=LabelDatensatzinfo.Caption;
   if EnaF2 = False then  ButtonNeu.Enabled:=False;
   if EnaF3 = False then  ButtonAusgabe.Enabled:=False;
   if EnaF5 = False then  ButtonKopieren.Enabled:=False;
   if EnaF6 = False then  ButtonAendern.Enabled:=False;
   if EnaF8 = False then  ButtonLoeschen.Enabled:=False;
   self.Top:=FensterTop;
   self.left:=FensterLeft;
   self.Width:=FensterWidth;
   self.Height:=FensterHeight;
   DBGrid1.ReadOnly:=True;
   Query1.RequestLive:=False;
   if UReadOnly = 1 then begin
     DBGrid1.ReadOnly:=False;
     Query1.RequestLive:=True;
     Showmessage('Achtung!!! Daten können im Datengitter geändert werden');
     DBGridNeu(SQLSelect,SQLFrom,SQLWhere,SQLOrder);
   end;
   ActiveControl:=DBGrid1;
   //if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GLeftSchritte;end;
end;
//Datensatz ändern -------------------------------------------------------------
procedure TForm1.ButtonAendernClick(Sender: TObject);
var i:integer;
    FFeld:TField;
    Fparameter:TStringList;
    FWertart:integer;
    FFloatWertTemp:Real;
    Fparameter3temp:integer;
    FFeldWertTemp:Real;
begin
   FFloatWertTemp:=0.0;
   FWertart:=1;
   FormPlanlos.GZeiger:= Query1.Fields[0].Value;
   FormPlanlos.GZeigerNeu:=False;
   Cnr:=FormPlanlos.Gzeiger;
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
   //------------------ oben Fensteranimation

      //if GAnimationsgeschwindigkeit=0 then Ua:=6 else  Ua:=GAnimationsgeschwindigkeit;//6
      UTop:=Top;ULeft:=Left;
      if UTop > (GOffeneFenster*Gtopschritte) then Ut:=UTop-(GOffeneFenster*Gtopschritte) Else Ut:=(GOffeneFenster*Gtopschritte)-UTop;
      if ULeft > (GOffeneFenster*GLeftschritte) then Ul:=ULeft-(GOffeneFenster*GLeftschritte) Else Ul:=(GOffeneFenster*GLeftschritte)-ULeft;
      Ut:=Round(Ut/(Ua));  Ul:=Round(Ul/Ua);
      for i := 1 to Ua do begin
        if UTop > (GOffeneFenster*Gtopschritte) then top:=top-Ut Else top:=top+Ut;if ULeft > (GOffeneFenster*GLeftschritte) then left:=left-Ul Else left:=Left+Ul;
      end;
      Top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;
   //-------------------------Fensteranimation Ende
   //Color:=clGray;//Query1.Close;
   if (IEinstellungsNr > 190) and (IEinstellungsNr < 209)Then begin
     Fparameter:=TStringList.Create;
     //Rückgabewert [0] OK  1=ja 0=Nein
     //wertart      [1] asString  1=string  2=Fester wert 3=Fester Wert erhöhen 4=Fester Wert minus 5=Prozentual erhöhen 6=Prozentual minus
     //wert         [2] als String
     //wert         [3] als String 0=ganzzahl 1 bis 5= kommastelle   6=ohne
     if (IEinstellungsNr = 191) Then begin
       FFeld:=Query1.FieldByName('EK_Preis');
       Fparameter:=FormSpalteAender.an(IEinstellungsNr,2{0=String 1=Float 2=Integer},FFeld.AsFloat,'geben Sie einen neuen Wert für den   "Einkaufspreis"   der gefilterten Artikel an:');
       FWertart:=strtoint(Fparameter[1]);
       FWertart:=1;  //0=String 1=Float 2=integer
     end;
     if (IEinstellungsNr = 192) Then begin
       FFeld:=Query1.FieldByName('Aufschlag');
       Fparameter:=FormSpalteAender.an(IEinstellungsNr,2{0=String 1=Float 2=Integer},FFeld.AsFloat,'geben Sie einen neuen Wert für den   "Aufschlag"   der gefilterten Artikel an:');
       FWertart:=strtoint(Fparameter[1]);
       FWertart:=1;  //0=String 1=Float 2=integer
     end;
     if (IEinstellungsNr = 208) Then begin
       FFeld:=Query1.FieldByName(LabelSortiert.Caption);
       FWertart:= 3;
       if FFeld.DataType=ftString then FWertart:=0;
       if FFeld.DataType=ftFloat then FWertart:=1;
       if (FFeld.DataType=ftInteger) or (FFeld.DataType=ftSmallint)then FWertart:=2;
       if FFeld.FieldName ='Nr' Then  FWertart:=3;
       if FWertart=3 Then begin
         Showmessage('Operation mit diesem Datentype nicht möglich');
         Fparameter.add('0');Fparameter.add('0');Fparameter.add('0');Fparameter.add('0');
       end
       Else begin
         FFeldWertTemp:=0.0;
         if FWertart=1 Then FFeldWertTemp:=FFeld.AsFloat;
         if FWertart=2 Then FFeldWertTemp:=FFeld.AsInteger;
         Fparameter:=FormSpalteAender.an(IEinstellungsNr,FWertart{0=String 1=Float 2=Integer},FFeldWertTemp,'geben Sie einen neuen Wert für die Spalte   "'+LabelSortiert.Caption+'"   der gefilterten Artikel an:');
       end;
     end;
     Fparameter3temp:=strtoint(Fparameter[3]);
     If Fparameter[0]='1' Then begin
       Query1.first;
       if FWertart=0 then begin
         while not Query1.eof do begin
           Query1.edit;
           FFeld.Asstring:=Fparameter[2];
           Query1.post;
           Query1.next;
         end;
       end;
       if FWertart=1 then begin
         while not Query1.eof do begin
           Query1.edit;
           if Fparameter[1]='0' Then  FFloatWertTemp:=strToFloat(Fparameter[2]);
           if Fparameter[1]='1' Then  FFloatWertTemp:=FFeld.AsFloat+strToFloat(Fparameter[2]);
           if Fparameter[1]='2' Then  FFloatWertTemp:=FFeld.AsFloat-strToFloat(Fparameter[2]);
           if Fparameter[1]='3' Then  FFloatWertTemp:=FFeld.AsFloat+(FFeld.AsFloat/100*strToFloat(Fparameter[2]));
           if Fparameter[1]='4' Then  FFloatWertTemp:=FFeld.AsFloat-(FFeld.AsFloat/100*strToFloat(Fparameter[2]));
           if Fparameter[3] = '0' Then FFeld.AsFloat:=Round(FFloatWertTemp);
           if (Fparameter3temp>0) and (Fparameter3temp<6)Then FFeld.AsFloat:=StrToFloat(FloattoStrF(FFloatWertTemp,ffNumber,10,Fparameter3temp));
           if Fparameter[3] = '6' Then FFeld.AsFloat:=FFloatWertTemp;
           Query1.post;
           Query1.next;
         end;
       end;
       if FWertart=2 then begin
         while not Query1.eof do begin
           Query1.edit;
           if Fparameter[1]='0' Then  FFeld.AsInteger:=strToInt(Fparameter[2]);
           if Fparameter[1]='1' Then  FFeld.AsInteger:=FFeld.AsInteger+strToInt(Fparameter[2]);
           if Fparameter[1]='2' Then  FFeld.AsInteger:=FFeld.AsInteger-strToInt(Fparameter[2]);
           if Fparameter[1]='3' Then  FFeld.AsInteger:=FFeld.AsInteger+Round((FFeld.AsInteger/100*strToInt(Fparameter[2])));
           if Fparameter[1]='4' Then  FFeld.AsInteger:=FFeld.AsInteger-Round((FFeld.AsInteger/100*strToInt(Fparameter[2])));
           Query1.post;
           Query1.next;
         end;
       end;
     end;
     Fparameter.Free;
   end
   Else FormMaske.Showmodal; //Standartfunktion
   DBGridNeu(SQLSelect,SQLFrom,SQLWhere,SQLOrder);
   FormPlanlos.Gzeiger:= 0;
   //------------------ Unten Fensteranimation
      for i := 1 to Ua do begin
        if Top > Utop then top:=top-Ut Else top:=top+Ut;
        if Left > ULeft then left:=left-Ul Else left:=Left+Ul;
      end;
      Top:=UTop;Left:=ULeft;
  //-------------------------Fensteranimation Ende
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
  ActiveControl:=DBGrid1;
end;
//Datensatz löschen------------------------------------------------------------
procedure TForm1.ButtonLoeschenClick(Sender: TObject);
var Loeschtext1,Loeschtext2,Loeschtext3,ZeitesFeld,DrittesFeld,ViertesFeld:string;
  loeschenJaNein:Boolean;
begin
  if Query1.FieldByName('ReadOnly').ASInteger <> 1 Then begin
    Loeschtext3:='Datensatz löschen ?';
    if (VarType(Query1.Fields[1].Value)=varString)then ZeitesFeld:=Query1.Fields[1].Value Else ZeitesFeld:='';
    if Query1.FieldCount >2 then  if (VarType(Query1.Fields[2].Value)=varString) then DrittesFeld:=Query1.Fields[2].Value Else DrittesFeld:='';
    if Query1.FieldCount >3 then  if (VarType(Query1.Fields[3].Value)=varString) then ViertesFeld:=Query1.Fields[3].Value Else ViertesFeld:='';
    Loeschtext1:= 'Datensatz Nr: '+ inttostr(Query1.Fields[0].Value)+'  '+ZeitesFeld;
    Loeschtext2:= DrittesFeld+'  '+ViertesFeld;
    DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
    if (IEinstellungsNr = 83) then Loeschtext3:='StüeckListen mit allen Artikel löschen';//Sondereinstellung
    loeschenJaNein:= Meldefenster.an(1,Loeschtext1,Loeschtext2,Loeschtext3);
    DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
    if loeschenJaNein then begin
      If (DataModuleDB.DatensatzLoeschen(SQLFrom,Query1.Fields[0].Value) = False) Then begin
        DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
        Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
        DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
        if (IEinstellungsNr = 83) then DataModuleDB.DatensaetzeLoeschen('Stuecklistenartikel','Stuecklisten_Nr',Query1.Fields[0].Value);//Sondereinstellung
      end;
    //if (IEinstellungsNr = 83) then DataModuleDB.DatensaetzeLoeschen('Stuecklistenartikel','Stuecklisten_Nr',Query1.Fields[0].Value);//Sondereinstellung
    DBGridNeu(SQLSelect,SQLFrom,SQLWhere,SQLOrder);
  end;
  end
  Else begin
    DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
    Meldefenster.an(2,'Datensatz konnte nicht gelöscht werden,','weil ReadOnly = 1!','');
    DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
  end;
end;

//Datensatz neu----------------------------------------------------------------
procedure TForm1.ButtonNeuClick(Sender: TObject);
var i:integer;
begin
  //Color:=clGray;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
  //DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  //------------------ oben Fensteranimation
      Ua:=6;UTop:=Top;ULeft:=Left;
      if UTop > (GOffeneFenster*Gtopschritte) then Ut:=UTop-(GOffeneFenster*Gtopschritte) Else Ut:=(GOffeneFenster*Gtopschritte)-UTop;
      if ULeft > (GOffeneFenster*GLeftschritte) then Ul:=ULeft-(GOffeneFenster*GLeftschritte) Else Ul:=(GOffeneFenster*GLeftschritte)-ULeft;
      Ut:=Round(Ut/(Ua));  Ul:=Round(Ul/Ua);
      for i := 1 to Ua do begin
        if UTop > (GOffeneFenster*Gtopschritte) then top:=top-Ut Else top:=top+Ut;if ULeft > (GOffeneFenster*GLeftschritte) then left:=left-Ul Else left:=Left+Ul;
      end;
      Top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;
  //-------------------------Fensteranimation Ende
  //Query1.Close;
  //showmessage(inttostr(IEinstellungsNr)+FelderWennNeu);
  if IEinstellungsNr = 32 then G_Artikelgruppe:=Query1.FieldByName('Artikelgruppe').AsString;
  if FelderWennNeu =''then FormPlanlos.Gzeiger:=DataModuleDB.DatensatzNeu(SQLFrom)
  else FormPlanlos.Gzeiger:=DataModuleDB.DatensatzNeuMit(SQLFrom,FelderWennNeu,FelderWennNeuValue);
  FormPlanlos.GzeigerNeu:=True;
  FormMaske.Showmodal;
  Cnr:=FormPlanlos.Gzeiger;
  DBGridNeu(SQLSelect,SQLFrom,SQLWhere,SQLOrder);
  //Color:=clYellow;
  //------------------ Unten Fensteranimation
      for i := 1 to Ua do begin
        if Top > Utop then top:=top-Ut Else top:=top+Ut;
        if Left > ULeft then left:=left-Ul Else left:=Left+Ul;
      end;
      Top:=UTop;Left:=ULeft;
  //-------------------------Fensteranimation Ende
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
  //DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p);
  ActiveControl:=DBGrid1;
end;

{function TForm1.DatensatzNeu:longint;
{var nr :longint;
    Feldname: String;
  begin
    Feldname:=DBGrid1.Fields[1].FieldName ;
    Query1.Close;
    Query1.SQL.Clear;
    Query1.SQL.Add('Insert Into '+ SQLFrom + #10 + #13 + '('+ Feldname + ') '+ #10 + #13 + 'values '+ #10 + #13 + '(Null)');
    Query1.ExecSQL;
    Query1.Close;
    Query1.SQL.Clear;
    Query1.sql.add('SELECT '+ SQLSelect + ' FROM '+ SQLFrom + ' Order by Nr');
    Query1.open;
    Query1.Last;
    nr:=strtoint(Query1.Fields[0].AsString);
    Result:=nr;
end;}
//Datensatz kopieren------------------------------------------------------------
procedure TForm1.ButtonKopierenClick(Sender: TObject);
var i:integer;//FNrVon:longint;
begin
  //FNrVon:=Query1.Fields[0].Value;
  FormPlanlos.GZeiger:=Query1.Fields[0].Value;
  //Color:=clGray;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
  //DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  //------------------ oben Fensteranimation
      //Ua:=6;
      UTop:=Top;ULeft:=Left;
      if UTop > (GOffeneFenster*Gtopschritte) then Ut:=UTop-(GOffeneFenster*Gtopschritte) Else Ut:=(GOffeneFenster*Gtopschritte)-UTop;
      if ULeft > (GOffeneFenster*GLeftschritte) then Ul:=ULeft-(GOffeneFenster*GLeftschritte) Else Ul:=(GOffeneFenster*GLeftschritte)-ULeft;
      Ut:=Round(Ut/(Ua));  Ul:=Round(Ul/Ua);
      for i := 1 to Ua do begin
        if UTop > (GOffeneFenster*Gtopschritte) then top:=top-Ut Else top:=top+Ut;if ULeft > (GOffeneFenster*GLeftschritte) then left:=left-Ul Else left:=Left+Ul;
      end;
      Top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;
  //-------------------------Fensteranimation Ende
  //Query1.Close;
  CNr:=DataModuleDB.DatensatzKopieren(SQLFrom,FormPlanlos.GZeiger);
  if (IEinstellungsNr = 83) then //Sondereinstellung
  begin
   DataModuleDB.DatensatzKopierenListe('StuecklistenArtikel','StueckListen_Nr',FormPlanlos.GZeiger,CNr);
  end;
  FormPlanlos.GzeigerNeu:=True;
  FormPlanlos.GZeiger:=CNr;
  FormMaske.Showmodal;
  if FormPlanlos.GZeiger = 0 Then
  begin
    FormPlanlos.GZeiger:=CNr;
    If (DataModuleDB.DatensatzLoeschen(SQLFrom,Query1.Fields[0].Value) = False) Then
    begin
      //ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
      //Color:=clGray;
      Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
      //Color:=clYellow;
    end;
  end;
  DBGridNeu(SQLSelect,SQLFrom,SQLWhere,SQLOrder);
  //------------------ Unten Fensteranimation
      for i := 1 to Ua do begin
        if Top > Utop then top:=top-Ut Else top:=top+Ut;
        if Left > ULeft then left:=left-Ul Else left:=Left+Ul;
      end;
      Top:=UTop;Left:=ULeft;
  //-------------------------Fensteranimation Ende
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
  //DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  //  Color:=clYellow;ActiveControl:=DBGrid1;
end;
{var neuerDatensatz,kopierenVon:longint;
    z:integer;
begin
   kopierenVon:=Query1.Fields[0].Value;
   neuerDatensatz:=DatensatzNeu;
   Self.Query2.close;
   Self.Query2.sql.Clear;
   Self.Query2.sql.add('SELECT '+ SQLSelect + ' FROM '+ SQLFrom +
                      ' WHERE  Nr = '+ inttostr(kopierenVon));
  try
    Self.Query2.open;
  finally
  end;
  Query1.edit;
  for z := 1 to SpaltenListe.Count -1 do
     Query1.Fields[z].Value := Query2.Fields[z].Value;
end;}

//Einstellungs-Datensatz suchen------------------------------------------------------------
procedure TForm1.FenstergroesseAbspeichern;
begin
  FormPlanlos.QueryEinstellungForm1L.close;
  FormPlanlos.QueryEinstellungForm1L.SQL.Clear;
  FormPlanlos.QueryEinstellungForm1L.SQL.Add('Select * FROM EinstellungForm1 WHERE Nr = ' + inttostr(GZeigerEinstellung));
  try
    FormPlanlos.QueryEinstellungForm1L.Open
  except
  end;
  FormPlanlos.QueryEinstellungForm1L.edit;
  FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterTop').AsInteger:=top;
  FormPlanlos.QueryEinstellungForm1L.FieldByName('FensterLeft').AsInteger:=left;
  FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterwidth').AsInteger:=width;
  FormPlanlos.QueryEinstellungForm1L.FieldByName('Fensterhoehe').AsInteger:=height;
  FormPlanlos.QueryEinstellungForm1L.post;
  FormPlanlos.QueryEinstellungForm1L.close;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
  Release;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  if GAnimationsgeschwindigkeit=0 then Ua:=18 else  Ua:=GAnimationsgeschwindigkeit;//6
  UTop:=FensterTop;ULeft:=FensterLeft;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,FormPlanlos.GCB);
  GZeigerEinstellung:=FormPlanlos.GZeiger;FormPlanlos.GZeiger:=0;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  if (UTop >0) and (ULeft>0) then begin top:=UTop;Left:=ULeft; End;
  ActiveControl:=DBGrid1;
  {if UReadOnly = 1 then begin
     DBGrid1.ReadOnly:=False;
     Query1.RequestLive:=True;
     Showmessage('Achtung!!! Daten können im Datengitter geändert werden 2');
   end Else begin
     DBGrid1.ReadOnly:=True;
     Query1.RequestLive:=False;
   end;
   ActiveControl:=DBGrid1;}
end;

procedure TForm1.EditZeigerEnter(Sender: TObject);
begin
  EditZeiger.Color:=clYellow;
end;

procedure TForm1.EditZeigerExit(Sender: TObject);
begin
  EditZeiger.Color:=clWindow;
end;

end.
