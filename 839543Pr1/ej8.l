	// Práctica 1 - Ejercicio 8
	// Athanasios Usero Samarás(NIP: 839543)
%{
	#include <stdio.h>
%}
%%
I(([H]*V){3})*[H]*F		{printf("++"); printf(yytext); printf("++");} // movimientos verticales múltiplos de 3
I(([H]*V){6})*([H]*V[H]*V[H]*){1,2}F	  {printf("+"); printf(yytext); printf("+");} //movimientos verticales pares no múltiplos de 3
I[H]*V(([H]*V){2})*[H]*F	  {printf("-"); printf(yytext); printf("-");} //movimientos verticales impares para determinar movimientos verticales impares no múltiplos de 3								
%%
int main(){
	int error = yylex();
	return error;
}
																																								