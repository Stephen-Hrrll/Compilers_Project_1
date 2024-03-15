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

ws  [ \t\r]+
comment	    "//".*\n
dComment    "--".*\n
line	[\n]
id		[A-Za-z]([A-Za-z_]*[A-Za-z0-9])?
digit	[0-9]
dec		{digit}+
hex 	#[0-9A-Fa-f]+
real	{digit}+\.{digit}+([eE][+-]?{digit}+)?
char    '\\b'|'\\t'|'\\n'|'\\f'|'[^']'
punc    [\(\),:;]

%%
{real}		{ ECHO; return(REAL); }
else		{ ECHO; return(ELSE); }
elsif		{ ECHO; return(ELSIF); }
endfold		{ ECHO; return(ENDFOLD); }
fold		{ ECHO; return(FOLD); }
if 			{ ECHO; return(IF); }
left		{ ECHO; return(LEFT); }
right		{ ECHO; return(RIGHT); }
then 		{ ECHO; return(THEN); }
begin		{ ECHO; return(BEGIN_); }
case		{ ECHO; return(CASE); }
character	{ ECHO; return(CHARACTER); }
end		{ ECHO; return(END); }
endswitch	{ ECHO; return(ENDSWITCH); }
function	{ ECHO; return(FUNCTION); }
is		{ ECHO; return(IS); }
list		{ ECHO; return(LIST); }
of		{ ECHO; return(OF); }
others		{ ECHO; return(OTHERS); }
returns		{ ECHO; return(RETURNS); }
switch		{ ECHO; return(SWITCH); }
integer		{ ECHO; return(INTEGER); }
when		{ ECHO; return(WHEN); }
{char}		{ ECHO; return(CHAR_LITERAL); }
{id}		{ if(strstr(yytext, "___") == NULL){
    ECHO;
    return(IDENTIFIER);
    }; }
"|"			{ ECHO; return(OROP); }
"!"			{ ECHO;return(NOTOP); }
"="			{ ECHO;return(RELOP); }
"<>"	    { ECHO; return(RELOP); }
">"			{ ECHO;return(RELOP); }
">="		{ ECHO;return(RELOP); }
"<="		{ ECHO; return(RELOP); }
"-"			{ ECHO;return(ADDOP); }
"/"			{ ECHO;return(MULOP); }
"%"			{ ECHO;return(REMOP); }
"^"			{ ECHO;return(EXPOP); }
"~"			{ ECHO;return(NEGOP); }
"+"		{ ECHO; return(ADDOP); }
"*"		{ ECHO; return(MULOP); }
"&"		{ ECHO; return(ANDOP); }
"<"		{ ECHO; return(RELOP); }
"=>"		{ ECHO; return(ARROW); }
{dec}		{ ECHO; return(INT_LITERAL); }
{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine(); }
{dComment}	{ ECHO; nextLine(); }
{line}		{ ECHO; nextLine(); }

{punc}		{ ECHO; return(yytext[0]); }
{hex}		{ ECHO; return(INT_LITERAL); }
.		{ ECHO; appendError(LEXICAL, yytext); }

%%

int main() {
	firstLine();
	
	FILE *file = fopen("lexemes.txt", "wa"); 
	int token = yylex();
	while (token) {
		fprintf(file, "%d %s\n", token, yytext);
		token = yylex();
	}
	lastLine();
	fclose(file);
	return 0;
}