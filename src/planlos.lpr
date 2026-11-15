program planlos;

{ Planlos — freies Fakturierprogramm
  Copyright (C) 2026 Günther Stadtler

  Dieses Programm ist freie Software unter der GNU General Public License,
  Version 3. Der volle Text steht in der Datei LICENSE im Projektordner.
  Es gibt keine Garantie, soweit das Gesetz das zulässt. }

{$mode objfpc}{$H+}
{$codepage UTF8}

uses
  {$IFDEF UNIX}
  cthreads,
  cwstring,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // zieht das LCL-Widgetset (Fenster) herein
  Forms, SysUtils,
  uhaupt, uanmeldung, ubenutzer;

var
  Meldung: string;

begin
  RequireDerivedFormResource := True;
  Application.Scaled := True;
  Application.Title := 'Planlos';
  Application.Initialize;
  Application.CreateForm(THauptfenster, Hauptfenster);
  if Hauptfenster.DatenbankOffen then
  begin
    if GetEnvironmentVariable('PLANLOS_SELBSTTEST') = '1' then
      Anmelden('Admin', '0000', Meldung)
    else if not AnmeldungZeigen then
      Exit;
  end;
  Application.Run;
end.
