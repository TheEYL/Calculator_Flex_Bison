/* simplest version of calculator */
%{
#include <stdio.h> 
%}

/* declare tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS 
%token OP CP
%token EOL
%token POW
%token MOD
%token  FLOAT
%token  INTEGER

%%
S: /*nothing*/ 
 | S E EOL { printf("Result => %d\n", $2); } 
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

F: NUMBER { $$ = $1; printf("F =>NUMBER; ");}
 | FLOAT { $$ = $1;printf("F =>FLOAT");} 
 | INTEGER { $$ = $1;printf("F =>INTEGER");}
 | OP E CP { $$ = $2; printf("F => (E) %d %d\n", $$,$2);}
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


