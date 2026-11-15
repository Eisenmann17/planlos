unit UnitDammiForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TDammiForm = class(TForm)
    Label1: TLabel;
  private
    { Private-Deklarationen }
  public
   function FensterAn(Herkunft:string;zeiger:longInt):longInt;
    { Public-Deklarationen }
  end;

var
  DammiForm: TDammiForm;
  Fzeiger:longint;

implementation

{$R *.DFM}
function TDammiForm.FensterAn(Herkunft:string;zeiger:longInt):longInt;
begin
  Fzeiger:=zeiger;
  {self.Query1.close;Query1.sql.Clear;
  Self.Query1.sql.add('Select * From Adress Where nr = '+ inttostr(Fzeiger));
  Self.Query1.active:=True;
  try
    Self.Query1.open;//Self.Query1.Edit;
  finally
  end;}
  DammiForm.ShowModal;
  Result:=Fzeiger;
end;

end.
