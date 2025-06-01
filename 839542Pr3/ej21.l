	// Práctica 3, ejercicio 21
	// Athanasios Usero, NIP: 839543
%{
#include <stdio.h>
#include <math.h>
#include "y.tab.h"
extern int base;
int conv;
%}
%%
"+"	{return(ADD);}
"-"	{return(SUB);}
"*"	{return(MUL);}
"/"	{return(DIV);}
"("	{return(OP);}
")"	{return(CP);}
"=" {return(IG);}
b {return(BASE); } 
[0-9]+b  {conv = 0; for(unsigned i = 0; i < yyleng - 1; i++){ // Conversión de base a decimal
						conv = conv + (int)(yytext[i] - '0') * pow(base,yyleng - 2 - i);
						}
						yylval = conv; return(NUMBER);}
[0-9]+	{yylval = atoi(yytext); return(NUMBER);}
\n	{return(EOL);}
[ \t]	{ }
.	{return(yytext[0]); /* caracter inesperado */}
%%