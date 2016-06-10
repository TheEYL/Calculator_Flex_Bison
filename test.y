
nclude <stdio.h>
%}
/* declare tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%%
calclist: /* nothing */
matches at beginning of input
| calclist exp EOL { printf("= %d\n", (); } EOL is end of an expression
;
exp: factor
default $$ = (
| exp ADD factor { $$ = ( + {; }
| exp SUB factor { $$ = ( - {; }
;
factor: term
default $$ = (
| factor MUL term { $$ = ( * {; }
| factor DIV term { $$ = ( / {; }
;
term: NUMBER default $$ = (
| ABS term
{ $$ = [ >= 0? [ : - [; }
;
%%
main(int argc, char **argv)
{
    yyparse();
}
yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
}]]])})}))})})))
    
