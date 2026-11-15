unit UnitFormatierung;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ExtDlgs;

type
  TFormFormatierung = class(TForm)
    CheckBoxSichbar: TCheckBox;
    Editx: TEdit;
    Edity: TEdit;
    Editl: TEdit;
    ComboBoxJ: TComboBox;
    ButtonSchrift: TButton;
    PanelFarbe: TPanel;
    ComboBoxRahmen: TComboBox;
    Label1: TLabel;
    ImageTastatur: TImage;
    Buttonabbrechen: TButton;
    ButtonOk: TButton;
    FontDialog1: TFontDialog;
    ColorDialog1: TColorDialog;
    EditName: TEdit;
    LabelHilfetext1: TLabel;
    LabelHilfetext2: TLabel;
    LabelHilfetext3: TLabel;
    Edith: TEdit;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    ButtonLogoLaden: TButton;
    LabelEsc: TLabel;
    LabelF10: TLabel;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    ComboBoxFelder: TComboBox;
    CheckBoxEdit: TCheckBox;
    ButtonBerechnung: TButton;
    function an(FFormatierung:String;FEinstelung:Integer;Hilfetext1,Hilfetext2,Hilfetext3,Titel:String):String;
    procedure ButtonSchriftClick(Sender: TObject);
    procedure PanelFarbeClick(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonLogoLadenClick(Sender: TObject);
    procedure ComboBoxFelderChange(Sender: TObject);
    procedure ButtonBerechnungClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormFormatierung: TFormFormatierung;
  abbrechen:Boolean;
  UEinstelung:Integer;
  USchriftOderDateiname:String;
  UMonitorNr:integer;
implementation

uses TempForm,UnitDataModul,UnitModule, UnitBerechnungsart;

{$R *.DFM}
function TFormFormatierung.an(FFormatierung:String;FEinstelung:Integer;Hilfetext1,Hilfetext2,Hilfetext3,Titel:String):String;
var y:String;
    sTemp:String;
    i,FEditTemp:integer;
    //N:String;
    E:Boolean;
begin
  UMonitorNr:=0;
  UEinstelung:=FEinstelung;
  if UEinstelung= 9 Then Label1.Caption:='Sichbar     x            y         länge      justierung                   Schrift           Farbe       Rahmen               Edit'
  Else Label1.Caption:='Sichbar     x            y         länge      justierung                   Schrift           Farbe       Rahmen               höhe';
  if UEinstelung= 9 Then begin
    ComboBoxRahmen.Items.Clear;
    ComboBoxRahmen.Items.Add('0=ohne Rahmen');
    ComboBoxRahmen.Items.Add('1=mit Rahmen');
    if Titel='Monitormaske1' then UMonitorNr:=0;
    if Titel='Monitormaske2' then UMonitorNr:=1;
    if Titel='Monitormaske3' then UMonitorNr:=2;
    if Titel='Monitormaske4' then UMonitorNr:=3;
    if Titel='Monitormaske5' then UMonitorNr:=4;
    if Titel='Monitormaske6' then UMonitorNr:=5;
    if Titel='Monitormaske7' then UMonitorNr:=6;
    if Titel='Monitormaske8' then UMonitorNr:=7;
    if Titel='Monitormaske9' then UMonitorNr:=8;
    if Titel='Monitormaske10' then UMonitorNr:=9;
    if Titel='Monitormaske11' then UMonitorNr:=10;
    if Titel='Monitormaske12' then UMonitorNr:=11;
    if Titel='Monitormaske13' then UMonitorNr:=12;
    if Titel='Monitormaske14' then UMonitorNr:=13;
    if Titel='Monitormaske15' then UMonitorNr:=14;
    if Titel='Monitormaske16' then UMonitorNr:=15;
    if Titel='Monitormaske17' then UMonitorNr:=16;
    if Titel='Monitormaske18' then UMonitorNr:=17;
    if Titel='Monitormaske19' then UMonitorNr:=18;
    if Titel='Monitormaske20' then UMonitorNr:=19;
  end else begin
    ComboBoxRahmen.Items.Clear;
    ComboBoxRahmen.Items.Add('0=ohne Rahmen');
    ComboBoxRahmen.Items.Add('1=links');
    ComboBoxRahmen.Items.Add('2=unten');
    ComboBoxRahmen.Items.Add('3');
    ComboBoxRahmen.Items.Add('4');
    ComboBoxRahmen.Items.Add('5');
    ComboBoxRahmen.Items.Add('6');
    ComboBoxRahmen.Items.Add('7 ');
    ComboBoxRahmen.Items.Add('8=Oben');
    ComboBoxRahmen.Items.Add('9');
    ComboBoxRahmen.Items.Add('10');
    ComboBoxRahmen.Items.Add('11');
    ComboBoxRahmen.Items.Add('12');
    ComboBoxRahmen.Items.Add('13');
    ComboBoxRahmen.Items.Add('14');
    ComboBoxRahmen.Items.Add('15=Rahmen');
  end;
  Caption:='Formartierung von  '+Titel;
  ButtonBerechnung.Visible:=True;
  EditName.Visible:=True;
  Editx.Visible:=True;
  Edity.Visible:=True;
  Editl.Visible:=True;
  Edith.Visible:=True;
  ComboBoxJ.Visible:=True;
  ButtonSchrift.Visible:=True;
  PanelFarbe.Visible:=True;
  ComboBoxRahmen.Visible:=True;
  ButtonLogoLaden.Visible:=True;
  Image1.Visible:=True;
  FontDialog1.Options:=[fdWysiwyg];
  ComboBoxFelder.Visible:=True;
  CheckBoxEdit.Visible:=True;
  if FEinstelung =0 Then begin ButtonLogoLaden.Visible:=False;
  {Druken Label}               Image1.Visible:=False;
                               ComboBoxFelder.Visible:=False;
                               CheckBoxEdit.Visible:=False;
                               ButtonBerechnung.Visible:=False; end;
  if FEinstelung =1 Then begin EditName.Visible:=False;
  {Druken DBFeld}              Edith.Visible:=False;
                               ButtonLogoLaden.Visible:=False;
                               Image1.Visible:=False;
                               ComboBoxFelder.Visible:=False;
                               CheckBoxEdit.Visible:=False;
                               ButtonBerechnung.Visible:=False; end;
  if FEinstelung =2 Then begin Edity.Visible:=False;
                               Edith.Visible:=False;
                               ButtonLogoLaden.Visible:=False;
                               Image1.Visible:=False;
                               ComboBoxFelder.Visible:=False;
                               CheckBoxEdit.Visible:=False;
                               ButtonBerechnung.Visible:=False; end;
  if FEinstelung =3 Then begin Editx.Visible:=False;
                               Editl.Visible:=False;
                               Edith.Visible:=False;
                               ButtonLogoLaden.Visible:=False;
                               Image1.Visible:=False;
                               ComboBoxFelder.Visible:=False;
                               CheckBoxEdit.Visible:=False;
                               ButtonBerechnung.Visible:=False; end;
  if FEinstelung =4 Then begin EditName.Visible:=False;
                               Edity.Visible:=False;
                               Edith.Visible:=False;
                               ButtonLogoLaden.Visible:=False;
                               Image1.Visible:=False;
                               ComboBoxFelder.Visible:=False;
                               CheckBoxEdit.Visible:=False;
                               ButtonBerechnung.Visible:=False; end;
  if FEinstelung =5 Then begin Edity.Visible:=False;
  {Drucken ganze Zeile}        Editx.Visible:=False;
                               Editl.Visible:=False;
                               Edith.Visible:=False;
                               ButtonLogoLaden.Visible:=False;
                               Image1.Visible:=False;
                               ComboBoxFelder.Visible:=False;
                               CheckBoxEdit.Visible:=False;
                               ButtonBerechnung.Visible:=False; end;
  if FEinstelung =6 Then begin EditName.Visible:=False;
  {Drucken Memo}               Edity.Visible:=False;
                               Editx.Visible:=False;
                               Editl.Visible:=False;
                               Edith.Visible:=False;
                               ButtonLogoLaden.Visible:=False;
                               Image1.Visible:=False;
                               ComboBoxFelder.Visible:=False;
                               CheckBoxEdit.Visible:=False;
                               ButtonBerechnung.Visible:=False; end;
  if FEinstelung =7 Then begin EditName.Visible:=False;
  {Drucken Rahmen}             ComboBoxJ.Visible:=False;
                               ButtonSchrift.Visible:=False;
                               PanelFarbe.Visible:=False;
                               ComboBoxRahmen.Visible:=False;
                               ButtonLogoLaden.Visible:=False;
                               Image1.Visible:=False;
                               ComboBoxFelder.Visible:=False;
                               CheckBoxEdit.Visible:=False;
                               ButtonBerechnung.Visible:=False; end;
  if FEinstelung =8 Then begin EditName.Visible:=False;
  {Drucken Logo}               ComboBoxJ.Visible:=False;
                               ButtonSchrift.Visible:=False;
                               PanelFarbe.Visible:=False;
                               ComboBoxRahmen.Visible:=False;
                               ComboBoxFelder.Visible:=False;
                               CheckBoxEdit.Visible:=False;
                               ButtonBerechnung.Visible:=False; end;
  if FEinstelung =9 Then begin EditName.Visible:=False;
  {monitormaske1-20}           ButtonLogoLaden.Visible:=False;
                               Image1.Visible:=False;Edith.Visible:=False;
                               ButtonBerechnung.Visible:=False; end;
  if FEinstelung =10 Then begin EditName.Visible:=False;
  {Drucken Feld1-18}            ButtonLogoLaden.Visible:=False;
                                Image1.Visible:=False;
                                Edith.Visible:=False;
                                ButtonBerechnung.Visible:=False;
                                CheckBoxEdit.Visible:=False; end;
  if FEinstelung =11 Then begin EditName.Visible:=False;
  {Drucken Feld19-20}           ButtonLogoLaden.Visible:=False;
                                Image1.Visible:=False;Edith.Visible:=False;
                                ButtonBerechnung.Visible:=False;
                                CheckBoxEdit.Visible:=False;
                                ComboBoxFelder.Visible:=False;end;
  y:=';';
  abbrechen:=True;
  sTemp:=FFormatierung;
  LabelHilfetext1.Caption:=Hilfetext1;
  LabelHilfetext2.Caption:=Hilfetext2;
  LabelHilfetext2.Caption:=Hilfetext3;

  if FFormatierung<>'' Then begin
    i:=Pos(y,sTemp);  CheckBoxSichbar.Checked:= DataModuleMyOffice.IntToBol(DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)));    sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  EditName.text:=           copy(sTemp,1,i-1);ComboBoxFelder.Text:=copy(sTemp,1,i-1);                         sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Editx.text:=              (copy(sTemp,1,i-1));                                                             sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Edity.text:=              (copy(sTemp,1,i-1));                                                             sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Editl.text:=              (copy(sTemp,1,i-1));                                                             sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  ComboBoxJ.ItemIndex:=     DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));                                 sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  ButtonSchrift.Font.name:= copy(sTemp,1,i-1);                                                               sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  PanelFarbe.Color:=        stringtocolor(copy(sTemp,1,i-1));                                                sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  ButtonSchrift.Font.Size:= DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));                                 sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  ButtonSchrift.Font.Style:=DataModuleMyOffice.IntToStyle(DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1)));  sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  ComboBoxRahmen.ItemIndex:=DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1));                                 sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  E{CheckBoxEdit.Checked}:=    DataModuleMyOffice.IntToBol(DataModuleMyOffice.XStrtoInt(copy(sTemp,1,i-1))); sTemp:=copy(sTemp,i+1,length(sTemp));
    i:=Pos(y,sTemp);  Edith.text:=              (copy(sTemp,1,i-1));if (copy(sTemp,1,i-1))='1' Then CheckBoxEdit.Checked:=True Else CheckBoxEdit.Checked:=False;
    if (UEinstelung = 9) or (UEinstelung = 10) then begin
      sTemp:=copy(sTemp,i+1,length(sTemp));
      i:=Pos(y,sTemp); if copy(sTemp,1,i-1)<>'' then begin
        ButtonBerechnung.Visible:=True;
        ButtonBerechnung.Caption:=copy(sTemp,1,i-1);
      end;
    end;
    CheckBoxEdit.Checked:= E;
    //then Showmessage('E:=1')Else Showmessage('E:=0');
    ColorDialog1.Color:=PanelFarbe.Color;
    FontDialog1.Font.Name:=ButtonSchrift.Font.name;
    FontDialog1.Font.Size:=ButtonSchrift.Font.Size;
    FontDialog1.Font.Style:=ButtonSchrift.Font.Style;
    FontDialog1.Font.Color:=PanelFarbe.Color;
    Image1.Picture.Bitmap:=GLogo;//SaveToStream
    //Image1.Picture.Bitmap:=LoadFromStream(GLogo);//SaveToStream
  end
  Else begin
    CheckBoxSichbar.Checked:=True;
    EditName.text:='';
    ComboBoxFelder.Text:='';
    Editx.text:='0';
    Edity.text:='0';
    Editl.text:='0';
    Edith.text:='0';
    CheckBoxEdit.Checked:=False;
    ComboBoxJ.ItemIndex:=0;
    ButtonSchrift.Font.name:='Arial';
    ButtonSchrift.Font.Size:=8;
    ButtonSchrift.Font.Style:=DataModuleMyOffice.IntToStyle(0);
    ComboBoxRahmen.ItemIndex:=0;
    ButtonSchrift.Font.color:=StringToColor('clBlack');
    PanelFarbe.color:=StringToColor('clBlack');
  end;

  FormFormatierung.ShowModal;

  if abbrechen Then Result:=''
  Else begin
    if UEinstelung <> 8 Then USchriftOderDateiname:=ButtonSchrift.Font.Name;
    //Showmessage(USchriftOderDateiname);
    //if (ColorToString(PanelFarbe.color)='clBtnFace') Then PanelFarbe.color:=StringToColor('clBlack');                              PanelFarbe.color:=StringToColor('clBlack');
    if (UEinstelung = 9) or (UEinstelung = 10)Then begin
      if  CheckBoxEdit.Checked then FEditTemp:=1 else FEditTemp:=0;
      Result:=DataModuleMyOffice.FdSetString(
      DataModuleMyOffice.BoltoInt(CheckBoxSichbar.Checked),
      ComboBoxFelder.text,
      DataModuleMyOffice.XStrToint(Editx.text),
      DataModuleMyOffice.XStrToint(Edity.text),
      DataModuleMyOffice.XStrToint(Editl.text),
      ComboBoxJ.ItemIndex,
      USchriftOderDateiname,
      colortostring(PanelFarbe.color),
      ButtonSchrift.Font.size,
      DataModuleMyOffice.StyleToInt(ButtonSchrift.Font.Style),
      ComboBoxRahmen.ItemIndex,
      FEditTemp,
      UMonitorNr);
      Result:=Result+ButtonBerechnung.caption+';';
    end Else begin
      Result:=DataModuleMyOffice.FdSetString(
      DataModuleMyOffice.BoltoInt(CheckBoxSichbar.Checked),
      EditName.text,
      DataModuleMyOffice.XStrToint(Editx.text),
      DataModuleMyOffice.XStrToint(Edity.text),
      DataModuleMyOffice.XStrToint(Editl.text),
      ComboBoxJ.ItemIndex,
      USchriftOderDateiname,
      colortostring(PanelFarbe.color),
      ButtonSchrift.Font.size,
      DataModuleMyOffice.StyleToInt(ButtonSchrift.Font.Style),
      ComboBoxRahmen.ItemIndex,
      0,
      DataModuleMyOffice.XStrToint(Edith.text));
    end;
  end;
end;
procedure TFormFormatierung.ButtonSchriftClick(Sender: TObject);
begin
  FontDialog1.Font:=ButtonSchrift.Font;
  if FontDialog1.Execute then  ButtonSchrift.Font:=FontDialog1.Font;
  {if ColorToString(PanelFarbe.color)='clBtnFace' Then }PanelFarbe.color:=FontDialog1.Font.Color ;
end;

procedure TFormFormatierung.PanelFarbeClick(Sender: TObject);
begin
  if ColorDialog1.Execute then  PanelFarbe.color:=ColorDialog1.Color;
end;

procedure TFormFormatierung.ButtonOkClick(Sender: TObject);
begin
  abbrechen:=False;
  Close;
end;

procedure TFormFormatierung.ButtonabbrechenClick(Sender: TObject);
begin
  abbrechen:=True;
  close;
end;

procedure TFormFormatierung.FormActivate(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  FontDialog1.Options := [];
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormFormatierung.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

procedure TFormFormatierung.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F10 then ButtonOKClick(Self);
end;

procedure TFormFormatierung.ButtonLogoLadenClick(Sender: TObject);
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
      if Dateigroesse > 1024000 Then Showmessage('Dateigröße ist Byte: ' + IntToStr(Dateigroesse)+',  darf aber nur max 1024000 groß sein')
      Else begin
        Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
        USchriftOderDateiname:=OpenPictureDialog1.FileName;
        //Showmessage(USchriftOderDateiname);
      end;
      Done := True;
    //end
    //else
    //  OpenPictureDialog1.Options := [ofExtensionDifferent];
    end
  else { Abbruch durch Benutzer }
    Done := True;
  end;
end;

procedure TFormFormatierung.ComboBoxFelderChange(Sender: TObject);
begin
  if (ComboBoxFelder.text ='Berechnen1') or (ComboBoxFelder.text ='Berechnen2') or (ComboBoxFelder.text ='Berechnen3') then
     ButtonBerechnung.Visible:=True
  Else begin
    ButtonBerechnung.caption:='';
    ButtonBerechnung.Visible:=False;
  end;
  if ComboBoxFelder.text ='Pos_Nr' then Editl.text:='29';
  if ComboBoxFelder.text ='Artikelgruppe' then Editl.text:='152';
  if ComboBoxFelder.text ='Artikel' then Editl.text:='149';
  if ComboBoxFelder.text ='Menge' then Editl.text:='45';
  if ComboBoxFelder.text ='EinheitMenge' then Editl.text:='67';
  if ComboBoxFelder.text ='EK_Preis' then Editl.text:='74';
  if ComboBoxFelder.text ='Einheit_EK' then Editl.text:='67';
  if ComboBoxFelder.text ='Aufschlag' then Editl.text:='39';
  if ComboBoxFelder.text ='Rabatt' then Editl.text:='39';
  if ComboBoxFelder.text ='VK_Preis' then Editl.text:='81';
  if ComboBoxFelder.text ='Pos_Text' then Editl.text:='370';
  if ComboBoxFelder.text ='Zahl1' then Editl.text:='65';
  if ComboBoxFelder.text ='Zahl2' then Editl.text:='65';
  if ComboBoxFelder.text ='Zahl3' then Editl.text:='65';
  if ComboBoxFelder.text ='Name1' then Editl.text:='150';
  if ComboBoxFelder.text ='Name2' then Editl.text:='150';
  if ComboBoxFelder.text ='Name3' then Editl.text:='513';
  if ComboBoxFelder.text ='Berechnen1' then Editl.text:='150';
  if ComboBoxFelder.text ='Berechnen2' then Editl.text:='150';
  if ComboBoxFelder.text ='Berechnen3' then Editl.text:='150';
  if ComboBoxFelder.text ='Gewicht' then Editl.text:='65';
  if ComboBoxFelder.text ='Erledigt1' then Editl.text:='15';
  if ComboBoxFelder.text ='Erledigt2' then Editl.text:='15';
  if ComboBoxFelder.text ='Erledigt3' then Editl.text:='15';
  if ComboBoxFelder.text ='Erledigt4' then Editl.text:='15';
  if ComboBoxFelder.text ='Geaendert' then Editl.text:='15';
  if ComboBoxFelder.text ='BerechnungsArt' then Editl.text:='150';
  if ComboBoxFelder.text ='ArtikelArt' then Editl.text:='150';
end;

procedure TFormFormatierung.ButtonBerechnungClick(Sender: TObject);
var Fnr:integer; Par:TStringList; Fname:string;
begin
  Par:=TStringList.Create;
  Par:=TForm1.an(FormBerechungsart,ButtonBerechnung.caption,GModulart,GBenutzer,182);
  Fnr:=strtoint(Par[0]);Fname:=Par[1];
  if Fname <> '' then  ButtonBerechnung.caption:=Fname;
  Par.Free;
end;

end.
