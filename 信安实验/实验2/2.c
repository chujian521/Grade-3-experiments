#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include "miracl.h"
#include <windows.h>

#define SIZE 50

int main() {
	FILE *fp;
	big a[SIZE], m[SIZE], t[SIZE], x[SIZE];
	big Xul, Mul, GCD, Mi, Mj, Mm, re;
	int i, k, b, j, flag;

	miracl *mip = mirsys(10000, 10);  
	mip->IOBASE = 10;
	Xul = mirvar(0);
	Mul = mirvar(1);
	GCD = mirvar(0);
	Mi = mirvar(1);
	Mj = mirvar(1);
	Mm = mirvar(0);
	re = mirvar(0);

	if ((fp = fopen("14.txt", "r")) == NULL) {
		printf("打开文件失败...\n");
		return -1;
	}
	//将文件内的数据读入数组
	for (b = 0; !feof(fp); b++) {
		t[b] = mirvar(0);  //先初始化
		cinnum(t[b], fp);  //读入数据
	}
	//再分别将数据放入a和m数组，前一半a，后一半m
	k = (b - 1) / 2;
	printf("a数组:\n");
	for (i = 0; i < k; i++) {
		a[i] = mirvar(0);
		a[i] = t[i];
		printf("a[%d]=", i);
		cotnum(t[i], stdout);
		x[i] = mirvar(1);  //顺便初始化
	}
	printf("m数组:\n");
	for (i = k; i < b - 1; i++) {
		m[i - k] = mirvar(0);
		m[i - k] = t[i];
		printf("m[%d]=", i - k);
		cotnum(t[i], stdout);
	}

	//比较m数组的数据，判断是否达到中国剩余定理的条件（两两互素）
	flag = 1;
	for (i = 0; i < k; i++) {
		for (j = 0; j < k; j++) {
			if (i == j) {
				continue;
			}
			else {
				egcd(m[i], m[j], GCD);  //计算最大公因数
				if (mr_compare(GCD, mirvar(1))) {   //不为1跳出
					flag = 0;
					break;
				}
			}
		}
		if (!flag) {
			break;
		}
	}

	if (!flag) {
		printf("不能直接利用中国剩余定理...");
	}
	else {
		for (i = 0; i < k; i++) {
			multiply(Mul, m[i], Mul);  //计算Mul=M1*M2*...*Mn
		}
		for (i = 0; i < k; i++)
		{
			fdiv(Mul, m[i], Mi);  //Mi=Mul/m[i]
			xgcd(Mi, m[i], Mj, Mj, Mj);   //Mj =invers(Mi,m[i]); 即求Mi的模逆（Example: xgcd(x,p,x,x,x); //x=x^-1 mod p）
			multiply(Mi, Mj, Mm);   //Mm=Mi*Mj
			multiply(Mm, a[i], x[i]);  //x[i]=Mi*Mj*a[i]
		}
		for (i = 0; i < k; i++)
		{
			add(Xul, x[i], Xul);  //累加
		}

		powmod(Xul, mirvar(1), Mul, re);  //re=Xul^1 mod Mul；即re=Xul%Mul
		printf("结果为:\n");
		cotnum(re, stdout);
	}

	mirkill(Xul);
	mirkill(Mul);
	mirkill(GCD);
	mirkill(Mi);
	mirkill(Mj);
	mirkill(Mm);
	mirkill(re);

	system("pause");
	return 0;
}