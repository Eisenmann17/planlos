unit UnitStueckListe;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Dialogs,
  StdCtrls, Forms, DBCtrls, DB, Mask, ExtCtrls, DBTables, Grids, DBGrids,
  Buttons, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFormStueckliste = class(TForm)
    DataSource1: TDataSource;
    PanelTastatur: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    EditStuecklistenGruppe: TDBEdit;
    Label3: TLabel;
    EditBezeichnung: TDBEdit;
    LabelEsc_p: TLabel;
    DBTextNr: TDBText;
    DBGrid1: TDBGrid;
    Label4: TLabel;
    DBEditBearbeiter: TDBEdit;
    DataSource2: TDataSource;
    BevelVK_Preis_p: TBevel;
    BevelEK_Preis_p: TBevel;
    BevelAufschlag_p: TBevel;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    LabelSEK_Preis_p: TLabel;
    LabelSAufschlag_p: TLabel;
    LabelSVK_Preis_p: TLabel;
    DataSource5: TDataSource;
    PanelSummen: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    LabelM: TLabel;
    LabelD: TLabel;
    LabelF: TLabel;
    LabelS: TLabel;
    LabelZ1: TLabel;
    LabelG: TLabel;
    LabelZ2: TLabel;
    LabelZ3: TLabel;
    LabelF2_p: TLabel;
    LabelF3_p: TLabel;
    LabelF4_p: TLabel;
    LabelF5_p: TLabel;
    LabelF6_p: TLabel;
    LabelF8_p: TLabel;
    LabelF10_p: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEditEinheitMenge: TDBEdit;
    DBEditAufschlag: TDBEdit;
    Label9: TLabel;
    ButtonPos_Text: TButton;
    DBMemoPos_text: TDBMemo;
    ButtonSTKopieren: TButton;
    LabelMVK: TLabel;
    LabelDVK: TLabel;
    LabelFVK: TLabel;
    LabelSVK: TLabel;
    Label18: TLabel;
    LabelZ_3: TLabel;
    LabelZ_2: TLabel;
    LabelZ_1: TLabel;
    LabelVK: TLabel;
    LabelEK: TLabel;
    LabelGEinheit: TLabel;
    LabelZ_2Einheit: TLabel;
    LabelZ_3Einheit: TLabel;
    LabelZ_1Einheit: TLabel;
    LabelAuschlag: TLabel;
    LabelMAufschlag: TLabel;
    LabelDAufschlag: TLabel;
    LabelFAufschlag: TLabel;
    LabelSSAufschlag: TLabel;
    QueryStuecklistenArtikel: TZQuery;
    QueryStueckliste: TZQuery;
    QueryArtikelgruppe: TZQuery;
    QueryArtikel: TZQuery;
    QuerySumme: TZQuery;
    ButtonEsc: TButton;
    ButtonF2: TButton;
    ButtonF3: TButton;
    ButtonF4: TButton;
    ButtonF5: TButton;
    ButtonF6: TButton;
    ButtonF8: TButton;
    ButtonF10: TButton;
    SpeedButtonBewegenNachOben: TSpeedButton;
    SpeedButtonBewegenNachUnten: TSpeedButton;
    ButtonsonstigeSummen: TButton;
    ButtonSummieren: TButton;
    CheckBoxSummenSofort: TCheckBox;
    CheckBoxArtikelAussuchen: TCheckBox;
    LabelEsc: TLabel;
    LabelF2: TLabel;
    LabelF3: TLabel;
    LabelF4: TLabel;
    LabelF5: TLabel;
    LabelF6: TLabel;
    LabelF8: TLabel;
    LabelF10: TLabel;
    BevelEK_Preis: TBevel;
    LabelSEK_Preis: TLabel;
    BevelAufschlag: TBevel;
    LabelSAufschlag: TLabel;
    BevelVK_Preis: TBevel;
    LabelSVK_Preis: TLabel;
    ImageTastatur: TImage;
    SpeedButtonBewegenNachOben_p: TSpeedButton;
    SpeedButtonBewegenNachUnten_p: TSpeedButton;
    procedure Focus;
    procedure EditStuecklistenGruppeEnter(Sender: TObject);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonF10Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure ButtonF4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonF8Click(Sender: TObject);
    procedure geheZu(Pos:integer);
    function  berechnung(Berechnungstext:String):Currency;
    procedure DBGrid1ColExit(Sender: TObject);
    procedure summierung(FEinstellung:integer);
    procedure ButtonF3Click(Sender: TObject);
    procedure QueryStuecklistenArtikelBeforeScroll(DataSet: TDataSet);
    procedure ButtonSummierenClick(Sender: TObject);
    procedure CheckBoxSummenSofortClick(Sender: TObject);
    procedure ButtonsonstigeSummenClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ButtonPos_TextClick(Sender: TObject);
    procedure ButtonF6Click(Sender: TObject);
    procedure ButtonSTKopierenClick(Sender: TObject);
    procedure DBEditAufschlagExit(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure SpeedButtonBewegenNachObenClick(Sender: TObject);
    procedure SpeedButtonBewegenNachUntenClick(Sender: TObject);
    procedure ButtonF2Click(Sender: TObject);
    procedure ButtonF5Click(Sender: TObject);
    procedure QueryStuecklistenArtikelAfterPost(DataSet: TDataSet);
    procedure QueryStuecklistenArtikelBeforePost(DataSet: TDataSet);
    procedure DBGrid1Exit(Sender: TObject);
    procedure CheckBoxArtikelAussuchenClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function  FeldEineZahl(Zahl:String):Boolean;
    //Bedienung  //Eingang/Ausgang  //DB
  private
    { Private-Deklarationen }
  public
    class Function an(FEinstellung:integer):TStringList;
  end;

var
  FormStueckliste: TFormStueckliste;
  UZeiger:longint;
  UZeigerNeu{,UArtikelNeu},USummenButtonAn:Boolean;
  UFocus:String;
  UDragPos:integer;
  UArtikelAusSuchen,UPos_TextSichbar,UFocusListe:Boolean;
  UActiveListe:String;
  {UArtikelZurueck,}UEinstelllisteArtikelAussuchen:TStringList;
  UPos_texthoehe,UEinstellung:integer;
  UAltcurser:Boolean;
  UTiteltext,UStuecklistenartikelTabellenName:String;
  UsrollAus,UArtikelNeu:Boolean;
  //UModuldaten:Boolean;

implementation

uses TempForm, UnitMeldefenster, UnitDB, UnitModule, UnitStuecklistenGruppe,
  UnitAdresse, UnitArtikelgruppe, UnitArtikel, UnitMaskeEinheit,
  UnitArtikelAussuchen,UnitDataModul;

{$R *.DFM}

class Function TFormStueckliste.an(FEinstellung:integer):TStringList; //Eingang/Ausgang
begin
  UEinstellung:=FEinstellung;
  FormStueckliste.ShowModal;
  //Result:=UArtikelZurueck;
end;

procedure TFormStueckliste.Focus;//Bedienung
begin
  If (ActiveControl.Name = EditStuecklistenGruppe.Name) or
     (ActiveControl.Name = DBEditBearbeiter.Name) or
     (ActiveControl.Name = DBEditEinheitMenge.Name) or
     (DBGrid1.SelectedField.FieldName = 'Artikelgruppe') or
     (DBGrid1.SelectedField.FieldName = 'Artikel') or
     (DBGrid1.SelectedField.FieldName = 'EinheitMenge') or
     (DBGrid1.SelectedField.FieldName = 'Einheit_EK') Then
  begin
    if (ActiveControl.Name = DBGrid1.Name) then begin //or (ActiveControl.Name ='ButtonF5') or (ActiveControl.Name ='ButtonF6') (ActiveControl.Name ='ButtonF8')then begin
      UFocus:= DBGrid1.SelectedField.FieldName;
      ButtonF4.Enabled:=False;
      ButtonF5.Enabled:=True;
      ButtonF6.Enabled:=True;
      ButtonF8.Enabled:=True;
      UFocusListe:=True;
    end
    else
    begin
      UFocus:=ActiveControl.Name;
      ButtonF4.Enabled:=True;
      //Showmessage('UFocus ='+UFocus+'    ActiveControl.Name ='+ActiveControl.Name);
      ButtonF5.Enabled:=False;
      ButtonF6.Enabled:=False;
      ButtonF8.Enabled:=False;
      UFocusListe:=False;
    End;
  end
  else
  begin
    UFocus:='';
    ButtonF4.Enabled:=False;
  end;
  if DBGrid1.SelectedField<>nil then begin
    if (DBGrid1.SelectedField.FieldName = 'Gewicht') or
       (DBGrid1.SelectedField.FieldName = 'Zahl1') or
       (DBGrid1.SelectedField.FieldName = 'Zahl2') or
       (DBGrid1.SelectedField.FieldName = 'Zahl3') or
       (DBGrid1.SelectedField.FieldName = 'Pos') or
       (DBGrid1.SelectedField.FieldName = 'Berechnungsart') or
       (DBGrid1.SelectedField.FieldName = 'StueckListen_Nr') or
       //(DBGrid1.SelectedField.FieldName = 'EK_Preis') or
       (DBGrid1.SelectedField.FieldName = 'VK_Preis') or
       //(DBGrid1.SelectedField.FieldName = 'Auf. %') or
       (DBGrid1.SelectedField.FieldName = 'Nr') Then
    begin
      DBGrid1.SelectedField:=QueryStuecklistenArtikel.FieldByName('Pos');
      DBGrid1.SelectedField:=QueryStuecklistenArtikel.FieldByName('Artikelgruppe');
      ButtonF5.Enabled:=True;
      ButtonF6.Enabled:=True;
      ButtonF8.Enabled:=True;
    end;
  end;
end;

procedure TFormStueckliste.EditStuecklistenGruppeEnter(Sender: TObject);//Bedienung
begin
  Focus;
end;

procedure TFormStueckliste.ButtonabbrechenClick(Sender: TObject);//Eingang/Ausgang
  var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,LabelSEK_Preis,LabelSAufschlag,LabelSVK_Preis,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,LabelSEK_Preis_p,LabelSAufschlag_p,LabelSVK_Preis_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  if FAbbrechen then
  begin
    if UZeigerNeu then //neu
      begin
        QueryStueckliste.close;
        QueryStuecklistenArtikel.close;
        DataModuleDB.DatensatzLoeschenMitFeld('StuecklistenArtikel',Uzeiger,'Stuecklisten_Nr');
        DataModuleDB.DatensatzLoeschen('Stueckliste',Uzeiger);
      end
    else               //ändern
    begin
      QueryStuecklistenArtikel.cancel;QueryStuecklistenArtikel.close;
      QueryStueckliste.Cancel;QueryStueckliste.close;
    end;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,LabelSEK_Preis,LabelSAufschlag,LabelSVK_Preis,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,LabelSEK_Preis_p,LabelSAufschlag_p,LabelSVK_Preis_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
end;

procedure TFormStueckliste.ButtonF10Click(Sender: TObject);//Eingang/Ausgang
begin
  if UEinstellung > 0 then QueryStueckliste.FieldByName('Geaendert').Asinteger:=1;
  QueryStueckliste.FieldByName('MatAufschlag').AsFloat:=StrToFloat(LabelMAufschlag.Caption);
  QueryStueckliste.FieldByName('DieAufschlag').AsFloat:=StrToFloat(LabelDAufschlag.Caption);
  QueryStueckliste.FieldByName('FreAufschlag').AsFloat:=StrToFloat(LabelFAufschlag.Caption);
  QueryStueckliste.FieldByName('SonAufschlag').AsFloat:=StrToFloat(LabelSSAufschlag.Caption);
  QueryStueckliste.Post;
  QueryStuecklistenArtikel.edit;
  QueryStuecklistenArtikel.FieldByName('VK_Preis').AsString:=Formatcurr('0.00',berechnung(QueryStuecklistenArtikel.FieldByName('Berechnungsart').AsString));
  QueryStuecklistenArtikel.Post;QueryStuecklistenArtikel.edit;
  summierung(1);//summierung mit abspeicherung
  FormPlanlos.Gzeiger:=QueryStueckliste.Fields[0].Value;
  DataModuleMyOffice.DSNil('Artikel1');DataModuleMyOffice.DSNil('Artikel2');
  DataModuleMyOffice.DSSet('Artikel1',QueryStueckliste);
  Artikel1.ArtikelArt:='Stueckliste';
  QueryStueckliste.close;
  QueryStuecklistenArtikel.close;
  close;
end;

procedure TFormStueckliste.FormKeyDown(Sender: TObject; var Key: Word;//Bedienung
  Shift: TShiftState);
begin
  if (Shift = [ssShift]) or (Shift = [ssAlt]) then
  begin
    if Shift = [ssShift] then
    begin
      if Key = 27 then  ButtonabbrechenClick(Self);
      if Key = VK_F3 then  Showmessage(QueryStueckliste.SQL.Strings[0]);
      if Key = VK_F4 then  Showmessage(QueryStuecklistenArtikel.SQL.Strings[0]);
      if Key = VK_F5 then  Showmessage(inttoStr(UEinstellung));
      if Key = VK_F7 then  Showmessage(UFocus);
    end
    Else
    begin
      if Key = VK_DOWN then begin UAltcurser:=True;SpeedButtonBewegenNachUntenClick(Self);end;
      if Key = VK_UP then begin UAltcurser:=True;SpeedButtonBewegenNachObenClick(Self);end;
    end;
  end
  else
  begin
    if Key = VK_F5 then ButtonF5Click(Self);
    if Key = VK_F2 then ButtonF2Click(Self);
    if Key = VK_F4 then ButtonF4Click(Self);
    if Key = VK_F6 then ButtonF6Click(Self);
    if Key = VK_F10 then ButtonF10Click(Self);
    if Key = VK_F8 then ButtonF8Click(Self);
    if Key = VK_F3 then ButtonF3Click(Self);
    if (Key = VK_Return) Then if (DBGrid1.SelectedField.FieldName = 'Menge') or (DBGrid1.SelectedField.FieldName = 'EK_Preis') or (DBGrid1.SelectedField.FieldName = 'Auf. %') then DBGrid1ColExit(Self);//Bedienung
  end;
end;

procedure TFormStueckliste.ButtonF4Click(Sender: TObject);//Bedienung
var Fnr,FArtikelNr,FPos:integer;Fname,FDatum:string;Par:TStringList;
begin
  If UFocus <> '' then
  begin
    DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,LabelSEK_Preis,LabelSAufschlag,LabelSVK_Preis,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,LabelSEK_Preis_p,LabelSAufschlag_p,LabelSVK_Preis_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
    FArtikelNr:=QueryStuecklistenArtikel.FieldByName('Nr').AsInteger;
    FPos:=QueryStuecklistenArtikel.FieldByName('Pos').AsInteger;
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
    Par:=TStringList.Create;
    if UFocus = 'Einheit_EK'then
    begin
      Par:=TForm1.an(FormEinheit,DBGrid1.SelectedField.AsString,GModulart,GBenutzer,136);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then
      begin
       QueryStuecklistenArtikel.edit;
       DBGrid1.SelectedField.AsString:=Fname;
       DBGrid1.SelectedField:=QueryStuecklistenArtikel.FieldByName('Aufschlag');
      end;
    end;
    if UFocus = 'EinheitMenge'then begin
      Par:=TForm1.an(FormEinheit,DBGrid1.SelectedField.AsString,GModulart,GBenutzer,135);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then
      begin
       QueryStuecklistenArtikel.edit;
       DBGrid1.SelectedField.AsString:=Fname;
       DBGrid1.SelectedField:=QueryStuecklistenArtikel.FieldByName('EK_Preis');
      end;
    end;
    if (UFocus = 'Artikel') or (UFocus = 'Artikelgruppe')then
    begin
      FArtikelNr:=QueryStuecklistenArtikel.FieldByName('Nr').AsInteger;
      FPos:=QueryStuecklistenArtikel.FieldByName('Pos').AsInteger;
      DataModuleMyOffice.DSNil('Artikel1');DataModuleMyOffice.DSNil('Artikel2');
      FormArtikelAussuchen2.an(QueryStuecklistenArtikel.FieldByName('Artikelgruppe').AsString,QueryStuecklistenArtikel.FieldByName('Artikel').AsString,2,'Artikel',UEinstelllisteArtikelAussuchen);
      if Artikel1.Nr<>0 then begin
        Artikel1.Stuecklisten_Nr:=UZeiger;
        if UEinstellung = 1 then Artikel1.ModulNr:=FormPlanlos.GModulNrFuerStuckliste;
        if UArtikelNeu Then Artikel1.Pos:=QueryStuecklistenArtikel.RecordCount+1 Else Artikel1.Pos:=FPos;
        Artikel1.Artikel_Nr:=Artikel1.Nr;
        QueryStuecklistenArtikel.close;
        if UArtikelNeu Then DataModuleMyOffice.DSGet('Artikel1',UStuecklistenartikelTabellenName,0)Else
             DataModuleMyOffice.DSGet('Artikel1',UStuecklistenartikelTabellenName,FArtikelNr);
        QueryStuecklistenArtikel.open;
        if UArtikelNeu Then geheZu(QueryStuecklistenArtikel.RecordCount) Else geheZu(FPos);
        QueryStuecklistenArtikel.FieldByName('VK_Preis').AsString:=Formatcurr('0.00',berechnung(QueryStuecklistenArtikel.FieldByName('Berechnungsart').AsString));
        summierung(0);
        DBGrid1.SelectedField:=QueryStuecklistenArtikel.FieldByName('Menge');
      end;
    end;
    /// KopfDaten
    if UFocus = 'DBEditBearbeiter'then begin
      Par:=TForm1.an(FormAdresse,DBEditBearbeiter.text,GModulart,GBenutzer,132);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then DBEditBearbeiter.text:=Fname;
      ActiveControl:=DBGrid1;
      DBGrid1.SelectedField:=QueryStuecklistenArtikel.FieldByName('Artikelgruppe');
    end;

    if UFocus = 'DBEditEinheitMenge'then begin
      Par:=TForm1.an(FormEinheit,DBEditEinheitMenge.text,GModulart,GBenutzer,133);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then DBEditEinheitMenge.text:=Fname;
      if  DBEditBearbeiter.Visible then ActiveControl:=DBEditBearbeiter
      Else if UPos_TextSichbar then ActiveControl:=DBMemoPos_text Else ActiveControl:=DBGrid1;
    end;
    if UFocus = 'EditStuecklistenGruppe' then begin
      Par:=TForm1.an(FormStuecklistengruppe,EditStuecklistenGruppe.text,GModulart,GBenutzer,131);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then EditStuecklistenGruppe.text:=Fname;
      ActiveControl:=EditBezeichnung;
    end;
    DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,LabelSEK_Preis,LabelSAufschlag,LabelSVK_Preis,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,LabelSEK_Preis_p,LabelSAufschlag_p,LabelSVK_Preis_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  end;
end;

procedure TFormStueckliste.FormActivate(Sender: TObject);//Eingang/Ausgang
var i:integer;
begin
  //if UEinstellung = 1 then DBEditBearbeiter.Visible:=False;
  UsrollAus:=False;
  UAltcurser:=False;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,LabelSEK_Preis,LabelSAufschlag,LabelSVK_Preis,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,LabelSEK_Preis_p,LabelSAufschlag_p,LabelSVK_Preis_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  UEinstelllisteArtikelAussuchen:=TStringList.Create;
  UPos_TextSichbar:=False;
  UPos_texthoehe:=0;
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  if UEinstellung = 0 then
  begin
    if UZeigerNeu then UTiteltext:='Neue Stückliste in den Stammdaten' Else UTiteltext:='Stückliste ändern in den Stammdaten';
    ButtonSTKopieren.Visible:=False;
    Label4.Visible:=True;
    DBEditBearbeiter.Visible:=True;
    Label1.Visible:=True;
    DBTextNr.Visible:=True;
  end;
  if UEinstellung = 1 then
  begin
    if UZeigerNeu then UTiteltext:='Neue Stückliste in der Artikelliste' Else UTiteltext:='Stückliste ändern in der Artikelliste';
    ButtonSTKopieren.Visible:=True;
    Label4.Visible:=False;
    DBEditBearbeiter.Visible:=False;
    Label1.Visible:=False;
    DBTextNr.Visible:=False;
  end;
  FormStueckliste.Caption:=UTiteltext;
  //Einstellungen für "Artikel aussuchen"  einfach eine zeile aktvieren
  //UEinstelllisteArtikelAussuchen.Clear;
  //UEinstelllisteArtikelAussuchen.add('');
  //UEinstelllisteArtikelAussuchen[0]:=  Width:=540; if UEinstellliste[0]<>''then Width:=strtoint(UEinstellliste[0]);
  //UEinstelllisteArtikelAussuchen[1]:=  URahmenBreite:=2;             if UEinstellliste[1]<>''then URahmenBreite:=strtoint(UEinstellliste[1]);
  //UEinstelllisteArtikelAussuchen[2]:=  UGruppeSpaltenbreite1:=1;     if UEinstellliste[2]<>''then UGruppeSpaltenbreite1:=strtoint(UEinstellliste[2]);
  //UEinstelllisteArtikelAussuchen[3]:=  UGruppeSpaltenbreite2:=0;     if UEinstellliste[3]<>''then UGruppeSpaltenbreite2:=strtoint(UEinstellliste[3]);
  //UEinstelllisteArtikelAussuchen[4]:=  UDBGridGruppeLeft:=130;       if UEinstellliste[4]<>''then UDBGridGruppeLeft:=strtoint(UEinstellliste[4]);
  //UEinstelllisteArtikelAussuchen[5]:=  DBGridGruppe.Width:=187;      if UEinstellliste[5]<>''then DBGridGruppe.Width:=strtoint(UEinstellliste[5]);
  //UEinstelllisteArtikelAussuchen[6]:=  UArtikelSpaltenbreite1:=1;    if UEinstellliste[6]<>''then UArtikelSpaltenbreite1:=strtoint(UEinstellliste[6]);
  //UEinstelllisteArtikelAussuchen[7]:=  UArtikelSpaltenbreite2:=0;    if UEinstellliste[7]<>''then UArtikelSpaltenbreite2:=strtoint(UEinstellliste[7]);
  //UEinstelllisteArtikelAussuchen[8]:=  USQLFilterEinstellungGruppe1:= UEinstellliste[8];
  //UEinstelllisteArtikelAussuchen[9]:=  USQLFilterEinstellungGruppe2:= UEinstellliste[9];
  //UEinstelllisteArtikelAussuchen[10]:=  USQLFilterEinstellungGruppe3:= UEinstellliste[10];
  //UEinstelllisteArtikelAussuchen[11]:=  USQLFilterEinstellungGruppe4:= UEinstellliste[11];
  //UEinstelllisteArtikelAussuchen[12]:=  USQLFilterEinstellungGruppe5:= UEinstellliste[12];
  //UEinstelllisteArtikelAussuchen[13]:=  USQLFilterEinstellungGruppe6:= UEinstellliste[13];
  //UEinstelllisteArtikelAussuchen[14]:=  USQLFilterEinstellungGruppe7:= UEinstellliste[14];
  //UEinstelllisteArtikelAussuchen[15]:=  USQLFilterEinstellungGruppe8:= UEinstellliste[15];
  //UEinstelllisteArtikelAussuchen[16]:=  USQLFilterEinstellungArtikel1:=UEinstellliste[16];
  //UEinstelllisteArtikelAussuchen[17]:=  USQLFilterEinstellungArtikel2:=UEinstellliste[17];
  //UEinstelllisteArtikelAussuchen[18]:=  USQLFilterEinstellungArtikel3:=UEinstellliste[18];
  //UEinstelllisteArtikelAussuchen[19]:=  USQLFilterEinstellungArtikel4:=UEinstellliste[19];
  //UEinstelllisteArtikelAussuchen[20]:=  USQLFilterEinstellungArtikel5:=UEinstellliste[20];
  //UEinstelllisteArtikelAussuchen[21]:=  USQLFilterEinstellungArtikel6:=UEinstellliste[21];
  //UEinstelllisteArtikelAussuchen[22]:=  USQLFilterEinstellungArtikel7:=UEinstellliste[22];
  //UEinstelllisteArtikelAussuchen[23]:=  USQLFilterEinstellungArtikel8:=UEinstellliste[23];
  //UEinstelllisteArtikelAussuchen[24]:=  EnaF2:=False; if UEinstellliste[24]='True' then EnaF2:=True;
  //UEinstelllisteArtikelAussuchen[25]:=  EnaF3:=False; if UEinstellliste[25]='True' then EnaF3:=True;
  //UEinstelllisteArtikelAussuchen[26]:=  EnaF4:=False; if UEinstellliste[26]='True' then EnaF4:=True;
  //UEinstelllisteArtikelAussuchen[27]:=  EnaF5:=False; if UEinstellliste[27]='True' then EnaF5:=True;
  //UEinstelllisteArtikelAussuchen[28]:=  EnaF6:=False; if UEinstellliste[28]='True' then EnaF6:=True;
  //UEinstelllisteArtikelAussuchen[29]:=  EnaF7:=False; if UEinstellliste[29]='True' then EnaF7:=True;
  //UEinstelllisteArtikelAussuchen[30]:=  EnaF8:=False; if UEinstellliste[30]='True' then EnaF8:=True;
  //UEinstelllisteArtikelAussuchen[31]:=  EnaF9:=False; if UEinstellliste[31]='True' then EnaF9:=True;
  //UEinstelllisteArtikelAussuchen[32]:=  UErledigtArtikelAusschalten:=False;  if UEinstellliste[32]='True'then UErledigtArtikelAusschalten:=True;
  //UEinstelllisteArtikelAussuchen[33]:=  UMarierenZeigenAn:=False;            if UEinstellliste[33]='True'then UMarierenZeigenAn:=True;//überhaupt  anzeigen
  //UEinstelllisteArtikelAussuchen[34]:=  UErledigtArtikelAn:=False;           if UEinstellliste[34]='True'then UErledigtArtikelAn:=True;//überhaupt  anzeigen
  //UEinstelllisteArtikelAussuchen[35]:=  UEnaButton1:=True;                   if UEinstellliste[35]='False'then UEnaButton1:=False;
  //UEinstelllisteArtikelAussuchen[36]:=  UEnaButton2:=False;                  if UEinstellliste[36]='True'then UEnaButton2:=True;
  //UEinstelllisteArtikelAussuchen[37]:=  UEnaButton3:=False;                  if UEinstellliste[37]='True'then UEnaButton3:=True;
  //UEinstelllisteArtikelAussuchen[38]:=  UEnaButton4:=False;                  if UEinstellliste[38]='True'then UEnaButton4:=True;
  //UEinstelllisteArtikelAussuchen[39]:=  UEnaButton5:=False;                  if UEinstellliste[39]='True'then UEnaButton5:=True;
  //UEinstelllisteArtikelAussuchen[40]:=  UEnaButton6:=False;                  if UEinstellliste[40]='True'then UEnaButton6:=True;
  //UEinstelllisteArtikelAussuchen[41]:=  UEnaButton7:=False;                  if UEinstellliste[41]='True'then UEnaButton7:=True;
  //UEinstelllisteArtikelAussuchen[42]:=  UEnaButton8:=False;                  if UEinstellliste[42]='True'then UEnaButton8:=True;
  //UEinstelllisteArtikelAussuchen[43]:=  UCaption1:='Artikel aussuchen';                                  if UEinstellliste[43]<>''then UCaption1:=UEinstellliste[43];
  //UEinstelllisteArtikelAussuchen[44]:=  UCaption2:='zurück für freie Eingabe';                           if UEinstellliste[44]<>''then UCaption1:=UEinstellliste[44];
  //UEinstelllisteArtikelAussuchen[45]:=  UCaption3:='Stückliste aussuchen';                               if UEinstellliste[45]<>''then UCaption1:=UEinstellliste[45];
  //UEinstelllisteArtikelAussuchen[46]:=  UCaption4:='Artikel aus dem/der '+GBeziehungs_Name+' aussuchen'; if UEinstellliste[46]<>''then UCaption1:=UEinstellliste[46];
  //UEinstelllisteArtikelAussuchen[47]:=  UCaption5:='Artikel aus dem Projekt aussuchen';                  if UEinstellliste[47]<>''then UCaption1:=UEinstellliste[47];
  //UEinstelllisteArtikelAussuchen[48]:=  UCaption6:='Artikel aus allen '+GModulart_Name+' aussuchen';     if UEinstellliste[48]<>''then UCaption1:=UEinstellliste[48];
  //UEinstelllisteArtikelAussuchen[49]:=  UCaption7:='Artikel aussuchen aus allen Modulen';                if UEinstellliste[49]<>''then UCaption1:=UEinstellliste[49];
  //UEinstelllisteArtikelAussuchen[50]:=  UCaption8:='noch nicht Bestellte Artikel aussuchen';            if UEinstellliste[50]<>''then UCaption1:=UEinstellliste[50];
  for i:=0 to 100 do UEinstelllisteArtikelAussuchen.add('');
  UEinstelllisteArtikelAussuchen[24]:='1';
  UEinstelllisteArtikelAussuchen[27]:='1';
  UEinstelllisteArtikelAussuchen[28]:='1';
  UEinstelllisteArtikelAussuchen[29]:='1';
  UEinstelllisteArtikelAussuchen[30]:='1';
  UEinstelllisteArtikelAussuchen[31]:='1';
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  if QueryStueckliste.Active then QueryStueckliste.close;
  QueryStueckliste.sql.Clear;
  if UEinstellung = 0 then QueryStueckliste.sql.add('Select * From Stueckliste Where nr = '+ inttostr(Uzeiger));
  if UEinstellung = 1 then QueryStueckliste.sql.add('Select * From ArtikelListe Where nr = '+ inttostr(Uzeiger));
  try
    QueryStueckliste.open;//Self.Query1.Edit;
  finally
  end;
  QueryStueckliste.edit;
  if QueryStuecklistenArtikel.Active then QueryStuecklistenArtikel.close;
  QueryStuecklistenArtikel.sql.Clear;
  if UEinstellung = 0 then QueryStuecklistenArtikel.sql.add('Select * From Stuecklistenartikel Where Stuecklisten_Nr = '+ inttostr(Uzeiger)+ ' Order by Pos' );
  if UEinstellung = 1 then QueryStuecklistenArtikel.sql.add('Select * From ArtikelListeS Where Stuecklisten_Nr = '+ inttostr(Uzeiger)+ ' Order by Pos' );
  try
    QueryStuecklistenArtikel.open;//Self.Query1.Edit;
  finally
  end;
  if UEinstellung = 0 then UStuecklistenartikelTabellenName:='Stuecklistenartikel';
  if UEinstellung = 1 then UStuecklistenartikelTabellenName:='ArtikelListeS';
  QueryStuecklistenArtikel.edit;
  if UZeigerNeu then
    ActiveControl:=EditBezeichnung
  else
  begin
    ActiveControl:=DBGrid1;
    DBGrid1.SelectedField:=QueryStuecklistenArtikel.FieldByName('Artikelgruppe');
  end;
  LabelZ_1.Caption:=GZahl1;
  LabelZ_2.Caption:=GZahl2;
  LabelZ_3.Caption:=GZahl3;
  LabelGEinheit.Caption:=GEinheitGewicht;
  LabelZ_1Einheit.Caption:=GEinheitZahl1;
  LabelZ_2Einheit.Caption:=GEinheitZahl2;
  LabelZ_3Einheit.Caption:=GEinheitZahl3;
  USummenButtonAn:=False;
  ButtonsonstigeSummenClick(Self);
  if G_Artikelgruppe<>''then begin
    EditStuecklistenGruppe.Text:=G_Artikelgruppe;
    ActiveControl:=EditBezeichnung;
    G_Artikelgruppe:='';
  end;
  summierung(0);
  if UZeigerNeu = False  then DBGrid1.SelectedField:=QueryStuecklistenArtikel.FieldByName('Artikelgruppe');
end;

procedure TFormStueckliste.FormClose(Sender: TObject;//Eingang/Ausgang
  var Action: TCloseAction);
begin
  UEinstellung:= 0 ;// zurücksetzen
  GOffeneFenster:=GOffeneFenster-1;
end;


procedure TFormStueckliste.ButtonF8Click(Sender: TObject);//DB
var Pos,i:integer;
begin
   Pos:=strtoint(QueryStuecklistenArtikel.FieldByName('Pos').Asstring);
   QueryStuecklistenArtikel.DisableControls;
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
   DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,LabelSEK_Preis,LabelSAufschlag,LabelSVK_Preis,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,LabelSEK_Preis_p,LabelSAufschlag_p,LabelSVK_Preis_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
   if Meldefenster.an(1,'soll die Position-Nr: '+inttostr(Pos),'gelöscht werden','') Then
   begin
    UsrollAus:=True;
    QueryStuecklistenArtikel.Delete;
    for I:=Pos to QueryStuecklistenArtikel.RecordCount do
    begin
      //QueryArtikelListe.Next;
      QueryStuecklistenArtikel.edit;
      QueryStuecklistenArtikel.FieldByName('Pos').Asstring:=inttostr(I);
      QueryStuecklistenArtikel.post;
      QueryStuecklistenArtikel.Next;
    end;
    UsrollAus:=False;
   geheZu(Pos);
   end;
   QueryStuecklistenArtikel.EnableControls;
   DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,LabelSEK_Preis,LabelSAufschlag,LabelSVK_Preis,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,LabelSEK_Preis_p,LabelSAufschlag_p,LabelSVK_Preis_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
   summierung(0);
   //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormStueckliste.geheZu(Pos:integer);//DB
var i:integer;
begin
  UsrollAus:=True;
  QueryStuecklistenArtikel.disableControls;
  QueryStuecklistenArtikel.First;
  for I:=1 to QueryStuecklistenArtikel.RecordCount do
    begin
      if QueryStuecklistenArtikel.FieldByName('Pos').Asstring = inttostr(Pos) then break;
      QueryStuecklistenArtikel.Next;
    end;
  QueryStuecklistenArtikel.EnableControls;
  UsrollAus:=False
end;

function TFormStueckliste.berechnung(Berechnungstext:String):Currency;//DB
var N1,N2,E,Aufschlag,Rabatt:Currency;
   i:integer;
   ErsteZahl:Boolean;
   Feld,O,O2,s,z:String;
begin
  s:=Berechnungstext;
  if s='' then s:='Menge*EK_Preis';
  //QueryArtikelliste.post;
  N1:=0.0;N2:=0.0;E:=0.0;
  ErsteZahl:=True;
  for i:=1 to length(s) do
  begin
    z:=copy(s,i,1);
    if (z='+')or(z='-')or(z='*')or(z='/') then
    begin
      if ErsteZahl Then O2:=Z  Else begin O:=O2;O2:=Z; end;
      if (FeldEineZahl(Feld)=False) and (QueryStuecklistenArtikel.FieldByName(Feld).AsString ='') then N1:=0.0;
      if ErsteZahl then  begin
        if FeldEineZahl(Feld) then N1:=strtoFloat(Feld)
        Else begin
          if QueryStuecklistenArtikel.FieldByName(Feld).AsString ='' then N1:=0.0
          Else N1:=strtoFloat(QueryStuecklistenArtikel.FieldByName(Feld).AsString);
        End;
        ErsteZahl:=False;
      end else  begin
        if FeldEineZahl(Feld) then N2:=strtoFloat(Feld)
        Else begin
          if QueryStuecklistenArtikel.FieldByName(Feld).AsString ='' then N2:=0.0
          Else N2:=strtoFloat(QueryStuecklistenArtikel.FieldByName(Feld).AsString);
        end;
        if O='+' then E:=N1 + N2;
        if O='-' then E:=N1 - N2;
        if O='*' then E:=N1 * N2;
        if O='/' then if N2=0.0 then E:=0.0 Else E:=N1 / N2;
        N1:=E;
      end;
      Feld:='';
    end
    else Feld:=Feld+z;
  end;  //ende for
  if (ErsteZahl=False) and (N1<>0.0) then
  begin
    //if QueryStuecklistenArtikel.FieldByName(Feld).AsString ='' then N1:=0.0
    //else
    //begin
      if FeldEineZahl(Feld) then N2:=strtoFloat(Feld)
      Else begin
       if QueryStuecklistenArtikel.FieldByName(Feld).AsString ='' then N2:=0.0
       Else N2:=strtoFloat(QueryStuecklistenArtikel.FieldByName(Feld).AsString);
      End;
      O:=O2;
      if O='+' then E:=N1 + N2;
      if O='-' then E:=N1 - N2;
      if O='*' then E:=N1 * N2;
      if O='/' then if N2=0.0 then E:=0.0 Else E:=N1 / N2;
      N1:=E;
    //end;
    if QueryStuecklistenArtikel.FieldByName('Aufschlag').AsString <>'' then
      N1:=N1/100*(strtocurr(QueryStuecklistenArtikel.FieldByName('Aufschlag').AsString)+100);
  end;
  if QueryStuecklistenArtikel.FieldByName('Pos').AsInteger = 0 Then begin
    QueryStuecklistenArtikel.FieldByName('Stuecklisten_Nr').AsInteger:=UZeiger;
    QueryStuecklistenArtikel.FieldByName('Pos').AsInteger:=QueryStuecklistenArtikel.RecordCount+1;
  end;
  Result:=N1;
end;

function TFormStueckliste.FeldEineZahl(Zahl:String):Boolean;
Var Komma,ZahlJa:Boolean;
    I:Integer;
    z:String;
begin
  Komma:=False;
  ZahlJa:=True;
  z:='';
  if Zahl='' Then  ZahlJa:=False;
  for i:=1 to length(Zahl) do begin
    z:=copy(Zahl,i,1);
    if (z='0') or (z='1') or (z='2') or (z='3') or (z='4') or (z='5') or (z='6') or (z='7') or (z='8') or (z='9') or (z=',') then begin
       If (z=',') Then begin
         If Komma then  ZahlJa:=False;
         Komma:=True;
       end;
    end
    Else  ZahlJa:=False;
  end;
  Result:=ZahlJa;
end;

procedure TFormStueckliste.DBGrid1ColExit(Sender: TObject);//Bedienung
begin
  //if QueryStuecklistenArtikel.FieldByName('Artikel').AsString <>'' then UArtikelNeu:=False;
  if (DBGrid1.SelectedField.FieldName = 'Menge') or (DBGrid1.SelectedField.FieldName = 'EK_Preis') or (DBGrid1.SelectedField.FieldName = 'Aufschlag') then begin
    QueryStuecklistenArtikel.edit;
    QueryStuecklistenArtikel.FieldByName('VK_Preis').AsString:=Formatcurr('0.00',berechnung(QueryStuecklistenArtikel.FieldByName('Berechnungsart').AsString));
    QueryStuecklistenArtikel.Post;QueryStuecklistenArtikel.edit;
    summierung(0);
  end;
  //if DBGrid1.SelectedField.FieldName = 'Menge' then Showmessage('DBGrid1ColExit "Menge"'+DBGrid1.SelectedField.FieldName);
end;

procedure TFormStueckliste.summierung(FEinstellung:integer);//DB
var i:integer;
    SEK_Preis,SEKPreis,SAufschlag,S_Aufschlag,SVKPreis,SVK_Preis,M_preis,D_preis,F_preis,S_preis,M_preisVK,D_preisVK,F_preisVK,S_preisVK,G,Z1,Z2,Z3:Double;
    //SEKPreis und SAufschlag sind Zwischenwerte
    Kostenart:char;
    FAufschlag:Double;
    FTempPos: integer;
begin
    if (CheckBoxSummenSofort.Checked) or (USummenButtonAn) then
    begin
      if QuerySumme.Active then QuerySumme.close;
      QuerySumme.sql.Clear;
      QuerySumme.sql.add(QueryStuecklistenArtikel.SQL.Strings[0]);
      try
        QuerySumme.open;//Self.Query1.Edit;
      finally
      end;
      SEK_Preis:=0;//Summierung von EK
      SVK_Preis:=0;//Summierung von VK
      S_Aufschlag:=0;//Tatsächlicher aufschlag in der ganzen Stückliste
      SEKPreis:=0;//wirklicher EK Preis pro datensatz
      M_preis:=0;D_preis:=0;F_preis:=0;S_preis:=0;
      M_preisVK:=0;D_preisVK:=0;F_preisVK:=0;S_preisVK:=0;
      G:=0;Z1:=0;Z2:=0;Z3:=0;
      if (QuerySumme.RecordCount > 0) Then
      begin
        QuerySumme.First;
        for i := 1 to QuerySumme.RecordCount do
        begin
          SAufschlag:=0;//Temporär für den Datensatz
          SEKPreis:=0;//Temporär für den Datensatz
          SVKPreis:=0;//Temporär für den Datensatz
          if QuerySumme.FieldByName('VK_Preis').AsFloat > 0 then
          begin
            SAufschlag:=QuerySumme.FieldByName('Aufschlag').AsFloat;
            SVK_Preis:=SVK_Preis+QuerySumme.FieldByName('VK_Preis').AsFloat;
            SVKPreis:=QuerySumme.FieldByName('VK_Preis').AsFloat;
            SEKPreis:=QuerySumme.FieldByName('VK_Preis').AsFloat / (1+(SAufschlag/100));
            SEK_Preis:=SEK_Preis+SEKPreis;
            if QuerySumme.FieldByName('KostenArt').AsString = 'M' then Kostenart:='M';
            if QuerySumme.FieldByName('KostenArt').AsString = 'D' then Kostenart:='D';
            if QuerySumme.FieldByName('KostenArt').AsString = 'F' then Kostenart:='F';
            if QuerySumme.FieldByName('KostenArt').AsString = 'S' then Kostenart:='S';
            case KostenArt of
             'D' : D_preis:=D_preis+SEKPreis;
             'F' : F_preis:=F_preis+SEKPreis;
             'S' : S_preis:=S_preis+SEKPreis;
             else  M_preis:=M_preis+SEKPreis;
            end;
            case KostenArt of
             'D' : D_preisVK:=D_preisVK+SVKPreis;
             'F' : F_preisVK:=F_preisVK+SVKPreis;
             'S' : S_preisVK:=S_preisVK+SVKPreis;
             else  M_preisVK:=M_preisVK+SVKPreis;
            end;
            G:=G+QuerySumme.FieldByName('Gewicht').AsFloat*QuerySumme.FieldByName('Menge').AsFloat;
            Z1:=Z1+QuerySumme.FieldByName('Zahl1').AsFloat*QuerySumme.FieldByName('Menge').AsFloat;
            Z2:=Z2+QuerySumme.FieldByName('Zahl2').AsFloat*QuerySumme.FieldByName('Menge').AsFloat;
            Z3:=Z3+QuerySumme.FieldByName('Zahl3').AsFloat*QuerySumme.FieldByName('Menge').AsFloat;
            QuerySumme.Next;
          end;
        end;
        if (SEK_Preis > 0) and (SVK_Preis > 0) then
        begin
          S_Aufschlag:=100/SEK_Preis*(SVK_Preis-SEK_Preis);
          LabelSEK_Preis.Caption:=FloattoStrF(SEK_Preis,ffNumber,10,2);
          LabelSEK_Preis_p.Caption:=LabelSEK_Preis.Caption;
          LabelSVK_Preis.Caption:=FloattoStrF(SVK_Preis,ffNumber,10,2);
          LabelSVK_Preis_p.Caption:=LabelSVK_Preis.Caption;
          LabelSAufschlag.Caption:=FloatToStrF(S_Aufschlag,ffNumber,10,0)+ ' %';
          LabelSAufschlag_P.Caption:=LabelSAufschlag.Caption;
          if PanelSummen.Visible then
          begin
            LabelM.Caption:=FloattoStrF(M_Preis,ffNumber,10,2);
            LabelD.Caption:=FloattoStrF(D_Preis,ffNumber,10,2);
            LabelF.Caption:=FloattoStrF(F_Preis,ffNumber,10,2);
            LabelS.Caption:=FloattoStrF(S_Preis,ffNumber,10,2);

            LabelG.Caption:=FloattoStrF(g,ffNumber,10,2);

            LabelZ1.Caption:=FloattoStrF(Z1,ffNumber,10,2);
            LabelZ2.Caption:=FloattoStrF(Z2,ffNumber,10,2);
            LabelZ3.Caption:=FloattoStrF(Z3,ffNumber,10,2);

            LabelMVK.Caption:=FloattoStrF(M_PreisVK,ffNumber,10,2);
            LabelDVK.Caption:=FloattoStrF(D_PreisVK,ffNumber,10,2);
            LabelFVK.Caption:=FloattoStrF(F_PreisVK,ffNumber,10,2);
            LabelSVK.Caption:=FloattoStrF(S_PreisVK,ffNumber,10,2);

            LabelMAufschlag.Caption:=FloattoStrF(M_PreisVK-M_Preis,ffNumber,10,2);
            LabelDAufschlag.Caption:=FloattoStrF(D_PreisVK-D_Preis,ffNumber,10,2);
            LabelFAufschlag.Caption:=FloattoStrF(F_PreisVK-F_Preis,ffNumber,10,2);
            LabelSSAufschlag.Caption:=FloattoStrF(S_PreisVK-S_Preis,ffNumber,10,2);

            DBEditAufschlag.Text:=  FormatFloat('0.00',S_Aufschlag);
          end;
        end;
      end;
      QuerySumme.close;
    end;
  //end;
  USummenButtonAn:=False;
  if FEinstellung  = 1 then //Summierung in der DB abspeichern
  begin
    QueryStueckliste.edit;
    QueryStueckliste.FieldByName('Materialleistung').AsFloat:=M_Preis;
    QueryStueckliste.FieldByName('Dienstleistung').AsFloat:=D_Preis;
    QueryStueckliste.FieldByName('Fremdleistung').AsFloat:=F_Preis;
    QueryStueckliste.FieldByName('Sonstigeleistung').AsFloat:=S_Preis;
    QueryStueckliste.FieldByName('VK_Preis').AsFloat:=0;//StrtoFloat(FormatFloat('0.00',SVK_Preis));
    QueryStueckliste.FieldByName('Aufschlag').AsFloat:=StrtoFloat(FormatFloat('0.00',S_Aufschlag));
    QueryStueckliste.FieldByName('Gewicht').AsFloat:=g;
    QueryStueckliste.FieldByName('Zahl1').AsFloat:=Z1;
    QueryStueckliste.FieldByName('Zahl2').AsFloat:=Z2;
    QueryStueckliste.FieldByName('Zahl3').AsFloat:=Z3;
    QueryStueckliste.FieldByName('EK_Preis').AsFloat:=StrtoFloat(FormatFloat('0.00',SEK_Preis));
    QueryStueckliste.post;
  end;
end;

procedure TFormStueckliste.ButtonF3Click(Sender: TObject);//DB
begin
  //
end;

procedure TFormStueckliste.QueryStuecklistenArtikelBeforeScroll(//Bedienung
  DataSet: TDataSet);
begin
  if UsrollAus = False Then Begin
    if (DBGrid1.SelectedField.FieldName = 'Menge') or (DBGrid1.SelectedField.FieldName = 'EK_Preis') or (DBGrid1.SelectedField.FieldName = 'Aufschlag') then begin
      QueryStuecklistenArtikel.edit;
      QueryStuecklistenArtikel.FieldByName('VK_Preis').AsString:=Formatcurr('0.00',berechnung(QueryStuecklistenArtikel.FieldByName('Berechnungsart').AsString));
      QueryStuecklistenArtikel.Post;QueryStuecklistenArtikel.edit;
      summierung(0);
      //if DBGrid1.SelectedField.FieldName = 'Menge' then Showmessage('QueryStuecklistenArtikelBeforeScroll "Menge"'+DBGrid1.SelectedField.FieldName);
    End;
  End;  
end;

procedure TFormStueckliste.ButtonSummierenClick(Sender: TObject);//Bedienung
begin
  USummenButtonAn:=True;
  summierung(0);
  ActiveControl:=DBGrid1;
end;

procedure TFormStueckliste.CheckBoxSummenSofortClick(Sender: TObject);//Bedienung
begin
  if CheckBoxSummenSofort.Checked then ButtonSummieren.Visible:=False else ButtonSummieren.Visible:=true;
  summierung(0);
  ActiveControl:=DBGrid1;
end;

procedure TFormStueckliste.ButtonsonstigeSummenClick(Sender: TObject);//Bedienung
begin
  if PanelSummen.Visible = False then
  begin
    PanelSummen.Visible:=True;
    PanelSummen.top:=clientheight-97;
    DBGrid1.Height:=clientheight-DBGrid1.Top-102;//92
    summierung(0);
  end
  else
    begin
    PanelSummen.Visible:=False;
    DBGrid1.Height:=clientheight-DBGrid1.Top-59;
  end;
  ActiveControl:=DBGrid1;
end;

procedure TFormStueckliste.FormResize(Sender: TObject);//Bedienung
var Leftpoint:integer;
begin
  //if UPos_TextSichbar then UPos_texthoehe:=118 else UPos_texthoehe:=0;
  //Leftpoint:=256;
  if Width<792 then Width:=792;
  DBGrid1.Top:=49+UPos_texthoehe;
  if PanelSummen.Visible = False then begin
    DBGrid1.Height:=clientheight-DBGrid1.Top-59;//49
    PanelSummen.Width:=clientWidth-5;
    PanelTastatur.Width:=clientWidth-5;
    ImageTastatur.Width:=clientWidth-5;;
  end
  else begin
    PanelSummen.top:=clientheight-97;
    ImageTastatur.top:=clientheight-97;
    DBGrid1.Height:=clientheight-DBGrid1.Top-102;//92
  end;
  DBGrid1.width:=clientwidth-2;
  if clientwidth < 474 then  clientwidth:=474;
  PanelSummen.Width:=clientwidth-2;
  PanelTastatur.Width:=clientwidth-2;
  PanelTastatur.top:=ClientHeight-44;
  ImageTastatur.Width:=PanelTastatur.Width-2;
  ImageTastatur.top:=ClientHeight-44;
  {LabelEsc_p
  LabelF2_p
  LabelF3_p
  LabelF4_p
  LabelF5_p
  LabelF6_p
  LabelF8_p
  LabelF10_p
  BevelEK_Preis_p
  BevelAufschlag_p
  BevelVK_Preis_p
  LabelSEK_Preis_p
  LabelSAufschlag_p
  LabelSVK_Preis_p}
  LabelEsc.Top:=ImageTastatur.top+7;
  LabelF2.Top:=ImageTastatur.top+7;
  LabelF3.Top:=ImageTastatur.top+7;
  LabelF4.Top:=ImageTastatur.top+7;
  LabelF5.Top:=ImageTastatur.top+7;
  LabelF6.Top:=ImageTastatur.top+7;
  LabelF8.Top:=ImageTastatur.top+7;
  LabelF10.Top:=ImageTastatur.top+7;
  BevelEK_Preis.Top:=ImageTastatur.top+3;
  BevelAufschlag.Top:=ImageTastatur.top+3;
  BevelVK_Preis.Top:=ImageTastatur.top+3;
  LabelSEK_Preis.Top:=ImageTastatur.top+6;
  LabelSAufschlag.Top:=ImageTastatur.top+6;
  LabelSVK_Preis.Top:=ImageTastatur.top+6;
  ButtonEsc.Top:=ImageTastatur.top+22;
  ButtonF2.Top:=ImageTastatur.top+22;
  ButtonF3.Top:=ImageTastatur.top+22;
  ButtonF4.Top:=ImageTastatur.top+22;
  ButtonF5.Top:=ImageTastatur.top+22;
  ButtonF6.Top:=ImageTastatur.top+22;
  ButtonF8.Top:=ImageTastatur.top+22;
  ButtonF10.Top:=ImageTastatur.top+22;
  ButtonsonstigeSummen.Top:=ImageTastatur.top+5;
  CheckBoxSummenSofort.Top:=ImageTastatur.top+22;
  ButtonSummieren.Top:=ImageTastatur.top+22;
  CheckBoxArtikelAussuchen.Top:=ImageTastatur.top+22;
  SpeedButtonBewegenNachOben.Top:=ImageTastatur.top+2;
  SpeedButtonBewegenNachUnten.Top:=ImageTastatur.top+22;
end;

procedure TFormStueckliste.ButtonPos_TextClick(Sender: TObject);//Bedienung
begin
  DBGrid1.Visible:=False;
  if UPos_TextSichbar then begin
    DBGrid1.Height:=clientheight-DBGrid1.Top-92-118;
    UPos_texthoehe:=0;
    UPos_TextSichbar:=False;
    DBMemoPos_text.Visible:=False;
    ButtonPos_Text.Caption:='Pos_Text an';
  end
  Else begin
    UPos_texthoehe:=118;
    UPos_TextSichbar:=True;
    DBMemoPos_text.Visible:=True;
    ButtonPos_Text.Caption:='Pos_Text aus';
  end;
  DBGrid1.Top:=59+UPos_texthoehe;
  if PanelSummen.Visible = False then  DBGrid1.Height:=clientheight-DBGrid1.Top-59
  Else DBGrid1.Height:=clientheight-DBGrid1.Top-102;
  DBGrid1.Visible:=True;
end;

procedure TFormStueckliste.ButtonF6Click(Sender: TObject);
var FEinstellung:longint;
    FPos:integer;
    FFocus:string;
begin
  FFocus:=DBGrid1.SelectedField.FieldName;
  Fpos:=QueryStuecklistenArtikel.FieldByName('Pos').Asinteger;
  QueryStuecklistenArtikel.edit;
  QueryStuecklistenArtikel.post;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,LabelSEK_Preis,LabelSAufschlag,LabelSVK_Preis,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,LabelSEK_Preis_p,LabelSAufschlag_p,LabelSVK_Preis_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  if UEinstellung = 0 then begin
    FormPlanlos.Gzeiger:=QueryStuecklistenArtikel.FieldByName('Nr').AsInteger;
    FormPlanlos.GzeigerNeu:=False;
    TFormArtikel.an(2);//  FormArtikel.ShowModal;
  end;
  if UEinstellung = 1 then  begin
    FormPlanlos.Gzeiger:=QueryStuecklistenArtikel.FieldByName('Nr').AsInteger;
    FormPlanlos.GzeigerNeu:=False;
    TFormArtikel.an(3);
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,LabelSEK_Preis,LabelSAufschlag,LabelSVK_Preis,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,LabelSEK_Preis_p,LabelSAufschlag_p,LabelSVK_Preis_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');

  QueryStuecklistenArtikel.close;QueryStuecklistenArtikel.open;QueryStuecklistenArtikel.edit;gehezu(Fpos);
  QueryStuecklistenArtikel.edit;//QueryStuecklistenArtikel.Post;
  QueryStuecklistenArtikel.FieldByName('VK_Preis').AsString:=Formatcurr('0.00',berechnung(QueryStuecklistenArtikel.FieldByName('Berechnungsart').AsString));
  QueryStuecklistenArtikel.Post;QueryStuecklistenArtikel.edit;
  //QueryStuecklistenArtikel.close;QueryStuecklistenArtikel.open;QueryStuecklistenArtikel.edit;gehezu(Fpos);
  //QueryStuecklistenArtikel.Post;QueryStuecklistenArtikel.edit;
  //QueryStuecklistenArtikel.close;QueryStuecklistenArtikel.open;gehezu(Fpos);
  //DBGrid1.Focused;
  //FormStueckliste.FocusControl(DBGrid1);
  //ActiveControl:=DBGrid1;DBGrid1.SelectedField:=DBGrid1.Fields[FFocus];
  //  SelectedField.FieldName:=FFocus;QueryStuecklistenArtikel.edit;
  DBGrid1.SelectedField:=QueryStuecklistenArtikel.FieldByName(FFocus);
end;

procedure TFormStueckliste.ButtonSTKopierenClick(Sender: TObject);
var Fnr:longint;
    //FMemo:TStringlist;
begin
  QueryStueckliste.Post;
  FNr:=DataModuleDB.StucklisteVonArtikellisteInStammdaten(QueryStueckliste.Fields[0].asinteger);
  //DataModuleDB.DatensatzkopierenListeMitFeld('ArtikellisteS','Stuecklisten_Nr',QueryStueckliste.Fields[0].Value,'Stuecklistenartikel','Stuecklisten_Nr',Fnr);
  //DataModuleDB.StuecklistekopierenInStammdaten('ArtikellisteS','Stuecklisten_Nr',QueryStueckliste.Fields[0].Value,'Stuecklistenartikel','Stuecklisten_Nr',Fnr);
  DataModuleMyOffice.DSArtikelListeKopieren('ArtikellisteS','Stuecklisten_Nr',QueryStueckliste.Fields[0].asinteger,'Stuecklistenartikel','Stuecklisten_Nr',FNr);
  Showmessage('Stückliste wurde in die Stammdaten kopiert mit der Nr. '+inttostr(Fnr));
  QueryStueckliste.Edit;
end;

procedure TFormStueckliste.DBEditAufschlagExit(Sender: TObject);
begin
  summierung(0);
end;

procedure TFormStueckliste.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var Pos : LongInt;
      gerade : integer;
begin
  Pos := Rect.Bottom div TStringGrid(DBGrid1).DefaultRowHeight;
  gerade := Pos mod 2;
  if gerade = 1 Then DBGrid1.Canvas.Brush.Color:= clBtnFace;
  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;


procedure TFormStueckliste.SpeedButtonBewegenNachObenClick(
  Sender: TObject);
var Pos,i:integer;

begin
  if UFocusListe then begin
    Pos:=strtoint(QueryStuecklistenArtikel.FieldByName('Pos').Asstring);
    if Pos > 1 then begin
      QueryStuecklistenArtikel.edit;
      QueryStuecklistenArtikel.FieldByName('Pos').Asstring:=inttostr(Pos-1);
      QueryStuecklistenArtikel.post;
      QueryStuecklistenArtikel.Prior;
      QueryStuecklistenArtikel.edit;
      QueryStuecklistenArtikel.FieldByName('Pos').Asstring:=inttostr(Pos);
      QueryStuecklistenArtikel.post;
      QueryStuecklistenArtikel.close;
      QueryStuecklistenArtikel.open;
      geheZu(Pos);
      if UAltcurser = False then QueryStuecklistenArtikel.Prior ;
    end
    Else  begin
     DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,LabelSEK_Preis,LabelSAufschlag,LabelSVK_Preis,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,LabelSEK_Preis_p,LabelSAufschlag_p,LabelSVK_Preis_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
     //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
     Meldefenster.an(2,'Die Position '+inttostr(Pos)+' kann nicht weiter','nach oben verschoben werden!','');
     DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,LabelSEK_Preis,LabelSAufschlag,LabelSVK_Preis,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,LabelSEK_Preis_p,LabelSAufschlag_p,LabelSVK_Preis_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
     //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
    end;
  end;
  UAltcurser:=False;
end;

procedure TFormStueckliste.SpeedButtonBewegenNachUntenClick(
  Sender: TObject);
var Pos,i:integer;
begin
  UsrollAus:=True;
  if UFocusListe then begin
    Pos:=strtoint(QueryStuecklistenArtikel.FieldByName('Pos').Asstring);
    if (Pos < QueryStuecklistenArtikel.RecordCount) {and (UFocusListe)} then begin
      QueryStuecklistenArtikel.edit;
      QueryStuecklistenArtikel.FieldByName('Pos').Asstring:=inttostr(Pos+1);
      QueryStuecklistenArtikel.post;
      QueryStuecklistenArtikel.next;
      QueryStuecklistenArtikel.edit;
      QueryStuecklistenArtikel.FieldByName('Pos').Asstring:=inttostr(Pos);
      QueryStuecklistenArtikel.post;
      QueryStuecklistenArtikel.close;
      QueryStuecklistenArtikel.open;
      geheZu(Pos);
      if UAltcurser = False then QueryStuecklistenArtikel.next ;
    end
    Else  begin
     DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF4,LabelF5,LabelF6,LabelF8,LabelF10,LabelSEK_Preis,LabelSAufschlag,LabelSVK_Preis,LabelF2,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF4_p,LabelF5_p,LabelF6_p,LabelF8_p,LabelF10_p,LabelSEK_Preis_p,LabelSAufschlag_p,LabelSVK_Preis_p,LabelF2_p,LabelF2_p,CheckBoxSummenSofort);
     //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
     Meldefenster.an(2,'Die Position '+inttostr(Pos)+' kann nicht weiter','nach unten verschoben werden!','');
     //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
    end;
  end;
  UsrollAus:=False;
end;

procedure TFormStueckliste.ButtonF2Click(Sender: TObject);
begin
  //QueryStuecklistenArtikel.edit;
  //QueryStuecklistenArtikel.Append;
  ActiveControl:=DBGrid1;
  DBGrid1.SelectedField:=QueryStuecklistenArtikel.FieldByName('Artikelgruppe');
  UArtikelNeu:=True;
  ButtonF4Click(Self);
  UArtikelNeu:=False;
end;

procedure TFormStueckliste.ButtonF5Click(Sender: TObject);
VAR NrAlt,PosNeu:integer;
begin
  NrAlt:=QueryStuecklistenArtikel.FieldByName('Nr').Asinteger;
  PosNeu:=QueryStuecklistenArtikel.RecordCount+1;
  QueryStuecklistenArtikel.close;
  if UEinstellung = 0 then DataModuleDB.DatensatzkopierenMit('Stuecklistenartikel',NrAlt,'Stuecklisten_Nr,Pos','"'+inttostr(UZeiger)+'","'+inttostr(PosNeu)+'"');
  if UEinstellung = 1 then DataModuleDB.DatensatzkopierenMit('ArtikelListeS',NrAlt,'Stuecklisten_Nr,Pos','"'+inttostr(UZeiger)+'","'+inttostr(PosNeu)+'"');
  QueryStuecklistenArtikel.Open;
  geheZu(PosNeu);
  DBGrid1.SelectedField:=QueryStuecklistenArtikel.FieldByName('Menge');
end;

procedure TFormStueckliste.QueryStuecklistenArtikelAfterPost(
  DataSet: TDataSet);
begin
  summierung(0);
end;

procedure TFormStueckliste.QueryStuecklistenArtikelBeforePost(
  DataSet: TDataSet);
begin
  //QueryStuecklistenArtikel.edit;
  //QueryStuecklistenArtikel.FieldByName('VK_Preis').AsString:=Formatcurr('0.00',berechnung(QueryStuecklistenArtikel.FieldByName('Berechnungsart').AsString));
end;

procedure TFormStueckliste.DBGrid1Exit(Sender: TObject);
begin
 if (DBGrid1.SelectedField.FieldName = 'Menge') or (DBGrid1.SelectedField.FieldName = 'EK_Preis') or (DBGrid1.SelectedField.FieldName = 'Aufschlag') then begin
   QueryStuecklistenArtikel.edit;
   QueryStuecklistenArtikel.FieldByName('VK_Preis').AsString:=Formatcurr('0.00',berechnung(QueryStuecklistenArtikel.FieldByName('Berechnungsart').AsString));
   QueryStuecklistenArtikel.Post;QueryStuecklistenArtikel.edit;
   summierung(0);
 end;
 //Focus;
 //summierung(0);
end;

procedure TFormStueckliste.CheckBoxArtikelAussuchenClick(Sender: TObject);
begin
  UArtikelAusSuchen:=CheckBoxArtikelAussuchen.Checked;
end;

procedure TFormStueckliste.DBGrid1DblClick(Sender: TObject);
begin
   ButtonF6Click(Self);
end;

procedure TFormStueckliste.FormCreate(Sender: TObject);
begin
 UEinstellung:=0;
end;

end.
