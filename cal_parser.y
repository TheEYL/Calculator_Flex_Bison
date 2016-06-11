/* simplest version of calculator */
%{

#include <math.h>
#include <stdio.h> 
#include <stdlib.h>
#define YYSTYPE double  
%}

/* declare tokens */
%token NUMBER 
%token ADD SUB MUL DIV ABS 
%token OP CP
%token EOL
%token POW
%token MOD

%left ADD SUB    
%left MUL DIV
%left NEG
%right POW
%start S
%%


S: /*nothing*/ 
 | S E EOL { printf("Result => %f\n", $2); } 
 | S EOL { printf("> "); } /* blank line or comment */
 ;

E: T { printf("E =>T %d %d\n",$$, $1);} /* $$ is given the value of $1 by default*/
 | E ADD T { $$ = $1 + $3; printf("E => E+T %d %d %d\n",$$,$1,$3);} 
 | E SUB T { $$ = $1 - $3; printf("E => E-T %d %d %d\n",$$,$1,$3);}  
 | E POW T { $$ = pow($1, $3);printf("E => E^T  %d %d %d\n",$$,$1,$3);}  
 | E MOD T { $$ = (int)$1%(int)$3; printf("E => E%T  %d %d %d\n",$$,$1,$3);}  
 ;

T: F {  printf("T =>F %d %d\n",$$, $1);} 
 | T MUL F { $$ = $1 * $3; printf("T => T*F %d %d %d\n",$$,$1,$3);}
 | T DIV F {$$ = $1 /$3; printf("T => T/F %d %d %d\n", $$, $1,$3);}
F: NUMBER { $$ = $1; printf("F =>NUMBER; ");}
 | OP E CP { $$ = $2; printf("F => (E) %d %d\n", $$,$2);}
 | SUB E %prec NEG {$$ =-$2;}
;

%%

main(int argc, char **argv)
{
    printf("> ");
    yyparse();
}

yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
}


