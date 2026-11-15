unit Eingang;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TFormEingang = class(TForm)
    ButtonOk: TButton;
    ButtonAbbrechen: TButton;
    LabelAnwender: TLabel;
    LabelPasswort: TLabel;
    EditAnwender: TEdit;
    EditPasswort: TEdit;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    LabelEsc: TLabel;
    LabelF10: TLabel;
    ImageTastatur: TImage;
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonAbbrechenClick(Sender: TObject);
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
  FormEingang: TFormEingang;

implementation

uses UnitModule, UnitDataModul;

//uses UnitModule;

{$R *.DFM}

procedure TFormEingang.ButtonOkClick(Sender: TObject);
begin
  FormEingang.Visible:=False;
  FormPlanlos.Show;
end;

procedure TFormEingang.ButtonAbbrechenClick(Sender: TObject);
begin
  Close;
end;

procedure TFormEingang.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F10 then ButtonOKClick(Self);
end;

procedure TFormEingang.FormActivate(Sender: TObject);
begin
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormEingang.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

end.
