#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include "sm2.h"
#include <miracl.h>

#define SM2_PAD_ZERO TRUE
#define SM2_DEBUG   0

struct FPECC {
	char *p;
	char *a;
	char *b;
	char *n;
	char *x;
	char *y;
};
///*SM2初始化各种参数*/
struct FPECC Ecc256 = {
"FFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF",//p
"FFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFC",//a
"28E9FA9E9D9F5E344D5A9E4BCF6509A7F39789F515AB8F92DDBCBD414D940E93",//b
"FFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFF7203DF6B21C6052B53BBF40939D54123",//n
"32C4AE2C1F1981195F9904466A39C9948FE30BBFF2660BE1715A4589334C74C7",//Gx
"BC3736A2F4F6779C59BDCEE36B692153D0A9877CC62A474002DF32E52139F0A0",//Gy
};

#define SEED_CONST 0x1BD8C95A
//秘密钥生成函数
void sm2_keygen(unsigned char *wx, int *wxlen, unsigned char *wy, int *wylen, unsigned char *privkey, int *privkeylen)
{
	struct FPECC *cfig = &Ecc256;
	epoint *g;
	big a, b, p, n, x, y, key1;
	miracl *mip = mirsys(20, 0);

	mip->IOBASE = 16;

	p = mirvar(0);
	a = mirvar(0);
	b = mirvar(0);
	n = mirvar(0);
	x = mirvar(0);
	y = mirvar(0);

	key1 = mirvar(0);
	//将给定数据赋值给对应变量
	cinstr(p, cfig->p);
	cinstr(a, cfig->a);
	cinstr(b, cfig->b);
	cinstr(n, cfig->n);
	cinstr(x, cfig->x);
	cinstr(y, cfig->y);
	//初始化椭圆曲线
	ecurve_init(a, b, p, MR_PROJECTIVE);
	g = epoint_init();
	epoint_set(x, y, 0, g);

	//初始化随机种子
	irand(time(NULL) + SEED_CONST);
	bigrand(n, key1); //随机数dB
	ecurve_mult(key1, g, g);//倍点运算后的g点即为PB
	epoint_get(g, x, y);//得到PB的x和y坐标

	*wxlen = big_to_bytes(32, x, (char *)wx, TRUE);
	*wylen = big_to_bytes(32, y, (char *)wy, TRUE);
	*privkeylen = big_to_bytes(32, key1, (char *)privkey, TRUE);

	mirkill(key1);
	mirkill(p);
	mirkill(a);
	mirkill(b);
	mirkill(n);
	mirkill(x);
	mirkill(y);
	epoint_free(g);
	mirexit();
}
//密钥派生函数
int kdf(unsigned char *zl, unsigned char *zr, int klen, unsigned char *kbuf)
{
	unsigned char buf[70];
	unsigned char digest[32];
	unsigned int ct = 0x00000001;
	int i, m, n;
	unsigned char *p;
	memcpy(buf, zl, 32);
	memcpy(buf + 32, zr, 32);
	m = klen / 32;
	n = klen % 32;
	p = kbuf;
	for (i = 0; i < m; i++)
	{
		buf[64] = (ct >> 24) & 0xFF;
		buf[65] = (ct >> 16) & 0xFF;
		buf[66] = (ct >> 8) & 0xFF;
		buf[67] = ct & 0xFF;
		sm3(buf, 68, p);
		p += 32;
		ct++;
	}
	if (n != 0)
	{
		buf[64] = (ct >> 24) & 0xFF;
		buf[65] = (ct >> 16) & 0xFF;
		buf[66] = (ct >> 8) & 0xFF;
		buf[67] = ct & 0xFF;
		sm3(buf, 68, digest);
	}
	memcpy(p, digest, n);
	for (i = 0; i < klen; i++)
	{
		if (kbuf[i] != 0)
			break;
	}
	if (i < klen)
		return 1;
	else
		return 0;
}
int sm2_encrypt(unsigned char *msg, int msglen, unsigned char *wx, int wxlen, unsigned char *wy, int wylen, unsigned char *outmsg)
{
	struct FPECC *cfig = &Ecc256;
	big x2, y2, c1, c2, k;
	big a, b, p, n, x, y;
	epoint *g, *w;
	int ret = -1;
	int i;
	unsigned char zl[32], zr[32];
	unsigned char *tmp;
	miracl *mip;

	tmp = malloc(msglen + 64);
	if (tmp == NULL)
		return -1;

	mip = mirsys(20, 0);
	mip->IOBASE = 16;
	p = mirvar(0);
	a = mirvar(0);
	b = mirvar(0);
	n = mirvar(0);
	x = mirvar(0);
	y = mirvar(0);
	k = mirvar(0);
	x2 = mirvar(0);
	y2 = mirvar(0);
	c1 = mirvar(0);
	c2 = mirvar(0);
	cinstr(p, cfig->p);
	cinstr(a, cfig->a);
	cinstr(b, cfig->b);
	cinstr(n, cfig->n);
	cinstr(x, cfig->x);
	cinstr(y, cfig->y);
	//初始化椭圆曲线
	ecurve_init(a, b, p, MR_PROJECTIVE);
	g = epoint_init();
	w = epoint_init();
	epoint_set(x, y, 0, g);
	bytes_to_big(wxlen, (char *)wx, x);
	bytes_to_big(wylen, (char *)wy, y);
	epoint_set(x, y, 0, w);
	irand(time(NULL) + SEED_CONST);

sm2_encrypt_again:
	do
	{
		bigrand(n, k);//产生随机大数k
	} while (k->len == 0);
	ecurve_mult(k, g, g);//倍点运算得到C1
	epoint_get(g, c1, c2);
	big_to_bytes(32, c1, (char *)outmsg, TRUE);//将C1的坐标表示为字节码
	big_to_bytes(32, c2, (char *)outmsg + 32, TRUE);
	//判断S是否为无穷远点
	if (point_at_infinity(w))
		goto exit_sm2_encrypt;
	//计算kPb并将其表示为字节码
	ecurve_mult(k, w, w);//kPB = (x2,y2)
	epoint_get(w, x2, y2);
	big_to_bytes(32, x2, (char *)zl, TRUE);
	big_to_bytes(32, y2, (char *)zr, TRUE);
	//计算t，利用密钥派生函数
	if (kdf(zl, zr, msglen, outmsg + 64) == 0)
		goto sm2_encrypt_again;
	//将M与t逐字节进行异或得到C2
	for (i = 0; i < msglen; i++)
	{
		outmsg[64 + i] ^= msg[i];
	}
	//将x2，M，y2连接，并计算其哈希值
	memcpy(tmp, zl, 32);
	memcpy(tmp + 32, msg, msglen);
	memcpy(tmp + 32 + msglen, zr, 32);
	sm3(tmp, 64 + msglen, &outmsg[64 + msglen]);//*outmsg为加密后的密文
	//得到的密文总长度为96加明文长度
	ret = msglen + 64 + 32;
exit_sm2_encrypt:
	mirkill(x2);
	mirkill(y2);
	mirkill(c1);
	mirkill(c2);
	mirkill(k);
	mirkill(a);
	mirkill(b);
	mirkill(p);
	mirkill(n);
	mirkill(x);
	mirkill(y);
	epoint_free(g);
	epoint_free(w);
	mirexit();
	free(tmp);
	return ret;
}
int sm2_decrypt(unsigned char *msg, int msglen, unsigned char *privkey, int privkeylen, unsigned char *outmsg)
{
	struct FPECC *cfig = &Ecc256;
	big x2, y2, c, k;
	big a, b, p, n, x, y, key1;
	epoint *g;
	unsigned char c3[32];
	unsigned char zl[32], zr[32];
	int i, ret = -1;
	unsigned char *tmp;
	miracl *mip;
	if (msglen < 96)
		return 0;
	msglen -= 96;
	tmp = malloc(msglen + 64);
	if (tmp == NULL)
		return 0;
	mip = mirsys(20, 0);
	mip->IOBASE = 16;
	x2 = mirvar(0);
	y2 = mirvar(0);
	c = mirvar(0);
	k = mirvar(0);
	p = mirvar(0);
	a = mirvar(0);
	b = mirvar(0);
	n = mirvar(0);
	x = mirvar(0);
	y = mirvar(0);
	key1 = mirvar(0);
	bytes_to_big(privkeylen, (char *)privkey, key1);
	cinstr(p, cfig->p);
	cinstr(a, cfig->a);
	cinstr(b, cfig->b);
	cinstr(n, cfig->n);
	cinstr(x, cfig->x);
	cinstr(y, cfig->y);
	ecurve_init(a, b, p, MR_PROJECTIVE);
	g = epoint_init();
	bytes_to_big(32, (char *)msg, x);
	bytes_to_big(32, (char *)msg + 32, y);
	if (!epoint_set(x, y, 0, g))
		goto exit_sm2_decrypt;
	if (point_at_infinity(g))
		goto exit_sm2_decrypt;
	ecurve_mult(key1, g, g);
	epoint_get(g, x2, y2);
	big_to_bytes(32, x2, (char *)zl, TRUE);
	big_to_bytes(32, y2, (char *)zr, TRUE);

	if (kdf(zl, zr, msglen, outmsg) == 0)
		goto exit_sm2_decrypt;
	for (i = 0; i < msglen; i++)
	{
		outmsg[i] ^= msg[i + 64];
	}
	memcpy(tmp, zl, 32);
	memcpy(tmp + 32, outmsg, msglen);
	memcpy(tmp + 32 + msglen, zr, 32);
	sm3(tmp, 64 + msglen, c3);
	if (memcmp(c3, msg + 64 + msglen, 32) != 0)
		goto exit_sm2_decrypt;
	ret = msglen;
exit_sm2_decrypt:
	mirkill(x2);
	mirkill(y2);
	mirkill(c);
	mirkill(k);
	mirkill(p);
	mirkill(a);
	mirkill(b);
	mirkill(n);
	mirkill(x);
	mirkill(y);
	mirkill(key1);
	epoint_free(g);
	mirexit();
	free(tmp);
	return ret;
}