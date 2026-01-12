/* CMSC 430 Compiler Theory and Design
   Project 1 Skeleton
   UMGC CITE
   Summer 2023 */

/* This file contains flex input file */

%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws          [ \t\r]+
comment     "//".*\n
comment2    "--".*\n
line        [\n]
/* Identifier: Starts with letter, alphanumeric inside, can have underscores (max 2 consecutive), 
   cannot end with underscore */
id          [A-Za-z]([A-Za-z0-9]|_[A-Za-z0-9]|__[A-Za-z0-9])*
digit       [0-9]
dec         {digit}+
hex         #[0-9a-fA-F]+
/* Real Literal: 
   1. defined integer part + dot + optional fraction + optional exponent
   2. dot + fraction + optional exponent
   3. defined integer + exponent (no dot) 
*/
real        ({digit}+\.{digit}*|\.{digit}+)([eE][+-]?{digit}+)?|{digit}+[eE][+-]?{digit}+
/* Char Literal: 'c', '\n', '\t', etc. */
char        '([^'\\\n]|\\.)'
punc        [\(\),:;]

%%

{ws}        { ECHO; }
{comment}   { ECHO; nextLine(); }
{comment2}  { ECHO; nextLine(); }
{line}      { ECHO; nextLine(); }

"+"         { ECHO; return(ADDOP); }
"-"         { ECHO; return(ADDOP); }
"*"         { ECHO; return(MULOP); }
"/"         { ECHO; return(MULOP); }
"&"         { ECHO; return(ANDOP); }
"|"         { ECHO; return(OROP); }
"!"         { ECHO; return(NOTOP); }
"%"         { ECHO; return(REMOP); }
"^"         { ECHO; return(EXPOP); }
"~"         { ECHO; return(NEGOP); }

"<"         { ECHO; return(RELOP); }
"="         { ECHO; return(RELOP); }
"<>"        { ECHO; return(RELOP); }
">"         { ECHO; return(RELOP); }
">="        { ECHO; return(RELOP); }
"<="        { ECHO; return(RELOP); }

"=>"        { ECHO; return(ARROW); }

begin       { ECHO; return(BEGIN_); }
case        { ECHO; return(CASE); }
character   { ECHO; return(CHARACTER); }
else        { ECHO; return(ELSE); }
elsif       { ECHO; return(ELSIF); }
end         { ECHO; return(END); }
endfold     { ECHO; return(ENDFOLD); }
endif       { ECHO; return(ENDIF); }
endswitch   { ECHO; return(ENDSWITCH); }
fold        { ECHO; return(FOLD); }
function    { ECHO; return(FUNCTION); }
if          { ECHO; return(IF); }
integer     { ECHO; return(INTEGER); }
is          { ECHO; return(IS); }
left        { ECHO; return(LEFT); }
list        { ECHO; return(LIST); }
of          { ECHO; return(OF); }
others      { ECHO; return(OTHERS); }
real        { ECHO; return(REAL); }
returns     { ECHO; return(RETURNS); }
right       { ECHO; return(RIGHT); }
switch      { ECHO; return(SWITCH); }
then        { ECHO; return(THEN); }
when        { ECHO; return(WHEN); }

{id}        { ECHO; return(IDENTIFIER); }
{hex}       { ECHO; return(INT_LITERAL); }
{dec}       { ECHO; return(INT_LITERAL); }
{real}      { ECHO; return(REAL_LITERAL); }
{char}      { ECHO; return(CHAR_LITERAL); }
{punc}      { ECHO; return(yytext[0]); }

.           { ECHO; appendError(LEXICAL, yytext); }

%%