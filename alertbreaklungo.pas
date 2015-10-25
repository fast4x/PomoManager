unit alertbreaklungo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm_alertbreaklungo }

  TForm_alertbreaklungo = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form_alertbreaklungo: TForm_alertbreaklungo;

implementation

{$R *.lfm}

{ TForm_alertbreaklungo }

procedure TForm_alertbreaklungo.Button1Click(Sender: TObject);
begin
  close;
end;

end.

