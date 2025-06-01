	// Práctica 3, ejercicio 21
	// Athanasios Usero, NIP: 839543
%{
#include <stdio.h>
extern int yylex();
extern int yyerror();
int base; // Variable que almacena la base adicional aceptada
%}
%token NUMBER BASE EOL CP OP IG 
%start calclist
%token ADD SUB
%token MUL DIV
%%

calclist : /* nada */
	| calclist exp EOL { printf("=%d\n", $2); }
	| calclist BASE IG NUMBER EOL {base = $4;} // Regla de producción de un cambio de base
	;
exp : 	factor 
	| exp ADD  factor { $$ = $1 + $3; }
	| exp SUB factor { $$ = $1 - $3; }	
	;
factor : 	factor MUL  factorsimple { $$ = $1 * $3; }
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

