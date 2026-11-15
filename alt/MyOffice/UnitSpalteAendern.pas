unit UnitSpalteAendern;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFormSpalteAender = class(TForm)
    RadioGroupWertart: TRadioGroup;
    EditWert: TEdit;
    PanelTastatur: TPanel;
    ImageTastatur: TImage;
    RadioGroupKommastzelle: TRadioGroup;
    LabelHilfetext: TLabel;
    Buttonabbrechen: TButton;
    ButtonOk: TButton;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    LabelESC: TLabel;
    LabelF10: TLabel;
    LabelProbewert: TLabel;
    LabelProbewertText: TLabel;
    Label2: TLabel;
    ButtonTest: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonTestClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    class function  an(Fensternr:integer;Wertart:integer;Probewert:Real;Hilfetext:String):TStringList;
  end;

var
  FormSpalteAender: TFormSpalteAender;
  UParSR:TStringList;UFensternr,UWertart:integer;//0=String 1=Float 2=Integer
  UProbewert:Real;
  UHilfetext:String;
implementation

uses UnitDataModul, UnitModule;

{$R *.DFM}

class function  TFormSpalteAender.an(Fensternr:integer;Wertart:integer;Probewert:Real;Hilfetext:String):TStringList;
begin
  UFensternr:=Fensternr;
  UWertart:=Wertart;
  UProbewert:=Probewert;
  UHilfetext:=Hilfetext;
  FormSpalteAender.ShowModal;
  Result:=UParSR;
end;

procedure TFormSpalteAender.FormActivate(Sender: TObject);
begin
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelESC_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  UParSR:=TStringList.Create;
  UParSR.add('0');//0
  UParSR.add('0');//1
  UParSR.add('0');//2
  UParSR.add('2');//3
  //UFensternr
  if (UWertart=0)then begin
    RadioGroupKommastzelle.Visible:=False;
    RadioGroupWertart.Visible:=False;
    LabelProbewertText.Visible:=False;
    ButtonTest.Visible:=False;
    LabelProbewert.Visible:=False;
  end;
  if (UWertart=2)then begin
    LabelProbewertText.Visible:=True;
    RadioGroupKommastzelle.Visible:=False;
    RadioGroupWertart.Visible:=True;
    ButtonTest.Visible:=True;
    LabelProbewert.Visible:=True;
  end;
  if (UWertart=1)then begin
    LabelProbewertText.Visible:=True;
    RadioGroupKommastzelle.Visible:=True;
    RadioGroupWertart.Visible:=True;
    ButtonTest.Visible:=True;
    LabelProbewert.Visible:=True;
  end;
  if (UWertart=1) then begin
     LabelProbewert.caption:=FloatToStr(UProbewert);
  end;
  if (UWertart=2) then begin
     LabelProbewert.caption:=FloatToStr(UProbewert);
  end;
  LabelHilfetext.Caption:=UHilfetext;
end;

procedure TFormSpalteAender.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

procedure TFormSpalteAender.ButtonOkClick(Sender: TObject);
begin
  UParSR[0]:='1';
  UParSR[1]:=inttostr(RadioGroupWertart.ItemIndex);
  UParSR[2]:=EditWert.text;
  UParSR[3]:=inttostr(RadioGroupKommastzelle.ItemIndex);
  Close;
end;

procedure TFormSpalteAender.ButtonabbrechenClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSpalteAender.ButtonTestClick(Sender: TObject);
Var FNeuerWertFeld,FAlterWert:Real;
begin
   FAlterWert:=strtoFloat(LabelProbewert.caption);
   FNeuerWertFeld:=strtoFloat(EditWert.text);
   if RadioGroupWertart.ItemIndex=0 Then  FNeuerWertFeld:=FNeuerWertFeld;
   if RadioGroupWertart.ItemIndex=1 Then  FNeuerWertFeld:=FAlterWert+FNeuerWertFeld;
   if RadioGroupWertart.ItemIndex=2 Then  FNeuerWertFeld:=FAlterWert-FNeuerWertFeld;
   if RadioGroupWertart.ItemIndex=3 Then  FNeuerWertFeld:=FAlterWert+(FAlterWert/100*FNeuerWertFeld);
   if RadioGroupWertart.ItemIndex=4 Then  FNeuerWertFeld:=FAlterWert-(FAlterWert/100*FNeuerWertFeld);
   if RadioGroupKommastzelle.ItemIndex=0 Then LabelProbewert.Caption:=FloattoStr(Round(FNeuerWertFeld));
   if (RadioGroupKommastzelle.ItemIndex>0) and (RadioGroupKommastzelle.ItemIndex<6) Then LabelProbewert.Caption:=FloattoStrF(FNeuerWertFeld,ffNumber,10,RadioGroupKommastzelle.ItemIndex);
   if RadioGroupKommastzelle.ItemIndex=0 Then LabelProbewert.Caption:=FloattoStr(FNeuerWertFeld);
end;

procedure TFormSpalteAender.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F10 then ButtonOKClick(Self);
end;

end.
