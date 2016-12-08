%{
  #include <stdio.h>
  #include "sin.h"

  #define ERROR_COMMENT       "COMENTARIO NAO TERMINA"
  #define ERROR_CHARACTER     "CARACTERE INVALIDO"
  #define ERROR_STRING        "CADEIA DE CARACTERES OCUPA MAIS DE UMA LINHA"   

  extern void yyerror(const char* s);
%}

%option yylineno
%option noyywrap

DIGITO [0-9]
LETRA [a-zA-Z]

%s IN_COMENTARIO
%s IN_STRING

%%

[ \t\n]+            ; 

[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]       { printf("--- COMENTARIO na linha %d\n", yylineno); return COMENTARIO; }
[/][*]                                    { yyerror(ERROR_COMMENT); }
 
"["                  { printf("--- A_CHAVE na linha %d\n", yylineno); return A_CHAVE; }
"]"                  { printf("--- F_CHAVE na linha %d\n", yylineno); return F_CHAVE; }
"("                  { printf("--- A_PARENTESIS na linha %d\n", yylineno); return A_PARENTESIS; }
")"                  { printf("--- F_PARENTESIS na linha %d\n", yylineno); return F_PARENTESIS; }
"{"                  { printf("--- A_COLCHETES na linha %d\n", yylineno); return A_COLCHETES; }
"}"                  { printf("--- F_COLCHETES na linha %d\n", yylineno); return F_COLCHETES; }
","                  { printf("--- VIRGULA na linha %d\n", yylineno); return VIRGULA; }
";"                  { printf("--- PONTOEVIRGULA na linha %d\n", yylineno); return PONTOEVIRGULA; }
"?"                  { printf("--- INTERROGACAO na linha %d\n", yylineno); return INTERROGACAO; }
":"                  { printf("--- DOISPONTOS na linha %d\n", yylineno); return DOISPONTOS; }
"+"                  { printf("--- MAIS na linha %d\n", yylineno); return MAIS; }
"-"                  { printf("--- MENOS na linha %d\n", yylineno); return MENOS; }
"!"                  { printf("--- NEGACAO na linha %d\n", yylineno); return NEGACAO; }
"=="                 { printf("--- IGUAL na linha %d\n", yylineno); return IGUAL; }
"="                  { printf("--- ASSIGN na linha %d\n", yylineno); return ASSIGN; }
"!="                 { printf("--- DIF na linha %d\n", yylineno); return DIF; }
"*"                  { printf("--- MULT na linha %d\n", yylineno); return MULT; }
"/"                  { printf("--- DIV na linha %d\n", yylineno); return DIV; }
"%"                  { printf("--- MOD na linha %d\n", yylineno); return MOD; }
">"                  { printf("--- MAIOR na linha %d\n", yylineno); return MAIOR; }
"<"                  { printf("--- MENOR na linha %d\n", yylineno); return MENOR; }
">="                 { printf("--- MAIORIGUAL na linha %d\n", yylineno); return MAIORIGUAL; }
"<="                 { printf("--- MENORIGUAL na linha %d\n", yylineno); return MENORIGUAL; }
"e"                  { printf("--- AND na linha %d\n", yylineno); return AND; }
"ou"                 { printf("--- OR na linha %d\n", yylineno); return OR; }
"se"                 { printf("--- SE na linha %d\n", yylineno); return SE; }
"int"                { printf("--- INT na linha %d\n", yylineno); return INT; }
"car"                { printf("--- CAR na linha %d\n", yylineno); return CAR; } 
"leia"               { printf("--- LEIA na linha %d\n", yylineno); return LEIA; }
"entao"              { printf("--- ENTAO na linha %d\n", yylineno); return ENTAO; }
"senao"              { printf("--- SENAO na linha %d\n", yylineno); return SENAO; }
"retorne"            { printf("--- RETORNE na linha %d\n", yylineno); return RETORNE; }
"escreva"            { printf("--- ESCREVA na linha %d\n", yylineno); return ESCREVA; }
"execute"            { printf("--- EXECUTE na linha %d\n", yylineno); return EXECUTE; }
"programa"           { printf("--- PROGRAMA na linha %d\n", yylineno); return PROGRAMA; }
"enquanto"           { printf("--- ENQUANTO na linha %d\n", yylineno); return ENQUANTO; }
"novalinha"          { printf("--- NOVALINHA na linha %d\n", yylineno); return NOVALINHA; }

{LETRA}({LETRA}|{DIGITO})*   { printf("--- IDENTIFICADOR na linha %d\n", yylineno); return IDENTIFICADOR; }
{DIGITO}+                    { printf("--- INTCONST na linha %d\n", yylineno); return INTCONST; }

(\")(.)*(\")  { printf("--- CARCONST na linha %d\n", yylineno); return CARCONST; }


.                    { yyerror(ERROR_CHARACTER); }

%%