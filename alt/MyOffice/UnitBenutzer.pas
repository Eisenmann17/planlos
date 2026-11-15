unit UnitBenutzer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Db, DBTables, ExtCtrls, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TFormBenutzer = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    DataSource1: TDataSource;
    DBEditBenutzer: TDBEdit;
    Label4: TLabel;
    EditPasswort: TEdit;
    DBEditPasswort: TEdit;
    DataSource2: TDataSource;
    Buttonabbrechen: TButton;
    LabelEsc: TLabel;
    Buttonspeichern: TButton;
    LabelF10: TLabel;
    ImageTastatur: TImage;
    QueryBenutzer: TZQuery;
    QueryKontrolle: TZQuery;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonspeichernClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  benutzertest:Boolean;
    function  strtochar(s:String):char;

    //function entschluesseln(text:string):string;

  private
    { Private-Deklarationen }
  public
      function entschluesseln(text:string):string;
      function verschluesseln(text:string):string;
  end;

var
  FormBenutzer: TFormBenutzer;
  UZeiger:longint;UZeigerNeu:Boolean;
  UBenutzer,UPasswort:String;


implementation

uses UnitMeldefenster, UnitDB, UnitModule,UnitDataModul;

{$R *.DFM}

procedure TFormBenutzer.FormActivate(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  UBenutzer:=DBEditBenutzer.EditText;
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  //if Utest then Showmessage('neu') else Showmessage('ändern');
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  if QueryBenutzer.Active then QueryBenutzer.close;
  QueryBenutzer.close;
  QueryBenutzer.sql.Clear;
  QueryBenutzer.sql.add('Select * From Benutzer Where nr = '+ inttostr(UZeiger));
  try
    QueryBenutzer.open;//Self.Query1.Edit;
  finally end;
  DBEditPasswort.Text:='';
  EditPasswort.Text:='';
  if UZeigerNeu = True then //neu
  begin
    DBEditBenutzer.enabled:=True;
    Label2.Caption:='Passwort :';
    Label4.Caption:='Passwort wiederholen :';
    caption:='neuer Benutzer eingeben !';
    ActiveControl:=DBEditBenutzer;
  end
  else                    //ändern
  begin
    DBEditBenutzer.enabled:=False;
    Label2.Caption:='neues Passwort :';
    Label4.Caption:='neues Passwort wiederholen :';
    caption:='Passwort ändern';
    ActiveControl:=DBEditPasswort;
  end;
  UPasswort:=QueryBenutzer.FieldByName('Passwort').asstring;
  QueryBenutzer.Edit;
end;

procedure TFormBenutzer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F10 then ButtonSpeichernClick(Self);
end;

procedure TFormBenutzer.ButtonabbrechenClick(Sender: TObject);
var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then  ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  //  PanelTastatur.Color:=clGray;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  //PanelTastatur.Color:=clYellow;
  if FAbbrechen then
  begin
    if UZeigerNeu then
      begin
        QueryBenutzer.close;
        if (DataModuleDB.DatensatzLoeschen('Benutzer',Uzeiger) = False) Then
        begin
          //PanelTastatur.Color:=clGray;
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
          //PanelTastatur.Color:=clYellow;
        end;
      end
    else // änderung
    begin
      QueryBenutzer.Cancel;QueryBenutzer.close;
    end;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormBenutzer.ButtonspeichernClick(Sender: TObject);
var FPasswortausgabe,FPassworteingabe:string;
    c1,c2:longint;
    i:integer;
    FAltesPassword:String;
begin
  if DBEditPasswort.Text= EditPasswort.Text then
  begin
    FPassworteingabe:=DBEditPasswort.Text;
    FPasswortausgabe:=verschluesseln(FPassworteingabe);
    if UZeigerNeu <> True then
    begin
      DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
      FAltesPassword:=Meldefenster.text('Altes Passwort für die Änderung eingeben :','','Sicherheitsabfrage');
      if FAltesPassword = entschluesseln(UPasswort)then
      begin
        //if Benutzertest then
        //begin
          QueryBenutzer.FieldByName('Passwort').asstring:=FPasswortausgabe;
          QueryBenutzer.Post;
          FormPlanlos.Gzeiger:=QueryBenutzer.Fields[0].Value;
          QueryBenutzer.close;
          close;
        //end
        //else Meldefenster.an(2,'dieser Benutzer wurder','schon angelegt !','Fehlermeldung !');
      end
      else
      begin
        Meldefenster.an(2,'altes Passwort falsch','Passwort kann nicht geändert werden','Fehlermeldung');
      end;
      DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
    end
    else  // wenn ein neuer Benutzer gespeichert werden soll
      if Benutzertest then
      begin
        QueryBenutzer.FieldByName('Passwort').asstring:=FPasswortausgabe;
        QueryBenutzer.Post;
        FormPlanlos.Gzeiger:=QueryBenutzer.Fields[0].Value;
        QueryBenutzer.close;
        close;
      end
      else Meldefenster.an(2,'dieser Benutzer wurder','schon angelegt !','Fehlermeldung !');
    end
  else
  begin // wenn passwort und Passwortzweiteingabe nicht gleich
    DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
    Meldefenster.an(2,'Passwort und Passwortwiederholung sind','nicht gleich !','');
    DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  end;
end;

function TFormBenutzer.entschluesseln(text:string):string;
var FPasswortausgabe,FPassworteingabe:string;
    c1,c2:integer;
    i:integer;
begin
   //showmessage('entschlüssel '+text) ;
   FPassworteingabe:=text;
   for i := 1 to (length(FPassworteingabe)) do
    begin
     c1:=ord(strtochar(copy(FPassworteingabe,i,1)));
     //showmessage('strtochar = '+strtochar(copy(FPassworteingabe,i,1)));
     c2:=c1+length(FPassworteingabe);
     FPasswortausgabe:=FPasswortausgabe + chr(c2);
    end;
   //showmessage('Entschüsselt  '+FPasswortausgabe);
   Result:=FPasswortausgabe;
   //Result:=text;
end;

function TFormBenutzer.verschluesseln(text:string):string;
var FPasswortausgabe,FPassworteingabe:string;
    c1,c2:integer;
    i:integer;
begin
   //showmessage('verschlüsseln '+text);
   FPassworteingabe:=text;
   for i := 1 to (length(FPassworteingabe)) do
    begin
     c1:=ord(strtochar(copy(FPassworteingabe,i,1)));
     //showmessage('strtochar = '+strtochar(copy(FPassworteingabe,i,1)));
     //showmessage('C1 = '+inttostr(c1));
     c2:=c1-length(FPassworteingabe);
     FPasswortausgabe:=FPasswortausgabe + chr(c2);
    end;
    //showmessage('Verschlüsselt  '+FPasswortausgabe);
   Result:=FPasswortausgabe;
   //Result:=text;
end;

procedure TFormBenutzer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;

function TFormBenutzer.benutzertest():Boolean;
var BenutzerNichtVorhanden:Boolean;
begin
  BenutzerNichtVorhanden:=False;
  If UZeigerneu then
  begin
    //QueryBenutzer no Edit
    if QueryKontrolle.Active then QueryKontrolle.close;
    QueryKontrolle.sql.Clear;
    QueryKontrolle.sql.add('Select * From Benutzer Where Benutzer = "'+DBEditBenutzer.EditText+'"');
    try
      QueryKontrolle.open;//Self.Query1.Edit;
    finally end;
    if  QueryKontrolle.RecordCount < 1 Then BenutzerNichtVorhanden:=True Else BenutzerNichtVorhanden:=False;
    QueryKontrolle.close;
  end;
  Result:=BenutzerNichtVorhanden;//kein Datensatz gefunden
end;

function  TFormBenutzer.strtochar(s:String):char;
var x:array[1..10] of char;
begin
  x[1]:=ShortString(s)[1];
  Result:=x[1];
end;
end.
