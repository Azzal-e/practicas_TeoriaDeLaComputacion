	// Práctica 3, ejercicio 22
	// Athanasios Usero, NIP: 839543
%{
#include <stdio.h>
#include <math.h>
extern int yylex();
extern int yyerror();
int base, conv, aux, pos, esNeg;
%}
%token NUMBER EOL CP OP PC LC IG BASE
%start calclist
%token ADD SUB
%token MUL DIV
%%
calclist : /* nada */
	| calclist exp PC EOL { printf("=%d\n", $2); } // Linea con finalización de resultado decimal
	| calclist exp LC EOL {aux = $2;esNeg = 0; if(aux < 0){aux = -aux; esNeg = 1;}	
						conv = aux % base; aux = aux / base; pos = 1; while(aux != 0){
						// Conversión del resultado de decimal a base.
						conv = conv + (aux % base) * pow(10, pos);
						aux = aux / base;
						pos = pos + 1;
						}
						if(esNeg == 1){$$ = -conv;} else{$$ = conv;}
						printf("=%d\n", $$);}
	| calclist BASE IG NUMBER EOL {base = $4;} // Actualización de base
	;
exp : 	factor 
	| exp ADD factor { $$ = $1 + $3; }
	| exp SUB factor { $$ = $1 - $3; }	
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

