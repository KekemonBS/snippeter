#.SILENT:

CC         = gcc
CFLAGS     = -Wall -Wunused -DYYDEBUG=1

SOURCES    = $(wildcard *.c)
OBJECTS    = $(SOURCES:.c=.o)
EXECUTABLE = snippeter
LEXFILE    = lexer.l
YACCFILE   = parser.y

all: $(EXECUTABLE)

$(EXECUTABLE): lex yacc $(OBJECTS)
	$(CC) $(OBJECTS) -o $(EXECUTABLE)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

lex: yacc 
	lex $(LEXFILE)
	$(CC) $(CFLAGS) -c lex.yy.c -o lex.yy.o

yacc: 
	yacc -d $(YACCFILE)
	$(CC) $(CFLAGS) -c y.tab.c -o y.tab.o
	
clean:
	rm -f $(OBJECTS) $(EXECUTABLE) $(wildcard *.yy.c) $(wildcard *.tab.c) y.tab.h
