	// Práctica 2, ejercicio 2
	// Athanasios Usero, NIP: 839543
%{
	#include <stdio.h>
%}
%%
^[b]*a[a]*b(a[a]*b)*b(b[a]*b(a[a]*b)*b)*a[a]*b[a]*b((a|b)[a]*b[a]*b)*$	{printf("**"); REJECT;} // Secuencia de reinicio de completo del autómata M1, y preparación para comprobar si también autómata M2
^(a|(ba))*bb[b]*a[a]*b((b|(a[a]*b))[b]*a[a]*b)*$	{printf("--"); printf(yytext);}	// Secuencia de reinicio completo del autómata M2
%%
int main(){
	int error = yylex();
	return error;
}
