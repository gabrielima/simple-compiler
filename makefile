default:
	bison -d sin.y
	mv sin.tab.h sin.h
	mv sin.tab.c sin.y.c
	flex lex.l
	mv lex.yy.c lex.l.c
	gcc -g -c lex.l.c -o lex.l.o
	gcc -g -c sin.y.c -o sin.y.o
	gcc -g -o cafezinho lex.l.o sin.y.o
	# rm *.c *.o sin.h

test1:
	$(MAKE)
	 ./cafezinho expressao1.z
test2:
	$(MAKE)
	 ./cafezinho expressao2.z
test3:
	$(MAKE)
	 ./cafezinho expressao3.z
test4:
	$(MAKE)
	 ./cafezinho fatorial.txt
test5:
	$(MAKE)
	./cafezinho teste.txt
test6:
	$(MAKE)
	./cafezinho selectionSort.z
