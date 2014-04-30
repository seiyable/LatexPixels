#include <stdio.h>

int main(void)
{
	int *p,i;
	p = &i;
	printf("p = %p\n",p);
	printf("&i = %p\n",&i);
	return 0;
}