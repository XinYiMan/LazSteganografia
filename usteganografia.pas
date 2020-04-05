unit usteganografia;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, BGRABitmap, BGRABitmapTypes;

type

    { TSteganografia }

    TSteganografia = class

    private

    public

          constructor Create;
          destructor Free;
          function SaveTextIntoBMP(Text : string; FileName : string) : boolean;
          function LoadTextFromBMP(var Text: string; FileName: string): boolean;
    end;

implementation

  { TSteganografia }

  constructor TSteganografia.Create;
  begin

  end;

  destructor TSteganografia.Free;
  begin

  end;

  function TSteganografia.SaveTextIntoBMP(Text: string; FileName: string
      ): boolean;
  var
     ret      : boolean;
     scanline : PBGRAPixel;
     y        : Integer;
     x        : Integer;
     MyImg    : TBGRABitmap;
     i        : integer;
     len      : integer;
  begin
       ret := false;

       len := Length(Text);

       if (FileExists(FileName) and (len>0)) then
       begin

            text := IntToStr(len) + ' ' + text;
            len := Length(Text);

            MyImg := TBGRABitmap.Create;
            MyImg.LoadFromFile(FileName);
            i := 1;

            for y := 0 to MyImg.Height - 1 do
            begin
              scanline := MyImg.ScanLine[y];
              for x := 0 to MyImg.Width - 1 do
              begin
                with scanline^ do
                begin

                     if i<=len then
                     begin
                          alpha := Ord(text[i]);
                          Inc(i);
                     end;

                end;
                inc(scanline);
              end;
            end;

            MyImg.InvalidateBitmap;

            DeleteFile(FileName);
            MyImg.SaveToFile(FileName);

            MyImg.Free;
            MyImg := nil;

            ret := true;
       end;

       result := ret;
  end;

  function TSteganografia.LoadTextFromBMP(var Text: string; FileName: string
    ): boolean;
  var
     ret      : boolean;
     scanline : PBGRAPixel;
     y        : Integer;
     x        : Integer;
     MyImg    : TBGRABitmap;
     len      : integer;
     len_str  : string;
  begin
       ret := false;

       if FileExists(FileName) then
       begin

            text    := '';
            len     := -1;
            len_str := '';

            MyImg := TBGRABitmap.Create;
            MyImg.LoadFromFile(FileName);

            for y := 0 to MyImg.Height - 1 do
            begin
              scanline := MyImg.ScanLine[y];
              for x := 0 to MyImg.Width - 1 do
              begin
                with scanline^ do
                begin

                     if len>0 then
                     begin
                          text := text + Chr(alpha);
                          Dec(len);
                     end;

                     if len = -1 then
                     begin
                          if Chr(alpha) = ' ' then
                          begin

                               len := STrToIntDef(len_str,-2);

                          end else begin

                            len_str := len_str + Chr(alpha);

                          end;
                     end;
                end;
                inc(scanline);
              end;
            end;

            MyImg.Free;
            MyImg := nil;

            ret := true;
       end;

       result := ret;
  end;

end.

