program HotKey;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'HotKey v0.6';
  Application.CreateForm(TForm1, Form1);
  if Form1.CheckBox6.Checked then Application.ShowMainForm := FALSE
  else
  Application.ShowMainForm := TRUE;
  Application.Run;
end.
