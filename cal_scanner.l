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
[0-9]*\.?[0-9]+|[0-9]+\. { printf("FLOAT\n"); yylval.flt =  atof(yytext); return FLOAT; }


"$"     { printf("EOF\n");}
\n      { printf("NEWLINE\n"); return EOL; }
"//".*  /* ignores comments */  
[ \t]   { /* ignore white space */ }
.    	{ yyerror("Other character %c\n", *yytext); }
%%
