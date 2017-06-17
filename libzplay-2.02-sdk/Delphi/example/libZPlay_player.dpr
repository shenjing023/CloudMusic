program libZPlay_player;

uses
  Forms,
  test_dll in 'TEST_DLL.PAS' {Form1},
  libZPlay in '..\libZPlay.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'libZPlay player';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
