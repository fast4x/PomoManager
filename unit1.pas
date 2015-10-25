unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Menus;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Lappdesc: TLabel;
    Ltime: TLabel;
    Ltime1: TLabel;
    Ltime2: TLabel;
    PageControl1: TPageControl;
    StatusBar1: TStatusBar;
    TabProd: TTabSheet;
    TabBreak: TTabSheet;
    TabBreakL: TTabSheet;
    TabSheet1: TTabSheet;
    TimerMain: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure TimerMainTimer(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  MS : Comp;
  TS : TTimeStamp;
  DT : TDateTime;
  actualtime:word; // 0 prod 1 break 2 break esteso
  countparzpomo, countpomo, countbreak, countbreakest:word;
  settimer:boolean;



implementation
uses alertpomo, LCLIntf,alertbreak, alertstopbreak, alertbreaklungo, Process
  {$IFDEF WIN32}
    ,MMSystem
  {$ENDIF}
  ;
// for systems using the PulseAudio sound server
// such as Linux Ubuntu Hardy Heron


function PlaySoundLnx(fileName: String): Boolean;
const
  playerCmd = 'paplay';  // pulseaudio client
var
  AProcess: TProcess;
begin
  AProcess := TProcess.Create(nil);
  with Aprocess do begin
    CommandLine := FindDefaultExecutablePath(playerCmd) +
      ' ' + filename;
    //Options := Options + [poWaitOnExit];
    try
      try
        Execute;
      except
        on E: Exception do
          ShowMessage(E.ClassName +
            ' error raised, with message : ' + E.Message);
      end;
    finally
      Free;
    end;
  end;
end;



procedure PlayMyWAV;
var appdir:string;
begin
  {$IFDEF UNIX}
  // get application directory;
  // wav file is in the adudio subdirectory
  AppDir := ExtractFilePath(Application.ExeName);
  // play WAV
  PlaySoundLnx(AppDir + './Gong.wav');
  {$ENDIF}
  {$IFDEF WIN32}
   PlaySound(pchar(AppDir + './Gong.wav'), 0, 0);
  {$ENDIF}
end;
{$R *.lfm}

{ TForm1 }

procedure TForm1.TimerMainTimer(Sender: TObject);
begin

  MS:=MS-1000;
  TS:=MSecsToTimeStamp(MS);
  DT:=TimeStampToDateTime(TS);


  if actualtime = 0 then begin
  if settimer=true then  begin
          MS:=1000*1500; // 25 minuti
          TS:=MSecsToTimeStamp(MS);
          DT:=TimeStampToDateTime(TS);

        settimer:=false;
  end;
  statusbar1.Panels[1].Text:='Fase: Tempo produttivo';
  tabprod.Show;
  ltime.Caption:=TimeToStr(DT);
  if ltime.caption='00:00:00' then begin
    inc(countparzpomo,1);
    inc(countpomo,1);
    timermain.Enabled:=false;
    if countparzpomo < 4 then begin
      PlayMyWAV;
       form_alertpomo.showmodal;
       form_alertbreak.showmodal;
    end;
    timermain.Enabled:=true; // riattiva timer
    actualtime:=1; // break
    settimer:=true;
    tabbreak.Show;
    label1.Caption:='Pomodori: '+inttostr(countpomo);
    if countparzpomo = 4 then begin
        actualtime:=2; // break esteso
        countparzpomo:=0;
        timermain.Enabled:=false;
        form_alertpomo.showmodal;
        form_alertbreaklungo.showmodal;
        timermain.Enabled:=true; // riattiva timer
    end;
  end;
  end;

  if actualtime = 1 then begin
  if settimer=true then  begin
       MS:=1000*300; // 5 minuti
       TS:=MSecsToTimeStamp(MS);
       DT:=TimeStampToDateTime(TS);

       settimer:=false;
  end;
  statusbar1.Panels[1].Text:='Fase: Break';
  tabbreak.Show;
  ltime1.Caption:=TimeToStr(DT);
  if ltime1.caption='00:00:00' then begin
    timermain.Enabled:=false;
    form_alertstopbreak.showmodal;
    timermain.Enabled:=true; // riattiva timer
    actualtime:=0; // produzione
    settimer:=true;
    tabprod.Show;
    inc(countbreak,1);
    label2.Caption:='Breaks: '+inttostr(countbreak);

  end;
  end;

  if actualtime = 2 then begin
  if settimer=true then begin
       MS:=1000*600; // 10 minuti
       TS:=MSecsToTimeStamp(MS);
       DT:=TimeStampToDateTime(TS);

       settimer:=false;
  end;
  statusbar1.Panels[1].Text:='Fase: Break esteso';
  tabbreakl.Show;
  ltime2.Caption:=TimeToStr(DT);
  if ltime2.caption='00:00:00' then begin
    timermain.Enabled:=false;
    form_alertstopbreak.showmodal;
    timermain.Enabled:=true; // riattiva timer
    actualtime:=0; // produzione
    settimer:=true;
    tabprod.Show;
    inc(countbreakest,1);
    label3.Caption:='Breaks estesi: '+inttostr(countbreakest);

  end;
  end;


end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  beep;
  //  TS:=DateTimeToTimeStamp(Now);
  //Writeln ('Now in days since 1/1/0001      : ',TS.Date);
  //Writeln ('Now in millisecs since midnight : ',TS.Time);
  //MS:=TimeStampToMSecs(TS);
  //Writeln ('Now in millisecs since 1/1/0001 : ',MS);
  //MS:=1000*1500;
  //MS:=MS-1000*3600*2;
  //TS:=MSecsToTimeStamp(MS);
  //DT:=TimeStampToDateTime(TS);
  //Writeln ('Now minus 1 day : ',DateTimeToStr(DT));
//  ltime.Caption:=TimeToStr(DT);

  if timermain.Enabled=true then begin
  timermain.Enabled:=false;
  statusbar1.Panels[0].Text:='Timer non attivo';
//  statusbar1.Panels[1].Text:='';
  end
  else begin
    timermain.Enabled:=true;
    statusbar1.Panels[0].Text:='Timer attivo';
  end;


end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  MS:=1000*300; // 5 minuti
  TS:=MSecsToTimeStamp(MS);
  DT:=TimeStampToDateTime(TS);
  ltime1.Caption:=TimeToStr(DT);


  MS:=1000*600; // 10 minuti
  TS:=MSecsToTimeStamp(MS);
  DT:=TimeStampToDateTime(TS);
  ltime2.Caption:=TimeToStr(DT);

  MS:=1000*1500; // 25 minuti
  TS:=MSecsToTimeStamp(MS);
  DT:=TimeStampToDateTime(TS);
  ltime.Caption:=TimeToStr(DT);

  settimer:=true;

  actualtime:=0;
  countpomo:=0;
  countbreak:=0;
  countbreakest:=0;
  label1.Caption:='Pomodori: 0';
  label2.Caption:='Breaks: 0';
  label3.Caption:='Breaks estesi: 0';
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin

end;

procedure TForm1.Label9Click(Sender: TObject);
begin
       OpenURL('http://www.fasttools.it');
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin

end;

end.

