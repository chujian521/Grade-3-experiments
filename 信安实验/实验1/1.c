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
	miracl *mip = mirsys(1500, 10);//�������Щ������󳤶ȶ���1500λ�����λ�Ǻ�����Ƶ�λ���������롢����������õĽ��ƶ���10���ơ�
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
	rando = mirvar(0);//�Ժ�����ʹ�õ���big�ͱ������г�ʼ��
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
		bigrand(obj, rando); //��������Ҫ�������
		egcd(rando, obj, mgcd);  //����obj�����ɵ���������������

		test = mr_compare(mgcd, num1);
		if (!test)  //�ж�obj��������Ƿ��أ����ǵ���������������1�Ļ���compare�������᷵��1������������
		{
			powmod(rando, tran1, obj, r);  //���� �����r=1����obj������������������һ��if���
			test1 = mr_compare(r, num1);
			if (!test1)  
				j++ ; //j���ж����ӣ����һ�����ܹ������ڵ�ǰ�������£������������㷨����j�ܹ����������j��������������ô������Ͳ�������;
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

