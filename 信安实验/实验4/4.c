#define _CRT_SECURE_NO_WARNINGS
#include <miracl.h>
#include <mirdef.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

void encrypt(big m, big p, big g, big y, big cs[2])
{
	big one, psubone, k, tmp;
	one = mirvar(1);
	psubone = mirvar(0);
	k = mirvar(0);
	tmp = mirvar(0);
	cs[0] = mirvar(0);
	cs[1] = mirvar(0);

	decr(p, 1, psubone);
	while (1)
	{
		bigrand(psubone, k);
		if (mr_compare(k, one) >= 0)
		{
			egcd(k, y, tmp);
			if (mr_compare(tmp, one) == 0)
				break;
		}
	}
	powmod(g, k, p, cs[0]);
	powmod(y, k, p, cs[1]);
	multiply(cs[1], m, cs[1]);
	powmod(cs[1], one, p, cs[1]);

	mirkill(one);
	mirkill(psubone);
	mirkill(k);
	return;
}

big decrypt(big cs[2], big p, big x)
{
	big tmp, one, ret;

	tmp = mirvar(0);
	ret = mirvar(0);
	one = mirvar(1);

	powmod(cs[0], x, p, tmp);
	xgcd(tmp, p, tmp, tmp, tmp);
	fft_mult(cs[1], tmp, tmp);
	powmod(tmp, one, p, ret);

	mirkill(tmp);
	mirkill(one);

	return ret;
}

int main(int argc, char* argv[])
{
	miracl *mip = mirsys(1000, 10);
	char buf[1001] = { 0 };
	char msg[151] = { 0 };
	FILE* fp = NULL;
	big two, one, p, q, g, x, y, m, c, tmp, psubtwo;
	big cs[2], ret;

	mip->IOBASE = 10;
	//��ȡ�ļ�����
	if (argc != 2)
	{
		fprintf(stderr, "usage: %s <message-file-path>\n", argv[0]);
		goto exit;
	}
	if ((fp = fopen(argv[1], "r")) == NULL)
	{
		fprintf(stderr, "file open err: can't open file %s !\n", argv[1]);
		goto exit;
	}
	if (fread(msg, sizeof(char), 150, fp) <= 0)
	{
		fprintf(stderr, "file read err: can't read file %s !\n", argv[1]);
		fclose(fp);
		goto exit;
	}
	fclose(fp);

	//��ʼ������
	one = mirvar(1);
	two = mirvar(2);
	p = mirvar(0);
	q = mirvar(0);
	g = mirvar(2);
	x = mirvar(0);
	y = mirvar(0);
	m = mirvar(0);
	c = mirvar(0);
	tmp = mirvar(0);
	psubtwo = mirvar(0);
	irand(time(NULL));

	//
	cinstr(m, msg);


	//ѡȡ�������q��p
	//����ǿ����p��p=2q+1
	while (1)
	{
		bigbits(499, q);
		if (isprime(q))
			break;
	}

	while (1)
	{
		add(q, two, q);
		if (!isprime(q))
		{
			continue;
		}
		add(q, q, p);
		add(p, one, p);
		if (isprime(p))
		{
			break;
		}
	}

	//��ȡ����Ԫg
	do {
		powmod(g, two, p, tmp);
		if (mr_compare(tmp, one) > 0)
		{
			powmod(g, q, p, tmp);
			if (mr_compare(tmp, one) > 0) {
				break;
			}
		}
		add(g, one, g);

	} while (mr_compare(g, p) < 0);

	//���ȡx,  1<x<p-2
	decr(p, 2, psubtwo);
	do {
		bigrand(psubtwo, x);
	} while (mr_compare(x, one) <= 0);

	//����y,??=??^?? ?????? ??
	powmod(g, x, p, y);

	//�����Կ
	printf("��Կ��\n");
	memset(buf, 0, 501);
	cotstr(p, buf);
	printf("p = %s\n", buf);
	memset(buf, 0, 501);
	cotstr(g, buf);
	printf("g = %s\n", buf);
	memset(buf, 0, 501);
	cotstr(y, buf);
	printf("y = %s\n", buf);
	printf("\n");


	//���˽Կ
	printf("˽Կ��\n");
	memset(buf, 0, 501);
	cotstr(x, buf);
	printf("x = %s\n", buf);
	printf("\n");

	//����
	encrypt(m, p, g, y, cs);

	//���y1��y2
	printf("���ģ�\n");
	memset(buf, 0, 501);
	cotstr(cs[0], buf);
	printf("y1 = %s\n", buf);
	memset(buf, 0, 501);
	cotstr(cs[1], buf);
	printf("y2 = %s\n", buf);
	printf("\n");

	//����
	ret = decrypt(cs, p, x);

	//�����ԭ����Ϣ
	printf("���ģ�\n");
	memset(buf, 0, 501);
	cotstr(ret, buf);
	printf("message = %s\n", buf);
	printf("\n");

	system("pause");
exit:
	mirexit();
	return 0;
}

