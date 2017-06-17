unit test_dll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Math, libZPlay;


type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    GroupBox1: TGroupBox;
    Info: TGroupBox;
    Timer1: TTimer;
    GroupBox2: TGroupBox;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    GroupBox3: TGroupBox;
    Button14: TButton;
    Button15: TButton;
    leftvu: TProgressBar;
    rightvu: TProgressBar;
    Button16: TButton;
    Timer2: TTimer;
    Button17: TButton;
    GroupBox5: TGroupBox;
    EqualizerCheckBox: TCheckBox;
    sbEq1: TScrollBar;
    sbEq2: TScrollBar;
    sbEq3: TScrollBar;
    sbEq4: TScrollBar;
    sbEq5: TScrollBar;
    sbEq6: TScrollBar;
    sbEq7: TScrollBar;
    sbEq8: TScrollBar;
    sbEq9: TScrollBar;
    sbEq10: TScrollBar;
    sbEqPreamp: TScrollBar;
    GroupBox6: TGroupBox;
    sbLeftMasterVolume: TScrollBar;
    sbRightMasterVolume: TScrollBar;
    GroupBox7: TGroupBox;
    sbLeftPlayerVolume: TScrollBar;
    sbRightPlayerVolume: TScrollBar;
    GroupBox8: TGroupBox;
    sbPitch: TScrollBar;
    sbTempo: TScrollBar;
    sbRate: TScrollBar;
    GroupBox4: TGroupBox;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    fftgraph: TPaintBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    EnableGraph: TCheckBox;
    ProgressBar1: TProgressBar;
    SUbgrid: TCheckBox;
    Button13: TButton;
    id3text1: TLabel;
    id3text2: TLabel;
    desc1: TLabel;
    desc2: TLabel;
    info1: TLabel;
    info3: TLabel;
    info2: TLabel;
    info4: TLabel;
    Button18: TButton;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Image1: TImage;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    GroupBox9: TGroupBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox4: TCheckBox;
    Button20: TButton;
    GroupBox10: TGroupBox;
    Image2: TImage;

    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure EqualizerCheckBoxClick(Sender: TObject);
    procedure sbEq1Change(Sender: TObject);
    procedure sbEq3Change(Sender: TObject);
    procedure sbEq2Change(Sender: TObject);
    procedure sbEq4Change(Sender: TObject);
    procedure sbEq5Change(Sender: TObject);
    procedure sbEq6Change(Sender: TObject);
    procedure sbEq7Change(Sender: TObject);
    procedure sbEq8Change(Sender: TObject);
    procedure sbEq9Change(Sender: TObject);
    procedure sbEq10Change(Sender: TObject);
    procedure sbEqPreampChange(Sender: TObject);
    procedure sbLeftMasterVolumeScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure sbRightMasterVolumeScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure sbLeftPlayerVolumeScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure sbRightPlayerVolumeScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure sbPitchScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure sbTempoScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure sbRateScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure EnableGraphClick(Sender: TObject);
    procedure ProgressBar1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SUbgridClick(Sender: TObject);
    procedure fftgraphPaint(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
   


  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  Form1: TForm1;
  cp:Integer ;
  echo:Boolean;
  eq:Boolean;

  DisplayGraph: Boolean;

  player: ZPlay;

  fvocalcut: Boolean;
  fsidecut: Boolean;

  NextSong: Boolean;




  buf:AnsiString;
  reverse : Boolean;


  wmp3x : Integer;


  Buffer: PChar;  // buffer for nonmanaged stream
  FileHandle: Integer; // file handle of managed and unmanaged stream
  FileSize: Integer;
  ChunkSize: Integer = 16384;


  FadeFinished: Boolean = false;
implementation







Function player_callback(objptr: Pointer; user_data: Integer; msg: TCallbackMessage; param1: Cardinal; param2: Cardinal):Integer;stdcall;
var
  ReadBytes: Integer;
begin
  Result := 0;
   case msg of
      libZPlay.MsgStreamNeedMoreDataAsync:
      begin
      // managed stream, read more data
        if FileHandle = 0 then
        begin
          player.PushDataToStream(nil, 0);
          Exit;
        end;

        if Buffer = nil then
        begin
          player.PushDataToStream(nil, 0);
          Exit;
        end;
        // read next data from file
        ReadBytes := FileRead(FileHandle, Buffer^, ChunkSize);
        if ReadBytes = 0 then
        begin
          player.PushDataToStream(nil, 0);
          Exit;
        end;
        // push new data to stream
        player.PushDataToStream(Buffer, ReadBytes);
      end;

      libZPlay.MsgExitVolumeSlideAsync:
      begin
        FadeFinished := true;
      end;


      libZPlay.MsgNextSongAsync:
      begin
        NextSong := true;
      end;
   end;

   Result := 0;
end;

{$R *.dfm}




procedure InitInfo(myForm: TForm1);
begin
    myForm.id3text1.Caption  := 'Title:'#13#10'Artist:'#13#10'Album:'#13#10'Genre:'#13#10'Track:'#13#10'Year:'#13#10'Comment:';
    myForm.id3text2.Caption := '';

    myform.desc1.Caption := 'Format:'#13#10'Length:'#13#10'Samplerate:'#13#10'Bitrate:'#13#10'Channel:'#13#10'VBR:';


  myForm.ProgressBar1.Min := 0;
  myForm.ProgressBar1.Max := 0;
  myForm.ProgressBar1.Position := 0;

end;



procedure SetInfo(myForm: TForm1);
var
  Id3Info: TID3InfoEx;
  Info: TStreamInfo;
begin

  InitInfo(myForm);


  if player.LoadID3Ex(Id3Info, true) then
  begin
    myForm.id3text2.Caption  := Id3Info.Title + ''#13#10'' + Id3Info.Artist + ''#13#10'' + Id3Info.Album + ''#13#10'' + Id3Info.Genre + ''#13#10'' + Id3Info.Track + ''#13#10'' + Id3Info.Year + ''#13#10'' + Id3Info.Comment;
  end;


  player.GetStreamInfo(Info);

  myForm.desc2.Caption  := Info.Description + ''#13#10'' + IntToStr(Info.Length.hms.hour) + ' : '
                        + IntToStr(Info.Length.hms.minute) + ' : ' +
                        IntToStr(Info.Length.hms.second) + ''#13#10'' + IntToStr(Info.SamplingRate) +  ' Hz' +''#13#10'' +
                         IntToStr(Info.Bitrate) + ' kbit/sec' + ''#13#10'' + IntToStr(Info.ChannelNumber) + ''#13#10'' +
                          BoolToStr(Info.VBR, true);


  myForm.ProgressBar1.Min := 0;
  myForm.ProgressBar1.Max := Info.Length.sec;
  myForm.ProgressBar1.Position := 0;


  if Id3Info.Picture.PicturePresent = True  then
    myForm.Image2.Picture := ID3Info.Picture.Bitmap;



end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  InitInfo(Form1);
  Timer1.Enabled := true;
  Timer2.Enabled := true;

  if(OpenDialog1.Execute()) then
  begin

    player.Close();

    if player.OpenFile(OpenDialog1.FileName, sfAutodetect) then
    begin
        SetInfo(Form1);
      player.StartPlayback();
    end
  else
       MessageBox(0, PAnsiChar(player.GetError()), 'Fatal error' ,0);

  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  EchoEffect: array[0 .. 1] of TEchoEffect;
  Left: Integer;
  Right: Integer;

begin
  DisplayGraph := true;

  Buffer := nil;
  FileHandle := 0;

  NextSong := false;

  // create class instance
  player := ZPlay.Create;

  info1.Caption  := 'Eq:'#13#10'Fade:'#13#10'Echo:'#13#10'Bitrate:'#13#10'Vocal cut:'#13#10'Side cut:';
  info3.Caption  := 'Loop:'#13#10'Reverse:'#13#10'Play:'#13#10'Pause:'#13#10'Channel mix:'#13#10'Load:';



  // set callback message, need this for managed stream and to trace fade volume

   // set callback function to feed new data into stream
   
    if player.SetCallbackFunc(Addr(player_callback), TCallbackMessage(Integer(libZPlay.MsgStreamNeedMoreDataAsync) + Integer(libZPlay.MsgExitVolumeSlideAsync) + Integer(libZPlay.MsgNextSongAsync)) , 0) = false then
    begin
      MessageBox(0, PAnsiChar(player.GetError()), 'Fatal error' ,0);
      Exit;
    end;


  echo := false;
  eq := false;
  fvocalcut := false;
  fsidecut := false;
  Buffer := NIL;
  reverse := false;


  EchoEffect[0].LeftDelay := 2000;
  EchoEffect[0].LeftSrcVolume := 50;
  EchoEffect[0].LeftEchoVolume := 30;
  EchoEffect[0].RightDelay := 2000;
  EchoEffect[0].RightSrcVolume := 50;
  EchoEffect[0].RightEchoVolume := 30;

  EchoEffect[1].LeftDelay := 30;
  EchoEffect[1].LeftSrcVolume := 50;
  EchoEffect[1].LeftEchoVolume := 30;
  EchoEffect[1].RightDelay := 30;
  EchoEffect[1].RightSrcVolume := 50;
  EchoEffect[1].RightEchoVolume := 30;

  player.SetEchoParam(EchoEffect, 2);


  player.GetMasterVolume(Left, Right);
  sbLeftMasterVolume.Position := 100 - Left;
  sbRightMasterVolume.Position := 100 - Right;

  player.GetPlayerVolume(Left, Right);
  sbLeftPlayerVolume.Position := 100 - Left;
  sbRightPlayerVolume.Position := 100 - Right;

  if ParamCount > 0 then
  begin

    InitInfo(Form1);
    Timer1.Enabled := true;
    Timer2.Enabled := true;


    if player.OpenFile(ParamStr(1), sfAutodetect) then
    begin
      SetInfo(Form1);
      player.StartPlayback;
    end
  else
       MessageBox(0, PAnsiChar(player.GetError()), 'Fatal error' ,0);
  end;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin

  player.Free;

  if Buffer <> NIL then
  begin
    FreeMemory(Buffer);
    Buffer := NIL;
  end;
 
  if FileHandle <> 0 then
  begin
    FileClose(FileHandle);
    FileHandle := 0;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  player.StartPlayback;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  player.StopPlayback;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  player.PausePlayback();
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  player.ResumePlayback;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  status : TStreamStatus;
  Position: TStreamTime;
  LoadInfo: TStreamLoadInfo;
  Left: Integer;
  Right: Integer;
begin

    player.GetPosition(Position);

     Label1.Caption := Format('%2u', [Position.hms.hour]) + ' : ' + Format('%2u', [Position.hms.minute ]) + ' : ' + Format('%2u', [Position.hms.second]) + ' : ' + Format('%3u', [Position.hms.millisecond]);

    ProgressBar1.Position :=  Position.sec;

    // status info
    player.GetStatus(status);

    info2.Caption :=  BoolToStr(status.fEqualizer, true) + ''#13#10'' +
    BoolToStr(status.fSlideVolume, true ) + ''#13#10'' +
    BoolToStr(status.fEcho, true) + ''#13#10'' +
    IntToStr(player.GetBitrate(false)) + ''#13#10''+
    BoolToStr(status.fVocalCut, true ) + ''#13#10'' +
    BoolToStr(status.fSideCut, true );


    player.GetDynamicStreamLoad(LoadInfo);

    info4.Caption :=  IntToStr(status.nLoop) + ''#13#10''+
     BoolToStr(status.fReverse, true) + ''#13#10'' +
    BoolToStr(status.fPlay, true) + ''#13#10'' +
     BoolToStr(status.fPause, true) + ''#13#10''+
     BoolToStr(status.fChannelMix, true)+ ''#13#10'' +
     IntToStr(LoadInfo.NumberOfBuffers );



      if status.fSlideVolume then
      begin
        player.GetPlayerVolume(Left, Right);
        sbLeftPlayerVolume.Position := 100 - Left;
        sbRightPlayerVolume.Position := 100 - Right;
      end;

      if FadeFinished then
      begin
        player.GetPlayerVolume(Left, Right);
        sbLeftPlayerVolume.Position := 100 - Left;
        sbRightPlayerVolume.Position := 100 - Right;
        FadeFinished := false
      end;

      if NextSong then
      begin
        SetInfo(Form1);
          NextSong := false;
      end;


end;



procedure TForm1.Button6Click(Sender: TObject);
var
  StartTime: TStreamTime;
  EndTime: TStreamTime;
  Left: Integer;
  Right: Integer;
begin
  player.GetPosition(StartTime);
  EndTime.sec := StartTime.sec + 5;
  player.GetPlayerVolume(Left, Right);
  player.SlideVolume(tfSecond, StartTime, Left, Right, tfSecond, EndTime, 100, 100);
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  StartTime: TStreamTime;
  EndTime: TStreamTime;
  Left: Integer;
  Right: Integer;
begin
  player.GetPosition(StartTime);
  EndTime.sec := StartTime.sec + 5;
  player.GetPlayerVolume(Left, Right);
  player.SlideVolume(tfSecond, StartTime, Left, Right, tfSecond, EndTime, 0, 0);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
    echo := not echo;
  player.EnableEcho(echo);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  fvocalcut := not fvocalcut;
  fsidecut := false;
  if fvocalcut then
    player.StereoCut(true, false, false)
  else
    player.StereoCut(false, false, false);
end;

procedure TForm1.Button10Click(Sender: TObject);
var
  time: TStreamTime;
begin
  time.sec := 5;
  player.Seek(tfSecond, time, smFromCurrentBackward);
end;

procedure TForm1.Button11Click(Sender: TObject);
var
  time: TStreamTime;
begin
  time.sec := 5;
  player.Seek(tfSecond, time, smFromCurrentForward);
end;

procedure TForm1.Button12Click(Sender: TObject);
var
  StartPos : TStreamTime;
  EndPos : TStreamTime;
begin
  player.GetPosition(StartPos);
  EndPos.sec := StartPos.sec + 2;
  player.PlayLoop(tfSecond, StartPos, tfSecond, EndPos, 3, 1);
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
  if MessageBox(Form1.Handle, 'This can take some time, please wait ! Continue ?', 'Beat per minute detection', MB_YESNOCANCEL) = ID_YES then
    MessageBox(Form1.Handle, PAnsiChar(IntToStr(player.DetectBPM(libZPlay.dmPeaks))), 'Beat per minute', MB_OK);
end;

procedure TForm1.Button14Click(Sender: TObject);
var
   format: TStreamFormat;
begin
  InitInfo(Form1);
  Timer1.Enabled := true;
  Timer2.Enabled := true;


  if(OpenDialog1.Execute()) then
  begin
    format := player.GetFileFormat(OpenDialog1.FileName);
    if(format = sfUnknown) then
    begin
      MessageBox(0, PAnsiChar(player.GetError()), 'Fatal error' ,0);
      Exit;
    end;

    player.Close();



    if Buffer <> NIL then
    begin
      FreeMemory(Buffer);
      Buffer := NIL;
    end;

    if FileHandle <> 0 then
    begin
      FileClose(FileHandle);
      FileHandle := 0;
    end;

      FileHandle := FileOpen(OpenDialog1.FileName, fmOpenRead);
      FileSize := FileSeek(FileHandle,0,2);
      FileSeek(FileHandle,0,0);
      GetMem(Buffer, FileSize + 1);
      FileRead(FileHandle, Buffer^, FileSize);
      FileClose(FileHandle);
      FileHandle := 0;



    if player.OpenStream(1, 0, Buffer, FileSize, format) then
    begin
      SetInfo(Form1);
      player.STartPlayback;
    end
    else
       MessageBox(0, PAnsiChar(player.GetError()), 'Fatal error' ,0);
    end;

end;




procedure TForm1.Button15Click(Sender: TObject);
begin
  reverse := not reverse;

  player.ReverseMode(reverse);


end;

procedure TForm1.Button16Click(Sender: TObject);
var
   format: TStreamFormat;
begin
  InitInfo(Form1);
  Timer1.Enabled := true;
  Timer2.Enabled := true;
  
  if(OpenDialog1.Execute()) then
  begin
    format := player.GetFileFormat(OpenDialog1.FileName);
    if(format = sfUnknown) then
    begin
      MessageBox(0, PAnsiChar(player.GetError()), 'Fatal error' ,0);
      Exit;
    end;

    player.Close();
    


    if Buffer <> NIL then
    begin
      FreeMemory(Buffer);
      Buffer := NIL;
    end;

    if FileHandle <> 0 then
    begin
      FileClose(FileHandle);
      FileHandle := 0;
    end;
      // open file, read small chunk of data and open managed, buffered stream
      FileHandle := FileOpen(OpenDialog1.FileName, fmOpenRead);
      FileSize := FileSeek(FileHandle,0,2);
      if FileSize > ChunkSize then
        FileSize := ChunkSize;

      FileSeek(FileHandle,0,0);
      GetMem(Buffer, FileSize + 1);
      FileRead(FileHandle, Buffer^, FileSize);

    if player.OpenStream(1, 1, Buffer, FileSize, format) then
    begin
      SetInfo(Form1);
      player.StartPlayback;
    end
  else
       MessageBox(0, PAnsiChar(player.GetError()), 'Fatal error' ,0);
  end;
end;



procedure TForm1.Timer2Timer(Sender: TObject);
var
 LeftChannelVUData: Cardinal;
 RightChannelVUData: Cardinal;


begin

  player.GetVUData(LeftChannelVUData, RightChannelVUData);
  leftvu.Position :=  LeftChannelVUData;
  rightvu.Position :=   RightChannelVUData;

  if DisplayGraph then
    fftgraph.OnPaint(Sender);  







end;


procedure TForm1.Button17Click(Sender: TObject);
begin
  fsidecut := not fsidecut;
  fvocalcut := false;
  if fsidecut then
    player.StereoCut(true, true, false)
  else
    player.StereoCut(false, true, false);
end;

procedure TForm1.EqualizerCheckBoxClick(Sender: TObject);
begin
    player.EnableEqualizer(EqualizerCheckBox.Checked)
end;

procedure TForm1.sbEq1Change(Sender: TObject);
begin
  player.SetEqualizerBandGain(0, 20000 - TScrollbar(Sender).Position * 1000);
end;



procedure TForm1.sbEq3Change(Sender: TObject);
begin
    player.SetEqualizerBandGain(2, 20000 - TScrollbar(Sender).Position * 1000);
end;



procedure TForm1.sbEq2Change(Sender: TObject);
begin
  player.SetEqualizerBandGain(1, 20000 - TScrollbar(Sender).Position * 1000);
end;

procedure TForm1.sbEq4Change(Sender: TObject);
begin
  player.SetEqualizerBandGain(3, 20000 - TScrollbar(Sender).Position * 1000);
end;

procedure TForm1.sbEq5Change(Sender: TObject);
begin
  player.SetEqualizerBandGain(4, 20000 - TScrollbar(Sender).Position * 1000);
end;

procedure TForm1.sbEq6Change(Sender: TObject);
begin
  player.SetEqualizerBandGain(5, 20000 - TScrollbar(Sender).Position * 1000);
end;

procedure TForm1.sbEq7Change(Sender: TObject);
begin
  player.SetEqualizerBandGain(6, 20000 - TScrollbar(Sender).Position * 1000);
end;

procedure TForm1.sbEq8Change(Sender: TObject);
begin
  player.SetEqualizerBandGain(7, 20000 - TScrollbar(Sender).Position * 1000);
end;

procedure TForm1.sbEq9Change(Sender: TObject);
begin
  player.SetEqualizerBandGain(8, 20000 - TScrollbar(Sender).Position * 1000);
end;

procedure TForm1.sbEq10Change(Sender: TObject);
begin
  player.SetEqualizerBandGain(9, 20000 - TScrollbar(Sender).Position * 1000);
end;

procedure TForm1.sbEqPreampChange(Sender: TObject);
begin
  player.SetEqualizerPreampGain(20000 - TScrollbar(Sender).Position * 1000);
end;

procedure TForm1.sbLeftMasterVolumeScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  player.SetMasterVolume(100 - sbLeftMasterVolume.Position, 100 - sbRightMasterVolume.Position);
end;

procedure TForm1.sbRightMasterVolumeScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  player.SetMasterVolume(100 - sbLeftMasterVolume.Position, 100 - sbRightMasterVolume.Position);
end;

procedure TForm1.sbLeftPlayerVolumeScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  player.SetPlayerVolume(100 - sbLeftPlayerVolume.Position, 100 - sbRightPlayerVolume.Position);
end;

procedure TForm1.sbRightPlayerVolumeScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  player.SetPlayerVolume(100 - sbLeftPlayerVolume.Position, 100 - sbRightPlayerVolume.Position);
end;
        
procedure TForm1.sbPitchScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  player.SetPitch(200 - ScrollPos);
end;

procedure TForm1.sbTempoScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  player.SetTempo(200 - ScrollPos);
end;

procedure TForm1.sbRateScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  player.SetRate( 200 - ScrollPos);
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    player.SetFFTGraphParam(gpHorizontalScale, Integer(gsLinear))
  else
    player.SetFFTGraphParam(gpHorizontalScale, Integer(gsLogarithmic));
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  case  TComboBox(Sender).ItemIndex of
  0: player.SetFFTGraphParam(gpGraphType, Integer(gtLinesLeftOnTop));
  1: player.SetFFTGraphParam(gpGraphType, Integer(gtLinesRightOnTop));
  2: player.SetFFTGraphParam(gpGraphType, Integer(gtAreaLeftOnTop));
  3: player.SetFFTGraphParam(gpGraphType, Integer(gtAreaRightOnTop));
  4: player.SetFFTGraphParam(gpGraphType, Integer(gtBarsLeftOnTop));
  5: player.SetFFTGraphParam(gpGraphType, Integer(gtBarsRightOnTop));
  6: player.SetFFTGraphParam(gpGraphType, Integer(gtSpectrum));
  end;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  player.SetFFTGraphParam(gpWindow, TComboBox(Sender).ItemIndex + 1);
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
  player.SetFFTGraphParam(gpFFTPoints, StrToInt(TComboBox(Sender).Items[TComboBox(Sender).ItemIndex]));
end;

procedure TForm1.EnableGraphClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    DisplayGraph := true
  else
    DisplayGraph := false;
end;

procedure TForm1.ProgressBar1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

var
  Percent: Double;
  Info: TStreamInfo;
  Pos: TStreamTime;
begin
  player.GetStreamInfo(Info);
  Percent := X / ProgressBar1.Width;
  Pos.sec := Floor(Percent * Info.Length.sec);
  player.Seek(tfSecond, Pos, smFromBeginning);
end;

procedure TForm1.SUbgridClick(Sender: TObject);
begin
  player.SetFFTGraphParam(gpSubgrid, Integer(TCheckBox(Sender).Checked));
end;

procedure TForm1.fftgraphPaint(Sender: TObject);
begin
 player.DrawFFTGraphOnHDC(fftgraph.Canvas.Handle, 0, 0, fftgraph.Width, fftgraph.Height);
end;

procedure TForm1.Button18Click(Sender: TObject);
begin

  if(OpenDialog1.Execute()) then
  begin
    if player.AddFile(OpenDialog1.FileName, sfAutodetect) = false then
    begin
       MessageBox(0, PAnsiChar(player.GetError()), 'Fatal error' ,0);
    end;
  end;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
player.SetFFTGraphParam(gpFrequencyGridVisible, Integer(TCheckBox(Sender).Checked));
player.SetFFTGraphParam(gpDecibelGridVisible, Integer(TCheckBox(Sender).Checked));
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
player.SetFFTGraphParam(gpFrequencyScaleVisible, Integer(TCheckBox(Sender).Checked));
player.SetFFTGraphParam(gpDecibelScaleVisible, Integer(TCheckBox(Sender).Checked));
end;

procedure TForm1.Button19Click(Sender: TObject);
begin
 player.Close();
   Timer1.Enabled := true;
  Timer2.Enabled := true;

    if player.OpenFile('wavein://src=line;volume=50;', sfAutodetect) then
    begin
        SetInfo(Form1);
      player.StartPlayback();
    end
  else
       MessageBox(0, PAnsiChar(player.GetError()), 'Fatal error' ,0)
end;

procedure TForm1.Button20Click(Sender: TObject);
var
filename : string;
format :TStreamFormat;
begin
filename :=  'wavein://';
format := sfMp3;

case ComboBox4.ItemIndex of
    0: filename :=  'wavein://src=line;volume=50;';
    1: filename :=  'wavein://src=mic;volume=50;';
    2: filename :=  'wavein://src=cd;volume=50;';
    3: filename :=  'wavein://src=midi;volume=50;';

end;

 player.Close();
   Timer1.Enabled := true;
  Timer2.Enabled := true;

    if not player.OpenFile(filename, sfAutodetect) then
       MessageBox(0, PAnsiChar(player.GetError()), 'Fatal error' ,0)
    else
    begin

     if ComboBox5.ItemIndex > 0 then
      begin
          case ComboBox5.ItemIndex of
            1:
            begin
              SaveDialog1.Title := 'Save to mp3 file';
              SaveDialog1.Filter := 'Mp3 File|*.mp3';
              format := sfMp3;
            end;

             2:
            begin
              SaveDialog1.Title := 'Save to ogg file';
              SaveDialog1.Filter := 'Ogg File|*.ogg';
              format := sfOgg;
            end;

             3:
            begin
              SaveDialog1.Title := 'Save to FLAC file';
              SaveDialog1.Filter := 'FLAC File|*.flac';
              format := sfFLAC;
            end;

             4:
            begin
              SaveDialog1.Title := 'Save to FLAC Ogg file';
              SaveDialog1.Filter := 'FLAC Ogg File|*.oga';
              format := sfFLACOgg;
            end;

             5:
            begin
              SaveDialog1.Title := 'Save to AAC file';
             SaveDialog1.Filter := 'AAC File|*.aac';
             format := sfAacADTS;
            end;

             6:
            begin
              SaveDialog1.Title := 'Save to Wav file';
              SaveDialog1.Filter := 'Wav File|*.wav';
              format := sfWav;
            end;

             7:
            begin
              SaveDialog1.Title := 'Save to RAW PCM file';
              SaveDialog1.Filter := 'PCM File|*.pcm';
              format := sfPCM;
            end;
          end;



        if SaveDialog1.Execute() then
        begin

          player.SetWaveOutFile(SaveDialog1.FileName, format, CheckBox4.Checked);
          SetInfo(Form1);
          player.StartPlayback();
        end;
      end
      else
        begin
           SetInfo(Form1);
          player.StartPlayback();
        end;

    end;
end;

procedure TForm1.Button21Click(Sender: TObject);
begin
  InitInfo(Form1);
  Timer1.Enabled := true;
  Timer2.Enabled := true;

  if(SaveDialog1.Execute()) then
  begin

    player.Close();

    if player.OpenFile('wavein://src=line;volume=50;', sfAutodetect) then
    begin
          if not player.SetWaveOutFile(SaveDialog1.FileName, sfWav, true) then
            MessageBox(0, PAnsiChar(player.GetError()), 'Fatal error' ,0);

        SetInfo(Form1);
      player.StartPlayback();
    end
  else
       MessageBox(0, PAnsiChar(player.GetError()), 'Fatal error' ,0);

  end;
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
InitInfo(Form1);
  Timer1.Enabled := true;
  Timer2.Enabled := true;

  if(SaveDialog1.Execute()) then
  begin

    player.Close();

    if player.OpenFile('wavein://src=mic;volume=50;', sfAutodetect) then
    begin
          if not player.SetWaveOutFile(SaveDialog1.FileName, sfWav, true) then
            MessageBox(0, PAnsiChar(player.GetError()), 'Fatal error' ,0);

        SetInfo(Form1);
      player.StartPlayback();
    end
  else
       MessageBox(0, PAnsiChar(player.GetError()), 'Fatal error' ,0);

  end;
end;

end.
