#include <windows.h>

int main()
{
	ShellExecute(NULL, "open", "xulrunner/xulrunner.exe", "xului/application.ini", NULL, 9);
    return 0;
}
