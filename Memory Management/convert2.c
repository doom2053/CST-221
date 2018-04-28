#include<stdio.h>
void convert(int, int);

int main()
{
	int a =0;
	int num;

	printf("Enter a decimal number between 0 and 4095 : "); //inserts decimal into the convert
	scanf("%d", &num);
	printf("\nBinary number :: "); //displays binary number
	convert(num, 2);
	printf("\n");

	printf("\nHexadecimal number :: "); //displays hexadecimal
	convert(num, 16);
	printf("\n");


	a = num << 16; //shifts the decimal left 16 bits
	printf("\n Decimal shifted left 16 bits:%d\n", a); 
	printf("\n");

printf("\nBinary number after shift :: ");
	convert(a, 2);
	printf("\n");

	printf("\nHexadecimal number after shift :: ");
	convert(a, 16);
	printf("\n");

}/*End of main()*/
 
void convert (int num, int base)
{
	int rem = num%base;
 
	if(num==0)
		return;
	convert(num/base, base);
 
	if(rem < 10)
		printf("%d", rem);
	else
		printf("%c", rem-10+'A' );
}/*End of convert()*/
