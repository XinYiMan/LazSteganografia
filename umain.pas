unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  usteganografia;

type

  { TForm1 }

  TForm1 = class(TForm)
    Btn_LoadFile: TButton;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    Txt_Message: TEdit;
    Txt_FileName: TEdit;
    procedure Btn_LoadFileClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
   app : TSteganografia;
begin
     app := TSteganografia.Create;
     if app.SaveTextIntoJpg(Self.Txt_Message.Text, Self.Txt_FileName.Text) then
        ShowMessage('Message added')
     else
         ShowMessage('Message added failed');
     app.Free;
     app := nil;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
   app : TSteganografia;
   msg : string;
begin
     app := TSteganografia.Create;
     if app.LoadTextFromJpg(msg, Self.Txt_FileName.Text) then
        Memo1.Text := msg
     else
         ShowMessage('Failed');
     app.Free;
     app := nil;
end;

procedure TForm1.Btn_LoadFileClick(Sender: TObject);
var
   ext_file : string;
begin
     Self.Txt_FileName.Clear;
     if Self.OpenDialog1.Execute then
     begin
          ext_file := LowerCase(ExtractFileExt(Self.OpenDialog1.FileName));
          if ((ext_file='.bmp')) then
             Self.Txt_FileName.Text:=Self.OpenDialog1.FileName;
     end;
end;

end.

