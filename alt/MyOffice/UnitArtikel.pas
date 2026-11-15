unit UnitArtikel;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,Dialogs,
  StdCtrls, Forms, DBCtrls, DB, Mask, DBTables, ExtCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFormArtikel = class(TForm)
    DataSource1: TDataSource;
    Label2: TLabel;
    EditArtikelgruppe: TDBEdit;
    Label3: TLabel;
    EditArtikel: TDBEdit;
    Label4: TLabel;
    EditEK_Preis: TDBEdit;
    Label5: TLabel;
    EditEinheit_EK: TDBEdit;
    Label6: TLabel;
    EditAufschlag: TDBEdit;
    LabelGewicht: TLabel;
    EditGewicht: TDBEdit;
    LabelZahl1: TLabel;
    EditZahl1: TDBEdit;
    LabelZahl2: TLabel;
    EditZahl2: TDBEdit;
    LabelZahl3: TLabel;
    EditZahl3: TDBEdit;
    LabelEinheitGewicht: TLabel;
    DBEditLieferant: TDBEdit;
    LabelLieferant: TLabel;
    DBMemo1: TDBMemo;
    Label12: TLabel;
    DBEditEinheit_Menge: TDBEdit;
    LabelEinheit_Menge: TLabel;
    LabelEinheitZahl1: TLabel;
    LabelEinheitZahl2: TLabel;
    LabelEinheitZahl3: TLabel;
    DataSource2: TDataSource;
    ImageTastatur: TImage;
    LabelESC: TLabel;
    Buttonabbrechen: TButton;
    Buttonsuchen: TButton;
    Buttonspeichern: TButton;
    LabelF4: TLabel;
    LabelF10: TLabel;
    DBTextNr: TDBText;
    QueryArtikelgruppe: TZQuery;
    QueryArtikel: TZQuery;
    LabelLieferantArtikelNr: TLabel;
    LabelName1: TLabel;
    LabelName2: TLabel;
    LabelName3: TLabel;
    DBEditLieferantArtikelNr: TDBEdit;
    LabelBestand: TLabel;
    LabelMinBestand: TLabel;
    DBEditName1: TDBEdit;
    DBEditName2: TDBEdit;
    DBEditName3: TDBEdit;
    DBEditBestand: TDBEdit;
    DBEditMinBestand: TDBEdit;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF4_p: TLabel;
    LabelF10_p: TLabel;
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonspeichernClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonsuchenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Focus;
    procedure EditArtikelgruppeEnter(Sender: TObject);
    procedure ArtikelgruppeAusgesucht;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditArtikelgruppeExit(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    class Function an(FEinstellung:integer):TStringList;
  end;

var
  FormArtikel: TFormArtikel;
  UZeiger:longint;UZeigerNeu:Boolean;UArtikelZurueck:TStringList;
  UFocus:String;UEinstellung:integer;
  UTiteltext:String;
implementation

uses UnitDammiForm,TempForm,UnitMeldefenster, UnitDB, UnitModule,
  UnitMaskeEinheit, UnitAdresse, UnitArtikelgruppe,UnitDataModul;

{$R *.DFM}

class Function TFormArtikel.an(FEinstellung:integer):TStringList;
begin
  //UModuldaten:=False;
  UEinstellung:=FEinstellung;
  {If UEinstellung>0 then begin
    DBEditBestand.DataField:='';
    DBEditMinBestand.DataField:='';
  Else begin
    DBEditBestand.DataField:='Bestand';
    DBEditMinBestand.DataField:='Min_Bestand';
  end;}
  FormArtikel.ShowModal;
  Result:=UArtikelZurueck;
end;

procedure TFormArtikel.ButtonabbrechenClick(Sender: TObject);
  var ABtext:String;
    FAbbrechen:Boolean;
begin
  if UZeigerNeu then
    ABtext:='Neueingabe abbrechen ?' else ABtext:='Änderung abbrechen ?';
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  //PanelTastatur.Color:=clGray;
  FAbbrechen:= Meldefenster.an(1,ABtext,'','');
  //PanelTastatur.Color:=clYellow;
  if FAbbrechen then
  begin
    if UZeigerNeu then
      begin
        QueryArtikel.close;
        if (DataModuleDB.DatensatzLoeschen('Artikel',Uzeiger) = False) Then
        begin
          //PanelTastatur.Color:=clGray;
          Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
          //PanelTastatur.Color:=clYellow;
        end;
      end
    else // änderung
    begin
      QueryArtikel.Cancel;QueryArtikel.close;
    end;
    FormPlanlos.Gzeiger:=0;
    Close;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormArtikel.ButtonspeichernClick(Sender: TObject);
begin
  if DBEditEinheit_Menge.Visible = False then  DBEditEinheit_Menge.text:=EditEinheit_EK.text;
  if UEinstellung > 0 then QueryArtikel.FieldByName('Geaendert').AsInteger:=1;
  QueryArtikel.Post;
  FormPlanlos.Gzeiger:=QueryArtikel.Fields[0].Value;
  QueryArtikel.close;
  close;
end;

procedure TFormArtikel.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F4 then ButtonsuchenClick(Self);
  if Key = VK_F10 then ButtonspeichernClick(Self);
end;

procedure TFormArtikel.ButtonsuchenClick(Sender: TObject);
var Fnr:integer;Fname,FDatum:string;Par:TStringList;
    FWeiter:Boolean;
begin
  FWeiter:=True;
  If UFocus <> '' then
  begin
    DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
    //PanelTastatur.Color:=clGray;
    Par:=TStringList.Create;
    if UFocus = 'DBEditLieferant'then begin
      Par:=TForm1.an(FormAdresse,DBEditLieferant.text,GModulart,GBenutzer,74);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then DBEditLieferant.text:=Fname;
      FWeiter:=False;
      ActiveControl:=EditArtikelgruppe;
    end;
    if UFocus = 'EditEinheit_EK'then begin
      Par:=TForm1.an(FormEinheit,EditEinheit_EK.text,GModulart,GBenutzer,72);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then EditEinheit_EK.text:=Fname;
      //if DBEditEinheit_Menge.Visible = False then  DBEditEinheit_Menge.text:=EditEinheit_EK.text;
      ActiveControl:=EditAufschlag;
    end;
    if UFocus = 'DBEditEinheit_Menge'then begin
      Par:=TForm1.an(FormEinheit,DBEditEinheit_Menge.text,GModulart,GBenutzer,75); //vorsicht Fenster dazwischen geschoben 75
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then DBEditEinheit_Menge.text:=Fname;
      ActiveControl:=EditEK_Preis;
    end;
    if (UFocus = 'EditArtikelgruppe') and FWeiter then begin
      Par:=TForm1.an(FormArtikelgruppe,EditArtikelgruppe.text,GModulart,GBenutzer,71);
      Fnr:=strtoint(Par[0]);Fname:=Par[1];
      if Fname <> '' then EditArtikelgruppe.text:=Fname;
      ActiveControl:=EditArtikel;
      ArtikelgruppeAusgesucht;
    end;
    //PanelTastatur.Color:=clYellow;
    DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
    //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
    end;
end;

procedure TFormArtikel.FormActivate(Sender: TObject);
begin
  If UEinstellung>0 then begin
    DBEditBestand.DataField:='';
    DBEditMinBestand.DataField:='';
  end
  Else begin
    DBEditBestand.DataField:='Bestand';
    DBEditMinBestand.DataField:='Min_Bestand';
  end;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF4,LabelF10,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelF4,LabelEsc_p,LabelF4_p,LabelF10_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,LabelF4_p,FormPlanlos.GCB);
  UZeiger:=FormPlanlos.Gzeiger;FormPlanlos.Gzeiger:=0;
  UZeigerNeu:=FormPlanlos.GZeigerNeu;FormPlanlos.GzeigerNeu:=False;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  if QueryArtikel.Active then QueryArtikel.close;
  QueryArtikel.sql.Clear;
  if UEinstellung = 0 then begin
    QueryArtikel.sql.add('Select * From Artikel Where nr = '+ inttostr(Uzeiger));
    if UZeigerNeu then UTiteltext:='neuer Artikel in die Stammdaten einfügen' Else UTiteltext:='Artikel in den Stammdaten ändern';
  end;
  if UEinstellung = 1 then begin
    QueryArtikel.sql.add('Select * From Artikelliste Where nr = '+ inttostr(Uzeiger));
    if UZeigerNeu then UTiteltext:='neuer Artikel in die Artikelliste einfügen' Else UTiteltext:='Artikel in der Artikelliste ändern';
  end;
  if UEinstellung = 2 then begin
    QueryArtikel.sql.add('Select * From StuecklistenArtikel Where nr = '+ inttostr(Uzeiger));
    if UZeigerNeu then UTiteltext:='neuer Artikel in die Stückliste der Stammdaten einfügen' Else UTiteltext:='Artikel in der Stückliste Stammdaten ändern';
  end;
  if UEinstellung = 3 then begin
    QueryArtikel.sql.add('Select * From ArtikellisteS Where nr = '+ inttostr(Uzeiger));
    if UZeigerNeu then UTiteltext:='neuer Artikel in der Stückliste der Artikelliste einfügen' Else UTiteltext:='Artikel in der Stückliste der Artikelliste ändern';
  end;
  FormArtikel.Caption:=UTiteltext;
  try
    QueryArtikel.open;//Self.Query1.Edit;
  finally
  end;
  QueryArtikel.edit;
  //if UZeigerNeu=False then ArtikelgruppeAusgesucht;
  //if UZeigerNeu = False Then {QueryArtikel.FieldByName('LetzteBearbeitung').AsString := Datetostr(Now)};
  LabelEinheitGewicht.caption:=GEinheitGewicht;
  LabelZahl1.caption:=GZahl1+':';LabelZahl2.caption:=GZahl2+':';LabelZahl3.caption:=GZahl3+':';
  LabelEinheitZahl1.caption:=GEinheitZahl1;
  LabelEinheitZahl2.caption:=GEinheitZahl3;
  LabelEinheitZahl3.caption:=GEinheitZahl3;
  LabelName1.caption:=GName1+':';
  LabelName2.caption:=GName2+':';
  LabelName3.caption:=GName3+':';
  {ImageTastatur.top:=FormArtikel.ClientHeight-43;
  Buttonabbrechen.top:=ImageTastatur.top+22;
  Buttonsuchen.top:=ImageTastatur.top+22;
  Buttonspeichern.top:=ImageTastatur.top+22;
  LabelESC.top:=ImageTastatur.top+5;
  LabelF4.top:=ImageTastatur.top+5;
  LabelF10.top:=ImageTastatur.top+5;}
  if G_Artikelgruppe<>''then begin
    //Showmessage(G_Artikelgruppe);
    EditArtikelgruppe.Text:=G_Artikelgruppe;
    //ArtikelgruppeAusgesucht;
    ActiveControl:=EditArtikel;
    G_Artikelgruppe:='';
  end;
  ArtikelgruppeAusgesucht;
end;

procedure TFormArtikel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
  UEinstellung:=0;
end;

procedure TFormArtikel.Focus;
begin
  If (ActiveControl.Name = EditArtikelgruppe.Name) or
     (ActiveControl.Name = DBEditEinheit_Menge.Name) or
     (ActiveControl.Name = EditEinheit_EK.Name) or
     {(ActiveControl.Name = DBEditEinheitGewicht.Name) or}
     (ActiveControl.Name = DBEditLieferant.Name) Then
  begin
    UFocus:=ActiveControl.Name;
    Buttonsuchen.Enabled:=True;
  end
  else
  begin
    UFocus:='';
    Buttonsuchen.Enabled:=False;
  end;
  //UEinstellung:=0;
end;

procedure TFormArtikel.EditArtikelgruppeEnter(Sender: TObject);
begin
  Focus;
end;

procedure TFormArtikel.ArtikelgruppeAusgesucht;
Var FAnzeigeZeilen,FAnzeigeZeilenPunkte,AlleAuserBestandMinus:integer;
begin
  AlleAuserBestandMinus:=48;
  FAnzeigeZeilen:=10;
  if QueryArtikelgruppe.Active then QueryArtikelgruppe.close;
  QueryArtikelgruppe.sql.Clear;
  QueryArtikelgruppe.sql.add('Select * From Artikelgruppe Where Artikelgruppe = "'+ EditArtikelgruppe.EditText+'"');
  try
    QueryArtikelgruppe.open;//Self.Query1.Edit;
  finally
  end;
  if QueryArtikelgruppe.RecordCount > 0 Then begin
    if QueryArtikelgruppe.FieldByName('S_Gewicht').Asinteger =0 then LabelGewicht.Visible:=False Else LabelGewicht.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Gewicht').Asinteger =0 then EditGewicht.Visible:=False Else EditGewicht.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Gewicht').Asinteger =0 then LabelEinheitGewicht.Visible:=False Else LabelEinheitGewicht.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Zahl1').Asinteger =0 then   LabelZahl1.Visible:=False Else LabelZahl1.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Zahl1').Asinteger =0 then   EditZahl1.Visible:=False Else EditZahl1.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Zahl1').Asinteger =0 then LabelEinheitZahl1.Visible:=False Else LabelEinheitZahl1.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Zahl2').Asinteger =0 then LabelZahl2.Visible:=False Else LabelZahl2.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Zahl2').Asinteger =0 then EditZahl2.Visible:=False Else EditZahl2.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Zahl2').Asinteger =0 then LabelEinheitZahl2.Visible:=False Else LabelEinheitZahl2.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Zahl3').Asinteger =0 then LabelZahl3.Visible:=False Else LabelZahl3.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Zahl3').Asinteger =0 then EditZahl3.Visible:=False Else EditZahl3.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Zahl3').Asinteger =0 Then LabelEinheitZahl3.Visible:=False Else LabelEinheitZahl3.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Lieferant').Asinteger =0 Then LabelLieferant.Visible:=False Else LabelLieferant.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Lieferant').Asinteger =0 Then DBEditLieferant.Visible:=False Else DBEditLieferant.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Postext').Asinteger =0 Then DBMemo1.Visible:=False Else DBMemo1.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_LieferantArtikelNr').Asinteger=0 Then LabelLieferantArtikelNr.Visible:=False Else LabelLieferantArtikelNr.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_LieferantArtikelNr').Asinteger=0 Then DBEditLieferantArtikelNr.Visible:=False Else DBEditLieferantArtikelNr.Visible:=True;
    LabelBestand.Visible:= False; If UEinstellung=0 then if QueryArtikelgruppe.FieldByName('S_Bestand').Asinteger =0 Then LabelBestand.Visible:=False Else LabelBestand.Visible:=True;
    DBEditBestand.Visible:=False; If UEinstellung=0 then if QueryArtikelgruppe.FieldByName('S_Bestand').Asinteger =0 Then DBEditBestand.Visible:=False Else DBEditBestand.Visible:=True;
    LabelMinBestand.Visible:=False; If UEinstellung=0 then if QueryArtikelgruppe.FieldByName('S_Min_Bestand').Asinteger =0 Then LabelMinBestand.Visible:=False Else LabelMinBestand.Visible:=True;
    DBEditMinBestand.Visible:=False; If UEinstellung=0 then if QueryArtikelgruppe.FieldByName('S_Min_Bestand').Asinteger =0 Then DBEditMinBestand.Visible:=False Else DBEditMinBestand.Visible:=True;
    If UEinstellung>0 then begin
      LabelBestand.Visible:=False;
      DBEditBestand.Visible:=False;DBEditBestand.Enabled:=False;
      LabelMinBestand.Visible:=False;
      DBEditMinBestand.Visible:=False;DBEditMinBestand.Enabled:=False;
    end;
    {Else begin
      LabelBestand.Visible:=True;
      DBEditBestand.Visible:=True;DBEditBestand.Enabled:=True;
      LabelMinBestand.Visible:=True;
      DBEditMinBestand.Visible:=True;DBEditMinBestand.Enabled:=True;
    end;}


    if QueryArtikelgruppe.FieldByName('S_Name1').Asinteger =0 Then LabelName1.Visible:=False Else LabelName1.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Name1').Asinteger =0 Then DBEditName1.Visible:=False Else DBEditName1.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Name2').Asinteger =0 Then LabelName2.Visible:=False Else LabelName2.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Name2').Asinteger =0 Then DBEditName2.Visible:=False Else DBEditName2.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Name3').Asinteger =0 Then LabelName3.Visible:=False Else LabelName3.Visible:=True;
    if QueryArtikelgruppe.FieldByName('S_Name3').Asinteger =0 Then DBEditName3.Visible:=False Else DBEditName3.Visible:=True;
    if QueryArtikelgruppe.FieldByName('EinheitMengeSichtbar').Asinteger = 1 then
    begin
      DBEditEinheit_Menge.Visible:=False;
      LabelEinheit_Menge.Visible:=False;
    end Else begin
      DBEditEinheit_Menge.Visible:=True;
      LabelEinheit_Menge.Visible:=True;
    end;
    if (UZeigerNeu) and (EditArtikel.EditText ='') then //Vorgabe einfügen
    begin
      QueryArtikel.FieldByName('Artikel').Asstring:=       QueryArtikelgruppe.FieldByName('V_Artikel').Asstring;
      QueryArtikel.FieldByName('EinheitMenge').Asstring:=  QueryArtikelgruppe.FieldByName('V_Einheit_Menge').Asstring;
      QueryArtikel.FieldByName('EK_Preis').Asstring:=      QueryArtikelgruppe.FieldByName('V_EK_Preis').Asstring;
      QueryArtikel.FieldByName('Einheit_EK').Asstring:=    QueryArtikelgruppe.FieldByName('V_Einheit_EKPreis').Asstring;
      QueryArtikel.FieldByName('Aufschlag').Asstring:=     QueryArtikelgruppe.FieldByName('V_Aufschlag').Asstring;
      QueryArtikel.FieldByName('Berechnungsart').Asstring:=QueryArtikelgruppe.FieldByName('Berechnungsart').Asstring;
      QueryArtikel.FieldByName('Kostenart').Asstring:=     QueryArtikelgruppe.FieldByName('Kostenart').Asstring;
      QueryArtikel.FieldByName('Lieferant').Asstring:=     QueryArtikelgruppe.FieldByName('V_Lieferant').Asstring;
      QueryArtikel.Post;
      QueryArtikel.edit;
    end;
    if LabelGewicht.Visible = False            then FAnzeigeZeilen:=FAnzeigeZeilen-1;
    if LabelZahl1.Visible = False              then FAnzeigeZeilen:=FAnzeigeZeilen-1;
    if LabelZahl2.Visible = False              then FAnzeigeZeilen:=FAnzeigeZeilen-1;
    if LabelZahl3.Visible = False              then FAnzeigeZeilen:=FAnzeigeZeilen-1;
    if LabelLieferant.Visible = False          then FAnzeigeZeilen:=FAnzeigeZeilen-1;
    if LabelLieferantArtikelNr.Visible = False then FAnzeigeZeilen:=FAnzeigeZeilen-1;
    if LabelBestand.Visible = False            then FAnzeigeZeilen:=FAnzeigeZeilen-1;
    if LabelMinBestand.Visible = False         then FAnzeigeZeilen:=FAnzeigeZeilen-1;
    if LabelName1.Visible = False              then FAnzeigeZeilen:=FAnzeigeZeilen-1;
    if LabelName2.Visible = False              then FAnzeigeZeilen:=FAnzeigeZeilen-1;
    if LabelName3.Visible = False              then FAnzeigeZeilen:=FAnzeigeZeilen-1;
    Clientheight:=115+ (FAnzeigeZeilen*24);
    if (DBMemo1.Visible = True)and (Clientheight<200) then  Clientheight:=200;
    FAnzeigeZeilen:=0;
    FAnzeigeZeilenPunkte:=0;
    if LabelGewicht.Visible = true then begin
      FAnzeigeZeilenPunkte:=FAnzeigeZeilen*24;
      LabelGewicht.Top:=44+4;EditGewicht.Top:=44;LabelEinheitGewicht.Top:=44+4;
      FAnzeigeZeilen:=FAnzeigeZeilen+1;
    end;
    if LabelZahl1.Visible = true then begin
      FAnzeigeZeilenPunkte:=FAnzeigeZeilen*24;
      LabelZahl1.Top:=44+FAnzeigeZeilenPunkte+4;EditZahl1.Top:=44+FAnzeigeZeilenPunkte;LabelEinheitZahl1.Top:=44+FAnzeigeZeilenPunkte+4;
      FAnzeigeZeilen:=FAnzeigeZeilen+1;
    end;
    if LabelZahl2.Visible = true then begin
      FAnzeigeZeilenPunkte:=FAnzeigeZeilen*24;
      LabelZahl2.Top:=44+FAnzeigeZeilenPunkte+4;EditZahl2.Top:=44+FAnzeigeZeilenPunkte;LabelEinheitZahl2.Top:=44+FAnzeigeZeilenPunkte+4;
      FAnzeigeZeilen:=FAnzeigeZeilen+1;
    end;
    if LabelZahl3.Visible = true then begin
      FAnzeigeZeilenPunkte:=FAnzeigeZeilen*24;
      LabelZahl3.Top:=44+FAnzeigeZeilenPunkte+4;EditZahl3.Top:=44+FAnzeigeZeilenPunkte;LabelEinheitZahl3.Top:=44+FAnzeigeZeilenPunkte+4;
      FAnzeigeZeilen:=FAnzeigeZeilen+1;
    end;
    if LabelLieferant.Visible = true then begin
      FAnzeigeZeilenPunkte:=FAnzeigeZeilen*24;
      LabelLieferant.Top:=44+FAnzeigeZeilenPunkte+4;DBEditLieferant.Top:=44+FAnzeigeZeilenPunkte;
      FAnzeigeZeilen:=FAnzeigeZeilen+1;
    end;
    if LabelLieferantArtikelNr.Visible = true then begin
      FAnzeigeZeilenPunkte:=FAnzeigeZeilen*24;
      LabelLieferantArtikelNr.Top:=44+FAnzeigeZeilenPunkte+4;DBEditLieferantArtikelNr.Top:=44+FAnzeigeZeilenPunkte;
      FAnzeigeZeilen:=FAnzeigeZeilen+1;
    end;
    if LabelBestand.Visible = true then begin
      FAnzeigeZeilenPunkte:=FAnzeigeZeilen*23;
      LabelBestand.Top:=44+FAnzeigeZeilenPunkte+4;DBEditBestand.Top:=44+FAnzeigeZeilenPunkte;
      FAnzeigeZeilen:=FAnzeigeZeilen+1;
    end;
    if LabelMinBestand.Visible = true then begin
      FAnzeigeZeilenPunkte:=FAnzeigeZeilen*24;
      LabelMinBestand.Top:=44+FAnzeigeZeilenPunkte+4;DBEditMinBestand.Top:=44+FAnzeigeZeilenPunkte;
      FAnzeigeZeilen:=FAnzeigeZeilen+1;
    end;
    if LabelName1.Visible = true then begin
      FAnzeigeZeilenPunkte:=FAnzeigeZeilen*24;
      LabelName1.Top:=44+FAnzeigeZeilenPunkte+4;DBEditName1.Top:=44+FAnzeigeZeilenPunkte;
      FAnzeigeZeilen:=FAnzeigeZeilen+1;
    end;
    if LabelName2.Visible = true then begin
      FAnzeigeZeilenPunkte:=FAnzeigeZeilen*24;
      LabelName2.Top:=44+FAnzeigeZeilenPunkte+4;DBEditName2.Top:=44+FAnzeigeZeilenPunkte;
      FAnzeigeZeilen:=FAnzeigeZeilen+1;
    end;
    if LabelName3.Visible = true then begin
      FAnzeigeZeilenPunkte:=FAnzeigeZeilen*24;
      LabelName3.Top:=44+FAnzeigeZeilenPunkte+4;DBEditName3.Top:=44+FAnzeigeZeilenPunkte;
      FAnzeigeZeilen:=FAnzeigeZeilen+1;
    end;
    if (DBMemo1.Visible = True) and (LabelName3.Visible) and (LabelName3.Top<160) Then begin
      LabelName3.Top:=160;
      DBEditName3.Top:=160;
      Clientheight:=200+30;
    end;
  end
  else Begin
    Height:=374;
    DBMemo1.Visible:=True;
    DBEditEinheit_Menge.Visible:=True;
    LabelEinheit_Menge.Visible:=True;
    LabelGewicht.Visible:=True;
    EditGewicht.Visible:=True;
    LabelEinheitGewicht.Visible:=True;
    LabelZahl1.Visible:=True;
    EditZahl1.Visible:=True;
    LabelEinheitZahl1.Visible:=True;
    LabelZahl2.Visible:=True;
    EditZahl2.Visible:=True;
    LabelEinheitZahl2.Visible:=True;
    LabelZahl3.Visible:=True;
    EditZahl3.Visible:=True;
    LabelEinheitZahl3.Visible:=True;
    LabelLieferant.Visible:=True;
    DBEditLieferant.Visible:=True;
    LabelLieferantArtikelNr.Visible:=True;
    DBEditLieferantArtikelNr.Visible:=True;
    LabelName1.Visible:=True;
    DBEditName1.Visible:=True;
    LabelName2.Visible:=True;
    DBEditName2.Visible:=True;
    LabelName3.Visible:=True;
    DBEditName3.Visible:=True;
    If UEinstellung = 0 then begin
      LabelBestand.Visible:=True;
      DBEditBestand.Visible:=True;
      LabelMinBestand.Visible:=True;
      DBEditMinBestand.Visible:=True;
    end
    Else
    begin
      Height:=374-AlleAuserBestandMinus;
      LabelBestand.Visible:=False;
      DBEditBestand.Visible:=False;
      LabelMinBestand.Visible:=False;
      DBEditMinBestand.Visible:=False;
    end;
    LabelGewicht.Top:=47;
    EditGewicht.Top:=44;
    LabelEinheitGewicht.Top:=47;
    LabelZahl1.Top:=68;
    EditZahl1.Top:=65;
    LabelEinheitZahl1.Top:=68;
    LabelZahl2.Top:=89;
    EditZahl2.Top:=86;
    LabelEinheitZahl2.Top:=89;
    LabelZahl3.Top:=111;
    EditZahl3.Top:=108;
    LabelEinheitZahl3.Top:=111;
    LabelLieferant.Top:=133;
    DBEditLieferant.Top:=130;
    LabelLieferantArtikelNr.Top:=156;
    DBEditLieferantArtikelNr.Top:=153;
    LabelName1.Top:=225;
    DBEditName1.Top:=222;
    LabelName2.Top:=250;
    DBEditName2.Top:=247;
    LabelName3.Top:=274;
    DBEditName3.Top:=271;
    LabelBestand.Top:=179;
    DBEditBestand.Top:=176;
    LabelMinBestand.Top:=203;
    DBEditMinBestand.Top:=200;
    If UEinstellung > 0 then begin
      LabelName1.Top:=225-AlleAuserBestandMinus;;
      DBEditName1.Top:=222-AlleAuserBestandMinus;;
      LabelName2.Top:=250-AlleAuserBestandMinus;;
      DBEditName2.Top:=247-AlleAuserBestandMinus;;
      LabelName3.Top:=274-AlleAuserBestandMinus;;
      DBEditName3.Top:=271-AlleAuserBestandMinus;;
    end;
  end;
  QueryArtikelgruppe.close;
end;
procedure TFormArtikel.FormResize(Sender: TObject);
begin
  ImageTastatur.top:=FormArtikel.ClientHeight-43;
  Buttonabbrechen.top:=ImageTastatur.top+22;
  Buttonsuchen.top:=ImageTastatur.top+22;
  Buttonspeichern.top:=ImageTastatur.top+22;
  PanelTastatur.top:=FormArtikel.ClientHeight-43;
  //LabelESC_p.top:=6;
  //LabelF4_p.top:=6;
  //LabelF10_p.top:=6;
  LabelEsc.top:=ClientHeight-40;
  LabelF4.top:=ClientHeight-40;
  LabelF10.top:=ClientHeight-40;
end;

procedure TFormArtikel.FormCreate(Sender: TObject);
begin
  UEinstellung:=0;
end;

procedure TFormArtikel.EditArtikelgruppeExit(Sender: TObject);
begin
  ArtikelgruppeAusgesucht;
end;

end.
