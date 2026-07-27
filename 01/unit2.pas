unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, windows, Forms, Controls, Graphics, Dialogs, StdCtrls, StrUtils,
  ComCtrls;

type
  TVarRec = record
    case Byte of
      vtInteger:    (VInteger: Integer; VType: Byte);
      vtBoolean:    (VBoolean: Boolean);
      vtChar:       (VChar: Char);
      vtExtended:   (VExtended: PExtended);
      vtString:     (VString: PShortString);
      vtPointer:    (VPointer: Pointer);
      vtPChar:      (VPChar: PChar);
      vtObject:     (VObject: TObject);
      vtClass:      (VClass: TClass);
      vtWideChar:   (VWideChar: WideChar);
      vtPWideChar:  (VPWideChar: PWideChar);
      vtAnsiString: (VAnsiString: Pointer);
      vtCurrency:   (VCurrency: PCurrency);
      vtVariant:    (VVariant: PVariant);
      vtInterface:  (VInterface: Pointer);
  end;

type
  P_TclassData = ^TclassData;
  TclassData = class
    Name_: string;
    Prefix: string;
    Str_: string;
    Int_: Integer;
    Suffix: string;
  end;

type
  P_TRecordData = ^TRecordData;
  TRecordData = record
    Name_: string;
    Prefix: string;
    Str_: string;
    Int_: Integer;
    Suffix: string;
  end;

procedure log2(LINENUM_: integer; message_: string);
function Message01(message_: string): TRecordData;
function Message02(out message_: TRecordData): TRecordData;
function Message03(var message_: TRecordData): TRecordData;
function Message04(const message_: string = 'Test'): TRecordData;
function Message05(message_: TRecordData): TRecordData;
function Format__(const Format_: string; const Args: array of const): string;
function SumAll (const Args: array of const): Extended;

function Min_(A,B: Integer): Integer; overload;
function Min_(A,B: Int64): Int64; overload;
function Min_(A,B: Single): Single; overload;
function Min_(A,B: Double): Double; overload;
function Min_(A,B: Extended): Extended; overload;

function ShowMsg(str_: string): String; overload;
function ShowMsg(FormatStr_: string; Params: array of const): String; overload;
function ShowMsg(I: Integer; str_: string): String; overload;

procedure MessageDlg (str: string); overload;

procedure MessBox (Msg: string; Caption: string = 'Warning'; Flags: LongInt = mb_OK or mb_IconHand);

function IsWindows64: boolean;

type
  TLogCallback = procedure();

type
  TLogCallback2 = procedure(const Msg: String);

  type
  TLogCallback3 = procedure(Sender: TObject) of object;

type
  TWorker = class
  public
    procedure OnComplete(Sender: TObject);
  end;

procedure DoWork(Callback: TLogCallback); overload;
procedure DoWork(Callback: TLogCallback2); overload;
Procedure Process01;
Procedure Process02(const Msg: String);

type
  Unit_ = class(TForm)
  private

  public
    procedure Button2Click(Sender: TObject);
  end;

var
  Memo_:TMemo;
  MyData: TRecordData;
  StartTime32, ElapsedTime32: LongInt;
  StartTime64, ElapsedTime64: Cardinal;
  FBuffer:TBitmap;
  theta:extended;
  String01:string;
  String02:string;
  String03:string;

implementation

procedure TWorker.OnComplete(Sender: TObject);
begin
  String03:= 'Callback triggered inside class instance!';
end;

Procedure Process01;
Begin
  String01:={$I %LINE%}+' Process01 -------------------------';
End;

Procedure Process02(const Msg: String);
Begin
  String02:={$I %LINE%}+' Process02: '+ Msg + ' -------------------------';
End;

procedure DoWork(Callback: TLogCallback); overload;
begin
  if Assigned(Callback) then
    Callback;//('Work completed successfully!');
end;

procedure DoWork(Callback: TLogCallback2); overload;
begin
  if Assigned(Callback) then
    Callback('Work completed successfully!');
end;

procedure log2(LINENUM_: integer; message_: string);
begin
  Memo_.Append(LINENUM_.ToString+message_);
end;

procedure Unit_.Button2Click(Sender: TObject);
begin

end;

function Message01(message_: string): TRecordData;
begin

  Result.Str_ := message_;

end;

function Message02(out message_: TRecordData): TRecordData;
begin
  message_.Str_:='#'+message_.Str_+'#';
  Result:= message_;

end;

function Message03(var message_: TRecordData): TRecordData;
begin
  message_.Str_:='!'+message_.Str_+'!';
  Result:= message_;

end;

function Message04(const message_: string = 'Test'): TRecordData;
begin

  Result.Str_ := message_;

end;

function Message05(message_: TRecordData): TRecordData;
begin
  message_.Str_:='??'+message_.Str_+'??';
  Result:= message_;

end;

function Format__(const Format_: string; const Args: array of const): string;
begin
  Result:= Format(Format_, Args);
end;

function SumAll (const Args: array of const): Extended;
var
  I: Integer;
begin
  Result := 0;
  for I := Low(Args) to High (Args) do
    case Args [I].VType of
      vtInteger: Result :=
        Result + Args [I].VInteger;
      vtBoolean:
        if Args [I].VBoolean then
          Result := Result + 1;
      vtChar:
        Result := Result + Ord (Args [I].VChar);
      vtExtended:
        Result := Result + Args [I].VExtended^;
      vtString, vtAnsiString:
        Result := Result + StrToIntDef ((Args [I].VString^), 0);
      vtWideChar:
        Result := Result + Ord (Args [I].VWideChar);
      vtCurrency:
        Result := Result + Args [I].VCurrency^;
    end; // case
end;

function Min_(A,B: Integer): Integer; overload;
begin
  if A <= B then
    Result:=A
  else
    Result:=b;
end;

function Min_(A,B: Int64): Int64; overload;
begin
  if A <= B then
    Result:=A
  else
    Result:=b;
end;

function Min_(A,B: Single): Single; overload;
begin
  if A <= B then
    Result:=A
  else
    Result:=b;
end;

function Min_(A,B: Double): Double; overload;
begin
  if A <= B then
    Result:=A
  else
    Result:=b;
end;

function Min_(A,B: Extended): Extended; overload;
begin
  if A <= B then
    Result:=A
  else
    Result:=b;
end;

function ShowMsg(str_: string): String; overload;
begin
  Result:=str_;
end;

function ShowMsg(FormatStr_: string; Params: array of const): String; overload;
begin
  Result:=Format(FormatStr_, Params);
end;

function ShowMsg(I: Integer; str_: string): String; overload;
begin
  Result:=IntToStr (I) + ' ' + str_;
end;

procedure MessageDlg(str: string); overload;
begin
  Dialogs.MessageDlg (str, mtInformation, [mbOK], 0);
end;

procedure MessBox (Msg: string; Caption: string = 'Warning'; Flags: LongInt = mb_OK or mb_IconHand);
begin
  Application.MessageBox (PChar (Msg),
    PChar (Caption), Flags);
end;

function IsWindows64: boolean;
{
Detect if we are running on 64 bit Windows or 32 bit Windows,
independently of bitness of this program.
Original source:
http://www.delphipraxis.net/118485-ermitteln-ob-32-bit-oder-64-bit-betriebssystem.html
modified for FreePascal in German Lazarus forum:
http://www.lazarusforum.de/viewtopic.php?f=55&t=5287
}
{$ifdef WIN32} //Modified KpjComp for 64bit compile mode
type
  TIsWow64Process = function( // Type of IsWow64Process API fn
      Handle: Windows.THandle; var Res: Windows.BOOL): Windows.BOOL; stdcall;
var
  IsWow64Result: Windows.BOOL; // Result from IsWow64Process
  IsWow64Process: TIsWow64Process; // IsWow64Process fn reference
begin
  // Try to load required function from kernel32
  IsWow64Process := TIsWow64Process(Windows.GetProcAddress(
    Windows.GetModuleHandle('kernel32'), 'IsWow64Process'));
  if Assigned(IsWow64Process) then
  begin
    // Function is implemented: call it
    if not IsWow64Process(Windows.GetCurrentProcess, IsWow64Result) then
      raise SysUtils.Exception.Create('IsWindows64: bad process handle');
    // Return result of function
    Result := IsWow64Result;
  end
  else
    // Function not implemented: can't be running on Wow64
    Result := False;
{$else} //if were running 64bit code, OS must be 64bit :)
begin
 Result := True;
{$endif}
end;

end.
