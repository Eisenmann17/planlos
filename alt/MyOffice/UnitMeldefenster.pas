unit UnitMeldefenster;
{Meldefenster.an  (1=OK        ,Hinweistext1,Hinweistext2,Titel):Boolan
                   2=OK und Esc,Hinweistext1,Hinweistext2,Titel):Boolan
                   3=OK und Esc,Hinweistext1,Hinweistext2,Titel):Boolan /Rückgabe nur wenn mit ja oder Ja geantwortete wurde
                   4=OK und Esc,Hinweistext1,Vorgabetext,Titel):Boolan /Rückgabetext die Variable GMeldefenster
 Meldfenster.text (Meldetext,Vorgabetext,titel                 ):String }
interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TMeldefenster = class(TForm)
    ButtonOK: TButton;
    Buttonabbrechen: TButton;
    Panel1: TPanel;
    LabelEsc: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    ImageTastatur: TImage;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelEnter_p: TLabel;
    LabelEnter: TLabel;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    Function an(art:integer;Text1,Text2,Titel:String):Boolean;
    Function text(Text1,Text2,Titel:String):String;
  end;

var
  Meldefenster:TMeldefenster;
  URueckgabe:Boolean;
  URueckgabetext:String;
  UArt:integer;
implementation
uses UnitModule, UnitDataModul;

{$R *.DFM}

Function TMeldefenster.an(art:integer;Text1,Text2,Titel:String):Boolean;
begin
  ActiveControl:=ButtonOK;
  Caption:=Titel;
  UArt:=art;
  if art= 1 then
  begin
    Buttonabbrechen.Visible:=True;
    //LabelEsc.Caption:='Esc                                        Enter';
    //LabelEsc_P.Caption:=LabelEsc.Caption;
    LabelEnter.Visible:=True;
    LabelEnter_p.Visible:=True;
    LabelEsc_P.Visible:=True;
    LabelEsc.Visible:=True;
    LabelEnter.left:= 218;
    LabelEnter_p.left:= 218;
    LabelEsc_P.left:= 73;
    LabelEsc.left:= 73;
    ButtonOK.left:= 189;
    if titel=''then Caption:='Dialogfenster' Else Caption:=titel;
    Edit1.Visible:=False;
    Label3.Visible:=True;
    Label2.Caption:=Text1;
    Label3.Caption:=Text2;
  end;

  If art= 2 then
  begin
    Buttonabbrechen.Visible:=False;
    //LabelEsc.Caption:='                      Enter';
    //LabelEsc_P.Caption:=LabelEsc.Caption;
    LabelEnter.Visible:=True;
    LabelEnter_p.Visible:=True;
    LabelEsc_P.Visible:=False;
    LabelEsc.Visible:=False;
    LabelEnter.left:= 138;
    LabelEnter_p.left:= 138;
    LabelEsc_P.left:= 73;
    LabelEsc.left:= 73;
    ButtonOK.left:= 116;
    if titel=''then Caption:='Meldefenster' Else Caption:=titel;
    Edit1.Visible:=False;
    Label3.Visible:=True;
    Label2.Caption:=Text1;
    Label3.Caption:=Text2;
  end;

  If art= 3 then
  begin
    Buttonabbrechen.Visible:=True;
    //LabelEsc.Caption:='Esc                                        Enter';
    //LabelEsc_P.Caption:=LabelEsc.Caption;
    LabelEnter.Visible:=True;
    LabelEnter_p.Visible:=True;
    LabelEsc_P.Visible:=True;
    LabelEsc.Visible:=True;
    LabelEnter.left:= 218;
    LabelEnter_p.left:= 218;
    LabelEsc_P.left:= 73;
    LabelEsc.left:= 73;
    ButtonOK.left:= 189;
    if titel=''then Caption:='Dialogfenster' Else Caption:=titel;
    Edit1.Visible:=True;
    Label3.Visible:=True;
    Label2.Caption:=Text1;Label2.Left:=8;
    Label3.Caption:=Text2;Label3.Left:=8;
    URueckgabe:=False;

    Edit1.text:='Nein';
    Edit1.Left:=250;
    Edit1.Width:=50;
  end;

  If art= 4 then
  begin
    Buttonabbrechen.Visible:=True;
    //LabelEsc.Caption:='Esc                                        Enter';
    //LabelEsc_P.Caption:=LabelEsc.Caption;
    LabelEnter.Visible:=True;
    LabelEnter_p.Visible:=True;
    LabelEsc_P.Visible:=True;
    LabelEsc.Visible:=True;
    LabelEnter.left:= 218;
    LabelEnter_p.left:= 218;
    LabelEsc_P.left:= 73;
    LabelEsc.left:= 73;
    ButtonOK.left:= 189;
    if titel=''then Caption:='Dialogfenster' Else Caption:=titel;
    Edit1.Visible:=True;
    Label3.Visible:=False;
    Label2.Caption:=Text1;Label2.Left:=8;
    //Label3.Caption:=Text2;Label3.Left:=8;
    URueckgabe:=False;

    Edit1.text:=Text2;
    Edit1.Left:=8;
    Edit1.Width:=450;
  end;
  //Edit1.Visible:=False;
  //Label3.Visible:=True;
  //Label2.Caption:=Text1;
  //Label3.Caption:=Text2;
  Showmodal;
  If art= 4 then GMeldefenster:=Edit1.text;
  Result:=URueckgabe;
end;

Function TMeldefenster.text(Text1,Text2,Titel:String):string;
begin
  Edit1.Visible:=True;
  Label3.Visible:=False;
  Edit1.text:=Text2;
  Label2.Caption:=Text1;
  if titel=''then Caption:='Meldefenster' Else Caption:=titel;
  Showmodal;
  Result:=URueckgabetext;
end;

procedure TMeldefenster.ButtonOKClick(Sender: TObject);
begin
  URueckgabetext:=Edit1.text;
  if (UArt = 3) then begin
    if (URueckgabetext='Ja') or (URueckgabetext='ja') then URueckgabe:=True Else URueckgabe:=False;
  end
  else URueckgabe:=True;
  close;
end;

procedure TMeldefenster.ButtonabbrechenClick(Sender: TObject);
begin
  Edit1.text:='';
  URueckgabetext:='';
  URueckgabe:=False;
  Close;
end;

procedure TMeldefenster.FormActivate(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelEnter,LabelESC,LabelESC,LabelESC,LabelESC,LabelESC,LabelESC,LabelESC,LabelESC,LabelESC,LabelESC,LabelESC,LabelESC_p,LabelEnter_p,LabelESC_p,LabelESC_p,LabelESC_p,LabelESC_p,LabelESC_p,LabelESC_p,LabelESC_p,LabelESC_p,LabelESC_p,LabelESC_p,LabelESC_p,FormPlanlos.GCB);
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
end;

procedure TMeldefenster.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

procedure TMeldefenster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonAbbrechenClick(Self);
  if Key = VK_RETURN then ButtonOkClick(Self);
end;

end.
