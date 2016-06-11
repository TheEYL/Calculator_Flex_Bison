/*recognize tokens for the calculator and print them out*/
%{
# include "cal_parser.tab.h"
%}
       
%%
"+"	    { printf("PLUS\n"); return ADD; }
"-"	    { printf("MINUS\n"); return SUB; }
"*"	    { printf("MULT\n"); return MUL; }
"/"	    { printf("DIV\n"); return DIV; }
"("     { printf("OPENPAR\n"); return OP; }
")"     { printf("CLOSEPAR\n"); return CP; }
"^"     { printf("EXPONENT\n"); return POW;}
"%"     { printf("MOD\n"); return MOD; }
[0-9]+	{ printf("INTEGER\n"); yylval = strtol (yytext, NULL, 10); return NUMBER; }
[0-9]*\.?[0-9]+|[0-9]+\. { printf("FLOAT\n"); yylval = strtol (yytext, NULL, 10); return NUMBER; }
0x[a-f0-9]+ {printf("HEX-NUMBER\n"); yylval = strtol (yytext + 2, NULL, 16); return NUMBER;}
0o[0-7]+ { printf("OCTAL-NUMBER\n"); yylval = strtol (yytext + 1, NULL, 8); return NUMBER;} /*octal number with a 0o prefix*/


"$"     { printf("EOF\n");}
\n      { printf("NEWLINE\n"); return EOL; }
"//".*  /* ignores comments */  
[ \t]   { /* ignore white space */ }
.    	{ yyerror("Other character %c\n", *yytext); }
%%
