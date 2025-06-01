	// Práctica 3, ejercicio 23
	// Athanasios Usero, NIP: 839543
%{
#include "y.tab.h"
extern int ac;
%}
%%
"+"	{return(ADD);}
"-"	{return(SUB);}
"*"	{return(MUL);}
"/"	{return(DIV);}
"("	{return(OP);}
")"	{return(CP);}
acum":="	{return (AS);} // Asignación de nuevo valor a acum
acum		{yylval = ac; return(NUMBER);} // Uso de acum en operación
[0-9]+	{yylval = atoi(yytext); return(NUMBER);}
\n	{return(EOL);}
[ \t]	{/* ignorar espacios */}
.	{return(yytext[0]); /* caracter inesperado */}
%%
