#include "stdafx.h"
#include <shellapi.h>

int APIENTRY WinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPSTR     lpCmdLine,
                     int       nCmdShow)
{
	ShellExecute(NULL, "open", "xulrunner/xulrunner.exe", "xului/application.ini", NULL, 9);
	return 0;
}