/* CMSC 430 Compiler Theory and Design
   Project 2 Skeleton
   UMGC CITE
   Summer 2023 

   Project 2 Parser */

%{

#include <string>

using namespace std;

#include "listing.h"

int yylex();
void yyerror(const char* message);

%}

%define parse.error verbose

%token IDENTIFIER INT_LITERAL CHAR_LITERAL REAL_LITERAL

%token ADDOP MULOP ANDOP RELOP ARROW OROP NOTOP REMOP EXPOP NEGOP

%token BEGIN_ CASE CHARACTER ELSE END ENDSWITCH FUNCTION INTEGER IS LIST OF OTHERS
	RETURNS SWITCH WHEN REAL IF THEN ELSIF ENDIF FOLD LEFT RIGHT ENDFOLD

%%

function:	
	function_header variables body ;
	
function_header:	
	FUNCTION IDENTIFIER parameters RETURNS type ';' |
	FUNCTION IDENTIFIER parameters RETURNS type error ';' ;

variables:
	variables variable |
	%empty ;

variable:	
	IDENTIFIER ':' type IS statement ';' |
	IDENTIFIER ':' LIST OF type IS list ';' |
	error ';' ;

parameters:
	parameter_list |
	%empty ;

parameter_list:
	parameter_list ',' parameter |
	parameter ;

parameter:
	IDENTIFIER ':' type ;

type:
	INTEGER |
	REAL |
	CHARACTER ;
	
list:
	'(' expressions ')' ;

expressions:
	expressions ',' expression | 
	expression ;

body:
	BEGIN_ statement_list END ';' ;

statement_list:
	statement_list statement_ |
	statement_ ;

statement_:
	statement ';' |
	error ';' ;
    
statement:
	expression |
	WHEN condition ',' expression ':' expression |
	SWITCH expression IS cases OTHERS ARROW statement ';' ENDSWITCH |
	IF condition THEN statement_list elsif_clauses ELSE statement_list ENDIF |
	IF condition THEN statement_list elsif_clauses ENDIF |
	FOLD direction operator list_choice ENDFOLD ;

elsif_clauses:
	elsif_clauses ELSIF condition THEN statement_list |
	%empty ;

cases:
	cases case |
	%empty ;
	
case:
	CASE INT_LITERAL ARROW statement ';' |
	error ';' ; 

direction:
	LEFT | RIGHT ;

operator:
	ADDOP | MULOP ;

list_choice:
	list | IDENTIFIER ;

condition:
	condition ANDOP relation |
	condition OROP relation |
	NOTOP relation |
	relation ;

relation:
	'(' condition ')' |
	expression RELOP expression ;

expression:
	expression ADDOP term |
	term ;
      
term:
	term MULOP factor |
	term REMOP factor |
	factor ;

factor:
	factor EXPOP power |
	power ;

power:
	unary ;

unary:
	NEGOP primary |
	primary ;

primary:
	'(' expression ')' |
	INT_LITERAL |
	CHAR_LITERAL |
	REAL_LITERAL |
	IDENTIFIER '(' expressions ')' |
	IDENTIFIER ;

%%

void yyerror(const char* message) {
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[]) {
	firstLine();
	yyparse();
	lastLine();
	return 0;
}