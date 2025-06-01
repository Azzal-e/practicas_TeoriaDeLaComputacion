	// Práctica 1 - Ejercicio 6
	// Athanasios Usero Samarás(NIP: 839543)
%{
	#include <stdio.h>
	int nl, nc, nb, nt, ns, nCons, aux = 0;  // declaración de variables contadoras
%} 
DIGITO [0-9] 
CONSONANTE [b-zB-Z]{-}[aeiouAEIOU]
%%
^[ ]*[\n]	{nb++; nl ++; aux = nl; nc += yyleng -1;} // Contabilización líneas en blanco
[\n]	{nl++; aux = nl;} // Contabilización de líneas
{DIGITO}+	{nt++; nc += yyleng;} // Contabilización de números
[.,:;] 	{if(aux == nl){aux++; ns++;}; nc += yyleng;} // Contabilización de líneas con algún signo de puntuación
^[ ]*{CONSONANTE}	{nCons++; nc += yyleng;}  // Contabilización de líneas que empiecen por consonante
.		{nc++;} // Contabilización de caracteres restantes
%%
int main(){
	int error = yylex();
	if (error == 0){
		printf("TL:%d\n", nl);
		printf("TB:%d\n", nb);
		printf("TC:%d\n", nc);
		printf("TN:%d\n", nt);
		printf("TS:%d\n", ns);
		printf("TCons:%d\n", nCons);
	}
	return error;
}
