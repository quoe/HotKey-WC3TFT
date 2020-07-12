library _HotKey;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils, Windows, Messages,
  Classes;

{$R *.res}
function FS(A: boolean): boolean; stdcall; export;   //Full_Same
begin
  if  A then Result := TRUE
  else
  begin
    Result := FALSE;
  end;
end;

procedure SetKeyMessage(Handle: HWND; Key: DWORD); stdcall; export;
begin
  //PostMessage(Handle, WM_KEYDOWN, Key, 0);
  //SendMessage(Handle, WM_KEYDOWN, Key, 0);
  //SendMessage(Handle, WM_KEYUP, Key, 0);
  SendMessage(Handle, WM_KEYDOWN, Key,0);
  SendMessage(Handle, WM_CHAR, Key,0);
  SendMessage(Handle, WM_KEYUP, Key, 0 );
end;

procedure ReleaseKeys(Handle: HWND); stdcall; export;
begin
  //Освобождаем клавиши
  UnRegisterHotKey(Handle, ord('Q'));
  UnRegisterHotKey(Handle, ord('E'));
  UnRegisterHotKey(Handle, ord('W'));
  UnRegisterHotKey(Handle, ord(VK_SPACE));
  UnRegisterHotkey(Handle, 1 );
  UnRegisterHotkey(Handle, 2);
end;

Exports FS, SetKeyMessage, ReleaseKeys;
begin
end.
 