unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    PaintBox1: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public
    constructor Create(TheOwner: TComponent); override;
    procedure OnIdle(Sender: TObject; var Done: boolean);
    procedure OnIdleEnd(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  MessageDlg('Hello');
  MessBox('Hello');
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FBuffer.Free;
end;

{ TForm1 }
constructor TForm1.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);

  FBuffer := TBitmap.Create;
  FBuffer.SetSize(PaintBox1.Width, PaintBox1.Height);
  //FBuffer.Canvas.Brush.Color := clSilver;
  FBuffer.Canvas.Brush.Color := $00C8D0D4;
  FBuffer.Canvas.FillRect(0, 0, FBuffer.Width, FBuffer.Height);

  theta:=0;

  Application.OnIdle := @OnIdle;
  Application.OnIdleEnd:=@OnIdleEnd;

end;

procedure TForm1.OnIdle(Sender: TObject; var Done: boolean);
var
  Origin: TPoint = (X:150; y:150);
  P1: TPoint = (X: 0; y:0);
  P2: TPoint = (X: 60; y:0);
  P3: TPoint= (X:60; y:60);
  IsWindows:boolean = false;
  IsCompiler32:boolean = false;
  IsCompiler64:boolean = false;
  x:integer;
  y:integer;
  TLog:TLogCallback2;
  Worker: TWorker;
  Callback: TLogCallback3;
begin
  {$IFDEF WIN32}
    ElapsedTime32 := GetTickCount-StartTime32;
    StartTime32 := GetTickCount;
  {$ENDIF}

  {$IFDEF WIN64}
    ElapsedTime64 := GetTickCount64 - StartTime64;
    StartTime64 := GetTickCount64;
  {$ENDIF}

  {$IFDEF MSWINDOWS}
    IsWindows:=true;
  {$ENDIF}

  if SizeOf(Pointer) = 4 then IsCompiler32:=true; // 32-bit environment.
  if SizeOf(Pointer) = 8 then IsCompiler64:=true; // 64-bit environment.

  FBuffer.Canvas.Clear;

  {$IFDEF WIN32}
    FBuffer.Canvas.TextOut(0,0,'ElapsedTime32: '+ElapsedTime32.ToString);
  {$ENDIF}

  {$IFDEF WIN64}
    FBuffer.Canvas.TextOut(0,20,'ElapsedTime64: '+ElapsedTime64.ToString);
  {$ENDIF}

  MyData:=Message01('Test');
  FBuffer.Canvas.TextOut(0,40,'Message01: '+MyData.Str_);
  Message02(MyData);
  FBuffer.Canvas.TextOut(0,60,'Message02: '+MyData.Str_);
  Message03(MyData);
  FBuffer.Canvas.TextOut(0,80,'Message03: '+MyData.Str_);
  MyData:=Message04();
  FBuffer.Canvas.TextOut(0,100,'Message04: '+MyData.Str_);
  Message05(MyData);
  FBuffer.Canvas.TextOut(0,120,'Message05: '+MyData.Str_);
  MyData:=Message05(MyData);
  FBuffer.Canvas.TextOut(0,140,'Message05: '+MyData.Str_);
  MyData.Str_:=Format__('Str: %s, Int: %d, Float: %f', ['Test', 456, 12.4]);
  FBuffer.Canvas.TextOut(0,160,'Format: '+MyData.Str_);
  MyData.Str_:=SumAll ([10 * 10, 'k', True, 10.34, '99999']).ToString;
  FBuffer.Canvas.TextOut(0,180,'SumAll: '+MyData.Str_);
  MyData.Str_:=min_(3.141597,Byte(4)).ToString;
  FBuffer.Canvas.TextOut(0,200,'min: '+MyData.Str_);
  MyData.Str_:=ShowMsg(123,'ABC');
  FBuffer.Canvas.TextOut(0,220,'ShowMsg: '+MyData.Str_);
  FBuffer.Canvas.TextOut(0,240,'IsWindows: '+IsWindows.ToInteger.ToString);
  FBuffer.Canvas.TextOut(0,260,'Compiler 32bit: '+IsCompiler32.ToInteger.ToString);
  FBuffer.Canvas.TextOut(0,280,'Compiler 64bit: '+IsCompiler64.ToInteger.ToString);
  FBuffer.Canvas.TextOut(0,300,'Windows 64bit: '+IsWindows64.ToInteger.ToString);

  FBuffer.Canvas.Pen.Width:=3;
  FBuffer.Canvas.Pen.Color:=clBlue;
  //FBuffer.Canvas.MoveTo(Origin);

  x:= Round((P1.x*cos(theta)) - (P1.y*sin(theta)));
  y:= Round((P1.x*sin(theta)) + (P1.y*cos(theta)));
  P1.X:=x; P1.Y:=y;
  P1:=P1+Origin;
  FBuffer.Canvas.MoveTo(P1);

  x:= Round((P2.x*cos(theta)) - (P2.y*sin(theta)));
  y:= Round((P2.x*sin(theta)) + (P2.y*cos(theta)));
  P2.X:=x; P2.Y:=y;
  P2:=P2+Origin;
  FBuffer.Canvas.LineTo(P2);

  x:= Round((P3.x*cos(theta)) - (P3.y*sin(theta)));
  y:= Round((P3.x*sin(theta)) + (P3.y*cos(theta)));
  P3.X:=x; P3.Y:=y;
  P3:=P3+Origin;
  FBuffer.Canvas.LineTo(P3);

  FBuffer.Canvas.LineTo(P1);

  String01:='';
  DoWork(@Process01);
  MyData:=Message01('Test');
  FBuffer.Canvas.TextOut(150,40,'String01: '+String01);

  String02:='';
  DoWork(@Process02);
  FBuffer.Canvas.TextOut(150,60,'String02: '+String02);

  String02:='';
  TLog:=@Process02;
  TLog('Hello');
  FBuffer.Canvas.TextOut(150,80,'String02: '+String02);

  String03:='';
  Worker := TWorker.Create;
  Callback := @Worker.OnComplete;
  Callback(Worker);
  Worker.Free;
  FBuffer.Canvas.TextOut(150,100,'String03: '+String03);

  PaintBox1.Canvas.Draw(0, 0, FBuffer);

  //Application.OnIdle := nil;


  theta:=theta+0.002;
  Done := false;
end;

procedure TForm1.OnIdleEnd(Sender: TObject);
begin
  // OnIdleEnd run when OnIdle  Done := true;
end;

end.

