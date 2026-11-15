unit UnitFilter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFormFilter = class(TForm)
    ComboBoxF1Spalte: TComboBox;
    ComboBoxF1Operand: TComboBox;
    EditF2: TEdit;
    CheckBoxF1: TCheckBox;
    GroupBoxF2: TGroupBox;
    GroupBoxF1: TGroupBox;
    CheckBoxF2: TCheckBox;
    ComboBoxF2Spalte: TComboBox;
    ComboBoxF2Operand: TComboBox;
    EditF1: TEdit;
    CheckBoxF3: TCheckBox;
    GroupBoxF3: TGroupBox;
    ComboBoxF3Spalte: TComboBox;
    ComboBoxF3Operand: TComboBox;
    EditF3: TEdit;
    ComboBoxAndOr1: TComboBox;
    ComboBoxAndOr2: TComboBox;
    LabelInfo: TLabel;
    Label1: TLabel;
    ButtonEsc: TButton;
    ButtonF10: TButton;
    LabelEsc: TLabel;
    LabelF10: TLabel;
    ImageTastatur: TImage;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    procedure ButtonF10Click(Sender: TObject);
    procedure ButtonEscClick(Sender: TObject);
    function  An(sqlList,spaltlist:TStringList):TStringList;
    procedure  KomponentsToList;
    procedure  ListeToKomponents;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBoxF2Click(Sender: TObject);
    procedure CheckBoxF1Click(Sender: TObject);
    procedure CheckBoxF3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormFilter: TFormFilter;
  FilterSqlWhereList: TStringlist;
  ablauf: String;

implementation

uses UnitModule, UnitDataModul;

{$R *.DFM}

function TFormFilter.An(sqlList,spaltlist:TStringList):TStringList;
begin
  FilterSqlWhereList:=TStringList.Create;
  FilterSqlWhereList:=sqlList;
  ablauf:='Aus';
  ComboBoxF1Spalte.text:=spaltlist[0];
  ComboBoxF1Spalte.Items:=spaltlist;
  ComboBoxF2Spalte.text:=spaltlist[0];
  ComboBoxF2Spalte.Items:=spaltlist;
  ComboBoxF3Spalte.text:=spaltlist[0];
  ComboBoxF3Spalte.Items:=spaltlist;
  ListeToKomponents;  
  ShowModal;
  if ablauf <>'abbrechen' then begin
    KomponentsToList;
    if ablauf <> 'An' then FilterSQLWhereList.clear;
    Result:=FilterSqlWhereList;
    end
  Else
    Result:=sqlList;
 // showmessage(Result.Strings[0]);
 //FilterSqlWhereList.free;
end;

procedure TFormFilter.KomponentsToList;
begin
  if CheckBoxF1.Checked = True Then begin
    ablauf:='An';
    FilterSqlWhereList.clear;
    FilterSqlWhereList.Add(ComboBoxF1Spalte.text);
    FilterSqlWhereList.Add(ComboBoxF1Operand.text);
    FilterSqlWhereList.Add(EditF1.text);
    if CheckBoxF2.Checked = True Then begin
      FilterSqlWhereList.Add(ComboBoxAndOr1.text);
      FilterSqlWhereList.Add(ComboBoxF2Spalte.text);
      FilterSqlWhereList.Add(ComboBoxF2Operand.text);
      FilterSqlWhereList.Add(EditF2.text);
      if CheckBoxF3.Checked = True Then begin
        FilterSqlWhereList.Add(ComboBoxAndOr2.text);
        FilterSqlWhereList.Add(ComboBoxF3Spalte.text);
        FilterSqlWhereList.Add(ComboBoxF3Operand.text);
        FilterSqlWhereList.Add(EditF3.text);
      end;
    end;
  end;
end;

procedure TFormFilter.ListeToKomponents;
var i:integer;
    t:String;
begin
  //showmessage(inttostr(FilterSqlWhereList.count));
  if FilterSqlWhereList.count > 2 Then begin
    CheckBoxF1.Checked:=True;
    //showmessage(FilterSqlWhereList.Strings[1]);
    //showmessage(FilterSqlWhereList.Strings[0]);
    ComboBoxF1Spalte.text:=FilterSqlWhereList.Strings[0];
    ComboBoxF1Operand.text:=FilterSqlWhereList.Strings[1];
    EditF1.text:=FilterSqlWhereList.Strings[2];
    if FilterSqlWhereList.count > 6 Then begin
      CheckBoxF2.Checked:=True;
      ComboBoxAndOr1.text:=FilterSqlWhereList.Strings[3];
      ComboBoxF2Spalte.text:=FilterSqlWhereList.Strings[4];
      ComboBoxF2Operand.text:=FilterSqlWhereList.Strings[5];
      EditF2.text:=FilterSqlWhereList.Strings[6];
      if FilterSqlWhereList.count > 10 Then begin
        CheckBoxF3.Checked:=True;
        ComboBoxAndOr2.text:=FilterSqlWhereList.Strings[7];
        ComboBoxF3Spalte.text:=FilterSqlWhereList.Strings[8];
        ComboBoxF3Operand.text:=FilterSqlWhereList.Strings[9];
        EditF3.text:=FilterSqlWhereList.Strings[10];
      end;
    end;
  end;
  CheckBoxF1Click(Self);
  CheckBoxF2Click(Self);
  CheckBoxF3Click(Self);
end;

procedure TFormFilter.ButtonF10Click(Sender: TObject);
begin
  Close;
end;

procedure TFormFilter.ButtonEscClick(Sender: TObject);
begin
  ablauf:='abbrechen';
  close;
end;

procedure TFormFilter.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonEscClick(Self);
  if Key = VK_RETURN then ButtonF10Click(Self);
  if Key = VK_F10 then ButtonF10Click(Self);
end;

procedure TFormFilter.CheckBoxF1Click(Sender: TObject);
begin
  if CheckBoxF1.Checked  Then begin
    ComboBoxF1Spalte.Visible:=True;
    ComboBoxF1Operand.Visible:=True;
    EditF1.Visible:=True; end
  Else begin
    ComboBoxF1Spalte.Visible:=False;
    ComboBoxF1Operand.Visible:=False;
    EditF1.Visible:=False;
    CheckBoxF2.Checked := False;
    CheckBoxF2Click(Self);
    CheckBoxF3.Checked := False;
    CheckBoxF3Click(Self);
    end;
end;

procedure TFormFilter.CheckBoxF2Click(Sender: TObject);
begin
  if (CheckBoxF2.Checked and CheckBoxF1.Checked) Then begin
    ComboBoxF2Spalte.Visible:=True;
    ComboBoxF2Operand.Visible:=True;
    EditF2.Visible:=True;
    ComboBoxAndOr1.Visible:=True; end
  Else begin
    ComboBoxF2Spalte.Visible:=False;
    ComboBoxF2Operand.Visible:=False;
    EditF2.Visible:=False;
    ComboBoxAndOr1.Visible:=False;
    CheckBoxF3.Checked := False;
    CheckBoxF3Click(Self);
    end;
end;

procedure TFormFilter.CheckBoxF3Click(Sender: TObject);
begin
  if (CheckBoxF3.Checked and CheckBoxF2.Checked and CheckBoxF1.Checked) Then begin
    ComboBoxF3Spalte.Visible:=True;
    ComboBoxF3Operand.Visible:=True;
    EditF3.Visible:=True;
    ComboBoxAndOr2.Visible:=True; end
  Else begin
    ComboBoxF3Spalte.Visible:=False;
    ComboBoxF3Operand.Visible:=False;
    EditF3.Visible:=False;
    ComboBoxAndOr2.Visible:=False; end;
end;

procedure TFormFilter.FormActivate(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormFilter.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

end.
