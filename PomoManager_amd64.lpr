program PomoManager_amd64;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,  Unit1, alertpomo, alertbreak,
  alertstopbreak, alertbreaklungo;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm_alertpomo, Form_alertpomo);
  Application.CreateForm(TForm_alertbreak, Form_alertbreak);
  Application.CreateForm(TForm_alertstopbreak, Form_alertstopbreak);
  Application.CreateForm(TForm_alertbreaklungo, Form_alertbreaklungo);
  Application.Run;
end.

