%{
	#include <stdio.h>
	
	extern int yylex();
	extern int yyparse();
	
	extern FILE* yyin;
	extern int yylineno;	

	void yyerror(const char* s);

	#define YYDEBUG 1
%}

%token VIRGULA PONTOEVIRGULA COMENTARIO
%token A_PARENTESIS F_PARENTESIS A_COLCHETES F_COLCHETES 
%token A_CHAVE F_CHAVE A_COMENTARIO F_COMENTARIO
%token IGUAL INTERROGACAO DOISPONTOS NEGACAO
%token MAIS MENOS DIF MULT DIV MOD
%token AND OR INT CAR ASSIGN
%token MAIOR MENOR MAIORIGUAL MENORIGUAL
%token INTCONST CARCONST IDENTIFICADOR
%token SE NOVALINHA LEIA ENTAO SENAO RETORNE ESCREVA EXECUTE PROGRAMA ENQUANTO

%error-verbose

%start Programa

%%

Programa : 
	DeclFuncVar DeclProg { printf(" \t- REGRA 1: Programa\n"); }
;

DeclFuncVar :  
	Tipo IDENTIFICADOR DeclVar PONTOEVIRGULA DeclFuncVar { printf(" \t- REGRA 2: DeclFuncVar\n"); }
	| Tipo IDENTIFICADOR A_CHAVE INTCONST F_CHAVE DeclVar PONTOEVIRGULA DeclFuncVar { printf(" \t- REGRA 3: DeclFuncVar\n"); }
	| Tipo IDENTIFICADOR DeclFunc DeclFuncVar { printf(" \t- REGRA 4: DeclFuncVar\n"); }
	| %empty
;

DeclProg : 
	PROGRAMA Bloco  { printf(" \t- REGRA 5: DeclProg\n"); }
;

DeclVar : 
	VIRGULA IDENTIFICADOR DeclVar  { printf(" \t- REGRA 6: DeclVar\n"); }
	| VIRGULA IDENTIFICADOR A_CHAVE INTCONST F_CHAVE DeclVar { printf(" \t- REGRA 7: DeclVar\n"); }
	| %empty
;

DeclFunc : 
	A_PARENTESIS ListaParametros F_PARENTESIS Bloco  { printf(" \t- REGRA 8: DeclFunc\n"); }
;

ListaParametros :
	%empty
	| ListaParametrosCont  { printf(" \t- REGRA 9: ListaParametros\n"); }
;

ListaParametrosCont :
	Tipo IDENTIFICADOR
	| Tipo IDENTIFICADOR A_CHAVE  F_CHAVE  { printf(" \t- REGRA 10: ListaParametrosCont\n"); }
	| Tipo IDENTIFICADOR VIRGULA ListaParametrosCont { printf(" \t- REGRA 11: ListaParametrosCont\n"); }
	| Tipo IDENTIFICADOR A_CHAVE  F_CHAVE VIRGULA ListaParametrosCont { printf(" \t- REGRA 12: ListaParametrosCont\n"); }
;

Bloco :
	A_COLCHETES ListaDeclVar ListaComando F_COLCHETES  { printf(" \t- REGRA 13: Bloco\n"); }
	| A_COLCHETES ListaDeclVar F_COLCHETES { printf(" \t- REGRA 14: Bloco\n"); }
;

ListaDeclVar :
	%empty  { printf(" \t- REGRA 15: ListaDeclVar\n"); }
	| Tipo IDENTIFICADOR DeclVar PONTOEVIRGULA ListaDeclVar { printf(" \t- REGRA 16: ListaDeclVar\n"); }
	| Tipo IDENTIFICADOR A_CHAVE INTCONST F_CHAVE DeclVar PONTOEVIRGULA ListaDeclVar { printf(" \t- REGRA 17: ListaDeclVar\n"); }
;

Tipo :
	INT { printf(" \t- REGRA 18: Tipo\n"); }
	| CAR  { printf(" \t- REGRA 19: Tipo\n"); }
;

ListaComando :
	Comando  { printf(" \t- REGRA 20: ListaComando\n"); }
	| Comando ListaComando  { printf(" \t- REGRA 21: ListaComando\n"); }
;

Comando :
	PONTOEVIRGULA  { printf(" \t- REGRA 22: Comando\n"); }
	| Expr PONTOEVIRGULA  { printf(" \t- REGRA 23: Comando\n"); }
	| RETORNE Expr PONTOEVIRGULA  { printf(" \t- REGRA 24: Comando\n"); }
	| LEIA LValueExpr PONTOEVIRGULA  { printf(" \t- REGRA 25: Comando\n"); }
	| ESCREVA Expr PONTOEVIRGULA  { printf(" \t- REGRA 26: Comando\n"); }
	| ESCREVA CARCONST PONTOEVIRGULA  { printf(" \t- REGRA 27: Comando\n"); }
	| NOVALINHA PONTOEVIRGULA  { printf(" \t- REGRA 28: Comando\n"); }
	| SE A_PARENTESIS Expr F_PARENTESIS ENTAO Comando  { printf(" \t- REGRA 29: Comando\n"); }
	| SE A_PARENTESIS Expr F_PARENTESIS ENTAO Comando SENAO Comando  { printf(" \t- REGRA 30: Comando\n"); }
	| ENQUANTO A_PARENTESIS Expr F_PARENTESIS EXECUTE Comando  { printf(" \t- REGRA 31: Comando\n"); }
	| Bloco  { printf(" \t- REGRA 32: Comando\n"); }
;

Expr : 
	AssignExpr  { printf(" \t- REGRA 33: Expr\n"); }
;

AssignExpr : 
	CondExpr  { printf(" \t- REGRA 34: AssignExpr\n"); }
	| LValueExpr ASSIGN AssignExpr { printf(" \t- REGRA 35: AssignExpr\n"); }
;

CondExpr : 
	OrExpr { printf(" \t- REGRA 36: CondExpr\n"); }
	| OrExpr INTERROGACAO Expr DOISPONTOS CondExpr  { printf(" \t- REGRA 37: CondExpr\n"); }
;

OrExpr :
	OrExpr OR AndExpr  { printf(" \t- REGRA 38: OrExpr\n"); }
	| AndExpr { printf(" \t- REGRA 39: OrExpr\n"); }
;

AndExpr : 
	AndExpr AND EqExpr  { printf(" \t- REGRA 40: AndExpr\n"); }
	| EqExpr  { printf(" \t- REGRA 41: AndExpr\n"); }
;

EqExpr : 
	EqExpr IGUAL DesigExpr  { printf(" \t- REGRA 42: EqExpr\n"); }
	| EqExpr DIF DesigExpr  { printf(" \t- REGRA 43: EqExpr\n"); }
	| DesigExpr  { printf(" \t- REGRA 44: EqExpr\n"); }
;

DesigExpr :  
	DesigExpr MENOR AddExpr  { printf(" \t- REGRA 45: DesigExpr\n"); }
	| DesigExpr MAIOR AddExpr { printf(" \t- REGRA 46: DesigExpr\n"); }
	| DesigExpr MAIORIGUAL AddExpr  { printf(" \t- REGRA 47: DesigExpr\n"); }
	| DesigExpr MENORIGUAL AddExpr { printf(" \t- REGRA 48: DesigExpr\n"); }
	| AddExpr { printf(" \t- REGRA 49: DesigExpr\n"); }
;

AddExpr :  
	AddExpr MAIS MulExpr  { printf(" \t- REGRA 50: AddExpr\n"); }
	| AddExpr MENOS MulExpr   { printf(" \t- REGRA 51: AddExpr\n"); }
	| MulExpr  { printf(" \t- REGRA 52: AddExpr\n"); }
;

MulExpr :  
	MulExpr MULT UnExpr  { printf(" \t- REGRA 53: MulExpr\n"); }
	| MulExpr DIV UnExpr { printf(" \t- REGRA 54: MulExpr\n"); }
	| MulExpr MOD UnExpr { printf(" \t- REGRA 55: MulExpr\n"); }
	| UnExpr { printf(" \t- REGRA 56: MulExpr\n"); }
;

UnExpr : 
	MENOS PrimExpr  { printf(" \t- REGRA 57: UnExpr\n"); }
	| NEGACAO PrimExpr { printf(" \t- REGRA 58: UnExpr\n"); }
	| PrimExpr { printf(" \t- REGRA 59: UnExpr\n"); }
;

LValueExpr :  
	IDENTIFICADOR A_CHAVE Expr F_CHAVE  { printf(" \t- REGRA 60: LValueExpr\n"); }
	| IDENTIFICADOR { printf(" \t- REGRA 61: LValueExpr\n"); }
;

PrimExpr :  
	IDENTIFICADOR A_PARENTESIS ListExpr F_PARENTESIS  { printf(" \t- REGRA 62: PrimExpr\n"); }
	| IDENTIFICADOR A_PARENTESIS F_PARENTESIS { printf(" \t- REGRA 63: PrimExpr\n"); }
	| IDENTIFICADOR A_CHAVE Expr F_CHAVE { printf(" \t- REGRA 64: PrimExpr\n"); }
	| IDENTIFICADOR { printf(" \t- REGRA 65: PrimExpr\n"); }
	| INTCONST { printf(" \t- REGRA 66: PrimExpr\n"); }
	| CARCONST { printf(" \t- REGRA 67: PrimExpr\n"); }
	| A_PARENTESIS Expr F_PARENTESIS { printf(" \t- REGRA 68: PrimExpr\n"); }
;

ListExpr :  
	AssignExpr  { printf(" \t- REGRA 69: ListExpr\n"); }
	| ListExpr VIRGULA AssignExpr { printf(" \t- REGRA 70: ListExpr\n"); }
;

%%

void yyerror (const char *s) {
	printf("ERRO %s na linha %d\n", s, yylineno);
}

int main(int argc, char* argv[]) {
	if(argc == 1)
		return 0;
	
	FILE *f;

	if((f = fopen(argv[1], "r")) == NULL) {
		printf("Erro ao abrir o arquivo\n");
		return 0;
	}

	yyin = f;

	do { 
		yyparse();
	} while(!feof(yyin));

	return 0;
}