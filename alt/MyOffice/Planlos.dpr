program Planlos;

uses
  Forms,
  Eingang in 'Eingang.pas' {FormEingang},
  UnitModule in 'UnitModule.pas' {FormPlanlos},
  TempForm in 'TempForm.pas' {Form1},
  UnitDammiForm in 'UnitDammiForm.pas' {DammiForm},
  UnitDatum in 'UnitDatum.pas' {FormDatum},
  UnitFilter in 'UnitFilter.pas' {FormFilter},
  UnitMaskeProjekt in 'UnitMaskeProjekt.pas' {FormProjekte},
  UnitArtikelSammlung in 'UnitArtikelSammlung.pas' {FormArtikelSammlung},
  UnitAdresse in 'UnitAdresse.pas' {FormAdresse},
  UnitKategorie in 'UnitKategorie.pas' {FormKategorie},
  UnitEinstellungForm1 in 'UnitEinstellungForm1.pas' {FormEinstellungForm1},
  UnitDB in 'UnitDB.pas' {DataModuleDB: TDataModule},
  UnitMeldefenster in 'UnitMeldefenster.pas' {Meldefenster},
  UnitMaskeEinheit in 'UnitMaskeEinheit.pas' {FormEinheit},
  UnitArtikel in 'UnitArtikel.pas' {FormArtikel},
  UnitArtikelgruppe in 'UnitArtikelgruppe.pas' {FormArtikelgruppe},
  UnitEinstellungModulart in 'UnitEinstellungModulart.pas' {FormEinstellungModulart},
  UnitGuppierung in 'UnitGuppierung.pas' {FormGruppierung},
  UnitTextbaustein in 'UnitTextbaustein.pas' {FormTextbaustein},
  UnitBenutzer in 'UnitBenutzer.pas' {FormBenutzer},
  UnitArtikelAussuchen in 'UnitArtikelAussuchen.pas' {FormArtikelAussuchen},
  UnitStuecklistenGruppe in 'UnitStuecklistenGruppe.pas' {FormStuecklistengruppe},
  UnitStueckListe in 'UnitStueckListe.pas' {FormStueckliste},
  UnitDataModul in 'UnitDataModul.pas' {DataModuleMyOffice: TDataModule},
  UnitEinstellungenDrucken in 'UnitEinstellungenDrucken.pas' {FormEinstellungenDrucken},
  UnitFormatierung in 'UnitFormatierung.pas' {FormFormatierung},
  UnitEinstellungenBenutzer in 'UnitEinstellungenBenutzer.pas' {FormEinstellungenBenutzer},
  UnitBerechnungsart in 'UnitBerechnungsart.pas' {FormBerechungsart},
  UnitSpalteAendern in 'UnitSpalteAendern.pas' {FormSpalteAender},
  registrierung in 'registrierung.pas' {Formregistrierung},
  UnitEinstellungenFenster in 'UnitEinstellungenFenster.pas' {FormEinstellungenFenster},
  UnitFensterdesign in 'UnitFensterdesign.pas' {Fensterdesigne},
  UnitExport in 'UnitExport.pas' {FormExport},
  UnitImport in 'UnitImport.pas' {FormImport},
  UnitEinstellungenArtikelAussuchen in 'UnitEinstellungenArtikelAussuchen.pas' {FormEinstellungenArtikelAussuchen};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormPlanlos, FormPlanlos);
  Application.CreateForm(TFormEingang, FormEingang);
  Application.CreateForm(TDammiForm, DammiForm);
  Application.CreateForm(TFormDatum, FormDatum);
  Application.CreateForm(TFormFilter, FormFilter);
  Application.CreateForm(TFormProjekte, FormProjekte);
  Application.CreateForm(TFormArtikelSammlung, FormArtikelSammlung);
  Application.CreateForm(TFormAdresse, FormAdresse);
  Application.CreateForm(TFormKategorie, FormKategorie);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormEinstellungForm1, FormEinstellungForm1);
  Application.CreateForm(TDataModuleDB, DataModuleDB);
  Application.CreateForm(TMeldefenster, Meldefenster);
  Application.CreateForm(TFormEinheit, FormEinheit);
  Application.CreateForm(TFormArtikel, FormArtikel);
  Application.CreateForm(TFormArtikelgruppe, FormArtikelgruppe);
  Application.CreateForm(TFormEinstellungModulart, FormEinstellungModulart);
  Application.CreateForm(TFormGruppierung, FormGruppierung);
  Application.CreateForm(TFormTextbaustein, FormTextbaustein);
  Application.CreateForm(TFormBenutzer, FormBenutzer);
  Application.CreateForm(TFormArtikelAussuchen, FormArtikelAussuchen);
  Application.CreateForm(TFormArtikelAussuchen, FormArtikelAussuchen1);
  Application.CreateForm(TFormArtikelAussuchen, FormArtikelAussuchen2);
  Application.CreateForm(TFormStuecklistengruppe, FormStuecklistengruppe);
  Application.CreateForm(TFormStueckliste, FormStueckliste);
  Application.CreateForm(TDataModuleMyOffice, DataModuleMyOffice);
  Application.CreateForm(TFormEinstellungenDrucken, FormEinstellungenDrucken);
  Application.CreateForm(TFormFormatierung, FormFormatierung);
  Application.CreateForm(TFormEinstellungenBenutzer, FormEinstellungenBenutzer);
  Application.CreateForm(TFormBerechungsart, FormBerechungsart);
  Application.CreateForm(TFormSpalteAender, FormSpalteAender);
  Application.CreateForm(TFormregistrierung, Formregistrierung);
  Application.CreateForm(TFormEinstellungenFenster, FormEinstellungenFenster);
  Application.CreateForm(TFensterdesigne, Fensterdesigne);
  Application.CreateForm(TFormExport, FormExport);
  Application.CreateForm(TFormImport, FormImport);
  Application.CreateForm(TFormEinstellungenArtikelAussuchen, FormEinstellungenArtikelAussuchen);
  Application.Run;
end.
