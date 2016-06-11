/*recognize tokens for the calculator and print them out*/
%{
# include "desk_calculator_parser.tab.h"
%}
       
%%
"+"	    { printf("PLUS\n"); return ADD; }
"-"	    { printf("MINUS\n"); return SUB; }
"*"	    { printf("MULT\n"); return MUL; }
"/"	    { printf("DIV\n"); return DIV; }
"("     { printf("OPENPAR\n"); return OP; }
")"     { printf("CLOSEPAR\n"); return CP; }
"^"     { printf("EXPONENT\n"); return POW;}
[0-9]+	{ printf("NUMBER\n");yylval = atoi(yytext); return NUMBER; }
0x[a-f0-9]+ {return NUMBER;}
"$"     { printf("EOF\n");}
\n      { printf("NEWLINE\n"); return EOL; }
"//".*  /* ignores comments */  
[ \t]   { /* ignore white space */ }
.    	{ yyerror("Other character %c\n", *yytext); }
%%
