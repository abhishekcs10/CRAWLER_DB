all: init compile4


init:
	python a3.py
compile1:
	bison -d parser.y
compile2:
	lex lexer.l
compile3:
	gcc parser.tab.c lex.yy.c -std=gnu99 -o scanner.out -g 
	bash script.sh
compile4:
	g++ -I/usr/include/mysql mysql_query.cpp -o mysql -lmysqlclient -g
	bash sql_script.sh

