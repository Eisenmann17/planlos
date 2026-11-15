unit UnitExport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFormExport = class(TForm)
    ImageTastatur: TImage;
    PanelTastatur: TPanel;
    LabelEsc_p: TLabel;
    LabelF10_p: TLabel;
    LabelESC: TLabel;
    LabelF10: TLabel;
    Buttonabbrechen: TButton;
    ButtonOk: TButton;
    ComboBoxTabelle: TComboBox;
    Label6: TLabel;
    EditDateiname: TEdit;
    Label1: TLabel;
    EditTrennzeichen: TEdit;
    Label2: TLabel;
    ButtonStart: TButton;
    QueryExport: TZQuery;
    DataSourceExport: TDataSource;
    CheckBoxErsteZeileSpalten: TCheckBox;
    RadioGroupTabellenauswahl: TRadioGroup;
    ComboBoxSortierung: TComboBox;
    Label3: TLabel;
    CheckBoxNoNr: TCheckBox;
    CheckBoxFilter: TCheckBox;
    ComboBoxFilterFeldnahme: TComboBox;
    ComboBoxFilterOperand: TComboBox;
    EditFilterText: TEdit;
    Label4: TLabel;
    MemoSQL: TMemo;
    Label5: TLabel;
    LabelFortlauf: TLabel;
    procedure ComboBoxTabelleChange(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ButtonabbrechenClick(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioGroupTabellenauswahlClick(Sender: TObject);
    procedure CheckBoxFilterClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormExport: TFormExport;

implementation

uses UnitDataModul, UnitModule;

{$R *.DFM}

procedure TFormExport.ComboBoxTabelleChange(Sender: TObject);
  Var i:integer;
begin
  EditDateiname.Text:=ComboBoxTabelle.Text+'.txt';
  ComboBoxSortierung.Items.Clear;
  ComboBoxFilterFeldnahme.Clear;
  if QueryExport.Active then QueryExport.close;
  QueryExport.sql.Clear;
  QueryExport.sql.add('Select * From '+ ComboBoxTabelle.Text);
  try QueryExport.open; finally end;
  for i := 0 to QueryExport.FieldCount - 1 do begin
    if QueryExport.Fields[i].IsBlob = False  then begin
       ComboBoxFilterFeldnahme.Items.Add(QueryExport.Fields[i].FieldName);
       ComboBoxSortierung.Items.Add(QueryExport.Fields[i].FieldName);
    end
  end;
  QueryExport.close;
end;

procedure TFormExport.ButtonStartClick(Sender: TObject);
Var  datendatei:System.text;
     zeile1,zeile2,zeile3,Zeile4,Zeile5,Zeile6,Zeile7,Zeile8,Zeile9,Zeile10:String;
     i,z: integer;
     //SpaltenListe: TStringlist;
     OrderBy,Filter:String;
begin
  //SpaltenListe:=TStringList.Create;
  Rewrite(datendatei,EditDateiname.Text);
  if QueryExport.Active then QueryExport.close;
  QueryExport.sql.Clear;
  if RadioGroupTabellenauswahl.ItemIndex = 0 Then begin
    if ComboBoxSortierung.Text='' then OrderBy:='' Else OrderBy:=' order By '+ComboBoxSortierung.Text;
    if (CheckBoxFilter.Checked) and (ComboBoxFilterFeldnahme.text<>'') Then Filter:=' Where '+ComboBoxFilterFeldnahme.text+' '+ComboBoxFilterOperand.text+' '+EditFilterText.Text
    Else Filter:='';
    QueryExport.sql.add('Select * From '+ ComboBoxTabelle.Text+' '+Filter+' '+OrderBy);
  end Else begin
    QueryExport.sql.AddStrings(MemoSQL.Lines);
  end;
  try QueryExport.open; finally end;
  z:=0;
  if CheckBoxErsteZeileSpalten.Checked Then begin
    zeile1:='';zeile2:='';zeile3:='';zeile4:='';zeile5:='';zeile6:='';zeile7:='';zeile8:='';zeile9:='';zeile10:='';
    for i := 0 to QueryExport.FieldCount - 1 do begin
      if CheckBoxNoNr.Checked then begin
        if (QueryExport.Fields[i].IsBlob = False)  and (QueryExport.Fields[i].FieldName <>'Nr') then begin
          if (length(QueryExport.Fields[i].FieldName)       + length(Zeile1)+length(EditTrennzeichen.Text)) < 255  then  Zeile1:=Zeile1+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile2)+length(EditTrennzeichen.Text)) < 255  then  Zeile2:=Zeile2+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile3)+length(EditTrennzeichen.Text)) < 255  then  Zeile3:=Zeile3+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile4)+length(EditTrennzeichen.Text)) < 255  then  Zeile4:=Zeile4+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile5)+length(EditTrennzeichen.Text)) < 255  then  Zeile5:=Zeile5+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile6)+length(EditTrennzeichen.Text)) < 255  then  Zeile6:=Zeile6+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile7)+length(EditTrennzeichen.Text)) < 255  then  Zeile7:=Zeile7+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile8)+length(EditTrennzeichen.Text)) < 255  then  Zeile8:=Zeile8+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile9)+length(EditTrennzeichen.Text)) < 255  then  Zeile9:=Zeile9+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile10)+length(EditTrennzeichen.Text)) < 255  then  Zeile10:=Zeile10+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text;
        end;
      end else begin
        if QueryExport.Fields[i].IsBlob = False  then begin
          if (length(QueryExport.Fields[i].FieldName)       + length(Zeile1)+length(EditTrennzeichen.Text)) < 255  then  Zeile1:=Zeile1+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile2)+length(EditTrennzeichen.Text)) < 255  then  Zeile2:=Zeile2+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile3)+length(EditTrennzeichen.Text)) < 255  then  Zeile3:=Zeile3+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile4)+length(EditTrennzeichen.Text)) < 255  then  Zeile4:=Zeile4+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile5)+length(EditTrennzeichen.Text)) < 255  then  Zeile5:=Zeile5+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile6)+length(EditTrennzeichen.Text)) < 255  then  Zeile6:=Zeile6+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile7)+length(EditTrennzeichen.Text)) < 255  then  Zeile7:=Zeile7+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile8)+length(EditTrennzeichen.Text)) < 255  then  Zeile8:=Zeile8+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile9)+length(EditTrennzeichen.Text)) < 255  then  Zeile9:=Zeile9+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text
          Else  if (length(QueryExport.Fields[i].FieldName) + length(Zeile10)+length(EditTrennzeichen.Text)) < 255  then  Zeile10:=Zeile10+QueryExport.Fields[i].FieldName + EditTrennzeichen.Text;
        end;
      end;
    end;
    Writeln(datendatei,zeile1+zeile2+zeile3+zeile4+zeile5+zeile6+zeile7+zeile8+zeile9+zeile10);
  end;
  QueryExport.First;
  while not QueryExport.eof do begin
    z:=z+1;
      zeile1:='';zeile2:='';zeile3:='';zeile4:='';zeile5:='';zeile6:='';zeile7:='';zeile8:='';zeile9:='';zeile10:='';
    for i := 0 to QueryExport.FieldCount - 1 do begin
      if CheckBoxNoNr.Checked then begin
        if (QueryExport.Fields[i].IsBlob = False)  and (QueryExport.Fields[i].FieldName <>'Nr') then begin
          if (length(QueryExport.Fields[i].AsString) +      length(Zeile1)+length(EditTrennzeichen.Text)) < 255  then  Zeile1:=Zeile1+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile2)+length(EditTrennzeichen.Text)) < 255  then  Zeile2:=Zeile2+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile3)+length(EditTrennzeichen.Text)) < 255  then  Zeile3:=Zeile3+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile4)+length(EditTrennzeichen.Text)) < 255  then  Zeile4:=Zeile4+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile5)+length(EditTrennzeichen.Text)) < 255  then  Zeile5:=Zeile5+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile6)+length(EditTrennzeichen.Text)) < 255  then  Zeile6:=Zeile6+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile7)+length(EditTrennzeichen.Text)) < 255  then  Zeile7:=Zeile7+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile8)+length(EditTrennzeichen.Text)) < 255  then  Zeile8:=Zeile8+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile9)+length(EditTrennzeichen.Text)) < 255  then  Zeile9:=Zeile9+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile10)+length(EditTrennzeichen.Text)) < 255  then  Zeile10:=Zeile10+QueryExport.Fields[i].AsString + EditTrennzeichen.Text;
        end;
      end Else begin
        if QueryExport.Fields[i].IsBlob = False  then begin
          if (length(QueryExport.Fields[i].AsString) +      length(Zeile1)+length(EditTrennzeichen.Text)) < 255  then  Zeile1:=Zeile1+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile2)+length(EditTrennzeichen.Text)) < 255  then  Zeile2:=Zeile2+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile3)+length(EditTrennzeichen.Text)) < 255  then  Zeile3:=Zeile3+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile4)+length(EditTrennzeichen.Text)) < 255  then  Zeile4:=Zeile4+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile5)+length(EditTrennzeichen.Text)) < 255  then  Zeile5:=Zeile5+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile6)+length(EditTrennzeichen.Text)) < 255  then  Zeile6:=Zeile6+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile7)+length(EditTrennzeichen.Text)) < 255  then  Zeile7:=Zeile7+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile8)+length(EditTrennzeichen.Text)) < 255  then  Zeile8:=Zeile8+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile9)+length(EditTrennzeichen.Text)) < 255  then  Zeile9:=Zeile9+QueryExport.Fields[i].AsString + EditTrennzeichen.Text
          Else if (length(QueryExport.Fields[i].AsString) + length(Zeile10)+length(EditTrennzeichen.Text)) < 255  then  Zeile10:=Zeile10+QueryExport.Fields[i].AsString + EditTrennzeichen.Text;
        end;
      end;
    end;
    LabelFortlauf.Caption:=IntToStr(QueryExport.RecordCount)+' von '+inttostr(z);
    Writeln(datendatei,zeile1+zeile2+zeile3+zeile4+zeile5+zeile6+zeile7+zeile8+zeile9+zeile10);
    QueryExport.next;
  end;
  CloseFile(datendatei);
  QueryExport.close;
  //SpaltenListe.Free;
end;

procedure TFormExport.FormActivate(Sender: TObject);
begin
  DataModuleMyOffice.FensteraktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
  GOffeneFenster:=GOffeneFenster+1;
  if GCascade=1 then begin top:=GOffeneFenster*Gtopschritte;Left:=GOffeneFenster*GLeftschritte;end;
  CheckBoxFilter.Checked:=False;
  CheckBoxFilterClick(Self);
  RadioGroupTabellenauswahlClick(Self);
  ComboBoxTabelleChange(Self);
  CheckBoxNoNr.Checked:=False;
  CheckBoxErsteZeileSpalten.Checked:=False;
  LabelFortlauf.Caption:='0 von 0';
end;

procedure TFormExport.ButtonabbrechenClick(Sender: TObject);
begin
  Close;
end;

procedure TFormExport.ButtonOkClick(Sender: TObject);
begin
  close;
end;

procedure TFormExport.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then  ButtonabbrechenClick(Self);
  if Key = VK_F10 then ButtonOKClick(Self);
end;

procedure TFormExport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GOffeneFenster:=GOffeneFenster-1;
  DataModuleMyOffice.FensterdeaktivLaden(PanelTastatur,ImageTastatur,LabelESC,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelF10,LabelEsc_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,LabelF10_p,FormPlanlos.GCB);
end;

procedure TFormExport.RadioGroupTabellenauswahlClick(Sender: TObject);
begin
  if RadioGroupTabellenauswahl.ItemIndex = 0 Then begin
    Label4.Visible:= False;
    MemoSQL.Visible:= False;
    Label6.Visible:= True;
    ComboBoxTabelle.Visible:= True;
    Label3.Visible:= True;
    ComboBoxSortierung.Visible := True;
    CheckBoxFilter.Visible:= True;
    ComboBoxFilterFeldnahme.Visible:= True;
    ComboBoxFilterOperand.Visible:= True;
    EditFilterText.Visible:= True;
    if CheckBoxFilter.Checked then begin
      ComboBoxFilterFeldnahme.Visible:= True;
      ComboBoxFilterOperand.Visible:= True;
      EditFilterText.Visible:= True;
      Label5.Visible:= True;
    end Else begin
      ComboBoxFilterFeldnahme.Visible:= False;
      ComboBoxFilterOperand.Visible:= False;
      EditFilterText.Visible:= False;
      Label5.Visible:= False;
    end;
  end else begin
    Label4.Visible:= True;
    MemoSQL.Visible:= True;
    Label6.Visible:= False;
    ComboBoxTabelle.Visible:= False;
    Label3.Visible:= False;
    ComboBoxSortierung.Visible := False;
    CheckBoxFilter.Visible:= False;
    ComboBoxFilterFeldnahme.Visible:= False;
    ComboBoxFilterOperand.Visible:= False;
    EditFilterText.Visible:= False;
    Label5.Visible:= False;
  end;
end;

procedure TFormExport.CheckBoxFilterClick(Sender: TObject);
begin
  if CheckBoxFilter.Checked then begin
    ComboBoxFilterFeldnahme.Visible:= True;
    ComboBoxFilterOperand.Visible:= True;
    EditFilterText.Visible:= True;
    Label5.Visible:= True;
  end Else begin
    ComboBoxFilterFeldnahme.Visible:= False;
    ComboBoxFilterOperand.Visible:= False;
    EditFilterText.Visible:= False;
    Label5.Visible:= False;
  end;
end;

end.
