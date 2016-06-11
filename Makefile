#part of make file


desk_calculator: desk_calculator_scanner.l desk_calculator_parser.y 
	bison -d desk_calculator_parser.y
	flex desk_calculator_scanner.l
	cc -o $@ desk_calculator_parser.tab.c lex.yy.c -lfl -lm

