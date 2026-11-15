unit UnitEinstellungenBenutzer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  DBCtrls, ExtDlgs;

type
  TFormEinstellungenBenutzer = class(TForm)
    QueryEinstellungenBenutzer: TZQuery;
    DataSourceEinstlungenBenutzer: TDataSource;
    ImageTastatur: TImage;
    Buttonabbrechen: TButton;
    LabelEsc: TLabel;
    ButtonSpeichern: TButton;
    LabelF10: TLabel;
    DBCheckBoxProjektNeu: TDBCheckBox;
    DBCheckBoxProjektAendern: TDBCheckBox;
    DBCheckBoxProjektLoeschen: TDBCheckBox;
    DBText1: TDBText;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    ButtonFensterdevLaden: TButton;
    Label2: TLabel;
    Buttonsuchen: TButton;
    LabelF4_p: TLabel;
    LabelF4: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonSpeichernClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
//    procedure ButtonsuchenClick(Sender: TObject);
    procedure ButtonFensterdevLadenClick(Sender: TObject);
//    procedure PanelButtonDateiActivClick(Sender: TObject);
//    procedure PanelButtonFarbeactivClick(Sender: TObject);
//    procedure PanelButtonFontColorActivClick(Sender: TObject);
//    procedure PanelButtonDateinichtActivClick(Sender: TObject);
//    procedure PanelButtonFarbenichtactivClick(Sender: TObject);
//    procedure PanelButtonFontColorNichtActivClick(Sender: TObject);
//    procedure DBRadioGroupTastaturActicChange(Sender: TObject);
//    procedure DBRadioGroupButtonNichtactivChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormEinstellungenBenutzer: TFormEinstellungenBenutzer;
  UZeiger:longint;UZeigerNeu:Boolean;
  UFocus:String;
  UFensterdesignNr:integer;
implementation

uses TempForm,UnitModule, UnitMeldefenster, UnitDB,UnitDataModul,
  UnitFensterdesign;
{$R *.DFM}

procedure TFormEinstellungenBenutzer.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  //if Key = VK_F4 then ButtonsuchenClick(Self);
  if Key = VK_F10 then ButtonSpeichernClick(Self);
end;

procedure TFormEinstellungenBenutzer.ButtonabbrechenClick(Sender: TObject);
var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then  ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  //PanelTastatur.Color:=clGray;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  //PanelTastatur.Color:=clYellow;
  if FAbbrechen then
  begin
    if UZeigerNeu then
      begin
        QueryEinstellungenBenutzer.close;
        if (DataModuleDB.DatensatzLoeschen('Benutzer',Uzeiger) = False) Then
        begin
         // PanelTastatur.Color:=clGray;
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
         // PanelTastatur.Color:=clYellow;
        end;
      end
    else // änderung
    begin
      QueryEinstellungenBenutzer.Cancel;QueryEinstellungenBenutzer.close;
    end;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormEinstellungenBenutzer.ButtonSpeichernClick(Sender: TObject);
begin
  {QueryEinstellungenBenutzer.FieldByName('ButtonDateiActive').AsString:=PanelButtonDateiActiv.Caption;
  QueryEinstellungenBenutzer.FieldByName('ButtonDateiNichtActive').AsString:=PanelButtonDateiNichtActiv.Caption;
  QueryEinstellungenBenutzer.FieldByName('ButtonFarbeActive').AsString:=ColorToString(PanelButtonFarbeactiv.Color);
  QueryEinstellungenBenutzer.FieldByName('ButtonFarbeNichtActive').AsString:=ColorToString(PanelButtonFarbeNichtactiv.Color);
  QueryEinstellungenBenutzer.FieldByName('ButtonFontColorActive').AsString:=ColorToString(PanelButtonFontColorActiv.Font.Color);
  }
  QueryEinstellungenBenutzer.FieldByName('Fensterdesign').AsString:=ButtonFensterdevLaden.Caption;
  QueryEinstellungenBenutzer.FieldByName('FensterdesignNr').Asinteger:=UFensterdesignNr;
  QueryEinstellungenBenutzer.Post;
  FormPlanlos.Gzeiger:=QueryEinstellungenBenutzer.Fields[0].Value;
  QueryEinstellungenBenutzer.close;
  close;
end;

procedure TFormEinstellungenBenutzer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

procedure TFormEinstellungenBenutzer.FormActivate(Sender: TObject);
begin
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  if QueryEinstellungenBenutzer.Active then QueryEinstellungenBenutzer.close;
  QueryEinstellungenBenutzer.close;
  QueryEinstellungenBenutzer.sql.Clear;
  QueryEinstellungenBenutzer.sql.add('Select * From Benutzer Where nr = '+ inttostr(UZeiger));
  //QueryKategorie.active:=True;
  try
    QueryEinstellungenBenutzer.open;//Self.Query1.Edit;
  finally end;
  QueryEinstellungenBenutzer.Edit;
  if UZeigerNeu then begin
    ButtonFensterdevLaden.Caption:='Standard';
    UFensterdesignNr:=1;
  end;
  {if UZeigerNeu=False then begin
    PanelButtonDateiActiv.Caption:=QueryEinstellungenBenutzer.FieldByName('ButtonDateiActive').AsString;
    PanelButtonDateiNichtActiv.Caption:=QueryEinstellungenBenutzer.FieldByName('ButtonDateiNichtActive').AsString;
    PanelButtonFarbeactiv.Color:=stringtocolor(QueryEinstellungenBenutzer.FieldByName('ButtonFarbeActive').AsString);
    PanelButtonFarbeNichtactiv.Color:=stringtocolor(QueryEinstellungenBenutzer.FieldByName('ButtonFarbeNichtActive').AsString);
    PanelButtonFontColorActiv.Font.Color:=stringtocolor(QueryEinstellungenBenutzer.FieldByName('ButtonFontColorActive').AsString);
    PanelButtonFontColorNichtActiv.Font.Color:=stringtocolor(QueryEinstellungenBenutzer.FieldByName('ButtonFontColorNichtActive').AsString);

    if QueryEinstellungenBenutzer.FieldByName('ButtonFeldActive').Asinteger = 0 then begin
      PanelButtonDateiActiv.Visible:=False;
      PanelButtonFarbeactiv.Visible:=False;
    end;
    if QueryEinstellungenBenutzer.FieldByName('ButtonFeldActive').Asinteger = 1 then begin
      PanelButtonDateiActiv.Visible:=True;
      PanelButtonFarbeactiv.Visible:=True;
      //PanelButtonDateiActiv.Caption:=QueryEinstellungenBenutzer.FieldByName('ButtonDateiActive').AsString;
    end;
    if QueryEinstellungenBenutzer.FieldByName('ButtonFeldActive').Asinteger = 2 then begin
      PanelButtonDateiActiv.Visible:=False;
      PanelButtonFarbeactiv.Visible:=True;
      //PanelButtonFarbeactiv.Color:=stringtocolor(QueryEinstellungenBenutzer.FieldByName('ButtonFarbeActive').AsString);
    end;
    if QueryEinstellungenBenutzer.FieldByName('ButtonFeldNichtActive').Asinteger = 0 then begin
      PanelButtonDateiNichtActiv.Visible:=False;
      PanelButtonFarbeNichtactiv.Visible:=False;
    end;
    if QueryEinstellungenBenutzer.FieldByName('ButtonFeldNichtActive').Asinteger = 1 then begin
      PanelButtonDateiNichtActiv.Visible:=True;
      PanelButtonFarbeNichtactiv.Visible:=True;
      //PanelButtonDateiNichtActiv.Caption:=QueryEinstellungenBenutzer.FieldByName('ButtonDateiNichtActive').AsString;
    end;
    if QueryEinstellungenBenutzer.FieldByName('ButtonFeldNichtActive').Asinteger = 2 then begin
      PanelButtonDateiNichtActiv.Visible:=False;
      PanelButtonFarbeNichtactiv.Visible:=True;
      //PanelButtonFarbeNichtactiv.Color:=stringtocolor(QueryEinstellungenBenutzer.FieldByName('ButtonFarbeNichtActive').AsString);
    end;
  end;}
end;

{procedure TFormEinstellungenBenutzer.PanelButtonDateiActivClick(
  Sender: TObject);
var Done:Boolean;
begin
Done:=False;
OpenPictureDialog1.DefaultExt := GraphicExtension(TBitmap);
OpenPictureDialog1.FileName := GraphicFileMask(TBitmap);
OpenPictureDialog1.Filter := GraphicFilter(TBitmap);
OpenPictureDialog1.Options := [ofFileMustExist{, ofHideReadOnly, ofNoChangeDir ];
while not Done do  begin
  if OpenPictureDialog1.Execute then begin
     //Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
     //UDateinameActiv:=OpenPictureDialog1.FileName;
     PanelButtonDateiActiv.Caption:=OpenPictureDialog1.FileName;
     Done := True;
  end
  else { Abbruch durch Benutzer
    Done := True;
  end;
end;

procedure TFormEinstellungenBenutzer.PanelButtonFarbeactivClick(
  Sender: TObject);
begin
  ColorDialog1.Color:=PanelButtonFarbeactiv.Color;
  if ColorDialog1.Execute then  PanelButtonFarbeactiv.color:=ColorDialog1.Color;
end;

procedure TFormEinstellungenBenutzer.PanelButtonFontColorActivClick(
  Sender: TObject);
begin
  ColorDialog1.Color:=PanelButtonFontColorActiv.Font.Color;
  if ColorDialog1.Execute then  PanelButtonFontColorActiv.Font.Color:=ColorDialog1.Color;
end;}

{procedure TFormEinstellungenBenutzer.PanelButtonDateinichtActivClick(
  Sender: TObject);
var Done:Boolean;
begin
  Done:=False;
  OpenPictureDialog1.DefaultExt := GraphicExtension(TBitmap);
  OpenPictureDialog1.FileName := GraphicFileMask(TBitmap);
  OpenPictureDialog1.Filter := GraphicFilter(TBitmap);
  OpenPictureDialog1.Options := [ofFileMustExist{, ofHideReadOnly, ofNoChangeDir ];
  while not Done do  begin
    if OpenPictureDialog1.Execute then begin
      //Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      //UDateinameNichtActiv:=OpenPictureDialog1.FileName;
      PanelButtonDateinichtActiv.Caption:=OpenPictureDialog1.FileName;
      Done := True;
    end
  else  Abbruch durch Benutzer
    Done := True;
  end;
end;}

{procedure TFormEinstellungenBenutzer.PanelButtonFarbenichtactivClick(
  Sender: TObject);
begin
  ColorDialog1.Color:=PanelButtonFarbenichtactiv.Color;
  if ColorDialog1.Execute then  PanelButtonFarbenichtactiv.color:=ColorDialog1.Color;
end;

procedure TFormEinstellungenBenutzer.PanelButtonFontColorNichtActivClick(
  Sender: TObject);
begin
  ColorDialog1.Color:=PanelButtonFontColorNichtActiv.Font.Color;
  if ColorDialog1.Execute then  PanelButtonFontColorNichtActiv.Font.Color:=ColorDialog1.Color;
end;

procedure TFormEinstellungenBenutzer.DBRadioGroupTastaturActicChange(
  Sender: TObject);
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
end;

procedure TFormEinstellungenBenutzer.DBRadioGroupButtonNichtactivChange(
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
end;}

procedure TFormEinstellungenBenutzer.ButtonFensterdevLadenClick(
  Sender: TObject);
   var Fnr:integer;Par:TStringList{;SQLSelect,SQLFrom,SQLWhere,SQLOrder:string};
       Fname:string;
begin //Fenster1
  Par:=TStringList.Create;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  Par:=TForm1.an(Fensterdesigne,ButtonFensterdevLaden.Caption,GModulart,GBenutzer,231);
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  Fnr:=strtoint(Par[0]);Fname:=Par[1];
  if Fname <> '' then begin
    ButtonFensterdevLaden.Caption:=Fname;
    UFensterdesignNr:=Fnr;
  end;
  Par.Free;
end;

end.
