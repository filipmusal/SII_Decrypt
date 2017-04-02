{-------------------------------------------------------------------------------

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.

-------------------------------------------------------------------------------}
unit LibExport;

{$INCLUDE '..\Source\SII_Decrypt_defs.inc'}

interface

implementation

uses
  AuxTypes, Decryptor
{$IFDEF FPC_NonUnicode}
  , LazUTF8
{$ENDIF};

//==============================================================================

Function Exp_IsEncryptedMemory(Mem: Pointer; Size: TMemSize): UInt32; stdcall;
begin
with TSIIDecryptor.Create do
try
  Result := Ord(IsEncryptedMemory(Mem,Size));
finally
  Free;
end;
end;

//------------------------------------------------------------------------------

Function Exp_IsEncryptedFile(FileName: PAnsiChar): UInt32; stdcall;
begin
with TSIIDecryptor.Create do
try
{$IFDEF FPC_NonUnicode}
  Result := Ord(IsEncryptedFile(WinCPToUTF8(FileName)));
{$ELSE}
  Result := Ord(IsEncryptedFile(FileName));
{$ENDIF}
finally
  Free;
end;
end;

//------------------------------------------------------------------------------

Function Exp_DecryptMemory(Input: Pointer; InSize: TMemSize; Output: Pointer; OutSize: PMemSize): UInt32; stdcall;
begin
with TSIIDecryptor.Create do
try
  Result := Ord(DecryptMemory(Input,InSize,Output,OutSize^));
finally
  Free;
end;
end;


//------------------------------------------------------------------------------

Function Exp_DecryptFile(InputFile: PAnsiChar; OutputFile: PAnsiChar): UInt32; stdcall;
begin
with TSIIDecryptor.Create do
try
{$IFDEF FPC_NonUnicode}
  Result := Ord(DecryptFile(WinCPToUTF8(InputFile),WinCPToUTF8(OutputFile)));
{$ELSE}
  Result := Ord(DecryptFile(InputFile,OutputFile));
{$ENDIF}
finally
  Free;
end;
end;

//------------------------------------------------------------------------------

Function Exp_DecryptFile2(FileName: PAnsiChar): UInt32; stdcall;
begin
with TSIIDecryptor.Create do
try
{$IFDEF FPC_NonUnicode}
  Result := Ord(DecryptFile(WinCPToUTF8(FileName),WinCPToUTF8(FileName)));
{$ELSE}
  Result := Ord(DecryptFile(FileName,FileName));
{$ENDIF}
finally
  Free;
end;
end;

//==============================================================================

exports
  Exp_IsEncryptedMemory name 'IsEncryptedMemory',
  Exp_IsEncryptedFile   name 'IsEncryptedFile',
  Exp_DecryptMemory     name 'DecryptMemory',
  Exp_DecryptFile       name 'DecryptFile',
  Exp_DecryptFile2      name 'DecryptFile2';

end.
