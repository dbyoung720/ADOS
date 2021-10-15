program aDOS;
{$IF CompilerVersion >= 21.0}
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$IFEND}

uses
  Winapi.Windows,
  System.Win.Registry,
  System.SysUtils;

{$R *.res}

procedure WriteREGCommand;
begin
  with TRegistry.Create do
  begin
    RootKey := HKEY_CLASSES_ROOT;
    OpenKey('*\shell\在此处打开命令窗口(管理员)\command', True);
    WriteString('', '"' + ParamStr(0) + '" "%1"');
    Free;
  end;

  with TRegistry.Create do
  begin
    RootKey := HKEY_CLASSES_ROOT;
    OpenKey('Directory\Background\shell\在此处打开命令窗口(管理员)\command', True);
    WriteString('', '"' + ParamStr(0) + '" "%V"');
    Free;
  end;

  with TRegistry.Create do
  begin
    RootKey := HKEY_CLASSES_ROOT;
    OpenKey('Folder\shell\在此处打开命令窗口(管理员)\command', True);
    WriteString('', '"' + ParamStr(0) + '" "%1"');
    Free;
  end;
end;

procedure Main;
var
  strDirPath: String;
begin
  WriteREGCommand;
  strDirPath := ParamStr(1);
  if GetFileAttributes(PChar(strDirPath)) and FILE_ATTRIBUTE_DIRECTORY = 0 then
    strDirPath := ExtractFilePath(strDirPath);
  if DirectoryExists(strDirPath) then
  begin
    SetCurrentDirectory(PChar(strDirPath));
    WinExec('CMD.exe', SW_SHOW);
  end;
end;

begin
  Main;

end.
