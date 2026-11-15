unit UnitImport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFormImport = class(TForm)
    OpenDialog1: TOpenDialog;
    LabelDatei: TLabel;
    ButtonDatei: TButton;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    LabelESC: TLabel;
    LabelF10: TLabel;
    Buttonabbrechen: TButton;
    ButtonStart: TButton;
    LabelFortlauf: TLabel;
    ButtonOk: TButton;
    ImageTastatur: TImage;
    Label1: TLabel;
    ComboBoxImportTabelle: TComboBox;
    ButtonersteZeileEinlesen: TButton;
    ListBoxersteZeile: TListBox;
    Label3: TLabel;
    EditTrennzeichen: TEdit;
    Label4: TLabel;
    EditZeileEinlesen: TEdit;
    Label5: TLabel;
    Label2: TLabel;
    EditabderZeile: TEdit;
    Label6: TLabel;
    Panel1: TPanel;
    Label7: TLabel;
    ListBoxTabellenFelder: TListBox;
    ListBoxFelderReihenfolgeImport: TListBox;
    QueryImport: TZQuery;
    DataSourceImport: TDataSource;
    Button1einfuegen: TButton;
    Button1zurueck: TButton;
    ButtonalleEinfuegen: TButton;
    ButtonAlleZurueck: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Buttonoben: TButton;
    Buttonunten: TButton;
    Label11: TLabel;
    Label12: TLabel;
    Panel2: TPanel;
    ButtonLeerfeld: TButton;
    procedure ButtonDateiClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonersteZeileEinlesenClick(Sender: TObject);
    procedure ComboBoxImportTabelleChange(Sender: TObject);
    procedure Button1einfuegenClick(Sender: TObject);
    procedure Button1zurueckClick(Sender: TObject);
    procedure ButtonalleEinfuegenClick(Sender: TObject);
    procedure ButtonAlleZurueckClick(Sender: TObject);
    procedure ButtonobenClick(Sender: TObject);
    procedure ButtonuntenClick(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonLeerfeldClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormImport: TFormImport;

implementation

uses UnitDataModul, UnitModule;

{$R *.DFM}

procedure TFormImport.ButtonDateiClick(Sender: TObject);
  Var Done: Boolean;
begin
  Done:=False;
  while not Done do  begin
    if OpenDialog1.Execute then begin
      ButtonDatei.Caption:=OpenDialog1.FileName;
      Done := True;
    end
  else { Abbruch durch Benutzer }
    Done := True;
  end;
end;

procedure TFormImport.FormActivate(Sender: TObject);
begin
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  LabelFortlauf.Caption:='0'+' Datensätze eingelesen';
end;

procedure TFormImport.ButtonabbrechenClick(Sender: TObject);
begin
  Close;
end;

procedure TFormImport.ButtonOkClick(Sender: TObject);
begin
  Close;
end;

procedure TFormImport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormImport.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F10 then ButtonOKClick(Self);
end;

procedure TFormImport.ButtonersteZeileEinlesenClick(Sender: TObject);
var datendatei:System.text;
    zeile1,zeile2,zeile3,Zeile4,Zeile5,Zeile6,Zeile7,Zeile8,Zeile9,Zeile10:String;
    z,i:integer;
    Zeichen:String;
    Feld:String;
begin
  if FileExists(ButtonDatei.Caption) then begin
    Reset(datendatei,ButtonDatei.Caption);
    z:=0;
    While z<strtoint(EditZeileEinlesen.text) do begin
      readln(datendatei,zeile1);
      Z:=Z+1;
    end;
    Feld:='';
    CloseFile(datendatei);
    ListBoxersteZeile.Items.Clear;
    for i:=1 to length(zeile1)do begin
      Zeichen:=copy(zeile1,i,1);
      if Zeichen<>EditTrennzeichen.text then Feld:=Feld+Zeichen
      else begin
        ListBoxersteZeile.Items.Add(Feld);
        Feld:='';
      end;
    end;
  end;
end;

procedure TFormImport.ComboBoxImportTabelleChange(Sender: TObject);
  Var i:integer;
begin
  ListBoxTabellenFelder.Items.Clear;
  ListBoxFelderReihenfolgeImport.Items.Clear;
  if QueryImport.Active then QueryImport.close;
  QueryImport.sql.Clear;
  QueryImport.sql.add('Select * From '+ ComboBoxImportTabelle.Text);
  try QueryImport.open; finally end;
  for i := 0 to QueryImport.FieldCount - 1 do begin
    if QueryImport.Fields[i].IsBlob = False  then begin
       ListBoxTabellenFelder.Items.Add(QueryImport.Fields[i].FieldName);
    end
  end;
  QueryImport.close;
end;

procedure TFormImport.Button1einfuegenClick(Sender: TObject);
begin
  if ListBoxTabellenFelder.ItemIndex > -1 then begin
    ListBoxFelderReihenfolgeImport.Items.Add(ListBoxTabellenFelder.Items[ListBoxTabellenFelder.ItemIndex]);
    ListBoxTabellenFelder.Items.Delete(ListBoxTabellenFelder.ItemIndex);
    //FocusControl(ListBoxTabellenFelder);
    ActiveControl:=ListBoxTabellenFelder;
  end;
end;

procedure TFormImport.Button1zurueckClick(Sender: TObject);
begin
  if ListBoxFelderReihenfolgeImport.ItemIndex > -1 then begin
    if ListBoxFelderReihenfolgeImport.Items[ListBoxFelderReihenfolgeImport.ItemIndex]<>'leer' Then
      ListBoxTabellenFelder.Items.Add(ListBoxFelderReihenfolgeImport.Items[ListBoxFelderReihenfolgeImport.ItemIndex]);
    ListBoxFelderReihenfolgeImport.Items.Delete(ListBoxFelderReihenfolgeImport.ItemIndex);
    //FocusControl(ListBoxTabellenFelder);
    ActiveControl:=ListBoxTabellenFelder;
  end;
end;

procedure TFormImport.ButtonalleEinfuegenClick(Sender: TObject);
begin
   ListBoxFelderReihenfolgeImport.Items.AddStrings(ListBoxTabellenFelder.Items);
   ListBoxTabellenFelder.Clear;
end;

procedure TFormImport.ButtonAlleZurueckClick(Sender: TObject);
begin
  ListBoxTabellenFelder.Items.AddStrings(ListBoxFelderReihenfolgeImport.Items);
  ListBoxFelderReihenfolgeImport.Clear;
end;

procedure TFormImport.ButtonobenClick(Sender: TObject);
begin
  if ListBoxFelderReihenfolgeImport.ItemIndex >= 1 then begin
    ListBoxFelderReihenfolgeImport.Items.Move(ListBoxFelderReihenfolgeImport.ItemIndex,ListBoxFelderReihenfolgeImport.ItemIndex-1);
    ActiveControl:=ListBoxFelderReihenfolgeImport;
  end;
end;

procedure TFormImport.ButtonuntenClick(Sender: TObject);
begin
  if ListBoxFelderReihenfolgeImport.ItemIndex < ListBoxFelderReihenfolgeImport.Items.Count-1 then begin
    ListBoxFelderReihenfolgeImport.Items.Move(ListBoxFelderReihenfolgeImport.ItemIndex,ListBoxFelderReihenfolgeImport.ItemIndex+1);
    ActiveControl:=ListBoxFelderReihenfolgeImport;
  end;
end;

procedure TFormImport.ButtonStartClick(Sender: TObject);
  Var i,DateiZeile:integer;
  datendatei:System.text;
  zeile1,zeile2,zeile3,Zeile4,Zeile5,Zeile6,Zeile7,Zeile8,Zeile9,Zeile10:String;
  Feld,Zeichen:String;
  DBSpaltenZahl:integer;
begin
  if QueryImport.Active then QueryImport.close;
  QueryImport.sql.Clear;
  QueryImport.sql.add('Select * From '+ ComboBoxImportTabelle.Text);
  try QueryImport.open; finally end;
  if FileExists(ButtonDatei.Caption) then begin
    Reset(datendatei,ButtonDatei.Caption);
    DBSpaltenZahl:=0;
    DateiZeile:=0;
    while not Eof(datendatei) do begin
      LabelFortlauf.Caption:=inttostr(DateiZeile)+' Datensätze eingelesen';
      DateiZeile:=DateiZeile+1;
      readln(datendatei,zeile1);
      Feld:='';
      DBSpaltenZahl:=0;
      if DateiZeile>=strtoint(EditabderZeile.Text) then begin
        QueryImport.Append;
        QueryImport.Edit;
        for i:=1 to length(zeile1)do begin
          Zeichen:=copy(zeile1,i,1);
          if Zeichen<>EditTrennzeichen.text then
            Feld:=Feld+Zeichen
          else begin
            if DBSpaltenZahl <= ListBoxFelderReihenfolgeImport.Items.Count then begin
              if Feld<>'leer' then  QueryImport.FieldByName(ListBoxFelderReihenfolgeImport.Items[DBSpaltenZahl]).AsString:=Feld;
            end;
            DBSpaltenZahl:=DBSpaltenZahl+1;
            Feld:='';
          end;
        end;
        QueryImport.post;
      end;
    end;
    CloseFile(datendatei);
  end;
  QueryImport.close;
end;

procedure TFormImport.ButtonLeerfeldClick(Sender: TObject);
begin
  ListBoxFelderReihenfolgeImport.Items.Add('leer');
end;

end.
