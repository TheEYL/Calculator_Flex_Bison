/*recognize tokens for the calculator and print them out*/
%{
#define YYSTYPE double
# include "cal_parser.tab.h"
# include <stdlib.h>
%}
       
white [ \t]+ 
digit [0-9]
integer {digit}+ 
exp [eE][+-]?{integer}
double {digit}*\.?{integer}{exp}?|{integer}+{exp}?\.
hex 0[xX][0-9a-fA-F]+
oct 0o[0-7]+

%%
"+"	        { printf("PLUS\n"); return ADD; }
"-"	        { printf("MINUS\n"); return SUB; }
"*"	        { printf("MULT\n"); return MUL; }
"/"	        { printf("DIV\n"); return DIV; }
"("         { printf("OPENPAR\n"); return OP; }
")"         { printf("CLOSEPAR\n"); return CP; }
"^"         { printf("EXPONENT\n"); return POW;}
"%"         { printf("MOD\n"); return MOD; }
{integer}	{ printf("INTEGER\n"); yylval = strtol (yytext, NULL, 10); return NUMBER; }
{double}    { printf("DOUBLE\n"); yylval =  atof(yytext);   return FLOAT; }
{hex}       { printf("HEX-NUMBER\n"); yylval = strtol (yytext + 2, NULL, 16); return HEX;}
{oct}       { printf("OCTAL-NUMBER\n"); yylval = strtol (yytext + 1, NULL, 8); return OCT;} /*octal number with a 0o prefix*/


"$"         { printf("EOF\n");}
\n          { printf("\nNEWLINE\n"); return EOL; }
"//".*  /* ignores comments */  
[ \t]       { /* ignore white space */ }
.        	{ yyerror("Other character %c\n", *yytext); }
%%
