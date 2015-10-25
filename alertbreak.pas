unit alertbreak;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm_alertbreak }

  TForm_alertbreak = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form_alertbreak: TForm_alertbreak;

implementation

{$R *.lfm}

{ TForm_alertbreak }

procedure TForm_alertbreak.Button1Click(Sender: TObject);
begin
  close;
end;

end.

