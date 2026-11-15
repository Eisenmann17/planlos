unit UnitDatum;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, Calendar;

type
  TFormDatum = class(TForm)
    CalenderTag: TCalendar;
    LabelTag: TLabel;
    LabelMonat: TLabel;
    LabelJahr: TLabel;
    ComboBoxMonat: TComboBox;
    ComboBoxJahr: TComboBox;
    ButtonAbbrechen: TButton;
    LabelEsc: TLabel;
    LabelF6: TLabel;
    ButtonHeute: TButton;
    LabelF10: TLabel;
    ButtonOK: TButton;
    ImageTastatur: TImage;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF6_p: TLabel;
    LabelF10_p: TLabel;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonAbbrechenClick(Sender: TObject);
    function an(Fdatum:String;x,Y:Integer):String;
    function datumAusKalender:TDateTime;
    procedure JahrMonatzumKalender;
    procedure DatumzumKalender(Fdatum:TDateTime);
    procedure ComboBoxJahrChange(Sender: TObject);
    procedure ComboBoxMonatChange(Sender: TObject);
    procedure ButtonHeuteClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormDatum: TFormDatum;
  UTag,UMonat,UJahr:Word;
  UDatum:TDateTime;
  UDatumStr:String;
  UOK:integer;

implementation

uses UnitModule, UnitDataModul;

{$R *.DFM}

procedure TFormDatum.ButtonOKClick(Sender: TObject);
begin
  UDatum:=datumAusKalender;
  UOK:=1;
  Close;
end;

function TFormDatum.an(Fdatum:String;x,Y:Integer):String;
begin
  UOK:=0;
  Left:=x;top:=y;
  //UDatum:=FDatum;
  //Showmessage(DateToStr(UDatum));
  if FDatum = '' then UDatum:=now Else Udatum:=StrtoDate(FDatum);
  DatumzumKalender(Udatum);
  FormDatum.ShowModal;
  If UOK = 1 Then UDatumStr:= DateToStr(UDatum) Else UDatumStr:='';
  Result:=UDatumStr;
end;


procedure TFormDatum.ButtonAbbrechenClick(Sender: TObject);
begin
  Close;
end;

function TFormDatum.datumAusKalender:TDateTime;
var Year, Month, Day: Word;
begin
  Year:=CalenderTag.Year;
  Month:=CalenderTag.Month;
  Day:=CalenderTag.Day;
  Result:=EncodeDate(Year, Month, Day);
end;

procedure TFormDatum.JahrMonatzumKalender;
var Year, Month, Day: Word;
begin
  CalenderTag.Year:=strtoint(ComboBoxJahr.text);
  CalenderTag.Month:=ComboBoxMonat.ItemIndex + 1;
end;

procedure TFormDatum.DatumzumKalender(Fdatum:TDateTime);
var Year, Month, Day: Word;
begin
  DecodeDate(Fdatum, Year, Month, Day);
  CalenderTag.Year:=Year;
  CalenderTag.Month:=Month;
  CalenderTag.Day:=Day;
  ComboBoxJahr.text:=inttostr(year);
  ComboBoxMonat.ItemIndex:=Month - 1;
end;

procedure TFormDatum.ComboBoxJahrChange(Sender: TObject);
begin
  JahrMonatzumKalender;
end;

procedure TFormDatum.ComboBoxMonatChange(Sender: TObject);
begin
  JahrMonatzumKalender;
end;

procedure TFormDatum.ButtonHeuteClick(Sender: TObject);
begin
  DatumzumKalender(now);
end;

procedure TFormDatum.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonAbbrechenClick(Self);
  if Key = VK_F6 then ButtonHeuteClick(Self);
  if Key = VK_RETURN then ButtonOkClick(Self);
  if Key = VK_F10 then ButtonOkClick(Self);
end;

procedure TFormDatum.FormActivate(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau2.bmp');
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF6,LabelF10,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelF6,LabelEsc_p,LabelF6_p,LabelF10_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,LabelF6_p,FormPlanlos.GCB);
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
end;

procedure TFormDatum.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

end.
