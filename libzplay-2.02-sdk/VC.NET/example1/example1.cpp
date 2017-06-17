// example1.cpp : main project file.

#include "stdafx.h"
#include "../libzplayNET.h"


using namespace System;
using namespace libZPlay;

int main(array<System::String ^> ^args)
{
     Console::WriteLine("Playing test.mp3. Press Q to quit.");
    ZPlay ^player;
    player = gcnew ZPlay();


    if (player->OpenFile("test.mp3", TStreamFormat::sfAutodetect) == false)
    {
        Console::WriteLine(player->GetError());
		delete player;
        return 0;
    }
    TStreamInfo info;
    player->GetStreamInfo(info);
    Console::WriteLine("Length: {0:G}:{1:G}:{2:G}:{3:G}", info.Length.hms.hour,
    info.Length.hms.minute,
    info.Length.hms.second,
    info.Length.hms.millisecond);

    player->StartPlayback();

    TStreamStatus status;
    TStreamTime time;
    status.fPlay = true;
    ConsoleKeyInfo cki;

    while (status.fPlay)
    {
        player->GetPosition(time);
        Console::Write("Pos: {0:G}:{1:G}:{2:G}:{3:G}r", time.hms.hour,
        time.hms.minute,
        time.hms.second,
        time.hms.millisecond);

        player->GetStatus(status);
        System::Threading::Thread::Sleep(50);
        if (Console::KeyAvailable)
        {
            cki = Console::ReadKey(true);
            if (cki.Key == ConsoleKey::Q)
            player->StopPlayback();
        }
    }

    delete player;
    return 0;

}
