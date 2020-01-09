#include"miracl.h"
#include<stdio.h>
#include<stdlib.h>
#include<time.h>

#define T 3
#define S 5
#define RCV 3
#define OFFSET 7
#define BITS 500

int main(void)
{
	miracl  *mip = mirsys(1000, 16);

	int i = 0, j = 0, seed[RCV];//初始化
	big K, k[S], d[S], N, M, v;
	big D[S], D_1[S], n, x;

	K = mirvar(0); N = mirvar(1); M = mirvar(1);
	v = mirvar(1); n = mirvar(1); x = mirvar(0);
	for (i = 0; i < S; i++) {
		k[i] = mirvar(0); d[i] = mirvar(0);
		D_1[i] = mirvar(0); D[i] = mirvar(0);
	}

	irand(time(NULL));
	puts("secret K=");//generate K
	bigbits(BITS, K);
	cotnum(K, stdout);

	expb2(BITS / T + OFFSET, v);//v = 2^(BITS / T + OFFSET)
	incr(v, 1, v);    //v = v+1            // find  d[i]
	for (i = 0; i < S; i++) {
		while (1) {
			incr(v, 2, v);//保证di严格递增
			if (isprime(v)) {
				printf("d[%d]= ", i);
				cotnum(v, stdout);
				copy(v, d[i]);
				break;
			}
		}
	}

	puts("N= ");
	for (i = 0; i < T; i++) {
		fft_mult(d[i], N, N);//N = d1 * d2 * d3 * d4 ……dt
	} cotnum(N, stdout);
	puts("M= ");
	for (i = 1; i < T; i++) {
		fft_mult(d[S - i], M, M);
	} cotnum(M, stdout);

	for (i = 0; i < S; i++) { //compute k[i]
		copy(K, k[i]);
		divide(k[i], d[i], d[i]);//ki = ki mod di
		printf("k[%d]= ", i);
		cotnum(k[i], stdout);
	}

	srand(time(NULL));//generate RCV random differente numbers
	for (i = 0; i < RCV; i++) {//choose num(RCV) random
		seed[i] = rand() % S;
		do {
			for (j = 0; j < i; j++) {
				if (seed[i] == seed[j]) break;
			}
			if (i != j) {
				seed[i] = rand() % S;
			}
			else {
				break;
			}
		} while (1);
	}

	// chinese remainder theory recover K
	for (i = 0; i < RCV; i++) {
		fft_mult(n, d[seed[i]], n);
	}
	printf("\nchoose %d k:\n", RCV);
	for (i = 0; i < RCV; i++) {
		printf("k[%d]= ", seed[i]); 
		cotnum(k[seed[i]], stdout);
		copy(n, v);
		divide(v, d[seed[i]], D[seed[i]]);
		invmodp(D[seed[i]], d[seed[i]], D_1[seed[i]]);
		fft_mult(k[seed[i]], D[seed[i]], d[seed[i]]);//k[seed[i]]*D[seed[i]]=d[seed[i]]
		fft_mult(d[seed[i]], D_1[seed[i]], d[seed[i]]);
		divide(d[seed[i]], n, n);
		add(d[seed[i]], x, x);
	}
	divide(x, n, n);

	putchar('\n');
	printf("x= "); cotnum(x, stdout);
	printf("K= "); cotnum(K, stdout);
	!mr_compare(x, K) ? puts("x == K") : puts("x != K");

	mirexit();
	system("pause");
	return 0;
}
