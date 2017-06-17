Imports example1.libZPlay
Module Module1

    Sub Main()
        Console.WriteLine("Playing test.mp3. Press Q to quit.")
        Dim player As New ZPlay()
        If player.OpenFile("test.mp3", TStreamFormat.sfAutodetect) = False Then
            Console.WriteLine(player.GetError())
            Return
        End If
        Dim info As New TStreamInfo()
        player.GetStreamInfo(info)
        Console.WriteLine("Length: {0:G}:{1:G}:{2:G}:{3:G}", info.Length.hms.hour, info.Length.hms.minute, info.Length.hms.second, info.Length.hms.millisecond)

        player.StartPlayback()

        Dim status As New TStreamStatus()
        Dim time As New TStreamTime()
        status.fPlay = True
        Dim cki As ConsoleKeyInfo

        Do While status.fPlay
            player.GetPosition(time)
            Console.Write("Pos: {0:G}:{1:G}:{2:G}:{3:G}" & Constants.vbCr, time.hms.hour, time.hms.minute, time.hms.second, time.hms.millisecond)
            player.GetStatus(status)
            System.Threading.Thread.Sleep(50)
            If Console.KeyAvailable Then
                cki = Console.ReadKey(True)
                If cki.Key = ConsoleKey.Q Then
                    player.StopPlayback()
                End If
            End If
        Loop

    End Sub

End Module
