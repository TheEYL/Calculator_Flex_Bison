#part of make file


cal: cal_scanner.l cal_parser.y 
	bison -d cal_parser.y
	flex cal_scanner.l
	cc -o $@ cal_parser.tab.c lex.yy.c -lfl -lm

