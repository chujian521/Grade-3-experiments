#define _CRT_SECURE_NO_WARNINGS
#include "miracl.h"
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include<string.h>
#define round 4

int Fermatjud_prime(big obj);

int main()

{

	FILE *fp;
	big obj;
	miracl *mip = mirsys(1500, 10);//定义的这些变量最大长度都是1500位（这个位是后面进制的位数），输入、输出、运算用的进制都是10进制。
	mip->IOBASE = 10;
	obj = mirvar(0);
	if ((fp = fopen("data.txt", "r+")) == NULL) {
		printf("Open the file failure...\n");
		exit(0);
	} 
	while (!feof(fp)) { 
		cinnum(obj, fp);
		cotnum(obj, stdout); 
		if (Fermatjud_prime(obj))
			printf("This number has a %6.4f%% probability of being a prime number.\n", 100 * (1 - pow(0.5, round)));
		else
			printf("This number is 100%% definitely a Composite number! \n");
	}

	fclose(fp);
	mirkill(obj); 
	mirexit();    
	getchar();
	return 0;
}

int Fermatjud_prime(big obj)

{
	big rando, tran, mgcd, tran1, r, num1;
	int i, j;
	int test,test1;
	miracl *mip = mirsys(1500, 10);
	mip->IOBASE = 16;
	rando = mirvar(0);//对函数中使用到的big型变量进行初始化
	tran = mirvar(0);
	mgcd = mirvar(0);
	tran1 = mirvar(0);
	r = mirvar(0);
	num1 = mirvar(1);

	i = 0;
	j = 0;
	decr(obj, 2, tran);
	decr(obj, 1, tran1);
	srand((unsigned int)time(NULL));
	for (i = 0; i<round; i++)
	{
		bigrand(obj, rando); //生成所需要的随机数
		egcd(rando, obj, mgcd);  //计算obj和生成的随机数的最大公因数

		test = mr_compare(mgcd, num1);
		if (!test)  //判断obj和随机数是否互素，它们的最大公因数如果不是1的话，compare函数将会返回1，不满足条件
		{
			powmod(rando, tran1, obj, r);  //计算 ，如果r=1，则obj可能是素数，进入下一个if语句
			test1 = mr_compare(r, num1);
			if (!test1)  
				j++ ; //j是判断因子，如果一个数能够满足在当前的轮数下，满足上述的算法，则j能够计数；如果j不等于轮数，那么这个数就不是素数;
		}

	}
	if (j == round)
		return 1;
	else
		return 0;

	mirkill(obj);
	mirkill(rando);
	mirkill(tran);
	mirkill(tran1);
	mirkill(r);
	mirkill(mgcd);
}

