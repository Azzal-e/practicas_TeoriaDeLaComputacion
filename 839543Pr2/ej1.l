	// Práctica 2, ejercicio 1
	// Athanasios Usero, NIP: 839543
%{
	#include <stdio.h>
	int l1 = 0, l2 = 0, l3 =0, c = 0, r = 0, i = 0, accionAnt, nllavesizq = 0, nllavesdcha = 0;
%}
%x reglas usuario acciones comentario codigo
%%
[\n]		{l1++;} // línea en estado INITIAL, sección de declaraciones
^"%%"		{BEGIN(reglas); l2--;} // Cambio de sección, se pasa al estado de la sección de reglas y se resta la línea de cambio de sección
<reglas,acciones,codigo>[\n]		{l2++;} // línea en uno de los estados asociados a la sección de reglas
<reglas>^[^ ]	{r++;} // En la sección de reglas (fuera de una acción), se comienza un línea con un caracter para definir un regla
<reglas>"{"	{BEGIN(acciones);} // Primer carácter "{", se inicia una acción
<acciones>"{" {BEGIN(codigo); nllavesizq++;} //  dentro de una acción se entra en un bloque de código y se contabiliza la anidación con llaves
<codigo>"{" {nllavesizq++;} // Otro bloque anidado
<codigo>"}" {nllavesdcha++; if((nllavesizq == nllavesdcha) && nllavesizq > 0){ // Se cierra un bloque. Si el número de llaves derechas iguala al de izquierdas, significa que cesa el bloque de código
		BEGIN(acciones); // Se vuelve al estado de acciones y se ponen a cero la llaves de cógido (ya no estamos en él)
		nllavesizq = 0;
		nllavesdcha = 0;}
	} 
<acciones>["].*["] // Si en una acción hay una cadena, se consumen todos sus símbolos para sí evitar la contabilización defectuosa de instrucciones
<acciones,codigo>;	{i++;} // Un punto y coma en un bloque de código o en la propia sección de acciones implica una instrucción
<acciones>"}" {BEGIN(reglas);} // Cuando se reconoce una llave derecha en la sección de acciones, significa el fin de estas y la vuelta al estado de reglas
<reglas>^"%%"		{BEGIN(usuario);l3--;} // Se efectúa un cambio de sección, restándole la línea de transición a este
<usuario>[\n]		{l3++;} // Línea en la sección de usuarios
<INITIAL,reglas,usuario,acciones,codigo>"//"		{accionAnt = YY_START; BEGIN(comentario); c++;}//Cuando en cualquier estado de cualquier sección (que no sea un comentario) se reconocen dos barras inclinadas, se entra en un comentario
<comentario>.*$	  {BEGIN(accionAnt);} // Los comentarios llegarán siempre al final de la línea. No se consume el fin de línea, se vuelve al estado anterior y este contabilizará para la sección pertinente
<*>. //Consumo de caracteres no reconocidos por ninguna regla
%%
int main(){
	int error = yylex();
	if(error == 0){
		printf("L1:%d\n", l1);
		printf("L2:%d\n", l2);
		printf("L3:%d\n", l3);
		printf("C:%d\n", c);
		printf("R:%d\n", r);
		printf("I:%d\n", i);
	}
	return error;
}
