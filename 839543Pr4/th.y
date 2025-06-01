	// Práctica 4
	// Athanasios Usero, NIP: 839543
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
extern int yylex();
extern int yyerror();
#define PALOS 3
#define DIM 27 //DIMENSION DE LA MATRIZ DE ADYACENCIA
#define BUFF 4000

//declarar la variable listaTr de tipo ListaTransiciones
//Almacena las transiciones de un solo nodo (nodoOrig) 
//a varios nodos (nodosFin y sus correspondientes etiquetas)
struct ListaTransiciones {
	char* nodoOrig;
	char* nodosFin[DIM];
	char* etiquetas[DIM]; 
	int total;
} listaTr;

//tabla de adyacencia
char* tablaTr[DIM][DIM];

//inicializa una tabla cuadrada DIM x DIM con la cadena vacia
void iniTabla(char* tabla[DIM][DIM]) {
	for (int i = 0; i < DIM; i++) {
		for (int j = 0; j < DIM; j++) {
			tabla[i][j] = "";
		}
	}
}
// Variable para almacenar entero de una cadena
int cadi, cadj;

/* Codifica la cadena s3s2s1 en base tres para poder representar
	cada estado como un indice de la matriz de adyacencia
*/
int codificar(char* estado){
	int cod = atoi(estado);
	int pot = 1;
	int res = 0;
	for(unsigned i = 0; i < 3; i++){
		res += (cod % 10) * pot;
		pot *= 3;
		cod = cod /10;
	}
	return res;
}
/*
 * Calcula la multiplicacion simbolica de matrices 
 * cuadradas DIM x DIM: res = t1*t2
 *
 * CUIDADO: res DEBE SER UNA TABLA DISTINTA A t1 y t2
 * Por ejemplo, NO SE DEBE USAR en la forma:
 *           multiplicar(pot, t, pot); //mal
 */
void multiplicar(char* t1[DIM][DIM], char* t2[DIM][DIM], char* res[DIM][DIM]) {
	for (int i = 0; i < DIM; i++) {
		for (int j = 0; j < DIM; j++) {
			res[i][j] = (char*) calloc(BUFF, sizeof(char));
			for (int k = 0; k < DIM; k++) {
				if (strcmp(t1[i][k],"")!=0 && strcmp(t2[k][j],"") != 0) {
					strcat(strcat(res[i][j],t1[i][k]),"-");
					strcat(res[i][j],t2[k][j]);
				}
			}
		}
	}
}


/* 
 *Copia la tabla orig en la tabla copia
*/
void copiar(char* orig[DIM][DIM], char* copia[DIM][DIM]) {
	for (int i = 0; i < DIM; i++) {
		for (int j = 0; j < DIM; j++) {
			copia[i][j] = strdup(orig[i][j]);
		}
	}
}


%}

  //nuevo tipo de dato para yylval
%union{
	char* nombre;
}

%token ID GRAPH NOMBRE FLECHA COMA PYC LLAVEIZQ LLAVEDER PARENTIZQ PARENTDER FL 
%start	grafo		//variable inicial 

%type<nombre> ID 	 //lista de tokens y variables que su valor semantico,
                     //recogido mediante yylval, es 'nombre' (ver union anterior).
					 //Para estos tokens, yylval será de tipo char* en lugar de int.

%%

grafo: /*Nada*/
	  | grafo GRAPH NOMBRE LLAVEIZQ FL transiciones LLAVEDER FL
	   ;
transiciones: /* Nada */	
			| transiciones ID FLECHA destinos PYC FL 	{listaTr.nodoOrig = $2; cadi = codificar(listaTr.nodoOrig);
															for(int i = 0;i < listaTr.total; i++){
																cadj = codificar(listaTr.nodosFin[i]);
																tablaTr[cadi][cadj] = listaTr.etiquetas[i];
																} 
															listaTr.total = 0;
														}												
			;
destinos: arcoestado	
		| arcoestado COMA destinos
		;
arcoestado: ID PARENTIZQ ID PARENTDER {listaTr.nodosFin[listaTr.total] = $1; listaTr.etiquetas[listaTr.total] = $3; listaTr.total++;}
 
%%

int yyerror(char* s) {
	printf("%s\n");
	return -1;
}

int main() {
	//inicializar lista transiciones
	listaTr.total = 0;

	//inicializar tabla de adyacencia
	iniTabla(tablaTr);

	//nodo inicial
	char* estadoIni = "000";

	//nodo final
	char* estadoFin = "111";
	
	int error = yyparse();

	
	if (error == 0) {
		//matriz para guardar la potencia
		char* pot[DIM][DIM];
		// Matriz para almacenar operaciones
		char* res[DIM][DIM];
		copiar(tablaTr,pot);
		copiar(tablaTr,res);
		//calcular movimientos de estadoIni a estadoFin
		//calculando las potencias sucesivas de tablaTr
		cadi = codificar(estadoIni);
		cadj = codificar(estadoFin);
		while(strcmp(pot[cadi][cadj],"") == 0){
			multiplicar(tablaTr, pot, res);
			copiar(res, pot);
		}		

		printf("Nodo inicial  : %s\n", estadoIni);
		printf("Movimientos   : %s\n", pot[cadi][cadj]);
		printf("Nodo final    : %s\n", estadoFin);
	}

	return error;
}
