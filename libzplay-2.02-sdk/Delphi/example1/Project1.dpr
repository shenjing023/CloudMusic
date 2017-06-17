program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows,
  libZPlay in '..\libZPlay.pas';

  var
  player: ZPlay;
  status: TStreamStatus;
  info: TStreamInfo;
  pos: TStreamTime;
  key: SmallInt;
  s : string;



begin
  { TODO -oUser -cConsole Main : Insert code here }
  { TODO -oUser -cConsole Main : Insert code here }
  Writeln('Playing test.mp3. Press Q to quit.');
  player := ZPlay.Create();
  if not player.OpenFile('mysong.mp3', sfAutodetect) then
  begin
      writeln(player.GetError());
      player.Free;
      Exit;
  end;

  player.GetStreamInfo(info);

  writeln('Length: ', info.Length.hms.hour, ':', info.Length.hms.minute, ':', info.Length.hms.second, ':', info.Length.hms.millisecond);

  player.StartPlayback;

  status.fPlay := true;
  while status.fPlay do
  begin
    player.GetPosition(pos);
    write('Pos: ', pos.hms.hour, ':', pos.hms.minute, ':', pos.hms.second, ':', pos.hms.millisecond, #13);
    player.GetStatus(status);
    Sleep(50);
    key := GetAsyncKeyState(81);
    if key <> 0 then
    break;

  end;
  player.Free;

end.
