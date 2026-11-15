unit UnitEinstellungenFenster;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, DBCtrls, ExtDlgs;

type
  TFormEinstellungenFenster = class(TForm)
    Label12: TLabel;
    DBRadioGroupTastaturActic: TDBRadioGroup;
    PanelButtonDateiActiv: TPanel;
    PanelButtonFarbeactiv: TPanel;
    PanelButtonFontColorActiv: TPanel;
    Label13: TLabel;
    DBRadioGroupButtonNichtactiv: TDBRadioGroup;
    PanelButtonDateinichtActiv: TPanel;
    PanelButtonFarbenichtactiv: TPanel;
    PanelButtonFontColorNichtActiv: TPanel;
    Label19: TLabel;
    ColorDialog1: TColorDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    Buttonabbrechen: TButton;
    ButtonSpeichern: TButton;
    ImageTastatur: TImage;
    LabelEsc: TLabel;
    LabelF10: TLabel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormEinstellungenFenster: TFormEinstellungenFenster;

implementation

{$R *.DFM}

end.
