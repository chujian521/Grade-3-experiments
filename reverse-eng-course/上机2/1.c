#include <stdio.h>
#include <windows.h>

int main(int argc,char *argv[])
{
	char szCommandLine[] = "\"D:\\Program Files\\odbg201\\ollydbg.exe\""; 
	STARTUPINFO si = { sizeof(si) };
	PROCESS_INFORMATION pi;
	si.dwFlags = STARTF_USESHOWWINDOW; // 指定wShowWindow成员有效
	si.wShowWindow = TRUE; // 此成员设为TRUE的话则显示新建进程的主窗口

	BOOL bRet = CreateProcess (
		NULL,	// 不在此指定可执行文件的文件名
		szCommandLine,// 命令行参数
		NULL,	// 默认进程安全性
		NULL,	// 默认进程安全性
		FALSE,	// 指定当前进程内句柄不可以被子进程继承
		CREATE_NEW_CONSOLE,	// 为新进程创建一个新的控制台窗口
		NULL,	// 使用本进程的环境变量
		NULL,	// 使用本进程的驱动器和目录
		&si,
		&pi);
	if(bRet)
	{
		// 不使用的句柄关掉
		CloseHandle(pi.hThread);
		CloseHandle(pi.hProcess);
		printf("新进程的ID号：%d\n",pi.dwProcessId);
		printf("新进程的主线程ID号：%d\n",pi.dwThreadId);
	}
	return 0;
}

