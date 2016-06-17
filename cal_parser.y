/* simplest version of calculator */
%{


#include <math.h>
#include <stdio.h> 
#include <stdlib.h>
#define YYSTYPE double  
%}

%code requires
{
    #define YYSTYPE double
}
/* declare tokens */
%token NUMBER FLOAT HEX OCT 
%token ADD SUB MUL DIV ABS 
%token OP CP
%token EOL
%token POW
%token MOD

%left NEG
%%


S: /*nothing*/ 
 | S E EOL { printf("Result => %g\n", $2); } 
 | S EOL { printf("> "); } /* blank line or comment */
 ;

E: T { printf("E =>T %g %g\n",$$, $1);} /* $$ is given the value of $1 by default*/
 | E ADD T { $$ = $1 + $3; printf("E => E+T %g %g %g\n",$$,$1,$3);} 
 | E SUB T { $$ = $1 - $3; printf("E => E-T %g %g %g\n",$$,$1,$3);}  
 | E G { $$ = $1 *$2; printf( "E => E * G %g %g", $$, $2);}
 | G E { $$ = $1 *$2; printf( "E => G * E %g %g", $$, $2);}
 ;

T: F {  printf("T =>F %g %g\n",$$, $1);} 
 | T MUL F { $$ = $1 * $3; printf("T => T*F %g %g %g\n",$$,$1,$3);}
 | T DIV F {$$ = $1 /$3; printf("T => T/F %g %g %g\n", $$, $1,$3);}
 | T MOD F { $$ = (unsigned)$1%(unsigned)$3; printf("T => T\%F  %g %g %g\n",$$,$1,$3);}  
 | T POW F { $$ = pow($1, $3);printf("T => T^F  %g %g %g\n",$$,$1,$3);}  
; 
F: NUMBER { $$ = $1; printf("F =>NUMBER; ");}
 | FLOAT  { $$ = $1; printf("F =>FLOAT; ");}
 | HEX    { $$ = $1; printf("F =>HEX; ");}
 | OCT    { $$ = $1; printf("F =>OCT; ");}
 | SUB E %prec NEG {$$ =-$2;}
 | G
;
G: OP E CP { $$ = $2; printf("F => (E) %g %g\n", $$,$2);}
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


