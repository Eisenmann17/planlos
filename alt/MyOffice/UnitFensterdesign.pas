unit UnitFensterdesign;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls, Mask,
  DBCtrls, ExtCtrls, ExtDlgs;

type
  TFensterdesigne = class(TForm)
    DBRadioGroupTastaturActic: TDBRadioGroup;
    Label13: TLabel;
    DBRadioGroupButtonNichtactiv: TDBRadioGroup;
    Label19: TLabel;
    PanelButtonDateiActiv: TPanel;
    PanelButtonFarbeactiv: TPanel;
    PanelButtonFontColorActiv: TPanel;
    PanelButtonDateinichtActiv: TPanel;
    PanelButtonFarbenichtactiv: TPanel;
    PanelButtonFontColorNichtActiv: TPanel;
    ImageTastatur: TImage;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    Buttonabbrechen: TButton;
    ButtonSpeichern: TButton;
    LabelEsc: TLabel;
    LabelF10: TLabel;
    DBEditName: TDBEdit;
    DataSourceFensterdesign: TDataSource;
    QueryFensterdesign: TZQuery;
    Label1: TLabel;
    ColorDialog1: TColorDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    DBCheckBoxCascade: TDBCheckBox;
    DBEditAnimation: TDBEdit;
    Label2: TLabel;
    ButtonBildZeigen: TButton;
    Image1: TImage;
    LabelDateinameBildfarben: TLabel;
    RadioGroupFarbeKopieren: TRadioGroup;
    RadioGroupZeigeAenderung: TRadioGroup;
    procedure DBRadioGroupTastaturActicChange(Sender: TObject);
    procedure DBRadioGroupButtonNichtactivChange(Sender: TObject);
    procedure PanelButtonDateiActivClick(Sender: TObject);
    procedure PanelButtonDateinichtActivClick(Sender: TObject);
    procedure PanelButtonFarbeactivClick(Sender: TObject);
    procedure PanelButtonFontColorActivClick(Sender: TObject);
    procedure PanelButtonFarbenichtactivClick(Sender: TObject);
    procedure PanelButtonFontColorNichtActivClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonSpeichernClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonBildZeigenClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ZeigeAenderung;
    procedure RadioGroupZeigeAenderungClick(Sender: TObject);
    procedure RadioGroupFarbeKopierenClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Fensterdesigne: TFensterdesigne;
  UZeigerNeu:Boolean;
  UButtonDateinameNichtActiv,UButtonDateinameActiv,UButtonFarbeActive,UButtonFarbeNichtActive:String;UButtonFeldActiv,UButtonFeldNichtActiv:Integer;
  UButtonFontColorActiv,UButtonFontColorNichtActiv:String;
implementation
uses UnitModule, UnitMeldefenster, UnitDB,UnitDataModul;

{$R *.DFM}

procedure TFensterdesigne.DBRadioGroupTastaturActicChange(Sender: TObject);
begin
  if DBRadioGroupTastaturActic.ItemIndex = 0 then begin
    PanelButtonDateiActiv.Visible:=False;
    PanelButtonFarbeactiv.Visible:=False;
  end;
  if DBRadioGroupTastaturActic.ItemIndex = 1 then begin
    PanelButtonDateiActiv.Visible:=True;
    PanelButtonFarbeactiv.Visible:=True;
    //PanelButtonDateiActiv.Caption:=QueryAllgemeineEinstellungen.FieldByName('ButtonDateiActive').AsString;
  end;
  if DBRadioGroupTastaturActic.ItemIndex = 2 then begin
    PanelButtonDateiActiv.Visible:=False;
    PanelButtonFarbeactiv.Visible:=True;
    //PanelButtonFarbeactiv.Color:=stringtocolor(QueryAllgemeineEinstellungen.FieldByName('ButtonFarbeActive').AsString);
  end;
  ZeigeAenderung;
end;

procedure TFensterdesigne.DBRadioGroupButtonNichtactivChange(
  Sender: TObject);
begin
  if DBRadioGroupButtonNichtactiv.ItemIndex = 0 then begin
    PanelButtonDateiNichtActiv.Visible:=False;
    PanelButtonFarbeNichtactiv.Visible:=False;
  end;
  if DBRadioGroupButtonNichtactiv.ItemIndex = 1 then begin
    PanelButtonDateiNichtActiv.Visible:=True;
    PanelButtonFarbeNichtactiv.Visible:=True;
    //PanelButtonDateiNichtActiv.Caption:=QueryAllgemeineEinstellungen.FieldByName('ButtonDateiNichtActive').AsString;
  end;
  if DBRadioGroupButtonNichtactiv.ItemIndex = 2 then begin
    PanelButtonDateiNichtActiv.Visible:=False;
    PanelButtonFarbeNichtactiv.Visible:=True;
    //PanelButtonFarbeNichtactiv.Color:=stringtocolor(QueryAllgemeineEinstellungen.FieldByName('ButtonFarbeNichtActive').AsString);
  end;
  ZeigeAenderung;
end;

procedure TFensterdesigne.PanelButtonDateiActivClick(Sender: TObject);
var Done:Boolean;
begin
  Done:=False;
  OpenPictureDialog1.DefaultExt := GraphicExtension(TBitmap);
  OpenPictureDialog1.FileName := GraphicFileMask(TBitmap);
  OpenPictureDialog1.Filter := GraphicFilter(TBitmap);
  OpenPictureDialog1.Options := [ofFileMustExist{, ofHideReadOnly}, ofNoChangeDir ];
  while not Done do  begin
    if OpenPictureDialog1.Execute then begin
       //Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
       //UDateinameActiv:=OpenPictureDialog1.FileName;
      PanelButtonDateiActiv.Caption:=OpenPictureDialog1.FileName;
      Done := True;
    end
    else { Abbruch durch Benutzer }
    Done := True;
  end;
  ZeigeAenderung;
end;

procedure TFensterdesigne.PanelButtonDateinichtActivClick(Sender: TObject);
var Done:Boolean;
begin
  Done:=False;
  OpenPictureDialog1.DefaultExt := GraphicExtension(TBitmap);
  OpenPictureDialog1.FileName := GraphicFileMask(TBitmap);
  OpenPictureDialog1.Filter := GraphicFilter(TBitmap);
  OpenPictureDialog1.Options := [ofFileMustExist{, ofHideReadOnly}, ofNoChangeDir ];
  while not Done do  begin
    if OpenPictureDialog1.Execute then begin
      //Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      //UDateinameNichtActiv:=OpenPictureDialog1.FileName;
      PanelButtonDateinichtActiv.Caption:=OpenPictureDialog1.FileName;
      Done := True;
    end
    else { Abbruch durch Benutzer }
      Done := True;
    end;
  ZeigeAenderung;
end;

procedure TFensterdesigne.PanelButtonFarbeactivClick(Sender: TObject);
begin
  ColorDialog1.Color:=PanelButtonFarbeactiv.Color;
  if ColorDialog1.Execute then  PanelButtonFarbeactiv.color:=ColorDialog1.Color;
  ZeigeAenderung;
end;

procedure TFensterdesigne.PanelButtonFontColorActivClick(Sender: TObject);
begin
  ColorDialog1.Color:=PanelButtonFontColorActiv.Font.Color;
  if ColorDialog1.Execute then  PanelButtonFontColorActiv.Font.Color:=ColorDialog1.Color;
  ZeigeAenderung;
end;

procedure TFensterdesigne.PanelButtonFarbenichtactivClick(Sender: TObject);
begin
  ColorDialog1.Color:=PanelButtonFarbenichtactiv.Color;
  if ColorDialog1.Execute then  PanelButtonFarbenichtactiv.color:=ColorDialog1.Color;
  ZeigeAenderung;
end;

procedure TFensterdesigne.PanelButtonFontColorNichtActivClick(
  Sender: TObject);
begin
  ColorDialog1.Color:=PanelButtonFontColorNichtActiv.Font.Color;
  if ColorDialog1.Execute then  PanelButtonFontColorNichtActiv.Font.Color:=ColorDialog1.Color;
  ZeigeAenderung;
end;

procedure TFensterdesigne.FormActivate(Sender: TObject);
begin
  UButtonDateinameNichtActiv:=FormPlanlos.GButtonDateinameNichtActiv;
  UButtonDateinameActiv:=FormPlanlos.GButtonDateinameActiv;
  UButtonFarbeActive:=FormPlanlos.GButtonFarbeActive;
  UButtonFarbeNichtActive:=FormPlanlos.GButtonFarbeNichtActive;
  UButtonFeldActiv:=FormPlanlos.GButtonFeldActiv;
  UButtonFeldNichtActiv:=FormPlanlos.GButtonFeldNichtActiv;
  UButtonFontColorActiv:=FormPlanlos.GButtonFontColorActiv;
  UButtonFontColorNichtActiv:=FormPlanlos.GButtonFontColorNichtActiv;

  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  if QueryFensterdesign.Active then QueryFensterdesign.close;
  QueryFensterdesign.close;
  QueryFensterdesign.sql.Clear;
  QueryFensterdesign.sql.add('Select * From Fensterdesign Where nr = '+ inttostr(UZeiger));
  //QueryKategorie.active:=True;
  try
    QueryFensterdesign.open;//Self.Query1.Edit;
  finally end;
  if UZeigerNeu=False then begin
    PanelButtonDateiActiv.Caption:=QueryFensterdesign.FieldByName('ButtonDateiActive').AsString;
    PanelButtonDateiNichtActiv.Caption:=QueryFensterdesign.FieldByName('ButtonDateiNichtActive').AsString;
    PanelButtonFarbeactiv.Color:=stringtocolor(QueryFensterdesign.FieldByName('ButtonFarbeActive').AsString);
    PanelButtonFarbeNichtactiv.Color:=stringtocolor(QueryFensterdesign.FieldByName('ButtonFarbeNichtActive').AsString);
    PanelButtonFontColorActiv.Font.Color:=stringtocolor(QueryFensterdesign.FieldByName('ButtonFontColorActive').AsString);
    PanelButtonFontColorNichtActiv.Font.Color:=stringtocolor(QueryFensterdesign.FieldByName('ButtonFontColorNichtActive').AsString);

    FormPlanlos.GButtonDateinameActiv:=QueryFensterdesign.FieldByName('ButtonDateiActive').AsString;
    FormPlanlos.GButtonDateinameNichtActiv:=QueryFensterdesign.FieldByName('ButtonDateiNichtActive').AsString;
    FormPlanlos.GButtonFarbeActive:=QueryFensterdesign.FieldByName('ButtonFarbeActive').AsString;
    FormPlanlos.GButtonFarbeNichtActive:=QueryFensterdesign.FieldByName('ButtonFarbeNichtActive').AsString;
    FormPlanlos.GButtonFontColorActiv:=QueryFensterdesign.FieldByName('ButtonFontColorActive').AsString;
    FormPlanlos.GButtonFontColorNichtActiv:=QueryFensterdesign.FieldByName('ButtonFontColorNichtActive').AsString;
    FormPlanlos.GButtonFeldActiv:=QueryFensterdesign.FieldByName('ButtonFeldActive').Asinteger;
    FormPlanlos.GButtonFeldNichtActiv:=QueryFensterdesign.FieldByName('ButtonFeldNichtActive').Asinteger;


    if QueryFensterdesign.FieldByName('ButtonFeldActive').Asinteger = 0 then begin
      PanelButtonDateiActiv.Visible:=False;
      PanelButtonFarbeactiv.Visible:=False;
    end;
    if QueryFensterdesign.FieldByName('ButtonFeldActive').Asinteger = 1 then begin
      PanelButtonDateiActiv.Visible:=True;
      PanelButtonFarbeactiv.Visible:=True;
      //PanelButtonDateiActiv.Caption:=QueryFensterdesign.FieldByName('ButtonDateiActive').AsString;
    end;
    if QueryFensterdesign.FieldByName('ButtonFeldActive').Asinteger = 2 then begin
      PanelButtonDateiActiv.Visible:=False;
      PanelButtonFarbeactiv.Visible:=True;
      //PanelButtonFarbeactiv.Color:=stringtocolor(QueryFensterdesign.FieldByName('ButtonFarbeActive').AsString);
    end;
    if QueryFensterdesign.FieldByName('ButtonFeldNichtActive').Asinteger = 0 then begin
      PanelButtonDateiNichtActiv.Visible:=False;
      PanelButtonFarbeNichtactiv.Visible:=False;
    end;
    if QueryFensterdesign.FieldByName('ButtonFeldNichtActive').Asinteger = 1 then begin
      PanelButtonDateiNichtActiv.Visible:=True;
      PanelButtonFarbeNichtactiv.Visible:=True;
      //PanelButtonDateiNichtActiv.Caption:=QueryFensterdesign.FieldByName('ButtonDateiNichtActive').AsString;
    end;
    if QueryFensterdesign.FieldByName('ButtonFeldNichtActive').Asinteger = 2 then begin
      PanelButtonDateiNichtActiv.Visible:=False;
      PanelButtonFarbeNichtactiv.Visible:=True;
      //PanelButtonFarbeNichtactiv.Color:=stringtocolor(QueryFensterdesign.FieldByName('ButtonFarbeNichtActive').AsString);
    end;
    ZeigeAenderung;
  end Else begin
    DBCheckBoxCascade.ValueChecked:='1';
    DBEditAnimation.Text:='6';
  end;
  QueryFensterdesign.Edit;
end;

procedure TFensterdesigne.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F10 then ButtonSpeichernClick(Self);
end;

procedure TFensterdesigne.ButtonabbrechenClick(Sender: TObject);
var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  //PanelTastatur.Color:=clGray;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  //PanelTastatur.Color:=clYellow;
  if FAbbrechen then
  begin
    if UZeigerNeu then
      begin
        QueryFensterdesign.close;
        if (DataModuleDB.DatensatzLoeschen('fensterdesign',Uzeiger) = False) Then
        begin
         // PanelTastatur.Color:=clGray;
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
         // PanelTastatur.Color:=clYellow;
        end;
      end
    else // änderung
    begin
      QueryFensterdesign.Cancel;QueryFensterdesign.close;
    end;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  //DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFensterdesigne.ButtonSpeichernClick(Sender: TObject);
begin
  Showmessage('änderungen werden beim neustart des Programms wirksam');
  QueryFensterdesign.FieldByName('ButtonDateiActive').AsString:=PanelButtonDateiActiv.Caption;
  QueryFensterdesign.FieldByName('ButtonDateiNichtActive').AsString:=PanelButtonDateiNichtActiv.Caption;
  QueryFensterdesign.FieldByName('ButtonFarbeActive').AsString:=ColorToString(PanelButtonFarbeactiv.Color);
  QueryFensterdesign.FieldByName('ButtonFarbeNichtActive').AsString:=ColorToString(PanelButtonFarbeNichtactiv.Color);
  QueryFensterdesign.FieldByName('ButtonFontColorActive').AsString:=ColorToString(PanelButtonFontColorActiv.Font.Color);
  QueryFensterdesign.FieldByName('ButtonFontColorNichtActive').AsString:=ColorToString(PanelButtonFontColorNichtActiv.Font.Color);
  QueryFensterdesign.Post;
  FormPlanlos.Gzeiger:=QueryFensterdesign.Fields[0].Value;
  QueryFensterdesign.close;
  close;
end;

procedure TFensterdesigne.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
  FormPlanlos.GButtonDateinameNichtActiv:=UButtonDateinameNichtActiv;
  FormPlanlos.GButtonDateinameActiv:=UButtonDateinameActiv;
  FormPlanlos.GButtonFarbeActive:=UButtonFarbeActive;
  FormPlanlos.GButtonFarbeNichtActive:=UButtonFarbeNichtActive;
  FormPlanlos.GButtonFeldActiv:=UButtonFeldActiv;
  FormPlanlos.GButtonFeldNichtActiv:=UButtonFeldNichtActiv;
  FormPlanlos.GButtonFontColorActiv:=UButtonFontColorActiv;
  FormPlanlos.GButtonFontColorNichtActiv:=UButtonFontColorNichtActiv;
end;

procedure TFensterdesigne.ButtonBildZeigenClick(Sender: TObject);
Var Done: Boolean;
    f: file of Byte;
    Dateigroesse : Longint;
begin
  Done:=False;
  OpenPictureDialog1.DefaultExt := GraphicExtension(TBitmap);
  OpenPictureDialog1.FileName := GraphicFileMask(TBitmap);
  OpenPictureDialog1.Filter := GraphicFilter(TBitmap);
  OpenPictureDialog1.Options := [ofFileMustExist{, ofHideReadOnly}, ofNoChangeDir ];
  while not Done do  begin
    if OpenPictureDialog1.Execute then begin
    //if not (ofExtensionDifferent in OpenPictureDialog1.Options) then  begin
      //Application.Icon.LoadFromFile(OpenPictureDialog1.FileName);
      //Showmessage(OpenPictureDialog1.FileName);
      AssignFile(f, OpenPictureDialog1.FileName);
      Reset(f);
      Dateigroesse:=FileSize(f);
      CloseFile(f);
      //if Dateigroesse > 1024000 Then Showmessage('Dateigröße ist Byte: ' + IntToStr(Dateigroesse)+',  darf aber nur max 1024000 groß sein')
      //Else begin
        Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
        LabelDateinameBildfarben.Caption:=OpenPictureDialog1.FileName;
        //Showmessage(USchriftOderDateiname);
      //end;
      Done := True;
    //end
    //else
    //  OpenPictureDialog1.Options := [ofExtensionDifferent];
    end
  else { Abbruch durch Benutzer }
    Done := True;
  end;
end;

procedure TFensterdesigne.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //P := BitMap.ScanLine[y];
  //showmessage(colortostring(Image1.Canvas.Pixels[x,y]));
  if LabelDateinameBildfarben.Caption<>'' then begin
    if RadioGroupFarbeKopieren.ItemIndex = 0 Then  PanelButtonFarbeactiv.Color:=Image1.Canvas.Pixels[x,y];
    if RadioGroupFarbeKopieren.ItemIndex = 1 Then  PanelButtonFontColorActiv.Font.Color:=Image1.Canvas.Pixels[x,y];
    if RadioGroupFarbeKopieren.ItemIndex = 2 Then  PanelButtonFarbenichtactiv.Color:=Image1.Canvas.Pixels[x,y];
    if RadioGroupFarbeKopieren.ItemIndex = 3 Then  PanelButtonFontColorNichtActiv.Font.Color:=Image1.Canvas.Pixels[x,y];
  end;
  //ZeigeAenderung;
end;

procedure TFensterdesigne.ZeigeAenderung;
begin
  FormPlanlos.GButtonDateinameActiv:=PanelButtonDateiActiv.Caption;
  FormPlanlos.GButtonDateinameNichtActiv:=PanelButtonDateiNichtActiv.Caption;
  FormPlanlos.GButtonFarbeActive:=ColorToString(PanelButtonFarbeactiv.Color);
  FormPlanlos.GButtonFarbeNichtActive:=ColorToString(PanelButtonFarbeNichtactiv.Color);
  FormPlanlos.GButtonFontColorActiv:=ColorToString(PanelButtonFontColorActiv.Font.Color);
  FormPlanlos.GButtonFontColorNichtActiv:=ColorToString(PanelButtonFontColorNichtActiv.Font.Color);
  FormPlanlos.GButtonFeldActiv:=DBRadioGroupTastaturActic.ItemIndex;
  FormPlanlos.GButtonFeldNichtActiv:=DBRadioGroupButtonNichtactiv.ItemIndex;
  if RadioGroupZeigeAenderung.itemindex=0 then
    DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB)
  else
    DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFensterdesigne.RadioGroupZeigeAenderungClick(Sender: TObject);
begin
  ZeigeAenderung;
end;

procedure TFensterdesigne.RadioGroupFarbeKopierenClick(Sender: TObject);
begin
  ZeigeAenderung;
end;

end.
