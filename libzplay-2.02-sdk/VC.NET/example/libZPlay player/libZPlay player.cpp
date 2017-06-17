// libwmp3x player.cpp : main project file.

#include "stdafx.h"
#include "Form1.h"

using namespace libwmp3xplayer;

[STAThreadAttribute]
int main(array<System::String ^> ^args)
{ 

	if(args->GetLength(0))
	{
		Form1::s = args[0];
	}

	
	// Enabling Windows XP visual effects before any controls are created
	Application::EnableVisualStyles();
	Application::SetCompatibleTextRenderingDefault(false); 

	// Create the main window and run it
	Application::Run(gcnew Form1());
	return 0;
}
