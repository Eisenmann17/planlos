unit UnitDB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,
  StdCtrls, DBCtrls, Mask, ExtCtrls, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TDataModuleDB = class(TDataModule)
    DataSourceDB: TDataSource;
    DataSourceDB2: TDataSource;
    QueryDB: TZQuery;
    QueryDB2: TZQuery;
  private
    { Private-Deklarationen }
  public
    function DatensatzNeu(FTabelle:String):longint;
    function DatensatzNeuMit(FTabelle,FFelder,FFeldwerte:String):longint;
    function DatensatzLoeschen(FTabelle:String;FNr:longint):Boolean;
    function DatensatzKopieren(FTabelle:String;FNr:longint):longint;
    function DatensatzUeberschreiben(FTabelle:String;FVonNr,FNachNr:longint):Boolean;
    function DatensatzkopierenMit(FTabelle:String;FNr:longint;FFelder,FFeldwert:String):longint;
    function DatensatzLoeschenMitFeld(FTabelle:String;FNr:longint;FFeld:string):Boolean;
    procedure DatensatzkopierenListe(FTabelle:String;FFeld:String;FNr_von,FNr_nach:longint);
    procedure DatensaetzeLoeschen(FTabelle,FFeld:String;FNr:longint);//Sondereinstellung
    procedure DatensatzkopierenListeMitFeld(FTabelle_Von,FFeld_Von:String;FNr_Von:longint;FTabelle_Nach,FFeld_Nach:String;FNr_Nach:longint);
    function StucklisteVonArtikellisteInStammdaten(FNr_Von:longint):longint;
        { Public-Deklarationen }
  end;

var
  DataModuleDB: TDataModuleDB;

implementation

uses   UnitDataModul;
{$R *.DFM}
  //UDBPaht:='C:\DB'
  //labelNr.Caption:=inttostr(             DatensatzNeuMit(EditTabelle.text,EditFelder.text,EditFeldwert.text));
  // CheckBoxKopierenDelete.Checked:=      DatensatzLoeschen('adressen',strtoint(EditDeleteNr.text));
  // LabelKopierNr.Caption:=inttostr(      DatensatzKopieren('Adressen',strtoint(EditKopierNr.text)));
  //                                       DatensatzUeberschreiben('Adressen',strtoint(EditUeberschreibenVon.text),strtoint(EditUebersschreibenNach.text));
  //LabelKopierenMitNr.caption:=inttostr(  DatensatzkopierenMit('Adressen',strtoint(EditkopierenMitNr.text),EditKopierenFelder.text,EditKopierenFeldwert.text));
  //                                       DatensatzLoeschenMitFeld('StuecklistenArtikel',Uzeiger,'Stuecklisten_Nr');
  //                                       DataModuleDB.DatensatzKopierenListe('StuecklistenArtikel','Stuecklisten_Nr',FormPlanlos.GZeiger,CNr);
  //                                       DataModuleDB.DatensatzkopierenListe(FTabelle_Von,FTabelle_Nach,FFeld_Von:String;FNr_Von,FNr_Nach:longint);
  //kopieren von                           FNr:=DataModuleDB.StucklisteVonArtikellisteInStammdaten(QueryStueckliste.Fields[0].Value);




function TDataModuleDB.StucklisteVonArtikellisteInStammdaten(FNr_Von:longint):longint;
var FNeuNr:longint;
    z:integer;
    FGruppe:String;
begin
  QueryDB.close;
  QueryDB.sql.Clear;
  QueryDB.sql.add('SELECT *  FROM Artikelliste WHERE  Nr = '+ inttostr(FNr_Von));
  try QueryDB.open; finally  end;
  DataModuleMyOffice.DSSet('Artikel1',QueryDB);
  FGruppe:=Artikel1.Artikelgruppe;
  DataModuleMyOffice.DSGet('Artikel1','Stueckliste',0);
  QueryDB.close;
  QueryDB.SQL.Clear;
  QueryDB.sql.add('SELECT Nr FROM Stueckliste Order by Nr');
  QueryDB.open;
  QueryDB.Last;
  FNeuNr:=strtoint(QueryDB.Fields[0].AsString);
  QueryDB.close;
  QueryDB.SQL.Clear;
  QueryDB.sql.add('SELECT * FROM Stuecklistengruppe Where Stuecklistengruppe = "'+FGruppe+'"');
  QueryDB.open;
  if QueryDB.RecordCount = 0 then
  begin
    DatensatzNeuMit('Stuecklistengruppe','Stuecklistengruppe','"'+FGruppe+'"');
    showmessage('eine neue Stuecklistengruppe wurde erzeugt   "'+FGruppe+' "');
  end;
  QueryDB.close;
  Result:=FNeuNr;
end;




function TDataModuleDB.DatensatzNeu(FTabelle:String):longint;
var FNeuNr:longint;
begin
  QueryDB.close;
  QueryDB.sql.Clear;
  QueryDB.sql.add('SELECT *  FROM '+FTabelle);
  try
    QueryDB.open;
  finally
  end;
  QueryDB.Append;
  QueryDB.post;
  QueryDB.close;
  QueryDB.SQL.Clear;
  QueryDB.sql.add('SELECT Nr FROM '+ FTabelle + ' Order by Nr');
  QueryDB.open;
  QueryDB.Last;
  FNeuNr:=strtoint(QueryDB.Fields[0].AsString);
  //QueryDB.FlushBuffers;
  Result:=FNeuNr;
end;

function TDataModuleDB.DatensatzNeuMit(FTabelle,FFelder,FFeldwerte:String):longint;
begin
  QueryDB.Close;
  QueryDB.SQL.Clear;
  QueryDB.SQL.Add('Insert Into '+ FTabelle + #10 + #13 + '('+ FFelder + ') '+ #10 + #13 + 'values '+ #10 + #13 +'('+ FFeldwerte+')');
  //showmessage(QueryDB.SQL.text);
  try
    QueryDB.ExecSQL;
  finally
  end;
  QueryDB.Close;
  QueryDB.SQL.Clear;
  QueryDB.sql.add('SELECT Nr FROM '+ FTabelle + ' Order by Nr');
  QueryDB.open;
  QueryDB.Last;
  //QueryDB.FlushBuffers;
  Result:=strtoint(QueryDB.Fields[0].AsString);
end;

function TDataModuleDB.DatensatzLoeschen(FTabelle:String;FNr:longint):Boolean;
begin
  QueryDB.Close;
  QueryDB.SQL.Clear;
  QueryDB.SQL.Add('Delete From ' + FTabelle + ' WHERE Nr = ' + inttostr(Fnr));
  try
    QueryDB.ExecSQL;
  finally
  end;
  QueryDB.Close;
  {QueryDB.SQL.Clear;
  QueryDB.SQL.Add('select * From ' + FTabelle + ' WHERE Nr = ' + inttostr(Fnr));
  try
    QueryDB.open;
  finally
  end;
  QueryDB.edit;
  QueryDB.post;}
  QueryDB.Close;
  Result:=True;
end;

procedure TDataModuleDB.DatensaetzeLoeschen(FTabelle,FFeld:String;FNr:longint);//Sondereinstellung
begin
  QueryDB.Close;
  QueryDB.SQL.Clear;
  QueryDB.SQL.Add('Delete From ' + FTabelle + ' WHERE '+FFeld+' = ' + inttostr(Fnr));
  try
    QueryDB.ExecSQL;
  finally
  end;
  QueryDB.Close;
 { QueryDB.SQL.Clear;
  QueryDB.SQL.Add('Select * From ' + FTabelle + ' WHERE '+FFeld+' = ' + inttostr(Fnr));
  try
    QueryDB.open;
  finally
  end;
  QueryDB.edit;
  QueryDB.post;
  QueryDB.Close;}
end;

function TDataModuleDB.DatensatzLoeschenMitFeld(FTabelle:String;FNr:longint;FFeld:string):Boolean;
begin
  QueryDB.Close;
  QueryDB.SQL.Clear;
  QueryDB.SQL.Add('Delete From ' + FTabelle + ' WHERE '+FFeld+' = ' + inttostr(Fnr));
  try
    QueryDB.ExecSQL;
  finally
  end;
  QueryDB.Close;
  Result:=True;
end;


function TDataModuleDB.DatensatzKopieren(FTabelle:String;FNr:longint):longint;
var FNeuNr:longint;
    z:integer;
begin
  QueryDB.close;
  QueryDB.sql.Clear;
  QueryDB.sql.add('SELECT *  FROM '+FTabelle+' WHERE  Nr = '+ inttostr(FNr));
  try
    QueryDB.open;
  finally
  end;
  QueryDB2.close;
  QueryDB2.sql.Clear;
  QueryDB2.sql.add('SELECT *  FROM '+FTabelle);
  try
    QueryDB2.open;
  finally
  end;
  QueryDB2.Append;
  for Z := 1 to QueryDB.FieldCount - 1 do
  begin
    QueryDB2.Fields[z].Value :=QueryDB.Fields[z].Value;
  end;
  QueryDB2.post;
  QueryDB2.close;
  QueryDB.close;
  QueryDB2.SQL.Clear;
  QueryDB2.sql.add('SELECT Nr FROM '+ FTabelle + ' Order by Nr');
  QueryDB2.open;
  QueryDB2.Last;
  FNeuNr:=strtoint(QueryDB2.Fields[0].AsString);
  QueryDB2.close;
  //showmessage(QueryDB2.Fields[0].AsString);
  Result:=FNeuNr;
end;

function TDataModuleDB.DatensatzUeberschreiben(FTabelle:String;FVonNr,FNachNr:longint):Boolean;
var z:integer;
begin
  QueryDB.close;
  QueryDB.sql.Clear;
  QueryDB.sql.add('SELECT *  FROM '+FTabelle+' WHERE  Nr = '+ inttostr(FVonNr));
  try
    QueryDB.open;
  finally
  end;
  QueryDB2.close;
  QueryDB2.sql.Clear;
  QueryDB2.sql.add('SELECT *  FROM '+FTabelle+' WHERE  Nr = '+ inttostr(FNachNr));
  try
    QueryDB2.open;
  finally
  end;
  QueryDB2.edit;
  for Z := 1 to QueryDB.FieldCount - 1 do
  begin
    QueryDB2.Fields[z].Value :=QueryDB.Fields[z].Value;
  end;
  QueryDB2.post;
  QueryDB2.close;
  QueryDB.close;
end;

function TDataModuleDB.DatensatzkopierenMit(FTabelle:String;FNr:longint;FFelder,FFeldwert:String):longint;
var FNeuNr:longint;
    z:integer;
begin
  QueryDB.Close; //neuer Datensatz mit Feldwerten
  QueryDB.SQL.Clear;
  QueryDB.SQL.Add('Insert Into '+ FTabelle + #10 + #13 + '('+ FFelder + ') '+ #10 + #13 + 'values '+ #10 + #13 +'('+ FFeldwert+')');
  try
    QueryDB.ExecSQL;
  finally
  end;
  QueryDB.Close;
  QueryDB.SQL.Clear;
  QueryDB.sql.add('SELECT Nr FROM '+ FTabelle + ' Order by Nr');
  QueryDB.open;
  QueryDB.Last;
  FNeuNr:=strtoint(QueryDB.Fields[0].AsString); //neeuerdatensatz mit werten ende
  QueryDB2.close;
  QueryDB2.sql.Clear;
  QueryDB2.sql.add('SELECT *  FROM '+FTabelle+' WHERE  Nr = '+ inttostr(FNr)); //Fnr = vonkopieren
  try
    QueryDB2.open;
  finally
  end;
  QueryDB.close;
  QueryDB.sql.Clear;
  QueryDB.sql.add('SELECT *  FROM '+FTabelle+' WHERE  Nr = '+ inttostr(FNeuNr));
  try
    QueryDB.open;
  finally
  end;
  QueryDB.edit;
  for Z := 1 to QueryDB2.FieldCount - 1 do
  begin
    if (QueryDB.Fields[z].AsString = '') or (QueryDB.Fields[z].AsString = '0')
     {if QueryDB.Fields[z].FieldName <> 'Artikel_Nr'} Then QueryDB.Fields[z].Value :=QueryDB2.Fields[z].Value;
        //showmessage(QueryDB2.Fields[z].FieldName+'  =  '+ QueryDB2.Fields[z].AsString);
  end;
  QueryDB.post;
  QueryDB2.close;
  QueryDB.close;
  Result:=FNeuNr;
end;

procedure TDataModuleDB.DatensatzkopierenListe(FTabelle:String;FFeld:String;FNr_von,FNr_nach:longint);
var z,z2:integer;
begin
  QueryDB.Close;//Zieldaten
  QueryDB.SQL.Clear;
  QueryDB.sql.add('SELECT * FROM '+ FTabelle);
  QueryDB.open;
  QueryDB2.close;//Quelldaten
  QueryDB2.sql.Clear;
  QueryDB2.sql.add('SELECT *  FROM '+FTabelle+' WHERE '+FFeld+' = '+ inttostr(FNr_von)); //FNr_von = vonkopieren
  try
    QueryDB2.open;
  finally
  end;
  for Z := 0 to QueryDB2.RecordCount - 1 do
  begin
    QueryDB.Append;
    for Z2 := 1 to QueryDB.FieldCount - 1 do
    begin
      QueryDB.Fields[z2].Value :=QueryDB2.Fields[z2].Value;
    end;
    //QueryDB.post;
    //QueryDB.edit;
    QueryDB.FieldByName(FFeld).AsInteger:=Fnr_nach;
    QueryDB.post;
    QueryDB2.next;
  end;
  QueryDB.close;
  QueryDB2.close;
end;

procedure TDataModuleDB.DatensatzkopierenListeMitFeld(FTabelle_Von,FFeld_Von:String;FNr_Von:longint;FTabelle_Nach,FFeld_Nach:String;FNr_Nach:longint);
var z,z2:integer;
begin
  QueryDB.Close;//Zieldaten
  QueryDB.SQL.Clear;
  QueryDB.sql.add('SELECT * FROM '+ FTabelle_Nach);
  QueryDB.open;
  QueryDB2.close;//Quelldaten
  QueryDB2.sql.Clear;
  QueryDB2.sql.add('SELECT *  FROM '+FTabelle_Von+' WHERE '+FFeld_Von+' = '+ inttostr(FNr_Von)); //FNr_von = vonkopieren
  try
    QueryDB2.open;
  finally
  end;
  for Z := 0 to QueryDB2.RecordCount - 1 do
  begin
    QueryDB.Append;
    for Z2 := 1 to QueryDB.FieldCount - 1 do
    begin
      QueryDB.Fields[z2].Value :=QueryDB2.Fields[z2].Value;
    end;
    //QueryDB.post;
    //QueryDB.edit;
    QueryDB.FieldByName(FFeld_Nach).AsInteger:=FNr_Nach;
    QueryDB.post;
    QueryDB2.next;
  end;
  QueryDB.close;
  QueryDB2.close;
end;

end.
