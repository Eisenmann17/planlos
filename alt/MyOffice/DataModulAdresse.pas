unit DataModulAdresse;

interface

uses
  SysUtils, Windows, Classes, Graphics, Controls,
  Forms, Dialogs, DB, DBTables;

type
  TDataModule1 = class(TDataModule)
    QueryAdresseNr: TIntegerField;
    QueryAdresseKategorie: TStringField;
    QueryAdresseNachname: TStringField;
    QueryAdresseVorname: TStringField;
    QueryAdresseTitel: TStringField;
    QueryAdresseFirma: TStringField;
    QueryAdresseTel_Firma: TStringField;
    QueryAdresseTel_Privat: TStringField;
    QueryAdresseTel_Fax: TStringField;
    QueryAdresseTel_Andere: TStringField;
    QueryAdresseE_Mail: TStringField;
    QueryAdresseStrasse_Nr: TStringField;
    QueryAdressePLZ: TStringField;
    QueryAdresseOrt: TStringField;
    QueryAdresseLand: TStringField;
    QueryAdresseNotiz: TMemoField;
    QueryAdresseAdresse: TMemoField;
    QueryAdresseFrei1: TStringField;
    QueryAdresseFrei2: TStringField;
    QueryAdresseFrei3: TStringField;
    QueryAdresseFrei4: TStringField;
    DataSource1: TDataSource;
    QueryAdresse: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.DFM}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  QueryAdresse.Open;
end;

end.