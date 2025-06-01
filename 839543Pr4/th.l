	// Práctica 4
	// Athanasios Usero, NIP: 839543
%{
#include<string.h>
#include "y.tab.h"
%}


%%
graph		{return(GRAPH);}
[a-zA-Z_0-9]*[a-zA-Z_][a-zA-Z_0-9]*	{return(NOMBRE);}
[0-9]+		{yylval.nombre=strdup(yytext);return(ID);}
->		{return(FLECHA);}	
,		{return(COMA);}
;		{return(PYC);}
"{"		{return(LLAVEIZQ);}
"}"		{return(LLAVEDER);}
"("		{return(PARENTIZQ);}
")"		{return(PARENTDER);}
[\n]	{return(FL);}
[ \t]	// Se ignoran espacios.
%%

