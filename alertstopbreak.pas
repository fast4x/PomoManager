unit alertstopbreak;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm_alertstopbreak }

  TForm_alertstopbreak = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form_alertstopbreak: TForm_alertstopbreak;

implementation

{$R *.lfm}

{ TForm_alertstopbreak }

procedure TForm_alertstopbreak.Button1Click(Sender: TObject);
begin
  close
end;

end.

