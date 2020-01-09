#ifndef __SM2_HEADER_2015_12_28__
#define __SM2_HEADER_2015_12_28__
#include "sm3.h"
#include "miracl.h"
#ifdef __cplusplus
extern "C" {
#endif
	void sm2_keygen(unsigned char *wx, int *wxlen, unsigned char *wy, int *wylen, unsigned char *privkey, int *privkeylen);
	int  sm2_encrypt(unsigned char *msg, int msglen, unsigned char *wx, int wxlen, unsigned char *wy, int wylen, unsigned char *outmsg);
	int  sm2_decrypt(unsigned char *msg, int msglen, unsigned char *privkey, int privkeylen, unsigned char *outmsg);
#ifdef __cplusplus
}
#endif
#endif