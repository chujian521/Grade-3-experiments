#include <windows.h>
#include <stdio.h>
#include<time.h>
#include<string.h>
#include<stdlib.h>

DWORD WINAPI ThreadProc1( LPVOID lpParam ) 
{	
	int len,id;
	TCHAR str[100] = { 0 };
	//获取本DLL的文件路径
	TCHAR szCurrent[100] = { 0 };
	HMODULE hModule = GetModuleHandle("kernel32.dll");

	if (hModule)
	{
		GetModuleFileName(hModule/*NULL*/, szCurrent, 519);
	}
	id = GetCurrentThreadId();
	sprintf(str,"%d",id);
	sprintf(szCurrent,"%s%s%s",szCurrent,";id=",str);
	MessageBox(NULL,TEXT(szCurrent),TEXT("Win_prog"),MB_YESNO|MB_ICONQUESTION);

}
int main()
{
    //让主线程进入循环，主线程若退出，子线程1，2会被系统“杀死”
  //创建线程1
    CreateThread( 
        NULL,              // default security attributes
        0,                 // use default stack size  
        ThreadProc1,        // thread function 
        NULL,             // argument to thread function 
        0,                 // use default creation flags 
        NULL);           // returns the thread identifier 
  	while(1);
  	return 0;
}

