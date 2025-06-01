	// Práctica 3, ejercicio 22
	// Athanasios Usero, NIP: 839543
%{
#include "y.tab.h"
%}
%%
"+"	{return(ADD);}
"-"	{return(SUB);}
"*"	{return(MUL);}
"/"	{return(DIV);}
"("	{return(OP);}
")"	{return(CP);}
"=" {return(IG);}
";" {return(PC);} // Fin de expresión para mostrar en decimal
b {return(BASE);}
";"b	{return (LC);} // Fin de expresión para codificar en base
[0-9]+	{yylval = atoi(yytext); return(NUMBER);}
\n	{return(EOL);}
[ \t]	{ }
.	{return(yytext[0]); /* caracter inesperado */}
%%