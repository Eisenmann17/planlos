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
  Forms,
  uhaupt;

begin
  RequireDerivedFormResource := False;
  Application.Scaled := True;
  Application.Title := 'Planlos';
  Application.Initialize;
  Application.CreateForm(THauptfenster, Hauptfenster);
  Application.Run;
end.
