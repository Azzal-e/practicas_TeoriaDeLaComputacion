	// Práctica 3, ejercicio 23
	// Athanasios Usero, NIP: 839543
%{
#include <stdio.h>
extern int yylex();
extern int yyerror();
int ac;
%}
%token NUMBER EOL CP OP AS
%start calclist
%token ADD SUB
%token MUL DIV
%%
calclist : /* nada */
	| calclist exp EOL { printf("=%d\n", $2); }
	| calclist AS exp EOL {ac = $3;} // Línea con asignación a variable acum
	;
exp : 	factor 
	| exp ADD factor { $$ = $1 + $3;}
	| exp SUB factor { $$ = $1 - $3;}	
	;
factor : 	factor MUL factorsimple { $$ = $1 * $3; }
		| factor DIV factorsimple { $$ = $1 / $3; }
		| factorsimple
		;
factorsimple : 	OP exp CP { $$ = $2; }
		| NUMBER 
		;
%%
int yyerror(char* s) {
   printf("\n%s\n", s);
   return 0;
}
int main() {
  yyparse();
}
