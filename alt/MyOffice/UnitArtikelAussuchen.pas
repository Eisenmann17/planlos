unit UnitArtikelAussuchen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, Grids, DBGrids, Db, DBTables, Buttons, DBCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFormArtikelAussuchen = class(TForm)
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBGridGruppe: TDBGrid;
    DBGridArtikel: TDBGrid;
    PopupMenuSuchenGruppe: TPopupMenu;
    PopupMenuSortierenGruppe: TPopupMenu;
    PopupMenuFilterGruppe: TPopupMenu;
    ButtonArtikel1: TButton;
    ButtonArtikel2: TButton;
    ButtonArtikel3: TButton;
    ButtonArtikel4: TButton;
    ButtonArtikel5: TButton;
    ButtonArtikel6: TButton;
    ButtonArtikel7: TButton;
    ButtonArtikel8: TButton;
    PopupMenuSuchenArtikel: TPopupMenu;
    PopupMenuSortierenArtikel: TPopupMenu;
    PopupMenuFilterArtikel: TPopupMenu;
    PanelAvtivRahmen: TPanel;
    SpeedButtonOben: TSpeedButton;
    ButtonAlle: TButton;
    ButtonAlleAus: TButton;
    Buttonmarkieren: TButton;
    ButtonerledigteZeigen: TButton;
    EditZeiger: TEdit;
    LabelDatensatzinfo: TLabel;
    LabelSortiert: TLabel;
    LabelFilter: TLabel;
    CheckBoxLife: TCheckBox;
    ButtonZurueck: TButton;
    ButtonNeu: TButton;
    ButtonAusgabe: TButton;
    ButtonKopieren: TButton;
    ButtonAendern: TButton;
    ButtonSortieren: TButton;
    ButtonLoeschen: TButton;
    ButtonFilter: TButton;
    ButtonEnter: TButton;
    BevelFilter: TBevel;
    BevelSortieren: TBevel;
    BevelDatensatzinfo: TBevel;
    LabelEsc: TLabel;
    LabelF2: TLabel;
    LabelF3: TLabel;
    LabelF5: TLabel;
    LabelF6: TLabel;
    LabelF7: TLabel;
    LabelF8: TLabel;
    LabelF9: TLabel;
    LabelEnter: TLabel;
    ImageTastatur: TImage;
    DBMemo1: TDBMemo;
    QueryGruppe: TZQuery;
    QueryArtikel: TZQuery;
    PanelTastatur: TPanel;
    LabelEsc_P: TLabel;
    LabelF2_p: TLabel;
    LabelF3_p: TLabel;
    LabelF5_p: TLabel;
    LabelF6_p: TLabel;
    LabelF7_p: TLabel;
    LabelF8_p: TLabel;
    LabelF9_p: TLabel;
    LabelEnter_p: TLabel;
    BevelDatensatzinfo_p: TBevel;
    BevelSortieren_p: TBevel;
    BevelFilter_p: TBevel;
    LabelDatensatzinfo_p: TLabel;
    LabelSortiert_p: TLabel;
    LabelFilter_p: TLabel;
    Labelbreite: TLabel;
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonZurueckClick(Sender: TObject);
    procedure QueryGruppeAfterScroll(DataSet: TDataSet);
    procedure EinstellungenAktivieren;
    procedure CheckBoxLifeClick(Sender: TObject);
    procedure ButtonEnterClick(Sender: TObject);
    procedure DBGridGruppeEnter(Sender: TObject);
    procedure DBGridArtikelEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    //procedure zeigeArtikel;
    procedure zeigeArtikel(GruppeAn:Boolean;SuchStringGruppe,SuchStringArtikel:String);
    procedure ButtonArtikel1Click(Sender: TObject);
    procedure ButtonArtikel5Click(Sender: TObject);
    procedure ButtonArtikel6Click(Sender: TObject);
    procedure ListeAusgesucht(ButtonNr:integer;GruppeAn:Boolean;FArtikelgruppe,FArtikel:String);
    procedure ButtonArtikel2Click(Sender: TObject);
    procedure ButtonArtikel3Click(Sender: TObject);
    procedure ButtonArtikel4Click(Sender: TObject);
    procedure ButtonArtikel7Click(Sender: TObject);
    procedure ButtonArtikel8Click(Sender: TObject);
    procedure schreibeTitel(FText:String);
    procedure QueryArtikelAfterScroll(DataSet: TDataSet);
    procedure EditZeigerChange(Sender: TObject);
    procedure SpaltenlisteErzeugen;
//    procedure PopupMenuSuchenGruppeClick(Sender: TObject);
    procedure PopupMenuSortierenGruppeClick(Sender: TObject);
    procedure PopupMenuSuchenArtikelClick(Sender: TObject);
    procedure PopupMenuSortierenArtikelClick(Sender: TObject);
    procedure ButtonAusgabeClick(Sender: TObject);
    procedure ButtonSortierenClick(Sender: TObject);
    procedure ButtonNeuClick(Sender: TObject);
    procedure SpeedButtonObenClick(Sender: TObject);
    procedure sucheGruppeNr(Fnr:longint);
    procedure sucheArtikelNr(Fnr:longint);
    procedure ButtonAendernClick(Sender: TObject);
    procedure ButtonKopierenClick(Sender: TObject);
    procedure ButtonLoeschenClick(Sender: TObject);
    procedure zeigeButtons;
    procedure ButtonFilterClick(Sender: TObject);
    procedure ButtonerledigteZeigenClick(Sender: TObject);
    procedure ButtonAlleClick(Sender: TObject);
    procedure ButtonmarkierenClick(Sender: TObject);
    procedure ButtonAlleAusClick(Sender: TObject);
    procedure DBGridArtikelDblClick(Sender: TObject);
    procedure DBGridGruppeDblClick(Sender: TObject);
    procedure EditZeigerEnter(Sender: TObject);
    procedure EditZeigerExit(Sender: TObject);
  private
    UDBGridGruppeBreite,UDBGridArtikelBreite,UDBGridGruppeLeft,UFensterNr,UEinstellungsNr,UGruppeSpaltenbreite1,UArtikelSpaltenbreite1:Integer;
    UGruppeSpaltenbreite2,UArtikelSpaltenbreite2,UButtonNr:integer;
    UCaption,UCaption1,UCaption2,UCaption3,UCaption4,UCaption5,UCaption6,UCaption7,UCaption8,UActivListe,UArtikelgruppe,UArtikel:String;
    UAbbrechen,USrollAus:Boolean;
    Uzurueck,UButtonListe,USpaltenListeGruppe,USpaltenListeArtikel:TStringList;
    UEditZeigerArtikelGruppe,UEditZeigerArtikel,ULabelSortiertGruppe,ULabelSortiertArtikel:String;
    UListeArt{,USuchgruppe,USuchArtikel,USQLOrderArtikel,USQLOrderGruppe}:String;
    URahmenBreite:integer;
    EnaF2,EnaF3,EnaF4,EnaF5,EnaF6,EnaF7,EnaF8,EnaF9,UEnaButton1,UEnaButton2,UEnaButton3,UEnaButton4,UEnaButton5,UEnaButton6,UEnaButton7,UEnaButton8:Boolean;
    UEnaButtonAnzahl:integer;
    USQLFilterGruppe,USQLFilterArtikel,USQLFilterEinstellungGruppe,USQLFilterEinstellungArtikel:String;
    USQLFilterGruppeListe,USQLFilterArtikelListe:TStringlist;
    USQLFilterEinstellungArtikel1,USQLFilterEinstellungArtikel2,USQLFilterEinstellungArtikel3,USQLFilterEinstellungArtikel4,USQLFilterEinstellungArtikel5,USQLFilterEinstellungArtikel6,USQLFilterEinstellungArtikel7,USQLFilterEinstellungArtikel8:String;
    USQLFilterEinstellungGruppe1,USQLFilterEinstellungGruppe2,USQLFilterEinstellungGruppe3,USQLFilterEinstellungGruppe4,USQLFilterEinstellungGruppe5,USQLFilterEinstellungGruppe6,USQLFilterEinstellungGruppe7,USQLFilterEinstellungGruppe8:String;
    UArtikelArt:String;
    UErledigtArtikelAn,UMarierenZeigenAn,UErledigtArtikelAusschalten:Boolean;
    UEinstellliste:TStringList;
    UTop,ULeft:integer; Ui,Ut,Ul,Ua:integer;//Fensteranimation
    UErledigtNr:Integer;
    { Private-Deklarationen }
  public
    Function an(FArtikelgruppe,FArtikel:String;FEinstellNr:integer;FArtikelArt:String;FEinstellliste:TStringList):TStringList;
  end;

var
  FormArtikelAussuchen,FormArtikelAussuchen1,FormArtikelAussuchen2: TFormArtikelAussuchen;

implementation

uses UnitModule, UnitDB, UnitArtikelgruppe, UnitArtikel,
  UnitStuecklistenGruppe, UnitStueckListe, UnitMeldefenster, UnitFilter,UnitDataModul;

{$R *.DFM}
Function TFormArtikelAussuchen.an(FArtikelgruppe,FArtikel:String;FEinstellNr:integer;FArtikelArt:String;FEinstellliste:TStringList):TStringList;
begin
  if QueryGruppe.Active = False then QueryGruppe.Active:=True;
  if QueryArtikel.Active = False then  QueryArtikel.Active:=True;
  UEinstellliste:=TStringList.Create;
  UEinstellliste:=FEinstellliste;
  Uzurueck:=TStringList.Create;
  UArtikelgruppe:=FArtikelgruppe;UArtikel:=FArtikel;UArtikelArt:=FArtikelArt;
  if FEinstellNr = 1 then  FormArtikelAussuchen1.ShowModal;
  if FEinstellNr = 2 then  FormArtikelAussuchen2.ShowModal;
  if FEinstellNr > 2 then  FormArtikelAussuchen.ShowModal;
  Result:=Uzurueck;
end;

procedure TFormArtikelAussuchen.SpaltenlisteErzeugen;
Var i,z:integer;
   NewItem1: TMenuItem;
   NewItem2: TMenuItem;
   NewItem3: TMenuItem;
   NewItem4: TMenuItem;
begin
  USpaltenListeArtikel.clear;
  USpaltenListeGruppe.clear;
  for I := 0 to PopupMenuSortierenGruppe.Items.Count-1 do  PopupMenuSortierenGruppe.Items.delete(0);
  for I := 0 to PopupMenuSortierenArtikel.Items.Count-1 do PopupMenuSortierenArtikel.Items.delete(0);
  z:=0;
  for i := 0 to QueryGruppe.FieldCount - 1 do
  with DBGridGruppe.Fields[i] do
  if FieldName <> '' then
  begin
    if QueryGruppe.Fields[i].IsBlob = False then
    begin
      USpaltenListeGruppe.add(DBGridGruppe.Fields[i].FieldName);
      NewItem1 := TMenuItem.Create(Self);
      NewItem1.Caption :=(DBGridGruppe.Fields[i].FieldName);
      NewItem2 := TMenuItem.Create(Self);
      NewItem2.Caption :=(DBGridGruppe.Fields[i].FieldName);
      PopupMenuSuchenGruppe.Items.Add(NewItem1);
      PopupMenuSortierenGruppe.Items.Add(NewItem2);
      PopupMenuSortierenGruppe.Items[z].OnClick:=PopupMenuSortierenGruppeClick;
      z:=z+1;
    end;
  end;
  z:=0;
  for i := 0 to QueryArtikel.FieldCount - 1 do
  with DBGridArtikel.Fields[i] do
  if FieldName <> '' then
  begin
    if QueryArtikel.Fields[i].IsBlob = False then
    begin
      USpaltenListeArtikel.add(DBGridArtikel.Fields[i].FieldName);
      NewItem3 := TMenuItem.Create(Self);
      NewItem3.Caption :=(DBGridArtikel.Fields[i].FieldName);
      NewItem4 := TMenuItem.Create(Self);
      NewItem4.Caption :=(DBGridArtikel.Fields[i].FieldName);
//      PopupMenuSuchenArtikel.Items.Add(NewItem3);
//      PopupMenuSuchenArtikel.Items[z].OnClick:=PopupMenuSuchenArtikelClick;
      PopupMenuSortierenArtikel.Items.Add(NewItem4);
      PopupMenuSortierenArtikel.Items[z].OnClick:=PopupMenuSortierenArtikelClick;
      z:=z+1;
    end;
  end;
  NewItem1.Free;
  NewItem2.Free;
  NewItem3.Free;
  NewItem4.Free;
end;

procedure TFormArtikelAussuchen.EinstellungenAktivieren;
Var FFensterbreite,i:integer;
begin
  Width:=540;                   if UEinstellliste[0]<>''then Width:=strtoint(UEinstellliste[0]);
  URahmenBreite:=2;             if UEinstellliste[1]<>''then URahmenBreite:=strtoint(UEinstellliste[1]);
  UGruppeSpaltenbreite1:=1;     if UEinstellliste[2]<>''then UGruppeSpaltenbreite1:=strtoint(UEinstellliste[2]);
  UGruppeSpaltenbreite2:=0;     if UEinstellliste[3]<>''then UGruppeSpaltenbreite2:=strtoint(UEinstellliste[3]);
  UDBGridGruppeLeft:=130;       if UEinstellliste[4]<>''then UDBGridGruppeLeft:=strtoint(UEinstellliste[4]);
  DBGridGruppe.Width:=187;      if UEinstellliste[5]<>''then DBGridGruppe.Width:=strtoint(UEinstellliste[5]);
  UArtikelSpaltenbreite1:=1;    if UEinstellliste[6]<>''then UArtikelSpaltenbreite1:=strtoint(UEinstellliste[6]);
  UArtikelSpaltenbreite2:=0;    if UEinstellliste[7]<>''then UArtikelSpaltenbreite2:=strtoint(UEinstellliste[7]);
  USQLFilterEinstellungGruppe1:= UEinstellliste[8];
  USQLFilterEinstellungGruppe2:= UEinstellliste[9];
  USQLFilterEinstellungGruppe3:= UEinstellliste[10];
  USQLFilterEinstellungGruppe4:= UEinstellliste[11];
  USQLFilterEinstellungGruppe5:= UEinstellliste[12];
  USQLFilterEinstellungGruppe6:= UEinstellliste[13];
  USQLFilterEinstellungGruppe7:= UEinstellliste[14];
  USQLFilterEinstellungGruppe8:= UEinstellliste[15];
  USQLFilterEinstellungArtikel1:=UEinstellliste[16];
  USQLFilterEinstellungArtikel2:=UEinstellliste[17];
  USQLFilterEinstellungArtikel3:=UEinstellliste[18];
  USQLFilterEinstellungArtikel4:=UEinstellliste[19];
  USQLFilterEinstellungArtikel5:=UEinstellliste[20];
  USQLFilterEinstellungArtikel6:=UEinstellliste[21];
  USQLFilterEinstellungArtikel7:=UEinstellliste[22];
  USQLFilterEinstellungArtikel8:=UEinstellliste[23];
  EnaF2:=True; if UEinstellliste[24]<>'1' then EnaF2:=False;
  EnaF3:=True; if UEinstellliste[25]<>'1' then EnaF3:=False;
  EnaF4:=True; if UEinstellliste[26]<>'1' then EnaF4:=False;
  EnaF5:=True; if UEinstellliste[27]<>'1' then EnaF5:=False;
  EnaF6:=True; if UEinstellliste[28]<>'1' then EnaF6:=False;
  EnaF7:=True; if UEinstellliste[29]<>'1' then EnaF7:=False;
  EnaF8:=True; if UEinstellliste[30]<>'1' then EnaF8:=False;
  EnaF9:=True; if UEinstellliste[31]<>'1' then EnaF9:=False;

  UErledigtArtikelAusschalten:=False;  if UEinstellliste[32]='1'then UErledigtArtikelAusschalten:=True;
  UMarierenZeigenAn:=False;            if UEinstellliste[33]='1'then UMarierenZeigenAn:=True;//überhaupt  anzeigen
  UErledigtArtikelAn:=False;           if UEinstellliste[34]='1'then UErledigtArtikelAn:=True;//überhaupt  anzeigen
  UEnaButton1:=True;                   if UEinstellliste[35]='0'then UEnaButton1:=False;
  UEnaButton2:=False;                  if UEinstellliste[36]='1'then UEnaButton2:=True;
  UEnaButton3:=False;                  if UEinstellliste[37]='1'then UEnaButton3:=True;
  UEnaButton4:=False;                  if UEinstellliste[38]='1'then UEnaButton4:=True;
  UEnaButton5:=False;                  if UEinstellliste[39]='1'then UEnaButton5:=True;
  UEnaButton6:=False;                  if UEinstellliste[40]='1'then UEnaButton6:=True;
  UEnaButton7:=False;                  if UEinstellliste[41]='1'then UEnaButton7:=True;
  UEnaButton8:=False;                  if UEinstellliste[42]='1'then UEnaButton8:=True;
  if FormPlanlos.GArtikelaussuchenneu=False then begin
    UEnaButton4:=False;
    UEnaButton5:=False;
    UEnaButton6:=False;
    UEnaButton7:=False;
    UEnaButton8:=False;
  end;
  UCaption1:='Artikel aussuchen';                                  if UEinstellliste[43]<>''then UCaption1:=UEinstellliste[43];
  UCaption2:='zurück für Freie Eingabe';                           if UEinstellliste[44]<>''then UCaption2:=UEinstellliste[44];
  UCaption3:='Stückliste aussuchen';                               if UEinstellliste[45]<>''then UCaption3:=UEinstellliste[45];
  UCaption4:='Artikel aus dem/der '+GBeziehungs_Name+' aussuchen'; if UEinstellliste[46]<>''then UCaption4:=UEinstellliste[46];
  UCaption5:='Artikel aus dem Projekt aussuchen';                  if UEinstellliste[47]<>''then UCaption5:=UEinstellliste[47];
  UCaption6:='Artikel aus allen '+GModulart_Name+' aussuchen';     if UEinstellliste[48]<>''then UCaption6:=UEinstellliste[48];
  UCaption7:='Artikel aussuchen aus allen Modulen';                if UEinstellliste[49]<>''then UCaption7:=UEinstellliste[49];
  UCaption8:='noch nicht Bestellte Artikel aussuchen';             if UEinstellliste[50]<>''then UCaption8:=UEinstellliste[50];
  UTop:=0; if UEinstellliste[51]<>'' then UTop:=strtoint(UEinstellliste[51]);
  ULeft:=0; if UEinstellliste[52]<>'' then ULeft:=strtoint(UEinstellliste[52]);
  UButtonNr:=1;
  if (UEinstellliste[53]<>'') and (UArtikelArt = '') then UButtonNr:=strtoint(UEinstellliste[53]);
  if (UEinstellliste[54]='') Then UErledigtNr:=0 Else UErledigtNr:=strtoint(UEinstellliste[54]);
  //Showmessage(UEinstellliste[54]);
  USQLFilterGruppe:='';
  USQLFilterArtikel:='';
  if UArtikelArt=('Freie Eingabe')then UButtonNr:=2;
  if UArtikelArt=('Stueckliste')then UButtonNr:=3;
  if UArtikelArt=(GBeziehungs_Name)then UButtonNr:=4;
  if UArtikelArt=('Projekt')then UButtonNr:=5;
  if UArtikelArt=(GModulart_Name)then UButtonNr:=6;
  if UArtikelArt=('alle Module')then UButtonNr:=7;
  if UArtikelArt=('Sonstiges')then UButtonNr:=8;
  USpaltenListeArtikel:=TStringList.Create;
  USpaltenListeGruppe:=TStringList.Create;
  UButtonListe:=TStringList.Create;
  UButtonListe.add('Artikel');
  UButtonListe.add('Freie Eingabe');
  UButtonListe.add('Stueckliste');
  UButtonListe.add(GBeziehungs_Name);//Beziehungsname
  UButtonListe.add('Projekt');
  UButtonListe.add(GModulart_Name);//gleiches Modul
  UButtonListe.add('alle Module');
  UButtonListe.add('Sonstiges');
  for i:=1 to UButtonListe.Count do
  begin
    if i = 1 then begin
      if UButtonListe[i-1]<>''then ButtonArtikel1.Caption:=UButtonListe[i-1] Else ButtonArtikel1.Visible:=False;end;
    if i = 2 then begin
      if UButtonListe[i-1]<>''then ButtonArtikel2.Caption:=UButtonListe[i-1] Else ButtonArtikel2.Visible:=False;end;
    if i = 3 then begin
       if UButtonListe[i-1]<>''then ButtonArtikel3.Caption:=UButtonListe[i-1] Else ButtonArtikel3.Visible:=False;end;
    if i = 4 then begin
       if UButtonListe[i-1]<>''then ButtonArtikel4.Caption:=UButtonListe[i-1] Else ButtonArtikel4.Visible:=False;end;
    if i = 5 then begin
       if UButtonListe[i-1]<>''then ButtonArtikel5.Caption:=UButtonListe[i-1] Else ButtonArtikel5.Visible:=False;end;
    if i = 6 then begin
       if UButtonListe[i-1]<>''then ButtonArtikel6.Caption:=UButtonListe[i-1] Else ButtonArtikel6.Visible:=False;end;
    if i = 7 then begin
       if UButtonListe[i-1]<>''then ButtonArtikel7.Caption:=UButtonListe[i-1] Else ButtonArtikel7.Visible:=False;end;
    if i = 8 then begin
       if UButtonListe[i-1]<>''then ButtonArtikel8.Caption:=UButtonListe[i-1] Else ButtonArtikel8.Visible:=False;end;
  end;

  UEnaButtonAnzahl:=0;
  if UEnaButton1 then UEnaButtonAnzahl:=UEnaButtonAnzahl+1;
  if UEnaButton2 then UEnaButtonAnzahl:=UEnaButtonAnzahl+1;
  if UEnaButton3 then UEnaButtonAnzahl:=UEnaButtonAnzahl+1;
  if UEnaButton4 then UEnaButtonAnzahl:=UEnaButtonAnzahl+1;
  if UEnaButton5 then UEnaButtonAnzahl:=UEnaButtonAnzahl+1;
  if UEnaButton6 then UEnaButtonAnzahl:=UEnaButtonAnzahl+1;
  if UEnaButton7 then UEnaButtonAnzahl:=UEnaButtonAnzahl+1;
  if UEnaButton8 then UEnaButtonAnzahl:=UEnaButtonAnzahl+1;
 zeigeButtons;
end;

procedure TFormArtikelAussuchen.zeigeButtons;
Var FAbstand,FLeft,FTop,FZaehler,FHeight:integer;
begin
  {FAbstand:=32};FLeft:=5;FTop:=78;FZaehler:=0;
  FHeight:=DBGridGruppe.Height-88;
  if UEnaButtonAnzahl> 1 then FAbstand:=Round(FHeight/(UEnaButtonAnzahl-1))Else FAbstand:=36;
  if UEnaButton1 then  begin ButtonArtikel1.Visible:=True; ButtonArtikel1.left:=FLeft;ButtonArtikel1.Top:=FTop+FAbstand*FZaehler;FZaehler:=FZaehler+1; end
  Else ButtonArtikel1.Visible:=False;
  if UEnaButton2 then  begin ButtonArtikel2.Visible:=True; ButtonArtikel2.left:=FLeft;ButtonArtikel2.Top:=FTop+FAbstand*FZaehler;FZaehler:=FZaehler+1; end
  Else ButtonArtikel2.Visible:=False;
  if UEnaButton3 then  begin ButtonArtikel3.Visible:=True; ButtonArtikel3.left:=FLeft;ButtonArtikel3.Top:=FTop+FAbstand*FZaehler;FZaehler:=FZaehler+1; end
  Else ButtonArtikel3.Visible:=False;
  if UEnaButton4 then  begin ButtonArtikel4.Visible:=True; ButtonArtikel4.left:=FLeft;ButtonArtikel4.Top:=FTop+FAbstand*FZaehler;FZaehler:=FZaehler+1; end
  Else ButtonArtikel4.Visible:=False;
  if UEnaButton5 then  begin ButtonArtikel5.Visible:=True; ButtonArtikel5.left:=FLeft;ButtonArtikel5.Top:=FTop+FAbstand*FZaehler;FZaehler:=FZaehler+1; end
  Else ButtonArtikel5.Visible:=False;
  if UEnaButton6 then  begin ButtonArtikel6.Visible:=True; ButtonArtikel6.left:=FLeft;ButtonArtikel6.Top:=FTop+FAbstand*FZaehler;FZaehler:=FZaehler+1; end
  Else ButtonArtikel6.Visible:=False;
  if UEnaButton7 then  begin ButtonArtikel7.Visible:=True; ButtonArtikel7.left:=FLeft;ButtonArtikel7.Top:=FTop+FAbstand*FZaehler;FZaehler:=FZaehler+1; end
  Else ButtonArtikel7.Visible:=False;
  if UEnaButton8 then  begin ButtonArtikel8.Visible:=True; ButtonArtikel8.left:=FLeft;ButtonArtikel8.Top:=FTop+FAbstand*FZaehler;FZaehler:=FZaehler+1; end
  Else ButtonArtikel8.Visible:=False;
end;

procedure TFormArtikelAussuchen.schreibeTitel(FText:String);
Var Buchstabenbreite:Real;
    CaptionLeerstelle:String;
    I:Integer;
begin
 Caption:=FText;
End;

procedure TFormArtikelAussuchen.FormResize(Sender: TObject);
var FFensterMinBreite,FFensterMinHoehe,SummGrid:integer;
    FArtikelOderStuecklisteAn:Boolean;
begin
  Labelbreite.Caption:=inttostr(Width);
  if (UListeArt = 'Artikel') or (UListeArt = 'Stueckliste')then FArtikelOderStuecklisteAn:=True Else FArtikelOderStuecklisteAn:=False;
  FFensterMinBreite:=540;
  FFensterMinHoehe:=414;
  DBGridGruppe.Left:=UDBGridGruppeLeft;
  if Width<FFensterMinBreite then Width:=FFensterMinBreite
  else DBGridArtikel.Width:=clientWidth-DBGridGruppe.Left-DBGridGruppe.Width-24;
  if ClientHeight<FFensterMinHoehe then ClientHeight:=FFensterMinHoehe;
  DBGridGruppe.Height:=ClientHeight-146;
  DBGridGruppe.Top:=40;
  DBGridArtikel.Left:=DBGridGruppe.Left+DBGridGruppe.Width+17;

  if UErledigtArtikelAn  and (FArtikelOderStuecklisteAn = False) then ButtonerledigteZeigen.visible:=True Else ButtonerledigteZeigen.visible:=False;
  if UMarierenZeigenAn and (FArtikelOderStuecklisteAn = False) then
  begin
    DBGridArtikel.Options:=[dgEditing,dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgConfirmDelete,dgCancelOnExit,dgMultiSelect];
    ButtonAlle.visible:=True;
    Buttonmarkieren.visible:=True;
    ButtonAlleAus.visible:=True;
  end
  Else
  begin
    DBGridArtikel.Options:=[dgEditing,dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgConfirmDelete,dgCancelOnExit];
    ButtonAlle.visible:=False;
    Buttonmarkieren.visible:=False;
    ButtonAlleAus.visible:=False;
  end;
  if ButtonerledigteZeigen.Visible then
    if ButtonAlle.Visible then DBGridArtikel.Height:=ClientHeight-115 else DBGridArtikel.Height:=ClientHeight-95
  else
    if ButtonAlle.Visible then DBGridArtikel.Height:=ClientHeight-95 else DBGridArtikel.Height:=ClientHeight-75;
  if ButtonerledigteZeigen.Visible then ButtonAlle.Top:=ClientHeight-104 Else ButtonAlle.Top:=ClientHeight-85;
  ButtonAlle.Left:=DBGridArtikel.Left;
  ButtonAlle.Width:=Round(DBGridArtikel.Width*0.24);

  if ButtonerledigteZeigen.Visible then Buttonmarkieren.Top:=ClientHeight-104 Else Buttonmarkieren.Top:=ClientHeight-85;
  Buttonmarkieren.Left:=DBGridArtikel.Left+Round(DBGridArtikel.Width*0.26);
  Buttonmarkieren.Width:=Round(DBGridArtikel.Width*0.46);

  if ButtonerledigteZeigen.Visible then ButtonAlleAus.Top:=ClientHeight-104 Else ButtonAlleAus.Top:=ClientHeight-85;
  ButtonAlleAus.Left:=DBGridArtikel.Left+Round(DBGridArtikel.Width*0.74);
  ButtonAlleAus.Width:=Round(DBGridArtikel.Width*0.26);

  ButtonerledigteZeigen.Top:=ClientHeight-85;
  ButtonerledigteZeigen.Left:=DBGridArtikel.Left;
  ButtonerledigteZeigen.Width:=DBGridArtikel.Width;
  if UErledigtArtikelAusschalten=False then ButtonerledigteZeigen.caption:='erledigte Artikel nicht mit anzeigen' else ButtonerledigteZeigen.caption:='erledigte Artikel mit anzeigen';
  ImageTastatur.Width:=ClientWidth;
  ImageTastatur.top:=ClientHeight-63;
  PanelTastatur.Width:=ClientWidth;
  PanelTastatur.top:=ClientHeight-63;
  ButtonZurueck.Left:=2;
   ButtonZurueck.Width:=Round(ClientWidth*0.11);
   ButtonZurueck.Top:=ClientHeight-44;
   ButtonNeu.Left:=Round(ClientWidth*0.11)+2;
   ButtonNeu.Width:=Round(ClientWidth*0.11);
   ButtonNeu.Top:=ClientHeight-44;
   ButtonAusgabe.Left:=Round(ClientWidth*0.22)+2;
   ButtonAusgabe.Width:=Round(ClientWidth*0.11);
   ButtonAusgabe.Top:=ClientHeight-44;
   ButtonKopieren.Left:=Round(ClientWidth*0.33)+2;
   ButtonKopieren.Width:=Round(ClientWidth*0.11);
   ButtonKopieren.Top:=ClientHeight-44;
   ButtonAendern.Left:=Round(ClientWidth*0.44+2);
   ButtonAendern.Width:=Round(ClientWidth*0.11);
   ButtonAendern.Top:=ClientHeight-44;
   ButtonSortieren.Left:=Round(ClientWidth*0.55)+2;
   ButtonSortieren.Width:=Round(ClientWidth*0.11);
   ButtonSortieren.Top:=ClientHeight-44;
   ButtonLoeschen.Left:=Round(ClientWidth*0.66)+2;
   ButtonLoeschen.Width:=Round(ClientWidth*0.11);
   ButtonLoeschen.Top:=ClientHeight-44;
   ButtonFilter.Left:=Round(ClientWidth*0.77)+2;
   ButtonFilter.Width:=Round(ClientWidth*0.11);
   ButtonFilter.Top:=ClientHeight-44;
   ButtonEnter.Left:=Round(ClientWidth*0.88)+2;
   ButtonEnter.Width:=Round(ClientWidth*0.11);
   ButtonEnter.Top:=ClientHeight-44;
   //Labels
   LabelEsc.Left:=Round(ClientWidth*0.04);
   LabelEsc.Top:=ClientHeight-58;
   LabelEsc.Visible:=True;
   LabelF2.Left:=Round(ClientWidth*0.15);
   LabelF2.Top:=ClientHeight-58;
   LabelF2.Visible:=True;
   LabelF3.Left:=Round(ClientWidth*0.26);
   LabelF3.Top:=ClientHeight-58;
   LabelF3.Visible:=True;
   LabelF5.Left:=Round(ClientWidth*0.37);
   LabelF5.Top:=ClientHeight-58;
   LabelF5.Visible:=True;
   LabelF6.Left:=Round(ClientWidth*0.48);
   LabelF6.Top:=ClientHeight-58;
   LabelF6.Visible:=True;
   LabelF7.Left:=Round(ClientWidth*0.60);
   LabelF7.Top:=ClientHeight-58;
   LabelF7.Visible:=True;
   LabelF8.Left:=Round(ClientWidth*0.7);
   LabelF8.Top:=ClientHeight-58;
   LabelF8.Visible:=True;
   LabelF9.Left:=Round(ClientWidth*0.82);
   LabelF9.Top:=ClientHeight-58;
   LabelF9.Visible:=True;
   LabelEnter.Left:=Round(ClientWidth*0.910);
   LabelEnter.Top:=ClientHeight-58;
   LabelEnter.Visible:=True;

   LabelEsc_p.Left:=Round(ClientWidth*0.04);
   LabelEsc_p.Top:=ClientHeight-58;
   LabelEsc_p.Visible:=True;
   LabelF2_p.Left:=Round(ClientWidth*0.15);
   LabelF2_p.Top:=ClientHeight-58;
   LabelF2_p.Visible:=True;
   LabelF3_p.Left:=Round(ClientWidth*0.26);
   LabelF3_p.Top:=ClientHeight-58;
   LabelF3_p.Visible:=True;
   LabelF5_p.Left:=Round(ClientWidth*0.37);
   LabelF5_p.Top:=ClientHeight-58;
   LabelF5_p.Visible:=True;
   LabelF6_p.Left:=Round(ClientWidth*0.48);
   LabelF6_p.Top:=ClientHeight-58;
   LabelF6_p.Visible:=True;
   LabelF7_p.Left:=Round(ClientWidth*0.60);
   LabelF7_p.Top:=ClientHeight-58;
   LabelF7_p.Visible:=True;
   LabelF8_p.Left:=Round(ClientWidth*0.7);
   LabelF8_p.Top:=ClientHeight-58;
   LabelF8_p.Visible:=True;
   LabelF9_p.Left:=Round(ClientWidth*0.82);
   LabelF9_p.Top:=ClientHeight-58;
   LabelF9_p.Visible:=True;
   LabelEnter_p.Left:=Round(ClientWidth*0.910);
   LabelEnter_p.Top:=ClientHeight-58;
   LabelEnter_p.Visible:=True;

   //sonstiges
   EditZeiger.Left:=1;//Round(ClientWidth*0.22);
   EditZeiger.Width:=Round(ClientWidth*0.22);
   EditZeiger.Height:=18;
   EditZeiger.Top:=ClientHeight-22;
   CheckBoxLife.Left:=Round(ClientWidth*0.23);
   CheckBoxLife.Top:=ClientHeight-18;
   BevelDatensatzinfo.Left:=Round(ClientWidth*0.44);
   BevelDatensatzinfo.Width:=Round(ClientWidth*0.11);
   BevelDatensatzinfo.Top:=ClientHeight-20;
   BevelSortieren.Left:=Round(ClientWidth*0.553);
   BevelSortieren.Width:=Round(ClientWidth*0.2144);
   BevelSortieren.Top:=ClientHeight-20;
   BevelFilter.Left:=Round(ClientWidth*0.77);
   BevelFilter.Width:=Round(ClientWidth*0.22);
   BevelFilter.Top:=ClientHeight-20;
   LabelDatensatzinfo.Left:=Round(ClientWidth*0.45);
   LabelDatensatzinfo.Top:=ClientHeight-18;
   LabelSortiert.Left:=Round(ClientWidth*0.56);
   LabelSortiert.Top:=ClientHeight-18;
   LabelFilter.Left:=Round(ClientWidth*0.78);
   LabelFilter.Top:=ClientHeight-18;

   BevelDatensatzinfo_p.Left:=Round(ClientWidth*0.44);
   BevelDatensatzinfo_p.Width:=Round(ClientWidth*0.11);
   BevelDatensatzinfo_p.Top:=ClientHeight-20;
   BevelSortieren_p.Left:=Round(ClientWidth*0.553);
   BevelSortieren_p.Width:=Round(ClientWidth*0.2144);
   BevelSortieren_p.Top:=ClientHeight-20;
   BevelFilter_p.Left:=Round(ClientWidth*0.77);
   BevelFilter_p.Width:=Round(ClientWidth*0.22);
   BevelFilter_p.Top:=ClientHeight-20;
   LabelDatensatzinfo_p.Left:=Round(ClientWidth*0.45);
   LabelDatensatzinfo_p.Top:=ClientHeight-18;
   LabelSortiert_p.Left:=Round(ClientWidth*0.56);
   LabelSortiert_p.Top:=ClientHeight-18;
   LabelFilter_p.Left:=Round(ClientWidth*0.78);
   LabelFilter_p.Top:=ClientHeight-18;
   PanelTastatur.Height:=63;


   ImageTastatur.Height:=63;
   ButtonZurueck.Caption:='Zurück';
   ButtonNeu.Caption:='Neu';
   ButtonAusgabe.Caption:='Ausgabe';
   ButtonKopieren.Caption:='Kopieren';
   ButtonAendern.Caption:='Ändern';
   ButtonSortieren.Caption:='Sortieren';
   ButtonLoeschen.Caption:='Löschen';
   ButtonFilter.Caption:='Filter';
   if (UActivListe='Artikel') then
   begin
     PanelAvtivRahmen.Left:=DBGridArtikel.left-URahmenBreite;
     PanelAvtivRahmen.Top:=DBGridArtikel.Top-URahmenBreite;
     PanelAvtivRahmen.Width:=DBGridArtikel.Width+(2*URahmenBreite);
     PanelAvtivRahmen.Height:=DBGridArtikel.Height+(2*URahmenBreite);
   end
   Else
   begin
     PanelAvtivRahmen.Left:=DBGridGruppe.left-URahmenBreite;
     PanelAvtivRahmen.Top:=DBGridGruppe.Top-URahmenBreite;
     PanelAvtivRahmen.Width:=DBGridGruppe.Width+(2*URahmenBreite);
     PanelAvtivRahmen.Height:=DBGridGruppe.Height+(2*URahmenBreite);
   end;
   zeigeButtons;
end;

procedure TFormArtikelAussuchen.FormActivate(Sender: TObject);
begin
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,CheckBoxLife);
  //CheckBoxLife.Color:=clPurple;
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  USrollAus:=False;
  EinstellungenAktivieren;
  if (UTop >0) and (ULeft>0) then begin top:=UTop;Left:=ULeft; End;
  ListeAusgesucht(UButtonNr,True,UArtikelgruppe,UArtikel);
  LabelSortiert.Caption:=ULabelSortiertGruppe;
  LabelSortiert_p.Caption:=LabelSortiert.Caption;
  if UArtikelSpaltenbreite1 > 0 then DBGridArtikel.Columns[0].Width:=UArtikelSpaltenbreite1;
  if UArtikelSpaltenbreite2 > 0 then DBGridArtikel.Columns[1].Width:=UArtikelSpaltenbreite2;
end;

procedure TFormArtikelAussuchen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
  if (Shift = [ssShift]) or (Shift = [ssAlt]) then
  begin
    if Shift = [ssShift] then
    begin
      if Key = 27 then  ButtonZurueckClick(Self);
      if Key = VK_F6 then
      begin
      end;
      if Key = VK_F2 then showmessage(QueryGruppe.sql.text);
      if Key = VK_F3 then showmessage(QueryArtikel.sql.text);
      if Key = VK_F4 then showmessage(QueryArtikel.Fields[0].AsString);
    end
    Else
    begin
      if (Key = VK_DOWN) or (Key = VK_UP) then Self.ActiveControl:=EditZeiger;
    end;
  end
  else
  begin
    if Key = 27 then  ButtonZurueckClick(Self);
    if Key = VK_F2 then  if EnaF2 then ButtonNeuClick(Self);
    if Key = VK_F3 then  if EnaF3 then ButtonAusgabeClick(Self);
    if Key = VK_F5 then  if EnaF5 then ButtonKopierenClick(Self);
    if Key = VK_F6 then  if EnaF6 then ButtonAendernClick(Self);
    if Key = VK_F7 then  if EnaF7 then ButtonSortierenClick(Self);
    if Key = VK_F8 then  if EnaF8 then ButtonLoeschenClick(Self);
    if Key = VK_F9 then  if EnaF9 then ButtonFilterClick(Self);
    if Key = VK_RETURN then            ButtonEnterClick(Self);//ButtonEnterClick(Self);
    if Key = VK_Space then if UActivListe='Artikel' then  ButtonmarkierenClick(Self);
    if (Key = VK_DOWN) or (Key = VK_UP) then if  ActiveControl = EditZeiger then if  UActivListe='Artikel' then  ActiveControl:=DBGridArtikel Else ActiveControl:=DBGridGruppe ;
  end;
end;

procedure TFormArtikelAussuchen.ButtonZurueckClick(Sender: TObject);
begin
  DataModuleMyOffice.DSNil('Artikel1');DataModuleMyOffice.DSNil('Artikel2');
  UAbbrechen:=True;
  Uzurueck.add('');Uzurueck.add('0');
  Close;
end;

procedure TFormArtikelAussuchen.QueryGruppeAfterScroll(DataSet: TDataSet);
begin
  If   USrollAus=False Then
  begin
    LabelDatensatzinfo.Caption:=IntToStr(QueryGruppe.RecNo)+'/'+IntToStr(QueryGruppe.RecordCount);
    LabelDatensatzinfo_p.Caption:=LabelDatensatzinfo.Caption;
    if (CheckBoxLife.Checked) and (UActivListe='Artikelgruppe')then
    begin
      zeigeArtikel(False,'','');
      if UArtikelSpaltenbreite1 > 0 then DBGridArtikel.Columns[0].Width:=UArtikelSpaltenbreite1;
      if UArtikelSpaltenbreite2 > 0 then DBGridArtikel.Columns[1].Width:=UArtikelSpaltenbreite2;
      DBGridGruppe.SelectedField:=QueryGruppe.Fields[1];
    end;
  end;
end;

procedure TFormArtikelAussuchen.QueryArtikelAfterScroll(DataSet: TDataSet);
begin
  if (UActivListe='Artikel') then
  begin
    LabelDatensatzinfo.Caption:=IntToStr(QueryArtikel.RecNo)+'/'+IntToStr(QueryArtikel.RecordCount);
    LabelDatensatzinfo_p.Caption:=LabelDatensatzinfo.Caption;
    if UArtikelSpaltenbreite1 > 0 then DBGridArtikel.Columns[0].Width:=UArtikelSpaltenbreite1;
    if UArtikelSpaltenbreite2 > 0 then DBGridArtikel.Columns[1].Width:=UArtikelSpaltenbreite2;
    DBGridArtikel.SelectedField:=QueryArtikel.Fields[2];
  end;
end;

procedure TFormArtikelAussuchen.CheckBoxLifeClick(Sender: TObject);
begin
  zeigeArtikel(True,'','');
  ActiveControl:=DBGridGruppe;
  DBGridGruppe.SelectedField:=QueryGruppe.Fields[1];
  //zeigeArtikel(;
end;

procedure TFormArtikelAussuchen.ButtonEnterClick(Sender: TObject);
var i,FModulNrTemp:integer;FModulNrTempOK:Boolean;
begin
  if (UActivListe='Artikel') then
  begin
    UAbbrechen:=False;

    if  UListeArt= 'Artikel' then
    begin
      DataModuleMyOffice.DSNil('Artikel1');
      DataModuleMyOffice.DSSet('Artikel1',QueryArtikel);
      Artikel1.ArtikelArt:='Artikel';
    end;

    if  UListeArt= 'Freie Eingabe' then
    begin
      DataModuleMyOffice.DSNil('Artikel1');
      Artikel1.Nr:=-1;
      //DataModuleMyOffice.DSSet('Artikel1',QueryArtikel);
      Artikel1.ArtikelArt:='Freie Eingabe';
    end;

    If UListeArt = 'Freie Stueckliste' then
     begin
      DataModuleMyOffice.DSNil('Artikel1');
      //DataModuleMyOffice.DSSet('Artikel1',QueryArtikel);
      Artikel1.ArtikelArt:='Freie Stueckliste';
    end;


    if  UListeArt= 'Stueckliste' then
    begin
      DataModuleMyOffice.DSNil('Artikel1');
      DataModuleMyOffice.DSSet('Artikel1',QueryArtikel);
      Artikel1.ArtikelArt:='Stueckliste';
    end;

    if  (UListeArt= 'Beziehungs Nr') or (UListeArt= 'Projekt Nr') or (UListeArt= 'Modul Nr') or (UListeArt= 'Alle Nr') then
    begin
      if DBGridArtikel.SelectedRows.Count = 0 then
      begin
        DataModuleMyOffice.DSNil('Artikel1');DataModuleMyOffice.DSNil('Artikel2');
        Artikel1.Artikelart:=UListeArt;Artikel1.Nr:=1;
        Uzurueck.clear;
        Uzurueck.Add(QueryArtikel.FieldByName('Artikelart').AsString);//UListeArt);
        Uzurueck.add(QueryArtikel.Fields[0].AsString);
      end Else begin
        DataModuleMyOffice.DSNil('Artikel1');DataModuleMyOffice.DSNil('Artikel2');
        Artikel1.Artikelart:=UListeArt;Artikel1.Nr:=1;
        QueryArtikel.first;
        Uzurueck.clear;
        while not QueryArtikel.eof do begin
          if DBGridArtikel.SelectedRows.CurrentRowSelected=true then begin
            Uzurueck.Add(QueryArtikel.FieldByName('Artikelart').AsString);//UListeArt);
            Uzurueck.add(QueryArtikel.Fields[0].AsString);
            //showmessage(Uzurueck[0]);
          end;
          QueryArtikel.Next;
        end;
      end;
    end;

    if  UListeArt= 'Sonstiges' then
    begin
      Uzurueck.clear;
      //DataModuleMyOffice.DSNil('Artikel1');
      if DBGridArtikel.SelectedRows.Count = 0 then begin
        DataModuleMyOffice.DSNil('Artikel1');DataModuleMyOffice.DSNil('Artikel2');
        DataModuleMyOffice.DSSet('Artikel1',QueryArtikel);
        Artikel1.Modul_Nr:=GZeigerFuerSonstiges;
        Artikel1.Pos_Nr:=GPosFuerSonstiges;
        Artikel1.Geaendert:=0;
        Artikel1.Erledigt1:=0; Artikel1.Erledigt2:=0; Artikel1.Erledigt3:=0; Artikel1.Erledigt4:=0; Artikel1.Erledigt5:=0;
        Uzurueck.Add('ZListe');
        Uzurueck.add(QueryArtikel.FieldByName('Artikel_Nr').AsString);
        Artikel1.ArtikelArt:='Artikel';
        DataModuleMyOffice.DSGet('Artikel1','ArtikelListe',0);
        Artikel1.ArtikelArt:='ZListe';
      end Else begin
        QueryArtikel.first;
        while not QueryArtikel.eof do begin
          if DBGridArtikel.SelectedRows.CurrentRowSelected=true then begin
            DataModuleMyOffice.DSNil('Artikel1');DataModuleMyOffice.DSNil('Artikel2');
            DataModuleMyOffice.DSSet('Artikel1',QueryArtikel);
            Artikel1.Modul_Nr:=GZeigerFuerSonstiges;
            Artikel1.Pos_Nr:=GPosFuerSonstiges;
            Artikel1.Geaendert:=0;
            Artikel1.Erledigt1:=0;Artikel1.Erledigt2:=0; Artikel1.Erledigt3:=0;  Artikel1.Erledigt4:=0; Artikel1.Erledigt5:=0;
            Uzurueck.Add('ZListe');
            Uzurueck.add(QueryArtikel.FieldByName('Artikel_Nr').AsString);
            //Uzurueck.add(QueryArtikel.Fields[0].AsString);
            Artikel1.ArtikelArt:='Artikel';
            DataModuleMyOffice.DSGet('Artikel1','ArtikelListe',0);
            GPosFuerSonstiges:=GPosFuerSonstiges+1;
            Showmessage('Pos wird eingetrage'+ inttostr(GPosFuerSonstiges));
          end;
          QueryArtikel.Next;
        end;
        Artikel1.ArtikelArt:='ZListe';Artikel1.Nr:=1;//Damit Artikelsammlung weiß, Das Die ausgesuchten artikel schon übertragen wurden.
      end;
      //Zusammenfassungen für z.B. Bestellungen
      GZeigerFuerSonstiges:=QueryGruppe.FieldByName('Nr').AsInteger;
    end;
    close;
  end
  Else ActiveControl:=DBGridArtikel;
end;

procedure TFormArtikelAussuchen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
end;


procedure TFormArtikelAussuchen.PopupMenuSuchenArtikelClick(Sender: TObject);
var suchtext,spalte: String;
    Button: Integer;
begin

end;

procedure TFormArtikelAussuchen.PopupMenuSortierenGruppeClick(Sender: TObject);
begin
  with Sender as TMenuItem do ULabelSortiertGruppe:=(Caption);
  zeigeArtikel(True,'','');
  ActiveControl:=DBGridGruppe;
  LabelSortiert.Caption:=ULabelSortiertGruppe;
  LabelSortiert_p.Caption:=LabelSortiert.Caption;
end;

procedure TFormArtikelAussuchen.PopupMenuSortierenArtikelClick(Sender: TObject);
begin
  with Sender as TMenuItem do ULabelSortiertArtikel:=(Caption);
  zeigeArtikel(False,'','');
  ActiveControl:=DBGridArtikel;
  LabelSortiert.Caption:=ULabelSortiertArtikel;
  LabelSortiert_p.Caption:=LabelSortiert.Caption;
end;


procedure TFormArtikelAussuchen.ButtonArtikel1Click(Sender: TObject);
begin
  ListeAusgesucht(1,True,'','');
end;

procedure TFormArtikelAussuchen.ButtonArtikel2Click(Sender: TObject);
begin
  ListeAusgesucht(2,True,'','');
end;

procedure TFormArtikelAussuchen.ButtonArtikel3Click(Sender: TObject);
begin
  ListeAusgesucht(3,True,'','');
end;

procedure TFormArtikelAussuchen.ButtonArtikel4Click(Sender: TObject);
begin
  ListeAusgesucht(4,True,'','');
end;

procedure TFormArtikelAussuchen.ButtonArtikel5Click(Sender: TObject);
begin
  ListeAusgesucht(5,True,'','');
end;

procedure TFormArtikelAussuchen.ButtonArtikel6Click(Sender: TObject);
begin
  ListeAusgesucht(6,True,'','');
end;

procedure TFormArtikelAussuchen.ButtonArtikel7Click(Sender: TObject);
begin
  ListeAusgesucht(7,True,'','');
end;

procedure TFormArtikelAussuchen.ButtonArtikel8Click(Sender: TObject);
begin
  ListeAusgesucht(8,True,'','');
end;

procedure TFormArtikelAussuchen.ListeAusgesucht(ButtonNr:integer;GruppeAn:Boolean;FArtikelgruppe,FArtikel:String);
Var i:integer;
begin //neutralstellung
  ButtonArtikel1.Font.Size:= 8;
  ButtonArtikel2.Font.Size:= 8;
  ButtonArtikel3.Font.Size:= 8;
  ButtonArtikel4.Font.Size:= 8;
  ButtonArtikel5.Font.Size:= 8;
  ButtonArtikel6.Font.Size:= 8;
  ButtonArtikel7.Font.Size:= 8;
  ButtonArtikel8.Font.Size:= 8;
  ButtonArtikel1.Font.Style:=[];
  ButtonArtikel2.Font.Style:=[];
  ButtonArtikel3.Font.Style:=[];
  ButtonArtikel4.Font.Style:=[];
  ButtonArtikel5.Font.Style:=[];
  ButtonArtikel6.Font.Style:=[];
  ButtonArtikel7.Font.Style:=[];
  ButtonArtikel8.Font.Style:=[];
  if ButtonNr=1 then begin UListeArt:= 'Artikel';      ButtonArtikel1.Font.Size:= 11;ButtonArtikel1.Font.Style:=[fsBold];schreibeTitel(UCaption1);ULabelSortiertGruppe:='ArtikelGruppe'; ULabelSortiertArtikel:='Artikel';end;
  if ButtonNr=2 then begin UListeArt:= 'Freie Eingabe';ButtonArtikel2.Font.Size:= 11;ButtonArtikel2.Font.Style:=[fsBold];schreibeTitel(UCaption2);ULabelSortiertGruppe:='ArtikelGruppe'; ULabelSortiertArtikel:='Artikel';end;
  if ButtonNr=3 then begin UListeArt:= 'Stueckliste';  ButtonArtikel3.Font.Size:= 11;ButtonArtikel3.Font.Style:=[fsBold];schreibeTitel(UCaption3);ULabelSortiertGruppe:='StuecklistenGruppe'; ULabelSortiertArtikel:='Artikel';end;
  if ButtonNr=4 then begin UListeArt:= 'Beziehungs Nr';ButtonArtikel4.Font.Size:= 11;ButtonArtikel4.Font.Style:=[fsBold];schreibeTitel(UCaption4);ULabelSortiertGruppe:='Bezeichnung'; ULabelSortiertArtikel:='Pos_Nr';end;
  if ButtonNr=5 then begin UListeArt:= 'Projekt Nr' ;  ButtonArtikel5.Font.Size:= 11;ButtonArtikel5.Font.Style:=[fsBold];schreibeTitel(UCaption5);ULabelSortiertGruppe:='Bezeichnung'; ULabelSortiertArtikel:='Pos_Nr';end;
  if ButtonNr=6 then begin UListeArt:= 'Modul Nr' ;    ButtonArtikel6.Font.Size:= 11;ButtonArtikel6.Font.Style:=[fsBold];schreibeTitel(UCaption6);ULabelSortiertGruppe:='Bezeichnung'; ULabelSortiertArtikel:='Pos_Nr';end;
  if ButtonNr=7 then begin UListeArt:= 'Alle Nr' ;     ButtonArtikel7.Font.Size:= 11;ButtonArtikel7.Font.Style:=[fsBold];schreibeTitel(UCaption7);ULabelSortiertGruppe:='Bezeichnung'; ULabelSortiertArtikel:='Pos_Nr';end;
  if ButtonNr=8 then begin UListeArt:= 'Sonstiges' ;   ButtonArtikel8.Font.Size:= 11;ButtonArtikel8.Font.Style:=[fsBold];schreibeTitel(UCaption8);ULabelSortiertGruppe:='Bezeichnung'; ULabelSortiertArtikel:='Pos_Nr';end;
  FormResize(Self);
  If (UListeArt = 'Artikel') or (UListeArt = 'Stueckliste') then UArtikelSpaltenbreite2:=1 Else UArtikelSpaltenbreite2:=0;
  zeigeArtikel(True,FArtikelgruppe,FArtikel);
  if UArtikelSpaltenbreite1 > 0 then DBGridArtikel.Columns[0].Width:=UArtikelSpaltenbreite1;
  if UArtikelSpaltenbreite2 > 0 then DBGridArtikel.Columns[1].Width:=UArtikelSpaltenbreite2;
  ActiveControl:=DBGridGruppe;
  SpaltenlisteErzeugen;
end;

procedure TFormArtikelAussuchen.DBGridGruppeEnter(Sender: TObject);
begin
  if EnaF2 = False then  ButtonNeu.Enabled:=False else ButtonNeu.Enabled:=True;
  if EnaF3 = False then  ButtonAusgabe.Enabled:=False else ButtonAusgabe.Enabled:=True;
  if EnaF5 = False then  ButtonKopieren.Enabled:=False else ButtonKopieren.Enabled:=True;
  if EnaF6 = False then  ButtonAendern.Enabled:=False else  ButtonAendern.Enabled:=True;
  if EnaF7 = False then  ButtonSortieren.Enabled:=False else ButtonSortieren.Enabled:=True;
  if EnaF8 = False then  ButtonLoeschen.Enabled:=False else  ButtonLoeschen.Enabled:=True;
  if EnaF9 = False then  ButtonFilter.Enabled:=False else  ButtonFilter.Enabled:=True;
  if (UListeArt= 'Beziehungs Nr') or (UListeArt= 'Projekt Nr') or (UListeArt= 'Modul Nr') or (UListeArt= 'Alle Nr') or (UListeArt= 'Sonstiges') then begin
    ButtonNeu.Enabled:=False;
    ButtonAusgabe.Enabled:=False;
    ButtonKopieren.Enabled:=False;
    ButtonAendern.Enabled:=False;
    ButtonLoeschen.Enabled:=False;
  end;
  //--------------zusetzliche sperren für Funktionen wenn Artikelgruppe ausgewählt
  //ButtonKopieren.Enabled:=False;
  //ButtonAendern.Enabled:=False;
  //ButtonLoeschen.Enabled:=False;
  //-----------------------------ende---------------------------------------------
  UActivListe:='Artikelgruppe';
  SpeedButtonOben.Glyph.LoadFromFile('TabRechts.BMP');
  PanelAvtivRahmen.Left:=DBGridGruppe.left-URahmenBreite;
  PanelAvtivRahmen.Width:=DBGridGruppe.Width+(2*URahmenBreite);
  PanelAvtivRahmen.Height:=DBGridGruppe.Height+(2*URahmenBreite);
  PanelAvtivRahmen.Top:=DBGridGruppe.Top-URahmenBreite;
  DBGridGruppe.color:=clWindow;
  DBGridArtikel.color:=cl3DLight;
  LabelDatensatzinfo.Caption:=IntToStr(QueryGruppe.RecNo)+'/'+IntToStr(QueryGruppe.RecordCount);
  LabelDatensatzinfo_p.Caption:=LabelDatensatzinfo.Caption;
  LabelSortiert.Caption:=ULabelSortiertGruppe;
  LabelSortiert_p.Caption:=LabelSortiert.Caption;
  if UGruppeSpaltenbreite1 > 0 then  DBGridGruppe.Columns[0].Width:=UGruppeSpaltenbreite1;
  if UGruppeSpaltenbreite2 > 0 then  DBGridGruppe.Columns[1].Width:=UGruppeSpaltenbreite2;
  DBGridGruppe.SelectedField:=QueryGruppe.Fields[1];
end;

procedure TFormArtikelAussuchen.DBGridArtikelEnter(Sender: TObject);
begin
  if EnaF2 = False then  ButtonNeu.Enabled:=False else ButtonNeu.Enabled:=True;
  if EnaF3 = False then  ButtonAusgabe.Enabled:=False else ButtonAusgabe.Enabled:=True;
  if EnaF5 = False then  ButtonKopieren.Enabled:=False else ButtonKopieren.Enabled:=True;
  if EnaF6 = False then  ButtonAendern.Enabled:=False else  ButtonAendern.Enabled:=True;
  if EnaF7 = False then  ButtonSortieren.Enabled:=False else ButtonSortieren.Enabled:=True;
  if EnaF8 = False then  ButtonLoeschen.Enabled:=False else  ButtonLoeschen.Enabled:=True;
  if EnaF9 = False then  ButtonFilter.Enabled:=False else  ButtonFilter.Enabled:=True;
  if (UListeArt= 'Beziehungs Nr') or (UListeArt= 'Projekt Nr') or (UListeArt= 'Modul Nr') or (UListeArt= 'Alle Nr') or (UListeArt= 'Sonstiges') then begin
    ButtonNeu.Enabled:=False;
    ButtonAusgabe.Enabled:=False;
    ButtonKopieren.Enabled:=False;
    ButtonAendern.Enabled:=False;
    ButtonLoeschen.Enabled:=False;
  end;
  UActivListe:='Artikel';
  SpeedButtonOben.Glyph.LoadFromFile('TabUnten.BMP');
  PanelAvtivRahmen.Left:=DBGridArtikel.left-URahmenBreite;
  PanelAvtivRahmen.Top:=DBGridArtikel.Top-URahmenBreite;
  PanelAvtivRahmen.Width:=DBGridArtikel.Width+(2*URahmenBreite);
  PanelAvtivRahmen.Height:=DBGridArtikel.Height+(2*URahmenBreite);
  DBGridArtikel.color:=clWindow;
  DBGridGruppe.color:=cl3DLight;
  LabelDatensatzinfo.Caption:=IntToStr(QueryArtikel.RecNo)+'/'+IntToStr(QueryArtikel.RecordCount);
  LabelDatensatzinfo_p.Caption:=LabelDatensatzinfo.Caption;
  LabelSortiert.Caption:=ULabelSortiertArtikel;
  LabelSortiert_p.Caption:=LabelSortiert.Caption;
  if CheckBoxLife.Checked = False then zeigeArtikel(False,'','');
  if UArtikelSpaltenbreite1 > 0 then DBGridArtikel.Columns[0].Width:=UArtikelSpaltenbreite1;
  if UArtikelSpaltenbreite2 > 0 then DBGridArtikel.Columns[1].Width:=UArtikelSpaltenbreite2;
  DBGridArtikel.SelectedField:=QueryArtikel.Fields[2];
end;

procedure TFormArtikelAussuchen.zeigeArtikel(GruppeAn:Boolean;SuchStringGruppe,SuchStringArtikel:String);
Var FSuchGruppeInArtikel,FSQLStringGruppe,FSQLStringArtikel1,FSQLStringArtikel2,FandGruppe,FandArtikel,FSQLFilterEinstellungArtikel,FErledigtAn:String;
    ArtikelSonstigesGefundenUndAddiert:Boolean;
    i1,i2,i3,i4:integer;
    FMenge:Real;
    FSpaltenArtikelliste,FSpaltenArtikelliste2:String;
begin
//                         1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
  FSpaltenArtikelliste:='Nr,Pos_Nr,Artikelgruppe,Artikel,EK_Preis,Einheit_EK,Menge,ArtikelArt,EinheitMenge,Aufschlag,Rabatt,VK_Preis,Modul_Nr,Artikel_Nr,Materialleistung,Dienstleistung,Fremdleistung,Sonstigeleistung,Gruppierung,';
  FSpaltenArtikelliste:=FSpaltenArtikelliste+'Gewicht,Zahl1,Zahl2,Zahl3,Name1,Name2,Name3,Lieferant,LieferantArtikelNr,BerechnungsArt,Erledigt1,Erledigt2,Erledigt3,Erledigt4,Erledigt5,Bearbeiter,Geaendert,Kostenart,ReadOnly,Berechnen1,Berechnen2,Berechnen3,Pos_Text ';
  FSpaltenArtikelliste2:='Nr,Artikelgruppe,Artikel,EK_Preis,Einheit_EK,Menge,ArtikelArt,EinheitMenge,Aufschlag,Rabatt,VK_Preis,Modul_Nr,Artikel_Nr,Materialleistung,Dienstleistung,Fremdleistung,Sonstigeleistung,Gruppierung,';
  FSpaltenArtikelliste2:=FSpaltenArtikelliste2+'Gewicht,Zahl1,Zahl2,Zahl3,Name1,Name2,Name3,Lieferant,LieferantArtikelNr,BerechnungsArt,Erledigt1,Erledigt2,Erledigt3,Erledigt4,Erledigt5,Bearbeiter,Geaendert,Kostenart,ReadOnly,Berechnen1,Berechnen2,Berechnen3,Pos_Nr,Pos_Text ';
  FandGruppe:='';FandArtikel:='';
  if UErledigtArtikelAusschalten then begin
    if UErledigtNr=0 Then FErledigtAn:='';
    if UErledigtNr=1 Then FErledigtAn:=' and Erledigt1 <> 1 ';
    if UErledigtNr=2 Then FErledigtAn:=' and Erledigt2 <> 1 ';
    if UErledigtNr=3 Then FErledigtAn:=' and Erledigt3 <> 1 ';
    if UErledigtNr=4 Then FErledigtAn:=' and Erledigt4 <> 1 ';
    if UErledigtNr=5 Then FErledigtAn:=' and Erledigt5 <> 1 ';
  end
  Else FErledigtAn:='';
  //Showmessage(inttostr(UErledigtNr)+'   '+FErledigtAn);
  If UListeArt = 'Artikel' then  begin
    if (USQLFilterGruppe <>'') or (USQLFilterEinstellungGruppe1<>'') then FandGruppe:=' Where ';
    if (USQLFilterGruppe ='') and (USQLFilterEinstellungGruppe1<>'')  then FandGruppe:=' Where Artikelgruppe <>"" ';
    FSQLStringGruppe:='Select Nr,Artikelgruppe From Artikelgruppe' +FandGruppe+USQLFilterGruppe+USQLFilterEinstellungGruppe1+' Order By ';
    FSQLFilterEinstellungArtikel:=USQLFilterEinstellungArtikel1;
    FSQLStringArtikel1:='Select * From Artikel Where Artikelgruppe = ';end;
  If UListeArt = 'Stueckliste' then begin
    if (USQLFilterGruppe <>'') or (USQLFilterEinstellungGruppe3<>'') then FandGruppe:='Where ';
    if (USQLFilterGruppe ='') and (USQLFilterEinstellungGruppe3<>'')  then FandGruppe:='Where StuecklistenGruppe <>""';
    FSQLStringGruppe:='Select Nr,StuecklistenGruppe From StuecklistenGruppe '+FandGruppe+USQLFilterGruppe+USQLFilterEinstellungGruppe3+' Order By ';
    FSQLFilterEinstellungArtikel:=USQLFilterEinstellungArtikel3;
    FSQLStringArtikel1:='Select * From Stueckliste Where Artikelgruppe = ';end;
  If UListeArt = 'Beziehungs Nr' then begin
    if (USQLFilterGruppe <>'') then FandGruppe:=' and ';
    FSQLStringGruppe:='Select Nr,Bezeichnung,Modulart,Projekt_Nr,Modulart_Nr From Module Where Modulart_Nr = "'+inttostr(GBeziehungs_Nr)+'" and Projekt_Nr = "'+inttostr(GProjekt_Nr)+'" '+FandGruppe+USQLFilterGruppe+USQLFilterEinstellungGruppe4+' Order By ';
    FSQLFilterEinstellungArtikel:=USQLFilterEinstellungArtikel4;
    FSQLStringArtikel1:='Select '+FSpaltenArtikelliste+' From Artikelliste Where Modul_Nr = ';end;
  If UListeArt = 'Projekt Nr' then begin
    if (USQLFilterGruppe <>'') then FandGruppe:=' and ';
    FSQLStringGruppe:='Select Nr,Bezeichnung,Modulart,Projekt_Nr,Modulart_Nr From Module Where Projekt_Nr = "'+inttostr(GProjekt_Nr)+'" '+FandGruppe+USQLFilterGruppe+USQLFilterEinstellungGruppe5+' Order By ';
    FSQLFilterEinstellungArtikel:=USQLFilterEinstellungArtikel5;
    FSQLStringArtikel1:='Select '+FSpaltenArtikelliste+' From Artikelliste Where Modul_Nr = ';end;
  If UListeArt = 'Modul Nr' then begin
    if (USQLFilterGruppe <>'') then FandGruppe:=' and ';
    FSQLStringGruppe:='Select Nr,Bezeichnung,Modulart,Projekt_Nr,Modulart_Nr From Module Where Modulart_Nr = "'+inttostr(Gmodulart_Nr)+'" '+FandGruppe+USQLFilterGruppe+USQLFilterEinstellungGruppe6+' Order By ';
    FSQLFilterEinstellungArtikel:=USQLFilterEinstellungArtikel6;
    FSQLStringArtikel1:='Select '+FSpaltenArtikelliste+' From Artikelliste Where Modul_Nr = ';end;
  If UListeArt = 'Alle Nr' then begin
    if (USQLFilterGruppe <>'') then FandGruppe:=' and ';
    FSQLStringGruppe:='Select Nr,Bezeichnung,Modulart,Projekt_Nr,Modulart_Nr From Module Where Modulart_Nr > 0 '+FandGruppe+USQLFilterGruppe+USQLFilterEinstellungGruppe7+' Order By ';
    FSQLFilterEinstellungArtikel:=USQLFilterEinstellungArtikel7;
    FSQLStringArtikel1:='Select '+FSpaltenArtikelliste+' From Artikelliste Where Modul_Nr = ';end;
  If (UListeArt = 'Sonstiges') {and  (GSonstigeSQLGruppe<>'') and (GSonstigeSQLArtikel1<>'')} then begin
    if (USQLFilterGruppe <>'') then FandGruppe:=' and ';
    //FSQLStringGruppe:=GSonstigeSQLGruppe+' '+FandGruppe+USQLFilterGruppe+USQLFilterEinstellungGruppe8+' Order By ';
    FSQLStringGruppe:='Select Nr,Bezeichnung,Modulart,Projekt_Nr,Modulart_Nr From Module Where Modulart_Nr = "'+inttostr(GBeziehungs_Nr)+'" and Projekt_Nr = "'+inttostr(GProjekt_Nr)+'" '+FandGruppe+USQLFilterGruppe+USQLFilterEinstellungGruppe8+' Order By ';
    FSQLFilterEinstellungArtikel:=USQLFilterEinstellungArtikel8;
    FSQLStringArtikel1:='Select '+FSpaltenArtikelliste2+' From Artikellistetemp Where Modul_Nr = ';end;

  If (UListeArt = 'Artikel') or (UListeArt = 'Stueckliste') or
    (UListeArt ='Beziehungs Nr') or (UListeArt ='Beziehungs Nr') or (UListeArt ='Projekt Nr') or (UListeArt ='Modul Nr') or (UListeArt ='Alle Nr') or (UListeArt ='Sonstiges')
  then begin
    if GruppeAn then begin
      if QueryGruppe.Active then QueryGruppe.close;
      QueryGruppe.sql.Clear;
      QueryGruppe.sql.add(FSQLStringGruppe+ULabelSortiertGruppe);
      try
        QueryGruppe.open; finally
      end;
    end;

    if (SuchStringGruppe<>'') and (QueryGruppe.Recordcount >0) then begin //suche Gruppe
      USrollAus:=True;
      QueryGruppe.First;
      while not QueryGruppe.eof do if QueryGruppe.Fields[1].Value=SuchStringGruppe then break  else QueryGruppe.next;
      UArtikelgruppe:='';
      USrollAus:=False;
    end;
    //sucheGruppe(SuchStringGruppe);
    If QueryGruppe.RecordCount >0 then  begin
      If (UListeArt = 'Artikel') or (UListeArt = 'Stueckliste') then begin
        If (UListeArt = 'Artikel') then FSuchGruppeInArtikel:=QueryGruppe.FieldByName('Artikelgruppe').Value
        else FSuchGruppeInArtikel:=QueryGruppe.FieldByName('StuecklistenGruppe').Value;
      end
      Else FSuchGruppeInArtikel:=QueryGruppe.FieldByName('Nr').ASString;
      if QueryArtikel.Active then QueryArtikel.close;
      QueryArtikel.sql.Clear;
      if USQLFilterArtikel<>'' then FandArtikel:=' and ';
      If (UListeArt = 'Artikel') or (UListeArt = 'Stueckliste') then
       QueryArtikel.sql.add(FandArtikel+FSQLStringArtikel1+ '"'+FSuchGruppeInArtikel+'" '+FandArtikel+USQLFilterArtikel+FSQLFilterEinstellungArtikel+' Order By '+ULabelSortiertArtikel)
      Else begin
        If (UListeArt = 'Sonstiges') then begin
          if DataModuleMyOffice.FQueryZu.Active Then DataModuleMyOffice.FQueryZu.Close;
          DataModuleMyOffice.DSLoeschen('ArtikelListeTemp','Modul_Nr',GZeigerFuerSonstiges);
          DataModuleMyOffice.FQueryZu.sql.Clear;
          DataModuleMyOffice.FQueryZu.sql.add('Select * From Artikellistetemp Where Modul_Nr = '+inttostr(GZeigerFuerSonstiges));
          DataModuleMyOffice.FQueryZu.Active;
          DataModuleMyOffice.FQueryZu.Open;
          if DataModuleMyOffice.FQueryVon.Active Then DataModuleMyOffice.FQueryVon.Close;
          DataModuleMyOffice.FQueryVon.sql.Clear;
          DataModuleMyOffice.FQueryVon.sql.add('Select * From ArtikelListe Where Modul_Nr = '+FSuchGruppeInArtikel);
          DataModuleMyOffice.FQueryVon.Active;
          DataModuleMyOffice.FQueryVon.open;
          DataModuleMyOffice.FQueryVon.first;
          //Showmessage(inttostr(DataModuleMyOffice.FQueryVon.Recordcount));
          //Showmessage(FSuchGruppeInArtikel);
          for i1:=0 to DataModuleMyOffice.FQueryVon.Recordcount-1 do begin
            //Showmessage(inttostr(DataModuleMyOffice.FQueryVon.Recordcount));
            DataModuleMyOffice.DSNil('Artikel1');
            DataModuleMyOffice.DSSet('Artikel1',DataModuleMyOffice.FQueryVon);
            ArtikelSonstigesGefundenUndAddiert:=False;
            if DataModuleMyOffice.FQueryVon.FieldByName('ArtikelArt').AsString='Artikel'then begin
              DataModuleMyOffice.DSNil('Artikel1');
              DataModuleMyOffice.DSSet('Artikel1',DataModuleMyOffice.FQueryVon);
              Artikel1.Modul_Nr:=GZeigerFuerSonstiges;
              DataModuleMyOffice.FQueryZu.first;
              if Artikel1.Artikel_Nr<>0 Then begin
                for i2:=0 to DataModuleMyOffice.FQueryZu.Recordcount-1 do begin
                  if  DataModuleMyOffice.FQueryZu.FieldByName('Artikel_Nr').AsInteger = Artikel1.Artikel_Nr then begin
                    DataModuleMyOffice.FQueryZu.edit;
                    DataModuleMyOffice.FQueryZu.FieldByName('Menge').AsFloat:=DataModuleMyOffice.FQueryZu.FieldByName('Menge').AsFloat+Artikel1.Menge;
                    DataModuleMyOffice.FQueryZu.post;
                    ArtikelSonstigesGefundenUndAddiert:=True;
                  end;
                  DataModuleMyOffice.FQueryZu.next;
                end;
              end;
              if ArtikelSonstigesGefundenUndAddiert=False then begin
                DataModuleMyOffice.FQueryZu.close;
                DataModuleMyOffice.DSGet('Artikel1','ArtikelListeTemp',0);
                //DataModuleMyOffice.FQueryZu.Active;
                DataModuleMyOffice.FQueryZu.Open;
              end;
            end;
            if DataModuleMyOffice.FQueryVon.FieldByName('ArtikelArt').AsString='Stueckliste'then begin
              FMenge:=DataModuleMyOffice.FQueryVon.FieldByName('Menge').AsFloat;
              if DataModuleMyOffice.FQuery2.Active Then DataModuleMyOffice.FQuery2.Close;
              DataModuleMyOffice.FQuery2.sql.Clear;
              DataModuleMyOffice.FQuery2.sql.add('Select * From ArtikelListeS Where Stuecklisten_Nr = '+DataModuleMyOffice.FQueryVon.FieldByName('Nr').AsString);
              DataModuleMyOffice.FQuery2.open;
              DataModuleMyOffice.FQuery2.first;
              for i3:=0 to DataModuleMyOffice.FQuery2.Recordcount-1 do begin
                ArtikelSonstigesGefundenUndAddiert:=False;
                DataModuleMyOffice.DSNil('Artikel1');
                DataModuleMyOffice.DSSet('Artikel1',DataModuleMyOffice.FQuery2);
                Artikel1.Modul_Nr:=GZeigerFuerSonstiges;
                //Artikel1.Menge:=Artikel1.Menge*FMenge;
                DataModuleMyOffice.FQueryZu.first;
                if Artikel1.Artikel_Nr<>0 Then begin
                  for i4:=0 to DataModuleMyOffice.FQueryZu.Recordcount-1 do begin
                    if  DataModuleMyOffice.FQueryZu.FieldByName('Artikel_Nr').AsInteger = DataModuleMyOffice.FQuery2.FieldByName('Artikel_Nr').AsInteger  then begin
                      DataModuleMyOffice.FQueryZu.edit;
                      DataModuleMyOffice.FQueryZu.FieldByName('Menge').AsFloat:=DataModuleMyOffice.FQueryZu.FieldByName('Menge').AsFloat+(DataModuleMyOffice.FQuery2.FieldByName('Menge').AsFloat*FMenge);
                      DataModuleMyOffice.FQueryZu.post;
                      ArtikelSonstigesGefundenUndAddiert:=True;
                      break;
                    end;
                    DataModuleMyOffice.FQueryZu.next;
                  end;
                end;
                if ArtikelSonstigesGefundenUndAddiert=False then begin
                  DataModuleMyOffice.FQueryZu.close;
                  Artikel1.Menge:=Artikel1.Menge*FMenge;
                  DataModuleMyOffice.DSGet('Artikel1','ArtikelListeTemp',0);
                  //DataModuleMyOffice.FQueryZu.Active;
                  DataModuleMyOffice.FQueryZu.Open;
                end;
                DataModuleMyOffice.FQuery2.next;
              end;
            end;
            DataModuleMyOffice.FQueryVon.next;
          end;
          if DataModuleMyOffice.FQuery2.Active Then DataModuleMyOffice.FQuery2.Close;
          if DataModuleMyOffice.FQueryVon.Active Then DataModuleMyOffice.FQueryVon.Close;
          if DataModuleMyOffice.FQueryZu.Active Then DataModuleMyOffice.FQueryZU.Close;
          FSuchGruppeInArtikel:=inttoStr(GZeigerFuerSonstiges);
        end;
        QueryArtikel.sql.add(FSQLStringArtikel1+FSuchGruppeInArtikel+' '+FandArtikel+USQLFilterArtikel+FSQLFilterEinstellungArtikel+FErledigtAn+' Order By '+ULabelSortiertArtikel);
      end;
      try QueryArtikel.open;finally; end;
    end;
  end;

  If UListeArt = 'Freie Eingabe' then
  begin
    UActivListe:='Artikel';
    ButtonEnterClick(Self);
  end;

  If UListeArt = 'Freie Stueckliste' then
  begin
    UActivListe:='Artikel';
    ButtonEnterClick(Self);
  end;

  if GruppeAn then begin if USQLFilterGruppe ='' then LabelFilter.Caption:='Aus' Else LabelFilter.Caption:=copy(USQLFilterGruppe,5,length(USQLFilterGruppe));end
  else begin  if USQLFilterArtikel ='' then LabelFilter.Caption:='Aus' Else LabelFilter.Caption:=copy(USQLFilterGruppe,5,length(USQLFilterArtikel));end;
  LabelFilter_p.Caption:=LabelFilter.Caption;
  if (SuchStringArtikel <>'') and (QueryArtikel.Recordcount >0)then //sucht im Artikel
  begin
    USrollAus:=True;
    QueryArtikel.First;
    while not QueryArtikel.eof do
    begin
      if QueryArtikel.Fields[2].Value=SuchStringArtikel then break
      else QueryArtikel.next;
    end;
    UArtikel:='';
    USrollAus:=False;
  end;
end;

procedure TFormArtikelAussuchen.sucheGruppeNr(Fnr:longint);
begin
  USrollAus:=True;
  QueryGruppe.First;
  while not QueryGruppe.eof do
  begin
    if QueryGruppe.Fields[0].Value=Fnr then break
    else QueryGruppe.next;
  end;
  USrollAus:=False;
end;

procedure TFormArtikelAussuchen.sucheArtikelNr(Fnr:longint);
begin
  USrollAus:=True;
  QueryArtikel.First;
  while not QueryArtikel.eof do
  begin
    if QueryArtikel.Fields[0].Value=Fnr then break
    else QueryArtikel.next;
  end;
  QueryGruppe.First;
  while not QueryGruppe.eof do
  begin
    if QueryGruppe.Fields[1].Value=QueryArtikel.Fields[1].Value then break
    else QueryGruppe.next;
  end;
  USrollAus:=False;
end;

procedure TFormArtikelAussuchen.EditZeigerChange(Sender: TObject);
begin
  QueryGruppe.DisableControls;
  QueryArtikel.DisableControls;
  USrollAus:=True;
  if UActivListe='Artikelgruppe' then
  begin
    QueryGruppe.First;
    LabelSortiert.Caption:=ULabelSortiertGruppe;
    LabelSortiert_p.Caption:=LabelSortiert.Caption;
    while not QueryGruppe.eof do begin
      if AnsiUpperCase((copy(QueryGruppe.FieldByName(LabelSortiert.Caption).AsString,1,Length(EditZeiger.text))))
        =AnsiUpperCase(EditZeiger.text) then begin zeigeArtikel(False,'',''); break; end
      else QueryGruppe.next;
    end;
  end
  Else
  begin
    LabelSortiert.Caption:=ULabelSortiertArtikel;
    LabelSortiert_p.Caption:=LabelSortiert.Caption;
    QueryArtikel.First;
    while not QueryArtikel.eof do begin
      if AnsiUpperCase((copy(QueryArtikel.FieldByName(LabelSortiert.Caption).AsString,1,Length(EditZeiger.text))))
        =AnsiUpperCase(EditZeiger.text) then break
      else QueryArtikel.next;
    end;
  end;
  QueryGruppe.EnableControls;
  QueryArtikel.EnableControls;
  USrollAus:=False;
  if UArtikelSpaltenbreite1 > 0 then DBGridArtikel.Columns[0].Width:=UArtikelSpaltenbreite1;
  if UArtikelSpaltenbreite2 > 0 then DBGridArtikel.Columns[1].Width:=UArtikelSpaltenbreite2;
end;

procedure TFormArtikelAussuchen.ButtonAusgabeClick(Sender: TObject);
begin
  Showmessage('für diese Tabelle ist keine Druckermaske definiert');
end;

procedure TFormArtikelAussuchen.ButtonSortierenClick(Sender: TObject);
begin
  if UActivListe='Artikelgruppe' then
    PopupMenuSortierenGruppe.Popup(Self.left+(Round(ClientWidth*0.55)+5),
    Self.Top+ClientHeight-(28 + (USpaltenListeGruppe.count*17)))
  Else
    PopupMenuSortierenArtikel.Popup(Self.left+(Round(ClientWidth*0.55)+5),
    Self.Top+ClientHeight-(28 + (USpaltenListeArtikel.count*17)))
end;

procedure TFormArtikelAussuchen.ButtonNeuClick(Sender: TObject);
Var Fnr,i:integer;
begin
  Fnr:=0;
  //------------------ oben Fensteranimation
      Ua:=6;UTop:=Top;ULeft:=Left;
      if UTop > (GOffeneFenster*Gtopschritte) then Ut:=UTop-(GOffeneFenster*Gtopschritte) Else Ut:=(GOffeneFenster*Gtopschritte)-UTop;
      if ULeft > (GOffeneFenster*GLeftschritte) then Ul:=ULeft-(GOffeneFenster*GLeftschritte) Else Ul:=(GOffeneFenster*GLeftschritte)-ULeft;
      Ut:=Round(Ut/(Ua));  Ul:=Round(Ul/Ua);
      for i := 1 to Ua do begin
        if UTop > (GOffeneFenster*Gtopschritte) then top:=top-Ut Else top:=top+Ut;if ULeft > (GOffeneFenster*GLeftschritte) then left:=left-Ul Else left:=Left+Ul;
      end;
  //-------------------------Fensteranimation Ende
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,CheckBoxLife);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  if UActivListe='Artikelgruppe' then
  begin
    If UListeArt = 'Artikel' then
    begin
      FormPlanlos.Gzeiger:=DataModuleDB.DatensatzNeu('ArtikelGruppe');
      FormPlanlos.GzeigerNeu:=True;
      FormArtikelgruppe.ShowModal;
    end;
    If UListeArt = 'Stueckliste' then
    begin
      FormPlanlos.Gzeiger:=DataModuleDB.DatensatzNeu('StuecklistenGruppe');
      FormPlanlos.GzeigerNeu:=True;
      FormStuecklistengruppe.ShowModal;
    end;
    ///////////ablauf für alle Gruppen
    Fnr:=FormPlanlos.Gzeiger;
    if Fnr<>0 then
    begin
      zeigeArtikel(True,'','');
      sucheGruppeNr(Fnr);
      ActiveControl:=DBGridGruppe;
      DBGridGruppe.SelectedField:=QueryGruppe.Fields[1];
    end;
  end
  Else ////////////////////Activliste = Artikel
  begin
    If UListeArt = 'Artikel' then
    begin
      FormPlanlos.Gzeiger:=DataModuleDB.DatensatzNeu('Artikel');
      FormPlanlos.GzeigerNeu:=True;
      G_Artikelgruppe:=QueryGruppe.FieldByName('Artikelgruppe').AsString;
      FormArtikel.ShowModal;
    end;
    If UListeArt = 'Stueckliste' then
    begin
      FormPlanlos.Gzeiger:=DataModuleDB.DatensatzNeu('Stueckliste');
      FormPlanlos.GzeigerNeu:=True;
      G_Artikelgruppe:=QueryGruppe.FieldByName('Stuecklistengruppe').AsString;
      FormStueckliste.ShowModal;
    end;
    //////////// ablauf für alle Artikel
    Fnr:=FormPlanlos.Gzeiger;
    if Fnr<>0 then
    begin
      zeigeArtikel(False,'','');
      sucheArtikelNr(Fnr);
      ActiveControl:=DBGridArtikel;
      DBGridArtikel.SelectedField:=QueryArtikel.Fields[2];
    end;
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,CheckBoxLife);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  //------------------ Unten Fensteranimation
      for i := 1 to Ua do begin
        if Top > Utop then top:=top-Ut Else top:=top+Ut;
        if Left > ULeft then left:=left-Ul Else left:=Left+Ul;
      end;
  //-------------------------Fensteranimation Ende
end;

procedure TFormArtikelAussuchen.SpeedButtonObenClick(Sender: TObject);
begin
   if UActivListe='Artikel' then ActiveControl:=DBGridGruppe Else ActiveControl:=DBGridArtikel;
end;

procedure TFormArtikelAussuchen.ButtonAendernClick(Sender: TObject);
Var Fnr,i:integer;
begin
  Fnr:=0;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,CheckBoxLife);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  //------------------ oben Fensteranimation
      Ua:=6;UTop:=Top;ULeft:=Left;
      if UTop > (GOffeneFenster*Gtopschritte) then Ut:=UTop-(GOffeneFenster*Gtopschritte) Else Ut:=(GOffeneFenster*Gtopschritte)-UTop;
      if ULeft > (GOffeneFenster*GLeftschritte) then Ul:=ULeft-(GOffeneFenster*GLeftschritte) Else Ul:=(GOffeneFenster*GLeftschritte)-ULeft;
      Ut:=Round(Ut/(Ua));  Ul:=Round(Ul/Ua);
      for i := 1 to Ua do begin
        if UTop > (GOffeneFenster*Gtopschritte) then top:=top-Ut Else top:=top+Ut;if ULeft > (GOffeneFenster*GLeftschritte) then left:=left-Ul Else left:=Left+Ul;
      end;
  //-------------------------Fensteranimation Ende
  if UActivListe='Artikelgruppe' then
  begin
    If UListeArt = 'Artikel' then
    begin
      FormPlanlos.Gzeiger:=QueryGruppe.Fields[0].Value;
      FormPlanlos.GzeigerNeu:=False;
      FormArtikelgruppe.ShowModal;
    end;
    If UListeArt = 'Stueckliste' then
    begin
      FormPlanlos.Gzeiger:=QueryGruppe.Fields[0].Value;
      FormPlanlos.GzeigerNeu:=False;
      FormStuecklistengruppe.ShowModal;
    end;
    ///////////ablauf für alle Gruppen
    Fnr:=FormPlanlos.Gzeiger;
    if Fnr<>0 then
    begin
      zeigeArtikel(True,'','');
      sucheGruppeNr(Fnr);
      ActiveControl:=DBGridGruppe;
      DBGridGruppe.SelectedField:=QueryGruppe.Fields[1];
    end;
  end
  Else ////////////////////Activliste = Artikel
  begin
    If UListeArt = 'Artikel' then
    begin
      FormPlanlos.Gzeiger:=QueryArtikel.Fields[0].Value;
      FormPlanlos.GzeigerNeu:=False;
      FormArtikel.ShowModal;
    end;
    If UListeArt = 'Stueckliste' then
    begin
      FormPlanlos.Gzeiger:=QueryArtikel.Fields[0].Value;
      FormPlanlos.GzeigerNeu:=False;
      FormStueckliste.ShowModal;
    end;
    //////////// ablauf für alle Artikel
    Fnr:=FormPlanlos.Gzeiger;
    if Fnr<>0 then
    begin
      zeigeArtikel(False,'','');
      sucheArtikelNr(Fnr);
      ActiveControl:=DBGridArtikel;
      DBGridArtikel.SelectedField:=QueryArtikel.Fields[2];
    end;
  end;
  //------------------ Unten Fensteranimation
      for i := 1 to Ua do begin
        if Top > Utop then top:=top-Ut Else top:=top+Ut;
        if Left > ULeft then left:=left-Ul Else left:=Left+Ul;
      end;
  //-------------------------Fensteranimation Ende
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,CheckBoxLife);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormArtikelAussuchen.ButtonKopierenClick(Sender: TObject);
Var Fnr,i:integer;
    Datensatzgeloscht:Boolean;
begin
  Datensatzgeloscht:=True;
  Fnr:=0;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,CheckBoxLife);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  //------------------ oben Fensteranimation
      Ua:=6;UTop:=Top;ULeft:=Left;
      if UTop > (GOffeneFenster*Gtopschritte) then Ut:=UTop-(GOffeneFenster*Gtopschritte) Else Ut:=(GOffeneFenster*Gtopschritte)-UTop;
      if ULeft > (GOffeneFenster*GLeftschritte) then Ul:=ULeft-(GOffeneFenster*GLeftschritte) Else Ul:=(GOffeneFenster*GLeftschritte)-ULeft;
      Ut:=Round(Ut/(Ua));  Ul:=Round(Ul/Ua);
      for i := 1 to Ua do begin
        if UTop > (GOffeneFenster*Gtopschritte) then top:=top-Ut Else top:=top+Ut;if ULeft > (GOffeneFenster*GLeftschritte) then left:=left-Ul Else left:=Left+Ul;
      end;
  //-------------------------Fensteranimation Ende
  if UActivListe='Artikelgruppe' then
  begin
    If UListeArt = 'Artikel' then
    begin
      FormPlanlos.Gzeiger:=DataModuleDB.DatensatzKopieren('Artikelgruppe',QueryGruppe.Fields[0].Value);
      Fnr:=FormPlanlos.Gzeiger;FormPlanlos.GzeigerNeu:=True;
      FormArtikelgruppe.ShowModal;
      if FormPlanlos.GZeiger = 0 Then  Datensatzgeloscht:=DataModuleDB.DatensatzLoeschen('Artikelgruppe',Fnr);
    end;
    ///////////ablauf für alle Gruppen
    Fnr:=FormPlanlos.Gzeiger;
    if Fnr<>0 then
    begin
      sucheGruppeNr(Fnr);
      zeigeArtikel(True,'','');
      ActiveControl:=DBGridGruppe;
      DBGridGruppe.SelectedField:=QueryGruppe.Fields[1];
    end;
  end
  Else ////////////////////Activliste = Artikel QueryArtikel.Fields[0].Value;
  begin
    If UListeArt = 'Artikel' then
    begin
      FormPlanlos.Gzeiger:=DataModuleDB.DatensatzKopieren('Artikel',QueryArtikel.Fields[0].Value);
      Fnr:=FormPlanlos.Gzeiger;FormPlanlos.GzeigerNeu:=True;
      FormArtikel.ShowModal;
      if FormPlanlos.GZeiger = 0 Then  Datensatzgeloscht:=DataModuleDB.DatensatzLoeschen('Artikel',Fnr);
    end;
    If UListeArt = 'Stueckliste' then
    begin
      FormPlanlos.Gzeiger:=DataModuleDB.DatensatzKopieren('Stueckliste',QueryArtikel.Fields[0].Value);
      DataModuleDB.DatensatzKopierenListe('StuecklistenArtikel','StueckListen_Nr',QueryArtikel.Fields[0].Value,FormPlanlos.GZeiger);
      Fnr:=FormPlanlos.Gzeiger;FormPlanlos.GzeigerNeu:=True;
      FormStueckliste.ShowModal;
      if FormPlanlos.GZeiger = 0 Then  Datensatzgeloscht:=DataModuleDB.DatensatzLoeschen('Stueckliste',Fnr);
      if FormPlanlos.GZeiger = 0 Then  Datensatzgeloscht:=DataModuleDB.DatensatzLoeschenMitFeld('StuecklistenArtikel',Fnr,'Stuecklisten_Nr');
    end;
    //////////// ablauf für alle Artikel StueckListenArtikel
    Fnr:=FormPlanlos.Gzeiger;
    if Fnr<>0 then
    begin
      zeigeArtikel(False,'','');
      sucheArtikelNr(Fnr);
      ActiveControl:=DBGridArtikel;
      DBGridArtikel.SelectedField:=QueryArtikel.Fields[2];
    end;
  end;
  If Datensatzgeloscht = False Then
  begin
   Color:=clGray;
   Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
   Color:=clYellow;
  end;
  //------------------ Unten Fensteranimation
      for i := 1 to Ua do begin
        if Top > Utop then top:=top-Ut Else top:=top+Ut;
        if Left > ULeft then left:=left-Ul Else left:=Left+Ul;
      end;
  //-------------------------Fensteranimation Ende
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,CheckBoxLife);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
end;

procedure TFormArtikelAussuchen.ButtonLoeschenClick(Sender: TObject);
Var Fnr:integer;
    FArtikelgruppe:String;
    Datensatzgeloscht:Boolean;
begin
  Datensatzgeloscht:=True;
  Fnr:=0;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,CheckBoxLife);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  if UActivListe='Artikelgruppe' then
  begin
    If UListeArt = 'Artikel' then
    begin
      Fnr:=QueryGruppe.Fields[0].Value;
      FArtikelgruppe:=QueryGruppe.Fields[1].Value;
      if Meldefenster.an(2,'wollen sie alle Artikel in',FArtikelgruppe+' löschen ?','Achtung alle Artikel in dieser Gruppe werden gelöscht') then
      begin
        Datensatzgeloscht:=DataModuleDB.DatensatzLoeschen('Artikelgruppe',Fnr);
//ändern        //DatensatzLoeschenMitFeld('Artikel','Artikelgruppe',FArtikelgruppe);
      end;
    end;
    If UListeArt = 'Stueckliste' then
    begin
      Fnr:=QueryGruppe.Fields[0].Value;
      if QueryArtikel.RecordCount>0 then
        Meldefenster.an(1,'es sind noch Stücklisten in der Sücklistengruppe',FArtikelgruppe+' vorhanden','Achtung Stücklisten-Gruppe kann nicht gelöscht werden !')
      else
        Datensatzgeloscht:=DataModuleDB.DatensatzLoeschen('Stuecklistengruppe',Fnr);
    end;
    ///////////ablauf für alle Gruppen
    if Datensatzgeloscht then zeigeArtikel(False,'','');
    ActiveControl:=DBGridGruppe;
    DBGridGruppe.SelectedField:=QueryGruppe.Fields[1];
  end
  Else ////////////////////Activliste = Artikel QueryArtikel.Fields[0].Value;
  begin
    If UListeArt = 'Artikel' then
    begin
      Fnr:=QueryArtikel.Fields[0].Value;
      Datensatzgeloscht:=DataModuleDB.DatensatzLoeschen('Artikel',Fnr);
    end;
    If UListeArt = 'Stueckliste' then
    begin
      Fnr:=QueryArtikel.Fields[0].Value;
      FArtikelgruppe:=QueryGruppe.Fields[1].Value;
      if Meldefenster.an(2,'wollen sie alle Artikel in',FArtikelgruppe+' löschen ?','Achtung alle Artikel in dieser Stückliste werden gelöscht') Then
      begin
        Datensatzgeloscht:=DataModuleDB.DatensatzLoeschen('Stueckliste',Fnr);
        Datensatzgeloscht:=DataModuleDB.DatensatzLoeschenMitFeld('StuecklistenArtikel',Fnr,'Stuecklisten_Nr');
      end;
    end;
    //////////// ablauf für alle Artikel StueckListenArtikel
    if Datensatzgeloscht then zeigeArtikel(False,'','');
    ActiveControl:=DBGridArtikel;
    DBGridArtikel.SelectedField:=QueryArtikel.Fields[2];
  end;
  If Datensatzgeloscht = False Then
  begin
   //Color:=clGray;
   Meldefenster.an(2,'Datensatz konnte','nicht gelöscht werden !','');
   //Color:=clYellow;
  end;
  //  PanelTastatur.Color:=clYellow;
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,CheckBoxLife);
end;
procedure TFormArtikelAussuchen.ButtonFilterClick(Sender: TObject);
var i:integer;
    filterString:String;
begin
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,CheckBoxLife);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1a.bmp');
  //  PanelTastatur.Color:=clGray;
  if UActivListe='Artikelgruppe' then
  begin
    USQLFilterGruppeListe:=FormFilter.an(USQLFilterGruppeListe,USpaltenListeGruppe);
    if USQLFilterGruppeListe.count > 2 then
      begin
        USQLFilterGruppe :='';
        for i:=0 to (USQLFilterGruppeListe.count -1) do
        USQLFilterGruppe:= USQLFilterGruppe + USQLFilterGruppeListe[i];
      end
    else USQLFilterGruppe :='';
  end
  else
  begin
    USQLFilterArtikelListe:=FormFilter.an(USQLFilterArtikelListe,USpaltenListeartikel);
    if USQLFilterArtikelListe.count > 2 then
      begin
        USQLFilterArtikel :='';
        for i:=0 to (USQLFilterArtikelListe.count -1) do
        USQLFilterArtikel:= USQLFilterArtikel + USQLFilterArtikelListe[i];
      end
    else USQLFilterArtikel :='';
  end;
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF2,LabelF3,LabelF5,LabelF6,LabelF7,LabelF8,LabelF9,LabelEnter,LabelDatensatzinfo,LabelSortiert,LabelFilter,LabelF2,LabelESC_p,LabelF2_p,LabelF3_p,LabelF5_p,LabelF6_p,LabelF7_p,LabelF8_p,LabelF9_p,LabelEnter_p,LabelDatensatzinfo_p,LabelSortiert_p,LabelFilter_p,LabelF2_p,CheckBoxLife);
  //if GBmpLaden then ImageTastatur.Picture.LoadFromFile('Tastaturblau1.bmp');
  zeigeArtikel(True,'','');
  if UActivListe='Artikelgruppe' then ActiveControl:=DBGridGruppe Else ActiveControl:=DBGridArtikel;
  DBGridArtikel.SelectedField:=QueryArtikel.Fields[2];
end;

procedure TFormArtikelAussuchen.ButtonerledigteZeigenClick(
  Sender: TObject);
begin
  if UErledigtArtikelAusschalten then UErledigtArtikelAusschalten:=False Else UErledigtArtikelAusschalten:=True;
  if UErledigtArtikelAusschalten=False then ButtonerledigteZeigen.caption:='erledigte Artikel nicht mit anzeigen' else ButtonerledigteZeigen.caption:='erledigte Artikel mit anzeigen';
  zeigeArtikel(False,'','');
  if UActivListe='Artikelgruppe' then ActiveControl:=DBGridGruppe Else ActiveControl:=DBGridArtikel;
end;

procedure TFormArtikelAussuchen.ButtonAlleClick(Sender: TObject);
begin
  QueryArtikel.first;
  while not QueryArtikel.eof do begin
    DBGridArtikel.SelectedRows.CurrentRowSelected:=true;
    QueryArtikel.Next;
  end;
  ActiveControl:=DBGridArtikel;
end;

procedure TFormArtikelAussuchen.ButtonmarkierenClick(Sender: TObject);
begin
  DBGridArtikel.SelectedRows.CurrentRowSelected:=true;
  QueryArtikel.Next;
  ActiveControl:=DBGridArtikel;
end;

procedure TFormArtikelAussuchen.ButtonAlleAusClick(Sender: TObject);
begin
  DBGridArtikel.SelectedRows.Clear;
  ActiveControl:=DBGridArtikel;
end;

procedure TFormArtikelAussuchen.DBGridArtikelDblClick(Sender: TObject);
begin
   ButtonEnterClick(Self);
end;

procedure TFormArtikelAussuchen.DBGridGruppeDblClick(Sender: TObject);
begin
  ButtonEnterClick(Self);
end;

procedure TFormArtikelAussuchen.EditZeigerEnter(Sender: TObject);
begin
  EditZeiger.Color:=clYellow;
end;

procedure TFormArtikelAussuchen.EditZeigerExit(Sender: TObject);
begin
    EditZeiger.Color:=clWindow;
end;

end.
