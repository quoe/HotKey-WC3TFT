unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, IniFiles, XPMan, registry, ComCtrls, ShellApi,
  Menus, ImgList;

type
  TForm1 = class(TForm)
    Label3: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label7: TLabel;
    Label8: TLabel;
    CheckBox3: TCheckBox;
    Label9: TLabel;
    CheckBox4: TCheckBox;
    XPManifest1: TXPManifest;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox4: TGroupBox;
    CheckBox5: TCheckBox;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    N11: TMenuItem;
    N21: TMenuItem;
    Num7Q1: TMenuItem;
    Num7W1: TMenuItem;
    Num7E1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    SPACE1: TMenuItem;
    CheckBox6: TCheckBox;
    ImageList1: TImageList;
    Button1: TButton;
    CheckBox7: TCheckBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Label2: TLabel;
    Image1: TImage;
    Label1: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N21Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure Num7Q1Click(Sender: TObject);
    procedure Num7W1Click(Sender: TObject);
    procedure Num7E1Click(Sender: TObject);
    procedure SPACE1Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY;
    procedure OnMinimize(var Msg: TWMSysCommand); message WM_SysCommand;
  public
    procedure IconCallBackMessage( var Mess : TMessage ); message WM_USER + 100;
  end;

var
  Form1: TForm1;
  work, Stop, MenuStop, Write: boolean;
  IniFile: TIniFile;
  //OmgCount: integer;
  WC3: HWND;
implementation
function FS(A: boolean): boolean; stdcall; external '_HotKey.dll';
procedure SetKeyMessage(Handle: HWND; Key: DWORD); stdcall; external '_HotKey.dll';
procedure ReleaseKeys(Handle: HWND); stdcall; external '_HotKey.dll';

{$R *.dfm}
{function FS(A: boolean): boolean;  //Full_Same
begin
  if  A then Result := TRUE
  else
  begin
    Result := FALSE;
  end;
end;}

//���� �������� ����� ���� �� ������� �� ���������� ������� � ����� ����  Warcraft III
{procedure SetKeyMessage(Handle: HWND; Key: DWORD);
begin
  //PostMessage(Handle, WM_KEYDOWN, Key, 0);
  //SendMessage(Handle, WM_KEYDOWN, Key, 0);
  //SendMessage(Handle, WM_KEYUP, Key, 0);
  SendMessage(Handle, WM_KEYDOWN, Key,0);
  SendMessage(Handle, WM_CHAR, Key,0);
  SendMessage(Handle, WM_KEYUP, Key, 0 );
end;}

procedure TForm1.FormDestroy(Sender: TObject);
begin
ReleaseKeys(Handle);
  //����������� �������
  {UnRegisterHotKey(handle, ord('Q'));
  UnRegisterHotKey(handle, ord('E'));
  UnRegisterHotKey(handle, ord('W'));
  UnRegisterHotKey(handle, ord(VK_SPACE));
  UnRegisterHotkey( Handle, 1 );
  UnRegisterHotkey(Handle, 2);}
end;

//����� ������� ������ � ��������� ������� ������ ������.
procedure TForm1.WMHotKey(var Msg: TWMHotKey);
begin
  WC3 := FindWindow(nil, 'Warcraft III');
  if WC3 = 0 then
  begin
    {CheckBox1.Enabled := FALSE;
    CheckBox2.Enabled := FALSE;
    CheckBox3.Enabled := FALSE;
    CheckBox4.Enabled := FALSE;
    PopupMenu1.Items[3].Enabled := FALSE;
    PopupMenu1.Items[4].Enabled := FALSE;
    PopupMenu1.Items[5].Enabled := FALSE;
    PopupMenu1.Items[6].Enabled := FALSE; }
    StatusBar1.Panels[0].Text := '���� Warcraft III �� �������...';
    StatusBar1.Panels[1].Text := '�� �������';
    work := FALSE;
    UnRegisterHotKey(handle, ord('Q'));
    UnRegisterHotKey(handle, ord('E'));
    UnRegisterHotKey(handle, ord('W'));
    UnRegisterHotKey(handle, ord(VK_SPACE));
    UnRegisterHotkey(Handle, 2);
    //exit;
  end
  else
  begin
    CheckBox1.Enabled := TRUE;
    CheckBox2.Enabled := TRUE;
    CheckBox3.Enabled := TRUE;
    CheckBox4.Enabled := TRUE;
    PopupMenu1.Items[3].Enabled := TRUE;
    PopupMenu1.Items[4].Enabled := TRUE;
    PopupMenu1.Items[5].Enabled := TRUE;
    PopupMenu1.Items[6].Enabled := TRUE;
    StatusBar1.Panels[0].Text := '���� Warcraft III �������!';
    StatusBar1.Panels[1].Text := '�������';
  if (msg.hotkey = 2) and CheckBox7.Checked and work then
  begin
    work := FALSE;
    Stop := TRUE;
    SetKeyMessage(WC3, VK_RETURN);
    UnRegisterHotKey(handle, ord('Q'));
    UnRegisterHotKey(handle, ord('E'));
    UnRegisterHotKey(handle, ord('W'));
    UnRegisterHotKey(handle, ord(VK_SPACE));
    UnRegisterHotKey(handle, ord(VK_RETURN));
    StatusBar1.Panels[1].Text := '�� �������';
    PopupMenu1.Items[1].Caption := '�����������';
    MenuStop := TRUE;
    exit;
  end
  else
  if (msg.hotkey = 2) and CheckBox7.Checked and not work then
  begin
    SetKeyMessage(WC3, VK_RETURN);
    if  CheckBox1.Checked then RegisterHotKey(handle, ord('W'), 0, ord('W'))
    else UnRegisterHotKey(handle, ord('W'));

    if CheckBox2.Checked then RegisterHotKey(handle, ord(VK_SPACE), 0, ord(VK_SPACE))
    else UnRegisterHotKey(handle, ord(VK_SPACE));

    if  CheckBox3.Checked then RegisterHotKey(handle, ord('E'), 0, ord('E'))
    else UnRegisterHotKey(handle, ord('E'));

    if CheckBox4.Checked then RegisterHotKey(handle, ord('Q'), 0, ord('Q'))
    else UnRegisterHotKey(handle, ord('Q'));

    if CheckBox7.Checked then RegisterHotkey(Handle, 2, 0, VK_RETURN)
    else UnRegisterHotkey(Handle, 2);

    //RegisterHotkey(Handle, 2, 0, VK_RETURN);
    work := TRUE;
    Stop := FALSE;
    MenuStop := FALSE;
    StatusBar1.Panels[1].Text := '�������';
    PopupMenu1.Items[1].Caption := '����������';
  end;
  //if msg.hotkey = 2 then msg.hotkey := 1;
  if MenuStop then msg.hotkey := 1;
  //���� ������ ��� ������� � ��������� ��������
  if (msg.hotkey = 1) and work then
  begin
    UnRegisterHotKey(handle, ord('Q'));
    UnRegisterHotKey(handle, ord('E'));
    UnRegisterHotKey(handle, ord('W'));
    UnRegisterHotKey(handle, ord(VK_SPACE));
    work := FALSE;
    Stop := TRUE;
    StatusBar1.Panels[1].Text := '�� �������';
    PopupMenu1.Items[1].Caption := '�����������';
    MenuStop := TRUE;
  end
  else
  if (msg.hotkey = 1) and not work then
  begin
    if  CheckBox1.Checked then RegisterHotKey(handle, ord('W'), 0, ord('W'))
    else UnRegisterHotKey(handle, ord('W'));

    if CheckBox2.Checked then RegisterHotKey(handle, ord(VK_SPACE), 0, ord(VK_SPACE))
    else UnRegisterHotKey(handle, ord(VK_SPACE));

    if  CheckBox3.Checked then RegisterHotKey(handle, ord('E'), 0, ord('E'))
    else UnRegisterHotKey(handle, ord('E'));

    if CheckBox4.Checked then RegisterHotKey(handle, ord('Q'), 0, ord('Q'))
    else UnRegisterHotKey(handle, ord('Q'));
    
    if CheckBox7.Checked then RegisterHotkey(Handle, 2, 0, VK_RETURN)
    else UnRegisterHotkey(Handle, 2);
    
    work := TRUE;
    Stop := FALSE;
    MenuStop := FALSE;
    StatusBar1.Panels[1].Text := '�������';
    PopupMenu1.Items[1].Caption := '����������';
  end;
  if not MenuStop and not work then
  begin
    if  CheckBox1.Checked then RegisterHotKey(handle, ord('W'), 0, ord('W'))
    else UnRegisterHotKey(handle, ord('W'));

    if CheckBox2.Checked then RegisterHotKey(handle, ord(VK_SPACE), 0, ord(VK_SPACE))
    else UnRegisterHotKey(handle, ord(VK_SPACE));

    if  CheckBox3.Checked then RegisterHotKey(handle, ord('E'), 0, ord('E'))
    else UnRegisterHotKey(handle, ord('E'));

    if CheckBox4.Checked then RegisterHotKey(handle, ord('Q'), 0, ord('Q'))
    else UnRegisterHotKey(handle, ord('Q'));
    work := TRUE;
    Stop := FALSE;
    MenuStop := FALSE;
    StatusBar1.Panels[1].Text := '�������';
    PopupMenu1.Items[1].Caption := '����������';
  end;                                      
  Case Msg.HotKey  of     //WC3
    ord('Q'): SetKeyMessage(WC3, VK_NUMPAD7); //��� ���� ������ ���� ���� �������� �� SetKeyMessage(������ ����, Ord(J));   SetKey(Ord(103));
    ord('E'): SetKeyMessage(WC3, VK_NUMPAD1);  //Ord(97))
    ord('W'): SetKeyMessage(WC3, VK_NUMPAD4);   //Ord(100));
    ord(VK_SPACE): SetKeyMessage(WC3, Ord(95));  //Ord(109)
  end;
 end;
end;


procedure TForm1.FormCreate(Sender: TObject);
var nid : TNotifyIconData;
begin
  label2.Caption := '��������� ������ ������ "' + Form1.Caption + '"' +   //' + #13#10 + '
               #13#10 + '��������� ����� � 2012 ������� �. �.' + #13#10 +
              '�������, ����������� ���� ��������.' + #13#10 +
              '����� �������, �������, ����������� - ' + #13#10 +
              '� �������� ������� �� ������ quoe@mail.ru';
  IniFile:=TIniFile.Create(ExtractFilePath(Application.ExeName)+ 'HotIni.ini');

  if (IniFile.ReadBool('INI info','Min', TRUE) = TRUE) then CheckBox6.Checked := True
  else CheckBox6.Checked:=False;

  if (IniFile.ReadInteger('INI info','num7', ord('Q')) = ord('Q')) then CheckBox4.Checked := True
  else CheckBox4.Checked:=False;

  if (IniFile.ReadInteger('INI info','num4', ord('W')) = ord('W')) then CheckBox1.Checked := True
  else CheckBox1.Checked := False;

  if (IniFile.ReadInteger('INI info','num1', ord('E')) = ord('E')) then CheckBox3.Checked := True
  else CheckBox3.Checked := False;

  if (IniFile.ReadInteger('INI info','Space', 1) = 1) then CheckBox2.Checked := True
  else CheckBox2.Checked := False;

  if (IniFile.ReadInteger('INI info','Chat', 1) = 1) then CheckBox7.Checked := True
  else CheckBox7.Checked := False;

  if (IniFile.ReadBool('INI info', 'AL', TRUE) = TRUE) then CheckBox5.Checked := True
  else CheckBox5.Checked := False;

  PopupMenu1.Items[3].Checked := FS(CheckBox4.Checked);
  PopupMenu1.Items[4].Checked := FS(CheckBox1.Checked);
  PopupMenu1.Items[5].Checked := FS(CheckBox3.Checked);
  PopupMenu1.Items[6].Checked := FS(CheckBox2.Checked);

  MenuStop := FALSE;
  Write := FALSE;

  WC3 := FindWindow(nil, 'Warcraft III');
  if WC3 = 0 then
  begin
    {CheckBox1.Enabled := FALSE;     
    CheckBox2.Enabled := FALSE;
    CheckBox3.Enabled := FALSE;
    CheckBox4.Enabled := FALSE;
    PopupMenu1.Items[3].Enabled := FALSE;
    PopupMenu1.Items[4].Enabled := FALSE;
    PopupMenu1.Items[5].Enabled := FALSE;
    PopupMenu1.Items[6].Enabled := FALSE;}
    StatusBar1.Panels[0].Text := '���� Warcraft III �� �������...';
    StatusBar1.Panels[1].Text := '�� �������';
    work := FALSE;
  end
  else
  begin
    {CheckBox1.Enabled := TRUE;
    CheckBox2.Enabled := TRUE;
    CheckBox3.Enabled := TRUE;
    CheckBox4.Enabled := TRUE;
    PopupMenu1.Items[3].Enabled := TRUE;
    PopupMenu1.Items[4].Enabled := TRUE;
    PopupMenu1.Items[5].Enabled := TRUE;
    PopupMenu1.Items[6].Enabled := TRUE;}
    
    work := TRUE;
    StatusBar1.Panels[0].Text := '���� Warcraft III �������!';
    StatusBar1.Panels[1].Text := '�������';

    if  CheckBox1.Checked then RegisterHotKey(handle, ord('W'), 0, ord('W'))
    else UnRegisterHotKey(handle, ord('W'));

    if CheckBox2.Checked then RegisterHotKey(handle, ord(VK_SPACE), 0, ord(VK_SPACE))
    else UnRegisterHotKey(handle, ord(VK_SPACE));

    if  CheckBox3.Checked then RegisterHotKey(handle, ord('E'), 0, ord('E'))
    else UnRegisterHotKey(handle, ord('E'));

    if CheckBox4.Checked then RegisterHotKey(handle, ord('Q'), 0, ord('Q'))
    else UnRegisterHotKey(handle, ord('Q'));

    if not RegisterHotkey(Handle, 1, MOD_SHIFT, ord('S')) then
    //MOD_CONTROL or MOD_ALT, ord('S')
    ShowMessage('�� ���� ��������� ������� ������� Shift+S!' + #13 + '��������, �� �������� �� ��� ����������.');

    if CheckBox7.Checked then RegisterHotkey(Handle, 2, 0, VK_RETURN)
    else UnRegisterHotKey(handle, 2);
  //��������� ������ � ���� ��� ������ ���������:
  end;
  with nid do  //��������� ��������� ������, ��� ���� ���������� ���������
               //TNotifyIconData.
  begin
    cbSize := SizeOf( TNotifyIconData ); //������ ��� ���������
    Wnd := Form1.Handle; //����� �� ��������� Handle ����� ������� �����
                         //������� ����� �������� ��������� �� ������.
    uID := 1;            //������������� ������
    uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP; //���������� ��, ��� �
                                                  //��������� ������:
                                                  //������, ��������� � �����
                                                  //��������� (�����).
    uCallbackMessage := WM_USER + 100;            //����� �� ���������, �����
                                                  //��������� ������  ��������
                                                  //�������� ����� ������� �����,
                                                  //� ��� ������, ����� �� ���
                                                  //(������)  ����������
                                                  //�����-���� �������
    hIcon := Application.Icon.Handle;             //��������� �� Handle
                                                  //������ (�����������)
                                                  //(� ������ ������ �����
                                                  //������ �������� �����
                                                  //����������. ���� �� �������
                                                  //��� ����� �� ��������)
    StrPCopy(szTip, Form1.Caption);                //��������� ����� �����������
                                                  //���������, ������� ����� ��
                                                  //���������� ToolTip,
                                                  //�������������� �� �������
                                                  //�����.
  end;
  Shell_NotifyIcon( NIM_ADD, @nid );
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  //���� ��������� ��������
  if work then
  begin
    if  CheckBox4.Checked then
    begin
      //����������� �������
      RegisterHotKey(handle, ord('Q'), 0, ord('Q'));
      IniFile.WriteInteger('INI info', 'num7', ord('Q'));
    end
    else
    begin
      UnRegisterHotKey(handle, ord('Q'));
      IniFile.WriteInteger('INI info','num7', 0);
    end;
  end
  else
    if  CheckBox4.Checked then
    begin
      //����������� �������
      IniFile.WriteInteger('INI info', 'num7', ord('Q'));
    end
    else
    begin
      IniFile.WriteInteger('INI info','num7', 0);
    end;
  PopupMenu1.Items[3].Checked := FS(CheckBox4.Checked);
  PopupMenu1.Items[4].Checked := FS(CheckBox1.Checked);
  PopupMenu1.Items[5].Checked := FS(CheckBox3.Checked);
  PopupMenu1.Items[6].Checked := FS(CheckBox2.Checked);
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  //���� ��������� ��������
  if work then
  begin
    if  CheckBox3.Checked then
    begin
      //����������� �������
      RegisterHotKey(handle, ord('E'), 0, ord('E'));
      IniFile.WriteInteger('INI info','num1',ord('E'));
    end
    else
    begin
      UnRegisterHotKey(handle, ord('E'));
      IniFile.WriteInteger('INI info','num1',0);
    end;
  end
  else
    if  CheckBox3.Checked then
    begin
      //����������� �������
      IniFile.WriteInteger('INI info','num1',ord('E'));
    end
    else
    begin
      IniFile.WriteInteger('INI info','num1',0);
    end;
  PopupMenu1.Items[3].Checked := FS(CheckBox4.Checked);
  PopupMenu1.Items[4].Checked := FS(CheckBox1.Checked);
  PopupMenu1.Items[5].Checked := FS(CheckBox3.Checked);
  PopupMenu1.Items[6].Checked := FS(CheckBox2.Checked);
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  //���� ��������� ��������
  if work then
  begin
    if  CheckBox1.Checked then
    begin
      //����������� �������
      RegisterHotKey(handle, ord('W'), 0, ord('W'));
      IniFile.WriteInteger('INI info','num4', ord('W'));
    end
    else
    begin
      UnRegisterHotKey(handle, ord('W'));
      IniFile.WriteInteger('INI info','num4', 0);
    end;
  end
  else
    if  CheckBox1.Checked then
    begin
      //����������� �������
      IniFile.WriteInteger('INI info','num4', ord('W'));
    end
    else
    begin
      IniFile.WriteInteger('INI info','num4', 0);
    end;
  PopupMenu1.Items[3].Checked := FS(CheckBox4.Checked);
  PopupMenu1.Items[4].Checked := FS(CheckBox1.Checked);
  PopupMenu1.Items[5].Checked := FS(CheckBox3.Checked);
  PopupMenu1.Items[6].Checked := FS(CheckBox2.Checked);
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  //���� ��������� ��������
  if work then
  begin
    if  CheckBox2.Checked then
    begin
      //����������� �������
      RegisterHotKey(handle, ord(VK_SPACE), 0, ord(VK_SPACE));
      IniFile.WriteInteger('INI info', 'Space', 1);
    end
    else
    begin
      UnRegisterHotkey(Handle, 2);
      IniFile.WriteInteger('INI info', 'Space', 0);
    end;
  end
  else
    if  CheckBox2.Checked then
    begin
      //����������� �������
      IniFile.WriteInteger('INI info', 'Space', 1);
    end
    else
    begin
      IniFile.WriteInteger('INI info', 'Space', 0);
    end;
  PopupMenu1.Items[3].Checked := FS(CheckBox4.Checked);
  PopupMenu1.Items[4].Checked := FS(CheckBox1.Checked);
  PopupMenu1.Items[5].Checked := FS(CheckBox3.Checked);
  PopupMenu1.Items[6].Checked := FS(CheckBox2.Checked);
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
var Reg: TRegistry;
begin
  if CheckBox5.Checked then
  begin
    IniFile.WriteBool('INI info', 'AL', TRUE);
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', false);
    Reg.WriteString('HOTKEY', Application.ExeName);
    Reg.Free;
  end
  else
  begin
    IniFile.WriteBool('INI info', 'AL', FALSE);
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run',false);
    Reg.DeleteValue('HOTKEY');
    Reg.Free;
  end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
var I   : TIcon;
    nid : TNotifyIconData;
    Pos: TPoint;                 // ������� �������
begin
  WC3 := FindWindow(nil, 'Warcraft III');
  GetCursorPos(Pos);
  if (WC3 = 0) or (WindowFromPoint(Pos) <> WC3) then
  begin
    {CheckBox1.Enabled := FALSE;
    CheckBox2.Enabled := FALSE;
    CheckBox3.Enabled := FALSE;
    CheckBox4.Enabled := FALSE;
    PopupMenu1.Items[3].Enabled := FALSE;
    PopupMenu1.Items[4].Enabled := FALSE;
    PopupMenu1.Items[5].Enabled := FALSE;
    PopupMenu1.Items[6].Enabled := FALSE;}
    StatusBar1.Panels[0].Text := '���� Warcraft III �� �������...';
    StatusBar1.Panels[1].Text := '�� �������';
    work := FALSE;
    ReleaseKeys(Handle);
    {UnRegisterHotKey(handle, ord('Q'));
    UnRegisterHotKey(handle, ord('E'));
    UnRegisterHotKey(handle, ord('W'));
    UnRegisterHotKey(handle, ord(VK_SPACE));
    UnRegisterHotkey(Handle, 1);
    UnRegisterHotkey(Handle, 2);}
  //����� �� ����� ������ ����������, ��� ���� ���������� ���������� ����
  //(��� ������ �����, ������� �������� ����������� ������)
  //����, ��� ����������:
    I := TIcon.Create; //������� ������ I ���� TIcon
    Imagelist1.GetIcon(1, I); //������ ��������� � ���� ����������� I.LoadFromFile(FullIcoFilePathBW)
                                          //�� ���� �����, ������� ��� ������ �
                                          //���� ����������� ����
    //����� ������ ��� ���� �����, ��� � ������, ������� ��������� ����
    //TNotifyIconData ���� ������� ��� ��������� ������:)
    with nid do
    begin
      cbSize := SizeOf( TNotifyIconData );
      Wnd := Form1.Handle;
      uID := 1;
      uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
      uCallbackMessage := WM_USER + 100;
      hIcon := I.Handle;
      StrPCopy(szTip, Form1.Caption);
    end;
    Shell_NotifyIcon( NIM_MODIFY , @nid );
    //� ��� ����� �� ������� ��������� � ������, ������� ��������� � ���������
    //���� �������� ��������, ��� ����� �� ��������� ��������� NIM_MODIFY
    //(��������� ������).
    //Icon.Picture.Icon := I;
    I.Free;
  end
  else
  if not Stop or not MenuStop then
  begin
    {CheckBox1.Enabled := TRUE;
    CheckBox2.Enabled := TRUE;
    CheckBox3.Enabled := TRUE;
    CheckBox4.Enabled := TRUE;
    PopupMenu1.Items[3].Enabled := TRUE;
    PopupMenu1.Items[4].Enabled := TRUE;
    PopupMenu1.Items[5].Enabled := TRUE;
    PopupMenu1.Items[6].Enabled := TRUE;}
    StatusBar1.Panels[0].Text := '���� Warcraft III �������!';
    StatusBar1.Panels[1].Text := '�������';
    if  CheckBox1.Checked then RegisterHotKey(handle, ord('W'), 0, ord('W'))
    else UnRegisterHotKey(handle, ord('W'));

    if CheckBox2.Checked then RegisterHotKey(handle, ord(VK_SPACE), 0, ord(VK_SPACE))
    else UnRegisterHotKey(handle, ord(VK_SPACE));

    if  CheckBox3.Checked then RegisterHotKey(handle, ord('E'), 0, ord('E'))
    else UnRegisterHotKey(handle, ord('E'));

    if CheckBox4.Checked then RegisterHotKey(handle, ord('Q'), 0, ord('Q'))
    else UnRegisterHotKey(handle, ord('Q'));

    RegisterHotkey(Handle, 1, MOD_SHIFT, ord('S'));
    //MOD_CONTROL or MOD_ALT, ord('S')
    //ShowMessage('�� ���� ��������� ������� ������� Shift+S!' + #13 + '��������, �� �������� �� ��� ����������.');

    work := TRUE;                                 
    Stop := FALSE;
    StatusBar1.Panels[1].Text := '�������';

    I := TIcon.Create;
    Imagelist1.GetIcon(0, I);
    with nid do
    begin
      cbSize := SizeOf( TNotifyIconData );
      Wnd := Form1.Handle;
      uID := 1;
      uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
      uCallbackMessage := WM_USER + 100;
      hIcon := I.Handle;
      StrPCopy(szTip, Form1.Caption);
    end;
    Shell_NotifyIcon( NIM_MODIFY , @nid );
    //� ��� ����� �� ������� ��������� � ������, ������� ��������� � ���������
    //���� �������� ��������, ��� ����� �� ��������� ��������� NIM_MODIFY
    //(��������� ������).
    //Icon.Picture.Icon := I;
    I.Free;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var nid : TNotifyIconData;
begin
  with nid do
  begin
    cbSize := SizeOf( TNotifyIconData );
    Wnd := Form1.Handle;
    uID := 1;
    uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
    uCallbackMessage := WM_USER + 100;
    hIcon := Application.Icon.Handle;
    StrPCopy(szTip, Form1.Caption);
  end;
  Shell_NotifyIcon( NIM_DELETE, @nid );
end;

procedure TForm1.IconCallBackMessage( var Mess : TMessage );
var P: TPoint;
begin
  GetCursorPos(P);
  case Mess.lParam of
    WM_LBUTTONUP: //'������� ����� ������ ����'
    begin
      Form1.Show; //Application.ShowMainForm := TRUE;
      Form1.Show;
      PopupMenu1.FreeOnRelease;
      //Form1.WindowState := wsNormal;
    end;
    //WM_RBUTTONDOWN    : TI_Event.Caption:= '������� ������ ������ ����'         ;
    WM_RBUTTONUP: PopupMenu1.Popup(P.X, P.Y);//'������� ������ ������ ����'         ;
  end;
end;

procedure TForm1.OnMinimize(var Msg: TWMSysCommand);
begin
 if Msg.CmdType = SC_MINIMIZE then
 begin
   Form1.Hide;
   //Form1.Visible := FALSE;
   //Application.ShowMainForm := FALSE;
 end
 else inherited;
end;

procedure TForm1.N21Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
  Form1.Show; //Application.ShowMainForm := TRUE;
  Form1.Show;
end;

procedure TForm1.Num7Q1Click(Sender: TObject);
begin
  if  CheckBox4.Checked then
  begin
    CheckBox4.Checked := FALSE;
    PopupMenu1.Items[3].Checked := FALSE;
    IniFile.WriteInteger('INI info', 'num7', 0);
  end
  else
  begin
    CheckBox4.Checked := TRUE;
    PopupMenu1.Items[3].Checked := TRUE;
    IniFile.WriteInteger('INI info', 'num7', ord('Q'));
  end;
end;

procedure TForm1.Num7W1Click(Sender: TObject);
begin
  if  CheckBox1.Checked then
  begin
    CheckBox1.Checked := FALSE;
    PopupMenu1.Items[4].Checked := FALSE;
    IniFile.WriteInteger('INI info','num4', 0);
  end
  else
  begin
    CheckBox1.Checked := TRUE;
    PopupMenu1.Items[4].Checked := TRUE;
    IniFile.WriteInteger('INI info','num4', ord('W'));
  end;
end;

procedure TForm1.Num7E1Click(Sender: TObject);
begin
  if  CheckBox3.Checked then
  begin
    CheckBox3.Checked := FALSE;
    PopupMenu1.Items[5].Checked := FALSE;
    IniFile.WriteInteger('INI info','num1', 0);
  end
  else
  begin
    CheckBox3.Checked := TRUE;
    PopupMenu1.Items[5].Checked := TRUE;
    IniFile.WriteInteger('INI info','num1', ord('E'));
  end;
end;

procedure TForm1.SPACE1Click(Sender: TObject);
begin
  if  CheckBox2.Checked then
  begin
    CheckBox2.Checked := FALSE;
    PopupMenu1.Items[6].Checked := FALSE;
    IniFile.WriteInteger('INI info', 'Space', 0);
  end
  else
  begin
    CheckBox2.Checked := TRUE;
    PopupMenu1.Items[6].Checked := TRUE;
    IniFile.WriteInteger('INI info', 'Space', 1);
  end;
end;

procedure TForm1.CheckBox6Click(Sender: TObject);
begin
  if  CheckBox6.Checked then
  begin
    IniFile.WriteBool('INI info','Min', TRUE); //Minimized
  end
  else
  begin
    IniFile.WriteBool('INI info','Min', FALSE);
  end;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  if PopupMenu1.Items[1].Caption = '����������' then
  begin
    UnRegisterHotKey(handle, ord('Q'));
    UnRegisterHotKey(handle, ord('E'));
    UnRegisterHotKey(handle, ord('W'));
    UnRegisterHotKey(handle, ord(VK_SPACE));
    StatusBar1.Panels[1].Text := '�� �������';
    PopupMenu1.Items[1].Caption := '�����������';
    MenuStop := TRUE;
    Stop := TRUE;
  end
  else
    if PopupMenu1.Items[1].Caption = '�����������' then
    begin
      if  CheckBox1.Checked then RegisterHotKey(handle, ord('W'), 0, ord('W'))
      else UnRegisterHotKey(handle, ord('W'));

      if CheckBox2.Checked then RegisterHotKey(handle, ord(VK_SPACE), 0, ord(VK_SPACE))
      else UnRegisterHotKey(handle, ord(VK_SPACE));

      if  CheckBox3.Checked then RegisterHotKey(handle, ord('E'), 0, ord('E'))
      else UnRegisterHotKey(handle, ord('E'));

      if CheckBox4.Checked then RegisterHotKey(handle, ord('Q'), 0, ord('Q'))
      else UnRegisterHotKey(handle, ord('Q'));

      if CheckBox7.Checked then RegisterHotkey(Handle, 2, 0, VK_RETURN)
      else UnRegisterHotkey(Handle, 2);

      StatusBar1.Panels[1].Text := '�������';
      PopupMenu1.Items[1].Caption := '����������';
      MenuStop := FALSE;
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage('��������� ������ ������ "' + Form1.Caption + '"' + #13#10 +   //' + #13#10 + '
               #13#10 + #13#10 + '��������� ����� � 2012 ������� �. �.' + #13#10 +
              '�������, ����������� ���� ��������.' + #13#10 + #13#10 +
              '����� �������, �������, ����������� - ' + #13#10 +
              '� �������� ������� �� ������ quoe@mail.ru');
end;

procedure TForm1.CheckBox7Click(Sender: TObject);
begin
  //���� ��������� ��������
  if work then
  begin
    if  CheckBox7.Checked then
    begin
      //����������� �������
      RegisterHotkey(Handle, 2, 0, VK_RETURN);
      IniFile.WriteBool('INI info','Chat', TRUE);
    end
    else
    begin
      UnRegisterHotKey(handle, VK_RETURN);
      IniFile.WriteBool('INI info','Chat', FALSE);
    end;
  end
  else
    if  CheckBox7.Checked then
    begin
      //����������� �������
      IniFile.WriteBool('INI info','Chat', TRUE);
    end
    else
    begin
      IniFile.WriteBool('INI info','Chat', FALSE);
    end;
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
  ShowMessage('�������� ������ � ������: ENTER ����� ENTER,' + #13 +
              '�.�. � ����� ��� ��� ����� ������, �� ������������,' + #13 +
              '�������� ���������/���������� ���������!');
end;

end.                        
