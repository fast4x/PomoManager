unit alertpomo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm_alertpomo }

  TForm_alertpomo = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form_alertpomo: TForm_alertpomo;

implementation

{$R *.lfm}

{ TForm_alertpomo }

procedure TForm_alertpomo.Button1Click(Sender: TObject);
begin
  close;
end;

end.

