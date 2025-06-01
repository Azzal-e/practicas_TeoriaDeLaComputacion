	// Práctica 1 - Ejercicio 5
	// Athanasios Usero Samarás(NIP: 839543)
%{
	#include <stdio.h>
%}
%%
^[ ]*[\n]       // línea de texto vacía
^[ ]+	{printf("    ");} // Sustituir espacios en blanco al inicio por 4 espacios
[ ]+$                   // Eliminar finales de líneas con espacios en blanco
[ ][ ]+	{printf(" ");}  // Sustituir dos o más espacios intermedios por uno
%%
int main(){ 
	int error = yylex();
	return error;
}
