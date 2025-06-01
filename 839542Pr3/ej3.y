	// Práctica 3, ejercicio 3
	// Athanasios Usero, NIP: 839543
%{
#include <stdio.h>
extern int yylex();
extern int yyerror();
%}
%token Z X Y EOL
%start entrada
%%
entrada: /* Nada */ // Para reconocer una entrada válida (o no).
		| s EOL
		;
s :	/* Nada(epsilon) */ // Reglas de producción del símbolo no terminal s
  | c X s 
  ;
b : X c Y   // Reglas de producción del símbolo no terminal b
  | X c
  ;
c : X b X    // Reglas de producción del símbolo no terminal c
  | Z
  ;
%%
int yyerror(char* s) {
   printf("\n%s\n", s);
   return 0;
}
int main() {
  yyparse();
}

