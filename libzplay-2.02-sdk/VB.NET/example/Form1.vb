Imports libZPlay
Imports Microsoft.VisualBasic
Imports System
Imports System.Collections
Imports System.Collections.Generic
Imports System.Data
Imports System.Drawing
Imports System.Diagnostics
Imports System.Windows.Forms
Imports System.Linq
Imports System.Xml.Linq


Namespace libwmp3x_player
	Partial Public Class Form1
		Friend Sub New()
			InitializeComponent()
		End Sub
        Private player As ZPlay
		Private LoadMode As Integer
		Private ReverseMode As Boolean
		Private Echo As Boolean
		Private VocalCut As Boolean = False
        Private SideCut As Boolean = False

        Private NextSong As Boolean = False

		Private FadeFinished As Boolean = False

		' need this for managed stream
		Private fStream As System.IO.FileStream = Nothing
		Private br As System.IO.BinaryReader = Nothing
		Private BufferCounter As Integer

        Private CallbackFunc As TCallbackFunc

        Private BlockSlideLeft As Boolean = False
        Private BlockSlideRight As Boolean = False

        ''' <summary>
        ''' Text callback
        ''' </summary>
        ''' <param name="text"></param>
        ''' <remarks></remarks>
        Public Delegate Sub SetTextCallback(ByVal text As String)


        Private Sub SetText(ByVal text As String)

            ' InvokeRequired required compares the thread ID of the
            ' calling thread to the thread ID of the creating thread.
            ' If these threads are different, it returns true.
            If Me.callback_text.InvokeRequired Then
                Dim d As New SetTextCallback(AddressOf SetText)
                Me.Invoke(d, New Object() {text})
            Else
                Me.callback_text.Text = text
            End If
        End Sub



        ''' <summary>
        ''' Show info
        ''' </summary>
        ''' <remarks></remarks>
        Public Sub showinfo()
            ' load id3 data if exists

            Dim info As New TID3InfoEx()
    


            Label3.Text = ""
            Label4.Text = ""
            Label5.Text = ""
            Label6.Text = ""
            Label7.Text = ""
            Label8.Text = ""
            Label9.Text = ""


            If player.LoadID3Ex(info, True) Then
                Label3.Text = info.Title
                Label4.Text = info.Artist
                Label5.Text = info.Album
                Label6.Text = info.Year
                Label7.Text = info.Track
                Label8.Text = info.Encoder
                Label9.Text = info.Comment
                

            End If


            If info.Picture.PicturePresent Then
                PictureBox2.Image = info.Picture.Bitmap
            Else
                PictureBox2.Image = Nothing
            End If



            descr.Text = "Format:" & System.Environment.NewLine & "Length:" & System.Environment.NewLine & "Samplerate:" & System.Environment.NewLine & "Bitrate:" & System.Environment.NewLine & "Channel:" & System.Environment.NewLine & "VBR:"

            Dim StreamInfo As New TStreamInfo()
            player.GetStreamInfo(StreamInfo)
            descr1.Text = StreamInfo.Description & System.Environment.NewLine & System.Convert.ToString(StreamInfo.Length.hms.hour) & " : " & System.Convert.ToString(StreamInfo.Length.hms.minute) & " : " & System.Convert.ToString(StreamInfo.Length.hms.second) & System.Environment.NewLine & System.Convert.ToString(StreamInfo.SamplingRate) & " Hz" & System.Environment.NewLine & System.Convert.ToString(StreamInfo.Bitrate) & " kbps" & System.Environment.NewLine & System.Convert.ToString(StreamInfo.ChannelNumber) & System.Environment.NewLine & System.Convert.ToString(StreamInfo.VBR)


            ProgressBar1.Minimum = 0
            ProgressBar1.Maximum = CInt(Fix(StreamInfo.Length.sec))
            ProgressBar1.Value = 0
            Timer1.Enabled = True
            Timer2.Enabled = True
        End Sub


        ''' <summary>
        ''' Callback function
        ''' </summary>
        ''' <param name="objptr"></param>
        ''' <param name="user_data"></param>
        ''' <param name="msg"></param>
        ''' <param name="param1"></param>
        ''' <param name="param2"></param>
        ''' <returns></returns>
        ''' <remarks></remarks>
        Public Function MyCallbackFunc(ByVal objptr As UInteger, ByVal user_data As Integer, ByVal msg As TCallbackMessage, ByVal param1 As UInteger, ByVal param2 As UInteger) As Integer
            Select Case msg
                Case TCallbackMessage.MsgEnterVolumeSlideAsync
                    SetText("EnterFadeAsync")

                Case TCallbackMessage.MsgExitVolumeSlideAsync
                    SetText("ExitFadeAsync")
                    FadeFinished = True

                Case TCallbackMessage.MsgStreamBufferDoneAsync
                    BufferCounter = BufferCounter + 1
                    SetText("StreamBufferDoneAsync: " & System.Convert.ToString(BufferCounter))
                    ' read more data and push into stream
                    Dim stream_data() As Byte = Nothing
                    Dim small_chunk As Integer = 100000
                    stream_data = br.ReadBytes(small_chunk)
                    If stream_data.Length > 0 Then
                        player.PushDataToStream(stream_data, CUInt(stream_data.Length))
                    Else
                        Dim tempMemNewData1() As Byte = Nothing
                        player.PushDataToStream(tempMemNewData1, 0)
                    End If


                Case TCallbackMessage.MsgNextSongAsync
                    SetText("MsgNextSongAsync: " & System.Convert.ToString(param1))
                    NextSong = True
            End Select

            Return 0
        End Function


        Private Sub Form1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
            player = New ZPlay()
            ReverseMode = False
            Echo = False

            Dim left As Integer = 0
            Dim right As Integer = 0
            player.GetMasterVolume(left, right)
            leftmastervolume.Value = 100 - left
            rightmastervolume.Value = 100 - right
            player.GetPlayerVolume(left, right)
            leftplayervolume.Value = 100 - left
            rightplayervolume.Value = 100 - right

            ' callback
            CallbackFunc = AddressOf MyCallbackFunc

            player.SetCallbackFunc(CallbackFunc, CType((TCallbackMessage.MsgEnterVolumeSlideAsync + _
                                                        TCallbackMessage.MsgExitVolumeSlideAsync + _
                                                        TCallbackMessage.MsgStreamBufferDoneAsync + _
                                                        TCallbackMessage.MsgNextSongAsync), TCallbackMessage), 0)



            ' echo


            Dim effect(2) As TEchoEffect

            effect(0).nLeftDelay = 2000
            effect(0).nLeftSrcVolume = 50
            effect(0).nLeftEchoVolume = 30
            effect(0).nRightDelay = 2000
            effect(0).nRightSrcVolume = 50
            effect(0).nRightEchoVolume = 30

            effect(1).nLeftDelay = 30
            effect(1).nLeftSrcVolume = 50
            effect(1).nLeftEchoVolume = 30
            effect(1).nRightDelay = 30
            effect(1).nRightSrcVolume = 50
            effect(1).nRightEchoVolume = 30

            player.SetEchoParam(effect, 2)



            ' '' set equalizer bands
            Dim EqPoints() As Integer = {100, 200, 300, 1000, 2000, 3000, 5000, 7000, 12000}
            player.SetEqualizerPoints(EqPoints, 9)

         

            ComboBox1.SelectedIndex = 0
            ComboBox2.SelectedIndex = 7
            ComboBox3.SelectedIndex = 11

            ComboBox4.SelectedIndex = 0
            ComboBox5.SelectedIndex = 0




            If My.MyApplication.Application.CommandLineArgs.Count <> 0 Then

                player.Close()

                If LoadMode = 0 Then
                    If Not (player.OpenFile(My.MyApplication.Application.CommandLineArgs(0), TStreamFormat.sfAutodetect)) Then
                        MessageBox.Show(player.GetError(), String.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error)
                    End If
                End If

                showinfo()
                player.StartPlayback()
            End If

        End Sub

        Private Sub Form1_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles MyBase.FormClosed

            If br IsNot Nothing Then
                br.Close()
            End If
            If fStream IsNot Nothing Then
                fStream.Close()
            End If
        End Sub

        Private Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
            LoadMode = 0
            OpenFileDialog1.ShowDialog()
        End Sub

        Private Sub OpenFileDialog1_FileOk(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles OpenFileDialog1.FileOk



            If LoadMode = 0 Then
                player.Close()
                If Not (player.OpenFile(OpenFileDialog1.FileName, TStreamFormat.sfAutodetect)) Then
                    MessageBox.Show(player.GetError(), String.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error)
                    Exit Sub
                End If
            ElseIf LoadMode = 1 Then
                player.Close()

                Dim format As TStreamFormat = player.GetFileFormat(OpenFileDialog1.FileName)

                Dim fInfo As New System.IO.FileInfo(OpenFileDialog1.FileName)
                Dim numBytes As Long = fInfo.Length
                Dim fStream As New System.IO.FileStream(OpenFileDialog1.FileName, System.IO.FileMode.Open, System.IO.FileAccess.Read)
                Dim br As New System.IO.BinaryReader(fStream)
                Dim stream_data() As Byte = Nothing

                stream_data = br.ReadBytes(CInt(Fix(numBytes)))
                If Not (player.OpenStream(True, False, stream_data, CUInt(numBytes), format)) Then
                    MessageBox.Show(player.GetError(), String.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error)
                End If

                br.Close()
                fStream.Close()
            ElseIf LoadMode = 2 Then
                player.Close()

                Dim format As TStreamFormat = player.GetFileFormat(OpenFileDialog1.FileName)
                BufferCounter = 0

                Dim fInfo As New System.IO.FileInfo(OpenFileDialog1.FileName)
                Dim numBytes As UInteger = CUInt(fInfo.Length)
                If br IsNot Nothing Then
                    br.Close()
                End If
                If fStream IsNot Nothing Then
                    fStream.Close()
                End If

                br = Nothing
                fStream = Nothing

                fStream = New System.IO.FileStream(OpenFileDialog1.FileName, System.IO.FileMode.Open, System.IO.FileAccess.Read)
                br = New System.IO.BinaryReader(fStream)
                Dim stream_data() As Byte = Nothing
                Dim small_chunk As UInteger = 0
                small_chunk = CType(Math.Min(100000, numBytes), UInteger)
                ' read small chunk of data
                stream_data = br.ReadBytes(CInt(Fix(small_chunk)))
                ' open stream
                If Not (player.OpenStream(True, True, stream_data, CUInt(stream_data.Length), format)) Then
                    MessageBox.Show(player.GetError(), String.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error)
                End If

                ' read more data and push into stream
                stream_data = br.ReadBytes(CInt(Fix(small_chunk)))
                player.PushDataToStream(stream_data, CUInt(stream_data.Length))

            ElseIf LoadMode = 3 Then
                If Not (player.AddFile(OpenFileDialog1.FileName, TStreamFormat.sfAutodetect)) Then
                    MessageBox.Show(player.GetError(), String.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error)
                    Exit Sub
                End If

            End If


            showinfo()
            player.StartPlayback()

        End Sub

        Private Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
            player.StartPlayback()
        End Sub

        Private Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            player.PausePlayback()

        End Sub

        Private Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
            player.ResumePlayback()
        End Sub

        Private Sub Button5_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button5.Click
            player.StopPlayback()
        End Sub

        Private Sub Button6_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button6.Click
            LoadMode = 1
            OpenFileDialog1.ShowDialog()
        End Sub

        Private Sub Button7_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button7.Click
            LoadMode = 2
            OpenFileDialog1.ShowDialog()
        End Sub

        Private Sub Timer1_Tick(ByVal sender As Object, ByVal e As System.EventArgs) Handles Timer1.Tick

            Dim pos As New TStreamTime()
            player.GetPosition(pos)

            If ProgressBar1.Maximum > CInt(Fix(pos.sec)) Then
                ProgressBar1.Value = CInt(Fix(pos.sec))
            End If

            position.Text = Format(pos.hms.hour, "00") & " : " & Format(pos.hms.minute, "00") & " : " & Format(pos.hms.second, "00") & " : " & Format(pos.hms.millisecond, "000")
            Dim Status As New TStreamStatus()
            player.GetStatus(Status)

            statuslabel1.Text = "Eq:" & System.Environment.NewLine & "Fade:" & System.Environment.NewLine & "Echo:" & System.Environment.NewLine & "Bitrate:" & System.Environment.NewLine & "Vocal cut:" & System.Environment.NewLine & "Side cut:"

            statuslabel2.Text = "Loop:" & System.Environment.NewLine & "Reverse:" & System.Environment.NewLine & "Play:" & System.Environment.NewLine & "Pause:" & System.Environment.NewLine & "Channel mix:" & System.Environment.NewLine & "Load:"

            statusvalue1.Text = System.Convert.ToString(Status.fEqualizer) & System.Environment.NewLine & System.Convert.ToString(Status.fSlideVolume) & System.Environment.NewLine & System.Convert.ToString(Status.fEcho) & System.Environment.NewLine & System.Convert.ToString(player.GetBitrate(False)) & System.Environment.NewLine & System.Convert.ToString(Status.fVocalCut) & System.Environment.NewLine & System.Convert.ToString(Status.fSideCut)

            Dim load As New TStreamLoadInfo()
            player.GetDynamicStreamLoad(load)
            statusvalue2.Text = System.Convert.ToString(Status.nLoop) & System.Environment.NewLine & System.Convert.ToString(Status.fReverse) & System.Environment.NewLine & System.Convert.ToString(Status.fPlay) & System.Environment.NewLine & System.Convert.ToString(Status.fPause) & System.Environment.NewLine & System.Convert.ToString(Status.fChannelMix) & System.Environment.NewLine & System.Convert.ToString(load.NumberOfBuffers)

            If Status.fSlideVolume <> False Then
                BlockSlideLeft = True
                BlockSlideRight = True
                Dim left As Integer
                Dim right As Integer
                player.GetPlayerVolume(left, right)
                leftplayervolume.Value = 100 - left
                rightplayervolume.Value = 100 - right


            End If

            If FadeFinished Then
                Dim left As Integer
                Dim right As Integer
                player.GetPlayerVolume(left, right)
                leftplayervolume.Value = 100 - left
                rightplayervolume.Value = 100 - right
                FadeFinished = False
            End If

            If NextSong Then
                showinfo()
                NextSong = False
            End If


        End Sub

        Private Sub ProgressBar1_MouseClick(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles ProgressBar1.MouseClick
            Dim newpos As New TStreamTime()
            Dim StreamInfo As New TStreamInfo()
            player.GetStreamInfo(StreamInfo)

            newpos.sec = CUInt(e.X * StreamInfo.Length.sec / CDbl((CType(sender, ProgressBar)).Size.Width))
            player.Seek(TTimeFormat.tfSecond, newpos, TSeekMethod.smFromBeginning)
        End Sub

        Private Sub Button9_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button9.Click
            Dim newpos As New TStreamTime()
            newpos.sec = 5
            player.Seek(TTimeFormat.tfSecond, newpos, TSeekMethod.smFromCurrentBackward)
        End Sub

        Private Sub Button10_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button10.Click
            Dim newpos As New TStreamTime()
            newpos.sec = 5
            player.Seek(TTimeFormat.tfSecond, newpos, TSeekMethod.smFromCurrentForward)
        End Sub

        Private Sub Button11_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button11.Click
            Dim startpos As New TStreamTime()
            Dim endpos As New TStreamTime()
            player.GetPosition(startpos)
            endpos.sec = CType(startpos.sec + 2, UInteger)
            player.PlayLoop(TTimeFormat.tfSecond, startpos, TTimeFormat.tfSecond, endpos, 3, True)

        End Sub

        Private Sub Button12_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button12.Click
            ReverseMode = Not ReverseMode
            player.ReverseMode(ReverseMode)

        End Sub

        Private Sub leftmastervolume_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles leftmastervolume.ValueChanged
            Dim left As Integer
            Dim right As Integer
            player.GetMasterVolume(left, right)
            player.SetMasterVolume(100 - (CType(sender, VScrollBar)).Value, right)
        End Sub

        Private Sub rightmastervolume_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rightmastervolume.ValueChanged
            Dim left As Integer
            Dim right As Integer
            player.GetMasterVolume(left, right)
            player.SetMasterVolume(left, 100 - (CType(sender, VScrollBar)).Value)
        End Sub

        Private Sub leftplayervolume_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles leftplayervolume.ValueChanged
            If Not BlockSlideLeft Then
                Dim left As Integer
                Dim right As Integer
                player.GetPlayerVolume(left, right)
                player.SetPlayerVolume(100 - (CType(sender, VScrollBar)).Value, right)
            End If
            BlockSlideLeft = False
        End Sub

        Private Sub rightplayervolume_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rightplayervolume.ValueChanged
            If Not BlockSlideRight Then
                Dim left As Integer
                Dim right As Integer
                player.GetPlayerVolume(left, right)
                player.SetPlayerVolume(left, 100 - (CType(sender, VScrollBar)).Value)
            End If
            BlockSlideRight = False
        End Sub

        Private Sub Timer2_Tick(ByVal sender As Object, ByVal e As System.EventArgs) Handles Timer2.Tick
            Dim left As Integer = 0
            Dim right As Integer = 0



            If FFTEnabled.Checked Then
                PictureBox1.Refresh()
            End If

        'Dim leftamplitude(512) As Integer
        'player.GetFFTValues(1024, CWMp3x.TFFTWindow.fwBartlett, Nothing, Nothing, leftamplitude, Nothing, Nothing, Nothing)
        'leftvu.Value = leftamplitude(1)

            player.GetVUData(left, right)
            leftvu.Value = left
            rightvu.Value = right

        End Sub

        Private Sub Button13_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button13.Click
            Dim left As Integer = 0
            Dim right As Integer = 0
            Dim startpos As New TStreamTime()
            Dim endpos As New TStreamTime()

            player.GetPlayerVolume(left, right)
            player.GetPosition(startpos)
            endpos.sec = CType(startpos.sec + 5, UInteger)
            player.SlideVolume(TTimeFormat.tfSecond, startpos, left, right, TTimeFormat.tfSecond, endpos, 100, 100)
        End Sub

        Private Sub Button14_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button14.Click
            Dim left As Integer = 0
            Dim right As Integer = 0
            Dim startpos As New TStreamTime()
            Dim endpos As New TStreamTime()

            player.GetPlayerVolume(left, right)
            player.GetPosition(startpos)
            endpos.sec = CType(startpos.sec + 5, UInteger)
            player.SlideVolume(TTimeFormat.tfSecond, startpos, left, right, TTimeFormat.tfSecond, endpos, 0, 0)

        End Sub

        Private Sub CheckBox1_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles CheckBox1.CheckedChanged
            player.EnableEqualizer((CType(sender, CheckBox)).Checked)
        End Sub

        Private Sub VScrollBar1_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VScrollBar1.ValueChanged
            If player IsNot Nothing Then
                player.SetEqualizerPreampGain(20000 - (CType(sender, VScrollBar)).Value * 1000)
            End If
        End Sub

        Private Sub VScrollBar2_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VScrollBar2.ValueChanged
            If player IsNot Nothing Then
                player.SetEqualizerBandGain(0, 20000 - (CType(sender, VScrollBar)).Value * 1000)
            End If
        End Sub

        Private Sub VScrollBar3_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VScrollBar3.ValueChanged
            If player IsNot Nothing Then
                player.SetEqualizerBandGain(1, 20000 - (CType(sender, VScrollBar)).Value * 1000)
            End If
        End Sub

        Private Sub VScrollBar4_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VScrollBar4.ValueChanged
            If player IsNot Nothing Then
                player.SetEqualizerBandGain(2, 20000 - (CType(sender, VScrollBar)).Value * 1000)
            End If
        End Sub

        Private Sub VScrollBar5_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VScrollBar5.ValueChanged
            If player IsNot Nothing Then
                player.SetEqualizerBandGain(3, 20000 - (CType(sender, VScrollBar)).Value * 1000)
            End If
        End Sub

        Private Sub VScrollBar6_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VScrollBar6.ValueChanged
            If player IsNot Nothing Then
                player.SetEqualizerBandGain(4, 20000 - (CType(sender, VScrollBar)).Value * 1000)
            End If
        End Sub

        Private Sub VScrollBar7_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VScrollBar7.ValueChanged
            If player IsNot Nothing Then
                player.SetEqualizerBandGain(5, 20000 - (CType(sender, VScrollBar)).Value * 1000)
            End If
        End Sub

        Private Sub VScrollBar8_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VScrollBar8.ValueChanged
            If player IsNot Nothing Then
                player.SetEqualizerBandGain(6, 20000 - (CType(sender, VScrollBar)).Value * 1000)
            End If
        End Sub

        Private Sub VScrollBar9_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VScrollBar9.ValueChanged
            If player IsNot Nothing Then
                player.SetEqualizerBandGain(7, 20000 - (CType(sender, VScrollBar)).Value * 1000)
            End If


        End Sub

        Private Sub VScrollBar10_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VScrollBar10.ValueChanged
            If player IsNot Nothing Then
                player.SetEqualizerBandGain(8, 20000 - (CType(sender, VScrollBar)).Value * 1000)
            End If
        End Sub

        Private Sub VScrollBar11_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VScrollBar11.ValueChanged
            If player IsNot Nothing Then
                player.SetEqualizerBandGain(9, 20000 - (CType(sender, VScrollBar)).Value * 1000)
            End If
        End Sub

        Private Sub Button15_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button15.Click
            Echo = Not Echo
            player.EnableEcho(Echo)
        End Sub

        Private Sub VScrollBar2_Scroll(ByVal sender As Object, ByVal e As System.Windows.Forms.ScrollEventArgs) Handles VScrollBar2.Scroll

        End Sub

        Private Sub VScrollBar12_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VScrollBar12.ValueChanged
            If player IsNot Nothing Then
                player.SetPitch(200 - (CType(sender, VScrollBar)).Value)
            End If
        End Sub

        Private Sub VScrollBar13_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VScrollBar13.ValueChanged
            If player IsNot Nothing Then
                player.SetTempo(200 - (CType(sender, VScrollBar)).Value)
            End If
        End Sub

        Private Sub VScrollBar14_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VScrollBar14.ValueChanged
            If player IsNot Nothing Then
                player.SetRate(200 - (CType(sender, VScrollBar)).Value)
            End If
        End Sub

        Private Sub Button8_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button8.Click
            SideCut = False
            VocalCut = Not VocalCut
            player.StereoCut(VocalCut, SideCut, True)
        End Sub

        Private Sub Button16_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button16.Click
            SideCut = Not SideCut
            VocalCut = False
            player.StereoCut(VocalCut Or SideCut, SideCut, False)

        End Sub


        Private Sub ComboBox1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ComboBox1.SelectedIndexChanged
            If player IsNot Nothing Then
                player.SetFFTGraphParam(TFFTGraphParamID.gpGraphType, (CType(sender, ComboBox)).SelectedIndex)
            End If
        End Sub

        Private Sub FFTLinear_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles FFTLinear.CheckedChanged
            If player IsNot Nothing Then
                If (CType(sender, CheckBox)).Checked Then
                    player.SetFFTGraphParam(TFFTGraphParamID.gpHorizontalScale, TFFTGraphHorizontalScale.gsLinear)
                Else
                    player.SetFFTGraphParam(TFFTGraphParamID.gpHorizontalScale, TFFTGraphHorizontalScale.gsLogarithmic)
                End If
            End If

        End Sub

        Private Sub ComboBox2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ComboBox2.SelectedIndexChanged
            Dim points As Integer = 0
            points = System.Convert.ToInt32(Math.Pow(2, (CType(sender, ComboBox)).SelectedIndex + 2))
            If player IsNot Nothing Then
                player.SetFFTGraphParam(TFFTGraphParamID.gpFFTPoints, points)
            End If
        End Sub

        Private Sub ComboBox3_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ComboBox3.SelectedIndexChanged
            If player IsNot Nothing Then
                player.SetFFTGraphParam(TFFTGraphParamID.gpWindow, (CType(sender, ComboBox)).SelectedIndex + 1)
            End If
        End Sub

        Private Sub CheckBox2_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles CheckBox2.CheckedChanged
            If player IsNot Nothing Then
                If (CType(sender, CheckBox)).Checked Then
                    player.SetFFTGraphParam(TFFTGraphParamID.gpFrequencyGridVisible, 1)
                    player.SetFFTGraphParam(TFFTGraphParamID.gpDecibelGridVisible, 1)
                Else
                    player.SetFFTGraphParam(TFFTGraphParamID.gpFrequencyGridVisible, 0)
                    player.SetFFTGraphParam(TFFTGraphParamID.gpDecibelGridVisible, 0)
                End If
            End If
        End Sub

        Private Sub Button17_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button17.Click
            If MessageBox.Show("This can take some time! Continue ?", "Detecting BPM", MessageBoxButtons.YesNoCancel) = System.Windows.Forms.DialogResult.Yes Then
                Dim BPM As Integer = 0
                BPM = player.DetectBPM(TBPMDetectionMethod.dmPeaks)
                MessageBox.Show("BPM: " & System.Convert.ToString(BPM), "Detected BPM", MessageBoxButtons.OK)
            End If
        End Sub

        Private Sub PictureBox1_Paint(ByVal sender As Object, ByVal e As System.Windows.Forms.PaintEventArgs) Handles PictureBox1.Paint
            Dim MyDeviceContext As IntPtr = e.Graphics.GetHdc()
            player.DrawFFTGraphOnHDC(MyDeviceContext, 0, 0, PictureBox1.Width, PictureBox1.Height)
            e.Graphics.ReleaseHdc(MyDeviceContext)
        End Sub

        Private Sub leftplayervolume_Scroll(ByVal sender As Object, ByVal e As ScrollEventArgs) Handles leftplayervolume.Scroll

        End Sub



        Private Sub Button18_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button18.Click
            LoadMode = 3
            OpenFileDialog1.ShowDialog()
        End Sub

        Private Sub CheckBox3_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CheckBox3.CheckedChanged
            If player IsNot Nothing Then
                If (CType(sender, CheckBox)).Checked Then
                    player.SetFFTGraphParam(TFFTGraphParamID.gpFrequencyScaleVisible, 1)
                    player.SetFFTGraphParam(TFFTGraphParamID.gpDecibelScaleVisible, 1)
                Else
                    player.SetFFTGraphParam(TFFTGraphParamID.gpFrequencyScaleVisible, 0)
                    player.SetFFTGraphParam(TFFTGraphParamID.gpDecibelScaleVisible, 0)
                End If
            End If
        End Sub

        Private Sub Button19_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
            player.Close()
            If Not (player.OpenFile("wavein://src=line;volume=50", TStreamFormat.sfAutodetect)) Then
                MessageBox.Show(player.GetError(), String.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error)
                Exit Sub
            End If

            showinfo()
            player.StartPlayback()
        End Sub

        Private Sub Button20_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
            player.Close()
            If Not (player.OpenFile("wavein://src=mic;volume=50", TStreamFormat.sfAutodetect)) Then
                MessageBox.Show(player.GetError(), String.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error)
                Exit Sub
            End If
            showinfo()
            player.StartPlayback()
        End Sub

        Private Sub Button21_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
            LoadMode = 0
            SaveFileDialog1.ShowDialog()
        End Sub

        Private Sub SaveFileDialog1_FileOk(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles SaveFileDialog1.FileOk
            Select Case ComboBox5.SelectedIndex
                Case 1
                    player.SetWaveOutFile(CType(sender, SaveFileDialog).FileName, TStreamFormat.sfMp3, CheckBox4.Checked)
                Case 2
                    player.SetWaveOutFile(CType(sender, SaveFileDialog).FileName, TStreamFormat.sfOgg, CheckBox4.Checked)
                Case 3
                    player.SetWaveOutFile(CType(sender, SaveFileDialog).FileName, TStreamFormat.sfFLAC, CheckBox4.Checked)
                Case 4
                    player.SetWaveOutFile(CType(sender, SaveFileDialog).FileName, TStreamFormat.sfFLACOgg, CheckBox4.Checked)
                Case 5
                    player.SetWaveOutFile(CType(sender, SaveFileDialog).FileName, TStreamFormat.sfAacADTS, CheckBox4.Checked)
                Case 6
                    player.SetWaveOutFile(CType(sender, SaveFileDialog).FileName, TStreamFormat.sfWav, CheckBox4.Checked)
                Case 7
                    player.SetWaveOutFile(CType(sender, SaveFileDialog).FileName, TStreamFormat.sfPCM, CheckBox4.Checked)
            End Select


            showinfo()
            player.StartPlayback()
        End Sub

        Private Sub Button22_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
            LoadMode = 1
            SaveFileDialog1.ShowDialog()
        End Sub

        Private Sub Button20_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button20.Click
            Dim file = "wavein://"

            Select Case ComboBox4.SelectedIndex
                Case 0
                    file = "wavein://src=line;volume=50;"
                Case 1
                    file = "wavein://src=mic;volume=50;"
                Case 2
                    file = "wavein://src=cd;volume=50;"
                Case 3
                    file = "wavein://src=midi;volume=50;"
            End Select
            player.Close()
            If Not (player.OpenFile(file, TStreamFormat.sfAutodetect)) Then
                MessageBox.Show(player.GetError(), String.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error)
                Exit Sub
            End If

            If ComboBox5.SelectedIndex > 0 Then


                Select Case ComboBox5.SelectedIndex
                    Case 1
                        SaveFileDialog1.Filter = "Mp3 File|*.mp3"
                        SaveFileDialog1.Title = "Save to mp3 file"
                    Case 2
                        SaveFileDialog1.Filter = "Ogg File|*.ogg"
                        SaveFileDialog1.Title = "Save to ogg file"
                    Case 3
                        SaveFileDialog1.Filter = "FLAC File|*.flac"
                        SaveFileDialog1.Title = "Save to FLAC file"
                    Case 4
                        SaveFileDialog1.Filter = "FLAC Ogg File|*.oga"
                        SaveFileDialog1.Title = "Save to FLAC Ogg file"
                    Case 5
                        SaveFileDialog1.Filter = "AAC File|*.aac"
                        SaveFileDialog1.Title = "Save to AAC file"
                    Case 6
                        SaveFileDialog1.Filter = "Wav File|*.wav"
                        SaveFileDialog1.Title = "Save to Wave file"
                    Case 7
                        SaveFileDialog1.Filter = "RAW PCM File|*.pcm"
                        SaveFileDialog1.Title = "Save to pcm file"
                End Select

                SaveFileDialog1.ShowDialog()
            Else
                showinfo()
                player.StartPlayback()

            End If




        End Sub
    End Class

End Namespace 'end of root namespace