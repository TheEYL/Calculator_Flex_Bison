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
%%
calclist: /* nothing */
 | calclist exp EOL { printf("Result => %d\n", $2); } 
 | calclist EOL { printf("> "); } /* blank line or comment */
 ;

exp: factor { printf("E =>T %d %d\n",$$, $1);} /* $$ is given the value of $1 by default*/
 | exp ADD factor { $$ = $1 + $3; printf("E => E+T %d %d %d\n",$$,$1,$3);} 
 | exp SUB factor { $$ = $1 - $3; printf("E => E-T %d %d %d\n",$$,$1,$3);}  
 | exp POW factor { $$ = pow ($1, $3); }
 ;

factor: term {  printf("T =>F %d %d\n",$$, $1);} 
 | factor MUL term { $$ = $1 * $3; printf("T => T*F %d %d %d\n",$$,$1,$3);}
 | factor DIV term { $$ = $1 / $3; printf("T => T/F %d %d %d\n",$$,$1,$3);} 
 ;

term: NUMBER { printf("F =>NUMBER %d %d\n",$$, $1);}
 | OP exp CP { $$ = $2; printf("F => (E) %d %d\n", $$,$2);}
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


