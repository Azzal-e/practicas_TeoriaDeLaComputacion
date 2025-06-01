	// Práctica 3, ejercicio 3
	// Athanasios Usero, NIP: 839543
%{
#include "y.tab.h"
%}
%%
x	{return(X);}
y	{return(Y);}
z	{return(Z);}
\n	{return(EOL);}
.	{return(yytext[0]); /* caracter inesperado */}
%%
