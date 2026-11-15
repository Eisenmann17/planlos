unit registrierung;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFormregistrierung = class(TForm)
    Buttonabbrechen: TButton;
    ButtonOK: TButton;
    Editnummer: TEdit;
    Editname: TEdit;
    LabelRegistriernummer: TLabel;
    LabelregistrierName: TLabel;
    Label1: TLabel;
    EditFirmenNr: TEdit;
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure speichern;
    function anfang:String;
    function pruefen:Boolean;
    function test(r1,r2,r3:String):Boolean;
  private
    { Private-Deklarationen }
  public

  end;

var
  Formregistrierung: TFormregistrierung;
  Rueckgabe:string;
  implementation

uses UnitModule;

{$R *.DFM}

function TFormregistrierung.pruefen:Boolean;{beim ˆffnen, wenn Key vorhanden pr¸fen}
var datendatei:System.text;
    rename:Array[1..3] of String;
begin
Result:=False;
  if FileExists('Key.ini') then begin
    Reset(datendatei,'Key.ini');
    readln(datendatei,rename[1]);
    readln(datendatei,rename[2]);
    readln(datendatei,rename[3]);
    CloseFile(datendatei);
    if test(rename[1],rename[2],rename[3]) then Result:=True Else showmessage('Ung¸ltige Registrierung');
  end;
end;

procedure TFormregistrierung.speichern; {datei speicher}
var datendatei:System.text;
    rename:Array[1..3] of String;
begin
    rename[1]:=EditName.text;
    rename[2]:=EditNummer.text;
    rename[3]:=EditFirmenNr.text;
    if test(rename[1],rename[2],rename[3]) then begin
      Rewrite(datendatei,'Key.ini');
      Writeln(datendatei,rename[1]);
      Writeln(datendatei,rename[2]);
      Writeln(datendatei,rename[3]);
      CloseFile(datendatei);
    end
    Else begin
      showmessage('Ung¸ltige Registrierung');
      Rueckgabe:='';
    end;
end;

function TFormregistrierung.anfang:String;
begin
  ShowModal;
  Result:=Rueckgabe;
end;

procedure TFormregistrierung.ButtonabbrechenClick(Sender: TObject);
begin
  Rueckgabe:='';
  close;
end;

procedure TFormregistrierung.ButtonOKClick(Sender: TObject);
begin
  Rueckgabe:=Editname.text;
  speichern;
  Showmessage('die Registrierung war erfolgreich');
  close;
end;

function TFormregistrierung.test(r1,r2,r3:String):Boolean;
var Auswertname,AuswertZahl,AuswertFirmenNr:String;
    Password1,Password2,Password3:integer;
    zahl:String;

begin
    if length(Auswertname)> 8 Then Showmessage('Benutzername muﬂ mindestens 8 Zeichen lang sein')
    Else begin

      Auswertname:=r1;
      AuswertZahl:=r2;
      AuswertFirmenNr:=r3;
      Password1:=strtoint('6');
      Password2:=strtoint('1');
      Password3:=strtoint('2');
      Auswertname:=copy(Auswertname,length(Auswertname)-6,6);
      Zahl:=zahl+inttostr(ord(Auswertname[Password1])); //6
      Zahl:=zahl+inttostr(ord(AuswertFirmenNr[1]));
      Zahl:=zahl+inttostr(ord(Auswertname[Password2])); //1
      Zahl:=zahl+inttostr(ord(AuswertFirmenNr[3]));
      Zahl:=zahl+inttostr(ord(Auswertname[Password3])); //2
      zahl:=Zahl + '2';                                    //Programmzahl 1=Tischrechner 2=MyOffice
      Zahl:=zahl+inttostr(ord(Auswertname[5]));
      zahl:=zahl + '01';//copy(Formplanlos.GVersion,1,2);
      //showmessage( copy(Formplanlos.GVersion,1,2));     //VersionNummer vor dem Punkt immer2 zeichen
      Zahl:=zahl+inttostr(ord(Auswertname[3]));
      //zahl:=Zahl + Edit4.text;                         //VersionNummer nach dem Punkt immer2 zeichen
      Zahl:=zahl+inttostr(ord(Auswertname[4]));
    end;




  //Randomize;
  //for i:=1 to (length(Auswertname)) do begin
    //if i < 3 then
    //  zahl:=zahl + inttoStr(Random(10))
    //else
  //  zahl:=inttostr(round(ord(Auswertname[i - 3])/i)) + Zahl;
  //end;
  //t1:=zahl;
  //t2:=r2;
  //showmessage(copy(r2,2,16));
  //t1:=copy(zahl,2,16);
  //t2:=copy(r2,2,16);
  //showmessage(r1);
  //showmessage(copy(zahl,0,(length(zahl)-3)) +'!   !' + copy(r2,0,(length(r2)-3)) + '!   !' + r2);
  //showmessage(zahl+'!   !' + r2+'!   !' + r2);
  //showmessage(zahl);
  //showmessage(t1);
  //showmessage(t2);
  //if copy(zahl,2,16) = copy(r2,2,16) Then Result:=true else Result:=false;
  //if zahl = r2 Then Result:=true else Result:=false;
  if zahl = AuswertZahl Then Result:=true else Result:=false;
end;


end.
