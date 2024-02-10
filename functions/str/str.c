#include "str.h"

int IsNumeric(const char* str) {
	while (*str) {
		if (*str < '0' || *str > '9')
			return 0;
		str++;
	}

	return 1;
}

int StringToInt(const char* str) {
	int result = 0;
	int sign = 1;

	while (*str == ' ' || (*str >= 9 && *str <= 13)) {
		str++;
	}

	if (*str == '+' || *str == '-') {
		sign = (*str++ == '-') ? -1 : 1;
	}

	while (*str >= '0' && *str <= '9') {
		result = result * 10 + (*str++ - '0');
	}

	return result * sign;
}

void IntToString(int num, char* buffer) {
	int i = 0;
	int isNegative = 0;

	if (num < 0) {
		isNegative = 1;
		num = -num;
	}

	do {
		buffer[i++] = (char)('0' + num % 10);
		num /= 10;
	} while (num > 0);

	if (isNegative) {
		buffer[i++] = '-';
	}

	buffer[i] = '\0';

	int lenght = i;
	for (i = 0; i < lenght / 2; ++i) {
		char temp = buffer[i];
		buffer[i] = buffer[lenght - i - 1];
		buffer[lenght - i - 1] = temp;
	}
}