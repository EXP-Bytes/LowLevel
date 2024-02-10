#include "op.h"

int Osszeg(int x) {
	int r, s = 0;

	do {
		r = x % 10;
		s += r;
		x /= 10;
	} while (x != 0);

	return s;
}

int Szama(int x) {
	int k = 0;

	do {
		k++;
		x /= 10;
	} while (x != 0);

	return k;
}

int Minimum(int x) {
	int r, min = x;

	do {
		r = x % 10;

		if(r < min)
			min = r;

		x /= 10;
	} while (x != 0);

	return min;
}

int Maximum(int x) {
	int r, max = 0;

	do {
		r = x % 10;

		if (r > max)
			max = r;

		x /= 10;
	} while (x != 0);

	return max;
}

int Tukor(int x) {
	int r, t = 0;

	do {
		r = x % 10;
		t = t * 10 + r;
		x /= 10;
	} while (x != 0);

	return t;
}

int Duplazott(int x) {
	int r, y = 0, p = 1;

	do {
		r = x % 10;
		y = y + r * p;
		p = p * 10;
		y = y + r * p;
		p = p * 10;
		x /= 10;
	} while (x != 0);

	return y;
}